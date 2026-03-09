Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3540FF417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbv2-0001NQ-7Y; Mon, 09 Mar 2026 10:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuc-0000s2-MN
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbua-0005GK-TD
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:50 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629EerBC3773507
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +noMkYUOhKd6CmPutkej3yzEfQc/TUuch39sOhKneQg=; b=KopeBWPMxbih+bDQ
 ATUCmYAAMMk8mH1Hc/pzl9nVGKH+LZH90y9bFii/zsDmg3Q4QTZwlbhFZMJR6VFT
 Fpg2PD8UpkxYNEcTGjrLaE5TAJtl1a/4m32khqQbo8jwmXLAnmZuFezsbnGxo9g/
 ToTcdLxhW+twpAqacdUc64rtVxxegzO7rxxm+T7wwAi6U4/H7txVxoMu+XpDBS6+
 jpOX4OGxLnGAAa4QT8TGLT8+psX2VRYsVOp5SyQnH5bap4xBSZbUsu2/MB5ZsoUA
 rKkmpD21eqNTylk10NiH0bxUBvcxfzxCX7KyyXvpdCUoXKnYCjmIjWMOngI7U2iA
 MIQ3Bg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cstsa98ee-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:47 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2bdc1b30ac8so47870993eec.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067726; x=1773672526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+noMkYUOhKd6CmPutkej3yzEfQc/TUuch39sOhKneQg=;
 b=A+vyDHStNPWjY/WBQmkK92iCNk5mhh3f98TfYQ8iLfq1QgV/FbcZ2C2hiB1gRk/UGs
 iN1161zoTQQlD4JkFTyagDFRetPV1ekflrUZk5wXcDKm5DH2yU9yG8a5QfVDQ6yePPCq
 PPZwvFv/tbohOdKNksDUwFvCGXy1+InwYaDmmqmm7A3y8d8cu0fUr4zA5IanUrqbHNzP
 Pek7RqT0NuE+piBbbzx9tQZrKTf+RrAIEJWVVG2br6XOPab1BYVc5odgirNjNoS/5dM6
 JurKaI4ke9mlJ7nr8D+EtPVQkL+ZjlbvUYXaG19jMkwKaffzA33wagl7yZdPXb2WR1ZZ
 bWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067726; x=1773672526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+noMkYUOhKd6CmPutkej3yzEfQc/TUuch39sOhKneQg=;
 b=SFqnpBUlooh/rZuR7zTSto2msld7598cJgmy4MPmv8EdwmQ54PFQXi8AzUXaToh9lz
 v838yXTtkCviXDzjh4qBEnIuaUjb/KOENzHRIUycXlnrnJBwsE1afghUvciRBA+hmuOI
 9L2Qv0kqKRzFDvIhuILSunxRitAmIOMTMXv3WfJkGKO68C2qZQP4dSadYsB+vHhtVjmx
 pUjmIXZyv7EC503qd6rhR6yL8TvwU7gCnnqYrTg9YM3U8FEC8QBtjBEoDt8+p8AJLYOx
 OXsEFMCPPV2yvCIvsV00aqwUnWdiGcEb90lhterKTjvoRK3IeV1Pcx38rHW+5inLbecI
 BHxA==
X-Gm-Message-State: AOJu0Yx7p5GIeDJVAxnoxUcErXFSYqxmXdX8zdXW/BC4wRqrzxRtpU7U
 gMyR1k+LytDbK+lWe5qwmYO2Lj6+hpDSdmxK3lrnMd5FSdXWokulAM6b/CuF/1Xlt24afXCpJps
 RPqpY89IsufCbbiAvp6WBoPpKt0eHn6bZ26OalrwjO0x6/23KLYV5/5LP2MCBVAZ3Eg==
X-Gm-Gg: ATEYQzwqvzbjs7MOaKQJLrP12bFa4y/V2QNf6ARZDD4ptJuKe+QSEqAyFuPfBVIWV8w
 Wunoh4WwOtP50xhy84v1G4qJVLfSSd2MrZ08E79yO9yfpTYGoD/f3hC1TN2l66Tc8qaZvKIOi6J
 rd0lXSPr9MgLi528et/CLQgvy2THVGQ8KHxXeaEDQaMi/QPQdbffSL9daKYE1hfSMQY/UI43Mk4
 TA7FnSVaXjiFCYdTH5SVp17eXAJV0z9awSEGVqIw5/4xJVEgVZ/zbSq8owEJqU6CNHO/OaBLUzI
 zYAaPwstFfCl1VlyNMNYu7dEaYkunZ1A0Tesksn8OeKUb495K3HJ146/wxW2rEP3++MCt4jr9DU
 0c0eJ89WniZhFVNRPIGONsfu2Z1SlDdTxSfqSLfOFdbBBuvqO6Dta5fRPAjIBdhBZtPNhcQ==
