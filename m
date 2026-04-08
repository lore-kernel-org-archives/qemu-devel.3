Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F00A10F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYCa-0001Qp-60; Wed, 08 Apr 2026 15:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAYCQ-0001O9-1A
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:04:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAVu7-0006ph-8R
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:37:25 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638Fs3Ti1924490
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 16:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=TZUvyFs0LMu
 cxealilFRfwo6HJ2f5iAQ5AEToHBFgnI=; b=CRvIf/fOk0F/PmdQEBuHH/hsunO
 p0hCsRbekAvpDz6u7LiXuoEV9iZ4acH3yUwLrDs9te9BE99ZC9Slm8Yc7+GpR3vH
 QoMa/HPK8JkPBImDHhBX2/nSmvhWDD4K+rpkn8W1p6p6LLtILd1J6U6YydoCfIlL
 9Hq0pJVfgwgon7FtI/ORm1N1bg6Ra6ZIIqW5Z29NxCl9lL9jLO/EsqE3kyaRvuWq
 pZYKYYwyQ8frUVe5lRSWqBr3W9sKed7T+v812vpfO9jBMpsjjT9yCEr5iiuAiLpY
 5Mg78mEpu1fsXPB9/RtPR8Obu+Q/geox/wTDjYc0HMOHmV0ZI2UyrgaIC8Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddt28r5aa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 16:37:21 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b630753cc38so138289a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 09:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775666241; x=1776271041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TZUvyFs0LMucxealilFRfwo6HJ2f5iAQ5AEToHBFgnI=;
 b=YHkuMFrpFlh/Rj49RQCHGYlAIbtwORml1WvjLKgNsiZvmarIT80QoV5IoI98UD6hR4
 xmG1dqkTRlgLFQ8lhexs6C/VODxKtqQwbSl1frbBG/lann4H9uiMfavbqesVydrgPvZ5
 uly3VLNbzWF+QtgHANi1cbJ9NvdN7i3HSSfjpD18A91C2rihQgMjCEV+khB4Kv8OaMPw
 97JfmUc7dcjGW46xtKQguUcpIEbuM5sR2Ypi/qWUdnWBIPEa4LTS27YVcYs3E09ToCp8
 Fo98iz6nGS3Kj+I2P7UijGAryWStoYqKUi/O3u1mB9M5tevwei+OiitpUbLjBCEiScZf
 pbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775666241; x=1776271041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TZUvyFs0LMucxealilFRfwo6HJ2f5iAQ5AEToHBFgnI=;
 b=JQvci2BbmUTHoqm1u+q5x4Q6QZpV08VsKEwoPKXq03C4dcRzle1gsLfjf26rDyNI/0
 +LbRQSdmHiDQ0wplzKgXQBQabSvFKw4bb060GKOq0egRKUQ3+aJqKXSGqHu26ZkN4H+s
 0dQhOTyC1bqwpfR1KTHOFe21bZBlvvKea7E2On4m5Q7eiZ8g2WR3rqZ9duWRR5C78br8
 3mpvKdd7DHco5JtAzeOazPqv7K2DjIz/5AWhLezFfeUg2xgXoFAbbDz0bg76wIBWx54j
 Q5I9oc4Hz7EMTQZDsdeQ/fByfqIaLjwJfgwoT95DNAXiNqA/ZIRasLxir6O2rl2IQW/Q
 E3iA==
X-Gm-Message-State: AOJu0Yz9ohF3HQItHvtx2LKvb0rfWVuxS1rTN9HXbPV8/eYc/rMXzFUe
 bIWzJFw3/6xbhvpoQcq5ydWmEhvczI6jr6QvAtY29Hel3XV9h0xjHmgSE8U5YdLJbqO8i5kOrf/
 J0N0zWI465hj75zpQXdehJ+L1vEm7kUObRmKAfY5/5FHPz6X+wx0hkzqKpq1/V52mCv9z
X-Gm-Gg: AeBDievd3JqlRHqorx1OhZKvaAakSrHid1JfCpXElM/HzbaL5pfHAnFmnexNt+CYHmV
 cD0ugBaX6/bvtXtUNvdonaAhNtJdtehRH41QgVWMv19SnNdB0bwkE6qIkKm2eH+zQQTSySn/eme
 oSvm3GtUyOsl3Fch9ecNV1O+ZAkYzvggpWQNWbSC69Gs9CLLdDOQYl3WnikSvmak6cITZvJawkP
 w8SefaLwaxK0esan2oUUR7LqyaQU0KUYBHDKnYu4u+MHkx4NlA8qBsB2bWd1Kuyj+jeqncHcr7x
 ekIsKjPk3YdsikKXIagMHg8Qvt6oq3J7pwOyj56Bq6vUk6+YsmL5If4/Zt/C2u0oQyMtVhC+IvM
 6MBIPHSLMdlVGYnT/Ipngc9Ok2rcuV6xE4LnEvZ7rlrxgyaYZVlxuEifPchAc2CBPr6MC1qJJLU
 m9vJPgwA4T
