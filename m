Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A265BC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5eS-0004G5-Ka; Tue, 07 Jul 2026 09:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5dH-0002rn-Az
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:14:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5dD-0000a9-Va
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:14:38 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C9ML93740903
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BccTxZKCA6gYkBziV/R59OR/YwezElAivEqozwYZ2Gc=; b=pfQ3lltMgZKQz0dN
 YAr/LHuj8u7IlnQkHroPhevqkQeV0lDR3LnIpIz+rA7rwwcakp038K1BZt5B5ZJQ
 x/q9NB4pkcPlI6+RkD1BV1EH562ZpFuvH9nJFJgnqYkreua0dLRy+NEvbxg/pjJq
 pTgnekLB9D8vV6qh1vIEQblM5YpybjIo/la1aaejR0r0a7LxUYdP+PaKZAF8SdmO
 yX2O/mTsq4xJ8eghfE+s5blpGJdehMYVMjbNrPO6y0KxEU4ShitB376VE5xwMhCZ
 vuaXEaZvt05I5ZbpE8L3BUO5UIcpxnIB+J+dEYpmVHXmr/il6B7CYIESl0m7/Mv/
 J5HiGA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8v9a9kxa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:14:34 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c110a3b6aso59713211cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783430074; x=1784034874; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BccTxZKCA6gYkBziV/R59OR/YwezElAivEqozwYZ2Gc=;
 b=goZ7RBomDZEuQFr/cpp1gv3JTCpvtpRNGlI5LPQo1U9JzB98G4oJKpeeQficyQhNIt
 kp4kERzUD6da2yBGe8z/lX1jTvPcLx75mNHn+1p/ICoshe8GqiERVhUDZd+ebWEu9SBK
 uREd+ocTxGFNAG5EDP3rsrHlN8Fo5pwm3l6HyWRVs0A1yKbkqIGAwQ7aGGqXy1oQ4bBm
 0UMdIvx9CDRooP+HrYXhXqdAF4dsCLo1vShiBS/+yFDk8URa5fNHd1hycB9AMqtruC3+
 XAkqVvi8GEG0aTesyPtdF083Bbuwijwn5OBd+rVKUkQ05qohSKP0DZQsNmDi4x1p+dDe
 UKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783430074; x=1784034874;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BccTxZKCA6gYkBziV/R59OR/YwezElAivEqozwYZ2Gc=;
 b=SU5wfxlyE+y282WEVd0GEO/W6DweS1COPBjipDXU8rGwVbpN2l22EuXYGX59Mz1qdq
 MnDyCcu5N6r4YnuLXU6rOM0vt7OrlAKFQp86y1QEmF2/J7sH9FhQBpa8Ny8h1bZTaQMw
 T3LHQDutc+kWY0bpHt9pKXdu28FDqTy0vSGRw+5Sx2BHpuabuYFPH4gP+cmu4Nao79Pf
 nM7hSqeenF4zzh6w/p8WlgOO/2n2YAe/xH4U1Pk9EJ3kpbZF/5jRkppy0hj17MYFZNZX
 zCV5yYYcNMssDIHUWbSvVxf88NabF5L7iCL6zlA6I1Axg6SIAFs46Jt69U3BwC3zhrm0
 JP0g==
X-Gm-Message-State: AOJu0YwxBh3kRWb1fZT5q41txcit7oz8bvcvTq+zeNW4PoT4KYnwfJXR
 eJ/t/b8y2oxXPMrTuMD7X1h8jxoMhzl+75TvD3gG7fFhVSNjHiEUePWEg8Y+C1/q1F1BpsLThOg
 vyHRNqveLYv7qvAcs0MhdgJ3v1b2LPq+J97m9yPEXiN51DtsmpI8F86kF4aqrqOE1vA==
X-Gm-Gg: AfdE7cl8ySdsKIeiRKajKKiWri2qmfJHiruDC10sdbwYXa54A8IlPJ6U8an7D/KGyHK
 DFtTaJAI9A5EVWgJJ4vSR0LhXmVfvThBqBnpj8EdA1JTE21IPbetVOmE1vKddy5rOkSF/f0w7Vc
 JQWs3TgJYoKB2Sljv9NiifD5kzbinzq7fMEa/8IbW/J6Wrsjx0x7rvL3M3QMaI1XKSyZjxlftD5
 jnVWiRdWCjbYwOh4XAfevpdnZkUeV1Cwuoh+P63lpO/LRuTt05F6t49tUVsZKe9QkuMzguSCZ4P
 GurD3TF02BMsQm2WKyIZ3Iw6K6yVi203Ki8+RsO+Lcj1MfS/Ys8Q4zP3ff3npg75w58ZJusI2SE
 H31nNE0t9fE4w41LKjjjZaV1/izhz5XBnxWAWJcob+oEAAxyjRmBP9BfPkWK9ArmeaYQ5
