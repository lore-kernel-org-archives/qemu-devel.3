Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB9CF459FC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 17:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBG5n-0006qL-VW; Fri, 10 Apr 2026 13:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5c-0006ol-LR
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5a-0001fJ-NM
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:20 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AB0Qw11925120
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ZzRENYlKEMP
 WXVJIPHrKdHk5SD4R2N5ZAAlk3V6uJ1Y=; b=aru4Mm59HaHJhC87FCRH5xwxbfZ
 PpDxs7OsbKx7HxO6aEWu/Kw6kHQ3DKXarZzVUCT9GcjG9pmGDcA0K2cooOvD9QoQ
 ckUH+ov3f8s5ejVJD1SNaBAXJSZz9pg6GliMcNAtfn22fWMa/JWJLrTrfuUaqWTB
 AFfJwsjA+p6R8OE8ETctKQKL2VM9liL0cs/TrDADi/pypxrDXTSwvQOgr4OBYxi3
 8+BlTguwdqA18iFg+dFAbUpufTgVdSzDQqPPMW5Bsk40c67IiaHfrSMgoOgj7A/T
 tZ88EYfGQqB3zLhhnAluldNo8iVh7Y9eA7UZUCfT5TP6CW6kFNu2NerzCMQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deudjtcfj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:17 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2d443c3b094so4175982eec.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 10:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775843777; x=1776448577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZzRENYlKEMPWXVJIPHrKdHk5SD4R2N5ZAAlk3V6uJ1Y=;
 b=Ija5+IQj4+pK/vfOND6dd+S4RJ1N6pBNtPKmWbQQ12Vs6MCJQl3+VlA4PzwC0iGWsk
 OPv56yRA+NuWXWRr/+PfFMwB00izs1C8V647DdcmNNIwFWpwsx7h2JvDuCBRFnOVX79V
 bXc8LEgRvagZO3rXTWy0B16Ln0hVNkpYh8636w4WhRD4912djPo5NqIG7oeHTlWdnjDz
 deYkyU/eHKAci7Zpt2MBvl6n/qtQwrgk2b2pvNv/GICU5qpraO5ywxPiOqN0KqQoMsUe
 PkJaW/GOqIds+Wv/4er7rIkYWoeO1ohuprzYd/0EWBg5Nawh7egP5fP8adVR0lW28y8X
 tXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775843777; x=1776448577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZzRENYlKEMPWXVJIPHrKdHk5SD4R2N5ZAAlk3V6uJ1Y=;
 b=OBzRvVK10R9/zvRH9tTLZ40FKlWrALCaNZSmImoITrWmfdu85/UkUPA9tSlzjrxf7c
 k5LmFsdaFQ7BHkpNDQpBNFS7sSPgPIQzVeQKa6mR8Tcs3/vc00Kkb/ff1SHWW3QF8eKG
 obgHIO4yrxgz3JEepgq+iQ5gcPhg6hfkg928WYQFMnftKxXwkxcEzZ+aHaSwb4niTIs7
 O1+AoJjFRHWO49mwBgYsETUguvQHLGYQaztwC7q/rFoKYLhVBTBZbKP9yrmPp4ZFKRC4
 QlKsdp+mM+oxFrsLOvqWHSFC/lbpQZ0H5SzZURLIQMnbY3IlNRdC7GaUOtvcsjY6DQL5
 1RwQ==
X-Gm-Message-State: AOJu0Yz4dQ0JovDRZExU2n356cpZ24f+61hGRBsDq4ln+Ddlri4kNaGi
 Zyz7rhCk1zoJcxuNVvqr/qBe+zM5hqEcQAnd7+l8X7jAWYDjENVihBWXIuZUtxg5e8mxf2/LtaG
 Jf9WRtyjkILCS9Tw0IagKEoF+H3sd0oSLuPzwqe4+wwO+cmBbJx0wc+qzyVfZLEdZH4YL
X-Gm-Gg: AeBDieuGCwPCTML1NnGJS93WkjG6gfl6ejDUYzep08YvTxYjwkU1hmf4hXs8jmBxFGN
 ZYvD/lBIc488dS9Zm4lHt41mQ2etpEESCdm3IzGQKcl9vwEFph6C8OHLnpPyx64+pI+0HFALg2W
 w4SUtMiL4BrfjNAouN+tgOuh/YVwKLtr/45jKFCFQJTnfun3Vyjbar0mqioPugqK9Tz2/RDgieS
 PARupzdsKScokVQ5q1MzjXHipKL9VCmik6KmV6oRg/123gR7KHOL0qHYfIjVcL7isL+zhrqmVHf
 uwljiZFGRhQ3xtvwqpGHCS/V7rcjxIZF4sE1iG92mH9yPBm/zMXFZuiVu0vuc2a349oPdKjY+oM
 fU18fV5zxgalQeC6VPFHMA4L1LU7ZRXsrue000Q8W0kjhGfFAbHrF7+FHzLbR2LLqy8fPFtVZwg
 wEMoMN/SZe
X-Received: by 2002:a05:7022:459d:b0:128:ca90:3301 with SMTP id
 a92af1059eb24-12c34ea55c7mr2371914c88.11.1775843776518; 
 Fri, 10 Apr 2026 10:56:16 -0700 (PDT)
