Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08DDE92FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 18:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaIJ5-0005X6-L9; Mon, 29 Dec 2025 13:49:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaIHm-0003lC-9l
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:48:09 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaIHi-0008ID-TP
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:48:05 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BT9jZbk4132692
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=d5x/aRRoY4O
 SgJd7MMecvrFmsj+bS5CZjYL4v9PUqkg=; b=Q5MEkkulUlK5CvH+2YelPLA+fAo
 sWFkN3e6tiUQUVXkmsFdOoOvzjqtdc1TTnZxvbDLYxB0tJM9AMrPgW9Uy2fCOAH8
 FONl3/7nS+1shaENjJqKaYP+9k/Btoi3kyg90m/ZLzGXEF1JBkhLISrbUeJU+RMn
 TeOTkBDUW2WRMI+lJ/Benx+aFFCVN1cCNur5N4gS8y9dwwFRUhfVgfTT469AIjzn
 w+qN5pEY8vWHi7mu0PnaUcn32vfpz/5eXinU8wUT67YrzcaXzpArx2nnVAFYxsdX
 ue1kaGMB0YCgOaQyPnZMHEKIydLkCtzWOBh+H/Qaex/MNbaxv+6StTgQjMg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba71ww4pp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:55 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a0bb1192cbso188370565ad.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 10:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767034075; x=1767638875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d5x/aRRoY4OSgJd7MMecvrFmsj+bS5CZjYL4v9PUqkg=;
 b=cPqinRp3KzNSo/HdsTbODAJep2TY+gNJ+xob0rBL7Dj0SgLhijBAP3nGK+cOy2YKf6
 SXxlAaVdiiP9ZMDlhZtlA9MwqNYIigM0KM14aiKOuWtvqPpuG3piVvpEtfI37pIhtTIY
 KAVcx3RNpzloSG9DnswSpUkmFP5WghZmp+Z3JLefNQFNrBo8tHigne4a18cl/oBWkFlK
 V7XsYCddytC/h4LiuxtL7GC/yrYVo3O78xsLL7rQ38op9Yq0AdqfCi4GBI5T3NsdQpZc
 ga9AYmo17vBDMvQ+T56IOSpR3TwDD7d1C2QSd9ogkXGR9Si/9Z28uljtDprkEnQG2D0y
 /YsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767034075; x=1767638875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d5x/aRRoY4OSgJd7MMecvrFmsj+bS5CZjYL4v9PUqkg=;
 b=IY5yxUkqvkCPn0SaOJga5nX0dHRInil7AEIRVvgG0GmUUW0tWr5sUdskDlpWyqv5eS
 zXH1j9WjZJ+WU3EfEFpJIeagyVIOFUqsAWW04olJUacYCarVfhRHH7HU2ykCHShx+aJG
 XH8YtnypVtPoH5UQkwdLbsXnpLhRMIIp9aCc9jYjTZjUc/atWLZ5yY1b/nxKHRKPO8X4
 gzQXx91K9t0yQLzwK12b1zjSboxJRgsiTzV9l2EFuCiVHvnMjSkLMJ1TeyF/2p96jv7Y
 I3K0/DO+fbWRX0vBCVvdHfDv176EaG2Jo39GJ3tiBBXU45ZHKtvWGnw//a7DvDKdtMTr
 XfSQ==
X-Gm-Message-State: AOJu0YyVm4cM1DljFAgAWOZVXBLtp+szedw69MO+mxG1R44oTookPUIH
 mUvKrf4Ed6GjtUsi96jCbL+OG9XBDu6AicbFGTLX/1tWdwBCjSJlAVQpejnm2v6pxwvx5PlQipp
 37DaaICC+RJ/wjcNKgOs0RLe3u+ZajlnJAXKjeabUvVIGNoRx9DWPJyxtnZ46Ml7GOg==
X-Gm-Gg: AY/fxX4SuICy7deZzPYTGpD+oM1x8AetZqejiT3uzKJCeFAG5j9nFIzozjCSjxExkr3
 YN9We86kTuYsc4fQ0RG5EFQy2Xm0Wk2/onN9SN886AXl/3C/SOsBNuO+W2NEVcvwAAekWjESbxG
 b4Db6lnVt3vqRDFTI49LMIETLr6a4yUbPMwdmqjfQ9/eS0teYtZ6xBpZMSzlNPkiz1ZLidDOOd1
 FBoLhgXZwjTTm7uf8Eqhg6gOjSiJXV78XZyQA06jUcn9+nvuDehDd/vdBr2pWBqZofVXj9fPHig
 aKHki5zBWvgl3ebN56kwCDLIMW/xGpKdAOGb+4os3NXWndkFK+xHaVb3gcvK0GntFITxC1pqRW9
 0ErUyGfW1P/IbZm2P5fsohcIm1mGMIg4pL4/aJ/5BfQw0tr4=