X-Received: by 2002:a05:7300:3b06:b0:2be:37d:3d6d with SMTP id
 5a478bee46e88-2be4e0ac5bemr4752492eec.32.1773067725849; 
 Mon, 09 Mar 2026 07:48:45 -0700 (PDT)
X-Received: by 2002:a05:7300:3b06:b0:2be:37d:3d6d with SMTP id
 5a478bee46e88-2be4e0ac5bemr4752464eec.32.1773067725243; 
 Mon, 09 Mar 2026 07:48:45 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:44 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 17/35] target/hexagon: Add handlers for guest/sysreg r/w
Date: Mon,  9 Mar 2026 07:48:04 -0700
Message-Id: <20260309144822.877695-18-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wO5oxUxqOYbSWhj2q1Xt6YIFQr1zcD6g
X-Authority-Analysis: v=2.4 cv=I+Vohdgg c=1 sm=1 tr=0 ts=69aeddcf cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=YS0KV4ZxTOLzYV__0jkA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfX8MI3pHQufn+V
 H2oBgS6UGm2ZHY74OMz5V6mXkAYw3n0O6fH+nbtwy09n2qxQi+uATK5OUKiQroTdhtPr3/pCl/k
 F8cctB/2xlSs6Q97W08jK3CtxqCafKiz8NCeV3OIswWjQWtRPw/fuVV/um60256VccQDnwI2tQB
 XNgAOL/6rszOx/oUtqfGbsxCVE/s0unL/eQTQyuZQaiwIa5GK6lqYUpYGJGwJVCexyVlXdmrTZ/
 c7G1HN3Z9RBmD44Ah+nypePbjUKq/uynvP5jK18wwecuK9XwwZolECqdDrYYi6ULyKFcLV3ODQT
 UvgeiaNBEGWm+RL3IMHBRPsrOkx9Gbv2Bw2ttzgl3dEMN2FoX7hSn8isF/nWmZdeFuodS4itLY+
 xTrDhRI+SF1qdjIebds940OnIx2FcV1E4+TcDUQUVAUL/g7mQmCjLy4A4Kkh0K1sciLpbR5g2en
 HzxhwsxuDtJPx7nX0YA==
X-Proofpoint-ORIG-GUID: wO5oxUxqOYbSWhj2q1Xt6YIFQr1zcD6g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
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

This commit provides handlers to generate TCG for guest and system
register reads and writes.  They will be leveraged by a future commit.

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/genptr.c | 147 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index 9eb21da6f3e..2310b9aec3a 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -23,6 +23,7 @@
 #include "exec/helper-gen.h"
 #include "insn.h"
 #include "opcodes.h"
+#include "sys_macros.h"
 #include "translate.h"
 #define QEMU_GENERATE       /* Used internally by macros.h */
 #include "macros.h"
@@ -120,6 +121,152 @@ TCGv get_result_pred(DisasContext *ctx, int pnum)
     }
 }
 
