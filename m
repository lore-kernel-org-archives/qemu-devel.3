Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E5E10F996B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXqJ-0002r7-2M; Wed, 08 Apr 2026 14:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAXqB-0002BO-36
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:41:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAVtz-0006o1-8f
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:37:17 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638G3CnS3781111
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 16:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tdmd31/hVMi
 bPQNSMF+BHceyMKga+YxUHsDryJbW/yM=; b=f4TUKGTssulp1YiqAiqhgvOZR34
 h9sSQnoQby+y3sHebn6OmMgAO4q5qS1Q8OqiUDxKM1v73QuJfWfFdZFfKzOmTisn
 08tAs9NKEBahSGx6Nk+p/u5RvQ5Ys9DCPV0UX46X4/UqXLX0NmZg9ao82NbGrCBs
 BZKWOgkXHYQ6FLBDXa2iNUwUe5syA33EzlZ9vAnXqstuXpyZvWJfuudRWzx8HQIV
 Esl1FtPHFLzXNjupdHCg68N94kB/2Z0QsHX//6ofMm9OGs5y6j4JN/VBYxEZ8/kQ
 ZOIfVYEZp8JKh2m3rvsF4Ohhrhux24pxP0Y1bHoeqzFeABiAIb322BkR9eg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddt6y84bf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 16:37:13 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b630753cc38so138136a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 09:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775666233; x=1776271033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tdmd31/hVMibPQNSMF+BHceyMKga+YxUHsDryJbW/yM=;
 b=ae+u2VUiWSlyj1vscAu+luKpvwX5shfeyzGeBm0TeKTCvrI+gpaf3sVZHb2FcrbmKB
 ITVlk7mkhQSwggvhE08bh9mTOMS8+np8yHJ6To2htub8nKK6WntfwXyowQoxqJ8yPRbe
 dN+Nco6Ph1/Yr51rZSBWtG6D+a6rihtHG4wRyuDcKMtH+pWA88Or3xH1cZoaFviQpnMx
 a9EHgxag9g0eiTXS7OXkOosHcBWKIir+bfozB6utVq5g4Pfnmx+qoOCq3vWZIsO3Gv9X
 cHF5S6mOgn/N+oiQLIxF3xzDVZ5e77QpsnaI2r25jC37R06npMBIk/T1lT2eZw6/tOAa
 N63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775666233; x=1776271033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tdmd31/hVMibPQNSMF+BHceyMKga+YxUHsDryJbW/yM=;
 b=fF+OHGWNcysUi+gczTSkVN579UMAFMmh+Yv52qiMW/4TfiQZcwYh6tlY7ziYWXSHT6
 ttcLSebLXKYJh2HUCCWcl7ji8jsVPIiGsdCrPdbcbgeL6+dVJWDSc/WHdTGv06fm5ZoC
 0bBWBUIuy0J/P9bIRgdbF2XYN5y+n8R+y6YkEYs4i5+PvB0tAlvhKXWWdYEs1OTq0RJ/
 k4DY2VGZPkuT8oICN0H0pilONOQbiwC4i81qJDEFSesS3yjKxAOonxsl6J+0AvZnisMQ
 wsYqALco4Tm3Fn1nzKd1kio0UBp49orIZsZRQgu1XHRfM6Ekay9e1USIda0E3+DW4gay
 b9Rg==
X-Gm-Message-State: AOJu0YxzAVm4WbxgZClpG57B1aGTkn+677MSxm+jY4EZx2bKgjq1OmYG
 BSEh/5ONVXX2ibj8BxJTc6W8pDU0FRkqysQcP+QporBujKiy5RmywyHfzWHnwz3VKW0Bkqeugqb
 fO99fmvAH3QKadQrR+txGdKXaQGMwo9AzEaB+BX4SXB6UT8wbezhOVrqcR8o8qLhBN4cZ
X-Gm-Gg: AeBDiev/8YcNs94RrWEv9I5rkIEXQq2bxosduJQZG7CM/S0PvCyg+CdXA4ghw0bGv1d
 IBDphSskytpSV5yMUaSCXCmcTsMVSSN6a5SBFd8gr+LD9par18khSgYwNQwUpWqeddWVsBlOCG0
 v1xYoUX+ADxXopHRJp4tuk5OqUdbr/AExslpnU1nVcjToKg0lCTD4iMktRExFkLju61lG+8s7a8
 x6rtkWcrZM4f3c+3X54vdq6g2a0XY6yuguyxunud928wFtlDgfudFAfZvIwQlKOgC2lspXZIZ/U
 apDFIM9VIwvmnv7iTA30xGYygllCfQxd/OomRK2s0HRPuJxKVFwg4voZeRrcfzZP0Rkn4P1w2NT
 Yjrff45RJaH5y8eDhhyYgAKzpgXVFyWyNqlCmIy3nLWVvQMMJMDuSRP6CcEJ4RpQoGByC3RzOPQ
 d5qosYfGUK
X-Received: by 2002:a05:7022:212:b0:128:d24a:a5ba with SMTP id
 a92af1059eb24-12bfb760956mr10168468c88.20.1775666232806; 
 Wed, 08 Apr 2026 09:37:12 -0700 (PDT)
X-Received: by 2002:a05:7022:212:b0:128:d24a:a5ba with SMTP id
 a92af1059eb24-12bfb760956mr10168442c88.20.1775666232170; 
 Wed, 08 Apr 2026 09:37:12 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c1ff43d04sm4082006c88.4.2026.04.08.09.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:37:11 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v3 03/16] target/hexagon/cpu: add HVX IEEE FP extension
Date: Wed,  8 Apr 2026 09:36:54 -0700
Message-Id: <bd05d9aa88d98453e25e5f3189f1a5d7bdbbc9af.1775665981.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 98xhWD-1hH7TIhUcVMrQ67jo4793rki6
X-Proofpoint-GUID: 98xhWD-1hH7TIhUcVMrQ67jo4793rki6
X-Authority-Analysis: v=2.4 cv=R9sz39RX c=1 sm=1 tr=0 ts=69d68439 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=QVGlRXe_Esul27Px_LMA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE1NCBTYWx0ZWRfXzTQ+BKJNR2YQ
 fPGneCx9MJQCBqHLUxWCjziax9446CvAvxUeWGMUQxiatCe18CDrEQI0nPAXx2NVN+mdCsDkXE1
 fN7ZVB9uc+txxUvpYwO3bhFiC+m4AkmIvrZnHcN63xcbUNt8Exy51qM3vQkpgwFBG2GbAqRIivY
 TGowT8MtsUV0e7K33DZZUoFp4tdA/mwOtmNlBsoO8Jxpmap0rtuOCHOEbNN1MliNujI0tQMIrRy
 jAd9YxHa4vSbvw/yJj2s677721QcfhwR0jbyUY+4WN++E+qLNFXbcxr5AY2IsN5ashoE0BnPNAv
 tYw9+eIRqxDPM1NGhdnYE7W+wwPTHSxPmGDw90DEO7TJYfUo6As8Na1S2iplPE2qMbsn8VQmpCU
 /AF1PDQliKw0NkNu5Mtw73hj0/oaZID6pXLEISfIKeGDjlvtrzZxW3sUZ4V5acWf5lT35Azcm13
 2KGtu/vSy58VGcHrVrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080154
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


