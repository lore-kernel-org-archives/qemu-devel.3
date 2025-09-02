Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63BECA100B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utHzp-0006ol-GZ; Mon, 01 Sep 2025 23:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzf-0006gM-To
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzc-0004R1-3w
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:39 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RuNw012447
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vSyen/JSsVX7mBtepLJb9QV1vbjNr1COrLIU23/g9uk=; b=RAxty3zhdNIlqaHQ
 3ICRdFBKxDk0IIy6rcxewW9b6aOgeEsOuURLLS86nqpva28FKTyz030kGkqj8nXi
 pXHvJFt+cwJrZ2V0rMZHB1oEjF4N0XVV2cuQN01K2gATeQxK1pZUHUccYiTx0DYG
 2Ag09Y/IDdJscGOlOhezgb5izGYpVAibL3kZWGDsWiZiEM/yiUZYJiYaOCSW7YWk
 RP6GhDHQJdubijuhwRaBs8CeMcPgZ0m+Ru5U1V3I2EvYOy8pT8orC5mWdZNqF+Ak
 inLVfYwsMeX2Ucqb0EB5yaPzhl1sgBp8qaju1FTRTJqHNZHknaB9s4YEVMzWfV90
 tXjkHg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fea08-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:32 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b471737e673so7176597a12.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784851; x=1757389651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vSyen/JSsVX7mBtepLJb9QV1vbjNr1COrLIU23/g9uk=;
 b=oilOv/QRPI5Z0Es3/7MtwCwjsoUjzymWlqwyZV+02woYekwZPqszngT/Cr8UVUVBOe
 qysw0D8yBcfYPPmFI9YcdEjmZHu8Ois2kXNZ21Xa0Ed8dkhg0PsyjkcDggVA37rDIblo
 fWpiVw1u3fzyf49INy5Hmlw+DwPckYPHUgF6HGO1blZU24lnXff7OKgNdPVZ843zRXZP
 TV7yQU2gyrx1htT87m0+ccdxX5YFqYUs9YlaVnL6Xbuysh3t4+zWfVHmxVax9vSTJ21u
 ibN02dhZ7Qy8BcJjifAkdHVqSVINEteqkKb7FzpkHNAaTsPkcCHY9mPJLA0wGcmZuhfC
 boeA==
X-Gm-Message-State: AOJu0YzKvvxav8sicsuxX4TqROz98erlafzouLN1W1MSjC+Qys92CRTs
 H+SPKvyUXibdurNtrPb8CPmu5uUd5WNo7X7vGqwiYhkIn083gVAipGjcQ+t2xMBdNNKnvpqsWre
 B58VIh08ToBF11dO3QYUrInoCQVmerAn/O4wm+oxxHax4ZWiloC9Kf0lsW6e1fbpdxblw
X-Gm-Gg: ASbGncsA7D96KsCfVDevF1L5OLfcv7DSPSY9SODE21qYij9F22AWjD6WuNkj6AjCdX7
 YNsH3JyMU7oOp7DCs8ODdfhCOnJQCnfaLfLrJxb+kZ+gk4LPWrD1fmg0f5Qma09M61dh36NcWMe
 81I4+O6o4N7ANpcIB6Z8HBkJUlO/1d5ZdBoDXXs6bs7vKB+PWZS4WRfFCnDuny54iFOoYfuMdTR
 ThAaU1pLtM4vUlv9wSOip3GpOO5kdqhfDF15Mv5bNR1pP50rMNonOZZxZmPd6eHq8EDecsUla2o
 6I7QjqZu3ys/P6tNpEq87tGQAjrlis3EA8Hbcn/wbL3B8XZf+YInNABx1TwBRBWaUtyYGNeeOfW
 cKGSFsVV9on/4
X-Received: by 2002:a05:6a20:7fa8:b0:240:104c:8e14 with SMTP id
 adf61e73a8af0-243d6f037acmr13582006637.38.1756784851381; 
 Mon, 01 Sep 2025 20:47:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhumOHNiaerPqghSnonzYVuqBjlry7QwPmDAgQGWTs8VQdymPW3wqM/zwEMl4iPdO/MdFacA==
X-Received: by 2002:a05:6a20:7fa8:b0:240:104c:8e14 with SMTP id
 adf61e73a8af0-243d6f037acmr13581970637.38.1756784850881; 
 Mon, 01 Sep 2025 20:47:30 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:30 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 07/40] target/hexagon: Switch to tag_ignore(),
 generate via get_{user, sys}_tags()
