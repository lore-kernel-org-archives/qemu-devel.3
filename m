Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E6CEC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 13:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjzv3-0005Xt-EY; Wed, 15 Jul 2026 09:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjzv0-0005WD-0j
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 09:44:58 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wjzuy-0007tj-Dx
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 09:44:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=Ti53ne6
 d2jvcPHcXNQ0kzqezW2C38SNRcjJZLFXLYaa06qH6V2Zo2/BtWphk5TsuZjCsz3xfgKCci
 sCe6XjaJOg3kXYV0wwfv6YDzhNFx+2B+LS0x8Hx7eeFqHi3/BFL0jMOR7dD/YpXPXk0YE6
 igBXdc77NGJF6w+rXR6+yQJv79D5tIzvX7Vlv8AoHFL+ziEP5uoY7NRLKpPsNy18e/E59T
 ZEgh3ODcUS2ZPPhwSS9K7vg6tZW+9e2ffm/DEYQZAc5WTkYDQD0mbXr+TCHfeZLVnxsujh
 8pW4UKzt7jdN6jo09u/GLV938Bh+ta7PDb3dRz/Sb31J+WJfnV3UVFA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=p
 QgaFwBfH2WRlTWcwX1VVdSzuQK3HKOK1hbZcrUPRaU=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=m3CqlcIlp3BYu6lyYLvrnlTrNilY9i0rArgU5w0S0YpERhnTYUbNn9lQTjXgOb+tq+cC
 tgXnJ/K63Q/UqhTqddbn+SlhzxtJtSmYKWpRWdmIWqTntdbKOWsN1ZJLnchb88K2933MWD
 XsnmtBvALuO3uJatgRMMRJDDZw3DRGM5JFesjgSS2iTjsNgrFCUykMwuNcUVnM0wcWFhvq
 bEBbowvkdF5tMYOgvJtsQzKDq1dT1E7j1ILRH+xAvsOLaEPznAtg8SXenV+rLngeavyc3U
 HH7uopdBRL8qFhoCgF0x2WV1xMwm85BcrsnNhvDtiSB27DG6sPVVAekHnfhg5vFA==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=SHnMwXJG; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=DHWCnELH;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=pQgaFwBf
 H2WRlTWcwX1VVdSzuQK3HKOK1hbZcrUPRaU=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=SHnMwXJGCj6j6U2psJPrlRgtSH14CdjDOeZ
 eYc4IhkQR3BCJAi7J8NS9Gx0SSw92MT/6nWy/gxOS91rjFsFfNvbFDL64gQo+52XWd9YDP
 1KeO8fzP6uWd7yZD3FaAlwa1aBhQcq5VI7mX+U44Rr3CoiJDzM+L7enmAJOgbkcTWZ/W16
 A5miJhYsWVIRqnICyA6VKTlCgqGpoc9v4e46DXzyDz4uHFLfHmhgvfxek7CZpB0pJTyots
 MRFiBPXT7E0bbHTSudsmns1jS1zIzyKSz0ai9UL3pMSYMNR3jCb0WXMgtsK6k8cqLHppyI
 sx8Ee7jWJMa0hy/bmldvDvectgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=pQgaFwBfH2WRlTWcwX1VVdSzuQK3HKOK1hbZcrUPRaU=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=DHWCnELHhPfGg380SK
 tnZl9oGw6Q7MtGA1lykDp2R28MEyJor+k774oPUssWCjsxfYBroO7HhC6SjxDX0ABiCw==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id a9292252
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Wed, 15 Jul 2026 15:44:50 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id ab459214;
 Wed, 15 Jul 2026 15:44:48 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v2 02/25] target/mips: fix MIPS64 segment access checks
Date: Wed, 15 Jul 2026 15:43:48 +0200
Message-ID: <20260715134447.56007-3-kirill@korins.ky>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715134447.56007-1-kirill@korins.ky>
References: <20260715134447.56007-1-kirill@korins.ky>
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


