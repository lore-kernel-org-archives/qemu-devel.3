Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31AFC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 11:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjEiA-0000CF-2f; Mon, 13 Jul 2026 07:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjEi1-0008NU-KQ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:20:26 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjEhz-00080r-Oo
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:20:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=NL/Oapy
 lCbwPqAkSIyq0jJKHji1dGAkrtCY0Wcvvvb32A+3/nFOh5skAkmQllvlOWSxsk41+hSH7/
 p8+0FaObt9qEyrTZT1iQfHs/bQJmd6PYJKoALiHJhjNbG6rP1RMec0K9kBUJ1MsN+WD1pQ
 OMk0PuNhOQ6Lu2IIevM7ixgQiu1vmEiqNcDn0iBMnYjkixc2tGi+IixEZLOlxdBKO7OpyX
 py0U/5nLb+wHs5y6pkpowrWnWio9VgrbP81w8hhjgnf2xsVOk0aJLDVUv6QXOCCnJ5rPb6
 gem/Y4hReh0L1lM1O3xgRG2kp/xL+MfICKIsnI9o/ek/vUFP1JpfFNA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=O
 nOzc/xFLlIzWsGfWekLrWErwBi3UvwPP5rpaHa7JzY=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=vtU4n8WsNoRR1LH6jxVNbItIxhttRuIX8LnbN+ALp73MCXklDCONeE+8wKAx6GMG+Hqj
 53a4+8gD3UXlTxd+NRCSfIrGYa0OUlpyQh2fA7DYPmINIQlqpsYAPrmu3zVMEE8NY+qZTs
 tMTu8cNW4juUmV75Q0c8ucpR65wzECebkDswgSjM1bNo3mjIpB4PdszsrqPaM7uUxoV1iX
 pT9icZ983cyNULvSfAKNzp/piGi4KJIAxTdHYrtcvhi/FrQJZ68CqOKFi++CwyDfr3u7PX
 KNxJMV707PbbMyLeZer/kxxG0uY6F+7aYBTqfKd5/mfhXqb+oaFWyae2PcIYcR+w==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=pKG0g+7a; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=ApZiVVbi;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=OnOzc/xF
 LlIzWsGfWekLrWErwBi3UvwPP5rpaHa7JzY=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=pKG0g+7aJKDqTRkJKU/Ri58DYi0P5S/USnJ
 JcgaU8qoa8jAi04z5vGGaby8g8KGLpI71fvxHHeab1j8jY08dTPXXLBFrges+ZCfkO6WMr
 Jmq15DgUrGhf9t8LQoi3Mvde8ESicU8ahbgtPjpFZT98uzTTb39YOGlXHFlfmM0ze+2DAp
 nvpD91EJQvgyqAYyLHuF4KBuHB3fFTqVrdGZVUrkzKtbrz3gZN4LWPSQ2QIdC2LnBuCjC/
 NqyAbE3Zr6JV2kqjACnTH71pXerENA69SPpM3JayZZ6MGT11dCoSW06AiO2fKU/Epda/EE
 w5UZVshhRGIHsyLMPb3czI8DGyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=OnOzc/xFLlIzWsGfWekLrWErwBi3UvwPP5rpaHa7JzY=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=ApZiVVbiwSEunlu8W3
 s8X/ze+vUdGIYLUqaCll25heumRDY3wPlPqnOtqXK0DtkMrkso3Abq5KKCkPYGXLZwBw==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id c61819eb
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Mon, 13 Jul 2026 13:20:16 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 2364ce22;
 Mon, 13 Jul 2026 13:20:13 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH 3/9] target/mips: fix MIPS64 segment access checks
Date: Mon, 13 Jul 2026 13:16:31 +0200
Message-ID: <20260713112004.4956-4-kirill@korins.ky>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713112004.4956-1-kirill@korins.ky>
References: <20260713112004.4956-1-kirill@korins.ky>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

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
index 746dbf8aa4..626d7ccc4c 100644
--- a/target/mips/system/physaddr.c
+++ b/target/mips/system/physaddr.c
@@ -143,7 +143,9 @@ int get_physical_address(CPUMIPSState *env, hwaddr *physical,
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
@@ -151,8 +153,8 @@ int get_physical_address(CPUMIPSState *env, hwaddr *physical,
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
2.54.0


