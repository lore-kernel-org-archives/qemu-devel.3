Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E64CD343F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 05:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPwQc-0004hK-NN; Thu, 21 May 2026 01:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wPwQb-0004gp-4n
 for qemu-devel@nongnu.org; Thu, 21 May 2026 01:58:41 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wPwQZ-0005Ig-15
 for qemu-devel@nongnu.org; Thu, 21 May 2026 01:58:40 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-651c5d525f6so5907515d50.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 22:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779343118; x=1779947918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SgDw4wDuhWc2HdYiA6TxnPIJZAPxBjyxaBSXfDIU2B4=;
 b=Dm8EXjuV7+aTpNohtdycBSRVGM4GKhJlk2mh7FISQCzOvXHAhC62oax6BFmqAZMVL+
 j/4ybEVbpethrv8eAA176KvxCbHXh7FIpLVZ/GfbR5TkvuWIFqOQpaaBZlqgh3XAQl7e
 JTW0tek4Zty0HNi44FzSDrO8TetTBQWyFHaOBtXsTcPZCEoKrqJEsd07mMIjonSGCy7F
 Toz+eJEToRdjvpXSZiVym+C1IbCQ12JrZlxOR6kUVhaI3pjfTQFC9MpCzHqUtNoUWEyy
 BUYkhAuYfZ3DUuBU5kRuJCKZoFnCxdSKdQkWWhcsdVk9WnZFcXGikCrFZtzArlbsFPhP
 AU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779343118; x=1779947918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SgDw4wDuhWc2HdYiA6TxnPIJZAPxBjyxaBSXfDIU2B4=;
 b=UEtl2zNSq+nNy8YP1LsbhDGHJDmkS66bbYjDyl3pH5dsmWoW0ODnAfexD1JuUciaUu
 OLHtp+m1LPS3mL6o2tarBfKqwfYnIVcj0ssB7DkIQifzLfjRc/eEzEB9x05JHTj+TKS0
 ixrWEPT5E5nqqmhNMB4IqeZTWwPfOQjPrk/UDGB98Q30auUdZZ3h/S5zmtVwj1c/mkbd
 /5NjFbbQoOfptH9LtyvN1O0rpyZqZRNedPHK4eJylXQ6LlRm5/oh+rHMCUMIimuMsRgl
 SoGB/ZC5djAUMZdsjVaKzMO+xwsBysPgetE2zo79wJLALWoGAX8Uu24Cu5iVCLXETIkG
 6eDQ==
X-Gm-Message-State: AOJu0Yxcs1fa1ByAOQR54Bd43DAScAARXXKt6e8MBQHEnbSU3GpwSaj0
 1XF624tdrNL05F6s4sjqvMJAnma8xF0fvy7FKx7w235CbZUX7eSIvfT6GfPFmOTC
X-Gm-Gg: Acq92OHYCQYTvxhVxAcrXmQTlpsceU7NJU4kSxe493M9icH1/ct8kpcp6gG5h5rYfsE
 N7yL7OPVb1xzJGFQ7Lk40MTviZLm/oWnfNPTIp/P5HvG6cMalFAlyAyzwr037L3nRBKhDlytzc+
 juWWZEcMOcCTWHuf0w3O+/9KkY7yR+vDl5GWvyUeMz+KVLfeyg9hzt5mkBTd2v1vr2dOMGnAIb5
 GWQZUIXtEeScvFUD2j7cL8QxbFAuZkF/+GkI2Dn7CCTCDo9owaYvNnciuclZf2uz0y+jqVmv1RM
 Lx0zNauQ2QSAjfNa1ZSPKWM0c5sJEZWxeAXd59D3ik0oj82tBcc688ne2gQLcudf/sdr1uvlPtu
 TgkvUOfmInCzT6gezGfmzyjtzQIZwosByjz6BdQJpGZ/d8uWzNjN4gkFklqIcZ8R6QAZtKo0krb
 oDNDD8r+aqiqrrvXw50qRNKs665alAEd5WBV/1UVz6XH+YyWkCXghZbafhzquT5K6a6jGcBXi05
 D8=
X-Received: by 2002:a05:690e:bca:b0:65c:6220:5fcf with SMTP id
 956f58d0204a3-65eae3caf3bmr1097575d50.62.1779343117934; 
 Wed, 20 May 2026 22:58:37 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-65e0d86bc02sm10285008d50.4.2026.05.20.22.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 22:58:36 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Matt Turner <mattst88@gmail.com>,
 qemu-stable@nongnu.org
Subject: [PATCH 2/2] linux-user/mips64: fix mipsn32 elf_core_copy_regs entry
 width
Date: Thu, 21 May 2026 01:58:21 -0400
Message-ID: <20260521055821.1380491-2-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521055821.1380491-1-mattst88@gmail.com>
References: <20260521055821.1380491-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb134.google.com
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
 linux-user/mips64/elfload.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git ./linux-user/mips64/elfload.c ./linux-user/mips64/elfload.c
index d19e5f2439..feba260462 100644
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
-        r->reserved[i] = tswapl(env->active_tc.gpr[i]);
+        regs[i] = tswapl(env->active_tc.gpr[i]);
     }
-    r->reserved[26] = 0;   /* k0 */
-    r->reserved[27] = 0;   /* k1 */
-    r->reserved[32] = tswapl(env->active_tc.LO[0]);
-    r->reserved[33] = tswapl(env->active_tc.HI[0]);
-    r->reserved[34] = tswapl(env->active_tc.PC);
-    r->reserved[35] = tswapl(env->CP0_BadVAddr);
-    r->reserved[36] = tswapl(env->CP0_Status);
-    r->reserved[37] = tswapl(env->CP0_Cause);
+    regs[26] = 0;   /* k0 */
+    regs[27] = 0;   /* k1 */
+    regs[32] = tswapl(env->active_tc.LO[0]);
+    regs[33] = tswapl(env->active_tc.HI[0]);
+    regs[34] = tswapl(env->active_tc.PC);
+    regs[35] = tswapl(env->CP0_BadVAddr);
+    regs[36] = tswapl(env->CP0_Status);
+    regs[37] = tswapl(env->CP0_Cause);
 }
-- 
2.53.0


