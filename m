Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38F8C98324
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 03:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAJ1E-00082t-28; Fri, 25 Sep 2026 23:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul@galbraiths.ca>)
 id 1xAJ1C-00082W-8v
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 23:24:06 -0400
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul@galbraiths.ca>)
 id 1xAJ1A-0000AN-G7
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 23:24:06 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 8CDEE1D00071;
 Fri, 25 Sep 2026 23:24:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Fri, 25 Sep 2026 23:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=galbraiths.ca;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1790393043; x=
 1790479443; bh=UiROjTviiSwdRAUeTrROxyenRNPGultVEh2ZzybIzPs=; b=S
 zJma5QlN1sStYOEHcBIgMl7Wrqb4ixy7GZib2zBP1k4tqloZzhBqUJ+z2v5heq+I
 DD9XodSvnnjAp7lYOU4at/DNG/jg3SYH/IL/YIMZfioXO8iFMRbpLXh4VmjLzGAv
 sVE0AsHhu7ZIev9P1yTebfESdSIP1TmopGfhVYGetDjguOmtN65zzZhqDoLysXBr
 owMM22YjTbyiyGocP6TrhYWZnYih1U9jNQS/SXLiibBuTYITNcn78WMvZ2cD/pQo
 /LmhOgqQmxLyKXhjhJ1RV2KKtjGqQp0Sbdg36+TgufWEx2tRWW//uuTLMDmONody
 Egl0AajYBstcylR0k4dpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1790393043; x=1790479443; bh=U
 iROjTviiSwdRAUeTrROxyenRNPGultVEh2ZzybIzPs=; b=P+olfjwG5RxOG4nUq
 rxa2vMXr0Po1PU4AoLUZXcdcLMMdhkVtIf2z0VZ29PKyeyxD7J9nHK/k2M71D/Nr
 hzHpyLIIJvFg74q2z9fS83oQ2Q4ygpYbpDlGN+PqMfekr9aGlUSTN4F/p1HudGYG
 cpm0rNtLbm5ERbSeCBK+4Lf+yVPo4rwskd1yTznJ6vrm4CTFanWs3jpQIt/ZJVH0
 5/K6pvGERVsJlH2slICH6RtYkoEi0S//GizZKaVAnA94wzJLv4uBHtGFS4UH3ZmK
 ftr3GaQaOc9t5O0YpCyvG4awQBNp/z/4SOemyKT2BQ/KGr1OXKMQ34teHEd0iXOb
 CrKuA==
X-ME-Sender: <xms:0zq3alCjUZdc4J0Q3acHCenAlT5Fz6ezkihXkNJR61IcfAVVSJw40g>
 <xme:0zq3ajrqzb7PnonmkspGHlEQeVcqn_ka6i42cjI5yzpSVGmAk1w3G7hp2tq0eHERd
 5VbIoTUUcb8ebvHFtNF6_s8Tf-jOpMphOEUdZDtuy8WZmV6GuUsJ8M>
X-ME-Received: <xmr:0zq3aojgZ-Xvxg_yV-ACtjWTBRx7CL0nWDZ5UBBsFWiKSGYejYz-xnjrB6DrN1Dct0_3OU7Pm36j76FMoylz>
X-ME-Proxy-Cause: dmFkZTEgfWq44un7oqbbc2cSBXVU9dUWrYd6s7OzGzXYSaviivPuhgIsDL6v/GSXMMoPj0
 506Z7ollbyjn15YT0z4R+mLfmdARf21h5/3FOiSHbXu3uMS7KRTgun9Xl7yq01PdX4Aoml
 NIuSIJF0CpvA6B/Znp3hvZ1uDkNhz3WOn54yjNig/Oxj5duuxPaYcfk+kAvStGrQJ3L1jS
 Ra6wUB9RqvNdqESUZ8O1ZPstDYOeXtwH/dHhn9qvIBTncyq3ETqEgkwOpk8VQl0YX0+vjL
 crw5ppkmSAFpsHyYe95iFJSz0KIMfhWNUfLVAKO5h4yPhcbFOl+B0kvn5ryXzDB5Ru+zQq
 KKK05MmjxuXaZqK8A+LeflQ7/02ZWJl96yAv8yJNbz4CL6gU1d34dozAv4vE58QbRTppKd
 +967EMXmojo4gZr/9ilkmyeIMr6WLcQ2/kRzvTdiCLybZI4GIwg/zT+WFCace7RmoarcKI
 ciN92yvhyiG1VczRcNuTss87zNnXPCXvFeOkEoZIY58Kmnw0mNQOj2NZCm6qiW2XGNNanZ
 Ujq9dQl3cjyS2X1mUqKmYoM0GqSOD48qG7S4lX+wjwOrTV2HPVOYxIdrRYpWBE3OQ0jk4I
 v2ti8PlL79uTJXZDwql6U5/G+hh4F8wlVmIShrkWiDeS7uoIq7WZV0LgNxeQ
