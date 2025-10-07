Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA2FCCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Qo-0005wI-3I; Tue, 07 Oct 2025 10:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QT-0005ou-IX
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:28 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QB-0002FQ-9U
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:25 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45b4d89217aso37568095e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846322; x=1760451122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IYIv2Y309r90WUK07FBdrVlv4IYcETYLV13KmD86218=;
 b=HVehQt93Ggy0vmHVd+4RQ6WkTgeneF3sVn3fiC1MoLg7NBUxVm9Gtb0LL/hBUPSxRj
 o7hycgY6bTU9eYKjNvTdNlHPPZOj+lNOB+I7gncShcku17bNbuIfTBuIkXj/CzbopzzZ
 +VCoa6NZNFLBoTV4tMmoU6OOeNPQBwHIitQA1RfpPtK+0MXUQDuX27L22q86S4IAMbtb
 H/qPPYHcDsXPeqCQmKSe8FsYu+L5Y+S1VaF2D9Y7WCCKFvipURjscdD7sc93NNCm8zqK
 ijrkJ5uxzsb0nghAhNprD2HSGB19MoeTCEkiCDLrRDhGH6IicoBR/N1WX3SZFBGpx8/Q
 jpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846322; x=1760451122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IYIv2Y309r90WUK07FBdrVlv4IYcETYLV13KmD86218=;
 b=J5Ho7oN4VJN1dsCXDXV36xugg8Fjpie4DXQ9k4AD4magr14r0/hWwGaV7zLovS/57H
 hyvLixj5d6ELnbAf7+ua4tAiYz44exYz+7/5ggEJhQLhvi6NjutHU4M+IJi4rblyi+bP
 Wooc/BaowMgcvqPn477RG5RuYj4TrWMkcw8M7BFldvyV0PiKA66J/L0Zw7ZQ909NaQTI
 3QRWvXWfZ+SBz3PWVzz5vmFgdkrKpdUGeoOxKCvQq43tbFM0Jnjw2odVQCIlvMXw94L6
 YpaGYgKdWd5sqD7+fb8M8iL+gg/KfEX7oXAX5686LM1NQCNAS3rG01jeFydWVJFYiHMx
 NWpg==
X-Gm-Message-State: AOJu0YxK22l6pe5XFjOM4IeKHwDc2f6PEnZwYLpVz/SAfGFsT0L/YxYW
 KW5aGQf2YxcNnd8OljwsWqg93KvoQ+VsACIoEsjmY2GzYHUwDADtZVvGdF2KJCWouZ9Sfp9AEMU
 embbB
X-Gm-Gg: ASbGncsr0+YC2hxPnKW6ywhn6Rp1OaKOxfeeOBTdP63wfxiMY0c6maab5RpwO2upObB
 tgBFpA3qlspRljcs8jNdD7dmtehVxYszhiP8G/Fmk6GqNVLiiDTGyTsbybove+C0z14TEJ0P9mu
 5xJsf50X9rEiocrtDk36cf2jjnCbwGwOCm7wLesZ1Nks9rjbNh2e3hsy8pupYQ7eTrSSAw8PPZA
 34f/6AQCslVYM4AlSVrdX8kOSd62M3nyUigkasdXLu+XxStyaWpGnW53wXErf1usokxJcEsX4WJ
 keXmD/K6Oi6uCJMDKjTfhsmmgMd/QP8by1gjupaE+mhI6WsFNU+n6z/P3xwAwmKebOAtYHYwYXR
 si4G1barRsmxeZdeBrJMsUTfV8I9lJ/Tb/Ha1rDRvOcD9IM1fcmEAJZdG
X-Google-Smtp-Source: AGHT+IGvMPsVQ5+tRpOQ7p8mnJ7KxPRkhhGjMrLK5ymrl9rPZjG1+M+e1BVCK1ci1wpL44MdxelA+Q==
X-Received: by 2002:a05:600c:a319:b0:46e:74cc:42b8 with SMTP id
 5b1f17b1804b1-46e74cc4609mr86514565e9.17.1759846321876; 
 Tue, 07 Oct 2025 07:12:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.12.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:12:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/62] hw/arm/xlnx-versal: reconnect the CRL to the other
 devices
Date: Tue,  7 Oct 2025 15:10:54 +0100
Message-ID: <20251007141123.3239867-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Luc Michel <luc.michel@amd.com>

The CRL connects to various devices through link properties to be able
to reset them. The connections were dropped during the SoC refactoring.
Reintroduce them now.

Rely on the QOM tree to retrieve the devices to connect. The component
parts of the device names are chosen to match the properties on the CRL.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-34-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-versal.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 2e28b807d71..6604e24a9cd 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -1476,17 +1476,46 @@ static void versal_create_cfu(Versal *s, const struct VersalCfuMap *map)
                                 sysbus_mmio_get_region(sbd, 0));
 }
 
+static inline void crl_connect_dev(Object *crl, Object *dev)
+{
+    const char *prop = object_get_canonical_path_component(dev);
+
+    /* The component part of the device path matches the CRL property name */
+    object_property_set_link(crl, prop, dev, &error_abort);
+}
+
+static inline void crl_connect_dev_by_name(Versal *s, Object *crl,
+                                           const char *name, size_t num)
+{
+    size_t i;
+
+    for (i = 0; i < num; i++) {
+        Object *dev = versal_get_child_idx(s, name, i);
+
+        crl_connect_dev(crl, dev);
+    }
+}
+
 static inline void versal_create_crl(Versal *s)
 {
     const VersalMap *map;
     const char *crl_class;
     DeviceState *dev;
+    Object *obj;
 
     map = versal_get_map(s);
 
     crl_class = TYPE_XLNX_VERSAL_CRL;
     dev = qdev_new(crl_class);
-    object_property_add_child(OBJECT(s), "crl", OBJECT(dev));
+    obj = OBJECT(dev);
+    object_property_add_child(OBJECT(s), "crl", obj);
+
+    crl_connect_dev_by_name(s, obj, "rpu-cluster/rpu",
+                            map->rpu.num_cluster * map->rpu.num_core);
+    crl_connect_dev_by_name(s, obj, map->zdma[0].name, map->zdma[0].num_chan);
+    crl_connect_dev_by_name(s, obj, "uart", map->num_uart);
+    crl_connect_dev_by_name(s, obj, "gem", map->num_gem);
+    crl_connect_dev_by_name(s, obj, "usb", map->num_usb);
 
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_abort);
 
-- 
2.43.0


