Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642E6CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 18:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ8Ky-0007K8-KJ; Thu, 21 May 2026 14:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wQ8Kl-0007IP-1G
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:41:27 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wQ8Kj-0006qB-55
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:41:26 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-7cfd0d8eb09so33997007b3.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 11:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779388884; x=1779993684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=esqqn6q3Fb9x+XYoWeseFgHkTfB9reADb20kHrnxVGE=;
 b=EyUG0L9a9t7glv1+V75R6wsjBAx5z356wxFMVSSQVF5syLiRx4cxgs/DmvXbP2Abbf
 4BXmRE7txJRU+uUTV6Mj+cb2csQHOOV1beM/fMetPV+n0eI24r+6f6dfX42P2OC4nauo
 LCs8T2cJ8Dp/oSduhYkYEaIanpwvX1J02LnAp7Z//W6ep4sPprE6veWMxnNa48EOsHvW
 izXdW8k2d+iOidySE0B6D+bIMi60UwVENmvmy5vMvgT9TAOpm28JLqLnBX92dJrLtGXm
 2vFkP6EJwRWTiObkVD/R6RliH/SKMgjt+GNIqKDzHtiok14h7so6rwu0+caH0FMBZLCq
 BbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779388884; x=1779993684;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=esqqn6q3Fb9x+XYoWeseFgHkTfB9reADb20kHrnxVGE=;
 b=ki+BgfG3Xt0jCL+eB46wtWMQNu1BzWDtXorpxeQrKR5Hb00UIViXBTMlrA3CJIMyAD
 SxX6k1gNb2/LAgyJmDSeBnXH+qxVjT4YVrLXXidY8fwpOZo85+2rhKegJpeWM8fXvOSi
 7Ja9gr24j2tLDoMpnb0FgRneXHQ4Shiom1GDXjM5fI1Uhg+ZwPDpTp28xz3ZK+j0XHN7
 tMNpAolFjuhaMevIf+QqgHbL7vARgU8CmC11HXU/Nzp6ThipWUPj+dNx3FbszoPltG5Z
 FaQ603NjlH7JnKnPXfRgFlYMal6BgY6xLHTzWz/oRZHDnmDSuDy1TQQIqqQ7XVlrtZtf
 5WHQ==
X-Gm-Message-State: AOJu0YxAWoDh0kgD5vfmjZSg0qoU7nluDrhLOwk3zmA4VFnkZr+rFULV
 fSSQ8DkKCmrwnJvUktrunq/Wl3OG22XQjL8OP8oSOOx36lMr0MHMBF1tKalgoAls
X-Gm-Gg: Acq92OFD89SmUwkj8WF+DpY1FQE1I+l0XKZaHdKn5MGMMAswurg9YPbNFYJN/zhuIk+
 VUjnkOPacwMYRqHYYi4WAXzUHjX+A5y1lKrwyLkAG515JXKDp360nVU60p1oL/v7Ij+yR34Yr4B
 kLK+Qq56QaFsC4e2boG+IrpcxyhHRazbNneaNBBBx3XbPRenoNr6dmLx1VUJbR1+nHHVInfkCzU
 w6r6sTGdkNpu31Uhk4NzCi1A3Sk6RBcvAp0hDn/j41tw7mo7z3uTyjUk42Y5EtyT/jT3v+5CHGw
 u3tRP20U7jgoNnw+YYlCv+CtOp9PzAXUW5/99xyub+WipfyoSK+giVKJz8/ip3PugsxMwlC4FuQ
 GYmS/fviV8SqB1grv0HdSSq4lfscrKBZ9DH+MujhJX1xYeFgH1yUFWWnznH0F6XOEM0FflLUdH8
 svyystRScDJKDfPdhAWyNA0FaOC1o1CGacowChwTmcwE4yt0rgMjnWgWt9nsgfpdRDGLFdnYENI
 yM=
X-Received: by 2002:a05:690c:c22d:b0:7b2:fc6f:b9bc with SMTP id
 00721157ae682-7d338a82013mr6938947b3.21.1779388883804; 
 Thu, 21 May 2026 11:41:23 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7d2c85bccffsm6430317b3.22.2026.05.21.11.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:41:22 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Matt Turner <mattst88@gmail.com>,
 qemu-stable@nongnu.org
Subject: [PATCH 1/3] linux-user/mips64: fix elf_core_copy_regs register layout
 in core files
