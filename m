Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80EDF46101
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4f8c-0000Gh-0m; Mon, 23 Mar 2026 09:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w4f8V-0000Fd-Vi
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:16:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w4f8R-0000LX-W2
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:16:03 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NCeiDd2476059
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ANMsdtIxPbN
 H+bQHOtC1oftfsPQnsKamB/rAUUz74gQ=; b=nTZuiXOukUo/Zz3MVrKZZfeztop
 tYTZXM/0t1AysPWvjjM6TRypLBai1qTeVpxq9wD82Zj/5qmKROvKfpCz0ZXsd7gI
 UMrTFsgWYmYsZYOoYsVayLHfs9q9oKUAKkixeIoHzHdv0tMIFZxsOLYlK7IYF1uS
 fqohL0buJ6upXYnV5/XRk4T6lGTFBpw87jZKva4E+gDR/YDciskEGnpSMJZwBBd2
 pndd2E/AlbwpdyEO7di65fuVqri7Hx541dmTZyz/wp7exC4nYREkbMAzr+/Luxhd
 vrK+3R4nHt6UbU3gL3rA7GAXOdZ3TYbJjpvNCq1ckjTS2va5G8LUnxyORtA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d35r203f7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:15:58 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ba9a744f7dso3189481eec.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 06:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774271758; x=1774876558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ANMsdtIxPbNH+bQHOtC1oftfsPQnsKamB/rAUUz74gQ=;
 b=VNgrhfGn9el+YH/til+u/dcLzTkR+rVczEtvX8ym7LHB4spYmn1L6v72gowss7UgfP
 xX+PvSCOaEFLuPLbdXZblRE6aVncLOIqxisJ+DV3w32qmp5FIbXztwZeC20IGR+nOWgR
 4aTD4jg7fJCuNwr+AU+3OxwFDmnIgtt4LCrNafc5vjkslKGfGoNpE7R/N2O9aoCBK49F
 F0E2x5ydJe8KaIK7uodl/M/xfuie8o2PUiJpB/+POA4fgq4sksvCCSvJG3wEv8DWngUd
 0RaQl0aOmCDbV2rLtIR0sRe1pCCCxyDi7E7jtDF3qqU8svpjqwfmq6QPoB8Ei2ixo8dV
 VpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774271758; x=1774876558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ANMsdtIxPbNH+bQHOtC1oftfsPQnsKamB/rAUUz74gQ=;
 b=Xn3u/cwrFuXCTrZymmY/Lj/aaaBNoI7sSsjD+BLk5HM0KygLzPc9cy01o8U5Nsxsj3
 VO5EaZo6JrF82z8ecXtCUEkD5nqvlk8zIeF6WhqH1GMManBhXEF50voax6crbJYICA+W
 fvBe6ZFmwL8JtC0hG4OSgthOr7Lub26di551F9xH2nHhfABDfNNI9SsdWgTXQyhDKS2o
 o8RRdBRDbZ2UOZ7jZrv1P2sEv9MKuJg3a1n01+jdBgasNZzNauoaTB1ZAWYlz4GOophU
 UI6df82W+r0fRLs+rRz2E+2B3pIhrkgfTybyipDs/stT2ge2wXYYLXHmXMxDKj0+MfwS
 QJpQ==
X-Gm-Message-State: AOJu0YxviD/stuIyAA/mkyNEFAtoDDzn1B0J6H+7T+HBu5NnYHJTFa5y
 GroZrcTf/1aqdVjzsWFG9cKJKyDyGMWf1H11fd6soI0f/KsIgbrE/LrLXxCzCTJxxGbtMk38nAa
 vGp0R1Wq1xsgCOI+8N7/hDfHUvmV58GIPgpefFng/grYcIlu46mvnn/LeB+MXoi7aT9g3
X-Gm-Gg: ATEYQzyPpSRIic8sdXyuc/sVB25FX/Z0Snqp3lkHVq/bEd+DziP9rwQMkA5lmAO4dOg
 dZL2uBmphCmxsmVA1wwo2q/IYLrS+lGTr9E7JAs8y+z318k0hOCBnh3P/YGb2osfkxYuGHdfzg4
 W6rBeXdJeGJpcSZpbZygBclM6OwaDCfAPLJQgU7/0EaJqSDdrOIEgfg+Id60UjZd1HA1x4X9dDs
 xUJKbTVJwb4wf8o4PgJ0r9Q3+WLFFOklE7qXtPaEV3E0v/2D2gc1NAVplD0dwv9+YkC3YKO9kfc
 hBtqCjGmoTZJLbG6as/PWkSslHUIS/epXOftZcvapoZhNgbU84Hb2ahLSGP+2Ps/AXwNfptOYDo
 rwY3LmoR52rF6U6PybGGz+JGHOKdKXrJODxXApUoqS9zsgHTcgizg/mIBJ9i75fFcvnuoadu2NC
 YokuoBloAp
