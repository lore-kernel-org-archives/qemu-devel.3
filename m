Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E73CD3940D
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 10:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8FbS-0005UX-VM; Thu, 02 Apr 2026 06:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8Fan-0004kb-Dh
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:48:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8Fah-0007pG-LQ
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:48:01 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6326cHLh1966350
 for <qemu-devel@nongnu.org>; Thu, 2 Apr 2026 10:47:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Z86RJd9yRDm
 73chbLTrBdQ3pbt8HT4DpM1gyCHvPTUI=; b=ZHQb1KPTbECnGaanEBNGBXC3f01
 jFandQa8dXjS7MIGWX67RQmUd9NsmJdixJETD0GfTxmDeVhF2XiQO/Hit/tHOlG2
 lc66+DKfqRoPzpT39kHvUQaUBrBEaezLYpMqjBZUA1GcoUGl2uu1haE8ThJQ8b+v
 RJstM1IAtYaDPQ/MepnilNAXiUPu03uYJ7Bp8vndjICzCxv6tgpDz7fjkR6J539C
 V5kfQYuhGokS2ahGrvv3RI55jcKP/NIglNnP8vIG18IViZy4Su1hBodHnuReyltL
 GpzcvKb+SBP1TTNSj40264WmmRbOIQe8wE9nh+MOm7mr3VO4f5Xpf7Ff5kQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9b9h2pkw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 10:47:47 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2c4cfe08c9dso4683939eec.1
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 03:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775126867; x=1775731667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z86RJd9yRDm73chbLTrBdQ3pbt8HT4DpM1gyCHvPTUI=;
 b=hLI3iksSNkBfnEpNGNLuWdpRGUhX3KK6y/Acgl9K7Qor+3Gs2yf/wSE893FOWoInoo
 tHZ/izbgrgnEwTkLD6tjK46pSsVkk1jlj2H0PF5Y7Ke31tfsC6Y/bN7AYf7jmgU9oQWF
 2KBUDT1rpjWU5/w2c6SU+VqGdNKCUA47re6+3PIGr1IMIgLorVZrzNP5ie5zg2+CDhV4
 iJw/4YwLRc8qImO6PkTyxfM1hHM+LFJ8i34JC0nAlYms7QmcFLPT93KfJJu6a+Dltt8r
 1cIn3OI+OwWDnyAOlsiIqOK9vrwgEeBEIHgKLeLv/iE8EBy1rhX51XfF+HdFNUQ8BDn4
 EjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775126867; x=1775731667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z86RJd9yRDm73chbLTrBdQ3pbt8HT4DpM1gyCHvPTUI=;
 b=WTFCZPt32mg+3kr/t66dRKqEYkJq2lNEvg7fWMEm3aGf+jElRNIgJG0YVznpMJp3xp
 NA8cUolEyC4YyIxqflERJ+TaHePjhGO84wrjZL4RxaVFHZKLGo5Vhcop2ZmTqYuU1IH0
 TPVxXDmz7z0jO7YYFGtARn50Ob4W4fI2BoZYqa8eoF7Sor0t/eewUTLLnPUwukTU5SwP
 ih3IteFutfV10Sq2qOzcbu+0oe/rkSUs00N+A010QRNCdMqB6dNmhG8X4Io61/H7sPlB
 gSzsbo+6vH0IWdoBpaF8RGgeN6hpTeqAtJfjX9+XOjfRPMocLGA5fN0e31xxYJRT0iG9
 7YFA==
X-Gm-Message-State: AOJu0YzPn45KmLp+aV/6VePgHezFK6hFZiKRuzCiXaQqGvsRSOqBr2mF
 dn5wREmRIZLdc3/J0nsVpUCzuqllXAhVflupu63SgxFgnkiC/Q7v8Jh1ufdiD0vrI3jTRMzl8nU
 d3Xl4N4RwoGK9txnIB7lRGjogyu3mDCGOVGHGnU0M0rY/DVhlThZze0MbcfP6gXE1hrUw
X-Gm-Gg: ATEYQzzV7QJEFqjVZYvjsp2s614Z5CSrevM5PPhDL06d+Wu+Tl5wxYYiI3lckCfPiGZ
 bdQFZf6omUo7FfTzpHo8l0RyWLZZ1MV8pt7HwiqtpxydAyNU99dKUhIqn3gsDWlteXE0apZ04DL
 yudn435EGBfr62XHttDT7WzbwfM7tFKaq8/dJp3DbnzOledsvf6ft5gW5Z6/F7oaWd21MvCycgu
 dVR4H6j9d+Z1fvoy/eQXXWtEtN9RtL81g+ARpgluIW6FQWFEuZzSNiMMtZq8nFTLAJyMkFoUgi8
 eexnBAWB/r5Xg8P8BH0ohdGvjX9o5FGibCytF65jmwawlvpF+O02FU59rCVMdActJDqWDq1NUfH
 wZPY4vf/hHNujzxo32V2W44Lo8egbGYQwZjV+tC33jq4CTmZ08RL1sJb04WaA5DZ3ieGN/K4kJ8
 IwCsbIIe49
