Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFD4C982CC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 08:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7qr0-0005Co-Vq; Sat, 19 Sep 2026 04:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7qqz-0005CH-8m
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 04:55:25 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7qqv-0007IL-SL
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 04:55:25 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912e4b11so7911375e9.3
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 01:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789808120; x=1790412920; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AcYTJx9E4CYdyyMY0Az5kiAEmPZKXqi/EESegL6wNG0=;
 b=aV0YVcRGmyGdsiCFltvSz9RzUEiYzXlaAyBIV67NAhtBe719+jCY2QzrQOdKe4vtVO
 bX+yQFCcjaAI0WJJUefa71agKQ9CX/OWuKsSaO59JY8S1Jfr7V/tn7cpR/GqpMhw14bF
 d0ZFEybqeytaMg4qGX8qWeIExpLretf6KgGqWYRUROqzh/wMJERqPkC0hYmY3AnEJs+N
 CoSouZqseiMgCCzTQK+Moywqx2lqcaKA+6jVfMabaDzru+EWtDs8EUCc6jyxSJvKttDA
 LQ50nrOGvoX/kgA2XpJ0eySNjYY/lmsVxNvGMc1bM8lRQi4cs+bwPkEdUhP2r3S9vsOe
 2/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789808120; x=1790412920;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AcYTJx9E4CYdyyMY0Az5kiAEmPZKXqi/EESegL6wNG0=;
 b=Hq8cGlkrrSfzIHDOsYMjd7yWhgMoc+yaEC2unUpZ5KF/Lst+VPi9tlNYAtdMiXA0DE
 4ttVlgQcjGwUHieWg8UNamhRxv+vfx3NoD9VfM33PRw3mSSVjyHzMvRGf7juojz3znoK
 LxweNn+Sdez4FfpoHn209qwCGEdFoUbSR1Kgq90E1OIUMCzuAi6dxOS4ciSeEPIIcQVK
 Tw6o4j3Liph1txxkUpmeyFlEu+rHsZuMhbO+9OpZcqdN0yjNSxVEbNEyZLZTe537GQea
 FqTpjPULwqvLZmyn+sn4YTLgfrpRA+qSsL4H+zYk+bMIB4gpA4q11vDnmh+sTdD64/m7
 /2oA==
X-Gm-Message-State: AFuF++lFuh/NGeZsboeZNPnyuMbD045SH/MC4WHMHyDXBJML+kGUhx/j
 6qHaNfJ9tfL33iKnha6iy7krQlUHY9n6fM+2QoMV4RWYz22iJKCZTAbJkFUx95/NY8b9oZkFyRA
 51QQY0zo=
X-Gm-Gg: AYBFou21IhzUHuq0a63N/4B3RR427m4Slxwd01aLwMatCRlSgQq+HCXfeOX1njoHZlK
 kGRrBnPEvxq7wJI2DIcXca0kCxYuJeuUKThSzKrm+dDFwQ4Am/FaZzwPDsUHt7LrTt8Zj+TWAK6
 bd2fabdH2M9XznN1yHv9jHnzrjkdmuAMAmNV9ZYMT9jN29KmHvtlS/S+KRdhAJUvy6K5W4DHerx
 NqT/JaKglMMcRyjtsxdzhpY1U+uEQzaSRieFi0GHCrcnpo4PIhf9XTTEl1ojPurdrWYyAcktxEz
 WOp//v426clyLSskr6/AiDcxlv0zcLU4jlGPHnpPSM9YdnRae/cCy1pCs/8uWh64SLos4Y78it+
 ECnGHAU1iKJ93GBj8UKW5Hjt1QCIh7B0rw1j5w7W3i8exIxG3WerbxnIk9YuFYgvWoe5HYGnvbo
 Fe4IpVgFQnW4Iut05WY4NEc9GhY02DyZOt1Pcg4OnZ9TqpZp9ljZcYDQAXRRj0T5X2sI8gU131k
 sVM7co+VklhKEHZ4gR021xl3lGs/y57+PbsGA9xJGxJ/SvJGH/pZHlHh9Vld7zsHF2MNzbytx3i
 ublrzmA8sdT8hkOC43ZVdKSdeHXIifQue41nZCe1txkTjYPlAgYUUOYLAWhwErbYKrvV4Vo2DFx
 jcYvhax0QloZn5Dgsyd/j/OrtYG6T6rWFxDkWYVmWHUJZ
X-Received: by 2002:a05:600c:46c7:b0:49e:7a00:b9a5 with SMTP id
 5b1f17b1804b1-49fc56dbb20mr70023155e9.4.1789808120480; 
 Sat, 19 Sep 2026 01:55:20 -0700 (PDT)
Received: from localhost.localdomain (athedsl-116222.home.otenet.gr.
 [85.75.29.157]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc58ce1ddsm82736875e9.3.2026.09.19.01.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 01:55:20 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v2 09/10] hw/audio/virtio-sound: introduce
 virtio_snd_set_active()
Date: Sat, 19 Sep 2026 11:54:56 +0300
Message-ID: <20260919085510.3388454-10-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260919085510.3388454-1-manos.pitsidianakis@linaro.org>
References: <20260919085510.3388454-1-manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm2-x10.google.com
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

From: Volker Rümelin <vr_qemu@t-online.de>

Split out the function virtio_snd_pcm_set_active() from
virtio_snd_pcm_start_stop(). A later patch also needs this
new funcion. There is no functional change.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
[AM: trivial rebase changes]
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260803081159.91981-10-alexander@mihalicyn.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 7944d2b3b9..12473862d2 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -461,6 +461,21 @@ static void virtio_snd_pcm_open(VirtIOSoundPCMStream *stream)
 }
 
 /*
+ * Activate/deactivate a stream.
+ *
+ * @stream: VirtIOSoundPCMStream *stream
+ * @active: whether to activate or deactivate the stream
+ */
+static void virtio_snd_pcm_set_active(VirtIOSoundPCMStream *stream, bool active)
+{
+    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
+        audio_be_set_active_out(stream->s->audio_be, stream->voice.out, active);
+    } else {
+        audio_be_set_active_in(stream->s->audio_be, stream->voice.in, active);
+    }
+}
+
+/*
  * Close a stream and free all its resources.
  *
  * @stream: VirtIOSoundPCMStream *stream
@@ -606,11 +621,7 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
         stream->state = VIRTIO_SND_PCM_STATE_STOPPED;
     }
 
-    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
-        audio_be_set_active_out(s->audio_be, stream->voice.out, start);
-    } else {
-        audio_be_set_active_in(s->audio_be, stream->voice.in, start);
-    }
+    virtio_snd_pcm_set_active(stream, start);
 
     return cpu_to_le32(VIRTIO_SND_S_OK);
 }
-- 
γαῖα πυρί μιχθήτω


