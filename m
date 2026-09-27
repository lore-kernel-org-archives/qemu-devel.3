Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90387C9833F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAjK4-0003Uh-Pt; Sun, 27 Sep 2026 03:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAjJ9-0001Tb-82; Sun, 27 Sep 2026 03:28:24 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAjJ7-0005cx-Ch; Sun, 27 Sep 2026 03:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790494014; bh=mScn57nSfFKiWsR2gjykJjgAHLKsYoWtWgKRoIM2VfA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eGgcCUpzcYUSrME4nSwt4cBIJTB352oD66b3L8Tc5W2qbTsUBU4j5XMN402RCcHfv
 dN6pai3uznxDFDrTa3ctYhAB+/khqG59TydjCdHs6qVmwq7E7TElu/LHSYI+ovTwBb
 Xhh72p6060OfIBdT4pXdCqOLbpkce46hvGvgRVi1OXGFIoKjJAvmvJzPWlTWJ5EqXg
 RmwyE3COiUrkU+g4eF1jSKA+AM4uXa1I3eUyns/8f4tJK0S9vucCBgxxm4frD/4oSx
 Uq9BTzDqlNp47Wn9tyGK8Mripmdx8EfvfKrmqw+s79JWLO/y8WbQttbRSaqlKA6Ivx
 iYvHnzf47bTAQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 106481D8AC8;
 Sun, 27 Sep 2026 10:26:54 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0E0C443205A;
 Sun, 27 Sep 2026 10:26:54 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 1528F5E63F; Sun, 27 Sep 2026 10:26:53 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Andrey Polivoda <apolivodaa433@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 v2 70/72] target/i386: Mark MOVNTI as not valid with
 prefixes 0x66, 0xF2, 0xF3
Date: Sun, 27 Sep 2026 10:26:02 +0300
Message-ID: <20260927072622.93656-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260927020824@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260927020824@cover.tls.msk.ru>
MIME-Version: 1.0
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Andrey Polivoda <apolivodaa433@gmail.com>

According to both table A-3 in Volume 2 of Intel 64 and IA-32 Architectures
Software Developer's Manual and table A-3 in Volume 3 of AMD64 Architecture
Programmer's Manual, 0F C3 is decoded as MOVNTI only if the instruction is
not preceded by prefixes 0x66, 0xF2, or 0xF3.

Currently, QEMU does not check the presence of these prefixes when decoding
0F C3, which leads to QEMU happily executing 0F C3 as MOVNTI instead of raising
an expected #UD when any of these prefixes are present, which does not match
the behavior of the real hardware.

This patch fixes this bug by correcting the decode table for MOVNTI so that
it requires that none of the 0x66, 0xF2, and 0xF3 prefixes is present.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Fixes: 3519b813e1f1 ("target/i386: port extensions of one-byte opcodes to new decoder")
Signed-off-by: Andrey Polivoda <apolivodaa433@gmail.com>
Link: https://lore.kernel.org/r/20260818145837.550059-1-apolivodaa433@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 6adc9d9cdc53e2299f3343950d519b6f26e114de)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 16ea52e9d5c..704858ff57b 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1265,7 +1265,7 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xc0] = X86_OP_ENTRY2(XADD,       E,b, G,b,            lock),
     [0xc1] = X86_OP_ENTRY2(XADD,       E,v, G,v,            lock),
     [0xc2] = X86_OP_ENTRY4(VCMP,       V,x, H,x, W,x,       vex2_rep3 p_00_66_f3_f2),
-    [0xc3] = X86_OP_ENTRY3(MOV,        EM,y,G,y, None,None, cpuid(SSE2)), /* MOVNTI */
+    [0xc3] = X86_OP_ENTRY3(MOV,        EM,y,G,y, None,None, cpuid(SSE2) p_00), /* MOVNTI */
     [0xc4] = X86_OP_ENTRY4(PINSRW,     V,dq,H,dq,E,w,       vex5 mmx p_00_66),
     [0xc5] = X86_OP_ENTRY3(PEXTRW,     G,d, U,dq,I,b,       vex5 mmx p_00_66),
     [0xc6] = X86_OP_ENTRY4(VSHUF,      V,x, H,x, W,x,       vex4 p_00_66),
-- 
2.47.3


