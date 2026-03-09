Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74766F417EE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbuq-0000yE-55; Mon, 09 Mar 2026 10:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuQ-0000pG-BQ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuO-0005Dg-Ah
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:37 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629EAR791249016
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4GZnug9ptvzXBeCOm6nt56nQExnanu1uhh//WEVAiVY=; b=YDNLrMwIwMxDYsA8
 YIZ5YhTVxsIlOlU6/jj+QG/2zXFuG2XgnggcZvCtPkxKkgfgg9dZ64cPOjvLmhcN
 0tpnxb56BIPpnTtOmK2423LJ1+Qm7UilVroF+Idw3RZvyO89tCu9kZjE91KfcRrp
 WVDQflbsY9YUuZ590TgMy0tuPZfLnCjdiOlGe2ux3ToQbqf9jX5PfidTc6TxBSDB
 d67Sqb1GX5SamQ23OPtuylEZM1HIpLkEXisehYIKINdaR4Bsos53iZ9hl/4Y22D9
 +JJFOg6XJzgjEur5uFl+d/noHGk73dlY8ZotPLBX9kTykiiA6nggEfkY6maj4Y08
 /Oeu1Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyr403s4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:34 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2be21146933so10001816eec.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067714; x=1773672514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4GZnug9ptvzXBeCOm6nt56nQExnanu1uhh//WEVAiVY=;
 b=Y7fkmvHnnKqcQOQ3nmh3LWJibaiP69rUOeRNvSpoGYBCb/OAdfwrJ3tgI6DHxU7zkf
 6xX8ZaQu3Zoj02RadaR+06DB828x8+zZ4zDUgVth42rKDw3iccQOj0MI/cB0goPE4CtZ
 BbENHaZTb0ARIccvCosbi6fU8p1lwpyANOrKY71Ao6NDchxrnhosgCihuhwcDvcR5qsg
 BYtWIR46jMnn9293bFqLud4JBnriAw5LTFv+EIlRZecRqm2O2BovhyLIT7KL5iTVSaN4
 r2Zzimuwf17a7yiXPuUrGK1hunMi66a4CpP5fWS824YeS2RmMV/rfTTncKRnr5hHNlSJ
 3b0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067714; x=1773672514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4GZnug9ptvzXBeCOm6nt56nQExnanu1uhh//WEVAiVY=;
 b=IOVzpxq9ElSLk0Q46Khipn9Ba5THGSsllm8RlYNBHPUpOwtwThm49uJkwinLdwh7dv
 lmloPtbhK/gl1voMlI6y4AmOXW/jdvNJt/9DP2V3drM3LyzmEUXKxcxj1pyoAozMqIqi
 diLgZP3d1u6pVbBikQyT7KJ4I7+LuiHrgkHOqzQDyAmQv4H7yDQv4c0bynK2Alw1TZSh
 vOytsZTTdfyz0lZAQjcjEoojkYRYVrNaKtT9fdSkCJgeirDO2/7uSGUlXlGDsyt+NeKs
 HmGMKba1aAYvHysQvGqXJG4Qd2+E/+5Rvj+7GDdVVckcVOgEmRwxsD9AbQsdDtNO4dld
 vbwg==
X-Gm-Message-State: AOJu0YxU5EsRx1rP1aVqyx9TzPkfUrk7roP1HIsVMKuvUSW6t6aBCPvb
 nrmfQFc9m33NV/3hHd1vw1fVpcovBJUBFpMTQID8sS4EXxHdCqz5v2vv/QpAIU+N6V8pW7FANct
 SILpOuImWCLi0XIaici+kHDT6NfCgnT1S92HK0MyDtRcbLniJ6OSLfWEX05Ek8eqoww==
