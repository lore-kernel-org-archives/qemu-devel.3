Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB346EB7ED2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 04:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy0HZ-0002kP-9s; Wed, 04 Mar 2026 23:25:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3vgWpaQQKCsEyrpynvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--rkir.bounces.google.com>)
 id 1vy0HP-0002jh-Qk
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 23:25:43 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3vgWpaQQKCsEyrpynvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--rkir.bounces.google.com>)
 id 1vy0HJ-00030g-U2
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 23:25:40 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-3598733bec0so22557550a91.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 20:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772684735; x=1773289535; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=f0jeF5OtZ+xh9chpO27ToX69VnKs/RQROjWupnuzbjg=;
 b=sicbXqflIjekwWez8p4RcygFRmDr2YZYuc3zmbRHxOOM4TBfiJfszDo7zGiSH14upX
 9pE4duPrXX2wrWuklZy3lmvo9EW9vY7cYmY18PL21Z3BLy7QCGguguCS7gycg7EhVctY
 CiDnD9JpExPLVwHZ4w67WSv2xej5EKbfDBsNdItbSC+sJsAXI5nw+ftn/RpvhPzpO9c6
 nadmcBxKO5fSHv1BL4IavR4Dwgu2Pxj9qB7C8KlEwilv9tZ3ej1XRlunIt9CoTg7XLay
 BUdiOBGHQB+n6rxf2dWlg+HUTniJLJUXBEdX+ydSI0PLG+kukqsNoGYriFT8x5vI0cHS
 XQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772684735; x=1773289535;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f0jeF5OtZ+xh9chpO27ToX69VnKs/RQROjWupnuzbjg=;
 b=YYeIKDYO+sy2uHhGDPFftPUNTg85MGZCJloTEVgl54bs7hKx1fA4/OUCjwe5irxEHY
 b7OustX9nwApC/dKeky021OZM+6r7BTc0MaRP3EnYM+IQ4qKCJM15vSUH+2hc3/oU5oM
 tEfwUOd/PoDweLSZwVnvrXRmCOWOLDymOJ6MfS8tvyJSKGD62+RFFat4ZA6GuxRubn9x
 G2gNqykMnwPDjaaWfMwXTvZ2w+4Jed45f1/WRspOCw3bTpl/6M8+QBoINrehVIlBY8Tx
 x9EsrKO/v27s1jtY54wYJcPtSqebg5uw+mEWNdxwvRkOOxM3g4UTb/slziswpaxju07+
 E/AA==
X-Gm-Message-State: AOJu0YyQeFnH2z+iZ4/bNbZISpVGJSBdpgw4tOYC14qdaUh4mjInWVfg
 aHFLvr4sZd432zV9qSvv8ZYSOLyfkKm/e49AdR7iOKOY3FTjgQZB83y1HjW9TJVY8/osDr3zfg=
 =
X-Received: from pgmm7.prod.google.com ([2002:a05:6a02:5507:b0:c65:d823:cdf2])
 (user=rkir job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:4598:b0:334:a11e:6bed
 with SMTP id adf61e73a8af0-3982deb980fmr4289719637.29.1772684734931; Wed, 04
 Mar 2026 20:25:34 -0800 (PST)
Date: Thu,  5 Mar 2026 04:25:23 +0000
In-Reply-To: <20260305042523.335493-1-rkir@google.com>
Mime-Version: 1.0
References: <20260305042523.335493-1-rkir@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260305042523.335493-2-rkir@google.com>
Subject: [PATCH 2/2] virtio-snd: remove redundant fields
From: Roman Kiryanov <rkir@google.com>
To: manos.pitsidianakis@linaro.org
Cc: qemu-devel@nongnu.org, whollins@google.com, jansene@google.com, 
 jpcottin@google.com, Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3vgWpaQQKCsEyrpynvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--rkir.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

VirtIOSoundPCM does not need a pointer to
VirtIOSound because each VirtIOSoundPCMStream
already carries a pointer to it.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 hw/audio/virtio-snd.c         | 6 ++----
 include/hw/audio/virtio-snd.h | 2 --
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 0f78cec967..fb5cff3866 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -402,10 +402,10 @@ static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
     if (stream) {
         virtio_snd_pcm_flush(stream);
         if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
-            audio_be_close_out(stream->pcm->snd->audio_be, stream->voice.out);
+            audio_be_close_out(stream->s->audio_be, stream->voice.out);
             stream->voice.out = NULL;
         } else if (stream->info.direction == VIRTIO_SND_D_INPUT) {
-            audio_be_close_in(stream->pcm->snd->audio_be, stream->voice.in);
+            audio_be_close_in(stream->s->audio_be, stream->voice.in);
             stream->voice.in = NULL;
         }
     }
@@ -440,7 +440,6 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
         stream = g_new0(VirtIOSoundPCMStream, 1);
         stream->active = false;
         stream->id = stream_id;
-        stream->pcm = &s->pcm;
         stream->s = s;
         stream->latency_bytes = 0;
         qemu_mutex_init(&stream->queue_mutex);
@@ -1064,7 +1063,6 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     vsnd->vmstate =
         qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vsnd);
 
-    vsnd->pcm.snd = vsnd;
     vsnd->pcm.streams =
         g_new0(VirtIOSoundPCMStream *, vsnd->snd_conf.streams);
     vsnd->pcm.pcm_params =
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index da2ba9675e..e28f1be5db 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -122,7 +122,6 @@ struct VirtIOSoundPCMBuffer {
 };
 
 struct VirtIOSoundPCM {
-    VirtIOSound *snd;
     /*
      * PCM parameters are a separate field instead of a VirtIOSoundPCMStream
      * field, because the operation of PCM control requests is first
@@ -135,7 +134,6 @@ struct VirtIOSoundPCM {
 };
 
 struct VirtIOSoundPCMStream {
-    VirtIOSoundPCM *pcm;
     virtio_snd_pcm_info info;
     virtio_snd_pcm_set_params params;
     uint32_t id;
-- 
2.53.0.473.g4a7958ca14-goog


