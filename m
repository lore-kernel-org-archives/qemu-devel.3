Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F4010F996B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXqF-0002Vx-BM; Wed, 08 Apr 2026 14:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAXqB-0002GU-LE
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:41:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAVtz-0006nx-S7
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:37:18 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638G4R3V2845045
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 16:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nOvzeWfo1gz
 MP3it2e0DgF8ZBLHR2ZVPC9oC1yks6l8=; b=Zb3ar69CPS/Qb5ocrIbW4Z1Id2Z
 CRfmFcHYK/SfdDd6DhEQZbyRYYhwtdd+A0DYbcppn5Bcru1dgy29aXDhiMbq/qPA
 aPCahryKsc2rmNR79m3pe6Y36DFTrMuteJqzJ4z2dyRS9aLcH7L1oDPWBCvTPTl3
 fxlyscdSuSPEYqV3B1i1diFL52t3rZYk/tA/aUQVFJKQ/e3KtNZJ1Cfxq4q5pa2o
 70tl7HrMkPctsC8/1N0ZQdC0pRsV6MBV4ztPjNoiY9fwLsmd/DV/lbvwKB5dg2au
 noiIQtcuXMXMpcHPCB6+71XBH5h9BrSigCbciXXDTwVqY+2hvyskUDm0nKg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddt7hg3m2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 16:37:13 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c7422397574so140157a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 09:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775666232; x=1776271032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nOvzeWfo1gzMP3it2e0DgF8ZBLHR2ZVPC9oC1yks6l8=;
 b=EfF+YRNFQxCAz6RYzgrZL36/RXhLejPM8Xb9y2yGtNhKzwbOEnu+NW9zO0pReGR9TU
 Qh0rWhG9+5D9gcdzVjgnjE32dIiMqc7JamihXTADVIcTW/zDfZDVRqHTiwaYkfEQwbhX
 rz1xgCBLbTRjNWD8dV//khJJxmGkvUawoEeE4E/FoSKFTkYXWgpOS4D+zVhdkXUH4TCN
 Wu/Y5FqdrTFNZusJvvzwK6ZaorqB+HcN8MnEpdf00cmbdTITnvShcPN/qq1aErfZ1Gpw
 w1GDRN3Utep/fAfhhT/Pm/l2SMnjtc8+Kw+AFrYuk9eI1qJD72Dp59gArMUhmL1opopV
 S8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775666232; x=1776271032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nOvzeWfo1gzMP3it2e0DgF8ZBLHR2ZVPC9oC1yks6l8=;
 b=cSLfZOjLt9NKQ3ICL2q/SMPzwhMT4ElqiLy+ormuhokFldLfvpA1A5sh4pV1rg9Hzb
 j5EXS8GYTysx5rMntZLXXrQbiC7QqdxNK1JDX3zV38OMycWXoxUDgNUrjwbPp7a18JIC
 msN72r200+Ju5qJCvXpe90B0vPw97IqTiI+2jmXfQ14Kf4IzFgdyIyrwmn6iOcgJZnBy
 1xz9bXi8+t/W9rITIynEBxgK7lVGncLMx6EH6FTt+y7HnnvJW94ZXz0JVJZ3C9CDwEE6
 vRuu7tjMWKR9WMxgAHkDgm/l/2O8ZtEetSQddbies7Mem4eBVlug1aO1X7K5bxvDd+jE
 2nVQ==
X-Gm-Message-State: AOJu0YyDu23nZFRvbJx2/W8R3LxsS4G3km4XFtbI2t7xbVm1inUsYq++
 RVWKv8ZN0qp2pn6/Nili/GCr9XhTpZjxtHi1YUEGLrxyPXItOKzq/Yt1//jTXR5IZYR04ydd4pz
 Q2kfaJ3HbzztZRBexYQoDfp0AVxdwMpgiLH6w5jB8eG3RJQdtN4Zb826d0KW40TLx+HYW
