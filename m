Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F0BF4610C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4f8i-0000IB-3V; Mon, 23 Mar 2026 09:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w4f8X-0000Fx-5G
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:16:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w4f8V-0000MD-6U
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:16:04 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NBgUZn123583
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:16:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=RFNTE4r6lEH
 zzhNGAcvE0NH/DzeW9XdrgsnPT6PjuLk=; b=hnYwST8hQ1tbLJfC9xCTWOQQQLl
 pGt/QQHzrV5x1gZmF9qs21jrGb291X9HSbXlyCpApIiDA9JICmWMwGleQyxVNQv2
 fJskXizzu7w3jBgZZFSrQjsvjBC8M2ND/HfR36WYxXhzvL1H8KcaT0NHVNRlmEU8
 k5WZn3EP7Oj2yxT8X7uX/dNBa8QCS7N5C7zWhgkfgEMGB/C+/6t30EfqPyXmn6xj
 QEN/MP4Rj7aWL9V+xh7xhMiTnuYPJxnjWA73Iv2jKt+ReejAVODM1UHtZXfOpd9C
 A1niAvRgQ2rSeFrMoztI2w/1yyn92Bg8/XOBk1TXpaV3+aaE7TAgnfRAgLg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d34vkr9fm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:16:02 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2c105e5ac70so3072846eec.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 06:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774271761; x=1774876561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RFNTE4r6lEHzzhNGAcvE0NH/DzeW9XdrgsnPT6PjuLk=;
 b=LcrtXs4XrZv02z2igE/UP0eQXXv7HaXCW9rSAxZchAiwc6q3YAj4+LE/4d7pOpTnP4
 75CIEaP4u6FVV1DnQty4anb0NtHGLUSEMDOqZp0q5sIIPlG8Ee/OVUSk7QXkOYkKFg5i
 6hTSxlrRC56C++zGFz2s4KRPDnNx2lsDz9GWvBPOiu7ued7uVSTW0NqCE/ndMPqzSdDT
 AuC/liQZ2CUwAWgcEaFsrJ5t67Y/KICnqxyRIMr/4yPRw1DZZizbzWHgmXUAqVpNO0Er
 cuwKrywHWREmURCDyYKp5H+in7Ar2TyTKbJaW6tl30hYDNhpQPLvKd7nUHCFSkv/iX7e
 vQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774271761; x=1774876561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RFNTE4r6lEHzzhNGAcvE0NH/DzeW9XdrgsnPT6PjuLk=;
 b=ZyGg3Phvz4id+itpE6DUcs3HoGL5vpCGJsPENIRhCdKGGrjMrUjZkhdzUmoGzRsgGj
 WjWdxQpCnCLQl4kYSWE1d0lVWNTBGrFB/pMs9RXhQmLYfjqD2CLAjd1Nwigc8xvsuAkS
 iGjqFErrn9F8vNd4Cr/9hd/wnTOOo3yIGEkXyyxiFmG7mM7pwA9cwtuwK8BqMbOk1CyO
 XWD2YJq57KErasZN8xnvkDWaikM5cXrjqmSGZMC41VHEuzfXfUU/2LOaLlXfoKfyBrpM
 kO8/IB0H447P7IESuwfeE09G84pWw/hOPfUfGz9UQ9qBPcJ6XNsTtH6zmqcBKxJ8VGHu
 dHsg==
X-Gm-Message-State: AOJu0YxGKZIh3kKTzwAbcBAFHp9u06hqtEcoqA8cgG54lytZHkMOhkOI
 T5cgxu7efrikXxIZeAVf7R52og3O3USLAahtL2WBYfU2N1pUaZdWDP7Xx2H5hnhzrlj3b0HWr2U
 J4dvHtftE+LYS1jJOlSqIbo3PdOlwYUhhsqe0A0V1y8ns0rrPG5s5KpAkGO7jS9dXo+Uo
