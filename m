Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A8BCCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CpK-0006Je-NL; Fri, 10 Oct 2025 09:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cp5-0006Ao-OJ
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:18 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Coh-0003p3-2N
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:13 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3fc36b99e92so2277581f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101544; x=1760706344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VH8TuOXK/91AQCE6m+GMPfGKCjQGAriOtz84pgrVsYE=;
 b=LA/VtPZuWxyKxsBIbAeiwyUJdxIhX4kYVnCqAhSApFkZuXwn/epKtkD8Vb+u3JBorf
 AlSD7yxYrdCp15DfSmpw3VuGilj6ZYpAuxAVwZZnq3TpOQoBhNVox/3JYIvDVX4+rtpA
 LVIQ36+dnoO0JhCY48mudfpDegnKiUrg97LoQLYI0eNM+hON3nNWb4u3S+32RssO6cDb
 U0cdRfrAgwmz6TU4W8jrY2M6I+tgxX1NA020niULIgDi6mjmYzcNIC7M3kVR70u2e7A4
 eQctghGi5Aktqs61qtIi4oKf5qbhjviCl0x49/AFuCSHVe1c6L2TUSWCB5Bj/lHXOGcw
 dU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101544; x=1760706344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VH8TuOXK/91AQCE6m+GMPfGKCjQGAriOtz84pgrVsYE=;
 b=vhqVcbSWcDGv/0WnmbTg2S5u3GvXXqzu6+ggYj6gB+3b3Bzly9r/UVgNWdzcVn5biR
 +dmgpJYt2euesX/isSNQY8VtXSxsuMbBVZqNzAc1llfo0v66mO8nfIranCdt3FDByi8g
 sCzPXrIuqAN+cGzSa4WkdAPqXEyh2izWf8JxgXJipYm9hmYgDeIofVePZSiETIsm23DN
 IQ/acOObLQ9kqusAPRd35WMVA61GCasZxHbbf22cKlSKu7g7bOMNI8boYDwiD5gVpsNP
 7J9vFPfH6GEEsfQZYAKPQWEbcnFhjUKJP+g/YlOchzJstPYW1Vn0bod/RZ1bYuYSp0O4
 uRFA==
X-Gm-Message-State: AOJu0YxcEeIW9EkBbxMkO4qqB8CXwNlaz5B1KXC49nl+K6nm6kkCGu51
 ts1V0UTI0oV31sxHMtnfIVsPYtBGdFJwJtWuz5rs+H3TQb3+MPSVZCMRs8ztrHfkF65E5ZGk9zV
 Pn1ga
X-Gm-Gg: ASbGnctus8jRgvMYiIQfLDM/KlplZVL4FqdeVIHLu7PiQVa2YUfIBoZ1hOgeYCTHh/U
 l99rlq57jBHWroC+aj8H1MqyZSQ/0kgL9frY1Ub+3QStKoLBSFGkeoSP8LWuctKvizDkGXiWW+4
 qMuNE1fIYTS7Dv1IYCVydpBUff9cIS4LPXcYRD4+TPb31JDyo/ncBpkPzkS6i40X8EBrPHVH6hf
 KMjaq4ZQuvRMN0OImBBQIlwqD/qNaEIHqGVzdMICzlzqlX7bDjvE7t7EIBQcKS1bF+1CrewlrBy
 sWET+1CXnzgtiBfdg6VlHWTeD+J1okvD67QFAic7E1KprWvg8mZ+yzPIUKXa9YjyCjQ9R+nmkXp
 HoBSSIBxNk+PKRIoPoS6zb/rI22PqJphFP7zzYcetd4HmBJ2jTQdgXlSCXZPUlA==
X-Google-Smtp-Source: AGHT+IGHEyMzDLHnzQHciMHaIbu69lnMMk7+RVLukf37bn55HtQ3ttGIzGUJtTnM2xZYk/wtJ98TGQ==
X-Received: by 2002:a05:6000:1845:b0:3ee:1494:27f5 with SMTP id
 ffacd0b85a97d-42666aad658mr8461025f8f.13.1760101544363; 
 Fri, 10 Oct 2025 06:05:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.05.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:05:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/76] target/arm: Implement dirtybit check for PIE
Date: Fri, 10 Oct 2025 14:04:23 +0100
Message-ID: <20251010130527.3921602-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Both S1PIE and S2PIE have a bit to make software tracking
of dirty pages easier.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-13-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h      |  1 +
 target/arm/ptw.c            | 16 ++++++++++++++++
 target/arm/tcg/tlb_helper.c | 12 +++++++++---
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index b59650959ec..69eb1df6173 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -752,6 +752,7 @@ struct ARMMMUFaultInfo {
     bool s1ptw;
     bool s1ns;
     bool ea;
+    bool dirtybit;  /* FEAT_S1PIE, FEAT_S2PIE */
 };
 
 /**
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 2e026a7c597..21540a1ec3e 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2343,6 +2343,22 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         goto do_fault;
     }
 
+    /* S1PIE and S2PIE both have a bit for software dirty page tracking. */
+    if (access_type == MMU_DATA_STORE && param.pie) {
+        /*
+         * For S1PIE, bit 7 is nDirty and both HA and HD are checked.
+         * For S2PIE, bit 7 is Dirty and only HD is checked.
+         */
+        bool bit7 = extract64(attrs, 7, 1);
+        if (regime_is_stage2(mmu_idx)
+            ? !bit7 && !param.hd
+            : bit7 && !(param.ha && param.hd)) {
+            fi->type = ARMFault_Permission;
+            fi->dirtybit = true;
+            goto do_fault;
+        }
+    }
+
     /* If FEAT_HAFDBS has made changes, update the PTE. */
     if (new_descriptor != descriptor) {
         new_descriptor = arm_casq_ptw(env, descriptor, new_descriptor, ptw, fi);
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 23c72a99f5c..ae2acd67276 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -24,13 +24,13 @@ bool arm_s1_regime_using_lpae_format(CPUARMState *env, ARMMMUIdx mmu_idx)
     return regime_using_lpae_format(env, mmu_idx);
 }
 
-static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
+static inline uint64_t merge_syn_data_abort(uint32_t template_syn,
                                             ARMMMUFaultInfo *fi,
                                             unsigned int target_el,
                                             bool same_el, bool is_write,
                                             int fsc)
 {
-    uint32_t syn;
+    uint64_t syn;
 
     /*
      * ISV is only set for stage-2 data aborts routed to EL2 and
@@ -75,6 +75,10 @@ static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
         /* Merge the runtime syndrome with the template syndrome.  */
         syn |= template_syn;
     }
+
+    /* Form ISS2 at the top of the syndrome. */
+    syn |= (uint64_t)fi->dirtybit << 37;
+
     return syn;
 }
 
@@ -176,7 +180,9 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr,
     int target_el = exception_target_el(env);
     int current_el = arm_current_el(env);
     bool same_el;
-    uint32_t syn, exc, fsr, fsc;
+    uint32_t exc, fsr, fsc;
+    uint64_t syn;
+
     /*
      * We know this must be a data or insn abort, and that
      * env->exception.syndrome contains the template syndrome set
-- 
2.43.0


