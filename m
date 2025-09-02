Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA6ACA100B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1q-00056C-Sf; Mon, 01 Sep 2025 23:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1o-0004pG-7A
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1m-0004gq-71
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:51 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SO4l013850
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 O9I3g7Y55SmupnY5HGKX2w4q9NJsFa535eQugDny6JE=; b=gnyrqfDY+rKrKegw
 vdfv4m65eD5VIc7Xu+c0pyKcf1/USiAbRukT0/A4wdTgQIFPc4iWLRni0Mp0X47b
 q4cTpDKpgXeboR29AHFYbtVNER+XYaxIyTSoHZmGBs0Q063K/PJCQEWDW7zRhANK
 X3TV14ag6b0qssat37kmVQd1+k2K3w0m9jG9sb41+werYlkC4rJKYAxr6/4LL17L
 WsJmEpihYdM4rRVwMkXX88ALA2lOOWKjfCq8FHv6bRAGdSZ69s5AqKwIcqu2fwDd
 /9Vw6pQgtTIIa1dhbeE+2hI9LrEunl+YT8Re1VLVQOI2sTg40Z7HnbB5SdiXK4sQ
 aikQ+A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0eejac-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:38 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-324e4c3af5fso5183780a91.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784977; x=1757389777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O9I3g7Y55SmupnY5HGKX2w4q9NJsFa535eQugDny6JE=;
 b=epsakrAs3x/evTAHnFlkM6jZwLIACE4uf8fubhYiJtyydahAyu9eP/qxLXZCG6Xllu
 ICojMB4bzZ0nhvgeLKoNl/4TzV/s87A2khlOQt9UwMJ8NoLrZ9r2B0X7bj5yNnsK3FOQ
 a4cnDQ0hP1GvW81ZhWjMokpXoeHPjXWfhfuyTGExQqz8ocCue1MJRQWJn1GQ+VEzqSQS
 ay1xvStOiDQoE7qVvgAWgajcg3EbbU/4z6nMmBqVoGGvH8L+H52Gs0B32cmSKRMFJnvk
 uS5j00GODj1R6kQh2NBCEJcUPRRGwZQmmbWONlUDn2fNXSVWI9JlkzuJIZfg0VGjGGxQ
 y4Mw==
X-Gm-Message-State: AOJu0YzlJSZjcRQ5yMlvEAvFH8SfveRQJ9adJf8HeakPzjwGsVe50yiY
 ma/RQjtOyrCmESfchy9nkvzkMV9Zxl4fuv47PTfLkMnAW9EfeVxSG7Ddv+Oixk6FkUksTd5Luay
 jxO+OnAmv+AGD0LYLHdc9ZkC85Z6nxH85/wTR1/SSjZMBSRj+rMiZRTWMxhYL5cGcpgKW
X-Gm-Gg: ASbGncut1pUfCqQdPqOePie89CGfu2z/8mJoSGL+Z+zmqEJUiQfltFiCrhaEMLdgQGk
 vBdEUdFlXnouXL6eShU54jryreIT9nkc/14BEOssBiIma7QLsly8XHtMJKknBqAY5p/Sio7Zuyb
 M79N+hGNOPosWtJvZ55qRNruOEHkvpNVebZE8dYF717F8z/iy8vw9UrGiAvNImVYNDen6mLZlgs
 eeS0082CW4QAsW7ddC0iR2SSSUYDOmToRU9Da09tJV34YLpy11azQkYopsl0KzJiMjnsMAj6Ntz
 ng9NTWGwo3B82ifvrLgUbyQXskgucbtg639HEhuHLPr4AsQnXe473l1fj8UPsJY8pumDhzL6g6J
 HUi/DAmU9LT43
X-Received: by 2002:a17:90b:54c5:b0:329:8160:437a with SMTP id
 98e67ed59e1d1-3298160446amr11234194a91.24.1756784977174; 
 Mon, 01 Sep 2025 20:49:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+a7kkaLQKQ/CLk4rCxxF60Z65/NJ0QJZr63EscBAjOLwYKGEDEMj8gl9NVsu/37FSCVYtuw==
X-Received: by 2002:a17:90b:54c5:b0:329:8160:437a with SMTP id
 98e67ed59e1d1-3298160446amr11234168a91.24.1756784976699; 
 Mon, 01 Sep 2025 20:49:36 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:36 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 37/39] target/hexagon: Add support for loadw_phys
