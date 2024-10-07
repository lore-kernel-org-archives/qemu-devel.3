Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EBDCFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 06:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxhhE-00020g-21; Mon, 07 Oct 2024 02:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1sxhhD-00020S-1I
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 02:58:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1sxhhB-0001si-1r
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 02:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728284279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K/a/RWmO5RwY5GDYcuWe9Sr7t/S4ZqMlK/d2olT8XXE=;
 b=UcYd58zqueDfE1sqn3OAh7JtDkmPkb0AbtU0V3syGoej0TTqNG2g9wUcgWhdVsNHGa4jil
 xGoubfCPm9icKp4wxEhGFLKWaSyn1omgbySZnyu13qamil/AoYmbBq1qDmz6x/BmE7CnBf
 loc/qlRo8s1Q6ZtGxAyBSKYaIlXZaHs=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-43_-W8jBNre0b-kNYgDoFA-1; Mon, 07 Oct 2024 02:57:57 -0400
X-MC-Unique: 43_-W8jBNre0b-kNYgDoFA-1
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-82b930cd6b2so632962239f.1
 for <qemu-devel@nongnu.org>; Sun, 06 Oct 2024 23:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728284277; x=1728889077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K/a/RWmO5RwY5GDYcuWe9Sr7t/S4ZqMlK/d2olT8XXE=;
 b=EDK02/0XG64AVCUjSkGf23E0DRBYwFs0VwhP2vO5cYi7G7xM222kNuOZV8DyazN6w0
 vclB/AV+0d53ZhDK/fNOSUm5oOLei8hDHX7La+HbK+AqZhBHO/ZZCnhI4qcHeC6kdH1b
 jx5uwizf6MEAEV1qAUlefti6xLPO62hCytwE71YCowhc2/jBIC3AY2uvBdqAixmWWhIw
 wzudFAsZx40JPA+CC7ADrdyA8SPL9mzZYW3y81545Fojkt9iUSWVWUaKJyyTGoDrEyxC
 m8o9O6iVnCU+AG0m+YUwNFESNENgGHoNqwG0xtpExQMV0IVRLVLpwtQ0MlJWqWu8p8wB
 rlPg==
X-Gm-Message-State: AOJu0YzXiZ1n0EeU2o/a/g8h5Il6vC+HYQU9EmT5uL4zbEW/iKXSRZZl
 gVuD8c/aNz0CF0fZYvuZg2QhWGMlfC+iLgeiZXHZrduDKoGOiKx+CxL3onmliDoMBcexJWT+jvZ
 hikA8J0xtVwekYAM4bC8SD/xq/KMbvGrKaQMjCAXJaUXZEEnWtk3bpn8RFbJhmXWs1Bp/zmMKtj
 n9oNdE1aXZu877XjH5JIqs1r8D1kE=
X-Received: by 2002:a92:c564:0:b0:3a0:92b1:ec4c with SMTP id
 e9e14a558f8ab-3a375bb7860mr86993425ab.23.1728284276939; 
 Sun, 06 Oct 2024 23:57:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFluvQBGSwUSA9Z/tu3L4ZtTME1z/5nZkyCBw0fPZ8oqy/eWD35CrUHv+9YG8Gpbljw1t5ib/llebRqH7FXDhg=
X-Received: by 2002:a92:c564:0:b0:3a0:92b1:ec4c with SMTP id
 e9e14a558f8ab-3a375bb7860mr86993355ab.23.1728284276659; Sun, 06 Oct 2024
 23:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20241004164140.1886877-1-dbassey@redhat.com>
 <kvbvl.ymheg31fu152@linaro.org>
In-Reply-To: <kvbvl.ymheg31fu152@linaro.org>
From: Dorinda Bassey <dbassey@redhat.com>
Date: Mon, 7 Oct 2024 08:57:36 +0200
Message-ID: <CACzuRyxynoXCdsXndD7d3UdL=XMRS8-V5NeTpSwsHAQh=jAR3A@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu: Add definition for resource_uuid feature
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mhrica@redhat.com
Content-Type: multipart/alternative; boundary="00000000000061afeb0623dd8aec"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dbassey@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

--00000000000061afeb0623dd8aec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Manos,

Thanks, for spotting that!

On Sat, Oct 5, 2024 at 7:43=E2=80=AFAM Manos Pitsidianakis <
manos.pitsidianakis@linaro.org> wrote:

