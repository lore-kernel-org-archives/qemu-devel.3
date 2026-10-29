Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653B3606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=ZEfwN0wF;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=umNJdM1L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMX1W-0000Ic-Vk; Thu, 29 Oct 2026 16:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMX0w-00086T-22
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:46:22 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMX0t-0007TA-7D
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:46:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=EpdQ9OB
 r4NLibskZqedtXjVN/qSe/Cf7+0defFGKcEOTYv1Wpb5LEpgKPQd/G0cyy9fQ7P64hcOf/
 1iOLh7dvuls9IAbK8DJ2vh+uBVGAzkVEIF7ViPPdz3Jsvb2lhT27K7rJLqB1X6rPQMMaT0
 OAjnYNrG6FKHY6S6H6cD3gQwIztvKc6am3hnsUFEBPKiKG1wa3oHjaf0L1kEP2IY81s1oZ
 UpZHyHVBm8eOl9023UZDRGiLC65NjF1J0TNstbgzahrf3yJSFxEzDs7ygvS0YONUfEbZfK
 um0s8EeskaxpflT+nSg7S2Ye7yC70/axM1Z9bDGxzTzIVlBN4Vj2/YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=o
 ZIhJ99tBnEm161PdQyhN93+GmDZtqEXkPIprVQL61k=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=NZnCSZpaZYUuxm7PV8agxe5elFTg0yE+v/uoft9ABXRNkvDEFTsOD9U5R/NWUdH/67KX
 J10yAHK1BEQUrNvro9OvnD+kqFsv9bL9WEBZnAhg+/qB0TOmdZ6UNcxALLDRtivFwEvzhR
 YRVI6A6nnFitqztHmnGbPclbqoII62yZtw1DVVMfvfw5TcpGYSi4SSRXeGO9Ywq6IFmoAt
 6k2iFGN52uuP+lRkb0lwGQYjRwUy+4jZWqytzTgK+5Rkprm71Sm/qu7JvA/X+2FZ2vjlie
 0kzh7NBZYN9oACIJHCu17cfLKfr1zcRg98wMcdceNjdG/A3NMnjCSv1B11QX9nrw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=ZEfwN0wF; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=umNJdM1L;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=oZIhJ99t
 BnEm161PdQyhN93+GmDZtqEXkPIprVQL61k=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=ZEfwN0wFspDWPLOVuCHCOojBYM68zMwq3+g
 evsJPVXhr66WdpUIJD0Dju4vCg4rSfl8bVx2AMoPPyJdR1BCyzSrPXOzfWQKyi0cwc7stK
 tHUbGxeExR64rwiMhnEBe/TQDy/Ta0OasGbMikZjw2/HOxLKdzB07A6982R+HtCSwaZBcO
 qfhStQMFf+z+TlrK+39vJrw8TvWM69rXshU/NyeIrqbLWVmpUWu4ZUNrt9OREiQA858Bz2
 QFstFJ60KCi7EcuujfzgEw+8G8Np3KmRCU5qLLAH/nXLUldBFLFQ7zN9rHtphM8DcZk+Pd
 pYnN8cVWReUyxOmIHj3W99WPN7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=oZIhJ99tBnEm161PdQyhN93+GmDZtqEXkPIprVQL61k=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=umNJdM1LMRYTRXZpvl
 CWLM9xPn+mVWDCPU4ikTAhpt8ip7ekskN1yILi1nA5Y7HClYIdaoGEgCnyziIkr3e0Cw==
Received: by mx1.catap.net (OpenSMTPD) id 20df3582;
 Thu, 29 Oct 2026 21:46:14 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id cb1a351d;
 Thu, 29 Oct 2026 21:46:12 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v5 02/26] target/mips: fix MIPS64 segment access checks
Date: Thu, 29 Oct 2026 21:43:47 +0100
Message-ID: <20261029204609.38989-3-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029204609.38989-1-kirill@korins.ky>
References: <20261029204609.38989-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

The xuseg and xsseg checks only tested UX and SX respectively; kernel
and supervisor accesses must instead use the mode bit that applies to
the current execution mode.

Allow supervisor and kernel mode to use xuseg when SX or KX is set, and
allow kernel mode to use xsseg when KX is set.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 target/mips/system/physaddr.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/mips/system/physaddr.c b/target/mips/system/physaddr.c
index 6f11e70ba8..69968022cd 100644
--- a/target/mips/system/physaddr.c
+++ b/target/mips/system/physaddr.c
@@ -144,7 +144,9 @@ int get_physical_address(CPUMIPSState *env, hwaddr *physical,
 #if defined(TARGET_MIPS64)
     } else if (address < 0x4000000000000000ULL) {
         /* xuseg */
-        if (UX && address <= (0x3FFFFFFFFFFFFFFFULL & env->SEGMask)) {
+        if (((user_mode && UX) || (supervisor_mode && SX) ||
+             (kernel_mode && KX)) &&
+            address <= (0x3FFFFFFFFFFFFFFFULL & env->SEGMask)) {
             ret = env->tlb->map_address(env, physical, prot,
                                         real_address, access_type);
         } else {
@@ -152,8 +154,8 @@ int get_physical_address(CPUMIPSState *env, hwaddr *physical,
         }
     } else if (address < 0x8000000000000000ULL) {
         /* xsseg */
-        if ((supervisor_mode || kernel_mode) &&
-            SX && address <= (0x7FFFFFFFFFFFFFFFULL & env->SEGMask)) {
+        if (((supervisor_mode && SX) || (kernel_mode && KX)) &&
+            address <= (0x7FFFFFFFFFFFFFFFULL & env->SEGMask)) {
             ret = env->tlb->map_address(env, physical, prot,
                                         real_address, access_type);
         } else {
-- 
2.56.0


