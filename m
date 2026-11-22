Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73C3606A32A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jkCDGkf8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xV7io-0006Im-Nz; Sun, 22 Nov 2026 08:35:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vladimir.chebotarev@gmail.com>)
 id 1xV2DQ-0004cA-Lg
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 02:42:24 -0500
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vladimir.chebotarev@gmail.com>)
 id 1xV2DO-0007oe-Up
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 02:42:24 -0500
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-9213eb1f3a7so17979946d6.0
 for <qemu-devel@nongnu.org>; Sat, 21 Nov 2026 23:42:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795333341; cv=none;
 d=google.com; s=arc-20260327;
 b=jk3xZq+sKfvS3GnGnr7lkIRmmRk+N7jk/fJhmQ4WIaOPzBhdgmJ+zNf2oSot3s9JHc
 8waDXmmLGvpE96TXW4emrxRxDFDVR1cFDhGFGka419pc9GoCA5bEAfb1VjAM+NyWl2kr
 cG5532TEiIDtnQgtxM7fsOTynD4M45+uK/Q6Qnv6AbE/vCF/aKFeHXksjt37cymRQPeF
 4cds4a0JNl8TaWYJNZ6X7CAFPLc1Mmbin1oBHISpzd7P/JfxKF/McM3QMRWCosuwwztN
 ZD2ynsp9HvGR7HCWIqNq3ltf/Td1rMwnSEpk0sjfMRtww2EvjTZ+URD5yVL5hnWwNxH2
 lDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=Ovcai4p3EzWQTLJ1c/mwYJgWYew4qeLuSR3fqyo+Fm8=;
 fh=yGWAaXXYYQtYW+LCE7nyqmcq5QIuKbScqyYf4NVD8c4=;
 b=RMoCe1vxCIGCELzgUyN10htZ3JEjxStRjlGk8JvLDRuZfWJ6VxnPX8CKL8qwfQ4ngO
 8gQoAa6jvOJ8GPkzd37MWBarh7br7o61shrZHdnVpCsa4wnf2kHIfOtd4e/B9TgfQ9H2
 cIVAosVliTih6J1Lor/lapHIGcXz4mj1T3E87eV6LZDw+DGeOWFY2SO0T/XidPE7Bp9e
 4u3AQE09ffgMjL6Kk7Bp6kbBEmPYKce+cX1utoEgUeY+k1x1ywF+3J8R70z4QgSXBiVC
 u9vRqq8fty+z51mxKJEQdCSvshnCdzY8cW2QkUY7B/qNoEv9L3a7IKntebVXsdk9m82+
 UVRg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795333341; x=1795938141; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ovcai4p3EzWQTLJ1c/mwYJgWYew4qeLuSR3fqyo+Fm8=;
 b=jkCDGkf8nTVKM9FtYMIQCLT0FyVkIUwlaouXK4mObl3+Vgx03iyBanwiKjZbjuziG6
 NId7G6APbROFs1ME8VH5euwNIwr0DjXI/+myoGB0aYblg8pwlqCTIrn/60yxHwzzVJEP
 8jDeu9xx3159LFaMb3RcDKHORWm2LMUTfmTiFX5BXvJFWS+/x8ledZlu03PYDghhbXcG
 lWCbBaE7SFIxIUV3fpcTC/XcwTnD6z/md9tHLBJxxPo39/p5PrB4G2vaP3M+5cyvgEvy
 2E1t9xp3zEiEfagyCkzHe+EhSiz0if+8jiVFpcHfgiC9jiOcuvfJxyGGpogbGennz6P0
 vr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795333341; x=1795938141;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ovcai4p3EzWQTLJ1c/mwYJgWYew4qeLuSR3fqyo+Fm8=;
 b=LE0O/FrHxspxGgvMrvnhlBLTUhCbfE1FLm4hxi9sFL4SEEfGgjOtfQjDS5oYH323lD
 JkquHIgOWK1R1z5yhK+kC8iFGuU3a9eDMOBeSATsxjDLpNWXcP493BzO1iMIIAyp7cCl
 US1s+ECTP2lu9wZlpq2DK+3xGv3h45MJ4Dsv1uv1fRFLnbqUYVfyIvMnmKmHVQX4qzic
 XTZJhzYds0kHAgEuFw05iOuGAW5kK/bD7xOMRm0tWzGmz8II5Tbx2eXxDjmuiRoTAxTK
 nMjzbi+/bHbOAUwREv/evn8qiAvZ/O8xLeLuJBMMUoaUfGxXEA/P86tGajK31YevrbYM
 uIiA==
