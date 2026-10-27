Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2261B606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ozTfbpiq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Iyhonp1w
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmoq-0004uh-P8; Tue, 27 Oct 2026 15:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmnz-0003B6-Cq
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:25:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmnv-000270-FC
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:25:52 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHWs92452042
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1LOKA7lXcy33YW769k8GzFvhzSH2IXj7A/uGs0KqBbI=; b=ozTfbpiqJCIB5xGX
 KzZkEkKUuZkq6fzuGfa7SSTPLPYqo6Qw12SsRwTSUIyr5efwkRBtW/AYvWQ7c2Dh
 l6g/kQpLGlBnmNm/CdicqaCO7lk1jAG4Jv6gmqN+yAtNSGOfbJSl/9SLUSTrli43
 rkq5bDECbY9AW7JQrDbv7hQx3fp4oCojzOjvlEgmXTls+x8lvSL4JYI1zHelS88C
 dhpGsE3Wxz9kRt0hmQNPqL6pVo4YJhJULdM5mo381hbrnOc26nAFqaeo59aKtLye
 wU0ln/zRXHvIVB0LnGP5Dts1CRnalppAf9xahfMQb0cVz5MPHBXz6pPiaTZMyK3a
 TAyN7Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy6g0ukt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:25:47 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93caf7856ffso26120185a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129147; x=1793733947; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1LOKA7lXcy33YW769k8GzFvhzSH2IXj7A/uGs0KqBbI=;
 b=Iyhonp1wg9zCqGKPUo6p604uBcLeH2x+7P74OUI0GmWonoNJlY50Tr/AVejXli0bAa
 h77eq0Z/VS4l/OfnFoUP/e23ov6xQb04CpkMknVKsicKqzlavYSyosITII+820SqUtI6
 MEgZL9QbJAK2HffP3HXdHNynzz7n2/+xy/No0oL3+4aIVDbyXWQpKgyPVj1jamo6jzo3
 JJ3Vav/C6hVHu4HHDvFzQZsLcZWdSsVKjWWxST8jXC7d9u0Ys2fOMrDtoCt6yAaffkng
 3ZfXvIA3Z//i8+UeO8zdxxXS9SYH16F5PUjjzR7058zVD2ZMW35XKlGY1Wt/mBbCzxYZ
 zixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129147; x=1793733947;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1LOKA7lXcy33YW769k8GzFvhzSH2IXj7A/uGs0KqBbI=;
 b=T/dsTfhWHFHhIYSWMsqjC9GWObFQhUtjKkljouzCmmBuRjwbJRHA0ppj5smOXw0Hhx
 92g0dTvew6xhX9ZtkaYhFL/25/vr4BovKdnHqE9cmcU+DoEw2PXgnq4k/kQ+oCJDzFBb
 2dCbmbQ13Hab1ZilqyfMZ2j/X+vDNlXKi8d5/XIFzlY8TkaGoobPL4VW8F3NFSn2uHeI
 cyPpLEsDdtXycnJd/JiDCyf4Idy9FQvE6OlVw3On4uLVQ7DmE7gghAIKfWnm5Z0CYM76
 K+tTav/1pkrdCrJUnQVUaHtV3WcwHOLO1VLkHWOcZRo138KDKsu+AWI5My4NUjFb6gwC
 YgIQ==
X-Gm-Message-State: AFq9FYJB3Po9om5zoSHXHaNBEissQ8YOucywI9r1/yiWz+BMdcnD4mEY
 /erKOQJAHf/xz6HnaMBqwsfFZZQeHTNEUDR62I4xAj5luO9qqRYlFlBZtlIKoj1Fct7BufcuKVt
 VZ87CZxIKOxCbyK/gCFf89bn5FCA5jqHMLELy7+qYeibQRuRBuFUQgVHMGMxtHw/E9w==
X-Gm-Gg: AYBFou29g7TzFLWC46KTwpbri9hnn6XTi1iwKYn/I8cOjri5CkBRWm6l0ICoxzWD5YG
 rV3bWdewJ94mb/0OIDD/YlgDmDZq7YEARvjPWw9LJA98NUZrn7mH7aXkX8kOGJ+Zr/ZDyDMcB6r
 ZoU2qYyLlJzstbxUhxu27KWuYAyPQUsBXs3qIYfwusZ6XG4i3jpzEzfmCuLBrD8p3NV2mREO7xK
 2AxvTUAROZGRKZvU8GJ4J0IIyyOhvm6KzkkrNeUz3oAO/Kxdahbske2b4NErWWTgNIhAY93+RXJ
 /mP1crBDAULJ1u+d93cTXtzh4ujy0OYB4VlzuH+A/Cu62wZYuvsA8xjJwQ8N+H6OlSSW9E//j/7
 AhSuZVgSTYtqFT4+gZ4e2EYFRMXIFRCKHEWymRVMmZkXZ5zVIdUfKYAqU
