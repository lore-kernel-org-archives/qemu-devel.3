Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86A6CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUex-00074q-3s; Tue, 29 Sep 2026 06:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUeu-00072D-ID
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:00 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUes-0008BF-D8
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:00 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48870973bddso278296f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676117; x=1791280917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vUO8rS+BkBvhQE8OR0Rq3cew0cRf5Km8o3EHJ4QAT5Y=;
 b=E0FmSPmuTVYb5YKsa1fv/I/OTViWOULtY5CWGRCU4xBUeGtSiLb71moBZ678Cva3az
 YP0itGZJRm6t3llDzWJfZaYiRP3mjx+RXaSzXR1tT9NeWOmT5gehiGkm/eSks+/rGw7o
 vhWrp8jO42dFBxwpiOM5anAIANqgGgG5+mwcAER7VoXI15s5Rxt00M+A5FvlnpnTM3z7
 GbzfY/+tkOEFyBkRy1rYqw5KwlD+78/9mXcCWu4xKkhic3cFK1/wlY8gjiY88cy99q14
 NehR6s8gUfiVuwPOhwhq4NRKx5FE5bI5fu1CXnz94ShR01J3J0X8toh4SP9pvMvJTA52
 qWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676117; x=1791280917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vUO8rS+BkBvhQE8OR0Rq3cew0cRf5Km8o3EHJ4QAT5Y=;
 b=1NQBkS0yaie98q+Kb59YUfa2+QusZK6VKOB93HO39Vzmlc53K/iihKtT3eip1tClvL
 oasgRE+VB9cRsMV58TCNXh2wAyROddPXMMwOwDNI2QvrNxPnwlbq1zOYS/6fHSr/ILyq
 71i76MEryyrglQRceEEZUD3Kv3Y2NNbp3moy7lGXfQONgY6mXeadb36vEXOuNkZqLm75
 JKaZKkoN3dT5P3wqVAOoS4tvauVzj/SHRRd+N8I8XKyTFMVtHYr9vBEHZmwI4LhMsfHB
 Jl5/0xgbZo5aoBSLejCqDZ/ttucop7y4x/bPsIyFb8iQGvSizguR9dzYll+xlGJIPzSA
 vFHQ==
X-Gm-Message-State: AFq9FYLcqNAQY73SUinVBDpAozidjGkkhEEJEp9oSXzJuPJXkXfI53YW
 U9sb3W2qbrFZcZ9EK2efXuYhsynVBIFkZbpmY/7f0WE7+Yt6Z8woZoOCENXIbC+8RxYC0o8JO58
 CRXlG
X-Gm-Gg: AYBFou0chHSbW9QZyofd+ZuAv1NPUyzRp8c7WJofd/rb8UzuuKv022QISkrC8NEpJh6
 SiWpY5DicPGAG6BCghc/++zVHiXPYgW7A2L7txLc7U1plW/I8Rz8SFm0cafVB7/ydbsxJsC/yo7
 /X2u4RSGcQofZR3Nk1o6tIynIWwwKfFshNQfpHHoRsAQpGINwAhLaS9TALyetsW+RtPEo439USl
 c3+0t7vCKNs96QVeHoJLPc7zPUVlpyZ7maoQR03cA8PlYFsaDHQWFwWGS4rem7RREFNkAT2vAkw
 uE33eO1D/+eUX9nB53cenMgG99dtH8RDPTub4Z/pR23mj8GJBQ2B6jsl85kpqitnOzal8szYv7i
 mCwcmk52/aTvoC3vW4B+f8yQlqV3oRMFix92wbivxvKnsyC+BqtznONrOdqr1ToAgkuK9eTnpwv
 QB856qiDIDPU+zVZh8AI12Ozx1ahc4u2gWknmoVpfCJCrjXa0hPZAyV8ZdAp8RG7k4ih89nZSpq
 dK5btLp+uxCGgwGYYZWCN3uISLVJbp5VEaNxexSN1LyOXdv1jdLHSphdF2gSwqW9S8NneyzpR08
 dKs=
X-Received: by 2002:a5d:588d:0:b0:487:fb2:1a0f with SMTP id
 ffacd0b85a97d-48af1b3622dmr3783602f8f.6.1790676116700; 
 Tue, 29 Sep 2026 03:01:56 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.01.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:01:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/37] target/arm: Don't assume secure-banked registers are
 migrated by 64-bit regs
Date: Tue, 29 Sep 2026 11:01:09 +0100
Message-ID: <20260929100133.2598676-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

In add_cpreg_to_hashtable() we have some code that automatically
marks the secure version of an AArch32 banked cpreg as ARM_CP_ALIAS
under two conditions:

 1) If the register has both 32-bit and 64-bit instances then we can
    count on the 64-bit instance taking care of the non-secure bank.

 2) If ARMv8 is enabled then we can count on a 64-bit version taking
    care of the secure bank.  This requires that separate 32 and
    64-bit definitions are provided.

