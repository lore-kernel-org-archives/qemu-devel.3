Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EA6606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GpPCu+vv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AxoGsRIj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmqd-000398-KR; Tue, 27 Oct 2026 15:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmq0-0002v9-73
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:28:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmpy-0002LV-0e
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:27:59 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHfaq1917531
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cKETLbdPQdzg4BSfMoLC+u+UL0vHyrUBbWDJ5Q+m82Y=; b=GpPCu+vvq2d8L2zc
 5Vv0vGRPCAHTdBuFJiHrEzaLOORGL0ZOLgERfcVSuWCsG9N8NGFcbAMAoVk+IMiV
 mKrgEoVd5M2FDAMHHLNa6AxGGpmEOzDtak5vik5QNRnrLk0X60uf56iSRbin0WKl
 s3+smtsgVHgHVihybVOe+1sGs8u3T70NT0MtDAbc1qWDY66uLceblMtIM7lldQ9w
 l4qn6LpcT300iNbQ8viqfXS8m4iK6iLd36gmpPm6h8fmK0fgRRSx0rk6Nh86Q6Rs
 yxrP1faTKs09EaT7QkaSKCSsaaQrOw/Lc1WLGuIJQQRhPP5wQ3mYHknrNb7vTfyw
 RsjAwA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjux99v6q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:27:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f2c0e6653so19282785a.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129275; x=1793734075; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cKETLbdPQdzg4BSfMoLC+u+UL0vHyrUBbWDJ5Q+m82Y=;
 b=AxoGsRIj5RAZfJECU1fPUtunToMItGTuCLI/ZRNuvi8169ICYaRxLwDww7wfcjGxTg
 aX8N03qJAkJ39rOSCF/eZ4dlqPv4s+dsmFogrOsQHqTybFyYPh93+Cz5AOK37qpUL2ye
 JRv0xXNWAfFexwxT0nv35AtseryLPtlqeJSwaQ+gUr/bmzZ4h4GtQXVZM+3DrEgFBnWt
 btvqu17lQhLVHFCLS9t+WsaaF1dagL0T9kKcY5rTZDKJAP+MNioGg5MT4ubwOprZcFCI
 jSa9DJAhldmgOV3y2T71n8rAzjJsCkZOXLJTJ9w8S1WuM1AotF6ZVWwZU8zdaO1hLNi1
 nKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129275; x=1793734075;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cKETLbdPQdzg4BSfMoLC+u+UL0vHyrUBbWDJ5Q+m82Y=;
 b=JejE8mj+BBRZFvuCEqx8IEyUU4OMbdQw/725uizG+WaAcNpwKnCWEKgyG8FluTra7K
 dSX0DAEPJzjcK1WYc9W0KkHB4NMJJs9Hc7GBCDnClOugJ9lsOWihjoyZgla4YHAtrUZJ
 DNZy/Yx8V1SxIlcXjS5Dkv7c2ju2UYV0cIEgyThyW9h1hQ4Cps7U/Bov+3OaR1VlDvUf
 7xUm6eWQG6TtxL8xAjqNdXTXor2Cbw/lb+zH4OO2KcGFH7XzoT4/ljM3Ygh8lMgroMSC
 S5LQAIvifOyPCLC4fYnIxZrbiFfPj/35o2CQB/8UfEFfaCnmBio71EUybFajAerL39ek
 M+sw==
X-Gm-Message-State: AFq9FYJwcK7i0NQP3wDb0eHU0e/1hBU+zRbftzu6gWOFT6rJjG8RB0dS
 WY3hQzo8xr4z+mqNyhOEgtI5OFoER+J1JlJkVejCfQ0YUSm9Bt5p2M6dxRQzfBLIbM8y2/VZcC2
 LPqZPvUa+tBQsVz3eqUPitO+pkNwBSEVCuIM75g4eae59OumTq7giuC+rmq+6MOL48A==
X-Gm-Gg: AYBFou2T1kZj948U2etLkqtEgcHvXbsWeNdJZZDIsf3S7ED648nKuOnDKYPmBoD2x3d
 y2GCjBKlzyZPT6jDjkTwzWayjzL6vI0E0oglyp2X8IGNxDbyURPsw0RzUTZ4o6fBO/AefKv1HtY
 V18ZIBHZaE0SATzpxSxLzsfMmm8QTE/CIRGd3ynXt+USt4Gec8LOiSJt30vaXPXACr162yrUtZ2
 Nk2nciHdoRkozJk3Jj2bj2i7U28fycOpNQ6ezkFgZuw1JMKbnII97TgQkgjCg5f9sGn30ucV3G/
 9DwxG/4j5Xwgd307jHWLHzwCc6g2AjstDkbSXyMigGf6haMCaXRQpC0JdE2KIU6C4KZi/pxBTZx
 a38l8uBJ7svb3Z2DOT/KupUwOBvEfqrSpQ0Ty/oiotK7pVCFlI0DB4/M8
X-Received: by 2002:a05:620a:a881:10b0:940:f53d:5f7 with SMTP id
 af79cd13be357-940f53d1553mr1151964585a.69.1793129275572; 
 Tue, 27 Oct 2026 12:27:55 -0700 (PDT)
X-Received: by 2002:a05:620a:a881:10b0:940:f53d:5f7 with SMTP id
 af79cd13be357-940f53d1553mr1151962785a.69.1793129274961; 
 Tue, 27 Oct 2026 12:27:54 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94c021080sm2956645e9.2.2026.10.27.12.27.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:27:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 37/59] hw/arm/fsl-imx8m: Fix typo
