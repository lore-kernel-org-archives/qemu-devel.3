Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F1FC48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvb1-0000K9-M9; Fri, 02 Feb 2024 10:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvb0-0000In-1a
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:50 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvax-0004TM-GZ
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:49 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5111c7d40deso3554666e87.1
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706888206; x=1707493006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DiMJCghid+PXdwMM48VSgNrU6KzfMReU7rheuaNV3y8=;
 b=GgFwwRK4vK/0V6dYjk9e+AmAJDO0pVyd4jTl5a+e6Oxe30rRnouuYXHSiknCoeA3bL
 wLLmFTO2LCDKHuyFpdj3H33cesOd229n5un0N2WR5ie2WEAdHKL7L+rJE6ApvI174MFM
 +2hbEy2C1Ch20KpNI5jkOSUEUI8bxehHD3WdnoUiTGEswm7It+8E3ONShrjCh/AW2G6B
 xBL0khEcO6G11f6/mnzWmUFBL5GlJV8thOOOzlz8p/OIsTIM1YhKEdOgZexJ5Znkgohs
 LRiMnGL2QBQV92qCwT5DB4vkhpdBdwpEpeX+IflJJEZy4ujI8ck23KwxrCqVNN5B8wf6
 nL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706888206; x=1707493006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DiMJCghid+PXdwMM48VSgNrU6KzfMReU7rheuaNV3y8=;
 b=RqmtLkiCnXLM0sk7IGpkI88+7C1HZMrHCapE+N8v8+bXBvwhYLa47X553tLPGslf/C
 oRZT0SegO+z2NdI+3n6m0QxzqCcwzkM+TJ0P5RS07s2MHzen1CicurpAggwYGib9K8BE
 xwS7YRBrU8bAkV/5NjpiTabc2VgQUdyL2hhSH0veE05Gba3sB+xzm8wApwlzr9+9Nesj
 biGnwWaddoh/47YKzHYESTImJBvO+heORkLx2zOwfCy2FGc33scFmCNiNzNedKMnZiCM
 AvnL6d9WISny+6s8/AjTgLxT3Ko+4hbfvVRL3FlDDoQejmej08rW51XcqwbgU1MvGjSy
 36oQ==
X-Gm-Message-State: AOJu0YwpliZGiAnFawHEni6b1vEuv6YUCGO/TB7qxsCom1zxqAgAlvt6
 7chrScsZkWQ1k5wQbu97eOz8n5s9YuCh9TetoxrWH+Aw20ihLn6Gk8uWb0hn+rQE2xSKhiqNrDY
 x
X-Google-Smtp-Source: AGHT+IEJLvLEgcsA4pX5nprkPbHNUOcG/7sAh77PIQPa73Gon1EY3vvzaQyJwZMBKb+mCIa8A/eQtw==
X-Received: by 2002:a05:6512:3e05:b0:511:33d4:c99a with SMTP id
 i5-20020a0565123e0500b0051133d4c99amr2115502lfv.61.1706888205883; 
 Fri, 02 Feb 2024 07:36:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c1c8200b0040fafd84095sm214735wms.41.2024.02.02.07.36.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:36:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/36] hw/arm/highbank: Add missing QOM parent for CPU cores
Date: Fri,  2 Feb 2024 15:36:16 +0000
Message-Id: <20240202153637.3710444-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202153637.3710444-1-peter.maydell@linaro.org>
References: <20240202153637.3710444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

QDev objects created with qdev_new() need to manually add
their parent relationship with object_property_add_child().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Message-id: 20240129151828.59544-4-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/highbank.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index e6e27d69af5..b8d702c82cc 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -209,6 +209,7 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
         cpuobj = object_new(machine->cpu_type);
         cpu = ARM_CPU(cpuobj);
 
+        object_property_add_child(OBJECT(machine), "cpu[*]", cpuobj);
         object_property_set_int(cpuobj, "psci-conduit", QEMU_PSCI_CONDUIT_SMC,
                                 &error_abort);
 
-- 
2.34.1


