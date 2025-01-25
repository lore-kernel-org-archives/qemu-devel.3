Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04001C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 18:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbkfv-0008Mw-V5; Sat, 25 Jan 2025 13:14:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbkfs-0008Js-94
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 13:14:29 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbkfq-0004HR-QD
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 13:14:28 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso20961315e9.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 10:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737828865; x=1738433665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J6WqpNLLgPHFQ99I41LLhDNBlDQghx4mWgl59MS9KjI=;
 b=Vw1eS1UR/ixe6IVZ3f93cUh84KleEPEoYHy/09q+UTxHTrPu8GaqmLkTWIEzEdfcd3
 KZ1uJ3GTCgIOS93c4T4ehsPzejz7XKmhtQz44/9gehDKkRq+ymDAXjq7hDUuMCWuvtZd
 ya8oKEx4q66kVgQaDAqH6g2/LbGaP0Og+HB+XZfEuKIBpGqwbw22z17iq3d3zWuOcPwB
 QJo/LXGF2EHNHla9wZW2JvdQKaKd+rbocNaaMbvOTBOefQp2pwYB7P/1TEaFoze9sn84
 SzcvENoDWRpglxSyD45XDNIPdY3GbtbokaOcgJ9nII950Zum5w9iIGf5qiTIHPsFLZUq
 /p7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737828865; x=1738433665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J6WqpNLLgPHFQ99I41LLhDNBlDQghx4mWgl59MS9KjI=;
 b=pqgBATdfhVp4dWFAn+wOZOcbrbBXmSdMtxB+/jV3ugWhv8O9cKSv0ZzTo286VKeKGz
 BF0DrZ5S1xlwhMJLomJlUYaXcWp119Jk06ae+U632QRkj0Wuw5istnBv8EZJaeXX64TV
 w3tawkeGucrmpDFiq/4wkPIESZ4nMDrq9dfzfPRcuxoH3HJq+spQIxlGX+8NdB8md/V3
 8ZH2h4AcLsAGi6MTJLjVKhUKYW/kqadkPxEJminnEsVvNlQsMTVAPNE1ebwl/nrZFOvF
 2DoRydtRbaR5FQM8P32vciaShvviYIqlq9WLJstiN5g7Er/25+loHRLV1Pr18374pGDq
 fGaw==
X-Gm-Message-State: AOJu0YwjsC44BkW/q4gnVQdYkzWYn6Ra6a44XxJ/PGMYrmVdxn04IKJq
 TFsgg3jcaLjaQehFxeIUx2n8xXvroM/ER1mH5fZskBMVEaisgx0iK8xQcK5AuovCwSTdoeGPa4m
 IWZE=
X-Gm-Gg: ASbGncujwj8AZ3jzX715oHoyTDYlFK3xooDHYoqU9U4f402pL1uj+/KdLuKyiYjZQPq
 OPvOiAyYVwgqEGCiC4Bsc0vU4PvCGA8xF/FCIbN6ffCpXT/4mgS+Pp6pG0UMbO80cv76QeIFIL4
 4ZzegV59eN3dm/phTU9JeF7R01ySaUalTm8SvU2o1r371HKJ/NDhlWo2eGjNfZ/o70aFh4YcQUC
 YBkm2F3u6smj/wyN6LYctogBIdfaTnK8rNv/vbd9Btab8f0o2bNILyVah40Y3SclDPEAK8JDTl9
 qAV7wZwAmm2X7+iOCoJ5eTH3r82LUyft5g6Qbh8YQKpc/1RGFp/orYJZ1azT
X-Google-Smtp-Source: AGHT+IHtukcUsuBgToag1rm73vPOv6PLwBxDIv19SmO8jk0VeznszQ2sl5L6woNkrDfICXUGMJC2jg==
X-Received: by 2002:a05:600c:1f86:b0:436:faeb:2a1b with SMTP id
 5b1f17b1804b1-438913db2cfmr312879235e9.13.1737828864896; 
 Sat, 25 Jan 2025 10:14:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4d29cesm69824895e9.35.2025.01.25.10.14.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 10:14:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Anthony PERARD <anthony@xenproject.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <graf@amazon.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/9] hw/net: Have eTSEC device inherit from
 DYNAMIC_SYS_BUS_DEVICE
Date: Sat, 25 Jan 2025 19:13:41 +0100
Message-ID: <20250125181343.59151-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125181343.59151-1-philmd@linaro.org>
References: <20250125181343.59151-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Because the network eTSEC device can be optionally plugged on the
TYPE_PLATFORM_BUS_DEVICE, have it inherit TYPE_DYNAMIC_SYS_BUS_DEVICE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/fsl_etsec/etsec.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index 781b9003954..3ce4fa2662d 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -425,14 +425,12 @@ static void etsec_class_init(ObjectClass *klass, void *data)
     dc->realize = etsec_realize;
     device_class_set_legacy_reset(dc, etsec_reset);
     device_class_set_props(dc, etsec_properties);
-    /* Supported by ppce500 machine */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo etsec_types[] = {
     {
         .name          = TYPE_ETSEC_COMMON,
-        .parent        = TYPE_SYS_BUS_DEVICE,
+        .parent        = TYPE_DYNAMIC_SYS_BUS_DEVICE,
         .instance_size = sizeof(eTSEC),
         .class_init    = etsec_class_init,
         .instance_init = etsec_instance_init,
-- 
2.47.1