X-Gm-Message-State: APuU4Z8Kla5Imdm+6MdAq2mPkS71Q4z/cTC/cOP2aUdNb2jmJwUv1srD
 Nlx9rYgGREKuF51BgfnPs7gpoMiYc8BO0AgV2z8kYFqEeNlMRppZVqoKgG7pc4460PN6ooS78G0
 VuAeq5dDZaUpe1/jQclIVcOyNBKiGhsm3yPZY
X-Gm-Gg: AZFdTZfVAmWJnnUpyoZi2NTl9XQfIw+NSWI2yw1N8vFVOEF5UCpooinRfWh85cp8mYe
 zMZ7Xc9JgVNZESThHw2bFtLD/AftjVg2/blHkGLOBAasMj92KhgPSbqUgAcSTG4YY90z1kwYq90
 2FslVGYJuZrJI4hClU5Ts3DQdG30Vx5w15OvtD1KTESaSrPMNnlI0gthb8Z4Qj6VsD6tMRWc/5F
 cxIJlKpOSIiWpRZ8GWOZiLbYwer1QuFkWn8f6P49pzspZxJxQINXrvDZD05p9IYzgq0FXdkKSbD
 N5pDwb8ilvX61cXe/+ynp+psfdM8byOWELr8iacHOCijmYBsWGwgm/Gg1ol9iExMu2soVuz5YDA
 lyUvg4ZoPu4xwSttGLIU9G3VHiJObx4LSTQmgXLByiCYRnqyb89DdmTUJlbiLChR89X/Z8g==
X-Received: by 2002:a05:6214:528a:b0:91c:72e2:3106 with SMTP id
 6a1803df08f44-92134b8fcabmr137404026d6.49.1795333340598; Sat, 21 Nov 2026
 23:42:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Vladimir Chebotarev <vladimir.chebotarev@gmail.com>
Date: Sun, 22 Nov 2026 10:42:07 +0300
X-Gm-Features: Aa3M54r7XxapgqYwFn63-QoiciB1MVDCLGVc8YGyz3rdaFMpBlR0U0Uf5qBh5ag
Message-ID: <CAHuqkx3+hxQ=moJxw0Ke+xYNt-NQWJ1OOeU4yKW8S526ouJHkA@mail.gmail.com>
Subject: [PATCH] target/i386: fix cross-page access bounds check
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=vladimir.chebotarev@gmail.com; helo=mail-qv1-xf2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 22 Nov 2026 08:35:05 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix an unsigned bounds-check underflow that corrupts x87 loads
crossing page boundaries. Add a regression test for the split-page
access.

Tests: i386-softmmu-x87-page-cross
Signed-off-by: Vladimir Chebotarev <vladimir.chebotarev@gmail.com>
---
Regarding #4682, I have a reproducer: on Windows NT 3.1 with Visual
C++ 1.5, an array of 17 structs, each containing six consecutive
double values, produces a garbled value in the 17th struct; adding an
L suffix changes the arena layout and masks the failure.

 target/i386/tcg/access.c               |  4 +-
 tests/tcg/i386/system/meson.build      |  3 +-
 tests/tcg/i386/system/x87-page-cross.S | 82 ++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/i386/system/x87-page-cross.S

diff --git a/target/i386/tcg/access.c b/target/i386/tcg/access.c
index 97e3f0e756..832c96ac4a 100644
--- a/target/i386/tcg/access.c
+++ b/target/i386/tcg/access.c
@@ -65,10 +65,10 @@ static void *access_ptr(X86Access *ac, vaddr addr,
unsigned len)
     }

 #ifdef CONFIG_USER_ONLY
