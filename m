Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69E2606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 23:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hQxytY5i;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I0VZ/Gmz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJfWV-00080J-NY; Wed, 21 Oct 2026 19:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfWG-0007sB-73
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfWE-00052T-AT
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:51 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKe8MF642066
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=HziJ8UBV9UV
 9YJwY/KW+mHg4CspLb3r8IA/SuQ3F/60=; b=hQxytY5iFTX8JXM62vFQrSu3Yok
 0yCgrjzVsfZG/9M+DqjEWvUWu28z6ggVBYpjvoXe9I/l4h5aK320DMYYvIKrvzSD
 Ld69cqY0dWn0a2vUhXSaybXCmch5wehQeWezkj/dwvimGijxRx28pcuZaas7CPpl
 NKsC0gudTe34awRpWVnQfQLifLbA8oKN3iWdaqR5+9BfIZfVc/NZS1hhhkOPJymM
 ZljMmYSnhoOd57bMPlNNAM/HW1Z20CRgKguJcmuEJP2IoDpG/cgAEdbnFfAfDxb9
 NvQCgRLA4SRcweZzeu4CkTVAxnyuWzf1gMgLxAwPz8NZzbFtGJgfwIoDi+g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex5qa75s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:39 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-536720195ebso26541941cf.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792624479; x=1793229279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HziJ8UBV9UV9YJwY/KW+mHg4CspLb3r8IA/SuQ3F/60=;
 b=I0VZ/GmzTgIRfzuwxIgILftHxMhl2fGi8pxBws79Y2b7nlPM8UgDeOVS+zTkciJU5x
 CNQ0vLQbBtNkHoxlvFhA/Dv51XjXch5XT3F4vpO1PchgmCe6BT+FlgxC8GnAcgSfzLUw
 7jh8MtJhh8tflIJLEqRAbA8G1aIKvWjVFZdukXM30rsocU0bYRrQyuM8xqhTWDN0Bp9e
 qx4mjzdFnlo64CGDa7HNa9GBSs9pwtn7E7gzMKYxPXLyFUVYbYzPBXRycI176mZa4aif
 Kwa+aIoW4T4ccwlKz3Xc03/WLSNt6s3BPy+6YwE0La8OUu1GgAylO9MJ4kVdmRY/NED4
 kG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792624479; x=1793229279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HziJ8UBV9UV9YJwY/KW+mHg4CspLb3r8IA/SuQ3F/60=;
 b=snCWGLgEpxYOCaO6t6/vL6suNQrBaBjeDuXcoSpDT++ed44lPfGcxBXn2m75xDDOLR
 TJ2h9e6DcCkAVe508ZyH4nTJKhdhDUv/qYPdDTACnpnC5wolx/brQhqbuiOkamqVJup+
 VQ+fnYWYSvtHxcm9Q2hfmBTgQt9hLBV6B/SO87m0FgeCVKc1Li8+MQNVeposnjoSQPm+
 dITD+0JVv2EDDFdVx6pVnxYFHnhXFz+yUDb+g7xzJ8yBvkJPVTjnbvOOMm8mxvr+gPSW
 ZyPTnfAnc8+tydwfSKOBeR7K1rLJrxsuQbUzCFCHASxC1tC7w5eqa3lTsjB69OUwqcJf
 bu2w==
X-Gm-Message-State: AFq9FYJ6bpOv3Fvs9jjoblD2tIf8wiAqroeROkrn8pXAjtzYFoiRz0nx
 zOfryq4O1Sx4KUYGcOzOZ79mjVNgqSSAYlyQmlT08yh1/glVHc5EXTTRUou1i9Ogx5Cwxw80yB0
 ZATr3iOHhF3kT/vbjt6dbEB3wwaEuxX1ZAlSXxgRhARsUVgY8MXqw9TZOPdwrXOs/Xw==