X-Received: by 2002:a17:903:41c8:b0:2a0:ba6d:d101 with SMTP id
 d9443c01a7336-2a2f24248b5mr323279955ad.21.1767034074574; 
 Mon, 29 Dec 2025 10:47:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4GbaIakhnlu/CgdkJHAEeYDCFJzm7p7KC0IT2IDCZdl/ZIiYvz/BrblS3A55aRpnVIzyqKw==
X-Received: by 2002:a17:903:41c8:b0:2a0:ba6d:d101 with SMTP id
 d9443c01a7336-2a2f24248b5mr323279835ad.21.1767034074035; 
 Mon, 29 Dec 2025 10:47:54 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.184.177])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c82aa8sm282198705ad.31.2025.12.29.10.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 10:47:53 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v3 14/17] hw/riscv,
 target/riscv: send resync updiscon trace packets
Date: Mon, 29 Dec 2025 15:46:53 -0300
Message-ID: <20251229184656.2224369-15-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
References: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE3MiBTYWx0ZWRfXxOozRqHgZUKm
 aTbm0doyi4n3OSMqoq/I2a5vqJGieCaTRf79eW5bOwKSJ0MEbfaovJbI4/xW5UuPxWaS4qsNIa3
 mDbQgCwhrn5w24zSxwg67bYWzU1G5vNMOmgBw+my+gs/wVvcjlDNUW0k+3jz5NwhAwq+yA78Tk+
 tN/7jBXDoDFDY+g6h3uMDMyENaRkvHDOrDbqfKAhZeVsOkG41z15nwHAj430Bd9rWp9LVzw5LwJ
 qqz4x6alicDHwEj4GpufiHVzyWHxVj+KBIgZHsu4UbBWeBl+Fa5drvmpa96QMWv5+fZ4gjxNKr0
 JMXnhaOBsme6AMT+0FUNvA7bjr92yu/WkgOojZDEoK5PmokR0RhNdswZUOdz57z/H4lEqoHXTGf
 XPSUHGgcTCSmS16YWdKBguvWwf2Y9ZDkyyKwo9XnInHUoYHpsI/ukRtloT/NJVivfpSRhssHHKs
 f0IMY9A795qh1UBUzyQ==
X-Proofpoint-ORIG-GUID: 7V-LlEuS7pBb1xjl6h_uc_McGm5FSaj6
X-Proofpoint-GUID: 7V-LlEuS7pBb1xjl6h_uc_McGm5FSaj6
X-Authority-Analysis: v=2.4 cv=CK4nnBrD c=1 sm=1 tr=0 ts=6952ccdb cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=cW5wcbexNO3A0Ml9TiDm9w==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=v6o39jtdX7kFEx2kGjIA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_06,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512290172
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Send updiscon packets based on the constraints already discussed in the
previous patch:

- We do not implement any form of call/return prediction in the encoder,
  and TCG will always retire a single insn per cycle, e.g. irreport will
  always be equal to updiscon;

- irdepth is not implemented since we'll always return a  package where
  irreport == updiscon.

Note that we're sending an updiscon packet if the 'updiscon_pending'
flag is set when we're about the send a resync or a trap packet. The TCG
helper in this case is just setting the trace encoder flags instead of
actually triggering a RAM sink SMEM write.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/trace-encoder.c                      | 37 +++++++++++++++++++
 hw/riscv/trace-encoder.h                      |  3 ++
 target/riscv/helper.h                         |  1 +
 .../riscv/insn_trans/trans_privileged.c.inc   | 11 ++++++
 target/riscv/insn_trans/trans_rvi.c.inc       |  2 +
 target/riscv/trace_helper.c                   | 14 +++++++
 target/riscv/translate.c                      |  9 +++++
 7 files changed, 77 insertions(+)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 7f130198a0..8b16ce6fa0 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -402,6 +402,22 @@ static void trencoder_send_sync_msg(Object *trencoder_obj, uint64_t pc)
     trencoder_send_message_smem(trencoder, msg, msg_size);
 }
 
+static void trencoder_send_updiscon(TraceEncoder *trencoder, uint64_t pc)
+{
+    g_autofree uint8_t *format2_msg = g_malloc0(TRACE_MSG_MAX_SIZE);
+    uint8_t addr_msb = extract64(pc, 31, 1);
+    bool notify = addr_msb;
+    bool updiscon = !notify;
+    uint8_t msg_size;
+
+    msg_size = rv_etrace_gen_encoded_format2_msg(format2_msg, pc,
+                                                 notify,
+                                                 updiscon);
+    trencoder_send_message_smem(trencoder, format2_msg, msg_size);
+
+    trencoder->updiscon_pending = false;
+}
+
 void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
 {
     TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
@@ -409,6 +425,10 @@ void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
     g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
     uint8_t msg_size;
 
+    if (trencoder->updiscon_pending) {
+        trencoder_send_updiscon(trencoder, pc);
+    }
+
     trencoder->first_pc = pc;
     trace_trencoder_first_trace_insn(pc);
     msg_size = rv_etrace_gen_encoded_sync_msg(msg, pc, priv);
@@ -426,6 +446,10 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
     g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
     uint8_t msg_size;
 
+    if (trencoder->updiscon_pending) {
+        trencoder_send_updiscon(trencoder, pc);
+    }
+
     msg_size = rv_etrace_gen_encoded_trap_msg(msg, pc, priv,
                                               ecause, is_interrupt,
                                               tval);
@@ -435,9 +459,22 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
 
 void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc)
 {
+    TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
+
+    if (trencoder->updiscon_pending) {
+        trencoder_send_updiscon(trencoder, pc);
+    }
+
     trencoder_send_sync_msg(trencoder_obj, pc);
 }
 