-    assert(offset <= ac->size1 - len);
+    assert(offset <= ac->size1 && len <= ac->size1 - offset);
     return ac->haddr1 + offset;
 #else
-    if (likely(offset <= ac->size1 - len)) {
+    if (likely(offset <= ac->size1 && len <= ac->size1 - offset)) {
         return ac->haddr1 + offset;
     }
     assert(offset <= ac->size - len);
diff --git a/tests/tcg/i386/system/meson.build
b/tests/tcg/i386/system/meson.build
index 44e86a12cd..de8a1e1ad2 100644
--- a/tests/tcg/i386/system/meson.build
+++ b/tests/tcg/i386/system/meson.build
@@ -35,7 +35,8 @@ foreach t: tcg_tests['multiarch-softmmu']['tests']
 endforeach

 tests += {
-  'wraparound.S': { 'cflags': cflags, 'qemu_args': ['-m', '4G'] +
qemu_def_args }
+  'wraparound.S': { 'cflags': cflags, 'qemu_args': ['-m', '4G'] +
qemu_def_args },
+  'x87-page-cross.S': { 'cflags': cflags, 'qemu_args': ['-m', '16M']
+ qemu_def_args }
 }

 if 'qemu-system-i386' in emulators
diff --git a/tests/tcg/i386/system/x87-page-cross.S
b/tests/tcg/i386/system/x87-page-cross.S
new file mode 100644
index 0000000000..fe21e73628
--- /dev/null
+++ b/tests/tcg/i386/system/x87-page-cross.S
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Regression test for an x87 80-bit load that crosses a guest page.
+ *
+ * The two virtual pages are deliberately mapped to non-adjacent physical
+ * pages.  This prevents X86Access from treating the host pointers as one
+ * contiguous range and exercises the split-access fallback in access_ptr().
+ */
+
+        .code32
+        .section .text
+
+.globl  main
+main:
+        /*
+         * Build an identity map for the first 4 MiB and a separate mapping
+         * for 0x400000..0x401fff:
+         *
+         *   0x400000 -> 0x00300000
+         *   0x401000 -> 0x00500000
+         *
+         * The test value starts at virtual address 0x400ffc.
+         */
+        xorl    %eax, %eax
+        movl    $0x200000, %edi
+        movl    $3072, %ecx
+        rep
+        stosl
+
+        movl    $0x201000, %edi
+        movl    $0x00000003, %eax
+        movl    $1024, %ecx
+.Lfill_identity:
+        stosl
+        addl    $0x1000, %eax
+        loop    .Lfill_identity
+
+        movl    $0x00201003, 0x200000
+        movl    $0x00202003, 0x200004
+        movl    $0x00300003, 0x202000
+        movl    $0x00500003, 0x202004
+
+        /* Expected x87 value: significand 0xc000000012345678, exp 0x3fff. */
+        movl    $0x12345678, 0x00300ffc
+        movl    $0xc0000000, 0x00500000
+        movw    $0x3fff, 0x00500004
+
+        /* Bytes read past physical page 0x00300000 must not be used. */
+        movl    $0x80000000, 0x00301000
+
+        movl    $0x00200000, %eax
+        movl    %eax, %cr3
+
+        movl    %cr0, %eax
+        orl     $0x80000000, %eax
+        movl    %eax, %cr0
+
+        fninit
+        fldt    0x400ffc
+        fstpt   result
+
+        movl    result, %eax
+        cmpl    $0x12345678, %eax
+        jne     .Lfail
+        movl    result + 4, %eax
+        cmpl    $0xc0000000, %eax
+        jne     .Lfail
+        movzwl  result + 8, %eax
+        cmpl    $0x3fff, %eax
+        jne     .Lfail
+
+        xorl    %eax, %eax
+        ret
+
+.Lfail:
+        movl    $1, %eax
+        ret
+
+        .section .bss
+        .align  4
+result:
+        .space  10
--
2.47.1

