Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EB0606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NZmy65ve
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQmf0-0000W2-2T; Tue, 10 Nov 2026 09:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <w1355457260@gmail.com>)
 id 1xQioG-0007Hq-4x
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 05:10:36 -0500
Received: from mail-lr2-x0a.google.com ([2a00:1450:4864:38::a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <w1355457260@gmail.com>)
 id 1xQioE-0006Cz-AA
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 05:10:35 -0500
Received: by mail-lr2-x0a.google.com with SMTP id
 38308e7fff4ca-3ad85432c52so13707141fa.1
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 02:10:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794305432; cv=none;
 d=google.com; s=arc-20260327;
 b=XAwkFoNXSf8ShOTYL0zxUBlKLKApal5b0lYwIrRLpGjOXEaT6iZamleyKrpO2P1A6m
 UFV92YYB45NwmzA+WMXPI+9jiUC6vC7UFDffhHfNz5AfTV0AZh2DYGfgENM9bnQzpChe
 r36kgp6I2br3QRbzX791qOnF2X7tTa0UpKYounC5d12SDcRrck2FLtLdCaqWZlqE8oCw
 uN3DQ5OGQA3PSQ/FKYnB1sopEex7U7OQq6uVE9hzl9n759BzGuSastazBg16/jlp3IyM
 rfbkJFF3NCk1HBqakiG8lM86dnZPaTS0L1xMZ82pyWXD8YYuhhpUHHuxXgR6qkqZ9sNO
 fLZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=1DKRrOztf8FbTnPvV+acV/pVjpX0NzCPLgLYB/f5Aa0=;
 fh=qUOFTwWG+G+YmxTz+HxoQUPJX6AFWbaPYrnquSe1BBk=;
 b=nSom2IL2gU9zGJNjJ9HrGO3loNHD3hp1iN06nqOtXdERoE/OLaI9JRT4w9rXTbPdeS
 y/9OGiroa/aS93ciGYzJmKGJ0Q1i5A+v6aZV0Y+/OA7qClGlToUdkRGXUcVMwgjvv6JO
 /0zVN1UuJzAlc0euxawlSib0BwWg4FVefJkzSmYpui+dT5zdi8mbegi9bAxfQhoCuIQ/
 WA+3qJSlVjDXUhP4SXp/bKyoULBdctJ159ILw0N5FdNGVnICuLVvwkIIRchxDIrGmxVO
 nFr67haBBwCKlzVqqY4jmFMxfN36zLzY+OkRZQbl7CwYQdvz+K7jsox4pFiER0BcU/ab
 evRw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794305432; x=1794910232; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1DKRrOztf8FbTnPvV+acV/pVjpX0NzCPLgLYB/f5Aa0=;
 b=NZmy65venisRq3Hz3qhXobvcB18Ao+e66e3+h4ZH7HZMpAQjUvp3nsO2Zhm78WuKAr
 O95XzfGAZW4t2jr7SKMpYiHJvH47XlegtUuBiob1uva4NQCRK5tb2STUW+fUlyJk5IUq
 8wquLitgHzoAunUG+ptHD1Sbh4v7Zlh/BEnmflbu8lAjjHt9B2lcUHxeGnoBbXF/zP4w
 9Jy6AQsVArrzlB+mRiwD9Plss5iYcPGlY6MGW3amQgoOoXE3vKxnh+tGphJ8tqFH0oPX
 ZwyZw8oLh/T7szl8m8Zttmd2asET2LiVQHTNh0hTh2GIwKyBpCTq5LZ+FfPfCR/mmUNI
 guFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794305432; x=1794910232;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1DKRrOztf8FbTnPvV+acV/pVjpX0NzCPLgLYB/f5Aa0=;
 b=JikTmBN0g72e94OVTLhR91iBlH4Asbp5dUML/p1TeAZTkOuFdxBYdfecdEZ/7Szi3e
 Dj4xRbe8UEQdqoOgSEh0ktLKC+1stImykkjFg5avmSmqhZCTrNulmpZte/9ZUdXaXFA1
 Q7JlIH6EAh1lJHizSKah6ecwL4We/zRcqguBmgzxters10YJrkG6PV+uj3TjQM13qLBB
 N0o6cA7zc1qZ4HobSuV+5FerMR7yAMoVmbailrCsDn/nPFYm44n0Jsmb8uqtKVCyPLZr
 AWEwXy9yPhdpT+vC+09rNsrgqhKNwSDbHpCz9hpgvu6/k+24W+3oNNQS58p03LtLv+f+
 HBSw==
X-Gm-Message-State: APuU4Z+5SE9FZTslQY/YjEAoyAFGhySCyERZYRcwkYiRut8PGjX4fjkJ
 0/Tt6RV5eaWLL5J8v7S+XR7m5lb/mRzmEqrwut7AecwltYY4S7R4XGfjBVBWergzv4WMBGEkREs
 9XGq4S4bxyJfH8PYznP/wCG1fLeFT5F48JNpdWV+yue+9S1U=
X-Gm-Gg: AYBFou3H+BZ124gJAABLR+xVYB+pRmDu0+39j8+OfH+Qk7svJIz1GpSLTWl6K3qTdbq
 dQ/DCOesH6IQB2xjIqVBA5TFQlr3wiVCq941LnIz87i3tDllfo360eoLho1j0LEctv/P3YOr03j
 wVPaaYrVLzh9IZ8KFJmGvIPqCsh0VKc6Z3EgJqorQLI3SckD9RsHwZQ6LlpQN6eDrEnJqsD93kG
 eSn1Y/FEFjWJiaHqGcCwXbsiS1BE74hUx9yWKVd9+dqqPszRIDTo/x6Z7onEsIMPaPtDd9kbk/j
 f7H3CkFvgzbKshoU/MhOIgyZ+KmvviKQP3dfELSJkgoMHXXZGQYFlzsIkR9igGGy399DfR8oVrz
 +5eZAuWz9agZabScvoXeZp/1D6ARvJhmlX0tp
X-Received: by 2002:a2e:bc93:0:b0:3a9:811d:3a58 with SMTP id
 38308e7fff4ca-3ae09631263mr3936611fa.14.1794305431608; Tue, 10 Nov 2026
 02:10:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: z Y <w1355457260@gmail.com>
Date: Tue, 10 Nov 2026 18:10:19 +0800
X-Gm-Features: AclHuK_Cs61vrsrbUvT97TcbxYVnTLj7gbZ0oZCsAOE6a6jL2bJF-sf9JvLAwWU
Message-ID: <CABG6VKODisrETOuH5thhimg_DtJLH+1wmARKL5OsoND5Qse_TA@mail.gmail.com>
Subject: [PATCH] target/i386/tcg: treat ENTER's size operand as unsigned
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:38::a;
 envelope-from=w1355457260@gmail.com; helo=mail-lr2-x0a.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 10 Nov 2026 09:17:10 -0500
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The first immediate operand of ENTER is the size of the dynamic storage
area and is unsigned.  Decoding it as a signed immediate sign-extends
values with bit 15 set, moving the stack pointer in the wrong direction.

Decode it with I_unsigned and add a regression test covering 32-bit and
64-bit guests.

Tested with a minimal x86_64-linux-user build; the new test fails before
the change and passes after it.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4643
Signed-off-by: Zixin Wang <w1355457260@gmail.com>
---
 target/i386/tcg/decode-new.c.inc |  2 +-
 tests/tcg/i386/meson.build       |  1 +
 tests/tcg/i386/test-i386-enter.c | 42 ++++++++++++++++++++++++++++++++
 tests/tcg/x86_64/meson.build     |  1 +
 4 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/i386/test-i386-enter.c

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index aa22014..c0ceefb 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1968,7 +1968,7 @@ static const X86OpEntry opcodes_root[256] = {
     [0xBE] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),
     [0xBF] = X86_OP_ENTRYwr(MOV, LoBits,v, I,v),

-    [0xC8] = X86_OP_ENTRYrr(ENTER, I,w, I,b),
+    [0xC8] = X86_OP_ENTRYrr(ENTER, I_unsigned, w, I, b),
     [0xC9] = X86_OP_ENTRY0(LEAVE),
     [0xCA] = X86_OP_ENTRYr(RETF,  I,w),
     [0xCB] = X86_OP_ENTRY0(RETF),
diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
index 648b516..ebe2e6a 100644
--- a/tests/tcg/i386/meson.build
+++ b/tests/tcg/i386/meson.build
@@ -36,6 +36,7 @@ tests += {
                '-lm', '-fno-pie', '-Wl,--no-warn-rwx-segments'],
   },
   'test-idiv-overflow.c': {},
