Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F484F45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 17:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBG5w-0006ti-H8; Fri, 10 Apr 2026 13:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5r-0006rn-SK
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5l-0001fi-Se
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:34 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AAg5NQ4147926
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ZzpX2dtmew8
 OnfEXBDiB07/5iswcyFDy+0j5bknVIDY=; b=L48LfI6lKkjCIil+x0bnr2HLLlX
 EP4RXDd89NK4ogfBA9IDvpdcZNgKrNYy/7Lg7rcpGzHgVzZPVpMY6GG2B2/vy6vx
 OU7A7rabtvmKNJfjleWjuIYAGR5pmywnpstK18Umgspyg06f5tWbdhd/VXe153Xq
 UfyJ0yx1Qn5hWRlXp5xodUXzF9iYRbZXeLwmg65qNzgA8apWFogKCK9RVyFDbv3h
 aYYNJWzJD81dgTOm15EAADB/oKxO6uYSnr4QxR9xyQF0kuCC6jy5NdZ08c5QbxNV
 IiYw4RL1gyAHwx+UoOijeugSH0L9ljFlD8ZOZn1/gG1FhngPI7yoYapeU9Q==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deudgjcd5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:18 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-12c35f2c09dso1274216c88.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 10:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775843778; x=1776448578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZzpX2dtmew8OnfEXBDiB07/5iswcyFDy+0j5bknVIDY=;
 b=SqxY5mMZPAxJjZGzGCvZjcLbsbiaFbvj4+5iQdxzEAJqdW2mQWnZsujoiILbWkpJ1i
 rzcJew2Pm+bZVP9dYXevJltSLxkdNqCYAE9CTv/0VgmxM3tRP3uIEUzZ4JWrnv8Nr22A
 LEd00VFGC13/nXlBTxcOaI+ONFA6dBIApwiMG5sb3dYdtX7ECu1o4M8chVW9/AwoOp69
 eoKq/pTbz8ashuSaTL2TlFYUp0dvGd7v/Sdj9LkfaMPjNQzJkEahRToNHc4zB8jqjJ12
 DkooqMoQ9Dpxq6xq0lCqTb6bt/8Bw3nOHx8g+NgbiurhOV1DzRKbQ+0d5vjSLTjIuT1H
 lVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775843778; x=1776448578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZzpX2dtmew8OnfEXBDiB07/5iswcyFDy+0j5bknVIDY=;
 b=mLD0DxA+pmYpIaCA0ZS1PFxfbu357QCe+CuthVK/BtXIhLTVfcXAWIAtaqSy4mBDKF
 bJwLucnVkPeEKvQL4bBhUxmvcXLuvX1FdrqxxKB7zQY9FPvPju24M9puJuKg4nJK0RMQ
 at8CLLf8+QoTeb9vvVx/KSIZKupLUuWxYxxlgQsmEKVIbCQvKX/p0f2WqunEomZXBSa/
 929ezZvoqGeQfsYD2QukQZHJRez5TVid5qJs6CxUdlaGwHBHh9yTDAF20/RPYEoej20J
 zeI2ZWh60+ke4hI+X+swkd8wcBNkhynEQff5Q4IP/8KwRxGWS5F81OVtMiRYuKMMG39g
 xAQA==
X-Gm-Message-State: AOJu0YxrOpCdaYv8RLPElMD44WAHu1Y+oEFz3sXi+EC8pENKcmMlOdSo
 0686AJOmR35gJRFN6RPTCfYRzvMvVDhxJPzVXqq8jik5GheSPJep90k6TSdPHoNzxqpSwaLIqMd
 3NoUZ70xF3WV7yjrevNZ3Y9fC24vLljtm3FHgA+HhDBBXXCSVKfW4AQD11A6oXoBkwgr6