Date: Mon,  1 Sep 2025 20:48:45 -0700
Message-Id: <20250902034847.1948010-38-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KBU_yr8vpUEkAtd_Nl0kzC4WGH2sTg20
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfXwv4U9pxmLZrj
 N1YsYPszHImchr9vyrUXrd4Z5El5+dc9kbvTjatMGeL1hHfCY4+t4d59gTtqYmxmuI8PC8+pX28
 P+lZiaDjutKj2sS4Lx/vAJCalmZ4Gga5EkpkwqQmaptYtayKJwPrTZdn/4S93g8Dt6of/FvtXt7
 3Hj6f24ECRYBZfIEeyfVbug98vK3WpFlCMmwygPQkQNlD+Xd3L5poH1KZAQsuFbRAiUq96yvtWR
 X5Tyz8U7LByzfglagNHEUf0a15syPDus4LwIwmrKjxHjOfWV1L7E0344pMiiKlryBd1TDqK3NsE
 pXdyR5zRBaOfrAQsVRYK5oSYb+Vo2xueiT2wca9WaSolEOr253DbaJYY7XAdIUgwgHKgNuo4NPq
 C/EuOrqt
X-Proofpoint-ORIG-GUID: KBU_yr8vpUEkAtd_Nl0kzC4WGH2sTg20
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b66952 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=M_0_kNSAHlZdZebFLzYA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/hex_common.py          | 3 +++
 target/hexagon/imported/encode_pp.def | 1 +
 target/hexagon/imported/ldst.idef     | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 39451e6d88..2770b0638b 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -265,6 +265,9 @@ def need_slot(tag):
         and "A_CVI_GATHER" not in attribdict[tag]
         and ("A_STORE" in attribdict[tag]
              or "A_LOAD" in attribdict[tag])
+        and tag != "L4_loadw_phys"
+        and tag != "L6_memcpy"
+        and tag != "Y6_dmlink"
     ):
         return 1
     else:
diff --git a/target/hexagon/imported/encode_pp.def b/target/hexagon/imported/encode_pp.def
index 37faf62b1b..41e4ab9e3a 100644
--- a/target/hexagon/imported/encode_pp.def
+++ b/target/hexagon/imported/encode_pp.def
@@ -388,6 +388,7 @@ DEF_ENC32(L4_return_fnew_pnt, ICLASS_LD" 011 0 000 sssss PP1010vv ---ddddd")
 
 /** Load Acquire Store Release Encoding **/
 
+DEF_ENC32(L4_loadw_phys,      ICLASS_LD" 001 0 000 sssss PP1ttttt -00ddddd")
 DEF_ENC32(L2_loadw_locked,    ICLASS_LD" 001 0 000 sssss PP000--- 000ddddd")
 DEF_ENC32(L4_loadd_locked,    ICLASS_LD" 001 0 000 sssss PP010--- 000ddddd")
 
diff --git a/target/hexagon/imported/ldst.idef b/target/hexagon/imported/ldst.idef
index 53198176a9..4e1e5d5326 100644
--- a/target/hexagon/imported/ldst.idef
+++ b/target/hexagon/imported/ldst.idef
@@ -203,6 +203,9 @@ Q6INSN(S2_storew_locked,"memw_locked(Rs32,Pd4)=Rt32", ATTRIBS(A_REGWRSIZE_4B,A_M
 Q6INSN(L4_loadd_locked,"Rdd32=memd_locked(Rs32)", ATTRIBS(A_REGWRSIZE_8B,A_MEMSIZE_8B,A_LOAD,A_RESTRICT_SLOT0ONLY,A_RESTRICT_PACKET_AXOK,A_NOTE_AXOK), "Load double with lock",
 { fEA_REG(RsV); fLOAD_LOCKED(1,8,u,EA,RddV) })
 
+Q6INSN(L4_loadw_phys,"Rd32=memw_phys(Rs32,Rt32)", ATTRIBS(A_REGWRSIZE_4B,A_PRIV,A_RESTRICT_SLOT0ONLY,A_NOTE_PRIV,A_MEMSIZE_4B,A_LOAD,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET), "Load word from physical address",
+{ fLOAD_PHYS(1,4,u,RsV,RtV,RdV); })
+
 Q6INSN(S4_stored_locked,"memd_locked(Rs32,Pd4)=Rtt32", ATTRIBS(A_REGWRSIZE_8B,A_MEMSIZE_8B,A_STORE,A_RESTRICT_SLOT0ONLY,A_RESTRICT_PACKET_AXOK,A_NOTE_AXOK,A_RESTRICT_LATEPRED,A_NOTE_LATEPRED), "Store word with lock",
 { fEA_REG(RsV); fSTORE_LOCKED(1,8,EA,RttV,PdV) })
 
-- 
2.34.1


