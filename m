Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1099C44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5eQ-00042c-HQ; Tue, 07 Jul 2026 09:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5d8-0002WY-SF
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:14:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5d6-0000ZW-OM
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:14:30 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C9DSv3590399
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VNKU7Sy//ix2WOvhHmnRBhTfLDyVWfCOE1gkUvP6xNE=; b=OcNKXIa8dpqnY0G6
 W6QpDP0V+WX/19HD+j3xsQANJXoS3UQlMb2BImciNV153X2JGA7tVyvXToeD1CJo
 l7Z9wQkqPEhFLu+u66TDfYQ6MmLu/+gzpVUYzCB52u+ZJuSjhoqbDcbH4r18Olbc
 Ldagp56HV01bSVb4cFBmNxhfXhn3RqRYvI20f1km3exYbtlIjA5TMlDojEjIxiku
 INIZu8VcBdchgQhxaKwgk6E/rB5fkU/JCRF59cq/UD9dloEwSYgVGDsv7f+E+V/a
 6aSPI9vApmPDdCwmdTuWcbe6QXZXR/zwBXIX6TNWSFAYYAsik/eku8vhW5e5M66E
 c36Zdg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8w2u9bmd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:14:27 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1eb52e1fso84346961cf.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783430067; x=1784034867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VNKU7Sy//ix2WOvhHmnRBhTfLDyVWfCOE1gkUvP6xNE=;
 b=dEl8r+PA/ooVPDTyqEoo9lzensyhd8JT4d86lWmlUcY3BcJJAQ2seFQjrcM4g/UQEP
 nkj/uO4hbF+SZczbeD06dxeFV14ld4iWnyJ2C4N1p2d6hPKNKXNwzoVSUPHPH7/0VrDJ
 VY2C2PEp3UKNvF3VWaBfwTJUwfSTt9pY7b3SZXvuX6uhoroMHVhPMNXAw4jmUsu+NiBo
 ZZyRke30d4k15sHi+7aNKb/M073Y1++DwDIlYOkC6ZKXjSqs7R7TmGcN32Vr2POrJA0N
 sZVFUFa/GLVIZ4nvsPLufQoxKIppFqruRMi0X4LjB/Xd82CO3FPd+wixb6eC3mRSWa0A
 Wnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783430067; x=1784034867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VNKU7Sy//ix2WOvhHmnRBhTfLDyVWfCOE1gkUvP6xNE=;
 b=sR7PGH0TdHBiU/kM5TmD6/wwWFf9GeE3Oi2hxBnQw2DztHyeQ1J1WW/wxwYXkRA6Rr
 fmmdR+4xEk2ccqAE1aEEKYGTpKHXbgg46AcnVn2FHsn+6X5ldfHgo4bThLPBg7W08LzN
 r/TIHQelYeYCGdaZVBFZnXKxOMp0/HzZsnyY9dA6RDKDR+jiwNw3I1xBZ5XyUXK0j2vv
 E3ohSjkEvplntJLpZcVSXTlla5o/SlK8q2ave6XcVXJhmgGT19qhEoNhhZB9GlPYvVSm
 6QVifjrrFYTGDOzFoZiV48M/qH++Y+ZYaPfOiCxyJYk9aVg22KWFQyyfd//yBXjLQbFf
 HLwg==
X-Gm-Message-State: AOJu0Yy4ggv49DUxrWEw7ueCWVYZS2cBcNGpyE/y3sxMynpO8YImAacB
 ivP9vqOam7agO4X1GND3f67DzI475FqnSn356SQh/jVvV9mmqiAAzJI58CoBaoOJqh5sI+g4O9O
 XmTo2a4ttlUgMoz9wl593iXME2IA+tIbM+SoQIO813+LbVmfQK23ztxZVmUMRVCuA5Q==
X-Gm-Gg: AfdE7cnyeKmKoGsLUqr282jcCZFB2NMEo/4jMUt4IeSYdqFjqQY6uhokxKdXJX03moR
 k4d3dWsKu2eRZNx4JR61IKDtNpgoK0DhwjTBW8vf6BlvytzQmICXVnVud0m5X8x5sE/z9z/uBO5
 xgWiNe3fDS/uXkGD0C8D8ajc2GKAsxQpa8oC8uU9XPCbgq1+jq8R/HsDJGhQcqwsw4YjFYgTV6R
 5EhKQuOns1IbBWQuRZy/sMQv2y1l95P9GAMDoI69BMp8Tehg9dZ9nhZIH/sZus+eQzXtpJe1iAl
 33QnwNcK7YUfyRXluPAqOzSySt/4+ux8ah1egH3XLH2TKO+ddCUIfQbvye2afpgMO0nJP+DW7Ym
 UXxvDXfqniVGOkUU/Q5CPDy64MPdYBgWARu8pXl4l1u3QSiE4OARZUrIrqT24LRG72w6+
X-Received: by 2002:ac8:7dcf:0:b0:51b:1f2:f38a with SMTP id
 d75a77b69052e-51c748932a4mr54713301cf.49.1783430066711; 
 Tue, 07 Jul 2026 06:14:26 -0700 (PDT)