> Hello Dorinda,
>
> On Fri, 04 Oct 2024 19:41, Dorinda Bassey <dbassey@redhat.com> wrote:
> >Add the VIRTIO_GPU_F_RESOURCE_UUID feature to enable the assignment
> >of resources UUIDs for export to other virtio devices.
> >
> >Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
> >---
> > hw/display/vhost-user-gpu.c    | 4 ++++
> > hw/display/virtio-gpu-base.c   | 3 +++
> > include/hw/virtio/virtio-gpu.h | 3 +++
> > 3 files changed, 10 insertions(+)
> >
> >diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> >index 14548f1a57..053cfd9cff 100644
> >--- a/hw/display/vhost-user-gpu.c
> >+++ b/hw/display/vhost-user-gpu.c
> >@@ -631,6 +631,10 @@ vhost_user_gpu_device_realize(DeviceState *qdev,
> Error **errp)
> >         error_report("EDID requested but the backend doesn't support
> it.");
> >         g->parent_obj.conf.flags &=3D ~(1 << VIRTIO_GPU_FLAG_EDID_ENABL=
ED);
> >     }
> >+    if (virtio_has_feature(g->vhost->dev.features,
> >+        VIRTIO_GPU_F_RESOURCE_UUID)) {
> >+        g->parent_obj.conf.flags |=3D 1 <<
> VIRTIO_GPU_F_RESOURCE_UUID_ENABLED;
> >+    }
> >
> >     if (!virtio_gpu_base_device_realize(qdev, NULL, NULL, errp)) {
> >         return;
> >diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
> >index 4fc7ef8896..7827536ac4 100644
> >--- a/hw/display/virtio-gpu-base.c
> >+++ b/hw/display/virtio-gpu-base.c
> >@@ -235,6 +235,9 @@ virtio_gpu_base_get_features(VirtIODevice *vdev,
> uint64_t features,
> >     if (virtio_gpu_context_init_enabled(g->conf)) {
> >         features |=3D (1 << VIRTIO_GPU_F_CONTEXT_INIT);
> >     }
> >+    if (virtio_gpu_resource_uuid_enabled(g->conf)) {
> >+        features |=3D (1 << VIRTIO_GPU_F_RESOURCE_UUID);
> >+    }
> >
> >     return features;
> > }
> >diff --git a/include/hw/virtio/virtio-gpu.h
> b/include/hw/virtio/virtio-gpu.h
> >index 7a59379f5a..15e193bb6d 100644
> >--- a/include/hw/virtio/virtio-gpu.h
> >+++ b/include/hw/virtio/virtio-gpu.h
> >@@ -99,6 +99,7 @@ enum virtio_gpu_base_conf_flags {
> >     VIRTIO_GPU_FLAG_BLOB_ENABLED,
> >     VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED,
> >     VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,
> >+    VIRTIO_GPU_F_RESOURCE_UUID_ENABLED,
>
>
> s/F_/FLAG_/
>
>
> > };
> >
> > #define virtio_gpu_virgl_enabled(_cfg) \
> >@@ -115,6 +116,8 @@ enum virtio_gpu_base_conf_flags {
> >     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED))
> > #define virtio_gpu_rutabaga_enabled(_cfg) \
> >     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_RUTABAGA_ENABLED))
> >+#define virtio_gpu_resource_uuid_enabled(_cfg) \
> >+    (_cfg.flags & (1 << VIRTIO_GPU_F_RESOURCE_UUID_ENABLED))
> > #define virtio_gpu_hostmem_enabled(_cfg) \
> >     (_cfg.hostmem > 0)
> >
> >--
> >2.46.1
> >
> >
>
>

--00000000000061afeb0623dd8aec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Manos,<br></div><div><br></div><div>Thanks, for sp=
otting that!</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Sat, Oct 5, 2024 at 7:43=E2=80=AFAM Manos Pitsidianaki=
s &lt;<a href=3D"mailto:manos.pitsidianakis@linaro.org">manos.pitsidianakis=
@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hello Dorinda,<br>
<br>
On Fri, 04 Oct 2024 19:41, Dorinda Bassey &lt;<a href=3D"mailto:dbassey@red=
hat.com" target=3D"_blank">dbassey@redhat.com</a>&gt; wrote:<br>
&gt;Add the VIRTIO_GPU_F_RESOURCE_UUID feature to enable the assignment<br>
&gt;of resources UUIDs for export to other virtio devices.<br>
&gt;<br>
&gt;Signed-off-by: Dorinda Bassey &lt;<a href=3D"mailto:dbassey@redhat.com"=
 target=3D"_blank">dbassey@redhat.com</a>&gt;<br>