X-Received: by 2002:a05:7022:61f:b0:12a:6c7e:bef9 with SMTP id
 a92af1059eb24-12bfb6fb39dmr11627227c88.9.1775666240279; 
 Wed, 08 Apr 2026 09:37:20 -0700 (PDT)
X-Received: by 2002:a05:7022:61f:b0:12a:6c7e:bef9 with SMTP id
 a92af1059eb24-12bfb6fb39dmr11627196c88.9.1775666239562; 
 Wed, 08 Apr 2026 09:37:19 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c1ff43d04sm4082006c88.4.2026.04.08.09.37.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:37:18 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v3 10/16] target/hexagon: add v68 HVX IEEE float compare insns
Date: Wed,  8 Apr 2026 09:37:01 -0700
Message-Id: <9518dd95bde0a79b7d74bf1f2a15577bfaadb976.1775665981.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: p59yCA-lJZkBBDHp2XIKUfxk86WRjjgD
X-Authority-Analysis: v=2.4 cv=fIIJG5ae c=1 sm=1 tr=0 ts=69d68441 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=JuoMN6qKTgbS_bYW1w0A:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE1NCBTYWx0ZWRfX7rclfm8bJo1y
 KiunQLM9KyiiMiix7NDgBJXv8+7Rq1XohCm5fEo0C40byW3pxtNC42AK+Y09xGR/L3N3EHvBmQS
 HK4bZ0le0mfnVjKoeRuRyR1WIuCAQDAUzX7EGQIU4rrJKxF6C9JfOUG5bc7lG32/RL5KgzIzGIK
 zOIlgZDztB1u5ifG7uGBtd1Gam5+C5dI6uAg1Fo7K0sD9iQJv6Ike3vZn5SWqSbURC35M80jpOs
 MbpHnOXYIKNdPjVqPTBLYvomuT5OXsvptEvWzWuvAJK2VQ9lzj/m67YhbRs/OdXr3Vdvu6U1qJx
 POlGws4lMn0ENmmO3+SW9El+7/ym4qqSLN5Jdn9Gv1SypisttiwtqEddslhCsf+4HYv6HMXndYl
 oU2t2DotKHlwe0iTFu6xB8magHWRGQuqU8nKV/EEtnntM4dI7YAT9/d08dUDEpY2TPNCyQOZR/y
 23qtYkBvYNNBkHs/K0A==
X-Proofpoint-GUID: p59yCA-lJZkBBDHp2XIKUfxk86WRjjgD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080154
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

Add HVX IEEE floating-point compare instructions:
- V6_vgthf, V6_vgtsf: greater-than compare
- V6_vgthf_and, V6_vgtsf_and: greater-than with predicate-and
- V6_vgthf_or, V6_vgtsf_or: greater-than with predicate-or
- V6_vgthf_xor, V6_vgtsf_xor: greater-than with predicate-xor

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/mmvec/hvx_ieee_fp.h           |  4 ++
 target/hexagon/mmvec/macros.h                |  3 +
 target/hexagon/mmvec/hvx_ieee_fp.c           | 48 +++++++++++++++
 target/hexagon/imported/mmvec/encode_ext.def | 10 ++++
 target/hexagon/imported/mmvec/ext.idef       | 61 ++++++++++++++++++++
 5 files changed, 126 insertions(+)

diff --git a/target/hexagon/mmvec/hvx_ieee_fp.h b/target/hexagon/mmvec/hvx_ieee_fp.h
index d55837b756..ad854b905d 100644
--- a/target/hexagon/mmvec/hvx_ieee_fp.h
+++ b/target/hexagon/mmvec/hvx_ieee_fp.h
@@ -25,4 +25,8 @@ uint16_t qf_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
 int32_t conv_w_sf(float32 a, float_status *fp_status);
 int16_t conv_h_hf(float16 a, float_status *fp_status);
 
+/* IEEE - FP compare instructions */
+uint32_t cmpgt_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
+uint16_t cmpgt_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
+
 #endif
diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.h
index ac709d8993..318d44efb7 100644
--- a/target/hexagon/mmvec/macros.h
+++ b/target/hexagon/mmvec/macros.h
@@ -356,4 +356,7 @@
                extract32(VAL, POS * 8, 8); \
     } while (0);
 