X-Received: by 2002:a05:7300:fd0b:b0:2c1:14ca:7c86 with SMTP id
 5a478bee46e88-2c932db3e06mr3601625eec.32.1775126867036; 
 Thu, 02 Apr 2026 03:47:47 -0700 (PDT)
X-Received: by 2002:a05:7300:fd0b:b0:2c1:14ca:7c86 with SMTP id
 5a478bee46e88-2c932db3e06mr3601605eec.32.1775126866527; 
 Thu, 02 Apr 2026 03:47:46 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca7d00f5easm2004783eec.29.2026.04.02.03.47.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 03:47:46 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v2 11/16] target/hexagon: add v73 HVX IEEE bfloat16 insns
Date: Thu,  2 Apr 2026 03:47:28 -0700
Message-Id: <d3dc083b191097dd8f2adee473b328f1321d91a8.1775122853.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TqLrRTXh c=1 sm=1 tr=0 ts=69ce4954 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=mMeFUOTstzKuDvyCm9AA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: BTJGmrKy-wtWZ9NFhMDAmNN_F0EG28fP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA5NyBTYWx0ZWRfXyCGXoNZUeZxO
 BA2hlR7Af2e2KM26udsSzhU9yW0tQOqTdIVoMQmSBpNACEI3wrfgHQdkif//I7DlzkNrGHd1oC6
 pxTya5aBuTTuFRFWua89muPlD4kuBHXD78lG14lRX0DmiUETr1sWdS89+gZSoYAz0W0JMm94nM9
 lmlvWavieaJLxC+JfpTJCx2WOvmbpoP1ZBkKKge/HknOPqvhSmPqiOrvxsML5IQ+fRY8QjqbwOE
 bTnr5YqbDsG8AkmVfXltV+vpxQOrgCrBiAm1XiopdtUgZW30Oyf+M36hiPrbW2aVU53rDl9zlk8
 hWBR+wt/irQT1VQPHn/YpaY/jb48i7prduuY26JqMRUfQqpv62Fcao9WpYWjtjGaF2e50uTHO9Z
 O6Xy7GD5BK++BpFA/dd1Yymm4v5/I02ltYAsNpD6uO6U8uz9qJuh1KB/6bBg1V6EUopuCEdhO6n
 gSdBb4PVq+8mrkc+D9A==
X-Proofpoint-GUID: BTJGmrKy-wtWZ9NFhMDAmNN_F0EG28fP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020097
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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

Add HVX IEEE bfloat16 (bf16) instructions:

Arithmetic operations:
- V6_vadd_sf_bf, V6_vsub_sf_bf: add/sub bf16 widening to sf output
- V6_vmpy_sf_bf: multiply bf16 widening to sf output
- V6_vmpy_sf_bf_acc: multiply-accumulate bf16 widening to sf output

Min/Max operations:
- V6_vmin_bf, V6_vmax_bf: bf16 min/max

Comparison operations:
- V6_vgtbf: greater-than compare
- V6_vgtbf_and, V6_vgtbf_or, V6_vgtbf_xor: predicate variants

Conversion operations:
- V6_vcvt_bf_sf: convert sf to bf16

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/mmvec/hvx_ieee_fp.h           | 44 ++++++++++++++
 target/hexagon/mmvec/macros.h                |  4 ++
 target/hexagon/mmvec/mmvec.h                 |  1 +
 target/hexagon/mmvec/hvx_ieee_fp.c           |  4 ++
 target/hexagon/imported/mmvec/encode_ext.def | 15 +++++
 target/hexagon/imported/mmvec/ext.idef       | 64 ++++++++++++++++++++
 6 files changed, 132 insertions(+)

diff --git a/target/hexagon/mmvec/hvx_ieee_fp.h b/target/hexagon/mmvec/hvx_ieee_fp.h
index b68d6db23e..0ca529b627 100644
--- a/target/hexagon/mmvec/hvx_ieee_fp.h
+++ b/target/hexagon/mmvec/hvx_ieee_fp.h
@@ -81,4 +81,48 @@ int16_t conv_hf_h(int16_t a, float_status *fp_status);
 int32_t conv_w_sf(uint32_t a, float_status *fp_status);
 int16_t conv_h_hf(uint16_t a, float_status *fp_status);
 
