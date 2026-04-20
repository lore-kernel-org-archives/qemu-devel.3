Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680A2EA71B0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 05:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEgqw-0004rc-7K; Mon, 20 Apr 2026 01:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wEgqu-0004qV-8l
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 01:07:20 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wEgqr-0002av-Eg
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 01:07:19 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43d77f6092eso1706840f8f.2
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2026 22:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776661632; x=1777266432; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L4L7y6C8teQb1pIcSjZXj7EqDslM7XaqTZ3gXfLwQzU=;
 b=M4Ns0dU9X1TbftFbZamnsLWv6UFZWGXKk+TcxiGkYGcKEJ4Oh5elq9ouqP+E3caGDy
 4kWWZHaz/fl00h1ahFPb5bmgdHowsaIEolMRoimWmNkbUB1wtW8RdHmNqSToVRa+Q3N4
 MvktqHUoe4SB9qRax2VP7WK1JT2A4DSD7qBHmlUoOTBMWWD+g0CLhgjhdkIEs+Z1JRyV
 XeUb3rUbCLblZAq10SOco5IWqpHwmuNoraWXB/IoiZw9gzKizmYCmJtnPhKLocbFMag4
 kxPL9UX2lPts2T6TO247NW31cXRAcAfr4EvY7e++CuiqJXf7ypIRqVD001kNr9G1d+CP
 9/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776661632; x=1777266432;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=L4L7y6C8teQb1pIcSjZXj7EqDslM7XaqTZ3gXfLwQzU=;
 b=AAEwQN1DBFaYSLZmo/NtT8XD2R//ggkRzg69d9LBdDrfZqcPlfq+6W/GKaEPrk68oy
 qqQmeE9rWHu6dSDVFgdQUT9iX65NPqO9CzliTvyksSj/1vZ6WP6gcMqc10rqoteoRPkK
 wFWdz39Etl8wEi1mrKpQl97wHLno2YHNHtO4drSqewMjJItHyaViCR2X4EZgzghnPNZF
 3944ydbhOMTikPW9vKO0UwkE6UgeyX+SKHqs1q+fjcrGCzNR6e4s8uQu9GJ4/qekTjLM
 GUl6SwrkPcRKBAGwSb6hihSdpkBaIqx0HCci6hgUzK57F1qIns627+1SKkgZF6LMsRLJ
 C3DA==
X-Gm-Message-State: AOJu0Yxs5iQhyahX4S8I++b2o42pIMD79gl/W77q4gntMnN6rTIRvTln
 d7jvRqEUE9uACRXXfCURR5yxCf9VIupeJcJ2hxnE+WYkivY6upbOWjd8/Iow53UIKhh8po9w3CV
 Ac+EOwfQ=
X-Gm-Gg: AeBDievyd1gudUw8+NUP67S8L/GlSKJ215gkvn3asEk7Iub26ktiqTKSJgs2MrneVDK
 XdQ5eHRTBuvLyYAd5bl/f9OJPQ1kqFo0/VxREQdBL+SlOxoILKTBJoENoMDB0kF1uy0xKqmlzzo
 Hv38LIKymi+ZZn/2SGvGFkm/i0ReAR84U+tMMrbOhmNV/xCi2ivtzfs6tEYHuI7MUWTvrTM7yr3
 Va/XTFBh1btVir+wljfYcGmpCYGa3gIkwwz62MiVL+yENs10M/SwZj46P+wrrlpKScG9k/RwV4j
 wokIpEFxQpOBlh+ZXHC1Znmm6AgB3zS0BysyUYfx//juy0RqigfxqkJ+hQy+tvsX43VkC6irbsi
 QsK3z6o6jtIp3lOHjn719ORXjiZPHBYnomtiXrluwLp7ipEcGBBTi8iON0+nyfs+6UgGF8ZSGwq
 W+C9KjBr8PvC8RKJCHZh+viwsgg/4YG+eM/7U/iOEbyaOkg3OALSdrYIOdmmfgesKLE47nYkB+1
 XxUFSSS4QpEiHHYqC1yLNLOMaG1j0zP2O5+HcqSuC1GiBbKUIs=
