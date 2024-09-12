Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707B0EE645B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 07:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soegW-0005bB-D4; Thu, 12 Sep 2024 03:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1soegT-0005Hq-2d
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:56:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1soegR-0003QF-Fs
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726127766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=US7inYOSex26au2+otWw4xhlYozguPZwZAr72xRmINc=;
 b=VAPUY1aMhgYdJttparGIDYPGax2PH5qgtUDKo2oeUGnD1z+MHbV0vqZnXuukGpCwpg+Gqa
 6ywd4mGl3T1hmA72nA9tjR1KEmbAVasJMYn+GM2iVxU2BJalfidWZJGYm91EXkJyw42nox
 lB0VZNx1hwsefNAvldh0/WAOBaGQFdg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-IhsV0tBQN2yOGv7mphXSxQ-1; Thu, 12 Sep 2024 03:56:04 -0400
X-MC-Unique: IhsV0tBQN2yOGv7mphXSxQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6c35d6feed7so15793886d6.0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 00:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726127764; x=1726732564;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=US7inYOSex26au2+otWw4xhlYozguPZwZAr72xRmINc=;
 b=h1vmObMHEY1yb4S91mhbDIXTx7153csBwmHnUaal+p6ipL1JfnuRgJOQz4C/37PvqF
 G3NOa06MYGPIWY/W3DDCLgrHfyvlCx2K++NFPgLOdjm2+EYZJQO64v4WM+Nt2kkT68qn
 Ic24CiNneHXSzKogEusMpO0CgpH/KYrta+QZRHVpc7FDIxl67kUP/I+sq1ZT9/a0DEU+
 FYpCV7DnHAkrHB/S4/CRdViF94wuMJwM9aofkX2l8IBxEYEfQ7UCvGQSk/su+Ey0iNMD
 9CRrZJmoc6vz3thLP1MpLzGrLB1hYaad32cD8wcEOu28xgxcfMBNfx+clvd4HbtXV70L
 Cgbg==
X-Gm-Message-State: AOJu0Yx4ZVWyv6iUPljsmVCLjnIfe/qGM+VQT1sQEVG9qf9CIRomn2Rh
 uxKXWV7dIPlpLFjPP6HARUauKdeml0tuSxEHuidW+RdDuQzsUZOUMcDJACzTcogX/ROKKge4od9
 OHI5rDJ7G6HhlgqWnnYb4a3FRe5nyaB5RD2mggZFx4TJBwT5uy/BM6CGYpyAqzE0jgYFQudsSnt
 JvP9xN8SC3ohRxi16I+S0VzW/sZaSDGMnrEKLet6W1
X-Received: by 2002:a05:6214:5712:b0:6c5:637d:bacd with SMTP id
 6a1803df08f44-6c5735304e4mr28404216d6.31.1726127764001; 
 Thu, 12 Sep 2024 00:56:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE5Q8+DwmgOvNdqLKK9nPQD6mDHQwm6yA0Y4WNAlskAPC6gytCGIlXW99wPoHIp7MPD3O1ankHluGxalfGimc=
X-Received: by 2002:a05:6214:5712:b0:6c5:637d:bacd with SMTP id
 6a1803df08f44-6c5735304e4mr28404046d6.31.1726127763609; Thu, 12 Sep 2024
 00:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240911131206.2503035-1-armbru@redhat.com>
 <20240911131206.2503035-3-armbru@redhat.com>
In-Reply-To: <20240911131206.2503035-3-armbru@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Thu, 12 Sep 2024 10:55:53 +0300
Message-ID: <CAPMcbCqe=-ufnED2juwyAWS4PrLknutqwoyUTj5RUwUM==BPTw@mail.gmail.com>
Subject: Re: [PATCH 2/2] qga: Improve error for guest-set-user-password
 parameter @crypted
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, eblake@redhat.com, 
 philmd@linaro.org
Content-Type: multipart/alternative; boundary="0000000000002ffa960621e77006"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--0000000000002ffa960621e77006
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Wed, Sep 11, 2024 at 4:12=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> The Windows version of guest-set-user-password rejects argument
> "crypted": true with the rather useless "this feature or command is
> not currently supported".  Improve to "'crypted' must be off on this
> host".
>
> QERR_UNSUPPORTED is now unused.  Drop.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/qmp/qerror.h | 3 ---
>  qga/commands-win32.c      | 2 +-
>  2 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
> index 38e89762b3..101c1141b9 100644
> --- a/include/qapi/qmp/qerror.h
> +++ b/include/qapi/qmp/qerror.h
> @@ -26,7 +26,4 @@
>  #define QERR_PROPERTY_VALUE_OUT_OF_RANGE \
>      "Property %s.%s doesn't take value %" PRId64 " (minimum: %" PRId64 "=
,
> maximum: %" PRId64 ")"
>
> -#define QERR_UNSUPPORTED \
> -    "this feature or command is not currently supported"
> -
>  #endif /* QERROR_H */
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 61b36da469..038beb8cfa 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -1914,7 +1914,7 @@ void qmp_guest_set_user_password(const char
> *username,
>      GError *gerr =3D NULL;
>
>      if (crypted) {
> -        error_setg(errp, QERR_UNSUPPORTED);
> +        error_setg(errp, "'crypted' must be off on this host");
>          return;
>      }
>
> --
> 2.46.0
>
>

--0000000000002ffa960621e77006
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 1=
1, 2024 at 4:12=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@r=
edhat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">The Windows version of guest-set-user-password =
rejects argument<br>
&quot;crypted&quot;: true with the rather useless &quot;this feature or com=
mand is<br>
not currently supported&quot;.=C2=A0 Improve to &quot;&#39;crypted&#39; mus=
t be off on this<br>
host&quot;.<br>
<br>
QERR_UNSUPPORTED is now unused.=C2=A0 Drop.<br>
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br>
---<br>
=C2=A0include/qapi/qmp/qerror.h | 3 ---<br>
=C2=A0qga/commands-win32.c=C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A02 files changed, 1 insertion(+), 4 deletions(-)<br>
<br>
diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h<br>
index 38e89762b3..101c1141b9 100644<br>
--- a/include/qapi/qmp/qerror.h<br>
+++ b/include/qapi/qmp/qerror.h<br>
@@ -26,7 +26,4 @@<br>
=C2=A0#define QERR_PROPERTY_VALUE_OUT_OF_RANGE \<br>
=C2=A0 =C2=A0 =C2=A0&quot;Property %s.%s doesn&#39;t take value %&quot; PRI=
d64 &quot; (minimum: %&quot; PRId64 &quot;, maximum: %&quot; PRId64 &quot;)=
&quot;<br>
<br>
-#define QERR_UNSUPPORTED \<br>
-=C2=A0 =C2=A0 &quot;this feature or command is not currently supported&quo=
t;<br>
-<br>
=C2=A0#endif /* QERROR_H */<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index 61b36da469..038beb8cfa 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -1914,7 +1914,7 @@ void qmp_guest_set_user_password(const char *username=
,<br>
=C2=A0 =C2=A0 =C2=A0GError *gerr =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (crypted) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;&#39;crypted&#39; must =
be off on this host&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-- <br>
2.46.0<br>
<br>
</blockquote></div>

--0000000000002ffa960621e77006--


