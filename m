Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E384CD39410
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 10:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8FaZ-0004h5-T1; Thu, 02 Apr 2026 06:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8FaX-0004fs-53
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:47:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8FaU-0007nx-L2
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:47:48 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6328dAhQ1249508
 for <qemu-devel@nongnu.org>; Thu, 2 Apr 2026 10:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=soNRWiA+58L
 ShvYtPlR5O15pOIyvGIp2qUYXHskXHes=; b=HC0+4T/Ueh8B2x3i1VRjK8pxj4x
 r74u6SOmZYeWqNThA13T1JoOPJmiXfv7X3peFmSVDV8mcDW1I9EH93UxxoG8WQ5W
 hdUoUSrJenbtsnosENg+ycZ4eVaVq5aW0XwQh+UbyB4VuOZg5FlXVfjll7jR/8kF
 mXK6XP4sRaVVk0ZkW/Y+o4i/RutcnkYmiDK3Sl+2AT6x63GLN4ziWElcDPSEHppP
 zxRfMXsjr/Av6GmokbgKX19DvMmCP42pVRVyqKdUPEZTYpbxZRTXBYMCzHGkPlOh
 vYFwM/2mZHPjZF1J6x0oTQAd2sUYyLJ05dYRD2KvVTLqaPTvyEQwyuWREIg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9n4t0fsn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 10:47:44 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ba9a744f7dso1115327eec.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 03:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775126864; x=1775731664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=soNRWiA+58LShvYtPlR5O15pOIyvGIp2qUYXHskXHes=;
 b=XY1gOkUQV0j6vreqTKA7DHONkdO36yZ2Y68q30E6XnuxfwueV2xpmcYaQIjdz4FfxT
 fZeeNQXm856cXSyKIu/KrDoG/2gXh5jherLqkWnOI5jeXp3ZTUYHyfwonXv4t/IYAAxK
 MoeQpBZgicHF/mlv5HH94rk2CWDMsDkp2DXFSNQZU6cc/SVS/N+coY1HTWCm8S625Dhg
 ebh/zDzC56xhOtJ51hDYpGuaH4d8jeIyqz2hM/ReGjeh2OwSW7qdE1ZAmYYxHE+jFUXO
 C2UsoSYHmeR7OyIlcV5VRZ6lkOByRzfdkntFXEx7gUnqoU1VU7YIUYguvtsW+viWZqx1
 hOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775126864; x=1775731664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=soNRWiA+58LShvYtPlR5O15pOIyvGIp2qUYXHskXHes=;
 b=FcGNWHPjuoTVkDS1NXCXXtWU/B89SSDBNTYLw5uEPunLFke59gAfXo1g/yi4ucrqi1
 aHJZL9QMFo+cd2c5A0QPehqasB9bBmllu5PM0BUeRVCd1FdbcvkK4Wsb3Jg5OqZh7x5Z
 xMe4/lZuSxmznL5t/AsV6sT+A2aZ+32xI6Sp/oycLI/JvmpqGsHXIbcUaRAwxe43RAzf
 Tm9wuQBVJRIKXiIlPzyJum3aUP9BWnv9R9B2fsfal9m+Yo00xe7bzUBnuakj1gDkDDBx
 1es+I41R5UtSHSn7Bz8hN5vVdc0zC48KnmJTUHW6wH2Fx0jbp+3eJRb6Zv6fvZN5Dmja
 8miQ==
X-Gm-Message-State: AOJu0Yx8SqqY5rZlf85LgTXI1TDa7m3GxBruHDS3zrv8Ni2sKPdHgVYN
 yjY/1PM9ToM9DgOWBgNS9fB96lVCEgMCgJFT+T99eIsuHRMspGBotkhcsp/kuHqamLyLYGu6Vn+
 JTeZz4Zl08gs2cQItHa165/JmHlMGgCg5PCc8aJpxMRIgY5Hf2dGzfFhTJay3vWmcKbTW
