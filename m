Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F97CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 05:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruQeB-0003bg-BV; Wed, 10 Apr 2024 01:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruQe9-0003bX-S0
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 01:37:21 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruQe8-0008Gk-4J
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 01:37:21 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a51d05c50b2so387028566b.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 22:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712727435; x=1713332235; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lSrMZkwIweBcmheInohcAPU95k3T864698IRAu4QHPo=;
 b=iD1FU7WUtzVF2XXnvQzP4GxbMsZO8MmMoE6l6m/JjSkrY56zJvJitCO516E3oCDgul
 rGPWgyaW0najVubsdWAp24ez47w1dsDIOYqxgl/cX4v6VmXE3+4FU9aUYqU26f78pU1h
 HnqHyL8A4T7aQTntBXdZiZF0C5Io4eVS3bzC12mEtESw+M3f4YAOF9HaycyYBSosTzWP
 AmgxZrLtLuRseKncyTiGmwyrK9b8WVng/5WKI0QmZ8GTleBCuLWk8fPL3WlhM4x3xBA5
 iY/OAs4VzUSHxPmA9jtdKMRIphW1/fIsVSM0TBxlwcIDFhjOBumoZlWFiyvUpLR5Pvdi
 MZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712727435; x=1713332235;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lSrMZkwIweBcmheInohcAPU95k3T864698IRAu4QHPo=;
 b=Nr22V0fbNmEIBQNoc6xSX6bPDjQq8Q0Lhjin0t/3y1ETB+ff6KX81ioQYnCWaryqZb
 NewaAjF6EkR6upcXfP9IRFOqoHIENI4STTpvJhigNEv8/G3+s4ONmrd2jQfWetD+uE2s
 aBp5kWXmrltxRsbjRag9Bd61ax28ix6ZWuhQATmb8b5ns0N6KJh8vVViOjb+f9mJ9eJR
 ttBnjrnd8+cn/XYNtkH+52m/6+te9dAGVvlYWtV+WkfLv2rF3TviVgYxCnNmLEr2ysda
 IIKVCxyWfBUAhgT4DMvGc4zt/iMd9W1u8N0G1tTPdIR7sEu3Ifs2BhySBJMaWKjdM18t
 PVdQ==
X-Gm-Message-State: AOJu0YwVYuXMNFqs2X3XDcevCjxqQWxqRMHYGx6hgqpYJ/4N9K4xspTK
 pw5mTR400VQzobzitM/6OnaHhAWzZ8zJe1VGQHokro8BLy4oh5l5lI8T/ygoROHlP1HDHB9pjG7
 g
X-Google-Smtp-Source: AGHT+IEpuUNesqKpV1GWxybi4Ydn/65/YRZKVqPfx0wZbjJyD8FhLzQs1er+3JpjJP3rn965kMtc4A==
X-Received: by 2002:a17:907:25ca:b0:a51:cb1b:618b with SMTP id
 ae10-20020a17090725ca00b00a51cb1b618bmr1114580ejc.11.1712727435567; 
 Tue, 09 Apr 2024 22:37:15 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 q19-20020a1709060f9300b00a51983e6190sm6468265ejj.205.2024.04.09.22.37.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Apr 2024 22:37:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/audio/virtio-snd: Remove unused assignment
Date: Wed, 10 Apr 2024 07:37:12 +0200
Message-ID: <20240410053712.34747-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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