X-Received: by 2002:a05:7300:d704:b0:2b0:48f7:837d with SMTP id
 5a478bee46e88-2c109624055mr4877507eec.11.1774271757363; 
 Mon, 23 Mar 2026 06:15:57 -0700 (PDT)
X-Received: by 2002:a05:7300:d704:b0:2b0:48f7:837d with SMTP id
 5a478bee46e88-2c109624055mr4877479eec.11.1774271756567; 
 Mon, 23 Mar 2026 06:15:56 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b14cadbsm14702574eec.3.2026.03.23.06.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 06:15:55 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com, marco.liebel@oss.qualcomm.com,
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH 05/13] target/hexagon: add v68 HVX IEEE float min/max insns
Date: Mon, 23 Mar 2026 06:15:41 -0700
Message-Id: <4895991dcd597b052869e2275d5f0056dfc2368b.1774271525.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VvUuwu2n c=1 sm=1 tr=0 ts=69c13d0e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=yvcF8Y4nJBuLCN0LrDUA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: BxGuSRWNPc4v9Gx6x_zd4mIXA4PsMavx
X-Proofpoint-ORIG-GUID: BxGuSRWNPc4v9Gx6x_zd4mIXA4PsMavx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEwMyBTYWx0ZWRfXwdfpHq/iAtp+
 is0Wj8HiPReXaFcjygzCW+SoKZ3BONAs6rtev5baZFTyrdgnoyTra3YlGukBwPlSOxUGOaDvj44
 atJZA5NBxAMUpaaCTVQArOWeHU0DWoqfNO1E1Rqfzlv5y72DlGClVaOrxF5dK5eUOz+UX7waHNt
 m6gjpspFPXKhnvEMNcDdZs0kVFQdFZkMHgMQghlhw6O+MB5HBtE2kNXVpfWQpMdI/coCLfuwxcg
 3wYH6IkhpXCMO2SWm4bQsOJWCrzJaGqeeqQDRUavY7GNU528mEK670E3m8EJRQF6skw1XG0Z6pV
 T8aqwgUzCajPZRvEO2rqLFibjUaj55NvB4Xwayj5EibBeXL97ajxPmuKqQkm1CbKojlWrg3z1k6
 8k+2QVhJ5dRnWyjxuiBPvP+9A5WkV0g53CzuCOvt+epUCnbozwBmlmUtseKTECWjOfN5HLv+Z7s
 jspiTHWu9C8gVOQ29EA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230103
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Add HVX IEEE floating-point min/max instructions:
- vfmin_hf, vfmin_sf: IEEE floating-point minimum
- vfmax_hf, vfmax_sf: IEEE floating-point maximum
- vmax_hf, vmax_sf: qfloat IEEE maximum
- vmin_hf, vmin_sf: qfloat IEEE minimum

The Hexagon qfloat variants are similar to the IEEE-754 ones, but they
handle NaN slightly differently. See comment on kvx_ieee.h

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/mmvec/kvx_ieee.h              | 12 +++++
 target/hexagon/mmvec/kvx_ieee.c              | 46 ++++++++++++++++++++
 target/hexagon/imported/mmvec/encode_ext.def | 11 +++++
 target/hexagon/imported/mmvec/ext.idef       | 28 +++++++++++-
 4 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/mmvec/kvx_ieee.h b/target/hexagon/mmvec/kvx_ieee.h
