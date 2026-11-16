Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612C8606A33B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=nfC4XapA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3IO-0000KZ-K3; Mon, 16 Nov 2026 15:27:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3IL-0008PM-Cz; Mon, 16 Nov 2026 15:27:17 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3II-0000iv-J5; Mon, 16 Nov 2026 15:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860763; bh=Sg5/jV4o4xN5OQZepB7W7o1l9mZwwOtkNSLGeMMYK+w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nfC4XapA6YXpZmbi2WVCd+9utO8fmd/xe+6Mrrpf2El8gMNPtJy77LmhJ7fc8kCjQ
 6vywNb32HvNXtRhvJ4AtSuz0fzCmZ7sLQ5Gmu2q3kbTajWdEVp11HMvyYzgSErPr4m
 RSpHa8wy3Adne9zZL4r57N4lCh5CPnMGY24tu8RoSmVAxinBQeRHWb28cogn6V5nl5
 t2+50U603BqrXkT09lrrFd+TgwEb5MIKmY2GDgmQMzBKQzfppaxn4Z65BtjfiOaRAC
 xq6TJkLLnGfyjjMFmXH2iIhe26DC1qAYLck7Q6tAzmfJe9xZPPWITtfXbzvrWhCtZ/
 FR/FX/wpa9fag==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EB8D91E71A4;
 Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E8A7545FBD0;
 Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 94B35B8E64; Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Matyas Bobek <matyas.bobek@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 15/63] hw/net/can/flexcan: Fix FLEXCAN_CRCR_MBCRC
 definition
Date: Mon, 16 Nov 2026 23:24:54 +0300
Message-ID: <20261116202554.535325-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

FLEXCAN_CRC_MBCRC is defined as
  (((x) & FLEXCAN_CRCR_MBCRC_MASK) << 16)
but FLEXCAN_CRCRC_MBCRC_MASK is (like the other _MASK values
in this header) defined to be an in-place mask
 FLEXCAN_GENMASK(22, 16)
(a value with bits set from 16 to 22).  The mask and shift operations
are done in the wrong order, and so the result of the macro can only
ever be zero.

Fix the macro to shift first and mask second.

Cc: qemu-stable@nongnu.org
Fixes: 3c4e23cbb597 ("hw/net/can/flexcan: NXP FlexCAN core emulation")
Resolves: Coverity CID 1662973
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Matyas Bobek <matyas.bobek@gmail.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Message-ID: <20261022195924.672606-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit d60f2b934245eba3428393168adb5b5f0dccc4ee)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/can/flexcan_regs.h b/hw/net/can/flexcan_regs.h
index c18bc4736e5..7923bf836ff 100644
--- a/hw/net/can/flexcan_regs.h
+++ b/hw/net/can/flexcan_regs.h
@@ -150,7 +150,7 @@
 
 /* FLEXCAN CRC Register (CRCR) bits */
 #define FLEXCAN_CRCR_MBCRC_MASK         FLEXCAN_GENMASK(22, 16)
-#define FLEXCAN_CRCR_MBCRC(x)           (((x) & FLEXCAN_CRCR_MBCRC_MASK) << 16)
+#define FLEXCAN_CRCR_MBCRC(x)           (((x) << 16) & FLEXCAN_CRCR_MBCRC_MASK)
 #define FLEXCAN_CRCR_TXCRC_MASK         FLEXCAN_GENMASK(14, 0)
 #define FLEXCAN_CRCR_TXCRC(x)           ((x) & FLEXCAN_CRCR_TXCRC_MASK)
 
-- 
2.47.3


