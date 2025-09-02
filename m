Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BAFCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utHzo-0006oC-Ky; Mon, 01 Sep 2025 23:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzg-0006gO-1F
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzc-0004RI-EI
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:39 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RmnZ012365
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j9oSIN6ZYdP72/shyqCodsje90cdMoo3gskGPOlFVGw=; b=cT6TZfOg4Ap68dQI
 wvDnRad0pVsXqsUiwVA4TwvkYIhKLjuhJQU7kEbiRyi72mWF8Ft1Dc4H+KOoi/lu
 V69g0a9bCJ5jVD8BIlUjGl+VfWtmJ4Xfvla4qlRrapMuVd4vhj6y5eywR/MkDzSM
 3HyvefCpVLM2BtqDf5db+pxGw/JHTEmujAhcViliH8fpQnF6foXdeX4QReXxzXH0
 2nFKujqQHRN85rPbwKrklFx5+qdRpHKNT5lnBo040mHbY9g9YnCKNwIIkm4OBixO
 hCo8odfP24t4Ph8zpUPBVNyWzscCim/rYJvGwopl71D+Vhjjwr1MJmxQIituP4Vy
 1JDYlA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fea0b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:34 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b471757d82fso3754431a12.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784854; x=1757389654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j9oSIN6ZYdP72/shyqCodsje90cdMoo3gskGPOlFVGw=;
 b=OfKZSU32yKlyJkdQf6LHFzGO7fDV83OaR0Eaz+DnMMG6F3dpsg75ex2pCbFwizPLIP
 72BDwyYSQtaviBC8mqKzXzYZZuLenMjjlAlG2xzN9Qui2NJISFhIU5+LxaT0n32PL+gf
 Nl6Sdm4ikQnv0AzxUP+QbrPuTjlOPYQmlBSemvv4KxokUrXvRx38wJTM8KdZaS1gW1Xf
 yRJvg6TabFqfxIbqIxIEzd/gGc+1iHVEupE5stveNgAPzgt5ULUC+m4kGYIaW9zckO56
 ObYr6xQ44Oxgxnn601/3usfJosvd6qBfb3dKvuW4n9dfEQ2k6T6te9RcmoddxsQur1Jw
 rLCw==
X-Gm-Message-State: AOJu0YzRxCJm2HGywSPP/5F9FMApna8Jbj+WWYWn5Vo6ND+Ep+aG+rVG
 HTO3AhgI7A7QuOckhahwvct15TgHf/YADTa/vX55LXWLWweTEjwezNe1NzBTVsg9V9Mho9DLcAk
 mLLIcIX3aX9S9c32O53p0pbsjPD2VK4eDTuZVxcf7ujiS2T7TbODJLZ3HJx+4i1AhoRCU
X-Gm-Gg: ASbGncuozIKay7veCsooL57Mju/p3XXbv6nKmGxy9sQVwMwTPgSvk8rjidg40tsjlpj
 59uivMc31XFAQ2wCqjX0GMdXotBsXW+4cFvYfcb1UNaJeP1Q50iL8cRC1qBb+DUmAYJ2BZZZNFg
 Lm4kDKSpcP43avt4yyLQZ2+Guy5n8ccPv33IgpqQzjbKW/ZZas/yt7pAyYZYDT+QnwKHeQSQAMK
 2Bw0SK1PbqM7i9m/nS8pXjvnidS2mP2mwTmeYlXIr6m0o33yPk45JBnTEl0tmR/ODZOqblwoYpk
 VsXXw5ja8B6TGwL9R1dwgx0bLQ6EQiuEX8CmeHrMJ/HD1kc4yL+cgdGZ3Koq/XA/OeQ5+emHzjk
 2wf9Zs1NXjJT2
X-Received: by 2002:a05:6a20:6a08:b0:243:ca56:a70f with SMTP id
 adf61e73a8af0-243d6dffa8amr13079775637.13.1756784853747; 
 Mon, 01 Sep 2025 20:47:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZ1hAokiBbe2tMeVpQEvAOGewq6wucMIJ8cm0KkGYPvmoKrNS9RW8wYcaDv08waV1++o1KuQ==
X-Received: by 2002:a05:6a20:6a08:b0:243:ca56:a70f with SMTP id
 adf61e73a8af0-243d6dffa8amr13079748637.13.1756784853302; 
 Mon, 01 Sep 2025 20:47:33 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:33 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 09/40] target/hexagon: Add privilege check, use tag_ignore()
Date: Mon,  1 Sep 2025 20:46:44 -0700
Message-Id: <20250902034715.1947718-10-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX84a7QpekA5F+
 6Z6jTPYAUm3kpBpcxmfIWp+ICViCrKHatw3sYW0PAwXsrIyncpJDAD1hurtw4uboNKI9Z3gQ9PE
 DKT+G+ESpnAkbCR+dnx9UTWgacxrORH/bIqLjnSHOxLLSKmjWrYejLO1rMfmWXaF3FpjTm63KFn
 DMw0bvyFYeYXx4/DMO5qzXN1o8jPY0upXOJJWTpIxF5jcajZvT9paPEDu60nWbX2rGP/wXAZRmm
 U1YhjgzLDoD4mrwSLjTV0Q6U2UVXdxpG1E9SQzlmk1M+QJgVUp3p5zWej0a1r+xXL+G2i5+ry45
 M0OFv0OoV708kgQJQSY4ENNLV1Lc/GvkdqvSnxDQ4DulvP+AGu23+6MdnZHJD5DO/sP0fsek+X7
 7xuQlkfh
