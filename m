Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C87606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c9Um2VQm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Urpifiw+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmoz-00067j-7F; Tue, 27 Oct 2026 15:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmo1-0003CQ-Nb
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:25:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmnz-00027G-J2
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:25:57 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIICDL3486395
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YOc9+g0uWp4YmdKLLJ65ly/FZiXn9rKsDmqyob+IyEs=; b=c9Um2VQmGJcvymqJ
 nknYFxDzXxxy1Pu+nhzxCai8yjMAsgcQmYOb/tPXkGX5Y/BGGFAjvJLFQOjJ629R
 /peqMJl83UDg/uoHi0+pbB9N35qvN8qpeD3w/7CiSAQAq8/cjkH9juuZ2X3BL6ys
 rt7/45ApWtb32sBw917PS03fLLkxLQdiC18Dx6oVIW3cPq6GrgqD7k4Bzt2rXXx6
 sbBmhBWPih+oxXUCyO0IXLV7wcz20Gnbxi7ZehJUm+am7Q2sDU4U5UFAS8DOmIgz
 uXrQGFkpn57eKxot4iGVggPI5hGe5km1YiqLgN1T61a7opJDIjmoFaXGZ+rWllVN
 Md8Dsw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjjbtc2u6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:25:54 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f37c94ceeso268552285a.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129154; x=1793733954; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YOc9+g0uWp4YmdKLLJ65ly/FZiXn9rKsDmqyob+IyEs=;
 b=Urpifiw+gEdTBbB32wyyH+oUTgAwgrUxleaZvTmX4qEfXzBxd5e4ilsDgTQECbxZYW
 NxEUHgX8mnHoMHPGNcXdKyN28LnLbWA12vFU6suPfe5V5DGVShrWBv9z5QNeLlcP6v2n
 p6eDFUIacJCEgw6AXHYCzG+j48F9Cc0q0Q157Mdq34XP90HgMg9HowUtHAFlcJZ/LSOr
 pVIVvEj9GbMPQ9fZQeqUAS2RE3CDnXm3u13++nKI4NuZM5HIQ52UDzsGkG82HAVq0WWZ
 HdkLWoq6z9hkIcR+SVCYH1zDg8NErCRX9BTWAcnekBMSkqdfA6Ai1S6dMJT4fnPNoCTf
 CqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129154; x=1793733954;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YOc9+g0uWp4YmdKLLJ65ly/FZiXn9rKsDmqyob+IyEs=;
 b=vb6YC6r+Y5SA5W66e8gp+MA+8BZoqu5TuKDnZbD4FCCXTGrGb/VS2L+FHeXRaillgx
 B5EB+WfkJrw5uSVut9jtzWzyS7bFPrPJZEtv9yZO9RQRCwUYU9yHMIT1yi/sSQ9puMw8
 1dG1tE5ONgMmdlFVz0FvcfYwHojBqKi72/IEDJZbinsd/KbuW0CH/RvHH/Bia4HL+5+N
 Zy2v57uz5JBFNxuUX4xSBiwxpJD6RGNNPhlxmPcKwfifc5yvQu/lz8XEf6fJzFkEEpK/
 1o2mN0PvBTF6tuWLptRlnTgdepXeatDYMOI/KXEdM3UcILb3b5WMP3ABOYuJ1nv1+WK9
 I0Vg==
X-Gm-Message-State: AFq9FYItaBgiCVFIXmYXezkV8YgRPvW47PIzkcAQz1w4jzlv56NXSapA
 t2uTrRLYzhME7a/V8C04Svp+PHRcWTRS6PGJGK+ixaz57kiReSfk1UQPL7H4k4ZHVA8rhG9Q8eO
 njV/F7CYPbIjtkNbsZiInJz9V94FiFCzoGwBKdYfaQBp+LyjI3CtmWUNE24iCCyi4aQ==