+#ifndef CONFIG_USER_ONLY
+G_GNUC_UNUSED
+static bool greg_writable(int rnum, bool pair)
+{
+    if (pair) {
+        if (rnum < HEX_GREG_G3) {
+            return true;
+        }
+        qemu_log_mask(LOG_UNIMP,
+                "Warning: ignoring write to guest register pair G%d:%d\n",
+                rnum + 1, rnum);
+    } else {
+        if (rnum <= HEX_GREG_G3) {
+            return true;
+        }
+        qemu_log_mask(LOG_UNIMP,
+                "Warning: ignoring write to guest register G%d\n", rnum);
+    }
+    return false;
+}
+
+G_GNUC_UNUSED
+static void check_greg_impl(int rnum, bool pair)
+{
+    if (pair && (!greg_implemented(rnum) || !greg_implemented(rnum + 1))) {
+        qemu_log_mask(LOG_UNIMP,
+                "Warning: guest register pair G%d:%d is unimplemented or "
+                "reserved. Read will yield 0.\n",
+                rnum + 1, rnum);
+    } else if (!pair && !greg_implemented(rnum)) {
+        qemu_log_mask(LOG_UNIMP,
+                "Warning: guest register G%d is unimplemented or reserved."
+                " Read will yield 0.\n", rnum);
+    }
+}
+
+G_GNUC_UNUSED
+static inline void gen_log_greg_write(DisasContext *ctx, int rnum, TCGv_i32 val)
+{
+    tcg_gen_mov_i32(ctx->greg_new_value[rnum], val);
+}
+
+G_GNUC_UNUSED
+static void gen_log_greg_write_pair(DisasContext *ctx, int rnum, TCGv_i64 val)
+{
+    TCGv_i32 val32 = tcg_temp_new_i32();
+
+    /* Low word */
+    tcg_gen_extrl_i64_i32(val32, val);
+    gen_log_greg_write(ctx, rnum, val32);
+
+    /* High word */
+    tcg_gen_extrh_i64_i32(val32, val);
+    gen_log_greg_write(ctx, rnum + 1, val32);
+}
+
+static const uint32_t sreg_immut_masks[NUM_SREGS] = {
+    [HEX_SREG_STID] = 0xff00ff00,
+    [HEX_SREG_ELR] = 0x00000003,
+    [HEX_SREG_SSR] = 0x00008000,
+    [HEX_SREG_CCR] = 0x10e0ff24,
+    [HEX_SREG_HTID] = IMMUTABLE,
+    [HEX_SREG_IMASK] = 0xffff0000,
+    [HEX_SREG_GEVB] = 0x000000ff,
+};
+
+G_GNUC_UNUSED
+static void gen_log_sreg_write(DisasContext *ctx, int rnum, TCGv_i32 val)
+{
+    const uint32_t reg_mask = sreg_immut_masks[rnum];
+
+    if (reg_mask != IMMUTABLE) {
+        if (rnum < HEX_SREG_GLB_START) {
+            gen_masked_reg_write(val, hex_t_sreg[rnum], reg_mask);
+            tcg_gen_mov_i32(ctx->t_sreg_new_value[rnum], val);
+        } else {
+            gen_helper_sreg_write_masked(tcg_env, tcg_constant_i32(rnum), val);
+        }
+    }
+}
+
+G_GNUC_UNUSED
+static void gen_log_sreg_write_pair(DisasContext *ctx, int rnum, TCGv_i64 val)
+{
+    TCGv_i32 val32 = tcg_temp_new_i32();
+
+    /* Low word */
+    tcg_gen_extrl_i64_i32(val32, val);
+    gen_log_sreg_write(ctx, rnum, val32);
+
+    /* High word */
+    tcg_gen_extrh_i64_i32(val32, val);
+    gen_log_sreg_write(ctx, rnum + 1, val32);
+}
+
+G_GNUC_UNUSED
+static void gen_read_sreg(TCGv_i32 dst, int reg_num)
+{
+    if (reg_num >= HEX_SREG_GLB_START || reg_num == HEX_SREG_BADVA) {
+        gen_helper_sreg_read(dst, tcg_env, tcg_constant_i32(reg_num));
+    } else {
+        tcg_gen_mov_i32(dst, hex_t_sreg[reg_num]);
+    }
+}
+
+G_GNUC_UNUSED
+static void gen_read_sreg_pair(TCGv_i64 dst, int reg_num)
+{
+    if (reg_num < HEX_SREG_GLB_START) {
+        if (reg_num + 1 == HEX_SREG_BADVA) {
+            TCGv_i32 badva = tcg_temp_new_i32();
+            gen_helper_sreg_read(badva, tcg_env,
+                                 tcg_constant_i32(HEX_SREG_BADVA));
+            tcg_gen_concat_i32_i64(dst, hex_t_sreg[reg_num], badva);
+        } else {
+            tcg_gen_concat_i32_i64(dst, hex_t_sreg[reg_num],
+                                        hex_t_sreg[reg_num + 1]);
+        }
+    } else {
+        gen_helper_sreg_read_pair(dst, tcg_env, tcg_constant_i32(reg_num));
+    }
+}
+
+G_GNUC_UNUSED
+static void gen_read_greg(TCGv_i32 dst, int reg_num)
+{
+    if (reg_num <= HEX_GREG_G3) {
+        tcg_gen_mov_i32(dst, hex_greg[reg_num]);
+    } else {
+        gen_helper_greg_read(dst, tcg_env, tcg_constant_i32(reg_num));
+    }
+}
+
+G_GNUC_UNUSED
+static void gen_read_greg_pair(TCGv_i64 dst, int reg_num)
+{
+    if (reg_num == HEX_GREG_G0 || reg_num == HEX_GREG_G2) {
+        tcg_gen_concat_i32_i64(dst, hex_greg[reg_num],
+                                    hex_greg[reg_num + 1]);
+    } else {
+        gen_helper_greg_read_pair(dst, tcg_env, tcg_constant_i32(reg_num));
+    }
+}
+#endif
+
+
 void gen_pred_write(DisasContext *ctx, int pnum, TCGv val)
 {
     TCGv pred = get_result_pred(ctx, pnum);
-- 
2.34.1


