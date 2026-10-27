Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0D1606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KYa/gejH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZFM/4DAh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmom-0004OZ-2W; Tue, 27 Oct 2026 15:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmoA-0003NZ-1d
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:26:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmo6-00027d-4i
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:26:03 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RII54t3554696
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XPZjUxCxFgVE5IIML6S+N0sJFExSD9+f4cuBqFNOilM=; b=KYa/gejHsh/lj05t
 9HArFLI6AkspRBFDIfr9UxzsSIip0unv1Lx/Cb8r0jOZZxa/0v1G48j5tXuhhmKA
 vpJuZY1WPyxSkWr/qFnG9ty+iZCioOwid38HvjbKl8bmlATWLMdKMzZ9HJXbyOWx
 DHwfC1UO0XldT3u/512IRcFxTzvFu9lGeeEarSieDtobLF3HTi50cppGUlENyGss
 7WcuMQ+haTWVzYnd6/uMoNylUeAuT7F7pXv9Ii+XPP0srATbYUmAxDFpXyV/z51r
 zQnlShRfxb+HS8CLM/yhInSW403cxCtQfFqJdHDFp86ixLFBwtu1VVxRUQbVqp8w
 8r1osw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqw22wjy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:26:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f5844cb60so44342985a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129160; x=1793733960; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XPZjUxCxFgVE5IIML6S+N0sJFExSD9+f4cuBqFNOilM=;
 b=ZFM/4DAhkZYOMSHnaX11FUMw1Zzeis/VFG7XDdjdVztZsbOmkjTTlC92q2LiapXJ6l
 wzODxgrH8Y/RfgQ776tYq413p6V4Nx30QE72h+BLELqt7tj0SuvpFQg6fcsxHw1ldb1B
 ufgZarHGz7DNneb/EBhzJGtv8VWFMIpnCAsiRMJXp+SMgrdrP3JLNeQk/d+QLtZQzs3c
 3WT1qouFy419OmsjCfPeAkF+Wo09fkUcXY3GZsl0zf+kIFy6nluFKE7DIkeSZnbKSY1f
 X3ZfZ79SmLMUp5M7oUR4uG6MmZt0pxnDpNJM3BcLz3/k0Ng0kJVjflzj9g2itfGa8gse
 zLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129160; x=1793733960;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XPZjUxCxFgVE5IIML6S+N0sJFExSD9+f4cuBqFNOilM=;
 b=UTUEbhNPXgN8oUH2AM7F3dB5rmau/zNoQ3o0eb3GHWPq8CyyqIvM/FrHUf0DwKwnfJ
 aW4ECCmSJ1cbtTvN89+Q1vDaHm5GU+cc5fITvwTsm3cSb52/26UpR29hr51LuiYyMx/l
 2PXXPhK79rxsaqr8iN2I3p4I3IdaNMrOmKAnxB7G5fg+RvwxSOn2FnOxPJ4IU7d+4v4/
 6KNvQfTgmetJmUsbmiGMuPQHIg4kZuFZbAGtrzAIaBBXrcPVMo/2oDTpjvnlzyebu3tH
 VqO6zZVUW7obGb4O+aQFmSLe+5IWh6xzb/+Y89GCSjE5dYk9Q08WOT88WMVmp6LQa4Ad
 ihbQ==
X-Gm-Message-State: AFq9FYLbf+BT5wgB/TqdEYD8PypnRi1DmpDiDPjvVe/bQxE8k6i7ebV1
 +OHC6VhhFyzS1HQPLcU0Da95tG3eYzyzXiNUwscNBTBpPznjE4efBaqeHrbZ/dM2Zf8nDGD1vkE
 0HmSxa6PZR1rxgV34ztshix5zkZPFwDaJjbti5wsRfSlUlOLV6YnvHQ2C0WuUE9UeIw==