X-ME-Proxy: <xmx:0zq3aoCKg1GWeT4x4raIMle1zAOzJi0ZWma_VqwO1HOX8-DNDLmuRQ>
 <xmx:0zq3alEGW_9KP5LuSGYcu_Nz7_wxjIA7IQTbjQcgsfGD98WbjxwoPA>
 <xmx:0zq3aoKEOmvCVCPhxmlbBm3pIwnMelU9Yhryg_99ddRt4HOuaYfbXA>
 <xmx:0zq3ahltEMyQrM_ZzuMUyc_WV2vJYN0M_gbHqtg_niGikyH1dJRhBQ>
 <xmx:0zq3apQ-OhT-r8ymZFW5wfNLDtoQdZ_J2V3t1b6_DACosgB-D8N8MW19>
Feedback-ID: i00314697:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 23:24:02 -0400 (EDT)
From: Paul Galbraith <paul@galbraiths.ca>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 Paul Galbraith <paul@galbraiths.ca>
Subject: [PATCH v3 2/2] tests/tcg/i386: add regression test for wrapping
 16-bit near branches
Date: Fri, 25 Sep 2026 23:23:36 -0400
Message-ID: <20260926032336.933-3-paul@galbraiths.ca>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20260926032336.933-1-paul@galbraiths.ca>
References: <20260926032336.933-1-paul@galbraiths.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.149; envelope-from=paul@galbraiths.ca;
 helo=fout-b6-smtp.messagingengine.com
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

Jump from IP 0xFFF0 to IP 0x0020 with a CS base that is not page
aligned, and check that EIP wraps.

Signed-off-by: Paul Galbraith <paul@galbraiths.ca>
---
 tests/tcg/i386/system/meson.build          |   7 ++
 tests/tcg/i386/system/test-branch-wrap16.S | 118 +++++++++++++++++++++
 2 files changed, 125 insertions(+)
 create mode 100644 tests/tcg/i386/system/test-branch-wrap16.S

diff --git a/tests/tcg/i386/system/meson.build b/tests/tcg/i386/system/meson.build
index d3f73997c7..d831f7e9c1 100644
--- a/tests/tcg/i386/system/meson.build
+++ b/tests/tcg/i386/system/meson.build
@@ -34,6 +34,13 @@ foreach t: tcg_tests['multiarch-softmmu']['tests']
   endforeach
 endforeach
 
