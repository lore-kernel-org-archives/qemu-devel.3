Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10A7C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 18:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4j9x-0001VB-3e; Thu, 10 Sep 2026 14:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul@galbraiths.ca>)
 id 1x4j9v-0001V2-EF
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:06:03 -0400
Received: from fout-a4-smtp.messagingengine.com ([103.168.172.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul@galbraiths.ca>)
 id 1x4j9t-0004me-3W
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:06:03 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 3DF46EC00D7;
 Thu, 10 Sep 2026 14:06:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Thu, 10 Sep 2026 14:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=galbraiths.ca;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1789063560; x=
 1789149960; bh=0Chb1GhlqwwrLxWbiTKYGUCyiAM24N62kTTrQvbY4IA=; b=M
 F7ChOyzbZCkFlyq/G6gkfp3delm3610asAJKINHh58uhZCX4tagmIByIajgim4JE
 tBi3qbvrxSNOQgcRkIyqqbxi7xZXG5FpU50jB1YKrXyeShS3T7qLJSki3VxHEvfd
 9UPB6XlA0cUAinas10n0Y6gRyjTpcFBENVOwRdRcoaPIZkw9pMAmhzbvsaOKSUPx
 +YyDR4pZVpFYkceiVl88CVAkR6t+f7Tthp86kShPtcqrKEdFv4yCxPRWtp832E0O
 ryQXuyONUA5TJas2kb54bG4T1sU1I8gKo23GqpD3B8XUDdr26/iGAqCXDMMCssbE
 jXQqsZ5QgPw0m66zod/Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1789063560; x=1789149960; bh=0
 Chb1GhlqwwrLxWbiTKYGUCyiAM24N62kTTrQvbY4IA=; b=sdN0RHq/GpV41WMTJ
 eKBhZFVwviREfBL4+x5a3v8U+OhzxtClTbDt/gKSK5idbhue7vvy1xI013JuR13F
 n4Ru0HLkz2Q1DMv1XAklnGoEiHl8cfnKwk/124Mtz4jHOxU8IccfZ1Z3LtOEvJJh
 XHB44tyc/fdRP7+98WTBldY8cE1jUTtSsLEWS/bHdqO5i+tCC0hmTtKWTyLBKBG6
 hrRlppyPulAFeIWPsRFCtz013hGiSMjX7o1DiMiCCMf+qm2WUw5m+07Yz+KgUMld
 cv2ODXqLeEIpvZFZEbQTtS6nM7tfKzLQ8Erh2VE21QZ5lkOY7/9a5eF7JGFxCDVH
 dvv5g==
X-ME-Sender: <xms:iPGiahzUmR-OWiJDvBA_f3aLy0QDA41kHesvR5imDJ7jTEMoCmv6uQ>
 <xme:iPGiahb5cYXYCGN4f1JiImxyy46mb1ZY3J7hdrFEsLsvmAS2A9n49D8JvU8AxIutV
 obpc-7KnoKMi-pNg3QFUCp3D-LUvD-N7L22YyM6pLiqoKdZ9bRNtopB>
X-ME-Received: <xmr:iPGiajTca1kRn2OVmyBNCnaT-pVLE4aLzqHzAZGqpQm5rnDtQRR96k_p57cwtwyTQU7UeD2sPAxGqEwj86Q>
X-ME-Proxy-Cause: dmFkZTFaar76tTIYgHXolqzS3zATiHsR+TE1QmJTugsE2y5nX3By6I4RPdLsnlSvgB3Zrb
 ghC7et9zNCNSKNL8yXuDDZyDi1rAm/1ETzx1V5dS7MUC/ui23q2083BcjM6tnZxdmJNZnt
 Lp0QRzW7Xp7n/RmcqfmGBijaEixPBjmAM2Xrc1b5rt5942/Crk9sOrYVCJpShLkA9gg//3
 ObIGpnBAnPuZ3Gn64YxZHmvbcAwgtNlmDb3q/X1mMZHv/PNIwnkv3MD3unfMAst//1wgs7
 zUSJD5ghZ8geVn+Vtla6pf/w10sdbxHxbv7vAaUZQ7yRHiSojhawxcOEn4zLRoMAZuJLdJ
 u3gEf++nDUAJoXvhOZoMWzOwKcw5s50N//4g3X9vFJcmiMT0LNoPwg1apwr/rynw+fMn6c
 35O09Lkdd/9lNC4IH16yI87chzDuHqWKT8AW2Fd9nF1P1XBoCM/WARFq4kBdrnhfSf2X4p
 WVkjOdLpTwBVwj9qEp7mhKJ+tOwrV3uZERYiqjMwa/ARWEl50FJ0F5AfUNyI9ooQNPlCt6
 FzXZiZQilwAAup88X0MdyRf7wC+lhwTLHGE0jkUrUc3srzYDC9p/V9wPf25s6pkbl29OWh
 0M1fMUEatvO4EmTmHNcqOLOAGDDNm+op1sPYVI+aFVjRFlrM+Y8cvE5kf7Dw
X-ME-Proxy: <xmx:iPGiarw64nXly1dXOe5j0A7eE-jnMNF1JvDmWR6pTWo5Txl37kbi-g>
 <xmx:iPGiat33UQ1RfVugbiC6W0euK2SlH29aQqXM4EC77qgCJkdp51GLJg>
 <xmx:iPGiah4lc0_efG8iFaMc3Ct1M6ApKWonhYmmlcUoZGjIWarkv98SHA>
 <xmx:iPGiaoX3SDDgbtwinNBHH7YYcqGEZXCvpQK4pIOPIvuKvPgmGMMadg>
 <xmx:iPGiak1qaPYMm3rE3vMEnyXrHxit66tlgaxJUsYnZFzSqIRFTDvh4JjV>
Feedback-ID: i00314697:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 14:05:59 -0400 (EDT)
From: Paul Galbraith <paul@galbraiths.ca>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paul Galbraith <paul@galbraiths.ca>
Subject: [PATCH v2 2/2] tests/tcg/i386: add regression test for wrapping
 16-bit near branches
Date: Thu, 10 Sep 2026 14:05:16 -0400
Message-ID: <20260910180517.97-2-paul@galbraiths.ca>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20260910180517.97-1-paul@galbraiths.ca>
References: <20260910180517.97-1-paul@galbraiths.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.147; envelope-from=paul@galbraiths.ca;
 helo=fout-a4-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Run the same JMP rel16 from two sites 48 bytes apart in a 16-bit code
segment, both wrapping EIP through 0xFFFF. One has its translation block
start on a different guest page from the untruncated target, and was
truncated even before the fix; the other starts on the same page, and
was not.

The segment base is deliberately not page aligned. With an aligned base
the wrap always crosses a page boundary in the linear address as well,
and the case cannot be reached.

This is on the CF_PCREL path, which is system mode, so the test does not
live next to tests/tcg/i386/test-i386-code16.S. Wire it up in
tests/tcg/i386/system/meson.build the same way x86_64's patch-target.c
is.

Signed-off-by: Paul Galbraith <paul@galbraiths.ca>
---
v1: https://patchew.org/QEMU/6c5fca8e-b9f4-48a0-a070-42f10d1f942b@app.fastmail.com/

Changes in v2:
 - Split out of the fix patch.
 - Moved from tests/tcg/i386/Makefile.softmmu-target to
   tests/tcg/i386/system/meson.build, following the tcg tests meson rework.
 - Otherwise the same test with the same geometry. Opcode, prefix and geometry
   constants are named now rather than bare hex, and the two far jumps take the
   selector and target IP as immediate operands from those defines instead of
   repeating the literals.
 - Added an SPDX-License-Identifier and a comment on the volatile, per
   checkpatch.

 tests/tcg/i386/system/meson.build          |   7 +
 tests/tcg/i386/system/test-branch-wrap16.c | 224 +++++++++++++++++++++
 2 files changed, 231 insertions(+)
 create mode 100644 tests/tcg/i386/system/test-branch-wrap16.c

diff --git a/tests/tcg/i386/system/meson.build b/tests/tcg/i386/system/meson.build
index d3f73997c7..136662db35 100644
--- a/tests/tcg/i386/system/meson.build
+++ b/tests/tcg/i386/system/meson.build
@@ -34,6 +34,13 @@ foreach t: tcg_tests['multiarch-softmmu']['tests']
   endforeach
 endforeach
 
+tests += {
+  'test-branch-wrap16.c': {
+    'cflags': cflags,
+    'qemu_args': qemu_def_args,
+  }
+}
+
 if 'qemu-system-i386' in emulators
   tcg_tests += {
     'i386-softmmu': {
diff --git a/tests/tcg/i386/system/test-branch-wrap16.c b/tests/tcg/i386/system/test-branch-wrap16.c
new file mode 100644
index 0000000000..7a6596bd98
--- /dev/null
+++ b/tests/tcg/i386/system/test-branch-wrap16.c
@@ -0,0 +1,224 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * A 16-bit near branch must truncate EIP to 16 bits.
+ *
+ * Two branches wrap EIP through 0xFFFF, from sites 48 bytes apart:
+ *
+ *   A  Control.  Its untruncated target is on another page, so the
+ *      truncation was never skipped.
+ *   B  Its untruncated target shares a page with the branch, which is
+ *      where the truncation used to be skipped.  Reaching that needs a
+ *      segment base which is not page aligned; with an aligned base the
+ *      wrap always crosses a page in the linear address as well.
+ *
+ * The truncation is only skipped on the CF_PCREL path, so this is a
+ * system-mode test rather than a linux-user one alongside
+ * tests/tcg/i386/test-i386-code16.S.
+ *
+ * Each branch lands on a hand-encoded stub that records where it arrived
+ * and far-jumps back to 32-bit code.  The stubs store through DS, which
+ * stays the flat data segment throughout.
+ */
+
+#include <stdint.h>
+#include <minilib.h>
+
+struct gdt_desc {
+    uint16_t limit_lo;
+    uint16_t base_lo;
+    uint8_t  base_mid;
+    uint8_t  access;
+    uint8_t  limit_hi_flags;
+    uint8_t  base_hi;
+};
+
+struct gdtr {
+    uint16_t limit;
+    uint32_t base;
+} __attribute__((packed));
+
+/*
+ * Selectors 0x08/0x10 must describe exactly the same flat code/data
+ * segments boot.S already loaded into CS/DS/ES/SS/FS/GS: those registers
+ * are never reloaded here, so their cached (shadow) descriptor state has
+ * to remain valid against this replacement table.
+ */
+#define SEL_CODE32 0x08
+#define SEL_DATA32 0x10
+#define SEL_CODE16 0x18
+
+static struct gdt_desc test_gdt[4];
+static struct gdtr test_gdtr;
+
+static void set_desc(struct gdt_desc *d, uint32_t base, uint32_t limit,
+                      uint8_t access, uint8_t gran)
+{
+    d->limit_lo = limit & 0xffff;
+    d->base_lo = base & 0xffff;
+    d->base_mid = (base >> 16) & 0xff;
+    d->access = access;
+    d->limit_hi_flags = ((limit >> 16) & 0x0f) | (gran & 0xf0);
+    d->base_hi = (base >> 24) & 0xff;
+}
+
+/*
+ * Cases A and B run here.  main() rounds the start up to a page boundary,
+ * which is what the spare page is for, and puts cs_base 0x10 bytes past
+ * it.  The geometry below depends on that offset.
+ *
+ * Round up at runtime rather than aligning the array: boot.S's multiboot
+ * header uses the AOUT kludge, which needs one constant file-offset to
+ * load-address mapping for the whole image, and a 64 KiB-aligned .bss
+ * object widens that segment's file alignment and corrupts the load.
+ *
+ * boot.S sets up no paging, so linear == physical and a pointer into the
+ * array is usable as a linear address.
+ *
+ * ARENA_SIZE is that spare page plus 0x11000, the span above base that has
+ * to be real memory: the last byte written is the end of the stub at
+ * ARENA_OFF(TARGET_IP + EIP_WRAP), at 0x1003F, rounded up to a whole page.
+ * Most of that span sits past the 16-bit segment's 64 KiB limit, so
+ * hardware could never reach it, but the untruncated jump has to land on
+ * something and record that it did, or the defect would show up as a fault
+ * rather than as the wrong marker.
+ */
+#define ARENA_SIZE (0x11000 + 0x1000)
+static uint8_t arena[ARENA_SIZE] __attribute__((aligned(16)));
+
+/*
+ * Geometry, with base = page-aligned-up(arena) and cs_base = base + 0x10.
+ * Both branches target IP 0x0020, and both wrap to EIP 0x10020, which is
+ * linear base+0x10030 if left untruncated.
+ *
+ *   A  IP 0xFFC0, linear base+0xFFD0, page base+0xF000.  The untruncated
+ *      target is on page base+0x10000, so EIP was always truncated.
+ *   B  IP 0xFFF0, linear base+0x10000, page base+0x10000.  Same page as
+ *      the untruncated target, so the truncation used to be skipped.
+ */
+#define BRANCH_A_IP 0xFFC0u
+#define BRANCH_B_IP 0xFFF0u
+#define TARGET_IP   0x0020u
+/* EIP wraps here: a 16-bit near branch keeps only the low 16 bits */
+#define EIP_WRAP    0x10000u
+/* cs_base sits this far into the page, which is what leaves it unaligned */
+#define CS_BASE_OFF 0x10u
+#define ARENA_OFF(ip) (CS_BASE_OFF + (ip))
+
+static uint8_t *base;
+
+/* rel16 for "jmp" (3-byte instruction), measured from the next IP */
+#define A_REL ((uint16_t)((EIP_WRAP + TARGET_IP) - (BRANCH_A_IP + 3u)))
+#define B_REL ((uint16_t)((EIP_WRAP + TARGET_IP) - (BRANCH_B_IP + 3u)))
+
+#define RESULT_NONE  0u
+#define RESULT_RIGHT 1u
+#define RESULT_WRONG 2u
+/*
+ * Written by the landing stubs, which are hand-assembled bytes the compiler
+ * cannot see, so it must not cache the value across the far jumps below.
+ */
+static volatile uint32_t g_result;
+
+/* machine instruction codes */
+#define PFX_ADDR32      0x67    /* address-size override */
+#define PFX_OPSIZE      0x66    /* operand-size override */
+#define OP_JMP_REL16    0xE9
+#define OP_JMP_FAR      0xEA    /* ptr16:16, or ptr16:32 with PFX_OPSIZE */
+#define OP_MOV_RM8_IMM8 0xC6
+#define MODRM_DISP32    0x05    /* mod=00 r/m=101: disp32, no base */
+
+static void write_branch(uint32_t off, uint16_t rel)
+{
+    base[off + 0] = OP_JMP_REL16;
+    base[off + 1] = rel & 0xff;
+    base[off + 2] = (rel >> 8) & 0xff;
+}
+
+/*
+ * A landing stub: "mov byte [addr32], marker" (address-size override,
+ * since the default in a 16-bit code segment is 16-bit addressing) then
+ * a far jump back to 32-bit flat code ("data32 ljmp $sel, $off32").
+ */
+static void write_stub(uint32_t off, uint8_t marker, uint32_t ret_addr)
+{
+    uint32_t addr = (uint32_t)&g_result;
+    uint8_t *p = &base[off];
+    int i = 0;
+
+    p[i++] = PFX_ADDR32;
+    p[i++] = OP_MOV_RM8_IMM8;
+    p[i++] = MODRM_DISP32;
+    p[i++] = addr & 0xff;
+    p[i++] = (addr >> 8) & 0xff;
+    p[i++] = (addr >> 16) & 0xff;
+    p[i++] = (addr >> 24) & 0xff;
+    p[i++] = marker;
+
+    p[i++] = PFX_OPSIZE;
+    p[i++] = OP_JMP_FAR;
+    p[i++] = ret_addr & 0xff;
+    p[i++] = (ret_addr >> 8) & 0xff;
+    p[i++] = (ret_addr >> 16) & 0xff;
+    p[i++] = (ret_addr >> 24) & 0xff;
+    p[i++] = SEL_CODE32 & 0xff;
+    p[i++] = (SEL_CODE32 >> 8) & 0xff;
+}
+
+static void write_stubs(uint32_t ret_addr)
+{
+    write_stub(ARENA_OFF(TARGET_IP), RESULT_RIGHT, ret_addr);
+    write_stub(ARENA_OFF(TARGET_IP + EIP_WRAP), RESULT_WRONG, ret_addr);
+}
+
+int main(void)
+{
+    uint32_t cs_base;
+
+    base = (uint8_t *)(((uint32_t)arena + 0xFFFu) & ~0xFFFu);
+    cs_base = (uint32_t)base + CS_BASE_OFF;
+
+    /* entries 0/1/2 mirror boot.S's null/code32/data32 descriptors */
+    set_desc(&test_gdt[0], 0, 0, 0, 0);
+    set_desc(&test_gdt[1], 0, 0xFFFFF, 0x9b, 0xC0);
+    set_desc(&test_gdt[2], 0, 0xFFFFF, 0x93, 0xC0);
+    /* a genuine 16-bit code segment: G=0, D/B=0, byte-granular 64K limit */
+    set_desc(&test_gdt[3], cs_base, 0xFFFF, 0x9b, 0x00);
+
+    test_gdtr.limit = sizeof(test_gdt) - 1;
+    test_gdtr.base = (uint32_t)&test_gdt;
+
+    write_branch(ARENA_OFF(BRANCH_A_IP), A_REL);
+    write_branch(ARENA_OFF(BRANCH_B_IP), B_REL);
+
+    asm volatile("lgdt %0" : : "m"(test_gdtr) : "memory");
+
+    /* -- A: control. Must already pass before the fix. -- */
+    write_stubs((uint32_t)&&L_return_a);
+    g_result = RESULT_NONE;
+    asm volatile("ljmpl $%c0, $%c1"
+                 : : "i"(SEL_CODE16), "i"(BRANCH_A_IP) : "memory");
+L_return_a:
+    if (g_result != RESULT_RIGHT) {
+        ml_printf("FAIL: control branch A landed wrong (result=%d)\n",
+                   (int)g_result);
+        return 1;
+    }
+    ml_printf("A (control, different page): landed correctly\n");
+
+    /* -- B: the regression check. -- */
+    write_stubs((uint32_t)&&L_return_b);
+    g_result = RESULT_NONE;
+    asm volatile("ljmpl $%c0, $%c1"
+                 : : "i"(SEL_CODE16), "i"(BRANCH_B_IP) : "memory");
+L_return_b:
+    if (g_result != RESULT_RIGHT) {
+        ml_printf("FAIL: branch wraparound left EIP untruncated "
+                   "(result=%d)\n", (int)g_result);
+        return 1;
+    }
+    ml_printf("B (same page as unwrapped target): landed correctly\n");
+
+    ml_printf("PASS\n");
+    return 0;
+}
-- 
2.54.0.windows.1