X-Gm-Gg: AeBDievYxBoR8ga2iNWcTeyuNoxsiDkdwZ2MGwswl3UiRXNjNXiWfQNmwYXVlwkbjF/
 IyjLAK2bPGZveoOa4Jkh5rThi4d7xQF6amPsY46908w5Nbh/cpB1vyMUeAHEV/bb/9VDdL1BP+k
 lebjYjQ5hYqIVHl2Mw2IQEtim8V5YLL06LXUikSTBvFDIGuJtWX9LXlG0D+OWpa4bEWl8y1hVWJ
 xJ7+n9wNWMkW4b3ySwPC1/ql/jelaOcnnzu73Q7QhlMRpSbVlIHmI4wmo8j/93hx8MsEFwzA41B
 MFJ777ieze5qMhFXdP2L7skRugYwbP2+6WNoTSD7q5ENBZ1lCza+c4N5I7A3KHQG0Vd2MZhs4bh
 BDs5RY3fwUcTuVjky29tNuQUYZ0reFSs31Hqj7Iy1Ge58h8SrO429+su4lHg47tFBGra41w60Rb
 WnCZZ9hatG
X-Received: by 2002:a05:7022:384:b0:12c:8b9:7200 with SMTP id
 a92af1059eb24-12c28c1baddmr93654c88.17.1775666232137; 
 Wed, 08 Apr 2026 09:37:12 -0700 (PDT)
X-Received: by 2002:a05:7022:384:b0:12c:8b9:7200 with SMTP id
 a92af1059eb24-12c28c1baddmr93621c88.17.1775666231280; 
 Wed, 08 Apr 2026 09:37:11 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c1ff43d04sm4082006c88.4.2026.04.08.09.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:37:10 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v3 02/16] target/hexagon: fix incorrect/too-permissive HVX
 encodings
Date: Wed,  8 Apr 2026 09:36:53 -0700
Message-Id: <c63e568f6cd1e9dc26f0112aff3ef039b081e83b.1775665981.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=O5IJeh9W c=1 sm=1 tr=0 ts=69d68439 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=LtKSMYrkcOpncNoavBoA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: Q9BOEHHNIS6jQt3vRyckvOFl2leYJD_v
X-Proofpoint-GUID: Q9BOEHHNIS6jQt3vRyckvOFl2leYJD_v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE1NCBTYWx0ZWRfXysYCbGAKitJV
 Qlm9UP4/1QtvwBrWe78X3nLXkg1rPh6n4q9wjbQz7jc4xZZxTwbOdtCVswLLaH1Oot97wtxYcHk
 7J2qy81J4q4SSt26A5yqyYafTqIEHaRxV1oh8vUyojKB7gP19TSx7UXTGS8XE9rdZXoiPGYH1db
 Kw5vPia9PRYf+pxC8OS5a0H78ZvhrYDgZR0QpcA8BGbKDQbvs1AQYnn5EsHJJ/XYGqlpwJdzFDj
 nhBKi4G1ntEAPJKuHacqqBeQ6h5aHveqMKMBngn/jUN9qRV2J5X2lQsV/3tXB7RpiUBRSRApzUJ
 7PI8UpnSk3mbOTscqeHr0cfis2jo1wK7uHypT27mOgqC37o8teQ4YGjVrq0Tk3znEAlzbInSS9F
 d+rRlDblOq8odgj7Em6V+vvhXb8IdvF+LIsC4+gPF0gbBS9IA1TWIIej48VTMH2rIS0CycrBMQg
 7Zc1bQhn/8f+rwX4j3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0 phishscore=0
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

The following encodings have become stricter since v68:

    - V6_vunpackob, V6_vunpackoh: ---00 -> --000
    - V6_vaddbq/hq/wq, V6_vaddbnq/hnq/wnq: ---01 -> --001
    - V6_vsubbq/hq, V6_vsubwq/bnq/hnq/wnq: ---01/---10 -> --001/--010
    - V6_vhist, V6_vwhist128/256, V6_vwhist128/256_sat: ---00 -> --000
    - V6_vhistq, V6_vwhist128/256q, V6_vwhist128/256q_sat: ---10 -> --010