Date: Thu, 21 May 2026 14:41:01 -0400
Message-ID: <20260521184119.1631958-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112f.google.com
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

mips64/elfload.c uses #include "../mips/elfload.c" to share code. When
the compiler processes mips/elfload.c the quoted #include "target_elf.h"
resolves relative to the including file's directory, so it picks up
mips/target_elf.h instead of mips64/target_elf.h.  mips/target_elf.h
pulls in mips/target_ptrace.h, whose target_pt_regs has a pad0[6] field
before regs[].  As a result elf_core_copy_regs writes:

  r->pt.regs[i]   -> reserved[6+i]   (shifted by 6 from the correct index)
  r->pt.cp0_epc   -> reserved[40]    (correct mips64 N64 index is 34)

The Linux kernel and glibc both use the mips64 N64 layout (no pad0): EPC
at reserved[34].  Debuggers and libunwind reading the core with N64
constants therefore see a completely wrong register set — EPC points to
GP, RA holds the branch target instead of the link address, etc.

Fix by:
 - Guarding the mips32 elf_core_copy_regs in mips/elfload.c with #ifndef
   TARGET_MIPS64 so it is not compiled for mips64/mipsn32 targets.
 - Providing a mips64-specific elf_core_copy_regs in mips64/elfload.c
   that writes directly to r->reserved[i] with the correct N64 indices,
   bypassing the struct field names that are tainted by the wrong header
   include.

The mipsn32 (TARGET_ABI_MIPSN32) and mips64el targets are covered by the
same mips64/elfload.c and benefit from the same fix.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Cc: qemu-stable@nongnu.org
---
v2: Use tswap32/tswap64 instead of tswapl

 linux-user/mips/elfload.c   |  2 ++
 linux-user/mips64/elfload.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git ./linux-user/mips/elfload.c ./linux-user/mips/elfload.c
index cc5bbf05ab..1a46e180cf 100644
--- ./linux-user/mips/elfload.c
+++ ./linux-user/mips/elfload.c
@@ -131,6 +131,7 @@ const char *get_elf_base_platform(CPUState *cs)
 #undef MATCH_PLATFORM_INSN
 
 /* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
+#ifndef TARGET_MIPS64
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
 {
     for (int i = 1; i < ARRAY_SIZE(env->active_tc.gpr); i++) {
@@ -146,3 +147,4 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
     r->pt.cp0_status = tswapl(env->CP0_Status);
     r->pt.cp0_cause = tswapl(env->CP0_Cause);
 }
+#endif
diff --git ./linux-user/mips64/elfload.c ./linux-user/mips64/elfload.c
index b719555e65..9081ae8111 100644
--- ./linux-user/mips64/elfload.c
+++ ./linux-user/mips64/elfload.c
@@ -1 +1,30 @@
 #include "../mips/elfload.c"
+
+/*
+ * mips/elfload.c defines elf_core_copy_regs guarded by #ifndef TARGET_MIPS64.
+ *
+ * We must provide the mips64 version here.  We cannot use r->pt.regs[] because
+ * when mips/elfload.c is #include'd above its "#include "target_elf.h"" resolves
+ * to mips/target_elf.h (compiler searches the including file's directory first),
+ * which pulls in mips/target_ptrace.h.  That struct has pad0[6] before regs[],
+ * so r->pt.regs[i] writes to reserved[6+i] — offset by 6 from what the kernel
+ * and glibc expect for the N64 ABI (EPC at reserved[34], not reserved[40]).
+ *
+ * Write directly to reserved[] using the mips64 N64 index layout:
+ *   R0-R31 at reserved[0..31], LO at [32], HI at [33], EPC at [34].
+ */
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
+{
+    /* R0 is always 0; r->reserved is zero-initialised by the caller */
+    for (int i = 1; i < 32; i++) {
+        r->reserved[i] = tswap64(env->active_tc.gpr[i]);
+    }
+    r->reserved[26] = 0;   /* k0 */
+    r->reserved[27] = 0;   /* k1 */
+    r->reserved[32] = tswap64(env->active_tc.LO[0]);
+    r->reserved[33] = tswap64(env->active_tc.HI[0]);
+    r->reserved[34] = tswap64(env->active_tc.PC);
+    r->reserved[35] = tswap64(env->CP0_BadVAddr);
+    r->reserved[36] = tswap64(env->CP0_Status);
+    r->reserved[37] = tswap64(env->CP0_Cause);
+}
-- 
2.53.0