+#define fCMPGT_SF(A, B) cmpgt_sf(A, B, &env->hvx_fp_status)
+#define fCMPGT_HF(A, B) cmpgt_hf(A, B, &env->hvx_fp_status)
+
 #endif
diff --git a/target/hexagon/mmvec/hvx_ieee_fp.c b/target/hexagon/mmvec/hvx_ieee_fp.c
index 0d9ff8bd5f..f3f8f30d48 100644
--- a/target/hexagon/mmvec/hvx_ieee_fp.c
+++ b/target/hexagon/mmvec/hvx_ieee_fp.c
@@ -86,3 +86,51 @@ int16_t conv_h_hf(float16 a, float_status *fp_status)
     }
     return float16_to_int16_round_to_zero(a, fp_status);
 }
+
+/*
+ * Returns true if f1 > f2, where at least one of the elements is guaranteed
+ * to be NaN.
+ * Up to v73, Hexagon HVX IEEE FP follows this order:
+ * QNaN > SNaN > +Inf > numbers > -Inf > SNaN_neg > QNaN_neg
+ */
+static bool float32_nan_compare(float32 f1, float32 f2, float_status *fp_status)
+{
+    /* opposite signs case */
+    if (float32_is_neg(f1) != float32_is_neg(f2)) {
+        return !float32_is_neg(f1);
+    }
+
+    /* same sign case */
+    bool result = (float32_is_any_nan(f1) && !float32_is_any_nan(f2)) ||
+        (float32_is_quiet_nan(f1, fp_status) && !float32_is_quiet_nan(f2, fp_status));
+    return float32_is_neg(f1) ? !result : result;
+}
+
+static bool float16_nan_compare(float16 f1, float16 f2, float_status *fp_status)
+{
+    /* opposite signs case */
+    if (float16_is_neg(f1) != float16_is_neg(f2)) {
+        return !float16_is_neg(f1);
+    }
+
+    /* same sign case */
+    bool result = (float16_is_any_nan(f1) && !float16_is_any_nan(f2)) ||
+        (float16_is_quiet_nan(f1, fp_status) && !float16_is_quiet_nan(f2, fp_status));
+    return float16_is_neg(f1) ? !result : result;
+}
+
+uint32_t cmpgt_sf(float32 a1, float32 a2, float_status *fp_status)
+{
+    if (float32_is_any_nan(a1) || float32_is_any_nan(a2)) {
+        return float32_nan_compare(a1, a2, fp_status);
+    }
+    return float32_compare(a1, a2, fp_status) == float_relation_greater;
+}
+
+uint16_t cmpgt_hf(float16 a1, float16 a2, float_status *fp_status)
+{
+    if (float16_is_any_nan(a1) || float16_is_any_nan(a2)) {
+        return float16_nan_compare(a1, a2, fp_status);
+    }
+    return float16_compare(a1, a2, fp_status) == float_relation_greater;
+}
diff --git a/target/hexagon/imported/mmvec/encode_ext.def b/target/hexagon/imported/mmvec/encode_ext.def
index c1ed1b6c23..3572e4de4c 100644
--- a/target/hexagon/imported/mmvec/encode_ext.def
+++ b/target/hexagon/imported/mmvec/encode_ext.def
@@ -858,4 +858,14 @@ DEF_ENC(V6_vconv_w_sf,"00011110--0--101PP1uuuuu001ddddd")
 DEF_ENC(V6_vconv_hf_h,"00011110--0--101PP1uuuuu100ddddd")
 DEF_ENC(V6_vconv_h_hf,"00011110--0--101PP1uuuuu010ddddd")
 
+/* IEEE FP compare instructions */
+DEF_ENC(V6_vgtsf,"00011100100vvvvvPP1uuuuu011100dd")
+DEF_ENC(V6_vgthf,"00011100100vvvvvPP1uuuuu011101dd")
+DEF_ENC(V6_vgtsf_and,"00011100100vvvvvPP1uuuuu110010xx")
+DEF_ENC(V6_vgthf_and,"00011100100vvvvvPP1uuuuu110011xx")
+DEF_ENC(V6_vgtsf_or,"00011100100vvvvvPP1uuuuu001100xx")
+DEF_ENC(V6_vgthf_or,"00011100100vvvvvPP1uuuuu001101xx")
+DEF_ENC(V6_vgtsf_xor,"00011100100vvvvvPP1uuuuu111010xx")
+DEF_ENC(V6_vgthf_xor,"00011100100vvvvvPP1uuuuu111011xx")
+
 #endif /* NO MMVEC */
