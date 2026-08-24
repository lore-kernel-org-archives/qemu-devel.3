Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45294C5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 04:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyMDx-0002Mn-4R; Mon, 24 Aug 2026 00:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul@galbraiths.ca>)
 id 1wyJrJ-0001mj-OI
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 21:52:21 -0400
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul@galbraiths.ca>)
 id 1wyJrG-0003e2-H0
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 21:52:21 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id CC0321D000B1;
 Sun, 23 Aug 2026 21:52:15 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
 by phl-compute-05.internal (MEProxy); Sun, 23 Aug 2026 21:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=galbraiths.ca;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm1; t=1787536335; x=
 1787622735; bh=Qmvf/tGpQZUaSiov1+0rrvF0rRq0a2scYST/ZZULc44=; b=U
 mvxSXG0qNa3jkDLquHqW30PjpbfQwSZrLfG4VR8V/d0RdCFbbuUsuoR5ubxWMfHY
 ZBrdnPyFTk/ZSBE+gno+r0KuXaHoUY95BIi4Z95ipdrhmXklatNdIuC5FY4/GwK9
 9qoPJf8nflx8Ik31ijcW4NlHpKb1FFzxtQWPMGr6d0N6YTCaurzrF1xY6yZO/Cy1
 FB+FrShPg0Jzmmd/0GBZ7rggamSw9mqAxuOopLUxKrwsucdqtNCXQS3xCbhVuQIX
 2tHG2hpoqNc7R3Q7wlBSssZbsIEBIImp1zH602T/XNmyF94EaQW1P6p2m9q3+mg3
 8+mdD++nIzhSdrT4QKSXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1787536335; x=1787622735; bh=Qmvf/tGpQZUaSiov1+0rrvF0rRq0
 a2scYST/ZZULc44=; b=Nr7KQDjndJym05xzn7hwSKXPfu4PjBCs7DNTBZWdz44W
 64afpKk14IDfE70AnzrZuWe7cDL0Op2rWYCrzrMwAxS1txlqVg6MKbxDLzdkTt2n
 QV0Zd6sEygih0RQlHFI0AAiPB6maaX3QU7CaTiFrOJeOcGIcE5yAv05QCZbKDd2X
 3pqsYyK3F/ckLES5vn8gpACfJ4lCseUDCSuJy7BiB5Tnro/gTMftWWriGuciDKh2
 Qvr/tKSTY+GmfG0QYWh3iY/jzZF1RVM8jCORPRPJTXzGyx6qiDbRpOC21O8gjfGC
 oSz/YEnTLO79DGE2Ti7+0tFHW6VKe1f6SqJTSItP5A==
X-ME-Sender: <xms:z6OLaoSToqT_ZPE-35EhqvpSnMc5vR_9DF7mOIfrvQOA3YH65dsCxg>
 <xme:z6OLagk7AHvciecDGbc7iimr-0qxKrTg-MAQsh_ldE4fqWwWBOK8Y_wV1DZT0VQDf
 wOxh7Hi7b_dCZ5A3ClD7C-OImTtlQhzJCgzrlH7H0IxK4W8eskLLUbN>
X-ME-Proxy-Cause: dmFkZTEsBIqZZ1ywhTrvY828ki12pKRHgXaPL0OeH9M0oln0QFVaUr8xZ9htVimOH3V+e9
 3MNqwSq1Wnz5ihpnptX4S8HAJcqpxn7TQGMXb+7Kwrd7bHHgaVOKiRDSDddRRLKsg+fe61
 LLkRw+0CD+zzi4Yr+q57ybESkPUL0azx6VyG9Z/rqCcXPWri8+pWbAn8RDGRd+nwGgupEQ
 QPuTnCulFliGIjYPWKt5P7MsUQ/wLHG5LKPorh04nZ4bp6gMFkV+U25ApyMIQasWJtf3/E
 pwuW7bOP2soOEIz56fnF40nUC6S2HmD6prN0czCLH26rBUBf2bJGoKLM+/j/DBmpZCUio2
 fgapL9fowyOeVUjb/Xv9tWhB4KxBBZckb1KWBEAX5QUDf1OFbk0G/r+OvMQUtlvrYOqUdn
 +WBpiH1Nh2x8rdaK9WI+jwNhRxmLMtcdU7rW54ghva8q2C9LAiHd3EnvL3/gd8GFGegUGT
 9bGnhv7rb+3/828p/tU5mErb6c3yxo5gwPJWI9/F9xOdVm/VuahcvEHkR8YbHsZfen4DcX
 Jo8w6QB8Hq1coat8RhWr1YH1MEBUj1+p+r930KiUbWuEKIz2+MCus/ccf7lR4xQg4/VPKY
 ixYXRePcJ0TMpsyMoOT68Y9VaI9rOw92vMAAC1mXimZF4hX/xS4CNzQqL70Q
