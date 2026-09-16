Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0FAC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6jl8-00066j-K5; Wed, 16 Sep 2026 03:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jky-0005wP-FB; Wed, 16 Sep 2026 03:08:37 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jks-0008KR-3G; Wed, 16 Sep 2026 03:08:36 -0400
Received: from xiaoou-ubuntu-02.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowACXaOxHQKpq3zYkCA--.4143S21;
 Wed, 16 Sep 2026 15:08:06 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: nutty.liu@hotmail.com, max.chou@sifive.com, xiaoou@iscas.ac.cn,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 19/19] tests/tcg/riscv: Add tests for the P extension
Date: Wed, 16 Sep 2026 07:07:21 +0000
Message-Id: <20260916070721.3279229-20-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
References: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACXaOxHQKpq3zYkCA--.4143S21
X-Coremail-Antispam: 1UD129KBjvAXoWDKw4xJF13GrWUXFyrtw45Awb_yoW3uFy5Ao
 W8XrW3JFWfKr48Cw1kAr1UX3WkXw1Iq3ZrKFnxJw4UGayUXr4xXFyDAr1rCa4kK34DXr1Y
 y34ayF95tw45JF1kn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUY_7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJV
 WxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
 3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
 02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S
 6xCaFVCjc4AY6r1j6r4UM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
 kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4U
 JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0x
 vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUoBTYUUUUU
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: 50ld003x6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.21; envelope-from=xiaoou@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.74,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

Add freestanding RV32 and RV64 packed SIMD assembly tests, shared test
macros, and TCG Makefile integration. Use PSIMD_CC to select a P-capable
Clang with support for the P v0.21 assembler options.

Cover arithmetic, shifts, multiplication, narrowing and saturation,
register overlap, zero register-pair operands and vxsat side effects.
Include regression cases for oversized rounding right shifts, SHLR
rounding overflow and zero register-pair narrowing sources.

Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
---
 tests/tcg/riscv/psimd-common.S        | 1105 ++++++++++++++++++++++
 tests/tcg/riscv/psimd-rv32.S          | 1256 +++++++++++++++++++++++++
 tests/tcg/riscv/psimd-rv64.S          |  578 ++++++++++++
 tests/tcg/riscv/psimd-test-macros.inc |  952 +++++++++++++++++++
 tests/tcg/riscv32/Makefile.target     |   30 +
 tests/tcg/riscv64/Makefile.target     |   25 +
 6 files changed, 3946 insertions(+)
 create mode 100644 tests/tcg/riscv/psimd-common.S
 create mode 100644 tests/tcg/riscv/psimd-rv32.S
 create mode 100644 tests/tcg/riscv/psimd-rv64.S
 create mode 100644 tests/tcg/riscv/psimd-test-macros.inc
 create mode 100644 tests/tcg/riscv32/Makefile.target

