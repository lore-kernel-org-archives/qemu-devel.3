Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2270C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLjn-0005Oi-Uj; Sat, 02 Aug 2025 19:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLho-0000AJ-54
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:32:01 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLhm-00057c-EZ
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:31:59 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2ffaa884a44so2080930fac.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177517; x=1754782317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TtfdJAKHkhBXVVur9KnTeJdEj0NKkUPLOFyccsCQyeU=;
 b=ja5tKzs6yXhp3ae36h5mQaZxwfZZJEfoxY1ZsAiosr0FKRKaFf6ZulY97coYxv6nN+
 jYmaeoVulsbej6EqlD/o2by0sE7oeUKXAWOmPaWsWo3SCWl0/47svLjTtab6xdEHZo+l
 8I08MGjnQUuXldGFQ7YH01UuL10tVWZQC8d/JKGqaJZMGNnnpwP4KYUj/aZQf9NlE1xf
 Otuit4h316JqEmGxIJ7bb/OeAOrOIJj2eB5ZPKQdpJDyYGX6bz2RTriJ/FtMc56yWN60
 wZmM2DcxoKV2I7cIwwFV+bmkHYOkJ+fplAXGwAbem0jOHwy62sYQjwjuUruga0VK/JeH
 DYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177517; x=1754782317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TtfdJAKHkhBXVVur9KnTeJdEj0NKkUPLOFyccsCQyeU=;
 b=w0A74bNyjnUJczKj+Hjb4J50TaJnDt+iQUg9aM70HK1CXTBI55x/hvzN2kx9XO0BcI
 AvrYhRprcCWUl2mywSlrZFV6jwsVQusrBEnPR+f8IdFB5+8Wz/9l9Uj0goKdowQc9sQ3
 KXauaRfO3bsnMivOe/WVUXN9PHnp1kc1n8Esfo/4LX/w/tUpyHV6BJ9P7opWF6vP0n1j
 iCH8dLPC1YI3RDFAcjbX71Zrny6YX4ODUWykw4xEQ7ebTHmlQtFRb+f1F8kU3xhbzVY4
 aSIfGvAyskuwr6k9AjRNEBmu5p5jBdQ8Tsjq+YTWhIeT/rOn4lD7C7+Qu78iKr6mM2qT
 IklQ==
X-Gm-Message-State: AOJu0Yyh06ablgIInl4Zv1CSCaE+uvQ05Hkgz6vNAcmhX84PnKchRUcx
 4cpLVbVWVsqQvl3PXmfZM7rJ3JSZIlKWnXqHnHlsWMoH0TZ0uQpHpF2+1kpwOaz42zywlXcc2M8
 GpMxzH6w=
X-Gm-Gg: ASbGncsCAcuXTO4UNybrrFQHkluwWiQWrr3M9DZyUnVf4hXOtIAh+Np46xYJKDiT9/e
 vtS3UL0Ze/GxRBKmg6/KN2JVCVwSyWHd5NfVaWFhvJIeTzOYiocr9vmZyf3m8RyCWXTFINrIzrt
 4Eex2VrkUtqIPx089qlA8UXx80ERurbSZ6H6QJ7PzNcfKjf/hbpXWbTydGLf3WN6UARALc+GUOH
 u2nJjRwwQqgly/NipCh3LuAEUgPtpYSXk7jluwc3MWJZjk/kgKwuzOmoHm+hs7/PjLF3T5ZumW/
 bvbWb2DcoJN67XG6COtnls7JdutrJ9JuZrbE78j0znH34ttnu+02LZlEnWP7rFlL0nryYowcFfA
 oJKyxwYZngpZGDJ0kaElISx/aIGwYQYyTw8g+c+mOjZn1R1Hpm5Ka
X-Google-Smtp-Source: AGHT+IGazccfX3NI/VYEnzo4AbEkGmch1ZTBvtJ6fLmfxKA3gMvnFQLPP+p/a9QEWaUbsXUWnGziEg==
X-Received: by 2002:a05:6870:a44a:b0:2eb:9fe5:d06c with SMTP id
 586e51a60fabf-30b6685b897mr2728877fac.3.1754177516873; 
 Sat, 02 Aug 2025 16:31:56 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30b8e3c9b32sm71031fac.24.2025.08.02.16.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:31:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 24/85] target/arm: Implement dirtybit check for PIE
Date: Sun,  3 Aug 2025 09:28:52 +1000
Message-ID: <20250802232953.413294-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Both S1PIE and S2PIE have a bit to make software tracking
of dirty pages easier.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h      |  1 +
 target/arm/ptw.c            | 16 ++++++++++++++++
 target/arm/tcg/tlb_helper.c | 12 +++++++++---
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index fc82dd65e8..b6499683cc 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -754,6 +754,7 @@ struct ARMMMUFaultInfo {
     bool s1ptw;
     bool s1ns;
     bool ea;
+    bool dirtybit;  /* FEAT_S1PIE, FEAT_S2PIE */
 };
 
 /**
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 323fc8052d..820d5e65a0 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2306,6 +2306,22 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
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
index 23c72a99f5..ae2acd6727 100644
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


