Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D91CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utHzl-0006mS-HV; Mon, 01 Sep 2025 23:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzi-0006hK-1K
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzd-0004RY-Od
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:40 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SfFS031364
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pvFy5+kJ1ISufQWFswLlkKA0vv5M4P09aiJ7fnxS08A=; b=HZ8UsP7ch1JGmGzg
 qy2g3bf+8y8ZZEKAJhaVStJToHZyzbVn8EdTLXaAR/hlIQNQJNX1HBdfj8Y3KhsY
 mVdYI9wam25tB2aNIzSBX4GcPOFiqKRLUdaV3fVTOzrJPoYbldhO6/QpFU3qgCyt
 h7kIsEqQCO43/b9PDj0iy0FBVMez6UDBs9rJEz48oowtIXAOp1tHBy3xeZAGT21c
 0cwCXQ15IOtPwbd91/9MLQSfEzpFU7cwmczeQ3Aq7Pg8/BZY6En/WPvmccSKrsQE
 o63pcOnpzUvMonWPd/97pg1qH8w5hg0bYbuCA+aB2t0siOW9de8OsPmFErt0XvGZ
 0jgfNw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush2xaer-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:36 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-244581953b8so53891465ad.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784855; x=1757389655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pvFy5+kJ1ISufQWFswLlkKA0vv5M4P09aiJ7fnxS08A=;
 b=k/qOy8M1cZxsUC2Tz5ll4ToFRZ/OLso1lpNtsKKVp4eskmx/xl/S05hmOn0qQhrQQ0
 jiTjCRmLPr7dWe2opuY+GE98n181ZXTDgorAHhu3OOUSme8EU2XRaYyNK+LaN1RCM+9t
 bOHyETlSJnWl9fT4s9XIQq9XiWnweyWK7VNTu6PuQfL0UBp14z6oURSP7FXZ/8nIbuII
 H69BcCO9x8GMsmpBEqcN9omp3fUjAvWLa16G7QciogyzbytkvKtUy7S9H5Xj2EChMQ6o
 Ff562+uqrhW0msNlS+HQ8MgW6KU1eNVG9WfeAw3d9lp38gmeaBUuIjvtB1jPwhTYlzMq
 3GHA==
X-Gm-Message-State: AOJu0YyBTDoqcvdDHd/24Q95n8NfT4NJxYPHAHuvj5z0AOslKPbHNlFx
 4X5CoZyX4Jg9vCuqpCwIBSUXZfa4TjmR1mT+jdwn7IdmOCEECL7+YuVUwKTi54gd8ByAi8shpVY
 dcpPWOCQdLxI77HA5bTKakNREZ+tKXnTKaejOdw66mC423DIFYJCu8eItMJ2KtGi0vVTE
X-Gm-Gg: ASbGncsD2gYFo6uYNu2UaV0InbQ1nho2vkdZ34l5ZQGgx54OEX806NLWgg8hszI8U/f
 ioa7XpTx3uVPVxowRaQ6ytkU/PGNieJtcqVlPMiWCFhzU8HDd5hVqd8QLMjElb8AbzbEA+BspUx
 8xFroFytjOeSpwt8n5PB6PZkxbsi//H1ry0zKE8STFiOBGJ/8mq5T3FW7mqUiDz6zxKqnVs6Tew
 orjWZQM7I5GsLNFgmIMsdH+THkDOcX4j+h91TscYt74VUkXsHgbBIaKkTOZY0MxckzPevcKhqGV
 fOVa+/Ryp32kbCPT+5GPvxMLOxJaO2QRKozILj8Lx9GnRZGZBpX9xtUZz5siSG8A+rCahrK8FFR
 R3mIpqeF1OcO0
X-Received: by 2002:a17:903:22cc:b0:244:6c39:336a with SMTP id
 d9443c01a7336-249448deb89mr159279885ad.3.1756784854927; 
 Mon, 01 Sep 2025 20:47:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY3UIqKHdm7UuuBPCswHP8M+8BzQ0mjDJeAc0CcWs0smicnUSVdTvzKcRcWiaOYc43BRlfsQ==
X-Received: by 2002:a17:903:22cc:b0:244:6c39:336a with SMTP id
 d9443c01a7336-249448deb89mr159279575ad.3.1756784854479; 
 Mon, 01 Sep 2025 20:47:34 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:34 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 10/40] target/hexagon: Add memory order definition
Date: Mon,  1 Sep 2025 20:46:45 -0700
Message-Id: <20250902034715.1947718-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfXzGGY9RJturiS
 EHX/sDgQPvs5Jmz33sAby1x7i+m4Up8Ao+TPYMtWo1B+rgiBholA9GpE4Vh6GPjdRLKaWmk5DQl
 ie8Cf9/QVGeuO4HhHWVhhxtfkxs0kwJXt79hZji+vDLTMY6ksSurGjzJGLYnqFsdids0zQYtJnT
 ntj2d8jXIpg/AYcEiOoZfkpiZ1uJ/4LpS6ptCmUFVvFpBBPsqXTspnhRjcDs1QaycLhEFd99FHO
 ozv8Jm2b0hi8IZMsQVc20yuUDoWBozCz3+AJMCc3JEXlxRmXQWGlFr5SuAvbfky14AWEvzC1XOh
 HB6HVlSsz2+NcMyLFGokPBS9Nww6wpIERHmqXWTVDRHfbxXCAG6KqIVrPZYftj4b48xwhBbc8cU
 cgrY3igJ
X-Proofpoint-ORIG-GUID: oTi5Voezh7t2OplbHsywE-P-J2vBhzrK
X-Proofpoint-GUID: oTi5Voezh7t2OplbHsywE-P-J2vBhzrK
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68b668d8 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=mbGQxb1c5k3ajljyOIAA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032
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

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu-param.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/hexagon/cpu-param.h b/target/hexagon/cpu-param.h
index 635d509e74..22bffa7881 100644
--- a/target/hexagon/cpu-param.h
+++ b/target/hexagon/cpu-param.h
@@ -25,4 +25,9 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
+/*
+ * Hexagon processors have a strong memory model.
+ */
+#define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL)
+
 #endif
-- 
2.34.1