X-Gm-Gg: AeBDievSA7bOYE9P9Ix6zwCgvy8Tn84JgE1G6KEPwqnIxA9NAHlfzlxhLeUfa9BmsdH
 ajMOLVZVB5+SDg8mlDkR3q3bvFrehORWH6PvBXHuypYHSC+rRVtWvQCigKkOX3nzgeqqZQunJ0V
 +lgsdAl0I5YcUd90uuq3GpgVcm64dh/e1+jKwDIvp59IHPLCVaa/gvKozeYoJFYUoYp80KIo4Ld
 MjfDFaRssD7qZdH03LGNqNOcmtChi3HhUiMeFikbMw5/IgBg6MHhXj8qVoJDPQnn/j3hmu7Yu7J
 nDpQzU5Wm97HGNf0m5CNG/amh/1xJhieBh48UtmqIBF56DyTFSTmjIrUdgUqKil50bhc5S8rS0p
 I7HxeAtxgaQIvMS25H1wToyUA/AqOZLxWNhUPs3SLKgs00Ju4t3laYN0W0Sezn1ZkqnCzXXskY5
 oGPtC5v2gA
X-Received: by 2002:a05:7022:fa04:b0:12b:ebb9:1c0b with SMTP id
 a92af1059eb24-12c34ef8f1cmr2443731c88.31.1775843777508; 
 Fri, 10 Apr 2026 10:56:17 -0700 (PDT)
X-Received: by 2002:a05:7022:fa04:b0:12b:ebb9:1c0b with SMTP id
 a92af1059eb24-12c34ef8f1cmr2443715c88.31.1775843776848; 
 Fri, 10 Apr 2026 10:56:16 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c3459f7ffsm4256271c88.3.2026.04.10.10.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 10:56:16 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v4 09/16] target/hexagon: add v68 HVX IEEE float conversion
 insns
Date: Fri, 10 Apr 2026 10:55:57 -0700
Message-Id: <7fecae322cee17ab9ffb66cc80654925290c795d.1775843299.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jdrfYgUv6ZgGkrZ-ltZa2vshG2QnMc_X
X-Proofpoint-GUID: jdrfYgUv6ZgGkrZ-ltZa2vshG2QnMc_X
X-Authority-Analysis: v=2.4 cv=H/brBeYi c=1 sm=1 tr=0 ts=69d939c3 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=2JvGeOnW2cDEA-NDw-QA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE2OCBTYWx0ZWRfX3RHfLcWelw8F
 f453ln/9wE7DqsVGM3hya9RZvX7W1dai58v+vLFY7hF2El7JCEsJwSmt76NOonNdS/7Lpe1Lb6e
 JGuApeXn7VEAlxPVjGngPXz2eC9qvWBiGwn51r4ildvBR3BDaEFctCnlh8sWq6VGDvNjrTRq815
 8LG5fIWU+rPgzpwlGqrc5U59wwn4byBQEeJJNHRjLTJaNIUfoEs+UezDQPji9lpD1Eq12Mih3zs
 siXXnhwOSrzMprg94yax2b/8TSPJ2GYNEdwJzSTpamv7ggHROtfqwgArxNrI4h0SzACqaKiDJQb
 00vkod8KMaZ81e2d+Mruyj1tNmjNso1O+PVNl3tIdx60TfHmim08wQryg6XkBB7G8VG1ahhm1rR
 Lwwj1w2o56GmHcDjW1biWbPA/lU/e/H71yH82bfP0jgydGF+gMxDb0haJqbTsgm/11fQi8aKa9R
 IgGvkdcOi+sc4C/kN8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100168
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