+tests += {
+  'test-branch-wrap16.S': {
+    'cflags': cflags,
+    'qemu_args': qemu_def_args,
+  }
+}
+
 if 'qemu-system-i386' in emulators
   tcg_tests += {
     'i386-softmmu': {
diff --git a/tests/tcg/i386/system/test-branch-wrap16.S b/tests/tcg/i386/system/test-branch-wrap16.S
new file mode 100644
index 0000000000..2520891ba7
--- /dev/null
+++ b/tests/tcg/i386/system/test-branch-wrap16.S
@@ -0,0 +1,118 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * A 16-bit near branch must truncate EIP to 16 bits.
+ *
+ * The test jumps from IP 0xFFF0 to IP 0x0020 in 16-bit code. The jump
+ * crosses 0xFFFF. For correct 16-bit behaviour the CPU should wrap the
+ * target to 0x0020, rather than branching to 0x10020.
+ *
+ * TCG used to skip the wrap when the untruncated target (CS base +
+ * 0x10020) was on the same guest page as the jump. That only happens
+ * when the CS base is not page aligned, so the code segment starts at
+ * a page boundary plus 0x10.
+ */
+
+#define SEL_CODE32   0x08
+#define SEL_CODE16   0x18
+
+#define RESULT_NONE  0
+#define RESULT_PASS  1
+#define RESULT_FAIL  2
+
+/*
+ * 16-bit relative 'jmp target', hand-assembled because clang rejects a
+ * rel16 displacement outside [-0x8000, 0x7FFF]. But, in 16-bit code, any
+ * 16-bit displacement is valid. GAS correctly accepts any 16-bit offset.
+ */
+.macro jmp_rel16 target
+        .byte 0xE9                              /* jmp rel16 opcode */
+        .word ((\target) - (. + 2)) & 0xFFFF    /* cw: 16-bit offset */
+.endm
+
+        .data
+
+g_result:
+        .long RESULT_NONE
+
+/* 0x08 and 0x10 must match boot.S, which loaded the data selectors */
+gdt16:
+        .quad 0
+        .word 0xFFFF, 0
+        .byte 0, 0x9b, 0xCF, 0
+        .word 0xFFFF, 0
+        .byte 0, 0x93, 0xCF, 0
+gdt16_code16:
+        /* 16-bit code, 64 KiB limit; main fills in the base */
+        .word 0xFFFF, 0
+        .byte 0, 0x9b, 0x00, 0
+gdt16_end:
+
+gdtr16:
+        .word gdt16_end - gdt16 - 1
+        .long gdt16
+
+fail_msg:
+        .asciz "FAIL: branch left EIP untruncated (result=%d)\n"
+pass_msg:
+        .asciz "PASS\n"
+
+        /*
+         * Page aligned plus 0x10. A larger alignment breaks the
+         * multiboot load in boot.S.
+         */
+        .balign 0x1000
+        .skip 0x10
+wrap16_cs_base:
+        .code16
+
+        /* jmp lands here when EIP wraps to 0x0020 */
+        .org wrap16_cs_base + 0x0020
+wrap16_target:
+        movl $g_result, %eax
+        movb $RESULT_PASS, (%eax)
+        ljmpl $SEL_CODE32, $wrap16_back
+
+        .org wrap16_cs_base + 0xFFF0
+        /* the problematic branch, which should wrap EIP */
+        jmp_rel16 wrap16_target
+
+        /* jmp lands here when EIP does not wrap (0x10020) */
+        .org wrap16_cs_base + 0x10020
+        movl $g_result, %eax
+        movb $RESULT_FAIL, (%eax)
+        ljmpl $SEL_CODE32, $wrap16_back
+
+        .code32
+
+        .text
+
+wrap16_run:
+        ljmp $SEL_CODE16, $0xFFF0
+wrap16_back:
+        ret
+
+        .globl main
+main:
+        movl $wrap16_cs_base, %eax
+        movw %ax, gdt16_code16 + 2
+        shrl $16, %eax
+        movb %al, gdt16_code16 + 4
+        movb %ah, gdt16_code16 + 7
+        lgdt gdtr16
+
+        call wrap16_run
+        cmpl $RESULT_PASS, g_result
+        jne test_failed
+        pushl $pass_msg         /* test passed */
+        call ml_printf
+        addl $4, %esp
+        xorl %eax, %eax
+        ret
+test_failed:
+        pushl g_result
+        pushl $fail_msg
+        call ml_printf
+        addl $8, %esp
+        movl $1, %eax
+        ret
-- 
2.55.0.windows.3


