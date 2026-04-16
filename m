Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E885F8A15F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 11:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDL47-00056q-OY; Thu, 16 Apr 2026 07:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wDL44-00055s-4b
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wDL3y-00039w-FI
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:19 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G9YVtS1553264
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=sangyG8tfzJ
 3xLqN6HjSzyDmUUok+xf6sPcbdCH9vRw=; b=B0BZFSavqLZxDWhJz3eV3mbIQ19
 amalyX19y15AsxyHs2/E0xG6gOLJ+V17KUVAEbyo07l/JHaRFFqPQYW6qn7uLk62
 /5sglp/z7nn0ZU00mf3D6aAoYCKmIAwj+a14GvkrlVAGqPiBu7QSlNZk4ogsslka
 hqecS21CDpm7TvinUQIu3bl8K0P2v+0yKsPesz3qhZGf5hOMm91z7jYI0KjtH19Y
 cQBOpyPeMLKpCMWEJ4Hp+T6UGBAR2tc5AP2MBJhaTRuflPHrkHO0P5VOfcBHy+l/
 crXHxJBWwH7j9Gn0fJwbNHUT93+4pyeoiQe7lHXUg104hwf4GyrSA7T6p1Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djrsn9g8g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:39:12 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2d8a677cdfaso5562870eec.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 04:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776339552; x=1776944352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sangyG8tfzJ3xLqN6HjSzyDmUUok+xf6sPcbdCH9vRw=;
 b=KvRoz3lziKnk8STmtVXpNRgHAKC//L67n8aohOKlUUCYTajDglveGj5XpFJ4AOP152
 8Mw+Aslv1t+oiNvxJE2HaJlGVOdGrd3Pb7XSUzXnbg2dAtZ55fyciwPm798X7WLVVPzk
 1eqWJnM3KpZV0jxWv/OXREW9eV0aBaBSsGhQAo9dFO7z8hZjrl8apMiQ4K3gzZTJ2DCQ
 4EQ7UimFsVtMUjirVA3RJCETydhlhD0KdZc41QibZrn3SpLQqkZI8OJN4MRpLNXR+00U
 MVInrJrM+zDe1/spai0tCmPNy5/9nxCe6HBV/KUqHQWlX4/0BuKDVbZTcyDVZPVYOOsh
 7TuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776339552; x=1776944352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sangyG8tfzJ3xLqN6HjSzyDmUUok+xf6sPcbdCH9vRw=;
 b=nCBHLrXt7B2VJBarP3WcyF8DgbeuOs74ojaFIO66ruxuE4stnl+9c++qQx7Tr0tf8I
 m53siY2oX973AjoqXJ5UmCMzjMQLo09K9/qWKDmwG2qrYKe8og8bDfurKxZuIwvIflD0
 jdYkIeZOXw6GL7eEd0R2mhahtFXSzTQla2XLXEr7rfelsiWHoSc/OiwBTsbAxB6FBXTX
 cg7FExurNkScL0PtP10DfQHNW/mzBF9WDtoyAQ4C7/9sQLO+SttXNkGlzp/RDM7IM0lR
 Kfu2ieaMAObnC9eXhbeptT3dQ0RHYiGVN8/OGtkgdhNX6EWRLQoHjlB1FaebolO5iRdm
 VYqA==
X-Gm-Message-State: AOJu0Yz8Fzt0vcCOGzmNI1T9nWFXUIsVCNtc9mHI5BZh2ug9d9ULEM85
 8SJCNUAOCp2IcSrMRuMPsWn0i1XD+xEloI+82G1IysShL+eA9MboazmqCWI/wtUt/GVWQpQRRYa
 mMtQysxOlQCB8CcRTIPvNp7qa/EjD8LiPkJ5l8yoiaKWEoc1AzB0VGHJaSmuibOs/0HuM
X-Gm-Gg: AeBDiescnPghHozgAhJjaDdAFm+LwvFCqVgnGYoSPXvCv+f3h6ZSemUriAVg3GBZ+Zy
 sxTKz3TSQ576Qktqp3EZZX0TUeP58yCPYgqtnCytNXuO8Tg33ke63i7eDR+utyUliudtqWh0Kk0
 Di0HeF03sOP4x5JA40wDqKsqBenQsMdZ+y7AgdkxdhpffKeSXozM/tUaYBpnyfJAVYvA7zkPqKG
 51LuVV14WXSLyxEi/RDvucnf23KzlxqmN0RLcyjf2J1oGlOLbd/ZfN4S/F5Sn5XB4qtjRiDAT/A
 JcxsxtZegeaEh0V22S20HXLunZYx0APvK95eIjA4HD/G/toVaWmEKq+TlT/3Tkvgpe5PbP7gcia
 YXyoKz9UDNSKU3aFhHfMbPUDdAn8kwA+EnxwlLTBUQ21zb9uv1LmKUhTI21kaekZ4Rh0E2lBGJn
 MOsOQqP57iMOc7hG81Iig=
X-Received: by 2002:a05:7300:cd86:b0:2dd:db16:478e with SMTP id
 5a478bee46e88-2dddb164ee1mr4761090eec.10.1776339551838; 
 Thu, 16 Apr 2026 04:39:11 -0700 (PDT)
X-Received: by 2002:a05:7300:cd86:b0:2dd:db16:478e with SMTP id
 5a478bee46e88-2dddb164ee1mr4761065eec.10.1776339551217; 
 Thu, 16 Apr 2026 04:39:11 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c10a65asm6845391eec.6.2026.04.16.04.39.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 04:39:10 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v5 03/16] target/hexagon/cpu: add HVX IEEE FP extension
Date: Thu, 16 Apr 2026 04:38:52 -0700
Message-Id: <10fb5b86db60a465e51db2cf73185307a1ec0895.1776339451.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: dfFrfKXMmgzBeXi9-t5OHpOv8C3H8XDJ
X-Proofpoint-GUID: dfFrfKXMmgzBeXi9-t5OHpOv8C3H8XDJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDExMCBTYWx0ZWRfX0eRXuAaqKvXk
 eCiu8MLm91Oe5H1ObODs6w1ijve1JRRxZAL/Oa1IzhKCpn97ZVVctoJQpgIDwY7MFM7Z6u0yaV3
 rL+FnBtmQkH3//93Rwd0CWSNCmTBqQu3/CNp+SduZRzwEabUa0z+rxavChV1Dp9vH+wnt6wTEss
 l5z4P9JsuZbk1B72zwuT8g2Vr/jADlHY5xB7WZcw4iux2Vn4Y11VXFpAyB1gddtZkzEkamN+Z5N
 Hx47ysdfXW2/OTMuBq1ROV48C9tZbB7zA33o5Lv85ZSlikGFYabR/40RgYDnN/WsjJUUwtUcH61
 IKR+USK5qv3KqLOJ4iB3ZeqRJPBVZXNXU9aDwOZTS7Qgk4IytJrghhabg3BdBUBJnEZanK+AULa
 rIXbKwY8Z2EztblLmyshqyWmTCwx+tbskS84qEHQ5lNY9MBgpHyG5XDPAmRzzan0uqKB7ZCblfN
 yuIWP9XrOww2sJ7Cigg==
X-Authority-Analysis: v=2.4 cv=EojiaycA c=1 sm=1 tr=0 ts=69e0ca60 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=3E6RppW8_B6KdyBj4qEA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160110
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


