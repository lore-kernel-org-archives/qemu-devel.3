Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296A0F4610C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4f8U-0000El-H9; Mon, 23 Mar 2026 09:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w4f8R-0000E3-PT
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:15:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w4f8P-0000L3-Kw
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:15:59 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NC28UT3042065
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+9uNrFY6zGk
 SuG/XbKlv8ybDbu8GutyHUVFX3MoK7RA=; b=V8svCJz/CnWCXg47qIRzsD1PBV9
 cRLGsOGku5QAbWvw9ME8asTo/8Vf8vQw0IyVNq5cQgsLNopCRB3V4f9rlbNijZpx
 8n9OPexN6M+DT8kmjaBX8kSO07qtOzaAxvkR0nQ35bogeseTkJkRKM66WpM5Jjec
 9j9NMykh7j6i3slcIM3hUPq6w4auB2b6Aa0g1ndHMp3F0o6lSWpktcqlGE1NpLG+
 N0U+bNVOCr6908rZfIA8cfMLFBLDsgKOpnrvp58Eb/Zsv9oj03MgQILfnk3DKcQL
 9/mVfABh2l2RtvzpQNV78XbRk9Sq5vmyurbh6QmlCwkxAIWXzSUKcClw1+g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d355w07h9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:15:56 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2bdc1b30ac8so5993663eec.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 06:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774271756; x=1774876556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+9uNrFY6zGkSuG/XbKlv8ybDbu8GutyHUVFX3MoK7RA=;
 b=MpZ/fQdg7xGDshic6NRef1NZdAId/EwFYicA706sn0WhmTn5Vjbc+O2JTbiCX+WLm2
 zBVufbj2FgzdsQI/JAXb2ZZ5fhnP3X1sFuOEduLoaVDTV0qsBxvvV+Tvhfobpky/oEAE
 V03QboZ5FYtZgwg4c8Qq+q96mga6OaqajYhR1QlxY9VRzR+KHaOWxNmvce1gasKwK1Ld
 /o/v8LRdPFQosflUkJTRTfZGUjRfiwu9LOWn9tSSXjLUla+/+nuYNPff0fm36EbdQmYX
 moq/RPsQQqPxZ6pob3uZbq4xnxHJ21us1oUIQIf7NFcdikneiBANQX2OZxsIz3QMCUBt
 lM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774271756; x=1774876556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+9uNrFY6zGkSuG/XbKlv8ybDbu8GutyHUVFX3MoK7RA=;
 b=jJvWdtsopDjwMtdKZvGp3f5Nj5crlp0rQLTRE+i3YvQVui0ZxsPQOGk4IIgEKAruXh
 puPEGPt5HcK5lWZRQmEI0QXFvJjcgZstV3p51gaycdTYb89czJiM3Y5zgXgcMee3flxX
 brrcbaoR4ZJWPefVEfUSMBjV78lNObfr4tdgbw081bZ1tH+UURleNLET1ItsrJgSxKdQ
 3opYRDREp+KKdxPTx/WSoSQvID/xJsT2rwF2EFVRp6+yMK4mmBJ0UznqT74GU3aATGYH
 adKp+iYAvnS0uIboIawfohPi/No7ey5OXXfd1su/R1orzlvLtBuIIv/d6P5ppbIH1cSc
 W8rw==
X-Gm-Message-State: AOJu0YyC8xre6oy+1HsHOrYSpk88jS/KQ8SfacdrSpIEn0LptirTFbOJ
 zpixV94DiPaE5GcTuPUmenulwYck3l5XoTyQbPHElDqBAz65lZ4HBkDK5egSeuEBtOH2sAqiIU4
 /rTp45GyNtiY/ieyjdQJpGAx3T6LXIlc/As3kj1j0HEqKlRepJsHmKE7qdWQZpUubc4xa
