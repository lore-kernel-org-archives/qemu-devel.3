Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784E8D59F5A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 18:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8kQ3-0002Xu-68; Wed, 06 Nov 2024 13:06:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t8kPu-0002Xj-JR
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:06:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t8kPr-0005PO-VD
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:06:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730916363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NcrYQnKUivgnEMl5AHfdshUmwkKcCpPauBue3SP6NlM=;
 b=HwatoPlJek24QoPICMJ52d2m2a9pAVuwHHbtX8JlUqmfidy2v+syHkiKMF+Uz92KGR3Fnp
 IyuEa2eGqg33IFj1c/YhnOqbuFcLDMvTTjDY6Exlhn0Wnqnrq+1E3Bwl8Tg+0TPV30NUWN
 nx0FhVY5KZrh9rYF/dO4KCcY/kaLRuY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-zIdNe1ahM2mWmGVAeZvtig-1; Wed, 06 Nov 2024 13:06:01 -0500
X-MC-Unique: zIdNe1ahM2mWmGVAeZvtig-1
X-Mimecast-MFC-AGG-ID: zIdNe1ahM2mWmGVAeZvtig
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6cbeca2b235so941856d6.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 10:06:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730916361; x=1731521161;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NcrYQnKUivgnEMl5AHfdshUmwkKcCpPauBue3SP6NlM=;
 b=P7jm4AIipvUxWb7I/nrls9MBvgZpbxpxyTJQ6VOAUeW7rIOUs5EVhZ+YCiUxF+6717
 qjpoWtnO6xwaLzX6owv+eNUnaDMwU1riTaGY3RINAXpLs51aFp+ZIiWbgv4LL8QURZh6
 9dPoC6F3igRfZcKhFUzQql6zzMFOV/gvZApzEdq+7e5bowpaj/ddjSFpfuqOLHOf2VFP
 0DTNBMVN/KbbaGvtnoxcBJRD/UyZOWdyy8WjgQ5ChcilU6NfFgyuGf+TAg7nbxMErLPV
 yT4lKQNTdC0JfR696XSgKZHRsAWNgisvs1leZpf0YS9wDhWc8e/QkCt3d3x0fJ7CY7/d
 Unnw==
X-Gm-Message-State: AOJu0Yxd0zcwcpIQTDMt8M0ekqGyWBC8UiNyfjqmscfOL9Pk6haComyT
 a8f0Kx/VjgNjWDKlC+ttjwPuyBJO/HBTkD2Udovm4hYDjb9Nm751CHY615276Vxkhy+VRgExNmM
 mcrsflUC6yjDbfREzg29vaDslHdhDQZdNsC9HA7LSNDoGeChYSYdmLoyVi9hUOJnRgf9U0g/3E+
 kDmhvemwmJp+NHsT7Vs6hN/IH9WZs=
X-Received: by 2002:a05:6214:540d:b0:6cc:1f0:d38a with SMTP id
 6a1803df08f44-6d35c0f9e90mr294240036d6.14.1730916361111; 
 Wed, 06 Nov 2024 10:06:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0wqfyozikfjAxmD32e2AWJ8+UFycTBexDM3Y94uipFhuWqkj763OQqZ+jWxXQs/vA1pX6GLF8xmGDVab10+k=
X-Received: by 2002:a05:6214:540d:b0:6cc:1f0:d38a with SMTP id
 6a1803df08f44-6d35c0f9e90mr294239636d6.14.1730916360717; Wed, 06 Nov 2024
 10:06:00 -0800 (PST)
MIME-Version: 1.0
References: <20241106084134.1133061-1-demeng@redhat.com>
 <20241106084134.1133061-2-demeng@redhat.com>
In-Reply-To: <20241106084134.1133061-2-demeng@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 6 Nov 2024 20:05:49 +0200
Message-ID: <CAPMcbCp64JKJo-EGU2XCEgWpiK0zefCa_dF8BJqr2ypvXrfwkA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] qemu-ga: Add 'Null' check and Redefine 'route'
To: Dehan Meng <demeng@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, peter.maydell@linaro.org, 
 berrange@redhat.com
