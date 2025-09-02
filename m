Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415C9CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utHzk-0006k8-SG; Mon, 01 Sep 2025 23:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzg-0006gT-7X
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHza-0004Qg-Vl
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:39 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Rp71012533
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4vYVB7ttqBKkKr0vKMuYGgNvfoJG7B2BtbwdwK5xIrQ=; b=aunCvHY3mUWSaxrI
 SjNSueTZ4+yg1iPwXP3GKLB/mrSN9iztxwkA8ZH2XJodoUwIUZ1j5W/SpkcDHelo
 mghdp8SjmeIT1+lKOhuxSoFE13XASuhclNoZuts7uk7UFtAIMVEQ2impk2MeG4xb
 vlnVAicKbW0hBZ3dVP3lBZsg7kAN18GlCFP8cOoMGkPw+IiVBOJizsEfErtermtR
 /14ps60UI6u1UBnO+REq05FO6pTV7bEABWRqsfz42nub0QgLK1G/9B7amihF3mai
 f+kyi95InRYVnzbr0okLHUpobOPV9DxVhtUwzssmmZTMXEkafR17xwACTHW4gBa9
 qQO0Cw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0eej4n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:30 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b4f8e079bc1so748071a12.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784849; x=1757389649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4vYVB7ttqBKkKr0vKMuYGgNvfoJG7B2BtbwdwK5xIrQ=;
 b=Y2EhLphqVka/sVYG9Dg2poBFZ8mR5cNOzO+99jPvz9zRv1RFkHOIB0YvLSusa1TZIs
 k2S0En3T1u1FFwLhpdeNKGgAckgRf41Mytjcb1xxrj0PdvVNAHI1PcljbrvzpmKSk0yT
 VCMzvDXszqbD/Nwca/UOLzuHSDa7OG9BUoqKzAy2F2HjsUx6vkJW5tzxTljS83xch0Mh
 sXj6r0VfFvYAZKnnzGnGSehJ7rI9vMxrnuAih55D5LpjiBqiQlxH5XxzUyE0DnLtn64q
 S/dakRzTGr7gVlUYW8vBJfUy6FgzNk/3h1h+rnxLUiqN7ldIZBwTvKOaafHxbI6XQ06C
 L72A==
X-Gm-Message-State: AOJu0YxJKL9/3DI/GV8i2/GHJX9lr1rP0WtmvBGv1/7W6on835fpZ5+W
 HB+gUB+0lEjbiQg+piYHqixrdPNpTRotoJHRoeGr9azfhDqOwoqd2P6fRieqBr780Zjmhe3dIlW
 nC5I5qNOxr0dDX/niG5qttXX1Yh4NqYSuvNGSqexbLep2eCkd4idvU0+9nCnCf6AAiLko
X-Gm-Gg: ASbGnct+Kq8QlxFWK8Pu8HCEBlfM5HRsSdOPN7z1+Ty4AXAqadHyLTchGOEABdXuIWJ
 Dt+wTYqtJOPxxjdZZbXSKJ+K7E6fMnDdbHoTvXT1P5bnO0o5WbFQUrztAqhC7MraSlJnPekd5QW
 JfwaB7mI/fXMGyf9sRdckmzobBO6lJxoxixytakEWP3WXqCK6H3kR6UN6bOsNl/LJstAdWocv3T
 aIzYlLc9/raa48io9IRgAPtNAU/+e+zSQpFRXdJh3TiUVkTddZuA4Z+9Ug1lDOAP+ePGXJ1XFuq
 vyRdfmgyyJ4eBtg4/ALZNxVIB9jM9QF55ArOA/nmokkMsSpAMAtdGzU2PsprA6iFa4eI+apAksL
 8L5nVM1B6/f6T
X-Received: by 2002:a05:6a20:bb0f:b0:243:f723:fe48 with SMTP id
 adf61e73a8af0-243f72400aemr3739074637.34.1756784848930; 
 Mon, 01 Sep 2025 20:47:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3/1S0uimOjoMPYze4KuL9CsisifGYiQhBWvxt2veEjU91xEKxVzXw4MFNJ3rCUkaP52cjtQ==
