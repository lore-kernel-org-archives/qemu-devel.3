Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE300FD88D2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 23:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w06wo-0004wZ-AZ; Tue, 10 Mar 2026 19:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <30K-waQQKCkc0tr0pxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--rkir.bounces.google.com>)
 id 1w06wm-0004vz-LW
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:57:09 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <30K-waQQKCkc0tr0pxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--rkir.bounces.google.com>)
 id 1w06wl-0002Js-3X
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:57:08 -0400
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-829b9320a2cso1398908b3a.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 16:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1773187025; x=1773791825; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=X0aTiEBxHzNsnv4Dg3eXLQ7mbtCD9oqDijUAqvIXilI=;
 b=alQemdvOimYDSzsylBRr2QsG+GWmr6PsH4tvzcMj107d0xHbVOUnLWXuVvvKQx4QgP
 7ye68s8NyVpZ9mNluFdk1ScJbjAkkkTnHILcJvjBzTQ+Yp2dYMwAaJvrBGoH2R0/Ohsf
 5V0Y81SpX+aOZZt4ujExIPpxGHtBDfgwCCyb+d8+UeqtyXRcHZNZ6IS7p6kfAPysU7XU
 SSumo1NjsKNP//q73j6LqyaEyQevj3fen+ZXhpCk5IFzAaKe815zv9nMJ6vhSQyTU4KT
 keMa7Devi0jp7uRZlWR0V55SXFdr63ig0b8FClweM6YdFpckG7iO79SZdh62FIKjFRE0
 cJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773187025; x=1773791825;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X0aTiEBxHzNsnv4Dg3eXLQ7mbtCD9oqDijUAqvIXilI=;
 b=n2YHNah+b0aEUt9bTvKP9arjlZ1MAq13cozQV6hrC26NRynAJ7i0AipOfUYy7jAASN
 hXcEZYWtwptVHSHdkQFMBz9NtmERDkN3Q8LmFKyQJD+dPwncteehGoujJVxJXSTxfRHu
 DkhkvHN6cQyEixedCIw5Gwy8xRmxR79MCvgTYJxENEWfpqRw9zWTymW4ruEtbeavfkpi
 az+ptGaof+0+5K54GAkQTPaWudYQUyaG/8VRIET9xsMn21HUByzxNxCNQMe8fED5cxdQ
 ivttzyyoc9XqF/zCP/a1y++EqqqrdDTj75ulhHipCvPobX7uA0RS2N4V0qqxzKjhUWpD
 B/RQ==
X-Gm-Message-State: AOJu0YwEhAbQx52sWXQyAUquq0AoXRUMfGoisXyE88mPvFo1g2JCc2jA
 jm13FWuJi1qyjg9j6Gnpxzv3R6EL2Tac50mWQRrNNcGnulBMwuxyXp/IuMCzFPvSXrEP0Y+i6Q=
 =
X-Received: from pfdj19.prod.google.com ([2002:a05:6a00:9513:b0:7dd:8bba:63aa])
 (user=rkir job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3d54:b0:823:8a5:297f
 with SMTP id d2e1a72fcca58-829f6ea7405mr522615b3a.16.1773187024998; Tue, 10
 Mar 2026 16:57:04 -0700 (PDT)
Date: Tue, 10 Mar 2026 23:56:31 +0000
In-Reply-To: <20260310235632.3987668-1-rkir@google.com>
Mime-Version: 1.0
References: <20260310235632.3987668-1-rkir@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310235632.3987668-3-rkir@google.com>
Subject: [PATCH 2/3] virtio-snd: remove virtio_snd_pcm_set_params from
 VirtIOSoundPCMStream
From: Roman Kiryanov <rkir@google.com>
To: philmd@linaro.org, manos.pitsidianakis@linaro.org
Cc: qemu-devel@nongnu.org, whollins@google.com, jansene@google.com, 
 jpcottin@google.com, Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::44a;
 envelope-from=30K-waQQKCkc0tr0pxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--rkir.bounces.google.com;
 helo=mail-pf1-x44a.google.com
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

The virtio_snd_pcm_set_params values are latched
into a VirtIOSoundPCMStream instance during
the PREPARE request where they are converted into
audsettings. Only the `period_bytes` value is used
afterwards.

Having both audsettings and virtio_snd_pcm_set_params
next to each other grows sizeof and adds confusion to
snapshot handling.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 hw/audio/virtio-snd.c         | 6 +++---
 include/hw/audio/virtio-snd.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index bd6a5d71bb..6d820b56a6 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -461,7 +461,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
     stream->info.channels_max = as.nchannels;
     stream->info.formats = supported_formats;
     stream->info.rates = supported_rates;
-    stream->params = *params;
+    stream->period_bytes = params->period_bytes;
     stream->as = as;
 
     if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
@@ -1271,7 +1271,7 @@ static void virtio_snd_pcm_in_cb(void *data, int available)
                     return_rx_buffer(stream, buffer);
                     break;
                 }
-                to_read = stream->params.period_bytes - buffer->size;
+                to_read = stream->period_bytes - buffer->size;
                 to_read = MIN(to_read, available);
                 to_read = MIN(to_read, max_size - buffer->size);
                 size = audio_be_read(stream->s->audio_be,
@@ -1284,7 +1284,7 @@ static void virtio_snd_pcm_in_cb(void *data, int available)
                 }
                 buffer->size += size;
                 available -= size;
-                if (buffer->size >= stream->params.period_bytes) {
+                if (buffer->size >= stream->period_bytes) {
                     return_rx_buffer(stream, buffer);
                     break;
                 }
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index f8bb5c95b9..a767f68301 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -135,8 +135,8 @@ struct VirtIOSoundPCM {
 
 struct VirtIOSoundPCMStream {
     virtio_snd_pcm_info info;
-    virtio_snd_pcm_set_params params;
     uint32_t id;
+    uint32_t period_bytes;  /* from virtio_snd_pcm_set_params */
     VirtIOSound *s;
     bool flushing;
     audsettings as;
-- 
2.53.0.473.g4a7958ca14-goog


