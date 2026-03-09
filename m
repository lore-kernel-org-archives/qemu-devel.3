Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C992F417EE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbv3-0001Tr-S2; Mon, 09 Mar 2026 10:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbux-00013j-5u
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbus-0005HW-QK
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:09 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629C5bDX526729
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8T6s34EiRvc+eZo2vQ6nD9tceOpn0K2a9cMDWgc0Ys8=; b=n/FV6Whd1tehg4xa
 9zB9vLBLB/Fl0qKG2Pg/JleIk2aYwBrFLuR71QTGvSf3h1ywnGULolsmdZB/IPi/
 py+D07ZVQYEyJvjkvg4BTB4cupDecz9+89L5rH0z93Cm23N0d+N/F4zvLY5Ne7rq
 cFkSZplt809RRCxfbWVR54MNe76Wj6m3MNVezcA6DT4y5EPBv9EeCjJPN7rhzCWN
 BrY9lszQCKZp/r/Lb+J40cXPNPA1/JMnI++Xdd8armx4n3FwMHP1ts59sIBJYIKM
 bga+xjy8VkKSwEWawaZwQNHuR6GwlzmNRhPQMayLQ1gRIOx+gLX+6XZ43B7s8G7B
 clqfFw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cswwkgg68-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:55 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2be0575e290so6879112eec.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067734; x=1773672534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8T6s34EiRvc+eZo2vQ6nD9tceOpn0K2a9cMDWgc0Ys8=;
 b=IeYsD8u6HDwWp4g6xWAQNqrHyYdLGtoYd/iCsrN3hXMbMCpblK3dU5gdtsHBoGPAvO
 8Y6fa4Pd2kIQpAggccROmB967Sawu8YYDKpyPcMflgRIpA/nFmcTiJ6x/6PJC5aVe7dN
 c/+yrD6QDa4MirmaHtVetSeuzm3FmwRlm/aeyUFMEEtNIm46Yx+BoWqoylmCunQRCJLN
 djBnhrWftQtVU7MuKGo95XaTOulqIdFtgKYNbuRa6kYMbmhsZ2yh0w45vycHv5mWxatR
 akVReYi9ZMuSNJ9o66rKj8ju/hu/XKSkNCyCxuI9UgFz2ZAKOS1t/DjqqyQ/y33fX/Kk
 AYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067734; x=1773672534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8T6s34EiRvc+eZo2vQ6nD9tceOpn0K2a9cMDWgc0Ys8=;
 b=UOvKlBjQCJ33h3yNvewsCrGzYoePorbQBuObmSHonNtmuTXey4smnTMS3fIcrRJazT
 QunkdWvLga4Fs1fFGAEeBuZa3OannhkV/tIFev/yslMWna93BezVvjWa/TUI9ii31JG4
 IuTXpKwH86+swLa0ChaQK1JFOQRzWnB1NmGowMLnMJavnn6MUHFaWBQLE6AVACQFmR6H
 JjAW3Td4s3W7kA8AlxYckiXDmfTLYdl8qtMRaPHUKG1jpoKecRRKSGPuDtYoSEx5mVVJ
 qHQORWf2YKhNEEFZgJiNGB5UuueneUfJIKffqM444qvxyk5IH1+WBLSioTS/xEZJWs8A
 F//Q==
X-Gm-Message-State: AOJu0Yx7aSqXtU43VRs18pUfAgz9sFTv/aF0obwXJ0cVnxFvrlAm2DG8
 9wXMNWcPsRIvK/knVRrCaat0lp2dyLWw/vKfGp5dtbs6CF/NwkJPkJhMLgjlf3rWi5GPo+sx8J0
 81lSccLlzstRolMRJv2ds12B+lJT2ayE2rcpYuMx6spTyFgxy/zsVAljf0gUcYbGELg==
X-Gm-Gg: ATEYQzw40B/9u+KQCbNb36N4BF6mlRNsXGf7N4ixWCHSZnpPiC0miTho/D2BZOYJXBu
 nGlI+ylJXIKT1ivgWeKLJMziS4wCcyhDy84m0VvaW05DoLuXW4wqSvkGfvC631ZCdonZiVYYpXa
 kWy//LGQWnkJuiLFzsBCzCr2dF3np0kGWryev4W/UTpcmWw01QK41rLevtXV79XQJrOqAeOwfWg
 Zia8/WYfjQfO2wAc8NV+/rm0N3k7LoqMEnJYFv2o3Bzv33amI2x7f9tj01yMkUJDd8YwZz7+rDU
 3iJDxZOM6ImnDfDorlgeD0u8aSzEtbWRlwgtCYv4DWHdLPf1TFB1H+sRx+3xVynZI7NzUjfPCuw
 of1jl8qqNJ37dgSz0Dcf0f7C/r7VE/tSWAx2V0KJ9n7G+S4YAwD7/9I3yJF4PV/nUmj54nw==
X-Received: by 2002:a05:7300:a985:b0:2be:79a:6a16 with SMTP id
 5a478bee46e88-2be4e057159mr4121196eec.21.1773067733798; 
 Mon, 09 Mar 2026 07:48:53 -0700 (PDT)
X-Received: by 2002:a05:7300:a985:b0:2be:79a:6a16 with SMTP id
 5a478bee46e88-2be4e057159mr4121149eec.21.1773067732978; 
 Mon, 09 Mar 2026 07:48:52 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:52 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 23/35] target/hexagon: Add system reg insns
Date: Mon,  9 Mar 2026 07:48:10 -0700
Message-Id: <20260309144822.877695-24-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=cZ/fb3DM c=1 sm=1 tr=0 ts=69aeddd7 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Lq-sf-uUdcGOnWOb84QA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: zD-_JMGhHOrMtnI56Ud3lmxAb_47B-jd
X-Proofpoint-GUID: zD-_JMGhHOrMtnI56Ud3lmxAb_47B-jd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfXwgzbMBnkPLZX
 Cb82m0mD7ZXjBQgYceFrDRDWkwIo6yRbtARR222hmxTCXAABmFt5mo/MAYRYeom7cSHpGuo5F5g
 Kp6YbZxx0TfDsb3YslL2jfduf8/u+LyWmmZmMLBPo14jLVlwZCMAaiDNyir35qQE9r2vvq2wpRN
 VefH2jmuOf1r7J9VnZC8T/3Q0eDjTOy4uHORFr4FW+Ws3XD0+1QUi4+vbXzaJNqJZw07vZZ072a
 AaIC5G9Xr+Vby7TS29PVEAJcFdmIru+bhH//Dfug8whFffoJtx6YiFv+FKAK2KBS0YyK+ZU582V
 6wCUFyBpd/DqbMIhu8wOZdDV3hHwHGW/8LAPmunuY5OO1E6ZOse5P16B7rN8M3r/umsJXB1bO99
 7gwFoMJihYWp7HTGKLKR7mhl0RRxS9rV6RqUWGXaiZoRxSIgLnJ9kOgNlJ7eVQBRSEV4gKUTeqm
 l4YMXY5A6intwQaMIww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090133
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

