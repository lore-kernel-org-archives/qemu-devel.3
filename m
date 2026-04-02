Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F416D39413
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 10:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Faf-0004jC-0D; Thu, 02 Apr 2026 06:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8FaW-0004fH-EU
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:47:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8FaT-0007nE-GE
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:47:48 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6328d7LC1249375
 for <qemu-devel@nongnu.org>; Thu, 2 Apr 2026 10:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tdmd31/hVMi
 bPQNSMF+BHceyMKga+YxUHsDryJbW/yM=; b=a5c0nS5CeYjZyl2aT9kImUwVi2j
 P7LGk309owNNgbnlWb27Bq9zTn6wtIJjJRXwyvLN+O6bNAKMjcuV8zrjw2gAU5g/
 6+onZgDsmtkSjzehfASQzZhdgq6uHWWJdN85bQYDSEGpt6vFB/W9ZB04UsyEzt4U
 AtIH1av7RViHTkLgSYD3dWcJqMg7bKUENd003egNJfew/SzfVu72BHlKBFMK/qyt
 oJcN2H6EI9eQnfZHTAWLkCciQn2fl2g7NNP6wZYAmwR+RkPnTxOWPXVeq9IC5lry
 lUqb8HbGAVPRnaxLRaFTD9fVI/Nf2mpYLYc9Zegxx2pFzpZrzlkxbRkDAqQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9n4t0fs9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 10:47:39 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2c5b48baf75so5456029eec.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 03:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775126859; x=1775731659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tdmd31/hVMibPQNSMF+BHceyMKga+YxUHsDryJbW/yM=;
 b=MriGsqBrF1GpsTmoe4XoLg6PzQD+lMdAFxaUJ7KZXjc6vIofGIqD89azYXt3JKntV/
 h2qcdKMX3IwgB16Z2bLZX1L/Xh0yN9CD3tbBTHS70n77avUJqRqMIx9/dMxStytxTWAE
 XzQ7AjB5gGZ9jJa0n2Jx9Pkq7gaNhlRhlS3kRUHbdODeO1msYxN90txeIYqp369qscl/
 BF53LVZWNxscBTfhQ3QUvbKvf7dB7K0aC67CNHvBfLLSoHfQg9+KsCIORligcgTTG286
 R+JR94BelgUOnNhZz/+tZYsaFTlBoXEYyXJizPMj+KQdLKfhHIKc/n2FM5liDEpjHiNU
 EDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775126859; x=1775731659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tdmd31/hVMibPQNSMF+BHceyMKga+YxUHsDryJbW/yM=;
 b=XaHdIsYurnuXGZZbDe8YjVidEim4blBJKtfCHZ52Iyxkh9eVY1rOYIzfDbZGAsO2yB
 iZ1Fx2YUY0leL9hYI0nbB+Ep/eAVxvPqV1rUizcH8z4cF3POjJtcsk+aW2ceXDjIAvqB
 zVX4b2pH8jLTpwj4XCSNbIk3iUKqVSZRU44j1hw+mzM5lh4nR9dczyxnB6PhojiHDiJ/
 CgFRo0tm0uDP3eRLDcD8ZM1fI6I5Zq7OM+7BCmGGwg7BtlwipRtXn9QqcZDMFKCo69S5
 VZrMCAmilawXDDR5haQjYrxv/Vefej1o7+jy8fIM6j17/49S5dBBZoWoyzWGg0hb2pcg
 /1GA==
X-Gm-Message-State: AOJu0Yx+Z59vN44jYxW9+cPiwp8PkqfiujlFTITcQRuMtHfic+z359od
 Hr+N+noA12Qaq5Qm7CUR9n+bam9dyAO+q7LImI11YrCBCFdqu7jnqBJvr3k7F06/Wt7TlodNkE6
 9yvY+kaIzKH62y5j9ccoS3VRj2vzBaFZlrci5ryX3srrZir7x/C6nCMd7Eii0PLr07CVv
