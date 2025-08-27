Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F840CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4f3-00038f-C8; Tue, 26 Aug 2025 21:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4dv-0000xa-Dh
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:08:03 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4dl-0007eM-7B
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:08:03 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-771fa65b0e1so659464b3a.0
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756256868; x=1756861668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8b32+ACK8cGml6u7LT+qVkPNEr56NeXpZfW7bYxN9l0=;
 b=yel0F8ZIJJAMgzOpRywrUvvjv/JjOYfYDRndPs+p754jw3PEgwei6IZGARVLxmAV0r
 eqZ9zzZL5xahjwpaeUbIRvtSoE+08mUkhC7WE0UXxCogvGiUkj3jKi/B5pciMtjMk+4Z
 a33TaZwQVLIDbFqShD9IYqH3XnUg6fxUuRC7Efbsm2Fhw7mpN88TMzkrEsRMi7JC3B7D
 YfyWRcWnRHDv+JikUmu+lCMWzYNAU+gR0hVZYIFFl9Ro6EM0jcPceiVrvgeQchoO2f3N
 KkgO8KZtik2WNatQIgKosWTvInf2s0tLF5VVeTOvgAAOMhdli7gjQ2B6+w2MsjOIZ1lj
 3kzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756256868; x=1756861668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8b32+ACK8cGml6u7LT+qVkPNEr56NeXpZfW7bYxN9l0=;
 b=qZa+Ha0XQ5vCTWw9Ksk2atJfoqVjnmLTyJv+Sw9rmQnuYVpN1FetFEn+479kzkdA30
 lrMET0SJm6Iuxd2xAo/KFW3B12Ng5wAEsSaSqOrO/VNPab29SQv0y5HqHkC77OyrArnv
 PNSuWZbHMzjVh5JYayq1eAh8eBL1D83gm5l+bcAyTvJOn9gq2WcLfAn9E1z/t5tLrRmX
 PSSfNlehnPiunx9rLVe09eriCcrtOqPMSmw8AEi2Q7Ux4rNGMrZ95ohqAX0yjXpm9fAc
 Gu8c8iZJ2JT0SnhdbJH3UYOEQr5N8PeRHthskwToVbzstUbjIx3BEEWpKr79JGFNkkB+
 KVPw==
X-Gm-Message-State: AOJu0YxLGUW7V++zcDOLC6OZL0+3So9oTrp2xxYJEo4pXhniDUa8baXO
 1MYuBYGN5ImBAmHh9hTa6a2ewRXEPdBNKSljOjCBSBgjXBaMlSrmtrMqVbGqD0R59Wv76IXOOzO
 Zkeh1neo=
X-Gm-Gg: ASbGncuSZ+6PqkpRE+CfNVy5o4AzrUMAwkr3tseFzaJVqyvi3IpWhnjxFxCot8W+N11
 ZqT0sni/2MTRM8MNK+us+rgJjCEv3rSLW0Amj+4Qtbj+0Jlolca92EL6JxGFbkupUOMvuiizQkn
 Wk+LctUtLG8WRtFrUac32pSUeSrA1ropGUM2REkIFKbDLDLgCVqurH+z4gvijimDbFtctXZNMQv
 ufqv81kdhbl5OpLS2SYemMchUwFg6gkjatkn2Q3Z+kTPxHOoI1NkJI/b/N9YsERwhJjJvmvs9oq
 0/IDMxKgFgcXjzBn3HCT0h5v9LiG7as/cn6v8PZ2va+OaqpO8m4/llMrkowuJyWg3/O9TReLB9a
 TDPQoLrxXnCMvQJL4QWsPp0knTg==
X-Google-Smtp-Source: AGHT+IEFhL7MXrrPDWVTHE3MmROJ4GKP+Aq+zYE1r1UcCG5KY+pM4KZ4gtZw6feimZhDhKQERBDcmQ==
X-Received: by 2002:a05:6a00:bd11:b0:771:f951:16c6 with SMTP id
 d2e1a72fcca58-771f9511920mr5526192b3a.15.1756256868147; 
 Tue, 26 Aug 2025 18:07:48 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7720274534esm1419241b3a.47.2025.08.26.18.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:07:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 33/61] target/arm: Redirect VHE FOO_EL1 -> FOO_EL2 during
 translation
