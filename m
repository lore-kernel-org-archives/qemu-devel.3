Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01A6C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we6qn-0007SZ-6G; Mon, 29 Jun 2026 03:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1we6qj-0007SC-VH
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 03:56:14 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1we6qi-0005h5-0H
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 03:56:13 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-47231f1f8f3so1929460f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 00:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782719769; x=1783324569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=NTv0sadmnwpESnlLYirF9CcQUOo36rT4HFNEoMdDXpc=;
 b=EkIhSzovyAj46S7mMK68XwVOik3SdO5xtrx4OGIGQ8cLBnBORyDnqZeObWU63QjKOo
 1mF3EDB/RyDoD2D6PZZSyOeapIhsJPeYNj6e7I8TXFDKx0P3GchJFKXPAvXEYCWU2U1O
 13wVfk4StWqFv+Ccq4WqApUy1oDS70L2VXjraG+YIYTJksNkgmroww+gqndGS7eOdHbO
 vqJwv/RVarP0756p5J9+1BvBTVeYJsFY1B7zNYNBjTwV3oBtaZh0FKaqeKkQa/apeq6J
 tV5IPoUyW5Rj6Z05ynkoV+7K1fAtQaSQZYtElVgORWGq3NjC1AZrediWdJ2AwJvroyiE
 u3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782719769; x=1783324569;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NTv0sadmnwpESnlLYirF9CcQUOo36rT4HFNEoMdDXpc=;
 b=aFO0gn9Phlyt7Xzud27iNpehJ4smV8lqerA58wvK97ZdTqQNSa5XPfmKKsSn4mjvm2
 A21mlkuuBWjGvKZzR62W0mGHVltTT/xgQyInYQCuu09NhbThjSH2Lv4qRF+jFE9b2VjQ
 VXAOiZV3f98Q+yiT1PVck6CFqDZCgOuCK3DqHyhWAuHfZ/oE2rkjttdFJ79hFoXaQZMq
 CtjahjWrQkRgLlBkI3lNlwVN0WG4PwIpub2TNozS0rfSKP1L1cCExXdF2b0u+GIcRkDO
 6s7aBm5iiM75tTUdxPkaKBSJrhKhP8iiQwhuO69Wh3sa2o6LMp25RcChkc3pk7eJEbcZ
 0T0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr62a9/Ce7weatRDNi/vsYsXWKqDd6UwOWEY0msLZlrIfA7gqUNpcwAlMkNz0JOMZAzTNCdwrQK55Fm@nongnu.org
X-Gm-Message-State: AOJu0Yx0BvdSQxGoSA8BhBx100MTLQuaVPyggDrcRygk5IcjKiWftdzo
 h90a1gD5AyOTYTr07rMoWsxLBfBwUi6Retrc9QQOYbWB3UW9hOX4n/grdQK9IjJNRaA=
X-Gm-Gg: AfdE7cn1M7OHIhm+Tw/lxWgfRbofoDhCH+O9Kk/EvxdDpWF2MekiQH/d4Bi5IbhGHoX
 bEchKJ3phuqEWoMx9mSOPSTEXH+osLFmVHwuwSf901soUFoL9h9HLztYFrG0m+kfGltU6WNQiai
 BzJhx4bEGiRbvwrwyYYopts+7deIRIjtXDfqQ5w5WDj6l3kcv5CEyJOu+4wLxMRgrvH54cm948w
 ypdqnlSFwrohs2Fo3UJS3xGQ9j+pSDPZ9n+7wCTxoQ6rAaC5MIlAjkRZvEQRSemvvSN+n+tsxuU
 j6GkQoTiCGodoUPu7l/Se368XmNPBIxZSazlAQgoFm2i+L/Jud+VDIEturijv5aZogFOSSAJsDV
 Vyy6Ls6Wben9g5p8Wx0nkgg9s2f99V8T8AXH2Olw1733kCuXWOHgARqK/Lx1x6ApWPq6a2AoUSL
 ZYAW5tnmZ7ftnhir6Q4tWx0ziHgXv9+mVb+OuqvQWehmRicO1XzTZEjfUcEie7KWHDcG/7s+nm2
 pftphkWPPKt2NY+nHj2iJAqm7YJptloqWFDP0LC2A0Uzf1KYTYe19JKYhusQmHNlPP2fonFGfkD
 jePMx4c615yGq8KI42ooIsc=
X-Received: by 2002:a05:6000:454e:b0:46e:765d:7894 with SMTP id
 ffacd0b85a97d-46e765d7e64mr14538812f8f.9.1782719769482; 
 Mon, 29 Jun 2026 00:56:09 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-131-154.home.otenet.gr. [2.86.131.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46f86c34d76sm22882764f8f.3.2026.06.29.00.56.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jun 2026 00:56:09 -0700 (PDT)
Date: Mon, 29 Jun 2026 10:51:44 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>, qemu-devel@nongnu.org
Cc: Volker R=?UTF-8?B?w7xtZWxpbg==?= <vr_qemu@t-online.de>,
 Marc-Andr=?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 St=?UTF-8?B?w6lwaGFuZQ==?= Graber <stgraber@stgraber.org>,
 "Daniel P . Berrang=?UTF-8?B?w6k=?=" <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v3 4/9] hw/audio/virtio-sound: split out
 virtio_snd_pcm_start_stop()
User-Agent: meli/0.8.13
References: <20260626123531.132078-1-alexander@mihalicyn.com>
 <20260626123531.132078-5-alexander@mihalicyn.com>
