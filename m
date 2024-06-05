Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C05C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 13:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEr2Z-0000ol-4l; Wed, 05 Jun 2024 09:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sEr2X-0000nT-V9
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 09:50:58 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sEr2U-0006zS-UM
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 09:50:57 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4402066471cso7936761cf.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 06:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717595453; x=1718200253; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZdVHvRs9o4/Aet/GFGJ1aFRizh/u0cmXBzkisDX4onc=;
 b=OxcYH4PEW2cKcLb2nvt4RSdM3C6qq1+2sLHCmvGyzMr3HML2mllOnMt/O6jzxnC4jl
 meAXkGRdbtxDOwfAqCYFQSvbQJGocpz/nfMRcTYsagsbDjrsDHd0Cw+yv4XyT8jIn9Wd
 7epI6utKd9SMtmCngg6MGLoldpBKRJmSlUS7DpNcbEWYfxNyktUUqs+TpFDau8wHlFUw
 QhepGd6rtlQ7xo2K8DL539e6CgvsMraGZa8KNFf8JPdmPOnKAGfyQWvqiaRVdvNfkra/
 YE9unzLrQa8ueeKh9DYWJaqalI5pQWduB6BOsj7uh4jwNmYQFKY6l1bZQhuJ4ET026Hg
 2/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717595453; x=1718200253;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZdVHvRs9o4/Aet/GFGJ1aFRizh/u0cmXBzkisDX4onc=;
 b=bROgYm2DtEHGS01i3IbsUMnZmkJ5RJAap6xXtTojEd72C/R0PLiN9oR38dA5OolJJZ
 k601f2RnXU6XKizQIvbTKjPhYdCA/+om4JvQ76injxHyLdIXYYimTYMQqUTOquSV+lOf
 WGkQw72GyBxxBKwyp0FkdpbHc3BNFf3H9t7He/ytXX10JKFs9B9ZFnEtH+uQRhSbBXtJ
 bmJOhL+u53kBrCtFHaq0TCSa32FlcBuk6+RdYwUy6gv+AyGb44yMls7eXkkaiHq3agk+
 Z+oWvdEfgOwyI6tNzxOlflqoXTx1t6BZKA0O8eXHGsnKCipNTkkjKKtD8X8B4ceEyEZ+
 WoAw==
X-Gm-Message-State: AOJu0YwVwYzuwMV/ypyAsLOhI6Gb51ubrOSooz4MS8bpQYgiRZiCgyNY
 PgsW535yF3NCqC0qFwhImKSxgMwUuyE1SddH2FezmZTI1OC8nLMLxp8JENOGRFbbJtOrDKbkxwd
 K9BGZMn0e0EyJCkiqow1kug3sYqo=
X-Google-Smtp-Source: AGHT+IGykfpm1KV8Hd4eoZjNqfOfJTxjj7DqRLUGC6FAGQ9lpCojNc1vbq93nk+4W2R+kJ3l8VLkE4hnmVRlaPCcQHs=
X-Received: by 2002:ac8:7c50:0:b0:440:1a67:481e with SMTP id
 d75a77b69052e-44029e9f826mr50918211cf.20.1717595453235; Wed, 05 Jun 2024
 06:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240605133527.529950-1-alex.bennee@linaro.org>
In-Reply-To: <20240605133527.529950-1-alex.bennee@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 5 Jun 2024 17:50:41 +0400
Message-ID: <CAJ+F1CKdme8dKCO3iMEZLU-uWLfk-PPCfMNwh6-vCbCLyJvYiw@mail.gmail.com>
Subject: Re: [RFC PATCH] subprojects: add a wrapper for libvirglrenderer
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000dbaef3061a24da0c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x831.google.com
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

--000000000000dbaef3061a24da0c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jun 5, 2024 at 5:35=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:

> As the latest features for virtio-gpu need a pretty recent version of
> libvirglrenderer. When it is not available on the system we can use a
> meson wrapper and provide it when --download is specified in
> configure.
>
> We have to take some additional care as currently QEMU will hang
> libvirglrenderer fails to exec the render server. As the error isn't
> back propagated we make sure we at least test we have a path to an
> executable before tweaking the environment.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  meson.build                    |  7 ++++++-
>  hw/display/virtio-gpu-virgl.c  | 24 ++++++++++++++++++++++++
>  subprojects/virglrenderer.wrap |  6 ++++++
>  3 files changed, 36 insertions(+), 1 deletion(-)
>  create mode 100644 subprojects/virglrenderer.wrap
>
> diff --git a/meson.build b/meson.build
> index 1d7346b703..e4e270df78 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1203,7 +1203,8 @@ have_vhost_user_gpu =3D have_tools and host_os =3D=
=3D
> 'linux' and pixman.found()
>  if not get_option('virglrenderer').auto() or have_system or
> have_vhost_user_gpu
>    virgl =3D dependency('virglrenderer',
>                       method: 'pkg-config',
> -                     required: get_option('virglrenderer'))
> +                     required: get_option('virglrenderer'),
> +                     default_options: ['default_library=3Dstatic',
> 'render-server=3Dtrue', 'venus=3Dtrue'])
>

So the subproject won't be used unless virgl-devel is missing on the
system. Is it really so useful? maybe, I am just used to installing my
bleeding edge libraries with stow..

>

