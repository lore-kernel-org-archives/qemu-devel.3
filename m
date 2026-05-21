Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9638ECD5BB0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 18:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ8Kz-0007Ky-6O; Thu, 21 May 2026 14:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wQ8Km-0007IU-QK
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:41:29 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wQ8Kl-0006rF-5v
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:41:28 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-7bd4c61765dso62818807b3.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 11:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779388886; x=1779993686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6MyzE0NxWiTgF4RZxrRNtyNcw0btq7zIh3/U7cTycDI=;
 b=KdbIUUus8hXp+wbdmSR6s90hes/w6RKsB7OKRkVzZQvTZ/joTdJCdc5krt054eVknm
 FLdiglrbF3Lt3/b934Ytj02elI0gKEKJw7qekasr+Wb1aTjJv4+85+29eoBqHBqMiRFN
 +hSuLtrXRY1OLkJ+GlfR3aVkUtirPo0dacNkNYEdMr9TpDmATleHdC+w+tjrse9O28wD
 XdbntOWbX1YleA6P/sfCXiyokso6HHc7AUiWko1eq/zn4a0hiTBHy3ZtrXRi8hoRQQHl
 G7N0qFn0wel9mZFCyTD82GiQx7C0x3iF7pDPv8RbYORRAqloiesUAG39s7zZVsdt/Pz+
 Pz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779388886; x=1779993686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6MyzE0NxWiTgF4RZxrRNtyNcw0btq7zIh3/U7cTycDI=;
 b=NUmB0OMY81Hnf0yli/0uVPsM7215C3uBFSPHOmY6QQeMt+pcWIHGBHxvEA/ha4fEa9
 EC0UIqjrfxPz44Di/q8acsM6zVnO9/PoYD/MLOeQHsjFQhU0r9Cga//JVRibAk3BXjFD
 +JKBfyxV0CwIiWLiACnQy9+O5QgqeGqoxV5HZna2AeX7vVXMLZ4S8lsU6C59akyjlNVH
 fYa5ke3T8gUN0jR6C2R4RnUucCJjb4zCSp+UTEwRCTmq6mxrPV8N1N44M4O37KEn0riF
 lvD6L25WETBCsin45YeuczpqKEmER1tbuUGA+mf8w86HhP0Kfm3XD4Ix/fiUGrleBeTw
 ysDg==
X-Gm-Message-State: AOJu0YzX4DgGdYayI5bb5bK3pymx3lhrcSZJ8VouQEpc6vNb4LuN806Y
 r6xx4uVt+TZd3/GM/Br28enqh+j1TXritQwIaKqJwNtlpdtc+n6gJXgcUPrbLXco
X-Gm-Gg: Acq92OHcga9Qr+rIb2OVS9U8X9NmFM26F6zw5wusyDC3tSiRQXvFT6qtrnOq9wG8gvR
 jd3O0Ba0fv6Bj8vPZBoGgiFSkEthvwjMJmK3eRuKHNU8qJkvnVgZsh18xPfOAe6/43y18GIT2H8
 Hv/JNlJGg1qhO4jOLuI5zUkLeUx0ZAQHaVBIfRT0GMYUKlKk8vLXIjXUEJQuG/aZN0VSGBaqRuU
 C2lxzdfBF0SkP648SoPmE1ob1OYloFsX2mlnLpZFSKSjkrVQTwz1LUKSKzJv56pspRYOQQVkwDq
 H0PboYyDua092Z91E0vkiuucbHXhOwhLK/w/PnkK+xpEmnlTNiSmVQG3eKBXQuJDz1kSpkGp/UT
 SKBVI5CWJIdir7iokqSBa9mUy5aaCbj5YEbYAF4tF1y7JNsjv2rzzmUZ+vTXphwLlNFMHe9nu2L
 uj54qzPzMe0xPzxUQVFWTIcwLpwJcqFpMkAtJgkyfFAsvyKDmxSghXwiD5qp0j36yVgPBQ4cEJD
 9E=
X-Received: by 2002:a05:690c:a94:b0:7b8:f152:7545 with SMTP id
 00721157ae682-7d333bd83f2mr6964727b3.9.1779388885903; 
 Thu, 21 May 2026 11:41:25 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7d2cb16ef60sm6548137b3.49.2026.05.21.11.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:41:25 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Matt Turner <mattst88@gmail.com>,
 qemu-stable@nongnu.org