X-ME-Proxy: <xmx:z6OLasyhZM0dpP17D2TgTDZpbFvg005aM6CsIKFDdgW2pS3_RWZF9g>
 <xmx:z6OLansjGJ9i5mSRrNbjphVieHb3C5qioMetdjJHyK95jKcR5UHkUQ>
 <xmx:z6OLarulCQEdoBRt_ypyYoddrMzSCxXcwJfNonl8Eh4de1tTmlq8qQ>
 <xmx:z6OLakMWMPc8mafT1Y29i12Y99ifKZ6DN26-KUSsIyDAUsY9mG0uiw>
 <xmx:z6OLagJ9EVt4mPRLeCq0c2fm-rFqX1-VvKpCT-144tFiDYd_RcZAkc32>
Feedback-ID: i00314697:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 5272E2400098; Sun, 23 Aug 2026 21:52:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Sun, 23 Aug 2026 21:51:54 -0400
From: "Paul Galbraith" <paul@galbraiths.ca>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org
Message-Id: <6c5fca8e-b9f4-48a0-a070-42f10d1f942b@app.fastmail.com>
Subject: [PATCH] target/i386/tcg: fix EIP truncation for wrapping 16-bit near
 branches
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=202.12.124.149; envelope-from=paul@galbraiths.ca;
 helo=fout-b6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 24 Aug 2026 00:23:48 -0400
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

gen_jmp_rel() decided whether goto_tb chaining was safe by checking if
the branch target's *linear* address stayed on the same guest page as
the translation block, then treated that as proof the EIP addition
could not wrap. For a 16-bit branch (MO_16) that reasoning does not
hold: the wrap boundary is at 0x10000 in EIP, not in the linear
address, so two linear addresses can share a page while the
corresponding EIP values straddle 0x10000. On the CF_PCREL path this
let a wrapping CALL/JMP rel16 execute with EIP left at its raw,
untruncated value whenever the unwrapped target happened to land on
the same page as the branch itself.

Require additionally that cs_base be page aligned before allowing
goto_tb: then the EIP wrap boundary (mask + 1) maps to a page-aligned
linear address, crossing it would cross a page boundary, and the
same-page test genuinely excludes the wrap. A translation-time check
of the computed EIP would not be sound here, because a CF_PCREL TB is
matched by physical address and cs_base -- not virtual PC -- and may
later run at a different linear address, shifting EIP by a multiple
of the page size; the alignment of cs_base, by contrast, is part of
the TB key and stable across reuse. This also subsumes the previous
CODE32-only special case, which forced chaining off unconditionally
for every data16 branch in a 32-bit segment. 64-bit mode is unchanged
(cs_base is 0 there).

Adds a regression test that installs a 16-bit code segment at a
deliberately non-page-aligned base and runs the same wrapping jmp
rel16 from two sites 48 bytes apart -- one whose translation block
starts on a different page than the unwrapped target (must already
pass) and one on the same page (where the defect manifested).

