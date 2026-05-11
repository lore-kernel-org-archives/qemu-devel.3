Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECE0CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVI8-0005Rj-6q; Mon, 11 May 2026 14:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHq-0004uH-VF
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:29 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHp-0002we-1Y
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:26 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7dbe437b072so2660856a34.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523804; x=1779128604; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OI7Nnr0/XFDg2DGEIke6C43YaOPcPxGOk89iy/MfMjE=;
 b=cO/P5JRwlaSPyhBYOMdiKjt3oULLGWU7I6VLbihDbuQncXMoU0ucR64kDmVM3VQQon
 EQIFov/DWfkvz8kipEsgKJaTas1wbd8io+if2drswRIm+hWxf6XOW2rIlZvnd7vsk8Am
 W1ewY8o4foc2e7lubxrePTOiC7S15Y+3dN24XiuhImF5yB194qTPCxND82j0YpCZexBW
 jwZ/aIbfWdywHOxnSre0TtX2GtiRkvslLYt4kxSZ/l0Hyod+ZVFtvhGRNvHoQ6B78T1e
 BfviWYOobE1IT43Gs9wjCrrp03AbGuFZY2dNjhZwD38taC2O7bRe2AwS8BpNbJDar86W
 dOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523804; x=1779128604;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OI7Nnr0/XFDg2DGEIke6C43YaOPcPxGOk89iy/MfMjE=;
 b=tYQiH5H/gTQS4fGyNaw2+SNHhwoYfKojzf2WyyHDP7UHSfu9qHBapGrFps/YnlizP7
 7WFXFRiPXM+Uy4rHFmbODaV/yumwZOcDkI2sRDnsSzj1vtQvJ0SozA/hILN3l6sOAVVt
 eVtOTuxIwyuov98u8BwUjhadp5oUmHzjbq9/8Seue0PAMmkHheIQkBCeJ1HCaCoiM41i
 nTXUbgFXkJFOqj6vSXtEIymZF/zEmQCKUsO4VSRh0yzJl/IZ5EvjuW32VlpIRF2fQfHz
 oHkLSfR3HS5uosBDtxbn/+u4z/80SGFnrPxIhhKLkKq6rEBcIg6l3ihbMqXAhYEsHRVf
 YChQ==
X-Gm-Message-State: AOJu0YzED0X3cR/i3uC8hTcRulhp08W3qhJXAHIy0ZAWJaV/SVy+bx6s
 QrUNTbUIXtMAfcb+Wqcd8IKo9q6jo7pQCzLnyCgLxa7ZdtClv+zuOygZ
X-Gm-Gg: Acq92OHcAgsUi0VhA1+38YdjqI8cHPxXdZ+DRWGuHBjZO7OtIrEZnszctIxntvmXEEj
 IlakPgsHAJuzCOfTjuNStagjeuOkOLxqAWQJT88j8iYpGHL1txYY9+IZdeSCpZ0O8Wr1IFyQL0a
 whmOjye9bC5M8Woaf8b9BkNEYa0OtVZadhIfOkPT7FY1WxtgaWfzygGcRQ7enpHjcuM2l5EY6Ox
 GZgYi9BYu3NGcWeGldtgsya+N2wy4lR+4c+BMX0JyKIOKq304fhH+LRYcBkPlHOHskp6eEddnTh
 LG1TeFurbpK7AZQKeTrOFuFOO/BJ0EmHegtreeO/mUbsUwDGDh1EiR3iX99oI1trLOz55UVC+OE
 bKzaIzGhQZajoeiVIT4ozDBZ5iEp31dTkqWIyu8Xa1RWYnSzBeRs1ByeR8trB5XRZDnQkGZx/WA
 owQ32x9G3oQo5i1mTaEApVkqS3LQ0b4hhtYLMO+ccFe9Dqpg76MqepxEzDTMO5PgHFkv0Me5o4n
 M7IegVvlWHeH1yyyUt1oajfRMYNLcz+hOfRxleoWU06G9cgzVWH60fg9+xOsAUc8+wY0J4AxQ4U
 8vQ=
X-Received: by 2002:a05:6830:3905:b0:7dc:cd0b:58b0 with SMTP id
 46e09a7af769-7e1ded2b16fmr15493680a34.3.1778523803897; 
 Mon, 11 May 2026 11:23:23 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:23:23 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 12:23:05 -0600
Subject: [PATCH v6 34/35] tests/tcg/mips: cover Octeon QMAC and CvmCount
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-34-5062889c4d3c@gmail.com>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32f.google.com
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


