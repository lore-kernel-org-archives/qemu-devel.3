Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E559D59F5A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 18:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8kRh-0003Qg-At; Wed, 06 Nov 2024 13:07:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t8kRb-0003Ia-Jb
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:07:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t8kRZ-0005jB-Ck
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730916468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KwmrM0PfD8swxHb9cqvqHY0JQJDfNR8Ws1C+TpkKGV8=;
 b=XXw3ywbKxipBw/amvxD9b2fCgmygYsVV2V4davpc7buup9gqO8rtNsuipR/hejIZLZByqA
 Gg3hvcSMNHtTlwzKycj5qC+1JoyM0yYpRYc3YHxxhgZhpdgGPdTRZ0z+k01ySwp9TW8bOH
 Rn8RmkPbnvmNntN7NbDiCYZTpGo/ddU=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-VLkL5rM5NPyB3UemrqQjXg-1; Wed, 06 Nov 2024 13:07:43 -0500
X-MC-Unique: VLkL5rM5NPyB3UemrqQjXg-1
X-Mimecast-MFC-AGG-ID: VLkL5rM5NPyB3UemrqQjXg
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3e6594fde2cso112937b6e.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 10:07:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730916463; x=1731521263;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KwmrM0PfD8swxHb9cqvqHY0JQJDfNR8Ws1C+TpkKGV8=;
 b=huTYQrkClyy2Hhw7fPi0hbQuIfHxmjDgntDNmH4ava8ARaOl6gsl8l68JZ/+64Xu7r
 USyK7UsU8t9s2b4rHCK/gqqg9iubGyEGEzecCwjeI0JAnJMvkIntCbDOUSg/Vjwu7PCX
 mfeKXQRthZcypJCL2VFjPqALKgTi61QORNdpcMus+bMp1g21XUOHMIzfVPMQlAB2U+1n
 CvgyNoICpoCKR/f7WHXtFr8IBHi7Yza/Wqa9lQlv7LBfNAR0hBhhPDFg3GWsyrv0jvt0
 Vnbpf6MB9djpAW2LoGN1CIN/mmqQ0wgv7bRJwHVQ3xMKzbFJZuig8CJturjqWB76v0T8
 G0YQ==
X-Gm-Message-State: AOJu0YyYGwm1W4onog1MJHVp3Of2llM/MNcPWpOwv6xukCPFoqRxFkcU
 cWCWGkFJyttWIed//Khz2F0zWOBRlvZ3vFWz3JkmooUIxyyxKwPb4XXEc9LGLHhOc5PD2C3rQzK
 PcXuCuXgGoV+AiMNuhcut2XEPNu+9lJ27bmvwvboXUy0KqyCalBJkIh2q00xRyodl5V6e/xBXgo
 AvnNtUm75CwwgfaWMFWz0n9yILl7w=
X-Received: by 2002:a05:6808:1925:b0:3e5:f9ee:a2b3 with SMTP id
 5614622812f47-3e63824b4ecmr40564339b6e.4.1730916462991; 
 Wed, 06 Nov 2024 10:07:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWupS70YE8PAwlQm9pJdcWCFkm62wn3Tw5WUEnM25Fm/E64WDhUpTvT/iPwBjEuw8IBUKcBb8pUVXZvjUT+cg=
X-Received: by 2002:a05:6808:1925:b0:3e5:f9ee:a2b3 with SMTP id
 5614622812f47-3e63824b4ecmr40564307b6e.4.1730916462636; Wed, 06 Nov 2024
 10:07:42 -0800 (PST)
MIME-Version: 1.0
References: <20241106084134.1133061-1-demeng@redhat.com>
 <20241106084134.1133061-4-demeng@redhat.com>
In-Reply-To: <20241106084134.1133061-4-demeng@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 6 Nov 2024 20:07:32 +0200
Message-ID: <CAPMcbCrySnTSECofboQdPUA5ROZeO+na5n9O3+i=T-b7E7spnQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] qemu-ga: Avoiding freeing line prematurely
To: Dehan Meng <demeng@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, peter.maydell@linaro.org, 
 berrange@redhat.com
Content-Type: multipart/alternative; boundary="000000000000e4446406264264dc"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000e4446406264264dc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 10:42=E2=80=AFAM Dehan Meng <demeng@redhat.com> wrot=
e:

