Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00DFC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAg9-00076i-Ko; Mon, 29 Jun 2026 08:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfm-0006xw-04
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:10 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfk-0007VR-4j
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:09 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47362928f65so860189f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734467; x=1783339267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Kdr+B0IDw6BWJTk+TtoSalHMga33GbxHLgqk8sNq28g=;
 b=WP3V+7zqUAQ1IcDpucsD9scr36EuGlrU41TPJAtzXMxWUsEhFkD20+G6LpbskWlOIS
 VSwH/9E3/qtqBZF3h416NXTlOEe+TsAF5J3YVdBewEfWxAQyDjNzOHdBHl/vo7FioOFr
 m62RV3HkjWaBPjW0YLQtKhr2n2JIMLu41eFu/rwv8QNo/3tWoLKCOIaOYNA6GGgmUrta
 cbKRCG1z2UeW/2V3ZxvqZFmpy+MkjdW90w8yW6zhSKeFh81vrckKa20CGLH5nCCwspl3
 P+Oq7LlkDEvEnZ77ub/1+S3+tFo5r9h0Lff/6cyGxwnz++Tu4kfEZHY4+pEmexF0i+NU
 suKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734467; x=1783339267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Kdr+B0IDw6BWJTk+TtoSalHMga33GbxHLgqk8sNq28g=;
 b=Hr2fMzu5IY9yAhVjQzU2o+XKXRnkHaVG+7UEFzIT5Pcbtr1AJlRtHz36AjOLDfLhn0
 HXkgnOBVpJWcyOYh+Jur4inRRR41uXn/yFsZ+ui73TOObVvyi3EJqMIn4FiXZM+zyOUE
 F2IZR5DD8RDj63YvRQNgPOL3QTfvcC5dRirvnJfiHyGRpPzS2W99sTK1p3/yvWQDu5wN
 vqXdvl9xIA77rXnq+PS6D9U2IO0XEGvSdreCoa4BpUPMT7OpzOtmpgoFEVoVjxdxLVDw
 8XhabNt/Fqbe26qXPrq7cW6ESqpAsqIa7KhS48mWIJviU0jbP4VQ66k3G1F5+YbjORhh
 ZwLA==
X-Gm-Message-State: AOJu0YyJC9f1OZNnF1nJiJeAXEt+MWCL4eThelgE1++CS3cMfP3AOYkd
 FYb5drpzW/xq+ewbQrf408I++L3tZBr32ZQGUxa00B99RAklLsl8+O/GmZ/LHhGG/aMtaBLBRI7
 GVvJb
X-Gm-Gg: AfdE7cku3xiJ4OzA+kQr2LxFSSmVTCaPpSHStKriGG5u7ZYd3f28nYvHtrhGBGw1Ehk
 PniBhi5KCpnjElsgvP2vMh/xKDoyJqJdyOZ8r7emqnMpmETZV0EWBGDizCPeA6ZQcqfwDyggUwe
 4ggfYqM77ZVF/LlSE7jfzRq34S7RLznyXtMK360jD4cN0HPq73E9afwr/+f2V+/fmEoRE8C/9VM
 YmVTWbLn0sEsgRf3sTRu5bGmbKp7tPgevSZrvd1OQb/2asG/C0mYauAiftZWkoBecKBSMBQ+/GQ
 hNA9zZp7phtV+hmtk5MUXI/Ci+j1yw8yR4z/7pgg5fyaDUusaHSTmBChfwc38NhvYlplRPudObn
 fO0BxMTYeELRFTr1XSdN/939esHcNxLLTGBvJ/5ea6P4nqqPMOYtoqPtHEOZIxC59u354KGOjuE
 gvMPGCpFWompWBjK/Dh5250S2z8UKgdT09l7z8EyrJ5ZCoMCrQLqmJXCRRi+4CMEDLbOR4ki8Hq
 vBIZgEad5czsbcoT98iAQ==
X-Received: by 2002:a05:6000:1846:b0:46f:f12b:e44b with SMTP id
 ffacd0b85a97d-4750079f323mr193975f8f.31.1782734466185; 
 Mon, 29 Jun 2026 05:01:06 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.01.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:01:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/54] hw/arm/sabrelite: Open code DEFINE_MACHINE_ARM
Date: Mon, 29 Jun 2026 13:00:09 +0100
Message-ID: <20260629120032.1645265-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Matyáš Bobek <matyas.bobek@gmail.com>

Open code the DEFINE_MACHINE_ARM macro in preparation of creating
SabreliteMachineState class.

Signed-off-by: Matyáš Bobek <matyas.bobek@gmail.com>
Signed-off-by: Pavel Pisa <pisa@fel.cvut.cz>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Pavel Pisa <pisa@fel.cvut.cz>
Message-id: 629d00a1d8712dbf293fb13ac1a02bf80f6334ca.1782140438.git.matyas.bobek@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/sabrelite.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index db5669c5c2..04484aaa14 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -104,8 +104,10 @@ static void sabrelite_init(MachineState *machine)
     }
 }
 
-static void sabrelite_machine_init(MachineClass *mc)
+static void sabrelite_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Freescale i.MX6 Quad SABRE Lite Board (Cortex-A9)";
     mc->init = sabrelite_init;
     mc->max_cpus = FSL_IMX6_NUM_CPUS;
@@ -114,4 +116,18 @@ static void sabrelite_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_ARM("sabrelite", sabrelite_machine_init)
+static const TypeInfo sabrelite_machine_init_typeinfo = {
+    .name          = MACHINE_TYPE_NAME("sabrelite"),
+    .parent        = TYPE_MACHINE,
+    .class_init    = sabrelite_machine_class_init,
+    .instance_size = sizeof(MachineState),
+    .abstract      = false,
+    .interfaces    = arm_machine_interfaces,
+};
+
+static void sabrelite_machine_init_register_types(void)
+{
+    type_register_static(&sabrelite_machine_init_typeinfo);
+}
+
+type_init(sabrelite_machine_init_register_types)
-- 
2.43.0


