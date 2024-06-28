Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55247C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5kY-0001NQ-AJ; Fri, 28 Jun 2024 03:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5kV-0001GJ-9B
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:10:23 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5kT-0004nn-Gh
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:10:22 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-424ad991c1cso3249135e9.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558619; x=1720163419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ioHSbst/hdtxzaxEjer3G8zRk1miiDF0UJMnrrURsps=;
 b=d9dKS1RO+hn2g7Lc+xoRmtdilEh+L+oWbUWUtCkyhTLek/TxvB2Q0eLk8ulXBjoVBC
 C1yjV/UQQ50BlAD3BfCZuLf3KJAiFrzaOtWAYCWAAlVz5LiVmiRcDLQl4+62I/0HR7iT
 co/TqO4MKy5MnfMBGnPCFZ/CmeKHa6imbe6MCvNaoPTwJtT5T9CGNNacxNmYQ1Qds/E0
 XwwHUWhpP2WrTtJlcBoXkY7ILilihIA92+s1u43P5sNMVDPpJCeh/+S7/tfjYHTdZ9nI
 pR6Nu0ts3U5sHXT2rzHXEweiJED2vpNGmLlcWaQVGlZYCJfco6U4ZhL4+SbnSne1BL1T
 ACxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558619; x=1720163419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ioHSbst/hdtxzaxEjer3G8zRk1miiDF0UJMnrrURsps=;
 b=mHPVT6L2cIx+quioNwqm1Er+XDNOSySmH8R1nYYlxCou46PZrY882iuzZAAogTyuWt
 HZRgEr7/5p6WeFZAJWwGPLWcP9vnBzLiP9Qw2T0lREh4I139M3JTFYfZLp8IOjTyd9Am
 I9o/XWy2Dpgja/s7yg7zqG2Gv1ELfq+9Y6kp05brR4jkUNf4gyzRlHP7xa8qpZKH5Edr
 q9uHKjw145eqfaZazKV+FLDrNj3fiyb1HE/AgN2QDklZCR84Rz2UCbL5GVkIcWDSNi+H
 ogbNdmUMoY2PCMhCiGRxUbSb2u12h1p3Zc+LuQJlw3x7o4uIvA7xM0eimZGpMGIRp+6D
 YiNQ==
X-Gm-Message-State: AOJu0Yx+6wnaQCV6frXxIE006p68YX0TTx3TeNZdiIsOyJsl8IKu8aoP
 wyxbJoSkE/FudqH9dEqOL3+BdO/qZrsiOHDs30HGKLYHVseb6+Rtv8h5wRGdE56tcg+cKsPuI9F
 ukPA=
X-Google-Smtp-Source: AGHT+IF7d1fdkTTvWd7f2NqILgHot3l9UtREiQOVhc1RdEsuh4VizMSJsGzR/HQCU8TQvjBE2GsJtw==
X-Received: by 2002:a05:600c:4f07:b0:421:dd8c:35a3 with SMTP id
 5b1f17b1804b1-4248cc586d0mr133713535e9.26.1719558619753; 
 Fri, 28 Jun 2024 00:10:19 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a103d62sm1328689f8f.105.2024.06.28.00.10.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:10:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 82/98] hw/sd/sdcard: Basis for eMMC support
Date: Fri, 28 Jun 2024 09:01:58 +0200
Message-ID: <20240628070216.92609-83-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sd.h |  3 +++
 hw/sd/sd.c         | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 0d6d9e452b..d35a839f5e 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -96,6 +96,9 @@ OBJECT_DECLARE_TYPE(SDState, SDCardClass, SD_CARD)
 #define TYPE_SD_CARD_SPI "sd-card-spi"
 DECLARE_INSTANCE_CHECKER(SDState, SD_CARD_SPI, TYPE_SD_CARD_SPI)
 
+#define TYPE_EMMC "emmc"
+DECLARE_INSTANCE_CHECKER(SDState, EMMC, TYPE_EMMC)
+
 struct SDCardClass {
     /*< private >*/
     DeviceClass parent_class;
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 92ac57a648..249fad0468 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2379,6 +2379,13 @@ static const SDProto sd_proto_sd = {
     },
 };
 
+static const SDProto sd_proto_emmc = {
+    /* Only v4.5 is supported */
+    .name = "eMMC",
+    .cmd = {
+    },
+};
+
 static void sd_instance_init(Object *obj)
 {
     SDState *sd = SD_CARD(obj);
@@ -2504,6 +2511,28 @@ static void sd_spi_class_init(ObjectClass *klass, void *data)
     sc->proto = &sd_proto_spi;
 }
 
+static void emmc_realize(DeviceState *dev, Error **errp)
+{
+    SDState *sd = SD_CARD(dev);
+
+    if (sd->spec_version == SD_PHY_SPECv2_00_VERS) {
+        error_setg(errp, "eMMC can not use spec v2.00");
+        return;
+    }
+
+    sd_realize(dev, errp);
+}
+
+static void emmc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    SDCardClass *sc = SD_CARD_CLASS(klass);
+
+    dc->desc = "eMMC";
+    dc->realize = emmc_realize;
+    sc->proto = &sd_proto_emmc;
+}
+
 static const TypeInfo sd_types[] = {
     {
         .name           = TYPE_SD_CARD,
@@ -2519,6 +2548,11 @@ static const TypeInfo sd_types[] = {
         .parent         = TYPE_SD_CARD,
         .class_init     = sd_spi_class_init,
     },
+    {
+        .name = TYPE_EMMC,
+        .parent = TYPE_SD_CARD,
+        .class_init = emmc_class_init,
+    },
 };
 
 DEFINE_TYPES(sd_types)
-- 
2.41.0