X-Received: by 2002:a05:7022:459d:b0:128:ca90:3301 with SMTP id
 a92af1059eb24-12c34ea55c7mr2371893c88.11.1775843775918; 
 Fri, 10 Apr 2026 10:56:15 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c3459f7ffsm4256271c88.3.2026.04.10.10.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 10:56:13 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v4 08/16] target/hexagon: add v68 HVX IEEE float misc insns
Date: Fri, 10 Apr 2026 10:55:56 -0700
Message-Id: <27a5ca1ce30e540826de5f1464ee1bf0e2c9a995.1775843299.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X+hi7mTe c=1 sm=1 tr=0 ts=69d939c1 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=287aDwLwmCB6td_Y28QA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: DJ0Xbhz4ykV-QmKxVZcP6aNYeEEv3i9N
X-Proofpoint-ORIG-GUID: DJ0Xbhz4ykV-QmKxVZcP6aNYeEEv3i9N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE2OCBTYWx0ZWRfX8LKFpvf64jJo
 9/gQolkTW1+mmCzCM4Cr2HeaaR0pJZyM5TR3Jw8nzoI2zOLVv5COzY8bJoFQrGlai0vnJnbBUMy
 BavPdzoxy+ShUpnEbbaaFct/LwwihFqkQ4JQbML4yMPMXaz1b+qlsDIjQY4t4KQlyrNqP8D42bD
 14YrSVz0EP79tVyVwmzKsV3N5CSCXWuuWyxJ78qsSv0Ier18v25fPbn/9PS/TFfKPF7Pm9lwitI
 CzATCQlfbfkAAGMO1ThzHaxOcgMp9Ednune870C+ROzlAGPX5F3JxTlXrqVLvklBh+eKk1qauUJ
 L+PH7U3NvlPXfHn5PCojOSNTOqwt/3rv7v/wHKtu3f4vtMQ8WAgFM9RBILf+bbG+/kVjZK6f5xL
 6YHR2gp+RhB9tKu+t1NZd5q4w1V/C10dGwWYXFHiLJ3ySlwIVFy64VSm5JyAPzizomB/S5nuacC
 FJ+0MtX3Tc5rFsiRPcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
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

Add HVX IEEE floating-point miscellaneous instructions:
- vassign_fp (vfmv): vector move
- vfneg_hf, vfneg_sf: vector floating-point negate
- vabs_hf, vabs_sf: vector absolute value

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/imported/mmvec/encode_ext.def |  7 +++++++
 target/hexagon/imported/mmvec/ext.idef       | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/target/hexagon/imported/mmvec/encode_ext.def b/target/hexagon/imported/mmvec/encode_ext.def
index d7f50db778..72daf8724c 100644
--- a/target/hexagon/imported/mmvec/encode_ext.def
+++ b/target/hexagon/imported/mmvec/encode_ext.def
@@ -833,4 +833,11 @@ DEF_ENC(V6_vmin_sf,"00011111110vvvvvPP1uuuuu010ddddd")
 DEF_ENC(V6_vmax_hf,"00011111110vvvvvPP1uuuuu011ddddd")
 DEF_ENC(V6_vmin_hf,"00011111110vvvvvPP1uuuuu100ddddd")
 
+/* IEEE FP move, negate, abs instructions */
+DEF_ENC(V6_vassign_fp,"00011110--0-0110PP1uuuuu001ddddd")
+DEF_ENC(V6_vfneg_hf,"00011110--0-0110PP1uuuuu010ddddd")
+DEF_ENC(V6_vfneg_sf,"00011110--0-0110PP1uuuuu011ddddd")
+DEF_ENC(V6_vabs_hf,"00011110--0-0110PP1uuuuu100ddddd")
+DEF_ENC(V6_vabs_sf,"00011110--0-0110PP1uuuuu101ddddd")
+
 #endif /* NO MMVEC */
diff --git a/target/hexagon/imported/mmvec/ext.idef b/target/hexagon/imported/mmvec/ext.idef
index 0e9cace203..1b16ed0628 100644
--- a/target/hexagon/imported/mmvec/ext.idef
+++ b/target/hexagon/imported/mmvec/ext.idef
@@ -3034,6 +3034,18 @@ ITERATOR_INSN_ANY_SLOT_2SRC(16,vmin_hf,"Vd32.hf=vmin(Vu32.hf,Vv32.hf)", \
     "Vector min of hf input", VdV.hf[i] = qf_min_hf(VuV.hf[i], VvV.hf[i], \
 	&env->hvx_fp_status))
 
+/* IEEE FP move, negate, abs instructions */
+ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vassign_fp, "Vd32.w=vfmv(Vu32.w)", \
+    "Vector IEEE move", VdV.w[i]  = VuV.w[i])
+ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vfneg_hf, "Vd32.hf=vfneg(Vu32.hf)", \
+    "Vector IEEE neg: hf", VdV.hf[i] = float16_chs(VuV.hf[i]))
+ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vfneg_sf, "Vd32.sf=vfneg(Vu32.sf)", \
+    "Vector IEEE neg: sf", VdV.sf[i] = float32_chs(VuV.sf[i]))
+ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vabs_hf,  "Vd32.hf=vabs(Vu32.hf)", \
+    "Vector IEEE abs: hf", VdV.hf[i] = float16_abs(VuV.hf[i]))
+ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vabs_sf,  "Vd32.sf=vabs(Vu32.sf)", \
+    "Vector IEEE abs: sf", VdV.sf[i] = float32_abs(VuV.sf[i]))
+
 /******************************************************************************
  DEBUG Vector/Register Printing
  ******************************************************************************/
-- 
2.37.2