+/* IEEE BFloat instructions */
+
+#define fp_mult_sf_bf(A, B) \
+    fp_mult_sf_sf(bfloat16_to_float32(A, &env->hvx_fp_status), \
+                  bfloat16_to_float32(B, &env->hvx_fp_status), \
+                  &env->hvx_fp_status)
+#define fp_add_sf_bf(A, B) \
+    fp_add_sf_sf(bfloat16_to_float32(A, &env->hvx_fp_status), \
+                 bfloat16_to_float32(B, &env->hvx_fp_status), \
+                 &env->hvx_fp_status)
+#define fp_sub_sf_bf(A, B) \
+    fp_sub_sf_sf(bfloat16_to_float32(A, &env->hvx_fp_status), \
+                 bfloat16_to_float32(B, &env->hvx_fp_status), \
+                 &env->hvx_fp_status)
+
+uint32_t fp_mult_sf_bf_acc(uint16_t op1, uint16_t op2, uint32_t acc,
+                           float_status *fp_status);
+
+#define bf_to_sf(A, fp_status) bfloat16_to_float32(A, fp_status)
+
+static inline uint16_t sf_to_bf(int32_t A, float_status *fp_status)
+{
+    uint32_t rslt = A;
+    if ((rslt & 0x1FFFF) == 0x08000) {
+        /* do not round up if exactly .5 and even already */
+    } else if ((rslt & 0x8000) == 0x8000) {
+        rslt += 0x8000; /* rounding to nearest number */
+    }
+    rslt = float32_is_any_nan(A) ? FP32_DEF_NAN : rslt;
+    return float32_to_bfloat16(rslt, fp_status);
+}
+
+#define fp_min_bf(A, B) \
+    sf_to_bf(fp_min_sf(bf_to_sf(A, &env->hvx_fp_status), \
+                       bf_to_sf(B, &env->hvx_fp_status), \
+                       &env->hvx_fp_status), \
+             &env->hvx_fp_status);
+
+#define fp_max_bf(A, B) \
+    sf_to_bf(fp_max_sf(bf_to_sf(A, &env->hvx_fp_status), \
+                       bf_to_sf(B, &env->hvx_fp_status), \
+                       &env->hvx_fp_status), \
+             &env->hvx_fp_status);
+
 #endif
diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.h
index 318d44efb7..4945a61194 100644
--- a/target/hexagon/mmvec/macros.h
+++ b/target/hexagon/mmvec/macros.h
@@ -25,6 +25,9 @@
 #include "accel/tcg/probe.h"
 #include "mmvec/hvx_ieee_fp.h"
 
+#define fBFLOAT()
+#define fCVI_VX_NO_TMP_LD()
+
 #ifndef QEMU_GENERATE
 #define VdV      (*(MMVector *restrict)(VdV_void))
 #define VsV      (*(MMVector *restrict)(VsV_void))
@@ -358,5 +361,6 @@
 
 #define fCMPGT_SF(A, B) cmpgt_sf(A, B, &env->hvx_fp_status)
 #define fCMPGT_HF(A, B) cmpgt_hf(A, B, &env->hvx_fp_status)
+#define fCMPGT_BF(A, B) fCMPGT_SF((uint32_t)(A) << 16, (uint32_t)(B) << 16)
 
 #endif
diff --git a/target/hexagon/mmvec/mmvec.h b/target/hexagon/mmvec/mmvec.h
index eaedfe0d6d..9d8d57c7c6 100644
--- a/target/hexagon/mmvec/mmvec.h
+++ b/target/hexagon/mmvec/mmvec.h
@@ -40,6 +40,7 @@ typedef union {
     int8_t    b[MAX_VEC_SIZE_BYTES / 1];
     int32_t  sf[MAX_VEC_SIZE_BYTES / 4];   /* single float (32-bit) */
     int16_t  hf[MAX_VEC_SIZE_BYTES / 2];   /* half float (16-bit) */
+    uint16_t bf[MAX_VEC_SIZE_BYTES / 2];   /* bfloat16 */
 } MMVector;
 
 typedef union {
diff --git a/target/hexagon/mmvec/hvx_ieee_fp.c b/target/hexagon/mmvec/hvx_ieee_fp.c
index 131d8e5595..9e2cff2ef7 100644
--- a/target/hexagon/mmvec/hvx_ieee_fp.c
+++ b/target/hexagon/mmvec/hvx_ieee_fp.c
@@ -269,3 +269,7 @@ uint16_t cmpgt_hf(uint16_t a1, uint16_t a2, float_status *fp_status)
     }
     return float16_compare(a1, a2, fp_status) == float_relation_greater;
 }