index e92ddebeb9..78f546eb8e 100644
--- a/target/hexagon/mmvec/kvx_ieee.h
+++ b/target/hexagon/mmvec/kvx_ieee.h
@@ -44,4 +44,16 @@ uint32_t fp_vdmpy(uint16_t a1, uint16_t a2, uint16_t a3, uint16_t a4,
 uint32_t fp_vdmpy_acc(uint32_t acc, uint16_t a1, uint16_t a2, uint16_t a3,
                       uint16_t a4, float_status *fp_status);
 
+/* IEEE - FP min/max instructions */
+uint32_t fp_min_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
+uint32_t fp_max_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
+uint16_t fp_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
+uint16_t fp_max_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
+
+/* Qfloat min/max treat +NaN as greater than +INF and -NaN as smaller than -INF */
+uint32_t qf_max_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
+uint32_t qf_min_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
+uint16_t qf_max_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
+uint16_t qf_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
+
 #endif
diff --git a/target/hexagon/mmvec/kvx_ieee.c b/target/hexagon/mmvec/kvx_ieee.c
index b763899aa3..33621a15f3 100644
--- a/target/hexagon/mmvec/kvx_ieee.c
+++ b/target/hexagon/mmvec/kvx_ieee.c
@@ -85,3 +85,49 @@ uint32_t fp_vdmpy_acc(uint32_t acc, uint16_t a1, uint16_t a2,
     float32 red = fp_vdmpy(a1, a2, a3, a4, fp_status);
     return fp_add_sf_sf(float32_val(red), acc, fp_status);
 }
+
+DEF_FP_INSN_2(min_sf, 32, 32, 32, float32_min(f1, f2, fp_status))
+DEF_FP_INSN_2(max_sf, 32, 32, 32, float32_max(f1, f2, fp_status))
+DEF_FP_INSN_2(min_hf, 16, 16, 16, float16_min(f1, f2, fp_status))
+DEF_FP_INSN_2(max_hf, 16, 16, 16, float16_max(f1, f2, fp_status))
+
+#define float32_is_pos_nan(X) (float32_is_any_nan(X) && !float32_is_neg(X))
+#define float32_is_neg_nan(X) (float32_is_any_nan(X) && float32_is_neg(X))
+#define float16_is_pos_nan(X) (float16_is_any_nan(X) && !float16_is_neg(X))
+#define float16_is_neg_nan(X) (float16_is_any_nan(X) && float16_is_neg(X))
+
+uint32_t qf_max_sf(uint32_t a1, uint32_t a2, float_status *fp_status)
+{
+    float32 f1 = make_float32(a1);
+    float32 f2 = make_float32(a2);
+    if (float32_is_pos_nan(f1) || float32_is_neg_nan(f2)) return a1;
+    if (float32_is_pos_nan(f2) || float32_is_neg_nan(f1)) return a2;
+    return fp_max_sf(a1, a2, fp_status);
+}
+
+uint32_t qf_min_sf(uint32_t a1, uint32_t a2, float_status *fp_status)
+{
+    float32 f1 = make_float32(a1);
+    float32 f2 = make_float32(a2);
+    if (float32_is_pos_nan(f1) || float32_is_neg_nan(f2)) return a2;
+    if (float32_is_pos_nan(f2) || float32_is_neg_nan(f1)) return a1;
+    return fp_min_sf(a1, a2, fp_status);
+}
+
+uint16_t qf_max_hf(uint16_t a1, uint16_t a2, float_status *fp_status)
+{
+    float16 f1 = make_float16(a1);
+    float16 f2 = make_float16(a2);
+    if (float16_is_pos_nan(f1) || float16_is_neg_nan(f2)) return a1;
+    if (float16_is_pos_nan(f2) || float16_is_neg_nan(f1)) return a2;
+    return fp_max_hf(a1, a2, fp_status);
+}
+
+uint16_t qf_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status)
+{
+    float16 f1 = make_float16(a1);
+    float16 f2 = make_float16(a2);
+    if (float16_is_pos_nan(f1) || float16_is_neg_nan(f2)) return a2;
+    if (float16_is_pos_nan(f2) || float16_is_neg_nan(f1)) return a1;
+    return fp_min_hf(a1, a2, fp_status);
+}
diff --git a/target/hexagon/imported/mmvec/encode_ext.def b/target/hexagon/imported/mmvec/encode_ext.def
index 4ce87d09fd..23fbb75743 100644
--- a/target/hexagon/imported/mmvec/encode_ext.def
+++ b/target/hexagon/imported/mmvec/encode_ext.def
@@ -823,4 +823,15 @@ DEF_ENC(V6_vsub_sf_hf,"00011111100vvvvvPP1uuuuu101ddddd")
 DEF_ENC(V6_vadd_hf_hf,"00011111101vvvvvPP1uuuuu111ddddd")
 DEF_ENC(V6_vsub_hf_hf,"00011111011vvvvvPP1uuuuu000ddddd")
 
+/* IEEE FP min/max instructions */
+DEF_ENC(V6_vfmin_hf,"00011100011vvvvvPP1uuuuu000ddddd")
+DEF_ENC(V6_vfmin_sf,"00011100011vvvvvPP1uuuuu001ddddd")
+DEF_ENC(V6_vfmax_hf,"00011100011vvvvvPP1uuuuu010ddddd")
+DEF_ENC(V6_vfmax_sf,"00011100011vvvvvPP1uuuuu011ddddd")
+DEF_ENC(V6_vmax_sf,"00011111110vvvvvPP1uuuuu001ddddd")
+DEF_ENC(V6_vmin_sf,"00011111110vvvvvPP1uuuuu010ddddd")
+DEF_ENC(V6_vmax_hf,"00011111110vvvvvPP1uuuuu011ddddd")
+DEF_ENC(V6_vmin_hf,"00011111110vvvvvPP1uuuuu100ddddd")
+DEF_ENC(V6_vcvt_ub_hf,"00011111110vvvvvPP1uuuuu101ddddd")
+
 #endif /* NO MMVEC */
