Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FE3C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 14:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2B6E-0002lB-09; Wed, 01 May 2024 10:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5p-0002hD-8U
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:37:58 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5n-00029n-An
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:37:56 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1eca195a7c8so4142935ad.2
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 07:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714574273; x=1715179073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QUzW5EpE6psTv3wNqcRJ2QohJfV0nsRef4r1zjcLMwE=;
 b=e7wVBdtFg43+oaXJphjrT4q2pWqM+9pGQmMKYGY4PLDaMZJkfHPcleEUuRmbU3EE3F
 bJZ9rbnTImOP2M6Eb+5mfOygjd22uDi6+lSUWm9icAjf5jiPQZ6Sts/eBLSycG2xAwyM
 iGiUvKiI4OTx343U215o4OJKcXzFy2tGc48IC/9kJ+ZwRCD3zzFmBUppGv6xrjSwWECW
 snmKSNRLz7M14OG2IHQr62o2cZWsyBp8+oA5gCoqoWEnH506Jte3oCqvEAUh0B8i1jj3
 mp6sTRF4XmLtD/Y0MsS9e+A8aIvvsP+iq5WnWwwm7lxMSKSUFPcho7J1v+b6Vdzo4m0I
 v8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714574273; x=1715179073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QUzW5EpE6psTv3wNqcRJ2QohJfV0nsRef4r1zjcLMwE=;
 b=cGcFtZ3AsMtcdNrQkCMSf9WVQWQYJqpVApkOhxHRHbg8FX9t2sj0TBpaQEldOSapbb
 hJWt2O49gS7ltd+tO6Vj5SfUhPI7+uzBxeC6H4T1/vDd04eYmcbyHvGu4xdJxk5JL4dg
 vlUP4pl2hIlTkk6PZyfZzt2s/Z6GRP7Ugfqr27WCmRfPoBOnTKWGLS2qYXipJqZFXuFp
 WtRXLY2F3s142/QK8B/CNpmf/7ai7SNhgLBFW8qaC1zbNUE478ONX/AXbhCoGFaF8APz
 PKj3ivOUx+IToIbUsKYZdtD3mYoNFp2ZtFE6qufNr8MOv46c6a3YEiZ+cO7F9AkK9fhE
 Wrpw==
X-Gm-Message-State: AOJu0YythhqtcOcHILrUv5u0My4g1lKbp3lCesqTTCt/4wvLH641JMDA
 0xa/RA18x/u7QKEEkndgjQ6rcXsfj73vIQ9Vs+fJZevYgWMd6ono7ratlr2o3pIJUe4jkRS6bNm
 p
X-Google-Smtp-Source: AGHT+IFlINeIyPCcmHH/dcjF1LA/M7svdp1OqMk2GeUqrNmqYh9ADWd7ZoYmX4F7SUxCs4RaC8+eGg==
X-Received: by 2002:a17:902:e892:b0:1eb:c3d4:349c with SMTP id
 w18-20020a170902e89200b001ebc3d4349cmr2785867plg.30.1714574273495; 
 Wed, 01 May 2024 07:37:53 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a170902f54c00b001ebd73f61fcsm5751573plf.121.2024.05.01.07.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 07:37:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 13/20] tcg: Remove INDEX_op_plugin_cb_{start,end}
Date: Wed,  1 May 2024 07:37:32 -0700
Message-Id: <20240501143739.10541-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501143739.10541-1-richard.henderson@linaro.org>
References: <20240501143739.10541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

These opcodes are no longer used.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h |  2 --
 include/tcg/tcg-opc.h       |  2 --
 accel/tcg/plugin-gen.c      | 18 ------------------
 tcg/tcg-op.c                | 10 ----------
 4 files changed, 32 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 72b80b20d0..009e2778c5 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -76,8 +76,6 @@ void tcg_gen_lookup_and_goto_ptr(void);
 
 void tcg_gen_plugin_cb(unsigned from);
 void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
-void tcg_gen_plugin_cb_start(unsigned from, unsigned type, unsigned wr);
-void tcg_gen_plugin_cb_end(void);
 
 /* 32 bit ops */
 
diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index be9e36e386..546eb49c11 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -199,8 +199,6 @@ DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
 
 DEF(plugin_cb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(plugin_mem_cb, 0, 1, 1, TCG_OPF_NOT_PRESENT)
-DEF(plugin_cb_start, 0, 0, 3, TCG_OPF_NOT_PRESENT)
-DEF(plugin_cb_end, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 
 /* Replicate ld/st ops for 32 and 64-bit guest addresses. */
 DEF(qemu_ld_a32_i32, 1, 1, 1,
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index fb77585ac0..d9ee9bb2ec 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -52,29 +52,11 @@
 #include "exec/plugin-gen.h"
 #include "exec/translator.h"
 
-/*
- * plugin_cb_start TCG op args[]:
- * 0: enum plugin_gen_from
- * 1: enum plugin_gen_cb
- * 2: set to 1 for mem callback that is a write, 0 otherwise.
- */
-
 enum plugin_gen_from {
     PLUGIN_GEN_FROM_TB,
     PLUGIN_GEN_FROM_INSN,
     PLUGIN_GEN_AFTER_INSN,
     PLUGIN_GEN_AFTER_TB,
-    PLUGIN_GEN_N_FROMS,
-};
-
-enum plugin_gen_cb {
-    PLUGIN_GEN_CB_UDATA,
-    PLUGIN_GEN_CB_UDATA_R,
-    PLUGIN_GEN_CB_INLINE,
-    PLUGIN_GEN_CB_MEM,
-    PLUGIN_GEN_ENABLE_MEM_HELPER,
-    PLUGIN_GEN_DISABLE_MEM_HELPER,
-    PLUGIN_GEN_N_CBS,
 };
 
 static void plugin_gen_empty_callback(enum plugin_gen_from from)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 0ae12fa49d..eff3728622 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -322,16 +322,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     tcg_gen_op2(INDEX_op_plugin_mem_cb, tcgv_i64_arg(addr), meminfo);
 }
 
-void tcg_gen_plugin_cb_start(unsigned from, unsigned type, unsigned wr)
-{
-    tcg_gen_op3(INDEX_op_plugin_cb_start, from, type, wr);
-}
-
-void tcg_gen_plugin_cb_end(void)
-{
-    tcg_emit_op(INDEX_op_plugin_cb_end, 0);
-}
-
 /* 32 bit ops */
 
 void tcg_gen_discard_i32(TCGv_i32 arg)
-- 
2.34.1