X-Received: by 2002:ac8:7dcf:0:b0:51b:1f2:f38a with SMTP id
 d75a77b69052e-51c748932a4mr54712951cf.49.1783430066203; 
 Tue, 07 Jul 2026 06:14:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ada057dasm138450566b.50.2026.07.07.06.14.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:14:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/32] hw/net/can/flexcan: Wire clock control module via link
 property
Date: Tue,  7 Jul 2026 15:12:07 +0200
Message-ID: <20260707131223.51505-18-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX7S0UgFrIJut+
 5UajjPIMFbvkiOjRczTFifqjqlWZtvOkaJjJ9jheR+Sj1v8R2C8ulaRYpLjr5WNwyFjH/dGR4ak
 RsXCxFxJqsdyv6qOWKit1RC7CkVDSQc=
X-Proofpoint-GUID: nMmSv3Ji7Wve988pVHhVSl1oZAzMfrV_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX11HBgIiVRMoz
 0YkSZ3oRCtZe2SqpgVCij/5zA5H7g9SfMivOUtVSr34DeupUljb3lM0BYUFPCuEXUj1Vsm8xa7w
 93QFaCdmQTWPboGWAj2qmh8Ti79iM7fPM2HAT4uDeAIYzcMjwP+h38sSXIepMJZuTieyWTdpAeO
 gfu0brgIk3bNNMw685CQXnchqrOYpVUH8qGap0hSAbKpF6QSbJN9mz4VaoZA9v0T/uMS466opZW
 wekLK7n/WWY36ekUfuoNIlG482vDsNeQt+rzknULeVY9yY6x/kcxpa519BdwBgIyrf//KU/oGtY
 51ngSkKwSqJpZxg+PajNybuSZN36PTibd6c278cjSINirdWA+ggmwpbMF//chJ+NyB3oZweHCKx
 Z+gUNcAGPu5G56AaCUwDHEzygW1zZBx0AR7c7aMOGfyWCgJAxQCWNNzOeWtdlSBiENSGvMzIER7
 KJFuV9KZpyOV4jXPr1g==
X-Proofpoint-ORIG-GUID: nMmSv3Ji7Wve988pVHhVSl1oZAzMfrV_
X-Authority-Analysis: v=2.4 cv=bPQm5v+Z c=1 sm=1 tr=0 ts=6a4cfbb3 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=waCdl2-9vCPkP2a9qEMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070129
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Bernhard Beschow <shentey@gmail.com>

When wiring struct FlexcanState to the clock control module, it is
currently necessary to reach into its private data. Moreover, when
forgetting to wire the clock control module, QEMU will crash after the
guest has already started. Fix both by letting struct FlexcanState
expose a link property whose sanity is checked at realize time.

Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Pavel Pisa <pisa@fel.cvut.cz>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
Message-ID: <20260702184038.178196-2-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/fsl-imx6.c    |  3 ++-
 hw/net/can/flexcan.c | 10 ++++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index bf106a90632..585c935b899 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -391,7 +391,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
             { FSL_IMX6_CAN2_ADDR, FSL_IMX6_FLEXCAN2_IRQ },
         };
 
-        s->flexcan[i].ccm = IMX_CCM(&s->ccm);
+        object_property_set_link(OBJECT(&s->flexcan[i]), "clock-control-module",
+                                 OBJECT(&s->ccm), &error_abort);
         object_property_set_link(OBJECT(&s->flexcan[i]), "canbus",
                                  OBJECT(s->canbus[i]), &error_abort);
 
diff --git a/hw/net/can/flexcan.c b/hw/net/can/flexcan.c
index 1ea459d9f69..8f3f066ef50 100644
--- a/hw/net/can/flexcan.c
+++ b/hw/net/can/flexcan.c
@@ -333,8 +333,6 @@ static uint32_t flexcan_get_bitrate(FlexcanState *s)
 
     uint32_t pe_freq, s_freq, bitrate;
 
-    assert(s->ccm);
-
     /* s_freq: CAN clock from CCM divided by the prescaler */
     pe_freq = imx_ccm_get_clock_frequency(s->ccm, CLK_CAN);
     s_freq = pe_freq / (1 + conf_presdiv);
@@ -1346,6 +1344,12 @@ static void flexcan_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    if (!s->ccm) {
+        error_setg(errp, "%s 'clock-control-module' link property not set",
+                   dev->canonical_path);
+        return;
+    }
+
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
     sysbus_init_irq(SYS_BUS_DEVICE(SYS_BUS_DEVICE(dev)), &s->irq);
 }
@@ -1366,6 +1370,8 @@ static const VMStateDescription vmstate_can = {
 static const Property flexcan_properties[] = {
     DEFINE_PROP_LINK("canbus", FlexcanState, canbus, TYPE_CAN_BUS,
                      CanBusState *),
+    DEFINE_PROP_LINK("clock-control-module", FlexcanState, ccm, TYPE_IMX_CCM,
+                     IMXCCMState *),
 };
 
 static void flexcan_class_init(ObjectClass *klass, const void *data)
-- 
2.53.0