diff --git a/target/hexagon/imported/mmvec/ext.idef b/target/hexagon/imported/mmvec/ext.idef
index 3306169060..b10c5f3240 100644
--- a/target/hexagon/imported/mmvec/ext.idef
+++ b/target/hexagon/imported/mmvec/ext.idef
@@ -3143,6 +3143,67 @@ ITERATOR_INSN_SHIFT_SLOT_FLT(16, vconv_hf_h,"Vd32.hf=Vu32.h",
     "Vector conversion of int hw format to hf16",
     VdV.hf[i] = float16_val(int16_to_float16(VuV.h[i], &env->hvx_fp_status)))
 
+/******************************************************************************
+ * IEEE FP compare instructions
+ ******************************************************************************/
+
+#define VCMPGT_SF(DEST, ASRC, ASRCOP, CMP, N, SRC, MASK, WIDTH) \
+{ \
+    for (fHIDE(int) i = 0; i < fVBYTES(); i += WIDTH) { \
+        fHIDE(int) VAL = fCMPGT_SF(VuV.SRC[i/WIDTH],VvV.SRC[i/WIDTH]) ? MASK : 0; \
+        fSETQBITS(DEST,WIDTH,MASK,i,ASRC ASRCOP VAL); \
+    } \
+}
+
+#define VCMPGT_HF(DEST, ASRC, ASRCOP, CMP, N, SRC, MASK, WIDTH) \
+{ \
+    for (fHIDE(int) i = 0; i < fVBYTES(); i += WIDTH) { \
+        fHIDE(int) VAL = fCMPGT_HF(VuV.SRC[i/WIDTH],VvV.SRC[i/WIDTH]) ? MASK : 0; \
+        fSETQBITS(DEST,WIDTH,MASK,i,ASRC ASRCOP VAL); \
+    } \
+}
+
+/* Vector SF compare */
+#define MMVEC_CMPGT_SF(TYPE,TYPE2,DESCR,N,MASK,WIDTH,SRC) \
+    EXTINSN(V6_vgt##TYPE##_and, "Qx4&=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than with predicate-and", \
+        VCMPGT_SF(QxV, fGETQBITS(QxV,WIDTH,MASK,i), &, ">", N, SRC, MASK, WIDTH)) \
+    EXTINSN(V6_vgt##TYPE##_xor, "Qx4^=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than with predicate-xor", \
+        VCMPGT_SF(QxV, fGETQBITS(QxV,WIDTH,MASK,i), ^, ">", N, SRC, MASK, WIDTH)) \
+    EXTINSN(V6_vgt##TYPE##_or, "Qx4|=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than with predicate-or", \
+        VCMPGT_SF(QxV, fGETQBITS(QxV,WIDTH,MASK,i), |, ">", N, SRC, MASK, WIDTH)) \
+    EXTINSN(V6_vgt##TYPE, "Qd4=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than", \
+        VCMPGT_SF(QdV, , , ">", N, SRC, MASK, WIDTH))
+
+/* Vector HF compare */
+#define MMVEC_CMPGT_HF(TYPE,TYPE2,DESCR,N,MASK,WIDTH,SRC) \
+    EXTINSN(V6_vgt##TYPE##_and, "Qx4&=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than with predicate-and", \
+        VCMPGT_HF(QxV, fGETQBITS(QxV,WIDTH,MASK,i), &, ">", N, SRC, MASK, WIDTH)) \
+    EXTINSN(V6_vgt##TYPE##_xor, "Qx4^=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than with predicate-xor", \
+        VCMPGT_HF(QxV, fGETQBITS(QxV,WIDTH,MASK,i), ^, ">", N, SRC, MASK, WIDTH)) \
+    EXTINSN(V6_vgt##TYPE##_or, "Qx4|=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than with predicate-or", \
+        VCMPGT_HF(QxV, fGETQBITS(QxV,WIDTH,MASK,i), |, ">", N, SRC, MASK, WIDTH)) \
+    EXTINSN(V6_vgt##TYPE, "Qd4=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than", \
+        VCMPGT_HF(QdV, , , ">", N, SRC, MASK, WIDTH))
+
+MMVEC_CMPGT_SF(sf,"sf","Vector sf Compare ", fVELEM(32), 0xF, 4, sf)
+MMVEC_CMPGT_HF(hf,"hf","Vector hf Compare ", fVELEM(16), 0x3, 2, hf)
+
 /******************************************************************************
  DEBUG Vector/Register Printing
  ******************************************************************************/
-- 
2.37.2