X-Gm-Gg: ATEYQzxqUHFqyTHm1ESEbWSY4bRJwYPDQUkwXdhpN9wtTjpXQ5RiZxrJ0S5Rqx1qV8q
 AdozB+lsco2dwx8svOjK8VZ8oUV4cRuU0MyPbV+pupyDEefCrbZDvNnpuYUr3rIylTcMX/gYlML
 VZ0voqWYw9FRhBfZFF1dFvjLEzFxXvOs7gjN2nhHxYQkD37CWjqrAtUrbLv6KJBwI82HZiO5qXe
 I7JTa4peVWzWOAWFdj675M9iU8kZO4iJblfAMUoihHMkfiX0NgVO4kGnYrFSj5RxI4ox/xjY9MR
 7+vJTm7+RpGe2TSKOfKa9WDxUB4FLHfmP/bDi/ZDeFvtFvCqYM1OMk++aEi2+4F9JS/1zI0hJI0
 J664k3Ao96bMp2AHPo6VpYRAG0Paf925TTS6RvEDalxaCuYYQV2EgsXoq7seMWKF/ZeseIKr42w
 pPtsYyeQBL
X-Received: by 2002:a05:7301:6794:b0:2b7:13f5:43ac with SMTP id
 5a478bee46e88-2c10966353emr5856778eec.15.1774271760655; 
 Mon, 23 Mar 2026 06:16:00 -0700 (PDT)
X-Received: by 2002:a05:7301:6794:b0:2b7:13f5:43ac with SMTP id
 5a478bee46e88-2c10966353emr5856756eec.15.1774271759829; 
 Mon, 23 Mar 2026 06:15:59 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b14cadbsm14702574eec.3.2026.03.23.06.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 06:15:58 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com, marco.liebel@oss.qualcomm.com,
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH 08/13] target/hexagon: add v68 HVX IEEE float compare insns
Date: Mon, 23 Mar 2026 06:15:44 -0700
Message-Id: <c687d91e8ad5b476593aa1969113e8c51987f156.1774271525.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEwMyBTYWx0ZWRfXzf0DKFQezTWQ
 b9Z/mTuQ+9KXSvbtKHpGTBfKqg30Cvuxsu6k8+odYvjnyHsUiAxCUL1AbQgeWwre8OaFbl+pUgj
 xRDfHeNXLhqvBmzVsP5NJ54FUimlBTGfBdZ9OtgThnLwfF6L0ZhADojHV/BYr+Bts3MkQxWXLyO
 xZ65yh2Gd2NrdarMoc0ApTb/T44B9shaSTRHacMCbfHpXatqZcS7PZ8QbvcdLMhA7QDCuK/7zWQ
 3BukqcaKjA1nt4/CPD20ndV+4wBDZ0xzfDIHuDBm/gmAraUGa0MWQQxRSnfWTciWUghZhmcU/7C
 FvCIQSEH0oGWI0veEKWb4v1bl3c5a1WgHXC56E0d8s04WaqdMENYwIInxwe+FXdC6U+QhH1hXdf
 N9p37gXnxDLft52GUzL751Eb/pBAOkpJ7O6hmBLFmcwQ5Hs5NBJXe9PdEr7wC1CNuuKkRF1cLMw
 qhfOHgKMONL2L2zXEqQ==
X-Authority-Analysis: v=2.4 cv=eMoeTXp1 c=1 sm=1 tr=0 ts=69c13d12 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=rrxrgvBJ-XzOK2CxOk4A:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: oJwpu-gceGr-hGQFV2Z5R4YHuPV5UShy
X-Proofpoint-ORIG-GUID: oJwpu-gceGr-hGQFV2Z5R4YHuPV5UShy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
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

Add HVX IEEE floating-point compare instructions:
- V6_vgthf, V6_vgtsf: greater-than compare
- V6_vgthf_and, V6_vgtsf_and: greater-than with predicate-and
- V6_vgthf_or, V6_vgtsf_or: greater-than with predicate-or
- V6_vgthf_xor, V6_vgtsf_xor: greater-than with predicate-xor

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/mmvec/macros.h                | 10 ++++
 target/hexagon/attribs_def.h.inc             |  2 +
 target/hexagon/hex_common.py                 |  1 +
 target/hexagon/imported/mmvec/encode_ext.def | 10 ++++
 target/hexagon/imported/mmvec/ext.idef       | 61 ++++++++++++++++++++
 5 files changed, 84 insertions(+)

diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.h
index 2af3d2d747..c342507d1a 100644
--- a/target/hexagon/mmvec/macros.h
+++ b/target/hexagon/mmvec/macros.h
@@ -356,4 +356,14 @@
                extract32(VAL, POS * 8, 8); \
     } while (0);
 
+#define fCMPGT_SF(A, B) \
+    (float32_is_any_nan(A) || float32_is_any_nan(B) ? \
+     (int32_t)(A) > (int32_t)(B) : \
+     float32_compare((A), (B), &env->fp_status) == float_relation_greater)
+
+#define fCMPGT_HF(A, B) \
+    (float16_is_any_nan(A) || float16_is_any_nan(B) ? \
+    (int16_t)(A) > (int16_t)(B) : \
+    float16_compare((A), (B), &env->fp_status) == float_relation_greater)
+
 #endif
diff --git a/target/hexagon/attribs_def.h.inc b/target/hexagon/attribs_def.h.inc
index d3c4bf6301..2d0fc7e9c0 100644
--- a/target/hexagon/attribs_def.h.inc
+++ b/target/hexagon/attribs_def.h.inc
@@ -81,6 +81,7 @@ DEF_ATTRIB(CVI_SCATTER, "CVI Scatter operation", "", "")
 DEF_ATTRIB(CVI_SCATTER_RELEASE, "CVI Store Release for scatter", "", "")
 DEF_ATTRIB(CVI_TMP_DST, "CVI instruction that doesn't write a register", "", "")
 DEF_ATTRIB(CVI_SLOT23, "Can execute in slot 2 or slot 3 (HVX)", "", "")
+DEF_ATTRIB(CVI_VA_2SRC, "Execs on multimedia vector engine; requires two srcs", "", "")
 
 DEF_ATTRIB(VTCM_ALLBANK_ACCESS, "Allocates in all VTCM schedulers.", "", "")
 
@@ -179,6 +180,7 @@ DEF_ATTRIB(HVX_IEEE_FP_ACC, "HVX IEEE FP accumulate instruction", "", "")
 DEF_ATTRIB(HVX_IEEE_FP_OUT_16, "HVX IEEE FP 16-bit output", "", "")
 DEF_ATTRIB(HVX_IEEE_FP_OUT_32, "HVX IEEE FP 32-bit output", "", "")
 DEF_ATTRIB(CVI_VX_NO_TMP_LD, "HVX multiply without tmp load", "", "")
+DEF_ATTRIB(HVX_FLT, "This a floating point HVX instruction.", "", "")
 
 /* Keep this as the last attribute: */
 DEF_ATTRIB(ZZ_LASTATTRIB, "Last attribute in the file", "", "")
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index f6a2848db1..f93c7559d2 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -216,6 +216,7 @@ def need_env(tag):
             "A_CVI_GATHER" in attribdict[tag] or
             "A_CVI_SCATTER" in attribdict[tag] or
             "A_HVX_IEEE_FP" in attribdict[tag] or
+            "A_HVX_FLT" in attribdict[tag] or
             "A_IMPLICIT_WRITES_USR" in attribdict[tag])
 
 
diff --git a/target/hexagon/imported/mmvec/encode_ext.def b/target/hexagon/imported/mmvec/encode_ext.def
index 5325bbd704..3f84a1691b 100644
--- a/target/hexagon/imported/mmvec/encode_ext.def
+++ b/target/hexagon/imported/mmvec/encode_ext.def
@@ -859,4 +859,14 @@ DEF_ENC(V6_vconv_w_sf,"00011110--0--101PP1uuuuu001ddddd")
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
index 8b832166e0..304c4966d8 100644
--- a/target/hexagon/imported/mmvec/ext.idef
+++ b/target/hexagon/imported/mmvec/ext.idef
@@ -3129,6 +3129,67 @@ ITERATOR_INSN_SHIFT_SLOT_FLT(16, vconv_hf_h,"Vd32.hf=Vu32.h",
     "Vector conversion of int hw format to hf16",
     VdV.hf[i] = conv_hf_h(VuV.h[i], &env->fp_status))
 
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


