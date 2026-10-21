Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1519A606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 23:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U30NakR9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AyJRiTRY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJfWZ-00089b-GT; Wed, 21 Oct 2026 19:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfWM-0007wu-PI
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfWK-00053O-Gt
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:58 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKeh9V2780607
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hmcIwt3ZVQi
 3llh2rdG1uErnxAPITOVacVDK7zbJnCk=; b=U30NakR9o9EVe61KZVdIZcMYv9D
 YwYZxJFi3z/GXHuu7Hs5p6igfQ/ak5O4r0nlSZN1rbhK3gJ1JEtpvTexsXn4aJA3
 9xQKHSZOEELkrPsc0G+shi8/YAsCqOle0i/RaNyQh+2bCCQ1AgZHwLYdMtlFzMZB
 xB5IOK1egbbrgMQOnmBtG9AxjNSTyMxtewVI1T9T3KFc/0wDMXeJEiL0UvRYy1Xe
 UD0bOCp4ZomOWet37nzvm16EjJcYzWOskoDS2TIU8gbJ1Y4dQUtC7RNylRSfn03O
 BiwdUFI+GCsvMw6XrTiT6C1gijR1qNuBZXsxg4oHoRMSLY/lazpr53zcRTw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heuhujxa2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:44 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5338974c0ceso36634201cf.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792624484; x=1793229284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hmcIwt3ZVQi3llh2rdG1uErnxAPITOVacVDK7zbJnCk=;
 b=AyJRiTRYRqXu2wVuO14QtGPAXCzVgpkYWz/sehpxLAzBXCO7dOKa2IfVXBppoqPbxL
 NYTit3h2b2vX40zaeDsIQijTkWtm+bDkJyi/ztKMjBVBAKse0t4dQtTlCTiLeD782Rkg
 RDE2Y37cBwJquKHFMP03S4UrlP3JWUsHFrn8p5z8OrMpTjVtWCeTmFAbAeRceKmnDgHd
 OqZGbtehYk3NlethxUsaEHxGdTQFtu3gA5Q6QOt/tgAyXWChr1kGllo2QB386BaJ8jdi
 OVzfew5ecu1TuIPa0wb/XwazJsTcJN2QYAVe5fDdgzEZjgyZUV3rVPN8OVPrYLSvv4Vm
 m16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792624484; x=1793229284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hmcIwt3ZVQi3llh2rdG1uErnxAPITOVacVDK7zbJnCk=;
 b=LQhgoeWGDMgrsbZGkNbWNUHq5Xrm6/BbGv3NjQe2xKac6NnF9HTZTFzkmaXxhQ4Tsu
 vHxzgbygQZ79i+XVyWJjaEVXP1KfwOWK37Tf72SV1JtZaLiZkNk9JqW8HWPaOwOMX6K+
 oN6SDiv+bLYoHp32dm5Vn9tFsFTJHi/nv9bEYYhFPkSe9p75AcJCjFL0TGzxN20M2muu
 7X05hByXF/5GO41fyM0s3oI0laMrOxIcrAimWfjufWXKIz+SKaKvvuag4heJGDsgMeEt
 3LgpMmR+JYtEGoJv0f9ODEsyph0kLbwXUxUTrDblq98yfPiWT8ds/iI9eQm4eP2mqUVD
 C4mg==
X-Gm-Message-State: AFq9FYKQsrH4XlOfYWPA7MauNrvvrfvGAshlEP0YEfI+PzIf2xD1pVlg
 i6elhAOrpHGjKI6KesIADrYZ8emLcJcUNF05+3WLafsTOaqE+IIPGPuOZb4bRPLvCRItRRKNUNy
 FUH5ebA9TwocNL9nagjAWsk6tNP95Orgg/0C0p4UVNrZXy/wuUDOsuk3U4yp0y+R7tA==
X-Gm-Gg: AYBFou1xJXSehh/Pzd2Z9NvsNuWxzoVykFVBMPMYb7GUoYsYF3VgbVQuow5FvlRsfKY
 GTwXFC8AC2hrIqA02jaGeX+TXEfytdaCrU+DMyhkuHWafOX2VFBcUkJlPx642Gy12zkSuHfqoI4
 OU/OjnwpM/dK2KIIKfD3Fr4oEu58RGa6CqXIg6s05x+ECo5m2W/HsgT0wkINj9N1yuVzDQXaCSV
 DZBxeoswF60fbkGsZnZEoY5WttfFgDq9dlu6NibegeiWZROkFE3A/OSkZymgXaMeEY0nJ2idTso
 QCjUiJ6tXIqT1vHy7foo8dtGaQTnSIrK4QYh2jTCLP6R1aGPwhJpH0YJW4Mx+XT8biBYOcpFCm6
 vHc7Z4cg1x0ww/dZLKlGp6tZIlJ8YonvmemRC2vjgyG1S2jEfjOMk6YAzQ10ILLly6Ofshz0yEQ
 ==