From: Brian Cain <bcain@quicinc.com>

Acked-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/imported/encode_pp.def | 128 ++++++++++++--
 target/hexagon/imported/system.idef   | 244 ++++++++++++++++++++++++--
 2 files changed, 345 insertions(+), 27 deletions(-)

diff --git a/target/hexagon/imported/encode_pp.def b/target/hexagon/imported/encode_pp.def
index 0cd30a5e857..04e911f59c8 100644
--- a/target/hexagon/imported/encode_pp.def
+++ b/target/hexagon/imported/encode_pp.def
@@ -382,15 +382,18 @@ DEF_ENC32(L4_return_fnew_pt,  ICLASS_LD" 011 0 000 sssss PP1110vv ---ddddd")
 DEF_ENC32(L4_return_tnew_pnt, ICLASS_LD" 011 0 000 sssss PP0010vv ---ddddd")
 DEF_ENC32(L4_return_fnew_pnt, ICLASS_LD" 011 0 000 sssss PP1010vv ---ddddd")
 
-DEF_ENC32(L2_loadw_locked,ICLASS_LD" 001 0 000 sssss PP000--- 000ddddd")
-
+/** Load Acquire Store Release Encoding **/
 
+DEF_ENC32(L2_loadw_locked,    ICLASS_LD" 001 0 000 sssss PP000--- 000ddddd")
+DEF_ENC32(L4_loadd_locked,    ICLASS_LD" 001 0 000 sssss PP010--- 000ddddd")
 
 DEF_ENC32(L2_loadw_aq,        ICLASS_LD" 001 0 000 sssss PP001--- 000ddddd")
 DEF_ENC32(L4_loadd_aq,        ICLASS_LD" 001 0 000 sssss PP011--- 000ddddd")
 
-DEF_ENC32(R6_release_at_vi,    ICLASS_ST" 000 01 11sssss PP0ttttt --0011dd")
-DEF_ENC32(R6_release_st_vi,   ICLASS_ST" 000 01 11sssss PP0ttttt --1011dd")
+
+DEF_ENC32(S2_storew_locked,   ICLASS_ST" 000 01 01sssss PP-ttttt ----00dd")
+DEF_ENC32(S4_stored_locked,   ICLASS_ST" 000 01 11sssss PP0ttttt ----00dd")
+
 
 DEF_ENC32(S2_storew_rl_at_vi,  ICLASS_ST" 000 01 01sssss PP-ttttt --0010dd")
 DEF_ENC32(S2_storew_rl_st_vi, ICLASS_ST" 000 01 01sssss PP-ttttt --1010dd")
@@ -398,17 +401,15 @@ DEF_ENC32(S2_storew_rl_st_vi, ICLASS_ST" 000 01 01sssss PP-ttttt --1010dd")
 DEF_ENC32(S4_stored_rl_at_vi,  ICLASS_ST" 000 01 11sssss PP0ttttt --0010dd")
 DEF_ENC32(S4_stored_rl_st_vi, ICLASS_ST" 000 01 11sssss PP0ttttt --1010dd")
 
-DEF_ENC32(L4_loadd_locked,ICLASS_LD" 001 0 000 sssss PP010--- 000ddddd")
-DEF_EXT_SPACE(EXTRACTW,   ICLASS_LD" 001 0 000 iiiii PP0iiiii -01iiiii")
+DEF_ENC32(R6_release_at_vi,    ICLASS_ST" 000 01 11sssss PP0ttttt --0011dd")
+DEF_ENC32(R6_release_st_vi,   ICLASS_ST" 000 01 11sssss PP0ttttt --1011dd")
+
+DEF_EXT_SPACE(EXTRACTW,   ICLASS_LD" 001 0 000 iiiii PP0iiiii 001iiiii")
 DEF_ENC32(Y2_dcfetchbo,   ICLASS_LD" 010 0 000 sssss PP0--iii iiiiiiii")
 
 
 
 
-
-
-
-
 /*******************************/
 /*                             */
 /*                             */
@@ -488,13 +489,17 @@ STD_PST_ENC(rinew, "1 101","10ttt")
 /*                               x bus/cache     */
 /*                                    x store/cache     */
 DEF_ENC32(S2_allocframe,   ICLASS_ST" 000 01 00xxxxx PP000iii iiiiiiii")
-DEF_ENC32(S2_storew_locked,ICLASS_ST" 000 01 01sssss PP-ttttt ----00dd")
-DEF_ENC32(S4_stored_locked,ICLASS_ST" 000 01 11sssss PP0ttttt ----00dd")
+DEF_ENC32(Y5_l2locka,      ICLASS_ST" 000 01 11sssss PP1----- ------dd")
 DEF_ENC32(Y2_dczeroa,      ICLASS_ST" 000 01 10sssss PP0----- --------")
 
 
 DEF_ENC32(Y2_barrier,      ICLASS_ST" 100 00 00----- PP------ 000-----")
 DEF_ENC32(Y2_syncht,       ICLASS_ST" 100 00 10----- PP------ --------")
+DEF_ENC32(Y2_l2kill,       ICLASS_ST" 100 00 01----- PP-000-- --------")
+DEF_ENC32(Y5_l2gunlock,    ICLASS_ST" 100 00 01----- PP-010-- --------")
+DEF_ENC32(Y5_l2gclean,     ICLASS_ST" 100 00 01----- PP-100-- --------")
+DEF_ENC32(Y5_l2gcleaninv,  ICLASS_ST" 100 00 01----- PP-110-- --------")
+DEF_ENC32(Y2_l2cleaninvidx,ICLASS_ST" 100 00 11sssss PP------ --------")
 
 
 
@@ -502,9 +507,28 @@ DEF_ENC32(Y2_dccleana,     ICLASS_ST" 000 00 00sssss PP------ --------")
 DEF_ENC32(Y2_dcinva,       ICLASS_ST" 000 00 01sssss PP------ --------")
 DEF_ENC32(Y2_dccleaninva,  ICLASS_ST" 000 00 10sssss PP------ --------")
 
