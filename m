Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED6AC27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 08:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEmJI-0005uo-Qm; Wed, 05 Jun 2024 04:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sEmJH-0005uV-B2
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:47:55 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sEmJF-0001cP-C5
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:47:55 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-627e3368394so56173407b3.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 01:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717577272; x=1718182072; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rxc3CMML855BVv+uxpgbhTs+5rL63qfFjl3yEpBtKJU=;
 b=ftm7d4rUYNjeolSOZ8SNr716okR5k9e+yAbQQ7HYfXRqSkhZjub8yjm+tMeA8dX2ya
 cXFPbLNCTrbG0nJm0nUn1MbjMU7rEMPCc8hhE8ksPip3fv+J6rll0Vrj1s1wPAHATXum
 bm2oCDtfLMajA8BHlclCkfxrl/kMF6Yho3oHIVT5rLmFvaJfm8nIoMoIMX5qqZyhKWzh
 qdHNBaldNz+VnoS2BGxBanLSufjWnC5iBoohH7TfXX1dIBs5/h2nGEDr7d3om9G6nQKF
 sKZbAPZXegx4BJBVIomtDenPwNyxwfKQq73fSiXk2xLRt7g9337FdAA3mk4uv19NFumR
 ANtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717577272; x=1718182072;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rxc3CMML855BVv+uxpgbhTs+5rL63qfFjl3yEpBtKJU=;
 b=lzaCFfpXdOzB2nlnjUD+1yDhHMCYCRFeEwHhvV6P7IIyL/uiqNUwvsHpfMxJw6S8QX
 xk+SmHXcrHvG1KGN8h05y7tJy5mA2FJ57cWM3029ykqw31WdJaIrVtXjQvAOoOVR+oQB
 TasSGA8ghqzVdMd8C56PEK9e4mQ1orwZ1khdrKBDq0HFCzP9IC8vNFciUGBPHyO0KPo+
 6ppi9OKRxF1fJBo+pJzHMFu/O4oR/LUjl+Jk/Bex7rrtBstzjiS5jBXek4df3stRL0W3
 66CF1PuQcUHag5l/+zshveLipJa9gea/gUvUgniwzkn0WCWbhQtlXCCe+ip8Mo9t+doD
 KCxA==
X-Gm-Message-State: AOJu0YxTbtHKW1PoI2O29GJPb+35WPrui65SPi99uP+oyogUcVB/EMYL
 UTTw/VzzVYVzGd4GL6WTv1A35ISnZnh3feirxeMN4EMDM9iBKXb2D7Pk4AlYKK9i4g0jqz5QiME
 Ipdhfm8gIWEvnU9REjhalOHfC38U=
X-Google-Smtp-Source: AGHT+IFya1Y5u/CX8Kl/oJKoq3ONPpeKV/NrHUO9g9BJJ7RFIq+8DMmyUEHKK0zrHFXzT/WlCV2rYqnV87tVenbjWD8=
X-Received: by 2002:a81:c20a:0:b0:61b:df5:7871 with SMTP id
 00721157ae682-62cbb4d9151mr17035457b3.16.1717577272033; Wed, 05 Jun 2024
 01:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240604134933.220112-1-berrange@redhat.com>
 <20240604134933.220112-8-berrange@redhat.com>
In-Reply-To: <20240604134933.220112-8-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 5 Jun 2024 12:47:39 +0400
Message-ID: <CAJ+F1CLhfHTnivCcCfOSEYw2nNsTrcgqx+iALRsWf9DbKjhmEg@mail.gmail.com>
Subject: Re: [PATCH 07/20] qga: move CONFIG_FSFREEZE/TRIM to be meson defined
 options
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002c89cb061a209f6b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000002c89cb061a209f6b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Jun 4, 2024 at 5:50=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com>
wrote:

> Defining these at the meson level allows them to be used a conditional
> tests in the QAPI schemas.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  meson.build           | 18 ++++++++++++++++++
>  qga/commands-common.h |  9 ---------
>  2 files changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 6386607144..356b2a4817 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2141,6 +2141,22 @@ have_virtfs_proxy_helper =3D
> get_option('virtfs_proxy_helper') \
>      .require(libcap_ng.found(), error_message: 'the virtfs proxy helper
> requires libcap-ng') \
>      .allowed()
>
> +qga_fsfreeze =3D false
> +qga_fstrim =3D false
> +if host_os =3D=3D 'windows'
> +    qga_fsfreeze =3D true
> +    qga_fstrim =3D true
>

The hook code in qga/main.c compiles for win32, but it is not used. Did you
intentionally enabled that?

+elif host_os =3D=3D 'linux'
> +    if cc.has_header_symbol('linux/fs.h', 'FIFREEZE')
> +        qga_fsfreeze =3D true
> +    endif
> +    if cc.has_header_symbol('linux/fs.h', 'FITRIM')
> +        qga_fstrim =3D true
> +    endif
> +elif host_os =3D=3D 'freebsd' and cc.has_header_symbol('ufs/ffs/fs.h',
> 'UFSSUSPEND')
> +    qga_fsfreeze =3D true
> +endif
> +
>  if get_option('block_drv_ro_whitelist') =3D=3D ''
>    config_host_data.set('CONFIG_BDRV_RO_WHITELIST', '')
>  else
> @@ -2375,6 +2391,8 @@ config_host_data.set('CONFIG_DEBUG_TCG',
> get_option('debug_tcg'))
>  config_host_data.set('CONFIG_DEBUG_REMAP', get_option('debug_remap'))
>  config_host_data.set('CONFIG_QOM_CAST_DEBUG',
> get_option('qom_cast_debug'))
>  config_host_data.set('CONFIG_REPLICATION',
> get_option('replication').allowed())
> +config_host_data.set('CONFIG_FSFREEZE', qga_fsfreeze)
> +config_host_data.set('CONFIG_FSTRIM', qga_fstrim)
>
>  # has_header
>  config_host_data.set('CONFIG_EPOLL', cc.has_header('sys/epoll.h'))
> diff --git a/qga/commands-common.h b/qga/commands-common.h
> index 8c1c56aac9..263e7c0525 100644
> --- a/qga/commands-common.h
> +++ b/qga/commands-common.h
> @@ -15,19 +15,10 @@
>
>  #if defined(__linux__)
>  #include <linux/fs.h>
> -#ifdef FIFREEZE
> -#define CONFIG_FSFREEZE
> -#endif
> -#ifdef FITRIM
> -#define CONFIG_FSTRIM
> -#endif
>  #endif /* __linux__ */
>
>  #ifdef __FreeBSD__
>  #include <ufs/ffs/fs.h>
> -#ifdef UFSSUSPEND
> -#define CONFIG_FSFREEZE
> -#endif
>  #endif /* __FreeBSD__ */
>
>  #if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM)
> --
> 2.45.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000002c89cb061a209f6b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 4, 2024 at 5:50=E2=80=
=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">be=
rrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Defining these at the meson level allows them to be used a=
 conditional<br>
tests in the QAPI schemas.<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
---<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 18 ++++++++++++=
++++++<br>
=C2=A0qga/commands-common.h |=C2=A0 9 ---------<br>
=C2=A02 files changed, 18 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/meson.build b/meson.build<br>
index 6386607144..356b2a4817 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -2141,6 +2141,22 @@ have_virtfs_proxy_helper =3D get_option(&#39;virtfs_=
proxy_helper&#39;) \<br>
=C2=A0 =C2=A0 =C2=A0.require(libcap_ng.found(), error_message: &#39;the vir=
tfs proxy helper requires libcap-ng&#39;) \<br>
=C2=A0 =C2=A0 =C2=A0.allowed()<br>
<br>
+qga_fsfreeze =3D false<br>
+qga_fstrim =3D false<br>
+if host_os =3D=3D &#39;windows&#39;<br>
+=C2=A0 =C2=A0 qga_fsfreeze =3D true<br>
+=C2=A0 =C2=A0 qga_fstrim =3D true<br></blockquote><div><br></div><div>The =
hook code in qga/main.c compiles for win32, but it is not used. Did you int=
entionally enabled that?<br></div><div><br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
+elif host_os =3D=3D &#39;linux&#39;<br>
+=C2=A0 =C2=A0 if cc.has_header_symbol(&#39;linux/fs.h&#39;, &#39;FIFREEZE&=
#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qga_fsfreeze =3D true<br>
+=C2=A0 =C2=A0 endif<br>
+=C2=A0 =C2=A0 if cc.has_header_symbol(&#39;linux/fs.h&#39;, &#39;FITRIM&#3=
9;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qga_fstrim =3D true<br>
+=C2=A0 =C2=A0 endif<br>
+elif host_os =3D=3D &#39;freebsd&#39; and cc.has_header_symbol(&#39;ufs/ff=
s/fs.h&#39;, &#39;UFSSUSPEND&#39;)<br>
+=C2=A0 =C2=A0 qga_fsfreeze =3D true<br>
+endif<br>
+<br>
=C2=A0if get_option(&#39;block_drv_ro_whitelist&#39;) =3D=3D &#39;&#39;<br>
=C2=A0 =C2=A0config_host_data.set(&#39;CONFIG_BDRV_RO_WHITELIST&#39;, &#39;=
&#39;)<br>
=C2=A0else<br>
@@ -2375,6 +2391,8 @@ config_host_data.set(&#39;CONFIG_DEBUG_TCG&#39;, get_=
option(&#39;debug_tcg&#39;))<br>
=C2=A0config_host_data.set(&#39;CONFIG_DEBUG_REMAP&#39;, get_option(&#39;de=
bug_remap&#39;))<br>
=C2=A0config_host_data.set(&#39;CONFIG_QOM_CAST_DEBUG&#39;, get_option(&#39=
;qom_cast_debug&#39;))<br>
=C2=A0config_host_data.set(&#39;CONFIG_REPLICATION&#39;, get_option(&#39;re=
plication&#39;).allowed())<br>
+config_host_data.set(&#39;CONFIG_FSFREEZE&#39;, qga_fsfreeze)<br>
+config_host_data.set(&#39;CONFIG_FSTRIM&#39;, qga_fstrim)<br>
<br>
=C2=A0# has_header<br>
=C2=A0config_host_data.set(&#39;CONFIG_EPOLL&#39;, cc.has_header(&#39;sys/e=
poll.h&#39;))<br>
diff --git a/qga/commands-common.h b/qga/commands-common.h<br>
index 8c1c56aac9..263e7c0525 100644<br>
--- a/qga/commands-common.h<br>
+++ b/qga/commands-common.h<br>
@@ -15,19 +15,10 @@<br>
<br>
=C2=A0#if defined(__linux__)<br>
=C2=A0#include &lt;linux/fs.h&gt;<br>
-#ifdef FIFREEZE<br>
-#define CONFIG_FSFREEZE<br>
-#endif<br>
-#ifdef FITRIM<br>
-#define CONFIG_FSTRIM<br>
-#endif<br>
=C2=A0#endif /* __linux__ */<br>
<br>
=C2=A0#ifdef __FreeBSD__<br>
=C2=A0#include &lt;ufs/ffs/fs.h&gt;<br>
-#ifdef UFSSUSPEND<br>
-#define CONFIG_FSFREEZE<br>
-#endif<br>
=C2=A0#endif /* __FreeBSD__ */<br>
<br>
=C2=A0#if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM)<br>
-- <br>
2.45.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--0000000000002c89cb061a209f6b--