+  'test-i386-enter.c': {'cflags': ['-O2', '-fomit-frame-pointer']},
   '../multiarch/sha512.c': {
      'exe_name': 'sha512-sse',
      'cflags': ['-msse4.1', '-O3'],
diff --git a/tests/tcg/i386/test-i386-enter.c b/tests/tcg/i386/test-i386-enter.c
new file mode 100644
index 0000000..509740d
--- /dev/null
+++ b/tests/tcg/i386/test-i386-enter.c
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * ENTER's 16-bit size operand is unsigned.  If the decoder sign-extends
+ * it, the stack pointer moves in the wrong direction.
+ */
+#include <stdio.h>
+
+static int check_enter(void)
+{
+    unsigned long before, after;
+
+#ifdef __x86_64__
+    __asm__ volatile(
+        "movq %%rsp, %0\n\t"
+        "enter $0x8000, $0\n\t"
+        "movq %%rsp, %1\n\t"
+        "leave\n\t"
+        : "=r"(before), "=r"(after)
+        :
+        : "memory");
+    return (before - after) == 0x8008 ? 0 : 1;
+#else
+    __asm__ volatile(
+        "movl %%esp, %0\n\t"
+        "enter $0x8000, $0\n\t"
+        "movl %%esp, %1\n\t"
+        "leave\n\t"
+        : "=r"(before), "=r"(after)
+        :
+        : "memory");
+    return (before - after) == 0x8004 ? 0 : 1;
+#endif
+}
+
+int main(void)
+{
+    if (check_enter()) {
+        printf("FAIL: ENTER treated the 16-bit size operand as signed\n");
+        return 1;
+    }
+    return 0;
+}
diff --git a/tests/tcg/x86_64/meson.build b/tests/tcg/x86_64/meson.build
index fc7f48e..9e34a39 100644
--- a/tests/tcg/x86_64/meson.build
+++ b/tests/tcg/x86_64/meson.build
@@ -49,6 +49,7 @@ tests += {
   '../i386/test-i386-adcox.c': {'cflags': ['-O2']},
   '../i386/test-i386-bmi2.c': {'cflags': ['-O2', '-fwrapv']},
   '../i386/test-idiv-overflow.c': {},
+  '../i386/test-i386-enter.c': {'cflags': ['-O2', '-fomit-frame-pointer']},
 }

 tests += {
-- 
2.56.0