Signed-off-by: Paul Galbraith <paul@galbraiths.ca>
---
 target/i386/tcg/translate.c                |  18 +-
 tests/tcg/i386/Makefile.softmmu-target     |   6 +-
 tests/tcg/i386/system/test-branch-wrap16.c | 221 +++++++++++++++++++++
 3 files changed, 237 insertions(+), 8 deletions(-)
 create mode 100644 tests/tcg/i386/system/test-branch-wrap16.c

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 2115c5cd24..c9755d28dd 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2027,9 +2027,6 @@ static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num)
     if (!CODE64(s)) {
         if (ot == MO_16) {
             mask = 0xffff;
-            if (tb_cflags(s->base.tb) & CF_PCREL && CODE32(s)) {
-                use_goto_tb = false;
-            }
         } else {
             mask = 0xffffffff;
         }
@@ -2039,11 +2036,18 @@ static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num)
     if (tb_cflags(s->base.tb) & CF_PCREL) {
         tcg_gen_addi_tl(cpu_eip, cpu_eip, new_pc - s->pc_save);
         /*
-         * If we can prove the branch does not leave the page and we have
-         * no extra masking to apply (data16 branch in code32, see above),
-         * then we have also proven that the addition does not wrap.
+         * The same-page test proves that the addition does not wrap EIP
+         * only if the wrap boundary (mask + 1) corresponds to a
+         * page-aligned linear address, i.e. only if cs_base is page
+         * aligned: then crossing the boundary would cross a page
+         * boundary, which the test excludes.  This must not be relaxed
+         * to a translation-time check of EIP itself, because a CF_PCREL
+         * TB may later run at a different linear address, shifting EIP
+         * by a multiple of the page size.
          */
-        if (!use_goto_tb || !translator_is_same_page(&s->base, new_pc)) {
+        if (!use_goto_tb
+            || (s->cs_base & ~TARGET_PAGE_MASK) != 0
+            || !translator_is_same_page(&s->base, new_pc)) {
             tcg_gen_andi_tl(cpu_eip, cpu_eip, mask);
             use_goto_tb = false;
         }
diff --git a/tests/tcg/i386/Makefile.softmmu-target b/tests/tcg/i386/Makefile.softmmu-target
index 4096a1cf31..16d3473fb6 100644
--- a/tests/tcg/i386/Makefile.softmmu-target
+++ b/tests/tcg/i386/Makefile.softmmu-target
@@ -18,7 +18,11 @@ LDFLAGS=-Wl,-T$(LINK_SCRIPT) -Wl,-melf_i386
 CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
 LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 
-TESTS+=$(MULTIARCH_TESTS)
+I386_SYSTEM_TEST_SRCS=$(wildcard $(I386_SYSTEM_SRC)/*.c)
+I386_SYSTEM_TESTS=$(patsubst $(I386_SYSTEM_SRC)/%.c,%,$(I386_SYSTEM_TEST_SRCS))
+VPATH+=$(I386_SYSTEM_SRC)
+
+TESTS+=$(MULTIARCH_TESTS) $(I386_SYSTEM_TESTS)
 EXTRA_RUNS+=$(MULTIARCH_RUNS)
 
 # building head blobs
diff --git a/tests/tcg/i386/system/test-branch-wrap16.c b/tests/tcg/i386/system/test-branch-wrap16.c
new file mode 100644
index 0000000000..76839895f8
--- /dev/null
+++ b/tests/tcg/i386/system/test-branch-wrap16.c
@@ -0,0 +1,221 @@
+/*
+ * Regression test: a 16-bit near JMP rel16 whose target wraps EIP through
+ * 0xFFFF must land at the truncated target, not at the unwrapped one.
+ *
+ * gen_jmp_rel() in target/i386/tcg/translate.c decides whether it is safe
+ * to chain translation blocks (goto_tb) by checking whether the *linear*
+ * address of the branch target lands on the same guest page as the start
+ * of the current translation block. For a 16-bit branch (MO_16) the wrap
+ * boundary is at 0x10000 in EIP, not in the linear address, so passing
+ * that same-page test does not prove the EIP addition did not wrap: two
+ * linear addresses can share a page while the corresponding EIP values
+ * straddle 0x10000. When that happens on the CF_PCREL path (system-mode
+ * TCG, i.e. here, not linux-user, which is why this is not alongside
+ * test-i386-code16.S) the masking AND is skipped and EIP is left with
+ * the raw, unwrapped, out-of-range value.
+ *
+ * This only shows up for a branch site whose *own* linear address and
+ * whose *unwrapped* target's linear address fall on the same page, which
+ * additionally requires cs_base not to be 4 KiB-aligned (with an aligned
+ * cs_base the 0x10000 wrap in EIP always coincides with a page boundary
+ * in the linear address, and the same-page test can never be fooled).
+ *
+ * The test below runs the identical wrapping JMP rel16 from two sites 48
+ * bytes apart in a purpose-built 16-bit code segment:
+ *
+ *   A (control): TB starts on a different page than the unwrapped target
+ *                -> masked correctly even before the fix -> must pass.
+ *   B (regression check): TB starts on the SAME page as the unwrapped
+ *                target -> this is exactly where the defect manifested.
+ *
+ * Both land on a small hand-encoded stub that records where it arrived
+ * (via a 32-bit-addressed store, using DS which is still the flat data
+ * segment throughout) and far-jumps back into 32-bit code to report it.
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
+ * A page (4 KiB) of headroom, rounded up to at runtime, so that
+ * cs_base = page_base(arena) + 0x10 is guaranteed NOT 4 KiB-aligned
+ * (cs_base & 0xfff == 0x10) while every other bit of cs_base's low 16
+ * bits is otherwise known exactly relative to a 4 KiB page boundary.
+ * That is what makes the branch-site/target page relationship below
+ * fall out of plain arithmetic instead of luck.
+ *
+ * This is computed at runtime rather than via an
+ * __attribute__((aligned(0x10000))) buffer deliberately: boot.S's
+ * multiboot header uses the AOUT-kludge (flags bit 0x10000), which
+ * assumes a single constant "file offset -> load address" mapping
+ * across the whole image. A 64 KiB-aligned .bss object makes the
+ * linker widen that segment's own file alignment past 4 KiB, which
+ * breaks that assumption and corrupts the load. Ordinary alignment on
+ * the buffer plus a runtime round-up avoids perturbing the segment
+ * layout entirely.
+ *
+ * No paging is set up by boot.S, so linear == physical here and a
+ * pointer into arena is directly usable as a linear address.
+ */
+#define ARENA_SIZE (0x11000 + 0x1000)
+static uint8_t arena[ARENA_SIZE] __attribute__((aligned(16)));
+
+/*
+ * Geometry (base = page-aligned-up(arena), cs_base = base + 0x10):
+ *
+ *   branch A  at IP 0xFFC0 -> linear base+0xFFD0, page base+0xF000
+ *   branch B  at IP 0xFFF0 -> linear base+0x10000, page base+0x10000
+ *   both target IP 0x0020  -> linear base+0x10030 (masked, correct)
+ *   unwrapped EIP for both is 0x10020 -> linear base+0x10030 (untruncated)
+ *
+ * A: unwrapped target's page (base+0x10000) differs from A's own TB
+ *    page (base+0xF000) -> gen_jmp_rel() emits the AND -> correct.
+ * B: unwrapped target's page (base+0x10000) is the SAME as B's own TB
+ *    page (base+0x10000) -> the AND used to be skipped -> defect.
+ */
+#define BRANCH_A_IP 0xFFC0u
+#define BRANCH_B_IP 0xFFF0u
+#define TARGET_IP   0x0020u
+#define ARENA_OFF(ip) (0x10u + (ip))
+
+static uint8_t *base;
+
+/* rel16 for "jmp" (3-byte instruction), measured from the next IP */
+#define A_REL ((uint16_t)((0x10000u + TARGET_IP) - (BRANCH_A_IP + 3u)))
+#define B_REL ((uint16_t)((0x10000u + TARGET_IP) - (BRANCH_B_IP + 3u)))
+
+#define RESULT_NONE  0u
+#define RESULT_RIGHT 1u
+#define RESULT_WRONG 2u
+static volatile uint32_t g_result;
+
+static void write_branch(uint32_t off, uint16_t rel)
+{
+    base[off + 0] = 0xE9;              /* jmp rel16 */
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
+    p[i++] = 0x67;                      /* address-size override */
+    p[i++] = 0xC6;                      /* MOV r/m8, imm8 */
+    p[i++] = 0x05;                      /* modrm: disp32, no base */
+    p[i++] = addr & 0xff;
+    p[i++] = (addr >> 8) & 0xff;
+    p[i++] = (addr >> 16) & 0xff;
+    p[i++] = (addr >> 24) & 0xff;
+    p[i++] = marker;
+
+    p[i++] = 0x66;                      /* operand-size override */
+    p[i++] = 0xEA;                      /* JMP ptr16:32 (direct far jump) */
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
+    write_stub(ARENA_OFF(TARGET_IP + 0x10000u), RESULT_WRONG, ret_addr);
+}
+
+int main(void)
+{
+    uint32_t cs_base;
+
+    base = (uint8_t *)(((uint32_t)arena + 0xFFFu) & ~0xFFFu);
+    cs_base = (uint32_t)base + 0x10;
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
+    asm volatile("ljmpl $0x18, $0xFFC0" : : : "memory");
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
+    asm volatile("ljmpl $0x18, $0xFFF0" : : : "memory");
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
2.55.0.windows.3