X-Received: by 2002:a05:622a:a14:b0:535:70b3:3527 with SMTP id
 d75a77b69052e-5369b91d6fdmr48558421cf.62.1792624483861; 
 Wed, 21 Oct 2026 16:14:43 -0700 (PDT)
X-Received: by 2002:a05:622a:a14:b0:535:70b3:3527 with SMTP id
 d75a77b69052e-5369b91d6fdmr48558041cf.62.1792624483377; 
 Wed, 21 Oct 2026 16:14:43 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com
 (200-204-190-237.dsl.telesp.net.br. [200.204.190.237])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536ab6cd0dcsm11995651cf.6.2026.10.21.16.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 16:14:42 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 antikostya2@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 16/18] hw/riscv/trace-encoder: send branches info
Date: Wed, 21 Oct 2026 20:13:43 -0300
Message-ID: <20261021231346.2452179-17-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=d4JgWhjE c=1 sm=1 tr=0 ts=6ad94764 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=QmVDPCq3bE4LYXGvZ20s0w==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=GSE619UI_DCnt5MBBt8A:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfX2FZsrB+oYs6d
 aYeT/9Aw1UZyFlLEwxXBwDv0B9Khc0p49i/7On7NePX0jCS5+a8ltNvxUDEFazRNs9vqwdrMpiF
 q2cMA767rvutm+SeLrd0Vwe470zjfuU=
X-Proofpoint-GUID: c3_QjLbIark2tsiOwxkQ0NNkEDP3fDjU
X-Proofpoint-ORIG-GUID: c3_QjLbIark2tsiOwxkQ0NNkEDP3fDjU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfXxbL8zOXrbKnD
 ej+kgOTJ0ax0e1LyhaWyqLFSpzHfGKdptYKG5jGiEeEMLl6jLo3448QkdqVILC4GrFNdxP14agw
 Q/SPIIIt+c05as/7cEihJtyDhFRbKq9sjIS3IJZSuxM5M6FJYa+frTxMTpbfNSqu8ymnnBTAnKY
 fyBsGT+l/73j4YrRdui9/J1N5+Tnnbnk63Nivasl0kYCP1IAcSRfPV6dGrbSbaK3hYeyYRRISgl
 7pEIdCsaLJSBgZAv9MzUL5NqRkPTDZox9mgwDFNNGQ5dNHOXfmY13pyl1bmQ1HHsSx/jiowbI2G
 Q6xmdpLso5KCXb12Z6vvu5WoIV9jGPam14W3i/gonx4q2B0HfOS/127ieohJBQBB0CYa40co0l4
 TE0aQFm8hzJfgspmcFLi97D+ElOKj9hU3rljoLgtms6K5m/z/decWf+rYlMdPvfZUZx2aufOFeX
 bDCPZVtsd5QjX+UhzrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Branch info is reported via the TCG helpers, updating the trace encoder
internal branch map.

Branch packets are sent in two circunstances:

- when the branch map is full;

- when an updiscon packet is about to be sent and the branch map
  isn't empty.

The former will trigger a Format 1 no-addr packet, the latter a Format 1
with the updiscon address.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/trace-encoder.c                    | 52 ++++++++++++++++++++-
 hw/riscv/trace-encoder.h                    |  4 ++
 target/riscv/helper.h                       |  1 +
 target/riscv/tcg/insn_trans/trans_rvi.c.inc | 11 +++++
 target/riscv/tcg/trace_helper.c             | 12 +++++
 5 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index b9121d93a7..290e648083 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -30,6 +30,8 @@
  */
 #define TRACE_MSG_MAX_SIZE 32
 
+#define TRACE_MAX_BRANCHES 31
+
 static TracePrivLevel trencoder_get_curr_priv_level(TraceEncoder *te)
 {
     CPURISCVState *env = &te->cpu->env;
@@ -314,6 +316,9 @@ static void trencoder_reset(DeviceState *dev)
     te->trace_running = false;
     te->trace_next_insn = false;
     env->trace_running = false;
+
+    te->branch_map = 0;
+    te->branches = 0;
 }
 
 static void trencoder_realize(DeviceState *dev, Error **errp)
@@ -411,9 +416,20 @@ static void trencoder_send_updiscon(TraceEncoder *trencoder, uint64_t pc)
     bool updiscon = !notify;
     uint8_t msg_size;
 
-    msg_size = rv_etrace_gen_encoded_format2_msg(format2_msg, pc,
+    if (trencoder->branches > 0) {
+        msg_size = rv_etrace_gen_encoded_format1(format2_msg,
+                                                 trencoder->branches,
+                                                 trencoder->branch_map,
+                                                 pc,
                                                  notify,
                                                  updiscon);
+        trencoder->branches = 0;
+    } else {
+        msg_size = rv_etrace_gen_encoded_format2_msg(format2_msg, pc,
+                                                     notify,
+                                                     updiscon);
+    }
+
     trencoder_send_message_smem(trencoder, format2_msg, msg_size);
 
     trencoder->updiscon_pending = false;
@@ -458,6 +474,40 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
     trencoder_send_message_smem(trencoder, msg, msg_size);
 }
 