X-Received: by 2002:a05:620a:4628:b0:93f:2ec5:7e1e with SMTP id
 af79cd13be357-940ef9322d4mr1729068285a.65.1793129146851; 
 Tue, 27 Oct 2026 12:25:46 -0700 (PDT)
X-Received: by 2002:a05:620a:4628:b0:93f:2ec5:7e1e with SMTP id
 af79cd13be357-940ef9322d4mr1729064085a.65.1793129146238; 
 Tue, 27 Oct 2026 12:25:46 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94e3c638csm2497475e9.8.2026.10.27.12.25.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:25:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/59] hw/arm/fsl-imx7: Derive from TYPE_SYS_BUS_DEVICE
Date: Tue, 27 Oct 2026 20:22:59 +0100
Message-ID: <20261027192341.9197-19-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX8njnbVYWLZrX
 kpxAOf59d48PmsINJ4cuUWdYzPAtHUdZ0aUVxhc29L6wwLXawWOb+iM84+Ou7N+madPwfIyU18b
 7t0HkFrUlAH2XAsE/5DdwgIvqhbSxtS7blBAuHz1/J/+6cwFSwOVw81I1UUPfOYJq42zTCLR+Yh
 O72RsaXbk2qbr2eonSSgp2mZHo2vKG2mMtU9TamY3G9SuLcboQHE6N5/6bWWvXD/GnK/UAC4vrF
 GsFjPx4GalAH2kKHj/irmXC/y5OVM9PuiHW2nZyTQMh9d9tLfcXKULbyv7PcDjGsMCQ09xHjDVg
 i+uya7CBcrOugN30SEM+VkKmkxMZMVvYKT9vqr3DC33OdNNV41ahGNZw9Y50NPk589FLRbW+8A6
 J2yg4LUo0SdzaA+dPzfVUdoJQl+yW8FaPcZoXpqznJc9zJFE3hnSSQMLylzJhk2sLA6MurX32CI
 t5ed8sayjXpyomTxmdg==
X-Proofpoint-GUID: DIXmTD6k87QdyniQ_w4BOh7JTxEdkAJV
X-Proofpoint-ORIG-GUID: DIXmTD6k87QdyniQ_w4BOh7JTxEdkAJV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfXxxy6ZC0tF8wz
 aMAIUdns6/iEEZTp3pADBe8nSMhcQg/VuZTbTduXyYUBB77iaP6zpUA1+2ycHwpN2Ms73Ohyzjp
 RDQCOWndIjkbVMyvGjzTd7Kn9TzPQHU=
X-Authority-Analysis: v=2.4 cv=dKgzC+Zb c=1 sm=1 tr=0 ts=6ae0fabb cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=lB3AAgnz6dsswKXpChIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Deriving from TYPE_SYS_BUS_DEVICE fixes the SoC object to be reset
upon machine reset.

Remove clearing user-creatable which is implicit for SysBus-based
devices.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20261006083445.30362-17-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/arm/fsl-imx7.h | 5 ++---
 hw/arm/fsl-imx7.c         | 5 +----
 hw/arm/mcimx7d-sabre.c    | 2 +-
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index a573e0dd4f8c..945d8c5ad78b 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -37,6 +37,7 @@
 #include "hw/pci-host/designware.h"
 #include "hw/usb/chipidea.h"
 #include "hw/core/or-irq.h"
+#include "hw/core/sysbus.h"
 #include "target/arm/cpu.h"
 #include "qom/object.h"
 #include "qemu/units.h"
@@ -64,10 +65,8 @@ enum FslIMX7Configuration {
 };
 
 struct FslIMX7State {
-    /*< private >*/
-    DeviceState    parent_obj;
+    SysBusDevice   parent_obj;
 
-    /*< public >*/
     ARMCPU             cpu[FSL_IMX7_NUM_CPUS];
     A15MPPrivState     a7mpcore;
     IMXGPTState        gpt[FSL_IMX7_NUM_GPTS];
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 2defa498d388..fc5d0efe0600 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -753,15 +753,12 @@ static void fsl_imx7_class_init(ObjectClass *oc, const void *data)
 
     device_class_set_props(dc, fsl_imx7_properties);
     dc->realize = fsl_imx7_realize;
-
-    /* Reason: Uses serial_hds and nd_table in realize() directly */
-    dc->user_creatable = false;
     dc->desc = "i.MX7 SOC";
 }
 
 static const TypeInfo fsl_imx7_type_info = {
     .name = TYPE_FSL_IMX7,
-    .parent = TYPE_DEVICE,
+    .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(FslIMX7State),
     .instance_init = fsl_imx7_init,
     .class_init = fsl_imx7_class_init,
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 47744e66a4a7..55c23061b0a4 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -52,7 +52,7 @@ static void mcimx7d_sabre_init(MachineState *machine)
     object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
     object_property_set_bool(OBJECT(s), "fec2-phy-connected", false,
                              &error_fatal);
-    qdev_realize(DEVICE(s), NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX7_MMDC_ADDR,
                                 machine->ram);
-- 
2.55.0


