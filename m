Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA94606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=MTNPgQHu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQqKe-0004OU-Qa; Tue, 10 Nov 2026 13:12:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xQqKO-0004Km-VD
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:12:21 -0500
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xQqKI-0001BX-LR
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:12:12 -0500
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-702dedeb70dso1209694eaf.1
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 10:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1794334329; x=1794939129; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2lz6ftAxs01+ACSsm7X1ZjSLeJAPTBgkfGH2sQxS7JU=;
 b=MTNPgQHuW+AoPs2+N7wi6yAb6ttgMX0+GDulCCMGeAomaP7OrRyWw2gLhIVD2Gn0l3
 oDiS4XAerDZ8NhJFRkR4SAqa+5ufwkYOthP2zCxSYBhTu8vwNP/RcGLFrNFqV1pYN/nC
 zpEIx/uEmW/bUKA3iXD1T9gdcjgUBFY51FS4TGJkqaAXZecGXgjpMurOiqAH3q7fO15x
 wuHigiT/vUo0/wPUzV1HtMysMczZFBlOs+KZhgg0pxWCJBO/HexJb+MbnvbVBuE3Vaxl
 Z+MHvMOpSOUBOVd4g3hnveNJ7EFf1FJ6HqR80bN7pnnM7KZVki5TeyUbGtQSAIZlxtYz
 WJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794334329; x=1794939129;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2lz6ftAxs01+ACSsm7X1ZjSLeJAPTBgkfGH2sQxS7JU=;
 b=sBRR73WPVzxvYDYzxNAWQsYgV1Uk6k8jTblRqnlNz8mvN8MQLBr9PMndSwXj4F325G
 X+m2UpFCyHeJEu0oQljT+WXXde5W1Fnf22pFz6L6xlsx5Pg/sLeySaucTnTtVYdYbgY+
 FQl8/iN8yZCfnbbUel03sK62i8niXlLSZfll5je0m5FnUJKKihUT8GLDizQcf6oUDvdW
 Ae3LCcpZs3GHX/fckLwL+kReA1UXOf//ajgjPVEDmySMq8JU5aEbI16dPh3PJyKpujg0
 mK4tPk2e0lQelQn+pPIPYLcDXR8444z8Do0fQzqiBRZNjHOVZkhl8EOrTcw3121HrgBk
 /loQ==
X-Gm-Message-State: APuU4Z+2vuY0DTY6/IDLp1MVl9urIQIuExIuXJzcdhmqT04ZFJQLYdgf
 hGJpvbYVbrCEA/p5GGeQs3hNWFiP4NNS59073QsPvzuF99W8dUe6iYXqzVo/j/H91Mg=
X-Gm-Gg: AYBFou39WdgY4skupwLrpopWbhPEbWENtvWVkgOkCwpJWpZaI4tsKmMU0StPQA3G3U8
 /5R7ye4p+qBab6AyGHZGgBN9wuCllGM1ZbHVnXl3LxiSyLhIU/3eSXmRDRIu2a8U5v+Qk/PzHFy
 ccrUOmhIiNzb8lD800xqlSEmrvTi+nKLiCen1sw0z0u6q7Tg6BuWmCFzDdtQsaRABSVTp/xRd/W
 NrDLgC0HVNi1JdTXTF5gLOa3VtFj3PIQ9eRoCLzn58htWNjLM17ZLawWOeKevyQb5tr//RmWsIs
 LgLjzTj7LrIN+wkn94zvODkiaqEhbdKQzcF0JXRzxhLUTYLYdOJRvZoBlVzDwPTAtZ58fCO78Lh
 YbbD6A5OnGKXB0k8/LteKS4jzDroyOJR8raAEgS6U3wtXPrcyxs5xGnRSkcOcWl1uh+KKLKm7rD
 PU+6O8pOS/xHTNjaSl+DFllbdS8YExo6awATJ1fBBb/6oQJks26jVeMXW6etSqIMI103m+D7S9G
 n+A6lYE9N3yvKtUA73Fr5PoeQC0dBFCPTIcXGSKyf5g/NfMeGo2aQWVRTK/E6jZ29VMSv1G495T
 6z1iQ+6F+yNGMo/t8cb8ludawgN9pJJkINQrjU5X1U9qPCgyaOXDiVI6456Lr6wjkHb+Y2jlAXR
 yq1k=