X-Gm-Gg: AYBFou0qYwVbrPcGCcc7AcYIe3ZC4s8KW8oZUvWSMXSnxdidOXl66bmLwqwRtEREDr3
 /RRE1rByi0v7pThgEGIgepAt3OM37WmkmE1Q8sIT+iS2K7PM9PWDjKdK8PN7UL9jEryFtvXKTiV
 J7r11ckp4QXlP1WYxl6/+6Se496vC76osHmTWVKVvbRe04IWwuXJ9SPHcJutXnbSjnNDzT7Mli7
 mlXqRb4s505+hCiUJt8zbHnzCW4OuPg17rINYOWyaIBqXrL5mMLxcgMIdn0Is/sNzW6ct9OdAuT
 NvC3/2o+mwM7DVoKQD531s5IV/iemHUoRu6AEwv/zMnhUHMBMYU+DdvkY+xYn9YwSNPdQDp6SiW
 uWn/+GGo4qU59Nf8QSkLKDdViV52qraN30ftrpMn70nhz80Cr3wguRBKc
X-Received: by 2002:a05:620a:2626:b0:93f:22af:ccdc with SMTP id
 af79cd13be357-943f4a05f51mr596407385a.4.1793129153779; 
 Tue, 27 Oct 2026 12:25:53 -0700 (PDT)
X-Received: by 2002:a05:620a:2626:b0:93f:22af:ccdc with SMTP id
 af79cd13be357-943f4a05f51mr596404185a.4.1793129153130; 
 Tue, 27 Oct 2026 12:25:53 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94ec8304dsm2844995e9.12.2026.10.27.12.25.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:25:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/59] hw/timer/imx_gpt: Wire clock control module via link
 property
Date: Tue, 27 Oct 2026 20:23:00 +0100
Message-ID: <20261027192341.9197-20-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfXzWGV7hcg+jks
 l6UwY2KIQaAvjmNf8uW5eGnBKmuMFK9bUBgDmPCGr+R48fhzjbzkrJYy6qHngcqTlDJlDMLT9Tc
 wfIZqU7kgjoEZdeupKMWxXTZzovuJRs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX2XzDeBlYnwHn
 fBKDWOTXPWoCp+4nzye97p0cjHRdFPcCMwdMz0w12vstS3GYMuT7oodgBzvgO9eytIRcP2Zjrnc
 9sOoiSJ45PsN/3FZRFam0Pa0HrP4y8gHD2Le45nIwX1Wdwm9mJ/Po7SL3VRMKovq/HUY3x4efh6
 03Zf2Q28GFbXzdhbaDFqJZgisSPigfuEL5Smad//BseWiy4jZrKjaF+HT3UJU0VabwE5yNxMQap
 z3+5DqHBta7OgrYTeKGGINH5DFbW+rt7TUHhAbC6fRy19FjkdWpzM2wxMdOVCHXTHnm3SKnKIm5
 TUymzR/vfFWe8Z8t6lGXp+bFRNBBXi3YHSCkniiduybrP1TsOjMedLvyudrUkPWT0o1Ewg+JpAp
 HARfAk1etErIv1+NZKeLUcOpDnrLlMaGkx/jzzm4LjG829OnIqZtFhOgab8HknLV8KgKZjgJABa
 fEITfbXZfr7Z9o16w1w==
X-Proofpoint-ORIG-GUID: q7vJtqpWGRfPiu16_uJ9dbLCOb81mKJ9
X-Proofpoint-GUID: q7vJtqpWGRfPiu16_uJ9dbLCOb81mKJ9
X-Authority-Analysis: v=2.4 cv=XaIcX455 c=1 sm=1 tr=0 ts=6ae0fac2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=UWXt6i8kVS0SnA6LmccA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270078
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

When wiring struct IMXGPTState to the clock control module, it is
currently necessary to reach into its private data. Moreover, when
forgetting to wire the clock control module, QEMU will crash after the
guest has already started. Fix both by letting struct IMXGPTState
expose a link property which is checked at realize time.

Inspired-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260921214710.29422-17-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/fsl-imx25.c  |  3 ++-
 hw/arm/fsl-imx31.c  |  3 ++-
 hw/arm/fsl-imx6.c   |  3 ++-
 hw/arm/fsl-imx6ul.c |  3 ++-
 hw/arm/fsl-imx7.c   |  3 ++-
 hw/arm/fsl-imx8mm.c |  3 ++-
 hw/arm/fsl-imx8mp.c |  3 ++-
 hw/timer/imx_gpt.c  | 14 ++++++++++++++
 8 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index efb22359c5b3..0840c2d86ada 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -138,7 +138,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
             { FSL_IMX25_GPT4_ADDR, FSL_IMX25_GPT4_IRQ }
         };
 
