Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793E2CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI07-0006th-90; Mon, 01 Sep 2025 23:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzq-0006qG-Uj
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzn-0004Tt-Tw
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:50 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S4uS030589
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u6+cmbwXwuBQg3mgmZyDbHMM77cwPQpYHh0dKMI4RyM=; b=UvP8O4fK8C7m4Oqq
 7MpmK/mKAvIBlWsu1HnlarAMRvCuVLFoqg0ETA2Y06p8Ie5LT3VLn91tUJSm8Ldx
 h0Oyb6t1Wi8GY9yiKy1Z4ib+mAkmgX1Pvah7T9sw9MWCp17pyo68VqRWYS/B5UdN
 NWp4z+NnWUa9jMJf1q3LdPAS5klsKI4LG0+bLfZPFvB4xCUb99HanWX9UGsyfPQ+
 lRLCPk2PyJFa1BsVbdhHQxMfSCUMo+gt+EScTNNMOxrN+nJ6XnL2CvfWrd7jvcFE
 3eTYobq4tvKUuxRTtf74D+yhMDfYpadLXALEj3byjxGWYIvAxIkHdGOdp43o7M/z
 /YXX3w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8pbxx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:46 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-77267239591so1184262b3a.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784865; x=1757389665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u6+cmbwXwuBQg3mgmZyDbHMM77cwPQpYHh0dKMI4RyM=;
 b=r4gVyEsV+yGdgAG0iGDjmZHcJnPRMbTw71TywOhmk37rmdmPEomhRrOutJl8NazenB
 YqI4j8BH+H+ReWFvNfNallhGzHOWl7SLnxpVB2pZ1mN8TtXdxis/Inp2Nf0Ljpn2XbLg
 N7Fm5Bp3+Hb0pzUKoj7zc+O5voNBr+IrNf0if5T5+/ysEG8krIqudT0U25CdrL6+UvNI
 0My7lRXl2sDLG3QknoFNqdytO2x2cFXCFR5MTVlg11xc+6YcfE/NgQDclIsZ25eVsi4E
 sXvMy334/QJGY4nPAaZ8ihxYmt/mxgwHbXaDDsekILbzEe2Z9GsZGJItemChbAmBhTzj
 QuNw==
X-Gm-Message-State: AOJu0Yym0aOoKbVMLIjC7bIy3DqkTWLWbW/LIOGpy0M7qn83g1s+jpvt
 i5EWrokxaz19sl4IAhMGkUdr12rREcf1/ngSYuzH4yeQZBY7Bm1HqlM1s66u+hHfoG+lNZsrQxW
 r5kxWfbP6bLJDQgnKDhT8a4B3DoYyQXohz+Ey0ZVHm1pcdpgMNciPifx8Kw5kb9TBIozB
X-Gm-Gg: ASbGncuMmfOUzvzjFZnM5qbA6mU0sITnrib83nqUIpkN171nDGQf786aeTk4fVK9Kk5
 Aevo98wPodf16w+nb3l3Brh+CRQHK3xnYwKDmBQ4Lm6/7NmAREXLTdsnjCLfUEn6HZQWmznAPmi
 kxrg5+frGQI4eX/mPfnWDn84ZT+bq/Gf+yhRfbhwxIweEclMypIemP+4boPGjHUCYZUpbpqazJV
 bpy2ROz6m4cfTdUTUUxaVW5vBJoK4Q7EhnN7dpAdwdpA+qHv0c7oEDIDoF7hKM+wQ6CmG+mgxPa
 wc5M8CNyLFd4i2Y3jb3Y0AcmjtiwmOF/XYf7LaEu2eLcQhdd48CZHgXXywgL/+b1KPhEIMxYTQw
 3w1tQfGXF43bH
X-Received: by 2002:a05:6a20:7d9a:b0:243:4b5d:5ea6 with SMTP id
 adf61e73a8af0-243d6e56fa9mr13813257637.26.1756784865279; 
 Mon, 01 Sep 2025 20:47:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkeWFczIB30dw79kli6Qlqszey2BYnWuEHXNaFxmPQBm/BPqZ+rWPhV+MzTeKUcytqwztbbg==
X-Received: by 2002:a05:6a20:7d9a:b0:243:4b5d:5ea6 with SMTP id
 adf61e73a8af0-243d6e56fa9mr13813223637.26.1756784864803; 
 Mon, 01 Sep 2025 20:47:44 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:44 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 19/40] target/hexagon: Add handlers for guest/sysreg r/w