X-Gm-Gg: ATEYQzwdtQMf1KMkqnUumZV9o77eExyeWAgw3AOWlYcntdDu1TZEMKEoazR1gZ9Oxeh
 e+hDq5hJ6agpAAdIzEiRiqGBSIeKniNUWmY6bFvgycQESe2rsUhlqY2s7kMBSzRBfr2HoodboZo
 VDTGXeKvHXpmDpf6/he+lHN/LrGNG8FVwxdPbYPD5ogO77Z8vvuMexuQMIVlnwRQBDG/dXJPSsC
 xLGMA4Dgi0Jk8ZJ8HrwdrBoV9l12APDWkwC8qfnGVvHtuBNZGy+C5r/FMj+J+nT3cnWx8RFJ52W
 pSCiqgbRaCNY0npDW0oDI4EIGiLOd/XgcAYkxBXeofa+AT0e0fOtlrMpWiQOHETikItxHpJIjl3
 3eKVBId5v0M0hErIPEn5WNm0r6aUxIdapTpCD7Z/f8KrKhKDlY4x4YKdKq/LCfjwTB1BKsw==
X-Received: by 2002:a05:7300:a985:b0:2be:10a6:647e with SMTP id
 5a478bee46e88-2be4e055786mr4195889eec.19.1773067713759; 
 Mon, 09 Mar 2026 07:48:33 -0700 (PDT)
X-Received: by 2002:a05:7300:a985:b0:2be:10a6:647e with SMTP id
 5a478bee46e88-2be4e055786mr4195859eec.19.1773067713051; 
 Mon, 09 Mar 2026 07:48:33 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:32 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 05/35] target/hexagon: Handle system/guest registers in
 gen_analyze_funcs.py and hex_common.py
Date: Mon,  9 Mar 2026 07:47:52 -0700
Message-Id: <20260309144822.877695-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfX7Z4eolJvNbna
 Bn4wHcfMSHDn8rKAbuQuBbiTSBaMq5bNQqAqrFjMpZMpRRVZ9iKqV3D63Jb4uZFdRbsI7K6okhe
 c+2dBqgfNsAmsoE1oWBRRmGgTU7XGlKyNL2Kmj79sikqF9c2uxJtVwtfE76cbcW1TkXZeYi/SND
 BE0NzjNQvYw4xrjFARhpaA1wpycmY7NzRGaR/xu55s+GglpXiPpwq+EuIj3Do0B535pzDJ2EAY5
 6HpkmTSi2ZV271DKThcsV1xvszCkqeigjFCj0oIe9A1wumJO8AqeqRkuR5ZceewMFnn78XzqAOE
 rOgqoE4G7QTwlQtWUvqyaNqyNmt3XfcoYVLUZdvD5m0glcnMiYYe8DRenfoeDc0JbI7S9khanYI
 TyuXT8Xwc3YgwA2OBVQUiuPfgV/ZPNyOG21OF/Cs+sSYW6m8K8Oszwx98DGMv5D2itNaYBKCdCj
 bgvi3qgDH9oLXW9eECA==
X-Proofpoint-GUID: b3nZtruKo_wjd9HbCrgLO7xsn6cFy8aA
X-Proofpoint-ORIG-GUID: b3nZtruKo_wjd9HbCrgLO7xsn6cFy8aA
X-Authority-Analysis: v=2.4 cv=KNRXzVFo c=1 sm=1 tr=0 ts=69aeddc2 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=-IRm0M9p1sl727KxlF4A:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090133
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

From: Brian Cain <bcain@quicinc.com>

Add register classes for guest (G) and system (S) registers to
hex_common.py, and update gen_analyze_funcs.py to handle them.

Guest and system registers can only appear once per packet (one
transfer instruction each), so there is no read-after-write hazard
to detect during the analyze phase.  Source classes (GuestSource,
GuestPairSource, SystemSource, SystemPairSource) provide a no-op
analyze_read() since these register reads do not need tracking.

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/gen_analyze_funcs.py |  14 ++-
 target/hexagon/hex_common.py        | 152 ++++++++++++++++++++++++++++
 2 files changed, 164 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/gen_analyze_funcs.py b/target/hexagon/gen_analyze_funcs.py
