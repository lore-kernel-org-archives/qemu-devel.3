Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FEB606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=A0KFR5Cn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVVsW-0001sp-2Q; Mon, 23 Nov 2026 10:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xVVrQ-0001Te-35
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:21:45 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xVVrM-0003dW-OT
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:21:39 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-67da69e7c31so3442043d50.3
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 07:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1795447295; x=1796052095; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/vs4sFdfKdIOq/B7UfEgjO9NdPjzDJFAw1/gWQ7A7dI=;
 b=A0KFR5CnxsRfvYS018rM6zpXlG6PrIpC5y6Kvph5jblKfYWzCJ40HqrULXfKM11E4w
 KrTns8MWyruG6BF2IoercidzUIHbn9i6/nQnwhtxmLE09wU8fxl/Skt0RAnzb2besc3z
 cXUQiseO/jOXrtoGzBHFqVV7WwzCF06/PXDaDpF5JvH3VSw9YPuN3yu263XVuvW0V6EY
 godQSB8FLlHxG44nzkst6tinwQ5EcXjy/GE/Ti8aCS8djxW+gEwZ/LEcOuwZTt6cWNsJ
 LqL+xb/SnBG1Jf5Q9sBE7WiLP6DxGwscMaWn9AknyvmcaMOk76IaNF6Ln/0sptDPcmF4
 osog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795447295; x=1796052095;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/vs4sFdfKdIOq/B7UfEgjO9NdPjzDJFAw1/gWQ7A7dI=;
 b=WjnBaF5aKcVRYpbX7gvJZp51yucuYzlZLQwUspON1QuV6kXVmPC1y9L5bAOgFPx1m9
 oCoyGbsf949CtMh6lNr6Jon+k3PLSTS+FUDgA/VM8mmwGL5eaNgsJ2fQmT66gnj60nzu
 DhnrWDc+aQVRBFVHH5bYW7So2y+bYcpWlzG3WYbsd+yvvVlHmD7Cc02jnVQcULffg/8y
 BQMFU7ZcuhkK0CUE8jJEN99UNjHgyVhKyMO0TsWgMsw2/LoKDPB+WjR1M9gTyoGCfyl0
 xVPHKSNmq5/hgBl/4uHjmVeeQrXBtvii70TKZIXwRLyhXpvCmdnu8+VJMdbWAJEilOP/
 SoxQ==
X-Gm-Message-State: APuU4Z8BUsyCxuKHlvB3tAmEQ0fNuUz/vT4/PO/dD01CV+jNc5jd2LKA
 pDVtjVvb6Lxc+DP4mCjxIqOZi2i4eH+XJhxg9K2wSjq4P861m9Zu3BBg9sukgFqT1+o=
X-Gm-Gg: AZFdTZecngoLPwqddKo3LQvIkHezIQ1msDs4jFpZ/Zr0zsfy5LgsmCplC9HjP7mHR0K
 /Ays3DwCLv9ov9/t7QjVtfa+0ywWVZlH5s92uSNaoMcl/L4ZgPTaM/2TcFFAhMDG86ikcBx/7JZ
 6rN+rjyuW/+4euziQIxxuFNPdzRbygI8VQktVdPv6iVP+SILGdbjnldlV3SbmvB4Icms3EMx4M7
 ceTaApXePSUbmWK2NrSPQ4xd3y/fkGHmUQHhw0pXniZlrNO64yoSoY1m9fdus7b5HtQJ5dtwehm
 euOEOYQHxFWmJoJvj7r82e2i1RibXiWPzUzrWtdeCcsVV7qrws0XQ2a7JmrDgndR+uTuojqYUa9
 WXTsfDz5g1wfqwJhzvUM5GU0GW3WZ+MxQjMpzKCp1u7yvpCZKFVBMoz2zVqlDrNIppfLOP7Tjry
 /LL/9f5/b2y7rf51cmJCUOj7Uy2H4/ki2Nly0kYtT8NXm1HO5B//Ms2qAuwTU1a0QC+KwW2mQ8b
 VRSJwlEaj0tTJf9DeeYCrgRvgfHoo4HxranW81fXoG+dsuDh4HsHJjSbyI89PH9AOu82wGXWhWD
 XeJM82RjKi4CrGHHYZM46bt55G0DsVF3hQ2pI9HHr5L3OKJiwCYQGwyC5cPpzazZmZSpPE09Dtq
 4mgTDdEEU
X-Received: by 2002:a05:690e:43d4:b0:67d:a47a:599d with SMTP id
 956f58d0204a3-67df44101d7mr2902524d50.27.1795447295218; 
 Mon, 23 Nov 2026 07:21:35 -0800 (PST)
Received: from [192.168.2.129] ([2600:1700:220:59e0:f880:d5ac:69f1:fb89])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67df3353258sm5747939d50.9.2026.11.23.07.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 07:21:34 -0800 (PST)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Mon, 23 Nov 2026 09:21:16 -0600
Subject: [PATCH v2 1/2] test/qtest/aspeed_smc-test: Send write enable
 before each page program command
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-m25p80_write_enable_fix-v2-1-0ac94f99e91f@oss.tenstorrent.com>
References: <20261123-m25p80_write_enable_fix-v2-0-0ac94f99e91f@oss.tenstorrent.com>
In-Reply-To: <20261123-m25p80_write_enable_fix-v2-0-0ac94f99e91f@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 qemu-stable@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yx1-xb129.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
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

Fixes: 3e62a32ddb89 ("test/qtest: Introduce a new aspeed-smc-utils.c to place common testcases")
Cc: qemu-stable@nongnu.org
Acked-by: Alistair Francis <alistair.francis@wdc.com>
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