+void trencoder_report_updiscon(Object *trencoder_obj)
+{
+    TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
+
+    trencoder->updiscon_pending = true;
+}
+
 static const Property trencoder_props[] = {
     /*
      * We need a link to the associated CPU to
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
index 13252f92b6..050406b531 100644
--- a/hw/riscv/trace-encoder.h
+++ b/hw/riscv/trace-encoder.h
@@ -36,6 +36,8 @@ struct TraceEncoder {
     uint32_t regs[TRACE_R_MAX];
     RegisterInfo regs_info[TRACE_R_MAX];
 
+    bool updiscon_pending;
+
     bool enabled;
     bool trace_running;
     bool trace_next_insn;
@@ -51,5 +53,6 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
                                bool is_interrupt,
                                uint64_t tval);
 void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc);
+void trencoder_report_updiscon(Object *trencoder_obj);
 
 #endif
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index e80320ad16..f27ff319e9 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -131,6 +131,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 
 /* Trace helpers (should be put inside ifdef) */
 DEF_HELPER_2(trace_insn, void, env, i64)
+DEF_HELPER_1(trace_updiscon, void, env)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(sret, tl, env)
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index 8a62b4cfcd..28089539d5 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -26,6 +26,8 @@
 
 static bool trans_ecall(DisasContext *ctx, arg_ecall *a)
 {
+    gen_trace_updiscon();
+
     /* always generates U-level ECALL, fixed in do_interrupt handler */
     generate_exception(ctx, RISCV_EXCP_U_ECALL);
     return true;
@@ -40,6 +42,8 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
     uint32_t ebreak = 0;
     uint32_t post   = 0;
 
+    gen_trace_updiscon();
+
     /*
      * The RISC-V semihosting spec specifies the following
      * three-instruction sequence to flag a semihosting call:
@@ -95,6 +99,8 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
 {
 #ifndef CONFIG_USER_ONLY
     if (has_ext(ctx, RVS)) {
+        gen_trace_updiscon();
+
         decode_save_opc(ctx, 0);
         translator_io_start(&ctx->base);
         gen_update_pc(ctx, 0);
@@ -113,6 +119,8 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
 static bool trans_mret(DisasContext *ctx, arg_mret *a)
 {
 #ifndef CONFIG_USER_ONLY
+    gen_trace_updiscon();
+
     decode_save_opc(ctx, 0);
     translator_io_start(&ctx->base);
     gen_update_pc(ctx, 0);
@@ -129,6 +137,9 @@ static bool trans_mnret(DisasContext *ctx, arg_mnret *a)
 {
 #ifndef CONFIG_USER_ONLY
     REQUIRE_SMRNMI(ctx);
+
+    gen_trace_updiscon();
+
     decode_save_opc(ctx, 0);
     gen_helper_mnret(cpu_pc, tcg_env);
     tcg_gen_exit_tb(NULL, 0); /* no chaining */
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 54b9b4f241..ac00cbc802 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -183,6 +183,8 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
         }
     }
 
+    gen_trace_updiscon();
+
     lookup_and_goto_ptr(ctx);
 
     if (misaligned) {
diff --git a/target/riscv/trace_helper.c b/target/riscv/trace_helper.c
index 5a6d725f56..a4c5720a65 100644
--- a/target/riscv/trace_helper.c
+++ b/target/riscv/trace_helper.c
@@ -28,9 +28,23 @@ void helper_trace_insn(CPURISCVState *env, uint64_t pc)
         te->trace_next_insn = false;
     }
 }
+
+void helper_trace_updiscon(CPURISCVState *env)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+    TraceEncoder *te = TRACE_ENCODER(cpu->trencoder);
+
+    te->updiscon_pending = true;
+    te->trace_next_insn = true;
+}
 #else /* #ifndef CONFIG_USER_ONLY */
 void helper_trace_insn(CPURISCVState *env, uint64_t pc)
 {
     return;
 }
+
+void helper_trace_updiscon(CPURISCVState *env)
+{
+    return;
+}
 #endif /* #ifndef CONFIG_USER_ONLY*/
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9dbc8649f0..e46b5e0c53 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -617,6 +617,15 @@ static void gen_ctr_jal(DisasContext *ctx, int rd, target_ulong imm)
 }
 #endif
 
+static void gen_trace_updiscon(void)
+{
+    TCGLabel *skip = gen_new_label();
+
+    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_trace_running, 0, skip);
+    gen_helper_trace_updiscon(tcg_env);
+    gen_set_label(skip);
+}
+
 static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
 {
     TCGv succ_pc = dest_gpr(ctx, rd);
-- 
2.51.1