Item 1 is correct: if the ARMCPRegInfo has ARM_CP_STATE_BOTH then we
will always add it as an AA32 entry (which then splits into an S
entry with bank_fieldoffsets[0] and an NS entry with
bank_fieldoffsets[1]) and as an AA64 entry (which uses
bank_fieldoffsets[1]), so the AA64 entry will always be present to
cover the NS banked AA32 entry.

Item 2 is not correct: the idea was that because typically AArch32
Secure banked registers are (non-architecturally) mapped to EL3
AArch64 registers, the AArch64 EL3 register would handle things
(and that we would be adding the AArch64 register to the hashtable
even if the CPU didn't have AArch64).

However, this fails in several cases:
 (a) registers like CSSELR, where there is only a CSSELR_EL1, and
     no _EL3 version. CSSELR_S's underlying state isn't migrated
 (b) registers like TPIDRURW, where the secure banked register
     isn't mapped to any AArch64 register, so the state isn't
     migrated
 (c) IFAR_S and DFAR_S are odd special cases, because they map to
     AArch32 HIFAR and HDFAR, which in turn map to AArch64 FAR_EL2.
     If the CPU doesn't have EL2, we don't register FAR_EL2 and
     the IFAR_S and DFAR_S registers don't get migrated.

More generally, the architecture dropped the concept of documenting
secure AArch32 registers as being "non-architecturally mapped" to EL3
AArch64 registers and relegated it to an implementation detail, which
is why TPIDRURW and friends got mishandled.

It also conflates "has 64-bit registers" with "is ARMv8", which is
wrong for the qemu-system-arm "max" type and for any AArch64 CPU
started with "aarch64=off".

Instead of marking the S-banked register as an alias if
ARM_FEATURE_V8, don't put it into the hashtable at all if
ARM_FEATURE_AARCH64 is present.

There are not all that many banked registers, and they're easy to
find by searching for regdefs that set bank_fieldoffsets:
 DACR, IFAR, DFAR, IFSR, DFSR, CSSELR, MAIR0, MAIR1,
 TPIDRURW, TPIDRURO, TPIDRPRW, TTBR0, TTBR1, TTBCR, TTBCR2,
 PAR, VBAR, SCTLR

None of these do complicated things on reset, so having both an
AArch64 view and an AArch32 view reset the same register state to the
same value and migrate the same data twice is harmless.  This is
better than sometimes not migrating or resetting it at all.

This changes the set of cpregs we will try to migrate for CPUs with
ARM_FEATURE_V8 but not ARM_FEATURE_AARCH64, and is a migration break
there.  However, the only such CPUs are the qemu-system-aarch32 "max"
CPU and AArch64 CPUs with "aarch64=off".

In an ideal world we would also not bother putting the S cpreg into
the hashtable if the CPU is AArch32 without EL3 (i.e.  it doesn't
implement Secure state at all), because nothing will ever look up the
S version of the register (access_secure_reg() always returns false).
But that would be a migration compat break for those CPUs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260907130223.3148989-3-peter.maydell@linaro.org
---
 target/arm/helper.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a608df12111..fe9838b3f6d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7787,18 +7787,33 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, ARMCPRegInfo *r,
         if (state == ARM_CP_STATE_AA32) {
             if (isbanked) {
                 /*
-                 * If the register is banked then we don't need to migrate or
-                 * reset the 32-bit instance in certain cases:
+                 * If this is an AArch64 CPU then AArch32 cpregs are never
+                 * banked, and if we put an NS version into the hash table
+                 * it would never be accessed (compare the condition we test
+                 * in access_secure_reg()). So drop it rather than adding it.
                  *
-                 * 1) If the register has both 32-bit and 64-bit instances
-                 *    then we can count on the 64-bit instance taking care
-                 *    of the non-secure bank.
-                 * 2) If ARMv8 is enabled then we can count on a 64-bit
-                 *    version taking care of the secure bank.  This requires
-                 *    that separate 32 and 64-bit definitions are provided.
+                 * Ideally we would also ignore the S banked register here
+                 * for an AArch32 register without EL3; however, that would
+                 * be a migration compatibility break for those CPUs, so we
+                 * continue with having the cpregs in the hashtable.
                  */
-                if ((r->state == ARM_CP_STATE_BOTH && ns) ||
-                    (arm_feature(env, ARM_FEATURE_V8) && !ns)) {
+                if (!ns && arm_feature(env, ARM_FEATURE_AARCH64)) {
+                    g_free(r);
+                    return;
+                }
+                /*
+                 * If the register is banked then we don't need to migrate or
+                 * reset the 32-bit instance if this is a STATE_BOTH regdef.
+                 * This is because we can know for certain that there's a
+                 * 64-bit regdef that's using bank_fieldoffsets[1] as its
+                 * fieldoffset, because the code that handles STATE_BOTH
+                 * always registers it. In other situations either the NS
+                 * or the S banked register might be aliased (architecturally
+                 * or non-architecturally) to a 64-bit register, but it might
+                 * not be. For those we must manually mark the alias in the
+                 * regdef struct if we care.
+                 */
+                if (r->state == ARM_CP_STATE_BOTH && ns) {
                     r->type |= ARM_CP_ALIAS;
                 }
             } else if ((secstate != r->secure) && !ns) {
-- 
2.43.0