index fdefd5b4b36..44bb22ed927 100755
--- a/target/hexagon/gen_analyze_funcs.py
+++ b/target/hexagon/gen_analyze_funcs.py
@@ -22,7 +22,6 @@
 import string
 import hex_common
 
-
 ##
 ## Generate the code to analyze the instruction
 ##     For A2_add: Rd32=add(Rs32,Rt32), { RdV=RsV+RtV;}
@@ -42,6 +41,13 @@ def gen_analyze_func(f, tag, regs, imms):
     f.write(f"static void analyze_{tag}(DisasContext *ctx)\n")
     f.write("{\n")
 
+    if hex_common.tag_ignore(tag):
+        f.write("}\n\n")
+        return
+
+    if hex_common.is_sysemu_tag(tag):
+        f.write("#ifndef CONFIG_USER_ONLY\n")
+
     f.write("    Insn *insn G_GNUC_UNUSED = ctx->insn;\n")
     if (hex_common.is_hvx_insn(tag)):
         if hex_common.has_hvx_helper(tag):
@@ -58,7 +64,8 @@ def gen_analyze_func(f, tag, regs, imms):
     for regno, register in enumerate(regs):
         reg_type, reg_id = register
         reg = hex_common.get_register(tag, reg_type, reg_id)
-        reg.decl_reg_num(f, regno)
+        if reg.is_read() or reg.is_written():
+            reg.decl_reg_num(f, regno)
 
     ## Analyze the register reads
     for regno, register in enumerate(regs):
@@ -78,6 +85,9 @@ def gen_analyze_func(f, tag, regs, imms):
 
     f.write("    mark_implicit_writes(ctx);\n")
 
+    if hex_common.is_sysemu_tag(tag):
+        f.write("#endif /* !CONFIG_USER_ONLY */\n")
+
     f.write("}\n\n")
 
 
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 002afcdb9e3..1e2c2e46506 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -33,6 +33,41 @@
 overrides = {}  # tags with helper overrides
 idef_parser_enabled = {}  # tags enabled for idef-parser
 
+
+def is_sysemu_tag(tag):
+    return bool(attribdict[tag] & {"A_PRIV", "A_GUEST"})
+
+
+def tag_ignore(tag):
+    tag_skips = (
+        "Y6_diag",
+        "Y6_diag0",
+        "Y6_diag1",
+    )
+    attr_skips = {
+        "A_FAKEINSN",
+        "A_MAPPING",
+        "A_CONDMAPPING",
+    }
+    return tag in tag_skips or attribdict[tag] & attr_skips
+
+
+def get_sys_tags():
+    return sorted(
+        tag for tag in frozenset(tags) if is_sysemu_tag(tag)
+    )
+
+
+def get_user_tags():
+    return sorted(
+        tag for tag in frozenset(tags) if not is_sysemu_tag(tag)
+    )
+
+
+def get_all_tags():
+    return get_user_tags() + get_sys_tags()
+
+
 # We should do this as a hash for performance,
 # but to keep order let's keep it as a list.
 def uniquify(seq):
@@ -369,12 +404,16 @@ def helper_proto_type(self):
         return "s32"
     def helper_arg_type(self):
         return "int32_t"
+    def is_pair(self):
+        return False
 
 class Pair(Scalar):
     def helper_proto_type(self):
         return "s64"
     def helper_arg_type(self):
         return "int64_t"
+    def is_pair(self):
+        return True
 
 class Hvx:
     def is_scalar_reg(self):
