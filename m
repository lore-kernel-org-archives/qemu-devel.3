Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24CBC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 08:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSBtL-0003IW-9y; Fri, 12 Jul 2024 04:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBtG-0002t6-Un
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:44:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBss-0001zp-Hy
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720773844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iiLkamLg2sNsDvvkLH1N2ZXWd4UPM4EfyFI9xAGPwnU=;
 b=djQyErW44Q3TziEV+LUXmuR6vVdYrKOKzoyS2XrIzIWJ/1tpa9t15pGhUJHOuGEws6cdnF
 A+9etPKe8bnlf5yQGmb1H5QpKw9zzawZL5BkSPPOgtmbHAYUH/G0mecbM7Z2qxoeLXmb5M
 Z+k3Kqn97TVSxtZrcZEp/hWBUpulN4o=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-zPSauhLSO8Cx-EbzpN8W0A-1; Fri, 12 Jul 2024 04:44:00 -0400
X-MC-Unique: zPSauhLSO8Cx-EbzpN8W0A-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-64b5588bcafso31333007b3.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 01:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720773840; x=1721378640;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iiLkamLg2sNsDvvkLH1N2ZXWd4UPM4EfyFI9xAGPwnU=;
 b=Iui5twjMYsO4dIYpTKdl/I2KcDR1y0fvheWMY6h5OgVs/ueKQCrmjgSg/VepISxH4F
 CHYqSPeYSjSL3SkD7g4sse6AyCIzry4X98aSeBzGD4iYx4V9ZhDC3prw0GsZiE3NAnXP
 EEAb/PSiJiLWL42IncJXk/OlUnfFpnbL/9W96n7cci4uZLPtjRLG5asUlDZb2bjfYBWZ
 WPxA91GoCmXjiZcdrfEvCXw513zlOhkpun296iA9qeeDedyKJWrpQMtBWdG/RfTV7Ifm
 /chy00rs28jWHKkTIWr6RemA4xlqqfnF1nFEl1u0qFpORM45qrxFibYswLdvrQdGJHpF
 0bKw==
X-Gm-Message-State: AOJu0YzrT4g2MsroINJXphjCA69kLdnGkaP9vE3NFKQ7hfdqdKpXRiJi
 5bVAZHLqfdXBefLKoIrIMDSQcJK4dyYND7w8ZoEYl8PY2jjOJ+ouotReEN0BbqoCZYjiGC+iKsO
 AlRHOE9MBOcdzEzHU256Mu0XBx/pXcuLjHFNmNcrlpnRUp4RmDPAtII98EVwdgV42572o5OxsA1
 Cc1FoH9sEJK3Va5rZrm6f0Va9XskA=
X-Received: by 2002:a0d:e645:0:b0:631:7b18:91a2 with SMTP id
 00721157ae682-65cd82c3626mr47314397b3.20.1720773840242; 
 Fri, 12 Jul 2024 01:44:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz8KPtrvxOdAXkpWRhXmCTyr2EYPhqwFaeNJaq+AJ5//iewNa1Gl06LAFnidKZ6+K9cPYUHFlqzEqXXIBI1vE=
X-Received: by 2002:a0d:e645:0:b0:631:7b18:91a2 with SMTP id
 00721157ae682-65cd82c3626mr47314237b3.20.1720773840014; Fri, 12 Jul 2024
 01:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-12-berrange@redhat.com>
In-Reply-To: <20240613154406.1365469-12-berrange@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 12 Jul 2024 11:43:49 +0300
Message-ID: <CAPMcbCpbnRWE-49=LAAzJP6gww4wtD=wVJPcbUby743yCjnO=g@mail.gmail.com>
Subject: Re: [PATCH v2 17/22] qga: conditionalize schema for commands not
 supported on other UNIX
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000079259e061d08e194"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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

--00000000000079259e061d08e194
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Thu, Jun 13, 2024 at 6:44=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> Rather than creating stubs for every command that just return
> QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema  to
> fully exclude generation of the commands on other UNIX.
>
> The command will be rejected at QMP dispatch time instead,
> avoiding reimplementing rejection by blocking the stub commands.
> This changes the error message for affected commands from
>
>     {"class": "CommandNotFound", "desc": "Command FOO has been disabled"}
>
> to
>
>     {"class": "CommandNotFound", "desc": "The command FOO has not been
> found"}
>
> This has the additional benefit that the QGA protocol reference
> now documents what conditions enable use of the command.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  meson.build          | 1 +
>  qga/commands-posix.c | 8 --------
>  qga/qapi-schema.json | 3 ++-
>  3 files changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index d9f3349b0a..92b8c02582 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2234,6 +2234,7 @@ config_host_data.set('CONFIG_ATTR', libattr.found()=
)
>  config_host_data.set('CONFIG_BDRV_WHITELIST_TOOLS',
> get_option('block_drv_whitelist_in_tools'))
>  config_host_data.set('CONFIG_BRLAPI', brlapi.found())
>  config_host_data.set('CONFIG_BSD', host_os in bsd_oses)
> +config_host_data.set('CONFIG_FREEBSD', host_os =3D=3D 'freebsd')
>  config_host_data.set('CONFIG_CAPSTONE', capstone.found())
>  config_host_data.set('CONFIG_COCOA', cocoa.found())
>  config_host_data.set('CONFIG_DARWIN', host_os =3D=3D 'darwin')
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index a353f64ae6..f4104f2760 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -877,14 +877,6 @@ void qmp_guest_set_user_password(const char *usernam=
e,
>          return;
>      }
>  }
> -#else /* __linux__ || __FreeBSD__ */
> -void qmp_guest_set_user_password(const char *username,
> -                                 const char *password,
> -                                 bool crypted,
> -                                 Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -}
>  #endif /* __linux__ || __FreeBSD__ */
>
>  #ifdef HAVE_GETIFADDRS
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 70d4f173ad..571be3a914 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1108,7 +1108,8 @@
>  # Since: 2.3
>  ##
>  { 'command': 'guest-set-user-password',
> -  'data': { 'username': 'str', 'password': 'str', 'crypted': 'bool' } }
> +  'data': { 'username': 'str', 'password': 'str', 'crypted': 'bool' },
> +  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD'] } }
>
>  ##
>  # @GuestMemoryBlock:
> --
> 2.45.1
>
>

