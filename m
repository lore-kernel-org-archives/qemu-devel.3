Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7D8E8FDD4
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 08:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQ44-0001ML-OQ; Sat, 27 Dec 2025 03:54:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vZQ42-0001LS-OW
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 03:54:18 -0500
Received: from mailgate01.uberspace.is ([95.143.172.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vZQ41-0001kt-7a
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 03:54:18 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 5F0CF60D43
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 09:54:08 +0100 (CET)
Received: (qmail 27282 invoked by uid 990); 27 Dec 2025 08:54:08 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sat, 27 Dec 2025 09:54:08 +0100
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>, qemu-trivial@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH] tests: fix comment declaring runtime in rv64
 interruptedmemory test
Date: Sat, 27 Dec 2025 09:53:46 +0100
Message-ID: <20251227085349.23808-1-neither@nut.email>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -
X-Rspamd-Report: MID_CONTAINS_FROM(1) BAYES_HAM(-2.991974) MIME_GOOD(-0.1)
 R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -1.591974
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=bDOhklJZKzpwddgwnTDpyzmwJIi+r0iPIv63V8dbigw=;
 b=H2W1CziceSMNdh1Q6GzBKRyW7uOLY8bYBH6muIbsIdZUOU/s0Pj9jf1d6FaRJo0q4rIvSOmW1X
 LBK1YCRcBjFrqaM5YRpU/7QHdiqm901QaD89Bs6ZS8v/cxOBJoKLgVll/rlO3kiirDrGezkpRC7e
 9hLmJmgw5yuPNr5/ppe9ls372ZphloosJGRTPza6GC/Cbi0lW5Jrd+28Vl/ogK6S60tcyP2ApV51
 pvy44+mV2YzCuz+aZ6bmpZ3el1E0jcz25l2excfksrqiBiaMOUu59lo7vwzg2ndkXyC1JCySPX1M
 cSS5N89bPdc0Wq2jJFQ0Wwr+vR6Vzg12VkcAEd6uONnoLm0TedtZHGJhDNAkOFis6eGNyjAbNwcr
 dtugcSsVZBypDaEBmtU9P84rl9zucSNHWMkwYrKjKyzmGKaYi89Km4S8wKeWiA/eIPU92kYLtSZP
 gh/58XBTcaKYb1W72YgrdKjcW/IpPWeo9SO9jh2MlO1PF7LmkK9K90QXdWjRKobm//4uOUJAu6Jf
 z3uhF0MWZR4FBMfkwSOOvLeGcAvpO5UsaKTnW2lAgPokXYUW8LUZEfA76pwHPlZMKmvIKk4PfkLp
 fhAbMRrEN6A7l6oJKTGdkbspM2XeZxFowkC4arFPUfJhEwbn7Dl7Q7+qR/3AtIQtiastkPRCviJg
 4=
Received-SPF: pass client-ip=95.143.172.20; envelope-from=neither@nut.email;
 helo=mailgate01.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The test attempts to trigger a regression for arount 30s. However, a
comment just before the computation of the target wall clock time falsly
declares the run time to be around 60s.

This was the case already when we introduced the test in

    5241645c47a9987f4fcc65bab303a444966b7942
    (tests: add test with interrupted memory accesses on rv64)

Signed-off-by: Julian Ganz <neither@nut.email>
---
 tests/tcg/riscv64/interruptedmemory.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/riscv64/interruptedmemory.S b/tests/tcg/riscv64/interruptedmemory.S
index cd9073ee31..c154f93839 100644
--- a/tests/tcg/riscv64/interruptedmemory.S
+++ b/tests/tcg/riscv64/interruptedmemory.S
@@ -25,7 +25,7 @@ _start:
 	li	a0, 0x03	# 8N1, DLAB=0
 	sb	a0, 3(t1)
 
-	# Run test for around 60s
+	# Run test for around 30s
 	call	rtc_get
 	li	t0, 30
 	slli	t0, t0, 30 # Approx. 10e9 ns
-- 
2.51.2