Add HVX IEEE floating-point conversion instructions:
- vconv_hf_h, vconv_h_hf, vconv_sf_w, vconv_w_sf: vconv operations
- vcvt_hf_sf, vcvt_sf_hf: float <-> half float conversions
- vcvt_hf_b, vcvt_hf_h, vcvt_hf_ub, vcvt_hf_uh: int to half float
- vcvt_b_hf, vcvt_h_hf, vcvt_ub_hf, vcvt_uh_hf: half float to int

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/mmvec/hvx_ieee_fp.h           |  4 +
 target/hexagon/mmvec/hvx_ieee_fp.c           | 18 ++++
 target/hexagon/imported/mmvec/encode_ext.def | 18 ++++
 target/hexagon/imported/mmvec/ext.idef       | 97 ++++++++++++++++++++
 4 files changed, 137 insertions(+)

diff --git a/target/hexagon/mmvec/hvx_ieee_fp.h b/target/hexagon/mmvec/hvx_ieee_fp.h
index dff2fab14c..bdc21e08f0 100644
--- a/target/hexagon/mmvec/hvx_ieee_fp.h
+++ b/target/hexagon/mmvec/hvx_ieee_fp.h
@@ -10,6 +10,7 @@
 #include "fpu/softfloat.h"
 
 #define f16_to_f32(A) float16_to_float32((A), true, &env->hvx_fp_status)
+#define f32_to_f16(A) float32_to_float16((A), true, &env->hvx_fp_status)
 
 float32 fp_mult_sf_hf(float16 a1, float16 a2, float_status *fp_status);
 float32 fp_vdmpy(float16 a1, float16 a2, float16 a3, float16 a4,
@@ -21,4 +22,7 @@ float32 qf_min_sf(float32 a1, float32 a2, float_status *fp_status);
 float16 qf_max_hf(float16 a1, float16 a2, float_status *fp_status);
 float16 qf_min_hf(float16 a1, float16 a2, float_status *fp_status);
 
+int32_t conv_w_sf(float32 a, float_status *fp_status);
+int16_t conv_h_hf(float16 a, float_status *fp_status);
+
 #endif
diff --git a/target/hexagon/mmvec/hvx_ieee_fp.c b/target/hexagon/mmvec/hvx_ieee_fp.c
index 2ae79a485a..697f35b5ed 100644
--- a/target/hexagon/mmvec/hvx_ieee_fp.c
+++ b/target/hexagon/mmvec/hvx_ieee_fp.c
@@ -69,3 +69,21 @@ float16 qf_min_hf(float16 a1, float16 a2, float_status *fp_status)
     }
     return float16_min(a1, a2, fp_status);
 }
+
+int32_t conv_w_sf(float32 a, float_status *fp_status)
+{
+    /* float32_to_int32 converts any NaN to MAX, hexagon looks at the sign. */
+    if (float32_is_any_nan(a)) {
+        return float32_is_neg(a) ? INT32_MIN : INT32_MAX;
+    }
+    return float32_to_int32_round_to_zero(a, fp_status);
+}
+
+int16_t conv_h_hf(float16 a, float_status *fp_status)
+{
+    /* float16_to_int16 converts any NaN to MAX, hexagon looks at the sign. */
+    if (float16_is_any_nan(a)) {
+        return float16_is_neg(a) ? INT16_MIN : INT16_MAX;
+    }
+    return float16_to_int16_round_to_zero(a, fp_status);
+}
diff --git a/target/hexagon/imported/mmvec/encode_ext.def b/target/hexagon/imported/mmvec/encode_ext.def
index 72daf8724c..c1ed1b6c23 100644
--- a/target/hexagon/imported/mmvec/encode_ext.def
+++ b/target/hexagon/imported/mmvec/encode_ext.def
@@ -840,4 +840,22 @@ DEF_ENC(V6_vfneg_sf,"00011110--0-0110PP1uuuuu011ddddd")
 DEF_ENC(V6_vabs_hf,"00011110--0-0110PP1uuuuu100ddddd")
 DEF_ENC(V6_vabs_sf,"00011110--0-0110PP1uuuuu101ddddd")
 