X-Received: by 2002:a05:6a20:bb0f:b0:243:f723:fe48 with SMTP id
 adf61e73a8af0-243f72400aemr3739050637.34.1756784848320; 
 Mon, 01 Sep 2025 20:47:28 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:27 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 05/40] target/hexagon: Handle system/guest registers in
 gen_analyze_funcs.py and hex_common.py
Date: Mon,  1 Sep 2025 20:46:40 -0700
Message-Id: <20250902034715.1947718-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: YBivJXSj9NC93bgndSEwAsvjObvn2J34
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX+IgJzdkiapki
 ppw3M1GgvEv75gEf7JWMBYjSCOwc0WPkX87eXsi9aaWUKIkcMY918sL+HqNBJZCLA2/HMW0PEZD
 RGczHrTbrR376y7WhapTu04CS/J2DZBoJgqRdcRLLNZzqJif2D25/sX0M1F5PD2OaDdbwE7UKNt
 IgC5HwOYvtvVGjip5Bkz8rSsT1JHk0f/Iz4o8HTeiXFWBQ1Ey1NCMOZMjXLc03DFx8QE1vOyJ+J
 wMwgu9GKXkuSthyD5khiCPJ1Z/mpJ/PQ6wNoW+Hs/miGgY7x9ZTyAhahkjc0hJqERYjq8qIFvJA
 CfoQlfzxWEpB4ltV+0DJUzSQEREUOLNGVLsvLgv39WBup/rwcQKfqeN95xruWEu+buxskhunniQ
 Fm7FFNiR
X-Proofpoint-ORIG-GUID: YBivJXSj9NC93bgndSEwAsvjObvn2J34
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b668d2 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=-IRm0M9p1sl727KxlF4A:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
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
 target/hexagon/gen_analyze_funcs.py |  21 +++-
 target/hexagon/hex_common.py        | 161 ++++++++++++++++++++++++++++
 2 files changed, 179 insertions(+), 3 deletions(-)

diff --git a/target/hexagon/gen_analyze_funcs.py b/target/hexagon/gen_analyze_funcs.py
index 3ac7cc2cfe..dfdf5f3b87 100755
--- a/target/hexagon/gen_analyze_funcs.py
+++ b/target/hexagon/gen_analyze_funcs.py
@@ -22,6 +22,8 @@
 import string
 import hex_common
 
+def has_analyze_func(reg, mode):
+    return callable(getattr(reg, f"analyze_{mode}", None))
 
 ##
 ## Generate the code to analyze the instruction
@@ -42,6 +44,14 @@ def gen_analyze_func(f, tag, regs, imms):
     f.write(f"static void analyze_{tag}(DisasContext *ctx)\n")
     f.write("{\n")
 
+    if hex_common.tag_ignore(tag):
+        f.write("}\n\n")
+        return
+
+    if ("A_PRIV" in hex_common.attribdict[tag] or
+        "A_GUEST" in hex_common.attribdict[tag]):
+        f.write("#ifndef CONFIG_USER_ONLY\n")
+
     f.write("    Insn *insn G_GNUC_UNUSED = ctx->insn;\n")
     if (hex_common.is_hvx_insn(tag)):
         if hex_common.has_hvx_helper(tag):
@@ -58,22 +68,27 @@ def gen_analyze_func(f, tag, regs, imms):
     for regno, register in enumerate(regs):
         reg_type, reg_id = register
         reg = hex_common.get_register(tag, reg_type, reg_id)
-        reg.decl_reg_num(f, regno)
+        if has_analyze_func(reg, "read") or has_analyze_func(reg, "write"):
+            reg.decl_reg_num(f, regno)
 
     ## Analyze the register reads
     for regno, register in enumerate(regs):
         reg_type, reg_id = register
         reg = hex_common.get_register(tag, reg_type, reg_id)
-        if reg.is_read():
+        if reg.is_read() and has_analyze_func(reg, "read"):
             reg.analyze_read(f, regno)
 
     ## Analyze the register writes
     for regno, register in enumerate(regs):
         reg_type, reg_id = register
         reg = hex_common.get_register(tag, reg_type, reg_id)