-DEF_ENC32(Y4_l2fetch,      ICLASS_ST" 011 00 00sssss PP-ttttt 000-----")
+/* Super */
+DEF_ENC32(Y2_dckill,       ICLASS_ST" 001 00 00----- PP------ --------")
+DEF_ENC32(Y2_dccleanidx,   ICLASS_ST" 001 00 01sssss PP------ --------")
+DEF_ENC32(Y2_dcinvidx,     ICLASS_ST" 001 00 10sssss PP------ --------")
+DEF_ENC32(Y2_dccleaninvidx,ICLASS_ST" 001 00 11sssss PP------ --------")
+
+DEF_ENC32(Y2_dctagw       ,ICLASS_ST" 010 00 00sssss PP-ttttt --------")
+DEF_ENC32(Y2_dctagr       ,ICLASS_ST" 010 00 01sssss PP------ ---ddddd")
+
+DEF_ENC32(Y4_l2tagw       ,ICLASS_ST" 010 00 10sssss PP0ttttt --------")
+DEF_ENC32(Y4_l2tagr       ,ICLASS_ST" 010 00 11sssss PP------ ---ddddd")
+
+DEF_ENC32(Y4_l2fetch,          ICLASS_ST" 011 00 00sssss PP-ttttt 000-----")
+DEF_ENC32(Y5_l2cleanidx,   ICLASS_ST" 011 00 01sssss PP------ --------")
+DEF_ENC32(Y5_l2invidx,     ICLASS_ST" 011 00 10sssss PP------ --------")
+DEF_ENC32(Y5_l2unlocka,    ICLASS_ST" 011 00 11sssss PP------ --------")
 DEF_ENC32(Y5_l2fetch,      ICLASS_ST" 011 01 00sssss PP-ttttt --------")
 
+DEF_ENC32(Y6_l2gcleanpa,   ICLASS_ST" 011 01 01----- PP-ttttt --------")
+DEF_ENC32(Y6_l2gcleaninvpa,ICLASS_ST" 011 01 10----- PP-ttttt --------")
+
+
 /*******************************/
 /*                             */
 /*                             */
@@ -547,13 +571,23 @@ DEF_ENC32(J2_jumprfnewpt, ICLASS_J" 0011  011sssss  PP-11-uu  --------")
 
 DEF_FIELDROW_DESC32(ICLASS_J" 0100 -------- PP------ --------","[#4] (#u8) ")
 DEF_ENC32(J2_trap0,     ICLASS_J" 0100  00------  PP-iiiii  ---iii--")
-DEF_ENC32(J2_pause,     ICLASS_J" 0100  01------  PP-iiiii  ---iii--")
+DEF_ENC32(J2_trap1,     ICLASS_J" 0100  10-xxxxx  PP-iiiii  ---iii--")
+DEF_ENC32(J2_pause,     ICLASS_J" 0100  01----ii  PP-iiiii  ---iii--")
+
+DEF_FIELDROW_DESC32(ICLASS_J" 0101 -------- PP------ --------","[#5] Rd=(Rs) ")
+DEF_ENC32(Y2_icdatar,   ICLASS_J" 0101  101sssss  PP------  ---ddddd")
+DEF_ENC32(Y2_ictagr,    ICLASS_J" 0101  111sssss  PP------  ---ddddd")
+DEF_ENC32(Y2_ictagw,    ICLASS_J" 0101  110sssss  PP0ttttt  --------")
+DEF_ENC32(Y2_icdataw,   ICLASS_J" 0101  110sssss  PP1ttttt  --------")
 
 DEF_FIELDROW_DESC32(ICLASS_J" 0110 -------- PP------ --------","[#6] icop(Rs) ")
 DEF_ENC32(Y2_icinva,    ICLASS_J" 0110  110sssss  PP000---  --------")
+DEF_ENC32(Y2_icinvidx,  ICLASS_J" 0110  110sssss  PP001---  --------")
+DEF_ENC32(Y2_ickill,    ICLASS_J" 0110  110-----  PP010---  --------")
 
 DEF_FIELDROW_DESC32(ICLASS_J" 0111 -------- PP------ --------","[#7] () ")
 DEF_ENC32(Y2_isync,     ICLASS_J" 0111  11000000  PP0---00  00000010")
+DEF_ENC32(J2_rte,       ICLASS_J" 0111  111-----  PP00----  000-----")
 
 /* JUMP */
 DEF_FIELDROW_DESC32(ICLASS_J" 100- -------- PP------ --------","[#8,9] PC=(#r22)")
@@ -738,12 +772,19 @@ DEF_ENC32(J2_jumprltezpt,ICLASS_CR" 0001  11isssss  PPi1iiii  iiiiiii-")
 
 DEF_FIELDROW_DESC32(    ICLASS_CR" 0010  --------  PP------  --------","[#2] Cd=Rs ")
 DEF_ENC32(A2_tfrrcr,    ICLASS_CR" 0010  001sssss  PP------  ---ddddd")
+DEF_ENC32(G4_tfrgrcr,   ICLASS_CR" 0010  000sssss  PP------  ---ddddd")
+DEF_ENC32(Y4_trace,     ICLASS_CR" 0010  010sssss  PP------  000-----")
+DEF_ENC32(Y6_diag,      ICLASS_CR" 0010  010sssss  PP------  001-----")
+DEF_ENC32(Y6_diag0,     ICLASS_CR" 0010  010sssss  PP-ttttt  010-----")
+DEF_ENC32(Y6_diag1,     ICLASS_CR" 0010  010sssss  PP-ttttt  011-----")
 
 DEF_FIELDROW_DESC32(    ICLASS_CR" 0011  --------  PP------  --------","[#3] Cdd=Rss ")
 DEF_ENC32(A4_tfrpcp,    ICLASS_CR" 0011  001sssss  PP------  ---ddddd")
+DEF_ENC32(G4_tfrgpcp,   ICLASS_CR" 0011  000sssss  PP------  ---ddddd")
 
 DEF_FIELDROW_DESC32(    ICLASS_CR" 1000  --------  PP------  --------","[#8] Rdd=Css ")
 DEF_ENC32(A4_tfrcpp,    ICLASS_CR" 1000  000sssss  PP------  ---ddddd")
+DEF_ENC32(G4_tfrgcpp,   ICLASS_CR" 1000  001sssss  PP------  ---ddddd")
 
 DEF_FIELDROW_DESC32(    ICLASS_CR" 1001  --------  PP------  --------","[#9] (#r8,#U10)")
 DEF_ENC32(J2_ploop1si,  ICLASS_CR" 1001  101IIIII  PP-iiiii  IIIii-II")
