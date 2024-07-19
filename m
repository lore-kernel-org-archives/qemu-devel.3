Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86686C3DA6F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 07:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUi8q-0007Q1-Ph; Fri, 19 Jul 2024 03:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sUi8o-0007Oz-MI
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 03:34:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sUi8l-0006yG-7j
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 03:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721374492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GsZ587Ag5z6OtoNVtqQDp6PifStIaze7A9UvVYEbApY=;
 b=NqucEn0LYj0YTvCIr+YGKXVZWhWjlZAX/dsDuwfXxp1X5gjMq2I1E76yQVqhWR9IHoKmGW
 KxbDqgsmHTmDEvhT6ev2avXSFS4u92PNHCEdJ5/YfIZe3Ebtf1Q9W5xMXGUZwFr/kN3qlL
 isXqe7e76LOr2HFY95M0/1HiBDZRAZ8=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-vFNjtss0Mz2mBvnHjOZg5Q-1; Fri, 19 Jul 2024 03:34:47 -0400
X-MC-Unique: vFNjtss0Mz2mBvnHjOZg5Q-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-e036150efc6so3723673276.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 00:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721374487; x=1721979287;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GsZ587Ag5z6OtoNVtqQDp6PifStIaze7A9UvVYEbApY=;
 b=BLZBMwrBSgMHgSzaBEzq0w4Vx8Ux+m+GG9iQ18Bu9lAw2064kXb0MXM7B7AYt5rMir
 8LOVD+XGuJsWLmTh7dGnl6Tp/+CyY3INqglESkmVqxrruF2v9wMd4GPzUpaKQMrlWdgo
 JJYZpdFLqpzsIFQgfCaqoQAlAsMp/9pAmDKVVvYUkm9W5+bDoZmCI8AvRCvQ9nDLH/uj
 Ms5AXp/z80jwkwGvCgu6nRPD9BqK9ZDt64wnRsJS5KtrKpdxEjX9WMMCKFx6mODzuIIv
 /EqzMdJN69MsXYXRjXrSiPB9l7n66H+zurQkZ8LGHXm20vaSa2uPRPTlgUjROhbvGR6g
 N3gw==
X-Gm-Message-State: AOJu0YwyLD8TxypCaOu6Pe7NQ82F1IZyKAPjHbefIRvnsD5B2dH4Ejgi
 kWYRlMEkhZGrX7DGFOrsYQg8SHE6Ic3GelCjK637p4JVxhbzlx97xeqXAcDKaG5GVo+l4xMsoPX
 eCgx50y8t4Jm/9/597vO4XQ4CI6KZTnYpOpglEQ4rj2lwL4T1tF0WJ36ZA9asll5p9Rn/E20iR8
 gcRKGOTk8npNlyNqPUXPXOo6LHo9E=
X-Received: by 2002:a05:6902:10c2:b0:e08:6373:dfb3 with SMTP id
 3f1490d57ef6-e086373e2d2mr950895276.1.1721374486916; 
 Fri, 19 Jul 2024 00:34:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbdL6p6SMlq2IqC3Ob+Ewqsa4nG70c8CC7S5SOyJaIZBY1aSMNMqwIjTqxpwyRSnoKhBoGuVnmlD1sfItT5Zc=
X-Received: by 2002:a05:6902:10c2:b0:e08:6373:dfb3 with SMTP id
 3f1490d57ef6-e086373e2d2mr950879276.1.1721374486654; Fri, 19 Jul 2024
 00:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240712132459.3974109-1-berrange@redhat.com>
 <20240712132459.3974109-8-berrange@redhat.com>
In-Reply-To: <20240712132459.3974109-8-berrange@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 19 Jul 2024 10:34:35 +0300
Message-ID: <CAPMcbCrzmbCQ5qgXMp1bECnS-h5Q-w54-0VmkaJZx5oTR3tA6g@mail.gmail.com>
Subject: Re: [PATCH v3 07/22] qga: move CONFIG_FSFREEZE/TRIM to be meson
 defined options
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000cd8338061d94baaf"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--000000000000cd8338061d94baaf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Fri, Jul 12, 2024 at 4:25=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> Defining these at the meson level allows them to be used a conditional
> tests in the QAPI schemas.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  meson.build           | 15 +++++++++++++++
>  qga/commands-common.h |  9 ---------
>  2 files changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 6a93da48e1..3f125d1b02 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2186,6 +2186,19 @@ have_virtfs_proxy_helper =3D
> get_option('virtfs_proxy_helper') \
>      .require(libcap_ng.found(), error_message: 'the virtfs proxy helper
> requires libcap-ng') \
>      .allowed()
>
> +qga_fsfreeze =3D false
> +qga_fstrim =3D false
> +if host_os =3D=3D 'linux'
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
> @@ -2422,6 +2435,8 @@ config_host_data.set('CONFIG_DEBUG_TCG',
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

--000000000000cd8338061d94baaf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 12, 2024 at 4:25=E2=
=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com"=
>berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">Defining these at the meson level allows them to be use=
d a conditional<br>
tests in the QAPI schemas.<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
---<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 15 ++++++++++++=
+++<br>
=C2=A0qga/commands-common.h |=C2=A0 9 ---------<br>
=C2=A02 files changed, 15 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/meson.build b/meson.build<br>
index 6a93da48e1..3f125d1b02 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -2186,6 +2186,19 @@ have_virtfs_proxy_helper =3D get_option(&#39;virtfs_=
proxy_helper&#39;) \<br>
=C2=A0 =C2=A0 =C2=A0.require(libcap_ng.found(), error_message: &#39;the vir=
tfs proxy helper requires libcap-ng&#39;) \<br>
=C2=A0 =C2=A0 =C2=A0.allowed()<br>
<br>
+qga_fsfreeze =3D false<br>
+qga_fstrim =3D false<br>
+if host_os =3D=3D &#39;linux&#39;<br>
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
@@ -2422,6 +2435,8 @@ config_host_data.set(&#39;CONFIG_DEBUG_TCG&#39;, get_=
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
</blockquote></div>

--000000000000cd8338061d94baaf--


