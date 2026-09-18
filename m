Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A59C88E75
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7T80-0005gm-MG; Fri, 18 Sep 2026 03:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7T7v-0005ew-9O
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 03:35:19 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7T7t-0007Ds-MC
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 03:35:18 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd38e0f79so2415325e9.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 00:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789716916; x=1790321716; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AcYTJx9E4CYdyyMY0Az5kiAEmPZKXqi/EESegL6wNG0=;
 b=ylezZytIC5Iru0Cp7OFSThT7nRUYsjBMZ7PnwjLGap3Eyp7HVB6yx3lFMVP7jc8AHR
 18XOT82pz8XSiYYzABcnaMEfKibDB5kMNCBHFSg2p2BZiw3+QagJ8Fi00yZkHQqmsB+E
 xT8Rhr73O8uU10gC2/UQ+y4o9aruOzY3fE/CRSTqqd2JIEKF2cPVhMd3k4HrxpKUt2UF
 XxhHufOLMP1w5pc7gg/nmGgPfqWbvjQ/WNcG1nAbsve0OqqLuE+1gaNx0CoWICDkBNNy
 PZInrckdFYvXLyh+jQh0JQEU8Qm1OIfyWEFx90sEXU9EsEAKh+qbEnMV/5H7j8oH/D81
 Fsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789716916; x=1790321716;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AcYTJx9E4CYdyyMY0Az5kiAEmPZKXqi/EESegL6wNG0=;
 b=NMsh+lKhg70kVqQo9J22p9nqleOtIRFD3jD8LEHZbpQu96ubL5bFGJltXc+ZzStTiC
 D97eP9Yo8kzERRtKT342/JXX0CeXjdrIQUZrha67VNyywgNeBAjxB0JpLsY7vVpqo37T
 3hHO7XnXmPC9MbGw4ZLOcNT8IBaPbWEhnIz22hOvY0ZSN/hyNvzr+WnasfTLWwU/fbJ7
 94Z4jldpmzsZWpq3W3F99EGwwMe34l0PZeFgmUcmPRQW06BUnqE5ZUjUJQ8Jet/GpKK6
 vEmFA7cYYsMYx5eFpzQtOn/jpiCLwjYkl/bzvOQxqjUXO4M88wolECIlS193PjXviLSS
 mbSQ==
X-Gm-Message-State: AFuF++n5mZm1NWFjLtE7QozbCcGZ2A4FDM3xd4zfWqLvJLLmkW6iR66l
 FHB9XKiqcXgFplh3SoIlqIjUJfh7d8f3yShjLH6gnGKLgzyuaC9qEde+ClpVhya2GHsAoHQqL7o
 MnNk99mc=
X-Gm-Gg: AYBFou0m16ulHwMVfpMJfR6Dz+DclElkBmj7vGKE/T4c+fngC8CyuyWOqGfAa6qBMki
 FWkuScsDyKrty76pDEjNouR07Hr+zqM9Zy5nLfwvi1vwWj0ETVtf4FX1yBrpl0PHfFiGRdJ1Zmc
 xmnV0/UxVgzXu95m0zMSC7bsfSTChtE9Tm6gTFTUaOyPMkK3DfwPs4V33Zzbl4iltRUL35e1yE+
 LZ4QEbhsC63wxE0R+FTbdAw3MDi12IYKsN9l9qFWkHULLd9VBrvgmQlNm6EmDB0zTiS8seE0O17
 yghbge15AvNAkey2J1L1lMP4u6XXo4DWP9286HeHhOi3mnsy1boqDO8wTMSilIRYmuMoPzwWOaP
 MBKL6BfyJdwyhGdQk15eZ7id6qlq7UsZzYb+PG621TplaR+igQ65AVfQP7pX2KQKT8OfGV4ahtQ
 65hL41Wnaj9r+x343FZ1IuIjRv5VPXEkw3WPw6TQndfmPLE4vhdbTHomTVU7pWJh5fAZp2DiRUq
 xVJybO6s7dN/JwzgQU7+XD7VGHjY6uJSYKaEqJ0sPCEINp5ZE8MD60mi3bqDFYxPXVednjoZK0k
 ROsEm0hdnIzm6+qGJ4pt0V8Zz3jmR5wHcYjNd8J/seF5yPM6s2JqE+i1iUEyKyylI2LC1f59FqL
 Qr8lN7+kAA6esli9jXI8Q370GuWOsRnFmbvbIXAw8ISP7
X-Received: by 2002:a05:600c:8709:b0:49d:870:7a69 with SMTP id
 5b1f17b1804b1-49fc573514bmr35198795e9.12.1789716916239; 
 Fri, 18 Sep 2026 00:35:16 -0700 (PDT)
Received: from localhost.localdomain (athedsl-116222.home.otenet.gr.
 [85.75.29.157]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc471b9a2sm23879825e9.0.2026.09.18.00.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 00:35:15 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 09/10] hw/audio/virtio-sound: introduce virtio_snd_set_active()
Date: Fri, 18 Sep 2026 10:34:52 +0300
Message-ID: <20260918073502.3265143-10-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918073502.3265143-1-manos.pitsidianakis@linaro.org>
References: <20260918073502.3265143-1-manos.pitsidianakis@linaro.org>
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


