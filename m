Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407BEC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5lD-0002Lf-8e; Fri, 28 Jun 2024 03:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5lA-0002Hq-5s
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:11:04 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5l8-0004rk-Es
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:11:03 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42564316479so2215605e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558661; x=1720163461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v3emiqbeR1uOJll/QBrY7vV5cW8ivGXHg4omZJGkoiU=;
 b=ObJbkQV71TS2FhfZcmI1Yk0BNETUwetZb/2L81g/Q2LKHYcaK+N0Sw8VTNwB+TxGX4
 0gUzFHRx+9Hbxro7qNjfFrExstHSZJaQBr2D0n7dPe31TC3B4RnCLBHQbp75Zj5dpt4Y
 T1SD/iRlzdRr3z+EXyVApIPzkbE6NSTqMCUgMsvgxoTn+xflxyRkAlB/jzNSV3waVW71
 /6Yp3fhEnWdh+09rxkszv8+AlKjLnsfQvh+8n2Y1G4Qfu6MQYZvTufiuUu191blWiJIk
 /f4hTU+SNwYh1XV4npezWGSS4PuKCXZWazdoaQlS56+x6bwPc7ON2A+2l4H7TF25eaN/
 dhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558661; x=1720163461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v3emiqbeR1uOJll/QBrY7vV5cW8ivGXHg4omZJGkoiU=;
 b=QDSXxsUnG68/s2HDqs4aUwb2rR5m2h/MA+AaaB1VKKDlbR5LO8u2rgDGOGsJ24n8PB
 1ks2iePQ5Zi6B97VeaNJeh2PYUSZnDQP+SpKhzGzzWC8IdUpugnZJ/Gd2TaKtvzrUHTT
 x8MrLHTVlFZrIWm6DGcvsycrqUetzi/3YUrkhCyUXQQBWZbAWni0XYV8GE91bUVlyE7t
 PB0tVAs2YJnvY/XN16XmCXYGsdBeVZ+K+svL0vr3csXbhpwbm3BONcO17edMQ3e+lDY4
 xwuKcHFAGH+qmhEIGh7xnf9uNEqPY1wn8G9O24kag4Bj1mpAp+lCV1bDEQGTItSr85Ou
 /Wtg==
X-Gm-Message-State: AOJu0YxbQufnl8CAzgmpIomRyGPzCFV4W0kSwZ00ve9CAvi9yav35xmp
 br7f5bausspQfIDbtCu00b4UMu1DtAAmGO1sX0n71md75tU+ZbtTKJMtNkbXh8cMwVQLfPdXD/o
 IcyU=
X-Google-Smtp-Source: AGHT+IGE0tFcBTo/JIau/huykcX6dT2U227kfoZc3W/S4GZDf3tnlEuXfXM1/dDRXlJF2KQkdLox5Q==
X-Received: by 2002:adf:9785:0:b0:360:74b3:260f with SMTP id
 ffacd0b85a97d-366e948fa74mr9341702f8f.21.1719558660788; 
 Fri, 28 Jun 2024 00:11:00 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd4a1sm1345327f8f.23.2024.06.28.00.10.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:11:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [RFC PATCH v42 90/98] hw/sd/sdcard: Add experimental
 'x-aspeed-emmc-kludge' property
Date: Fri, 28 Jun 2024 09:02:06 +0200
Message-ID: <20240628070216.92609-91-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

When booting U-boot/Linux on Aspeed boards via eMMC,
some commands don't behave as expected from the spec.

Add the 'x-aspeed-emmc-kludge' property to allow non
standard uses until we figure out the reasons.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index bd77853419..dc692fe1fa 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -127,6 +127,7 @@ struct SDState {
 
     uint8_t spec_version;
     BlockBackend *blk;
+    bool aspeed_emmc_kludge;
 
     const SDProto *proto;
 
@@ -2567,6 +2568,8 @@ static Property sd_properties[] = {
     DEFINE_PROP_UINT8("spec_version", SDState,
                       spec_version, SD_PHY_SPECv3_01_VERS),
     DEFINE_PROP_DRIVE("drive", SDState, blk),
+    DEFINE_PROP_BOOL("x-aspeed-emmc-kludge", SDState,
+                     aspeed_emmc_kludge, false),
     /* We do not model the chip select pin, so allow the board to select
      * whether card should be in SSI or MMC/SD mode.  It is also up to the
      * board to ensure that ssi transfers only occur when the chip select
-- 
2.41.0


