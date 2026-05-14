Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF243CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNa20-0001i0-KO; Thu, 14 May 2026 13:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa18-0000tK-MD
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:41 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa10-0004AQ-Uh
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:37 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7dca00c1591so2818521a34.3
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780309; x=1779385109; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OI7Nnr0/XFDg2DGEIke6C43YaOPcPxGOk89iy/MfMjE=;
 b=BN1miQe8klBDLi64b0X4QMVWIwxH9pEWuq9DAmO0YOlk0Q/6Xc/uPJU+fCsA7HYR2R
 4A10puEOHG0+lDm8vnRegugdwcSRwQ3JgcF8YeA47FlvNeNGpQ5+jEs4PWbMWn7DxaXR
 +h11PfhhDcG7pMp3fkI6XlOSpoxhd1ZC1skFmQ7gJs0ewPFmicGOikueDK60LCoQEdY1
 ZB+mpiIFU6JWU6zMgR3ebRpCozT+bPtOEIbE6WSi068LKOgA87Lr/kgBQoA4/v2Kokfm
 qwp8gYUmnwMfP7eAZV5MYWp9YX9F0C8fxsSTzpi7pxtVcRGqoXlFU+jJzSy6jOfQDlub
 NLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780309; x=1779385109;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OI7Nnr0/XFDg2DGEIke6C43YaOPcPxGOk89iy/MfMjE=;
 b=ixn3kQS6DgiMiwrjtOZJMWcrN5uqyhiBbiYlmv9oo4i9pvBRXmP+g5BK7Iq5fC8Xw6
 SkoTTim9rFHltYoNtotM0DZ2FN1XXO183l7EEZ4yK3t1IhpCWJKDLEMt04WNurfwbOrF
 MBSUzNg5y7FYy65USa/OJGEGZ6Oyt7aWDYWkph3kfAz0sFk2w2fFVTL87cWv7NX/Vnd8
 TNwrgYMSY9LNQmw60zDp0K+g8ou3KeBeVxtWsv8HX/q6exly4xmSn3Dpvyfxv3J7qdYY
 o6tKIB7S31nuYeS32roy99O55X9QhuSlfOfZsvJRbS0X3ykIKWihTQEwz9FTMcS9aFFD
 tzGw==
X-Gm-Message-State: AOJu0Yy5Xczq8Z7EjXOFUzARhUKcPh6iWAGe5PqjD7FA9qHUtJBQ8r5u
 lf20t+g5oaYFx4AOQwkQULqAP19qN2ouopXjU6RPuh0dZzmMeQkZHVKm5uuhuQ==
X-Gm-Gg: Acq92OFtV74vXotJa00hsHBGRXfLwevmshyjxyJ1gmIjHXw569MK7W+KoguNoTbFPTJ
 +Fjn8nFh8pYa1UYvhj8X641JlUP1Ks+cFBiavVR88+U9NPCNvV8UvpfrHa7J25wCd6AJinNRl6s
 +tDnrdgcOPgIahT6HTKqoVUuEd3GwxO2fjaaiZKQFRAJ0jXF4g6riSv3NJNOTjVHpdhtq81kM5O
 waety5MRV75XpRFBU9B9O3c7RgRHQOeSyDGcjL9zboaRxSxXEYFEQsPi45TTl+ednfOYTHSux4f
 PgSmf6YSU++8diR5bsDZnOQKjOWv95PWb2ruZePe9k6eE20iTP84i0D0cqJhSYipuKm+b22unbl
 Fk1wlwaKkp9vtKjmcEOTihAcpw/L0vGtx1hzomEsi6/a8TCSQbeqoA8a5KxpvnvntE2Dr3NW6D3
 qEvCsj7FSbb5QRfXHtHG+LKUUAFMEnqhDtW3Mzgf8qJk4bGooEovjoQG0G6dmSBsgE6XAME49x0
 Vc8YAKvQ5brqheQqduf1zGksKdIx58w2Hjrd75qFFxfl5ft3Y6GW5AIoxs9A/RsCxnP
X-Received: by 2002:a05:6820:8188:b0:696:9364:c284 with SMTP id
 006d021491bc7-69c9c02054emr242496eaf.44.1778780308753; 
 Thu, 14 May 2026 10:38:28 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b8ccdc74esm1687254eaf.13.2026.05.14.10.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:38:27 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 14 May 2026 11:37:23 -0600
Subject: [PATCH v7 34/35] tests/tcg/mips: cover Octeon QMAC and CvmCount
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-mips-octeon-missing-insns-v2-v7-34-226686be4ce1@gmail.com>
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x332.google.com
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

Extend the Octeon linux-user smoke test with QMAC/QMACS fixed-point
accumulator checks and an RDHWR $31 monotonicity check.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 57 +++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index 435ccfa347..1dbdd9f52a 100644
--- a/tests/tcg/mips/user/isa/octeon/octeon-insns.c
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -129,6 +129,59 @@ static uint64_t octeon_vmm0(uint64_t mpl0, uint64_t p0,
     return rd;
 }
 
+static uint64_t octeon_qmac_lo(uint64_t rs, uint64_t rt, uint64_t lo)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        "mtlo %[lo]\n\t"
+        "mthi $0\n\t"
+        ".word 0x710904d2\n\t" /* qmac.03 $8, $9 */
+        "mflo %[rd]\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt), [lo] "r" (lo)
+        : "$8", "$9");
+
+    return rd;
+}
+
+static uint64_t octeon_qmacs_state(uint64_t rs, uint64_t rt, uint64_t lo)
+{
+    uint64_t hi, rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        "mtlo %[lo]\n\t"
+        "mthi $0\n\t"
+        ".word 0x71090012\n\t" /* qmacs.00 $8, $9 */
+        "mfhi %[hi]\n\t"
+        "mflo %[rd]\n\t"
+        : [hi] "=r" (hi), [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt), [lo] "r" (lo)
+        : "$8", "$9");
+
+    return ((hi & 1) << 32) | (rd & 0xffffffff);
+}
+
+static uint64_t octeon_rdhwr31_non_decreasing(void)
+{
+    uint64_t first, second;
+
+    asm volatile(
+        ".word 0x7c08f83b\n\t" /* rdhwr $8, $31 */
+        ".word 0x7c09f83b\n\t" /* rdhwr $9, $31 */
+        "move %[first], $8\n\t"
+        "move %[second], $9\n\t"
+        : [first] "=r" (first), [second] "=r" (second)
+        :
+        : "$8", "$9");
+
+    return second >= first;
+}
+
 static uint64_t octeon_vmm0_zeroes_mpl1(void)
 {
     uint64_t rd;
@@ -259,6 +312,10 @@ int main(void)
     assert(octeon_seq(0xabc, 0xdef) == 0);
     assert(octeon_sne(0xabc, 0xabc) == 0);
     assert(octeon_sne(0xabc, 0xdef) == 1);
+    assert(octeon_qmac_lo(0x0003000000000000ULL, 2, 1) == 13);
+    assert(octeon_qmacs_state(1, 1, 0x7ffffffe) == 0x17fffffffULL);
+    assert(octeon_qmacs_state(0x8000, 0x8000, 0) == 0x17fffffffULL);
+    assert(octeon_rdhwr31_non_decreasing());
     assert(octeon_vmulu(5, 7, 11) == 46);
     assert(octeon_vmm0(5, 13, 7, 11) == 59);
     assert(octeon_vmm0_zeroes_mpl1() == 0);

-- 
2.54.0