&gt;---<br>
&gt; hw/display/vhost-user-gpu.c=C2=A0 =C2=A0 | 4 ++++<br>
&gt; hw/display/virtio-gpu-base.c=C2=A0 =C2=A0| 3 +++<br>
&gt; include/hw/virtio/virtio-gpu.h | 3 +++<br>
&gt; 3 files changed, 10 insertions(+)<br>
&gt;<br>
&gt;diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c<=
br>
&gt;index 14548f1a57..053cfd9cff 100644<br>
&gt;--- a/hw/display/vhost-user-gpu.c<br>
&gt;+++ b/hw/display/vhost-user-gpu.c<br>
&gt;@@ -631,6 +631,10 @@ vhost_user_gpu_device_realize(DeviceState *qdev, E=
rror **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;EDID requested but=
 the backend doesn&#39;t support it.&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g-&gt;parent_obj.conf.flags &amp;=3D =
~(1 &lt;&lt; VIRTIO_GPU_FLAG_EDID_ENABLED);<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;+=C2=A0 =C2=A0 if (virtio_has_feature(g-&gt;vhost-&gt;dev.features,<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VIRTIO_GPU_F_RESOURCE_UUID)) {<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g-&gt;parent_obj.conf.flags |=3D 1 &lt;&lt=
; VIRTIO_GPU_F_RESOURCE_UUID_ENABLED;<br>
&gt;+=C2=A0 =C2=A0 }<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0if (!virtio_gpu_base_device_realize(qdev, NULL, NUL=
L, errp)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.=
c<br>
&gt;index 4fc7ef8896..7827536ac4 100644<br>
&gt;--- a/hw/display/virtio-gpu-base.c<br>
&gt;+++ b/hw/display/virtio-gpu-base.c<br>
&gt;@@ -235,6 +235,9 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, ui=
nt64_t features,<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (virtio_gpu_context_init_enabled(g-&gt;conf)) {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0features |=3D (1 &lt;&lt; VIRTIO_GPU_=
F_CONTEXT_INIT);<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;+=C2=A0 =C2=A0 if (virtio_gpu_resource_uuid_enabled(g-&gt;conf)) {<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 features |=3D (1 &lt;&lt; VIRTIO_GPU_F_RES=
OURCE_UUID);<br>
&gt;+=C2=A0 =C2=A0 }<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0return features;<br>
&gt; }<br>
&gt;diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-=
gpu.h<br>
&gt;index 7a59379f5a..15e193bb6d 100644<br>
&gt;--- a/include/hw/virtio/virtio-gpu.h<br>
&gt;+++ b/include/hw/virtio/virtio-gpu.h<br>
&gt;@@ -99,6 +99,7 @@ enum virtio_gpu_base_conf_flags {<br>
&gt;=C2=A0 =C2=A0 =C2=A0VIRTIO_GPU_FLAG_BLOB_ENABLED,<br>
&gt;=C2=A0 =C2=A0 =C2=A0VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED,<br>
&gt;=C2=A0 =C2=A0 =C2=A0VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,<br>
&gt;+=C2=A0 =C2=A0 VIRTIO_GPU_F_RESOURCE_UUID_ENABLED,<br>
<br>
<br>
s/F_/FLAG_/<br>
<br>
<br>
&gt; };<br>
&gt; <br>
&gt; #define virtio_gpu_virgl_enabled(_cfg) \<br>
&gt;@@ -115,6 +116,8 @@ enum virtio_gpu_base_conf_flags {<br>
&gt;=C2=A0 =C2=A0 =C2=A0(_cfg.flags &amp; (1 &lt;&lt; VIRTIO_GPU_FLAG_CONTE=
XT_INIT_ENABLED))<br>
&gt; #define virtio_gpu_rutabaga_enabled(_cfg) \<br>
&gt;=C2=A0 =C2=A0 =C2=A0(_cfg.flags &amp; (1 &lt;&lt; VIRTIO_GPU_FLAG_RUTAB=
AGA_ENABLED))<br>
&gt;+#define virtio_gpu_resource_uuid_enabled(_cfg) \<br>
&gt;+=C2=A0 =C2=A0 (_cfg.flags &amp; (1 &lt;&lt; VIRTIO_GPU_F_RESOURCE_UUID=
_ENABLED))<br>
&gt; #define virtio_gpu_hostmem_enabled(_cfg) \<br>
&gt;=C2=A0 =C2=A0 =C2=A0(_cfg.hostmem &gt; 0)<br>
&gt; <br>
&gt;-- <br>
&gt;2.46.1<br>
&gt;<br>
&gt;<br>
<br>
</blockquote></div>

--00000000000061afeb0623dd8aec--


