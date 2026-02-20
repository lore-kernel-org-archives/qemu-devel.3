Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C10C55175
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 09:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtN11-0007xQ-Eg; Fri, 20 Feb 2026 04:41:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vtN0T-0007ib-9R
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 04:41:10 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vtN0R-0006Mh-JW
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 04:41:05 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43626796202so1699833f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 01:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771580462; x=1772185262; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B0IRzPWtqyZ5uN2/UAwNr0qfK9GFEvq8f/l9vnG82Uc=;
 b=BWTGRSqA0FdMKoKEpRx9xgldnH2JEotJx1NnNwBrvQLiHsi/nGLOlWO6ap/HSoqkWf
 AYTDzX8npXtMtMY0kc3QRMo1bfOfa2sIwEwQ0DamJYrpAv84sjQ+LLj+xTeusX4C7qaY
 kxvz0D/M+/mbcU1M/t1sD4WPXdX0SPqOIdhUq9QG8+vX0ykrLg6e2FhvmNDJxw82cXm5
 My1PN8yKU3fIGwwskHrRPESfWsnDWubUANWJCHB61lt3Kc+pKaHwIGuDkAQaN4xAK1i4
 L2p/5cIXPCV9P5kTY4+wChdJdoXv8f/I88nr5Kx6vtDbDrT3fQBoqxzu/Zy93DJMfagi
 NX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771580462; x=1772185262;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=B0IRzPWtqyZ5uN2/UAwNr0qfK9GFEvq8f/l9vnG82Uc=;
 b=LJbHJ5bmyildra457cOAfmiBBmRMEowDwHGG2N/ToCpHukl3hEQkgeafkNzeTXMA1+
 vtBmY3TEYa1oAXLwdmcyNXXn3rprAe5Erh1LvrrcL+8lvd/JLUYyq7Sl6dSty1ROzO+F
 yiJy0dQR1EJgmblxrNsJ1BwLAA/iyho07D8XQQqN7olO8ZFdefjI3bkDI8bp5ciJKbQd
 eq0qEnkLUQbUAoPmtj5k+054lR6wAiS7QhFduwmLA+OAwIejRgttpyPNND55yjEPirDg
 b+VqMomY9Z64Vi/Z9gBbnbhjKiKpSZpS5MeZpQ0VicbdZ7w34JFFOa7SjCCaFYJEouSY
 POjQ==
X-Gm-Message-State: AOJu0YxmHuZfeqKtXSGxzpToeN6JLSsi7YgFa0iv0uyYIn5kzl7F6YiI
 D9ZvJjy/VSLvB+3myo4bxzzBoe4BPUMk5d3DujXfxnd6aXf8mJzpVNF3aLlrfsLof2w2zFJhR9j
 inmNgNqc=
X-Gm-Gg: AZuq6aKR62RNwXQWp7he1kHgxGuwGkPUOomVms+DXzU1IuPEghfMlkWJpxWKlm2cVEl
 WsK6UGOXIv9nNnWnOUnmkr5rocfUanI6tCXi6bb0psqIpK/4SCItj/10YFMGZtnDPDxlNtzq3uJ
 /3l+RSwc/jERbmP993EgyjqjoQXgqf9shz6mY6z4BJtSmtKJzCceDV6rdi3M5kPhZv1tNKdfP6c
 iGQ2YdmzVWUSms856tDnoKwtal/Fe86WgakE/QDtnHQGsuKnlbBT6LzMrlzdnb9jgo9JMtUufQL
 ZvGtFTDL7Sz3jG18mUghmI6d+gb+oX8P5wO89T63YQbnJqn5jEGdLgl0nNKrUp+4rnztX2sVBWu
 1OUDeDwgMUURnR5uJQ6InsGlmOHw5NNNhGMBfTys9Czu0gKKh0C0mXmTCdTHbOM7YMqPMRxHNvh
 xXzjLnsu/D5a3mn8JbZQCHHmlSnHrgeQD66XHyUI5tQ38qh5I2LZSHsbawhXS0n79rPdgL+GpsY
 u0bz1vb64wTfDDbPPhOqBWxpCSZ7XW0ZahWw8U=
X-Received: by 2002:a05:6000:2082:b0:436:34e8:e665 with SMTP id
 ffacd0b85a97d-43958e58cecmr15566146f8f.54.1771580461927; 
 Fri, 20 Feb 2026 01:41:01 -0800 (PST)