In-Reply-To: <20260626123531.132078-5-alexander@mihalicyn.com>
Message-ID: <thdvdk.23mk4gyijvrt@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 26 Jun 2026 15:35, Alexander Mikhalitsyn <alexander@mihalicyn.com> wrote:
>From: Volker Rümelin <vr_qemu@t-online.de>
>
>Split out virtio_snd_pcm_start_stop(). This is a preparation
>for the next patch so that it doesn't become too big.
>
>Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
>[AM: there were too many conflicts, I did `git checkout --ours -- <.>`
>     and then reimplemented the patch idea
>/AM]
>Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>---
>v3:
>	- resurrected error_report(..) as suggested by Marc-André Lureau
>---
> hw/audio/trace-events |  3 ++-
> hw/audio/virtio-snd.c | 59 ++++++++++++++++++++++++++++---------------
> 2 files changed, 41 insertions(+), 21 deletions(-)
>
>diff --git a/hw/audio/trace-events b/hw/audio/trace-events
>index 30f59215453..75d1fb37bd9 100644
>--- a/hw/audio/trace-events
>+++ b/hw/audio/trace-events
>@@ -53,7 +53,8 @@ virtio_snd_unrealize(void *snd) "snd %p: unrealize"
> virtio_snd_handle_pcm_set_params(uint32_t stream) "VIRTIO_SND_PCM_SET_PARAMS called for stream %"PRIu32
> virtio_snd_handle_ctrl(void *vdev, void *vq) "snd %p: handle ctrl event for queue %p"
> virtio_snd_handle_pcm_info(uint32_t stream) "VIRTIO_SND_R_PCM_INFO called for stream %"PRIu32
>-virtio_snd_handle_pcm_start_stop(const char *code, uint32_t stream) "%s called for stream %"PRIu32
>+virtio_snd_handle_pcm_start(uint32_t stream) "VIRTIO_SND_R_PCM_START called for stream %"PRIu32
>+virtio_snd_handle_pcm_stop(uint32_t stream) "VIRTIO_SND_R_PCM_STOP called for stream %"PRIu32
> virtio_snd_handle_pcm_release(uint32_t stream) "VIRTIO_SND_PCM_RELEASE called for stream %"PRIu32
> virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg val = %"PRIu32" == %s"
> virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
>diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
>index 8f4421ba844..300ba13ffeb 100644
>--- a/hw/audio/virtio-snd.c
>+++ b/hw/audio/virtio-snd.c
>@@ -521,7 +521,44 @@ static void virtio_snd_handle_pcm_prepare(VirtIOSound *s,
> }
> 
> /*
>- * Handles VIRTIO_SND_R_PCM_START.
>+ * Starts/Stops a VirtIOSound card stream.
>+ * Returns the response status code. (VIRTIO_SND_S_*).
>+ *
>+ * @s: VirtIOSound device
>+ * @stream_id: stream id
>+ * @start: whether to start or stop the stream
>+ */
>+static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
>+                                          uint32_t stream_id,
>+                                          bool start)
>+{
>+    VirtIOSoundPCMStream *stream;
>+
>+    stream = virtio_snd_pcm_get_stream(s, stream_id);
>+    if (!stream) {
>+        qemu_log_mask(LOG_GUEST_ERROR,
>+            "%s: Invalid stream id: %"PRIu32 "\n", __func__, stream_id);

Minor formatting nit:

+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Invalid stream id: %"PRIu32 "\n",
+                      __func__, stream_id);

>+        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>+    }
>+
>+    if (start) {
>+        trace_virtio_snd_handle_pcm_start(stream_id);
>+    } else {
>+        trace_virtio_snd_handle_pcm_stop(stream_id);
>+    }

Let's move the trace_*() calls at the start of the function, before the 
error checking, like it used to be.

>+
>+    stream->active = start;
>+    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
>+        audio_be_set_active_out(s->audio_be, stream->voice.out, start);
>+    } else {
>+        audio_be_set_active_in(s->audio_be, stream->voice.in, start);
>+    }
>+
>+    return cpu_to_le32(VIRTIO_SND_S_OK);
>+}
>+
>+/*
>+ * Handles VIRTIO_SND_R_PCM_START and VIRTIO_SND_R_PCM_STOP.
>  *
>  * @s: VirtIOSound device
>  * @cmd: The request command queue element from VirtIOSound cmdq field
>@@ -531,7 +568,6 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
>                                              virtio_snd_ctrl_command *cmd,
>                                              bool start)
> {
>-    VirtIOSoundPCMStream *stream;
>     virtio_snd_pcm_hdr req;
>     uint32_t stream_id;
>     size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
>@@ -549,24 +585,7 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
>     }
> 
>     stream_id = le32_to_cpu(req.stream_id);
>-    cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
>-    trace_virtio_snd_handle_pcm_start_stop(start ? "VIRTIO_SND_R_PCM_START" :
>-            "VIRTIO_SND_R_PCM_STOP", stream_id);
>-
>-    stream = virtio_snd_pcm_get_stream(s, stream_id);
>-    if (stream) {
>-        stream->active = start;
>-        if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
>-            audio_be_set_active_out(s->audio_be, stream->voice.out, start);
>-        } else {
>-            audio_be_set_active_in(s->audio_be, stream->voice.in, start);
>-        }
>-    } else {
>-        error_report("Invalid stream id: %"PRIu32, stream_id);
>-        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>-        return;
>-    }
>-    stream->active = start;
>+    cmd->resp.code = virtio_snd_pcm_start_stop(s, stream_id, start);
> }
> 
> /*
>-- 
>2.47.3
>

