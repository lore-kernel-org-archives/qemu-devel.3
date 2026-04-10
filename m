Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AB0F459FC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 17:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBG5a-0006nT-Er; Fri, 10 Apr 2026 13:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5Y-0006mf-PK
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5W-0001Xj-2I
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:16 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AApPnH709117
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=sangyG8tfzJ
 3xLqN6HjSzyDmUUok+xf6sPcbdCH9vRw=; b=UJQDbGAMJu4SfaSY2CwMv6DwORw
 WN3ghlqfTcIJIIiFUXC5uR1GTy8WozcgEV87LlxAADBQB4di354GDy8JbO0wJOm2
 8KG8dkHyy2PcbnmTWXL0vVgnjbLKgZSHSKt1X4Yc8dBGhkjeV3jaB3d0ikEeOG2+
 EwuHwhy910U0Rwzumos0dua9iSVZjYXNFD/rZGKPAWbWNeKiBxZTb7v0pkDdLKjO
 BJVBCKxrvMXz9nTDOVym74Qa5I0wVOSXI0TOSSAN9JoAiMe01NKD2clqcDn/z9jt
 GwLOwrYTq+04fmTdZJLjC+UFnv5qjC8WMJu6FzOeFIiFxD2ecBxuW3adc8A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deudj2dgw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:11 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2b81ff82e3cso1183653eec.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 10:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775843770; x=1776448570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sangyG8tfzJ3xLqN6HjSzyDmUUok+xf6sPcbdCH9vRw=;
 b=MSKN2o2s+2W0icQ9xu/BmPh1Nz6Haw4NerJf56zLKH5uZQD55vPiry0j147UgLzXr1
 14xU38+29j87g/ggQ7dCrzIyEpSRGLGPiyS8Ahn+tQpoDvUAkErjo2UUtGHboyt3c3XZ
 Se1rw34oYgQepZIdL9al6/oLQ9ASPfslxS7G3DSCD32u3lz3bUDEBFGhJ4VJxZrV7nvM
 1HniflGF5seIrZvCSR29yRPOCOmopVdiVQSyfwSo1jPNFwlSgoYLkR/S0EdCsxSms327
 HG2GU/mR2jsGqDk7FpR+S+Nda5ozsBA5yQZYlK3YoFUeypU8edoIuXYhoq4CQxsu7V4T
 IJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775843770; x=1776448570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sangyG8tfzJ3xLqN6HjSzyDmUUok+xf6sPcbdCH9vRw=;
 b=rgBsdcQ1tn0dZbKScgk01cBkXcJZkk4sGTqe41arhnb32b5lpMLtp6FtitzX94jXyI
 rmhQwSb1WZGcFV+ovInBjBD9ZTNI2Kp8Zm3B9ihtgJR6OLyITXJmhO/o7Zdk+NsRLn33
 eJOq0XrkvfhXjYKOXW5masxBp0Jf1vq3kyZvNZaTTYvS2GGkdsxsRYWTznztgxjkwsvY
 9TGjGkwmMsOCtU94DEhLJVVwmKtFbwhUqG8pyONItFtDEKQGLomoDLBYVRxPhBAhXkLr
 XBZvphfUvCeX1eem/ZNIAHmb6vyjNEAZ6xyMN2X0I4fdD0Yqi3LttVVquevHPO9PQOmR
 fkwA==
X-Gm-Message-State: AOJu0YxTSe4YgvDynaGaBra2Rl/ijNgvGE5UjvQGAYLAMmhElDFeF3Ww
 +eclYSKryG8+GQlxGRUFUvHVhaiggv7mEsdFBDtGMXMn+U5mfyDexcKpa71rx3nX6jgvfs/TCWW
 h+mniybiqbEUawhqqZ1nk4VQ9QjiwZAAmY5A/hjJO6+jsKfRUDuarMzOnDBhy1TMx1/+u