X-Gm-Gg: AYBFou2L0nUGQya8MLvpdhxd8LSRIXA2PxekxnaMGCgrEn2re92RSXBKu3ozoqgAd0y
 bzrZjLdZ+ZDya1ZZvK9F8lHl4HXNaSSsHrLOAUW2REhnEWM2EMlCBhGer6nupixgyATSjcjpgFg
 /4ZKceD/VVhMrL6BPmqEUczhOembemLzzpBCCjwN8WKspkFTGMs73xVdFVxoEFKwuZU1aIRqh1r
 wd4ZtClM5JPv0SLirqpPjfI3SrSGRNchY2faTA5UAbCowKq0xagN3wt/0L1AirChxMCYZy0ijm1
 bRtGUcW5uKff6oFFzk9GWTZ4ksPcR4AjhVu6Jj/6Xi5deFsm9mi/nCcmYCsa02+x3LHOY2seLH2
 4XnBHQD6/pxPSWG582mJ3eUUzMtWPherWw81+fhXA66UMGaTIcmX6U1Io
X-Received: by 2002:a05:620a:4722:b0:93f:4a02:ed99 with SMTP id
 af79cd13be357-943f4b8ce2amr591971985a.20.1793129160362; 
 Tue, 27 Oct 2026 12:26:00 -0700 (PDT)
X-Received: by 2002:a05:620a:4722:b0:93f:4a02:ed99 with SMTP id
 af79cd13be357-943f4b8ce2amr591967585a.20.1793129159822; 
 Tue, 27 Oct 2026 12:25:59 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94ddf8cacsm2446715e9.5.2026.10.27.12.25.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:25:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/59] hw/timer/imx_epit: Wire clock control module via link
 property
Date: Tue, 27 Oct 2026 20:23:01 +0100
Message-ID: <20261027192341.9197-21-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX0W4Ux6j/fLvb
 rBdk778vYbsTHcNgeczKiBRJ5zEw5WdwC98Yp5BTC9Qu3jDmudVpIX4wVk8QcZ3X3ZSuXKdsplN
 t7sUNDez6Ty7edSsCWOJU16w8fZWtDKfpwXOl88UDxB53obs6LdfgmTxy55afoBuuf5wcZYWcC6
 1fIam0xjXvXfBgYo1YxolvnnEsoiH7XPcVj81orQj+m9GANE1pCNao6g7dpeVi0cRRzGAo3tLUl
 A2W16gu8HYAvQ2N7d7tS9c9ihGWbWXWmD0oCcRiGrxqfmohi8FL4ePbq7uajlH7rUGEU+Ykb5yo
 Sp7pKLiaArgwCid01RzxSP0PlNljargMXnR07JCh0Ds1XPgPiutDxBzMQeDyI6UJt2kzldeTGHO
 NCWbY5WUF+5FXsozkkdfhOHW2nDWK2JIVglSd6TzsLHvCbSF5TL1LX584rfp1YM72Vx7APcMid+
 GbcGusqEI8VBLvlzSJw==
X-Proofpoint-GUID: 3S8pVPowcSzq5WCH7RUTdhiTp2Lc9ene
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfXyMhjoWINxqvp
 D7Zw7JjPJKs2/OaEICxRBTRHZEV1mC9b2bafoonqynYwqpD2Rm8Hq8fLGrCS1BEJtNyWKEJ07g7
 25IqIaPXYGkXgS3rwKjClBjqDN2UmGg=
X-Authority-Analysis: v=2.4 cv=PsYG/AM3 c=1 sm=1 tr=0 ts=6ae0fac9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=HZG9NnMo3wJFbGJbj0gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: 3S8pVPowcSzq5WCH7RUTdhiTp2Lc9ene
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0
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

When wiring struct IMXEPITState to the clock control module, it is
currently necessary to reach into its private data. Moreover, when
forgetting to wire the clock control module, QEMU will crash after the
guest has already started. Fix both by letting struct IMXEPITState
expose a link property which is checked at realize time.

