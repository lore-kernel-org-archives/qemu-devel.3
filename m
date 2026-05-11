Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47771CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRDY-0004gJ-4K; Mon, 11 May 2026 10:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wMRCJ-0003xP-Cs
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:01:35 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wMRCA-000643-L7
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:01:23 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7de7c57b52cso3527293a34.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778508075; x=1779112875; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JBnR4ZVm8fhrjiMTwdEiXk++2/68t2Ii5JMtq9oYUgw=;
 b=gBLvTuaYFyc+miV3DrP+5f5lGDxvVnFvTsk0fNcPa55V3KP9BNwvYVS8e3T36CZYbs
 /qnAFYJCjQ3qD9rER516HNgnjRaLZrre4u7kENJsfvffGYpeyyuGJBsZvfWDDB/2Fncd
 qOT0QDQwSOJ4OQ7+BI+BVPUMMkWYn0AmIk3pkKwyEivX6QSDWzyDs0DqeMQCmbfSD4hA
 n+lc55G7NtrPFbqzk4dj5r25rPo91vrffPsRMGXRgNzEUYUeEWK0ipPRFHhfvohzxQvP
 fUqosbJWYVMSsje8GSXn4oBnk6ITVAK+UgN913fqpcEctRfMXJlzcbrlH8sfuYwD8zDS
 aCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508075; x=1779112875;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JBnR4ZVm8fhrjiMTwdEiXk++2/68t2Ii5JMtq9oYUgw=;
 b=fug6Kwlg2MgSbO9f9N+M13d/Qe+RiOa+ZfJQSfWgStjcmgTPu5cELKJMA23yp4uiVn
 qaIdby5e5ec12k8NjVQq7sUXHKctW661g3sy0dem3FQdaUs/gztq4fjnKwN6wcWLAHVQ
 urAdG966Jhig8F2e7kTDwstlyRU1IZAmjXSzsB2sI62cxt8fkUHv+BgEK03swBzlLAxd
 D36Yo45XtZqHy7TBprYjhNAjmZ2CkD6Bxrs9/HpsqYttK1DCkQHoyuOm4cATm66mXIlp
 T++c/sUpiVOlJIUwqgjc1DcNrLixIJUvodS5YLM/PnzNbHsHV2My72T1fpkVeLctWQks
 uwOQ==
X-Gm-Message-State: AOJu0YwF3Y+0YcXu7Al109fkDCidbF/o1MTydzMY+1f0fCI5figRpmHh
 jMnHs8Hp3iQ5JQKbC3F7CPz6h+KbogDGpRjcI+MqL5iGmRJrN2Pspz8w
X-Gm-Gg: Acq92OFBPSY8YX53Qo+NXYuRfD9lEpYOSk44SfvxRJxSO/pAWEBSaKmIAmgz0SWehs3
 G8WpqeLzfZ6BV9Ud1jRNcWykcpG1sQQGMvPc99BWr/6E0+IRWUP0p3WIPp4ojdQk2IL/JqZZr7J
 g0QpAUCX9Od57I9txx1kwudLt+tce0Y5Pfq3WIHEXOEsAwJ13W1G3csxdCe5rdwiysJC8hsaVc7
 QZS8D08DBOFraHaueqa/zEhx/fiBmXiQKFsS7s/d/fg05DmKa2cC32esXFhTUbCLfHWw4AIPRv9
 Awyhr/izfJj76R7Ao0NfKDqax1rE3fBJF4CZrg0Yyw8SeoiaoosKVpbX+CVon7grrXUWMZCDk81
 gnJHmcz+J8KkKbW0MesKYv1BQEn3qTdRjlQ9TdNKhhg+h4+cVVr7kqzZ48nF/emlI6WBDVn/f4m
 rtmUBs8ThTx3S31SqU4vXVm6mkxmgHF52gR9ILQVp/
X-Received: by 2002:a05:6830:82f2:b0:7dc:db3c:1d63 with SMTP id
 46e09a7af769-7e1df1f786fmr14365198a34.24.1778508074871; 
 Mon, 11 May 2026 07:01:14 -0700 (PDT)
Received: from [192.168.1.160] ([2600:4041:54f3:a400:c013:3550:ed5f:a59a])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c7dd09sm94773756d6.31.2026.05.11.07.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 07:01:14 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 11 May 2026 10:01:04 -0400
Subject: [PATCH v6 06/15] target/arm: add MTX to MTEDESC and DisasContext
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-feat-mte4-v6-6-8557cc1313b9@gmail.com>
References: <20260511-feat-mte4-v6-0-8557cc1313b9@gmail.com>
In-Reply-To: <20260511-feat-mte4-v6-0-8557cc1313b9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778508062; l=5381;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=2E2Zs8EcdJv+NH2+oioAGSfvt6XdJ2K43JuJsPWcvmE=;
 b=sVvgNmhZxauciT7WdyES3MlTULt6J+WzxZ90pFWWYnB7gzPi7Tl80WQLVHdoLxIkUJzI8hB5I
 tO+5OrhHB3tDmxavEyMnLjh4ZU14DumzzLbPM7TnYZYPpnUJiMz52Ee
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=brookmangabriel@gmail.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add fields for MTX to DisasContext and MTEDESC. With MTE4, the fields
will be needed in future patches that alter tag check, tag load and tag
store behavior.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h               | 1 +
 target/arm/tcg/hflags.c        | 2 ++
 target/arm/tcg/translate-a64.c | 7 +++++++
 target/arm/tcg/translate.h     | 1 +
 4 files changed, 11 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index fce0bde168..8ef01c82b3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2533,6 +2533,7 @@ FIELD(TBFLAG_A64, GCS_RVCEN, 42, 1)
 FIELD(TBFLAG_A64, GCSSTR_EL, 43, 2)
 FIELD(TBFLAG_A64, MTE_STORE_ONLY, 45, 1)
 FIELD(TBFLAG_A64, MTE0_STORE_ONLY, 46, 1)