> It's now only freed at the end of the function.
>
> Signed-off-by: Dehan Meng <demeng@redhat.com>
> ---
>  qga/commands-linux.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/qga/commands-linux.c b/qga/commands-linux.c
> index 55c35bfc8f..70020621bf 100644
> --- a/qga/commands-linux.c
> +++ b/qga/commands-linux.c
> @@ -2138,8 +2138,7 @@ GuestNetworkRouteList
> *qmp_guest_network_get_route(Error **errp)
>          is_ipv6 =3D (i =3D=3D 1);
>          fp =3D fopen(routeFiles[i], "r");
>          if (fp =3D=3D NULL) {
> -            error_setg_errno(errp, errno, "open(\"%s\")", routeFiles[i])=
;
> -            free(line);
> +            error_setg_errno(errp, errno, "open(\"%s\")", route_files[i]=
);
>

Compilation failed

../qga/commands-linux.c:2140:59: error: =E2=80=98route_files=E2=80=99 undec=
lared (first use
in this function); did you mean =E2=80=98routeFiles=E2=80=99?
 2140 |             error_setg_errno(errp, errno, "open(\"%s\")",
route_files[i]);



>              continue;
>          }
>
> @@ -2148,7 +2147,6 @@ GuestNetworkRouteList
> *qmp_guest_network_get_route(Error **errp)
>                  firstLine =3D 0;
>                  continue;
>              }
> -
>              if (is_ipv6) {
>                  char destination[33], source[33], next_hop[33];
>                  int des_prefixlen, src_prefixlen, metric, refcnt, use,
> flags;
> @@ -2215,9 +2213,8 @@ GuestNetworkRouteList
> *qmp_guest_network_get_route(Error **errp)
>              QAPI_LIST_APPEND(tail, route);
>          }
>
> -        free(line);
>          fclose(fp);
>      }
> -
> +    free(line);
>      return head;
>  }
> --
> 2.40.1
>
>

--000000000000e4446406264264dc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 6, 2024 at 10:42=E2=80=AF=
AM Dehan Meng &lt;<a href=3D"mailto:demeng@redhat.com">demeng@redhat.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">It&=
#39;s now only freed at the end of the function.<br>
<br>
Signed-off-by: Dehan Meng &lt;<a href=3D"mailto:demeng@redhat.com" target=
=3D"_blank">demeng@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-linux.c | 7 ++-----<br>
=C2=A01 file changed, 2 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/qga/commands-linux.c b/qga/commands-linux.c<br>
index 55c35bfc8f..70020621bf 100644<br>
--- a/qga/commands-linux.c<br>
+++ b/qga/commands-linux.c<br>
@@ -2138,8 +2138,7 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Er=
ror **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0is_ipv6 =3D (i =3D=3D 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(routeFiles[i], &quot;r&quot;=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fp =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &q=
uot;open(\&quot;%s\&quot;)&quot;, routeFiles[i]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(line);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &q=
uot;open(\&quot;%s\&quot;)&quot;, route_files[i]);<br></blockquote><div><br=
></div><div>Compilation failed</div><div><br></div><div>../qga/commands-lin=
ux.c:2140:59: error: =E2=80=98route_files=E2=80=99 undeclared (first use in=
 this function); did you mean =E2=80=98routeFiles=E2=80=99?<br>=C2=A02140 |=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &q=
uot;open(\&quot;%s\&quot;)&quot;, route_files[i]);</div><div><br></div><div=
>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -2148,7 +2147,6 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Er=
ror **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0firstLine =3D=
 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_ipv6) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char destinat=
ion[33], source[33], next_hop[33];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int des_prefi=
xlen, src_prefixlen, metric, refcnt, use, flags;<br>
@@ -2215,9 +2213,8 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Er=
ror **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QAPI_LIST_APPEND(tail, rout=
e);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(line);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fclose(fp);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-<br>
+=C2=A0 =C2=A0 free(line);<br>
=C2=A0 =C2=A0 =C2=A0return head;<br>
=C2=A0}<br>
-- <br>
2.40.1<br>
<br>
</blockquote></div></div>

--000000000000e4446406264264dc--


