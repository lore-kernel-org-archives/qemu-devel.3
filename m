Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6CEF327D4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 17:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFEtQ-00041x-S0; Tue, 21 Apr 2026 13:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wFEt5-0003mD-H5
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 13:27:53 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wFEsw-0006h0-Me
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 13:27:44 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-415e568a7ecso1911196fac.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 10:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776792461; x=1777397261; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Gu2YLJ24XV2eW3iG8BpKQlGIGVRYDVb1RgP8oSGX5xg=;
 b=BGOc3Edi6E5jfO0NLq6/pSZ/ajRljuiF3REC0u5SCga9jRdAoBwxChQ+d7upH13C9T
 hdkN5nNS9oI+hgGeIMgIcV5KoYq72HHs5LcWUjwWDzWsw6+ihPrk8DEagPa1Y/zFjWXz
 hYlgACWFuCOGYeJAd3GoTtMjAMxUXx+jvYF4X1LTpoHSIs4wjhdGJFkSwM0Pi7QDNMg2
 c7RsP59DzOuZ2p2Pv9nfjlGIt/IraabifIsKmbNcnBsaA25sm5FWu8b4soH4PL0TiYgp
 cGT9q/XC8VH0jRKOO/lu9l/UjQmwu48fwrZmr5c/oAFivApU+iwYrt1u3E4DJB30MHJa
 hk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776792461; x=1777397261;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Gu2YLJ24XV2eW3iG8BpKQlGIGVRYDVb1RgP8oSGX5xg=;
 b=iTYoJiklclVfIdsVxvgkqsoue2HUtRlV/bCG6TdGC7qbxC2FxX9eAj8ODMacO4WZDU
 u/rq5d7zXaorWoVRfnDAt3YBgfKSLxolPbQEUVDqma82D90LAQtzu9M8+u4ebq4d0rN+
 4O1pD9XvRa12XUrrkCbUGCx+6j5JurMkZ2NCX/mTCR0wwf60pZCqvbPiV6UiQ/kcJLSd
 TAnvXeMVMFOhpUNZWBXjkRyprnfoeGE1neeey4PVirobMgnGOVl+tOL2Hc97B7GrE3CM
 UFojQ6/iT58B4TnQ65aE2ssrgCZ51BKRELC75ILspvKnsSO7RBWZQr0zwTER7Uute30j
 Wjcw==
X-Gm-Message-State: AOJu0YzUQFXYh8HWRQrCtDzC85ozfCEvA8fD4wi6c2RZ1UWXkN5dT8B7
 +lyxquitcQ376B6+8mpn/qQMqf6SJ5U25Iu/gIzTxlLzszScu5b02PhL
X-Gm-Gg: AeBDieu1WsDpLJ4lHXDB2lTxAwtXgyd/3sUAjidyDiw0WvseWps4p6e8lmemumL3qYF
 y/QF2XW20lnmdhvSYfiUtfHsaT6EaFdHRan/gYWM4Vw6brbnH88xwPkKjHI/MBRSA+gFPyl8Iss
 9PTeu7728cxNJedmOOWS0q//Kg1surJnuI4iiPG4NNHOmRuFiRh4Lb0iz9gEFkBLGWYwrx6EqlG
 ZArmeJ+9eu0dbFofOgXXBKMw3x74qdMIEUIBu6rQ6o/xcSaWa8aeo55BSqUQg75Hg2eJ5ydigW4
 CGsQnqaXT0I++O0YnkP6+kG9t20bAK9iu4o8/DwqfVpOXgkkBxG/IrF6z2zzAVQRQRyZQoWhsUe
 KJNdAvT236V+Fj+DVVlpeGimkCqKpGPiviB3h2OO5QHTssydkQ+Xzm+cAh8G3q7sOgEWkEmTnCz
 CArpltNvzoYQk+YeMXOk/A9kCl8wfgrXv29mPrKjNt2J2VHxym63/Bym1owHhYrVuhzkR6djdC4
 mMkWyZqrXMPrU//ziiIl1gQ3ke1fh4mRUfD0iuVJsrzrBSjY2hNssze5Bb0wJxOdCe29UyESr5Z
 MUD484BY15/pF2lO
X-Received: by 2002:a05:6871:384e:b0:42c:2464:4ec3 with SMTP id
 586e51a60fabf-42c2466f612mr2412690fac.38.1776792461139; 
 Tue, 21 Apr 2026 10:27:41 -0700 (PDT)
Received: from mac.localdomain (97-118-149-104.hlrn.qwest.net.
 [97.118.149.104]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b8fe2c52bsm12209290fac.0.2026.04.21.10.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 10:27:40 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 21 Apr 2026 11:27:29 -0600
Subject: [PATCH v2 02/13] target/mips: fix Octeon arithmetic destination
 handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260421-mips-octeon-missing-insns-v2-v2-2-a0791df188c9@gmail.com>
References: <20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com>
In-Reply-To: <20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

BADDU and DMUL write their results to rd, not rt. Avoid treating rt ==
$zero as a nop, and route writes through gen_store_gpr() so rd == $zero
is handled consistently.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Split the BADDU/DMUL destination handling fix out of the Octeon
    arithmetic instruction patch.  (suggested by Philippe Mathieu-Daudé)
---
 target/mips/tcg/octeon_translate.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index b2eca29e06..41e0d770f5 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -45,7 +45,7 @@ static bool trans_BADDU(DisasContext *ctx, arg_BADDU *a)
 {
     TCGv t0, t1;
 
-    if (a->rt == 0) {
+    if (a->rd == 0) {
         /* nop */
         return true;
     }
@@ -55,8 +55,9 @@ static bool trans_BADDU(DisasContext *ctx, arg_BADDU *a)
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
-    tcg_gen_add_tl(t0, t0, t1);
-    tcg_gen_andi_i64(cpu_gpr[a->rd], t0, 0xff);
+    tcg_gen_add_i64(t0, t0, t1);
+    tcg_gen_andi_i64(t0, t0, 0xff);
+    gen_store_gpr(t0, a->rd);
     return true;
 }
 
@@ -64,7 +65,7 @@ static bool trans_DMUL(DisasContext *ctx, arg_DMUL *a)
 {
     TCGv t0, t1;
 
-    if (a->rt == 0) {
+    if (a->rd == 0) {
         /* nop */
         return true;
     }
@@ -74,7 +75,8 @@ static bool trans_DMUL(DisasContext *ctx, arg_DMUL *a)
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
-    tcg_gen_mul_i64(cpu_gpr[a->rd], t0, t1);
+    tcg_gen_mul_i64(t0, t0, t1);
+    gen_store_gpr(t0, a->rd);
     return true;
 }
 

-- 
2.53.0


