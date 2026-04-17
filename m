Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F59F8E4A5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 05:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDbTI-0006rk-Vj; Fri, 17 Apr 2026 01:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wDbTB-0006qO-Vm
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 01:10:22 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wDbT8-0002Ns-UN
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 01:10:21 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43d03db7f87so124835f8f.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 22:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776402617; x=1777007417; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=30dDtFtVzrZ0rFH7FQtblfDTpXIqR78+UUjDSh4LLvs=;
 b=zjxpQP54fyG+fqLFMc8ZEnjy4smYssAeAcXQBFnj/JAoF3lFA1FtT5okDkqGEvnozC
 XZFC5wzJc+hiFLo7khPEO33wJ0gQ1ZIfpY9HTJQUpFoJgTcYa3a4n2rBKnb3SDex5FYV
 o4WfAz+s7yBIUKeJ/k+DJAUaQSKn0mGjsjQcVFKSXphcHtJqsWjbRSGfqpoeI448Die2
 dhu7qU7jB5nc4n4/qnmFpN0W9jPzy6t7kNR8CU1iBUsp9qB0ALR42CDMADCcl7eEQeAA
 vCgx9lVdWQzRSSSBiB7I9Sl3P9gDCCIxih+YcvmafJ5MOSWhfNIJso5eeXN38Ubu+aat
 Hluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776402617; x=1777007417;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=30dDtFtVzrZ0rFH7FQtblfDTpXIqR78+UUjDSh4LLvs=;
 b=GMx6ULIw7AvLv0pb8Vskj/zpkOhY6PZUW9PVVItTjKcyfPkbzS8XaAjfTDWTKFiE0U
 WdpkP6ZczOeWtH3XDfUv6uHoE/UvfRJW4GXjP7RrFrfqwKoC2W71AEL4Qkqm+ooFdKDa
 YdmnEtbQdUTypzXSNg5Uuadb+DnAXmiNQe3C6ODcOvoX6Zlmsdwk4IqyBv8u62YimXdm
 rnrrO2jeqOFpSMqQzttJo1IsPSFfJogat7dBRuDbYKjIJaYWNp1Qy6No28W44HebbXrC
 p4ixHz0lHqHlGaHi9igRM7FNdQR6q6K3Laai7jySIvXkxux8xEdQlHWrO+AMu87x4Jxl
 CUfg==
X-Gm-Message-State: AOJu0Yx+Zp3pm6geUF+56PT6oyk08Hs7asTRURr9EJdhEl53ECbIcX3W
 5lk2ugQ5TE2Hr6nSDhRNZB9ivwHwUtylYJxM7hjAVRxS91qTmhOB0yy1mMfQQ11WdDH7/6W4Xuc
 P9xZEFcQ=
X-Gm-Gg: AeBDieuEWS2Z1ZYFFp8JBzRrrMcs6Yyn0gpYH6L+tGB+q1uBrbPJ1C43p6wfl/zyE6h
 FjQVcoDGn8IJmJ5mgqWg2Gwk7jZyTRw6GSfs6tvlizn9jw8pK2rUeHRAh2K632E0+KzZV1YbKSx
 S8tClGmomMsYfX3EIwgpGctnTLfbCMTViuG3A95thVgO7c/wxdpq1dQps7VRbDhcPAx5PYq0vdG
 6VLA7BammuIltwFhGVwSmSnQbacEEObkIPdqRov2xL0aN2D1iQDNdnRCECkW9p2S8SqjFsw8dru
 rtDUXDNVoS4RUOgcB0U1Ui+qoNeYWnj+pky40wAOIXO4Tuy+6djefIAkUjidfKQxCSobQltWYUZ
 EZF83nV7y/ZryGKgPVw9L6bMNrqs2XEnFU+e/Ra8ZgLnrnDuWf/KCd+cixWfwUY6biEZQa70sa9
 T8gAq6a2sn3acJB+YnSU3k0QOy9lgMSQgIT2nVT0zdwqDlzr9kdV0BUjrqxZNEWILeCEtJNYS1+
 8KMgj7X7pRLjUhG8nSLqzlCngDtcUvLa72jGYV8Mjp0V9tDS+E=
X-Received: by 2002:a05:6000:24c8:b0:43d:70b3:7edf with SMTP id
 ffacd0b85a97d-43fe3dc5386mr1776620f8f.12.1776402616764; 
 Thu, 16 Apr 2026 22:10:16 -0700 (PDT)
