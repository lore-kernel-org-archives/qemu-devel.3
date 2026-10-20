Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A60606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 23:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IBUlhyip;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JzsOr12s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJJ4K-0002If-HH; Tue, 20 Oct 2026 19:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJJ49-0002I4-Kd
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 19:16:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJJ47-0007wq-NK
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 19:16:21 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KKts993856505
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 23:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=UUnEKV76IrqweUGT3w2EpC7aJdrXgaXngBj
 IiBkLCjM=; b=IBUlhyipAUrO42PfBcsK15fprM1Hms9HKnVQo2jMFNNVdrLevkG
 tGXkWedpPx0Vf4nYytuCtQLMn/g/PXWApLpNE0kP+Ib/BMDc3hc30ovnf02mr4mz
 vM15paNNLUowUdEFLbCdnD0/WiTkDc53MXqpeoheevKKuTwp4+qRzhOmPKvgs7Fr
 fJG/JBM9rKLtY4xeej+hZTuP/jcGswVHS9bcE0v3tDrxqLAm9kbRZjBe7E+6ePGj
 7ICiGULQmcOLq4GgsL5u3U5G9b++5y7aFt8qo75+KYQXck61NlOalSJNjJkrXRTd
 s5N3FPtWC+0AgRHAd6Ds1pL8Js5il4eZSlQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedabh099-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 23:16:17 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ac7a4ba546so803432a91.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 16:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792538176; x=1793142976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UUnEKV76IrqweUGT3w2EpC7aJdrXgaXngBjIiBkLCjM=;
 b=JzsOr12sxzIhVWF9BXIafUF0qYYKoOXVq9r2qrq2S/jpKQoD+z/iZN7N8kJNqghw5G
 ZOWl5tDaf1UJj4yE7YCFLrl4VmPh4pUZCWI34Q5hCNWxwQ5P5SdSEvZYa6kWGAPA5ROA
 WaQTQfDzu0QMNE0rs0AC19Yfr1AEM0UJdJ05iGQqCiOOilTEg+hubzAwQk2/7wWFGYlP
 rmLelfRdkZhLKjeabtgbYSX1a32RZzDx6zg7VawAN9A/HOEWh+rzsL9Csjniv6RzJ28x
 URpOt7NG8JJwX/Ih0P7uAnr4/I3nIkohiyZgHebCys5HXjX4hMS0gWx+kcl+PHOY9W7Q
 OXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792538176; x=1793142976;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UUnEKV76IrqweUGT3w2EpC7aJdrXgaXngBjIiBkLCjM=;
 b=1H47WaJY2IFSkmInzdPsxpXigGR4LzPv0SbXrXppkXnFgIMfIeU3N7Y6XQ370grJAp
 SQvu+LKTQ1fPIu4Se59omfiYLPva7Pgf8QqURhNv6vIiFoJPNGKa5rY/kJGsDDXuEoZ8
 i13COX6xy45pUzUmFiIUdUp9XPIce60drkHaq/UGl3C9WM2yZdumrObJYMi3Y3mYlgu5
 VG189uiGO21ZI7bH685PTpWSq3gYkaiBftK/LNx9PyEP8H3T9T0ssXhxMRemNNi63aoU
 l482TRxbydXhPjPSNSJ5wSDUbKf0HqRgRRhhK1ZnV2PAkxxOTab51xBEPrM7KUmUrDfl
 HXBQ==
X-Gm-Message-State: AFq9FYJrCPBXu3+W2FZPjV+WPlwHkti0CG+iShuMRNFm6als4CX5ITTp
 pysYT+DWNnaBwbqZCtdWEgQZrzIzqxBOqHd5dr/hreHSyosdkTbOLb8eTOCOKU4UjzsBIwOJiXU
 h/xZQTtFhjzFViJLOBe9vFKMASK2pZTH5mrnVjQsY5KIA7wdvOtdlgSP7Yk1m8f/SjQ==