X-Received: by 2002:a05:6000:2307:b0:43b:3e40:2223 with SMTP id
 ffacd0b85a97d-43fe3dcc52cmr18293730f8f.19.1776661630925; 
 Sun, 19 Apr 2026 22:07:10 -0700 (PDT)
Received: from [127.0.1.1] (athedsl-4440559.home.otenet.gr. [79.129.177.223])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a341sm28886954f8f.24.2026.04.19.22.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 22:07:10 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 20 Apr 2026 08:07:05 +0300
Subject: [PATCH v3 1/2] virtio-snd: check rx buffer descriptor size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260420-virtio-fixups-v3-1-07aef1eff9d2@linaro.org>
References: <20260420-virtio-fixups-v3-0-07aef1eff9d2@linaro.org>
In-Reply-To: <20260420-virtio-fixups-v3-0-07aef1eff9d2@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1448;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=0XTx6kbq4YY1BBPqSAfMX1GSupccz3LwWPrnsQLDA7E=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnA1YlI4TU83V0ZtRzZFaTlpMzBhQTBESjA4RW8yCnNpcGQxcHpzenA5dDgwVnhE
 ckdKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWVXMGZBQUt
 DUkIzS2Nkd2YzNEowSkZwRC8wYzJxM2xkTlY4Q3J1VVpYWUhNd3dwNjNtREdKckdheitVdm1BUw
 pXRDZoYmpnWGtaV2FEb1RoaUZIMWpGRitFUHRlK2xJOUg2MU1WeC9OblYxaERCQzVEbko4WElrK
 zYzZ2FwQXFPCkFyVlZDbm9MbDZxTVZRbVB5dHJweHRXSk4zalNXZVh5ZjdyWjNKZFNHYVV5MU1R
 MzFBSnBvQUZyUmdleXlQMXAKMVdZZk9sVFZMMnZ0ek5xeWZkWEVOMHRQd0ppVC9GK1ZHK1lHTWR
 PZTl1NHd3VHdFbnlaVVpoT1B6OVlRZmNGSgpXcVJwanBWSk0vZlRicVRNQzBEeUZWVnhTNHBFa2
 xVRTFzM3JobDdmZGVYT2g5cWV4VVlSOCtpNys3MnhVTG9CCmY3VS9XdTgxUmVJZ0VJMzhLYnpvW
 DNadzhrQ2paRTVsTHBTczJoQjR2T3R1ZFBnQ2JDc0ZvV1VXb1FpZTRHOVYKTFN3dmZhai9Sc3NJ
 M2c1L1BtTUN5SGRaaE1rYlJ0TW02WUxOdElHNUJ1VDE1MDNwUGtGRFNKdUQwenhIUTdqSwpwNW9
 MZmtRZXVucUM0UlcybHAyMFpuVlYwZ3EyanYvUllld1dSNVAvdndBTWtRZnU0OHRYNWZoY0F4RX
 hyZ2wvClRUZklRYm0zMzJSZ0JwVWRsN2VpT0srSXdGazM3T21tRk1meXgxR3NEMzFnNkJrTk42M
 2NSQ1pGUmNocU9vNkEKaUV1clhEMVFzeTVFVHpiUGJ5WG5RQVNHSVQ1NmIvdUkyNnFxS0J6eHNH
 ZXlUdTZUdFl6Z1JmejdmbVlJOXl4KwpqRDJQWGMwUkRadzQwbkRxQlZZNWRacXl3RXFyRXB6UWI
 2aEI4eG9ONldvcG94aDh3UEFaZEErTHBweVc5NTFOCm5lVVFnQT09Cj1odmtMCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
points it out in CID 1547527 so add a check.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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


