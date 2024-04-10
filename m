Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CE5CD1297
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 09:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruU3Z-00088p-NW; Wed, 10 Apr 2024 05:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU36-0007CL-7a
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:15:20 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU34-0005tT-Eu
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:15:19 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a51fd94c0bfso187440066b.2
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 02:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712740515; x=1713345315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Na6FzHvKUI8XfFFB8KxCEL6XESOoupUckFCQxyDkVbo=;
 b=CMYlsvtCvDYq9A/m43Vku9lQSFzOUckJyexGmzPDAQ8FD2Y6uYCY0KIkavKxVU4Stl
 BQjpWT8S1V5NTSYIhQggKLA5eOl864AIahfcXfS2Dr4XvmYBCaxdkjnY7cNJsQtap3Qt
 2VnYXEbD7viYQJEO0B5EB/Du3oSEWYvKaAJ8zctzim68YPT/QxoSCDJKQlDQrxCDXuDx
 JsWdPB6UizHS1iOa2TMzDSjd7NeKl3uaM6tHxixtxL+syImVYDi4z0RwKbZAKYU7X9V7
 rh5KS3jibBCUIN/bD8A3h7yQxJ7dZpbdUO193zm6QRjobNpJXXqpHgefVtjLaqH9fqN3
 sB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712740515; x=1713345315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Na6FzHvKUI8XfFFB8KxCEL6XESOoupUckFCQxyDkVbo=;
 b=ma49Y2h7+0+V6OgyT4Wjl/JmsyTPsBjJRbzmDlC0vZSvHhYzt35hfXWfCNcxL9766b
 LlXFxl1yN7+D3YlyGJlRAS6nIy/AvBL5ETDKFuvHbhEQMpPfIOW0+FLKj/HQC4LVKFeX
 bdH4yixZTZVa7YOXMdTWkCApA5aJw2mEzrZQ2Ean8BwZOBnBSkLpC9+GoObvGCTe6TP2
 r/DDy4YPe2tUnmEPllv3B0KLodDuQxhZ0TQw9ANXJ3Jlw6WeKfNovR32maRwuXljMqVA
 iVqYuxIkeinOtRnHRyVWtyYq5kP94AM914Rkr2vZqCiHOy3w09sXP6pnS67Xj9PhOtAj
 u59A==
X-Gm-Message-State: AOJu0YyWRJV5Sp7OexxGv2jlVjiUb+9PEuid8PFXEKk2rEoFqFtD7x0k
 UdezXV+Ub4Ek9lbp2n2wwyFoW3TF+gW7KLN5ME84T3g95IGEtGzhzUlVUGf4e9QZXtuLNxKWTsz
 L
X-Google-Smtp-Source: AGHT+IHk1nu8hUSLKRx/Z3Dk0Mwte37YIBjOnzOZidEzFOKOcz8uDPWOFi3rZyObr56MxO1UjPzxug==
X-Received: by 2002:a17:906:e288:b0:a52:a3a:3959 with SMTP id
 gg8-20020a170906e28800b00a520a3a3959mr1044618ejb.23.1712740515544; 
 Wed, 10 Apr 2024 02:15:15 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 gc7-20020a170906c8c700b00a51a259fa60sm6663631ejb.118.2024.04.10.02.15.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 02:15:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 16/16] hw/audio/virtio-snd: Remove unused assignment
Date: Wed, 10 Apr 2024 11:13:15 +0200
Message-ID: <20240410091315.57241-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240410091315.57241-1-philmd@linaro.org>
References: <20240410091315.57241-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

Coverity reported:

  >>>     CID 1542933:  Code maintainability issues  (UNUSED_VALUE)
  >>>     CID 1542934:  Code maintainability issues  (UNUSED_VALUE)
  >>>     Assigning value "NULL" to "stream" here, but that stored
          value is overwritten before it can be used.

Simply remove the unused assignments.

Resolves: Coverity CID 1542933
Resolves: Coverity CID 1542934
Fixes: 731655f87f ("virtio-snd: rewrite invalid tx/rx message handling")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20240410053712.34747-1-philmd@linaro.org>
---
 hw/audio/virtio-snd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 90d9a2796e..c80b58bf5d 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -885,7 +885,9 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
     }
     trace_virtio_snd_handle_tx_xfer();
 
-    for (VirtIOSoundPCMStream *stream = NULL;; stream = NULL) {
+    for (;;) {
+        VirtIOSoundPCMStream *stream;
+
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
         if (!elem) {
             break;
@@ -964,7 +966,9 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
     }
     trace_virtio_snd_handle_rx_xfer();
 
-    for (VirtIOSoundPCMStream *stream = NULL;; stream = NULL) {
+    for (;;) {
+        VirtIOSoundPCMStream *stream;
+
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
         if (!elem) {
             break;
-- 
2.41.0


