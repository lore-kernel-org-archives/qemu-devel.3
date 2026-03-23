Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035C1F46101
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4f8h-0000Hb-J1; Mon, 23 Mar 2026 09:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w4f8V-0000FY-QE
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:16:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w4f8S-0000Lm-Bx
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:16:03 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NADsZ53539886
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yxnWkgrof+C
 3h7cqEh7UJxAE8rAxqqV8GNsStTLZtDs=; b=DF2rNuRquh6KEYO8C/3Eqpd0rBX
 JatvHeFEvXVj7yheRyg79mkzJWdlJMn8ds7Soz10mRN5Qmeq2i/MkBw4Tn7lr+hP
 o8ZfPMLeAItlpXoxQz9vPAg/NGzw7Inm1A2+KjYfEd1leePEqI9S18Ob02P5ogD6
 BuOVTheME2+TxQR6H72oJsDikM88nMfJjzzJCxs7ISv1514to2z6iaYhKzAB2lOf
 DV0PuvPfK1DCM22JxOG7htGW9eIo3ggeqA8uRNR51riSbExVwTX0cn9v3UDXWz/4
 aPfkPKRG/neYx1o4an66VZhzG4gS9e2sjZUIs6Q3/2HaMJXlBAcR5/fG+/g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d33k30ju5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:15:59 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2c1030ca85eso4179562eec.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 06:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774271758; x=1774876558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yxnWkgrof+C3h7cqEh7UJxAE8rAxqqV8GNsStTLZtDs=;
 b=IffpDmqd4SL9rzVeg/kXOdAvH32LX34OSyO6i6wR8VIB+pPWPfkkXnXdbq8Ml1EmSv
 eT02ev/kOfqLz7FafAFjWif7KhXf0fFvzdMgplEZpYp6CHWw5LQh6DXCNtcCzYwvdKvA
 tgfAdCT52WAcq9MVAyoWS4k19jvsJLN7ASH6LYg5+9uApQ0VX/yji8rC6WFcmDK8TZaK
 Q+phfbEiQvsVor912XBiiFVae1UqF/KRb52TBtmaBYWeqmtENKM/OOoacrUo3YZMJgih
 YBAt/tQ7zNTDqOgs6T+OSvZ+ZH7R3ed3fCx8h8wmxb7dII6KFHgIi7+MiOtPmoB1lgG4
 5xBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774271758; x=1774876558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yxnWkgrof+C3h7cqEh7UJxAE8rAxqqV8GNsStTLZtDs=;
 b=SEXWmcifpGMsjOH/hMMcASnffxNigFUe1BZ9rpq3S+ebmOrlNHVK2WD+eTBDDAooWW
 5GmUAcaREMeBtOKP10Fbjmidk5Kmhs6T6Wyk81osMXmhtBXzmJMJ+KaOvmEh0hBv6IaT
 sWW2Ji5DxIt8gMmtNxY6JGl/or48Zg41tKZvmNPk/7S/r3BleFKlAFAbKnNoywjTYhaU
 6zwFiegdmMHQF2X7Y8ACzbk2EMdPoWoqf7M5OFunSePDGpR1g5HqriTXebmMnIuNFPL/
 w9GRwAcr7pTgqCnIYn+Mst9iplpG5B9eosBz3ue9PLVDvlMBXVwyWtLKpIOcje3sDyea
 GlyQ==
X-Gm-Message-State: AOJu0YyqjmNKcHHlaO1dn6GFJq0w65DUK8HnHSWea+lWXywffTZ878p3
 hMAyTwqcYmfk2hHiaXVgPVyFDxkonrC+2galSHLYRAVIZWWrAfjj6yX0iIjBFlpxRumsB9ZYShE
 /qPre0A+qatM3jxbYVAAgKAy+ScFsXziIGcGFcpSKqRFf2V6+y8DfRUBwJMtQJL721J74