@@ -754,6 +795,7 @@ DEF_ENC32(J2_loop1i,    ICLASS_CR" 1001  001IIIII  PP-iiiii  IIIii-II")
 
 DEF_FIELDROW_DESC32(    ICLASS_CR" 1010  --------  PP------  --------","[#10] Rd=Cs ")
 DEF_ENC32(A2_tfrcrr,    ICLASS_CR" 1010  000sssss  PP------  ---ddddd")
+DEF_ENC32(G4_tfrgcrr,   ICLASS_CR" 1010  001sssss  PP------  ---ddddd")
 DEF_ENC32(C4_addipc,    ICLASS_CR" 1010  01001001  PP-iiiii  i--ddddd")
 
 
@@ -781,6 +823,64 @@ DEF_ENC32(C4_fastcorner9_not,   ICLASS_CR"1011 0001--ss  PP1---tt 1--1--dd")
 
 
 
+/* Supervisor CR ops */
+/* Interrupts */
+DEF_FIELDROW_DESC32(   ICLASS_CR" 0100 -------- PP------  --------","[#4] (Rs,Pt)")
+DEF_ENC32(Y2_swi,      ICLASS_CR" 0100 000sssss PP------ 000-----")
+DEF_ENC32(Y2_cswi,     ICLASS_CR" 0100 000sssss PP------ 001-----")
+DEF_ENC32(Y2_iassignw, ICLASS_CR" 0100 000sssss PP------ 010-----")
+DEF_ENC32(Y2_ciad,     ICLASS_CR" 0100 000sssss PP------ 011-----")
+DEF_ENC32(Y2_setimask, ICLASS_CR" 0100 100sssss PP----tt 000-----")
+DEF_ENC32(Y2_setprio,  ICLASS_CR" 0100 100sssss PP----tt 001-----")
+DEF_ENC32(Y4_siad,     ICLASS_CR" 0100 100sssss PP------ 011-----")
+
+DEF_ENC32(Y2_wait,     ICLASS_CR" 0100 010sssss PP------ 000-----")
+DEF_ENC32(Y2_resume,   ICLASS_CR" 0100 010sssss PP------ 001-----")
+DEF_ENC32(Y2_stop,     ICLASS_CR" 0100 011sssss PP------ 000-----")
+DEF_ENC32(Y2_start,    ICLASS_CR" 0100 011sssss PP------ 001-----")
+DEF_ENC32(Y4_nmi,      ICLASS_CR" 0100 011sssss PP------ 010-----")
+
+DEF_FIELDROW_DESC32(   ICLASS_CR" 0101 -------- PP------  --------","[#5] Rx ")
+DEF_ENC32(Y2_crswap0,  ICLASS_CR" 0101 000xxxxx PP------ --------")
+DEF_ENC32(Y4_crswap1,  ICLASS_CR" 0101 001xxxxx PP------ --------")
+
+DEF_FIELDROW_DESC32(   ICLASS_CR" 0110 -------- PP------  --------","[#6] Rd=(Rs)")
+DEF_ENC32(Y2_getimask, ICLASS_CR" 0110 000sssss PP------ ---ddddd")
+DEF_ENC32(Y2_iassignr, ICLASS_CR" 0110 011sssss PP------ ---ddddd")
+
+DEF_FIELDROW_DESC32(   ICLASS_CR" 0111 -------- PP------  --------","[#7] cr=Rs ")
+DEF_ENC32(Y2_tfrsrcr,  ICLASS_CR" 0111 00-sssss PP------ -ddddddd")
+
+DEF_FIELDROW_DESC32(   ICLASS_CR" 1100 -------- PP------  --------","[#12] ")
+DEF_ENC32(Y2_break,    ICLASS_CR" 1100 001----- PP------ 000-----")
+DEF_ENC32(Y2_tlblock,  ICLASS_CR" 1100 001----- PP------ 001-----")
+DEF_ENC32(Y2_tlbunlock,ICLASS_CR" 1100 001----- PP------ 010-----")
+DEF_ENC32(Y2_k0lock,   ICLASS_CR" 1100 001----- PP------ 011-----")
+DEF_ENC32(Y2_k0unlock, ICLASS_CR" 1100 001----- PP------ 100-----")
+DEF_ENC32(Y2_tlbp,     ICLASS_CR" 1100 100sssss PP------ ---ddddd")
+DEF_ENC32(Y5_tlboc,    ICLASS_CR" 1100 111sssss PP------ ---ddddd")
+DEF_ENC32(Y5_tlbasidi, ICLASS_CR" 1100 101sssss PP------ --------")
+DEF_ENC32(Y2_tlbr,     ICLASS_CR" 1100 010sssss PP------ ---ddddd")
+DEF_ENC32(Y2_tlbw,     ICLASS_CR" 1100 000sssss PP0ttttt --------")
+DEF_ENC32(Y5_ctlbw,    ICLASS_CR" 1100 110sssss PP0ttttt ---ddddd")
+
+DEF_FIELDROW_DESC32(   ICLASS_CR" 1101 -------- PP------  --------","[#13] Rxx ")
+DEF_ENC32(Y4_crswap10, ICLASS_CR" 1101 10-xxxxx PP------ ---00000")
+DEF_ENC32(Y4_tfrspcp,  ICLASS_CR" 1101 00-sssss PP------ -ddddddd")
+
+DEF_FIELDROW_DESC32(   ICLASS_CR" 1110 -------- PP------  --------","[#14] Rd=cr ")
+DEF_ENC32(Y2_tfrscrr,  ICLASS_CR" 1110 1sssssss PP------ ---ddddd")
+
+DEF_FIELDROW_DESC32(   ICLASS_CR" 1111 -------- PP------  --------","[#15] Rdd=Sss ")
+DEF_ENC32(Y4_tfrscpp,  ICLASS_CR" 1111 0sssssss PP------ ---ddddd")
+
+
+
+
+
+
+
+
 /*******************************/
 /*                             */
 /*                             */
diff --git a/target/hexagon/imported/system.idef b/target/hexagon/imported/system.idef
index 7c6568e75e4..df4527a5fa9 100644
--- a/target/hexagon/imported/system.idef
+++ b/target/hexagon/imported/system.idef
@@ -25,31 +25,230 @@
 /* User->OS interface                       */
 /********************************************/
 