Subject: [PATCH 2/3] linux-user/mips64: fix mipsn32 elf_core_copy_regs entry
 width
Date: Thu, 21 May 2026 14:41:02 -0400
Message-ID: <20260521184119.1631958-2-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521184119.1631958-1-mattst88@gmail.com>
References: <20260521184119.1631958-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

For mipsn32 (TARGET_ABI32=y, TARGET_LONG_BITS=64):
  abi_ulong = uint32_t (4 bytes) — for pointers and ABI-sized fields
  target_ulong = uint64_t (8 bytes) — for general-purpose registers

linux-user/elfload.c allocates target_elf_prstatus using the
mips64/target_elf.h definition where target_elf_gregset_t has
target_ulong reserved[45] (8 bytes each, 360 bytes total).

However, in linux-user/mips64/elfload.c, #include "target_elf.h" inside
the included mips/elfload.c resolves to mips/target_elf.h (compiler
searches the file's own directory first), where the union uses abi_ulong
reserved[45].  For mipsn32 this gives 4-byte entries (180 bytes), not
the 8-byte entries (360 bytes) that elfload.c actually allocated.

Writing via r->reserved[34] therefore lands at byte offset 34*4=136
instead of the correct 34*8=272, silently zeroing the EPC in the core
file.

Fix by casting the pointer to target_ulong * so writes always use 8-byte
slots and land at the offsets matching the allocated layout.

This does not change behavior for mips64 (N64) where abi_ulong already
equals target_ulong (both 8 bytes).

Signed-off-by: Matt Turner <mattst88@gmail.com>
Cc: qemu-stable@nongnu.org
---
v2: Use tswap32/tswap64 instead of tswapl

 linux-user/mips64/elfload.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git ./linux-user/mips64/elfload.c ./linux-user/mips64/elfload.c
index 9081ae8111..e4d84a7bd6 100644
--- ./linux-user/mips64/elfload.c
+++ ./linux-user/mips64/elfload.c
@@ -15,16 +15,31 @@
  */
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
 {
-    /* R0 is always 0; r->reserved is zero-initialised by the caller */
+    /*
+     * linux-user/elfload.c allocates target_elf_prstatus using the
+     * definition from mips64/target_elf.h, where target_elf_gregset_t
+     * has target_ulong reserved[45] (8 bytes each = 360 bytes total).
+     *
+     * But in this compilation unit, "#include target_elf.h" resolved to
+     * mips/target_elf.h (wrong directory), so our local target_elf_gregset_t
+     * has abi_ulong reserved[45] which is only 4 bytes each for mipsn32.
+     * Using r->reserved[i] would write to the wrong offsets for mipsn32.
+     *
+     * Cast to target_ulong * to always write 8-byte entries at the correct
+     * positions, matching the layout that elfload.c allocated.
+     */
+    target_ulong *regs = (target_ulong *)r;
+
+    /* R0 is always 0; buffer is zero-initialised by the caller */
     for (int i = 1; i < 32; i++) {
-        r->reserved[i] = tswap64(env->active_tc.gpr[i]);
+        regs[i] = tswap64(env->active_tc.gpr[i]);
     }
-    r->reserved[26] = 0;   /* k0 */
-    r->reserved[27] = 0;   /* k1 */
-    r->reserved[32] = tswap64(env->active_tc.LO[0]);
-    r->reserved[33] = tswap64(env->active_tc.HI[0]);
-    r->reserved[34] = tswap64(env->active_tc.PC);
-    r->reserved[35] = tswap64(env->CP0_BadVAddr);
-    r->reserved[36] = tswap64(env->CP0_Status);
-    r->reserved[37] = tswap64(env->CP0_Cause);
+    regs[26] = 0;   /* k0 */
+    regs[27] = 0;   /* k1 */
+    regs[32] = tswap64(env->active_tc.LO[0]);
+    regs[33] = tswap64(env->active_tc.HI[0]);
+    regs[34] = tswap64(env->active_tc.PC);
+    regs[35] = tswap64(env->CP0_BadVAddr);
+    regs[36] = tswap64(env->CP0_Status);
+    regs[37] = tswap64(env->CP0_Cause);
 }
-- 
2.53.0