Date: Mon,  1 Sep 2025 20:46:54 -0700
Message-Id: <20250902034715.1947718-20-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pNPCWjchi3K3s_D272ajkLFMGSsZOllC
X-Proofpoint-GUID: pNPCWjchi3K3s_D272ajkLFMGSsZOllC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX1S2RazfDf0E7
 T802Levy681JS5MTWOhlKAr6XcsR1ueoImyzd8RU0oMCWQ2wthvu4AjNHXhjXhbgnn1yPftis8l
 iPqEgA5xV8HbZ02vZiqFupB096Fyg80qHVscl67Yw4B8EU+1yaO++nK9fZLvaf5q03RRsqGHT4i
 zVb53Uu1e7xOXwz9hZaEugESb4m9toCfOtw6/1qa32Rg33PgLpA4KafqDcpeFbxNyWk7ybhETiv
 Yd4t7/5vmYMisoKUv2gHl1uW86O8zIYoOwHI8gIhFkBKSsfUcXT+E0nzyatW6P5CAQxXKWZS8iu
 eodlC/muRrNXxRu5hakWSjAazfg69UGtwzRcHnOWoEPrlg9aRVGO6ijQmpQcjWuf53CIkw89PvD
 EdLYYkqq
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b668e2 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=l5hRqwrd4wiMbFURoVoA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

This commit provides handlers to generate TCG for guest and system
register reads and writes.  They will be leveraged by a future commit.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/genptr.c | 138 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index 08fc5413de..a474787816 100644
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
@@ -128,6 +129,143 @@ TCGv get_result_pred(DisasContext *ctx, int pnum)
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
+static inline void gen_log_greg_write(DisasContext *ctx, int rnum, TCGv val)
+{
+    tcg_gen_mov_tl(ctx->greg_new_value[rnum], val);
+}
+
+G_GNUC_UNUSED
+static void gen_log_greg_write_pair(DisasContext *ctx, int rnum, TCGv_i64 val)
+{
+    TCGv val32 = tcg_temp_new();
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
+static const target_ulong sreg_immut_masks[NUM_SREGS] = {
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
+static void gen_log_sreg_write(DisasContext *ctx, int rnum, TCGv val)
+{
+    const target_ulong reg_mask = sreg_immut_masks[rnum];
+
+    if (reg_mask != IMMUTABLE) {
+        if (rnum < HEX_SREG_GLB_START) {
+            gen_masked_reg_write(val, hex_t_sreg[rnum], reg_mask);
+            tcg_gen_mov_tl(ctx->t_sreg_new_value[rnum], val);
+        } else {
+            gen_helper_sreg_write_masked(tcg_env, tcg_constant_i32(rnum), val);
+        }
+    }
+}
+
+G_GNUC_UNUSED
+static void gen_log_sreg_write_pair(DisasContext *ctx, int rnum, TCGv_i64 val)
+{
+    TCGv val32 = tcg_temp_new();
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
+static void gen_read_sreg(TCGv dst, int reg_num)
+{
+    if (reg_num >= HEX_SREG_GLB_START || reg_num == HEX_SREG_BADVA) {
+        gen_helper_sreg_read(dst, tcg_env, tcg_constant_i32(reg_num));
+    } else {
+        tcg_gen_mov_tl(dst, hex_t_sreg[reg_num]);
+    }
+}
+
+G_GNUC_UNUSED
+static void gen_read_sreg_pair(TCGv_i64 dst, int reg_num)
+{
+    if (reg_num < HEX_SREG_GLB_START) {
+        if (reg_num + 1 == HEX_SREG_BADVA) {
+            TCGv badva = tcg_temp_new();
+            gen_helper_sreg_read(badva, tcg_env,
+                                 tcg_constant_tl(HEX_SREG_BADVA));
+            tcg_gen_concat_i32_i64(dst, hex_t_sreg[reg_num], badva);
+        } else {
+            tcg_gen_concat_i32_i64(dst, hex_t_sreg[reg_num],
+                                        hex_t_sreg[reg_num + 1]);
+        }
+    } else {
+        gen_helper_sreg_read_pair(dst, tcg_env, tcg_constant_tl(reg_num));
+    }
+}
+
+G_GNUC_UNUSED
+static void gen_read_greg(TCGv dst, int reg_num)
+{
+    gen_helper_greg_read(dst, tcg_env, tcg_constant_tl(reg_num));
+}
+
+G_GNUC_UNUSED
+static void gen_read_greg_pair(TCGv_i64 dst, int reg_num)
+{
+    gen_helper_greg_read_pair(dst, tcg_env, tcg_constant_tl(reg_num));
+}
+#endif
+
+
 void gen_log_pred_write(DisasContext *ctx, int pnum, TCGv val)
 {
     TCGv pred = get_result_pred(ctx, pnum);
-- 
2.34.1