X-Gm-Gg: AYBFou1A6l9OlUd/mtgnexCeF5r0ofqQRerZBZ4H4Iqp//tmU1gIdj1vHqr727puPuv
 Kl70Uo3zm5WrpkflQuLIfOP04Vqu+6UWp8GO15vYYkSfFLwEJVAOAUNOMEEVgdMR5mk9F+qZz18
 OVtXMXqt1FT4h6JOuc82u7VEuRRqxswxw78tHnGHZqTA2Qy9qtCVPBz/Xhts+xoEqLgDYcgbXwX
 hhb63O+DDL18T+ZkAnwWmACrXG6U0uXGr5o0sXUP317ssaR+U3ivkbhvY625yqFtgYwq/dX3rqU
 zRBkDtIOJfp/iBHFFBFqInbW6MvqUriLzqZlrRom+KiIX7D31wthk1OYmCCLLfizZivbqefPlPG
 A08OoVLL9Phe4c/mo4Lm6DKs866DDXqk4IivHI24BF3+bAEv8Coo+/VI62ga7Sq1V5bDNgmzrPg
 ==
X-Received: by 2002:a05:622a:1aa5:b0:536:6902:db04 with SMTP id
 d75a77b69052e-5369bb9b16emr55840301cf.75.1792624478641; 
 Wed, 21 Oct 2026 16:14:38 -0700 (PDT)
X-Received: by 2002:a05:622a:1aa5:b0:536:6902:db04 with SMTP id
 d75a77b69052e-5369bb9b16emr55839861cf.75.1792624478067; 
 Wed, 21 Oct 2026 16:14:38 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com
 (200-204-190-237.dsl.telesp.net.br. [200.204.190.237])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536ab6cd0dcsm11995651cf.6.2026.10.21.16.14.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 16:14:37 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 antikostya2@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 14/18] hw/riscv,
 target/riscv: send resync updiscon trace packets
Date: Wed, 21 Oct 2026 20:13:41 -0300
Message-ID: <20261021231346.2452179-15-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfXwba38xLQ3lNg
 X/eZRKsJk0ZbGhItFHNHKZZ4Ppmt33jC4SYLflu/nZKnR2y8R023LbZBEgFez5fBOazHDHGmOT4
 z/r2TFKLIMVHFpRTXIuYspaOcCVXqP4=
X-Authority-Analysis: v=2.4 cv=eJaGH3p1 c=1 sm=1 tr=0 ts=6ad9475f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=QmVDPCq3bE4LYXGvZ20s0w==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=v6o39jtdX7kFEx2kGjIA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 8FBOQRyrqy48SWeBMkID5RZyT-AdwCOn
X-Proofpoint-ORIG-GUID: 8FBOQRyrqy48SWeBMkID5RZyT-AdwCOn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfX6mRUp1PeG8L4
 osiKEyodDbC7lH4i7usRr6JNXnExTM6u2sZtaoebSiN8qdNKFu0ZnEY+a5uNwwyR8HzsdClMkLH
 4Cb+sDSuz06clqsAWvVxfDPp8CcrnbETbDcsBuU+9xLHYwrnvVK/1YWKbqZsgQFNt6NrC9vBV3A
 6r1Trq1DVXmRmhLipATqNMTtBGHyXfJGj9V2u625NmdrA29Vy3CXuw92hWNRhCVZmF544soct4l
 62Jr06XESbMuzjjy1Nr0iNMOJFiPSx4gs/pTiK942cdMsNKArhiG1rLfEuU8m90kxr+frozzjL+
 jeeo7J1FBKG8bKyVHBkQFy6Ef6UlApTaXGyYnjGsw4OJn+jrezcSRR88Jl+6V8KCO/51cXfKHix
 ji7XSTlbhM6D6+Fd70APLe4R1IRkOnOR+qOxP1aLTwlvs63eJNM/h7QMaJMX6HVxeIJyxXR/YvM
 zOymDX8oiO0wFF0ZEBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210092
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
 .../tcg/insn_trans/trans_privileged.c.inc     | 11 ++++++
 target/riscv/tcg/insn_trans/trans_rvi.c.inc   |  2 +
 target/riscv/tcg/trace_helper.c               | 14 +++++++
 target/riscv/tcg/translate.c                  |  7 ++++
 7 files changed, 75 insertions(+)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index b2e2707e0c..b9121d93a7 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -403,6 +403,22 @@ static void trencoder_send_sync_msg(Object *trencoder_obj, uint64_t pc)
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
@@ -410,6 +426,10 @@ void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
     g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
     uint8_t msg_size;
 
