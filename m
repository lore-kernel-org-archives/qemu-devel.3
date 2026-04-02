Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682FBD39410
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 10:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Fad-0004ib-8V; Thu, 02 Apr 2026 06:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8FaV-0004eb-0q
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:47:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8FaS-0007n9-77
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:47:46 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6329ojAi1551329
 for <qemu-devel@nongnu.org>; Thu, 2 Apr 2026 10:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nOvzeWfo1gz
 MP3it2e0DgF8ZBLHR2ZVPC9oC1yks6l8=; b=J9iNizoskDz3T4W7Dj5U4ogegjg
 PsFeu0csuUjNAj8ItUrY+DTZc6ev/braFFWA690TVuH2w4p0rtcGvCK8YLUKEYek
 5aYYYEZoKxFBQMXLOHj27xg6O5sz30MnW1DvvccKwOP7Kr9gAifbu4FxCo3RO+7F
 DAtegOH/kG2ZwV6EB/OsuEVgjqsNqWdb+kEbhvetw8xuBI8E9zeqrwIEdCmJStVh
 ixcvuKFUq6S2X1Xq9M4Bd190psFQ70ywvjqWkMo6pXe9RdpyP2gd/znQAP3i7Zv6
 KeEmbOoktgNvsohLA+UYBm5xWDpd/nhaoRndanWVBZi3bnSviujGjRCXb3w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9heesgvc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 10:47:38 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2c68a134df8so690190eec.1
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 03:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775126858; x=1775731658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nOvzeWfo1gzMP3it2e0DgF8ZBLHR2ZVPC9oC1yks6l8=;
 b=hr9QeBVUnNViA73fyMlhYACHRSTjATiAMGWzk7AsWvv0f256CBrUFSXoC4eihveOa4
 LIoeOu8SrSwGwtSFeZh2YduXVhuECJCVh35DewPEATt5yeyC6qKEH/E7pDOodj789Tpn
 We5sLudmjf3eMYchZy5ZXYDmBoj3ZiuFJ5eMsnOxKSCCh4yZIqGXJGold7HftWzl9L04
 8hkraudm/1+yTXVC4k4Rs5hbfzlprFHSflQHkKywaDhLDmeG3uw4OfN85xXkS0k/1elK
 YvEFuhPMKRkkHIz7zeW5a82P+fwaZPsz3IdKySKPaRjdjikEkSA7FCAk4oOmrKilADe+
 xVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775126858; x=1775731658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nOvzeWfo1gzMP3it2e0DgF8ZBLHR2ZVPC9oC1yks6l8=;
 b=g9KBYhemg5wri2aVvUF3x7Sjs4kZu+D+oMyvRnrSFkrOdCWRP33kiQA8Q/J4eL1KFr
 pxiDJi7MJaCQQZEgdF2J3Wa6o3Pk63QKg0IE7YSN5FW8wKS+q+uuT4dP0j1IJ362BEAR
 qmrZCK9z8Lo2lFQY638LOUVE/FroRrfbXmOW9nvZpDLJ8FdYHIla1imBNFT6V+7ALrzb
 mnsRj8gU6qBajTpl0euOZs0rneCskXBVeiopMUkUjLsuSKse2e6IinCqLDg7L5fWD6Pa
 qOi/H8EjQBqoj123YrXxV5XbS6GgfrccWvbHJ9JAZMUX1576Ci9eq6gAoM5mbF9zEErD
 b4Qw==
X-Gm-Message-State: AOJu0YxYPoxU34a1vLtUSvzCBsAPR6OOIMe3ZikhB9XI/+6LD6ealjFf
 PZ+kR2Y3Dx0CoK95990BKkW07p/gb8De16Ary/PDV0zdWc6/hkrHk6DCYojKb+DjwyjGIu9gIK/
 IZaJv3nW5HN9pPe1iN0O3f8Ggl9fhsisjwmZn9O6AlyEykTet0URLCb7n9xviKsYp3WIk
X-Gm-Gg: ATEYQzxO4bsObbdjJ5TOG2rp/wFEcQSrvYxqOx8hqTilIq+cUBH10xAXVCiQgcdevQG
 I5DVW771DrGZDSVmXzR+xhnP+esRX5UzNSL9SBaAhj9qKvPDyr5BtwCcH6CcgAxwyshOXhihajx
 tU/AixQiCVj6D0MYNyGP2eCxRXMnWmviE1f4j4oGxSi2f/A3kwodrfGCaJyVgrKVSA9QNUr0Thv
 PuehwImftxdzpWkUZ1VMnZP3m5paSlLoFHUM4jZ1MVOwNG9YkfYKGRNBe0Ds/EMaaKN9EaXfmSu
 GlFk/sJkRmEKR1o5RJ5/ylvVaksn1v6mR7WmauWtdLo9sn48MrWmWNyE+MTxHBJQKN2nDC8rM/h
 Pz5ZK/ARVqUPSiHlzMZIdlyRoR5V9B9SAGhxt3VXZ05Synw7ahffLtz/V36hbeOQd5EPZSJlALO
 0VL78Wy70y
X-Received: by 2002:a05:7300:ed0e:b0:2c0:c5e4:6057 with SMTP id
 5a478bee46e88-2c9328ac376mr3866696eec.19.1775126857965; 
 Thu, 02 Apr 2026 03:47:37 -0700 (PDT)
X-Received: by 2002:a05:7300:ed0e:b0:2c0:c5e4:6057 with SMTP id
 5a478bee46e88-2c9328ac376mr3866681eec.19.1775126857439; 
 Thu, 02 Apr 2026 03:47:37 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca7d00f5easm2004783eec.29.2026.04.02.03.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 03:47:37 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v2 02/16] target/hexagon: fix incorrect/too-permissive HVX
 encodings
Date: Thu,  2 Apr 2026 03:47:19 -0700
Message-Id: <529c8c9063f2f25d215727905d830bb0b19028e7.1775122853.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ULqYCN1JL0x5cGWePmQg4coLmD2vX8MS
X-Authority-Analysis: v=2.4 cv=VY36/Vp9 c=1 sm=1 tr=0 ts=69ce494a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=LtKSMYrkcOpncNoavBoA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: ULqYCN1JL0x5cGWePmQg4coLmD2vX8MS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA5NyBTYWx0ZWRfX/yir0TkesiLb
 J9A3JglncQZwdswpehP4ZVwsSe/CO3PpoBgChlyMyq1JNtLcILC9ffR2jpG03OFfzBV2WPSbXmR
 DepoXZ/T8Z7jwEhQ3F4tEWTfdVguVWSYPcSfAagYKIAM3EYGQ6TlxUMn2HPVLrLGosVIwwIfUIh
 SDDiw40J4mIXyrJ9R6Gnbs8BkyFJDTVp+HgheCWZMcfXjKIhuuPT4VxPVWm5t1CprdWqWyVp48T
 tRc0k7NOG7yMHG42DrUQP0fwZFJ3ve2KdXfZp8NKAHGqM4H5fYClHbAUUBXlcegWAKUFMrgY2Kb
 4uhukwBA5GEbF9ZhnWC9yvI28ABhBE0HiiWdmHhWPW9BtdvMNwcsNNjs6E0UBKt5tYLe7jMxMsH
 /ARbkCHOjK6W6BuAgih5AHTeS5jbLOJdNGe3fkjaWaxmUrS2Nm/lbecKf1ktlcawYtdHpvfF5mm
 j272pNfMX/k/6rUl7Qw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0
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