-Q6INSN(J2_trap0,"trap0(#u8)",ATTRIBS(A_COF),
+Q6INSN(J2_trap0,"trap0(#u8)",ATTRIBS(A_COF,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET),
 "Trap to Operating System",
     fTRAP(0,uiV);
 )
 
-Q6INSN(J2_pause,"pause(#u8)",ATTRIBS(A_COF),
+Q6INSN(J2_trap1,"trap1(Rx32,#u8)",ATTRIBS(A_COF,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET),
+"Trap to Operating System",
+	/*
+	 * Note: if RxV is not written, we get the same as the input.
+	 * Since trap1 is SOLO, this means the register will effectively not be updated
+	 */
+	if (!fTRAP1_VIRTINSN(uiV)) {
+		fTRAP(1,uiV);
+	} else if (uiV == 1) {
+		fVIRTINSN_RTE(uiV,RxV);
+	} else if (uiV == 3) {
+		fVIRTINSN_SETIE(uiV,RxV);
+	} else if (uiV == 4) {
+		fVIRTINSN_GETIE(uiV,RxV);
+	} else if (uiV == 6) {
+		fVIRTINSN_SPSWAP(uiV,RxV);
+	})
+
+Q6INSN(J2_pause,"pause(#u8)",ATTRIBS(A_COF,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET),
 "Enter low-power state for #u8 cycles",{fPAUSE(uiV);})
 
-Q6INSN(Y2_icinva,"icinva(Rs32)",ATTRIBS(A_ICOP,A_ICFLUSHOP),"Instruction Cache Invalidate Address",{fEA_REG(RsV); fICINVA(EA);})
+Q6INSN(J2_rte,  "rte", ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NO_TIMING_LOG),
+"Return from Exception",
+{
+fHIDE(if((thread->timing_on) && (thread->status & EXEC_STATUS_REPLAY)) { return; })
+fHIDE(CALLBACK(thread->processor_ptr->options->rte_callback,
+      thread->system_ptr,thread->processor_ptr,
+      thread->threadId,0);)
+fCLEAR_RTE_EX();
+fBRANCH(fREAD_ELR(),COF_TYPE_RTE);})
 
-Q6INSN(Y2_isync,"isync",ATTRIBS(),"Memory Synchronization",{fISYNC();})
-Q6INSN(Y2_barrier,"barrier",ATTRIBS(A_RESTRICT_SLOT0ONLY),"Memory Barrier",{fBARRIER();})
-Q6INSN(Y2_syncht,"syncht",ATTRIBS(A_RESTRICT_SLOT0ONLY),"Memory Synchronization",{fSYNCH();})
 
+/********************************************/
+/* Interrupt Management                     */
+/********************************************/
 
-Q6INSN(Y2_dcfetchbo,"dcfetch(Rs32+#u11:3)",ATTRIBS(A_RESTRICT_PREFERSLOT0,A_DCFETCH),"Data Cache Prefetch",{fEA_RI(RsV,uiV); fDCFETCH(EA);})
+Q6INSN(Y2_swi,"swi(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_AXOK,A_RESTRICT_PACKET_AXOK),"Software Interrupt",{DO_SWI(RsV);})
+Q6INSN(Y2_cswi,"cswi(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_AXOK,A_RESTRICT_PACKET_AXOK),"Cancel Software Interrupt",{DO_CSWI(RsV);})
+Q6INSN(Y2_ciad,"ciad(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_AXOK,A_RESTRICT_PACKET_AXOK),"Re-enable interrupt in IAD",{DO_CIAD(RsV);})
+Q6INSN(Y4_siad,"siad(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_AXOK,A_RESTRICT_PACKET_AXOK),"Disable interrupt in IAD",{DO_SIAD(RsV);})
+Q6INSN(Y2_iassignr,"Rd32=iassignr(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_AXOK,A_RESTRICT_PACKET_AXOK),"Read interrupt to thread assignments",{DO_IASSIGNR(RsV,RdV);})
+Q6INSN(Y2_iassignw,"iassignw(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_AXOK,A_RESTRICT_PACKET_AXOK),"Write interrupt to thread assignments",{DO_IASSIGNW(RsV);})
 
 
-Q6INSN(Y2_dczeroa,"dczeroa(Rs32)",ATTRIBS(A_STORE,A_RESTRICT_SLOT0ONLY,A_DCZEROA),"Zero an aligned 32-byte cacheline",{fEA_REG(RsV); fDCZEROA(EA);})
-Q6INSN(Y2_dccleana,"dccleana(Rs32)",ATTRIBS(A_RESTRICT_SLOT0ONLY,A_DCFLUSHOP),"Data Cache Clean Address",{fEA_REG(RsV); fDCCLEANA(EA);})
-Q6INSN(Y2_dccleaninva,"dccleaninva(Rs32)",ATTRIBS(A_RESTRICT_SLOT0ONLY,A_DCFLUSHOP),"Data Cache Clean and Invalidate Address",{fEA_REG(RsV); fDCCLEANINVA(EA);})
-Q6INSN(Y2_dcinva,"dcinva(Rs32)",ATTRIBS(A_RESTRICT_SLOT0ONLY,A_DCFLUSHOP),"Data Cache Invalidate Address",{fEA_REG(RsV); fDCCLEANINVA(EA);})
+Q6INSN(Y2_getimask,"Rd32=getimask(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_AXOK,A_RESTRICT_PACKET_AXOK),"Read imask register of another thread",
+{RdV = READ_IMASK(RsV & thread->processor_ptr->thread_system_mask); })
 
+Q6INSN(Y2_setimask,"setimask(Pt4,Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_AXOK,A_RESTRICT_PACKET_AXOK),"Change imask register of another thread",
+{fPREDUSE_TIMING();WRITE_IMASK(PtV & thread->processor_ptr->thread_system_mask,RsV); })
 
-Q6INSN(Y4_l2fetch,"l2fetch(Rs32,Rt32)",ATTRIBS(A_RESTRICT_SLOT0ONLY),"L2 Cache Prefetch",
+
+
+/********************************************/
+/* TLB management                           */
+/********************************************/
+
+Q6INSN(Y2_tlbw,"tlbw(Rss32,Rt32)", ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET),
+"Write TLB entry", {fTLBW(RtV,RssV);})
+
+Q6INSN(Y5_ctlbw,"Rd32=ctlbw(Rss32,Rt32)", ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET),
+"Conditional Write TLB entry",
+{
+  if (fTLB_ENTRY_OVERLAP( (1LL<<63) | RssV )) {
+        RdV=fTLB_ENTRY_OVERLAP_IDX( (1LL<<63) | RssV);
+     } else {
+        fTLBW(RtV,RssV);
+        RdV=0x80000000;
+     }
+})
+
+Q6INSN(Y5_tlboc,"Rd32=tlboc(Rss32)", ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET),
+"TLB overlap check",
+{
+  if (fTLB_ENTRY_OVERLAP( (1LL<<63) | RssV )) {
+        RdV=fTLB_ENTRY_OVERLAP_IDX( (1LL<<63) | RssV);
+     } else {
+        RdV=0x80000000;
+     }
+})
+
+Q6INSN(Y2_tlbr,"Rdd32=tlbr(Rs32)", ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET), "Read TLB entry",
+{RddV = fTLBR(RsV);})
+
+Q6INSN(Y2_tlbp,"Rd32=tlbp(Rs32)", ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET), "Probe TLB", {RdV=fTLBP(RsV);})
+
+Q6INSN(Y5_tlbasidi,"tlbinvasid(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET), "Invalidate ASID",
+{
+	fHIDE(int i;)
+    fHIDE(unsigned int NUM_TLB_ENTRIES = NUM_TLB_REGS(thread->processor_ptr);)
+	for (i = 0; i < NUM_TLB_ENTRIES; i++) {
+		if ((fGET_FIELD(fTLBR(i),PTE_G) == 0) &&
+			(fGET_FIELD(fTLBR(i),PTE_ASID) == fEXTRACTU_RANGE(RsV,26,20))) {
+			fTLBW(i,fTLBR(i) & ~(1ULL << 63));
+		}
+	}
+})
+
+Q6INSN(Y2_tlblock,"tlblock", ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET,A_NO_TIMING_LOG), "Lock TLB",
+{fSET_TLB_LOCK();})
+
+Q6INSN(Y2_tlbunlock,"tlbunlock", ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET), "Unlock TLB",
+{fCLEAR_TLB_LOCK();})
+
+Q6INSN(Y2_k0lock,"k0lock", ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET,A_NO_TIMING_LOG), "Lock K0",
+{fSET_K0_LOCK();})
+
+Q6INSN(Y2_k0unlock,"k0unlock", ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET), "Unlock K0",
+{fCLEAR_K0_LOCK();})
+
+/********************************************/
+/* Supervisor Reg Management                */
+/********************************************/
+
+Q6INSN(Y2_crswap0,"crswap(Rx32,sgp0)",ATTRIBS(A_PRIV,A_NOTE_PRIV), "Swap system general pointer 0 with GPR",
+{fHIDE(size4s_t tmp;) tmp = RxV; RxV = READ_SGP0(); WRITE_SGP0(tmp);})
+Q6INSN(Y4_crswap1,"crswap(Rx32,sgp1)",ATTRIBS(A_PRIV,A_NOTE_PRIV), "Swap system general pointer 1 with GPR",
+{fHIDE(size4s_t tmp;) tmp = RxV; RxV = READ_SGP1(); WRITE_SGP1(tmp);})
+
+Q6INSN(Y4_crswap10,"crswap(Rxx32,sgp1:0)",ATTRIBS(A_PRIV,A_NOTE_PRIV), "Swap system general purpose 0/1 with GPR Pair",
+{fHIDE(size8s_t tmp;) tmp = RxxV; RxxV=READ_SGP10(); WRITE_SGP10(tmp);})
+
+Q6INSN(Y2_tfrscrr,"Rd32=Ss128",ATTRIBS(A_PRIV,A_NOTE_PRIV),"Transfer Supervisor Reg to GPR", {RdV=SsV;})
+Q6INSN(Y2_tfrsrcr,"Sd128=Rs32",ATTRIBS(A_PRIV,A_NOTE_PRIV),"Transfer GPR to Supervisor Reg", {SdV=RsV;})
+Q6INSN(Y4_tfrscpp,"Rdd32=Sss128",ATTRIBS(A_PRIV,A_NOTE_PRIV),"Transfer Supervisor Reg to GPR", {RddV=SssV;})
+Q6INSN(Y4_tfrspcp,"Sdd128=Rss32",ATTRIBS(A_PRIV,A_NOTE_PRIV),"Transfer GPR to Supervisor Reg", {SddV=RssV;})
+
+Q6INSN(G4_tfrgcrr,"Rd32=Gs32",ATTRIBS(A_GUEST,A_NOTE_GUEST),"Transfer Guest Reg to GPR", {RdV=GsV;})
+Q6INSN(G4_tfrgrcr,"Gd32=Rs32",ATTRIBS(A_GUEST,A_NOTE_GUEST),"Transfer GPR to Guest Reg", {GdV=RsV;})
+Q6INSN(G4_tfrgcpp,"Rdd32=Gss32",ATTRIBS(A_GUEST,A_NOTE_GUEST),"Transfer Guest Reg to GPR", {RddV=GssV;})
+Q6INSN(G4_tfrgpcp,"Gdd32=Rss32",ATTRIBS(A_GUEST,A_NOTE_GUEST),"Transfer GPR to Guest Reg", {GddV=RssV;})
+
+
+
+Q6INSN(Y2_setprio,"setprio(Pt4,Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV),"Change TID Prio of another thread",
+{fPREDUSE_TIMING();WRITE_PRIO(PtV & thread->processor_ptr->thread_system_mask,RsV); })
+
+
+
+
+/********************************************/
+/* Power Management / Thread on/off         */
+/********************************************/
+Q6INSN(Y6_diag,"diag(Rs32)",ATTRIBS(),"Send value to Diag trace module",{
+})
+Q6INSN(Y6_diag0,"diag0(Rss32,Rtt32)",ATTRIBS(),"Send values of two register to DIAG Trace. Set X=0",{
+})
+Q6INSN(Y6_diag1,"diag1(Rss32,Rtt32)",ATTRIBS(),"Send values of two register to DIAG Trace.  Set X=1",{
+})
+
+
+Q6INSN(Y4_trace,"trace(Rs32)",ATTRIBS(A_NOTE_AXOK,A_RESTRICT_PACKET_AXOK),"Send value to ETM trace",{
+    fDO_TRACE(RsV);
+})
+
+Q6INSN(Y2_stop,"stop(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET),"Stop thread(s)",{
+    fHIDE(RsV=RsV;)
+    if (!fIN_DEBUG_MODE_NO_ISDB(fGET_TNUM())) fCLEAR_RUN_MODE(fGET_TNUM());
+})
+
+Q6INSN(Y4_nmi,"nmi(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET,A_NO_TIMING_LOG),"Raise NMI on thread(s)",{
+    fDO_NMI(RsV);
+})
+
+Q6INSN(Y2_start,"start(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET),"Start thread(s)",fSTART(RsV);)
+
+Q6INSN(Y2_wait,"wait(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET,A_NO_TIMING_LOG),"Make thread(s) wait",{
+    fHIDE(RsV=RsV;)
+    if (!fIN_DEBUG_MODE(fGET_TNUM())) fSET_WAIT_MODE(fGET_TNUM());
+	fIN_DEBUG_MODE_WARN(fGET_TNUM());
+})
+
+Q6INSN(Y2_resume,"resume(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET),"Make thread(s) stop waiting",fRESUME(RsV);)
+
+Q6INSN(Y2_break,"brkpt",ATTRIBS(A_NOTE_NOPACKET,A_RESTRICT_NOPACKET),"Breakpoint",{fBREAK();})
+
+
+/********************************************/
+/* Cache Management                         */
+/********************************************/
+
+Q6INSN(Y2_ictagr,"Rd32=ictagr(Rs32)",ATTRIBS(A_ICOP,A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET,A_CACHEOP,A_COPBYIDX,A_ICTAGOP),"Instruction Cache Tag Read",{fICTAGR(RsV,RdV,RdN);})
+Q6INSN(Y2_ictagw,"ictagw(Rs32,Rt32)",ATTRIBS(A_ICOP,A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET,A_CACHEOP,A_COPBYIDX,A_ICTAGOP),"Instruction Cache Tag Write",{fICTAGW(RsV,RtV);})
+Q6INSN(Y2_icdataw,"icdataw(Rs32,Rt32)",ATTRIBS(A_ICOP,A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET,A_CACHEOP,A_COPBYIDX,A_ICTAGOP),"Instruction Cache Data Write",{fICDATAW(RsV,RtV);})
+Q6INSN(Y2_icdatar,"Rd32=icdatar(Rs32)",ATTRIBS(A_ICOP,A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET,A_CACHEOP,A_COPBYIDX,A_ICTAGOP),"Instruction Cache Data Read",{fICDATAR(RsV, RdV);})
+Q6INSN(Y2_icinva,"icinva(Rs32)",ATTRIBS(A_ICOP,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET,A_CACHEOP,A_COPBYADDRESS,A_ICFLUSHOP),"Instruction Cache Invalidate Address",{fEA_REG(RsV); fICINVA(EA);})
+Q6INSN(Y2_icinvidx,"icinvidx(Rs32)",ATTRIBS(A_ICOP,A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET,A_CACHEOP,A_COPBYIDX,A_ICFLUSHOP),"Instruction Cache Invalidate Index",{fICINVIDX(RsV);})
+Q6INSN(Y2_ickill,"ickill",ATTRIBS(A_ICOP,A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET,A_CACHEOP,A_ICFLUSHOP),"Instruction Cache Invalidate",{fICKILL();})
+
+Q6INSN(Y2_isync,"isync",ATTRIBS(A_NOTE_NOPACKET,A_RESTRICT_NOPACKET),"Memory Synchronization",{fISYNC();})
+Q6INSN(Y2_barrier,"barrier",ATTRIBS(A_NOTE_NOPACKET,A_RESTRICT_SLOT0ONLY,A_RESTRICT_PACKET_AXOK),"Memory Barrier",{fBARRIER();})
+Q6INSN(Y2_syncht,"syncht",ATTRIBS(A_NOTE_NOPACKET,A_RESTRICT_SLOT0ONLY,A_RESTRICT_NOPACKET),"Memory Synchronization",{fSYNCH();})
+
+
+Q6INSN(Y2_dcfetchbo,"dcfetch(Rs32+#u11:3)",ATTRIBS(A_RESTRICT_PREFERSLOT0,A_DCFETCH,A_RESTRICT_NOSLOT1_STORE),"Data Cache Prefetch",{fEA_RI(RsV,uiV); fDCFETCH(EA);})
+Q6INSN(Y2_dckill,"dckill",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_SLOT0ONLY,A_RESTRICT_NOPACKET,A_CACHEOP,A_DCFLUSHOP),"Data Cache Invalidate",{fDCKILL();})
+
+
+Q6INSN(Y2_dczeroa,"dczeroa(Rs32)",ATTRIBS(A_STORE,A_RESTRICT_SLOT1_AOK,A_NOTE_SLOT1_AOK,A_RESTRICT_SLOT0ONLY,A_CACHEOP,A_COPBYADDRESS,A_DCZEROA),"Zero an aligned 32-byte cacheline",{fEA_REG(RsV); fDCZEROA(EA);})
+Q6INSN(Y2_dccleana,"dccleana(Rs32)",ATTRIBS(A_RESTRICT_SLOT1_AOK,A_NOTE_SLOT1_AOK,A_RESTRICT_SLOT0ONLY,A_CACHEOP,A_COPBYADDRESS,A_DCFLUSHOP),"Data Cache Clean Address",{fEA_REG(RsV); fDCCLEANA(EA);})
+Q6INSN(Y2_dccleanidx,"dccleanidx(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_RESTRICT_PACKET_AXOK,A_NOTE_AXOK,A_RESTRICT_SLOT0ONLY,A_CACHEOP,A_COPBYIDX,A_DCFLUSHOP),"Data Cache Clean Index",{fDCCLEANIDX(RsV);})
+Q6INSN(Y2_dccleaninva,"dccleaninva(Rs32)",ATTRIBS(A_RESTRICT_SLOT1_AOK,A_NOTE_SLOT1_AOK,A_RESTRICT_SLOT0ONLY,A_CACHEOP,A_COPBYADDRESS,A_DCFLUSHOP),"Data Cache Clean and Invalidate Address",{fEA_REG(RsV); fDCCLEANINVA(EA);})
+Q6INSN(Y2_dccleaninvidx,"dccleaninvidx(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_RESTRICT_PACKET_AXOK,A_NOTE_AXOK,A_RESTRICT_SLOT0ONLY,A_CACHEOP,A_COPBYIDX,A_DCFLUSHOP),"Data Cache Clean and Invalidate Index",{fDCCLEANINVIDX(RsV);})
+Q6INSN(Y2_dcinva,"dcinva(Rs32)",ATTRIBS(A_RESTRICT_SLOT1_AOK,A_NOTE_SLOT1_AOK,A_RESTRICT_SLOT0ONLY,A_CACHEOP,A_COPBYADDRESS,A_DCFLUSHOP),"Data Cache Invalidate Address",{fEA_REG(RsV); fDCCLEANINVA(EA);})
+Q6INSN(Y2_dcinvidx,"dcinvidx(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_RESTRICT_PACKET_AXOK,A_NOTE_AXOK,A_RESTRICT_SLOT0ONLY,A_CACHEOP,A_COPBYIDX,A_DCFLUSHOP),"Data Cache Invalidate Index",{fDCINVIDX(RsV);})
+Q6INSN(Y2_dctagr,"Rd32=dctagr(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_RESTRICT_PACKET_AXOK,A_NOTE_AXOK,A_RESTRICT_SLOT0ONLY,A_CACHEOP,A_COPBYIDX,A_DCTAGOP),"Data Cache Tag Read",{fDCTAGR(RsV,RdV,RdN);})
+Q6INSN(Y2_dctagw,"dctagw(Rs32,Rt32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_RESTRICT_SLOT0ONLY,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET,A_CACHEOP,A_COPBYIDX,A_DCTAGOP),"Data Cache Tag Write",{fDCTAGW(RsV,RtV);})
+
+
+Q6INSN(Y2_l2kill,"l2kill",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_SLOT0ONLY,A_RESTRICT_NOPACKET,A_CACHEOP,A_L2FLUSHOP),"L2 Cache Invalidate",{fL2KILL();})
+Q6INSN(Y4_l2tagw,"l2tagw(Rs32,Rt32)",ATTRIBS(A_PRIV,A_NOTE_BADTAG_UNDEF,A_NOTE_PRIV,A_RESTRICT_SLOT0ONLY,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET,A_CACHEOP,A_COPBYIDX,A_L2TAGOP),"L2 Cache Tag Write",{fL2TAGW(RsV,RtV);})
+Q6INSN(Y4_l2tagr,"Rd32=l2tagr(Rs32)",ATTRIBS(A_PRIV,A_NOTE_BADTAG_UNDEF,A_NOTE_PRIV,A_NOTE_AXOK,A_RESTRICT_PACKET_AXOK,A_RESTRICT_SLOT0ONLY,A_CACHEOP,A_COPBYIDX,A_L2TAGOP),"L2 Cache Tag Read",{fL2TAGR(RsV,RdV,RdN);})
+
+Q6INSN(Y2_l2cleaninvidx,"l2cleaninvidx(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_AXOK,A_RESTRICT_PACKET_AXOK,A_RESTRICT_SLOT0ONLY,A_CACHEOP,A_COPBYIDX,A_L2FLUSHOP),"L2 Cache Clean and Invalidate Index",{fL2CLEANINVIDX(RsV); })
+Q6INSN(Y5_l2cleanidx,"l2cleanidx(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_AXOK,A_RESTRICT_PACKET_AXOK,A_RESTRICT_SLOT0ONLY,A_CACHEOP,A_COPBYIDX,A_L2FLUSHOP),"L2 Cache Clean by Index",{fL2CLEANIDX(RsV); })
+Q6INSN(Y5_l2invidx,"l2invidx(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_AXOK,A_RESTRICT_PACKET_AXOK,A_RESTRICT_SLOT0ONLY,A_CACHEOP,A_COPBYIDX,A_L2FLUSHOP),"L2 Cache Invalidate by Index",{fL2INVIDX(RsV); })
+
+
+
+Q6INSN(Y4_l2fetch,"l2fetch(Rs32,Rt32)",ATTRIBS(A_RESTRICT_SLOT0ONLY,A_RESTRICT_PACKET_AXOK,A_NOTE_AXOK),"L2 Cache Prefetch",
 { fL2FETCH(RsV,
            (RtV&0xff), /*height*/
            ((RtV>>8)&0xff), /*width*/
@@ -59,10 +258,29 @@ Q6INSN(Y4_l2fetch,"l2fetch(Rs32,Rt32)",ATTRIBS(A_RESTRICT_SLOT0ONLY),"L2 Cache P
 
 
 
-Q6INSN(Y5_l2fetch,"l2fetch(Rs32,Rtt32)",ATTRIBS(A_RESTRICT_SLOT0ONLY),"L2 Cache Prefetch",
+Q6INSN(Y5_l2fetch,"l2fetch(Rs32,Rtt32)",ATTRIBS(A_RESTRICT_SLOT0ONLY,A_RESTRICT_PACKET_AXOK,A_NOTE_AXOK),"L2 Cache Prefetch",
 { fL2FETCH(RsV,
            fGETUHALF(0,RttV), /*height*/
            fGETUHALF(1,RttV), /*width*/
            fGETUHALF(2,RttV), /*stride*/
            fGETUHALF(3,RttV)); /*flags*/
 })
+
+Q6INSN(Y5_l2locka,"Pd4=l2locka(Rs32)", ATTRIBS(A_PRIV,A_NOTE_PRIV,A_CACHEOP,A_COPBYADDRESS,A_RESTRICT_SLOT0ONLY,A_RESTRICT_PACKET_AXOK,A_NOTE_AXOK,A_RESTRICT_LATEPRED,A_NOTE_LATEPRED),
+"Lock L2 cache line by address", { fEA_REG(RsV); fL2LOCKA(EA,PdV,PdN); fHIDE(MARK_LATE_PRED_WRITE(PdN)) })
+
+
+Q6INSN(Y5_l2unlocka,"l2unlocka(Rs32)", ATTRIBS(A_PRIV,A_NOTE_PRIV,A_CACHEOP,A_COPBYADDRESS,A_RESTRICT_SLOT0ONLY,A_RESTRICT_PACKET_AXOK,A_NOTE_AXOK), "UnLock L2 cache line by address", { fEA_REG(RsV); fL2UNLOCKA(EA); })
+
+
+
+Q6INSN(Y5_l2gunlock,"l2gunlock",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_SLOT0ONLY,A_RESTRICT_NOPACKET,A_CACHEOP,A_L2FLUSHOP),"L2 Global Unlock",{fL2UNLOCK();})
+
+Q6INSN(Y5_l2gclean,"l2gclean",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_SLOT0ONLY,A_RESTRICT_NOPACKET,A_CACHEOP,A_L2FLUSHOP),"L2 Global Clean",{fL2CLEAN();})
+
+Q6INSN(Y5_l2gcleaninv,"l2gcleaninv",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_SLOT0ONLY,A_RESTRICT_NOPACKET,A_CACHEOP,A_L2FLUSHOP),"L2 Global Clean and Invalidate",{fL2CLEANINV();})
+
+Q6INSN(Y6_l2gcleanpa,"l2gclean(Rtt32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_SLOT0ONLY,A_RESTRICT_NOPACKET,A_CACHEOP,A_L2FLUSHOP),"L2 Global Clean by PA Range",{fL2CLEANPA(RttV);})
+
+Q6INSN(Y6_l2gcleaninvpa,"l2gcleaninv(Rtt32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_SLOT0ONLY,A_RESTRICT_NOPACKET,A_CACHEOP,A_L2FLUSHOP),"L2 Global Clean and Invalidate by PA Range",{fL2CLEANINVPA(RttV);})
+
-- 
2.34.1


