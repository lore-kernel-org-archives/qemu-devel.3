Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9606CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1o-0004oy-6d; Mon, 01 Sep 2025 23:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1l-0004ct-HF
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1e-0004f6-Ae
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:49 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Rok9012516
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 odlSiS+rcvfGScBqQl/2ZTBdoBcRPzOiwcEO95H2Szk=; b=T7FHzg3055OWyLQJ
 z8JW3bKsN/LULkScvnR0vM18L51JAbENM++WMFwii/AhWVfesJt8dERCMvetOStN
 n3jI+buRJK17MlHnc9/KrMat2ymWz+AwYkCBBkTYbg6XcoBryp3ShbQ8xH1CdKvS
 iDZ6MOM3ts0NVNSLjH0cCzmmIur85SBGScXwo7m2uWAThgPmc44R4+UvgnmwVK5A
 zXd1EH92g/gNMUVlFr5gfJTyBNnw/X6XGyHTaGZNs4fDVsiR33+9IpTzzRXrvm1E
 CzKgSZjuAgnFsrIpZdA4MtYvd7VWpKpVlIXBQYqIzbNS3xkkmoezJwLie5cESxPc
 r6XzbA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0eeja1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:30 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3274f7e6c1fso5175918a91.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784969; x=1757389769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=odlSiS+rcvfGScBqQl/2ZTBdoBcRPzOiwcEO95H2Szk=;
 b=Wfn1Go21QmDKKyOArTXD7Sd2gEPuL7J+wMY4AMVhHLbmxBv6eas1h4ifIryTVMdQAC
 fAU+2hAnDGRamHwepNmMDWdYupwqCXAk89krFohkEJMNuxUYgF7RElmgA2pZSZMcEGdi
 2+UaKvvrxE4tKifbAIIOEbGYrCtfNPGCLIVWSzHkXfBcDtDKLKJjQQNnPUNV6i0HGOV6
 +W9lbEKdUw9gTbpeq0UVne2zFsx7uofcYHcAzujztBaVls6F2AAPB84Sd8pnAKEnEZ26
 xyi6pHnU6Fm3FcAk20xOxX6mEd9hEYbFcQcBVxixHsBN+zgcckYgadAxDL60c4JsRvbt
 T4oA==
X-Gm-Message-State: AOJu0YwkFZLQbSBGJKmjDHpTvzbq3b0wgNwcLABrFthgtdLgXUfagJOn
 974jCujTVuuoyC6hyCUQatjy9Hl93bAiEGc9+YeEgugHVe1wSJ+BIuh8yoFugK+mOoQQGsaKob6
 Ob6pTuvsfXCNsZaI4a2D724tQiufFzamkcyHHpZHf//dyzfKpoGTnNYYlUnhPkbkiP0LR
X-Gm-Gg: ASbGncs4aBZhx922qZGlZmBwq2TM8vDrU724PkANixbjST7J4oD6CIWfh96Tpr6htCX
 ahQ5BXZ5x0PnqtYBB9g40+wxjPuXo+3URZa2+hd8BgdW9ZCCwF17a0zfLxhj259IOxn2C0T4Ie1
 0k3o0yKZZRYosmvql/TZdPa+swi0ZgelQho2G380ggn2CKZCsq3aq+UywWiK1lYDYK9HIJzUZQf
 e69r3p06XF4IOl77Vh0e0c2OD7Ixp43TubbDPqH5PQ/ogoi2hL7uYvIJURMGwnt25ZcxCwtxlAS
 WHImiqNxH/uhr6esemm7AGna71qX4DlIEECLMsAHN3RDpTzfCtmv5cEBflMN46bUuwndE8r/m+/
 6gxGvcGPn+bYo
X-Received: by 2002:a17:90b:2ec8:b0:327:5081:d5d0 with SMTP id
 98e67ed59e1d1-328156bac3dmr13404866a91.19.1756784969370; 
 Mon, 01 Sep 2025 20:49:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR9+T75fORHH+wbdFXW8zCMda6dNO1WwyXLi77RQ6MtVMh2oRScSMBSuvBQS5OtehYZzXjEg==
X-Received: by 2002:a17:90b:2ec8:b0:327:5081:d5d0 with SMTP id
 98e67ed59e1d1-328156bac3dmr13404831a91.19.1756784968778; 
 Mon, 01 Sep 2025 20:49:28 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:28 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 30/39] target/hexagon: Add next_PC, {s,g}reg writes