Date: Tue, 27 Oct 2026 20:23:18 +0100
Message-ID: <20261027192341.9197-38-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GYyCDgXL c=1 sm=1 tr=0 ts=6ae0fb3c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=8AirrxEcAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8
 a=3gjPW9hNBChsr7orIJ4A:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=ST-jHhOKWsTCqRlWije3:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: x4MAL3kIHoijgVKWayulDl_c1yyZn0Ll
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX0Djk+CXKJv6+
 eaGT90bVKsadk3Qsa/thgZtRPQOXRKZ6zlwovMQCf0bF6cZyGQR1rnCjRXiUwC5FQMbhPZealvn
 hggoaEdfmOIanNYW9Ap6kE7oY0SqjgxFKyWDLlrSwuBPnwr87ctO2tSqUbs/1vpLY4yPf1fokMl
 X6ECarz8Nc+bFj9L7bP9k9F+In58UTCJ9Y+WiYa/XoOEcot+6IO18piTmKG5j3/3Gk8e0rExCJf
 Qro9KJxmObxpnFmx8BlNKmzAvEEGP3Ueu59AozZNTK+jLxAUnM3qDaEvVV956hXH873231rrkVm
 1PWH4hbf/aqeDjpyeYkqu3MFiZ/nt79lrchIjI8m7/r7tgqGpl0CUGr37BlO8kCH4Kb0RYKTA+F
 6s0AOgRM1rGbUy6q450Q8/Tk8ibRS7yhPaciECNYx/LcB/Xw2cGc5hRC/RKlATypdov04/D3+O8
 MsMoia95NQDrcGADs7Q==
X-Proofpoint-GUID: x4MAL3kIHoijgVKWayulDl_c1yyZn0Ll
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfXwlCGaECV+PCo
 4Gu7ek9tutGFPexklpkxfRbvW87pU3+yYv/8HPf77ShSCvpGBVolBIJSZ1ES2cn0dnZd/xh/9eo
 vTJ6H9gMaUOkFRiQt5U7QnznD/sE/gI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

From: Bernhard Beschow <shentey@gmail.com>

This is IMX8MP and IMX8MM, not IMX6.

Fixes: 0c105b261551 ("hw/arm/fsl-imx8mp: Add Ethernet controller")
Fixes: 857670200c51 ("hw/arm/fsl-imx8mm: Adding support for ENET ethernet controller")
Reviewed-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20261006083445.30362-32-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/arm/fsl-imx8mm.h | 4 ++--
 include/hw/arm/fsl-imx8mp.h | 4 ++--
 hw/arm/fsl-imx8mm.c         | 2 +-
 hw/arm/fsl-imx8mp.c         | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/arm/fsl-imx8mm.h b/include/hw/arm/fsl-imx8mm.h
index 60d79a6e3c61..1966fa505fe4 100644
--- a/include/hw/arm/fsl-imx8mm.h
+++ b/include/hw/arm/fsl-imx8mm.h
@@ -229,8 +229,8 @@ enum FslImx8mmIrqs {
     FSL_IMX8MM_WDOG2_IRQ    = 79,
     FSL_IMX8MM_WDOG3_IRQ    = 10,
 
-    FSL_IMX8MM_ENET1_MAC_IRQ    = 118,
-    FSL_IMX6_ENET1_MAC_1588_IRQ = 121,
+    FSL_IMX8MM_ENET1_MAC_IRQ      = 118,
+    FSL_IMX8MM_ENET1_MAC_1588_IRQ = 121,
 
     FSL_IMX8MM_PCI_INTA_IRQ = 122,
     FSL_IMX8MM_PCI_INTB_IRQ = 123,
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 2be3c51af56a..3acfffd30fb9 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -276,8 +276,8 @@ enum FslImx8mpIrqs {
     FSL_IMX8MP_WDOG2_IRQ    = 79,
     FSL_IMX8MP_WDOG3_IRQ    = 10,
 
-    FSL_IMX8MP_ENET1_MAC_IRQ    = 118,
-    FSL_IMX6_ENET1_MAC_1588_IRQ = 121,
+    FSL_IMX8MP_ENET1_MAC_IRQ      = 118,
+    FSL_IMX8MP_ENET1_MAC_1588_IRQ = 121,
 
     FSL_IMX8MP_PCI_INTA_IRQ = 126,
     FSL_IMX8MP_PCI_INTB_IRQ = 125,
diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index 37934d295111..90c167346147 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -590,7 +590,7 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->enet), 0,
                        qdev_get_gpio_in(gicdev, FSL_IMX8MM_ENET1_MAC_IRQ));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->enet), 1,
-                       qdev_get_gpio_in(gicdev, FSL_IMX6_ENET1_MAC_1588_IRQ));
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MM_ENET1_MAC_1588_IRQ));
 
     /* SNVS */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->snvs), errp)) {
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index f855378dff2d..fbc094b7db90 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -620,7 +620,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->enet), 0,
                        qdev_get_gpio_in(gicdev, FSL_IMX8MP_ENET1_MAC_IRQ));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->enet), 1,
-                       qdev_get_gpio_in(gicdev, FSL_IMX6_ENET1_MAC_1588_IRQ));
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MP_ENET1_MAC_1588_IRQ));
 
     /* SNVS */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->snvs), errp)) {
-- 
2.55.0


