Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D2BF417F1
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbun-0000wP-T9; Mon, 09 Mar 2026 10:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuU-0000qb-I4
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuR-0005EH-Qi
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:42 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629EXmIf830355
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UpqvNEgrDXSReMAt/ZkuRiatJrVkNDM/d28/q34WiRY=; b=gD5WQyv8HQ2f8v+4
 RKJognkpr4FctEWuCRYsnYdPo7ftOat+2hKVnmNH0921O8ppugg5GGIc5DjHKzFG
 wgGtJRmK2VPcjODzgljecUJUYQPWoOGU/QxM39BNvDhhPchsHXL4w+S5M4yibcM5
 NJlwtDuVZvCxkpHxxpRckRAgWqns23pm4x0nNKZpQs5dyp2k2lXIjA2nzx7+WXpU
 kHdUeUgg3d6JI9+wvy5xhAiBo9tAstcdKwCJKHrXe2qGhPnZ+wat2Ni794r9TbxP
 TuwQIO5CBH2TCbngSrhkUXzmucqAyvuy5abaqROu42K9w5QyWqj7y0XoewMnyWZ2
 uekAGg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ct03282an-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:37 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bdd327d970so5942002eec.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067717; x=1773672517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UpqvNEgrDXSReMAt/ZkuRiatJrVkNDM/d28/q34WiRY=;
 b=BLERE0XE6tAqKueIHDRi74JMic0+raeAc+iTk2RWCcKhh3OAb5FkHfCJutguAYauhs
 IamHYMH+wdpXX8YzGVd7MFTfVeGnYvWSONQ/UsnopU0QtPX6xPQZID6Oy/70O0j8uCcP
 FtK7WXxvmyGhSIkAupiLq9tQHxsDLBLS9ZJWXokMtj2rcJ01YUxB6a8+GWRsNzcAI+UQ
 LLvvZUtTnGPWA9MegFCacFWS/lWT7I1ruHeeewDD/QEJcOHvW4O49J2piOyBCVIzKoRo
 KcQQlSQvXe6XZRQMqPPg0/cfX4JrmPcbB89FPb8G2zEP5NdItZNvTIh1MJKxbFQOG0JZ
 Ow6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067717; x=1773672517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UpqvNEgrDXSReMAt/ZkuRiatJrVkNDM/d28/q34WiRY=;
 b=EPSP1X/uEOgdvapK/twkkp43boPd/PKsDJmhqI3taam3zfpr1GfFfJm/ADQ0X4evGj
 9Lm4+HQxI/OOmlK4z1h6YwsFqMTbbrHjt0TbUznjkL+Jj4puWdEuF+4GFEbVFpI9WHis
 r9cn8ES7dyaJQm0cfHfs6EfmzxkR6dUIv7xdcjqVPUSGOosNuetgm5s+BiQlEuL+MVMR
 9v6or1LIQcxR6YWLqSsWwMcWnu3ho0+yiv4TAY9iLksKRNVpqJ47+XgFrsZxr6XSGnt9
 Pp/VZ1C7aa2VLUazZKUq3umSYt5sDL2hNbjKY9NW6tQx2xOyr5udueKsp9xTiBsQxZRc
 K0zQ==
X-Gm-Message-State: AOJu0Yy2SQ1AB/fCBS1QKpuUfzB0HYutO0jNbAsnbHkGr4jUzVd52EKY
 P3I+p+DHh7FdJLRae617IpoL3jbo+13sc9cOJfMQqnfYPWBvie6lU9PSy3kuGdncGi4uRDsaoSN
 EZgSKT9iqx8NVa++FRs4QLFxXCLnScQXYrLzCHerNrDb13FaFbw/yAiz0NZ5JcjIh5g==
X-Gm-Gg: ATEYQzyrsysSF21E3qPaY93vvgd2z1sB82PR0CftleBupq+ZIukS93Q2ZDdkN8Lf+YR
 yGEmywtIrGlRH7dEusgmd8Eq6qUc6jzfNQyFRYP6/RlX3BOrHBRdB8IchXcv2+Cd8GxlpLtMLsR
 gDkTczx/2tz3MS9eymoceQTMiv0S8qwznpJx6lyMdqY9aZbsWERSZ82fTZBzZNbKcKg6DztwkC1
 ya5sd82kV/MYSN9PgGRF6PNWZoHN18V/+Q6yk6X8SkiaxuyrnZWZshxV+9Tt/41dGlapJpKFBBf
 mULzOBdU+1tPwjuCYrUMGtKeewSMWgzgpGxOO8Gw86KJbghAzUB0b18o6NU6dS1w4wNqcLCTt9x
 HiVIHeROFMFKwS6a8gho9FJdSMyBkH8Q7RK3WMAH+AmgMDqdEXImtzPJ/tVV8fDWyOkVYDQ==