Content-Type: multipart/alternative; boundary="000000000000d122500626425e4e"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000d122500626425e4e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Best Regards,
Konstantin Kostiuk.


On Wed, Nov 6, 2024 at 10:41=E2=80=AFAM Dehan Meng <demeng@redhat.com> wrot=
e:

> sscanf return values are checked and add 'Null' check for
> mandatory parameters. And merged redundant route and
> networkroute variables.
>
> Signed-off-by: Dehan Meng <demeng@redhat.com>
> ---
>  qga/commands-linux.c | 86 +++++++++++++++++++++++---------------------
>  1 file changed, 45 insertions(+), 41 deletions(-)
>
> diff --git a/qga/commands-linux.c b/qga/commands-linux.c
> index 51d5e3d927..495de74b31 100644
> --- a/qga/commands-linux.c
> +++ b/qga/commands-linux.c
> @@ -2103,7 +2103,9 @@ static char *hexToIPAddress(const void *hexValue,
> int is_ipv6)
>          int i;
>
>          for (i =3D 0; i < 16; i++) {
> -            sscanf(&hexStr[i * 2], "%02hhx", &in6.s6_addr[i]);
> +            if (sscanf(&hex_str[i * 2], "%02hhx", &in6.s6_addr[i]) !=3D =
1) {
> +                return NULL;
> +            }
>          }
>          inet_ntop(AF_INET6, &in6, addr, INET6_ADDRSTRLEN);
>
> @@ -2160,26 +2162,25 @@ GuestNetworkRouteList
> *qmp_guest_network_get_route(Error **errp)
>                      continue;
>                  }
>
> -                route =3D g_new0(GuestNetworkRoute, 1);
> -                networkroute =3D route;
> -                networkroute->iface =3D g_strdup(Iface);
> -                networkroute->destination =3D hexToIPAddress(Destination=
,
> 1);
> -                networkroute->metric =3D Metric;
> -                networkroute->source =3D hexToIPAddress(Source, 1);
> -                networkroute->desprefixlen =3D g_strdup_printf(
> -                    "%d", DesPrefixlen
> -                );
> -                networkroute->srcprefixlen =3D g_strdup_printf(
> -                    "%d", SrcPrefixlen
> -                );
> -                networkroute->nexthop =3D hexToIPAddress(NextHop, 1);
> -                networkroute->has_flags =3D true;
> -                networkroute->flags =3D Flags;
> -                networkroute->has_refcnt =3D true;
> -                networkroute->refcnt =3D RefCnt;
> -                networkroute->has_use =3D true;
> -                networkroute->use =3D Use;
> -                networkroute->version =3D 6;
> +                g_autoptr(GuestNetworkRoute) route =3D
> g_new0(GuestNetworkRoute, 1);
> +
> +                route->destination =3D hex_to_ip_address(destination, 1)=
;
>

Compilation failed

../qga/commands-linux.c: In function =E2=80=98qmp_guest_network_get_route=
=E2=80=99:
../qga/commands-linux.c:2189:56: error: passing argument 1 of
=E2=80=98hex_to_ip_address=E2=80=99 makes pointer from integer without a ca=
st
[-Wint-conversion]
 2189 |                 route->destination =3D hex_to_ip_address(destinatio=
n,
1);
      |                                                        ^~~~~~~~~~~
      |                                                        |
      |                                                        unsigned int
../qga/commands-linux.c:2096:44: note: expected =E2=80=98const void *=E2=80=
=99 but argument
is of type =E2=80=98unsigned int=E2=80=99
 2096 | static char *hex_to_ip_address(const void *hex_value, int is_ipv6)
      |                                ~~~~~~~~~~~~^~~~~~~~~

You use `destination` but the variable declaration was not updated from
`Destination`.
The same for DesPrefixlen/des_prefixlen, Flags/flags, etc.

Looks like you mixed changes from the next commit into this one.