X-Gm-Gg: AeBDies/TxIryyFGWqgmmsFTRfESIG6es21+ksEx0V4vUfaUyxtZpKNSEIrqCYjr86S
 kwbklFpaJwdwQU8Cn1GLIwMwKZRnsm6KzMWPJLIrd+0S++HN7rta5TMDUiGJ6FuGZb7YkueAEft
 CpojLUgLNZUMfaz+N7LcaJJAKdBPatcA0ZIOrihL42dHVggodYWM8r7DtSqxDgslU6cp5UhcmYK
 /kgrcSMyKX11ky72GOWKuDRzfMoitGaUAJGtlIXkzekE6ovYNAICkkRhay11qCZsXOWt9o6RSfO
 WdhDC8A9THLeePzF3wSumJ4C8zhxiYx7H56sQDuDm+bn52RS4tkA0r63a4zk0gvMZw6EF51FFjc
 KEtihMwV1bEFOTZfA18FyZacorl/iwd/ikx5LMLj9OAdD/NgWkpGacBPNYm9VOBn/ZhqasfO0L2
 OlsqMgULtP
X-Received: by 2002:a05:7022:6186:b0:12c:f77:f087 with SMTP id
 a92af1059eb24-12c28c2946emr4003215c88.12.1775843770226; 
 Fri, 10 Apr 2026 10:56:10 -0700 (PDT)
X-Received: by 2002:a05:7022:6186:b0:12c:f77:f087 with SMTP id
 a92af1059eb24-12c28c2946emr4003210c88.12.1775843769681; 
 Fri, 10 Apr 2026 10:56:09 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c3459f7ffsm4256271c88.3.2026.04.10.10.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 10:56:09 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v4 03/16] target/hexagon/cpu: add HVX IEEE FP extension
Date: Fri, 10 Apr 2026 10:55:51 -0700
Message-Id: <7889db953a4d91781d4c669ab89a43ad8ed3fe6e.1775843299.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: x6PxLnRSRTR-FdkOCih8oSu_mCJ0nkt4
X-Proofpoint-GUID: x6PxLnRSRTR-FdkOCih8oSu_mCJ0nkt4
X-Authority-Analysis: v=2.4 cv=cKfQdFeN c=1 sm=1 tr=0 ts=69d939bb cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=3E6RppW8_B6KdyBj4qEA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE2OCBTYWx0ZWRfX5hK0sa8Mz+03
 zHLSECuu7xdPzD6y4Y42f8cHkTvIvFJJGyzC6V1AiLZOpGe4MYXINjYSmxBoc0okNP8LfrG9Egp
 eEEmdpqprAlKeFEZgihgIXWOCEICv1F9Z1x+sGSpOl4uvoNYSRqy3WVAQHCx8Px/l3epLLic1CD
 q7xKUuvCaYWbRpeWLEA7G0/FSHGqbBB4I2olC6ZmxZwaL46QgQA0lhtzWyubpIU68zf/ewBSYtF
 0kaLJcP5pLrUCANWvgj5f4yEpi9SbBETJJJUXyTd4mo1q24pnrQmm8083zRFwydQHUikded1pml
 b+r/tKI2BawCNIqQ92rk+EqlK69PyjrB6WtBNfF9Y7FDwfNv807tBxVC7+x4ahSAlw4GP5OoGDS
 MNdkyeAzlUWX/H9RwIzrmHwxqpCU7MUQZRfF7tKVvjd0mDNStxvWEGtCw53B9B/M9YCQMI8FeKK
 IeIuJLWnmflBiuvTDdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100168
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
instruction effectively only set the destination registers to 0.

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/cpu.h             |  1 +
 target/hexagon/translate.h       |  1 +
 target/hexagon/attribs_def.h.inc |  3 +++
 target/hexagon/cpu.c             |  1 +
 target/hexagon/translate.c       |  1 +
 target/hexagon/gen_tcg_funcs.py  | 11 +++++++++++
 target/hexagon/hex_common.py     | 25 +++++++++++++++++++++++++
 7 files changed, 43 insertions(+)

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
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 633401451d..fa8f615a9e 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -988,6 +988,7 @@ static void hexagon_tr_init_disas_context(DisasContextBase *dcbase,
     ctx->branch_cond = TCG_COND_NEVER;
     ctx->is_tight_loop = FIELD_EX32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP);
     ctx->short_circuit = hex_cpu->short_circuit;