diff --git a/target/hexagon/imported/mmvec/ext.idef b/target/hexagon/imported/mmvec/ext.idef
index 3f0d8e366e..43153366b1 100644
--- a/target/hexagon/imported/mmvec/ext.idef
+++ b/target/hexagon/imported/mmvec/ext.idef
@@ -43,7 +43,9 @@
 EXTINSN(V6_##TAG, SYNTAX, ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA),  \
 DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
 
-
+#define ITERATOR_INSN_ANY_SLOT_2SRC(WIDTH,TAG,SYNTAX,DESCR,CODE) \
+EXTINSN(V6_##TAG, SYNTAX, ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT),  \
+DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
 
 #define ITERATOR_INSN2_ANY_SLOT(WIDTH,TAG,SYNTAX,SYNTAX2,DESCR,CODE) \
 ITERATOR_INSN_ANY_SLOT(WIDTH,TAG,SYNTAX2,DESCR,CODE)
@@ -2992,6 +2994,30 @@ ITERATOR_INSN_IEEE_FP_DOUBLE_32(32, vsub_sf_hf,
     VddV.v[0].sf[i] = fp_sub_sf_hf(VuV.hf[2*i], VvV.hf[2*i], &env->fp_status);
     VddV.v[1].sf[i] = fp_sub_sf_hf(VuV.hf[2*i+1], VvV.hf[2*i+1], &env->fp_status))
 
+#define ITERATOR_INSN_IEEE_FP_16_32_LATE(WIDTH,TAG,SYNTAX,DESCR,CODE) \
+EXTINSN(V6_##TAG, SYNTAX, \
+        ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX,A_HVX_IEEE_FP_OUT_16,A_HVX_IEEE_FP_OUT_32), \
+        DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
+
+/* IEEE FP min/max instructions */
+ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vfmin_hf, "Vd32.hf=vfmin(Vu32.hf,Vv32.hf)", \
+    "Vector IEEE min: hf",  VdV.hf[i] = fp_min_hf(VuV.hf[i], VvV.hf[i], &env->fp_status))
+ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vfmin_sf, "Vd32.sf=vfmin(Vu32.sf,Vv32.sf)", \
+    "Vector IEEE min: sf",  VdV.sf[i] = fp_min_sf(VuV.sf[i], VvV.sf[i], &env->fp_status))
+ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vfmax_hf,  "Vd32.hf=vfmax(Vu32.hf,Vv32.hf)", \
+    "Vector IEEE max: hf", VdV.hf[i] = fp_max_hf(VuV.hf[i], VvV.hf[i], &env->fp_status))
+ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vfmax_sf,  "Vd32.sf=vfmax(Vu32.sf,Vv32.sf)", \
+    "Vector IEEE max: sf", VdV.sf[i] = fp_max_sf(VuV.sf[i], VvV.sf[i], &env->fp_status))
+
+ITERATOR_INSN_ANY_SLOT_2SRC(32,vmax_sf,"Vd32.sf=vmax(Vu32.sf,Vv32.sf)", \
+    "Vector max of sf input", VdV.sf[i] = qf_max_sf(VuV.sf[i], VvV.sf[i], &env->fp_status))
+ITERATOR_INSN_ANY_SLOT_2SRC(32,vmin_sf,"Vd32.sf=vmin(Vu32.sf,Vv32.sf)", \
+    "Vector min of sf input", VdV.sf[i] = qf_min_sf(VuV.sf[i], VvV.sf[i], &env->fp_status))
+ITERATOR_INSN_ANY_SLOT_2SRC(16,vmax_hf,"Vd32.hf=vmax(Vu32.hf,Vv32.hf)", \
+    "Vector max of hf input", VdV.hf[i] = qf_max_hf(VuV.hf[i], VvV.hf[i], &env->fp_status))
+ITERATOR_INSN_ANY_SLOT_2SRC(16,vmin_hf,"Vd32.hf=vmin(Vu32.hf,Vv32.hf)", \
+    "Vector min of hf input", VdV.hf[i] = qf_min_hf(VuV.hf[i], VvV.hf[i], &env->fp_status))
+
 /******************************************************************************
  DEBUG Vector/Register Printing
  ******************************************************************************/
-- 
2.37.2