-        if reg.is_written():
+        if reg.is_written() and has_analyze_func(reg, "write"):
             reg.analyze_write(f, tag, regno)
 
+    if ("A_PRIV" in hex_common.attribdict[tag] or
+        "A_GUEST" in hex_common.attribdict[tag]):
+        f.write("#endif /* !CONFIG_USER_ONLY */\n")
+
     f.write("}\n\n")
 
 
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index e60e8efabc..fa122b6d76 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -33,6 +33,42 @@
 overrides = {}  # tags with helper overrides
 idef_parser_enabled = {}  # tags enabled for idef-parser
 
+
+def is_sysemu_tag(tag):
+    return "A_PRIV" in attribdict[tag] or "A_GUEST" in attribdict[tag]
+
+
+def tag_ignore(tag):
+    tag_skips = (
+        "Y6_diag",
+        "Y6_diag0",
+        "Y6_diag1",
+    )
+    attr_skips = (
+        "A_FAKEINSN",
+        "A_MAPPING",
+        "A_CONDMAPPING",
+    )
+    return tag in tag_skips or \
+        any(attr in attribdict[tag] for attr in attr_skips)
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
@@ -370,12 +406,16 @@ def helper_proto_type(self):
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
@@ -1013,6 +1053,117 @@ def analyze_write(self, f, tag, regno):
             ctx_log_qreg_write(ctx, {self.reg_num}, insn_has_hvx_helper);
         """))
 
+class GuestRegister(Register):
+    def gen_check_impl(self, f, regno):
+        if self.is_written():
+            f.write(code_fmt(f"""\
+                if (!greg_writable(insn->regno[{regno}],
+                    {str(self.is_pair()).lower()})) {{
+                    return;
+                }}
+            """))
+        else:
+            f.write(code_fmt(f"""\
+                check_greg_impl(insn->regno[{regno}],
+                                {str(self.is_pair()).lower()});
+            """))
+
+class GuestDest(GuestRegister, Single, Dest):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        self.gen_check_impl(f, regno)
+        f.write(code_fmt(f"""\
+            TCGv {self.reg_tcg()} = tcg_temp_new();
+        """))
+    def log_write(self, f, tag):
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
+        self.decl_reg_num(f, regno);
+        self.gen_check_impl(f, regno)
+        f.write(code_fmt(f"""\
+            TCGv {self.reg_tcg()} = tcg_temp_new();
+            gen_read_greg({self.reg_tcg()}, {self.reg_num});
+        """))
+
+class GuestPairDest(GuestRegister, Pair, Dest):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        self.gen_check_impl(f, regno)
+        f.write(code_fmt(f"""\
+            TCGv_i64 {self.reg_tcg()} = tcg_temp_new_i64();
+        """))
+    def log_write(self, f, tag):
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
+        self.gen_check_impl(f, regno)
+        f.write(code_fmt(f"""\
+            TCGv_i64 {self.reg_tcg()} = tcg_temp_new_i64();
+            gen_read_greg_pair({self.reg_tcg()}, {self.reg_num});
+        """))
+
+class SystemDest(Register, Single, Dest):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            TCGv {self.reg_tcg()} = tcg_temp_new();
+        """))
+    def log_write(self, f, tag):
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
+        self.decl_reg_num(f, regno);
+        f.write(code_fmt(f"""\
+            TCGv {self.reg_tcg()} = tcg_temp_new();
+            gen_read_sreg({self.reg_tcg()}, {self.reg_num});
+        """))
+
+class SystemPairDest(Register, Pair, Dest):
+    def decl_tcg(self, f, tag, regno):
+        self.decl_reg_num(f, regno)
+        f.write(code_fmt(f"""\
+            TCGv_i64 {self.reg_tcg()} = tcg_temp_new_i64();
+        """))
+    def log_write(self, f, tag):
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
+
 def init_registers():
     regs = {
         GprDest("R", "d"),
@@ -1059,6 +1210,16 @@ def init_registers():
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


