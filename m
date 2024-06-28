Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEED8C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5eM-0001Kf-6t; Fri, 28 Jun 2024 03:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5e3-0000qR-Qf
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:03:44 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5dz-0006kx-U9
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:03:43 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-424f2b73629so3116285e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558218; x=1720163018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J3wthznmbxomPepKTD+GJx+mK9dnEa8WgXWlEO2pfXs=;
 b=q/MT49paNwk9DCE0NiN4cyqbIotR6b5MQFtHhs/OH5F0BU0ETLAirFUl8hCLUzOsGj
 PEiWcbl8k5+Ir1gR0g26YzcX7CpboreGEcc7XAZINa8P/Rh3KntRQ5W4gxfHXyvCfp1K
 Rtw4szqt6FoKv0CEHpmVbVBDd+9SUWPed+PL/GBOGCXPDLyHXuMn/wIXmdOOlbTokydh
 F2UruHfnD9iDe7VeGSvZgYBtkduB7c9NAu1bw+DlsbJojzzEZwXkydNy+peMgLyV/jvk
 gsfQh/L1sniIPccU7b/zETdfnW35v2/qbjyeZ/jbGNc0aCaQXI1lw4ZQLlA8Y7D6q4eh
 7GnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558218; x=1720163018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J3wthznmbxomPepKTD+GJx+mK9dnEa8WgXWlEO2pfXs=;
 b=XX6UpRAc11stt7uhTRNibCxCME9fg6YdgC6tqFPG93wIZdoDsWx9Xi0CNeU4pgqZe4
 Os2LiBhkWMDfihMFToi+ff5r6Y1FpIU35W/dWn9gxOBQ1UJjwlPzAgXQG5Gt5fCIh9ww
 FO4INEEew2IiAxXk0cugEprHyROEiYBffZNDJ0qjw7pCx8ovi776MweCrP987I6Fj2MC
 d8bg9Dxg+j2ocnvzuHEf717XW7e7J/UViXstWz3DEfi8SKgDoxf5GW6Hqh/GQ64aHEQR
 1MUk8RR+tC19wVBpFef9aVqv+j/QYYUX4cW22f47LHPO14Lvp5LFwfNuslneVbM5cLkc
 XwRg==
X-Gm-Message-State: AOJu0Yw64i9JH9uAV6goZBgwRNCjFG9I2SCJC0KgQ+B5dyOhbxQNW48e
 MnI+JPAxD/NYnxrrcA3TykagT/fLc+Mo3io0TrCv3VV2u+H9zyjPtBsEk472ITmrMjk3zeKysQM
 JQH0=
X-Google-Smtp-Source: AGHT+IHp+3yHX+ZUH8iqIfw4AoVlShhomNWS0Zk9o9sG6ZvePG0H7XyMgx1XeBoWhrDqvH56H3gViQ==
X-Received: by 2002:a05:600c:48a4:b0:424:addc:c7ae with SMTP id
 5b1f17b1804b1-424addcc946mr62733785e9.28.1719558218171; 
 Fri, 28 Jun 2024 00:03:38 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af5ba67sm21352435e9.19.2024.06.28.00.03.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:03:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [NOTFORMERGE PATCH v42 15/98] tests/qtest: Disable npcm7xx_sdhci
 tests using hardcoded RCA
Date: Fri, 28 Jun 2024 09:00:51 +0200
Message-ID: <20240628070216.92609-16-philmd@linaro.org>
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

Disable tests using 0x4567 hardcoded RCA otherwise when
using random RCA we get:

  ERROR:../../tests/qtest/npcm7xx_sdhci-test.c:69:write_sdread: assertion failed: (ret == len)
  not ok /arm/npcm7xx_sdhci/read_sd - ERROR:../../tests/qtest/npcm7xx_sdhci-test.c:69:write_sdread: assertion failed: (ret == len)
  Bail out!

See https://lore.kernel.org/qemu-devel/37f83be9-deb5-42a1-b704-14984351d803@linaro.org/

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Cc: Hao Wu <wuhaotsh@google.com>
Cc: Shengtan Mao <stmao@google.com>
Cc: Tyrone Ting <kfting@nuvoton.com>

See also discussion with Thomas:
https://lore.kernel.org/qemu-devel/484dce48-286a-4a2b-9040-98c45bcfb563@linaro.org/
---
 tests/qtest/npcm7xx_sdhci-test.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/qtest/npcm7xx_sdhci-test.c b/tests/qtest/npcm7xx_sdhci-test.c
index 5d68540e52..6a42b142ad 100644
--- a/tests/qtest/npcm7xx_sdhci-test.c
+++ b/tests/qtest/npcm7xx_sdhci-test.c
@@ -44,6 +44,7 @@ static QTestState *setup_sd_card(void)
     sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0x41200000, 0, (41 << 8));
     sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0, 0, SDHC_ALL_SEND_CID);
     sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0, 0, SDHC_SEND_RELATIVE_ADDR);
+    g_test_skip("hardcoded 0x4567 card address");
     sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0x45670000, 0,
                    SDHC_SELECT_DESELECT_CARD);
 
@@ -76,6 +77,9 @@ static void test_read_sd(void)
 {
     QTestState *qts = setup_sd_card();
 
+    g_test_skip("hardcoded 0x4567 card address used in setup_sd_card()");
+    return;
+
     write_sdread(qts, "hello world");
     write_sdread(qts, "goodbye");
 
@@ -108,6 +112,9 @@ static void test_write_sd(void)
 {
     QTestState *qts = setup_sd_card();
 
+    g_test_skip("hardcoded 0x4567 card address used in setup_sd_card()");
+    return;
+
     sdwrite_read(qts, "hello world");
     sdwrite_read(qts, "goodbye");
 
-- 
2.41.0