Date: Mon,  1 Sep 2025 20:48:38 -0700
Message-Id: <20250902034847.1948010-31-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qjTlhruIvykvi7Duy8Hr7s8pDQwcjm8h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX6YShhM6xTMba
 XXBzkhBnRKG/IUOKSy2N22OW8wVmuZxGrFsiXazHcrnkMupKBduR5k7//W3Ocu34ESqtoY7IvNC
 4rCg1GPanVyTJYwmqU8zTtsB6kVOATGlbZ84CKzonxRboYFO/EzHPgm8PLEhgTNNAAhK7Xchy/1
 bNPh+S7WqBzDfdp14wSFsvvlsD/cnxk1OmbChEDkNswuYj/GhbHOW/WxZrvkO7HgsV/au1J5jeI
 e/Mxmo5eNmCO4aeKTMmrVorC/DKhwUlpWMkh2OUnFO7Akot+6LsAN/Zjnw/Y1AP8gBO8ngtvAU/
 XwtKdl9U7LCIfkvi4MLvwfz9JNz8R/CmWX41dzERl0FsoLAuiGRvi+gdfgIqcbb7+EwSePZ1ssY
 1vq+uoLo
X-Proofpoint-ORIG-GUID: qjTlhruIvykvi7Duy8Hr7s8pDQwcjm8h
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b6694a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=2idpCataKItiPf5XX10A:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Brian Cain <bcain@quicinc.com>

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/translate.h |   2 +
 target/hexagon/genptr.c    |   7 +-
 target/hexagon/translate.c | 134 ++++++++++++++++++++++++++++++++-----
 3 files changed, 123 insertions(+), 20 deletions(-)

diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index 08194a3309..95f570c02a 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -85,6 +85,7 @@ typedef struct DisasContext {
     TCGv dczero_addr;
     bool pcycle_enabled;
     bool pkt_ends_tb;
+    bool need_next_pc;
     uint32_t num_cycles;
 } DisasContext;
 
@@ -306,6 +307,7 @@ static inline void ctx_log_qreg_read(DisasContext *ctx,
 }
 
 extern TCGv hex_gpr[TOTAL_PER_THREAD_REGS];
+extern TCGv hex_next_PC;
 extern TCGv hex_pred[NUM_PREGS];
 extern TCGv hex_slot_cancelled;
 extern TCGv hex_new_value_usr;
diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index 0648daefb6..ca41ddf0e9 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -613,14 +613,15 @@ static void gen_write_new_pc_addr(DisasContext *ctx, TCGv addr,
         tcg_gen_brcondi_tl(cond, pred, 0, pred_false);
     }
 
