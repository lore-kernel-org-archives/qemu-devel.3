Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C4B10F996A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXqP-0003lk-RE; Wed, 08 Apr 2026 14:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAXqM-0003R4-O7
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:41:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAVu4-0006p2-DN
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:37:21 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638GD8TM674162
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 16:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=D8XB9U6uJxW
 K1qSpayLLf8XN+ydkf0YDu+EikZ8lS78=; b=C+IX71Cs4R9IhiO/IcZXmPPq68o
 pe4k1Ql5fwozoenW3dg3AZONideh9V52PfBfcayN1S3WO9/RqV88dkS8/TtGL6QW
 1pQrZ3oUHzKBELLy5XZZqvBmJAx+BrEbSvVfePsNQOtXvd0CRbbA26I0GAtaAd2R
 HU1ZycbcB1aUNNc5NSzvw9Vxo4RkFsbHMqbhCTLuTiCj5VpJEZamGn+Rt67G3jAt
 e5S+eBmm/fWomIJDlY8iiz2NKy3QqGdxmZTOoakJYdhpdpC955jtQ1JpdO4BIkmI
 okdi6fWlpzDdoStOmQQbrCKi4GbRiGk4Vz4Tf1RsgIkZKe3k3szeFyHt4Ww==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddtbmr2h5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 16:37:19 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c709551ec08so115515a12.3
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775666238; x=1776271038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D8XB9U6uJxWK1qSpayLLf8XN+ydkf0YDu+EikZ8lS78=;
 b=TRDwW3WH4mo5W2SCZoZ/IYjL6qhMRAohBQEwxPIZUdmPGVM337VJ+M3J1Lc0ITmvcZ
 PFOs0z1N7HpDD0ipOenyyQG66tJaQKe/Ipixh3aCfRcb99LzcGjdgWLJwuWkU3Cl5l+H
 qRAJWRTtNB9Oc3oujgdafjdwnlvR8FvGhoDXWG+aSJpKc6QjRWMwTCwN9WIEtoSDaF53
 cCAVIKwadmXZ7ZwYNfbBsdiUCNClcUET3dwwNgsJloxXnOd66LLLYw1gtbT36QiyTBXj
 mvwBFX0XWoWxsCRFFkh1c0iKk+goOEe88YpU9435EwlB6YJtio+S1GV6VsaDqjOJuMP7
 PswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775666238; x=1776271038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D8XB9U6uJxWK1qSpayLLf8XN+ydkf0YDu+EikZ8lS78=;
 b=RRPP2aM8xtNpXxUElSLbD2sC/ZNO5QlHCDWSahPJdIVklDSuNdd5uGAYXyz1VOvf49
 8Jv7yR6/UyQEb2PTRrYC3GrbH+CT0l56L9MfOoHgKZ1prQXu8OBu/JRYlZQO/wr+P+/U
 j5OQrr3HmtCpRbQ0jX7mtFW0xG8gjPPSjFD1x/4J46fFXlBLaQnywy88uUJrMK5u2Y44
 caAc94wqIYK4yql+ZVZrLQ2W3n+YinMMBCrL8c9XvUF1tS7QhHkmUk+K/7jiJ0O+AgtC
 WTAzKg1FnB1+ZBO44ZLVyQ66kBiP14+SyRUJSlY2rzH6a+UyXZSeOg+LXvsSo3S+sE5W
 Ruwg==
X-Gm-Message-State: AOJu0YxaJO0zcGzFsU617dgtdibZocxK7LnC3wrPJ8B2eQOs8xGOclW2
 aZCIiGRXbuhtWAtYlgNDh78BWu+uQGuTcHlfRJpbRS/DlU9BgfHiN1ybu/E9apDF5GVnteiOQc0
 E2SVNLDoudbP//4a/wW2jK9+nhRtO+GVx0o+0CbKG1YXJS3N2WHoBtbDYpt/+c1ElNmOC