+static void trencoder_send_branch_map(Object *trencoder_obj)
+{
+    TraceEncoder *te = TRACE_ENCODER(trencoder_obj);
+    g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
+    uint8_t msg_size;
+
+    msg_size = rv_etrace_gen_encoded_format1_noaddr(msg,
+                                                    te->branches,
+                                                    te->branch_map);
+    trencoder_send_message_smem(te, msg, msg_size);
+}
+
+void trencoder_report_branch(Object *trencoder_obj, uint64_t pc, bool taken)
+{
+    TraceEncoder *te = TRACE_ENCODER(trencoder_obj);
+
+    /*
+     * Note: the e-trace spec determines the value '1' for a
+     * branch *not* taken. The helper API is using taken = 1
+     * to be more intuitive when reading TCG code.
+     */
+    if (!taken) {
+        te->branch_map = deposit32(te->branch_map, te->branches, 1, 1);
+    }
+
+    te->last_branch_pc = pc;
+    te->branches++;
+
+    if (te->branches == TRACE_MAX_BRANCHES) {
+        trencoder_send_branch_map(trencoder_obj);
+        te->branches = 0;
+    }
+}
+
 void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc)
 {
     TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
index 9116fe4f56..0fc24bc967 100644
--- a/hw/riscv/trace-encoder.h
+++ b/hw/riscv/trace-encoder.h
@@ -28,6 +28,9 @@ struct TraceEncoder {
     uint32_t reg_mem_size;
 
     uint64_t first_pc;
+    uint64_t last_branch_pc;
+    uint32_t branch_map;
+    uint8_t branches;
 
     hwaddr baseaddr;
     hwaddr dest_baseaddr;
@@ -54,5 +57,6 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
                                uint64_t tval);
 void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc);
 void trencoder_report_updiscon(Object *trencoder_obj);
+void trencoder_report_branch(Object *trencoder_obj, uint64_t pc, bool taken);
 
 #endif
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 68348e5473..2d4392807b 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -133,6 +133,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 /* Trace helpers (should be put inside ifdef) */
 DEF_HELPER_2(trace_insn, void, env, i64)
 DEF_HELPER_1(trace_updiscon, void, env)
+DEF_HELPER_3(trace_branch, void, env, tl, int)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(sret, tl, env)
diff --git a/target/riscv/tcg/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
index 2de67c1a88..8b32686073 100644
--- a/target/riscv/tcg/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
@@ -268,6 +268,13 @@ static void gen_setcond_i128(TCGv rl, TCGv rh,
     tcg_gen_movi_tl(rh, 0);
 }
 
+static void gen_trace_branch(DisasContext *ctx, int taken)
+{
+    if (ctx->cpu_trace_running) {
+        gen_helper_trace_branch(tcg_env, cpu_pc, tcg_constant_i32(taken));
+    }
+}
+
 static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
 {
     TCGLabel *l = gen_new_label();
@@ -299,11 +306,15 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
     }
 #endif
 
+    gen_trace_branch(ctx, 0);
+
     gen_goto_tb(ctx, 1, ctx->cur_insn_len);
     ctx->pc_save = orig_pc_save;
 
     gen_set_label(l); /* branch taken */
 
+    gen_trace_branch(ctx, 1);
+
     if (!riscv_cpu_allow_16bit_insn(ctx->cfg_ptr,
                                     ctx->priv_ver,
                                     ctx->misa_ext) &&
diff --git a/target/riscv/tcg/trace_helper.c b/target/riscv/tcg/trace_helper.c
index a4c5720a65..cd57641d9b 100644
--- a/target/riscv/tcg/trace_helper.c
+++ b/target/riscv/tcg/trace_helper.c
@@ -37,6 +37,13 @@ void helper_trace_updiscon(CPURISCVState *env)
     te->updiscon_pending = true;
     te->trace_next_insn = true;
 }
+
+void helper_trace_branch(CPURISCVState *env, target_ulong pc, int taken)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+
+    trencoder_report_branch(cpu->trencoder, pc, taken);
+}
 #else /* #ifndef CONFIG_USER_ONLY */
 void helper_trace_insn(CPURISCVState *env, uint64_t pc)
 {
@@ -47,4 +54,9 @@ void helper_trace_updiscon(CPURISCVState *env)
 {
     return;
 }
+
+void helper_trace_branch(CPURISCVState *env, target_ulong pc, int taken)
+{
+    return;
+}
 #endif /* #ifndef CONFIG_USER_ONLY*/
-- 
2.43.0


