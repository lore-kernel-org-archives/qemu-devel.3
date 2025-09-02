Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA94ECA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1j-0004Ka-W7; Mon, 01 Sep 2025 23:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1b-0003GO-4E
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1Y-0004eN-8b
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:37 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SJMD015457
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ThSS2CFTT2j/21ACnOfKTPFMSqyy1/Djxkz0Pjw7nUs=; b=G8syCzu+6mdd8qhb
 SpEuxdTYo8S814FoNTL8LX4WxqxK35Cp1AmWYL1i3H1vtEcxMhRWaW9rsADDFCnv
 LtexKz/ajL3v4eJa6WlIWzxW2WZGwUqF2IfDCYgjZWMOc312RXI4Vx3FhktnkW7g
 vrkl458UAqbomywahWbXFumAJu6JPXYKTdHizEx1I/wDIJroMlwXEd+8RngviQqO
 nwVTEO04mzAGIxG6uvENSR1gSRdT+QI9RyOAFgJlPbodZWKgIPraewt1l5/gydVC
 UEp6PHQmMtCrhBuTtAonHIMygjSiPFp/I2fJ5qkn0+ktFJGYk+eMjqzNiAp0vQYb
 7lsbAA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urvyxdkh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:25 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-329d88c126cso523640a91.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784964; x=1757389764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ThSS2CFTT2j/21ACnOfKTPFMSqyy1/Djxkz0Pjw7nUs=;
 b=wz5/n6CeVXBLx5yO+kfJzwVjnRUn4t3kf0/rQTJzwEK1BMo0IdQzryoDffFUO0F/A+
 6tZfDOgSRFeABQDykY8Ze+G9w3NQkbRpoxJE5pZOgiWpIMjtqvP+YnGvahowzQyN7FbF
 JjytAt77Cp6gkk7yMBYvjM4oEXaLSkT+JGYg9Uo7tJzO7IqcBCE/xBrXLWg2m0OFpOOG
 koq8UaSEmcWniKMsdKANpsjYMQJEm2U7pZ1JWELkkI2kJHumMAQUauiXTdtZmFpPXrFH
 VEd156wFcP2wzw4aaDv3sjAtiCbSZ4PhH+B6fwuSLIhwpVT6fk7qK83TlelrimyQ4G5D
 V0IA==
X-Gm-Message-State: AOJu0YxLzk73JQtZYa/StQtusYvvdEnh1iSUu2kPRsjGY5PQAfaYkczU
 AnezZRydt91/GYvUweM7IKXGpgFZMMZy/o060cOumi3D40Emr9pksnVaWVq2U8mDzYxO26NwCn9
 TODqjmeYU+ksqbAjP978OrT2L3AszTeMIc/6+c+o2IlpXTS7rxROlFOh6mnJVrtSKhBVL
X-Gm-Gg: ASbGncsh1YZ5r6Czsn3mGpCD20E0ztFEDcNxrHEEsyml5LE9GFTAJ3O7HVK1iLPmiJP
 P1zz7hKJ85KEvB0yqdt9Pd0G1/9F4yWXQyY7fUd7N5A0yGNNEmcTpJMc4T0H/g1D6aYz20URglV
 HzmZB3GvM24KgAHckBUGM0tSOTUk/2aExWfxBmnD+DJc8tS5jyB/G+Mowc+JTdXvu9Kz5j4C92E
 +r/jtYJZcdpBJBGhfaVlIC6E4MKu9jhNlcT5xIsAESD4jG9Vc6SlVuChFjGsIQn+YYPH6aRSFRB
 t0K0+19jx77usd8s7ftBmoFlzgTJX17K9fL9gz3Qu/hb9LlbTmzmw1NrXas4cAZ3DqDImp+BD8k
 rywWmiWtAOpgK
X-Received: by 2002:a17:90b:1a8f:b0:325:ce00:fcb4 with SMTP id
 98e67ed59e1d1-328156e1719mr10858852a91.31.1756784963698; 
 Mon, 01 Sep 2025 20:49:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr5ux6SWnMO+a3C9qw/N1s3UIkDZ0coi2s5PIdUBav7qudSlaiX45SwuZANmMBc1GC7HwBkA==
X-Received: by 2002:a17:90b:1a8f:b0:325:ce00:fcb4 with SMTP id
 98e67ed59e1d1-328156e1719mr10858834a91.31.1756784963211; 
 Mon, 01 Sep 2025 20:49:23 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:23 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 26/39] target/hexagon: Decode trap1, rte as COF
Date: Mon,  1 Sep 2025 20:48:34 -0700
Message-Id: <20250902034847.1948010-27-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jqo86oWfvOFuagNZQVjBRB96LIO9618I
X-Proofpoint-ORIG-GUID: jqo86oWfvOFuagNZQVjBRB96LIO9618I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX1z8Rl3U0yMnw
 F5uADEG5+ZjU1o6SA7kL29Y+EazHfq7iedk3fDDWeEIWvFQE3WHLYspMnZ3z2nf5hiJP5kX24A/
 HL17hOYA6U4yv0NZvH27sYQ0D7LxQVoCm2V/aOB+bWZs7Q704IxnJ9/HYyz+q8vuJTcKGO3xe/z
 1m5e8LX6Ugrg5ZUzFvFrksxADUZr4vqKVeHjCPQ79bwBVULJm3AXUfdScofhhyPh+akyl3hD+ED
 gcFP7xFHwBpKywy5wsk73CPLmPQ+kjIMGNIUPOU3ciGckSLf6mUdq/ynbKyy66FINVrMWfFKS6I
 bPmgLfc/MIWQjQS2/97iDvXX2/1gXhb0Z29i7/zdIlm11F1O+Zm/kJKKzbJYTrX8W8X0nvmdJTF
 IOFjkBLW
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b66945 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=oDs3gbQtVgqjpHJ5GUgA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Also: handle rte instructions at the end of the packet.


Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/decode.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index 23deba2426..5d0beeeaf2 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -193,6 +193,8 @@ static bool decode_opcode_can_jump(int opcode)
     if ((GET_ATTRIB(opcode, A_JUMP)) ||
         (GET_ATTRIB(opcode, A_CALL)) ||
         (opcode == J2_trap0) ||
+        (opcode == J2_trap1) ||
+        (opcode == J2_rte) ||
         (opcode == J2_pause)) {
         /* Exception to A_JUMP attribute */
         if (opcode == J4_hintjumpr) {
@@ -371,6 +373,18 @@ static void decode_shuffle_for_execution(Packet *packet)
             break;
         }
     }
+    /*
+     * And at the very very very end, move any RTE's, since they update
+     * user/supervisor mode.
+     */
+#if !defined(CONFIG_USER_ONLY)
+    for (i = 0; i < last_insn; i++) {
+        if (packet->insn[i].opcode == J2_rte) {
+            decode_send_insn_to(packet, i, last_insn);
+            break;
+        }
+    }
+#endif
 }
 
 static void
-- 
2.34.1