+    if (trencoder->updiscon_pending) {
+        trencoder_send_updiscon(trencoder, pc);
+    }
+
     trencoder->first_pc = pc;
     trace_trencoder_first_trace_insn(pc);
     msg_size = rv_etrace_gen_encoded_sync_msg(msg, pc, priv);
@@ -427,6 +447,10 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
     g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
     uint8_t msg_size;
 
+    if (trencoder->updiscon_pending) {
+        trencoder_send_updiscon(trencoder, pc);
+    }
+
     msg_size = rv_etrace_gen_encoded_trap_msg(msg, pc, priv,
                                               ecause, is_interrupt,
                                               tval);
@@ -436,9 +460,22 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
 
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
index 64e19c5752..9116fe4f56 100644
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
index 0832159adc..68348e5473 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -132,6 +132,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 
 /* Trace helpers (should be put inside ifdef) */
 DEF_HELPER_2(trace_insn, void, env, i64)
+DEF_HELPER_1(trace_updiscon, void, env)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(sret, tl, env)
diff --git a/target/riscv/tcg/insn_trans/trans_privileged.c.inc b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
index e22df6fbe7..531eb40595 100644
--- a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
@@ -26,6 +26,8 @@
 
 static bool trans_ecall(DisasContext *ctx, arg_ecall *a)
 {
+    gen_trace_updiscon(ctx);
+
     /* always generates U-level ECALL, fixed in do_interrupt handler */
     generate_exception(ctx, RISCV_EXCP_U_ECALL);
     return true;
@@ -40,6 +42,8 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
     uint32_t ebreak = 0;
     uint32_t post   = 0;
 
+    gen_trace_updiscon(ctx);
+
     /*
      * The RISC-V semihosting spec specifies the following
      * three-instruction sequence to flag a semihosting call:
@@ -101,6 +105,8 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
 {
 #ifndef CONFIG_USER_ONLY
     if (has_ext(ctx, RVS)) {
+        gen_trace_updiscon(ctx);
+
         decode_save_opc(ctx, 0);
         translator_io_start(&ctx->base);
         gen_update_pc(ctx, 0);
@@ -119,6 +125,8 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
 static bool trans_mret(DisasContext *ctx, arg_mret *a)
 {
 #ifndef CONFIG_USER_ONLY
+    gen_trace_updiscon(ctx);
+
     decode_save_opc(ctx, 0);
     translator_io_start(&ctx->base);
     gen_update_pc(ctx, 0);
@@ -153,6 +161,9 @@ static bool trans_mnret(DisasContext *ctx, arg_mnret *a)
 {
 #ifndef CONFIG_USER_ONLY
     REQUIRE_SMRNMI(ctx);
+
+    gen_trace_updiscon(ctx);
+
     decode_save_opc(ctx, 0);
     gen_helper_mnret(cpu_pc, tcg_env);
     tcg_gen_exit_tb(NULL, 0); /* no chaining */
diff --git a/target/riscv/tcg/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
index cc1b5dbbad..2de67c1a88 100644
--- a/target/riscv/tcg/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
@@ -183,6 +183,8 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
         }
     }
 
+    gen_trace_updiscon(ctx);
+
     lookup_and_goto_ptr(ctx);
 
     if (misaligned) {
diff --git a/target/riscv/tcg/trace_helper.c b/target/riscv/tcg/trace_helper.c
index 5a6d725f56..a4c5720a65 100644
--- a/target/riscv/tcg/trace_helper.c
+++ b/target/riscv/tcg/trace_helper.c
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
diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
index fb82a6b2fa..7f6dc6e9e3 100644
--- a/target/riscv/tcg/translate.c
+++ b/target/riscv/tcg/translate.c
@@ -627,6 +627,13 @@ static void gen_ctr_jal(DisasContext *ctx, int rd, target_ulong imm)
 }
 #endif
 
+static void gen_trace_updiscon(DisasContext *ctx)
+{
+    if (ctx->cpu_trace_running) {
+        gen_helper_trace_updiscon(tcg_env);
+    }
+}
+
 static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
 {
     TCGv succ_pc = dest_gpr(ctx, rd);
-- 
2.43.0