+/* IEEE FP vcvt instructions */
+DEF_ENC(V6_vcvt_sf_hf,"00011110--0-0100PP1uuuuu100ddddd")
+DEF_ENC(V6_vcvt_hf_sf,"00011111011vvvvvPP1uuuuu001ddddd")
+DEF_ENC(V6_vcvt_hf_ub,"00011110--0-0100PP1uuuuu001ddddd")
+DEF_ENC(V6_vcvt_hf_b,"00011110--0-0100PP1uuuuu010ddddd")
+DEF_ENC(V6_vcvt_hf_uh,"00011110--0-0100PP1uuuuu101ddddd")
+DEF_ENC(V6_vcvt_hf_h,"00011110--0-0100PP1uuuuu111ddddd")
+DEF_ENC(V6_vcvt_uh_hf,"00011110--0--101PP1uuuuu000ddddd")
+DEF_ENC(V6_vcvt_h_hf,"00011110--0-0110PP1uuuuu000ddddd")
+DEF_ENC(V6_vcvt_ub_hf,"00011111110vvvvvPP1uuuuu101ddddd")
+DEF_ENC(V6_vcvt_b_hf,"00011111110vvvvvPP1uuuuu110ddddd")
+
+/* IEEE FP vconv instructions */
+DEF_ENC(V6_vconv_sf_w,"00011110--0--101PP1uuuuu011ddddd")
+DEF_ENC(V6_vconv_w_sf,"00011110--0--101PP1uuuuu001ddddd")
+DEF_ENC(V6_vconv_hf_h,"00011110--0--101PP1uuuuu100ddddd")
+DEF_ENC(V6_vconv_h_hf,"00011110--0--101PP1uuuuu010ddddd")
+
 #endif /* NO MMVEC */
