Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15340C27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 14:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEVPA-0004bd-Qa; Tue, 04 Jun 2024 10:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sEVP9-0004b9-BZ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:44:51 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sEVP7-0000B9-Hq
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:44:51 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3d1fd55081fso523062b6e.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 07:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717512288; x=1718117088; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2ZAYJRfvgdK00JilvMEzvKdm1UtIiVs7VYUy0HFhxG4=;
 b=EMb3yXxxXt6pFXz5d6bkGGCcFsFO/SJMla8n4YPNdUw67YGMykKIkPk0GYxJIyEVlt
 mAlvGvVDs6XgDZce6MgbQ+rUhnwf9qFQNT26j79CkpiJxZZHwp6SbnqsRyk9DVWMxXm8
 49As3xKj14Go0l/A12flilead6ZsGOZUrEaqPSjorOWP+M04CZq73wszrK99eaU05jF1
 ZIBE1SH4UvIPyAKTHKHEjtUGNEJNw0soi+fYt73ScgHO2VshCS3zq5KWl4tiPY+3T1cm
 2XRbHK8iBOK0Dq4GAiOM44LJhBfAxf8FzjNaeo/bhoDh1QPhP7IUQ1bdDFKBWtC2o2S0
 omDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717512288; x=1718117088;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2ZAYJRfvgdK00JilvMEzvKdm1UtIiVs7VYUy0HFhxG4=;
 b=PnD4SGrsooOcjdpu2vSdXxFfJ2AdljRCK2GyR2o6YykJOsbvdc/flUOwAonRnqg38i
 HUoA5jbwSHN/xef4niyxhN/3OvXHZ2LPWl8FLk4f8p4KTARIcSfHGE5opxKFi4dEfTLY
 Uvpark6S81bqRTP7YsDKv+PWneMcaVH5mUfGSSI8ctoH/WksWn+6ZD04DJIl7N3F8fH4
 gi6dQEMuGZ7bU2S7JfZmuiIYxXYFXEEz6yv1oC5W6ey/8qdmxZWLDJQtV8PdXbOFbcLR
 rBhKbgD8MMysmpJpvkocitcEE/bwL8WESYV9hZeBgiQgBOXboIx+zA/SNkkdvcAAJZWJ
 s21g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5/nie4WJ9VOVZoADDGnSbqarV9MwKD9FAFmspV9IGZs+TTxxEGXa6nw8MArJKJzpLg80hZwOgAKmt7TrvNO8R2tlKTtc=
X-Gm-Message-State: AOJu0Yz9+BF0AP0r9l/gbq7MUMc6PUh3J6vQ43B1iiOG03ZuQRP/gIGe
 oqc17jWFvVuBQ0TQOKSBWtrlgEeY0Ac84ZLgG8bAzIbof8w0F9lkMXzray046iU12Jylub+Y7Or
 iosXlxy8XTG7pExYfhSqZq7IpYuM=
X-Google-Smtp-Source: AGHT+IH/0s2i7hYmDDhxfrc/imD9PmHRfpznJHlcWdoaG68Z323TjBNL4hFIqRXvEYpbm90yIzqQ61HZfaf5gfiH2b8=
X-Received: by 2002:aca:180d:0:b0:3c9:66f2:69c0 with SMTP id
 5614622812f47-3d1e35cf455mr10825777b6e.55.1717512287901; Tue, 04 Jun 2024
 07:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240527030233.3775514-1-dmitry.osipenko@collabora.com>
 <20240527030233.3775514-11-dmitry.osipenko@collabora.com>
In-Reply-To: <20240527030233.3775514-11-dmitry.osipenko@collabora.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 4 Jun 2024 18:44:36 +0400
Message-ID: <CAJ+F1C+mMKR_bU3HiJP+v9PdGXS+4qfmkoydaEC3MAzmS3TkHg@mail.gmail.com>
Subject: Re: [PATCH v13 10/13] virtio-gpu: Support suspension of commands
 processing
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
Content-Type: multipart/alternative; boundary="000000000000d15feb061a117d42"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-oi1-x22c.google.com
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

--000000000000d15feb061a117d42
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, May 27, 2024 at 7:03=E2=80=AFAM Dmitry Osipenko <
dmitry.osipenko@collabora.com> wrote:

> Check whether command processing has been finished; otherwise, stop
> processing commands and retry the command again next time. This allows
> us to support asynchronous execution of non-fenced commands needed for
> unmapping host blobs safely.
>
> Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  hw/display/virtio-gpu.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index f3d2def9a49f..8e05a2d0c7c5 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1054,6 +1054,11 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
>          /* process command */
>          vgc->process_cmd(g, cmd);
>
> +        /* command suspended */
> +        if (!cmd->finished && !(cmd->cmd_hdr.flags &
> VIRTIO_GPU_FLAG_FENCE)) {
>

Since this is not tracked in "inflight" debugging, it would be worth adding
a trace for this early break.

Btw, if you could replace the fprintf below with a trace as well, this
would be a nice cleanup too



> +            break;
> +        }
> +
>          QTAILQ_REMOVE(&g->cmdq, cmd, next);
>          if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
>              g->stats.requests++;
> --
> 2.44.0
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000d15feb061a117d42
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 27, 2024 at 7:03=E2=80=
=AFAM Dmitry Osipenko &lt;<a href=3D"mailto:dmitry.osipenko@collabora.com">=
dmitry.osipenko@collabora.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">Check whether command processing has been fini=
shed; otherwise, stop<br>
processing commands and retry the command again next time. This allows<br>
us to support asynchronous execution of non-fenced commands needed for<br>
unmapping host blobs safely.<br>
<br>
Suggested-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com"=
 target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
Signed-off-by: Dmitry Osipenko &lt;<a href=3D"mailto:dmitry.osipenko@collab=
ora.com" target=3D"_blank">dmitry.osipenko@collabora.com</a>&gt;<br>
---<br>
=C2=A0hw/display/virtio-gpu.c | 5 +++++<br>
=C2=A01 file changed, 5 insertions(+)<br>
<br>
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c<br>
index f3d2def9a49f..8e05a2d0c7c5 100644<br>
--- a/hw/display/virtio-gpu.c<br>
+++ b/hw/display/virtio-gpu.c<br>
@@ -1054,6 +1054,11 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* process command */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vgc-&gt;process_cmd(g, cmd);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* command suspended */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cmd-&gt;finished &amp;&amp; !(cmd-&gt;cmd=
_hdr.flags &amp; VIRTIO_GPU_FLAG_FENCE)) {<br>
</blockquote><div><br></div><div>Since this is not tracked in &quot;infligh=
t&quot; debugging, it would be worth adding a trace for this early break.</=
div><div><br></div><div>Btw, if you could replace the fprintf below with a =
trace as well, this would be a nice cleanup too</div><div><br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QTAILQ_REMOVE(&amp;g-&gt;cmdq, cmd, next)=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (virtio_gpu_stats_enabled(g-&gt;parent=
_obj.conf)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g-&gt;stats.requests++;<br>
-- <br>
2.44.0<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000d15feb061a117d42--