+FIELD(TBFLAG_A64, MTX, 47, 2)
 
 /*
  * Helpers for using the above. Note that only the A64 accessors use
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 9fa63cd568..5789d7aeb8 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -462,6 +462,8 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         }
         /* Cache TCMA as well as TBI. */
         DP_TBFLAG_A64(flags, TCMA, aa64_va_parameter_tcma(tcr, mmu_idx));
+        /* Cache MTX. */
+        DP_TBFLAG_A64(flags, MTX, mtx);
     }
 
     if (cpu_isar_feature(aa64_gcs, env_archcpu(env))) {
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ce6249649a..cd86178d56 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -312,6 +312,7 @@ static TCGv_i64 gen_mte_check1_mmuidx(DisasContext *s, TCGv_i64 addr,
         desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
         desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
         desc = FIELD_DP32(desc, MTEDESC, ALIGN, memop_alignment_bits(memop));
+        desc = FIELD_DP32(desc, MTEDESC, MTX, s->mtx);
         desc = FIELD_DP32(desc, MTEDESC, SIZEM1, memop_size(memop) - 1);
 
         ret = tcg_temp_new_i64();
@@ -345,6 +346,7 @@ TCGv_i64 gen_mte_checkN(DisasContext *s, TCGv_i64 addr, bool is_write,
         desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
         desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
         desc = FIELD_DP32(desc, MTEDESC, ALIGN, memop_alignment_bits(single_mop));
+        desc = FIELD_DP32(desc, MTEDESC, MTX, s->mtx);
         desc = FIELD_DP32(desc, MTEDESC, SIZEM1, total_size - 1);
 
         ret = tcg_temp_new_i64();
@@ -3003,6 +3005,7 @@ static void handle_sys(DisasContext *s, bool isread,
             desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
             desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
             desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
+            desc = FIELD_DP32(desc, MTEDESC, MTX, s->mtx);
 
             tcg_rt = tcg_temp_new_i64();
             gen_helper_mte_check_zva(tcg_rt, tcg_env,
@@ -4873,6 +4876,7 @@ static bool do_SET(DisasContext *s, arg_set *a, bool is_epilogue,
         desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
         desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
         desc = FIELD_DP32(desc, MTEDESC, WRITE, true);
+        desc = FIELD_DP32(desc, MTEDESC, MTX, s->mtx);
         /* SIZEM1 and ALIGN we leave 0 (byte write) */
     }
     /* The helper function always needs the memidx even with MTE disabled */
@@ -4927,11 +4931,13 @@ static bool do_CPY(DisasContext *s, arg_cpy *a, bool is_epilogue, CpyFn fn)
     if (s->mte_active[runpriv]) {
         rdesc = FIELD_DP32(rdesc, MTEDESC, TBI, s->tbid);
         rdesc = FIELD_DP32(rdesc, MTEDESC, TCMA, s->tcma);
+        rdesc = FIELD_DP32(rdesc, MTEDESC, MTX, s->mtx);
     }
     if (s->mte_active[wunpriv]) {
         wdesc = FIELD_DP32(wdesc, MTEDESC, TBI, s->tbid);
         wdesc = FIELD_DP32(wdesc, MTEDESC, TCMA, s->tcma);
         wdesc = FIELD_DP32(wdesc, MTEDESC, WRITE, true);
+        wdesc = FIELD_DP32(wdesc, MTEDESC, MTX, s->mtx);
     }
     /* The helper function needs these parts of the descriptor regardless */
     rdesc = FIELD_DP32(rdesc, MTEDESC, MIDX, rmemidx);
@@ -10701,6 +10707,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->mte_active[1] = EX_TBFLAG_A64(tb_flags, MTE0_ACTIVE);
     dc->mte_store_only[0] = EX_TBFLAG_A64(tb_flags, MTE_STORE_ONLY);
     dc->mte_store_only[1] = EX_TBFLAG_A64(tb_flags, MTE0_STORE_ONLY);
+    dc->mtx = EX_TBFLAG_A64(tb_flags, MTX);
     dc->pstate_sm = EX_TBFLAG_A64(tb_flags, PSTATE_SM);
     dc->pstate_za = EX_TBFLAG_A64(tb_flags, PSTATE_ZA);
     dc->sme_trap_nonstreaming = EX_TBFLAG_A64(tb_flags, SME_TRAP_NONSTREAMING);
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index c74a4f6675..75d1b0fbd9 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -82,6 +82,7 @@ typedef struct DisasContext {
     uint8_t tbii;      /* TBI1|TBI0 for insns */
     uint8_t tbid;      /* TBI1|TBI0 for data */
     uint8_t tcma;      /* TCMA1|TCMA0 for MTE */
+    uint8_t mtx;       /* MTX1|MTX0 for MTE */
     bool ns;        /* Use non-secure CPREG bank on access */
     int fp_excp_el; /* FP exception EL or 0 if enabled */
     int sve_excp_el; /* SVE exception EL or 0 if enabled */

-- 
2.54.0


