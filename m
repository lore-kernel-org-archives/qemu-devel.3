Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592C9606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=azwbtyrk;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=oiIBeGvS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNWZ2-0000av-0U; Sun, 01 Nov 2026 09:29:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNWX9-0006be-FN
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:27:47 -0500
Received: from mx1.catap.net ([2a01:4f8:271:125e::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNWX7-000846-6e
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:27:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=RzQ5Z99
 wAZemi2CjdrNeYxR5R1ZcF4hQ8gXZwziF4M5oH+yt7byX+dW+j0GH74ugBBwgXMTFxIGx4
 2qQ2bYfE7IJR5l0awjNxIJ8P4AtrMTVNK2PHlclDwHgKlJpLhh6ROkJlV3iJZxXLlvRoyL
 ituq82FpyViB3VHdwJGhvQCFbse3hGEfSV43fi++x0TT5RU8Q7211g5TcjQ698T0XIp2Dy
 Nx2di/OBbaRCK5VpOt6tKcH9ifPs5pGfxS3XruJHZzKU7whCNO2OXer2BvqReT6puIVtJy
 kpmsYdjGVIWWOiyy/36akHhWSbH2hhnTrNwx+4Z4J3SwEHi/lZa+yQg==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=N
 so+m+B+gwZs3DcwkZgF+lh1fIK1VFkO2gFwGgrfXGg=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=SrV7OWJWTI+ZyYjcCdJ+IN9xjkIAPGDjx67kk0uvPS/G+s0PUzJ8J/XE0gMTg4x0Ii8e
 bwaxp7fIoEC/1j4xyrB531KGezLlZvMWkYl1aRE6coK7u+JFeCB20RhqaEBCrjH7XAdLF3
 MTAIXuzNjgF7tvFERpbPdamnBDrd6rSQ7pUzMfmWBf0/WNHU5oCNyEkavK/mT50OIh5UZ3
 /Ek8Mhj1bRYkDfuRkC3ByoP/TLbsmiwkLXA+zoa7fMWiFoq6XemA1qK6eop9EPderinxpy
 YJVOYGBwrWJ6WP1WgCFaCSfsFX4QDTHdxP/ny5ItG2M8v1lW4Y3QZz2eTsYvGaXA==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=azwbtyrk; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=oiIBeGvS;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=Nso+m+B+
 gwZs3DcwkZgF+lh1fIK1VFkO2gFwGgrfXGg=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=azwbtyrkelsBX5lW8cGj0ZkYeRBf9EgU1vB
 5KMJ/GoUO7IQ+YWpCw1kkDexpr+SV7HPF3r+4VoVwilx4TxCw4tUF+tYXbRjoM/WgZE3+7
 NAQmdV3VD+BXaeLEiMXPKgRiF3tPFnTaTGga6QNcPAXHQJgMyfoLa3r0qjhMgmKk9ZsYM9
 d/VXDQVNr56/4yArUjCWwjx3ovypq/HHcG5eQfyUc996ha8Gu64E+hkIchg/DKJSmLgFxF
 noRwyLwOOn+1cBLrVyY2LQhhjibrJ24qF4dqmndzvwbcIYYfUSZ+EvjXXmXnyIVBqdkrMC
 cwwVJM6t0i+RbvhxZu5EgetPQHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=Nso+m+B+gwZs3DcwkZgF+lh1fIK1VFkO2gFwGgrfXGg=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=oiIBeGvSBOZhqBG4nC
 70IKYDxKTFuzFOWCNtsHvApFAPjkQioiwmyZvijh+w0KTKf4iqeV3YHeGXKiyu8adyBg==
Received: by mx1.catap.net (OpenSMTPD) id 78ac4b3d;
 Sun, 1 Nov 2026 15:27:35 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id a4792c60;
 Sun, 1 Nov 2026 15:27:30 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 07/26] target/mips: accept Octeon PageMask encodings
Date: Sun,  1 Nov 2026 15:23:23 +0100
Message-ID: <20261101142723.41346-8-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101142723.41346-1-kirill@korins.ky>
References: <20261101142723.41346-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f8:271:125e::2;
 envelope-from=kirill@korins.ky; helo=mx1.catap.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
index 3fc55314a8..9f7270d558 100644
--- a/target/mips/tcg/system/cp0_helper.c
+++ b/target/mips/tcg/system/cp0_helper.c
@@ -885,11 +885,17 @@ void HELPER(mtc0_memorymapid)(CPUMIPSState *env, target_ulong arg1)
 uint32_t compute_pagemask(CPUMIPSState *env, uint32_t val)
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


