Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8001C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEV4U-000363-DO; Tue, 04 Jun 2024 10:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sEV4T-00035q-Ks
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:23:29 -0400
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sEV4R-0008DO-Gk
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:23:29 -0400
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6af4fcb45ccso22583236d6.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 07:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717511005; x=1718115805; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oFSqNccqFycVrfo3QkFWzu3TMcH4lBSVziX1WBJjq8g=;
 b=OgGBFVqEkqxwtndzUCnt2Iwxu2nRhP8Z2hNmHFJ41ISJKF7YlTTOdWpHe/c/OO0VcF
 okDLInXiigcgFD0zUTpRlCZCp2Rt/fPyZ0L6lOj+j9hw5oKjkcAO9Y/Z8ofW3KYtxvsb
 K2PoGpCC/MdOhLLmOms1mAXBWqxSuQ74RwPrk2bfywZcZYkaeM6PByroAunNHlFFMXVr
 nKVzY3T9KwN/cDfO1MLsSm2uF2S4hk/tBTmmOAX6TT0j2bWZmXy3YmBEw2G4dzMl7He8
 VRb7hkJTd0LsMcEDS1ntal59vdoir52GXv6kKtkudqrUBfbdwP+4vgD5y5/5nFHd6T5Q
 FJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717511005; x=1718115805;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oFSqNccqFycVrfo3QkFWzu3TMcH4lBSVziX1WBJjq8g=;
 b=wmB4i3F5oDr73ymNsMB9OefSu4V30wVoYGT7kFg3tin7jFnKcocBOC0u55m5MTYk7r
 gCVWeGU4uFsiGbNxaZdQtfCdTK/OaknEln04W6P/fFjEl4HUDp09m8waCuh+hZ7yoAo0
 6FLiGTqJPZ3/pIKKs5/KGgzbD+aYHPOAYPvSqzma4EPYhbsX4KXzDeeh2MXBP/qsQzAo
 wAQYNUGcbTedmu0H1iLjxVCtN26HwtukLOIWyO4vWdstYNeHINSms7DrGQoiecmpEZi2
 x/eOoJCzEp54HiJcRYAuQ+Jdct3uIxeM9Jq+0RT8+Bvnk/VDjgbQRxnDwHbwwZAPMfum
 wQcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1blrvCUwWmeiGeHKt6Hf01bMSb/u5A7DcYLvH1qdBN1d0eNnpwoA9TZWVicSsaTJLNdpD/CqWwben01H051K4n4uz1Qk=
X-Gm-Message-State: AOJu0YzcvR0duw0S3LvYGHIO+OckM+pLRkg/vaWXFHxabgwB+MylwMFi
 JnulWMBDEuWOL2De5JN3r+iGCroI6q9+aUkhzT53UGb+bvEh1KHIXA65J0bIfWs6/fPCgbdOBFH
 emA5pxwYfrJ2UozJpdLpaDID8PUs=
X-Google-Smtp-Source: AGHT+IE7AwePRa+1aQMEM2cBsKOyG3KzuDNtxzjxCgyjw4ieAWVyAPtDTtoNJW7aR95Ui3+gFXOl8lXD7L5cKW19Wq8=
X-Received: by 2002:a05:6214:45a1:b0:6ae:d3f9:d71f with SMTP id
 6a1803df08f44-6aff7239820mr52576766d6.5.1717511005479; Tue, 04 Jun 2024
 07:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240527030233.3775514-1-dmitry.osipenko@collabora.com>
 <20240527030233.3775514-5-dmitry.osipenko@collabora.com>
In-Reply-To: <20240527030233.3775514-5-dmitry.osipenko@collabora.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 4 Jun 2024 18:23:14 +0400
Message-ID: <CAJ+F1CKRBcPif9QyNOP7jK22PRUALrVY8pSvXhR4zEPaCMmbPw@mail.gmail.com>
Subject: Re: [PATCH v13 04/13] virtio-gpu: Unrealize GL device
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>, 
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>, 
 Gert Wollny <gert.wollny@collabora.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, 
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>, 
 Yiwei Zhang <zzyiwei@chromium.org>
