# This dockerfile utilizes components licensed by their respective owners/authors.
# Prior to utilizing this file or resulting images please review the respective licenses at: http://nginx.org/LICENSE

FROM microsoft/windowsservercore

#LABEL Description="Nginx" Vendor=Nginx" Version="1.0.13"

ADD ["embyserver.tar","c:/"]
COPY ["VC_redist.x64.exe","c:/"]
COPY ["avicap32.dll","c:/windows/system32/"]
COPY ["msvfw32.dll","c:/windows/system32/"]
RUN powershell -Command \
		$ErrorActionPreference = 'Stop'; \	
		.\VC_redist.x64.exe /quiet ; \
		Remove-Item c:\VC_redist.x64.exe -Force		
		
WORKDIR /embyserver

VOLUME C:\\embyserver\\mnt1 C:\\embyserver\\mnt2 C:\\embyserver\\mnt3 C:\\embyserver\\mnt4 C:\\embyserver\\mnt5 C:\\embyserver\\mnt6 c:\\embyserver\\programdata

RUN net user /add embyserver
RUN net localgroup Administrators embyserver /add
USER embyserver
CMD ["/embyserver/system/embyserver.exe"]


#docker create --name embyserver -v D:\data\movies:c:\embyserver\mnt1 -v D:\data\pictures:c:\embyserver\mnt2 -v D:\docker\embyserver\programdata:c:\embyserver\programdata --restart always -p 8096:8096 --net nat --ip 172.27.86.70 jallytom/embyserver