X-Gm-Gg: ATEYQzza0tAg9+LZQ8z1zYsZskw2TmgUcVpCx6bJfai6OlfGuOag76ywUaKNad9jiHb
 8NKravh/7n0a/KQB6H6W8SH64709pSezmykqbEIHHKNLeQpOvvPeZNk2pTJ3K5eQEkTMaDi5w6T
 ZhfvKi6VVGXl7VobGm9HYirbIfpuARaRMAcTwdysId55nJ2qxo72zTJCEOq5EuKE8z58YosACw3
 0aTKiyNHy9LzjsfWy00RSxYeZS1ih5VAb8+k+S89EXrTHcLDXFd5XDbE3uLgMS0KsmkzQWZEv1g
 TCxB80f1WM0VNpW0tx6Wg/ODQmnPNODW6TNMcACbZSgQH+yaW7PjrqxuQB8vLbIw403IJ6oOoPa
 k9HHysyi0xG8lHuaO6yYbEKCzPWgLeqdX7Eek3WY0t6CmAmtVlSZolq4oRJUZVoZCgNhS9ch8ov
 DoP2YZ6t2E
X-Received: by 2002:a05:693c:300f:b0:2be:837d:cc4d with SMTP id
 5a478bee46e88-2c109579f0bmr5949747eec.5.1774271755299; 
 Mon, 23 Mar 2026 06:15:55 -0700 (PDT)
X-Received: by 2002:a05:693c:300f:b0:2be:837d:cc4d with SMTP id
 5a478bee46e88-2c109579f0bmr5949724eec.5.1774271754553; 
 Mon, 23 Mar 2026 06:15:54 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b14cadbsm14702574eec.3.2026.03.23.06.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 06:15:54 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com, marco.liebel@oss.qualcomm.com,
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH 03/13] target/hexagon/cpu: add HVX IEEE FP extension
Date: Mon, 23 Mar 2026 06:15:39 -0700
Message-Id: <4f6bd77ba6c6c07c8796e805ce6e50539bde260e.1774271525.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fq7RpV4f c=1 sm=1 tr=0 ts=69c13d0c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=kpEvSfgP-Ez5Y9dk4oUA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: TMAkN1c1-tMKCM9pgDApnbIdCAgB0ErP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEwMyBTYWx0ZWRfX7ygD8+sT9Mv/
 HAOnERkJvvHaeanRaHzbLIBWVYtVr0dabYJPGWfInapGpS7QX56P/BQxQ2yVhS6LAVRu4/xMvWn
 ygHJlneGCj/3rb03sQOezijTPTXtWULPq8ZnOyPH0SOesrZeEsga2XWV3wPrIBiqLmt1IflPAZd
 q1xAiwAcgbj/GYnUu1hCHk3xtbTkSbbS4/0uG2OCntVM/w0k0InVOQbAo7UbLWZS2Oh80U/VR+W
 4oLQp3BWotBUnkUSxI+mLsSkG43l/ZTCWX0dVSzuDIhPHKC/yMIBXFO4hZ4Zm48YkznVJCr5p07
 7WAkjy4Dx423qbe/qlVETHnsv3XSunkaqdnfUX91v3joQcSAZtx8p5HvGyvXZ+sNI7CvLInTFsy
 CrqyOM5KyQl+hZI9A6e8MZzv8i7cTPyTs3ALb77IVUN51ZCuuW2HOx0u5PmzOEkPX4b3+a6bOGK
 7MqGFvLz3nvPC380Tgg==
X-Proofpoint-GUID: TMAkN1c1-tMKCM9pgDApnbIdCAgB0ErP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230103
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

This flag will be used to control the HVX IEEE float instructions, which
are only available at some Hexagon cores. When unavailable, the
instruction is essentially treated as a no-op.

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/cpu.h             |  1 +
 target/hexagon/translate.h       |  1 +
 target/hexagon/attribs_def.h.inc |  3 +++
 target/hexagon/cpu.c             |  1 +
 target/hexagon/decode.c          | 22 ++++++++++++++++++++++
 target/hexagon/translate.c       |  1 +
 6 files changed, 29 insertions(+)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 85afd59277..77822a48b6 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -127,6 +127,7 @@ struct ArchCPU {
     bool lldb_compat;
     target_ulong lldb_stack_adjust;
     bool short_circuit;
+    bool ieee_fp_extension;
 };
 
 #include "cpu_bits.h"
diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index b37cb49238..516aab7038 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -70,6 +70,7 @@ typedef struct DisasContext {
     target_ulong branch_dest;
     bool is_tight_loop;
     bool short_circuit;
+    bool ieee_fp_extension;
     bool read_after_write;
     bool has_hvx_overlap;
     TCGv new_value[TOTAL_PER_THREAD_REGS];
diff --git a/target/hexagon/attribs_def.h.inc b/target/hexagon/attribs_def.h.inc
index 9e3a05f882..c85cd5d17c 100644
--- a/target/hexagon/attribs_def.h.inc
+++ b/target/hexagon/attribs_def.h.inc
@@ -173,5 +173,8 @@ DEF_ATTRIB(NOTE_SHIFT_RESOURCE, "Uses the HVX shift resource.", "", "")
 DEF_ATTRIB(RESTRICT_NOSLOT1_STORE, "Packet must not have slot 1 store", "", "")
 DEF_ATTRIB(RESTRICT_LATEPRED, "Predicate can not be used as a .new.", "", "")
 
+/* HVX IEEE FP extension attributes */
+DEF_ATTRIB(HVX_IEEE_FP, "HVX IEEE FP extension instruction", "", "")
+
 /* Keep this as the last attribute: */
 DEF_ATTRIB(ZZ_LASTATTRIB, "Last attribute in the file", "", "")
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index ffd14bb467..8b72a5d3c8 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -54,6 +54,7 @@ static const Property hexagon_cpu_properties[] = {
     DEFINE_PROP_UNSIGNED("lldb-stack-adjust", HexagonCPU, lldb_stack_adjust, 0,
                          qdev_prop_uint32, target_ulong),
     DEFINE_PROP_BOOL("short-circuit", HexagonCPU, short_circuit, true),
+    DEFINE_PROP_BOOL("ieee-fp", HexagonCPU, ieee_fp_extension, true),
 };
 
 const char * const hexagon_regnames[TOTAL_PER_THREAD_REGS] = {
diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index dbc9c630e8..d832a64a17 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -696,6 +696,18 @@ static bool pkt_has_write_conflict(Packet *pkt)
     return !bitmap_empty(conflict, 32);
 }
 
+static void convert_to_nop(Insn *insn)
+{
+    bool is_endloop = insn->is_endloop;
+    memset(insn, 0, sizeof(*insn));
+    insn->opcode = A2_nop;
+    insn->new_read_idx = -1;
+    insn->dest_idx = -1;
+    insn->generate = opcode_genptr[insn->opcode];
+    insn->iclass = 0b111;
+    insn->is_endloop = is_endloop;
+}
+
 /*
  * decode_packet
  * Decodes packet with given words
@@ -746,6 +758,16 @@ int decode_packet(DisasContext *ctx, int max_words, const uint32_t *words,
         /* Ran out of words! */
         return 0;
     }
+
+    /* Disable HVX IEEE instruction if extension is disabled. */
+    if (!ctx->ieee_fp_extension) {
+        for (i = 0; i < num_insns; i++) {
+            if (GET_ATTRIB(pkt->insn[i].opcode, A_HVX_IEEE_FP)) {
+                convert_to_nop(&pkt->insn[i]);
+            }
+        }
+    }
+
     pkt->encod_pkt_size_in_bytes = words_read * 4;
     pkt->pkt_has_hvx = false;
     for (i = 0; i < num_insns; i++) {
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 8a223f6e13..9f8104f949 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -988,6 +988,7 @@ static void hexagon_tr_init_disas_context(DisasContextBase *dcbase,
     ctx->branch_cond = TCG_COND_NEVER;
     ctx->is_tight_loop = FIELD_EX32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP);
     ctx->short_circuit = hex_cpu->short_circuit;
+    ctx->ieee_fp_extension = hex_cpu->ieee_fp_extension;
 }
 
 static void hexagon_tr_tb_start(DisasContextBase *db, CPUState *cpu)
-- 
2.37.2