diff --git a/target/hexagon/imported/mmvec/ext.idef b/target/hexagon/imported/mmvec/ext.idef
index 1b16ed0628..788ce1d2ae 100644
--- a/target/hexagon/imported/mmvec/ext.idef
+++ b/target/hexagon/imported/mmvec/ext.idef
@@ -63,6 +63,9 @@ ITERATOR_INSN_ANY_SLOT_DOUBLE_VEC(WIDTH,TAG,SYNTAX2,DESCR,CODE)
 EXTINSN(V6_##TAG, SYNTAX, ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VS),  \
 DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
 
+#define ITERATOR_INSN_SHIFT_SLOT_FLT(WIDTH,TAG,SYNTAX,DESCR,CODE) \
+EXTINSN(V6_##TAG, SYNTAX, ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VS,A_HVX_FLT),  \
+DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
 
 #define ITERATOR_INSN_SHIFT3_SLOT(WIDTH,TAG,SYNTAX,DESCR,CODE) \
 EXTINSN(V6_##TAG, SYNTAX, ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VS,A_CVI_VS_3SRC,A_NOTE_SHIFT_RESOURCE,A_NOTE_NOVP,A_NOTE_VA_UNARY),  \
@@ -3046,6 +3049,100 @@ ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vabs_hf,  "Vd32.hf=vabs(Vu32.hf)", \
 ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vabs_sf,  "Vd32.sf=vabs(Vu32.sf)", \
     "Vector IEEE abs: sf", VdV.sf[i] = float32_abs(VuV.sf[i]))
 
+/* Two pipes: P2 & P3, two outputs, 16-bit */
+#define ITERATOR_INSN_IEEE_FP_DOUBLE_16(WIDTH,TAG,SYNTAX,DESCR,CODE) \
+EXTINSN(V6_##TAG, SYNTAX, \
+ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX_DV,A_HVX_IEEE_FP_OUT_16), \
+DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
+
+/* Two pipes: P2 & P3, two outputs, 32-bit output */
+#define ITERATOR_INSN_IEEE_FP_DOUBLE_32(WIDTH,TAG,SYNTAX,DESCR,CODE) \
+EXTINSN(V6_##TAG, SYNTAX, \
+    ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX_DV,A_HVX_IEEE_FP_OUT_32), \
+    DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
+
+/* Single pipe, 16-bit output */
+#define ITERATOR_INSN_IEEE_FP_16(WIDTH,TAG,SYNTAX,DESCR,CODE) \
+EXTINSN(V6_##TAG, SYNTAX, \
+    ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX,A_HVX_IEEE_FP_OUT_16), \
+    DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
+
+/* single pipe, output can feed 16- or 32-bit accumulate */
+#define ITERATOR_INSN_IEEE_FP_16_32(WIDTH,TAG,SYNTAX,DESCR,CODE) \
+EXTINSN(V6_##TAG, SYNTAX, \
+    ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX,A_HVX_IEEE_FP_OUT_16,A_HVX_IEEE_FP_OUT_32), \
+    DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
+
+/******************************************************************************
+ * IEEE FP convert instructions
+ ******************************************************************************/
+
+ITERATOR_INSN_IEEE_FP_DOUBLE_16(32,  vcvt_hf_ub, "Vdd32.hf=vcvt(Vu32.ub)",
+    "Vector IEEE cvt from int: ub widen to hf",
+    VddV.v[0].hf[2*i]   = uint64_to_float16_scalbn(VuV.ub[4*i], float_round_nearest_even, 0);
+    VddV.v[0].hf[2*i+1] = uint64_to_float16_scalbn(VuV.ub[4*i+1], float_round_nearest_even, 0);
+    VddV.v[1].hf[2*i]   = uint64_to_float16_scalbn(VuV.ub[4*i+2], float_round_nearest_even, 0);
+    VddV.v[1].hf[2*i+1] = uint64_to_float16_scalbn(VuV.ub[4*i+3], float_round_nearest_even, 0))
+
+ITERATOR_INSN_IEEE_FP_DOUBLE_16(32,  vcvt_hf_b,  "Vdd32.hf=vcvt(Vu32.b)",
+    "Vector IEEE cvt from int: b widen to hf",
+    VddV.v[0].hf[2*i]   = int64_to_float16_scalbn(VuV.b[4*i], float_round_nearest_even, 0);
+    VddV.v[0].hf[2*i+1] = int64_to_float16_scalbn(VuV.b[4*i+1], float_round_nearest_even, 0);
+    VddV.v[1].hf[2*i]   = int64_to_float16_scalbn(VuV.b[4*i+2], float_round_nearest_even, 0);
+    VddV.v[1].hf[2*i+1] = int64_to_float16_scalbn(VuV.b[4*i+3], float_round_nearest_even, 0))
+
+ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vcvt_sf_hf, "Vdd32.sf=vcvt(Vu32.hf)",
+    "Vector IEEE cvt: hf widen to sf",
+    VddV.v[0].sf[i] = f16_to_f32(VuV.hf[2*i]);
+    VddV.v[1].sf[i] = f16_to_f32(VuV.hf[2*i+1]))
+
+ITERATOR_INSN_IEEE_FP_16(16,    vcvt_hf_uh, "Vd32.hf=vcvt(Vu32.uh)",
+    "Vector IEEE cvt from int: uh to hf",
+    VdV.hf[i] = uint64_to_float16_scalbn(VuV.uh[i], float_round_nearest_even, 0))
+ITERATOR_INSN_IEEE_FP_16(16,    vcvt_hf_h,  "Vd32.hf=vcvt(Vu32.h)",
+    "Vector IEEE cvt from int: h to hf",
+    VdV.hf[i] = int64_to_float16_scalbn(VuV.h[i], float_round_nearest_even, 0))
+ITERATOR_INSN_IEEE_FP_16_32(16, vcvt_uh_hf, "Vd32.uh=vcvt(Vu32.hf)",
+    "Vector IEEE cvt to int: hf to uh",
+    VdV.uh[i] = float16_to_uint16_scalbn(VuV.hf[i], float_round_nearest_even, 0, &env->hvx_fp_status))
+ITERATOR_INSN_IEEE_FP_16_32(16, vcvt_h_hf,  "Vd32.h=vcvt(Vu32.hf)",
+    "Vector IEEE cvt to int: hf to h",
+    VdV.h[i]  = float16_to_int16_scalbn(VuV.hf[i], float_round_nearest_even, 0, &env->hvx_fp_status))
+
+ITERATOR_INSN_IEEE_FP_16(32, vcvt_hf_sf, "Vd32.hf=vcvt(Vu32.sf,Vv32.sf)",
+    "Vector IEEE cvt: sf to hf",
+    VdV.hf[2*i]   = f32_to_f16(VuV.sf[i]);
+    VdV.hf[2*i+1] = f32_to_f16(VvV.sf[i]))
+
+ITERATOR_INSN_IEEE_FP_16_32(32, vcvt_ub_hf, "Vd32.ub=vcvt(Vu32.hf,Vv32.hf)", "Vector cvt to int: hf narrow to ub",
+    VdV.ub[4*i]   = float16_to_uint8_scalbn(VuV.hf[2*i], float_round_nearest_even, 0, &env->hvx_fp_status);
+    VdV.ub[4*i+1] = float16_to_uint8_scalbn(VuV.hf[2*i+1], float_round_nearest_even, 0, &env->hvx_fp_status);
+    VdV.ub[4*i+2] = float16_to_uint8_scalbn(VvV.hf[2*i], float_round_nearest_even, 0, &env->hvx_fp_status);
+    VdV.ub[4*i+3] = float16_to_uint8_scalbn(VvV.hf[2*i+1], float_round_nearest_even, 0, &env->hvx_fp_status))
+
+ITERATOR_INSN_IEEE_FP_16_32(32, vcvt_b_hf,  "Vd32.b=vcvt(Vu32.hf,Vv32.hf)",
+    "Vector cvt to int: hf narrow to b",
+    VdV.b[4*i]   = float16_to_int8_scalbn(VuV.hf[2*i], float_round_nearest_even, 0, &env->hvx_fp_status);
+    VdV.b[4*i+1] = float16_to_int8_scalbn(VuV.hf[2*i+1], float_round_nearest_even, 0, &env->hvx_fp_status);
+    VdV.b[4*i+2] = float16_to_int8_scalbn(VvV.hf[2*i], float_round_nearest_even, 0, &env->hvx_fp_status);
+    VdV.b[4*i+3] = float16_to_int8_scalbn(VvV.hf[2*i+1], float_round_nearest_even, 0, &env->hvx_fp_status))
+
+ITERATOR_INSN_SHIFT_SLOT_FLT(32, vconv_w_sf,"Vd32.w=Vu32.sf",
+    "Vector conversion of sf32 format to int w",
+    VdV.w[i] = conv_w_sf(VuV.sf[i], &env->hvx_fp_status))
+
+ITERATOR_INSN_SHIFT_SLOT_FLT(16, vconv_h_hf,"Vd32.h=Vu32.hf",
+    "Vector conversion of hf16 format to int hw",
+    VdV.h[i] = conv_h_hf(VuV.hf[i], &env->hvx_fp_status))
+
+ITERATOR_INSN_SHIFT_SLOT_FLT(32, vconv_sf_w,"Vd32.sf=Vu32.w",
+    "Vector conversion of int w format to sf32",
+    VdV.sf[i] = int32_to_float32(VuV.w[i], &env->hvx_fp_status))
+
+ITERATOR_INSN_SHIFT_SLOT_FLT(16, vconv_hf_h,"Vd32.hf=Vu32.h",
+    "Vector conversion of int hw format to hf16",
+    VdV.hf[i] = float16_val(int16_to_float16(VuV.h[i], &env->hvx_fp_status)))
+
 /******************************************************************************
  DEBUG Vector/Register Printing
  ******************************************************************************/
-- 
2.37.2


