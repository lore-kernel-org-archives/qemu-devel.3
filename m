Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8BBCCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 23:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGQb7-00020n-Hu; Tue, 04 Nov 2025 18:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3SY4KaQwKCt4NABIHESTEFANGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--nabihestefan.bounces.google.com>)
 id 1vGQb1-00020H-PP
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 18:37:52 -0500
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3SY4KaQwKCt4NABIHESTEFANGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--nabihestefan.bounces.google.com>)
 id 1vGQay-0005BT-Cp
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 18:37:50 -0500
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-781253de15aso14549674b3a.2
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 15:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1762299465; x=1762904265; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=YU0uSHcPrYiF3ZdbzJ9P1EwGSlz9hc7xoEWUvhDGKI0=;
 b=whzed4/7eOicvSGAXqiwecX7RFR1Yj7oghnlu6bjFnBXR+Sxs4DIs1FG9WYOwcQNIh
 X3fXxbAs/e3NXoZpJZcFfVylP6a5at7DeJy0grhQaF7bMa+/5UEfiSGacVObfobw7GOR
 +gu2o1Hcp6iwS92P5ed3nieOHfj0G1K6SnObnJIERendmLTMK8fn7MTW81e/ImLuyh81
 MiVTV39OyxFIkC4Radp+VoWc5+LG8gqxXr7tRiBQkBM7p7+4bBKvLyzz4sHErll/CX9F
 tdmsth/8yJHdwaE4fMY+RNCpRvj/YDUjRgkUK8KLSEDa/xdLJNAfSH/mLtvTJQSgIPIY
 IKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762299465; x=1762904265;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YU0uSHcPrYiF3ZdbzJ9P1EwGSlz9hc7xoEWUvhDGKI0=;
 b=az5zxRmlpCn0NhUjCGMOEzMZ3QEvl2CWx55dS/vRuwc+NgUvCyroYqfZTUNsVZHols
 0ZmCUfAiIQMiJX0+hcOTBiqEvaZZOxMtzaNyERiSWp7jqojz3QjtY2gLotDhn5hXDnN+
 Lbe5UAuI8w2YJehjv6PlMvnhMTZGthvn9jIc2SDcfipFZO20nAUGg9+QG3ofv2Dme88I
 rc79ZrfcxIyqUVoYEmidmyNzcGyVFYyWVN0A2sYR45Mr1Nv54JL7H+/EUhK1KzS7GwhM
 upxevGZjWA1YivJppO3AiaxC//yARRpUhJ3L9L/jUFBvXxNyYUST6kdnfUTKq8MC2jiG
 W7iA==
X-Gm-Message-State: AOJu0YwZaG3aLosukZF2hKGrps3HjOfsxtDUvcZrKZkFOQVteS20kmR4
 wPJPFPTM6NJOsXwwM0RtFFWjonjBPvr/fU7k6w7+7sRm6YtiYZkMc4dFojSTvpaByQbp5fqV5zq
 83ABh3A1frwxDlm8kP90yo9HXNRFQGkruLLKxLK2uWJIl+kEOjaUOKtaMxZUokaG/I/xFW6+TQr
 wVxm9bH/4ztf2ToetZxnuVkRzKtzAQ1AP/daCCOT0kqP93EWU9ItQlWrUk0SIO5/HEEb8=
X-Google-Smtp-Source: AGHT+IFRS6jXbhIVJDOyrmhvgadCce/I3QfLB0EvF7tGNGWKSHhPhczRtLKLUw3QFLqSzq48zYVY++CpubReCWhFg/s=
X-Received: from dlbsw2.prod.google.com ([2002:a05:7022:3a82:b0:119:49ca:6bae])
 (user=nabihestefan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:338c:b0:343:70a2:bca9 with SMTP id
 adf61e73a8af0-34f863015bcmr1292965637.53.1762299465369; 
 Tue, 04 Nov 2025 15:37:45 -0800 (PST)
Date: Tue,  4 Nov 2025 23:37:42 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1006.ga50a493c49-goog
Message-ID: <20251104233742.2147367-1-nabihestefan@google.com>
Subject: [PATCH] hw/arm/ast27x0: Fix typo in LTPI address
From: Nabih Estefan <nabihestefan@google.com>
To: qemu-devel@nongnu.org
Cc: clg@kaod.org, peter.maydell@linaro.org, steven_lee@aspeedtech.com, 
 leetroy@gmail.com, jamin_lin@aspeedtech.com, qemu-arm@nongnu.org, 
 Nabih Estefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3SY4KaQwKCt4NABIHESTEFANGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--nabihestefan.bounces.google.com;
 helo=mail-pf1-x449.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

The address for LTPI has one more 0 that it should, bug introduced in
commit 91064bea6b2d747a981cb3bd2904e56f443e6c67.

Signed-off-by: Nabih Estefan <nabihestefan@google.com>
---
 hw/arm/aspeed_ast27x0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index c484bcd4e2..1e6f469538 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -87,11 +87,11 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_UART11]    =  0x14C33A00,
     [ASPEED_DEV_UART12]    =  0x14C33B00,
     [ASPEED_DEV_WDT]       =  0x14C37000,
+    [ASPEED_DEV_LTPI]      =  0x30000000,
     [ASPEED_DEV_PCIE_MMIO0] = 0x60000000,
     [ASPEED_DEV_PCIE_MMIO1] = 0x80000000,
     [ASPEED_DEV_PCIE_MMIO2] = 0xA0000000,
     [ASPEED_DEV_SPI_BOOT]  =  0x100000000,
-    [ASPEED_DEV_LTPI]      =  0x300000000,
     [ASPEED_DEV_SDRAM]     =  0x400000000,
 };
 
-- 
2.51.2.1006.ga50a493c49-goog


