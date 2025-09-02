Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD2DCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI0U-0007K6-Ca; Mon, 01 Sep 2025 23:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0C-0006wP-0F
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI09-0004Vj-8u
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:11 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RpH7030092
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vgCHS3aLEltyNqfHFNdMSq/Dy0IvxO4z23Y9RYywzOU=; b=aR7EZNs3K1+4Cs9O
 paHbyKP36Cz8UwUm7Gw5Iokjg5W2+aBbyY+Z2Vijzu2KKj846QGqgAI/+IJ6oBn7
 bqRih8tB/CXwlSqkq5Qp41gHwqcd2SWfdI4/lAm8uZ3O/cm1jXs4fmREFyK+DXsp
 95lGwMHOYAt6qx2cnXrS33lbCzvaFi8mIwfhcINc/SXJIFeNQMOA4BiF3tjoJXlT
 0Kr/FecNKAoINs3vcw84Fw0ex7xJ0h7nTRtllAhPLNQk8+VRDwzYBpbVoSw1jDmQ
 LC3y2lNd/QVexD5tBmE0Lx044wxdlHT80oA3my1qdsXl2w148XZp2bFqwHGDEV9d
 Alp54w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush2xafu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:56 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b47174b3427so4078635a12.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784875; x=1757389675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vgCHS3aLEltyNqfHFNdMSq/Dy0IvxO4z23Y9RYywzOU=;
 b=lJYQnql0a1izFUTe6039hRmgJ5DC/06PJXK/D7IEc4AmvB7h7tgFyDW+hXoHwRiW8+
 FDsBeMd5Ivd6w/BCju189eaxMZVn3S0DJwED8Gv5pdeC5ofIXFE1414g+7VO4OQhjDOw
 Fmzqm61C/Lv1lByv9VejGB/GZtjaEzX7ZzCVfszXwebWBM+QJuEgjt2/BWPYVb+C/q0X
 IVjHA7VD+p9AcHbWJVTNgDZbY1gHmkP1XFnKfmp3wbLSxFXxOViUfjnUQpCNmvSqHHM/
 QUFn6yz9zqPNAiWYRWtCxqnxvxnnki7mZmtozopoolbyC2cmZg8syT/IKtMCXoEF2nRy
 PMwg==
X-Gm-Message-State: AOJu0YzHYExjX3s1waMGXkWH3hc9MEbP+g3F6JKbRI3DnuRvCqzVKaj2
 heTDOc/YTQVd5sg/7uCahDc1qwufsIX0dogsWsh2wx4DwVPRsAZrg6Id3JNTX+6KV4yrEmEJ7B/
 DL1Cyn/QMbQt99k8HYnGdxoRmEc+Ws9+xs7W53N9DaDAiFVq1mBS25xoAbHgpIIMEqBdK
X-Gm-Gg: ASbGncuZlOB2YH/MAEJDDnMIx8sY501lSjmNMAl9LtvNX6zBNYuJh/4H7UO2OgBLk8O
 rYafkR+iPYdi08dxZCmuXLVmBpt6bTfmiz8OayTTLLxOUXxFjmWqKPSJcTD4OMK/hSrdianqXHn
 DrwB2osSGOSW68NmBCqNGBwjUtRVgird0k2GiZdTrj5rJFSBw8XLNnSCizwML5fgLHlRBjnk8sE
 AKGu9pHASOfD1LAG2CK7xD22Gn3KNkgFoR9mf7YrL3ECEUQSek+5h6jkOGCyvulO+YGWmTjd277
 MRA/RfBDoLqwVINezG/Tverx5hZq3pKFKEI6Tu2VTYhvrtI3z0B4mStGHViVx+P2UcT6vTf4dil
 fGPyItul0wsQL
X-Received: by 2002:a05:6a20:a105:b0:240:1c56:64a5 with SMTP id
 adf61e73a8af0-243d6e07ab8mr14813894637.15.1756784875266; 
 Mon, 01 Sep 2025 20:47:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEccNOItZ1OinKgOcEnvCS6RPs82/DW06eyRgGg/PsQoPTRlXEWxS58NZWWg2YbdQplsq/0Aw==
X-Received: by 2002:a05:6a20:a105:b0:240:1c56:64a5 with SMTP id
 adf61e73a8af0-243d6e07ab8mr14813865637.15.1756784874845; 
 Mon, 01 Sep 2025 20:47:54 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:54 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 28/40] target/hexagon: Add TCG overrides for int handler
 insts
Date: Mon,  1 Sep 2025 20:47:03 -0700
Message-Id: <20250902034715.1947718-29-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX2SHAgyT7nCEC
 0qa/vbQEkaQDyAkKI+jnbYmil+CBc/6oO7bX6Jr5f+3VTVIbXF5IGhjPTGJoDxZN8eyr4shNtGW
 SGZVRAMGjHy6Dh6WUBFkrAhKOu7nSS96a866miJXUrKrP25GAMZWyGGaYQ+94Lh00YG7rRlyd52
 2cPOGk5JMkvowDmfmr+2qEnaUw8wHBDS6NHjKzEbWrspq8LqTSzQbY/xtlQhbJz7HUORXyKbsSh
 mVZvm0YKwcBA/bhhf14/w1OKegr4bfq++TIYWSNljZZcv3rhrXV/9J41N+BVl+HMwCoqhAM/LDq
 QcyZHqXanfGjD+AugflAIUXrff3TapS9AHoBs5+RfS2VeCYx6hKhlqXYuJswcl8Lwu4I5mEiVUA
 Qq36JeCD
