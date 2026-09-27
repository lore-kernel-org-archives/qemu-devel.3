Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39F7C98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAksc-0000Kr-6d; Sun, 27 Sep 2026 05:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkrf-0002xM-EX; Sun, 27 Sep 2026 05:08:08 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkrd-0008Fu-BJ; Sun, 27 Sep 2026 05:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790499961; bh=Efpnn7ZN5eb3wLnqdfxtKkWPj55g8PGCMQPViKUJMxU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=qHSzbHPlSr115BOCAFZrP9hd1N6E1iKiWWVjP/dufjKWqSThK7Z1giwlnuGEuPyXb
 nU4xEhRzf2TMcATK2vTx4MX2NBImRxBKAaytkvXwVrW0uXPrJyeB394x1O+DYEbZa/
 PO+b47sJ/HTJaFRmbFNAPgjhnY87DuTko8npq1gjv6NU2gfHN48mSCLueDt+PIjcUB
 fFvBR7xxgVwTGZtFk874Ke+vlftThXgHYlmsHvJFpWSbIQ/NJi6N8XXnfF+xS7Bidv
 Kv5vQVTJ1/eu48WoKj6+Ox10fJ8vC1VLU9f/gl45T7m9jbyBq1tfIH3y3B9BOcBshx
 V3CycM6sW7aGQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8F9351D8B25;
 Sun, 27 Sep 2026 12:06:01 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8CA2C4320DE;
 Sun, 27 Sep 2026 12:06:01 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id F02E15E67B; Sun, 27 Sep 2026 12:06:00 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Andrey Polivoda <apolivodaa433@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 v2 84/86] target/i386: Mark MOVNTI as not valid with
 prefixes 0x66, 0xF2, 0xF3
Date: Sun, 27 Sep 2026 12:05:31 +0300
Message-ID: <20260927090540.102811-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
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
index 0ae192835e6..3905ce19cc5 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1389,7 +1389,7 @@ static const X86OpEntry opcodes_0F[256] = {
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


