Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29154CA1000
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNyS-0006KR-3h; Sat, 30 Aug 2025 11:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQw-0007Kn-7Z
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:28 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQs-0004ui-2F
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:25 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b47173749dbso2059022a12.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532837; x=1757137637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fffkORVnYV9vwb7ZzaoscxQOChXjanmw50YJNQj3i8k=;
 b=AZwpWRA2fEpeiAz86VNOcpg9Oqq2GbALP9W8nPW2on9JZFCLpIqWtlUorHrQq7CHfn
 eLKgQJVcL5lMw1xNpleSF0NerbXdVQ+fEa8M4HLtEL/LJpp0DQY+f/jmCsR6Ewy0cJdd
 R0lomMSUET/iLfnMt+v+wPwCrSnOHcczuVVojoohB9ByGhBliFV0s9jJaKtwUsAOC4+Z
 sBIFanoZuq+KLNSTrlYgwxR7m1q2jhy76LpuNpYy0oxMbYl0s9009W5BQaWhvfCowvpZ
 zw47Yv2MT1O9zakJTPvq2kwzcFMdW8Z8+I7D+gsiNhhAndj70N38batTQXfzuSMDf10A
 oOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532837; x=1757137637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fffkORVnYV9vwb7ZzaoscxQOChXjanmw50YJNQj3i8k=;
 b=kNfi3/p36qKie5T3oO/c5dA4teFqpGEttb8fY0Xo3k9rWkfEdvOoblXnE0HndAWuDj
 vy4McUfmyHTeOnPg0LiC2E1OmXxNAO9HO+9qiWtINGIeDQ8UZqOBrpInJJvHaEXa3PuN
 lcntdNouTzEtRhjO+ab0fFuP0pOZKTjV9NLZxPnzJQDdgRztM43J/XJNKLMpcbOzMToG
 xaxAsqGqi+hjia5Cl8lYNuO5MZ042ZTqZDOwoRZD+TEkhKWimDzC6EMmom3wTiZrxXsH
 3s9AbmvX9YOELqcr/kERUl1S1TsQOTIe2yMFKAlb9+TK9jzFP3IM6iH9PR+92n+FY5lo
 gzYA==
X-Gm-Message-State: AOJu0YyGLYX8pEJGnV7zGRyySErSDZ7mdwc2K0+NDJBjh+XSd3Jaq2MK
 dCreykfr6lDjMIpuXFCVkUbCMGHsSM706m8dEolMb4e1S83Yk1R1nYyJ4USMDqLdOI5ET5hdiLL
 qCnqQK9c=
X-Gm-Gg: ASbGncsmKHtfITzfisT99fg5P9QRQ9XYjWHQIdSMUxOoc7E4xcuj6tZQKeM/yOcJJvk
 RY8UfVRHy0jK9SY09DGEdstlKnD6FPXkFAbz6V3Eat+Xq/GmWyMES3foQmtkDMLf8kMbHF96qPb
 NUSeK8iLNS+TYHg/b68boKGmdVRvK0adOqXIr6WHZglOCUGWjDuqjvyK9iWQje+AgtUcf6Z4Xv2
 k2eIu7LhaxoRoldBYbTjQBp42IGWlhYQcjLSdjIjikm57LhUcfs83exBA0wJs6rzmIthhK2LD73
 weVwwos5ITVrYfq8rRh8jpkR438sVCaLuB1o+0nX8eT7hWa81r7vxJn8yA9TOxatK0ksUbKUDBd
 yQuwv9mYW3NTBnzlXozg6TxM3Bkcb8cWr/HJPXmxan544t1fi3jq91vCPAYRgA8On0TDj17cDKA
 ==
X-Google-Smtp-Source: AGHT+IELHzHE3uV9dhyLVhlKwsisVPbxK5jP67qpallhzzbgIAIQrVgudEBhLQP27RXxs40uC983hA==
X-Received: by 2002:a17:902:db07:b0:248:f809:9322 with SMTP id
 d9443c01a7336-2494486e840mr19214275ad.12.1756532837519; 
 Fri, 29 Aug 2025 22:47:17 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:47:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 57/84] target/arm: Implement GCSSTR, GCSSTTR
Date: Sat, 30 Aug 2025 15:41:01 +1000
Message-ID: <20250830054128.448363-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Note that CreateAccDescGCS() does not enable tagchecked,
and Data Aborts from GCS instructions do not set iss.isv.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 42 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/a64.decode      |  3 +++
 2 files changed, 45 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1175d37c87..022a7c27e3 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -139,6 +139,12 @@ static int core_user_mem_index(DisasContext *s, bool unpriv)
     return arm_to_core_mmu_idx(arm_user_mem_index(s, unpriv));
 }
 
+/* For a given translation regime, return the core mmu_idx for gcs access. */
+static int core_gcs_mem_index(ARMMMUIdx armidx)
+{
+    return arm_to_core_mmu_idx(regime_to_gcs(armidx));
+}
+
 static void set_btype_raw(int val)
 {
     tcg_gen_st_i32(tcg_constant_i32(val), tcg_env,
@@ -3951,6 +3957,42 @@ static bool trans_STLR_i(DisasContext *s, arg_ldapr_stlr_i *a)
     return true;
 }
 
+static bool trans_GCSSTR(DisasContext *s, arg_GCSSTR *a)
+{
+    ARMMMUIdx armidx;
+
+    if (!dc_isar_feature(aa64_gcs, s)) {
+        return false;
+    }
+
+    /*
+     * The pseudocode for GCSSTTR is
+     *
+     *   effective_el = AArch64.IsUnprivAccessPriv() ? PSTATE.EL : EL0;
+     *   if (effective_el == PSTATE.EL) CheckGCSSTREnabled();
+     *
+     * We have cached the result of IsUnprivAccessPriv in DisasContext,
+     * but since we need the result of arm_user_mem_index anyway, use
+     * the mmu_idx test as a proxy for the effective_el test.
+     */
+    armidx = arm_user_mem_index(s, a->unpriv);
+    if (armidx == s->mmu_idx && s->gcsstr_el != 0) {
+        gen_exception_insn_el(s, 0, EXCP_UDEF,
+                              syn_gcs_gcsstr(a->rn, a->rt),
+                              s->gcsstr_el);
+        return true;
+    }
+
+    if (a->rn == 31) {
+        gen_check_sp_alignment(s);
+    }
+    tcg_gen_qemu_st_i64(cpu_reg(s, a->rt),
+                        clean_data_tbi(s, cpu_reg_sp(s, a->rn)),
+                        core_gcs_mem_index(armidx),
+                        finalize_memop(s, MO_64 | MO_ALIGN));
+    return true;
+}
+
 static bool trans_LD_mult(DisasContext *s, arg_ldst_mult *a)
 {
     TCGv_i64 clean_addr, tcg_rn, tcg_ebytes;
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 8283a9c83d..2ae73f443a 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -571,6 +571,9 @@ LDAPR_i         10 011001 10 0 ......... 00 ..... ..... @ldapr_stlr_i sign=1 ext
 LDAPR_i         00 011001 11 0 ......... 00 ..... ..... @ldapr_stlr_i sign=1 ext=1 sz=0
 LDAPR_i         01 011001 11 0 ......... 00 ..... ..... @ldapr_stlr_i sign=1 ext=1 sz=1
 
+# GCSSTR, GCSSTTR
+GCSSTR          11011001 000 11111 000 unpriv:1 11 rn:5 rt:5
+
 # Load/store multiple structures
 # The 4-bit opcode in [15:12] encodes repeat count and structure elements
 &ldst_mult      rm rn rt sz q p rpt selem
-- 
2.43.0