Pre v68 compilers, by default, already use "0" for the non-specified bit
that changed in v68, so unless someone is manually writing the binary
encoding, this should not cause any backwards incompatibility with
pre-v68 binaries.

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/imported/mmvec/encode_ext.def | 48 ++++++++++----------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/target/hexagon/imported/mmvec/encode_ext.def b/target/hexagon/imported/mmvec/encode_ext.def
index 402438f566..6d70086b5f 100644
--- a/target/hexagon/imported/mmvec/encode_ext.def
+++ b/target/hexagon/imported/mmvec/encode_ext.def
@@ -647,36 +647,36 @@ DEF_ENC(V6_vsubububb_sat,    ICLASS_CJ" 1 110 101 vvvvv PP 0 uuuuu 101 ddddd")
 DEF_ENC(V6_vmpyewuh_64,        ICLASS_CJ" 1 110 101 vvvvv PP 0 uuuuu 110 ddddd")
 
 DEF_FIELDROW_DESC32(        ICLASS_CJ" 1 110 --0 ----- PP 1 ----- ----- ---","Vx32=Vu32")
-DEF_ENC(V6_vunpackob,         ICLASS_CJ" 1 110 --0 ---00 PP 1 uuuuu 000 xxxxx") //
-DEF_ENC(V6_vunpackoh,         ICLASS_CJ" 1 110 --0 ---00 PP 1 uuuuu 001 xxxxx") //
+DEF_ENC(V6_vunpackob,         ICLASS_CJ" 1 110 --0 --000 PP 1 uuuuu 000 xxxxx") //
+DEF_ENC(V6_vunpackoh,         ICLASS_CJ" 1 110 --0 --000 PP 1 uuuuu 001 xxxxx") //
 //DEF_ENC(V6_vunpackow,     ICLASS_CJ" 1 110 --0 ---00 PP 1 uuuuu 010 xxxxx") //
 
-DEF_ENC(V6_vhist,            ICLASS_CJ" 1 110 --0 ---00 PP 1 -000- 100 -----")
-DEF_ENC(V6_vwhist256,        ICLASS_CJ" 1 110 --0 ---00 PP 1 -0010 100 -----")
-DEF_ENC(V6_vwhist256_sat,    ICLASS_CJ" 1 110 --0 ---00 PP 1 -0011 100 -----")
-DEF_ENC(V6_vwhist128,        ICLASS_CJ" 1 110 --0 ---00 PP 1 -010- 100 -----")
-DEF_ENC(V6_vwhist128m,        ICLASS_CJ" 1 110 --0 ---00 PP 1 -011i 100 -----")
+DEF_ENC(V6_vhist,            ICLASS_CJ" 1 110 --0 --000 PP 1 -000- 100 -----")
+DEF_ENC(V6_vwhist256,        ICLASS_CJ" 1 110 --0 --000 PP 1 -0010 100 -----")
+DEF_ENC(V6_vwhist256_sat,    ICLASS_CJ" 1 110 --0 --000 PP 1 -0011 100 -----")
+DEF_ENC(V6_vwhist128,        ICLASS_CJ" 1 110 --0 --000 PP 1 -010- 100 -----")
+DEF_ENC(V6_vwhist128m,        ICLASS_CJ" 1 110 --0 --000 PP 1 -011i 100 -----")
 
 DEF_FIELDROW_DESC32(        ICLASS_CJ" 1 110 --0 ----- PP 1 ----- ----- ---","if (Qv4) Vx32=Vu32")