X-Proofpoint-ORIG-GUID: 7cN6bw5n3L-CruXJ6MdaAK6yRvePyTZT
X-Proofpoint-GUID: 7cN6bw5n3L-CruXJ6MdaAK6yRvePyTZT
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68b668ec cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=ncxFUDX8U6Z2rYVbhVQA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032
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

Define TCG overrides for {c,}swi {c,s}iad, iassign{r,w}, {s,g}etimask
instructions.


Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/gen_tcg_sys.h | 25 ++++++++++++++++++++++
 target/hexagon/helper.h      |  8 ++++++++
 target/hexagon/op_helper.c   | 40 ++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+)

diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.h
index 362703ab45..642ca3d3ff 100644
--- a/target/hexagon/gen_tcg_sys.h
+++ b/target/hexagon/gen_tcg_sys.h
@@ -7,6 +7,31 @@
 #ifndef HEXAGON_GEN_TCG_SYS_H
 #define HEXAGON_GEN_TCG_SYS_H
 
+/* System mode instructions */
+#define fGEN_TCG_Y2_swi(SHORTCODE) \
+    gen_helper_swi(tcg_env, RsV)
+
+#define fGEN_TCG_Y2_cswi(SHORTCODE) \
+    gen_helper_cswi(tcg_env, RsV)
+
+#define fGEN_TCG_Y2_ciad(SHORTCODE) \
+    gen_helper_ciad(tcg_env, RsV)
+
+#define fGEN_TCG_Y4_siad(SHORTCODE) \
+    gen_helper_siad(tcg_env, RsV)
+
+#define fGEN_TCG_Y2_iassignw(SHORTCODE) \
+    gen_helper_iassignw(tcg_env, RsV)
+
+#define fGEN_TCG_Y2_iassignr(SHORTCODE) \
+    gen_helper_iassignr(RdV, tcg_env, RsV)
+
+#define fGEN_TCG_Y2_getimask(SHORTCODE) \
+    gen_helper_getimask(RdV, tcg_env, RsV)
+
+#define fGEN_TCG_Y2_setimask(SHORTCODE) \
+    gen_helper_setimask(tcg_env, PtV, RsV)
+
 #define fGEN_TCG_Y2_setprio(SHORTCODE) \
     gen_helper_setprio(tcg_env, PtV, RsV)
 
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 146f4f02e4..2fe4440ddc 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -109,6 +109,14 @@ DEF_HELPER_2(probe_hvx_stores, void, env, int)
 DEF_HELPER_2(probe_pkt_scalar_hvx_stores, void, env, int)
 
 #if !defined(CONFIG_USER_ONLY)
+DEF_HELPER_2(swi, void, env, i32)
+DEF_HELPER_2(cswi, void, env, i32)
+DEF_HELPER_2(ciad, void, env, i32)
+DEF_HELPER_2(siad, void, env, i32)
+DEF_HELPER_2(iassignw, void, env, i32)
+DEF_HELPER_2(iassignr, i32, env, i32)
+DEF_HELPER_2(getimask, i32, env, i32)
+DEF_HELPER_3(setimask, void, env, i32, i32)
 DEF_HELPER_2(sreg_read, i32, env, i32)
 DEF_HELPER_2(sreg_read_pair, i64, env, i32)
 DEF_HELPER_2(greg_read, i32, env, i32)
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index cfd34d8712..01e2677a62 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1337,6 +1337,46 @@ void HELPER(vwhist128qm)(CPUHexagonState *env, int32_t uiV)
 }
 
 #ifndef CONFIG_USER_ONLY
+void HELPER(ciad)(CPUHexagonState *env, uint32_t mask)
+{
+    g_assert_not_reached();
+}
+
+void HELPER(siad)(CPUHexagonState *env, uint32_t mask)
+{
+    g_assert_not_reached();
+}
+
+void HELPER(swi)(CPUHexagonState *env, uint32_t mask)
+{
+    g_assert_not_reached();
+}
+
+void HELPER(cswi)(CPUHexagonState *env, uint32_t mask)
+{
+    g_assert_not_reached();
+}
+
+void HELPER(iassignw)(CPUHexagonState *env, uint32_t src)
+{
+    g_assert_not_reached();
+}
+
+uint32_t HELPER(iassignr)(CPUHexagonState *env, uint32_t src)
+{
+    g_assert_not_reached();
+}
+
+uint32_t HELPER(getimask)(CPUHexagonState *env, uint32_t tid)
+{
+    g_assert_not_reached();
+}
+
+void HELPER(setimask)(CPUHexagonState *env, uint32_t pred, uint32_t imask)
+{
+    g_assert_not_reached();
+}
+
 void HELPER(sreg_write)(CPUHexagonState *env, uint32_t reg, uint32_t val)
 {
     g_assert_not_reached();
-- 
2.34.1