X-Received: by 2002:a05:7300:7fa1:b0:2bd:816b:734d with SMTP id
 5a478bee46e88-2be4e708bdcmr4352166eec.18.1773067716498; 
 Mon, 09 Mar 2026 07:48:36 -0700 (PDT)
X-Received: by 2002:a05:7300:7fa1:b0:2bd:816b:734d with SMTP id
 5a478bee46e88-2be4e708bdcmr4352151eec.18.1773067715944; 
 Mon, 09 Mar 2026 07:48:35 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:35 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 08/35] target/hexagon: Switch to tag_ignore(),
 generate via get_{user, sys}_tags()
Date: Mon,  9 Mar 2026 07:47:55 -0700
Message-Id: <20260309144822.877695-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfX3lxTmf/7x2KX
 cQLAjOXWrjF9e6moQUq7ZmHIgI5lSwQ/SrkNt2YCRghM8+C2N3bhh86P5f2Dof8AvZH1bqGK90Z
 FG21mfRXJ++7etKoIRAV1c6wHSyD8y9Pz8HDsDibXZbeEFBPIaWZxJW6+ZbS3g6cNYJotK2/aXd
 uwcZhEfkf5pIi5JbirytZUvztCv5vWUvvZ66Ro4KXw6l3ZLnOapicB8anGhagDSeczdIWbwUnz2
 Gwbis8CROVx3m4Xwc8Hw6l0okJ4hpo0SsbAt8bn5yFxmWqVZOnOOMN8LOd1ZgkL5Z8NSgP3Aw9N
 aWWQR1aYjdegrLACggdvKAoHDdwghgS2JjbscD74bKr8BnVhhZFcUKreXUjpr8PpPay1K0piA85
 z2WhpoUlUm2XqlRNqved2vm8oSskcgx/r/nVmWeRoYbm/S/kThRB8AC/Hg49oJggH8EgjdwHcXx
 SC//XvxnjhYUAW1al5Q==
X-Proofpoint-ORIG-GUID: lG_6WSPqLoJR5H1ylhvyJnWJ6CmayLZj
X-Proofpoint-GUID: lG_6WSPqLoJR5H1ylhvyJnWJ6CmayLZj
X-Authority-Analysis: v=2.4 cv=WtEm8Nfv c=1 sm=1 tr=0 ts=69aeddc5 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=orAq0Iv1PZLbcfkgE-4A:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090133
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
Reply-to:  Brian Cain <brian.cain@oss.qualcomm.com>
From:  Brian Cain via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Brian Cain <bcain@quicinc.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/gen_helper_funcs.py      | 26 ++++++++++---------------
 target/hexagon/gen_helper_protos.py     | 23 +++++++++++-----------
 target/hexagon/gen_idef_parser_funcs.py |  2 ++
 target/hexagon/gen_op_attribs.py        |  2 +-
 target/hexagon/gen_opcodes_def.py       |  5 ++++-
 5 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/target/hexagon/gen_helper_funcs.py b/target/hexagon/gen_helper_funcs.py
index 6206104424c..1629ebc0e1a 100755
--- a/target/hexagon/gen_helper_funcs.py
+++ b/target/hexagon/gen_helper_funcs.py
@@ -104,29 +104,23 @@ def main():
     tagimms = hex_common.get_tagimms()
 
     with open(args.out, "w") as f:
-        for tag in hex_common.tags:
-            ## Skip the priv instructions
-            if "A_PRIV" in hex_common.attribdict[tag]:
-                continue
-            ## Skip the guest instructions
-            if "A_GUEST" in hex_common.attribdict[tag]:
-                continue
-            ## Skip the floating point instructions
-            if "A_FPOP" in hex_common.attribdict[tag]:
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
index 77f8e0a6a32..59c8bdd05c0 100755
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
index 2f6e826f76d..32bce9b0028 100644
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
index bbbb02df3a2..94dd1f876b2 100755
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
index 94a19ff412e..17ba3f9db95 100755
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
 
 
-- 
2.34.1