-        s->gpt[i].ccm = IMX_CCM(&s->ccm);
+        object_property_set_link(OBJECT(&s->gpt[i]), "clock-control-module",
+                                 OBJECT(&s->ccm), &error_abort);
 
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpt[i]), errp)) {
             return;
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index dd929c108588..b440ad6e28d7 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -105,7 +105,8 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
                                             serial_table[i].irq));
     }
 
-    s->gpt.ccm = IMX_CCM(&s->ccm);
+    object_property_set_link(OBJECT(&s->gpt), "clock-control-module",
+                             OBJECT(&s->ccm), &error_abort);
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpt), errp)) {
         return;
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 7ba9b85a2eac..22deb7249639 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -204,7 +204,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gic, serial_table[i].irq));
     }
 
-    s->gpt.ccm = IMX_CCM(&s->ccm);
+    object_property_set_link(OBJECT(&s->gpt), "clock-control-module",
+                             OBJECT(&s->ccm), &error_abort);
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpt), errp)) {
         return;
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 84451c99097a..2786889bdafe 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -245,7 +245,8 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
             FSL_IMX6UL_GPT2_IRQ,
         };
 
-        s->gpt[i].ccm = IMX_CCM(&s->ccm);
+        object_property_set_link(OBJECT(&s->gpt[i]), "clock-control-module",
+                                 OBJECT(&s->ccm), &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&s->gpt[i]), &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpt[i]), 0,
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index fc5d0efe0600..9e206c59a17e 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -250,7 +250,8 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
             FSL_IMX7_GPT4_IRQ,
         };
 
-        s->gpt[i].ccm = IMX_CCM(&s->ccm);
+        object_property_set_link(OBJECT(&s->gpt[i]), "clock-control-module",
+                                 OBJECT(&s->ccm), &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&s->gpt[i]), &error_abort);
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpt[i]), 0, FSL_IMX7_GPTn_ADDR[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpt[i]), 0,
diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index 875e92bb3473..37934d295111 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -420,7 +420,8 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
             fsl_imx8mm_memmap[FSL_IMX8MM_GPT6].addr,
         };
 
-        s->gpt[i].ccm = IMX_CCM(&s->ccm);
+        object_property_set_link(OBJECT(&s->gpt[i]), "clock-control-module",
+                                 OBJECT(&s->ccm), &error_abort);
 
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpt[i]), errp)) {
             return;
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index bcd91739d9b2..f855378dff2d 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -447,7 +447,8 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
             fsl_imx8mp_memmap[FSL_IMX8MP_GPT6].addr,
         };
 
-        s->gpt[i].ccm = IMX_CCM(&s->ccm);
+        object_property_set_link(OBJECT(&s->gpt[i]), "clock-control-module",
+                                 OBJECT(&s->ccm), &error_abort);
 
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpt[i]), errp)) {
             return;
diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
index cdc025712625..22fc8203bfd3 100644
--- a/hw/timer/imx_gpt.c
+++ b/hw/timer/imx_gpt.c
@@ -15,8 +15,10 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/timer/imx_gpt.h"
 #include "migration/vmstate.h"
+#include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
 #include "trace.h"
@@ -522,6 +524,12 @@ static void imx_gpt_realize(DeviceState *dev, Error **errp)
     IMXGPTState *s = IMX_GPT(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
+    if (!s->ccm) {
+        error_setg(errp, "%s 'clock-control-module' link property not set",
+                   dev->canonical_path);
+        return;
+    }
+
     sysbus_init_irq(sbd, &s->irq);
     memory_region_init_io(&s->iomem, OBJECT(s), &imx_gpt_ops, s, TYPE_IMX_GPT,
                           0x00001000);
@@ -530,12 +538,18 @@ static void imx_gpt_realize(DeviceState *dev, Error **errp)
     s->timer = ptimer_init(imx_gpt_timeout, s, PTIMER_POLICY_LEGACY);
 }
 
+static const Property imx_timer_gpt_properties[] = {
+    DEFINE_PROP_LINK("clock-control-module", IMXGPTState, ccm, TYPE_IMX_CCM,
+                     IMXCCMState *),
+};
+
 static void imx_gpt_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = imx_gpt_realize;
     device_class_set_legacy_reset(dc, imx_gpt_reset);
+    device_class_set_props(dc, imx_timer_gpt_properties);
     dc->vmsd = &vmstate_imx_timer_gpt;
     dc->desc = "i.MX general timer";
 }
-- 
2.55.0