diff --git a/tests/tcg/riscv/psimd-common.S b/tests/tcg/riscv/psimd-common.S
new file mode 100644
index 00000000000..61c64305e86
--- /dev/null
+++ b/tests/tcg/riscv/psimd-common.S
@@ -0,0 +1,1105 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Test cases shared by RV32 and RV64.  Included from psimd-rv*.S. */
+
+#if __riscv_xlen == 32
+    /* PLI.B: zero, one, high immediate bits, and a mixed-bit pattern. */
+    TEST_PSIMD_LI 1, pli.b, 0xa5, 0xa5a5a5a5
+    TEST_PSIMD_LI 1, pli.b, 0, 0
+    TEST_PSIMD_LI 1, pli.b, 1, 0x01010101
+    TEST_PSIMD_LI 1, pli.b, 0xff, 0xffffffff
+    TEST_PSIMD_LI 279, pli.h, 0, 0
+    TEST_PSIMD_LI 279, pli.h, 1, 0x00010001
+    TEST_PSIMD_LI 279, pli.h, 511, 0x01ff01ff
+    TEST_PSIMD_LI 279, pli.h, -512, 0xfe00fe00
+    TEST_PSIMD_LI 280, plui.h, 0, 0
+    TEST_PSIMD_LI 280, plui.h, 1, 0x00400040
+    TEST_PSIMD_LI 280, plui.h, 511, 0x7fc07fc0
+    TEST_PSIMD_LI 280, plui.h, -512, 0x80008000
+
+    /* PADD.B: distinct lanes, zero, wraparound, and both rd aliases. */
+    TEST_PSIMD_RR 2, padd.b, 0x7f120003, 0x7f340007, 0xfe46000a
+    TEST_PSIMD_RR 2, padd.b, 0, 0, 0
+    TEST_PSIMD_RR 2, padd.b, 0x7f80ff00, 0x01010101, 0x80810001
+    TEST_PSIMD_RR_RD_RS1 2, padd.b, 0x7f120003, 0x7f340007, \
+                         0xfe46000a
+    TEST_PSIMD_RR_RD_RS2 2, padd.b, 0x7f120003, 0x7f340007, \
+                         0xfe46000a
+
+    /* PSADD.B: no saturation, exact bounds, both overflows, and sticky. */
+    TEST_PSIMD_RR_VXSAT 3, psadd.b, 0x7f120003, 0x7f340007, \
+                        0x7f46000a
+    TEST_PSIMD_RR_VXSAT_STATE 3, psadd.b, 0x0102fefe, 0x01010101, \
+                               0x0203ffff, 0, 0
+    TEST_PSIMD_RR_VXSAT_STATE 3, psadd.b, 0x7e7e8181, 0x0101ffff, \
+                               0x7f7f8080, 0, 0
+    TEST_PSIMD_RR_VXSAT_STATE 3, psadd.b, 0x80808080, 0xffffffff, \
+                               0x80808080, 0, 1
+    TEST_PSIMD_RR_VXSAT_STATE 3, psadd.b, 0, 0, 0, 1, 1
+
+    /* PSATI.H width=5: exact bounds and values outside both bounds. */
+    TEST_PSIMD_RI_VXSAT 4, psati.h, 0x7fff8000, 5, 0x000ffff0
+    TEST_PSIMD_RI_VXSAT_STATE 4, psati.h, 0x000ffff0, 5, \
+                               0x000ffff0, 0, 0
+    TEST_PSIMD_RI_VXSAT_STATE 4, psati.h, 0x0010ffef, 5, \
+                               0x000ffff0, 0, 1
+    TEST_PSIMD_RI_VXSAT_STATE 4, psati.h, 0x7fff8000, 16, \
+                               0x7fff8000, 0, 0
+
+    /* PMHACC.H: nonzero rd, zero products, and signed-negative inputs. */
+    TEST_PSIMD_ACC_RR 5, pmhacc.h, 0x00010002, 0x7fff8000, \
+                      0x7fff8001, 0x40004001
+    TEST_PSIMD_ACC_RR 5, pmhacc.h, 0x12345678, 0, 0, 0x12345678
+    TEST_PSIMD_ACC_RR 5, pmhacc.h, 0, -1, -1, 0
+
+    /* PPAIRE.B uses a unique value in every source lane. */
+    TEST_PSIMD_RR 6, ppaire.b, 0xaabbccdd, 0x33445566, 0x44bb66dd
+    TEST_PSIMD_RR 6, ppaire.b, 0, 0, 0
+    TEST_PSIMD_RR_RD_RS1 6, ppaire.b, 0xaabbccdd, 0x33445566, \
+                         0x44bb66dd
+    TEST_PSIMD_RR_RD_RS2 6, ppaire.b, 0xaabbccdd, 0x33445566, \
+                         0x44bb66dd
+
+    /* Signed/unsigned byte comparisons deliberately disagree by lane. */
+    TEST_PSIMD_RR_SET 30, pmin.b, 0x807f00ff, 0x7f8000ff, 0x808000ff
+    TEST_PSIMD_RR_SET 31, pminu.b, 0x807f00ff, 0x7f8000ff, 0x7f7f00ff
+    TEST_PSIMD_RR_SET 32, pmax.b, 0x807f00ff, 0x7f8000ff, 0x7f7f00ff
+    TEST_PSIMD_RR_SET 33, pmaxu.b, 0x807f00ff, 0x7f8000ff, 0x808000ff
+    TEST_PSIMD_RR_SET 34, pmseq.b, 0x807f00ff, 0x7f8000ff, 0x0000ffff, -1
+    TEST_PSIMD_RR_SET 35, pmslt.b, 0x807f00ff, 0x7f8000ff, 0xff000000
+    TEST_PSIMD_RR_SET 36, pmsltu.b, 0x807f00ff, 0x7f8000ff, 0x00ff0000
+
+    /* Halfword extrema exercise signed and unsigned ordering. */
+    TEST_PSIMD_RR_SET 37, pmin.h, 0x80007fff, 0x7fff8000, 0x80008000
+    TEST_PSIMD_RR_SET 38, pminu.h, 0x80007fff, 0x7fff8000, 0x7fff7fff
+    TEST_PSIMD_RR_SET 39, pmax.h, 0x80007fff, 0x7fff8000, 0x7fff7fff
+    TEST_PSIMD_RR_SET 40, pmaxu.h, 0x80007fff, 0x7fff8000, 0x80008000
+    TEST_PSIMD_RR_SET 41, pmseq.h, 0x80007fff, 0x7fff8000, 0, -1
+    TEST_PSIMD_RR_SET 42, pmslt.h, 0x80007fff, 0x7fff8000, 0xffff0000
+    TEST_PSIMD_RR_SET 43, pmsltu.h, 0x80007fff, 0x7fff8000, 0x0000ffff
+
+    /* Wrapping subtraction and halfword addition/subtraction. */
+    TEST_PSIMD_RR_SET 72, psub.b, 0x0304fefd, 0x0101ff01, 0x0203fffc
+    TEST_PSIMD_RR_SET 73, padd.h, 0x7fff8000, 0x00018000, 0x80000000
+    TEST_PSIMD_RR_SET 74, psub.h, 0x7fff8000, 0x00018000, 0x7ffe0000
+
+    /* Signed byte saturation: positive and negative overflow. */
+    TEST_PSIMD_SAT_RR_SET 75, pssub.b, 0x0304fefd, 0x0101ff01, \
+                          0x0203fffc, 0x7f7f7f7f, -1, 0x7f7f7f7f, \
+                          0x80808080, 0x01010101, 0x80808080
+
+    /* Unsigned byte add overflow and subtract underflow. */
+    TEST_PSIMD_SAT_RR_SET 76, psaddu.b, 0x0102fefe, 0x01010101, \
+                          0x0203ffff, -1, 0x01010101, -1, \
+                          0xf0f0f0f0, 0x20202020, -1
+    TEST_PSIMD_SAT_RR_SET 77, pssubu.b, 0x0304fefd, 0x01010101, \
+                          0x0203fdfc, 0, 0x01010101, 0, \
+                          0x000100ff, 0x01020001, 0x000000fe
+
+    /* Halfword signed/unsigned saturated add and subtract. */
+    TEST_PSIMD_SAT_RR_SET 78, psadd.h, 0x00010002, 0x00030004, \
+                          0x00040006, 0x7fff7fff, 0x00010001, \
+                          0x7fff7fff, 0x80008000, -1, 0x80008000
+    TEST_PSIMD_SAT_RR_SET 79, psaddu.h, 0x00010002, 0x00030004, \
+                          0x00040006, -1, 0x00010001, -1, \
+                          0xf000f000, 0x20002000, -1
+    TEST_PSIMD_SAT_RR_SET 80, pssub.h, 0x00040006, 0x00010004, \
+                          0x00030002, 0x7fff7fff, -1, 0x7fff7fff, \
+                          0x80008000, 0x00010001, 0x80008000
+    TEST_PSIMD_SAT_RR_SET 81, pssubu.h, 0x00040006, 0x00010004, \
+                          0x00030002, 0, 0x00010001, 0, \
+                          0x000100ff, 0x00020001, 0x000000fe
+
+    /* Signed/unsigned average add/subtract with distinct byte lanes. */
+    TEST_PSIMD_RR_SET 109, paadd.b, 0x7f120003, 0x7f340007, 0x7f230005
+    TEST_PSIMD_RR_SET 110, paaddu.b, 0x7f120003, 0x7f340007, 0x7f230005
+    TEST_PSIMD_RR_SET 111, pasub.b, 0xffff0000, 0x11110001, 0xf7f700ff
+    TEST_PSIMD_RR_SET 112, pasubu.b, 0xffff0000, 0x11110001, 0x777700ff
+    TEST_PSIMD_RR 109, paadd.b, 0x7f7f7f7f, 0x80808080, -1
+    TEST_PSIMD_RR 110, paaddu.b, -1, 0x01010101, 0x80808080
+    TEST_PSIMD_RR 111, pasub.b, 0x80808080, 0x7f7f7f7f, 0x80808080
+    TEST_PSIMD_RR 112, pasubu.b, -1, 0, 0x7f7f7f7f
+
+    /* Halfword average operations exercise signed/unsigned divergence. */
+    TEST_PSIMD_RR_SET 113, paadd.h, 0x7f120003, 0x7f340007, 0x7f230005
+    TEST_PSIMD_RR_SET 114, paaddu.h, 0x7f120003, 0x7f340007, 0x7f230005
+    TEST_PSIMD_RR_SET 115, pasub.h, 0xffff0000, 0x11110001, 0xf777ffff
+    TEST_PSIMD_RR_SET 116, pasubu.h, 0xffff0000, 0x11110001, 0x7777ffff
+    TEST_PSIMD_RR 113, paadd.h, 0x7fff7fff, 0x80008000, -1
+    TEST_PSIMD_RR 114, paaddu.h, -1, 0x00010001, 0x80008000
+    TEST_PSIMD_RR 115, pasub.h, 0x80008000, 0x7fff7fff, 0x80008000
+    TEST_PSIMD_RR 116, pasubu.h, -1, 0, 0x7fff7fff
+
+    /* Shift-one add wraps; the signed form saturates and sets vxsat. */
+    TEST_PSIMD_RR_SET 117, psh1add.h, 0x07ffffff, 0x80007fff, 0x8ffe7ffd
+    TEST_PSIMD_SAT_RR_SET 118, pssh1sadd.h, 1, 2, 4, \
+                          0x40004000, 0, 0x7fff7fff, \
+                          0xc000c000, -1, 0x80008000
+    /* Absolute difference: signed and unsigned ordering deliberately differ. */
+    TEST_PSIMD_RR_SET 146, pabd.b, 0x7f7f01ff, 0x7f70ff7e, \
+                       0x000f027f
+    TEST_PSIMD_RR_SET 147, pabdu.b, 0x807f01ff, 0x7f01fffe, \
+                       0x017efe01
+    TEST_PSIMD_RR_SET 148, pabd.h, 0x00017fff, 0x00020001, \
+                       0x00017ffe
+    TEST_PSIMD_RR_SET 149, pabdu.h, 0xfffe7fff, 0x00010001, \
+                       0xfffd7ffe
+
+    /* Sum of unsigned byte differences, with and without old-rd input. */
+    TEST_PSIMD_RR_SET 150, pabdsumu.b, 0x807fffff, 0x7f0101fe, \
+                       0x0000017e
+    TEST_PSIMD_ACC_RR_SET 151, pabdsumau.b, 1, 0x807fffff, \
+        0x7f0101fe, 0x0000017f, 0x8080017d, 0x7f01037c
+    TEST_PSIMD_ACC_RR 151, pabdsumau.b, 0x12345678, 0, 0, \
+                      0x12345678
+
+    /* Saturating absolute value covers ordinary/minimum lanes and sticky. */
+    TEST_PSIMD_SAT_R_SET 152, psabs.b, 0x7fff0181, 0x7f01017f, \
+                          0x80008000, 0x7f007f00
+    TEST_PSIMD_SAT_R_SET 153, psabs.h, 0x7fffffff, 0x7fff0001, \
+                          0x80000001, 0x7fff0001
+
+    /* Reduction lanes are unique; signed and unsigned results diverge. */
+    TEST_PSIMD_RR_SET 154, predsum.bs, 0x7eff0180, 1, -1
+    TEST_PSIMD_RR_SET 155, predsumu.bs, 0x7eff0180, 1, 0x1ff
+    TEST_PSIMD_RR_SET 156, predsum.hs, 0x00030004, 0xa, 0x11
+    TEST_PSIMD_RR_SET 157, predsumu.hs, 0x10008000, 0x1000, 0xa000
+
+    /* Packed shifts: amount zero/one/maximum, truncation, and signed fill. */
+    TEST_PSIMD_SHIFT_RR_SET 172, psll.bs, 0x807f1201, 0x00fe2402, \
+                             7, 0x00800080
+    TEST_PSIMD_SHIFT_RR_SET 173, psrl.bs, 0x807f1201, 0x403f0900, \
+                             7, 0x01000000
+    TEST_PSIMD_SHIFT_RR_SET 174, psra.bs, 0x807f1201, 0xc03f0900, \
+                             7, 0xff000000
+    TEST_PSIMD_SHIFT_RI_SET 175, pslli.b, 0x807f1201, 0x00fe2402, \
+                             7, 0x00800080
+    TEST_PSIMD_SHIFT_RI_SET 176, psrli.b, 0x807f1201, 0x403f0900, \
+                             7, 0x01000000
+    TEST_PSIMD_SHIFT_RI_SET 177, psrai.b, 0x807f1201, 0xc03f0900, \
+                             7, 0xff000000
+
+    TEST_PSIMD_SHIFT_RR_SET 178, psll.hs, 0x80017fff, 0x0002fffe, \
+                             15, 0x80008000
+    TEST_PSIMD_SHIFT_RR_SET 179, psrl.hs, 0x80017fff, 0x40003fff, \
+                             15, 0x00010000
+    TEST_PSIMD_SHIFT_RR_SET 180, psra.hs, 0x80017fff, 0xc0003fff, \
+                             15, 0xffff0000
+    TEST_PSIMD_SHIFT_RI_SET 181, pslli.h, 0x80017fff, 0x0002fffe, \
+                             15, 0x80008000
+    TEST_PSIMD_SHIFT_RI_SET 182, psrli.h, 0x80017fff, 0x40003fff, \
+                             15, 0x00010000
+    TEST_PSIMD_SHIFT_RI_SET 183, psrai.h, 0x80017fff, 0xc0003fff, \
+                             15, 0xffff0000
+
+    /* Rounded shifts: odd/even lanes give guard bits one/zero. */
+    TEST_PSIMD_SHIFT_RI_SET 208, psrari.h, 0xfffd0002, \
+                             0xffff0001, 15, 0
+    TEST_PSIMD_RI 208, psrari.h, 0x0003fffc, 1, 0x0002fffe
+    TEST_PSIMD_SHIFT_RI_SET 209, srari, 0x80000001, \
+                             0xc0000001, 31, -1
+    TEST_PSIMD_RI 209, srari, 3, 1, 2
+
+    /* Pair/merge operations use unique bytes to expose every source choice. */
+    TEST_PSIMD_RR_SET 261, ppaireo.b, 0x11223344, 0xaabbccdd, \
+                       0xaa22cc44
+    TEST_PSIMD_RR_SET 262, ppairoe.b, 0x11223344, 0xaabbccdd, \
+                       0xbb11dd33
+    TEST_PSIMD_RR_SET 263, ppairo.b, 0x11223344, 0xaabbccdd, \
+                       0xaa11cc33
+    TEST_PSIMD_RR_SET 264, ppaireo.h, 0x11223344, 0xaabbccdd, \
+                       0xaabb3344
+    TEST_PSIMD_RR_SET 265, ppairoe.h, 0x11223344, 0xaabbccdd, \
+                       0xccdd1122
+    TEST_PSIMD_RR_SET 266, ppairo.h, 0x11223344, 0xaabbccdd, \
+                       0xaabb1122
+
+    TEST_PSIMD_R_SET 283, psext.h.b, 0x007f0080, 0x007fff80
+
+    /* Mask merge instructions prove that old rd participates bit-for-bit. */
+    TEST_PSIMD_ACC_RR_SET 292, mvm, 0xaaaaaaaa, 0x55555555, \
+        0x0f0ff0f0, 0xa5a55a5a, 0x55555555, 0x05055050
+    TEST_PSIMD_ACC_RR 292, mvm, 0xaaaaaaaa, 0x55555555, 0, \
+                      0xaaaaaaaa
+    TEST_PSIMD_ACC_RR_SET 293, mvmn, 0xaaaaaaaa, 0x55555555, \
+        0x0f0ff0f0, 0x5a5aa5a5, 0x55555555, 0x5f5ff5f5
+    TEST_PSIMD_ACC_RR 293, mvmn, 0xaaaaaaaa, 0x55555555, -1, \
+                      0xaaaaaaaa
+    TEST_PSIMD_ACC_RR_SET 294, merge, 0xaaaaaaaa, 0x55555555, \
+        0x0f0ff0f0, 0x5f5ff5f5, 0x05055050, 0x5f5ff5f5
+    TEST_PSIMD_RR_SET 295, pack, 0x11223344, 0xaabbccdd, \
+                       0xccdd3344
+
+    TEST_PSIMD_R 297, cls, 1, 30
+    TEST_PSIMD_R_RD_RS1 297, cls, 1, 30
+    TEST_PSIMD_R 297, cls, 0, 31
+    TEST_PSIMD_R 297, cls, -1, 31
+    TEST_PSIMD_R 297, cls, 0x40000000, 0
+
+    TEST_PSIMD_RR_SET 298, mseq, 0x80000000, 0x80000000, -1, -1
+    TEST_PSIMD_RR_SET 299, mslt, 0x80000000, 0x7fffffff, -1
+    TEST_PSIMD_RR_SET 300, msltu, 0x80000000, 0x7fffffff, 0
+
+    TEST_PSIMD_SAT_RI_SET 313, sati, 5, 15, 15, 16, 15, -17, -16
+    TEST_PSIMD_RI_VXSAT_STATE 313, sati, 0x7fffffff, 32, \
+                               0x7fffffff, 0, 0
+    TEST_PSIMD_SAT_RI_SET 314, pusati.h, 4, 0x000f0000, \
+                           0x000f0000, 0x00100010, 0x000f000f, -1, 0
+    TEST_PSIMD_RI_VXSAT_STATE 314, pusati.h, 0x7fff0000, 15, \
+                               0x7fff0000, 0, 0
+    TEST_PSIMD_SAT_RI_SET 315, usati, 4, 15, 15, 16, 15, -1, 0
+    TEST_PSIMD_RI_VXSAT_STATE 315, usati, 0x7fffffff, 31, \
+                               0x7fffffff, 0, 0
+
+    TEST_PSIMD_SAT_RI_SET 323, psslai.h, 1, 0x0001ffff, \
+                           0x0002fffe, 0x40004000, 0x7fff7fff, \
+                           0xbfffbfff, 0x80008000
+    TEST_PSIMD_RI_VXSAT_STATE 323, psslai.h, 0, 15, 0, 0, 0
+    TEST_PSIMD_SAT_RI_SET 324, sslai, 1, 1, 2, \
+                           0x40000000, 0x7fffffff, \
+                           0xbfffffff, 0x80000000
+    TEST_PSIMD_RI_VXSAT_STATE 324, sslai, 0, 31, 0, 0, 0
+
+    /* Signed variable shifts: positive means saturating left, negative right. */
+    TEST_PSIMD_SAT_RR_SET 328, pssha.hs, 0x0001ffff, 1, \
+                          0x0002fffe, 0x40004000, 1, 0x7fff7fff, \
+                          0xbfffbfff, 1, 0x80008000
+    TEST_PSIMD_RR_VXSAT_STATE 328, pssha.hs, 0x0003fffc, -1, \
+                               0x0001fffe, 0, 0
+    TEST_PSIMD_SAT_RR_SET 329, psshar.hs, 0x0001ffff, 1, \
+                          0x0002fffe, 0x40004000, 1, 0x7fff7fff, \
+                          0xbfffbfff, 1, 0x80008000
+    TEST_PSIMD_RR_VXSAT_STATE 329, psshar.hs, 0x0003fffc, -1, \
+                               0x0002fffe, 0, 0
+
+    /* Unsigned variable shifts: saturating left and logical rounded right. */
+    TEST_PSIMD_SAT_RR_SET 600, psshl.hs, \
+                          0x7ffe4000, 1, 0xfffc8000, \
+                          0x80004001, 1, 0xffff8002, \
+                          0xffff0001, 1, 0xffff0002
+    TEST_PSIMD_RR_VXSAT_STATE 600, psshl.hs, \
+                               0x80017fff, -1, 0x40003fff, 0, 0
+    TEST_PSIMD_SAT_RR_SET 601, psshlr.hs, \
+                          0x7ffe4000, 1, 0xfffc8000, \
+                          0x80004001, 1, 0xffff8002, \
+                          0xffff0001, 1, 0xffff0002
+    TEST_PSIMD_RR_VXSAT_STATE 601, psshlr.hs, \
+                               0x80030002, -1, 0x40020001, 0, 0
+    TEST_PSIMD_RR_VXSAT_STATE 601, psshlr.hs, \
+                               0x80017fff, -17, 0x00010000, 0, 0
+
+    TEST_PSIMD_SAT_RR_SET 332, ssha, 1, 1, 2, \
+                          0x40000000, 1, 0x7fffffff, \
+                          0xbfffffff, 1, 0x80000000
+    TEST_PSIMD_RR_VXSAT_STATE 332, ssha, -4, -1, -2, 0, 0
+    TEST_PSIMD_SAT_RR_SET 333, sshar, 1, 1, 2, \
+                          0x40000000, 1, 0x7fffffff, \
+                          0xbfffffff, 1, 0x80000000
+    TEST_PSIMD_RR_VXSAT_STATE 333, sshar, 3, -1, 2, 0, 0
+
+    /* Byte-selection multiply: signed and unsigned high-bit inputs diverge. */
+    TEST_PSIMD_RR_SET 344, pmul.h.b00, 0x7f80017f, 0x7f018001, \
+                       0xff80007f
+    TEST_PSIMD_RR_SET 345, pmul.h.b01, 0x7f80017f, 0x017f0180, \
+                       0xff80007f
+    TEST_PSIMD_RR_SET 346, pmul.h.b11, 0x80667f88, 0x017f0180, \
+                       0xff80007f
+    TEST_PSIMD_RR_SET 347, pmulsu.h.b00, 0x7f80017f, 0x7f018001, \
+                       0xff80007f
+    TEST_PSIMD_RR_SET 348, pmulsu.h.b11, 0x807f7f04, 0x017f0108, \
+                       0xff80007f
+    TEST_PSIMD_RR_SET 349, pmulu.h.b00, 0x7f80017f, 0x7f018001, \
+                       0x0080007f
+    TEST_PSIMD_RR_SET 350, pmulu.h.b01, 0x7f80017f, 0x017f0180, \
+                       0x0080007f
+    TEST_PSIMD_RR_SET 351, pmulu.h.b11, 0x80807f7f, 0x017f0180, \
+                       0x0080007f
+
+    /* High-half multiply distinguishes truncating and rounded variants. */
+    TEST_PSIMD_RR_SET 368, pmulh.h, 0x7fff0002, 0x7fff0003, \
+                       0x3fff0000
+    TEST_PSIMD_RR_SET 369, pmulhr.h, 0x7fff8000, 0x7fff8001, \
+                       0x3fff4000
+    TEST_PSIMD_RR_SET 370, pmulhsu.h, 0x7fff8000, 0xffff0001, \
+                       0x7ffeffff
+    TEST_PSIMD_RR_SET 371, pmulhrsu.h, 0x7fff8000, 0xffff0001, \
+                       0x7fff0000
+    TEST_PSIMD_RR_SET 372, pmulhu.h, 0x8000ffff, 0x7fff0001, \
+                       0x3fff0000
+    TEST_PSIMD_RR_SET 373, pmulhru.h, 0x8000ffff, 0x7fff0001, \
+                       0x40000001
+
+    /* Q15 multiply: rounding carry plus the unique min*min saturation. */
+    TEST_PSIMD_SAT_RR_SET 383, pmulq.h, \
+                          0x00017fff, 0x40007fff, 0x00007ffe, \
+                          0x80008000, 0x80008000, 0x7fff7fff, \
+                          0x80008000, 0x80008000, 0x7fff7fff
+    TEST_PSIMD_SAT_RR_SET 384, pmulqr.h, \
+                          0x00017fff, 0x40007fff, 0x00017ffe, \
+                          0x80008000, 0x80008000, 0x7fff7fff, \
+                          0x80008000, 0x80008000, 0x7fff7fff
+
+    TEST_PSIMD_RR_SET 389, pmulh.h.b0, 0x7fff8000, 0x01017f7f, \
+                       0x007fc080
+    TEST_PSIMD_RR_SET 390, pmulh.h.b1, 0x7fff8000, 0x01017f7f, \
+                       0x007fc080
+    TEST_PSIMD_RR_SET 391, pmulhsu.h.b0, 0x0010ffff, 0x01800001, \
+                       0x0008ffff
+    TEST_PSIMD_RR_SET 392, pmulhsu.h.b1, 0x0010ffff, 0x8001017f, \
+                       0x0008ffff
+
+    /* Scalar ABS wraps at INT_MIN, exactly as the SPEC bit-vector formula. */
+    TEST_PSIMD_R_SET 158, abs, -1, 1
+    TEST_PSIMD_R 158, abs, 0x80000000, 0x80000000
+
+#elif __riscv_xlen == 64
+    /* PLI.B: zero, one, high immediate bits, and a mixed-bit pattern. */
+    TEST_PSIMD_LI 1, pli.b, 0xa5, 0xa5a5a5a5a5a5a5a5
+    TEST_PSIMD_LI 1, pli.b, 0, 0
+    TEST_PSIMD_LI 1, pli.b, 1, 0x0101010101010101
+    TEST_PSIMD_LI 1, pli.b, 0xff, 0xffffffffffffffff
+    TEST_PSIMD_LI 279, pli.h, 0, 0
+    TEST_PSIMD_LI 279, pli.h, 1, 0x0001000100010001
+    TEST_PSIMD_LI 279, pli.h, 511, 0x01ff01ff01ff01ff
+    TEST_PSIMD_LI 279, pli.h, -512, 0xfe00fe00fe00fe00
+    TEST_PSIMD_LI 280, plui.h, 0, 0
+    TEST_PSIMD_LI 280, plui.h, 1, 0x0040004000400040
+    TEST_PSIMD_LI 280, plui.h, 511, 0x7fc07fc07fc07fc0
+    TEST_PSIMD_LI 280, plui.h, -512, 0x8000800080008000
+    TEST_PSIMD_LI 281, pli.w, 0, 0
+    TEST_PSIMD_LI 281, pli.w, 1, 0x0000000100000001
+    TEST_PSIMD_LI 281, pli.w, 511, 0x000001ff000001ff
+    TEST_PSIMD_LI 281, pli.w, -512, 0xfffffe00fffffe00
+    TEST_PSIMD_LI 282, plui.w, 0, 0
+    TEST_PSIMD_LI 282, plui.w, 1, 0x0040000000400000
+    TEST_PSIMD_LI 282, plui.w, 511, 0x7fc000007fc00000
+    TEST_PSIMD_LI 282, plui.w, -512, 0x8000000080000000
+
+    /* PADD.B keeps all high 32 bits active and tests both rd aliases. */
+    TEST_PSIMD_RR 2, padd.b, 0x7f120003ff780001, 0x7f340007ff9a0005, \
+                  0xfe46000afe120006
+    TEST_PSIMD_RR 2, padd.b, 0, 0, 0
+    TEST_PSIMD_RR 2, padd.b, 0x7f80ff007f80ff00, \
+                  0x0101010101010101, 0x8081000180810001
+    TEST_PSIMD_RR_RD_RS1 2, padd.b, 0x7f120003ff780001, \
+                         0x7f340007ff9a0005, 0xfe46000afe120006
+    TEST_PSIMD_RR_RD_RS2 2, padd.b, 0x7f120003ff780001, \
+                         0x7f340007ff9a0005, 0xfe46000afe120006
+
+    /* PSADD.B: no saturation, exact bounds, both overflows, and sticky. */
+    TEST_PSIMD_RR_VXSAT 3, psadd.b, 0x7f120003ff788001, \
+                        0x7f340007ff9a8005, 0x7f46000afe128006
+    TEST_PSIMD_RR_VXSAT_STATE 3, psadd.b, 0x0102fefe0102fefe, \
+                               0x0101010101010101, \
+                               0x0203ffff0203ffff, 0, 0
+    TEST_PSIMD_RR_VXSAT_STATE 3, psadd.b, 0x7e7e81817e7e8181, \
+                               0x0101ffff0101ffff, \
+                               0x7f7f80807f7f8080, 0, 0
+    TEST_PSIMD_RR_VXSAT_STATE 3, psadd.b, 0x8080808080808080, -1, \
+                               0x8080808080808080, 0, 1
+    TEST_PSIMD_RR_VXSAT_STATE 3, psadd.b, 0, 0, 0, 1, 1
+
+    /* PSATI.H width=5: exact bounds and values outside both bounds. */
+    TEST_PSIMD_RI_VXSAT 4, psati.h, 0x000ffff07fff8000, 5, \
+                        0x000ffff0000ffff0
+    TEST_PSIMD_RI_VXSAT_STATE 4, psati.h, 0x000ffff0000ffff0, 5, \
+                               0x000ffff0000ffff0, 0, 0
+    TEST_PSIMD_RI_VXSAT_STATE 4, psati.h, 0x0010ffef0010ffef, 5, \
+                               0x000ffff0000ffff0, 0, 1
+    TEST_PSIMD_RI_VXSAT_STATE 4, psati.h, \
+                               0x7fff80007fff8000, 16, \
+                               0x7fff80007fff8000, 0, 0
+
+    /* PMHACC.H: nonzero rd, zero products, and signed-negative inputs. */
+    TEST_PSIMD_ACC_RR 5, pmhacc.h, 0x0001000200030004, \
+                      0x7fff800000020002, 0x7fff80010003fffe, \
+                      0x4000400100030003
+    TEST_PSIMD_ACC_RR 5, pmhacc.h, 0x123456789abcdef0, 0, 0, \
+                      0x123456789abcdef0
+    TEST_PSIMD_ACC_RR 5, pmhacc.h, 0, -1, -1, 0
+
+    /* PPAIRE.B uses a unique value in every source lane. */
+    TEST_PSIMD_RR 6, ppaire.b, 0xaabbccddeeff1122, \
+                  0x3344556677889900, 0x44bb66dd88ff0022
+    TEST_PSIMD_RR 6, ppaire.b, 0, 0, 0
+    TEST_PSIMD_RR_RD_RS1 6, ppaire.b, 0xaabbccddeeff1122, \
+                         0x3344556677889900, 0x44bb66dd88ff0022
+    TEST_PSIMD_RR_RD_RS2 6, ppaire.b, 0xaabbccddeeff1122, \
+                         0x3344556677889900, 0x44bb66dd88ff0022
+
+    /* Signed/unsigned byte comparisons disagree in both XLEN halves. */
+    TEST_PSIMD_RR_SET 30, pmin.b, 0x807f00ff807f00ff, \
+                       0x7f8000ff7f8000ff, 0x808000ff808000ff
+    TEST_PSIMD_RR_SET 31, pminu.b, 0x807f00ff807f00ff, \
+                       0x7f8000ff7f8000ff, 0x7f7f00ff7f7f00ff
+    TEST_PSIMD_RR_SET 32, pmax.b, 0x807f00ff807f00ff, \
+                       0x7f8000ff7f8000ff, 0x7f7f00ff7f7f00ff
+    TEST_PSIMD_RR_SET 33, pmaxu.b, 0x807f00ff807f00ff, \
+                       0x7f8000ff7f8000ff, 0x808000ff808000ff
+    TEST_PSIMD_RR_SET 34, pmseq.b, 0x807f00ff807f00ff, \
+                       0x7f8000ff7f8000ff, 0x0000ffff0000ffff, -1
+    TEST_PSIMD_RR_SET 35, pmslt.b, 0x807f00ff807f00ff, \
+                       0x7f8000ff7f8000ff, 0xff000000ff000000
+    TEST_PSIMD_RR_SET 36, pmsltu.b, 0x807f00ff807f00ff, \
+                       0x7f8000ff7f8000ff, 0x00ff000000ff0000
+
+    /* Halfword extrema exercise signed and unsigned ordering. */
+    TEST_PSIMD_RR_SET 37, pmin.h, 0x80007fff80007fff, \
+                       0x7fff80007fff8000, 0x8000800080008000
+    TEST_PSIMD_RR_SET 38, pminu.h, 0x80007fff80007fff, \
+                       0x7fff80007fff8000, 0x7fff7fff7fff7fff
+    TEST_PSIMD_RR_SET 39, pmax.h, 0x80007fff80007fff, \
+                       0x7fff80007fff8000, 0x7fff7fff7fff7fff
+    TEST_PSIMD_RR_SET 40, pmaxu.h, 0x80007fff80007fff, \
+                       0x7fff80007fff8000, 0x8000800080008000
+    TEST_PSIMD_RR_SET 41, pmseq.h, 0x80007fff80007fff, \
+                       0x7fff80007fff8000, 0, -1
+    TEST_PSIMD_RR_SET 42, pmslt.h, 0x80007fff80007fff, \
+                       0x7fff80007fff8000, 0xffff0000ffff0000
+    TEST_PSIMD_RR_SET 43, pmsltu.h, 0x80007fff80007fff, \
+                       0x7fff80007fff8000, 0x0000ffff0000ffff
+
+    /* RV64 word lanes keep the high 32-bit lane nonzero. */
+    TEST_PSIMD_RR_SET 44, pmin.w, 0x800000007fffffff, \
+                       0x7fffffff80000000, 0x8000000080000000
+    TEST_PSIMD_RR_SET 45, pminu.w, 0x800000007fffffff, \
+                       0x7fffffff80000000, 0x7fffffff7fffffff
+    TEST_PSIMD_RR_SET 46, pmax.w, 0x800000007fffffff, \
+                       0x7fffffff80000000, 0x7fffffff7fffffff
+    TEST_PSIMD_RR_SET 47, pmaxu.w, 0x800000007fffffff, \
+                       0x7fffffff80000000, 0x8000000080000000
+    TEST_PSIMD_RR_SET 48, pmseq.w, 0x800000007fffffff, \
+                       0x7fffffff80000000, 0, -1
+    TEST_PSIMD_RR_SET 49, pmslt.w, 0x800000007fffffff, \
+                       0x7fffffff80000000, 0xffffffff00000000
+    TEST_PSIMD_RR_SET 50, pmsltu.w, 0x800000007fffffff, \
+                       0x7fffffff80000000, 0x00000000ffffffff
+
+    /* Wrapping subtraction and wider lane add/subtract operations. */
+    TEST_PSIMD_RR_SET 72, psub.b, 0x0304fefd0304fefd, \
+                       0x0101ff010101ff01, 0x0203fffc0203fffc
+    TEST_PSIMD_RR_SET 73, padd.h, 0x7fff80007fff8000, \
+                       0x0001800000018000, 0x8000000080000000
+    TEST_PSIMD_RR_SET 74, psub.h, 0x7fff80007fff8000, \
+                       0x0001800000018000, 0x7ffe00007ffe0000
+    TEST_PSIMD_RR_SET 82, padd.w, 0x7fffffff80000000, \
+                       0x0000000180000000, 0x8000000000000000
+    TEST_PSIMD_RR_SET 83, psub.w, 0x7fffffff80000000, \
+                       0x0000000180000000, 0x7ffffffe00000000
+
+    /* Signed byte saturation: positive and negative overflow. */
+    TEST_PSIMD_SAT_RR_SET 75, pssub.b, 0x0304fefd0304fefd, \
+                          0x0101ff010101ff01, 0x0203fffc0203fffc, \
+                          0x7f7f7f7f7f7f7f7f, -1, \
+                          0x7f7f7f7f7f7f7f7f, \
+                          0x8080808080808080, 0x0101010101010101, \
+                          0x8080808080808080
+
+    /* Unsigned byte add overflow and subtract underflow. */
+    TEST_PSIMD_SAT_RR_SET 76, psaddu.b, 0x0102fefe0102fefe, \
+                          0x0101010101010101, 0x0203ffff0203ffff, -1, \
+                          0x0101010101010101, -1, \
+                          0xf0f0f0f0f0f0f0f0, 0x2020202020202020, -1
+    TEST_PSIMD_SAT_RR_SET 77, pssubu.b, 0x0304fefd0304fefd, \
+                          0x0101010101010101, 0x0203fdfc0203fdfc, 0, \
+                          0x0101010101010101, 0, \
+                          0x000100ff000100ff, 0x0102000101020001, \
+                          0x000000fe000000fe
+
+    /* Halfword signed/unsigned saturated add and subtract. */
+    TEST_PSIMD_SAT_RR_SET 78, psadd.h, 0x0001000200010002, \
+                          0x0003000400030004, 0x0004000600040006, \
+                          0x7fff7fff7fff7fff, 0x0001000100010001, \
+                          0x7fff7fff7fff7fff, 0x8000800080008000, -1, \
+                          0x8000800080008000
+    TEST_PSIMD_SAT_RR_SET 79, psaddu.h, 0x0001000200010002, \
+                          0x0003000400030004, 0x0004000600040006, -1, \
+                          0x0001000100010001, -1, \
+                          0xf000f000f000f000, 0x2000200020002000, -1
+    TEST_PSIMD_SAT_RR_SET 80, pssub.h, 0x0004000600040006, \
+                          0x0001000400010004, 0x0003000200030002, \
+                          0x7fff7fff7fff7fff, -1, 0x7fff7fff7fff7fff, \
+                          0x8000800080008000, 0x0001000100010001, \
+                          0x8000800080008000
+    TEST_PSIMD_SAT_RR_SET 81, pssubu.h, 0x0004000600040006, \
+                          0x0001000400010004, 0x0003000200030002, 0, \
+                          0x0001000100010001, 0, \
+                          0x000100ff000100ff, 0x0002000100020001, \
+                          0x000000fe000000fe
+
+    /* RV64 word saturation keeps both 32-bit lanes active. */
+    TEST_PSIMD_SAT_RR_SET 84, psadd.w, 0x0000000100000002, \
+                          0x0000000300000004, 0x0000000400000006, \
+                          0x7fffffff7fffffff, 0x0000000100000001, \
+                          0x7fffffff7fffffff, 0x8000000080000000, -1, \
+                          0x8000000080000000
+    TEST_PSIMD_SAT_RR_SET 85, psaddu.w, 0x0000000100000002, \
+                          0x0000000300000004, 0x0000000400000006, -1, \
+                          0x0000000100000001, -1, \
+                          0xf0000000f0000000, 0x2000000020000000, -1
+    TEST_PSIMD_SAT_RR_SET 86, pssub.w, 0x0000000400000006, \
+                          0x0000000100000004, 0x0000000300000002, \
+                          0x7fffffff7fffffff, -1, 0x7fffffff7fffffff, \
+                          0x8000000080000000, 0x0000000100000001, \
+                          0x8000000080000000
+    TEST_PSIMD_SAT_RR_SET 87, pssubu.w, 0x0000000400000006, \
+                          0x0000000100000004, 0x0000000300000002, 0, \
+                          0x0000000100000001, 0, \
+                          0x00000001000000ff, 0x0000000200000001, \
+                          0x00000000000000fe
+
+    /* Signed/unsigned average byte add/subtract with active high lanes. */
+    TEST_PSIMD_RR_SET 109, paadd.b, 0x7f120003ff780001, \
+                       0x7f340007ff9a0005, 0x7f230005ff090003
+    TEST_PSIMD_RR_SET 110, paaddu.b, 0x7f120003ff780001, \
+                       0x7f340007ff9a0005, 0x7f230005ff890003
+    TEST_PSIMD_RR_SET 111, pasub.b, 0xffff000000000001, \
+                       0x111100010000ffff, 0xf7f700ff00000001
+    TEST_PSIMD_RR_SET 112, pasubu.b, 0xffff000000000001, \
+                       0x111100010000ffff, 0x777700ff00008081
+    TEST_PSIMD_RR 109, paadd.b, 0x7f7f7f7f7f7f7f7f, \
+                  0x8080808080808080, -1
+    TEST_PSIMD_RR 110, paaddu.b, -1, 0x0101010101010101, \
+                  0x8080808080808080
+    TEST_PSIMD_RR 111, pasub.b, 0x8080808080808080, \
+                  0x7f7f7f7f7f7f7f7f, 0x8080808080808080
+    TEST_PSIMD_RR 112, pasubu.b, -1, 0, 0x7f7f7f7f7f7f7f7f
+
+    /* Halfword average operations exercise signed/unsigned divergence. */
+    TEST_PSIMD_RR_SET 113, paadd.h, 0x7f120003ff780001, \
+                       0x7f340007ff9a0005, 0x7f230005ff890003
+    TEST_PSIMD_RR_SET 114, paaddu.h, 0x7f120003ff780001, \
+                       0x7f340007ff9a0005, 0x7f230005ff890003
+    TEST_PSIMD_RR_SET 115, pasub.h, 0xffff000000000001, \
+                       0x111100010000ffff, 0xf777ffff00000001
+    TEST_PSIMD_RR_SET 116, pasubu.h, 0xffff000000000001, \
+                       0x111100010000ffff, 0x7777ffff00008001
+    TEST_PSIMD_RR 113, paadd.h, 0x7fff7fff7fff7fff, \
+                  0x8000800080008000, -1
+    TEST_PSIMD_RR 114, paaddu.h, -1, 0x0001000100010001, \
+                  0x8000800080008000
+    TEST_PSIMD_RR 115, pasub.h, 0x8000800080008000, \
+                  0x7fff7fff7fff7fff, 0x8000800080008000
+    TEST_PSIMD_RR 116, pasubu.h, -1, 0, 0x7fff7fff7fff7fff
+
+    /* RV64 word averages keep both word lanes nonzero. */
+    TEST_PSIMD_RR_SET 119, paadd.w, 0xffffff12ffffff78, \
+                       0xffffff34ffffff9a, 0xffffff23ffffff89
+    TEST_PSIMD_RR_SET 120, paaddu.w, 0xffffff12ffffff78, \
+                       0xffffff34ffffff9a, 0xffffff23ffffff89
+    TEST_PSIMD_RR_SET 121, pasub.w, 1, 0x00000001ffffffff, \
+                       0xffffffff00000001
+    TEST_PSIMD_RR_SET 122, pasubu.w, 1, 0x00000001ffffffff, \
+                       0xffffffff80000001
+    TEST_PSIMD_RR 119, paadd.w, 0x7fffffff7fffffff, \
+                  0x8000000080000000, -1
+    TEST_PSIMD_RR 120, paaddu.w, -1, 0x0000000100000001, \
+                  0x8000000080000000
+    TEST_PSIMD_RR 121, pasub.w, 0x8000000080000000, \
+                  0x7fffffff7fffffff, 0x8000000080000000
+    TEST_PSIMD_RR 122, pasubu.w, -1, 0, 0x7fffffff7fffffff
+
+    /* Shift-one add wraps; signed variants saturate and set vxsat. */
+    TEST_PSIMD_RR_SET 117, psh1add.h, 0x7fff8000000afffb, \
+                       0x0001fffe00050005, 0xfffffffe0019fffb
+    TEST_PSIMD_SAT_RR_SET 118, pssh1sadd.h, 1, 2, 4, \
+                          0x4000400040004000, 0, \
+                          0x7fff7fff7fff7fff, \
+                          0xc000c000c000c000, -1, \
+                          0x8000800080008000
+    TEST_PSIMD_RR_SET 123, psh1add.w, 0x0000000a2000000f, \
+                       0x0000000500000003, 0x0000001940000021
+    TEST_PSIMD_SAT_RR_SET 124, pssh1sadd.w, \
+                          0x0000000200000001, 0x0000000300000004, \
+                          0x0000000700000006, \
+                          0x4000000040000000, 0, \
+                          0x7fffffff7fffffff, \
+                          0xc0000000c0000000, -1, \
+                          0x8000000080000000
+    /* Absolute difference with every high-half lane active. */
+    TEST_PSIMD_RR_SET 146, pabd.b, 0x807f0201807f0201, \
+                       0x018001ff7f80027f, 0x81ff0102ffff007e
+    TEST_PSIMD_RR_SET 147, pabdu.b, 0x807f0201807f0201, \
+                       0x018001ff7f80027f, 0x7f0101fe0101007e
+    TEST_PSIMD_RR_SET 148, pabd.h, 0x00010002fffe7fff, \
+                       0x0002000100010001, 0x0001000100037ffe
+    TEST_PSIMD_RR_SET 149, pabdu.h, 0x00010002fffe7fff, \
+                       0x0002000100010001, 0x00010001fffd7ffe
+
+    TEST_PSIMD_RR_SET 150, pabdsumu.b, 0x807fffff807fffff, \
+                       0x7f0101fe7f0101fe, 0x2fc
+    TEST_PSIMD_ACC_RR_SET 151, pabdsumau.b, 1, \
+        0x807fffff807fffff, 0x7f0101fe7f0101fe, 0x2fd, \
+        0x807fffff808002fb, 0x7f0101fe7f0104fa
+    TEST_PSIMD_ACC_RR 151, pabdsumau.b, 0x123456789abcdef0, 0, 0, \
+                      0x123456789abcdef0
+
+    TEST_PSIMD_SAT_R_SET 152, psabs.b, 0x00007fffffff8101, \
+                          0x00007f0101017f01, \
+                          0x8000000080000000, 0x7f0000007f000000
+    TEST_PSIMD_SAT_R_SET 153, psabs.h, 0x00007fffffff8001, \
+                          0x00007fff00017fff, \
+                          0x8000000080000000, 0x7fff00007fff0000
+
+    TEST_PSIMD_RR_SET 154, predsum.bs, 0x807f02fe01807f02, \
+                       0x64, 0x65
+    TEST_PSIMD_RR_SET 155, predsumu.bs, 0x807f02ff01807f02, \
+                       0x64, 0x366
+    TEST_PSIMD_RR_SET 156, predsum.hs, 0x0003000400010002, 0xa, 0x14
+    TEST_PSIMD_RR_SET 157, predsumu.hs, 0x1000200030004000, \
+                       0x1000, 0xb000
+    TEST_PSIMD_RR_SET 159, predsum.ws, 0x7fffffff00000005, \
+                       0x1000, 0x0000000080001004
+    TEST_PSIMD_RR_SET 160, predsumu.ws, 0xffffffff0000000a, \
+                       0x1000, 0x0000000100001009
+
+    /* Packed shifts keep distinct data in both halves of the RV64 register. */
+    TEST_PSIMD_SHIFT_RR_SET 172, psll.bs, 0x807f1201807f1201, \
+                             0x00fe240200fe2402, 7, \
+                             0x0080008000800080
+    TEST_PSIMD_SHIFT_RR_SET 173, psrl.bs, 0x807f1201807f1201, \
+                             0x403f0900403f0900, 7, \
+                             0x0100000001000000
+    TEST_PSIMD_SHIFT_RR_SET 174, psra.bs, 0x807f1201807f1201, \
+                             0xc03f0900c03f0900, 7, \
+                             0xff000000ff000000
+    TEST_PSIMD_SHIFT_RI_SET 175, pslli.b, 0x807f1201807f1201, \
+                             0x00fe240200fe2402, 7, \
+                             0x0080008000800080
+    TEST_PSIMD_SHIFT_RI_SET 176, psrli.b, 0x807f1201807f1201, \
+                             0x403f0900403f0900, 7, \
+                             0x0100000001000000
+    TEST_PSIMD_SHIFT_RI_SET 177, psrai.b, 0x807f1201807f1201, \
+                             0xc03f0900c03f0900, 7, \
+                             0xff000000ff000000
+
+    TEST_PSIMD_SHIFT_RR_SET 178, psll.hs, 0x80017fff80017fff, \
+                             0x0002fffe0002fffe, 15, \
+                             0x8000800080008000
+    TEST_PSIMD_SHIFT_RR_SET 179, psrl.hs, 0x80017fff80017fff, \
+                             0x40003fff40003fff, 15, \
+                             0x0001000000010000
+    TEST_PSIMD_SHIFT_RR_SET 180, psra.hs, 0x80017fff80017fff, \
+                             0xc0003fffc0003fff, 15, \
+                             0xffff0000ffff0000
+    TEST_PSIMD_SHIFT_RI_SET 181, pslli.h, 0x80017fff80017fff, \
+                             0x0002fffe0002fffe, 15, \
+                             0x8000800080008000
+    TEST_PSIMD_SHIFT_RI_SET 182, psrli.h, 0x80017fff80017fff, \
+                             0x40003fff40003fff, 15, \
+                             0x0001000000010000
+    TEST_PSIMD_SHIFT_RI_SET 183, psrai.h, 0x80017fff80017fff, \
+                             0xc0003fffc0003fff, 15, \
+                             0xffff0000ffff0000
+
+    TEST_PSIMD_SHIFT_RR_SET 184, psll.ws, 0x800000017fffffff, \
+                             0x00000002fffffffe, 31, \
+                             0x8000000080000000
+    TEST_PSIMD_SHIFT_RR_SET 185, psrl.ws, 0x800000017fffffff, \
+                             0x400000003fffffff, 31, \
+                             0x0000000100000000
+    TEST_PSIMD_SHIFT_RR_SET 186, psra.ws, 0x800000017fffffff, \
+                             0xc00000003fffffff, 31, \
+                             0xffffffff00000000
+    TEST_PSIMD_SHIFT_RI_SET 187, pslli.w, 0x800000017fffffff, \
+                             0x00000002fffffffe, 31, \
+                             0x8000000080000000
+    TEST_PSIMD_SHIFT_RI_SET 188, psrli.w, 0x800000017fffffff, \
+                             0x400000003fffffff, 31, \
+                             0x0000000100000000
+    TEST_PSIMD_SHIFT_RI_SET 189, psrai.w, 0x800000017fffffff, \
+                             0xc00000003fffffff, 31, \
+                             0xffffffff00000000
+
+    /* Rounded shifts cover both guard values and negative arithmetic fill. */
+    TEST_PSIMD_SHIFT_RI_SET 208, psrari.h, \
+                             0x80017ffffffd0002, \
+                             0xc0014000ffff0001, 15, \
+                             0xffff000100000000
+    TEST_PSIMD_RI 208, psrari.h, 0x0003fffc00050004, 1, \
+                  0x0002fffe00030002
+    TEST_PSIMD_SHIFT_RI_SET 210, psrari.w, \
+                             0x800000017fffffff, \
+                             0xc000000140000000, 31, \
+                             0xffffffff00000001
+    TEST_PSIMD_RI 210, psrari.w, 0x00000003fffffffc, 1, \
+                  0x00000002fffffffe
+    TEST_PSIMD_SHIFT_RI_SET 209, srari, 0x8000000000000001, \
+                             0xc000000000000001, 63, -1
+    TEST_PSIMD_RI 209, srari, 3, 1, 2
+
+    /* Pair/merge operations make every RV64 source field visible. */
+    TEST_PSIMD_RR_SET 261, ppaireo.b, 0x1122334455667788, \
+                       0x99aabbccddeeff00, 0x9922bb44dd66ff88
+    TEST_PSIMD_RR_SET 262, ppairoe.b, 0x1122334455667788, \
+                       0x99aabbccddeeff00, 0xaa11cc33ee550077
+    TEST_PSIMD_RR_SET 263, ppairo.b, 0x1122334455667788, \
+                       0x99aabbccddeeff00, 0x9911bb33dd55ff77
+    TEST_PSIMD_RR_SET 267, ppaire.h, 0x1122334455667788, \
+                       0x99aabbccddeeff00, 0xbbcc3344ff007788
+    TEST_PSIMD_RR_SET 264, ppaireo.h, 0x1122334455667788, \
+                       0x99aabbccddeeff00, 0x99aa3344ddee7788
+    TEST_PSIMD_RR_SET 265, ppairoe.h, 0x1122334455667788, \
+                       0x99aabbccddeeff00, 0xbbcc1122ff005566
+    TEST_PSIMD_RR_SET 266, ppairo.h, 0x1122334455667788, \
+                       0x99aabbccddeeff00, 0x99aa1122ddee5566
+    TEST_PSIMD_RR_SET 268, ppaireo.w, 0x1122334455667788, \
+                       0x99aabbccddeeff00, 0x99aabbcc55667788
+    TEST_PSIMD_RR_SET 269, ppairoe.w, 0x1122334455667788, \
+                       0x99aabbccddeeff00, 0xddeeff0011223344
+    TEST_PSIMD_RR_SET 270, ppairo.w, 0x1122334455667788, \
+                       0x99aabbccddeeff00, 0x99aabbcc11223344
+
+    TEST_PSIMD_R_SET 283, psext.h.b, 0x000100ff007f0080, \
+                      0x0001ffff007fff80
+    TEST_PSIMD_R_SET 284, psext.w.b, 0x000000800000007f, \
+                      0xffffff800000007f
+    TEST_PSIMD_R_SET 285, psext.w.h, 0x0000800100007fff, \
+                      0xffff800100007fff
+
+    TEST_PSIMD_ACC_RR_SET 292, mvm, 0xaaaaaaaaaaaaaaaa, \
+        0x5555555555555555, 0x0f0ff0f00f0ff0f0, \
+        0xa5a55a5aa5a55a5a, 0x5555555555555555, \
+        0x0505505005055050
+    TEST_PSIMD_ACC_RR 292, mvm, 0xaaaaaaaaaaaaaaaa, \
+                      0x5555555555555555, 0, 0xaaaaaaaaaaaaaaaa
+    TEST_PSIMD_ACC_RR_SET 293, mvmn, 0xaaaaaaaaaaaaaaaa, \
+        0x5555555555555555, 0x0f0ff0f00f0ff0f0, \
+        0x5a5aa5a55a5aa5a5, 0x5555555555555555, \
+        0x5f5ff5f55f5ff5f5
+    TEST_PSIMD_ACC_RR 293, mvmn, 0xaaaaaaaaaaaaaaaa, \
+                      0x5555555555555555, -1, 0xaaaaaaaaaaaaaaaa
+    TEST_PSIMD_ACC_RR_SET 294, merge, 0xaaaaaaaaaaaaaaaa, \
+        0x5555555555555555, 0x0f0ff0f00f0ff0f0, \
+        0x5f5ff5f55f5ff5f5, 0x0505505005055050, \
+        0x5f5ff5f55f5ff5f5
+    TEST_PSIMD_RR_SET 295, pack, 0x1122334455667788, \
+                       0x99aabbccddeeff00, 0xddeeff0055667788
+
+    TEST_PSIMD_R 297, cls, 1, 62
+    TEST_PSIMD_R_RD_RS1 297, cls, 1, 62
+    TEST_PSIMD_R 297, cls, 0, 63
+    TEST_PSIMD_R 297, cls, -1, 63
+    TEST_PSIMD_R 297, cls, 0x4000000000000000, 0
+    TEST_PSIMD_R 301, clsw, 1, 30
+    TEST_PSIMD_R_RD_RS1 301, clsw, 1, 30
+    TEST_PSIMD_R 301, clsw, 0, 31
+    TEST_PSIMD_R 301, clsw, 0xffffffff, 31
+
+    TEST_PSIMD_SAT_RI_SET 313, sati, 5, 15, 15, 16, 15, -17, -16
+    TEST_PSIMD_RI_VXSAT_STATE 313, sati, 0x7fffffffffffffff, 64, \
+                               0x7fffffffffffffff, 0, 0
+    TEST_PSIMD_SAT_RI_SET 316, psati.w, 5, \
+                           0x0000000ffffffff0, \
+                           0x0000000ffffffff0, \
+                           0x0000001000000010, \
+                           0x0000000f0000000f, \
+                           0xffffffefffffffef, \
+                           0xfffffff0fffffff0
+    TEST_PSIMD_RI_VXSAT_STATE 316, psati.w, \
+                               0x7fffffff80000000, 32, \
+                               0x7fffffff80000000, 0, 0
+    TEST_PSIMD_SAT_RI_SET 314, pusati.h, 4, \
+                           0x000f0000000f0000, \
+                           0x000f0000000f0000, \
+                           0x0010001000100010, \
+                           0x000f000f000f000f, -1, 0
+    TEST_PSIMD_RI_VXSAT_STATE 314, pusati.h, \
+                               0x7fff00007fff0000, 15, \
+                               0x7fff00007fff0000, 0, 0
+    TEST_PSIMD_SAT_RI_SET 317, pusati.w, 4, \
+                           0x0000000f00000000, \
+                           0x0000000f00000000, \
+                           0x0000001000000010, \
+                           0x0000000f0000000f, -1, 0
+    TEST_PSIMD_RI_VXSAT_STATE 317, pusati.w, \
+                               0x7fffffff00000000, 31, \
+                               0x7fffffff00000000, 0, 0
+    TEST_PSIMD_SAT_RI_SET 315, usati, 4, 15, 15, 16, 15, -1, 0
+    TEST_PSIMD_RI_VXSAT_STATE 315, usati, \
+                               0x7fffffffffffffff, 63, \
+                               0x7fffffffffffffff, 0, 0
+
+    TEST_PSIMD_SAT_RI_SET 323, psslai.h, 1, \
+                           0x0001ffff0001ffff, \
+                           0x0002fffe0002fffe, \
+                           0x4000400040004000, \
+                           0x7fff7fff7fff7fff, \
+                           0xbfffbfffbfffbfff, \
+                           0x8000800080008000
+    TEST_PSIMD_RI_VXSAT_STATE 323, psslai.h, 0, 15, 0, 0, 0
+    TEST_PSIMD_SAT_RI_SET 325, psslai.w, 1, \
+                           0x00000001ffffffff, \
+                           0x00000002fffffffe, \
+                           0x4000000040000000, \
+                           0x7fffffff7fffffff, \
+                           0xbfffffffbfffffff, \
+                           0x8000000080000000
+    TEST_PSIMD_RI_VXSAT_STATE 325, psslai.w, 0, 31, 0, 0, 0
+
+    TEST_PSIMD_SAT_RR_SET 328, pssha.hs, \
+                          0x0001ffff0001ffff, 1, \
+                          0x0002fffe0002fffe, \
+                          0x4000400040004000, 1, \
+                          0x7fff7fff7fff7fff, \
+                          0xbfffbfffbfffbfff, 1, \
+                          0x8000800080008000
+    TEST_PSIMD_RR_VXSAT_STATE 328, pssha.hs, \
+                               0x0003fffc0003fffc, -1, \
+                               0x0001fffe0001fffe, 0, 0
+    TEST_PSIMD_SAT_RR_SET 329, psshar.hs, \
+                          0x0001ffff0001ffff, 1, \
+                          0x0002fffe0002fffe, \
+                          0x4000400040004000, 1, \
+                          0x7fff7fff7fff7fff, \
+                          0xbfffbfffbfffbfff, 1, \
+                          0x8000800080008000
+    TEST_PSIMD_RR_VXSAT_STATE 329, psshar.hs, \
+                               0x0003fffc0003fffc, -1, \
+                               0x0002fffe0002fffe, 0, 0
+
+    /* Unsigned variable shifts: saturating left and logical rounded right. */
+    TEST_PSIMD_SAT_RR_SET 600, psshl.hs, \
+                          0x000100027ffe4000, 1, \
+                          0x00020004fffc8000, \
+                          0x8000400180004001, 1, \
+                          0xffff8002ffff8002, \
+                          0xffff0001ffff0001, 1, \
+                          0xffff0002ffff0002
+    TEST_PSIMD_RR_VXSAT_STATE 600, psshl.hs, \
+                               0x80017fff00030002, -1, \
+                               0x40003fff00010001, 0, 0
+    TEST_PSIMD_SAT_RR_SET 601, psshlr.hs, \
+                          0x0003000420001000, 1, \
+                          0x0006000840002000, \
+                          0x8000400180004001, 1, \
+                          0xffff8002ffff8002, \
+                          0xffff0001ffff0001, 1, \
+                          0xffff0002ffff0002
+    TEST_PSIMD_RR_VXSAT_STATE 601, psshlr.hs, \
+                               0x8003000200030002, -1, \
+                               0x4002000100020001, 0, 0
+    TEST_PSIMD_RR_VXSAT_STATE 601, psshlr.hs, \
+                               0x80017fff80000001, -17, \
+                               0x0001000000010000, 0, 0
+
+    TEST_PSIMD_SAT_RR_SET 336, pssha.ws, \
+                          0x00000001ffffffff, 1, \
+                          0x00000002fffffffe, \
+                          0x4000000040000000, 1, \
+                          0x7fffffff7fffffff, \
+                          0xbfffffffbfffffff, 1, \
+                          0x8000000080000000
+    TEST_PSIMD_RR_VXSAT_STATE 336, pssha.ws, \
+                               0x00000003fffffffc, -1, \
+                               0x00000001fffffffe, 0, 0
+    TEST_PSIMD_SAT_RR_SET 337, psshar.ws, \
+                          0x00000001ffffffff, 1, \
+                          0x00000002fffffffe, \
+                          0x4000000040000000, 1, \
+                          0x7fffffff7fffffff, \
+                          0xbfffffffbfffffff, 1, \
+                          0x8000000080000000
+    TEST_PSIMD_RR_VXSAT_STATE 337, psshar.ws, \
+                               0x00000003fffffffc, -1, \
+                               0x00000002fffffffe, 0, 0
+
+    TEST_PSIMD_RR_SET 344, pmul.h.b00, \
+                       0x7f80017f05027e01, \
+                       0x7f0180015e80007f, \
+                       0xff80007fff00007f
+    TEST_PSIMD_RR_SET 345, pmul.h.b01, \
+                       0x7f80017f05027e01, \
+                       0x017f0180805e7f80, \
+                       0xff80007fff00007f
+    TEST_PSIMD_RR_SET 346, pmul.h.b11, \
+                       0x80667f8802500101, \
+                       0x017f0180805e7f80, \
+                       0xff80007fff00007f
+    TEST_PSIMD_RR_SET 347, pmulsu.h.b00, \
+                       0x7f80017f05027e01, \
+                       0x7f0180015e80007f, \
+                       0xff80007f0100007f
+    TEST_PSIMD_RR_SET 348, pmulsu.h.b11, \
+                       0x807f7f04027f017e, \
+                       0x017f010880807f55, \
+                       0xff80007f0100007f
+    TEST_PSIMD_RR_SET 349, pmulu.h.b00, \
+                       0x7f80017f05027e01, \
+                       0x7f0180015e80007f, \
+                       0x0080007f0100007f
+    TEST_PSIMD_RR_SET 350, pmulu.h.b01, \
+                       0x7f80017f05027e01, \
+                       0x017f018080807f7f, \
+                       0x0080007f0100007f
+    TEST_PSIMD_RR_SET 351, pmulu.h.b11, \
+                       0x80807f7f02020101, \
+                       0x017f018080807f7f, \
+                       0x0080007f0100007f
+
+    /* Halfword-selection multiply produces two distinct 32-bit lanes. */
+    TEST_PSIMD_RR_SET 352, pmul.w.h00, \
+                       0xffff7fffffff0001, \
+                       0xffff7fff0000ffff, \
+                       0x3fff0001ffffffff
+    TEST_PSIMD_RR_SET 353, pmul.w.h01, \
+                       0xffff7fffffff0001, \
+                       0x7fffffffffff0000, \
+                       0x3fff0001ffffffff
+    TEST_PSIMD_RR_SET 354, pmul.w.h11, \
+                       0x7fffffff0001ffff, \
+                       0x7fffffffffff0000, \
+                       0x3fff0001ffffffff
+    TEST_PSIMD_RR_SET 355, pmulsu.w.h00, \
+                       0xffff7fffffff0001, \
+                       0xffff7fff0000ffff, \
+                       0x3fff00010000ffff
+    TEST_PSIMD_RR_SET 356, pmulsu.w.h11, \
+                       0x7fffffff0001ffff, \
+                       0x7fffffffffff0000, \
+                       0x3fff00010000ffff
+    TEST_PSIMD_RR_SET 357, pmulu.w.h00, \
+                       0xffff7fffffffffff, \
+                       0xffff7fff00000001, \
+                       0x3fff00010000ffff
+    TEST_PSIMD_RR_SET 358, pmulu.w.h01, \
+                       0xffff7fffffffffff, \
+                       0x7fffffff000107ff, \
+                       0x3fff00010000ffff
+    TEST_PSIMD_RR_SET 359, pmulu.w.h11, \
+                       0x7fffffffffffffff, \
+                       0x7fffffff000107ff, \
+                       0x3fff00010000ffff
+
+    TEST_PSIMD_RR_SET 368, pmulh.h, \
+                       0x7fff00028000fffe, \
+                       0x7fff00037fff0001, \
+                       0x3fff0000c000ffff
+    TEST_PSIMD_RR_SET 369, pmulhr.h, \
+                       0x7fff800000028000, \
+                       0x7fff800100037fff, \
+                       0x3fff40000000c001
+    TEST_PSIMD_RR_SET 370, pmulhsu.h, \
+                       0x7fff80000002fffe, \
+                       0xffff000100030004, \
+                       0x7ffeffff0000ffff
+    TEST_PSIMD_RR_SET 371, pmulhrsu.h, \
+                       0x7fff80000002fffe, \
+                       0xffff000100030004, \
+                       0x7fff000000000000
+    TEST_PSIMD_RR_SET 372, pmulhu.h, \
+                       0x8000ffff0002fffe, \
+                       0x7fff000180017fff, \
+                       0x3fff000000017ffe
+    TEST_PSIMD_RR_SET 373, pmulhru.h, \
+                       0x8000ffff0002fffe, \
+                       0x7fff000180017fff, \
+                       0x4000000100017ffe
+
+    TEST_PSIMD_RR_SET 374, pmulh.w, \
+                       0x000000017fffffff, \
+                       0xffffffff7fffffff, \
+                       0xffffffff3fffffff
+    TEST_PSIMD_RR_SET 375, pmulhr.w, \
+                       0x000000017fffffff, \
+                       0xffffffff7fffffff, \
+                       0x000000003fffffff
+    TEST_PSIMD_RR_SET 376, pmulhsu.w, \
+                       0x7fff80000002fffe, \
+                       0xffff000100030004, \
+                       0x7fff000000000009
+    TEST_PSIMD_RR_SET 377, pmulhrsu.w, \
+                       0x7fff80000002fffe, \
+                       0xffff000100030004, \
+                       0x7fff000100000009
+    TEST_PSIMD_RR_SET 378, pmulhu.w, \
+                       0x8000ffff0002fffe, \
+                       0x7fff000180017fff, \
+                       0x3fffffff00018003
+    TEST_PSIMD_RR_SET 379, pmulhru.w, \
+                       0x8000ffff0002fffe, \
+                       0x7fffffff80017fff, \
+                       0x40007fff00018003
+
+    TEST_PSIMD_SAT_RR_SET 383, pmulq.h, \
+                          0x00017fff0002ffff, \
+                          0x40007fff20000001, \
+                          0x00007ffe0000ffff, \
+                          0x8000800080008000, \
+                          0x8000800080008000, \
+                          0x7fff7fff7fff7fff, \
+                          0x8000800080008000, \
+                          0x8000800080008000, \
+                          0x7fff7fff7fff7fff
+    TEST_PSIMD_SAT_RR_SET 384, pmulqr.h, \
+                          0x00017fff0002ffff, \
+                          0x40007fff20000001, \
+                          0x00017ffe00010000, \
+                          0x8000800080008000, \
+                          0x8000800080008000, \
+                          0x7fff7fff7fff7fff, \
+                          0x8000800080008000, \
+                          0x8000800080008000, \
+                          0x7fff7fff7fff7fff
+    TEST_PSIMD_SAT_RR_SET 385, pmulq.w, \
+                          0x000000017fffffff, \
+                          0x400000007fffffff, \
+                          0x000000007ffffffe, \
+                          0x8000000080000000, \
+                          0x8000000080000000, \
+                          0x7fffffff7fffffff, \
+                          0x8000000080000000, \
+                          0x8000000080000000, \
+                          0x7fffffff7fffffff
+    TEST_PSIMD_SAT_RR_SET 386, pmulqr.w, \
+                          0x000000017fffffff, \
+                          0x400000007fffffff, \
+                          0x000000017ffffffe, \
+                          0x8000000080000000, \
+                          0x8000000080000000, \
+                          0x7fffffff7fffffff, \
+                          0x8000000080000000, \
+                          0x8000000080000000, \
+                          0x7fffffff7fffffff
+
+    TEST_PSIMD_RR_SET 389, pmulh.h.b0, \
+                       0x7fff80000001ffff, \
+                       0x01017f7f80010001, \
+                       0x007fc0800000ffff
+    TEST_PSIMD_RR_SET 390, pmulh.h.b1, \
+                       0x7fff80000001ffff, \
+                       0x01017f7f01800100, \
+                       0x007fc0800000ffff
+    TEST_PSIMD_RR_SET 391, pmulhsu.h.b0, \
+                       0x7fff80000010ffff, \
+                       0x01017f7f01800001, \
+                       0x007fc0800008ffff
+    TEST_PSIMD_RR_SET 392, pmulhsu.h.b1, \
+                       0x7fff80000010ffff, \
+                       0x01017f7f8001017f, \
+                       0x007fc0800008ffff
+    TEST_PSIMD_RR_SET 393, pmulh.w.h0, \
+                       0x000000017fffffff, \
+                       0x0000ffff00007fff, \
+                       0xffffffff3fff7fff
+    TEST_PSIMD_RR_SET 394, pmulh.w.h1, \
+                       0x000000017fffffff, \
+                       0xffff00007fff0000, \
+                       0xffffffff3fff7fff
+    TEST_PSIMD_RR_SET 395, pmulhsu.w.h0, \
+                       0x000000017fffffff, \
+                       0x0000ffff00007fff, \
+                       0x000000003fff7fff
+    TEST_PSIMD_RR_SET 396, pmulhsu.w.h1, \
+                       0x000000017fffffff, \
+                       0xffff00007fff0000, \
+                       0x000000003fff7fff
+
+    TEST_PSIMD_R_SET 158, abs, -1, 1
+    TEST_PSIMD_R 158, abs, 0x8000000000000000, 0x8000000000000000
+    TEST_PSIMD_R_SET 161, absw, 0x12345678ffffffff, 1
+    TEST_PSIMD_R 161, absw, 0x1234567880000000, \
+                  0xffffffff80000000
+
+#else
+#error unsupported RISC-V XLEN
+#endif
diff --git a/tests/tcg/riscv/psimd-rv32.S b/tests/tcg/riscv/psimd-rv32.S
new file mode 100644
index 00000000000..9a20142e98b
--- /dev/null
+++ b/tests/tcg/riscv/psimd-rv32.S
@@ -0,0 +1,1256 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Basic RV32 P extension execution tests. */
+
+#include "psimd-test-macros.inc"
+
+    .text
+    .balign 4
+    .globl _start
+    .type _start, @function
+_start:
+#include "psimd-common.S"
+
+    TEST_PSIMD_PAIR_RR 7, padd.db, 0x7f120003, 0xff780001, \
+                       0x7f340007, 0xff9a0005, 0xfe46000a, 0xfe120006
+    TEST_PSIMD_PAIR_RR 7, padd.db, 0, 0, 0, 0, 0, 0
+    TEST_PSIMD_PAIR_RR 7, padd.db, 0x7f80ff00, 0x008001ff, \
+                       0x01010101, 0xff017f01, 0x80810001, 0xff818000
+    TEST_PSIMD_PAIR_RR_RD_RS1 7, padd.db, 0x7f120003, 0xff780001, \
+                              0x7f340007, 0xff9a0005, 0xfe46000a, \
+                              0xfe120006
+    TEST_PSIMD_PAIR_RR_RD_RS2 7, padd.db, 0x7f120003, 0xff780001, \
+                              0x7f340007, 0xff9a0005, 0xfe46000a, \
+                              0xfe120006
+
+    /* Double-wide byte comparisons, including pair source overlap. */
+    TEST_PSIMD_PAIR_RR_SET 51, pmin.db, 0x807f00ff, 0x807f00ff, \
+                           0x7f8000ff, 0x7f8000ff, 0x808000ff, \
+                           0x808000ff, 0
+    TEST_PSIMD_PAIR_RR_SET 52, pminu.db, 0x807f00ff, 0x807f00ff, \
+                           0x7f8000ff, 0x7f8000ff, 0x7f7f00ff, \
+                           0x7f7f00ff, 0
+    TEST_PSIMD_PAIR_RR_SET 53, pmax.db, 0x807f00ff, 0x807f00ff, \
+                           0x7f8000ff, 0x7f8000ff, 0x7f7f00ff, \
+                           0x7f7f00ff, 0
+    TEST_PSIMD_PAIR_RR_SET 54, pmaxu.db, 0x807f00ff, 0x807f00ff, \
+                           0x7f8000ff, 0x7f8000ff, 0x808000ff, \
+                           0x808000ff, 0
+    TEST_PSIMD_PAIR_RR_SET 55, pmseq.db, 0x807f00ff, 0x807f00ff, \
+                           0x7f8000ff, 0x7f8000ff, 0x0000ffff, \
+                           0x0000ffff
+    TEST_PSIMD_PAIR_RR_SET 56, pmslt.db, 0x807f00ff, 0x807f00ff, \
+                           0x7f8000ff, 0x7f8000ff, 0xff000000, \
+                           0xff000000, 0
+    TEST_PSIMD_PAIR_RR_SET 57, pmsltu.db, 0x807f00ff, 0x807f00ff, \
+                           0x7f8000ff, 0x7f8000ff, 0x00ff0000, \
+                           0x00ff0000, 0
+
+    /* Double-wide halfword comparisons. */
+    TEST_PSIMD_PAIR_RR_SET 58, pmin.dh, 0x80007fff, 0x80007fff, \
+                           0x7fff8000, 0x7fff8000, 0x80008000, \
+                           0x80008000, 0
+    TEST_PSIMD_PAIR_RR_SET 59, pminu.dh, 0x80007fff, 0x80007fff, \
+                           0x7fff8000, 0x7fff8000, 0x7fff7fff, \
+                           0x7fff7fff, 0
+    TEST_PSIMD_PAIR_RR_SET 60, pmax.dh, 0x80007fff, 0x80007fff, \
+                           0x7fff8000, 0x7fff8000, 0x7fff7fff, \
+                           0x7fff7fff, 0
+    TEST_PSIMD_PAIR_RR_SET 61, pmaxu.dh, 0x80007fff, 0x80007fff, \
+                           0x7fff8000, 0x7fff8000, 0x80008000, \
+                           0x80008000, 0
+    TEST_PSIMD_PAIR_RR_SET 62, pmseq.dh, 0x80007fff, 0x80007fff, \
+                           0x7fff8000, 0x7fff8000, 0, 0
+    TEST_PSIMD_PAIR_RR_SET 63, pmslt.dh, 0x80007fff, 0x80007fff, \
+                           0x7fff8000, 0x7fff8000, 0xffff0000, \
+                           0xffff0000, 0
+    TEST_PSIMD_PAIR_RR_SET 64, pmsltu.dh, 0x80007fff, 0x80007fff, \
+                           0x7fff8000, 0x7fff8000, 0x0000ffff, \
+                           0x0000ffff, 0
+
+    /* Double-wide word lanes verify low/high register ordering. */
+    TEST_PSIMD_PAIR_RR_SET 65, pmin.dw, 0x7fffffff, 0x80000000, \
+                           0x80000000, 0x7fffffff, 0x80000000, \
+                           0x80000000, 0
+    TEST_PSIMD_PAIR_RR_SET 66, pminu.dw, 0x7fffffff, 0x80000000, \
+                           0x80000000, 0x7fffffff, 0x7fffffff, \
+                           0x7fffffff, 0
+    TEST_PSIMD_PAIR_RR_SET 67, pmax.dw, 0x7fffffff, 0x80000000, \
+                           0x80000000, 0x7fffffff, 0x7fffffff, \
+                           0x7fffffff, 0
+    TEST_PSIMD_PAIR_RR_SET 68, pmaxu.dw, 0x7fffffff, 0x80000000, \
+                           0x80000000, 0x7fffffff, 0x80000000, \
+                           0x80000000, 0
+    TEST_PSIMD_PAIR_RR_SET 69, pmseq.dw, 0x7fffffff, 0x80000000, \
+                           0x80000000, 0x7fffffff, 0, 0
+    TEST_PSIMD_PAIR_RR_SET 70, pmslt.dw, 0x7fffffff, 0x80000000, \
+                           0x80000000, 0x7fffffff, 0, -1, 0
+    TEST_PSIMD_PAIR_RR_SET 71, pmsltu.dw, 0x7fffffff, 0x80000000, \
+                           0x80000000, 0x7fffffff, -1, 0, 0
+
+    /* Remaining wrapping double-wide add/sub lane widths. */
+    TEST_PSIMD_PAIR_RR_SET 88, psub.db, 0x0304fefd, 0x0304fefd, \
+                           0x0101ff01, 0x0101ff01, 0x0203fffc, \
+                           0x0203fffc, 0
+    TEST_PSIMD_PAIR_RR_SET 89, padd.dh, 0x7fff8000, 0x7fff8000, \
+                           0x00018000, 0x00018000, 0x80000000, \
+                           0x80000000, 0
+    TEST_PSIMD_PAIR_RR_SET 90, psub.dh, 0x7fff8000, 0x7fff8000, \
+                           0x00018000, 0x00018000, 0x7ffe0000, \
+                           0x7ffe0000, 0
+    TEST_PSIMD_PAIR_RR_SET 91, padd.dw, 0x7fffffff, 0x80000000, \
+                           0x00000001, 0x80000000, 0x80000000, 0, 0
+    TEST_PSIMD_PAIR_RR_SET 92, psub.dw, 0x7fffffff, 0x80000000, \
+                           0x00000001, 0x80000000, 0x7ffffffe, 0, 0
+
+    /* Saturated byte register-pair operations. */
+    TEST_PSIMD_PAIR_SAT_RR_SET 93, psadd.db, \
+        0x0102fefe, 0x0102fefe, 0x01010101, 0x01010101, \
+        0x0203ffff, 0x0203ffff, \
+        0x7f7f7f7f, 0x7f7f7f7f, 0x01010101, 0x01010101, \
+        0x7f7f7f7f, 0x7f7f7f7f, \
+        0x80808080, 0x80808080, -1, -1, 0x80808080, 0x80808080
+    TEST_PSIMD_PAIR_SAT_RR_SET 94, psaddu.db, \
+        0x0102fefe, 0x0102fefe, 0x01010101, 0x01010101, \
+        0x0203ffff, 0x0203ffff, \
+        -1, -1, 0x01010101, 0x01010101, -1, -1, \
+        0xf0f0f0f0, 0xf0f0f0f0, 0x20202020, 0x20202020, -1, -1
+    TEST_PSIMD_PAIR_SAT_RR_SET 95, pssub.db, \
+        0x0304fefd, 0x0304fefd, 0x0101ff01, 0x0101ff01, \
+        0x0203fffc, 0x0203fffc, \
+        0x7f7f7f7f, 0x7f7f7f7f, -1, -1, 0x7f7f7f7f, 0x7f7f7f7f, \
+        0x80808080, 0x80808080, 0x01010101, 0x01010101, \
+        0x80808080, 0x80808080
+    TEST_PSIMD_PAIR_SAT_RR_SET 96, pssubu.db, \
+        0x0304fefd, 0x0304fefd, 0x01010101, 0x01010101, \
+        0x0203fdfc, 0x0203fdfc, \
+        0, 0, 0x01010101, 0x01010101, 0, 0, \
+        0x000100ff, 0x000100ff, 0x01020001, 0x01020001, \
+        0x000000fe, 0x000000fe
+
+    /* Saturated halfword register-pair operations. */
+    TEST_PSIMD_PAIR_SAT_RR_SET 97, psadd.dh, \
+        0x00010002, 0x00010002, 0x00030004, 0x00030004, \
+        0x00040006, 0x00040006, \
+        0x7fff7fff, 0x7fff7fff, 0x00010001, 0x00010001, \
+        0x7fff7fff, 0x7fff7fff, \
+        0x80008000, 0x80008000, -1, -1, 0x80008000, 0x80008000
+    TEST_PSIMD_PAIR_SAT_RR_SET 98, psaddu.dh, \
+        0x00010002, 0x00010002, 0x00030004, 0x00030004, \
+        0x00040006, 0x00040006, \
+        -1, -1, 0x00010001, 0x00010001, -1, -1, \
+        0xf000f000, 0xf000f000, 0x20002000, 0x20002000, -1, -1
+    TEST_PSIMD_PAIR_SAT_RR_SET 99, pssub.dh, \
+        0x00040006, 0x00040006, 0x00010004, 0x00010004, \
+        0x00030002, 0x00030002, \
+        0x7fff7fff, 0x7fff7fff, -1, -1, 0x7fff7fff, 0x7fff7fff, \
+        0x80008000, 0x80008000, 0x00010001, 0x00010001, \
+        0x80008000, 0x80008000
+    TEST_PSIMD_PAIR_SAT_RR_SET 100, pssubu.dh, \
+        0x00040006, 0x00040006, 0x00010004, 0x00010004, \
+        0x00030002, 0x00030002, \
+        0, 0, 0x00010001, 0x00010001, 0, 0, \
+        0x000100ff, 0x000100ff, 0x00020001, 0x00020001, \
+        0x000000fe, 0x000000fe
+
+    /* Saturated word register-pair operations. */
+    TEST_PSIMD_PAIR_SAT_RR_SET 101, psadd.dw, \
+        1, 2, 3, 4, 4, 6, \
+        0x7fffffff, 0x7fffffff, 1, 1, 0x7fffffff, 0x7fffffff, \
+        0x80000000, 0x80000000, -1, -1, 0x80000000, 0x80000000
+    TEST_PSIMD_PAIR_SAT_RR_SET 102, psaddu.dw, \
+        1, 2, 3, 4, 4, 6, \
+        -1, -1, 1, 1, -1, -1, \
+        0xf0000000, 0xf0000000, 0x20000000, 0x20000000, -1, -1
+    TEST_PSIMD_PAIR_SAT_RR_SET 103, pssub.dw, \
+        4, 6, 1, 4, 3, 2, \
+        0x7fffffff, 0x7fffffff, -1, -1, 0x7fffffff, 0x7fffffff, \
+        0x80000000, 0x80000000, 1, 1, 0x80000000, 0x80000000
+    TEST_PSIMD_PAIR_SAT_RR_SET 104, pssubu.dw, \
+        4, 6, 1, 4, 3, 2, \
+        0, 0, 1, 1, 0, 0, \
+        1, 0xff, 2, 1, 0, 0xfe
+
+    /* RV32 scalar saturation covers XLEN-wide signed/unsigned bounds. */
+    TEST_PSIMD_SAT_RR_SET 105, sadd, 1, 2, 3, \
+                          0x7fffffff, 1, 0x7fffffff, \
+                          0x80000000, -1, 0x80000000
+    TEST_PSIMD_SAT_RR_SET 106, saddu, 1, 2, 3, \
+                          -1, 1, -1, 0xf0000000, 0x20000000, -1
+    TEST_PSIMD_SAT_RR_SET 107, ssub, 4, 1, 3, \
+                          0x7fffffff, -1, 0x7fffffff, \
+                          0x80000000, 1, 0x80000000
+    TEST_PSIMD_SAT_RR_SET 108, ssubu, 4, 1, 3, \
+                          0, 1, 0, 1, 2, 0
+
+    /* RV32 XLEN-wide signed/unsigned averaging and saturated shift-add. */
+    TEST_PSIMD_RR_SET 125, aadd, 0x40000000, 0x80000000, 0xe0000000
+    TEST_PSIMD_RR_SET 126, aaddu, 0x40000000, 0x80000000, 0x60000000
+    TEST_PSIMD_RR_SET 127, asub, 0x80000000, 0x40000000, 0xa0000000
+    TEST_PSIMD_RR_SET 128, asubu, 0x80000000, 0x40000000, 0x20000000
+    TEST_PSIMD_SAT_RR_SET 129, ssh1sadd, 1, 2, 4, \
+                          0x40000000, 0, 0x7fffffff, \
+                          0xc0000000, -1, 0x80000000
+
+    /* Byte double-wide signed/unsigned average operations. */
+    TEST_PSIMD_PAIR_RR_SET 130, paadd.db, \
+                           0x7f120003, 0x7f120003, \
+                           0x7f340007, 0x7f340007, \
+                           0x7f230005, 0x7f230005, 0
+    TEST_PSIMD_PAIR_RR 130, paadd.db, 0x7f7f7f7f, 0x7f7f7f7f, \
+                        0x80808080, 0x80808080, -1, -1
+    TEST_PSIMD_PAIR_RR_SET 131, paaddu.db, \
+                           0x7f120003, 0x7f120003, \
+                           0x7f340007, 0x7f340007, \
+                           0x7f230005, 0x7f230005, 0
+    TEST_PSIMD_PAIR_RR 131, paaddu.db, -1, -1, \
+                        0x01010101, 0x01010101, \
+                        0x80808080, 0x80808080
+    TEST_PSIMD_PAIR_RR_SET 132, pasub.db, \
+                           0xffff0000, 0xffff0000, \
+                           0x11110001, 0x11110001, \
+                           0xf7f700ff, 0xf7f700ff, 0
+    TEST_PSIMD_PAIR_RR 132, pasub.db, 0x80808080, 0x80808080, \
+                        0x7f7f7f7f, 0x7f7f7f7f, \
+                        0x80808080, 0x80808080
+    TEST_PSIMD_PAIR_RR_SET 133, pasubu.db, \
+                           0xffff0000, 0xffff0000, \
+                           0x11110001, 0x11110001, \
+                           0x777700ff, 0x777700ff, 0
+    TEST_PSIMD_PAIR_RR 133, pasubu.db, -1, -1, 0, 0, \
+                        0x7f7f7f7f, 0x7f7f7f7f
+
+    /* Halfword double-wide signed/unsigned average operations. */
+    TEST_PSIMD_PAIR_RR_SET 134, paadd.dh, \
+                           0x7f120003, 0x7f120003, \
+                           0x7f340007, 0x7f340007, \
+                           0x7f230005, 0x7f230005, 0
+    TEST_PSIMD_PAIR_RR 134, paadd.dh, 0x7fff7fff, 0x7fff7fff, \
+                        0x80008000, 0x80008000, -1, -1
+    TEST_PSIMD_PAIR_RR_SET 135, paaddu.dh, \
+                           0x7f120003, 0x7f120003, \
+                           0x7f340007, 0x7f340007, \
+                           0x7f230005, 0x7f230005, 0
+    TEST_PSIMD_PAIR_RR 135, paaddu.dh, -1, -1, \
+                        0x00010001, 0x00010001, \
+                        0x80008000, 0x80008000
+    TEST_PSIMD_PAIR_RR_SET 136, pasub.dh, \
+                           0xffff0000, 0xffff0000, \
+                           0x11110001, 0x11110001, \
+                           0xf777ffff, 0xf777ffff, 0
+    TEST_PSIMD_PAIR_RR 136, pasub.dh, 0x80008000, 0x80008000, \
+                        0x7fff7fff, 0x7fff7fff, \
+                        0x80008000, 0x80008000
+    TEST_PSIMD_PAIR_RR_SET 137, pasubu.dh, \
+                           0xffff0000, 0xffff0000, \
+                           0x11110001, 0x11110001, \
+                           0x7777ffff, 0x7777ffff, 0
+    TEST_PSIMD_PAIR_RR 137, pasubu.dh, -1, -1, 0, 0, \
+                        0x7fff7fff, 0x7fff7fff
+
+    /* Word double-wide averages use distinct low/high source registers. */
+    TEST_PSIMD_PAIR_RR_SET 138, paadd.dw, \
+                           0xffffff78, 0xffffff12, \
+                           0xffffff9a, 0xffffff34, \
+                           0xffffff89, 0xffffff23, 0
+    TEST_PSIMD_PAIR_RR 138, paadd.dw, 0x7fffffff, 0x7fffffff, \
+                        0x80000000, 0x80000000, -1, -1
+    TEST_PSIMD_PAIR_RR_SET 139, paaddu.dw, \
+                           0xffffff78, 0xffffff12, \
+                           0xffffff9a, 0xffffff34, \
+                           0xffffff89, 0xffffff23, 0
+    TEST_PSIMD_PAIR_RR 139, paaddu.dw, -1, -1, 1, 1, \
+                        0x80000000, 0x80000000
+    TEST_PSIMD_PAIR_RR_SET 140, pasub.dw, \
+                           1, 0, -1, 1, 1, -1, 0
+    TEST_PSIMD_PAIR_RR 140, pasub.dw, 0x80000000, 0x80000000, \
+                        0x7fffffff, 0x7fffffff, \
+                        0x80000000, 0x80000000
+    TEST_PSIMD_PAIR_RR_SET 141, pasubu.dw, \
+                           1, 0, -1, 1, 0x80000001, -1, 0
+    TEST_PSIMD_PAIR_RR 141, pasubu.dw, -1, -1, 0, 0, \
+                        0x7fffffff, 0x7fffffff
+
+    /* Double-wide shift-one add, wrapping and saturating. */
+    TEST_PSIMD_PAIR_RR_SET 142, psh1add.dh, \
+                           0x01010101, 0x02020202, \
+                           0x01010101, 0x03030303, \
+                           0x03030303, 0x07070707, 0
+    TEST_PSIMD_PAIR_RR_SET 143, psh1add.dw, \
+                           1, 2, 3, 4, 5, 8, 0
+    TEST_PSIMD_PAIR_SAT_RR_SET 144, pssh1sadd.dh, \
+        0x00010001, 0x00020002, 0x00020002, 0x00030003, \
+        0x00040004, 0x00070007, \
+        0x40004000, 0x40004000, 0, 0, 0x7fff7fff, 0x7fff7fff, \
+        0xc000c000, 0xc000c000, -1, -1, 0x80008000, 0x80008000
+    TEST_PSIMD_PAIR_SAT_RR_SET 145, pssh1sadd.dw, \
+        1, 2, 2, 3, 4, 7, \
+        0x40000000, 0x40000000, 0, 0, 0x7fffffff, 0x7fffffff, \
+        0xc0000000, 0xc0000000, -1, -1, 0x80000000, 0x80000000
+
+    /* Pair shifts use distinct low/high registers and overlap rd with rs1. */
+    TEST_PSIMD_PAIR_SHIFT_RR_SET 190, psll.dbs, \
+        0x807f1201, 0xff400a05, 0x00fe2402, 0xfe80140a, \
+        7, 0x00800080, 0x80000080
+    TEST_PSIMD_PAIR_SHIFT_RR_SET 191, psrl.dbs, \
+        0x807f1201, 0xff400a05, 0x403f0900, 0x7f200502, \
+        7, 0x01000000, 0x01000000
+    TEST_PSIMD_PAIR_SHIFT_RR_SET 192, psra.dbs, \
+        0x807f1201, 0xff400a05, 0xc03f0900, 0xff200502, \
+        7, 0xff000000, 0xff000000
+    TEST_PSIMD_PAIR_SHIFT_RI_SET 193, pslli.db, \
+        0x807f1201, 0xff400a05, 0x00fe2402, 0xfe80140a, \
+        7, 0x00800080, 0x80000080
+    TEST_PSIMD_PAIR_SHIFT_RI_SET 194, psrli.db, \
+        0x807f1201, 0xff400a05, 0x403f0900, 0x7f200502, \
+        7, 0x01000000, 0x01000000
+    TEST_PSIMD_PAIR_SHIFT_RI_SET 195, psrai.db, \
+        0x807f1201, 0xff400a05, 0xc03f0900, 0xff200502, \
+        7, 0xff000000, 0xff000000
+
+    TEST_PSIMD_PAIR_SHIFT_RR_SET 196, psll.dhs, \
+        0x80017fff, 0x0003fffe, 0x0002fffe, 0x0006fffc, \
+        15, 0x80008000, 0x80000000
+    TEST_PSIMD_PAIR_SHIFT_RR_SET 197, psrl.dhs, \
+        0x80017fff, 0x0003fffe, 0x40003fff, 0x00017fff, \
+        15, 0x00010000, 0x00000001
+    TEST_PSIMD_PAIR_SHIFT_RR_SET 198, psra.dhs, \
+        0x80017fff, 0x0003fffe, 0xc0003fff, 0x0001ffff, \
+        15, 0xffff0000, 0x0000ffff
+    TEST_PSIMD_PAIR_SHIFT_RI_SET 199, pslli.dh, \
+        0x80017fff, 0x0003fffe, 0x0002fffe, 0x0006fffc, \
+        15, 0x80008000, 0x80000000
+    TEST_PSIMD_PAIR_SHIFT_RI_SET 200, psrli.dh, \
+        0x80017fff, 0x0003fffe, 0x40003fff, 0x00017fff, \
+        15, 0x00010000, 0x00000001
+    TEST_PSIMD_PAIR_SHIFT_RI_SET 201, psrai.dh, \
+        0x80017fff, 0x0003fffe, 0xc0003fff, 0x0001ffff, \
+        15, 0xffff0000, 0x0000ffff
+
+    TEST_PSIMD_PAIR_SHIFT_RR_SET 202, psll.dws, \
+        0x80000001, 0x7fffffff, 0x00000002, 0xfffffffe, \
+        31, 0x80000000, 0x80000000
+    TEST_PSIMD_PAIR_SHIFT_RR_SET 203, psrl.dws, \
+        0x80000001, 0x7fffffff, 0x40000000, 0x3fffffff, \
+        31, 1, 0
+    TEST_PSIMD_PAIR_SHIFT_RR_SET 204, psra.dws, \
+        0x80000001, 0x7fffffff, 0xc0000000, 0x3fffffff, \
+        31, -1, 0
+    TEST_PSIMD_PAIR_SHIFT_RI_SET 205, pslli.dw, \
+        0x80000001, 0x7fffffff, 0x00000002, 0xfffffffe, \
+        31, 0x80000000, 0x80000000
+    TEST_PSIMD_PAIR_SHIFT_RI_SET 206, psrli.dw, \
+        0x80000001, 0x7fffffff, 0x40000000, 0x3fffffff, \
+        31, 1, 0
+    TEST_PSIMD_PAIR_SHIFT_RI_SET 207, psrai.dw, \
+        0x80000001, 0x7fffffff, 0xc0000000, 0x3fffffff, \
+        31, -1, 0
+
+    /* Scalar halfword-selection multiply validates all source selectors. */
+    TEST_PSIMD_RR_SET 360, mul.h00, 0xffff7fff, 0xffff7fff, \
+                       0x3fff0001
+    TEST_PSIMD_RR_SET 361, mul.h01, 0xffff7fff, 0x7fffffff, \
+                       0x3fff0001
+    TEST_PSIMD_RR_SET 362, mul.h11, 0x7fffffff, 0x7fffffff, \
+                       0x3fff0001
+    TEST_PSIMD_RR_SET 363, mulsu.h00, 0x8000ffff, 0x7fff8000, \
+                       0xffff8000
+    TEST_PSIMD_RR_SET 364, mulsu.h11, 0x8000ffff, 0x7fff8000, \
+                       0xc0008000
+    TEST_PSIMD_RR_SET 365, mulu.h00, 0x8000ffff, 0x7fff8000, \
+                       0x7fff8000
+    TEST_PSIMD_RR_SET 366, mulu.h01, 0x8000ffff, 0x7fff8000, \
+                       0x7ffe8001
+    TEST_PSIMD_RR_SET 367, mulu.h11, 0x8000ffff, 0x7fff8000, \
+                       0x3fff8000
+    TEST_PSIMD_RR_SET 380, mulhr, 1, -1, 0
+    TEST_PSIMD_RR_SET 381, mulhrsu, 1, -1, 1
+    TEST_PSIMD_RR_SET 382, mulhru, -1, -1, -2
+    TEST_PSIMD_SAT_RR_SET 387, mulq, 1, 0x40000000, 0, \
+                          0x80000000, 0x80000000, 0x7fffffff, \
+                          0x80000000, 0x80000000, 0x7fffffff
+    TEST_PSIMD_SAT_RR_SET 388, mulqr, 1, 0x40000000, 1, \
+                          0x80000000, 0x80000000, 0x7fffffff, \
+                          0x80000000, 0x80000000, 0x7fffffff
+    TEST_PSIMD_RR_SET 397, mulh.h0, 1, 0x0000ffff, -1
+    TEST_PSIMD_RR_SET 398, mulh.h1, 1, 0xffff0000, -1
+    TEST_PSIMD_RR_SET 399, mulhsu.h0, 0x7fffffff, 0x0000ffff, \
+                       0x7fff7fff
+    TEST_PSIMD_RR_SET 400, mulhsu.h1, 0x80000000, 0xffff0000, \
+                       0x80008000
+
+    /* Pair signed variable shifts cover saturating left and rounded right. */
+    TEST_PSIMD_PAIR_VAR_SAT_SET 340, pssha.dhs, \
+        0x0001ffff, 0x0002fffe, 0x0002fffe, 0x0004fffc, \
+        0x40004000, 0x40004000, 0x7fff7fff, 0x7fff7fff, \
+        0xbfffbfff, 0xbfffbfff, 0x80008000, 0x80008000
+    TEST_PSIMD_PAIR_SHIFT_RR_VXSAT_STATE 340, pssha.dhs, \
+        0x0003fffc, 0x00050004, -1, \
+        0x0001fffe, 0x00020002, 0, 0
+    TEST_PSIMD_PAIR_VAR_SAT_SET 341, psshar.dhs, \
+        0x0001ffff, 0x0002fffe, 0x0002fffe, 0x0004fffc, \
+        0x40004000, 0x40004000, 0x7fff7fff, 0x7fff7fff, \
+        0xbfffbfff, 0xbfffbfff, 0x80008000, 0x80008000
+    TEST_PSIMD_PAIR_SHIFT_RR_VXSAT_STATE 341, psshar.dhs, \
+        0x0003fffc, 0x00050004, -1, \
+        0x0002fffe, 0x00030002, 0, 0
+    TEST_PSIMD_PAIR_VAR_SAT_SET 342, pssha.dws, \
+        1, -1, 2, -2, \
+        0x40000000, 0x40000000, 0x7fffffff, 0x7fffffff, \
+        0xbfffffff, 0xbfffffff, 0x80000000, 0x80000000
+    TEST_PSIMD_PAIR_SHIFT_RR_VXSAT_STATE 342, pssha.dws, \
+        3, -4, -1, 1, -2, 0, 0
+    TEST_PSIMD_PAIR_VAR_SAT_SET 343, psshar.dws, \
+        1, -1, 2, -2, \
+        0x40000000, 0x40000000, 0x7fffffff, 0x7fffffff, \
+        0xbfffffff, 0xbfffffff, 0x80000000, 0x80000000
+    TEST_PSIMD_PAIR_SHIFT_RR_VXSAT_STATE 343, psshar.dws, \
+        3, -4, -1, 2, -2, 0, 0
+
+    /* Pair signed/unsigned saturation checks all lanes and sticky vxsat. */
+    /* Signed operands specify width; the encoded immediate is width - 1. */
+    TEST_PSIMD_PAIR_SAT_RI_SET 319, psati.dh, 5, \
+        0x000ffff0, 0xfff0000f, 0x000ffff0, 0xfff0000f, \
+        0x00100010, 0x00100010, 0x000f000f, 0x000f000f, \
+        0xffefffef, 0xffefffef, 0xfff0fff0, 0xfff0fff0
+    TEST_PSIMD_PAIR_SAT_RI_SET 320, psati.dw, 5, \
+        15, -16, 15, -16, 16, 16, 15, 15, -17, -17, -16, -16
+    TEST_PSIMD_PAIR_SAT_RI_SET 321, pusati.dh, 4, \
+        0x000f0000, 0x0000000f, 0x000f0000, 0x0000000f, \
+        0x00100010, 0x00100010, 0x000f000f, 0x000f000f, \
+        -1, -1, 0, 0
+    TEST_PSIMD_PAIR_SAT_RI_SET 322, pusati.dw, 4, \
+        15, 0, 15, 0, 16, 16, 15, 15, -1, -1, 0, 0
+    TEST_PSIMD_PAIR_RI_VXSAT_STATE 319, psati.dh, \
+        0x7fff8000, 0x0001ffff, 16, \
+        0x7fff8000, 0x0001ffff, 0, 0
+    TEST_PSIMD_PAIR_RI_VXSAT_STATE 320, psati.dw, \
+        0x7fffffff, 0x80000000, 32, \
+        0x7fffffff, 0x80000000, 0, 0
+    TEST_PSIMD_PAIR_RI_VXSAT_STATE 321, pusati.dh, \
+        0x7fff0000, 0x00010001, 15, \
+        0x7fff0000, 0x00010001, 0, 0
+    TEST_PSIMD_PAIR_RI_VXSAT_STATE 322, pusati.dw, \
+        0x7fffffff, 0, 31, 0x7fffffff, 0, 0, 0
+    TEST_PSIMD_PAIR_SAT_RI_SET 326, psslai.dh, 1, \
+        0x0001ffff, 0x0002fffe, 0x0002fffe, 0x0004fffc, \
+        0x40004000, 0x40004000, 0x7fff7fff, 0x7fff7fff, \
+        0xbfffbfff, 0xbfffbfff, 0x80008000, 0x80008000
+    TEST_PSIMD_PAIR_SAT_RI_SET 327, psslai.dw, 1, \
+        1, -1, 2, -2, \
+        0x40000000, 0x40000000, 0x7fffffff, 0x7fffffff, \
+        0xbfffffff, 0xbfffffff, 0x80000000, 0x80000000
+    TEST_PSIMD_PAIR_RI_VXSAT_STATE 326, psslai.dh, \
+        0, 0, 15, 0, 0, 0, 0
+    TEST_PSIMD_PAIR_RI_VXSAT_STATE 327, psslai.dw, \
+        0, 0, 31, 0, 0, 0, 0
+
+    /* Full register-pair arithmetic checks carry, borrow, and pair aliases. */
+    TEST_PSIMD_PAIR_RR_SET 303, addd, -1, 0, 1, 0, 0, 1, 0
+    TEST_PSIMD_PAIR_RR_SET 304, subd, 0, 1, 1, 0, -1, 0, 0
+
+    /* Signed/unsigned widen results deliberately differ in the high word. */
+    TEST_PSIMD_WIDE_RR_SET 305, wadd, -1, -1, -2, -1
+    TEST_PSIMD_WIDE_RR_SET 306, waddu, -1, -1, -2, 1
+    TEST_PSIMD_WIDE_RR_SET 307, wsub, -1, 1, -2, -1
+    TEST_PSIMD_WIDE_RR_SET 308, wsubu, -1, 1, -2, 0
+
+    /* Accumulating forms start from the nonzero 64-bit value five. */
+    TEST_PSIMD_WIDE_ACC_RR_SET 309, wadda, 5, 0, -1, -1, 3, 0, \
+        0xfffffffd, 0, 0xfffffffd, 0
+    TEST_PSIMD_WIDE_ACC_RR 309, wadda, -1, -1, 0, 0, -1, -1
+    TEST_PSIMD_WIDE_ACC_RR_SET 310, waddau, 5, 0, -1, -1, 3, 2, \
+        0xfffffffd, 2, 0xfffffffd, 2
+    TEST_PSIMD_WIDE_ACC_RR_SET 311, wsuba, 5, 0, -1, 1, 3, 0, \
+        0xfffffffd, 0, 0xffffffff, 0xffffffff
+    TEST_PSIMD_WIDE_ACC_RR_SET 312, wsubau, 5, 0, -1, 1, 3, 1, \
+        0xfffffffd, 1, 0xffffffff, 0
+
+    /* Pair immediates cover zero, one, signed extrema, and encoding high bits. */
+    TEST_PSIMD_PAIR_LI_SET 286, pli.db, 0x01010101, 255, -1, 0, 0
+    TEST_PSIMD_PAIR_LI_SET 287, pli.dh, 0x00010001, 511, \
+                            0x01ff01ff, -512, 0xfe00fe00
+    TEST_PSIMD_PAIR_LI_SET 288, plui.dh, 0x00400040, 511, \
+                            0x7fc07fc0, -512, 0x80008000
+
+    /* Pair sign extension verifies each extracted element and output order. */
+    TEST_PSIMD_PAIR_R_SET 289, psext.dh.b, 0x007f0080, 0x000100ff, \
+                           0x007fff80, 0x0001ffff
+    TEST_PSIMD_PAIR_R_SET 290, psext.dw.b, 0x00000080, 0x0000007f, \
+                           0xffffff80, 0x0000007f
+    TEST_PSIMD_PAIR_R_SET 291, psext.dw.h, 0x0000ffff, 0x00008000, \
+                           -1, 0xffff8000
+
+    /* Double-wide pair/merge verifies both register halves and overlap. */
+    TEST_PSIMD_PAIR_RR_SET 271, ppaire.db, \
+        0x11223344, 0x55667788, 0xaabbccdd, 0xddeeff00, \
+        0xbb22dd44, 0xee660088, 0
+    TEST_PSIMD_PAIR_RR_SET 272, ppaireo.db, \
+        0x11223344, 0x55667788, 0xaabbccdd, 0xddeeff00, \
+        0xaa22cc44, 0xdd66ff88, 0
+    TEST_PSIMD_PAIR_RR_SET 273, ppairoe.db, \
+        0x11223344, 0x55667788, 0xaabbccdd, 0xddeeff00, \
+        0xbb11dd33, 0xee550077, 0
+    TEST_PSIMD_PAIR_RR_SET 274, ppairo.db, \
+        0x11223344, 0x55667788, 0xaabbccdd, 0xddeeff00, \
+        0xaa11cc33, 0xdd55ff77, 0
+    TEST_PSIMD_PAIR_RR_SET 275, ppaire.dh, \
+        0x11223344, 0x55667788, 0xaabbccdd, 0xddeeff00, \
+        0xccdd3344, 0xff007788, 0
+    TEST_PSIMD_PAIR_RR_SET 276, ppaireo.dh, \
+        0x11223344, 0x55667788, 0xaabbccdd, 0xddeeff00, \
+        0xaabb3344, 0xddee7788, 0
+    TEST_PSIMD_PAIR_RR_SET 277, ppairoe.dh, \
+        0x11223344, 0x55667788, 0xaabbccdd, 0xddeeff00, \
+        0xccdd1122, 0xff005566, 0
+    TEST_PSIMD_PAIR_RR_SET 278, ppairo.dh, \
+        0x11223344, 0x55667788, 0xaabbccdd, 0xddeeff00, \
+        0xaabb1122, 0xddee5566, 0
+
+    /* Signed narrowing clip: exact bounds plus both overflow directions. */
+    TEST_PSIMD_PAIR_CLIP_RI_SET 231, pnclipi.b, \
+        0x00feff00, 0x0002fffe, 1, 0x01ff7f80, \
+        0x0100fefe, 0x7fff8000, 0x7f807f80
+    TEST_PSIMD_PAIR_CLIP_RR_SET 232, pnclip.bs, \
+        0x00feff00, 0x0002fffe, 1, 0x01ff7f80, \
+        0x0100fefe, 0x7fff8000, 0x7f807f80
+    TEST_PSIMD_PAIR_CLIP_RI_SET 233, pnclipri.b, \
+        0x00fdff01, 0x0001fffd, 1, 0x01ff7f81, \
+        0x00fffefd, 0x7fff8000, 0x7f807f80
+    TEST_PSIMD_PAIR_CLIP_RR_SET 234, pnclipr.bs, \
+        0x00fdff01, 0x0001fffd, 1, 0x01ff7f81, \
+        0x00fffefd, 0x7fff8000, 0x7f807f80
+
+    TEST_PSIMD_PAIR_CLIP_RI_SET 235, pnclipi.h, \
+        0xffff0000, 0x0000fffe, 1, 0x7fff8000, \
+        0xfffefffe, 0x00010000, 0x7fff8000
+    TEST_PSIMD_PAIR_CLIP_RR_SET 236, pnclip.hs, \
+        0xffff0000, 0x0000fffe, 1, 0x7fff8000, \
+        0xfffefffe, 0x00010000, 0x7fff8000
+    TEST_PSIMD_PAIR_CLIP_RI_SET 237, pnclipri.h, \
+        0xffff0001, 0x0000fffd, 1, 0x7fff8001, \
+        0xfffefffd, 0x0000ffff, 0x7fff8000
+    TEST_PSIMD_PAIR_CLIP_RR_SET 238, pnclipr.hs, \
+        0xffff0001, 0x0000fffd, 1, 0x7fff8001, \
+        0xfffefffd, 0x0000ffff, 0x7fff8000
+
+    TEST_PSIMD_PAIR_CLIP_RI_SET 239, nclipi, \
+        0xfffffffe, -1, 1, 0xffffffff, \
+        0, 1, 0x7fffffff
+    TEST_PSIMD_PAIR_NARROW_RI_VXSAT_STATE 239, nclipi, 0, -2, 1, \
+        0x80000000, 0, 1
+    TEST_PSIMD_PAIR_CLIP_RR_SET 240, nclip, \
+        0xfffffffe, -1, 1, 0xffffffff, \
+        0, 1, 0x7fffffff
+    TEST_PSIMD_PAIR_NARROW_RR_VXSAT_STATE 240, nclip, 0, -2, 1, \
+        0x80000000, 0, 1
+    TEST_PSIMD_PAIR_CLIP_RI_SET 241, nclipri, \
+        0xffffffff, -1, 1, 0, \
+        1, 2, 0x7fffffff
+    TEST_PSIMD_PAIR_NARROW_RI_VXSAT_STATE 241, nclipri, 0, -2, 1, \
+        0x80000000, 0, 1
+    TEST_PSIMD_PAIR_CLIP_RR_SET 242, nclipr, \
+        0xffffffff, -1, 1, 0, \
+        1, 2, 0x7fffffff
+    TEST_PSIMD_PAIR_NARROW_RR_VXSAT_STATE 242, nclipr, 0, -2, 1, \
+        0x80000000, 0, 1
+
+    /* Unsigned clip uses logical shifts; high-bit inputs are not negative. */
+    TEST_PSIMD_PAIR_CLIP_RI_SET 243, pnclipiu.b, \
+        0x01fe0000, 0x00030002, 1, 0x0101ff00, \
+        0x02000000, 0xffff0400, 0xffffff00
+    TEST_PSIMD_PAIR_CLIP_RR_SET 244, pnclipu.bs, \
+        0x01fe0000, 0x00030002, 1, 0x0101ff00, \
+        0x02000000, 0xffff0400, 0xffffff00
+    TEST_PSIMD_PAIR_CLIP_RI_SET 245, pnclipriu.b, \
+        0x01fd0000, 0x00030002, 1, 0x0201ff00, \
+        0x01ff0000, 0xffff0400, 0xffffff00
+    TEST_PSIMD_PAIR_CLIP_RR_SET 246, pnclipru.bs, \
+        0x01fd0000, 0x00030002, 1, 0x0201ff00, \
+        0x01ff0000, 0xffff0400, 0xffffff00
+
+    TEST_PSIMD_PAIR_CLIP_RI_SET 247, pnclipiu.h, \
+        0x0001fffe, 2, 1, 0x0001ffff, \
+        0x00020000, 0xffffffff, 0xffffffff
+    TEST_PSIMD_PAIR_CLIP_RR_SET 248, pnclipu.hs, \
+        0x0001fffe, 2, 1, 0x0001ffff, \
+        0x00020000, 0xffffffff, 0xffffffff
+    TEST_PSIMD_PAIR_CLIP_RI_SET 249, pnclipriu.h, \
+        0x0001fffd, 3, 1, 0x0002ffff, \
+        0x0001ffff, 0xffffffff, 0xffffffff
+    TEST_PSIMD_PAIR_CLIP_RR_SET 250, pnclipru.hs, \
+        0x0001fffd, 3, 1, 0x0002ffff, \
+        0x0001ffff, 0xffffffff, 0xffffffff
+
+    TEST_PSIMD_PAIR_CLIP_RI_SET 251, nclipiu, \
+        0xfffffffe, 1, 1, 0xffffffff, 0, 2, -1
+    TEST_PSIMD_PAIR_CLIP_RR_SET 252, nclipu, \
+        0xfffffffe, 1, 1, 0xffffffff, 0, 2, -1
+    TEST_PSIMD_PAIR_CLIP_RI_SET 253, nclipriu, \
+        0xfffffffd, 1, 1, 0xffffffff, 0xffffffff, 3, -1
+    TEST_PSIMD_PAIR_CLIP_RR_SET 254, nclipru, \
+        0xfffffffd, 1, 1, 0xffffffff, 0xffffffff, 3, -1
+
+    /* Narrowing shifts pack pair lanes in low-to-high source order. */
+    TEST_PSIMD_PAIR_NARROW_RI_SET 213, pnsrli.b, \
+        0x0003fffc, 0x80017fff, 0x01ff03fc, 0x00ff01fe, \
+        15, 0x01000001
+    pnsrli.b a0, zero, 1
+    PSIMD_FAIL_IF_NE a0, zero, 213
+    TEST_PSIMD_PAIR_NARROW_RR_SET 214, pnsrl.bs, \
+        0x0003fffc, 0x80017fff, 0x01ff03fc, 0x00ff01fe, \
+        15, 0x01000001
+    TEST_PSIMD_PAIR_NARROW_RI_SET 215, pnsrai.b, \
+        0x0003fffc, 0x80017fff, 0x01ff03fc, 0x00ff01fe, \
+        15, 0xff0000ff
+    TEST_PSIMD_PAIR_NARROW_RR_SET 216, pnsra.bs, \
+        0x0003fffc, 0x80017fff, 0x01ff03fc, 0x00ff01fe, \
+        15, 0xff0000ff
+    TEST_PSIMD_PAIR_NARROW_RI_SET 217, pnsrari.b, \
+        0x0003fffc, 0x80017fff, 0x01ff03fc, 0x010002fe, \
+        15, 0xff010000
+    TEST_PSIMD_PAIR_NARROW_RR_SET 218, pnsrar.bs, \
+        0x0003fffc, 0x80017fff, 0x01ff03fc, 0x010002fe, \
+        15, 0xff010000
+
+    TEST_PSIMD_PAIR_NARROW_RI_SET 219, pnsrli.h, \
+        0x80000003, 0x7ffffffc, 0xfffc0003, 0xfffe0001, \
+        31, 1
+    TEST_PSIMD_PAIR_NARROW_RR_SET 220, pnsrl.hs, \
+        0x80000003, 0x7ffffffc, 0xfffc0003, 0xfffe0001, \
+        31, 1
+    TEST_PSIMD_PAIR_NARROW_RI_SET 221, pnsrai.h, \
+        0x80000003, 0x7ffffffc, 0xfffc0003, 0xfffe0001, \
+        31, 0x0000ffff
+    TEST_PSIMD_PAIR_NARROW_RR_SET 222, pnsra.hs, \
+        0x80000003, 0x7ffffffc, 0xfffc0003, 0xfffe0001, \
+        31, 0x0000ffff
+    TEST_PSIMD_PAIR_NARROW_RI_SET 223, pnsrari.h, \
+        0x80000003, 0x7ffffffc, 0xfffc0003, 0xfffe0002, \
+        31, 0x0001ffff
+    TEST_PSIMD_PAIR_NARROW_RR_SET 224, pnsrar.hs, \
+        0x80000003, 0x7ffffffc, 0xfffc0003, 0xfffe0002, \
+        31, 0x0001ffff
+
+    TEST_PSIMD_PAIR_NARROW_RI_SET 225, nsrli, \
+        3, 0x80000001, 3, 0x80000001, 63, 1
+    TEST_PSIMD_PAIR_NARROW_RR_SET 226, nsrl, \
+        3, 0x80000001, 3, 0x80000001, 63, 1
+    TEST_PSIMD_PAIR_NARROW_RI_SET 227, nsrai, \
+        3, 0x80000001, 3, 0x80000001, 63, -1
+    TEST_PSIMD_PAIR_NARROW_RR_SET 228, nsra, \
+        3, 0x80000001, 3, 0x80000001, 63, -1
+    TEST_PSIMD_PAIR_NARROW_RI_SET 229, nsrari, \
+        3, 0x80000001, 3, 0x80000002, 63, -1
+    TEST_PSIMD_PAIR_NARROW_RR_SET 230, nsrar, \
+        3, 0x80000001, 3, 0x80000002, 63, -1
+
+    /* Pair rounded shifts cover guard zero/one and signed negative lanes. */
+    TEST_PSIMD_PAIR_SHIFT_RI_SET 211, psrari.dh, \
+        0xfffd0002, 0x80017fff, 0xffff0001, 0xc0014000, \
+        15, 0, 0xffff0001
+    TEST_PSIMD_PAIR_SHIFT_RI_SET 212, psrari.dw, \
+        0x80000001, 0x7fffffff, 0xc0000001, 0x40000000, \
+        31, -1, 1
+
+    /* Double-wide absolute difference verifies low/high pair ordering. */
+    TEST_PSIMD_PAIR_RR_SET 162, pabd.db, 0x7f7f01ff, 0x807f0201, \
+                           0x7f70ff7e, 0x018001ff, \
+                           0x000f027f, 0x81ff0102, 0
+    TEST_PSIMD_PAIR_RR_SET 163, pabdu.db, 0x807f01ff, 0x807f0201, \
+                           0x7f01fffe, 0x018001ff, \
+                           0x017efe01, 0x7f0101fe, 0
+    TEST_PSIMD_PAIR_RR_SET 164, pabd.dh, 0x00017fff, 0xfffe7fff, \
+                           0x00020001, 0x00010001, \
+                           0x00017ffe, 0x00037ffe, 0
+    TEST_PSIMD_PAIR_RR_SET 165, pabdu.dh, 0xfffe7fff, 0x00020002, \
+                           0x00010001, 0x00010004, \
+                           0xfffd7ffe, 0x00010002, 0
+
+    TEST_PSIMD_PAIR_SAT_R_SET 166, psabs.db, \
+        0x7fff0181, 0x01ff7f81, 0x7f01017f, 0x01017f7f, \
+        0x80008000, 0x00800080, 0x7f007f00, 0x007f007f
+    TEST_PSIMD_PAIR_SAT_R_SET 167, psabs.dh, \
+        0x7fffffff, 0x0001ffff, 0x7fff0001, 0x00010001, \
+        0x80000001, 0x00018000, 0x7fff0001, 0x00017fff
+
+    /* Pair reductions use all eight bytes/four halfwords and scalar rs2. */
+    TEST_PSIMD_PAIR_REDUCE 168, predsum.dbs, 0x0403fe01, \
+                            0x807f02ff, 0xa, 0x10
+    TEST_PSIMD_PAIR_REDUCE 169, predsumu.dbs, 0x0403fe01, \
+                            0x807f02ff, 0xa, 0x310
+    TEST_PSIMD_PAIR_REDUCE 170, predsum.dhs, 0x0403fe01, \
+                            0x807f02ff, 0xa, 0xffff858c
+    TEST_PSIMD_PAIR_REDUCE 171, predsumu.dhs, 0x0403fe01, \
+                            0x807f02ff, 0xa, 0x0001858c
+
+    /*
+     * Widening multiply: every source lane differs, so these values also
+     * check lane placement and the low/high destination-register ordering.
+     * The SET form additionally covers zero and rd overlap with each source.
+     */
+    TEST_PSIMD_WIDE_RR_SET 401, pwmul.b, 0x7f80ff01, 0x0203fe04, \
+                           0x00020004, 0x00fefe80
+    TEST_PSIMD_WIDE_RR_SET 402, pwmulsu.b, 0x7f80ff01, 0x0203fe04, \
+                           0xff020004, 0x00fefe80
+    TEST_PSIMD_WIDE_RR_SET 403, pwmulu.b, 0x7f80ff01, 0x0203fe04, \
+                           0xfd020004, 0x00fe0180
+    TEST_PSIMD_WIDE_RR_SET 404, pwmul.h, 0x7fff8000, 0x0002ffff, \
+                           0x00008000, 0x0000fffe
+    TEST_PSIMD_WIDE_RR_SET 405, pwmulsu.h, 0x7fff8000, 0x0002ffff, \
+                           0x80008000, 0x0000fffe
+    TEST_PSIMD_WIDE_RR_SET 406, pwmulu.h, 0x7fff8000, 0x0002ffff, \
+                           0x7fff8000, 0x0000fffe
+
+    /* Full-width products distinguish signed, signed/unsigned and unsigned. */
+    TEST_PSIMD_WIDE_RR_SET 407, wmul, 0x80000000, 3, \
+                           0x80000000, 0xfffffffe
+    TEST_PSIMD_WIDE_RR_SET 408, wmulsu, -2, 0xffffffff, \
+                           2, 0xfffffffe
+    TEST_PSIMD_WIDE_RR_SET 409, wmulu, 0xffffffff, 2, \
+                           0xfffffffe, 1
+
+    /* Packed widening add/sub: signedness changes the widened upper bits. */
+    TEST_PSIMD_WIDE_RR_SET 418, pwadd.b, 0x7f80ff01, 0x0203fe04, \
+                           0xfffd0005, 0x0081ff83
+    TEST_PSIMD_WIDE_RR_SET 419, pwaddu.b, 0x7f80ff01, 0x0203fe04, \
+                           0x01fd0005, 0x00810083
+    TEST_PSIMD_WIDE_RR_SET 420, pwsub.b, 0x7f80ff01, 0x0203fe04, \
+                           0x0001fffd, 0x007dff7d
+    TEST_PSIMD_WIDE_RR_SET 421, pwsubu.b, 0x7f80ff01, 0x0203fe04, \
+                           0x0001fffd, 0x007d007d
+    TEST_PSIMD_WIDE_RR_SET 422, pwadd.h, 0x7fff8000, 0x0002ffff, \
+                           0xffff7fff, 0x00008001
+    TEST_PSIMD_WIDE_RR_SET 423, pwaddu.h, 0x7fff8000, 0x0002ffff, \
+                           0x00017fff, 0x00008001
+    TEST_PSIMD_WIDE_RR_SET 424, pwsub.h, 0x8000ffff, 0x00017fff, \
+                           0xffff8000, 0xffff7fff
+    TEST_PSIMD_WIDE_RR_SET 425, pwsubu.h, 0x8000ffff, 0x00017fff, \
+                           0x00008000, 0x00007fff
+
+    /* Accumulating forms start from distinct nonzero widened lanes. */
+    TEST_PSIMD_WIDE_ACC_RR_SET 426, pwadda.b, \
+        0x000a0001, 0x03e8fffb, 0x7f80ff01, 0x0203fe04, \
+        0x00070006, 0x0469ff7e, 0x7f7dff06, 0x0469ff7e, \
+        0x0200fe09, 0x0469ff7e
+    TEST_PSIMD_WIDE_ACC_RR_SET 427, pwaddau.b, \
+        0x000a0001, 0x03e8fffb, 0x7f80ff01, 0x0203fe04, \
+        0x02070006, 0x0469007e, 0x817dff06, 0x0469007e, \
+        0x0400fe09, 0x0469007e
+    TEST_PSIMD_WIDE_ACC_RR_SET 428, pwsuba.b, \
+        0x000a0001, 0x03e8fffb, 0x7f80ff01, 0x0203fe04, \
+        0x000bfffe, 0x0465ff78, 0x7f81fefe, 0x0465ff78, \
+        0x0204fe01, 0x0465ff78
+    TEST_PSIMD_WIDE_ACC_RR_SET 429, pwsubau.b, \
+        0x000a0001, 0x03e8fffb, 0x7f80ff01, 0x0203fe04, \
+        0x000bfffe, 0x04650078, 0x7f81fefe, 0x04650078, \
+        0x0204fe01, 0x04650078
+    TEST_PSIMD_WIDE_ACC_RR_SET 430, pwadda.h, \
+        5, -7, 0x7fff8000, 0x0002ffff, \
+        0xffff8004, 0x00007ffa, 0x7ffeffff, 0x00007ffa, \
+        0x00027ffe, 0x00007ffa
+    TEST_PSIMD_WIDE_ACC_RR_SET 431, pwaddau.h, \
+        5, -7, 0x7fff8000, 0x0002ffff, \
+        0x00018004, 0x00007ffa, 0x8000ffff, 0x00007ffa, \
+        0x00047ffe, 0x00007ffa
+    TEST_PSIMD_WIDE_ACC_RR_SET 432, pwsuba.h, \
+        5, -7, 0x8000ffff, 0x00017fff, \
+        0xffff8005, 0xffff7ff8, 0x80007fff, 0xffff7ff8, \
+        0x0000ffff, 0xffff7ff8
+    TEST_PSIMD_WIDE_ACC_RR_SET 433, pwsubau.h, \
+        5, -7, 0x8000ffff, 0x00017fff, \
+        0x00008005, 0x00007ff8, 0x80017fff, 0x00007ff8, \
+        0x0001ffff, 0x00007ff8
+
+    /* Scalar halfword MAC selection, modulo-32 accumulation and rd aliases. */
+    TEST_PSIMD_ACC_RR_SET 434, macc.h00, 0x7ffffffd, \
+                           0x8002fffd, 0x0004ffff, 0x80000000, \
+                           0x80030000, 0x00050002
+    TEST_PSIMD_ACC_RR_SET 435, macc.h01, 0x7ffffffd, \
+                           0x8002fffd, 0x0004ffff, 0x7ffffff1, \
+                           0x8002fff1, 0x0004fff3
+    TEST_PSIMD_ACC_RR_SET 436, macc.h11, 0x7ffffffd, \
+                           0x8002fffd, 0x0004ffff, 0x7ffe0005, \
+                           0x80010005, 0x00030007
+    TEST_PSIMD_ACC_RR_SET 437, maccsu.h00, 0x7ffffffd, \
+                           0x8002fffd, 0x0004ffff, 0x7ffd0000, \
+                           0x80000000, 0x00020002
+    TEST_PSIMD_ACC_RR_SET 438, maccsu.h11, 0x7ffffffd, \
+                           0x8002fffd, 0x0004ffff, 0x7ffe0005, \
+                           0x80010005, 0x00030007
+    TEST_PSIMD_ACC_RR_SET 439, maccu.h00, 0x7ffffffd, \
+                           0x8002fffd, 0x0004ffff, 0x7ffc0000, \
+                           0x7fff0000, 0x00010002
+    TEST_PSIMD_ACC_RR_SET 440, maccu.h01, 0x7ffffffd, \
+                           0x8002fffd, 0x0004ffff, 0x8003fff1, \
+                           0x8006fff1, 0x0008fff3
+    TEST_PSIMD_ACC_RR_SET 441, maccu.h11, 0x7ffffffd, \
+                           0x8002fffd, 0x0004ffff, 0x80020005, \
+                           0x80050005, 0x00070007
+
+    /* Multiply-high accumulation; rounded lanes straddle the guard bit. */
+    TEST_PSIMD_ACC_RR_SET 5, pmhacc.h, 0xfffe0001, \
+                           0x8001ffff, 0x7fff8000, 0xbffe0001, \
+                           0x4001ffff, 0x3fff8000
+    TEST_PSIMD_ACC_RR_SET 451, pmhaccsu.h, 0xfffe0001, \
+                           0x8001ffff, 0x7fff8000, 0xbffe0000, \
+                           0x4001fffe, 0x3fff7fff
+    TEST_PSIMD_ACC_RR_SET 452, pmhaccu.h, 0xfffe0001, \
+                           0x8001ffff, 0x7fff8000, 0x3ffd8000, \
+                           0xc0007ffe, 0xbffeffff
+    TEST_PSIMD_ACC_RR_SET 453, pmhracc.h, 0xfffe0001, \
+                           0x8001ffff, 0x7fff8000, 0xbfff0002, \
+                           0x40020000, 0x40008001
+    TEST_PSIMD_ACC_RR_SET 454, pmhraccsu.h, 0xfffe0001, \
+                           0x8001ffff, 0x7fff8000, 0xbfff0001, \
+                           0x4002ffff, 0x40008000
+    TEST_PSIMD_ACC_RR_SET 455, pmhraccu.h, 0xfffe0001, \
+                           0x8001ffff, 0x7fff8000, 0x3ffe8001, \
+                           0xc0017fff, 0xbfff0000
+
+    /* Scalar high-half MAC: product low word is exactly the rounding guard. */
+    TEST_PSIMD_ACC_RR_SET 456, mhacc, 0x7fffffff, \
+                           0x80000000, 0xffffffff, 0x7fffffff, \
+                           0x80000000, 0xffffffff
+    TEST_PSIMD_ACC_RR_SET 457, mhaccsu, 0x7fffffff, \
+                           0x80000000, 0xffffffff, 0xffffffff, \
+                           0, 0x7fffffff
+    TEST_PSIMD_ACC_RR_SET 458, mhaccu, 0x7fffffff, \
+                           0x80000000, 0xffffffff, 0xfffffffe, \
+                           0xffffffff, 0x7ffffffe
+    TEST_PSIMD_ACC_RR_SET 459, mhracc, 0x7fffffff, \
+                           0x80000000, 0xffffffff, 0x80000000, \
+                           0x80000001, 0
+    TEST_PSIMD_ACC_RR_SET 460, mhraccsu, 0x7fffffff, \
+                           0x80000000, 0xffffffff, 0, \
+                           1, 0x80000000
+    TEST_PSIMD_ACC_RR_SET 461, mhraccu, 0x7fffffff, \
+                           0x80000000, 0xffffffff, 0xffffffff, \
+                           0, 0x7fffffff
+
+    /* Halfword-by-selected-byte high products. */
+    TEST_PSIMD_ACC_RR_SET 462, pmhacc.h.b0, 0xfffe0001, \
+                           0x7fff8001, 0x02ff7f80, 0xff7e4000, \
+                           0x7f7fc000, 0x027fbf7f
+    TEST_PSIMD_ACC_RR_SET 463, pmhacc.h.b1, 0xfffe0001, \
+                           0x7fff8001, 0x02ff7f80, 0x00fdc081, \
+                           0x80fe4081, 0x03fe4000
+    TEST_PSIMD_ACC_RR_SET 464, pmhaccsu.h.b0, 0xfffe0001, \
+                           0x7fff8001, 0x02ff7f80, 0x7f7dc001, \
+                           0xff7e4001, 0x827e3f80
+    TEST_PSIMD_ACC_RR_SET 465, pmhaccsu.h.b1, 0xfffe0001, \
+                           0x7fff8001, 0x02ff7f80, 0x00fdc081, \
+                           0x80fe4081, 0x03fe4000
+
+    /* Full word by selected halfword, extracting product bits [47:16]. */
+    TEST_PSIMD_ACC_RR_SET 466, mhacc.h0, 0x7ffffffd, \
+                           0x80000001, 0x0004ffff, 0x80007ffc, \
+                           0x80008000, 0x00057ffe
+    TEST_PSIMD_ACC_RR_SET 467, mhacc.h1, 0x7ffffffd, \
+                           0x80000001, 0x0004ffff, 0x7ffdfffd, \
+                           0x7ffe0001, 0x0002ffff
+    TEST_PSIMD_ACC_RR_SET 468, mhaccsu.h0, 0x7ffffffd, \
+                           0x80000001, 0x0004ffff, 0x00007ffd, \
+                           0x00008001, 0x80057fff
+    TEST_PSIMD_ACC_RR_SET 469, mhaccsu.h1, 0x7ffffffd, \
+                           0x80000001, 0x0004ffff, 0x7ffdfffd, \
+                           0x7ffe0001, 0x0002ffff
+
+    /* Q15 selected-halfword accumulation; H00 has a set rounding guard. */
+    TEST_PSIMD_ACC_RR_SET 470, mqacc.h00, 0x7ffffffd, \
+                           0x80004001, 0x80004000, 0x80001ffd, \
+                           0x80006001, 0x80006000
+    TEST_PSIMD_ACC_RR_SET 471, mqacc.h01, 0x7ffffffd, \
+                           0x80004001, 0x80004000, 0x7fffbffc, \
+                           0x80000000, 0x7fffffff
+    TEST_PSIMD_ACC_RR_SET 472, mqacc.h11, 0x7ffffffd, \
+                           0x80004001, 0x80004000, 0x80007ffd, \
+                           0x8000c001, 0x8000c000
+    TEST_PSIMD_ACC_RR_SET 473, mqracc.h00, 0x7ffffffd, \
+                           0x80004001, 0x80004000, 0x80001ffe, \
+                           0x80006002, 0x80006001
+    TEST_PSIMD_ACC_RR_SET 474, mqracc.h01, 0x7ffffffd, \
+                           0x80004001, 0x80004000, 0x7fffbffc, \
+                           0x80000000, 0x7fffffff
+    TEST_PSIMD_ACC_RR_SET 475, mqracc.h11, 0x7ffffffd, \
+                           0x80004001, 0x80004000, 0x80007ffd, \
+                           0x8000c001, 0x8000c000
+
+    /* Cross add/sub and signed averaging verify both source permutations. */
+    TEST_PSIMD_RR_SET 486, pas.hx, 0x7fff8001, 0x0003fffe, \
+                       0x7ffd7ffe
+    TEST_PSIMD_RR_SET 487, psa.hx, 0x7fff8001, 0x0003fffe, \
+                       0x80018004
+    TEST_PSIMD_RR_SET 488, paas.hx, 0x7fff8001, 0x0003fffe, \
+                       0x3ffebfff
+    TEST_PSIMD_RR_SET 489, pasa.hx, 0x7fff8001, 0x0003fffe, \
+                       0x4000c002
+
+    /* Double-wide variants additionally check pair ordering and overlap. */
+    TEST_PSIMD_PAIR_RR_SET 490, pas.dhx, \
+        0x7fff8001, 0x00048002, 0x0003fffe, 0x7ffd0005, \
+        0x7ffd7ffe, 0x00090005, 0
+    TEST_PSIMD_PAIR_RR_SET 491, psa.dhx, \
+        0x7fff8001, 0x00048002, 0x0003fffe, 0x7ffd0005, \
+        0x80018004, 0xffffffff, 0
+    TEST_PSIMD_PAIR_RR_SET 492, paas.dhx, \
+        0x7fff8001, 0x00048002, 0x0003fffe, 0x7ffd0005, \
+        0x3ffebfff, 0x00048002, 0
+    TEST_PSIMD_PAIR_RR_SET 493, pasa.dhx, \
+        0x7fff8001, 0x00048002, 0x0003fffe, 0x7ffd0005, \
+        0x4000c002, 0xffffffff, 0
+
+    /* Saturating cross operations cover normal, positive/negative overflow. */
+    TEST_PSIMD_SAT_RR_SET 494, psas.hx, \
+        0xff380064, 0xffd8001e, 0xff56008c, \
+        0x7fff7fff, 0xffff0001, 0x7fff7fff, \
+        0x80008000, 0x0001ffff, 0x80008000
+    TEST_PSIMD_SAT_RR_SET 495, pssa.hx, \
+        0xff380064, 0xffd8001e, 0xff1a003c, \
+        0x7fff7fff, 0x0001ffff, 0x7fff7fff, \
+        0x80008000, 0xffff0001, 0x80008000
+    TEST_PSIMD_PAIR_SAT_RR_SET 496, psas.dhx, \
+        0xff380064, 0xfe70012c, 0xffd8001e, 0x003cffce, \
+        0xff56008c, 0xfe3e00f0, \
+        0x7fff7fff, 0x7fff7fff, 0xffff0001, 0xffff0001, \
+        0x7fff7fff, 0x7fff7fff, \
+        0x80008000, 0x80008000, 0x0001ffff, 0x0001ffff, \
+        0x80008000, 0x80008000
+    TEST_PSIMD_PAIR_SAT_RR_SET 497, pssa.dhx, \
+        0xff380064, 0xfe70012c, 0xffd8001e, 0x003cffce, \
+        0xff1a003c, 0xfea20168, \
+        0x7fff7fff, 0x7fff7fff, 0x0001ffff, 0x0001ffff, \
+        0x7fff7fff, 0x7fff7fff, \
+        0x80008000, 0x80008000, 0xffff0001, 0xffff0001, \
+        0x80008000, 0x80008000
+
+    /* Two-product horizontal add/sub: direct and crossed pairings differ. */
+    TEST_PSIMD_RR_SET 498, pm2add.h, 0x0004fffd, 0xfffe0005, \
+                       0xffffffe9
+    TEST_PSIMD_RR_SET 499, pm2addsu.h, 0x0004fffd, 0xfffe0005, \
+                       0x0003ffe9
+    TEST_PSIMD_RR_SET 500, pm2addu.h, 0x0004fffd, 0xfffe0005, \
+                       0x0008ffe9
+    TEST_PSIMD_RR_SET 501, pm2add.hx, 0x0004fffd, 0xfffe0005, 0x1a
+    TEST_PSIMD_RR_SET 502, pm2sub.h, 0x0004fffd, 0xfffe0005, \
+                       0xfffffff9
+    TEST_PSIMD_RR_SET 503, pm2sub.hx, 0x0004fffd, 0xfffe0005, \
+                       0xfffffff2
+    /* PM2SADD cannot negatively overflow; -2147418112 is the exact minimum. */
+    TEST_PSIMD_RR_VXSAT_STATE 510, pm2sadd.h, \
+                               0x0004fffd, 0xfffe0005, -23, 0, 0
+    TEST_PSIMD_RR_VXSAT_STATE 510, pm2sadd.h, \
+                               0x80008000, 0x80008000, 0x7fffffff, 0, 1
+    TEST_PSIMD_RR_VXSAT_STATE 510, pm2sadd.h, \
+                               0x80008000, 0x7fff7fff, 0x80010000, 0, 0
+    TEST_PSIMD_RR_VXSAT_STATE 510, pm2sadd.h, 0, 0, 0, 1, 1
+    TEST_PSIMD_RR_RD_RS1 510, pm2sadd.h, \
+                          0x0004fffd, 0xfffe0005, -23
+    TEST_PSIMD_RR_RD_RS2 510, pm2sadd.h, \
+                          0x0004fffd, 0xfffe0005, -23
+    TEST_PSIMD_RR_VXSAT_STATE 511, pm2sadd.hx, \
+                               0x0004fffd, 0xfffe0005, 26, 0, 0
+    TEST_PSIMD_RR_VXSAT_STATE 511, pm2sadd.hx, \
+                               0x80008000, 0x80008000, 0x7fffffff, 0, 1
+    TEST_PSIMD_RR_VXSAT_STATE 511, pm2sadd.hx, \
+                               0x80008000, 0x7fff7fff, 0x80010000, 0, 0
+    TEST_PSIMD_RR_VXSAT_STATE 511, pm2sadd.hx, 0, 0, 0, 1, 1
+    TEST_PSIMD_RR_RD_RS1 511, pm2sadd.hx, \
+                          0x0004fffd, 0xfffe0005, 26
+    TEST_PSIMD_RR_RD_RS2 511, pm2sadd.hx, \
+                          0x0004fffd, 0xfffe0005, 26
+    TEST_PSIMD_ACC_RR_SET 512, pm2adda.h, 0x7ffffffd, \
+        0x0004fffd, 0xfffe0005, 0x7fffffe6, 0x0004ffe6, 0xfffdffee
+    TEST_PSIMD_ACC_RR_SET 513, pm2addasu.h, 0x7ffffffd, \
+        0x0004fffd, 0xfffe0005, 0x8003ffe6, 0x0008ffe6, 0x0001ffee
+    TEST_PSIMD_ACC_RR_SET 514, pm2addau.h, 0x7ffffffd, \
+        0x0004fffd, 0xfffe0005, 0x8008ffe6, 0x000dffe6, 0x0006ffee
+    TEST_PSIMD_ACC_RR_SET 515, pm2adda.hx, 0x7ffffffd, \
+        0x0004fffd, 0xfffe0005, 0x80000017, 0x00050017, 0xfffe001f
+    TEST_PSIMD_ACC_RR_SET 516, pm2suba.h, 0x7ffffffd, \
+        0x0004fffd, 0xfffe0005, 0x7ffffff6, 0x0004fff6, 0xfffdfffe
+    TEST_PSIMD_ACC_RR_SET 517, pm2suba.hx, 0x7ffffffd, \
+        0x0004fffd, 0xfffe0005, 0x7fffffef, 0x0004ffef, 0xfffdfff7
+    TEST_PSIMD_RR_SET 524, pm4add.b, 0xfc03fe01, 0x08f90605, \
+                       0xffffffc4
+    TEST_PSIMD_RR_SET 525, pm4addsu.b, 0xfc03fe01, 0x08f90605, \
+                       0x000002c4
+    TEST_PSIMD_RR_SET 526, pm4addu.b, 0xfc03fe01, 0x08f90605, \
+                       0x000010c4
+    TEST_PSIMD_ACC_RR_SET 527, pm4adda.b, 0x7ffffffd, \
+        0xfc03fe01, 0x08f90605, 0x7fffffc1, 0xfc03fdc5, 0x08f905c9
+    TEST_PSIMD_ACC_RR_SET 528, pm4addasu.b, 0x7ffffffd, \
+        0xfc03fe01, 0x08f90605, 0x800002c1, 0xfc0400c5, 0x08f908c9
+    TEST_PSIMD_ACC_RR_SET 529, pm4addau.b, 0x7ffffffd, \
+        0xfc03fe01, 0x08f90605, 0x800010c1, 0xfc040ec5, 0x08f916c9
+    TEST_PSIMD_RR_SET 536, pmq2add.h, \
+                       0x80004001, 0x80004000, 0x0000a000
+    TEST_PSIMD_RR_SET 537, pmqr2add.h, \
+                       0x80004001, 0x80004000, 0x0000a001
+    TEST_PSIMD_ACC_RR_SET 538, pmq2adda.h, 0x7ffffffd, \
+        0x80004001, 0x80004000, 0x80009ffd, 0x8000e001, 0x8000e000
+    TEST_PSIMD_ACC_RR_SET 539, pmqr2adda.h, 0x7ffffffd, \
+        0x80004001, 0x80004000, 0x80009ffe, 0x8000e002, 0x8000e001
+
+    /* Widening MACs keep independent low/high accumulator words. */
+    TEST_PSIMD_WIDE_ACC_RR_SET 544, pwmacc.h, \
+        0x7ffffffd, 0xfffffffd, 0x7fff8000, 0x0002ffff, \
+        0x80007ffd, 0x0000fffb, 0x80000000, 0x0000fffb, \
+        0x00037fff, 0x0000fffb
+    TEST_PSIMD_WIDE_ACC_RR_SET 545, pwmaccsu.h, \
+        0x7ffffffd, 0xfffffffd, 0x7fff8000, 0x0002ffff, \
+        0x00007ffd, 0x0000fffb, 0, 0x0000fffb, \
+        0x80037fff, 0x0000fffb
+    TEST_PSIMD_WIDE_ACC_RR_SET 546, pwmaccu.h, \
+        0x7ffffffd, 0xfffffffd, 0x7fff8000, 0x0002ffff, \
+        0xffff7ffd, 0x0000fffb, 0xffff0000, 0x0000fffb, \
+        0x80027fff, 0x0000fffb
+    TEST_PSIMD_WIDE_ACC_RR_SET 547, wmacc, \
+        0xfffffffd, 0x7fffffff, 0x80000000, 3, \
+        0x7ffffffd, 0x7ffffffe, 0, 0x7ffffffe, \
+        0x80000003, 0x7ffffffd
+    TEST_PSIMD_WIDE_ACC_RR_SET 548, wmaccsu, \
+        0xfffffffd, 0x7fffffff, -2, 0xffffffff, \
+        0xffffffff, 0x7ffffffd, 0, 0x7ffffffe, \
+        1, 0x7ffffffe
+    TEST_PSIMD_WIDE_ACC_RR_SET 549, wmaccu, \
+        0xfffffffd, 0x7fffffff, 0xffffffff, 2, \
+        0xfffffffb, 0x80000001, 0xfffffffd, 0x80000001, \
+        0, 0x80000001
+
+    /* Two halfword products combine into one signed/unsigned 64-bit result. */
+    TEST_PSIMD_WIDE_RR_SET 550, pm2wadd.h, \
+        0x0004fffd, 0xfffe0005, 0xffffffe9, 0xffffffff
+    TEST_PSIMD_WIDE_RR_SET 551, pm2waddsu.h, \
+        0x0004fffd, 0xfffe0005, 0x0003ffe9, 0
+    TEST_PSIMD_WIDE_RR_SET 552, pm2waddu.h, \
+        0x0004fffd, 0xfffe0005, 0x0008ffe9, 0
+    TEST_PSIMD_WIDE_RR_SET 553, pm2wadd.hx, \
+        0x0004fffd, 0xfffe0005, 26, 0
+    TEST_PSIMD_WIDE_RR_SET 554, pm2wsub.h, \
+        0x0004fffd, 0xfffe0005, -7, -1
+    TEST_PSIMD_WIDE_RR_SET 555, pm2wsub.hx, \
+        0x0004fffd, 0xfffe0005, -14, -1
+    TEST_PSIMD_WIDE_ACC_RR_SET 556, pm2wadda.h, \
+        0xfffffffd, 0x7fffffff, 0x0004fffd, 0xfffe0005, \
+        0xffffffe6, 0x7fffffff, 0x0004ffe6, 0x7fffffff, \
+        0xfffdffee, 0x7fffffff
+    TEST_PSIMD_WIDE_ACC_RR_SET 557, pm2waddasu.h, \
+        0xfffffffd, 0x7fffffff, 0x0004fffd, 0xfffe0005, \
+        0x0003ffe6, 0x80000000, 0x0008ffe6, 0x7fffffff, \
+        0x0001ffee, 0x80000000
+    TEST_PSIMD_WIDE_ACC_RR_SET 558, pm2waddau.h, \
+        0xfffffffd, 0x7fffffff, 0x0004fffd, 0xfffe0005, \
+        0x0008ffe6, 0x80000000, 0x000dffe6, 0x7fffffff, \
+        0x0006ffee, 0x80000000
+    TEST_PSIMD_WIDE_ACC_RR_SET 559, pm2wadda.hx, \
+        0xfffffffd, 0x7fffffff, 0x0004fffd, 0xfffe0005, \
+        0x00000017, 0x80000000, 0x00050017, 0x7fffffff, \
+        0xfffe001f, 0x7fffffff
+    TEST_PSIMD_WIDE_ACC_RR_SET 560, pm2wsuba.h, \
+        0xfffffffd, 0x7fffffff, 0x0004fffd, 0xfffe0005, \
+        0xfffffff6, 0x7fffffff, 0x0004fff6, 0x7fffffff, \
+        0xfffdfffe, 0x7fffffff
+    TEST_PSIMD_WIDE_ACC_RR_SET 561, pm2wsuba.hx, \
+        0xfffffffd, 0x7fffffff, 0x0004fffd, 0xfffe0005, \
+        0xffffffef, 0x7fffffff, 0x0004ffef, 0x7fffffff, \
+        0xfffdfff7, 0x7fffffff
+    TEST_PSIMD_RR_SET 562, padd.bs, 0xff807f01, 0xdeadbe80, 0x7f00ff81
+    TEST_PSIMD_RR_SET 563, padd.hs, 0x7fff8001, 0xdead8000, 0xffff0001
+    /* Widen before shifting: unsigned and signed forms differ at shift zero. */
+    TEST_PSIMD_WIDE_RI_SET 567, pwslli.b, 0x7f80ff01, \
+        0x00ff0001, 0x007f0080, 0x01fe0002, 0x00fe0100, \
+        15, 0x80008000, 0x80000000
+    TEST_PSIMD_WIDE_RI_SET 568, pwslli.h, 0x7fff8001, \
+        0x00008001, 0x00007fff, 0x00010002, 0x0000fffe, \
+        31, 0x80000000, 0x80000000
+    TEST_PSIMD_WIDE_RI_SET 569, wslli, 0x80000001, \
+        0x80000001, 0, 2, 1, 63, 0, 0x80000000
+    TEST_PSIMD_WIDE_RI_SET 570, pwslai.b, 0x7f80ff01, \
+        0xffff0001, 0x007fff80, 0xfffe0002, 0x00feff00, \
+        15, 0x80008000, 0x80000000
+    TEST_PSIMD_WIDE_RI_SET 571, pwslai.h, 0x7fff8001, \
+        0xffff8001, 0x00007fff, 0xffff0002, 0x0000fffe, \
+        31, 0x80000000, 0x80000000
+    TEST_PSIMD_WIDE_RI_SET 572, wslai, 0x80000001, \
+        0x80000001, 0xffffffff, 2, 0xffffffff, \
+        63, 0, 0x80000000
+    TEST_PSIMD_WIDE_RR_SET 573, pwsll.bs, \
+        0x7f80ff01, 1, 0x01fe0002, 0x00fe0100
+    TEST_PSIMD_WIDE_RR 573, pwsll.bs, \
+        0x7f80ff01, 15, 0x80008000, 0x80000000
+    TEST_PSIMD_WIDE_RR_SET 574, pwsll.hs, \
+        0x7fff8001, 1, 0x00010002, 0x0000fffe
+    TEST_PSIMD_WIDE_RR 574, pwsll.hs, \
+        0x7fff8001, 31, 0x80000000, 0x80000000
+    TEST_PSIMD_WIDE_RR_SET 575, wsll, 0x80000001, 1, 2, 1
+    TEST_PSIMD_WIDE_RR 575, wsll, 0x80000001, 63, 0, 0x80000000
+    TEST_PSIMD_WIDE_RR_SET 576, pwsla.bs, \
+        0x7f80ff01, 1, 0xfffe0002, 0x00feff00
+    TEST_PSIMD_WIDE_RR 576, pwsla.bs, \
+        0x7f80ff01, 15, 0x80008000, 0x80000000
+    TEST_PSIMD_WIDE_RR_SET 577, pwsla.hs, \
+        0x7fff8001, 1, 0xffff0002, 0x0000fffe
+    TEST_PSIMD_WIDE_RR 577, pwsla.hs, \
+        0x7fff8001, 31, 0x80000000, 0x80000000
+    TEST_PSIMD_WIDE_RR_SET 578, wsla, 0x80000001, 1, 2, 0xffffffff
+    TEST_PSIMD_WIDE_RR 578, wsla, 0x80000001, 63, 0, 0x80000000
+    TEST_PSIMD_WIDE_RR_SET 579, wzip8p, \
+        0x44332211, 0x88776655, 0x66225511, 0x88447733
+    TEST_PSIMD_WIDE_RR_SET 580, wzip16p, \
+        0x44332211, 0x88776655, 0x66552211, 0x88774433
+    /* Extended shifts use the old rd and must snapshot aliased sources. */
+    TEST_PSIMD_ACC_RR_SET 593, slx, 0x11223344, \
+        0x99aabb5a, 8, 0x22334499, 0xaabb5a99, 0x899
+    TEST_PSIMD_ACC_RR_SET 594, srx, 0x11223344, \
+        0x99aabb5a, 8, 0x5a112233, 0x5a99aabb, 0x5a000000
+    TEST_PSIMD_PAIR_SCALAR_RR_SET 564, padd.dbs, \
+        0xff807f01, 0x04030201, 0xdeadbe80, 0x7f00ff81, 0x84838281
+    TEST_PSIMD_PAIR_SCALAR_RR_SET 565, padd.dhs, \
+        0x7fff8001, 0x00048002, 0xdead8000, 0xffff0001, 0x80040002
+    TEST_PSIMD_PAIR_SCALAR_RR_SET 566, padd.dws, \
+        0x80000001, 0x7fffffff, 0x80000000, 1, 0xffffffff
+
+    /* Pair selector zero supplies an all-zero source, including X1. */
+    addi    sp, sp, -16
+    sw      ra, 12(sp)
+    li      ra, 0x12345678
+    li      a4, 0x80
+    padd.dbs a0, zero, a4
+    mv      t4, a0
+    mv      t5, a1
+    lw      ra, 12(sp)
+    addi    sp, sp, 16
+    li      t0, 0x80808080
+    PSIMD_FAIL_IF_NE t4, t0, 564
+    PSIMD_FAIL_IF_NE t5, t0, 564
+
+    /* Pair destination selector zero must suppress the write to X1 too. */
+    addi    sp, sp, -16
+    sw      ra, 12(sp)
+    li      ra, 0x12345678
+    li      a2, 0x01020304
+    li      a3, 0x05060708
+    li      a4, 1
+    padd.dbs zero, a2, a4
+    mv      t4, ra
+    lw      ra, 12(sp)
+    addi    sp, sp, 16
+    li      t0, 0x12345678
+    PSIMD_FAIL_IF_NE t4, t0, 564
+
+    /* Every zero pair selector denotes { X[0], X[0] }, never { X[1], X[0] }. */
+    addi    sp, sp, -16
+    sw      ra, 12(sp)
+    li      ra, 0x12345678
+
+    /* Check both source positions in a three-pair instruction. */
+    li      a4, 0x01020304
+    li      a5, 0x10203040
+    padd.db a0, zero, a4
+    PSIMD_FAIL_IF_NE a0, a4, 610
+    PSIMD_FAIL_IF_NE a1, a5, 610
+    li      a2, 0x11223344
+    li      a3, 0x55667788
+    padd.db a0, a2, zero
+    PSIMD_FAIL_IF_NE a0, a2, 610
+    PSIMD_FAIL_IF_NE a1, a3, 610
+
+    /* Cover concatenated, unary, immediate-shift, and arithmetic paths. */
+    addd    a0, zero, a4
+    PSIMD_FAIL_IF_NE a0, a4, 610
+    PSIMD_FAIL_IF_NE a1, a5, 610
+    psext.dw.b a0, zero
+    PSIMD_FAIL_IF_NE a0, zero, 610
+    PSIMD_FAIL_IF_NE a1, zero, 610
+    pslli.dw a0, zero, 1
+    PSIMD_FAIL_IF_NE a0, zero, 610
+    PSIMD_FAIL_IF_NE a1, zero, 610
+    pmin.dw a0, zero, a4
+    PSIMD_FAIL_IF_NE a0, zero, 610
+    PSIMD_FAIL_IF_NE a1, zero, 610
+
+    /* A zero destination suppresses both writes but not CSR side effects. */
+    pli.db  zero, 1
+    li      t0, 0x12345678
+    PSIMD_FAIL_IF_NE ra, t0, 610
+    li      a2, 0x7f7f7f7f
+    li      a3, 0x7f7f7f7f
+    li      a4, 0x01010101
+    li      a5, 0x01010101
+    csrw    vxsat, zero
+    psadd.db zero, a2, a4
+    PSIMD_FAIL_IF_NE ra, t0, 610
+    csrr    t4, vxsat
+    li      t5, 1
+    PSIMD_FAIL_IF_NE t4, t5, 610
+
+    lw      ra, 12(sp)
+    addi    sp, sp, 16
+
+    /* Q15 lanes and Q31 scalar terms accumulate into an RV32 register pair. */
+    TEST_PSIMD_WIDE_ACC_RR_SET 482, pmqwacc.h, \
+        0x7ffffffd, 0xfffffffd, 0x80004001, 0x80004000, \
+        0x80001ffd, 0x00007ffd, 0x80006001, 0x00007ffd, \
+        0x80006000, 0x00007ffd
+    TEST_PSIMD_WIDE_ACC_RR_SET 483, pmqrwacc.h, \
+        0x7ffffffd, 0xfffffffd, 0x80004001, 0x80004000, \
+        0x80001ffe, 0x00007ffd, 0x80006002, 0x00007ffd, \
+        0x80006001, 0x00007ffd
+    TEST_PSIMD_WIDE_ACC_RR_SET 484, mqwacc, \
+        0xfffffffd, 0x7fffffff, 0x40000001, 0x40000000, \
+        0x1ffffffd, 0x80000000, 0x60000001, 0x7fffffff, \
+        0x60000000, 0x7fffffff
+    TEST_PSIMD_WIDE_ACC_RR 484, mqwacc, 0, 0, \
+                            0x80000000, 0x80000000, 0x80000000, 0
+    TEST_PSIMD_WIDE_ACC_RR_SET 485, mqrwacc, \
+        0xfffffffd, 0x7fffffff, 0x40000001, 0x40000000, \
+        0x1ffffffe, 0x80000000, 0x60000002, 0x7fffffff, \
+        0x60000001, 0x7fffffff
+    TEST_PSIMD_WIDE_ACC_RR 485, mqrwacc, 0, 0, \
+                            0x80000000, 0x80000000, 0x80000000, 0
+
+    /* LLVM RV32 encodes REV as 0x69f...; catches decoder-version skew. */
+    TEST_PSIMD_R_SET 598, rev, 0x01234567, 0xe6a2c480
+
+    /* P v0.21 variable-shift mnemonics. */
+    TEST_PSIMD_SAT_RR_SET 602, sshl, \
+        0x40000000, 1, 0x80000000, \
+        0x80000000, 1, -1, -1, 1, -1
+    TEST_PSIMD_RR_VXSAT_STATE 602, sshl, \
+        0x80000001, -1, 0x40000000, 0, 0
+    TEST_PSIMD_SAT_RR_SET 603, sshlr, \
+        0x40000000, 1, 0x80000000, \
+        0x80000000, 1, -1, -1, 1, -1
+    TEST_PSIMD_RR_VXSAT_STATE 603, sshlr, \
+        0x80000003, -1, 0x40000002, 0, 0
+    TEST_PSIMD_RR_VXSAT_STATE 603, sshlr, \
+        0x80000000, -33, 1, 0, 0
+
+    TEST_PSIMD_PAIR_VAR_SAT_SET 604, psshl.dhs, \
+        0x7ffe4000, 0x00020001, 0xfffc8000, 0x00040002, \
+        0x80004001, 0, 0xffff8002, 0, \
+        0xffff0001, 0, 0xffff0002, 0
+    TEST_PSIMD_PAIR_SHIFT_RR_VXSAT_STATE 604, psshl.dhs, \
+        0x80017fff, 0xffff0002, -1, 0x40003fff, 0x7fff0001, 0, 0
+    TEST_PSIMD_PAIR_VAR_SAT_SET 605, psshl.dws, \
+        0x40000000, 1, 0x80000000, 2, \
+        0x80000000, 0, -1, 0, -1, 0, -1, 0
+    TEST_PSIMD_PAIR_SHIFT_RR_VXSAT_STATE 605, psshl.dws, \
+        0x80000001, 3, -1, 0x40000000, 1, 0, 0
+    TEST_PSIMD_PAIR_VAR_SAT_SET 606, psshlr.dhs, \
+        0x7ffe4000, 0x00020001, 0xfffc8000, 0x00040002, \
+        0x80004001, 0, 0xffff8002, 0, \
+        0xffff0001, 0, 0xffff0002, 0
+    TEST_PSIMD_PAIR_SHIFT_RR_VXSAT_STATE 606, psshlr.dhs, \
+        0x80030002, 0xffff0001, -1, 0x40020001, 0x80000001, 0, 0
+    TEST_PSIMD_PAIR_VAR_SAT_SET 607, psshlr.dws, \
+        0x40000000, 1, 0x80000000, 2, \
+        0x80000000, 0, -1, 0, -1, 0, -1, 0
+    TEST_PSIMD_PAIR_SHIFT_RR_VXSAT_STATE 607, psshlr.dws, \
+        0x80000003, 2, -1, 0x40000002, 1, 0, 0
+    PSIMD_TEST_EXIT 0
+    .size _start, .-_start
+
+    PSIMD_DEFINE_FAILURE_HANDLER
+
+    .section .note.GNU-stack,"",@progbits
diff --git a/tests/tcg/riscv/psimd-rv64.S b/tests/tcg/riscv/psimd-rv64.S
new file mode 100644
index 00000000000..ea1db55cd02
--- /dev/null
+++ b/tests/tcg/riscv/psimd-rv64.S
@@ -0,0 +1,578 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Basic RV64 P extension execution tests. */
+
+#include "psimd-test-macros.inc"
+
+    .text
+    .balign 4
+    .globl _start
+    .type _start, @function
+_start:
+#include "psimd-common.S"
+
+    /*
+     * Scalar word-selection products.  Both input high words are nonzero;
+     * W00/W01/W11 therefore expose a wrong half selection immediately.
+     */
+    TEST_PSIMD_RR_SET 410, mul.w00, \
+                       0xfffffffdfffffffe, 0x00000004ffffffff, 2
+    TEST_PSIMD_RR_SET 411, mul.w01, \
+                       0xfffffffdfffffffe, 0x00000004ffffffff, -8
+    TEST_PSIMD_RR_SET 412, mul.w11, \
+                       0xfffffffdfffffffe, 0x00000004ffffffff, -12
+    TEST_PSIMD_RR_SET 413, mulsu.w00, \
+                       0xfffffffdfffffffe, 0x00000004ffffffff, \
+                       0xfffffffe00000002
+    TEST_PSIMD_RR_SET 414, mulsu.w11, \
+                       0xfffffffdfffffffe, 0x00000004ffffffff, -12
+    TEST_PSIMD_RR_SET 415, mulu.w00, \
+                       0xfffffffdfffffffe, 0x00000004ffffffff, \
+                       0xfffffffd00000002
+    TEST_PSIMD_RR_SET 416, mulu.w01, \
+                       0xfffffffdfffffffe, 0x00000004ffffffff, \
+                       0x00000003fffffff8
+    TEST_PSIMD_RR_SET 417, mulu.w11, \
+                       0xfffffffdfffffffe, 0x00000004ffffffff, \
+                       0x00000003fffffff4
+
+    /* Scalar word MAC selection, modulo-64 accumulation and rd aliases. */
+    TEST_PSIMD_ACC_RR_SET 434, macc.w00, 0x7ffffffffffffffd, \
+                           0x80000002fffffffd, 0x00000004ffffffff, \
+                           0x8000000000000000, 0x8000000300000000, \
+                           0x0000000500000002
+    TEST_PSIMD_ACC_RR_SET 435, macc.w01, 0x7ffffffffffffffd, \
+                           0x80000002fffffffd, 0x00000004ffffffff, \
+                           0x7ffffffffffffff1, 0x80000002fffffff1, \
+                           0x00000004fffffff3
+    TEST_PSIMD_ACC_RR_SET 436, macc.w11, 0x7ffffffffffffffd, \
+                           0x80000002fffffffd, 0x00000004ffffffff, \
+                           0x7ffffffe00000005, 0x8000000100000005, \
+                           0x0000000300000007
+    TEST_PSIMD_ACC_RR_SET 437, maccsu.w00, 0x7ffffffffffffffd, \
+                           0x80000002fffffffd, 0x00000004ffffffff, \
+                           0x7ffffffd00000000, 0x8000000000000000, \
+                           0x0000000200000002
+    TEST_PSIMD_ACC_RR_SET 438, maccsu.w11, 0x7ffffffffffffffd, \
+                           0x80000002fffffffd, 0x00000004ffffffff, \
+                           0x7ffffffe00000005, 0x8000000100000005, \
+                           0x0000000300000007
+    TEST_PSIMD_ACC_RR_SET 439, maccu.w00, 0x7ffffffffffffffd, \
+                           0x80000002fffffffd, 0x00000004ffffffff, \
+                           0x7ffffffc00000000, 0x7fffffff00000000, \
+                           0x0000000100000002
+    TEST_PSIMD_ACC_RR_SET 440, maccu.w01, 0x7ffffffffffffffd, \
+                           0x80000002fffffffd, 0x00000004ffffffff, \
+                           0x80000003fffffff1, 0x80000006fffffff1, \
+                           0x00000008fffffff3
+    TEST_PSIMD_ACC_RR_SET 441, maccu.w11, 0x7ffffffffffffffd, \
+                           0x80000002fffffffd, 0x00000004ffffffff, \
+                           0x8000000200000005, 0x8000000500000005, \
+                           0x0000000700000007
+
+    /* Packed halfword products accumulate independently into two words. */
+    TEST_PSIMD_ACC_RR_SET 442, pmacc.w.h00, 0x800000057ffffffd, \
+                           0x8002fffd7fff0002, 0x0004ffff00030005, \
+                           0x8000000880000007, 0x800300007fff000c, \
+                           0x000500020003000f
+    TEST_PSIMD_ACC_RR_SET 443, pmacc.w.h01, 0x800000057ffffffd, \
+                           0x8002fffd7fff0002, 0x0004ffff00030005, \
+                           0x7ffffff980000003, 0x8002fff17fff0008, \
+                           0x0004fff30003000b
+    TEST_PSIMD_ACC_RR_SET 444, pmacc.w.h11, 0x800000057ffffffd, \
+                           0x8002fffd7fff0002, 0x0004ffff00030005, \
+                           0x7ffe000d80017ffa, 0x8001000580007fff, \
+                           0x0003000700048002
+    TEST_PSIMD_ACC_RR_SET 445, pmaccsu.w.h00, 0x800000057ffffffd, \
+                           0x8002fffd7fff0002, 0x0004ffff00030005, \
+                           0x7ffd000880000007, 0x800000007fff000c, \
+                           0x000200020003000f
+    TEST_PSIMD_ACC_RR_SET 446, pmaccsu.w.h11, 0x800000057ffffffd, \
+                           0x8002fffd7fff0002, 0x0004ffff00030005, \
+                           0x7ffe000d80017ffa, 0x8001000580007fff, \
+                           0x0003000700048002
+    TEST_PSIMD_ACC_RR_SET 447, pmaccu.w.h00, 0x800000057ffffffd, \
+                           0x8002fffd7fff0002, 0x0004ffff00030005, \
+                           0x7ffc000880000007, 0x7fff00007fff000c, \
+                           0x000100020003000f
+    TEST_PSIMD_ACC_RR_SET 448, pmaccu.w.h01, 0x800000057ffffffd, \
+                           0x8002fffd7fff0002, 0x0004ffff00030005, \
+                           0x8003fff980000003, 0x8006fff17fff0008, \
+                           0x0008fff30003000b
+    TEST_PSIMD_ACC_RR_SET 449, pmaccu.w.h11, 0x800000057ffffffd, \
+                           0x8002fffd7fff0002, 0x0004ffff00030005, \
+                           0x8002000d80017ffa, 0x8005000580007fff, \
+                           0x0007000700048002
+
+    /* Four distinct halfword lanes cover high-half and rounded extraction. */
+    TEST_PSIMD_ACC_RR_SET 5, pmhacc.h, 0xfffc0003fffe0001, \
+                           0x7fff00028001ffff, 0x0004fffd7fff8000, \
+                           0xfffd0002bffe0001, 0x800000014001ffff, \
+                           0x0005fffc3fff8000
+    TEST_PSIMD_ACC_RR_SET 451, pmhaccsu.h, 0xfffc0003fffe0001, \
+                           0x7fff00028001ffff, 0x0004fffd7fff8000, \
+                           0xfffd0004bffe0000, 0x800000034001fffe, \
+                           0x0005fffe3fff7fff
+    TEST_PSIMD_ACC_RR_SET 452, pmhaccu.h, 0xfffc0003fffe0001, \
+                           0x7fff00028001ffff, 0x0004fffd7fff8000, \
+                           0xfffd00043ffd8000, 0x80000003c0007ffe, \
+                           0x0005fffebffeffff
+    TEST_PSIMD_ACC_RR_SET 453, pmhracc.h, 0xfffc0003fffe0001, \
+                           0x7fff00028001ffff, 0x0004fffd7fff8000, \
+                           0xfffe0003bfff0002, 0x8001000240020000, \
+                           0x0006fffd40008001
+    TEST_PSIMD_ACC_RR_SET 454, pmhraccsu.h, 0xfffc0003fffe0001, \
+                           0x7fff00028001ffff, 0x0004fffd7fff8000, \
+                           0xfffe0005bfff0001, 0x800100044002ffff, \
+                           0x0006ffff40008000
+    TEST_PSIMD_ACC_RR_SET 455, pmhraccu.h, 0xfffc0003fffe0001, \
+                           0x7fff00028001ffff, 0x0004fffd7fff8000, \
+                           0xfffe00053ffe8001, 0x80010004c0017fff, \
+                           0x0006ffffbfff0000
+
+    /* Packed word high-half MAC, with guard-bit rounding in both lanes. */
+    TEST_PSIMD_ACC_RR_SET 456, pmhacc.w, 0xfffffffd7fffffff, \
+                           0x8000000180000000, 0x80000000ffffffff, \
+                           0x3ffffffc7fffffff, 0xc000000080000000, \
+                           0xbfffffffffffffff
+    TEST_PSIMD_ACC_RR_SET 457, pmhaccsu.w, 0xfffffffd7fffffff, \
+                           0x8000000180000000, 0x80000000ffffffff, \
+                           0xbffffffdffffffff, 0x4000000100000000, \
+                           0x400000007fffffff
+    TEST_PSIMD_ACC_RR_SET 458, pmhaccu.w, 0xfffffffd7fffffff, \
+                           0x8000000180000000, 0x80000000ffffffff, \
+                           0x3ffffffdfffffffe, 0xc0000001ffffffff, \
+                           0xc00000007ffffffe
+    TEST_PSIMD_ACC_RR_SET 459, pmhracc.w, 0xfffffffd7fffffff, \
+                           0x8000000180000000, 0x80000000ffffffff, \
+                           0x3ffffffd80000000, 0xc000000180000001, \
+                           0xc000000000000000
+    TEST_PSIMD_ACC_RR_SET 460, pmhraccsu.w, 0xfffffffd7fffffff, \
+                           0x8000000180000000, 0x80000000ffffffff, \
+                           0xbffffffe00000000, 0x4000000200000001, \
+                           0x4000000180000000
+    TEST_PSIMD_ACC_RR_SET 461, pmhraccu.w, 0xfffffffd7fffffff, \
+                           0x8000000180000000, 0x80000000ffffffff, \
+                           0x3ffffffeffffffff, 0xc000000200000000, \
+                           0xc00000017fffffff
+
+    /* Four halfword-by-selected-byte lanes exercise B0/B1 independently. */
+    TEST_PSIMD_ACC_RR_SET 462, pmhacc.h.b0, 0xfffc0003fffe0001, \
+                           0x0003fffe7fff8001, 0x04fe800102ff7f80, \
+                           0xfffb0002ff7e4000, 0x0002fffd7f7fc000, \
+                           0x04fd8000027fbf7f
+    TEST_PSIMD_ACC_RR_SET 463, pmhacc.h.b1, 0xfffc0003fffe0001, \
+                           0x0003fffe7fff8001, 0x04fe800102ff7f80, \
+                           0xfffc000400fdc081, 0x0003ffff80fe4081, \
+                           0x04fe800203fe4000
+    TEST_PSIMD_ACC_RR_SET 464, pmhaccsu.h.b0, 0xfffc0003fffe0001, \
+                           0x0003fffe7fff8001, 0x04fe800102ff7f80, \
+                           0xfffe00027f7dc001, 0x0005fffdff7e4001, \
+                           0x05008000827e3f80
+    TEST_PSIMD_ACC_RR_SET 465, pmhaccsu.h.b1, 0xfffc0003fffe0001, \
+                           0x0003fffe7fff8001, 0x04fe800102ff7f80, \
+                           0xfffc000200fdc081, 0x0003fffd80fe4081, \
+                           0x04fe800003fe4000
+
+    /* Two full words multiply selected H0/H1 values and keep bits [47:16]. */
+    TEST_PSIMD_ACC_RR_SET 466, pmhacc.w.h0, 0xfffffffd7ffffffd, \
+                           0x7fffffff80000001, 0x0004fffd0003ffff, \
+                           0xfffe7ffd80007ffc, 0x7ffe7fff80008000, \
+                           0x00037ffd00047ffe
+    TEST_PSIMD_ACC_RR_SET 467, pmhacc.w.h1, 0xfffffffd7ffffffd, \
+                           0x7fffffff80000001, 0x0004fffd0003ffff, \
+                           0x0001fffc7ffe7ffd, 0x8001fffe7ffe8001, \
+                           0x0006fffc00027fff
+    TEST_PSIMD_ACC_RR_SET 468, pmhaccsu.w.h0, 0xfffffffd7ffffffd, \
+                           0x7fffffff80000001, 0x0004fffd0003ffff, \
+                           0x7ffe7ffc00007ffd, 0xfffe7ffe00008001, \
+                           0x80037ffc80047fff
+    TEST_PSIMD_ACC_RR_SET 469, pmhaccsu.w.h1, 0xfffffffd7ffffffd, \
+                           0x7fffffff80000001, 0x0004fffd0003ffff, \
+                           0x0001fffc7ffe7ffd, 0x8001fffe7ffe8001, \
+                           0x0006fffc00027fff
+
+    /* Q31 selected-word accumulation; W00 distinguishes rounded extraction. */
+    TEST_PSIMD_ACC_RR_SET 470, mqacc.w00, 0x7ffffffffffffffd, \
+                           0x8000000040000001, 0x8000000040000000, \
+                           0x800000001ffffffd, 0x8000000060000001, \
+                           0x8000000060000000
+    TEST_PSIMD_ACC_RR_SET 471, mqacc.w01, 0x7ffffffffffffffd, \
+                           0x8000000040000001, 0x8000000040000000, \
+                           0x7fffffffbffffffc, 0x8000000000000000, \
+                           0x7fffffffffffffff
+    TEST_PSIMD_ACC_RR_SET 472, mqacc.w11, 0x7ffffffffffffffd, \
+                           0x8000000040000001, 0x8000000040000000, \
+                           0x800000007ffffffd, 0x80000000c0000001, \
+                           0x80000000c0000000
+    TEST_PSIMD_ACC_RR_SET 473, mqracc.w00, 0x7ffffffffffffffd, \
+                           0x8000000040000001, 0x8000000040000000, \
+                           0x800000001ffffffe, 0x8000000060000002, \
+                           0x8000000060000001
+    TEST_PSIMD_ACC_RR_SET 474, mqracc.w01, 0x7ffffffffffffffd, \
+                           0x8000000040000001, 0x8000000040000000, \
+                           0x7fffffffbffffffc, 0x8000000000000000, \
+                           0x7fffffffffffffff
+    TEST_PSIMD_ACC_RR_SET 475, mqracc.w11, 0x7ffffffffffffffd, \
+                           0x8000000040000001, 0x8000000040000000, \
+                           0x800000007ffffffd, 0x80000000c0000001, \
+                           0x80000000c0000000
+
+    /* Packed Q15 products accumulate into independent 32-bit lanes. */
+    TEST_PSIMD_ACC_RR_SET 476, pmqacc.w.h00, 0xfffffffd7ffffffd, \
+                           0x4001800080004001, 0x4000800080004000, \
+                           0x00007ffd80001ffd, 0x4002000080006001, \
+                           0x4001000080006000
+    TEST_PSIMD_ACC_RR_SET 477, pmqacc.w.h01, 0xfffffffd7ffffffd, \
+                           0x4001800080004001, 0x4000800080004000, \
+                           0xffffbffd7fffbffc, 0x4001400080000000, \
+                           0x400040007fffffff
+    TEST_PSIMD_ACC_RR_SET 478, pmqacc.w.h11, 0xfffffffd7ffffffd, \
+                           0x4001800080004001, 0x4000800080004000, \
+                           0x00001ffd80007ffd, 0x4001a0008000c001, \
+                           0x4000a0008000c000
+    TEST_PSIMD_ACC_RR_SET 479, pmqracc.w.h00, 0xfffffffd7ffffffd, \
+                           0x4001800080004001, 0x4000800080004000, \
+                           0x00007ffd80001ffe, 0x4002000080006002, \
+                           0x4001000080006001
+    TEST_PSIMD_ACC_RR_SET 480, pmqracc.w.h01, 0xfffffffd7ffffffd, \
+                           0x4001800080004001, 0x4000800080004000, \
+                           0xffffbffd7fffbffc, 0x4001400080000000, \
+                           0x400040007fffffff
+    TEST_PSIMD_ACC_RR_SET 481, pmqracc.w.h11, 0xfffffffd7ffffffd, \
+                           0x4001800080004001, 0x4000800080004000, \
+                           0x00001ffe80007ffd, 0x4001a0018000c001, \
+                           0x4000a0018000c000
+
+    /* Halfword and word cross operations use nonzero upper RV64 lanes. */
+    TEST_PSIMD_RR_SET 486, pas.hx, \
+                       0x000480027fff8001, 0x7ffd00050003fffe, \
+                       0x000900057ffd7ffe
+    TEST_PSIMD_RR_SET 487, psa.hx, \
+                       0x000480027fff8001, 0x7ffd00050003fffe, \
+                       0xffffffff80018004
+    TEST_PSIMD_RR_SET 488, paas.hx, \
+                       0x000480027fff8001, 0x7ffd00050003fffe, \
+                       0x000480023ffebfff
+    TEST_PSIMD_RR_SET 489, pasa.hx, \
+                       0x000480027fff8001, 0x7ffd00050003fffe, \
+                       0xffffffff4000c002
+    TEST_PSIMD_RR_SET 490, pas.wx, \
+                       0x7fffffff80000001, 0x00000003fffffffe, \
+                       0x7ffffffd7ffffffe
+    TEST_PSIMD_RR_SET 491, psa.wx, \
+                       0x7fffffff80000001, 0x00000003fffffffe, \
+                       0x8000000180000004
+    TEST_PSIMD_RR_SET 492, paas.wx, \
+                       0x7fffffff80000001, 0x00000003fffffffe, \
+                       0x3ffffffebfffffff
+    TEST_PSIMD_RR_SET 493, pasa.wx, \
+                       0x7fffffff80000001, 0x00000003fffffffe, \
+                       0x40000000c0000002
+
+    TEST_PSIMD_SAT_RR_SET 494, psas.hx, \
+        0xfe70012cff380064, 0x003cffceffd8001e, \
+        0xfe3e00f0ff56008c, \
+        0x7fff7fff7fff7fff, 0xffff0001ffff0001, \
+        0x7fff7fff7fff7fff, \
+        0x8000800080008000, 0x0001ffff0001ffff, \
+        0x8000800080008000
+    TEST_PSIMD_SAT_RR_SET 495, pssa.hx, \
+        0xfe70012cff380064, 0x003cffceffd8001e, \
+        0xfea20168ff1a003c, \
+        0x7fff7fff7fff7fff, 0x0001ffff0001ffff, \
+        0x7fff7fff7fff7fff, \
+        0x8000800080008000, 0xffff0001ffff0001, \
+        0x8000800080008000
+    TEST_PSIMD_SAT_RR_SET 496, psas.wx, \
+        0xfffff830000003e8, 0xfffffe700000012c, \
+        0xfffff95c00000578, \
+        0x7fffffff7fffffff, 0xffffffff00000001, \
+        0x7fffffff7fffffff, \
+        0x8000000080000000, 0x00000001ffffffff, \
+        0x8000000080000000
+    TEST_PSIMD_SAT_RR_SET 497, pssa.wx, \
+        0xfffff830000003e8, 0xfffffe700000012c, \
+        0xfffff70400000258, \
+        0x7fffffff7fffffff, 0x00000001ffffffff, \
+        0x7fffffff7fffffff, \
+        0x8000000080000000, 0xffffffff00000001, \
+        0x8000000080000000
+
+    /* Two independent halfword groups and full-width word pairings. */
+    TEST_PSIMD_RR_SET 498, pm2add.h, \
+                       0xfffb00020004fffd, 0x0003fff9fffe0005, \
+                       0xffffffe3ffffffe9
+    TEST_PSIMD_RR_SET 499, pm2addsu.h, \
+                       0xfffb00020004fffd, 0x0003fff9fffe0005, \
+                       0x0001ffe30003ffe9
+    TEST_PSIMD_RR_SET 500, pm2addu.h, \
+                       0xfffb00020004fffd, 0x0003fff9fffe0005, \
+                       0x0004ffe30008ffe9
+    TEST_PSIMD_RR_SET 501, pm2add.hx, \
+                       0xfffb00020004fffd, 0x0003fff9fffe0005, \
+                       0x000000290000001a
+    TEST_PSIMD_RR_SET 502, pm2sub.h, \
+                       0xfffb00020004fffd, 0x0003fff9fffe0005, \
+                       0x00000001fffffff9
+    TEST_PSIMD_RR_SET 503, pm2sub.hx, \
+                       0xfffb00020004fffd, 0x0003fff9fffe0005, \
+                       0xffffffe3fffffff2
+    TEST_PSIMD_RR_SET 504, pm2add.w, \
+                       0x00000004fffffffd, 0xfffffffe00000005, \
+                       0xffffffffffffffe9
+    TEST_PSIMD_RR_SET 505, pm2addsu.w, \
+                       0x00000004fffffffd, 0xfffffffe00000005, \
+                       0x00000003ffffffe9
+    TEST_PSIMD_RR_SET 506, pm2addu.w, \
+                       0x00000004fffffffd, 0xfffffffe00000005, \
+                       0x00000008ffffffe9
+    TEST_PSIMD_RR_SET 507, pm2add.wx, \
+                       0x00000004fffffffd, 0xfffffffe00000005, 0x1a
+    TEST_PSIMD_RR_SET 508, pm2sub.w, \
+                       0x00000004fffffffd, 0xfffffffe00000005, -7
+    TEST_PSIMD_RR_SET 509, pm2sub.wx, \
+                       0x00000004fffffffd, 0xfffffffe00000005, -14
+
+    TEST_PSIMD_RR_VXSAT_STATE 510, pm2sadd.h, \
+        0xfffb00020004fffd, 0x0003fff9fffe0005, \
+        0xffffffe3ffffffe9, 0, 0
+    TEST_PSIMD_RR_VXSAT_STATE 510, pm2sadd.h, \
+        0x8000800080008000, 0x8000800080008000, \
+        0x7fffffff7fffffff, 0, 1
+    TEST_PSIMD_RR_VXSAT_STATE 510, pm2sadd.h, \
+        0x8000800080008000, 0x7fff7fff7fff7fff, \
+        0x8001000080010000, 0, 0
+    TEST_PSIMD_RR_VXSAT_STATE 510, pm2sadd.h, 0, 0, 0, 1, 1
+    TEST_PSIMD_RR_RD_RS1 510, pm2sadd.h, \
+        0xfffb00020004fffd, 0x0003fff9fffe0005, \
+        0xffffffe3ffffffe9
+    TEST_PSIMD_RR_RD_RS2 510, pm2sadd.h, \
+        0xfffb00020004fffd, 0x0003fff9fffe0005, \
+        0xffffffe3ffffffe9
+    TEST_PSIMD_RR_VXSAT_STATE 511, pm2sadd.hx, \
+        0xfffb00020004fffd, 0x0003fff9fffe0005, \
+        0x000000290000001a, 0, 0
+    TEST_PSIMD_RR_VXSAT_STATE 511, pm2sadd.hx, \
+        0x8000800080008000, 0x8000800080008000, \
+        0x7fffffff7fffffff, 0, 1
+    TEST_PSIMD_RR_VXSAT_STATE 511, pm2sadd.hx, \
+        0x8000800080008000, 0x7fff7fff7fff7fff, \
+        0x8001000080010000, 0, 0
+    TEST_PSIMD_RR_VXSAT_STATE 511, pm2sadd.hx, 0, 0, 0, 1, 1
+    TEST_PSIMD_RR_RD_RS1 511, pm2sadd.hx, \
+        0xfffb00020004fffd, 0x0003fff9fffe0005, \
+        0x000000290000001a
+    TEST_PSIMD_RR_RD_RS2 511, pm2sadd.hx, \
+        0xfffb00020004fffd, 0x0003fff9fffe0005, \
+        0x000000290000001a
+    TEST_PSIMD_ACC_RR_SET 512, pm2adda.h, 0xfffffffd7ffffffd, \
+        0xfffb00020004fffd, 0x0003fff9fffe0005, \
+        0xffffffe07fffffe6, 0xfffaffe50004ffe6, 0x0003ffdcfffdffee
+    TEST_PSIMD_ACC_RR_SET 513, pm2addasu.h, 0xfffffffd7ffffffd, \
+        0xfffb00020004fffd, 0x0003fff9fffe0005, \
+        0x0001ffe08003ffe6, 0xfffcffe50008ffe6, 0x0005ffdc0001ffee
+    TEST_PSIMD_ACC_RR_SET 514, pm2addau.h, 0xfffffffd7ffffffd, \
+        0xfffb00020004fffd, 0x0003fff9fffe0005, \
+        0x0004ffe08008ffe6, 0xffffffe5000dffe6, 0x0008ffdc0006ffee
+    TEST_PSIMD_ACC_RR_SET 515, pm2adda.hx, 0xfffffffd7ffffffd, \
+        0xfffb00020004fffd, 0x0003fff9fffe0005, \
+        0x0000002680000017, 0xfffb002b00050017, 0x00040022fffe001f
+    TEST_PSIMD_ACC_RR_SET 516, pm2suba.h, 0xfffffffd7ffffffd, \
+        0xfffb00020004fffd, 0x0003fff9fffe0005, \
+        0xfffffffe7ffffff6, 0xfffb00030004fff6, 0x0003fffafffdfffe
+    TEST_PSIMD_ACC_RR_SET 517, pm2suba.hx, 0xfffffffd7ffffffd, \
+        0xfffb00020004fffd, 0x0003fff9fffe0005, \
+        0xffffffe07fffffef, 0xfffaffe50004ffef, 0x0003ffdcfffdfff7
+    TEST_PSIMD_ACC_RR_SET 518, pm2adda.w, 0x7ffffffffffffffd, \
+        0x00000004fffffffd, 0xfffffffe00000005, \
+        0x7fffffffffffffe6, 0x00000004ffffffe6, 0xfffffffdffffffee
+    TEST_PSIMD_ACC_RR_SET 519, pm2addasu.w, 0x7ffffffffffffffd, \
+        0x00000004fffffffd, 0xfffffffe00000005, \
+        0x80000003ffffffe6, 0x00000008ffffffe6, 0x00000001ffffffee
+    TEST_PSIMD_ACC_RR_SET 520, pm2addau.w, 0x7ffffffffffffffd, \
+        0x00000004fffffffd, 0xfffffffe00000005, \
+        0x80000008ffffffe6, 0x0000000dffffffe6, 0x00000006ffffffee
+    TEST_PSIMD_ACC_RR_SET 521, pm2adda.wx, 0x7ffffffffffffffd, \
+        0x00000004fffffffd, 0xfffffffe00000005, \
+        0x8000000000000017, 0x0000000500000017, 0xfffffffe0000001f
+    TEST_PSIMD_ACC_RR_SET 522, pm2suba.w, 0x7ffffffffffffffd, \
+        0x00000004fffffffd, 0xfffffffe00000005, \
+        0x7ffffffffffffff6, 0x00000004fffffff6, 0xfffffffdfffffffe
+    TEST_PSIMD_ACC_RR_SET 523, pm2suba.wx, 0x7ffffffffffffffd, \
+        0x00000004fffffffd, 0xfffffffe00000005, \
+        0x7fffffffffffffef, 0x00000004ffffffef, 0xfffffffdfffffff7
+    TEST_PSIMD_RR_SET 524, pm4add.b, \
+                       0x08f906fbfc03fe01, 0xf40b0af708f90605, \
+                       0xffffffbcffffffc4
+    TEST_PSIMD_RR_SET 525, pm4addsu.b, \
+                       0x08f906fbfc03fe01, 0xf40b0af708f90605, \
+                       0x000002bc000002c4
+    TEST_PSIMD_RR_SET 526, pm4addu.b, \
+                       0x08f906fbfc03fe01, 0xf40b0af708f90605, \
+                       0x000104bc000010c4
+    TEST_PSIMD_ACC_RR_SET 527, pm4adda.b, 0xfffffffd7ffffffd, \
+        0x08f906fbfc03fe01, 0xf40b0af708f90605, \
+        0xffffffb97fffffc1, 0x08f906b7fc03fdc5, 0xf40b0ab308f905c9
+    TEST_PSIMD_ACC_RR_SET 528, pm4addasu.b, 0xfffffffd7ffffffd, \
+        0x08f906fbfc03fe01, 0xf40b0af708f90605, \
+        0x000002b9800002c1, 0x08f909b7fc0400c5, 0xf40b0db308f908c9
+    TEST_PSIMD_ACC_RR_SET 529, pm4addau.b, 0xfffffffd7ffffffd, \
+        0x08f906fbfc03fe01, 0xf40b0af708f90605, \
+        0x000104b9800010c1, 0x08fa0bb7fc040ec5, 0xf40c0fb308f916c9
+    TEST_PSIMD_RR_SET 530, pm4add.h, \
+                       0x0006fffb0004fffd, 0xfff60009fff80007, -158
+    TEST_PSIMD_RR_SET 531, pm4addsu.h, \
+                       0x0006fffb0004fffd, 0xfff60009fff80007, \
+                       0x000000000009ff62
+    TEST_PSIMD_RR_SET 532, pm4addu.h, \
+                       0x0006fffb0004fffd, 0xfff60009fff80007, \
+                       0x000000000019ff62
+    TEST_PSIMD_ACC_RR_SET 533, pm4adda.h, 0x7ffffffffffffffd, \
+        0x0006fffb0004fffd, 0xfff60009fff80007, \
+        0x7fffffffffffff5f, 0x0006fffb0004ff5f, 0xfff60009fff7ff69
+    TEST_PSIMD_ACC_RR_SET 534, pm4addasu.h, 0x7ffffffffffffffd, \
+        0x0006fffb0004fffd, 0xfff60009fff80007, \
+        0x800000000009ff5f, 0x0006fffb000eff5f, 0xfff6000a0001ff69
+    TEST_PSIMD_ACC_RR_SET 535, pm4addau.h, 0x7ffffffffffffffd, \
+        0x0006fffb0004fffd, 0xfff60009fff80007, \
+        0x800000000019ff5f, 0x0006fffb001eff5f, 0xfff6000a0011ff69
+    TEST_PSIMD_RR_SET 536, pmq2add.h, \
+                       0x4001800080004001, 0x4000400080004000, \
+                       0xffffe0000000a000
+    TEST_PSIMD_RR_SET 537, pmqr2add.h, \
+                       0x4001800080004001, 0x4000400080004000, \
+                       0xffffe0010000a001
+    TEST_PSIMD_ACC_RR_SET 538, pmq2adda.h, 0xfffffffd7ffffffd, \
+        0x4001800080004001, 0x4000400080004000, \
+        0xffffdffd80009ffd, 0x400160008000e001, 0x400020008000e000
+    TEST_PSIMD_ACC_RR_SET 539, pmqr2adda.h, 0xfffffffd7ffffffd, \
+        0x4001800080004001, 0x4000400080004000, \
+        0xffffdffe80009ffe, 0x400160018000e002, 0x400020018000e001
+    TEST_PSIMD_RR_SET 540, pmq2add.w, \
+                       0x8000000040000001, 0x8000000040000000, \
+                       0x00000000a0000000
+    TEST_PSIMD_RR_SET 541, pmqr2add.w, \
+                       0x8000000040000001, 0x8000000040000000, \
+                       0x00000000a0000001
+    TEST_PSIMD_ACC_RR_SET 542, pmq2adda.w, 0x7ffffffffffffffd, \
+        0x8000000040000001, 0x8000000040000000, \
+        0x800000009ffffffd, 0x80000000e0000001, 0x80000000e0000000
+    TEST_PSIMD_ACC_RR_SET 543, pmqr2adda.w, 0x7ffffffffffffffd, \
+        0x8000000040000001, 0x8000000040000000, \
+        0x800000009ffffffe, 0x80000000e0000002, 0x80000000e0000001
+    TEST_PSIMD_RR_SET 562, padd.bs, \
+        0x04030201ff807f01, 0x1234567880000080, 0x848382817f00ff81
+    TEST_PSIMD_RR_SET 563, padd.hs, \
+        0x000480027fff8001, 0x1234567880008000, 0x80040002ffff0001
+    TEST_PSIMD_RR_SET 564, padd.ws, \
+        0x7fffffff80000001, 0x1234567880000000, 0xffffffff00000001
+
+    /* ZIP/UNZIP: every byte is unique so lane source and order are visible. */
+    TEST_PSIMD_RR_SET 581, zip8p, \
+        0x7766554433221100, 0xffeeddccbbaa9988, 0xbb33aa2299118800
+    TEST_PSIMD_RR_SET 582, zip8hp, \
+        0x7766554433221100, 0xffeeddccbbaa9988, 0xff77ee66dd55cc44
+    TEST_PSIMD_RR_SET 583, zip16p, \
+        0x7766554433221100, 0xffeeddccbbaa9988, 0xbbaa332299881100
+    TEST_PSIMD_RR_SET 584, zip16hp, \
+        0x7766554433221100, 0xffeeddccbbaa9988, 0xffee7766ddcc5544
+    TEST_PSIMD_RR_SET 585, unzip8p, \
+        0x7766554433221100, 0xffeeddccbbaa9988, 0xeeccaa8866442200
+    TEST_PSIMD_RR_SET 586, unzip8hp, \
+        0x7766554433221100, 0xffeeddccbbaa9988, 0xffddbb9977553311
+    TEST_PSIMD_RR_SET 587, unzip16p, \
+        0x7766554433221100, 0xffeeddccbbaa9988, 0xddcc998855441100
+    TEST_PSIMD_RR_SET 588, unzip16hp, \
+        0x7766554433221100, 0xffeeddccbbaa9988, 0xffeebbaa77663322
+
+    /* Signed-direction whole-register shifts, including both right guards. */
+    TEST_PSIMD_RR_SET 589, sha, 0x8000000000000001, 1, 2
+    TEST_PSIMD_RR 589, sha, 0x8000000000000001, -1, \
+        0xc000000000000000
+    TEST_PSIMD_RR 589, sha, 0x8000000000000001, -64, -1
+    TEST_PSIMD_RR 589, sha, 0x8000000000000001, 64, 0
+    /* Rounded right shifts: guard 0/1, negative operand, and -XLEN. */
+    TEST_PSIMD_RR_SET 591, shar, 3, -1, 2
+    TEST_PSIMD_RR 591, shar, 2, -1, 1
+    TEST_PSIMD_RR 591, shar, -3, -1, -1
+    /* Extended shifts consume the old rd; exercise it and both aliases. */
+    TEST_PSIMD_ACC_RR_SET 593, slx, 0x1122334455667788, \
+        0x99aabbccddeeff5a, 8, 0x2233445566778899, \
+        0xaabbccddeeff5a99, 0x899
+    TEST_PSIMD_ACC_RR_SET 594, srx, 0x1122334455667788, \
+        0x99aabbccddeeff5a, 8, 0x5a11223344556677, \
+        0x5a99aabbccddeeff, 0x5a00000000000000
+
+    TEST_PSIMD_R_SET 598, rev, 0x0123456789abcdef, 0xf7b3d591e6a2c480
+    TEST_PSIMD_R_SET 599, rev16, \
+        0x0123456789abcdef, 0xcdef89ab45670123
+
+    /* SPEC: rounding -1 by XLEN yields zero; kept last as a bug detector. */
+    TEST_PSIMD_RR 591, shar, -1, -64, 0
+
+    /* P v0.21 variable-shift and narrowing mnemonics. */
+    TEST_PSIMD_SAT_RR_SET 608, psshl.ws, \
+        0x400000007ffffffe, 1, 0x80000000fffffffc, \
+        0x8000000040000001, 1, 0xffffffff80000002, \
+        0xffffffff00000001, 1, 0xffffffff00000002
+    TEST_PSIMD_RR_VXSAT_STATE 608, psshl.ws, \
+        0x800000017fffffff, -1, 0x400000003fffffff, 0, 0
+    TEST_PSIMD_SAT_RR_SET 609, psshlr.ws, \
+        0x400000007ffffffe, 1, 0x80000000fffffffc, \
+        0x8000000040000001, 1, 0xffffffff80000002, \
+        0xffffffff00000001, 1, 0xffffffff00000002
+    TEST_PSIMD_RR_VXSAT_STATE 609, psshlr.ws, \
+        0x800000037ffffffe, -1, 0x400000023fffffff, 0, 0
+    TEST_PSIMD_RR_VXSAT_STATE 609, psshlr.ws, \
+        0x800000017fffffff, -33, 0x0000000100000000, 0, 0
+
+    TEST_PSIMD_RR_SET 610, shl, 0x8000000000000001, -1, \
+        0x4000000000000000
+    TEST_PSIMD_RR 610, shl, 0x8000000000000001, 64, 0
+    TEST_PSIMD_RR_SET 611, shlr, 0x8000000000000003, -1, \
+        0x4000000000000002
+    TEST_PSIMD_RR 611, shlr, -1, -1, 0x8000000000000000
+    TEST_PSIMD_RR 611, shlr, -1, -64, 1
+    TEST_PSIMD_RR 611, shlr, 0x8000000000000000, -65, 1
+
+    TEST_PSIMD_SAT_RR_SET 612, pnclipp.b, \
+        0x0001ffff007fff80, 0x007efffe00020000, \
+        0x7efe020001ff7f80, \
+        0x0080008000800080, 0x0080008000800080, \
+        0x7f7f7f7f7f7f7f7f, \
+        0xff7fff7fff7fff7f, 0xff7fff7fff7fff7f, \
+        0x8080808080808080
+    TEST_PSIMD_SAT_RR_SET 613, pnclipp.h, \
+        0x00007fffffff8000, 0x00000001ffffffff, \
+        0x0001ffff7fff8000, \
+        0x0000800000008000, 0x0000800000008000, \
+        0x7fff7fff7fff7fff, \
+        0xffff7fffffff7fff, 0xffff7fffffff7fff, \
+        0x8000800080008000
+    TEST_PSIMD_SAT_RR_SET 614, pnclipp.w, \
+        0xffffffff80000000, 0x000000007fffffff, \
+        0x7fffffff80000000, \
+        0x0000000080000000, 0x0000000080000000, \
+        0x7fffffff7fffffff, \
+        0xffffffff7fffffff, 0xffffffff7fffffff, \
+        0x8000000080000000
+    TEST_PSIMD_SAT_RR_SET 615, pnclipup.b, \
+        0x00fe000100ff0000, 0x002a007f00800002, \
+        0x2a7f8002fe01ff00, \
+        0x0100010001000100, 0x0100010001000100, -1, \
+        -1, -1, -1
+    TEST_PSIMD_SAT_RR_SET 616, pnclipup.h, \
+        0x0000ffff00000000, 0x0000fffe00000001, \
+        0xfffe0001ffff0000, \
+        0x0001000000010000, 0x0001000000010000, -1, \
+        -1, -1, -1
+    TEST_PSIMD_SAT_RR_SET 617, pnclipup.w, \
+        0x00000000ffffffff, 1, 0x00000001ffffffff, \
+        0x0000000100000000, 0x0000000100000000, -1, \
+        -1, -1, -1
+    PSIMD_TEST_EXIT 0
+    .size _start, .-_start
+
+    PSIMD_DEFINE_FAILURE_HANDLER
+
+    .section .note.GNU-stack,"",@progbits
diff --git a/tests/tcg/riscv/psimd-test-macros.inc b/tests/tcg/riscv/psimd-test-macros.inc
new file mode 100644
index 00000000000..7fd270762b9
--- /dev/null
+++ b/tests/tcg/riscv/psimd-test-macros.inc
@@ -0,0 +1,952 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Common assembly test macros for the RISC-V P extension. */
+
+/*
+ * Allocate a stable assertion number for every case ID at assembly time.
+ * The per-case symbol survives non-contiguous groups of vectors, so the same
+ * instruction can add tests later without reusing an earlier subcase number.
+ */
+.macro PSIMD_FAIL_IF_NE actual, expected, case_id
+    .ifndef .Lpsimd_subcase_\case_id
+        .set .Lpsimd_subcase_\case_id, 0
+    .else
+        .set .Lpsimd_subcase_\case_id, .Lpsimd_subcase_\case_id + 1
+    .endif
+    beq     \actual, \expected, .Lpass\@
+    li      a0, \case_id
+    li      a1, .Lpsimd_subcase_\case_id
+    tail    psimd_test_fail
+.Lpass\@:
+.endm
+
+/* Linux syscall numbers are shared by RV32 and RV64. */
+#define PSIMD_NR_WRITE 64
+#define PSIMD_NR_EXIT  93
+
+.macro PSIMD_TEST_EXIT status
+    li      a0, \status
+    li      a7, PSIMD_NR_EXIT
+    ecall
+.endm
+
+/*
+ * Emit once, after _start.  Keep diagnostics independent of libc by filling
+ * fixed-width decimal fields and writing the message directly to stdout.
+ */
+.macro PSIMD_DEFINE_FAILURE_HANDLER
+    .section .data
+.Lpsimd_fail_message:
+    .ascii  "PSIMD FAIL: case=00000 subcase=00000\n"
+.Lpsimd_fail_message_end:
+
+    .text
+    .balign 4
+    .type psimd_test_fail, @function
+psimd_test_fail:
+    la      t0, .Lpsimd_fail_message
+    li      t1, 10
+
+    /* Fill the five case digits from right to left. */
+    addi    t2, t0, 21
+    li      t3, 5
+.Lpsimd_case_loop:
+    remu    t4, a0, t1
+    addi    t4, t4, '0'
+    sb      t4, 0(t2)
+    divu    a0, a0, t1
+    addi    t2, t2, -1
+    addi    t3, t3, -1
+    bnez    t3, .Lpsimd_case_loop
+
+    /* Fill the five subcase digits from right to left. */
+    addi    t2, t0, 35
+    li      t3, 5
+.Lpsimd_subcase_loop:
+    remu    t4, a1, t1
+    addi    t4, t4, '0'
+    sb      t4, 0(t2)
+    divu    a1, a1, t1
+    addi    t2, t2, -1
+    addi    t3, t3, -1
+    bnez    t3, .Lpsimd_subcase_loop
+
+    li      a0, 1
+    la      a1, .Lpsimd_fail_message
+    li      a2, .Lpsimd_fail_message_end - .Lpsimd_fail_message
+    li      a7, PSIMD_NR_WRITE
+    ecall
+
+    li      a0, 1
+    li      a7, PSIMD_NR_EXIT
+    ecall
+    .size psimd_test_fail, .-psimd_test_fail
+.endm
+
+.macro TEST_PSIMD_RR case_id, insn, input1, input2, expected
+    li      t0, \input1
+    li      t1, \input2
+    \insn   t2, t0, t1
+    li      t3, \expected
+    PSIMD_FAIL_IF_NE t2, t3, \case_id
+.endm
+
+.macro TEST_PSIMD_RR_RD_RS1 case_id, insn, input1, input2, expected
+    li      t0, \input1
+    li      t1, \input2
+    \insn   t0, t0, t1
+    li      t3, \expected
+    PSIMD_FAIL_IF_NE t0, t3, \case_id
+.endm
+
+.macro TEST_PSIMD_RR_RD_RS2 case_id, insn, input1, input2, expected
+    li      t0, \input1
+    li      t1, \input2
+    \insn   t1, t0, t1
+    li      t3, \expected
+    PSIMD_FAIL_IF_NE t1, t3, \case_id
+.endm
+
+.macro TEST_PSIMD_R case_id, insn, input, expected
+    li      t0, \input
+    \insn   t2, t0
+    li      t3, \expected
+    PSIMD_FAIL_IF_NE t2, t3, \case_id
+.endm
+
+.macro TEST_PSIMD_R_RD_RS1 case_id, insn, input, expected
+    li      t0, \input
+    \insn   t0, t0
+    li      t3, \expected
+    PSIMD_FAIL_IF_NE t0, t3, \case_id
+.endm
+
+/* Normal value, zero, and rd == rs1. */
+.macro TEST_PSIMD_R_SET case_id, insn, input, expected
+    TEST_PSIMD_R \case_id, \insn, \input, \expected
+    TEST_PSIMD_R \case_id, \insn, 0, 0
+    TEST_PSIMD_R_RD_RS1 \case_id, \insn, \input, \expected
+.endm
+
+.macro TEST_PSIMD_R_VXSAT_STATE case_id, insn, input, expected, \
+                                 initial_vxsat, expected_vxsat
+    li      t4, \initial_vxsat
+    csrw    vxsat, t4
+    li      t0, \input
+    \insn   t2, t0
+    li      t3, \expected
+    PSIMD_FAIL_IF_NE t2, t3, \case_id
+    csrr    t4, vxsat
+    li      t5, \expected_vxsat
+    PSIMD_FAIL_IF_NE t4, t5, \case_id
+.endm
+
+/* Unary saturation: ordinary, minimum negative, sticky, and source alias. */
+.macro TEST_PSIMD_SAT_R_SET case_id, insn, normal, normal_expected, \
+                             saturating, saturating_expected
+    TEST_PSIMD_R_VXSAT_STATE \case_id, \insn, \normal, \
+                              \normal_expected, 0, 0
+    TEST_PSIMD_R_VXSAT_STATE \case_id, \insn, \saturating, \
+                              \saturating_expected, 0, 1
+    TEST_PSIMD_R_VXSAT_STATE \case_id, \insn, 0, 0, 1, 1
+    TEST_PSIMD_R_RD_RS1 \case_id, \insn, \normal, \normal_expected
+.endm
+
+/* Normal, zero, and both legal destination/source aliasing forms. */
+.macro TEST_PSIMD_RR_SET case_id, insn, input1, input2, expected, zero_expected=0
+    TEST_PSIMD_RR \case_id, \insn, \input1, \input2, \expected
+    TEST_PSIMD_RR \case_id, \insn, 0, 0, \zero_expected
+    TEST_PSIMD_RR_RD_RS1 \case_id, \insn, \input1, \input2, \expected
+    TEST_PSIMD_RR_RD_RS2 \case_id, \insn, \input1, \input2, \expected
+.endm
+
+.macro TEST_PSIMD_RI case_id, insn, input, immediate, expected
+    li      t0, \input
+    \insn   t2, t0, \immediate
+    li      t3, \expected
+    PSIMD_FAIL_IF_NE t2, t3, \case_id
+.endm
+
+.macro TEST_PSIMD_RI_RD_RS1 case_id, insn, input, immediate, expected
+    li      t0, \input
+    \insn   t0, t0, \immediate
+    li      t3, \expected
+    PSIMD_FAIL_IF_NE t0, t3, \case_id
+.endm
+
+/* Immediate shift: amount 1, zero, legal maximum, and rd == rs1. */
+.macro TEST_PSIMD_SHIFT_RI_SET case_id, insn, input, shift1_expected, \
+                                max_shift, max_expected
+    TEST_PSIMD_RI \case_id, \insn, \input, 1, \shift1_expected
+    TEST_PSIMD_RI \case_id, \insn, \input, 0, \input
+    TEST_PSIMD_RI \case_id, \insn, \input, \max_shift, \max_expected
+    TEST_PSIMD_RI_RD_RS1 \case_id, \insn, \input, 1, \shift1_expected
+.endm
+
+/* Register shift adds a maximum masked amount to the standard RR set. */
+.macro TEST_PSIMD_SHIFT_RR_SET case_id, insn, input, shift1_expected, \
+                                max_shift, max_expected
+    TEST_PSIMD_RR_SET \case_id, \insn, \input, 1, \shift1_expected
+    TEST_PSIMD_RR \case_id, \insn, \input, \max_shift, \max_expected
+.endm
+
+.macro TEST_PSIMD_LI case_id, insn, immediate, expected
+    \insn   t2, \immediate
+    li      t3, \expected
+    PSIMD_FAIL_IF_NE t2, t3, \case_id
+.endm
+
+.macro TEST_PSIMD_PAIR_LI case_id, insn, immediate, expected_lo, expected_hi
+    \insn   a0, \immediate
+    li      t0, \expected_lo
+    PSIMD_FAIL_IF_NE a0, t0, \case_id
+    li      t0, \expected_hi
+    PSIMD_FAIL_IF_NE a1, t0, \case_id
+.endm
+
+.macro TEST_PSIMD_PAIR_LI_SET case_id, insn, one_expected, max_immediate, \
+                               max_expected, min_immediate, min_expected
+    TEST_PSIMD_PAIR_LI \case_id, \insn, 0, 0, 0
+    TEST_PSIMD_PAIR_LI \case_id, \insn, 1, \one_expected, \one_expected
+    TEST_PSIMD_PAIR_LI \case_id, \insn, \max_immediate, \max_expected, \
+                       \max_expected
+    TEST_PSIMD_PAIR_LI \case_id, \insn, \min_immediate, \min_expected, \
+                       \min_expected
+.endm
+
+/* rd is both the accumulator input and the result. */
+.macro TEST_PSIMD_ACC_RR case_id, insn, initial, input1, input2, expected
+    li      t0, \input1
+    li      t1, \input2
+    li      t2, \initial
+    \insn   t2, t0, t1
+    li      t3, \expected
+    PSIMD_FAIL_IF_NE t2, t3, \case_id
+.endm
+
+/* Accumulator result, zero case, and both architecturally valid rd aliases. */
+.macro TEST_PSIMD_ACC_RR_SET case_id, insn, initial, input1, input2, expected, \
+                              rd_rs1_expected, rd_rs2_expected
+    TEST_PSIMD_ACC_RR \case_id, \insn, \initial, \input1, \input2, \expected
+    TEST_PSIMD_ACC_RR \case_id, \insn, 0, 0, 0, 0
+
+    li      t0, \input1
+    li      t1, \input2
+    \insn   t0, t0, t1
+    li      t3, \rd_rs1_expected
+    PSIMD_FAIL_IF_NE t0, t3, \case_id
+
+    li      t0, \input1
+    li      t1, \input2
+    \insn   t1, t0, t1
+    li      t3, \rd_rs2_expected
+    PSIMD_FAIL_IF_NE t1, t3, \case_id
+.endm
+
+/*
+ * Check the saturated result, vxsat, and its sticky behavior.  The second
+ * operation (1 + 1 in each XLEN value) does not saturate.
+ */
+.macro TEST_PSIMD_RR_VXSAT case_id, insn, input1, input2, expected
+    csrw    vxsat, zero
+    li      t0, \input1
+    li      t1, \input2
+    \insn   t2, t0, t1
+    li      t3, \expected
+    PSIMD_FAIL_IF_NE t2, t3, \case_id
+    csrr    t4, vxsat
+    li      t5, 1
+    PSIMD_FAIL_IF_NE t4, t5, \case_id
+
+    li      t0, 1
+    li      t1, 1
+    \insn   t2, t0, t1
+    csrr    t4, vxsat
+    PSIMD_FAIL_IF_NE t4, t5, \case_id
+.endm
+
+.macro TEST_PSIMD_RR_VXSAT_STATE case_id, insn, input1, input2, expected, \
+                                  initial_vxsat, expected_vxsat
+    li      t4, \initial_vxsat
+    csrw    vxsat, t4
+    li      t0, \input1
+    li      t1, \input2
+    \insn   t2, t0, t1
+    li      t3, \expected
+    PSIMD_FAIL_IF_NE t2, t3, \case_id
+    csrr    t4, vxsat
+    li      t5, \expected_vxsat
+    PSIMD_FAIL_IF_NE t4, t5, \case_id
+.endm
+
+/*
+ * Saturating RR operation: normal, two saturating boundaries, sticky flag,
+ * and both destination/source aliases.  Both saturation vectors must set
+ * vxsat; their meaning (positive/negative/unsigned underflow) is per opcode.
+ */
+.macro TEST_PSIMD_SAT_RR_SET case_id, insn, normal1, normal2, normal_expected, \
+                              sat1_1, sat1_2, sat1_expected, sat2_1, sat2_2, \
+                              sat2_expected
+    TEST_PSIMD_RR_VXSAT_STATE \case_id, \insn, \normal1, \normal2, \
+                               \normal_expected, 0, 0
+    TEST_PSIMD_RR_VXSAT_STATE \case_id, \insn, \sat1_1, \sat1_2, \
+                               \sat1_expected, 0, 1
+    TEST_PSIMD_RR_VXSAT_STATE \case_id, \insn, \sat2_1, \sat2_2, \
+                               \sat2_expected, 0, 1
+    TEST_PSIMD_RR_VXSAT_STATE \case_id, \insn, 0, 0, 0, 1, 1
+    TEST_PSIMD_RR_RD_RS1 \case_id, \insn, \normal1, \normal2, \
+                         \normal_expected
+    TEST_PSIMD_RR_RD_RS2 \case_id, \insn, \normal1, \normal2, \
+                         \normal_expected
+.endm
+
+.macro TEST_PSIMD_RI_VXSAT case_id, insn, input, immediate, expected
+    csrw    vxsat, zero
+    li      t0, \input
+    \insn   t2, t0, \immediate
+    li      t3, \expected
+    PSIMD_FAIL_IF_NE t2, t3, \case_id
+    csrr    t4, vxsat
+    li      t5, 1
+    PSIMD_FAIL_IF_NE t4, t5, \case_id
+.endm
+
+.macro TEST_PSIMD_RI_VXSAT_STATE case_id, insn, input, immediate, expected, \
+                                  initial_vxsat, expected_vxsat
+    li      t4, \initial_vxsat
+    csrw    vxsat, t4
+    li      t0, \input
+    \insn   t2, t0, \immediate
+    li      t3, \expected
+    PSIMD_FAIL_IF_NE t2, t3, \case_id
+    csrr    t4, vxsat
+    li      t5, \expected_vxsat
+    PSIMD_FAIL_IF_NE t4, t5, \case_id
+.endm
+
+.macro TEST_PSIMD_SAT_RI_SET case_id, insn, immediate, normal, \
+                              normal_expected, positive, positive_expected, \
+                              negative, negative_expected
+    TEST_PSIMD_RI_VXSAT_STATE \case_id, \insn, \normal, \immediate, \
+                               \normal_expected, 0, 0
+    TEST_PSIMD_RI_VXSAT_STATE \case_id, \insn, \positive, \immediate, \
+                               \positive_expected, 0, 1
+    TEST_PSIMD_RI_VXSAT_STATE \case_id, \insn, \negative, \immediate, \
+                               \negative_expected, 0, 1
+    TEST_PSIMD_RI_VXSAT_STATE \case_id, \insn, 0, \immediate, 0, 1, 1
+    TEST_PSIMD_RI_RD_RS1 \case_id, \insn, \normal, \immediate, \
+                         \normal_expected
+.endm
+
+/* RV32 register-pair operands: a0/a1, a2/a3, and a4/a5. */
+.macro TEST_PSIMD_PAIR_RR case_id, insn, input1_lo, input1_hi, input2_lo, \
+                          input2_hi, expected_lo, expected_hi
+    li      a2, \input1_lo
+    li      a3, \input1_hi
+    li      a4, \input2_lo
+    li      a5, \input2_hi
+    \insn   a0, a2, a4
+    li      t0, \expected_lo
+    PSIMD_FAIL_IF_NE a0, t0, \case_id
+    li      t0, \expected_hi
+    PSIMD_FAIL_IF_NE a1, t0, \case_id
+.endm
+
+/* RV32 scalar sources with a 64-bit destination register pair. */
+.macro TEST_PSIMD_WIDE_RR case_id, insn, input1, input2, expected_lo, \
+                           expected_hi
+    li      t0, \input1
+    li      t1, \input2
+    \insn   a0, t0, t1
+    li      t2, \expected_lo
+    PSIMD_FAIL_IF_NE a0, t2, \case_id
+    li      t2, \expected_hi
+    PSIMD_FAIL_IF_NE a1, t2, \case_id
+.endm
+
+.macro TEST_PSIMD_WIDE_RR_SET case_id, insn, input1, input2, expected_lo, \
+                               expected_hi
+    TEST_PSIMD_WIDE_RR \case_id, \insn, \input1, \input2, \expected_lo, \
+                       \expected_hi
+    TEST_PSIMD_WIDE_RR \case_id, \insn, 0, 0, 0, 0
+
+    li      a2, \input1
+    li      a4, \input2
+    \insn   a2, a2, a4
+    li      t0, \expected_lo
+    PSIMD_FAIL_IF_NE a2, t0, \case_id
+    li      t0, \expected_hi
+    PSIMD_FAIL_IF_NE a3, t0, \case_id
+
+    li      a2, \input1
+    li      a4, \input2
+    \insn   a4, a2, a4
+    li      t0, \expected_lo
+    PSIMD_FAIL_IF_NE a4, t0, \case_id
+    li      t0, \expected_hi
+    PSIMD_FAIL_IF_NE a5, t0, \case_id
+.endm
+
+.macro TEST_PSIMD_WIDE_RI case_id, insn, input, immediate, expected_lo, \
+                           expected_hi
+    li      t0, \input
+    \insn   a0, t0, \immediate
+    li      t1, \expected_lo
+    PSIMD_FAIL_IF_NE a0, t1, \case_id
+    li      t1, \expected_hi
+    PSIMD_FAIL_IF_NE a1, t1, \case_id
+.endm
+
+.macro TEST_PSIMD_WIDE_RI_SET case_id, insn, input, zero_lo, zero_hi, \
+                               one_lo, one_hi, max_imm, max_lo, max_hi
+    TEST_PSIMD_WIDE_RI \case_id, \insn, \input, 0, \zero_lo, \zero_hi
+    TEST_PSIMD_WIDE_RI \case_id, \insn, \input, 1, \one_lo, \one_hi
+    TEST_PSIMD_WIDE_RI \case_id, \insn, \input, \max_imm, \max_lo, \max_hi
+
+    li      a2, \input
+    \insn   a2, a2, 1
+    li      t0, \one_lo
+    PSIMD_FAIL_IF_NE a2, t0, \case_id
+    li      t0, \one_hi
+    PSIMD_FAIL_IF_NE a3, t0, \case_id
+.endm
+
+.macro TEST_PSIMD_WIDE_ACC_RR case_id, insn, initial_lo, initial_hi, input1, \
+                               input2, expected_lo, expected_hi
+    li      a0, \initial_lo
+    li      a1, \initial_hi
+    li      a2, \input1
+    li      a3, \input2
+    \insn   a0, a2, a3
+    li      t0, \expected_lo
+    PSIMD_FAIL_IF_NE a0, t0, \case_id
+    li      t0, \expected_hi
+    PSIMD_FAIL_IF_NE a1, t0, \case_id
+.endm
+
+.macro TEST_PSIMD_WIDE_ACC_RR_SET case_id, insn, initial_lo, initial_hi, \
+                                   input1, input2, expected_lo, expected_hi, \
+                                   rd_rs1_lo, rd_rs1_hi, rd_rs2_lo, rd_rs2_hi
+    TEST_PSIMD_WIDE_ACC_RR \case_id, \insn, \initial_lo, \initial_hi, \
+                           \input1, \input2, \expected_lo, \expected_hi
+    TEST_PSIMD_WIDE_ACC_RR \case_id, \insn, 0, 0, 0, 0, 0, 0
+
+    li      a2, \input1
+    li      a3, \initial_hi
+    li      a4, \input2
+    \insn   a2, a2, a4
+    li      t0, \rd_rs1_lo
+    PSIMD_FAIL_IF_NE a2, t0, \case_id
+    li      t0, \rd_rs1_hi
+    PSIMD_FAIL_IF_NE a3, t0, \case_id
+
+    li      a2, \input1
+    li      a4, \input2
+    li      a5, \initial_hi
+    \insn   a4, a2, a4
+    li      t0, \rd_rs2_lo
+    PSIMD_FAIL_IF_NE a4, t0, \case_id
+    li      t0, \rd_rs2_hi
+    PSIMD_FAIL_IF_NE a5, t0, \case_id
+.endm
+
+/* RV32 pair-to-scalar reduction: rs1 is a pair and rs2 is scalar. */
+.macro TEST_PSIMD_PAIR_REDUCE case_id, insn, input_lo, input_hi, scalar, \
+                               expected
+    li      a2, \input_lo
+    li      a3, \input_hi
+    li      a4, \scalar
+    \insn   a0, a2, a4
+    li      t0, \expected
+    PSIMD_FAIL_IF_NE a0, t0, \case_id
+
+    li      a2, 0
+    li      a3, 0
+    li      a4, 0
+    \insn   a0, a2, a4
+    PSIMD_FAIL_IF_NE a0, zero, \case_id
+
+    /* Scalar destination overlaps the low register of the source pair. */
+    li      a2, \input_lo
+    li      a3, \input_hi
+    li      a4, \scalar
+    \insn   a2, a2, a4
+    li      t0, \expected
+    PSIMD_FAIL_IF_NE a2, t0, \case_id
+
+    /* Scalar destination overlaps the scalar accumulator source. */
+    li      a2, \input_lo
+    li      a3, \input_hi
+    li      a4, \scalar
+    \insn   a4, a2, a4
+    li      t0, \expected
+    PSIMD_FAIL_IF_NE a4, t0, \case_id
+.endm
+
+/* RV32 register-pair result and rs1, with a scalar rs2 element. */
+.macro TEST_PSIMD_PAIR_SCALAR_RR_SET case_id, insn, input_lo, input_hi, \
+                                      scalar, expected_lo, expected_hi
+    li      a2, \input_lo
+    li      a3, \input_hi
+    li      a4, \scalar
+    \insn   a0, a2, a4
+    li      t0, \expected_lo
+    PSIMD_FAIL_IF_NE a0, t0, \case_id
+    li      t0, \expected_hi
+    PSIMD_FAIL_IF_NE a1, t0, \case_id
+
+    li      a2, 0
+    li      a3, 0
+    li      a4, 0
+    \insn   a0, a2, a4
+    PSIMD_FAIL_IF_NE a0, zero, \case_id
+    PSIMD_FAIL_IF_NE a1, zero, \case_id
+
+    li      a2, \input_lo
+    li      a3, \input_hi
+    li      a4, \scalar
+    \insn   a2, a2, a4
+    li      t0, \expected_lo
+    PSIMD_FAIL_IF_NE a2, t0, \case_id
+    li      t0, \expected_hi
+    PSIMD_FAIL_IF_NE a3, t0, \case_id
+
+    li      a2, \input_lo
+    li      a3, \input_hi
+    li      a4, \scalar
+    \insn   a4, a2, a4
+    li      t0, \expected_lo
+    PSIMD_FAIL_IF_NE a4, t0, \case_id
+    li      t0, \expected_hi
+    PSIMD_FAIL_IF_NE a5, t0, \case_id
+.endm
+
+/* RV32 pair result with scalar shift amount in rs2. */
+.macro TEST_PSIMD_PAIR_SHIFT_RR_SET case_id, insn, input_lo, input_hi, \
+                                     shift1_lo, shift1_hi, max_shift, \
+                                     max_lo, max_hi
+    li      a2, \input_lo
+    li      a3, \input_hi
+    li      a4, 1
+    \insn   a0, a2, a4
+    li      t0, \shift1_lo
+    PSIMD_FAIL_IF_NE a0, t0, \case_id
+    li      t0, \shift1_hi
+    PSIMD_FAIL_IF_NE a1, t0, \case_id
+
+    li      a2, 0
+    li      a3, 0
+    li      a4, 0
+    \insn   a0, a2, a4
+    PSIMD_FAIL_IF_NE a0, zero, \case_id
+    PSIMD_FAIL_IF_NE a1, zero, \case_id
+
+    li      a2, \input_lo
+    li      a3, \input_hi
+    li      a4, \max_shift
+    \insn   a0, a2, a4
+    li      t0, \max_lo
+    PSIMD_FAIL_IF_NE a0, t0, \case_id
+    li      t0, \max_hi
+    PSIMD_FAIL_IF_NE a1, t0, \case_id
+
+    li      a2, \input_lo
+    li      a3, \input_hi
+    li      a4, 1
+    \insn   a2, a2, a4
+    li      t0, \shift1_lo
+    PSIMD_FAIL_IF_NE a2, t0, \case_id
+    li      t0, \shift1_hi
+    PSIMD_FAIL_IF_NE a3, t0, \case_id
+.endm
+
+.macro TEST_PSIMD_PAIR_SHIFT_RR_VXSAT_STATE case_id, insn, input_lo, \
+                                              input_hi, shift, expected_lo, \
+                                              expected_hi, initial_vxsat, \
+                                              expected_vxsat
+    li      t4, \initial_vxsat
+    csrw    vxsat, t4
+    li      a2, \input_lo
+    li      a3, \input_hi
+    li      a4, \shift
+    \insn   a0, a2, a4
+    li      t0, \expected_lo
+    PSIMD_FAIL_IF_NE a0, t0, \case_id
+    li      t0, \expected_hi
+    PSIMD_FAIL_IF_NE a1, t0, \case_id
+    csrr    t4, vxsat
+    li      t5, \expected_vxsat
+    PSIMD_FAIL_IF_NE t4, t5, \case_id
+.endm
+
+.macro TEST_PSIMD_PAIR_VAR_SAT_SET case_id, insn, normal_lo, normal_hi, \
+                                    normal_exp_lo, normal_exp_hi, sat1_lo, \
+                                    sat1_hi, sat1_exp_lo, sat1_exp_hi, \
+                                    sat2_lo, sat2_hi, sat2_exp_lo, sat2_exp_hi
+    TEST_PSIMD_PAIR_SHIFT_RR_VXSAT_STATE \case_id, \insn, \normal_lo, \
+        \normal_hi, 1, \normal_exp_lo, \normal_exp_hi, 0, 0
+    TEST_PSIMD_PAIR_SHIFT_RR_VXSAT_STATE \case_id, \insn, \sat1_lo, \
+        \sat1_hi, 1, \sat1_exp_lo, \sat1_exp_hi, 0, 1
+    TEST_PSIMD_PAIR_SHIFT_RR_VXSAT_STATE \case_id, \insn, \sat2_lo, \
+        \sat2_hi, 1, \sat2_exp_lo, \sat2_exp_hi, 0, 1
+    TEST_PSIMD_PAIR_SHIFT_RR_VXSAT_STATE \case_id, \insn, 0, 0, 0, \
+        0, 0, 1, 1
+    li      a2, \normal_lo
+    li      a3, \normal_hi
+    li      a4, 1
+    \insn   a2, a2, a4
+    li      t0, \normal_exp_lo
+    PSIMD_FAIL_IF_NE a2, t0, \case_id
+    li      t0, \normal_exp_hi
+    PSIMD_FAIL_IF_NE a3, t0, \case_id
+.endm
+
+/* RV32 pair immediate shift with immediate 1, zero, maximum, and overlap. */
+.macro TEST_PSIMD_PAIR_SHIFT_RI_SET case_id, insn, input_lo, input_hi, \
+                                     shift1_lo, shift1_hi, max_shift, \
+                                     max_lo, max_hi
+    li      a2, \input_lo
+    li      a3, \input_hi
+    \insn   a0, a2, 1
+    li      t0, \shift1_lo
+    PSIMD_FAIL_IF_NE a0, t0, \case_id
+    li      t0, \shift1_hi
+    PSIMD_FAIL_IF_NE a1, t0, \case_id
+
+    li      a2, \input_lo
+    li      a3, \input_hi
+    \insn   a0, a2, 0
+    PSIMD_FAIL_IF_NE a0, a2, \case_id
+    PSIMD_FAIL_IF_NE a1, a3, \case_id
+
+    li      a2, \input_lo
+    li      a3, \input_hi
+    \insn   a0, a2, \max_shift
+    li      t0, \max_lo
+    PSIMD_FAIL_IF_NE a0, t0, \case_id
+    li      t0, \max_hi
+    PSIMD_FAIL_IF_NE a1, t0, \case_id
+
+    li      a2, \input_lo
+    li      a3, \input_hi
+    \insn   a2, a2, 1
+    li      t0, \shift1_lo
+    PSIMD_FAIL_IF_NE a2, t0, \case_id
+    li      t0, \shift1_hi
+    PSIMD_FAIL_IF_NE a3, t0, \case_id
+.endm
+
+/* RV32 register-pair source narrowed to one scalar destination. */
+.macro TEST_PSIMD_PAIR_NARROW_RI_SET case_id, insn, input_lo, input_hi, \
+                                      shift0_expected, shift1_expected, \
+                                      max_shift, max_expected
+    li      a2, \input_lo
+    li      a3, \input_hi
+    \insn   a0, a2, 1
+    li      t0, \shift1_expected
+    PSIMD_FAIL_IF_NE a0, t0, \case_id
+
+    li      a2, \input_lo
+    li      a3, \input_hi
+    \insn   a0, a2, 0
+    li      t0, \shift0_expected
+    PSIMD_FAIL_IF_NE a0, t0, \case_id
+
+    li      a2, \input_lo
+    li      a3, \input_hi
+    \insn   a0, a2, \max_shift
+    li      t0, \max_expected
+    PSIMD_FAIL_IF_NE a0, t0, \case_id
+
+    li      a2, \input_lo
+    li      a3, \input_hi
+    \insn   a2, a2, 1
+    li      t0, \shift1_expected
+    PSIMD_FAIL_IF_NE a2, t0, \case_id
+.endm
+
+.macro TEST_PSIMD_PAIR_NARROW_RR_SET case_id, insn, input_lo, input_hi, \
+                                      shift0_expected, shift1_expected, \
+                                      max_shift, max_expected
+    li      a2, \input_lo
+    li      a3, \input_hi
+    li      a4, 1
+    \insn   a0, a2, a4
+    li      t0, \shift1_expected
+    PSIMD_FAIL_IF_NE a0, t0, \case_id
+
+    li      a2, \input_lo
+    li      a3, \input_hi
+    li      a4, 0
+    \insn   a0, a2, a4
+    li      t0, \shift0_expected
+    PSIMD_FAIL_IF_NE a0, t0, \case_id
+
+    li      a2, \input_lo
+    li      a3, \input_hi
+    li      a4, \max_shift
+    \insn   a0, a2, a4
+    li      t0, \max_expected
+    PSIMD_FAIL_IF_NE a0, t0, \case_id
+
+    li      a2, \input_lo
+    li      a3, \input_hi
+    li      a4, 1
+    \insn   a2, a2, a4
+    li      t0, \shift1_expected
+    PSIMD_FAIL_IF_NE a2, t0, \case_id
+.endm
+
+.macro TEST_PSIMD_PAIR_NARROW_RI_VXSAT_STATE case_id, insn, input_lo, \
+                                               input_hi, immediate, expected, \
+                                               initial_vxsat, expected_vxsat
+    li      t4, \initial_vxsat
+    csrw    vxsat, t4
+    li      a2, \input_lo
+    li      a3, \input_hi
+    \insn   a0, a2, \immediate
+    li      t0, \expected
+    PSIMD_FAIL_IF_NE a0, t0, \case_id
+    csrr    t4, vxsat
+    li      t5, \expected_vxsat
+    PSIMD_FAIL_IF_NE t4, t5, \case_id
+.endm
+
+.macro TEST_PSIMD_PAIR_NARROW_RR_VXSAT_STATE case_id, insn, input_lo, \
+                                               input_hi, shift, expected, \
+                                               initial_vxsat, expected_vxsat
+    li      t4, \initial_vxsat
+    csrw    vxsat, t4
+    li      a2, \input_lo
+    li      a3, \input_hi
+    li      a4, \shift
+    \insn   a0, a2, a4
+    li      t0, \expected
+    PSIMD_FAIL_IF_NE a0, t0, \case_id
+    csrr    t4, vxsat
+    li      t5, \expected_vxsat
+    PSIMD_FAIL_IF_NE t4, t5, \case_id
+.endm
+
+.macro TEST_PSIMD_PAIR_CLIP_RI_SET case_id, insn, normal_lo, normal_hi, \
+                                    immediate, normal_expected, sat_lo, \
+                                    sat_hi, sat_expected
+    TEST_PSIMD_PAIR_NARROW_RI_VXSAT_STATE \case_id, \insn, \normal_lo, \
+        \normal_hi, \immediate, \normal_expected, 0, 0
+    TEST_PSIMD_PAIR_NARROW_RI_VXSAT_STATE \case_id, \insn, \sat_lo, \
+        \sat_hi, \immediate, \sat_expected, 0, 1
+    TEST_PSIMD_PAIR_NARROW_RI_VXSAT_STATE \case_id, \insn, 0, 0, 0, \
+        0, 1, 1
+    li      a2, \normal_lo
+    li      a3, \normal_hi
+    \insn   a2, a2, \immediate
+    li      t0, \normal_expected
+    PSIMD_FAIL_IF_NE a2, t0, \case_id
+.endm
+
+.macro TEST_PSIMD_PAIR_CLIP_RR_SET case_id, insn, normal_lo, normal_hi, \
+                                    shift, normal_expected, sat_lo, sat_hi, \
+                                    sat_expected
+    TEST_PSIMD_PAIR_NARROW_RR_VXSAT_STATE \case_id, \insn, \normal_lo, \
+        \normal_hi, \shift, \normal_expected, 0, 0
+    TEST_PSIMD_PAIR_NARROW_RR_VXSAT_STATE \case_id, \insn, \sat_lo, \
+        \sat_hi, \shift, \sat_expected, 0, 1
+    TEST_PSIMD_PAIR_NARROW_RR_VXSAT_STATE \case_id, \insn, 0, 0, 0, \
+        0, 1, 1
+    li      a2, \normal_lo
+    li      a3, \normal_hi
+    li      a4, \shift
+    \insn   a2, a2, a4
+    li      t0, \normal_expected
+    PSIMD_FAIL_IF_NE a2, t0, \case_id
+.endm
+
+.macro TEST_PSIMD_PAIR_R case_id, insn, input_lo, input_hi, expected_lo, \
+                          expected_hi
+    li      a2, \input_lo
+    li      a3, \input_hi
+    \insn   a0, a2
+    li      t0, \expected_lo
+    PSIMD_FAIL_IF_NE a0, t0, \case_id
+    li      t0, \expected_hi
+    PSIMD_FAIL_IF_NE a1, t0, \case_id
+.endm
+
+.macro TEST_PSIMD_PAIR_R_RD_RS1 case_id, insn, input_lo, input_hi, \
+                                 expected_lo, expected_hi
+    li      a2, \input_lo
+    li      a3, \input_hi
+    \insn   a2, a2
+    li      t0, \expected_lo
+    PSIMD_FAIL_IF_NE a2, t0, \case_id
+    li      t0, \expected_hi
+    PSIMD_FAIL_IF_NE a3, t0, \case_id
+.endm
+
+/* Unary pair result: lane order, zero, and the legal rd == rs1 overlap. */
+.macro TEST_PSIMD_PAIR_R_SET case_id, insn, input_lo, input_hi, expected_lo, \
+                              expected_hi
+    TEST_PSIMD_PAIR_R \case_id, \insn, \input_lo, \input_hi, \
+                      \expected_lo, \expected_hi
+    TEST_PSIMD_PAIR_R \case_id, \insn, 0, 0, 0, 0
+    TEST_PSIMD_PAIR_R_RD_RS1 \case_id, \insn, \input_lo, \input_hi, \
+                             \expected_lo, \expected_hi
+.endm
+
+.macro TEST_PSIMD_PAIR_R_VXSAT_STATE case_id, insn, input_lo, input_hi, \
+                                      expected_lo, expected_hi, \
+                                      initial_vxsat, expected_vxsat
+    li      t4, \initial_vxsat
+    csrw    vxsat, t4
+    li      a2, \input_lo
+    li      a3, \input_hi
+    \insn   a0, a2
+    li      t0, \expected_lo
+    PSIMD_FAIL_IF_NE a0, t0, \case_id
+    li      t0, \expected_hi
+    PSIMD_FAIL_IF_NE a1, t0, \case_id
+    csrr    t4, vxsat
+    li      t5, \expected_vxsat
+    PSIMD_FAIL_IF_NE t4, t5, \case_id
+.endm
+
+.macro TEST_PSIMD_PAIR_RI_VXSAT_STATE case_id, insn, input_lo, input_hi, \
+                                       immediate, expected_lo, expected_hi, \
+                                       initial_vxsat, expected_vxsat
+    li      t4, \initial_vxsat
+    csrw    vxsat, t4
+    li      a2, \input_lo
+    li      a3, \input_hi
+    \insn   a0, a2, \immediate
+    li      t0, \expected_lo
+    PSIMD_FAIL_IF_NE a0, t0, \case_id
+    li      t0, \expected_hi
+    PSIMD_FAIL_IF_NE a1, t0, \case_id
+    csrr    t4, vxsat
+    li      t5, \expected_vxsat
+    PSIMD_FAIL_IF_NE t4, t5, \case_id
+.endm
+
+.macro TEST_PSIMD_PAIR_SAT_RI_SET case_id, insn, immediate, normal_lo, \
+                                   normal_hi, normal_exp_lo, normal_exp_hi, \
+                                   positive_lo, positive_hi, pos_exp_lo, \
+                                   pos_exp_hi, negative_lo, negative_hi, \
+                                   neg_exp_lo, neg_exp_hi
+    TEST_PSIMD_PAIR_RI_VXSAT_STATE \case_id, \insn, \normal_lo, \
+        \normal_hi, \immediate, \normal_exp_lo, \normal_exp_hi, 0, 0
+    TEST_PSIMD_PAIR_RI_VXSAT_STATE \case_id, \insn, \positive_lo, \
+        \positive_hi, \immediate, \pos_exp_lo, \pos_exp_hi, 0, 1
+    TEST_PSIMD_PAIR_RI_VXSAT_STATE \case_id, \insn, \negative_lo, \
+        \negative_hi, \immediate, \neg_exp_lo, \neg_exp_hi, 0, 1
+    TEST_PSIMD_PAIR_RI_VXSAT_STATE \case_id, \insn, 0, 0, \immediate, \
+        0, 0, 1, 1
+    li      a2, \normal_lo
+    li      a3, \normal_hi
+    \insn   a2, a2, \immediate
+    li      t0, \normal_exp_lo
+    PSIMD_FAIL_IF_NE a2, t0, \case_id
+    li      t0, \normal_exp_hi
+    PSIMD_FAIL_IF_NE a3, t0, \case_id
+.endm
+
+.macro TEST_PSIMD_PAIR_SAT_R_SET case_id, insn, normal_lo, normal_hi, \
+                                  normal_exp_lo, normal_exp_hi, sat_lo, \
+                                  sat_hi, sat_exp_lo, sat_exp_hi
+    TEST_PSIMD_PAIR_R_VXSAT_STATE \case_id, \insn, \normal_lo, \
+                                   \normal_hi, \normal_exp_lo, \
+                                   \normal_exp_hi, 0, 0
+    TEST_PSIMD_PAIR_R_VXSAT_STATE \case_id, \insn, \sat_lo, \sat_hi, \
+                                   \sat_exp_lo, \sat_exp_hi, 0, 1
+    TEST_PSIMD_PAIR_R_VXSAT_STATE \case_id, \insn, 0, 0, 0, 0, 1, 1
+    TEST_PSIMD_PAIR_R_RD_RS1 \case_id, \insn, \normal_lo, \normal_hi, \
+                              \normal_exp_lo, \normal_exp_hi
+.endm
+
+
+.macro TEST_PSIMD_PAIR_RR_RD_RS1 case_id, insn, input1_lo, input1_hi, \
+                                  input2_lo, input2_hi, expected_lo, \
+                                  expected_hi
+    li      a2, \input1_lo
+    li      a3, \input1_hi
+    li      a4, \input2_lo
+    li      a5, \input2_hi
+    \insn   a2, a2, a4
+    li      t0, \expected_lo
+    PSIMD_FAIL_IF_NE a2, t0, \case_id
+    li      t0, \expected_hi
+    PSIMD_FAIL_IF_NE a3, t0, \case_id
+.endm
+
+.macro TEST_PSIMD_PAIR_RR_RD_RS2 case_id, insn, input1_lo, input1_hi, \
+                                  input2_lo, input2_hi, expected_lo, \
+                                  expected_hi
+    li      a2, \input1_lo
+    li      a3, \input1_hi
+    li      a4, \input2_lo
+    li      a5, \input2_hi
+    \insn   a4, a2, a4
+    li      t0, \expected_lo
+    PSIMD_FAIL_IF_NE a4, t0, \case_id
+    li      t0, \expected_hi
+    PSIMD_FAIL_IF_NE a5, t0, \case_id
+.endm
+
+.macro TEST_PSIMD_PAIR_RR_SET case_id, insn, input1_lo, input1_hi, \
+                               input2_lo, input2_hi, expected_lo, \
+                               expected_hi, zero_expected=-1
+    TEST_PSIMD_PAIR_RR \case_id, \insn, \input1_lo, \input1_hi, \
+                       \input2_lo, \input2_hi, \expected_lo, \expected_hi
+    TEST_PSIMD_PAIR_RR \case_id, \insn, 0, 0, 0, 0, \
+                       \zero_expected, \zero_expected
+    TEST_PSIMD_PAIR_RR_RD_RS1 \case_id, \insn, \input1_lo, \input1_hi, \
+                              \input2_lo, \input2_hi, \expected_lo, \
+                              \expected_hi
+    TEST_PSIMD_PAIR_RR_RD_RS2 \case_id, \insn, \input1_lo, \input1_hi, \
+                              \input2_lo, \input2_hi, \expected_lo, \
+                              \expected_hi
+.endm
+
+.macro TEST_PSIMD_PAIR_RR_VXSAT_STATE case_id, insn, input1_lo, input1_hi, \
+                                       input2_lo, input2_hi, expected_lo, \
+                                       expected_hi, initial_vxsat, \
+                                       expected_vxsat
+    li      t4, \initial_vxsat
+    csrw    vxsat, t4
+    li      a2, \input1_lo
+    li      a3, \input1_hi
+    li      a4, \input2_lo
+    li      a5, \input2_hi
+    \insn   a0, a2, a4
+    li      t0, \expected_lo
+    PSIMD_FAIL_IF_NE a0, t0, \case_id
+    li      t0, \expected_hi
+    PSIMD_FAIL_IF_NE a1, t0, \case_id
+    csrr    t4, vxsat
+    li      t5, \expected_vxsat
+    PSIMD_FAIL_IF_NE t4, t5, \case_id
+.endm
+
+.macro TEST_PSIMD_PAIR_SAT_RR_SET case_id, insn, normal1_lo, normal1_hi, \
+                                   normal2_lo, normal2_hi, normal_exp_lo, \
+                                   normal_exp_hi, sat1_1_lo, sat1_1_hi, \
+                                   sat1_2_lo, sat1_2_hi, sat1_exp_lo, \
+                                   sat1_exp_hi, sat2_1_lo, sat2_1_hi, \
+                                   sat2_2_lo, sat2_2_hi, sat2_exp_lo, \
+                                   sat2_exp_hi
+    TEST_PSIMD_PAIR_RR_VXSAT_STATE \case_id, \insn, \normal1_lo, \
+                                    \normal1_hi, \normal2_lo, \normal2_hi, \
+                                    \normal_exp_lo, \normal_exp_hi, 0, 0
+    TEST_PSIMD_PAIR_RR_VXSAT_STATE \case_id, \insn, \sat1_1_lo, \
+                                    \sat1_1_hi, \sat1_2_lo, \sat1_2_hi, \
+                                    \sat1_exp_lo, \sat1_exp_hi, 0, 1
+    TEST_PSIMD_PAIR_RR_VXSAT_STATE \case_id, \insn, \sat2_1_lo, \
+                                    \sat2_1_hi, \sat2_2_lo, \sat2_2_hi, \
+                                    \sat2_exp_lo, \sat2_exp_hi, 0, 1
+    TEST_PSIMD_PAIR_RR_VXSAT_STATE \case_id, \insn, 0, 0, 0, 0, \
+                                    0, 0, 1, 1
+    TEST_PSIMD_PAIR_RR_RD_RS1 \case_id, \insn, \normal1_lo, \normal1_hi, \
+                              \normal2_lo, \normal2_hi, \normal_exp_lo, \
+                              \normal_exp_hi
+    TEST_PSIMD_PAIR_RR_RD_RS2 \case_id, \insn, \normal1_lo, \normal1_hi, \
+                              \normal2_lo, \normal2_hi, \normal_exp_lo, \
+                              \normal_exp_hi
+.endm
diff --git a/tests/tcg/riscv32/Makefile.target b/tests/tcg/riscv32/Makefile.target
new file mode 100644
index 00000000000..8f25cfb906a
--- /dev/null
+++ b/tests/tcg/riscv32/Makefile.target
@@ -0,0 +1,30 @@
+# -*- Mode: makefile -*-
+# RISC-V specific tweaks
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+VPATH += $(SRC_PATH)/tests/tcg/riscv32
+VPATH += $(SRC_PATH)/tests/tcg/riscv
+
+# Export PSIMD_CC=/path/to/clang to enable these freestanding tests without
+# making the P-aware compiler the CC for every RISC-V TCG test.
+PSIMD_CFLAGS = --target=riscv32-unknown-linux-gnu \
+	-Wall -Werror -O0 -g -Wno-error=unused-command-line-argument \
+	-menable-experimental-extensions -march=rv32gp0p21 -mabi=ilp32
+PSIMD_LDFLAGS = -nostdlib -static -fuse-ld=lld -Wl,-e,_start
+
+ifneq ($(strip $(PSIMD_CC)),)
+TESTS += psimd-rv32
+endif
+
+psimd-rv32: psimd-rv32.S \
+	$(SRC_PATH)/tests/tcg/riscv/psimd-common.S \
+	$(SRC_PATH)/tests/tcg/riscv/psimd-test-macros.inc
+ifeq ($(strip $(PSIMD_CC)),)
+	$(error Set PSIMD_CC to a Clang with RISC-V P extension support)
+else
+	$(call quiet-command,$(PSIMD_CC) $(PSIMD_CFLAGS) -Wa$(COMMA)--noexecstack \
+		$< -o $@ $(PSIMD_LDFLAGS),CC,$@)
+endif
+
+run-psimd-rv32: QEMU_OPTS += \
+	-cpu rv32,x-p=true,zmmul=true,zba=true,zbb=true
diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefile.target
index 4da5b9a3b32..e6645487f56 100644
--- a/tests/tcg/riscv64/Makefile.target
+++ b/tests/tcg/riscv64/Makefile.target
@@ -2,9 +2,34 @@
 # RISC-V specific tweaks
 
 VPATH += $(SRC_PATH)/tests/tcg/riscv64
