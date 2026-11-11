Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28EB606A330
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=ufW+BEZF;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=Lkw7vphf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR9RH-00014q-AE; Wed, 11 Nov 2026 09:36:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xR9Qq-0000r0-3O
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 09:36:12 -0500
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xR9Qn-00025c-PM
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 09:36:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=O6zZAE8
 paUYUrECkJCMXY0/PgpvnX0824LllsS7K8bxFUI+He21yK+n/pCA6npqgR4VoUseq5MPkk
 qMEVZzdwjAMWt55lFN4UN4ikKoK+R1ZwgiQzG9FklvtKaOBWbgiOl66KnSKBoxredrOFj9
 ymDLdhGTTSNZUXNKy05hPlc66A3Op1LK5yeT2jVWTqbiwyNvLYS3kc3z4ABH6P5oXsqYB6
 aVg6uiQktZr8D+qE03QJIfrTZGCZHR4mnKIfg6nOEYl4V3dBmArhYfon9Lda1rWZkIaNR9
 JbFjvME3AfCihDG/gdfuOFAGyOpHVLniKfaymrnsj4LP2eedoeiM5SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=i
 p+05HQUtpyNAF9Y8Zc9TEjOA31v/XNdzRO8hUjPYzU=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=PETiQXEAAIKqS5jhbHGRtEUhudx/fG3vpeOIZL4rC15iL4G6FRxQswn58VXaxHjhF5Tf
 LgG3XHkjb5H5/nkj5pS0V8ETmaqOeS9MJQXj8oic/ZlvGTLh5GboAWcg4IqpY0oDZY1Oc4
 7kLVg94Wyf2ZfZNdMQEoAJPUPiYJhZXYjlhJISp8OknjINZiWXw1yCckoDxPxQ2rcWvLbW
 Vwk1RatTNBXZyxJEmbF0pLz7Tme2NOf5p9zMttxLBMhgdxtrWmfoiN4W07yunaFw5Up/ez
 Q4+9wsPLveKHZew3gD6Vrd13SkDq29i3skuZhyyZtajOrV8rTmvF+sRQ888oZP3Q==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=ufW+BEZF; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=Lkw7vphf;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=ip+05HQU
 tpyNAF9Y8Zc9TEjOA31v/XNdzRO8hUjPYzU=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=ufW+BEZFVioAuqamnlEJV/ZCV7ypDaPPGwd
 gci2myJDT2A7G2heyfl79SJiaqEeOqFKrDXt0HIcgbABqv4iudg6ejZGejF6eGkMKTjFQd
 peAehBIsSEgdryPGvqTTQBHConfUcDhBhAiTMz1XlvBEbV0WVlq0qaHpPNhafqMHnFsoxT
 UWAlxh80vgQsVAGCpa1CL0AtkZMObSVJ0JOh6a/rXXRccTUYE5Ebam+zIw0rQMPIYYsyD9
 GrIl9nkxNV/sYQTDv2rDPSZoFpcJEWWZq3w1424Cd3V/U4Xkh4Lx8mTK51lLc6eLEkdv7I
 K+M59ck8xomMOfY0RR6JdZ21F/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=ip+05HQUtpyNAF9Y8Zc9TEjOA31v/XNdzRO8hUjPYzU=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=Lkw7vphfX7Tr9n5xU9
 rzxcKA605dZPjZr3rwUY9y8FaBfQJ636Ik2yo6xNjUne4TW2zkPDGqTykJEm5OMd8yAA==
Received: by mx2.catap.net (OpenSMTPD) id cb0c203f;
 Wed, 11 Nov 2026 15:36:01 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 3f559266;
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
Subject: [PATCH v7 02/26] target/mips: fix MIPS64 segment access checks
Date: Wed, 11 Nov 2026 15:32:02 +0100
Message-ID: <20261111143533.1775-3-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111143533.1775-1-kirill@korins.ky>
References: <20261111143533.1775-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Kirill A. Korinsky" <kirill@korins.ky>

The xuseg and xsseg checks only tested UX and SX respectively; kernel
and supervisor accesses must instead use the mode bit that applies to
the current execution mode.

Allow supervisor and kernel mode to use xuseg when SX or KX is set, and
allow kernel mode to use xsseg when KX is set.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/system/physaddr.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/mips/system/physaddr.c b/target/mips/system/physaddr.c
index 523197f020..b9f44c27bc 100644
--- a/target/mips/system/physaddr.c
+++ b/target/mips/system/physaddr.c
@@ -145,7 +145,9 @@ int get_physical_address(const CPUMIPSState *env, hwaddr *physical,
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
@@ -153,8 +155,8 @@ int get_physical_address(const CPUMIPSState *env, hwaddr *physical,
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


