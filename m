Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BDACA100D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI2X-00078w-Ku; Mon, 01 Sep 2025 23:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI2K-0006Tt-FV
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:50:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI2H-0004vw-Kk
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:50:24 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RmuA009790
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Cxpn5WiUNamoyYJ5chnT6xEKV6QOQI0br86wFh+RdBg=; b=Hdom5UaTM08C6kSf
 rXq6YlrpOVGmie6TvtnwohHqIWdKT7U1TzFo0dvlwab2mNnXdPQNTUD/lIPsKHOR
 S0Ihim+PfjEB2oCLS5zS4tfJm9o/twCyDn2OPAo5NV6QLGOLQyreQzZLiK8yHSjM
 /rjC/ngG8ONtvg+f3kHjvzbB2ByHqEWrPXlYXPFPEdq3nqxvOMi8/SXMSY+pfZbq
 R5CpR5878TPtUfgI0p4kqmxadnBaI2OLVfqwz2PI5q4JZ/jSYH8DTBe9osLAdlAV
 bAp21ey0/OVmbIigHZSCuGhouJP070F76bpXHJDxHSNgWAY2XUWMtYk6DS6h21f/
 RNwRSw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjedcy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:50:10 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-24a9de13b7eso25940285ad.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785009; x=1757389809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cxpn5WiUNamoyYJ5chnT6xEKV6QOQI0br86wFh+RdBg=;
 b=fewiXVEKLkWze324/iDL6IYVD+tIdkumLENOqK1xTwyiExR1Hisg8GzHYTsAOaYYYx
 FN8GETdqbMsf1kuGy4tAsrYJIUoTkA5LGJwD4sUDPPbhgN/df+fIdiKtHbwrKT5LoKnG
 ikAZOhD7sfV1F8x2o/eM03MjGLGO49IhoKOIuY7vyrhqJ4fQ/x3Gjr/iloQCGQUfE9ME
 BIE9UMHZTpIWwSTbISnc0duJDenZPOJds7GmMCVpVoqDckwij9dMAVV7YnYRuoRWvV0T
 +PJ1I1Qhr6iLgiDsGXX72MGesOBc2ukMYWcmkMg809Qr7lAnJHDuwmNuadwC8dSv/0m0
 6dQA==
X-Gm-Message-State: AOJu0YxsLTrxksCCeSXU5RTXXDUynI4sUK8D6yjAStSmdATri3krFarr
 Vau/jgVka0arOkqgUoqBYMZOtETEJjWo4hCE9tgQHto2EjXl6aIyi2ZtQcxSls5c/FP7qXti9cW
 rjxUhRUkgf3M2h3NtnZjlOjWnGyv7FrwOTGPmM3jnMZ0RD4po2dl6DBPXFiQfPHzOeiyu
X-Gm-Gg: ASbGncttqWUqlCYMQcy//mdipeEvYXLGL1ZN6JaFpqdjw8p1xI0s+f4YGcax/o52fCd
 b/35d5rjlYde71NdAzRXcIOC4jC1PIlhbNNgvsGQHPWe47VHK5hyqIduC5nAfmMQDQg9pnZzg8+
 JS9txi8xjB5zJzi7mVkGsQ5O48X7UK9NTNnRdRZi1WzFm85DZbrRvTzuvc6EsircTzDT6GlX2ae
 Q0qDYsIMBL+XJIQAjivOWXH8jtyzzlvM1bB5+jZtHZQlgPJHi3j+q7wKYIPZa4JPsPERVzkD9ya
 NIpV5or6B/3VZt8vFaFXqGrl2gcm6zksVhVhteEAWc8jRn8G8p6kyd8mmFtlJ+noJtMFl/TLlN0
 QzQJHrUwSml0W
X-Received: by 2002:a17:903:ac8:b0:248:a629:4b23 with SMTP id
 d9443c01a7336-24944aa310bmr140061485ad.36.1756785009028; 
 Mon, 01 Sep 2025 20:50:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUdYYCsxjUW5rIw+f3t6W/0Wd7s88TMne2S9/CLMn4X4jcftFU10InwDxNxRIBfQVmesDb7g==
X-Received: by 2002:a17:903:ac8:b0:248:a629:4b23 with SMTP id
 d9443c01a7336-24944aa310bmr140061135ad.36.1756785008553; 
 Mon, 01 Sep 2025 20:50:08 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327c5fc5055sm14117932a91.14.2025.09.01.20.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:50:08 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 06/11] hw/hexagon: Modify "Standalone" symbols
Date: Mon,  1 Sep 2025 20:49:46 -0700
Message-Id: <20250902034951.1948194-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034951.1948194-1-brian.cain@oss.qualcomm.com>
References: <20250902034951.1948194-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b66972 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=QhYL57-57G4zB7GrFpIA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: kNaI94D7shRxJuvn54xPKw-Q1fG0gQOu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfXzynhFJBnFUvM
 Cd5a5WG7R6ZoluYMamatsiLJwMq5uaGIOaL+PbsB473ZE+QjYJLwWMKn8hLakKEWo883xvdj4qD
 WSQ+Json6tcpub6POqXXGyR4G7K2XWW+hv7Hj1xXmGD/EaVnvE7CZXnUA09B2jnH7ywmRpMyKMq
 cHIvjl80IS6RsPrSsKzrBVvD882/iQw7BTiJ1r5QKhDBwnJgsf3LxqX2qBrod6lj/8pkJ55LZJ1
 ahOwW0JRKpTD/obSviOoXuhb85QYE80RBYD39tiwAPCxEfuF59GqcGEar/al9fOZMC95JDTiSVH
 L/RiLCvR8e52qwlkVraJXDB+XTxWo46xUZwS3qbBbnNQ2IqWFkP8G771ZVAEZOSLH6ASBGhTy7X
 g33nFWTT
X-Proofpoint-ORIG-GUID: kNaI94D7shRxJuvn54xPKw-Q1fG0gQOu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024
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

These symbols are used by Hexagon Standalone OS to indicate whether
the program should halt and wait for interrupts at startup.  For QEMU,
we want these programs to just continue crt0 startup through to the user
program's main().


Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 hw/hexagon/hexagon_dsp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/hexagon/hexagon_dsp.c b/hw/hexagon/hexagon_dsp.c
index 486dc41f5d..510378280e 100644
--- a/hw/hexagon/hexagon_dsp.c
+++ b/hw/hexagon/hexagon_dsp.c
@@ -29,9 +29,17 @@
 
 #include "machine_cfg_v66g_1024.h.inc"
 
+static hwaddr isdb_secure_flag;
+static hwaddr isdb_trusted_flag;
 static void hex_symbol_callback(const char *st_name, int st_info,
                                 uint64_t st_value, uint64_t st_size)
 {
+    if (!g_strcmp0("isdb_secure_flag", st_name)) {
+        isdb_secure_flag = st_value;
+    }
+    if (!g_strcmp0("isdb_trusted_flag", st_name)) {
+        isdb_trusted_flag = st_value;
+    }
 }
 
 /* Board init.  */
@@ -60,6 +68,13 @@ static void hexagon_init_bootstrap(MachineState *machine, HexagonCPU *cpu)
 {
     if (machine->kernel_filename) {
         hexagon_load_kernel(cpu);
+        uint32_t mem = 1;
+        if (isdb_secure_flag) {
+            cpu_physical_memory_write(isdb_secure_flag, &mem, sizeof(mem));
+        }
+        if (isdb_trusted_flag) {
+            cpu_physical_memory_write(isdb_trusted_flag, &mem, sizeof(mem));
+        }
     }
 }
 
-- 
2.34.1


