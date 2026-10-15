Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE8BCC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ4n-0002Tx-3L; Thu, 15 Oct 2026 06:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4l-0002T5-5X
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:43 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4j-0007r5-CX
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:42 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48c6955a7c3so1462780f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792061560; x=1792666360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n98E2pZRXP0uOhJ5yNj447/v7obAeDWkpJner3Bn8g0=;
 b=sM3zIqjdmvHPqcqAUoUmohDZxJkgt6u6u1rSeYUp+WYgrRCEwz0IQGjMAKnN5laABR
 5nNGPOQ8t5bY8mWoeNJMDtTuTb695f9rvnHxQkzbcbnv2Cm1ZYT82bLKbIUgFoV1fIan
 5jpEBKYpyDHSRWdbGtIGayF3mFUmOqqk9G7jQz/76euUAfQa3rjeGS5/isbXpkteQM7D
 u1/+YYJCFgOrVpCyxbI+j45IRB03sNs4S1lT4cCYfIuGh6Vk8Sflghx1HaI206rW6jWR
 t7whgY1lCdGreB9+7k7KoxolQkvhrvGVrSoCh8TT2q10lg4a825+MtyJiUK3kXsEsAlK
 iCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061560; x=1792666360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=n98E2pZRXP0uOhJ5yNj447/v7obAeDWkpJner3Bn8g0=;
 b=OYX3KxMLkaHxAat2kqTUEFbOFYtFtZv5EQtp0jAlvVHdT0svIlC6ljFys5UpQgeWjj
 ROVCH4a1Op2eAQfVB1avjmJjCxsBHsKemd2fQOBHJpMmEZeKBTJG+HR1Y6cI8KP557ZU
 /+gXz6DGfzN2d2OagEwOkx/0Vrl4McpBfJXmI4QQIfNVdc57zpbth376REGnI2vuyM0X
 +Cc5mZIxh9qhnQWocZQVSAMt8KYG64BWgl/4EyUTpJPihL/EE52ZrxbHVEioUreIYSJH
 OYIo6ZYyO83ZT8uATTdhOAH1nWDgYAn9b9rTNpXy87sJjX7QFJ4+vOvYlY+XOOC/JPfb
 yACA==
X-Gm-Message-State: AFq9FYJ/eLhBUcHy838NFOzneUpVO26PnRRjFSomChN4UPMM6//T/VBQ
 gB7F7S9PdfL5fu3PSshZTktdQm518airT/TEiWjzfZIptzV8j0GZHx6hwAYgmtpV2388DDPJjfC
 b4AVnHqk=
X-Gm-Gg: AYBFou0jbVKxQCe4O9J1mrmpHM8Fhc4bGOoNRIQH2Tf57n817UcGv2HDtLiSGbC89QL
 e52tG8oO5qCxJAix1lzI2nXi3vDayvIME2ZHP9UayklZpvbN3tdDmqBDPwNrYw5n1PdfCFK+tDK
 iKVaJsao7guy5UbbZYoQrGOa8Y4xhzIBt+Tae7eK6zeTLXMhmYPX+XxFBGWnZOemjlAVx0IzPlz
 j/PBGgmdxSu2YWuq5541XfClcegqkjdQKMlOtjEnDF8AMjr8Iuxd11Z/ZQLcxPik34u+JGBC6ov
 RqH0Dno/sXgim55S1+6fwpIEh5/ddMROXCzuhZrR8BPY6dpcRG9GurLFiPbUnhkiMIFJyYgchSe
 v9EEUR8usp2wrknx9jj+L0Fh09nlVzLjtrMLHfGb8EWWcVZNV55R1lSF/myVhYOjSLg8+fxemFk
 8KLPUAKqSB0ww05m7EMB8Ue0kRJF94SYyL4l+wMR4WUjpTTaVrX8arc9P1pkSLeNlwockK9WFlk
 3m4ugBgWmB8Mne14BjQggOZ4bobzRIUiAejvltv8twVLbF+hZLriuviR4JUBeZID+1tpGLcyQhY
 eSF+jKHERoDr82c=
X-Received: by 2002:a05:6000:46cb:b0:48c:4444:f0a2 with SMTP id
 ffacd0b85a97d-48dba7bf41dmr24022626f8f.7.1792061559811; 
 Thu, 15 Oct 2026 03:52:39 -0700 (PDT)
Received: from stoup.fritz.box
 (p200300ca3f0f8b006e0ed1a687ab6860.dip0.t-ipconnect.de.
 [2003:ca:3f0f:8b00:6e0e:d1a6:87ab:6860])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df5b88207sm3075949f8f.59.2026.10.15.03.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:52:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Chou <max.chou@sifive.com>
