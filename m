Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3942F8A163
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 11:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDL4M-00059F-7h; Thu, 16 Apr 2026 07:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wDL47-00056r-79
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wDL44-0003Ar-Bi
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:22 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G9YVtV1553264
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ZzRENYlKEMP
 WXVJIPHrKdHk5SD4R2N5ZAAlk3V6uJ1Y=; b=hweQ38cQM8tZvDlt6bv0fdLebkj
 FkzAjS8mLnwF42V7BOOYP6LcaeqNh9MMNUebPrea/YpS8yrwd04rpV8VDHxg1t9R
 U3C96cOdRgvK0le16vD8RAE6PjM9tGJzDJVC8jJDWj5F4VXOrqg18dpoPc/P8Taw
 n+8QeLFMDwrwpocs7NlsqADuIjIhEcAg+hRXux7EWNWH/bMpKxuhtVZiF5cJ5NPH
 RjJgpdU9PoKue+BQzhzDPRgw6cpeWbDcBzO4qu97454lEJCoxD9MetiRtSkEz8NB
 RJzpriqSgrQZMGlKHNrNxJS976459l/VE7oFkpxl0u6bKo+4bN9hgkPHOxw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djrsn9g8y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:39:18 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2d3a617ad90so27056431eec.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 04:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776339558; x=1776944358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZzRENYlKEMPWXVJIPHrKdHk5SD4R2N5ZAAlk3V6uJ1Y=;
 b=ID/Cp4UuH47ToZeNOzcCYSFM8vlyMfpMXvXnzPxlZQa1WsjbDlXNSgrx4XDaSWUGUD
 YIosejw/rmQ+AaqZCHajMlSqQloCR7rB98O9wrGxHO9NZT3T8b+IuGsiKtKeFSZ7HHOB
 wicZanB9H3BNNJ9e/iP7XIdPHFeZtqfjS+UQnPUm2ciOPN5pUl8JJHNueUfYu9JhQKQq
 fhloHnWRjrW6j7LMt0AEu6H+KR6ULHJnM+SjcgZpoPNOvOKgw8neKYfg0/GqWbSg2Ej3
 W4QeqxKMEECBSOq8f/M8Y0FWbvKO0baDlSUngKY319vvFdoSquP4a4dBm89V6gdlb+6m
 fK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776339558; x=1776944358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZzRENYlKEMPWXVJIPHrKdHk5SD4R2N5ZAAlk3V6uJ1Y=;
 b=Iy5BQO4550HMct5iptBt5hSb/y/WpZR4En8kbuD6yctwWI9dLnR9iWSzZi9uU6kv3p
 NyT3CKIcMxwhe6hi8G+QDoOYsps3XgPCnrAlkRaWyOE2whCIrfMciN5Wfa5kSFmI1LuK
 TxaU+DnYqSq8H6bR7RP2BPgtgiCaPmrmsQA9APd7koZ6opZbiYCarEnxMps0A4oR6IM/
 ePZMvgtSNRHyUCjmF+YDg+dyOhjcfZlB1hPXlJr7c56k5C1w9S2gi93mRzO4sk+BNaoO
 WCb8x/TqGDhoOHaoBCearkoiuePxkKY43uKYv+s31d6Bzsj6CZ2J2PVygH/JP6Ir+EBB
 d0ZA==
X-Gm-Message-State: AOJu0YzZzfsGprRaskU+SdJ49jf/uOvpQ0YxAOTu6lAMusYRbOxRGOXi
 8ka5JkznhbMAmxjfmPlI1iaBmChs/WYmg/LXYFcfS5diaci7czoVSz0Rc844Ofp7dtSZhiMfOn4
 Ffn5fAdx13dwIRvjDZYYmmKGUAEnRgWbFJPRzBxey3Z07zzPHyAuVzgb+lii1BVpSJY86
X-Gm-Gg: AeBDieufOpxymsx8bnkwJLX/7QvLAPX9RcEDOqj7e3t8I9SLs7ttPDaJiuC6bQP2qZY
 WtxtKk6HYDwDdAzr9IXcTi/Tiix0+gpMDxmFX2glNik9EMbOGjSL0EPouTmGL1qyQ2mL8GuzKXU
 WFyy2chrNchRUQ7V7NKSy9xg6NDWOo03fotQBaFLb1Y8YH7ChaXF4PSj2gM126wiZ1GdOPYavMU
 1KA15ayjU9H7KV2gcES32ZC2+ITK7pBXmpJJfG+fSX/BU9/ThGw2gLqPnJJAM1yjQmR9LfalIak
 kKxNHSX/b7Hd/QtXPr1e9C/jmg38k4Jxme2MTZgixfot4ZH0a6dlIe1ojx7tCsad1r/nkCqyrr6
 RcJp27NOOnQ7MOHTdumjocQU/6CMrKZ00CtOmG2lH6vIbeCtVpLXA55zlkWVmk2sCR07X+6nXFC
 94Gh3ZFe7sXqJUWhrJ8Ak=
X-Received: by 2002:a05:7301:434c:b0:2c1:6676:5ebd with SMTP id
 5a478bee46e88-2d587e7a9e8mr13980539eec.10.1776339557803; 
 Thu, 16 Apr 2026 04:39:17 -0700 (PDT)
X-Received: by 2002:a05:7301:434c:b0:2c1:6676:5ebd with SMTP id
 5a478bee46e88-2d587e7a9e8mr13980525eec.10.1776339557237; 
 Thu, 16 Apr 2026 04:39:17 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c10a65asm6845391eec.6.2026.04.16.04.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 04:39:15 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v5 08/16] target/hexagon: add v68 HVX IEEE float misc insns
Date: Thu, 16 Apr 2026 04:38:57 -0700
Message-Id: <0bd3279ca0bbf7c01548e3b4e7a9c8fdbdbe4ee1.1776339451.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hSS_mjQBZDNIgRfIjzICZuqPXX3Ca9g3
X-Proofpoint-GUID: hSS_mjQBZDNIgRfIjzICZuqPXX3Ca9g3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDExMCBTYWx0ZWRfX20zseLpbVoDJ
 dnonAcY2ta8+kDeGPwuG1RDkxo5yNXyNHM4y9kBgUBoww8yH2p3nFkIEza5HZIF77g2t7N4IUpe
 5Js4wOHbUurBkPR5daqbaWLHWqMDz9Cc4jEVYguxl1i2AycCdJJSXxLVY7oDdXSAjRxLu+7vQoi
 EjrHb8Y4d1MBe7j1tbmPky6hiUk9lq0ahC939vuir5ntgeoWTSiJNDoomypIxv+oRO2lZ1PCKMJ
 UY5T/DPGc/yQHY1HrVL4RJGpknIqskulEKa0tB/HkClf2AYWHQvWFXuFlh9VSpgOKaiL+01R9JJ
 Rqs9cXErnbV9NrtB1TWUsI2+ATjHdNOR5kXWv8JMpu7aL1ccGwRHPXbItr7rpi0PjKXAq2LGrKL
 NRC2ao9x6bBlonn77NVT7wz4oIsBjYhYxk/k92NTn7xX0d1tTdMhjbIwVI1A9o2zK8pNmKdyM4H
 a0cKpzxj9FqZiHNqi4Q==
X-Authority-Analysis: v=2.4 cv=EojiaycA c=1 sm=1 tr=0 ts=69e0ca66 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=287aDwLwmCB6td_Y28QA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160110
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


