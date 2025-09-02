Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C6ACA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utHzl-0006mV-Kq; Mon, 01 Sep 2025 23:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzi-0006hL-1K
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHze-0004Rk-O3
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:40 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S2Mc017549
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D9buGlWbXXSE/93PtKdOm5QlqDe4gbK8gLamSNKDoHU=; b=QkTvDRaZq6VLMcGg
 9hOEN6Q1t+gfkkwzuPAkvaGk7rw+dwU17rUG+NJ5h3FpV7TqTld6V5HUcYbWHYzY
 y6vWnZ0WQAnc2RzxrlqgND3CuQMYbbf2XWU6uVo3m6l3h0UvlXzEHQND4pvKScfc
 5lmWi5vLwQGOMOq7fn9tUAcT2yna/vT43+iMmKF/Q3RrA2ikD4Kccf0IsyOZLcx7
 SNFpka5pNd0Ktmk3injbf8lu7XvVfkkQYw1dHbmNY3fOg7keenZdul5CSr2MGXS6
 RLS3REViHMjt196Bfwl1O/UEH5JM54E7YjmgPMlrelwFk6JBf/QiXkpxMTPuc4L0
 aSddyg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk8x860-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:37 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b4d48818a04so2706995a12.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784856; x=1757389656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D9buGlWbXXSE/93PtKdOm5QlqDe4gbK8gLamSNKDoHU=;
 b=ZfrDu4Yg56c2eGCBhoKRDLSfoNxcDSK60IQEk0JHWgQeE0e1isz2tGpv5ISXXjhfns
 KUPbiYqX/oATCiTe+UoNHNVmNO0QD2CQ/h58ExEoE/GrUvRralUJn3vIdql4sdK+J1NW
 mHdb5sHOZTdP8F/+KAvqYdHO/w0tsZgoI7OpkW2JDRQ+wm2d5iG5A1AmcwEr2qGwkDZb
 mZMcE6UEP8DvzCWBIlZHimIafE4NRnaH/9YtKQhN1WfQi7qJOKo1hPEcbjutX3/N5MH+
 MqNg4zU7ulEjGeiaXkVNcclTvztM6mWhUMrZ7GncXm0/tWVihM+nSQF4xvmt/NnSUZYI
 /dwg==
X-Gm-Message-State: AOJu0Yznj+mFPCWUfptNXN63k56kbsTHTA0swcFS1siOKg5oOCkcata3
 ZwYYqLIW7Ej0IjVKCAGfCQ2BWfZoMnzCOeMSXf8FRa2MvOmUakXs70AGsq3lIoXCNWmCYNY58b/
 LwvW3gwy+417OVol9tJhxLhwVlDsItL1aJPIJiRTQVLtHw9K8AMoWD9DgBqpNqF4+xSrf
X-Gm-Gg: ASbGncuIWKJzpE8Vwhe0rX1VLxnejPjqv9ZJeKAeYm6hSe/970WmeiR7nFyvs/l1RWK
 mM52k9XCNe13K6peJcsLGJ1jjW+x/8XRcRALiMKCXgtix0K5CsDqOHjL42OhtfuJBqgZrVws4i9
 I2mWk3b6vnAy2r9kWiU4oxBgNOFH0JLdW9BdElBfnRXZG4lbC5UeEiVAsSTlVNEGtQryuA339ZX
 hzStXwPSRjCi/TBdujSatEdtbENNzgcKPo21H/63LOyEzjKXGuhCyeydpO0XZVNDq4MRgCf6TiK
 GuqrYr+Ax7nyvanN6jPMIoA8FbRZNWNDePktkpjDoP7hmEMXxeRbsSa52eyOpuf70KhXxUNT/ok
 mhmyEpvtc80z/
X-Received: by 2002:a05:6a20:12c5:b0:243:a663:9110 with SMTP id
 adf61e73a8af0-243d6e00835mr13963590637.14.1756784856097; 
 Mon, 01 Sep 2025 20:47:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdWyP2oHCBbye0A02idjhPwVecukBU1jOpHxxImAu9MR7WfmY3KnuE6tsvWH3Kp4lUQW1G1A==
X-Received: by 2002:a05:6a20:12c5:b0:243:a663:9110 with SMTP id
 adf61e73a8af0-243d6e00835mr13963562637.14.1756784855670; 
 Mon, 01 Sep 2025 20:47:35 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:35 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 11/40] target/hexagon: Add a placeholder fp exception
Date: Mon,  1 Sep 2025 20:46:46 -0700
Message-Id: <20250902034715.1947718-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: d8AYoeuJwYe76N6l1ra_ftsGOIjHWes3
X-Proofpoint-ORIG-GUID: d8AYoeuJwYe76N6l1ra_ftsGOIjHWes3
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b668d9 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=R5LHHePp8dzqxDYlWrYA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX9C6IIDlMXDgn
 ye7k1x7OoxM9Hib8lYSDMj2wRMDEQEze/C/mHBZkOSzlGGW/UCAaJ0pqlTutEPdHpFKxqgchKBc
 Q1obGwKlvDfU0On2zshPgBFMLGIQMr8ldMLQiZW6jL+by2Evqd+mWn64wZuxiJxd4B3ZEH4nK9l
 vb6+hKtaAsu+sJvcLsTmpizk1Y5g/BkoOzcaKLxutxbeuMDiF3JUU7NTScBpN2YVlxUycUiq6Cg
 yQ0vVli0c7JyiGiy8eJPMyyW4rAvYGhWsqclZstPjdw3KADs0p/5P0Tu8E/wsXOHxxV5XDPAtax
 mCCIGcNDc8risQ6rLK6XFJ5IdOrs738RboZ/QNwf3VMUGEe+kMmNNqyeviQPiABAaHuyF9au65v
 JfiD1bAb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042
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
 target/hexagon/arch.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/hexagon/arch.c b/target/hexagon/arch.c
index d053d68487..87c2f6a53f 100644
--- a/target/hexagon/arch.c
+++ b/target/hexagon/arch.c
@@ -208,6 +208,11 @@ void arch_fpop_start(CPUHexagonState *env)
  * model it in qemu user mode.
  */
 #define RAISE_FP_EXCEPTION   do {} while (0)
+#else
+ /*
+  * To be implemented.
+  */
+#define RAISE_FP_EXCEPTION   do { g_assert_not_reached(); } while (0)
 #endif
 
 #define SOFTFLOAT_TEST_FLAG(FLAG, MYF, MYE) \
-- 
2.34.1