X-Received: by 2002:a05:6820:628:b0:715:1e5a:dc95 with SMTP id
 006d021491bc7-7189e63d743mr1693528eaf.0.1794334329314; 
 Tue, 10 Nov 2026 10:12:09 -0800 (PST)
Received: from [10.200.24.109] ([12.55.13.134])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-718aa034ad2sm2063514eaf.13.2026.11.10.10.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 10:12:08 -0800 (PST)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Tue, 10 Nov 2026 12:11:48 -0600
Subject: [PATCH 1/2] test/qtest/aspeed_smc-test: Send write enable before
 each page program command
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-m25p80_write_enable_fix-v1-1-3a2abc0072b0@oss.tenstorrent.com>
References: <20261110-m25p80_write_enable_fix-v1-0-3a2abc0072b0@oss.tenstorrent.com>
In-Reply-To: <20261110-m25p80_write_enable_fix-v1-0-3a2abc0072b0@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-oo1-xc34.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The M25P80 specification [1] dictates that a write enable (WREN) must
be sent before a page program (PP), and that the write enable latch
(WEL) is reset at some point before the PP command has finished.

The current tests that make use of page program send WREN only once at
the beginning, before issuing multiple PP commands. The m25p80
implementation in QEMU doesn't deassert WEL at the end of each PP
operation (so this isn't an issue currently), but real hardware would
unset WEL at the end of the first PP command the second PP command would
fail. Update the tests to send WREN before each PP command.

The current m25p80 model does not reset the WEL at the end of each PP
command. This is a bug, and a subsequent commit will fix this.

[1] https://www.alldatasheet.com/datasheet-pdf/download/22807/STMICROELECTRONICS/M25P80.html

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 tests/qtest/aspeed-smc-utils.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/aspeed-smc-utils.c b/tests/qtest/aspeed-smc-utils.c
index 146332240d..85e883d0b8 100644
--- a/tests/qtest/aspeed-smc-utils.c
+++ b/tests/qtest/aspeed-smc-utils.c
@@ -218,12 +218,23 @@ static void read_page_mem(const AspeedSMCTestData *data, uint32_t addr,
 typedef void (*read_page_mem_fn)(const AspeedSMCTestData *data,
                                  uint32_t addr, uint32_t *page);
 
+static void flash_write_enable(const AspeedSMCTestData *data)
+{
+    spi_ctrl_start_user(data);
+    flash_writeb(data, 0, WREN);
+    spi_ctrl_stop_user(data);
+}
+
 static void write_page_mem(const AspeedSMCTestData *data, uint32_t addr,
                            uint32_t write_value)
 {
-    spi_ctrl_setmode(data, CTRL_WRITEMODE, PP);
-
     for (int i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        /* Send write enable before each Page Program */
+        flash_write_enable(data);
+
+        /* move out USER mode to use direct writes to the AHB bus */
+        spi_ctrl_setmode(data, CTRL_WRITEMODE, PP);
+
         flash_writel(data, addr + i * 4, write_value);
     }
 }
@@ -468,10 +479,13 @@ void aspeed_smc_test_write_page_mem(const void *data)
     flash_writeb(test_data, 0, WREN);
     spi_ctrl_stop_user(test_data);
 
-    /* move out USER mode to use direct writes to the AHB bus */
-    spi_ctrl_setmode(test_data, CTRL_WRITEMODE, PP);
-
     for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        /* Send write enable before each Page Program */
+        flash_write_enable(test_data);
+
+        /* move out USER mode to use direct writes to the AHB bus */
+        spi_ctrl_setmode(test_data, CTRL_WRITEMODE, PP);
+
         flash_writel(test_data, my_page_addr + i * 4,
                make_be32(my_page_addr + i * 4));
     }

-- 
2.43.0