X-Gm-Gg: ATEYQzxAo8VOQh0COd6VPZih0Hpk9s8Uasar+QI8WNKwPAz89cIsW7zLLfiJqsiy3KS
 5PadGAmoKjenOziTK8TlemZXTHEPJqB0pBtuV5WDOcLD1idZm8y36PnzRqAi4tRn2qGk+tmZkmJ
 h5CIpML+d/Jw5PgDrWbYKaBll2aRCHcbxyadt2jtLUgT0SNWOlFgqOkJtChEe7djvNDb5+ZRxrs
 7QHg2blgTJhwuhQIKremX33S5sJkVpHYmhzs2phcAtXGOTTiQXuBUI2Ph3lOUHBKq7DJANP9pi8
 4qpBJvc2YKcDsj8tEqNAmXdv+5/1pqoZto7zGBP7l/jnxJTLut40eaO/q6qemJt5vAfyogRGhJ3
 Zvp99zEo4uUtK7ZLYZbAa6OVO2qcjhtU/XbCNaC7d1hp5fBy3jNPUUuPgkOO4pBfp5QPl91EiW2
 e1w+ylLxVo
X-Received: by 2002:a05:7301:6093:b0:2ba:a1a5:b5b1 with SMTP id
 5a478bee46e88-2c109584b61mr6077194eec.7.1774271758115; 
 Mon, 23 Mar 2026 06:15:58 -0700 (PDT)
X-Received: by 2002:a05:7301:6093:b0:2ba:a1a5:b5b1 with SMTP id
 5a478bee46e88-2c109584b61mr6077171eec.7.1774271757552; 
 Mon, 23 Mar 2026 06:15:57 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b14cadbsm14702574eec.3.2026.03.23.06.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 06:15:57 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com, marco.liebel@oss.qualcomm.com,
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH 06/13] target/hexagon: add v68 HVX IEEE float misc insns
Date: Mon, 23 Mar 2026 06:15:42 -0700
Message-Id: <c47bfbfbd95829c8493be298a9fb1f49a6584308.1774271525.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CYYFJbrl c=1 sm=1 tr=0 ts=69c13d0f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=QFng14Z7CN1KHDVayVwA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEwMyBTYWx0ZWRfX2Eu1vEEn4K7o
 fozT1tpvSLqdx/lQmI+cQ+vEtYBJ98ldOaT+looXzK/PgmMRlxBMvjOpi3MrzmUyHvPSFg8rIUA
 j8qMiccjpFehGUa7HOmBH6a1qjsvTR2qOYXX9LbnPINVG8nErjhSfh6+g+vw5cJ2Dy9jEX7uEvb
 +G8kNUGdEKy1JV9VzIPbLk8tfybZ9ZWLIHqkbM0nJWwvtT4jc2QG493CrbpeYd/NZMqTXUu0903
 sT0VPNwJBwwwc8t7/ez+v9VrqpNOp6tnVv9utlVafqoTiS1QC2y66y/E8HbWDlc+tjdY+xgLxUm
 PBnKvoZOUc30DZHUHJv9AZySHIuPcEsZsI+uJD364Dgx2F036aCOK9sDelP7MIRz/m9YfTRnTc5
 BKFroVFGM2aAeNNzYD5unUrBxLL/XOP00gmVDOc2CHAMxrDn6q6EItP7HVFGtlYfWoO3wXVdao9
 9s02dnasCA1CldoQiLg==
X-Proofpoint-GUID: J_aIG_2SqMh4XofJgt33mElrquPkLWT0
X-Proofpoint-ORIG-GUID: J_aIG_2SqMh4XofJgt33mElrquPkLWT0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0
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

Add HVX IEEE floating-point miscellaneous instructions:
- vassign_fp (vfmv): vector move
- vfneg_hf, vfneg_sf: vector floating-point negate
- vabs_hf, vabs_sf: vector absolute value

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/mmvec/kvx_ieee.h              |  3 +++
 target/hexagon/imported/mmvec/encode_ext.def |  7 +++++++
 target/hexagon/imported/mmvec/ext.idef       | 14 ++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/target/hexagon/mmvec/kvx_ieee.h b/target/hexagon/mmvec/kvx_ieee.h