Received: from [127.0.1.1] (athedsl-4440559.home.otenet.gr. [79.129.177.223])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a18csm1749524f8f.20.2026.04.16.22.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 22:10:16 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 17 Apr 2026 08:10:09 +0300
Subject: [PATCH v2 1/2] virtio-snd: check rx buffer descriptor size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-virtio-fixups-v2-1-4a0d8636a628@linaro.org>
References: <20260417-virtio-fixups-v2-0-4a0d8636a628@linaro.org>
In-Reply-To: <20260417-virtio-fixups-v2-0-4a0d8636a628@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1381;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=e7CNu6bOPefkB4cYwLokIAQo8SEItIOzfhxsnDPZRv4=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnA0Y0MyUWpGM2pKNTNSNmdueVNhdnZXSTNhVzU0CkVpODhiRXo4Vi9VNnN6eVQ1
 NnFKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWVIQXRnQUt
 DUkIzS2Nkd2YzNEowQnh0RC85WFBuZVdQVEtKOGRPTUduRTlsNEFLWUllUTFVS2xYOHJxNDJxWQ
 pTKzVaaUFFNUgxNnJtZTUzT0tMc0NqMnhRRFB2R2VwY1FGSXBJazhZYXF4SmI2c043YTJmRFQrS
 VdHNXIzUEVUCmUrVUQ3QXExUmxQSWl6Q1cwbVZBaXF1QVB3SUthSmNSU2E1cVNTY0ZPRk9sb2Q4
 QTE4Z1dHb2hlckR2QjVuUzYKYmh4eXRWcjZ2eWFzTC8yUjVsK0Qzbjl6YUFOcU85NjdLcG5oOWh
 wNnlNU0NXVUJ4QU1TM2Y4WFM2T3FKQTZQRQpDazlFeFZjYnczV3dscW8wU2U0d3pWRFEyd3JkOW
 JEczRxM3h3cFJZRTE1dmdmcFZIUFZjc0x6VzVJU3gzbTU0CkR1SS9jZjBoQVZSNi9Dd1h3WUNTL
 051MGE5R09oNFN2djFLeVdFNTQ2eVlSZHVvZnJ6Wms5WVJxM3pFSHhjNkcKTVVpd3psanZEdlN1
 NjhoVmUxNko2S0lJaG53bEpjZkI5NW56RlR3THYrQVp5TjJScE9KNGU5aFNYL0NCdzl5bApjM3p
 xa0w5VEJ2SC94SDIvUkFweG5rNHR1Q3MxeVVxS2dFV290cmdjRzZVUUlBS05NcmVnT0RJR3ZIMX
 RZZTFSCjBBSUtIWi9VZ0oyQUFNNzNoeWFxRGFoeXdxKzJFOE4yTWMvUHFwZjJVUnB1OVNWV2dLN
 2ZuYXJHN2l1NytYdFoKT3lpZkJGQ09zY0RHVmpmalozS2cyZkM2U1RySHZEekQ1c2NvOHBBQzlD
 bWFZRDZmeXFGamk0Y0pGYkJCa0tqdApyVjlaL2tiUzcxRVNzWEF6V2pXQlNnSFJrS2JsMnl3Nm9
 6WHlQNFdFU1JpMWl6d1U4b2xFMTZyKzJrSjBMQXlpCml6VkF3UT09Cj1yNkVaCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42e.google.com
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

It must be at least sizeof(virtio_snd_pcm_status).

I haven't verified if it's possible to get an underflow, but coverity
points it out so add a check.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index fb5cff386606d03e5cfce88f79e404e510bbcde7..93fbcfb43f7fdcfd5c164b496015da743822f5eb 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -970,12 +970,14 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
         }
 
         stream = vsnd->pcm.streams[stream_id];
-        if (stream == NULL || stream->info.direction != VIRTIO_SND_D_INPUT) {
+        size = iov_size(elem->in_sg, elem->in_num);
+        if (stream == NULL
+            || stream->info.direction != VIRTIO_SND_D_INPUT
+            || size < sizeof(virtio_snd_pcm_status)) {
             goto rx_err;
         }
+        size -= sizeof(virtio_snd_pcm_status);
         WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-            size = iov_size(elem->in_sg, elem->in_num) -
-                sizeof(virtio_snd_pcm_status);
             buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
             buffer->elem = elem;
             buffer->vq = vq;

-- 
2.47.3