X-Gm-Gg: AYBFou3/6V5cpJ0/ryZzkERaft/9UdmZRyWPik+becSlKVpTGjxkUQ6aGVUMObW9sEs
 HBVdRk5oIorswpxRY/HnEzYl3ggG71EdrUfkWdtqPK78pL9c3WMcCKykBxWCc2h6yhkZ2aOXBIP
 kQMWClrCmXwfeXlY2pcflJBRKhkLr2AbAqk55hJkvLfS5xoB5USC/nJo5hchx0cfSEpVQN7qPmA
 dkWhs6uGfL8R5jO5R9qzSnbBtw0Avhhs5dFos2g/xWMI7kkBmcmI6VjO/8siM6WtNaDvLgi0klZ
 7/34YseGaAoB3ECpS1ZEDUy0IkZIPfb/gU2cQB35aDIx/9GESCoqWJ+/trdMf+1ox6ld332yf8M
 hX+8XK988N+Xoc7sX0/bLGhMlqPEd/rK8TZQnI/J9ptCV/IPXYZmgmPpwNALhFJo=
X-Received: by 2002:a17:90a:e707:b0:3ab:b39f:41ca with SMTP id
 98e67ed59e1d1-3ad86f397e5mr153928a91.31.1792538176280; 
 Tue, 20 Oct 2026 16:16:16 -0700 (PDT)
X-Received: by 2002:a17:90a:e707:b0:3ab:b39f:41ca with SMTP id
 98e67ed59e1d1-3ad86f397e5mr153917a91.31.1792538175785; 
 Tue, 20 Oct 2026 16:16:15 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad8085ede9sm1327968a91.0.2026.10.20.16.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 16:16:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] ci: add automatic retry
Date: Tue, 20 Oct 2026 23:16:02 +0000
Message-ID: <20261020231602.24344-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA5MiBTYWx0ZWRfXyg1TJKf8aMgK
 icoIHSe9phu6osWYCmlK2UwHa3nF3Gyv4Oa68Ia8ra0hHhppWDPutzgp88m7Bh6tDoFEgj3ISkX
 cpB91wy5pHDPpTIx4qUbS13a5ZNq3wY=
X-Proofpoint-ORIG-GUID: RBVd4nXCN1ZnAJgifEa4n2U0HC5Waoac
X-Proofpoint-GUID: RBVd4nXCN1ZnAJgifEa4n2U0HC5Waoac
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA5MiBTYWx0ZWRfX5SCNeIoXf9r3
 yjQp0D3Yxm8wmAwN8VSSy/Q+7Yi1o8o7aGwaFu+P2Y5Mg8n5rHUQUlmzC10fBgRex8OUUdW/O1m
 DMWyGygMfCoNzuShtnXOi0WkYufvPrhXeZ9Kz2MMzfcx62DacfI6yevuPhZyUBhbZxZelKFXsd2
 yAvGFJc1F839v6+DkqN6AMiw7fZS1ay2xMFWOVHLiBSqUXzV9e9czp+OwzCjKyHN8ly83fhMQGT
 ZWRA8la+ycV7tHKKi6CALwQsIi+Np1dr5B2sFXbUH4O4R9c0Me2z/rrdZk+khNEF8es9GyWqEFk
 65zWplTG7MUcoebeNxoshjNMFjV32LgYv4CXf6yUgMTVoep13t0XLdLHWHRMq4hZ7h9gQJSlVJq
 G/A4Qp/aNwtXTIO3EkWQMLCIVqade9EkSpd6bnYiqkX0IiuThWdakTpB4iqZvoCvMDXORID7udM
 eLe58XVC7RBADiDFz8g==
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ad7f641 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=tvjTBfmJX5djJxn3ErEA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When merging PR on the project, it's possible to observe failures on CI
that can be related to sporadic test failures or infrastructure issues
(pod eviction with Kubernetes). As a result, it adds latency on the
process and workload for our top maintainers.

This patch sets an automatic retry (supported by gitlab out of the box),
so failing jobs are automatically retriggered.

It's important to note that in case there is a real test or build
failure, concerned jobs will run a second time, and fail again. That
said, it happens seldomly since sub maintainers are supposed to test for
this before sending it. Also, the retry is limited to the job that
failed, so it should be cheap in terms of CI minutes.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 .gitlab-ci.d/base.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
index 8fe00809357..63ba82e3632 100644
--- a/.gitlab-ci.d/base.yml
+++ b/.gitlab-ci.d/base.yml
@@ -31,8 +31,9 @@ variables:
     # Ensure docker.py / tests/docker/Makefile.include always displays stdout
     # from any docker commands to aid debugging of failures
     DOCKER_V: 1
-
   interruptible: true
+  # automatic retry on failure (sporadic test failures or infra issues)
+  retry: 2
 
   rules:
     #############################################################
-- 
2.53.0