+                route->iface =3D g_strdup(iface);
> +                if (route->destination =3D=3D NULL) {
> +                    continue;
> +                }
> +                route->source =3D hex_to_ip_address(source, 1);
> +                route->nexthop =3D hex_to_ip_address(next_hop, 1);
> +                route->desprefixlen =3D g_strdup_printf("%d",
> des_prefixlen);
> +                route->srcprefixlen =3D g_strdup_printf("%d",
> src_prefixlen);
> +                route->metric =3D metric;
> +                route->has_flags =3D true;
> +                route->flags =3D flags;
> +                route->has_refcnt =3D true;
> +                route->refcnt =3D refcnt;
> +                route->has_use =3D true;
> +                route->use =3D use;
> +                route->version =3D 6;
>              } else {
>                  unsigned int Destination, Gateway, Mask, Flags;
>                  int RefCnt, Use, Metric, MTU, Window, IRTT;
> @@ -2191,26 +2192,29 @@ GuestNetworkRouteList
> *qmp_guest_network_get_route(Error **errp)
>                      continue;
>                  }
>
> -                route =3D g_new0(GuestNetworkRoute, 1);
> -                networkroute =3D route;
> -                networkroute->iface =3D g_strdup(Iface);
> -                networkroute->destination =3D hexToIPAddress(&Destinatio=
n,
> 0);
> -                networkroute->gateway =3D hexToIPAddress(&Gateway, 0);
> -                networkroute->mask =3D hexToIPAddress(&Mask, 0);
> -                networkroute->metric =3D Metric;
> -                networkroute->has_flags =3D true;
> -                networkroute->flags =3D Flags;
> -                networkroute->has_refcnt =3D true;
> -                networkroute->refcnt =3D RefCnt;
> -                networkroute->has_use =3D true;
> -                networkroute->use =3D Use;
> -                networkroute->has_mtu =3D true;
> -                networkroute->mtu =3D MTU;
> -                networkroute->has_window =3D true;
> -                networkroute->window =3D Window;
> -                networkroute->has_irtt =3D true;
> -                networkroute->irtt =3D IRTT;
> -                networkroute->version =3D 4;
> +                g_autoptr(GuestNetworkRoute) route =3D
> g_new0(GuestNetworkRoute, 1);
> +
> +                route->destination =3D hex_to_ip_address(destination, 1)=
;
> +                route->iface =3D g_strdup(iface);
> +                if (route->destination =3D=3D NULL) {
> +                    continue;
> +                }
> +                route->gateway =3D hex_to_ip_address(&gateway, 0);
> +                route->mask =3D hex_to_ip_address(&mask, 0);
> +                route->metric =3D metric;
> +                route->has_flags =3D true;
> +                route->flags =3D flags;
> +                route->has_refcnt =3D true;
> +                route->refcnt =3D refcnt;
> +                route->has_use =3D true;
> +                route->use =3D use;
> +                route->has_mtu =3D true;
> +                route->mtu =3D mtu;
> +                route->has_window =3D true;
> +                route->window =3D window;
> +                route->has_irtt =3D true;
> +                route->irtt =3D irtt;
> +                route->version =3D 4;
>              }
>
>              QAPI_LIST_APPEND(tail, route);
> --
> 2.40.1
>
>