X-Received: by 2002:a05:622a:1183:b0:51c:1361:fead with SMTP id
 d75a77b69052e-51c7487fec7mr51708071cf.37.1783430074157; 
 Tue, 07 Jul 2026 06:14:34 -0700 (PDT)
X-Received: by 2002:a05:622a:1183:b0:51c:1361:fead with SMTP id
 d75a77b69052e-51c7487fec7mr51707701cf.37.1783430073679; 
 Tue, 07 Jul 2026 06:14:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ad9bfdccsm141337966b.36.2026.07.07.06.14.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:14:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/32] hw/net/can/flexcan: Subclass TYPE_CAN_FLEXCAN
Date: Tue,  7 Jul 2026 15:12:08 +0200
Message-ID: <20260707131223.51505-19-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uUexIbtyGzloorVbCwYCQ3QIuIfm2eH3
X-Proofpoint-ORIG-GUID: uUexIbtyGzloorVbCwYCQ3QIuIfm2eH3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX0r1Btc1V9DMT
 k/V9Il9vXm2XTmx98ZaUMWVu/Tf5b5JArOqac/mL1zCCRfztd8eUnODnOpRL7TQVhiVO7kBGT/I
 bBSJJFU8FGdsipfaLi9prJaPIZiiJck=
X-Authority-Analysis: v=2.4 cv=b9yCJNGx c=1 sm=1 tr=0 ts=6a4cfbba cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ItCWRy2WlyBiaE_UJHsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfXzypELb7Mo2xr
 C94qzmMYXHxFxNWU/zCSzawgb8ZqiYRInzVXNGnUhmFYFJU+78M90+Q4eP0L0kceXLJSk1dQYWx
 /TmN75fLG0p8F93PbE1G3DABcFQUh8LOgbNt3qM4oq0wu78vMN/EoJtQIU5H5DjEvTQYGP953Va
 QWOEQrQRGTNKhPdInUIlLED0e4d33Ta8cBeWleP9c/im++7i2HXWbO6dj63kjOsVaJcio8DWrpu
 s5Bj0k13EGfT0aYnEuHzMFLOoxrwKcG0ZX49WcdTRfF6Qrv5ZdScPUQOQca2GjJwNS+F1GGY1g8
 9pkwhO2ywmprFgcqaZ2Eox+aB/W2x3cF1Gnv5naheis+G3C+PiJ3x5oHjsdsEmb6KVp8xouhcee
 edLfp93IFDiQKYIqTdh6zyZZV4iKiIvQiMuUjT/rZRKFj8ef9G7fJ6Zm1yTAiTnjbCoPelp4IXm
 5ra/Zb1nXAFaGhDF8SA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
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

Subclass TYPE_CAN_FLEXCAN, yielding TYPE_CAN_FLEXCAN2 and
TYPE_CAN_FLEXCAN3.
Since TYPE_CAN_FLEXCAN is now abstract, TYPE_FSL_IMX6 needs to use
TYPE_CAN_FLEXCAN2. TYPE_CAN_FLEXCAN3 will be used in TYPE_FSL_IMX8MP.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Pavel Pisa <pisa@fel.cvut.cz>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
Message-ID: <20260702184038.178196-3-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/net/flexcan.h |  4 +-
 hw/arm/fsl-imx6.c        |  2 +-
 hw/net/can/flexcan.c     | 80 ++++++++++++++++++++++++++++++++--------
 3 files changed, 69 insertions(+), 17 deletions(-)

diff --git a/include/hw/net/flexcan.h b/include/hw/net/flexcan.h
index 153afc1e03b..32de7b904af 100644
--- a/include/hw/net/flexcan.h
+++ b/include/hw/net/flexcan.h
@@ -139,7 +139,9 @@ typedef struct FlexcanState {
 } FlexcanState;
 
 #define TYPE_CAN_FLEXCAN "flexcan"
-
 OBJECT_DECLARE_SIMPLE_TYPE(FlexcanState, CAN_FLEXCAN);
 