+
+DEF_FP_INSN_3(mult_sf_bf_acc, 32, 16, 16, 32,
+              float32_muladd(bf_to_sf(f1, fp_status), bf_to_sf(f2, fp_status),
+                             f3, 0, fp_status))
diff --git a/target/hexagon/imported/mmvec/encode_ext.def b/target/hexagon/imported/mmvec/encode_ext.def
index 3572e4de4c..16f043b77d 100644
--- a/target/hexagon/imported/mmvec/encode_ext.def
+++ b/target/hexagon/imported/mmvec/encode_ext.def
@@ -868,4 +868,19 @@ DEF_ENC(V6_vgthf_or,"00011100100vvvvvPP1uuuuu001101xx")
 DEF_ENC(V6_vgtsf_xor,"00011100100vvvvvPP1uuuuu111010xx")
 DEF_ENC(V6_vgthf_xor,"00011100100vvvvvPP1uuuuu111011xx")
 
+/* BFLOAT instructions */
+DEF_ENC(V6_vmpy_sf_bf,"00011101010vvvvvPP1uuuuu100ddddd")
+DEF_ENC(V6_vmpy_sf_bf_acc,"00011101000vvvvvPP1uuuuu000xxxxx")
+DEF_ENC(V6_vadd_sf_bf,"00011101010vvvvvPP1uuuuu110ddddd")
+DEF_ENC(V6_vsub_sf_bf,"00011101010vvvvvPP1uuuuu101ddddd")
+DEF_ENC(V6_vmax_bf,"00011101010vvvvvPP1uuuuu111ddddd")
+DEF_ENC(V6_vmin_bf,"00011101010vvvvvPP1uuuuu000ddddd")
+DEF_ENC(V6_vcvt_bf_sf,"00011101010vvvvvPP1uuuuu011ddddd")
+
+/* BFLOAT compare instructions */
+DEF_ENC(V6_vgtbf,"00011100100vvvvvPP1uuuuu011110dd")
+DEF_ENC(V6_vgtbf_and,"00011100100vvvvvPP1uuuuu110100xx")
+DEF_ENC(V6_vgtbf_or,"00011100100vvvvvPP1uuuuu001110xx")
+DEF_ENC(V6_vgtbf_xor,"00011100100vvvvvPP1uuuuu111100xx")
+
 #endif /* NO MMVEC */
diff --git a/target/hexagon/imported/mmvec/ext.idef b/target/hexagon/imported/mmvec/ext.idef
index 6f01a9d48f..aaae2d90e1 100644
--- a/target/hexagon/imported/mmvec/ext.idef
+++ b/target/hexagon/imported/mmvec/ext.idef
@@ -3155,6 +3155,15 @@ ITERATOR_INSN_SHIFT_SLOT_FLT(16, vconv_hf_h,"Vd32.hf=Vu32.h",
     } \
 }
 