--000000000000d122500626425e4e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyIGNsZWFyPSJhbGwiPjxkaXY+PGRpdiBk
aXI9Imx0ciIgY2xhc3M9ImdtYWlsX3NpZ25hdHVyZSI+PGRpdiBkaXI9Imx0ciI+PGRpdj5CZXN0
IFJlZ2FyZHMsPC9kaXY+PGRpdj5Lb25zdGFudGluIEtvc3RpdWsuPC9kaXY+PC9kaXY+PC9kaXY+
PC9kaXY+PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0
ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFdlZCwgTm92IDYsIDIwMjQgYXQgMTA6NDHigK9BTSBE
ZWhhbiBNZW5nICZsdDs8YSBocmVmPSJtYWlsdG86ZGVtZW5nQHJlZGhhdC5jb20iPmRlbWVuZ0By
ZWRoYXQuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFp
bF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHgg
c29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5zc2NhbmYgcmV0dXJuIHZh
bHVlcyBhcmUgY2hlY2tlZCBhbmQgYWRkICYjMzk7TnVsbCYjMzk7IGNoZWNrIGZvcjxicj4NCm1h
bmRhdG9yeSBwYXJhbWV0ZXJzLiBBbmQgbWVyZ2VkIHJlZHVuZGFudCByb3V0ZSBhbmQ8YnI+DQpu
ZXR3b3Jrcm91dGUgdmFyaWFibGVzLjxicj4NCjxicj4NClNpZ25lZC1vZmYtYnk6IERlaGFuIE1l
bmcgJmx0OzxhIGhyZWY9Im1haWx0bzpkZW1lbmdAcmVkaGF0LmNvbSIgdGFyZ2V0PSJfYmxhbmsi
PmRlbWVuZ0ByZWRoYXQuY29tPC9hPiZndDs8YnI+DQotLS08YnI+DQrCoHFnYS9jb21tYW5kcy1s
aW51eC5jIHwgODYgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS08
YnI+DQrCoDEgZmlsZSBjaGFuZ2VkLCA0NSBpbnNlcnRpb25zKCspLCA0MSBkZWxldGlvbnMoLSk8
YnI+DQo8YnI+DQpkaWZmIC0tZ2l0IGEvcWdhL2NvbW1hbmRzLWxpbnV4LmMgYi9xZ2EvY29tbWFu
ZHMtbGludXguYzxicj4NCmluZGV4IDUxZDVlM2Q5MjcuLjQ5NWRlNzRiMzEgMTAwNjQ0PGJyPg0K
LS0tIGEvcWdhL2NvbW1hbmRzLWxpbnV4LmM8YnI+DQorKysgYi9xZ2EvY29tbWFuZHMtbGludXgu
Yzxicj4NCkBAIC0yMTAzLDcgKzIxMDMsOSBAQCBzdGF0aWMgY2hhciAqaGV4VG9JUEFkZHJlc3Mo
Y29uc3Qgdm9pZCAqaGV4VmFsdWUsIGludCBpc19pcHY2KTxicj4NCsKgIMKgIMKgIMKgIMKgaW50
IGk7PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqBmb3IgKGkgPSAwOyBpICZsdDsgMTY7IGkrKykg
ezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBzc2NhbmYoJmFtcDtoZXhTdHJbaSAqIDJdLCAmcXVv
dDslMDJoaHgmcXVvdDssICZhbXA7aW42LnM2X2FkZHJbaV0pOzxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCBpZiAoc3NjYW5mKCZhbXA7aGV4X3N0cltpICogMl0sICZxdW90OyUwMmhoeCZxdW90Oywg
JmFtcDtpbjYuczZfYWRkcltpXSkgIT0gMSkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCByZXR1cm4gTlVMTDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgfTxicj4NCsKgIMKgIMKgIMKg
IMKgfTxicj4NCsKgIMKgIMKgIMKgIMKgaW5ldF9udG9wKEFGX0lORVQ2LCAmYW1wO2luNiwgYWRk
ciwgSU5FVDZfQUREUlNUUkxFTik7PGJyPg0KPGJyPg0KQEAgLTIxNjAsMjYgKzIxNjIsMjUgQEAg
R3Vlc3ROZXR3b3JrUm91dGVMaXN0ICpxbXBfZ3Vlc3RfbmV0d29ya19nZXRfcm91dGUoRXJyb3Ig
KiplcnJwKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29udGludWU7PGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHJvdXRlID0gZ19uZXcwKEd1ZXN0TmV0d29ya1JvdXRlLCAxKTs8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgbmV0d29ya3JvdXRlID0gcm91dGU7PGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIG5ldHdvcmtyb3V0ZS0mZ3Q7aWZhY2UgPSBnX3N0cmR1cChJZmFjZSk7
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG5ldHdvcmtyb3V0ZS0mZ3Q7ZGVzdGluYXRp
b24gPSBoZXhUb0lQQWRkcmVzcyhEZXN0aW5hdGlvbiwgMSk7PGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIG5ldHdvcmtyb3V0ZS0mZ3Q7bWV0cmljID0gTWV0cmljOzxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBuZXR3b3Jrcm91dGUtJmd0O3NvdXJjZSA9IGhleFRvSVBBZGRyZXNz
KFNvdXJjZSwgMSk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG5ldHdvcmtyb3V0ZS0m
Z3Q7ZGVzcHJlZml4bGVuID0gZ19zdHJkdXBfcHJpbnRmKDxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCAmcXVvdDslZCZxdW90OywgRGVzUHJlZml4bGVuPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgICk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG5ldHdvcmty
b3V0ZS0mZ3Q7c3JjcHJlZml4bGVuID0gZ19zdHJkdXBfcHJpbnRmKDxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDslZCZxdW90OywgU3JjUHJlZml4bGVuPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgICk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG5l
dHdvcmtyb3V0ZS0mZ3Q7bmV4dGhvcCA9IGhleFRvSVBBZGRyZXNzKE5leHRIb3AsIDEpOzxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBuZXR3b3Jrcm91dGUtJmd0O2hhc19mbGFncyA9IHRy
dWU7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG5ldHdvcmtyb3V0ZS0mZ3Q7ZmxhZ3Mg
PSBGbGFnczs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbmV0d29ya3JvdXRlLSZndDto
YXNfcmVmY250ID0gdHJ1ZTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbmV0d29ya3Jv
dXRlLSZndDtyZWZjbnQgPSBSZWZDbnQ7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG5l
dHdvcmtyb3V0ZS0mZ3Q7aGFzX3VzZSA9IHRydWU7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIG5ldHdvcmtyb3V0ZS0mZ3Q7dXNlID0gVXNlOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBuZXR3b3Jrcm91dGUtJmd0O3ZlcnNpb24gPSA2Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBnX2F1dG9wdHIoR3Vlc3ROZXR3b3JrUm91dGUpIHJvdXRlID0gZ19uZXcwKEd1ZXN0
TmV0d29ya1JvdXRlLCAxKTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJv
dXRlLSZndDtkZXN0aW5hdGlvbiA9IGhleF90b19pcF9hZGRyZXNzKGRlc3RpbmF0aW9uLCAxKTs8
YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+Q29tcGlsYXRpb24gZmFpbGVkPGJy
PjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+Li4vcWdhL2NvbW1hbmRzLWxpbnV4LmM6IEluIGZ1
bmN0aW9uIOKAmHFtcF9ndWVzdF9uZXR3b3JrX2dldF9yb3V0ZeKAmTo8YnI+Li4vcWdhL2NvbW1h
bmRzLWxpbnV4LmM6MjE4OTo1NjogZXJyb3I6IHBhc3NpbmcgYXJndW1lbnQgMSBvZiDigJhoZXhf
dG9faXBfYWRkcmVzc+KAmSBtYWtlcyBwb2ludGVyIGZyb20gaW50ZWdlciB3aXRob3V0IGEgY2Fz
dCBbLVdpbnQtY29udmVyc2lvbl08YnI+wqAyMTg5IHwgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
cm91dGUtJmd0O2Rlc3RpbmF0aW9uID0gaGV4X3RvX2lwX2FkZHJlc3MoZGVzdGluYXRpb24sIDEp
Ozxicj7CoCDCoCDCoCB8IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXn5+fn5+fn5+fn48YnI+
wqAgwqAgwqAgfCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHw8YnI+wqAgwqAgwqAgfCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHVuc2lnbmVkIGludDxicj4uLi9xZ2EvY29tbWFuZHMtbGlu
dXguYzoyMDk2OjQ0OiBub3RlOiBleHBlY3RlZCDigJhjb25zdCB2b2lkICrigJkgYnV0IGFyZ3Vt
ZW50IGlzIG9mIHR5cGUg4oCYdW5zaWduZWQgaW504oCZPGJyPsKgMjA5NiB8IHN0YXRpYyBjaGFy
ICpoZXhfdG9faXBfYWRkcmVzcyhjb25zdCB2b2lkICpoZXhfdmFsdWUsIGludCBpc19pcHY2KTxi
cj7CoCDCoCDCoCB8IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgfn5+fn5+fn5+fn5+Xn5+fn5+fn5+PC9kaXY+PGRpdj7CoDwvZGl2PjxkaXY+WW91IHVzZSBg
ZGVzdGluYXRpb25gIGJ1dCB0aGUgdmFyaWFibGUgZGVjbGFyYXRpb24gd2FzIG5vdCB1cGRhdGVk
IGZyb20gYERlc3RpbmF0aW9uYC48L2Rpdj48ZGl2PlRoZSBzYW1lIGZvciBEZXNQcmVmaXhsZW4v
ZGVzX3ByZWZpeGxlbiwgRmxhZ3MvZmxhZ3MsIGV0Yy4gPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+TG9va3MgbGlrZSB5b3UgbWl4ZWQgY2hhbmdlcyBmcm9tIHRoZSBuZXh0IGNvbW1pdCBp
bnRvIHRoaXMgb25lLjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0i
Z21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6
MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgcm91dGUtJmd0O2lmYWNlID0gZ19zdHJkdXAoaWZhY2UpOzxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAocm91dGUtJmd0O2Rlc3RpbmF0aW9uID09IE5VTEwp
IHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY29udGludWU7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcm91
dGUtJmd0O3NvdXJjZSA9IGhleF90b19pcF9hZGRyZXNzKHNvdXJjZSwgMSk7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHJvdXRlLSZndDtuZXh0aG9wID0gaGV4X3RvX2lwX2FkZHJlc3Mo
bmV4dF9ob3AsIDEpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByb3V0ZS0mZ3Q7ZGVz
cHJlZml4bGVuID0gZ19zdHJkdXBfcHJpbnRmKCZxdW90OyVkJnF1b3Q7LCBkZXNfcHJlZml4bGVu
KTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcm91dGUtJmd0O3NyY3ByZWZpeGxlbiA9
IGdfc3RyZHVwX3ByaW50ZigmcXVvdDslZCZxdW90Oywgc3JjX3ByZWZpeGxlbik7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJvdXRlLSZndDttZXRyaWMgPSBtZXRyaWM7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJvdXRlLSZndDtoYXNfZmxhZ3MgPSB0cnVlOzxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByb3V0ZS0mZ3Q7ZmxhZ3MgPSBmbGFnczs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgcm91dGUtJmd0O2hhc19yZWZjbnQgPSB0cnVlOzxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByb3V0ZS0mZ3Q7cmVmY250ID0gcmVmY250Ozxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByb3V0ZS0mZ3Q7aGFzX3VzZSA9IHRydWU7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJvdXRlLSZndDt1c2UgPSB1c2U7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIHJvdXRlLSZndDt2ZXJzaW9uID0gNjs8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoH0gZWxzZSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1bnNpZ25lZCBp
bnQgRGVzdGluYXRpb24sIEdhdGV3YXksIE1hc2ssIEZsYWdzOzxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgaW50IFJlZkNudCwgVXNlLCBNZXRyaWMsIE1UVSwgV2luZG93LCBJUlRUOzxi
cj4NCkBAIC0yMTkxLDI2ICsyMTkyLDI5IEBAIEd1ZXN0TmV0d29ya1JvdXRlTGlzdCAqcW1wX2d1
ZXN0X25ldHdvcmtfZ2V0X3JvdXRlKEVycm9yICoqZXJycCk8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGNvbnRpbnVlOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
fTxicj4NCjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByb3V0ZSA9IGdfbmV3MChHdWVz
dE5ldHdvcmtSb3V0ZSwgMSk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG5ldHdvcmty
b3V0ZSA9IHJvdXRlOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBuZXR3b3Jrcm91dGUt
Jmd0O2lmYWNlID0gZ19zdHJkdXAoSWZhY2UpOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBuZXR3b3Jrcm91dGUtJmd0O2Rlc3RpbmF0aW9uID0gaGV4VG9JUEFkZHJlc3MoJmFtcDtEZXN0
aW5hdGlvbiwgMCk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG5ldHdvcmtyb3V0ZS0m
Z3Q7Z2F0ZXdheSA9IGhleFRvSVBBZGRyZXNzKCZhbXA7R2F0ZXdheSwgMCk7PGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIG5ldHdvcmtyb3V0ZS0mZ3Q7bWFzayA9IGhleFRvSVBBZGRyZXNz
KCZhbXA7TWFzaywgMCk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG5ldHdvcmtyb3V0
ZS0mZ3Q7bWV0cmljID0gTWV0cmljOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBuZXR3
b3Jrcm91dGUtJmd0O2hhc19mbGFncyA9IHRydWU7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIG5ldHdvcmtyb3V0ZS0mZ3Q7ZmxhZ3MgPSBGbGFnczs8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgbmV0d29ya3JvdXRlLSZndDtoYXNfcmVmY250ID0gdHJ1ZTs8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgbmV0d29ya3JvdXRlLSZndDtyZWZjbnQgPSBSZWZDbnQ7PGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG5ldHdvcmtyb3V0ZS0mZ3Q7aGFzX3VzZSA9IHRydWU7
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG5ldHdvcmtyb3V0ZS0mZ3Q7dXNlID0gVXNl
Ozxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBuZXR3b3Jrcm91dGUtJmd0O2hhc19tdHUg
PSB0cnVlOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBuZXR3b3Jrcm91dGUtJmd0O210
dSA9IE1UVTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbmV0d29ya3JvdXRlLSZndDto
YXNfd2luZG93ID0gdHJ1ZTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbmV0d29ya3Jv
dXRlLSZndDt3aW5kb3cgPSBXaW5kb3c7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG5l
dHdvcmtyb3V0ZS0mZ3Q7aGFzX2lydHQgPSB0cnVlOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBuZXR3b3Jrcm91dGUtJmd0O2lydHQgPSBJUlRUOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBuZXR3b3Jrcm91dGUtJmd0O3ZlcnNpb24gPSA0Ozxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBnX2F1dG9wdHIoR3Vlc3ROZXR3b3JrUm91dGUpIHJvdXRlID0gZ19uZXcwKEd1
ZXN0TmV0d29ya1JvdXRlLCAxKTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHJvdXRlLSZndDtkZXN0aW5hdGlvbiA9IGhleF90b19pcF9hZGRyZXNzKGRlc3RpbmF0aW9uLCAx
KTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcm91dGUtJmd0O2lmYWNlID0gZ19zdHJk
dXAoaWZhY2UpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAocm91dGUtJmd0O2Rl
c3RpbmF0aW9uID09IE5VTEwpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
Y29udGludWU7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgcm91dGUtJmd0O2dhdGV3YXkgPSBoZXhfdG9faXBfYWRkcmVzcygmYW1w
O2dhdGV3YXksIDApOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByb3V0ZS0mZ3Q7bWFz
ayA9IGhleF90b19pcF9hZGRyZXNzKCZhbXA7bWFzaywgMCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHJvdXRlLSZndDttZXRyaWMgPSBtZXRyaWM7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHJvdXRlLSZndDtoYXNfZmxhZ3MgPSB0cnVlOzxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCByb3V0ZS0mZ3Q7ZmxhZ3MgPSBmbGFnczs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgcm91dGUtJmd0O2hhc19yZWZjbnQgPSB0cnVlOzxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCByb3V0ZS0mZ3Q7cmVmY250ID0gcmVmY250Ozxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCByb3V0ZS0mZ3Q7aGFzX3VzZSA9IHRydWU7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHJvdXRlLSZndDt1c2UgPSB1c2U7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHJvdXRlLSZndDtoYXNfbXR1ID0gdHJ1ZTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgcm91dGUtJmd0O210dSA9IG10dTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcm91
dGUtJmd0O2hhc193aW5kb3cgPSB0cnVlOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBy
b3V0ZS0mZ3Q7d2luZG93ID0gd2luZG93Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBy
b3V0ZS0mZ3Q7aGFzX2lydHQgPSB0cnVlOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBy
b3V0ZS0mZ3Q7aXJ0dCA9IGlydHQ7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJvdXRl
LSZndDt2ZXJzaW9uID0gNDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQo8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoFFBUElfTElTVF9BUFBFTkQodGFpbCwgcm91dGUpOzxicj4NCi0t
IDxicj4NCjIuNDAuMTxicj4NCjxicj4NCjwvYmxvY2txdW90ZT48L2Rpdj48L2Rpdj4NCg==
--000000000000d122500626425e4e--