X-Proofpoint-ORIG-GUID: GRKf_710uYnl4AEtCWew_cqwiHuHHA0x
X-Proofpoint-GUID: GRKf_710uYnl4AEtCWew_cqwiHuHHA0x
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b668d6 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=VlJJRYDoeMviBMv8l8cA:9 a=QEXdDO2ut3YA:10
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Brian Cain <bcain@quicinc.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu.h            |  1 +
 linux-user/hexagon/cpu_loop.c   | 16 ++++++++++++++++
 target/hexagon/cpu.c            |  1 +
 target/hexagon/translate.c      |  8 ++++++++
 target/hexagon/gen_tcg_funcs.py | 32 +++++++++++++++++++-------------
 5 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 1fc4093176..df1f2b569c 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -85,6 +85,7 @@ typedef struct {
 typedef struct CPUArchState {
     target_ulong gpr[TOTAL_PER_THREAD_REGS];
     target_ulong pred[NUM_PREGS];
+    target_ulong cause_code;
 
     /* For comparing with LLDB on target - see adjust_stack_ptrs function */
     target_ulong last_pc_dumped;
diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
index 25c97edcae..28ad8073f6 100644
--- a/linux-user/hexagon/cpu_loop.c
+++ b/linux-user/hexagon/cpu_loop.c
@@ -22,6 +22,7 @@
 #include "qemu.h"
 #include "user-internals.h"
 #include "user/cpu_loop.h"
+#include "target/hexagon/internal.h"
 #include "signal-common.h"
 #include "internal.h"
 
@@ -60,6 +61,21 @@ void cpu_loop(CPUHexagonState *env)
                 env->gpr[0] = ret;
             }
             break;
+        case HEX_EVENT_PRECISE:
+            switch (env->cause_code) {
+            case HEX_CAUSE_PRIV_USER_NO_GINSN:
+            case HEX_CAUSE_PRIV_USER_NO_SINSN:
+            case HEX_CAUSE_INVALID_PACKET:
+            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC,
+                    env->gpr[HEX_REG_PC]);
+            break;
+            default:
+                EXCP_DUMP(env, "\nqemu: unhandled CPU precise exception "
+                    "cause code 0x%x - aborting\n",
+                    env->cause_code);
+                exit(EXIT_FAILURE);
+            }
+            break;
         case HEX_CAUSE_PC_NOT_ALIGNED:
             force_sig_fault(TARGET_SIGBUS, TARGET_BUS_ADRALN,
                             env->gpr[HEX_REG_R31]);
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index a193acdbfc..c9dfdd7864 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -298,6 +298,7 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
     set_float_detect_tininess(float_tininess_before_rounding, &env->fp_status);
     /* Default NaN value: sign bit set, all frac bits set */
     set_float_default_nan_pattern(0b11111111, &env->fp_status);
+    env->cause_code = HEX_EVENT_NONE;
 }
 
 static void hexagon_cpu_disas_set_info(CPUState *s, disassemble_info *info)
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 15f5adc400..c87f07ab69 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -61,6 +61,10 @@ TCGv hex_vstore_addr[VSTORES_MAX];
 TCGv hex_vstore_size[VSTORES_MAX];
 TCGv hex_vstore_pending[VSTORES_MAX];
 
+#ifndef CONFIG_USER_ONLY
+TCGv hex_cause_code;
+#endif
+
 static const char * const hexagon_prednames[] = {
   "p0", "p1", "p2", "p3"
 };
@@ -1107,4 +1111,8 @@ void hexagon_translate_init(void)
             offsetof(CPUHexagonState, vstore_pending[i]),
             vstore_pending_names[i]);
     }
+#ifndef CONFIG_USER_ONLY
+    hex_cause_code = tcg_global_mem_new(tcg_env,
+        offsetof(CPUHexagonState, cause_code), "cause_code");
+#endif
 }
diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs.py
index c2ba91ddc0..65bfa046b8 100755
--- a/target/hexagon/gen_tcg_funcs.py
+++ b/target/hexagon/gen_tcg_funcs.py
@@ -21,7 +21,7 @@
 import re
 import string
 import hex_common
-
+from textwrap import dedent
 
 ##
 ## Generate the TCG code to call the helper
@@ -50,6 +50,18 @@ def gen_tcg_func(f, tag, regs, imms):
 
     f.write("    Insn *insn G_GNUC_UNUSED = ctx->insn;\n")
 
+    if "A_PRIV" in hex_common.attribdict[tag]:
+        f.write(dedent("""\
+#ifdef CONFIG_USER_ONLY
+    hex_gen_exception_end_tb(ctx, HEX_CAUSE_PRIV_USER_NO_SINSN);
+#else
+"""))
+    if "A_GUEST" in hex_common.attribdict[tag]:
+        f.write(dedent("""\
+#ifdef CONFIG_USER_ONLY
+    hex_gen_exception_end_tb(ctx, HEX_CAUSE_PRIV_USER_NO_GINSN);
+#else
+"""))
     if hex_common.need_ea(tag):
         f.write("    TCGv EA G_GNUC_UNUSED = tcg_temp_new();\n")
 
@@ -97,6 +109,11 @@ def gen_tcg_func(f, tag, regs, imms):
         if reg.is_written():
             reg.log_write(f, tag)
 
+    if (
+        "A_PRIV" in hex_common.attribdict[tag]
+        or "A_GUEST" in hex_common.attribdict[tag]
+    ):
+        f.write("#endif   /* CONFIG_USER_ONLY */\n")
     f.write("}\n\n")
 
 
@@ -121,18 +138,7 @@ def main():
             f.write('#include "idef-generated-emitter.h.inc"\n\n')
 
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
 
             gen_def_tcg_func(f, tag, tagregs, tagimms)
-- 
2.34.1