-DEF_ENC(V6_vaddbq,             ICLASS_CJ" 1 110 vv0 ---01 PP 1 uuuuu 000 xxxxx") //
-DEF_ENC(V6_vaddhq,             ICLASS_CJ" 1 110 vv0 ---01 PP 1 uuuuu 001 xxxxx") //
-DEF_ENC(V6_vaddwq,             ICLASS_CJ" 1 110 vv0 ---01 PP 1 uuuuu 010 xxxxx") //
-DEF_ENC(V6_vaddbnq,         ICLASS_CJ" 1 110 vv0 ---01 PP 1 uuuuu 011 xxxxx") //
-DEF_ENC(V6_vaddhnq,         ICLASS_CJ" 1 110 vv0 ---01 PP 1 uuuuu 100 xxxxx") //
-DEF_ENC(V6_vaddwnq,         ICLASS_CJ" 1 110 vv0 ---01 PP 1 uuuuu 101 xxxxx") //
-DEF_ENC(V6_vsubbq,             ICLASS_CJ" 1 110 vv0 ---01 PP 1 uuuuu 110 xxxxx") //
-DEF_ENC(V6_vsubhq,             ICLASS_CJ" 1 110 vv0 ---01 PP 1 uuuuu 111 xxxxx") //
+DEF_ENC(V6_vaddbq,             ICLASS_CJ" 1 110 vv0 --001 PP 1 uuuuu 000 xxxxx") //
+DEF_ENC(V6_vaddhq,             ICLASS_CJ" 1 110 vv0 --001 PP 1 uuuuu 001 xxxxx") //
+DEF_ENC(V6_vaddwq,             ICLASS_CJ" 1 110 vv0 --001 PP 1 uuuuu 010 xxxxx") //
+DEF_ENC(V6_vaddbnq,         ICLASS_CJ" 1 110 vv0 --001 PP 1 uuuuu 011 xxxxx") //
+DEF_ENC(V6_vaddhnq,         ICLASS_CJ" 1 110 vv0 --001 PP 1 uuuuu 100 xxxxx") //
+DEF_ENC(V6_vaddwnq,         ICLASS_CJ" 1 110 vv0 --001 PP 1 uuuuu 101 xxxxx") //
+DEF_ENC(V6_vsubbq,             ICLASS_CJ" 1 110 vv0 --001 PP 1 uuuuu 110 xxxxx") //
+DEF_ENC(V6_vsubhq,             ICLASS_CJ" 1 110 vv0 --001 PP 1 uuuuu 111 xxxxx") //
 
-DEF_ENC(V6_vsubwq,             ICLASS_CJ" 1 110 vv0 ---10 PP 1 uuuuu 000 xxxxx") //
-DEF_ENC(V6_vsubbnq,         ICLASS_CJ" 1 110 vv0 ---10 PP 1 uuuuu 001 xxxxx") //
-DEF_ENC(V6_vsubhnq,         ICLASS_CJ" 1 110 vv0 ---10 PP 1 uuuuu 010 xxxxx") //
-DEF_ENC(V6_vsubwnq,         ICLASS_CJ" 1 110 vv0 ---10 PP 1 uuuuu 011 xxxxx") //
+DEF_ENC(V6_vsubwq,             ICLASS_CJ" 1 110 vv0 --010 PP 1 uuuuu 000 xxxxx") //
+DEF_ENC(V6_vsubbnq,         ICLASS_CJ" 1 110 vv0 --010 PP 1 uuuuu 001 xxxxx") //
+DEF_ENC(V6_vsubhnq,         ICLASS_CJ" 1 110 vv0 --010 PP 1 uuuuu 010 xxxxx") //
+DEF_ENC(V6_vsubwnq,         ICLASS_CJ" 1 110 vv0 --010 PP 1 uuuuu 011 xxxxx") //
 
-DEF_ENC(V6_vhistq,            ICLASS_CJ" 1 110 vv0 ---10 PP 1 --00- 100 -----")
-DEF_ENC(V6_vwhist256q,        ICLASS_CJ" 1 110 vv0 ---10 PP 1 --010 100 -----")
-DEF_ENC(V6_vwhist256q_sat,    ICLASS_CJ" 1 110 vv0 ---10 PP 1 --011 100 -----")
-DEF_ENC(V6_vwhist128q,        ICLASS_CJ" 1 110 vv0 ---10 PP 1 --10- 100 -----")
-DEF_ENC(V6_vwhist128qm,        ICLASS_CJ" 1 110 vv0 ---10 PP 1 --11i 100 -----")
+DEF_ENC(V6_vhistq,            ICLASS_CJ" 1 110 vv0 --010 PP 1 --00- 100 -----")
+DEF_ENC(V6_vwhist256q,        ICLASS_CJ" 1 110 vv0 --010 PP 1 --010 100 -----")
+DEF_ENC(V6_vwhist256q_sat,    ICLASS_CJ" 1 110 vv0 --010 PP 1 --011 100 -----")
+DEF_ENC(V6_vwhist128q,        ICLASS_CJ" 1 110 vv0 --010 PP 1 --10- 100 -----")
+DEF_ENC(V6_vwhist128qm,        ICLASS_CJ" 1 110 vv0 --010 PP 1 --11i 100 -----")
 
 
 DEF_ENC(V6_vandvqv,            ICLASS_CJ" 1 110 vv0 ---11 PP 1 uuuuu 000 ddddd")
-- 
2.37.2