+#define TYPE_CAN_FLEXCAN2 "flexcan2"
+#define TYPE_CAN_FLEXCAN3 "flexcan3"
+
 #endif
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 585c935b899..eec9673c6fb 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -92,7 +92,7 @@ static void fsl_imx6_init(Object *obj)
     }
     for (i = 0; i < FSL_IMX6_NUM_CANS; i++) {
         snprintf(name, NAME_SIZE, "flexcan%d", i + 1);
-        object_initialize_child(obj, name, &s->flexcan[i], TYPE_CAN_FLEXCAN);
+        object_initialize_child(obj, name, &s->flexcan[i], TYPE_CAN_FLEXCAN2);
     }
     for (i = 0; i < FSL_IMX6_NUM_WDTS; i++) {
         snprintf(name, NAME_SIZE, "wdt%d", i);
diff --git a/hw/net/can/flexcan.c b/hw/net/can/flexcan.c
index 8f3f066ef50..da36d10bd33 100644
--- a/hw/net/can/flexcan.c
+++ b/hw/net/can/flexcan.c
@@ -1290,7 +1290,7 @@ static bool flexcan_mem_accepts(void *opaque, hwaddr addr,
     return true;
 }
 
-static const struct MemoryRegionOps flexcan_ops = {
+static const struct MemoryRegionOps flexcan2_ops = {
     .read = flexcan_mem_read,
     .write = flexcan_mem_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
@@ -1307,6 +1307,23 @@ static const struct MemoryRegionOps flexcan_ops = {
     },
 };
 
+static const struct MemoryRegionOps flexcan3_ops = {
+    .read = flexcan_mem_read,
+    .write = flexcan_mem_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = true,
+        .accepts = flexcan_mem_accepts
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false
+    },
+};
+
 static CanBusClientInfo flexcan_bus_client_info = {
     .can_receive = flexcan_can_receive,
     .receive = flexcan_receive,
@@ -1322,16 +1339,26 @@ static int flexcan_connect_to_bus(FlexcanState *s, CanBusState *bus)
     return 0;
 }
 
-static void flexcan_init(Object *obj)
+static void flexcan2_init(Object *obj)
 {
     FlexcanState *s = CAN_FLEXCAN(obj);
 
     memory_region_init_io(
-        &s->iomem, obj, &flexcan_ops, s, TYPE_CAN_FLEXCAN,
+        &s->iomem, obj, &flexcan2_ops, s, TYPE_CAN_FLEXCAN2,
         offsetof(FlexcanRegs, _reserved6)
     );
 }
 
+static void flexcan3_init(Object *obj)
+{
+    FlexcanState *s = CAN_FLEXCAN(obj);
+
+    memory_region_init_io(
+        &s->iomem, obj, &flexcan3_ops, s, TYPE_CAN_FLEXCAN3,
+        sizeof(FlexcanRegs)
+    );
+}
+
 static void flexcan_realize(DeviceState *dev, Error **errp)
 {
     FlexcanState *s = CAN_FLEXCAN(dev);
@@ -1384,19 +1411,42 @@ static void flexcan_class_init(ObjectClass *klass, const void *data)
     dc->realize = flexcan_realize;
     device_class_set_props(dc, flexcan_properties);
     dc->vmsd = &vmstate_can;
-    dc->desc = "i.MX FLEXCAN Controller";
 }
 
-static const TypeInfo flexcan_info = {
-    .name          = TYPE_CAN_FLEXCAN,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(FlexcanState),
-    .class_init    = flexcan_class_init,
-    .instance_init = flexcan_init,
+static void flexcan2_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "i.MX FlexCAN 2 Controller";
+}
+
+static void flexcan3_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "i.MX FlexCAN 3 Controller";
+}
+
+static const TypeInfo flexcan_types[] = {
+    {
+        .name          = TYPE_CAN_FLEXCAN,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(FlexcanState),
+        .class_init    = flexcan_class_init,
+        .abstract      = true,
+    },
+    {
+        .name          = TYPE_CAN_FLEXCAN2,
+        .parent        = TYPE_CAN_FLEXCAN,
+        .class_init    = flexcan2_class_init,
+        .instance_init = flexcan2_init,
+    },
+    {
+        .name          = TYPE_CAN_FLEXCAN3,
+        .parent        = TYPE_CAN_FLEXCAN,
+        .class_init    = flexcan3_class_init,
+        .instance_init = flexcan3_init,
+    },
 };
 
-static void can_register_types(void)
-{
-    type_register_static(&flexcan_info);
-}
-type_init(can_register_types)
+DEFINE_TYPES(flexcan_types)
-- 
2.53.0