+#define VCMPGT_BF(DEST, ASRC, ASRCOP, CMP, N, SRC, MASK, WIDTH) \
+{ \
+    fBFLOAT(); \
+    for (fHIDE(int) i = 0; i < fVBYTES(); i += WIDTH) { \
+        fHIDE(int) VAL = fCMPGT_BF(VuV.SRC[i/WIDTH],VvV.SRC[i/WIDTH]) ? MASK : 0; \
+        fSETQBITS(DEST,WIDTH,MASK,i,ASRC ASRCOP VAL); \
+    } \
+}
+
 /* Vector SF compare */
 #define MMVEC_CMPGT_SF(TYPE,TYPE2,DESCR,N,MASK,WIDTH,SRC) \
     EXTINSN(V6_vgt##TYPE##_and, "Qx4&=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
@@ -3193,8 +3202,63 @@ ITERATOR_INSN_SHIFT_SLOT_FLT(16, vconv_hf_h,"Vd32.hf=Vu32.h",
         DESCR" greater than", \
         VCMPGT_HF(QdV, , , ">", N, SRC, MASK, WIDTH))
 
+/* Vector BF compare */
+#define MMVEC_CMPGT_BF(TYPE,TYPE2,DESCR,N,MASK,WIDTH,SRC) \
+    EXTINSN(V6_vgt##TYPE##_and, "Qx4&=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")",\
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than with predicate-and", \
+        VCMPGT_BF(QxV, fGETQBITS(QxV,WIDTH,MASK,i), &, ">", N, SRC, MASK, WIDTH)) \
+    EXTINSN(V6_vgt##TYPE##_xor, "Qx4^=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than with predicate-xor", \
+        VCMPGT_BF(QxV, fGETQBITS(QxV,WIDTH,MASK,i), ^, ">", N, SRC, MASK, WIDTH)) \
+    EXTINSN(V6_vgt##TYPE##_or, "Qx4|=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than with predicate-or", \
+        VCMPGT_BF(QxV, fGETQBITS(QxV,WIDTH,MASK,i), |, ">", N, SRC, MASK, WIDTH)) \
+    EXTINSN(V6_vgt##TYPE, "Qd4=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than", \
+        VCMPGT_BF(QdV, , , ">", N, SRC, MASK, WIDTH))
+
 MMVEC_CMPGT_SF(sf,"sf","Vector sf Compare ", fVELEM(32), 0xF, 4, sf)
 MMVEC_CMPGT_HF(hf,"hf","Vector hf Compare ", fVELEM(16), 0x3, 2, hf)
+MMVEC_CMPGT_BF(bf,"bf","Vector bf Compare ", fVELEM(16), 0x3, 2, bf)
+
+/******************************************************************************
+ BFloat arithmetic and max/min instructions
+ ******************************************************************************/
+
+ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vadd_sf_bf,
+    "Vdd32.sf=vadd(Vu32.bf,Vv32.bf)",  "Vector IEEE add: bf widen to sf",
+    VddV.v[0].sf[i] = fp_add_sf_bf(VuV.bf[2*i], VvV.bf[2*i]);
+    VddV.v[1].sf[i] = fp_add_sf_bf(VuV.bf[2*i+1], VvV.bf[2*i+1]); fBFLOAT())
+ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vsub_sf_bf,
+    "Vdd32.sf=vsub(Vu32.bf,Vv32.bf)",  "Vector IEEE sub: bf widen to sf",
+    VddV.v[0].sf[i] = fp_sub_sf_bf(VuV.bf[2*i], VvV.bf[2*i]);
+    VddV.v[1].sf[i] = fp_sub_sf_bf(VuV.bf[2*i+1], VvV.bf[2*i+1]); fBFLOAT())
+ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vmpy_sf_bf,
+    "Vdd32.sf=vmpy(Vu32.bf,Vv32.bf)",  "Vector IEEE mul: hf widen to sf",
+    VddV.v[0].sf[i] = fp_mult_sf_bf(VuV.bf[2*i], VvV.bf[2*i]);
+    VddV.v[1].sf[i] = fp_mult_sf_bf(VuV.bf[2*i+1], VvV.bf[2*i+1]); fBFLOAT())
+ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vmpy_sf_bf_acc,
+    "Vxx32.sf+=vmpy(Vu32.bf,Vv32.bf)", "Vector IEEE fma: hf widen to sf",
+    VxxV.v[0].sf[i] = fp_mult_sf_bf_acc(VuV.bf[2*i], VvV.bf[2*i],
+                                        VxxV.v[0].sf[i], &env->hvx_fp_status);
+    VxxV.v[1].sf[i] = fp_mult_sf_bf_acc(VuV.bf[2*i+1], VvV.bf[2*i+1],
+                                        VxxV.v[1].sf[i], &env->hvx_fp_status);
+    fCVI_VX_NO_TMP_LD(); fBFLOAT())
+ITERATOR_INSN_IEEE_FP_16(32, vcvt_bf_sf,
+    "Vd32.bf=vcvt(Vu32.sf,Vv32.sf)",   "Vector IEEE cvt: sf to bf",
+    VdV.bf[2*i]   = sf_to_bf(VuV.sf[i], &env->hvx_fp_status);
+    VdV.bf[2*i+1] = sf_to_bf(VvV.sf[i], &env->hvx_fp_status); fBFLOAT())
+
+ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vmax_bf, "Vd32.bf=vmax(Vu32.bf,Vv32.bf)",
+    "Vector IEEE max: bf", VdV.bf[i] = fp_max_bf(VuV.bf[i], VvV.bf[i]);
+    fBFLOAT())
+ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vmin_bf, "Vd32.bf=vmin(Vu32.bf,Vv32.bf)",
+    "Vector IEEE max: bf", VdV.bf[i] = fp_min_bf(VuV.bf[i], VvV.bf[i]);
+    fBFLOAT())
 
 /******************************************************************************
  DEBUG Vector/Register Printing
-- 
2.37.2