+    ctx->ieee_fp_extension = hex_cpu->ieee_fp_extension;
 }
 
 static void hexagon_tr_tb_start(DisasContextBase *db, CPUState *cpu)
diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs.py
index 87b7f10d7f..b752ec883c 100755
--- a/target/hexagon/gen_tcg_funcs.py
+++ b/target/hexagon/gen_tcg_funcs.py
@@ -22,6 +22,14 @@
 import string
 import hex_common
 
+def gen_disabled_ieee_insn(f, tag, regs):
+    f.write("    if (!ctx->ieee_fp_extension) {\n")
+    for regtype, regid in regs:
+        reg = hex_common.get_register(tag, regtype, regid)
+        if reg.is_hvx_reg() and reg.is_written():
+            reg.gen_zero(f)
+    f.write("        return;\n")
+    f.write("    }\n")
 
 ##
 ## Generate the TCG code to call the helper
@@ -62,6 +70,9 @@ def gen_tcg_func(f, tag, regs, imms):
         i = 1 if immlett.isupper() else 0
         f.write(f"    int {hex_common.imm_name(immlett)} = insn->immed[{i}];\n")
 
+    if "A_HVX_IEEE_FP" in hex_common.attribdict[tag]:
+        gen_disabled_ieee_insn(f, tag, regs)
+
     if hex_common.is_idef_parser_enabled(tag):
         declared = []
         ## Handle registers
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index c0e9f26aeb..e82a3da1e4 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -723,6 +723,11 @@ def decl_tcg(self, f, tag, regno):
                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
             """))
+    def gen_zero(self, f):
+        f.write(code_fmt(f"""\
+                tcg_gen_gvec_dup_imm(MO_64, {self.hvx_off()},
+                    sizeof(MMVector), sizeof(MMVector), 0);
+            """))
     def gen_write(self, f, tag):
         pass
     def helper_hvx_desc(self, f):
@@ -789,6 +794,11 @@ def decl_tcg(self, f, tag, regno):
                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
             """))
+    def gen_zero(self, f):
+        f.write(code_fmt(f"""\
+                tcg_gen_gvec_dup_imm(MO_64, {self.hvx_off()},
+                    sizeof(MMVector), sizeof(MMVector), 0);
+            """))
     def gen_write(self, f, tag):
         pass
     def helper_hvx_desc(self, f):
@@ -821,6 +831,11 @@ def decl_tcg(self, f, tag, regno):
                                  vreg_src_off(ctx, {self.reg_num}),
                                  sizeof(MMVector), sizeof(MMVector));
             """))
+    def gen_zero(self, f):
+        f.write(code_fmt(f"""\
+                tcg_gen_gvec_dup_imm(MO_64, {self.hvx_off()},
+                    sizeof(MMVector), sizeof(MMVector), 0);
+            """))
     def gen_write(self, f, tag):
         f.write(code_fmt(f"""\
             gen_vreg_write(ctx, {self.hvx_off()}, {self.reg_num},
@@ -854,6 +869,11 @@ def decl_tcg(self, f, tag, regno):
                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
             """))
+    def gen_zero(self, f):
+        f.write(code_fmt(f"""\
+            tcg_gen_gvec_dup_imm(MO_64, {self.hvx_off()},
+                sizeof(MMVectorPair), sizeof(MMVectorPair), 0);
+        """))
     def gen_write(self, f, tag):
         pass
     def helper_hvx_desc(self, f):
@@ -913,6 +933,11 @@ def decl_tcg(self, f, tag, regno):
                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
             """))
+    def gen_zero(self, f):
+        f.write(code_fmt(f"""\
+            tcg_gen_gvec_dup_imm(MO_64, {self.hvx_off()},
+                sizeof(MMVectorPair), sizeof(MMVectorPair), 0);
+        """))
     def gen_write(self, f, tag):
         f.write(code_fmt(f"""\
             gen_vreg_write_pair(ctx, {self.hvx_off()}, {self.reg_num},
-- 
2.37.2


