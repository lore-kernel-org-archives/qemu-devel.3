Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8849606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=nEBFPSQN;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=W4GSeqky
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR9R6-000102-CL; Wed, 11 Nov 2026 09:36:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xR9Qs-0000rZ-HV
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 09:36:16 -0500
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xR9Qq-00025i-Qd
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 09:36:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=tkWcmBA
 MXpEXmyMX4b2OA583oq4/p0w9PV5jm3QPP2Fw+QGtRH6aIn7HSnQbT2hU9DYSYeptRx8FU
 cpvlHB2yfG3jUGQ7UyivICO8EQlzdg/AP7DVvJyJ5BaF2Pk67Mrb87s4L/1KpNOe4Qonr5
 kiCSTLLTDTXW02ww47ckYdpYFeef7Kimk2pI4g37lJngmquOP9Wk0F8brUq4dxSUrvn4NM
 h4Yr6nWyDXyu8ov7M9cAXmna6gJoAQHFLqwoDJHWhoh+XS15iV8+znxYaIDQs3c0/Tz5sD
 /n3+/3SiX4P9dEUkdjjcPe28SB8168tF4rHG/4T5nOTLFW59qa9GfRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=E
 XtxmjxRjywOGfgMVk2aytYI6QwoCbqfbJ2OEYNn/ek=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=lizUlUhCLDIrn7ZspNwGNGuEzzCPIMmk7T6NUpsSHPk5yBcfqt6Fl4Z49EW4QZxeAjBQ
 ZBlQz4HulKgWnuLgfdOGyAif1Wjwh+b4UUaZKLp2cfbH03pqrypB22MdLrrlFNUfd45lIQ
 ki/NyMY8vDpiUsp7fPmDZ7OKM9GBYaReqR0hFq0e7t5pxiHsgZX/sScUj7q2tzBSN7aAyl
 xnwoJweyoF5sJdplT1ZHcYRzF1/g+QgRWgcusVXG/I0VFtqu4xxAFtDgnGP+P92/udIz82
 PEq19uiMstT7zxKfeMyzDoWlgFVkeViRUrEp2HdppLTkqGT54/2j7wKS2YgEHVEA==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=nEBFPSQN; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=W4GSeqky;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=EXtxmjxR
 jywOGfgMVk2aytYI6QwoCbqfbJ2OEYNn/ek=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=nEBFPSQNcYao6yfP8/utBAAdXFxIA++ZwgS
 pFSFfKNavCa5J/yFm2oOlZPX+mvOcD53Xf8La0WZAORPSRshvU4IFtdWkCcEkBrpyFA73Z
 2mYjptheUu/dZ7PO0rgI60qqL11u+ooM4rpCsqOlaf4rcKI5FbjJD2C1dn3A/AWGS5BlBl
 Nt6bZWn4foYuzQFnrKnG2l78aJ5iqlKiCuRaBynXeAt7hUSZcoH55YRsdUcY5AA40Fr2EF
 EsUpk5Ec456Os76gMiDyjAj8dHzJqBxbYoRI1Mr+U0ZgT+LDb0gdPTIKSD9NlVmtTgLkx0
 4iy+iXyKzcI/Z6hyJFo93vXFP4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=EXtxmjxRjywOGfgMVk2aytYI6QwoCbqfbJ2OEYNn/ek=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=W4GSeqky+cxTMsY9v7
 N1DPte7cbPsJZgVxqmiDiJVGf+kiQJKrHLLML8H9AWOpAF0IHCaZVD1Jy7uZ0chF7GCw==
Received: by mx1.catap.net (OpenSMTPD) id 8e51519c;
 Wed, 11 Nov 2026 15:36:04 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 12b9af30;
 Wed, 11 Nov 2026 15:35:54 +0100 (CET)
From: Kirill A. Korinsky <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: "Kirill A . Korinsky" <kirill@korins.ky>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v7 07/26] target/mips: accept Octeon PageMask encodings
Date: Wed, 11 Nov 2026 15:32:07 +0100
Message-ID: <20261111143533.1775-8-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111143533.1775-1-kirill@korins.ky>
References: <20261111143533.1775-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Kirill A. Korinsky" <kirill@korins.ky>

Octeon firmware programs contiguous PageMask values that do not follow
the generic R4K even maskbits rule.

Keep the generic validation rule for other MIPS CPUs, while allowing
Octeon CPUs to use the contiguous masks accepted by hardware.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/system/cp0_helper.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/mips/tcg/system/cp0_helper.c b/target/mips/tcg/system/cp0_helper.c
index dd4f06bd8e..e71c41aee4 100644
--- a/target/mips/tcg/system/cp0_helper.c
+++ b/target/mips/tcg/system/cp0_helper.c
@@ -885,11 +885,17 @@ void HELPER(mtc0_memorymapid)(CPUMIPSState *env, target_ulong arg1)
 uint32_t compute_pagemask(const CPUMIPSState *env, uint32_t val)
 {
     /* Don't care MASKX as we don't support 1KB page */
-    uint32_t mask = extract32(val, CP0PM_MASK, 16);
+    uint32_t mask = (env->insn_flags & INSN_OCTEON) ?
+                    val >> CP0PM_MASK : extract32(val, CP0PM_MASK, 16);
     int maskbits = cto32(mask);
 
-    /* Ensure no more set bit after first zero, and maskbits even. */
-    if ((mask >> maskbits) == 0 && maskbits % 2 == 0) {
+    /*
+     * Generic R4K PageMask values use two mask bits per size step.
+     * Octeon accepts contiguous byte masks such as 0x003fffff for
+     * two 2 MiB pages.
+     */
+    if ((mask & (mask + 1)) == 0 &&
+        ((env->insn_flags & INSN_OCTEON) || maskbits % 2 == 0)) {
         return mask << CP0PM_MASK;
     } else {
         /* When invalid, set to default target page size. */
-- 
2.56.0