+    TCGv PC_wr = ctx->need_next_pc ? hex_next_PC : hex_gpr[HEX_REG_PC];
     if (ctx->pkt->pkt_has_multi_cof) {
         /* If there are multiple branches in a packet, ignore the second one */
-        tcg_gen_movcond_tl(TCG_COND_NE, hex_gpr[HEX_REG_PC],
+        tcg_gen_movcond_tl(TCG_COND_NE, PC_wr,
                            ctx->branch_taken, tcg_constant_tl(0),
-                           hex_gpr[HEX_REG_PC], addr);
+                           PC_wr, addr);
         tcg_gen_movi_tl(ctx->branch_taken, 1);
     } else {
-        tcg_gen_mov_tl(hex_gpr[HEX_REG_PC], addr);
+        tcg_gen_mov_tl(PC_wr, addr);
     }
 
     if (cond != TCG_COND_ALWAYS) {
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 92adc60d1a..70e0a1ff33 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -49,6 +49,7 @@ static const AnalyzeInsn opcode_analyze[XX_LAST_OPCODE] = {
 TCGv hex_gpr[TOTAL_PER_THREAD_REGS];
 TCGv hex_pred[NUM_PREGS];
 TCGv hex_slot_cancelled;
+TCGv hex_next_PC;
 TCGv hex_new_value_usr;
 TCGv hex_store_addr[STORES_MAX];
 TCGv hex_store_width[STORES_MAX];
@@ -61,6 +62,7 @@ TCGv_i64 hex_cycle_count;
 TCGv hex_vstore_addr[VSTORES_MAX];
 TCGv hex_vstore_size[VSTORES_MAX];
 TCGv hex_vstore_pending[VSTORES_MAX];
+static bool need_next_PC(DisasContext *ctx);
 
 #ifndef CONFIG_USER_ONLY
 TCGv hex_greg[NUM_GREGS];
@@ -183,6 +185,9 @@ static void gen_end_tb(DisasContext *ctx)
 
     gen_exec_counters(ctx);
 
+    if (ctx->need_next_pc) {
+        tcg_gen_mov_tl(hex_gpr[HEX_REG_PC], hex_next_PC);
+    }
     if (ctx->branch_cond != TCG_COND_NEVER) {
         if (ctx->branch_cond != TCG_COND_ALWAYS) {
             TCGLabel *skip = gen_new_label();
@@ -368,18 +373,24 @@ static bool pkt_ends_tb(Packet *pkt)
 static bool need_next_PC(DisasContext *ctx)
 {
     Packet *pkt = ctx->pkt;
-
-    /* Check for conditional control flow or HW loop end */
-    for (int i = 0; i < pkt->num_insns; i++) {
-        uint16_t opcode = pkt->insn[i].opcode;
-        if (GET_ATTRIB(opcode, A_CONDEXEC) && GET_ATTRIB(opcode, A_COF)) {
-            return true;
-        }
-        if (GET_ATTRIB(opcode, A_HWLOOP0_END) ||
-            GET_ATTRIB(opcode, A_HWLOOP1_END)) {
-            return true;
+    if (pkt->pkt_has_cof || ctx->pkt_ends_tb) {
+        for (int i = 0; i < pkt->num_insns; i++) {
+            uint16_t opcode = pkt->insn[i].opcode;
+            if ((GET_ATTRIB(opcode, A_CONDEXEC) && GET_ATTRIB(opcode, A_COF)) ||
+                GET_ATTRIB(opcode, A_HWLOOP0_END) ||
+                GET_ATTRIB(opcode, A_HWLOOP1_END)) {
+                return true;
+            }
         }
     }
+    /*
+     * We end the TB on some instructions that do not change the flow (for
+     * other reasons). In these cases, we must set pc too, as the insn won't
+     * do it themselves.
+     */
+    if (ctx->pkt_ends_tb && !check_for_attrib(pkt, A_COF)) {
+        return true;
+    }
     return false;
 }
 
@@ -531,6 +542,10 @@ static void gen_start_packet(DisasContext *ctx)
     ctx->reg_log_idx = 0;
     bitmap_zero(ctx->regs_written, TOTAL_PER_THREAD_REGS);
     bitmap_zero(ctx->predicated_regs, TOTAL_PER_THREAD_REGS);
+#ifndef CONFIG_USER_ONLY
+    ctx->greg_log_idx = 0;
+    ctx->sreg_log_idx = 0;
+#endif
     ctx->preg_log_idx = 0;
     bitmap_zero(ctx->pregs_written, NUM_PREGS);
     ctx->future_vregs_idx = 0;
@@ -563,21 +578,41 @@ static void gen_start_packet(DisasContext *ctx)
      * gen phase, so clear it again.
      */
     bitmap_zero(ctx->pregs_written, NUM_PREGS);
+#ifndef CONFIG_USER_ONLY
+    for (i = 0; i < NUM_SREGS; i++) {
+        ctx->t_sreg_new_value[i] = NULL;
+    }
+    for (i = 0; i < ctx->sreg_log_idx; i++) {
+        int reg_num = ctx->sreg_log[i];
+        if (reg_num < HEX_SREG_GLB_START) {
+            ctx->t_sreg_new_value[reg_num] = tcg_temp_new();
+            tcg_gen_mov_tl(ctx->t_sreg_new_value[reg_num], hex_t_sreg[reg_num]);
+        }
+    }
+    for (i = 0; i < NUM_GREGS; i++) {
+        ctx->greg_new_value[i] = NULL;
+    }
+    for (i = 0; i < ctx->greg_log_idx; i++) {
+        int reg_num = ctx->greg_log[i];
+        ctx->greg_new_value[reg_num] = tcg_temp_new();
+    }
+#endif
 
     /* Initialize the runtime state for packet semantics */
     if (need_slot_cancelled(pkt)) {
         tcg_gen_movi_tl(hex_slot_cancelled, 0);
     }
     ctx->branch_taken = NULL;
-    ctx->pkt_ends_tb = pkt_ends_tb(pkt);
     if (pkt->pkt_has_cof) {
         ctx->branch_taken = tcg_temp_new();
-        if (pkt->pkt_has_multi_cof) {
-            tcg_gen_movi_tl(ctx->branch_taken, 0);
-        }
-        if (need_next_PC(ctx)) {
-            tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], next_PC);
-        }
+    }
+    if (pkt->pkt_has_multi_cof) {
+        tcg_gen_movi_tl(ctx->branch_taken, 0);
+    }
+    ctx->pkt_ends_tb = pkt_ends_tb(pkt);
+    ctx->need_next_pc = need_next_PC(ctx);
+    if (ctx->need_next_pc) {
+        tcg_gen_movi_tl(hex_next_PC, next_PC);
     }
 
     /* Preload the predicated registers into get_result_gpr(ctx, i) */
@@ -713,6 +748,59 @@ static void gen_reg_writes(DisasContext *ctx)
     }
 }
 
+#ifndef CONFIG_USER_ONLY
+static void gen_greg_writes(DisasContext *ctx)
+{
+    int i;
+
+    for (i = 0; i < ctx->greg_log_idx; i++) {
+        int reg_num = ctx->greg_log[i];
+
+        tcg_gen_mov_tl(hex_greg[reg_num], ctx->greg_new_value[reg_num]);
+    }
+}
+
+
+static void gen_sreg_writes(DisasContext *ctx)
+{
+    int i;
+
+    TCGv old_reg = tcg_temp_new();
+    for (i = 0; i < ctx->sreg_log_idx; i++) {
+        int reg_num = ctx->sreg_log[i];
+
+        if (reg_num == HEX_SREG_SSR) {
+            tcg_gen_mov_tl(old_reg, hex_t_sreg[reg_num]);
+            tcg_gen_mov_tl(hex_t_sreg[reg_num], ctx->t_sreg_new_value[reg_num]);
+            gen_helper_modify_ssr(tcg_env, ctx->t_sreg_new_value[reg_num],
+                                  old_reg);
+            /* This can change processor state, so end the TB */
+            ctx->base.is_jmp = DISAS_NORETURN;
+        } else if ((reg_num == HEX_SREG_STID) ||
+                   (reg_num == HEX_SREG_IMASK) ||
+                   (reg_num == HEX_SREG_IPENDAD)) {
+            if (reg_num < HEX_SREG_GLB_START) {
+                tcg_gen_mov_tl(old_reg, hex_t_sreg[reg_num]);
+                tcg_gen_mov_tl(hex_t_sreg[reg_num],
+                               ctx->t_sreg_new_value[reg_num]);
+            }
+            /* This can change the interrupt state, so end the TB */
+            gen_helper_pending_interrupt(tcg_env);
+            ctx->base.is_jmp = DISAS_NORETURN;
+        } else if ((reg_num == HEX_SREG_BESTWAIT) ||
+                   (reg_num == HEX_SREG_SCHEDCFG)) {
+            /* This can trigger resched interrupt, so end the TB */
+            gen_helper_resched(tcg_env);
+            ctx->base.is_jmp = DISAS_NORETURN;
+        }
+
+        if (reg_num < HEX_SREG_GLB_START) {
+            tcg_gen_mov_tl(hex_t_sreg[reg_num], ctx->t_sreg_new_value[reg_num]);
+        }
+    }
+}
+#endif
+
 static void gen_pred_writes(DisasContext *ctx)
 {
     /* Early exit if not needed or the log is empty */
@@ -1012,6 +1100,10 @@ static void gen_commit_packet(DisasContext *ctx)
     process_store_log(ctx);
 
     gen_reg_writes(ctx);
+#if !defined(CONFIG_USER_ONLY)
+    gen_greg_writes(ctx);
+    gen_sreg_writes(ctx);
+#endif
     gen_pred_writes(ctx);
     if (pkt->pkt_has_hvx) {
         gen_commit_hvx(ctx);
@@ -1073,6 +1165,7 @@ static void hexagon_tr_init_disas_context(DisasContextBase *dcbase,
     ctx->is_tight_loop = FIELD_EX32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP);
     ctx->short_circuit = hex_cpu->short_circuit;
     ctx->pcycle_enabled = FIELD_EX32(hex_flags, TB_FLAGS, PCYCLE_ENABLED);
+    ctx->need_next_pc = false;
 }
 
 static void hexagon_tr_tb_start(DisasContextBase *db, CPUState *cpu)
@@ -1201,6 +1294,13 @@ void hexagon_translate_init(void)
         offsetof(CPUHexagonState, llsc_val_i64), "llsc_val_i64");
     hex_cycle_count = tcg_global_mem_new_i64(tcg_env,
             offsetof(CPUHexagonState, t_cycle_count), "t_cycle_count");
+#ifndef CONFIG_USER_ONLY
+    hex_cause_code = tcg_global_mem_new(tcg_env,
+        offsetof(CPUHexagonState, cause_code), "cause_code");
+#endif
+    hex_next_PC = tcg_global_mem_new(tcg_env,
+        offsetof(CPUHexagonState, next_PC), "next_PC");
+
     for (i = 0; i < STORES_MAX; i++) {
         snprintf(store_addr_names[i], NAME_LEN, "store_addr_%d", i);
         hex_store_addr[i] = tcg_global_mem_new(tcg_env,
-- 
2.34.1