--00000000000079259e061d08e194
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 13, 2024 at 6:44=E2=
=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com"=
>berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">Rather than creating stubs for every command that just =
return<br>
QERR_UNSUPPORTED, use &#39;if&#39; conditions in the QAPI schema=C2=A0 to<b=
r>
fully exclude generation of the commands on other UNIX.<br>
<br>
The command will be rejected at QMP dispatch time instead,<br>
avoiding reimplementing rejection by blocking the stub commands.<br>
This changes the error message for affected commands from<br>
<br>
=C2=A0 =C2=A0 {&quot;class&quot;: &quot;CommandNotFound&quot;, &quot;desc&q=
uot;: &quot;Command FOO has been disabled&quot;}<br>
<br>
to<br>
<br>
=C2=A0 =C2=A0 {&quot;class&quot;: &quot;CommandNotFound&quot;, &quot;desc&q=
uot;: &quot;The command FOO has not been found&quot;}<br>
<br>
This has the additional benefit that the QGA protocol reference<br>
now documents what conditions enable use of the command.<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
---<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 +<br>
=C2=A0qga/commands-posix.c | 8 --------<br>
=C2=A0qga/qapi-schema.json | 3 ++-<br>
=C2=A03 files changed, 3 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/meson.build b/meson.build<br>
index d9f3349b0a..92b8c02582 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -2234,6 +2234,7 @@ config_host_data.set(&#39;CONFIG_ATTR&#39;, libattr.f=
ound())<br>
=C2=A0config_host_data.set(&#39;CONFIG_BDRV_WHITELIST_TOOLS&#39;, get_optio=
n(&#39;block_drv_whitelist_in_tools&#39;))<br>
=C2=A0config_host_data.set(&#39;CONFIG_BRLAPI&#39;, brlapi.found())<br>
=C2=A0config_host_data.set(&#39;CONFIG_BSD&#39;, host_os in bsd_oses)<br>
+config_host_data.set(&#39;CONFIG_FREEBSD&#39;, host_os =3D=3D &#39;freebsd=
&#39;)<br>
=C2=A0config_host_data.set(&#39;CONFIG_CAPSTONE&#39;, capstone.found())<br>
=C2=A0config_host_data.set(&#39;CONFIG_COCOA&#39;, cocoa.found())<br>
=C2=A0config_host_data.set(&#39;CONFIG_DARWIN&#39;, host_os =3D=3D &#39;dar=
win&#39;)<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index a353f64ae6..f4104f2760 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -877,14 +877,6 @@ void qmp_guest_set_user_password(const char *username,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
-#else /* __linux__ || __FreeBSD__ */<br>
-void qmp_guest_set_user_password(const char *username,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *password,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool crypted,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-}<br>
=C2=A0#endif /* __linux__ || __FreeBSD__ */<br>
<br>
=C2=A0#ifdef HAVE_GETIFADDRS<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index 70d4f173ad..571be3a914 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -1108,7 +1108,8 @@<br>
=C2=A0# Since: 2.3<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-set-user-password&#39;,<br>
-=C2=A0 &#39;data&#39;: { &#39;username&#39;: &#39;str&#39;, &#39;password&=
#39;: &#39;str&#39;, &#39;crypted&#39;: &#39;bool&#39; } }<br>
+=C2=A0 &#39;data&#39;: { &#39;username&#39;: &#39;str&#39;, &#39;password&=
#39;: &#39;str&#39;, &#39;crypted&#39;: &#39;bool&#39; },<br>
+=C2=A0 &#39;if&#39;: { &#39;any&#39;: [ &#39;CONFIG_WIN32&#39;, &#39;CONFI=
G_LINUX&#39;, &#39;CONFIG_FREEBSD&#39;] } }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestMemoryBlock:<br>
-- <br>
2.45.1<br>
<br>
</blockquote></div>

--00000000000079259e061d08e194--