X-Gm-Gg: AeBDiesw/AMgD8uVO9AjtIjcZ5t9IjQUEpBXGrx9WI8yYwZvar9ojRH++W088W4RvTA
 eYNe2Wn/j65oVqS38NAG41Nt027IY85KP0pW5GWQwbajVnfMFKNJjddR7WU6cXoB8HUC2ro6ayO
 NPyysWkxvIiKhm0gr80h+v9ZCZT5uOla5Og3dmxJ9jtW4REHMCnqwmYSG1xP1W2zubNnkh8XNmd
 zpdcamlkmBIWS0UU+b5CCwEQqH3ku3JoC9u65co/U3jFHGqJMigo1VrlOCenlDwB4WEHytgHv8g
 IXRcrUEHxiGZCHQvAYp52zf7XjebNz31hMIngEko+ChjMflWOwDfp4nDgjmn4W26I7BDk1fN5/3
 h+HAZU/SBeZlhIO9h25iJDXMuhHLsClW2j8OfJkrmPiEH0Pj4QB3OTylcv/KVkFe6lJVQaaqE9D
 l24G8U4N1H
X-Received: by 2002:a05:7300:dc8b:b0:2be:837d:cc4d with SMTP id
 5a478bee46e88-2ca8dcea8a4mr1457338eec.5.1775126858940; 
 Thu, 02 Apr 2026 03:47:38 -0700 (PDT)
X-Received: by 2002:a05:7300:dc8b:b0:2be:837d:cc4d with SMTP id
 5a478bee46e88-2ca8dcea8a4mr1457314eec.5.1775126858341; 
 Thu, 02 Apr 2026 03:47:38 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca7d00f5easm2004783eec.29.2026.04.02.03.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 03:47:38 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v2 03/16] target/hexagon/cpu: add HVX IEEE FP extension
Date: Thu,  2 Apr 2026 03:47:20 -0700
Message-Id: <cbb8794e47694bbb0576313b882dd0ecc525cef1.1775122853.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6wSV6cocFeSotUmD9Xu1MsUiLoYIs9Lk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA5NyBTYWx0ZWRfX/ZWQ4eAXX3el
 5dQOTgsT7K2EuUusSXGtZLABD+XnEvyukjzvbfZyUWJUsm+Q+CrMqj21g0sg4mQauJH4DM3OK/s
 jtCfMjjRjPFFW9zBL5ZLFJGtZFpzu8hbE2Y7O7pjROdz7TW3pblp4rlYi8j0IetmBhO/ShzvgNB
 Tikkb0/yjYSOu55gBphbMEx05e1M1HswrK0pKIy8CAh/Qj//1H9YxC0m90qlO/nrk4xM0zhXSt3
 D7jn0FCH0ZASNM+BnfVAC1fHmvLVhUJ19EKT6KuFlwO91FMYvgH4FoQEWwhgygdwsHZ6CV/uUTl
 x+jK5I3VX9wSeVxzw2tXFKRGLFVLZDFYFbKb3/GYiyrP3uunjH+5ZawE4dM+vFIPGhx2nwdM2Ua
 AlG6D67g+Sb+UQmJROa/9HmuHR2PEFFv65S1CqSNnw75Av2VAC+7OfgIBfkPyDny23Kf2KCTMNr
 yxgWJRMc+8mJTL/4BXg==
X-Proofpoint-GUID: 6wSV6cocFeSotUmD9Xu1MsUiLoYIs9Lk
X-Authority-Analysis: v=2.4 cv=Ap/jHe9P c=1 sm=1 tr=0 ts=69ce494b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=QVGlRXe_Esul27Px_LMA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020097
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 target/hexagon/gen_tcg_funcs.py  | 11 ++++++++++
 target/hexagon/hex_common.py     | 35 ++++++++++++++++++++++++++++++++
 7 files changed, 53 insertions(+)

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
index c0e9f26aeb..32a61505ce 100755
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
@@ -946,6 +971,11 @@ def decl_tcg(self, f, tag, regno):
                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
             """))
+    def gen_zero(self, f):
+        f.write(code_fmt(f"""\
+            tcg_gen_gvec_dup_imm(MO_64, {self.hvx_off()},
+                sizeof(MMQReg), sizeof(MMQReg), 0);
+        """))
     def gen_write(self, f, tag):
         pass
     def helper_hvx_desc(self, f):
@@ -993,6 +1023,11 @@ def decl_tcg(self, f, tag, regno):
                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
             """))
+    def gen_zero(self, f):
+        f.write(code_fmt(f"""\
+            tcg_gen_gvec_dup_imm(MO_64, {self.hvx_off()},
+                sizeof(MMQReg), sizeof(MMQReg), 0);
+        """))
     def gen_write(self, f, tag):
         pass
     def helper_hvx_desc(self, f):
-- 
2.37.2


