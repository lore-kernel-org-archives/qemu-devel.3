Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73236CA100E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utHzi-0006hR-5W; Mon, 01 Sep 2025 23:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzc-0006f6-BP
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzW-0004QU-65
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:35 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SGBQ030247
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NfINXXkxFRQnMka7kpnE3XMHXe7dvGXpqVDi+3A38oI=; b=ERffZPIaziQOfU+s
 FXH++4hMv9G73C0f9okWbUVZmgkNrRKWKnrf2m5So9bPDoZwpqDFB9x0GxkKSLiT
 mxzbLTUvxJAvYRXJE34W5oJ5n10XRNueabRuiHqObYnmRVNkTWxHRaVGPw049hwe
 EKRIKshuFKbt8YdgoQwlJOsRVD+VeR5JnBGc+cGRnAe4pHyinWJVv4gMvsgrBwch
 JFV/hSVD+j3Fb5l0B3N1Pf7Zf7DOV2qlSbGFV2oH3+czFMYvdDFkEOqM0yblrfT7
 Dj09BK46guZ6cwTw03on9wlk/0gWKX7kCFnMDbeJMT3QWShIlpKPe6vYaaXpCbKH
 ZudWaQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy26nj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:28 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-325ce1082bcso7722633a91.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784847; x=1757389647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NfINXXkxFRQnMka7kpnE3XMHXe7dvGXpqVDi+3A38oI=;
 b=IzW5Px/ywCjTgVGBX0vVPIrG3m4kmcp1QKhjiFaKWciH5m8JuhqhCoVJ1IlFNQnRtW
 /aPlQb/OozmKbL36k2NBwk3zrJwvo5iIF3KZdtB6u3+9fwhZRza6QOGM9jaQKexGo0px
 7XE5bikJNcB+yEYGhohYvwXmCb294ER25FH2cdB6wLt1gdkYfAQ3Ad988BgSVs4W2pEu
 iLi8nqrkDJEugH2O0DLfWRRJLjWNAc0EUI5+ntMKr2lzehiTnrcHQbVmEWevdZrEn0hl
 TmoUXbVZv7WzSDo23+iZ86MVgSTt3j4dOLst0PxzEvwPjSqgL2446Jz2xqWLU9beam5c
 dwcw==
X-Gm-Message-State: AOJu0YySqxjwjX5Ezpi9TRJVmzkmR4KbB/uAxRDWCe36jmjq5HkDN+BS
 txQfjfgRHmQDHmXdKp1PPXBMo6354SH3FfdC3oaz3gD8JqkUMAcSnaBXHRwlnZVvfXJxa99wJSe
 TjMNpSMcCmKzT/6RVu8OhO1GUvUHaoVZshsdFGYgCZhmpyItw7zMZ+pWgTwhKLXJpUmju
X-Gm-Gg: ASbGnctLdkv3S84ziGrf2H6SqEhwAZFnYKcQmoV6VHbCoWYazR9yYgjf7SeE0lal0XM
 IIWyh9v9b10j6twB9P4NIdX2c6a8oHV7p8LRmevjGwf22LNwjUxXOQbEjEz6IGtIJDlVh9X28lI
 h3ilCXsbIoZAi57WrHTMQPo6hRJB3mRrMgOfWQHfCv6vCG4LF/UdV/Xw2Wmvl22RCHL4HxbKayi
 R6XY3eHnKrHWEH6vToTPannuxnFSlb9TTX2rfH3qd8YPSrFrrRtoPaVBtfEEil+anD96RVf8/Iv
 pIwWtXxu0Nl3FV43s12cU6xcmj1tNzADz8AepSShA3fhGF/U7M4zGM5vANKMBy6dZUqdsYvryjb
 rMt9CVU44BCCJ
X-Received: by 2002:a17:90b:3e84:b0:327:7bf8:273a with SMTP id
 98e67ed59e1d1-32815412e85mr15051027a91.6.1756784847573; 
 Mon, 01 Sep 2025 20:47:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUdn0/kKA8H6RN1gHrs0DL7LQCJTl94sdU4CFiuFNYloS+vY0nnCdAtMLy2hD0fsEBeCFr2g==
X-Received: by 2002:a17:90b:3e84:b0:327:7bf8:273a with SMTP id
 98e67ed59e1d1-32815412e85mr15050995a91.6.1756784847113; 
 Mon, 01 Sep 2025 20:47:27 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:26 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 04/40] target/hexagon: Add missing A_CALL attr,
 hintjumpr to multi_cof
Date: Mon,  1 Sep 2025 20:46:39 -0700
Message-Id: <20250902034715.1947718-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b668d1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=UrstOHIbV4iY_BwJnwMA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 62q_Znw2oU40c6y-EdIiyvLam_0EqMxG
X-Proofpoint-ORIG-GUID: 62q_Znw2oU40c6y-EdIiyvLam_0EqMxG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX446Sw8XwGPMA
 rcwidSHVYbnzqpcwakKxcliJZxXlbCU7DIwKEivqLPmYd2Y4K1ul/NvpomHadSI4OOv9gxUwYP3
 48W8grza0Km8LkU4QoBNg50Pp7a4xjYMeYgE/seKYoVcG0/TGeTaUFOblc0h67MXVhn3dOHs/op
 yuM/5ubMffhhdz44rZ59gSzrGhwGz0qoqyAC+84RO8utT2vtB6Fzalm+D7spc8LJdANznGa2Dzp
 3eKKXicxoccqQ1vYIpsm865YNF5KJphR5gtBrSpgWYBHgmGfPoWWJu1CcZP5t7FPkzjaadCWeGR
 fGpWRev7xQq5+qbPLbVzv3lMvXvQ1e/4oXiiM93y32LTVORU8sY/uaqMfShu100pCnEoBHGJ/rj
 EA8WbuNw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101
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

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/hex_common.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 758e5fd12d..e60e8efabc 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -247,7 +247,11 @@ def need_next_PC(tag):
 
 
 def need_pkt_has_multi_cof(tag):
-    return "A_COF" in attribdict[tag]
+    if "A_JUMP" in attribdict[tag] or "A_CALL" in attribdict[tag]:
+        if tag == "J4_hintjumpr":
+            return False
+        return True
+    return False
 
 
 def need_pkt_need_commit(tag):
-- 
2.34.1


