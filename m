Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F8BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 07:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1serJ8-0007Sp-Oq; Fri, 16 Aug 2024 03:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1serJ7-0007Mc-9M
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:23:33 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1serJ5-00043l-E2
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:23:32 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-201df0b2df4so15000015ad.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 00:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723793009; x=1724397809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kbgug2KmicUlkOb+wrePUsXTI50rlI7sMrXGG0mr2zY=;
 b=W94Y7PIN4osfRxMcN0WMG8/uBfuu0qjO1Q8PFhqHxeFy1QgKq3c1NV+LMi5RH1PwEl
 nRQ64kE/4ewupNJ7+lmcH8/ztA3eFQMM9H+W3qS6WBNQJsRIjgMijj6QW2FQlL1L4jod
 4D086qeCQOUaCLQNiSiOUIudNgvi3Z0j4Tfth7NLmFnOvJ5ed3U3Q/KWHaip0BPlsPmz
 EJ4dNqJS0GvsjxdECHnOr5bQzynoQ3yYYOhm7XQRtS37F1o1jC1T0f42M9wRK2Ap2CS/
 syx5IP2R6BNkFwZsH0o4vYTqr/pPcgys0qq5/6OVHrbChvcvhEzaDo3IQcaY6cy/rWw/
 agew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723793009; x=1724397809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kbgug2KmicUlkOb+wrePUsXTI50rlI7sMrXGG0mr2zY=;
 b=v6QsXgPTmZ8635RQ1rg3qzfftmf33LaiCklAwmtGnwimBmDORD6+hLb6snwcCV4v+F
 uGdw0YCZdGEPktVdzrtWUkvWW8VyNnBWO8XyzgHZ+hS1ra0Y+R1IsyuGCginE5JPWu2f
 iIh74aFhx11uxt2ZDmUEW00U8auztEOCbNyrwzd2/AFTMQAMmYK6wTKBVK7doVmRs2KS
 5mkPkBGIX8OVgzHwcE9HkTzbeB0T6slJBqE0ft1rXXSh1zaXCGDwEy00WkZhiXUPrAkH
 a3g/A8PfneBocW25ntOO1d1jI+RaYQCVyEqbWYQmUye4sNH2YjHkBcu/pIK90WVfU5PF
 EysQ==
X-Gm-Message-State: AOJu0YxgFT0UtwJE/QSgMwPsBT/wvcsXpL7JFyE814YrI3itTY2RbfT1
 yf5GMIxd9cqnLmIfTUY4heEuTz5wCxIIjnginPxZanzKtLy6VwjYU/EX16hsSA//MlRdTfReQUd
 2ipo=
X-Google-Smtp-Source: AGHT+IFqObAsAnQn0XVCwl1Bqnf2UjMwIkvpMiiTVmYVLPOkaqiP17I5jfgtmQ2wtcNkefvQRStzGQ==
X-Received: by 2002:a17:902:e849:b0:202:708:3443 with SMTP id
 d9443c01a7336-2020708378fmr16542325ad.27.1723793009453; 
 Fri, 16 Aug 2024 00:23:29 -0700 (PDT)
Received: from stoup.. (2403-580a-f89b-0-1b6b-8c7b-90f9-144f.ip6.aussiebb.net.
 [2403:580a:f89b:0:1b6b:8c7b:90f9:144f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f037588esm20195525ad.171.2024.08.16.00.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 00:23:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: chauser@pullman.com
Subject: [PATCH v3 5/6] target/sparc: Implement STDFQ
Date: Fri, 16 Aug 2024 17:23:10 +1000
Message-ID: <20240816072311.353234-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240816072311.353234-1-richard.henderson@linaro.org>
References: <20240816072311.353234-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Invalid encoding of addr should raise TT_ILL_INSN, so
check before supervisor, which might raise TT_PRIV_INSN.
Clear QNE after execution.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c  | 24 +++++++++++++++++++++++-
 target/sparc/insns.decode |  4 ++--
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index eb0158a11d..6d4c0e79c9 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4531,17 +4531,39 @@ TRANS(STQFA, 64, do_st_fpr, a, MO_128)
 
 static bool trans_STDFQ(DisasContext *dc, arg_STDFQ *a)
 {
+    TCGv addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
+
     if (!avail_32(dc)) {
         return false;
     }
+    if (addr == NULL) {
+        return false;
+    }
     if (!supervisor(dc)) {
         return raise_priv(dc);
     }
+#if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
     if (gen_trap_ifnofpu(dc)) {
         return true;
     }
-    gen_op_fpexception_im(dc, FSR_FTT_SEQ_ERROR);
+    if (dc->fsr_qne) {
+        TCGv_i64 fq = tcg_temp_new_i64();
+
+        /* Store the single element from the queue. */
+        tcg_gen_ld_i64(fq, tcg_env, offsetof(CPUSPARCState, fq.d));
+        tcg_gen_qemu_st_i64(fq, addr, dc->mem_idx, MO_TEUQ | MO_ALIGN_4);
+
+        /* Mark the queue empty, transitioning to fp_execute state. */
+        tcg_gen_st_i32(tcg_constant_i32(0), tcg_env,
+                       offsetof(CPUSPARCState, fsr_qne));
+        dc->fsr_qne = 0;
+    } else {
+        gen_op_fpexception_im(dc, FSR_FTT_SEQ_ERROR);
+    }
     return true;
+#else
+    qemu_build_not_reached();
+#endif
 }
 
 static bool trans_LDFSR(DisasContext *dc, arg_r_r_ri *a)
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index fbcb4f7aef..923f348580 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -644,8 +644,8 @@ STF         11 ..... 100100 ..... . .............          @r_r_ri_na
 STFSR       11 00000 100101 ..... . .............          @n_r_ri
 STXFSR      11 00001 100101 ..... . .............          @n_r_ri
 {
-  STQF      11 ..... 100110 ..... . .............          @q_r_ri_na
-  STDFQ     11 ----- 100110 ----- - -------------
+  STQF      11 ..... 100110 ..... . .............          @q_r_ri_na # v9
+  STDFQ     11 ..... 100110 ..... . .............          @r_r_ri    # v7,v8
 }
 STDF        11 ..... 100111 ..... . .............          @d_r_ri_na
 
-- 
2.43.0