Date: Wed, 27 Aug 2025 11:04:24 +1000
Message-ID: <20250827010453.4059782-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h            |  6 ++++
 target/arm/gdbstub.c           |  5 ++++
 target/arm/helper.c            | 53 +---------------------------------
 target/arm/tcg/translate-a64.c |  9 ++++++
 4 files changed, 21 insertions(+), 52 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 7bdf6cf847..d34ed0d40b 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -911,6 +911,12 @@ struct ARMCPRegInfo {
      */
     uint32_t nv2_redirect_offset;
 
+    /*
+     * With VHE, with E2H, at EL2, access to this EL0/EL1 reg redirects
+     * to the EL2 reg with the specified key.
+     */
+    uint32_t vhe_redir_to_el2;
+
     /* This is used only by VHE. */
     void *opaque;
     /*
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index e2fc389170..3727dc01af 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -249,6 +249,11 @@ static int arm_gdb_get_sysreg(CPUState *cs, GByteArray *buf, int reg)
     if (ri) {
         switch (cpreg_field_type(ri)) {
         case MO_64:
+            if (ri->vhe_redir_to_el2 &&
+                (arm_hcr_el2_eff(env) & HCR_E2H) &&
+                arm_current_el(env) == 2) {
+                ri = get_arm_cp_reginfo(cpu->cp_regs, ri->vhe_redir_to_el2);
+            }
             return gdb_get_reg64(buf, (uint64_t)read_raw_cp_reg(env, ri));
         case MO_32:
             return gdb_get_reg32(buf, (uint32_t)read_raw_cp_reg(env, ri));
diff --git a/target/arm/helper.c b/target/arm/helper.c
index d0ccc23811..3f69ce6cb5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4441,47 +4441,6 @@ static CPAccessResult access_el1nvvct(CPUARMState *env, const ARMCPRegInfo *ri,
     return e2h_access(env, ri, isread);
 }
 
-/* Test if system register redirection is to occur in the current state.  */
-static bool redirect_for_e2h(CPUARMState *env)
-{
-    return arm_current_el(env) == 2 && (arm_hcr_el2_eff(env) & HCR_E2H);
-}
-
-static uint64_t el2_e2h_read(CPUARMState *env, const ARMCPRegInfo *ri)
-{
-    CPReadFn *readfn;
-
-    if (redirect_for_e2h(env)) {
-        /* Switch to the saved EL2 version of the register.  */
-        ri = ri->opaque;
-        readfn = ri->readfn;
-    } else {
-        readfn = ri->orig_readfn;
-    }
-    if (readfn == NULL) {
-        readfn = raw_read;
-    }
-    return readfn(env, ri);
-}
-
-static void el2_e2h_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                          uint64_t value)
-{
-    CPWriteFn *writefn;
-
-    if (redirect_for_e2h(env)) {
-        /* Switch to the saved EL2 version of the register.  */
-        ri = ri->opaque;
-        writefn = ri->writefn;
-    } else {
-        writefn = ri->orig_writefn;
-    }
-    if (writefn == NULL) {
-        writefn = raw_write;
-    }
-    writefn(env, ri, value);
-}
-
 static uint64_t el2_e2h_e12_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     /* Pass the EL1 register accessor its ri, not the EL12 alias ri */
@@ -4657,17 +4616,7 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
                                  (gpointer)(uintptr_t)a->new_key, new_reg);
         g_assert(ok);
 
-        src_reg->opaque = dst_reg;
-        src_reg->orig_readfn = src_reg->readfn ?: raw_read;
-        src_reg->orig_writefn = src_reg->writefn ?: raw_write;
-        if (!src_reg->raw_readfn) {
-            src_reg->raw_readfn = raw_read;
-        }
-        if (!src_reg->raw_writefn) {
-            src_reg->raw_writefn = raw_write;
-        }
-        src_reg->readfn = el2_e2h_read;
-        src_reg->writefn = el2_e2h_write;
+        src_reg->vhe_redir_to_el2 = a->dst_key;
     }
 }
 #endif
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 8303f0dac2..8fcc74d151 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2573,6 +2573,15 @@ static void handle_sys(DisasContext *s, bool isread,
         }
     }
 
+    if (ri->vhe_redir_to_el2 && s->current_el == 2 && s->e2h) {
+        /*
+         * This one of the FOO_EL1 registers which redirect to FOO_EL2
+         * from EL2 when HCR_EL2.E2H is set.
+         */
+        key = ri->vhe_redir_to_el2;
+        ri = redirect_cpreg(s, key, isread);
+    }
+
     if (ri->accessfn || (ri->fgt && s->fgt_active)) {
         /* Emit code to perform further access permissions checks at
          * runtime; this may result in an exception.
-- 
2.43.0