Content-Type: multipart/alternative; boundary="000000000000612acd061a11319c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qv1-xf32.google.com
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

--000000000000612acd061a11319c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, May 27, 2024 at 7:03=E2=80=AFAM Dmitry Osipenko <
dmitry.osipenko@collabora.com> wrote:

> Even though GL GPU doesn't support hotplugging today, free virgl
> resources when GL device is unrealized. For consistency.
>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  hw/display/virtio-gpu-gl.c     | 13 +++++++++++++
>  hw/display/virtio-gpu-virgl.c  | 11 +++++++++++
>  include/hw/virtio/virtio-gpu.h |  1 +
>  3 files changed, 25 insertions(+)
>
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index 38a2b1bd3916..7978b2985e17 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -149,6 +149,18 @@ static Property virtio_gpu_gl_properties[] =3D {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> +static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
> +{
> +    VirtIOGPU *g =3D VIRTIO_GPU(qdev);
> +    VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(qdev);
> +
> +    if (gl->renderer_state >=3D RS_INITED) {
> +        virtio_gpu_virgl_deinit(g);
>

The extra function seems unnecessary.


> +    }
> +
> +    gl->renderer_state =3D RS_START;
> +}
> +
>  static void virtio_gpu_gl_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -162,6 +174,7 @@ static void virtio_gpu_gl_class_init(ObjectClass
> *klass, void *data)
>      vgc->update_cursor_data =3D virtio_gpu_gl_update_cursor_data;
>
>      vdc->realize =3D virtio_gpu_gl_device_realize;
> +    vdc->unrealize =3D virtio_gpu_gl_device_unrealize;
>      vdc->reset =3D virtio_gpu_gl_reset;
>      device_class_set_props(dc, virtio_gpu_gl_properties);
>  }
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.=
c
> index fa0da8f5c7f1..66c4aab9b283 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -669,3 +669,14 @@ int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
>
>      return capset2_max_ver ? 2 : 1;
>  }
> +
> +void virtio_gpu_virgl_deinit(VirtIOGPU *g)
> +{
> +    VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(g);
> +
> +    if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
> +        timer_free(gl->print_stats);
> +    }
> +    timer_free(gl->fence_poll);
> +    virgl_renderer_cleanup(NULL);
> +}
> diff --git a/include/hw/virtio/virtio-gpu.h
> b/include/hw/virtio/virtio-gpu.h
> index 6e71d799e5da..2faeda6f6abe 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -345,6 +345,7 @@ void virtio_gpu_virgl_fence_poll(VirtIOGPU *g);
>  void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g);
>  void virtio_gpu_virgl_reset(VirtIOGPU *g);
>  int virtio_gpu_virgl_init(VirtIOGPU *g);
> +void virtio_gpu_virgl_deinit(VirtIOGPU *g);
>  int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g);
>
>  #endif
> --
> 2.44.0
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000612acd061a11319c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 27, 2024 at 7:03=E2=80=
=AFAM Dmitry Osipenko &lt;<a href=3D"mailto:dmitry.osipenko@collabora.com">=
dmitry.osipenko@collabora.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">Even though GL GPU doesn&#39;t support hotplug=
ging today, free virgl<br>
resources when GL device is unrealized. For consistency.<br>
<br>
Signed-off-by: Dmitry Osipenko &lt;<a href=3D"mailto:dmitry.osipenko@collab=
ora.com" target=3D"_blank">dmitry.osipenko@collabora.com</a>&gt;<br>
---<br>
=C2=A0hw/display/virtio-gpu-gl.c=C2=A0 =C2=A0 =C2=A0| 13 +++++++++++++<br>
=C2=A0hw/display/virtio-gpu-virgl.c=C2=A0 | 11 +++++++++++<br>
=C2=A0include/hw/virtio/virtio-gpu.h |=C2=A0 1 +<br>
=C2=A03 files changed, 25 insertions(+)<br>
<br>
diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c<br>
index 38a2b1bd3916..7978b2985e17 100644<br>
--- a/hw/display/virtio-gpu-gl.c<br>
+++ b/hw/display/virtio-gpu-gl.c<br>
@@ -149,6 +149,18 @@ static Property virtio_gpu_gl_properties[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_END_OF_LIST(),<br>
=C2=A0};<br>
<br>
+static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)<br>
+{<br>
+=C2=A0 =C2=A0 VirtIOGPU *g =3D VIRTIO_GPU(qdev);<br>
+=C2=A0 =C2=A0 VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(qdev);<br>
+<br>
+=C2=A0 =C2=A0 if (gl-&gt;renderer_state &gt;=3D RS_INITED) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_virgl_deinit(g);<br></blockquote><d=
iv><br></div><div>The extra function seems unnecessary.</div><div>=C2=A0<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 gl-&gt;renderer_state =3D RS_START;<br>
+}<br>
+<br>
=C2=A0static void virtio_gpu_gl_class_init(ObjectClass *klass, void *data)<=
br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
@@ -162,6 +174,7 @@ static void virtio_gpu_gl_class_init(ObjectClass *klass=
, void *data)<br>
=C2=A0 =C2=A0 =C2=A0vgc-&gt;update_cursor_data =3D virtio_gpu_gl_update_cur=
sor_data;<br>
<br>
=C2=A0 =C2=A0 =C2=A0vdc-&gt;realize =3D virtio_gpu_gl_device_realize;<br>
+=C2=A0 =C2=A0 vdc-&gt;unrealize =3D virtio_gpu_gl_device_unrealize;<br>
=C2=A0 =C2=A0 =C2=A0vdc-&gt;reset =3D virtio_gpu_gl_reset;<br>
=C2=A0 =C2=A0 =C2=A0device_class_set_props(dc, virtio_gpu_gl_properties);<b=
r>
=C2=A0}<br>
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c<=
br>
index fa0da8f5c7f1..66c4aab9b283 100644<br>
--- a/hw/display/virtio-gpu-virgl.c<br>
+++ b/hw/display/virtio-gpu-virgl.c<br>
@@ -669,3 +669,14 @@ int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)<br>
<br>
=C2=A0 =C2=A0 =C2=A0return capset2_max_ver ? 2 : 1;<br>
=C2=A0}<br>
+<br>
+void virtio_gpu_virgl_deinit(VirtIOGPU *g)<br>
+{<br>
+=C2=A0 =C2=A0 VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(g);<br>
+<br>
+=C2=A0 =C2=A0 if (virtio_gpu_stats_enabled(g-&gt;parent_obj.conf)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_free(gl-&gt;print_stats);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 timer_free(gl-&gt;fence_poll);<br>
+=C2=A0 =C2=A0 virgl_renderer_cleanup(NULL);<br>
+}<br>
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.=
h<br>
index 6e71d799e5da..2faeda6f6abe 100644<br>
--- a/include/hw/virtio/virtio-gpu.h<br>
+++ b/include/hw/virtio/virtio-gpu.h<br>
@@ -345,6 +345,7 @@ void virtio_gpu_virgl_fence_poll(VirtIOGPU *g);<br>
=C2=A0void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g);<br>
=C2=A0void virtio_gpu_virgl_reset(VirtIOGPU *g);<br>
=C2=A0int virtio_gpu_virgl_init(VirtIOGPU *g);<br>
+void virtio_gpu_virgl_deinit(VirtIOGPU *g);<br>
=C2=A0int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g);<br>
<br>
=C2=A0#endif<br>
-- <br>
2.44.0<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000612acd061a11319c--