>  endif
>  rutabaga =3D not_found
>  if not get_option('rutabaga_gfx').auto() or have_system or
> have_vhost_user_gpu
> @@ -2314,6 +2315,10 @@ if virgl.version().version_compare('>=3D1.0.0')
>    config_host_data.set('HAVE_VIRGL_RESOURCE_BLOB', 1)
>    config_host_data.set('HAVE_VIRGL_VENUS', 1)
>  endif
> +if virgl.type_name().contains('internal')
> +  config_host_data.set('HAVE_BUNDLED_VIRGL_SERVER', 1)
> +endif
> +
>  config_host_data.set('CONFIG_VIRTFS', have_virtfs)
>  config_host_data.set('CONFIG_VTE', vte.found())
>  config_host_data.set('CONFIG_XKBCOMMON', xkbcommon.found())
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.=
c
> index c9d20a8a60..53d6742e79 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -14,6 +14,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
>  #include "qemu/iov.h"
> +#include "qemu/cutils.h"
>  #include "trace.h"
>  #include "hw/virtio/virtio.h"
>  #include "hw/virtio/virtio-gpu.h"
> @@ -1122,6 +1123,26 @@ void virtio_gpu_virgl_reset(VirtIOGPU *g)
>      virgl_renderer_reset();
>  }
>
> +/*
> + * If we fail to spawn the render server things tend to hang so it is
> + * important to do our due diligence before then. If QEMU has bundled
> + * the virgl server we want to ensure we can run it from the build
> + * directory and if installed.
> + *
> + * The principle way we can override the libvirglrenders behaviour is
> + * by setting environment variables.
> + */
> +static void virgl_set_render_env(void)
> +{
> +#ifdef HAVE_BUNDLED_VIRGL_SERVER
> +    g_autofree char *file =3D get_relocated_path(CONFIG_QEMU_HELPERDIR
> "/virgl_render_server");
> +    if (g_file_test(file, G_FILE_TEST_EXISTS |
> G_FILE_TEST_IS_EXECUTABLE)) {
> +        g_setenv("RENDER_SERVER_EXEC_PATH", file, false);
> +    }
> +#endif
> +}
> +
> +
>  int virtio_gpu_virgl_init(VirtIOGPU *g)
>  {
>      int ret;
> @@ -1145,6 +1166,9 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>      }
>  #endif
>
> +    /* Ensure we can find the render server */
> +    virgl_set_render_env();
> +
>      ret =3D virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
>      if (ret !=3D 0) {
>          error_report("virgl could not be initialized: %d", ret);
> diff --git a/subprojects/virglrenderer.wrap
> b/subprojects/virglrenderer.wrap
> new file mode 100644
> index 0000000000..3656a478c4
> --- /dev/null
> +++ b/subprojects/virglrenderer.wrap
> @@ -0,0 +1,6 @@
> +[wrap-git]
> +url =3D https://gitlab.freedesktop.org/virgl/virglrenderer.git
> +revision =3D virglrenderer-1.0.1
> +
> +[provide]
> +virglrenderer =3D libvirglrenderer_dep
> --
> 2.39.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000dbaef3061a24da0c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 5, 2024 at 5:35=E2=80=
=AFPM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.b=
ennee@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">As the latest features for virtio-gpu need a pretty recent =
version of<br>
libvirglrenderer. When it is not available on the system we can use a<br>
meson wrapper and provide it when --download is specified in<br>
configure.<br>
<br>
We have to take some additional care as currently QEMU will hang<br>
libvirglrenderer fails to exec the render server. As the error isn&#39;t<br=
>
back propagated we make sure we at least test we have a path to an<br>
executable before tweaking the environment.<br>
<br>
Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.or=
g" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
Cc: Manos Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidianakis@linaro.or=
g" target=3D"_blank">manos.pitsidianakis@linaro.org</a>&gt;<br>
Cc: Dmitry Osipenko &lt;<a href=3D"mailto:dmitry.osipenko@collabora.com" ta=
rget=3D"_blank">dmitry.osipenko@collabora.com</a>&gt;<br>
Cc: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D=
"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
---<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 7 ++++++-<br>
=C2=A0hw/display/virtio-gpu-virgl.c=C2=A0 | 24 ++++++++++++++++++++++++<br>
=C2=A0subprojects/virglrenderer.wrap |=C2=A0 6 ++++++<br>
=C2=A03 files changed, 36 insertions(+), 1 deletion(-)<br>
=C2=A0create mode 100644 subprojects/virglrenderer.wrap<br>
<br>
diff --git a/meson.build b/meson.build<br>
index 1d7346b703..e4e270df78 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -1203,7 +1203,8 @@ have_vhost_user_gpu =3D have_tools and host_os =3D=3D=
 &#39;linux&#39; and pixman.found()<br>
=C2=A0if not get_option(&#39;virglrenderer&#39;).auto() or have_system or h=
ave_vhost_user_gpu<br>
=C2=A0 =C2=A0virgl =3D dependency(&#39;virglrenderer&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 method: &#39;pkg-config&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0required: get_option(&#39;virglrenderer&#39;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0required: get_option(&#39;virglrenderer&#39;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0default_options: [&#39;default_library=3Dstatic&#39;, &#39;render-server=
=3Dtrue&#39;, &#39;venus=3Dtrue&#39;])<br></blockquote><div><br></div><div>=
<div class=3D"gmail_quote">So the subproject won&#39;t be used unless virgl=
-devel is missing on the system. Is it really so useful? maybe, I am just u=
sed to installing my bleeding edge libraries with stow..<br></div><div clas=
s=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
</blockquote></div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
=C2=A0endif<br>
=C2=A0rutabaga =3D not_found<br>
=C2=A0if not get_option(&#39;rutabaga_gfx&#39;).auto() or have_system or ha=
ve_vhost_user_gpu<br>
@@ -2314,6 +2315,10 @@ if virgl.version().version_compare(&#39;&gt;=3D1.0.0=
&#39;)<br>
=C2=A0 =C2=A0config_host_data.set(&#39;HAVE_VIRGL_RESOURCE_BLOB&#39;, 1)<br=
>
=C2=A0 =C2=A0config_host_data.set(&#39;HAVE_VIRGL_VENUS&#39;, 1)<br>
=C2=A0endif<br>
+if virgl.type_name().contains(&#39;internal&#39;)<br>
+=C2=A0 config_host_data.set(&#39;HAVE_BUNDLED_VIRGL_SERVER&#39;, 1)<br>
+endif<br>
+<br>
=C2=A0config_host_data.set(&#39;CONFIG_VIRTFS&#39;, have_virtfs)<br>
=C2=A0config_host_data.set(&#39;CONFIG_VTE&#39;, vte.found())<br>
=C2=A0config_host_data.set(&#39;CONFIG_XKBCOMMON&#39;, xkbcommon.found())<b=
r>
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c<=
br>
index c9d20a8a60..53d6742e79 100644<br>
--- a/hw/display/virtio-gpu-virgl.c<br>
+++ b/hw/display/virtio-gpu-virgl.c<br>
@@ -14,6 +14,7 @@<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
=C2=A0#include &quot;qemu/iov.h&quot;<br>
+#include &quot;qemu/cutils.h&quot;<br>
=C2=A0#include &quot;trace.h&quot;<br>
=C2=A0#include &quot;hw/virtio/virtio.h&quot;<br>
=C2=A0#include &quot;hw/virtio/virtio-gpu.h&quot;<br>
@@ -1122,6 +1123,26 @@ void virtio_gpu_virgl_reset(VirtIOGPU *g)<br>
=C2=A0 =C2=A0 =C2=A0virgl_renderer_reset();<br>
=C2=A0}<br>
<br>
+/*<br>
+ * If we fail to spawn the render server things tend to hang so it is<br>
+ * important to do our due diligence before then. If QEMU has bundled<br>
+ * the virgl server we want to ensure we can run it from the build<br>
+ * directory and if installed.<br>
+ *<br>
+ * The principle way we can override the libvirglrenders behaviour is<br>
+ * by setting environment variables.<br>
+ */<br>
+static void virgl_set_render_env(void)<br>
+{<br>
+#ifdef HAVE_BUNDLED_VIRGL_SERVER<br>
+=C2=A0 =C2=A0 g_autofree char *file =3D get_relocated_path(CONFIG_QEMU_HEL=
PERDIR &quot;/virgl_render_server&quot;);<br>
+=C2=A0 =C2=A0 if (g_file_test(file, G_FILE_TEST_EXISTS | G_FILE_TEST_IS_EX=
ECUTABLE)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_setenv(&quot;RENDER_SERVER_EXEC_PATH&quot;, =
file, false);<br>
+=C2=A0 =C2=A0 }<br>
+#endif<br>
+}<br>
+<br>
+<br>
=C2=A0int virtio_gpu_virgl_init(VirtIOGPU *g)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
@@ -1145,6 +1166,9 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#endif<br>
<br>
+=C2=A0 =C2=A0 /* Ensure we can find the render server */<br>
+=C2=A0 =C2=A0 virgl_set_render_env();<br>
+<br>
=C2=A0 =C2=A0 =C2=A0ret =3D virgl_renderer_init(g, flags, &amp;virtio_gpu_3=
d_cbs);<br>
=C2=A0 =C2=A0 =C2=A0if (ret !=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;virgl could not be ini=
tialized: %d&quot;, ret);<br>
diff --git a/subprojects/virglrenderer.wrap b/subprojects/virglrenderer.wra=
p<br>
new file mode 100644<br>
index 0000000000..3656a478c4<br>
--- /dev/null<br>
+++ b/subprojects/virglrenderer.wrap<br>
@@ -0,0 +1,6 @@<br>
+[wrap-git]<br>
+url =3D <a href=3D"https://gitlab.freedesktop.org/virgl/virglrenderer.git"=
 rel=3D"noreferrer" target=3D"_blank">https://gitlab.freedesktop.org/virgl/=
virglrenderer.git</a><br>
+revision =3D virglrenderer-1.0.1<br>
+<br>
+[provide]<br>
+virglrenderer =3D libvirglrenderer_dep<br>
-- <br>
2.39.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000dbaef3061a24da0c--