@@ -1010,6 +1049,109 @@ def analyze_write(self, f, tag, regno):
             ctx_log_qreg_write(ctx, {self.reg_num}, insn_has_hvx_helper);
         """))
 
+class GuestRegister(Register):
+    pass
+
+class GuestDest(GuestRegister, Single, Dest):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            TCGv {self.reg_tcg()} = tcg_temp_new();
+        """))
+    def gen_write(self, f, tag):
+        f.write(code_fmt(f"""\
+            gen_log_greg_write(ctx, {self.reg_num}, {self.reg_tcg()});
+        """))
+    def analyze_write(self, f, tag, regno):
+        f.write(code_fmt(f"""\
+            ctx_log_greg_write(ctx, {self.reg_num});
+        """))
+
+class GuestSource(GuestRegister, Single, OldSource):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            TCGv {self.reg_tcg()} = tcg_temp_new();
+            gen_read_greg({self.reg_tcg()}, {self.reg_num});
+        """))
+    def analyze_read(self, f, regno):
+        pass
+
+class GuestPairDest(GuestRegister, Pair, Dest):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            TCGv_i64 {self.reg_tcg()} = tcg_temp_new_i64();
+        """))
+    def gen_write(self, f, tag):
+        f.write(code_fmt(f"""\
+            gen_log_greg_write_pair(ctx, {self.reg_num}, {self.reg_tcg()});
+        """))
+    def analyze_write(self, f, tag, regno):
+        f.write(code_fmt(f"""\
+            ctx_log_greg_write_pair(ctx, {self.reg_num});
+        """))
+
+class GuestPairSource(GuestRegister, Pair, OldSource):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            TCGv_i64 {self.reg_tcg()} = tcg_temp_new_i64();
+            gen_read_greg_pair({self.reg_tcg()}, {self.reg_num});
+        """))
+    def analyze_read(self, f, regno):
+        pass
+
+class SystemDest(Register, Single, Dest):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            TCGv {self.reg_tcg()} = tcg_temp_new();
+        """))
+    def gen_write(self, f, tag):
+        f.write(code_fmt(f"""\
+            gen_log_sreg_write(ctx, {self.reg_num}, {self.reg_tcg()});
+        """))
+    def analyze_write(self, f, tag, regno):
+        f.write(code_fmt(f"""\
+            ctx_log_sreg_write(ctx, {self.reg_num});
+        """))
+
+class SystemSource(Register, Single, OldSource):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            TCGv {self.reg_tcg()} = tcg_temp_new();
+            gen_read_sreg({self.reg_tcg()}, {self.reg_num});
+        """))
+    def analyze_read(self, f, regno):
+        pass
+
+class SystemPairDest(Register, Pair, Dest):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            TCGv_i64 {self.reg_tcg()} = tcg_temp_new_i64();
+        """))
+    def gen_write(self, f, tag):
+        f.write(code_fmt(f"""\
+            gen_log_sreg_write_pair(ctx, {self.reg_num}, {self.reg_tcg()});
+        """))
+    def analyze_write(self, f, tag, regno):
+        f.write(code_fmt(f"""\
+            ctx_log_sreg_write_pair(ctx, {self.reg_num});
+        """))
+
+class SystemPairSource(Register, Pair, OldSource):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            TCGv_i64 {self.reg_tcg()} = tcg_temp_new_i64();
+            gen_read_sreg_pair({self.reg_tcg()}, {self.reg_num});
+        """))
+    def analyze_read(self, f, regno):
+        pass
+
 def init_registers():
     regs = {
         GprDest("R", "d"),
@@ -1056,6 +1198,16 @@ def init_registers():
         QRegSource("Q", "u"),
         QRegSource("Q", "v"),
         QRegReadWrite("Q", "x"),
+
+        # system regs
+        GuestDest("G", "d"),
+        GuestSource("G", "s"),
+        GuestPairDest("G", "dd"),
+        GuestPairSource("G", "ss"),
+        SystemDest("S", "d"),
+        SystemSource("S", "s"),
+        SystemPairDest("S", "dd"),
+        SystemPairSource("S", "ss"),
     }
     for reg in regs:
         registers[f"{reg.regtype}{reg.regid}"] = reg
-- 
2.34.1