Inspired-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260921214710.29422-18-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/fsl-imx25.c  |  3 ++-
 hw/arm/fsl-imx31.c  |  3 ++-
 hw/arm/fsl-imx6.c   |  3 ++-
 hw/arm/fsl-imx6ul.c |  3 ++-
 hw/timer/imx_epit.c | 14 ++++++++++++++
 5 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 0840c2d86ada..a8745d5d1abf 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -160,7 +160,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
             { FSL_IMX25_EPIT2_ADDR, FSL_IMX25_EPIT2_IRQ }
         };
 
-        s->epit[i].ccm = IMX_CCM(&s->ccm);
+        object_property_set_link(OBJECT(&s->epit[i]), "clock-control-module",
+                                 OBJECT(&s->ccm), &error_abort);
 
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), errp)) {
             return;
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index b440ad6e28d7..79e2f7f79562 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -126,7 +126,8 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
             { FSL_IMX31_EPIT2_ADDR, FSL_IMX31_EPIT2_IRQ },
         };
 
-        s->epit[i].ccm = IMX_CCM(&s->ccm);
+        object_property_set_link(OBJECT(&s->epit[i]), "clock-control-module",
+                                 OBJECT(&s->ccm), &error_abort);
 
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), errp)) {
             return;
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 22deb7249639..5bb828fbb655 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -225,7 +225,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
             { FSL_IMX6_EPIT2_ADDR, FSL_IMX6_EPIT2_IRQ },
         };
 
-        s->epit[i].ccm = IMX_CCM(&s->ccm);
+        object_property_set_link(OBJECT(&s->epit[i]), "clock-control-module",
+                                 OBJECT(&s->ccm), &error_abort);
 
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), errp)) {
             return;
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 2786889bdafe..f72121e23d0c 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -270,7 +270,8 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
             FSL_IMX6UL_EPIT2_IRQ,
         };
 
-        s->epit[i].ccm = IMX_CCM(&s->ccm);
+        object_property_set_link(OBJECT(&s->epit[i]), "clock-control-module",
+                                 OBJECT(&s->ccm), &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->epit[i]), 0,
diff --git a/hw/timer/imx_epit.c b/hw/timer/imx_epit.c
index 374ec7d324d5..e1050b51d82b 100644
--- a/hw/timer/imx_epit.c
+++ b/hw/timer/imx_epit.c
@@ -17,7 +17,9 @@
 #include "hw/timer/imx_epit.h"
 #include "migration/vmstate.h"
 #include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/misc/imx_ccm.h"
+#include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
 #include "trace.h"
@@ -386,6 +388,12 @@ static void imx_epit_realize(DeviceState *dev, Error **errp)
     IMXEPITState *s = IMX_EPIT(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
+    if (!s->ccm) {
+        error_setg(errp, "%s 'clock-control-module' link property not set",
+                   dev->canonical_path);
+        return;
+    }
+
     sysbus_init_irq(sbd, &s->irq);
     memory_region_init_io(&s->iomem, OBJECT(s), &imx_epit_ops, s, TYPE_IMX_EPIT,
                           0x00001000);
@@ -412,12 +420,18 @@ static void imx_epit_dev_reset(DeviceState *dev)
     imx_epit_reset(s, true);
 }
 
+static const Property imx_timer_epit_properties[] = {
+    DEFINE_PROP_LINK("clock-control-module", IMXEPITState, ccm, TYPE_IMX_CCM,
+                     IMXCCMState *),
+};
+
 static void imx_epit_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc  = DEVICE_CLASS(klass);
 
     dc->realize = imx_epit_realize;
     device_class_set_legacy_reset(dc, imx_epit_dev_reset);
+    device_class_set_props(dc, imx_timer_epit_properties);
     dc->vmsd = &vmstate_imx_timer_epit;
     dc->desc = "i.MX periodic timer";
 }
-- 
2.55.0