Received: from [127.0.1.1] (ppp-2-86-215-248.home.otenet.gr. [2.86.215.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5ac87sm58432818f8f.3.2026.02.20.01.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 01:41:01 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 20 Feb 2026 11:40:16 +0200
Subject: [PATCH 5/5] virtio-snd: tighten read amount in in_cb
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-virtio-snd-series-v1-5-207c4f7200a2@linaro.org>
References: <20260220-virtio-snd-series-v1-0-207c4f7200a2@linaro.org>
In-Reply-To: <20260220-virtio-snd-series-v1-0-207c4f7200a2@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 qemu-stable@nongnu.org, DARKNAVY <vr@darknavy.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1916;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=jSodi3U0ox5YuVVKKenaXqxN7t7IHGzYBhq5vHJQvs8=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnBtQ3duWVoxMWRoSnNtSGhRRENJV2R6VFAzZG92Ck9BdUJSbEtaOUtCdkFTeGdF
 YkdKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYVpnc0p3QUt
 DUkIzS2Nkd2YzNEowS0IxRC85QnFWS08rdURvSXNDWWNTbUhJRDdaR1RWM0FvVjNTT0FoU01MWA
 pRZm4yYXIzTHBVNUtJRVRzOFlmTWhmRkljQmFVWG05N2ZLRytpQ1ZqaGk3eTVyUWt6RXg4cG9aU
 y84d2xqdEt6CnNNZDk2bkROdlUrQkR4QTVURjdPZS8vK25EQStUbWNmUVJMcUlTS1U3Z21ma3lM
 YmpBcjkxZXJqZ0ZlNmFIVEYKT2laRk9vMjc4QzVhc08vKzFCUlNnaHBkeUpTemxpZzIxd2dEcm5
 xeGViMmlqeEhmNU12NkRtV0dXaDVHU3ZpeQpBWnRIUmJwSHJFZVU2REYxekNhanhwdGNFRERMMH
 phNkdXZ0RPd09FaFA2ZzZlcEJYMkdPeVZxYzY5TmdVV1d1CmYrQ0NBRU5wNFlNMHVMOEhhTWszc
 m5uYi9NajBIbGpqL0s4KzA0RnRmYUYvWWx2MnVJSXNXdTQvSk9QVlFzT00KYklJR01FZzRLWkdu
 MUp0YmhjSUlnK3loQ1BpTmgyZHRpZkVaSEVFS0w5aGNHSlpHQnZIbTlLeEVoMXorYnluZwpBR2R
 zM2g2WElrSFVOWDdqL05QRmtMZ3VjTE9qcGJzc2hXMzNXaXlqQitla09nYkZNRG9nSHAvUkIzQ1
 ZkdDZZCmVpNjdqbTdIeW53RVBIakxieTdiczErbytIZXZLY2lJeGFuUDdYQ0tXZXRpQWlQMm1GQ
 WRPejZpSUxTU0xybjEKSDloUmJHS1gySWkzaVRKbVV1NzVERVpkeDFMeVRnYVZIMkZqc2x1bUFa
 aGFzL1VPejdONlcydVNYSFlhNHBFSgo0SFZ4WjBKRzh1cDdHbDR3MWxWODRtMkhCajRtWTdxUTV
 2Z1FGLzc2VXMwSnpFRStLbHB0TDgvT05uYTBteXI0CmQzUVYyQT09Cj1BNCtUCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42a.google.com
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

The amount of bytes to read passed to AUD_read() should never surpass
the maximum available buffer length. Tighten the current amount by
MIN(<amount>, max_size - <existing size>).

Cc: qemu-stable@nongnu.org
Fixes: 98e77e3dd8dd6e7aa9a7dffa60f49c8c8a49d4e3 ("virtio-snd: add max size bounds check in input cb")
Reported-by: DARKNAVY <vr@darknavy.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 3437211f7904ac77265d8ace8c1a5a582c0be96d..fc0781ae9a3564f547e0295a95d8f71fb5426aa9 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -1240,7 +1240,7 @@ static void virtio_snd_pcm_in_cb(void *data, int available)
 {
     VirtIOSoundPCMStream *stream = data;
     VirtIOSoundPCMBuffer *buffer;
-    size_t size, max_size;
+    size_t size, max_size, to_read;
 
     WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
         while (!QSIMPLEQ_EMPTY(&stream->queue)) {
@@ -1266,10 +1266,12 @@ static void virtio_snd_pcm_in_cb(void *data, int available)
                     return_rx_buffer(stream, buffer);
                     break;
                 }
+                to_read = stream->params.period_bytes - buffer->size;
+                to_read = MIN(to_read, available);
+                to_read = MIN(to_read, max_size - buffer->size);
                 size = AUD_read(stream->voice.in,
-                        buffer->data + buffer->size,
-                        MIN(available, (stream->params.period_bytes -
-                                        buffer->size)));
+                                buffer->data + buffer->size,
+                                to_read);
                 if (!size) {
                     available = 0;
                     break;

-- 
2.47.3


