Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1F3CFB43C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 22:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxD48-0006yv-PS; Sat, 05 Oct 2024 18:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxD3y-0006xf-UP
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 18:15:49 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxD3x-0005tV-8e
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 18:15:46 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-71dfccba177so161424b3a.0
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 15:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728166542; x=1728771342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uUuy8elcXKD4Ev+p0aNnxP0u8ZBZ/r7M+GG9/Xwm2Sw=;
 b=T5gZHPMLE0FsYe21vAYp6DMTn1wbmrt1qLTM1LueCuy3pHp4s308km+sH4dOaSOV9B
 U+q5Vpcio8ar3JxrBr0szf3iMM4zhpe/Nbi/weYY6G4C7ckPetz3Yn4pTomPhsOLvZ8A
 f3LLKDM+LxMskz1e2J+EN9OjiqTWqWmG+K63/tt/kK9j9VrW7ryU+S0Esc/QCzGdOLlI
 LUIYLfLnB6OZNWkz0p4CUW1biRX889tZYGfckEIvkXkbcf7IUh/5jjlFK48B4Okwg33Z
 VGsuNDM1xhhJAn+HEhXPdTzWGcX81+lBS3Gk97WrW8xehwmP2yoHEukIK3E0THjMwgD0
 HJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728166542; x=1728771342;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uUuy8elcXKD4Ev+p0aNnxP0u8ZBZ/r7M+GG9/Xwm2Sw=;
 b=khbCZozntt4lLWp65uY11bDFUHHlWFO3lsTIyFDs6c3DrdeZSG2QG0KxNWFMaNGfyg
 EsmYpihO7kJzU+d2R8pQ1kYflsdAnqkckhFge/ntNIEqxMlANPMBnBNkqvIPwG657KCL
 eLdAlKqwFXN1cJZnBV9ZwNSh3SUCmVCGBK7VxVysR/sWMEVJNn4xkT6I1sKHOOLH1s+u
 KbsgZaCR2uLD9GGHP3Gk9angKUxlthd6DXw7gOXWnngx8JQVhReX9o1krL/V1C6jlkjC
 LJtvp6xkkfn6O2yagi+FeXz97QUEj4/mFb7lG+jfcC7Ylzr0PN3C21qOYcDTcYHUb7AD
 EiCQ==
X-Gm-Message-State: AOJu0YyEZXkl0DsEe9vmwpJNRYa+PeOgWX5MsHzs37IaKwq3NnUdZSTG
 p9ep5r8JJf9ZBOUlgB4Bzk17p8ZkvbHlwUb+eUxpOo8gSTPwTEtWpdIx39vwL+TqoZqs+Z7pvSc
 T
X-Google-Smtp-Source: AGHT+IEbsa7lHlzM+1jzQlCJqKmWd8yxk+yz64viibsZwUZ/O936SabXCAbyjX83JHNVYmdzDBRrKA==
X-Received: by 2002:a05:6a21:3983:b0:1d6:97f2:4c12 with SMTP id
 adf61e73a8af0-1d6e02b14e3mr11918140637.1.1728166542412; 
 Sat, 05 Oct 2024 15:15:42 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f680c2d6sm2216860a12.5.2024.10.05.15.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 15:15:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru
Subject: [PATCH] tcg/ppc: Use TCG_REG_TMP2 for scratch index in
 prepare_host_addr
Date: Sat,  5 Oct 2024 15:15:41 -0700
Message-ID: <20241005221541.495844-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In tcg_out_qemu_ldst_i128, we need a non-zero index register,
which we then use as a base register in several address modes.
Since we always have TCG_REG_TMP2 available, use that.

In tcg_out_qemu_st, in the fallback when STDBRX is not available,
avoid clobbering TCG_REG_TMP1, which might be h.base, which is
still in use.  Use TCG_REG_TMP2 instead.  Since the final use of
h.index is that ADDI, there is no conflict with the above.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2597
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 3f413ce3c1..223f079524 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2617,8 +2617,8 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 
     if (TCG_TARGET_REG_BITS == 64 && addr_type == TCG_TYPE_I32) {
         /* Zero-extend the guest address for use in the host address. */
-        tcg_out_ext32u(s, TCG_REG_R0, addrlo);
-        h->index = TCG_REG_R0;
+        tcg_out_ext32u(s, TCG_REG_TMP2, addrlo);
+        h->index = TCG_REG_TMP2;
     } else {
         h->index = addrlo;
     }
@@ -2704,9 +2704,9 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg datalo, TCGReg datahi,
         uint32_t insn = qemu_stx_opc[opc & (MO_BSWAP | MO_SIZE)];
         if (!have_isa_2_06 && insn == STDBRX) {
             tcg_out32(s, STWBRX | SAB(datalo, h.base, h.index));
-            tcg_out32(s, ADDI | TAI(TCG_REG_TMP1, h.index, 4));
+            tcg_out32(s, ADDI | TAI(TCG_REG_TMP2, h.index, 4));
             tcg_out_shri64(s, TCG_REG_R0, datalo, 32);
-            tcg_out32(s, STWBRX | SAB(TCG_REG_R0, h.base, TCG_REG_TMP1));
+            tcg_out32(s, STWBRX | SAB(TCG_REG_R0, h.base, TCG_REG_TMP2));
         } else {
             tcg_out32(s, insn | SAB(datalo, h.base, h.index));
         }
-- 
2.43.0