Subject: [PULL 12/16] tcg/riscv64: Return success from encode_jimm
Date: Thu, 15 Oct 2026 12:52:04 +0200
Message-ID: <20261015105212.356392-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015105212.356392-1-richard.henderson@linaro.org>
References: <20261015105212.356392-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Centralize the range test for this encoding.
Directly OR into the insn value.
Assert success in encode_j.
Use encode_jimm in tcg_out_call_int.

Reviewed-by: Max Chou <max.chou@sifive.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv64/tcg-target.c.inc | 46 ++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 3a7761b6fec..c8f91612d37 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -507,24 +507,26 @@ static tcg_insn_unit encode_u(RISCVInsn opc, TCGReg rd, tcg_target_long imm)
 
 /* Type-J */
 
-static tcg_insn_unit encode_jimm20(tcg_target_long imm)
+static bool encode_jimm20(tcg_insn_unit *insn, tcg_target_long imm)
 {
-    tcg_insn_unit ret = 0;
-
-    ret |= (imm & 0x0007fe) << (21 - 1);
-    ret |= (imm & 0x000800) << (20 - 11);
-    ret |= (imm & 0x0ff000) << (12 - 12);
-    ret |= (imm & 0x100000) << (31 - 20);
-
-    return ret;
+    if ((imm & 1) == 0 && imm == sextract32(imm, 0, 20)) {
+        *insn |= ((imm & 0x0007fe) << (21 - 1)
+                  | (imm & 0x000800) << (20 - 11)
+                  | (imm & 0x0ff000) << (12 - 12)
+                  | (imm & 0x100000) << (31 - 20));
+        return true;
+    }
+    return false;
 }
 
 static tcg_insn_unit encode_j(RISCVInsn opc, TCGReg rd, tcg_target_long imm)
 {
-    return opc | (rd & 0x1f) << 7 | encode_jimm20(imm);
+    tcg_insn_unit insn = opc | (rd & 0x1f) << 7;
+    bool ok = encode_jimm20(&insn, imm);
+    tcg_debug_assert(ok);
+    return insn;
 }
 
-
 /* Type-OPIVI */
 
 static tcg_insn_unit encode_vi(RISCVInsn opc, TCGReg rd, tcg_target_long imm,
@@ -635,12 +637,7 @@ static bool reloc_jimm20(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
     intptr_t offset = (intptr_t)target - (intptr_t)src_rx;
 
     tcg_debug_assert((offset & 1) == 0);
-    if (offset == sextreg(offset, 0, 20)) {
-        *src_rw |= encode_jimm20(offset);
-        return true;
-    }
-
-    return false;
+    return encode_jimm20(src_rw, offset);
 }
 
 static bool reloc_call(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
@@ -1580,14 +1577,15 @@ static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *arg, bool tail)
 {
     TCGReg link = tail ? TCG_REG_ZERO : TCG_REG_RA;
     ptrdiff_t offset = tcg_pcrel_diff(s, arg);
+    tcg_insn_unit insn = encode_j(OPC_JAL, link, 0);
     int ret;
 
     init_setting_vtype(s);
 
     tcg_debug_assert((offset & 1) == 0);
-    if (offset == sextreg(offset, 0, 20)) {
-        /* short jump: -2097150 to 2097152 */
-        tcg_out_opc_jump(s, OPC_JAL, link, offset);
+    if (encode_jimm20(&insn, offset)) {
+        /* short jump */
+        tcg_out32(s, insn);
     } else if (offset == (int32_t)offset) {
         /* long jump: -2147483646 to 2147483648 */
         tcg_out_opc_upper(s, OPC_AUIPC, TCG_REG_TMP0, 0);
@@ -1964,15 +1962,13 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
 {
     uintptr_t addr = tb->jmp_target_addr[n];
     ptrdiff_t offset = addr - jmp_rx;
-    tcg_insn_unit insn;
+    tcg_insn_unit insn = OPC_JAL; /* rd = TCG_REG_ZERO */
 
     /* Either directly branch, or fall through to indirect branch. */
-    if (offset == sextreg(offset, 0, 20)) {
-        insn = encode_j(OPC_JAL, TCG_REG_ZERO, offset);
-    } else {
+    if (!encode_jimm20(&insn, offset)) {
         insn = OPC_NOP;
     }
-    qatomic_set((uint32_t *)jmp_rw, insn);
+    qatomic_set((tcg_insn_unit *)jmp_rw, insn);
     flush_idcache_range(jmp_rx, jmp_rw, 4);
 }
 
-- 
2.53.0