Date: Mon,  1 Sep 2025 20:46:42 -0700
Message-Id: <20250902034715.1947718-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX9RooRd/MXUBk
 E2ZtJr1fGvd8Q7se+K2NQUv76C5eawip+qZWFMnfr+gWMsMGUcaiXMetlQp7OZQpsbDUd+MMWq7
 hzY/6zCRg4sab5psVJL7uHq2TPUrwszG0VcmYjv7Wy78getBT4CTy+tyzdl1CutvBpImBuZnhaR
 SX3nE/xsw3XbjDI+rZlLKxaPRBFg+ppsk7BWdbaTztO7F2JZsVsSPV2JJjDN2WR46tjylkxuXnS
 9gyRvz0oR6Nk3ksatzPjCmgSnPN19vZ4qPKHW0QtAhnJMhT7wP9ocgvamgny4/ZQrCPq9sxRdO7
 0GhYjnawgo9yxA+5a1ulSJkJCMK0yBcZOO++B+WSXlPxewNqJm1jqTG1VpZFbm3kP7r/Yrnv0N3
 huwVO91U
X-Proofpoint-ORIG-GUID: 9hxlLN6BDoodxhSP_jxQfHU8L4HvOJwx
X-Proofpoint-GUID: 9hxlLN6BDoodxhSP_jxQfHU8L4HvOJwx
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b668d4 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=w5GA-SIdXBg7ke_1h4wA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038
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
Reply-to:  Brian Cain <brian.cain@oss.qualcomm.com>
From:  Brian Cain via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Brian Cain <bcain@quicinc.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/gen_helper_funcs.py      | 23 ++++++++++-------------
 target/hexagon/gen_helper_protos.py     | 23 ++++++++++++-----------
 target/hexagon/gen_idef_parser_funcs.py |  2 ++
 target/hexagon/gen_op_attribs.py        |  2 +-
 target/hexagon/gen_opcodes_def.py       |  5 ++++-
 target/hexagon/gen_tcg_func_table.py    | 14 ++------------
 6 files changed, 31 insertions(+), 38 deletions(-)

diff --git a/target/hexagon/gen_helper_funcs.py b/target/hexagon/gen_helper_funcs.py
index c1f806ac4b..dd8ab60598 100755
--- a/target/hexagon/gen_helper_funcs.py
+++ b/target/hexagon/gen_helper_funcs.py
@@ -109,26 +109,23 @@ def main():
     tagimms = hex_common.get_tagimms()
 
     with open(args.out, "w") as f:
-        for tag in hex_common.tags:
-            ## Skip the priv instructions
-            if "A_PRIV" in hex_common.attribdict[tag]:
-                continue
-            ## Skip the guest instructions
-            if "A_GUEST" in hex_common.attribdict[tag]:
-                continue
-            ## Skip the diag instructions
-            if tag == "Y6_diag":
-                continue
-            if tag == "Y6_diag0":
-                continue
-            if tag == "Y6_diag1":
+        for tag in hex_common.get_user_tags():
+            if hex_common.tag_ignore(tag):
                 continue
             if hex_common.skip_qemu_helper(tag):
                 continue
             if hex_common.is_idef_parser_enabled(tag):
                 continue
+            gen_helper_function(f, tag, tagregs, tagimms)
 
+        f.write("#if !defined(CONFIG_USER_ONLY)\n")
+        for tag in hex_common.get_sys_tags():
+            if hex_common.skip_qemu_helper(tag):
+                continue
+            if hex_common.is_idef_parser_enabled(tag):
+                continue
             gen_helper_function(f, tag, tagregs, tagimms)
+        f.write("#endif\n")
 
 
 if __name__ == "__main__":
diff --git a/target/hexagon/gen_helper_protos.py b/target/hexagon/gen_helper_protos.py
index 77f8e0a6a3..59c8bdd05c 100755
--- a/target/hexagon/gen_helper_protos.py
+++ b/target/hexagon/gen_helper_protos.py
@@ -59,27 +59,28 @@ def main():
     tagimms = hex_common.get_tagimms()
 
     with open(args.out, "w") as f:
-        for tag in hex_common.tags:
-            ## Skip the priv instructions
-            if "A_PRIV" in hex_common.attribdict[tag]:
+        for tag in hex_common.get_user_tags():
+            if hex_common.tag_ignore(tag):
                 continue
-            ## Skip the guest instructions
-            if "A_GUEST" in hex_common.attribdict[tag]:
-                continue
-            ## Skip the diag instructions
-            if tag == "Y6_diag":
-                continue
-            if tag == "Y6_diag0":
+
+            if hex_common.skip_qemu_helper(tag):
                 continue
-            if tag == "Y6_diag1":
+            if hex_common.is_idef_parser_enabled(tag):
                 continue
 
+            gen_helper_prototype(f, tag, tagregs, tagimms)
+
+        f.write("#if !defined(CONFIG_USER_ONLY)\n")
+        for tag in hex_common.get_sys_tags():
+            if hex_common.tag_ignore(tag):
+                continue
             if hex_common.skip_qemu_helper(tag):
                 continue
             if hex_common.is_idef_parser_enabled(tag):
                 continue
 
             gen_helper_prototype(f, tag, tagregs, tagimms)
+        f.write("#endif\n")
 
 
 if __name__ == "__main__":
diff --git a/target/hexagon/gen_idef_parser_funcs.py b/target/hexagon/gen_idef_parser_funcs.py
index 2f6e826f76..32bce9b002 100644
--- a/target/hexagon/gen_idef_parser_funcs.py
+++ b/target/hexagon/gen_idef_parser_funcs.py
@@ -60,6 +60,8 @@ def main():
         f.write('#include "macros.h.inc"\n\n')
 
         for tag in hex_common.tags:
+            if hex_common.tag_ignore(tag):
+                continue
             ## Skip the priv instructions
             if "A_PRIV" in hex_common.attribdict[tag]:
                 continue
diff --git a/target/hexagon/gen_op_attribs.py b/target/hexagon/gen_op_attribs.py
index bbbb02df3a..94dd1f876b 100755
--- a/target/hexagon/gen_op_attribs.py
+++ b/target/hexagon/gen_op_attribs.py
@@ -38,7 +38,7 @@ def main():
     ##     Generate all the attributes associated with each instruction
     ##
     with open(args.out, "w") as f:
-        for tag in hex_common.tags:
+        for tag in hex_common.get_all_tags():
             f.write(
                 f"OP_ATTRIB({tag},ATTRIBS("
                 f'{",".join(sorted(hex_common.attribdict[tag]))}))\n'
diff --git a/target/hexagon/gen_opcodes_def.py b/target/hexagon/gen_opcodes_def.py
index 94a19ff412..17ba3f9db9 100755
--- a/target/hexagon/gen_opcodes_def.py
+++ b/target/hexagon/gen_opcodes_def.py
@@ -37,7 +37,10 @@ def main():
     ##     Generate a list of all the opcodes
     ##
     with open(args.out, "w") as f:
-        for tag in hex_common.tags:
+        for tag in hex_common.get_user_tags():
+            f.write(f"OPCODE({tag}),\n")
+
+        for tag in hex_common.get_sys_tags():
             f.write(f"OPCODE({tag}),\n")
 
 
diff --git a/target/hexagon/gen_tcg_func_table.py b/target/hexagon/gen_tcg_func_table.py
index 299a39b1aa..70c8db5c44 100755
--- a/target/hexagon/gen_tcg_func_table.py
+++ b/target/hexagon/gen_tcg_func_table.py
@@ -41,19 +41,9 @@ def main():
         f.write("#define HEXAGON_FUNC_TABLE_H\n\n")
 
         f.write("const SemanticInsn opcode_genptr[XX_LAST_OPCODE] = {\n")
+
         for tag in hex_common.tags:
-            ## Skip the priv instructions
-            if "A_PRIV" in hex_common.attribdict[tag]:
-                continue
-            ## Skip the guest instructions
-            if "A_GUEST" in hex_common.attribdict[tag]:
-                continue
-            ## Skip the diag instructions
-            if tag == "Y6_diag":
-                continue
-            if tag == "Y6_diag0":
-                continue
-            if tag == "Y6_diag1":
+            if hex_common.tag_ignore(tag):
                 continue
 
             f.write(f"    [{tag}] = generate_{tag},\n")
-- 
2.34.1