index 78f546eb8e..263feb7e94 100644
--- a/target/hexagon/mmvec/kvx_ieee.h
+++ b/target/hexagon/mmvec/kvx_ieee.h
@@ -13,6 +13,9 @@
 #define FP32_DEF_NAN      0x7FFFFFFF
 #define FP16_DEF_NAN      0x7FFF
 
+#define signF32UI(a) ((bool)((uint32_t)(a) >> 31))
+#define signF16UI(a) ((bool)((uint16_t)(a) >> 15))
+
 /*
  * IEEE - FP ADD/SUB/MPY instructions
  */
diff --git a/target/hexagon/imported/mmvec/encode_ext.def b/target/hexagon/imported/mmvec/encode_ext.def
index 23fbb75743..7138e593dd 100644
--- a/target/hexagon/imported/mmvec/encode_ext.def
+++ b/target/hexagon/imported/mmvec/encode_ext.def
@@ -834,4 +834,11 @@ DEF_ENC(V6_vmax_hf,"00011111110vvvvvPP1uuuuu011ddddd")
 DEF_ENC(V6_vmin_hf,"00011111110vvvvvPP1uuuuu100ddddd")
 DEF_ENC(V6_vcvt_ub_hf,"00011111110vvvvvPP1uuuuu101ddddd")
 
+/* IEEE FP move, negate, abs instructions */
+DEF_ENC(V6_vassign_fp,"00011110--0-0110PP1uuuuu001ddddd")
+DEF_ENC(V6_vfneg_hf,"00011110--0-0110PP1uuuuu010ddddd")
+DEF_ENC(V6_vfneg_sf,"00011110--0-0110PP1uuuuu011ddddd")
+DEF_ENC(V6_vabs_hf,"00011110--0-0110PP1uuuuu100ddddd")
+DEF_ENC(V6_vabs_sf,"00011110--0-0110PP1uuuuu101ddddd")
+
 #endif /* NO MMVEC */
diff --git a/target/hexagon/imported/mmvec/ext.idef b/target/hexagon/imported/mmvec/ext.idef
index 43153366b1..5ef5baa404 100644
--- a/target/hexagon/imported/mmvec/ext.idef
+++ b/target/hexagon/imported/mmvec/ext.idef
@@ -3018,6 +3018,20 @@ ITERATOR_INSN_ANY_SLOT_2SRC(16,vmax_hf,"Vd32.hf=vmax(Vu32.hf,Vv32.hf)", \
 ITERATOR_INSN_ANY_SLOT_2SRC(16,vmin_hf,"Vd32.hf=vmin(Vu32.hf,Vv32.hf)", \
     "Vector min of hf input", VdV.hf[i] = qf_min_hf(VuV.hf[i], VvV.hf[i], &env->fp_status))
 
+/* IEEE FP move, negate, abs instructions */
+ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vassign_fp, "Vd32.w=vfmv(Vu32.w)", \
+    "Vector IEEE move", VdV.w[i]  = VuV.w[i])
+ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vfneg_hf, "Vd32.hf=vfneg(Vu32.hf)", \
+    "Vector IEEE neg: hf", VdV.hf[i] = (VuV.hf[i] ^ 0x8000))
+ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vfneg_sf, "Vd32.sf=vfneg(Vu32.sf)", \
+    "Vector IEEE neg: sf", VdV.sf[i] = (VuV.sf[i] ^ 0x80000000))
+ITERATOR_INSN_IEEE_FP_16_32_LATE(16, vabs_hf,  "Vd32.hf=vabs(Vu32.hf)", \
+    "Vector IEEE abs: hf", \
+    VdV.hf[i] = ((signF16UI(VuV.hf[i])) ? (VuV.hf[i] ^ 0x8000) : VuV.hf[i]))
+ITERATOR_INSN_IEEE_FP_16_32_LATE(32, vabs_sf,  "Vd32.sf=vabs(Vu32.sf)", \
+    "Vector IEEE abs: sf", \
+    VdV.sf[i] = ((signF32UI(VuV.sf[i])) ? (VuV.sf[i] ^ 0x80000000) : VuV.sf[i]))
+
 /******************************************************************************
  DEBUG Vector/Register Printing
  ******************************************************************************/
-- 
2.37.2


