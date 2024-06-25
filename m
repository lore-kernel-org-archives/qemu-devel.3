Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD60CC41513
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 05:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLz83-0001bA-Qg; Tue, 25 Jun 2024 01:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLz82-0001aQ-7z
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:54:06 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLz80-0001Wb-GP
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:54:05 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-424a2ad06f1so1798535e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 22:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719294843; x=1719899643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FRec2147tzGGJgDwnAFCM7MdLQrzjYCwJA0fQ2k29gM=;
 b=lbXzn8zCEM/eFhv9FQbcfblXmtgXwrTwVOnwN/0y0nzt2U0J8Rr1YaQAjKRMaSBX4s
 zEHh0IUOk2Q4vRDE39zXnoW/g6XoLCR2sZ8OUqakcyI+0MeT/e77ISrl5ChETnyfUupI
 jwp4YFLhQ0j5QBKcrc0o6nAxegIdE9GtewtkxaSlnD1ATUb4S4LoDhDCQ9dSNGomSFEs
 o4G0Kqn8MXlPGd6wUquyT+ntBVuiYhGYsloNtKZ+lY5kNtElQWWQ/UZle+F3B1+Xlzxo
 fNV1a9ego3cYth8kOwr7dxhCH7P0dsB2pVOIpCBRiYgu/j2QXaJm2BPqd2ys62WcWOVc
 PhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719294843; x=1719899643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FRec2147tzGGJgDwnAFCM7MdLQrzjYCwJA0fQ2k29gM=;
 b=F9jDbat2ooKc60dqo26UA2BJEAwEp7nD3IRsrODrK25E/SyxPnV9bON5oEY+OzK0Lr
 oZO9kRmFFx3g98h9dL2isUSdMGbPjqLogLEd5gHMjI24wR+y3BVVcR8nMiqnz8brfHEq
 ue1PxtTJNtqR/4Om1MsZ2zMb6DmoZop8d6ySj2ONs3fqiXa2ICcsXqWJ/hjtsOx9JoaQ
 GnRhCtbmGwTkn2N8am/5G1VvdDnO0EZT345ytthExQY+qgF3+Kon8VjBjIfvp3oB3LGA
 MJuLwG3+WasmGh1Zy6YRINlIdYOzCkD1fFeGE+9/jpw47ygnKMP1PLcVYItViEVe8d1G
 38yA==
X-Gm-Message-State: AOJu0Yz4PeIP4HYjvcZx6o7P38K4r//gV7AaisesmN1uShBFAqbqpqiK
 jybN4deIPAMPnrTZe9n9UMH2epSkxok2oAQS6rJqPU8rx7gFgef5at+rHlPTSZf9qK5zj03bWWG
 0
X-Google-Smtp-Source: AGHT+IGjpxv8iQ5xIystXJEUsQL/JE9wFc/LepnYZUbDyhJjLg2KVeXtDurTLf42/0131WswwlFmsQ==
X-Received: by 2002:a05:600c:3c91:b0:424:8fe1:41f9 with SMTP id
 5b1f17b1804b1-4248fe14320mr36673165e9.11.1719294842831; 
 Mon, 24 Jun 2024 22:54:02 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424a49d6112sm4561375e9.6.2024.06.24.22.54.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 22:54:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Hao Wu <wuhaotsh@google.com>,
 Shengtan Mao <stmao@google.com>, Tyrone Ting <kfting@nuvoton.com>
Subject: [PATCH v2 01/12] tests/qtest: Disable npcm7xx_sdhci tests using
 hardcoded RCA
Date: Tue, 25 Jun 2024 07:53:42 +0200
Message-ID: <20240625055354.23273-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625055354.23273-1-philmd@linaro.org>
References: <20240625055354.23273-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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


