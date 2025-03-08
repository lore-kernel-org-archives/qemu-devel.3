Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089D2C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr1sP-0006b6-N5; Sat, 08 Mar 2025 16:38:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr1r2-0005QV-5f
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:37:10 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr1qz-0003uC-9Z
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:37:07 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-390f5f48eafso1530200f8f.0
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741469823; x=1742074623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B/DAOjgGSbt8R5XFJfa90IfAIHW3vg/xwsnsSI4jCJ0=;
 b=RgjmaF5oNLjV3aADvkVb4Oivfd9lH385d2iELV7/mFe+rCX+/kiqo9+qlkmjtoeBc3
 1H5u0SGSTWC5FedmTaOUP+RdR3Q879Q7TATAZWU3eRJLHl231NCganIYa5E+l3wduEqW
 NZPcrpLpBZ9ARZ3zswNjA2ye8bMJB//grtbegSQ/CfzslGVjqELLimxrwD/sS2FOC2tt
 3zNKio/yoUKikjv6sXuaYZA6bEbPMM8JDTDlFk28bCQ8AnLn7bO80SdtMagtnvE6/ZZz
 766lsfzOnOb4YbkktruvCx+0I/syoIs99mXGXC5/DS52KBbykmtHG6zRy1S46lm2AcpI
 SU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741469823; x=1742074623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B/DAOjgGSbt8R5XFJfa90IfAIHW3vg/xwsnsSI4jCJ0=;
 b=TRHu8xfDGTbsXsb344aNBf2lZWL3ilNeXEq97Oaa70T2N+FTB4eNQ3xR/VpIMkfNB5
 FJfLQcisuocqbeFTqeKs6uiK3f/VTSxK5bjg3MyZiUd7yvADhLHtBjB0Kvu4f3m7vYV0
 en+zz8Hdes9/sL4Tdmuftf0Gqyxvobr71lpqyu/1KphrkIA/Xb4kjuMrsC6UDiIKSzmi
 pJwxAF/hyf9GDOv7oKjNdTGJcldTnrv2GizPPx8B5VwuQ+H3yUjIMWrR6umQJLlMDUst
 9LFE5lkRR5bqxl1bXG3t3hICOZRlugoexM9zD4/W4rKAGHLa2RfsMGCdTq78O1gXRDDh
 a45w==
X-Gm-Message-State: AOJu0YwKrNd7X6yNvvC+Qgc2bPq+SKIuNcGcMIaHwOHlpXbbbumqDD+V
 EQQX8SIvPT9JfsInR0riQztcnW2T2/93LGwyrtae5rOyn7/ktZQAL0CHPfDPvoE5rdW04RUJaH1
 DyF4=
X-Gm-Gg: ASbGncvNewJB4fDaTmsv6X0rcRi9xHfsdiIDPA/Nx+J9HxJp8M2XCxFkGsbc57w9kaP
 HPRCQqYnxOJfwQfaR26A+rAKEo9oOLAMHiJL3pAODio1KQVJoKwh1h1j8xCKGVQvxFpaAh/UsKu
 REFBUOpugCIIhO0aKldM3N9nh4yg3bZZd7wPEWFiz4AVUBqVrzQHFFUO2FZr132sIcK26c/YCpg
 rItB6290FOdjVWSTt5tpa2q8trb66pUszD0aKnE8LiHfV8nVwrRtGbaxz7Hm70SaLFa0L5p/gs/
 AXBWqzDVNpa7TBTch9hduzGPJyz3+OG+UYu6Rgrb/61zXcyNGYZmWS47zb/PmHgSCEX0fEIkfIm
 6t260rsB7xfgxa0Z9AMz0UeI1jUCVyw==
X-Google-Smtp-Source: AGHT+IHNIRlXIyqDHZtXrj4/5MhbJa6bQZXiAykfyeWnlVpK5uK9skvNveQY6R1e0SRcLHz5PaarKQ==
X-Received: by 2002:a05:6000:156b:b0:38d:e304:7478 with SMTP id
 ffacd0b85a97d-39132dc56f2mr6089276f8f.38.1741469823381; 
 Sat, 08 Mar 2025 13:37:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e4065sm10069393f8f.62.2025.03.08.13.37.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 13:37:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Guenter Roeck <linux@roeck-us.net>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org
Subject: [PATCH v4 04/14] hw/sd/sdhci: Make quirks a class property
Date: Sat,  8 Mar 2025 22:36:30 +0100
Message-ID: <20250308213640.13138-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308213640.13138-1-philmd@linaro.org>
References: <20250308213640.13138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

All TYPE_IMX_USDHC instances use the quirk:
move it to the class layer.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sdhci.h |  3 ++-
 hw/sd/sdhci.c         | 15 +++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index c4b20db3877..0616ce3aa59 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -95,7 +95,6 @@ struct SDHCIState {
 
     /* Configurable properties */
     bool pending_insert_quirk; /* Quirk for Raspberry Pi card insert int */
-    uint32_t quirks;
     uint8_t endianness;
     uint8_t sd_spec_version;
     uint8_t uhs_mode;
@@ -112,6 +111,8 @@ typedef struct SDHCIClass {
         PCIDeviceClass pci_parent_class;
         SysBusDeviceClass sbd_parent_class;
     };
+
+    uint32_t quirks;
 } SDHCIClass;
 
 /*
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 4917a9b3632..2b7eb11a14a 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -345,6 +345,8 @@ static void sdhci_send_command(SDHCIState *s)
     rlen = sdbus_do_command(&s->sdbus, &request, response);
 
     if (s->cmdreg & SDHC_CMD_RESPONSE) {
+        SDHCIClass *sc = SYSBUS_SDHCI_GET_CLASS(s);
+
         if (rlen == 4) {
             s->rspreg[0] = ldl_be_p(response);
             s->rspreg[1] = s->rspreg[2] = s->rspreg[3] = 0;
@@ -366,7 +368,7 @@ static void sdhci_send_command(SDHCIState *s)
             }
         }
 
-        if (!(s->quirks & SDHCI_QUIRK_NO_BUSY_IRQ) &&
+        if (!(sc->quirks & SDHCI_QUIRK_NO_BUSY_IRQ) &&
             (s->norintstsen & SDHC_NISEN_TRSCMP) &&
             (s->cmdreg & SDHC_CMD_RESPONSE) == SDHC_CMD_RSP_WITH_BUSY) {
             s->norintsts |= SDHC_NIS_TRSCMP;
@@ -1886,7 +1888,15 @@ static void imx_usdhc_init(Object *obj)
     SDHCIState *s = SYSBUS_SDHCI(obj);
 
     s->io_ops = &usdhc_mmio_ops;
-    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
+}
+
+static void imx_usdhc_class_init(ObjectClass *oc, void *data)
+{
+    SDHCIClass *sc = SYSBUS_SDHCI_CLASS(oc);
+
+    sc->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
+
+    sdhci_common_class_init(oc, data);
 }
 
 /* --- qdev Samsung s3c --- */
@@ -1967,6 +1977,7 @@ static const TypeInfo sdhci_types[] = {
         .name = TYPE_IMX_USDHC,
         .parent = TYPE_SYSBUS_SDHCI,
         .instance_init = imx_usdhc_init,
+        .class_init = imx_usdhc_class_init,
     },
     {
         .name = TYPE_S3C_SDHCI,
-- 
2.47.1


