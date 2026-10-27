Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997D3606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=r5tkX44s;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=6ytKOvcP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLefx-0005LI-48; Tue, 27 Oct 2026 06:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xLefv-0005Ku-HG
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 06:45:03 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xLeft-0007qu-K4
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 06:45:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=Th9MVAj
 5gFWbxKHBt2glcymYdPmgfXjUnL4/2pHp5SFFmFIi9VmdqC3KYMKKnHYhiLEZeiAvFNkac
 SQ6esKkC10iO3Es6ekOTAMZYNlJ3wdxMHu8SMjc/vGG7SUL113wCU1bCf0cuDj8zRmmJae
 zXp6Ch0aBf4F93AmpQUaVqBFP2Ln7+Yoyx6zjYmEkJmVaMZR/ap1W3voeFr+7+Zp4o8p4G
 9GkpNG2HDgVbi3exS1ckY62xK4GhT9/QYx2lt/OEbJ9cLhAXBk2iOiZe88Y6acyNH392gz
 /RsrW6Bq+2x+U5QcMPQjH5JvIodFJwwOl9pfpiULuOfDfQ2DyJN9irQ==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=+
 fhJAxNZCxUtVDQZxnV6+1qWoB8B7h/jIV/o8uX6WS8=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=ddiTe1mepXJosQW7STNYCtulQpDFiPqe6NCtHk8iVjiviUSHo+lpaFy4KuH+uPp9gc7j
 NrEdCpGV4kLdD2p06kSGUJBG6uFMmtoP1mgkZY1r6MPu18KpEMwjL2QCtf8kqwVs1GGOZV
 Zjh3ZDs1zqeiBWkJ4Ke2Xt4fnyfwF0ikC+qE0nPIm+P5VM2q10JwHN5IrqMeGUh8KnWY58
 wyHFu4N4fRPmnepgtS7T+9q06kDBYA/tOTVowUZA3Z5BH6dupH1vzWaFfNB78jLuck6UP7
 KJ2l4WZq+Zx6nWl+G4uOocvcGuCAqSWO3GGULZExlFRpsBu8ZVEHcKZq+myPeNTg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=r5tkX44s; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=6ytKOvcP;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=+fhJAxNZ
 CxUtVDQZxnV6+1qWoB8B7h/jIV/o8uX6WS8=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=r5tkX44sqDePeL+D/RKuUHOkfjfNZFHGo9o
 w9HO45uOUQDXxy5J1ur25zD+YBf9YCfnuAeuzdP9EWyiYqc8jDVKPiaH7kKqnng15++nST
 mh82zOdyd5cSrEt9RVML9CQqs4vsPyECwX2XLfg9TzsxI/Pbz5xcvUffFpkEN8MW243tCc
 PBiLZi+uEEH9EPJkPwYBSiJBUjymNdpzKMosTqFXo/iBzXpxh1DWqHSF76LShm0Jskx3vJ
 Cw4cXaVVv9PrTlpj9WQvk8c8d9Qsa8xzwT0weN1wl17Qr8Lgpp6izxPVs74TpT38DkEld2
 8cYSs+VDvVlcnwPmpKLccU1NeVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=+fhJAxNZCxUtVDQZxnV6+1qWoB8B7h/jIV/o8uX6WS8=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=6ytKOvcPRc2dLYcuv4
 +nKBJpN3HMU29+qliV8n29qqutZx6fVNTMYxAqkNd5V0EOVsa54cKo6vHLD50ZsZ+6Cg==
Received: by mx2.catap.net (OpenSMTPD) id 42449ccb;
 Tue, 27 Oct 2026 11:44:53 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id a69918f1;
 Tue, 27 Oct 2026 11:44:51 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v4 02/25] target/mips: fix MIPS64 segment access checks
Date: Tue, 27 Oct 2026 11:41:26 +0100
Message-ID: <20261027104433.25720-3-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027104433.25720-1-kirill@korins.ky>
References: <20261027104433.25720-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
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
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The xuseg and xsseg checks only tested UX and SX respectively; kernel
and supervisor accesses must instead use the mode bit that applies to
the current execution mode.

Allow supervisor and kernel mode to use xuseg when SX or KX is set, and
allow kernel mode to use xsseg when KX is set.
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