X-Gm-Gg: AeBDietBRtrOIK6obgIjCpH0ZNn1JyuUyoKBs5hEz+z+5Lvc/8/To1OiehoY2Ydhh89
 ZZ9Hw1aP4m3eiTSpTb9P9g0cv0vH3offVC0FiM9O+DuAHZg/Sey6igLfoUPJudfLrKjI0XGPypT
 BsWhZZj0F+7ZJp/siihFFmHUqAQHbC5brhvsclO3G6Z0qTKe98SSsyAL+DjcjPaRsO/ivRDF4wo
 NhwP+ZuWBKtWpioSvBoFkbS37ubU1IUX5yQW/QSiWWRLbFCZwqc8w3fkncyGEWryXg7NGkLRam3
 mVmg7qKUsJEGj7Hv+vTr7N1xZrb9ASaa8eACcFzezu1hu3baiAyGyUiwP/F2tZXs82E9U8JioLx
 cZufNDDyiiOyQ+rGeK158fbJAjWQhdihVrYlDjLaaLj05QiBrx1jggrta4Qu7I39jZA7aKVRbKB
 LnK4d1fiOe
X-Received: by 2002:a05:7022:6997:b0:128:d362:31e8 with SMTP id
 a92af1059eb24-12bfb74518amr11549439c88.20.1775666237881; 
 Wed, 08 Apr 2026 09:37:17 -0700 (PDT)
X-Received: by 2002:a05:7022:6997:b0:128:d362:31e8 with SMTP id
 a92af1059eb24-12bfb74518amr11549413c88.20.1775666237325; 
 Wed, 08 Apr 2026 09:37:17 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c1ff43d04sm4082006c88.4.2026.04.08.09.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:37:16 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v3 08/16] target/hexagon: add v68 HVX IEEE float misc insns
Date: Wed,  8 Apr 2026 09:36:59 -0700
Message-Id: <2aa7f105031465bdbd63c22bca6e2b77b92bab5f.1775665981.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dae6gfnzzDxSrSrbxgCZiA5OI61ZZ_bm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE1NCBTYWx0ZWRfX7Mb1IOquiQXN
 9e23zbIj8MTV1FCmFRkYRQJqqb3lnYtsNjxXokNaWFRJecF2bklSW7Ff3X8g1ruhZW5DqvLJ8ff
 fz+Jv47t2ZNj1o7kfD+Sh7wGlQ/uI/go7NXkp/xIP+To8AMSV0UHchYzhweL6nXU/txgxlIliSB
 hdggSckQrqlJyJTUcJO9aUEIT+XBIDQeoTrT+El1IdzH46s9KJs8sxXWnpExIh/jM8aO8F1OM2D
 NByv4/qf2b9pLEcVTB/wzgGdEb4KGxdvOHd/DX4lknb4VbV2Uu0+ACxne2vC4d5qVObVWHEbuMh
 W7OZJTE1l6WkaG/euqv2drbx/haUXb09zTa+wLwTbCZFhop5wAUSiaNP0LAmq4Wpg3LZXORDcqQ
 UWws1uz5lj8aHqFkVlY6yfUQ/5En+gw0rct5kwvWk6bveOLXkh7DflN7dQXgCtHdLxkyoqjbhd3
 v9zYuS36rHI6OX769Mg==
X-Authority-Analysis: v=2.4 cv=YM2vDxGx c=1 sm=1 tr=0 ts=69d6843f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=XuGYLkldsImkkdaR63EA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: dae6gfnzzDxSrSrbxgCZiA5OI61ZZ_bm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080154
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
index 0e9cace203..5312661684 100644
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
+    "Vector IEEE abs: sf", VdV.hf[i] = float32_abs(VuV.hf[i]))
+
 /******************************************************************************
  DEBUG Vector/Register Printing
  ******************************************************************************/
-- 
2.37.2