X-Gm-Gg: AeBDietHa8NGa4/yOgfKvObNMkymrGa3GTbvuAqEAkbHQAd42xc+QJQaQKDVbqY40Ja
 QG+8X5rXGH09+n6b2zi5R9LNeZ3bY/hGhnQwk+rU3smjiRoCyZSnzNmsSaqson9ZZeS/eaUQmuE
 WcQCZ+7EQjTWEn4ACUb77C02Bf9yq7j23/nwLC0+rFxAdIVjCqSbLtS4Qn38VeJKtKYZLrwniL+
 z0pQ+J/BVwhGCkl+i6SmKoXGZhJ7iveEL24MkoUB0roem8TbB/hR3HbUE4crhnEV871klCCrkyk
 rnPls9c/n5Qr6W618cWix4qPGcALS/Z+ZveJ1hhn4R0lbRpR6ItdLNzinpuO4VpdOtt3aV8oyVi
 GCNBu9BF71ixy0w7RL7F1vqXcV69zI4cd2O0T79HBUUzRtEF6To1BoydTaGlZY90NvBwZ0WVGjR
 1ECllCOMV9
X-Received: by 2002:a05:7300:d50e:b0:2c1:6cfd:73d4 with SMTP id
 5a478bee46e88-2ca8f7452f2mr1379155eec.23.1775126864202; 
 Thu, 02 Apr 2026 03:47:44 -0700 (PDT)
X-Received: by 2002:a05:7300:d50e:b0:2c1:6cfd:73d4 with SMTP id
 5a478bee46e88-2ca8f7452f2mr1379138eec.23.1775126863692; 
 Thu, 02 Apr 2026 03:47:43 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca7d00f5easm2004783eec.29.2026.04.02.03.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 03:47:43 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v2 08/16] target/hexagon: add v68 HVX IEEE float misc insns
Date: Thu,  2 Apr 2026 03:47:25 -0700
Message-Id: <7d1812d87058379ae9b4c2e9adcdf1cdb9eafb26.1775122853.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Vberd3zamJEK9ZT5LmHMaS1etuvD3IKu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA5NyBTYWx0ZWRfX26wAynXiZDOl
 kHKiaJOQZG99Xzo2Hnsgw/U0NMkuBv8hdCfWF5UDKxlg/MB4ly1oBgWSG0lxws8BaHOwPcNjSpf
 f381PMdYx7BUeMZ+lyGOobesNnQuqXIdxk3Ca0QE/NtpSfDEACYBmOmRMrdsf5ihJ0KsefsGNwk
 yyrf2pz6f7E965z97EGGDFdHw+IWH6ftrGk9wjBmRLpuF6BlAJsemox9Iv3oZsGbhJ3aCLgSUel
 8DRNsI2dxJy66lrUNlDf38etCUDSg9eVTyZ+vAH1YbVLFwEn2y8qqDaNjwzlNzwZlPAuPjWWMev
 0zNKCtJlfeI5lfgrl8zTWMHSxspB05RJL6nD4Mo/F1shux6g0tPza1g/xyH1diQ+ttBJDp/V0qa
 88a1Dbb6f7YjuRGg2UrCHkoRc50ckuAq7rcjYrJRpRDkxyxG2deaFNqa6BSuNUzVILvsdDKeU9Y
 1QbusdEuWROlO1U3q0w==
X-Proofpoint-GUID: Vberd3zamJEK9ZT5LmHMaS1etuvD3IKu
X-Authority-Analysis: v=2.4 cv=Ap/jHe9P c=1 sm=1 tr=0 ts=69ce4950 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=b_pcDZiHv-GACHTOAAQA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020097
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

Add HVX IEEE floating-point miscellaneous instructions:
- vassign_fp (vfmv): vector move
- vfneg_hf, vfneg_sf: vector floating-point negate
- vabs_hf, vabs_sf: vector absolute value

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
index 19135853d4..54bed47083 100644
--- a/target/hexagon/imported/mmvec/ext.idef
+++ b/target/hexagon/imported/mmvec/ext.idef
@@ -3026,6 +3026,18 @@ ITERATOR_INSN_ANY_SLOT_2SRC(16,vmin_hf,"Vd32.hf=vmin(Vu32.hf,Vv32.hf)", \
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
+    "Vector IEEE abs: sf", VdV.hf[i] = float32_abs(VuV.hf[i]))
+
 /******************************************************************************
  DEBUG Vector/Register Printing
  ******************************************************************************/
-- 
2.37.2