+VPATH += $(SRC_PATH)/tests/tcg/riscv
 TESTS += test-div
 TESTS += noexec
 
+# Export PSIMD_CC=/path/to/clang to enable these freestanding tests without
+# making the P-aware compiler the CC for every RISC-V TCG test.
+PSIMD_CFLAGS = --target=riscv64-unknown-linux-gnu \
+	-Wall -Werror -O0 -g -Wno-error=unused-command-line-argument \
+	-menable-experimental-extensions -march=rv64gp0p21 -mabi=lp64d
+PSIMD_LDFLAGS = -nostdlib -static -fuse-ld=lld -Wl,-e,_start
+
+ifneq ($(strip $(PSIMD_CC)),)
+TESTS += psimd-rv64
+endif
+
+psimd-rv64: psimd-rv64.S \
+	$(SRC_PATH)/tests/tcg/riscv/psimd-common.S \
+	$(SRC_PATH)/tests/tcg/riscv/psimd-test-macros.inc
+ifeq ($(strip $(PSIMD_CC)),)
+	$(error Set PSIMD_CC to a Clang with RISC-V P extension support)
+else
+	$(call quiet-command,$(PSIMD_CC) $(PSIMD_CFLAGS) -Wa$(COMMA)--noexecstack \
+		$< -o $@ $(PSIMD_LDFLAGS),CC,$@)
+endif
+
+run-psimd-rv64: QEMU_OPTS += \
+	-cpu rv64,x-p=true,zmmul=true,zba=true,zbb=true
+
 # Disable compressed instructions for test-noc
 TESTS += test-noc
 test-noc: LDFLAGS = -nostdlib -static
-- 
2.34.1


