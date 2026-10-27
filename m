Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC76606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HgMNAgNI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GASOOlb3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmoF-0003f3-St; Tue, 27 Oct 2026 15:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmnf-0002y4-01
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:25:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmnZ-00025W-4e
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:25:32 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHWYv1917333
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gKKf7t/h1QmhB1gSp3dvANRhxukEMn/ZUmcSGNatBOs=; b=HgMNAgNIw1nMOVF0
 ELrN1NrW+dAPIHC1xq8qza0jMumjfkPVHf6yT9QtaHYo5X/Uvftnj6ml3Nvg8x/A
 QzZgmK3iPdElDwMhuj2Mpy0lsEUDyTLqyO+88lzCgXqg294HvAMtPL0kq/O1AYD0
 cu99we5P603L/P07yojZQBlkjIlTiceslLNBbsSQQdmH6Gx7mBtky6CfVP35WZzm
 ihuaFlOCxr2AE9fXeiISQ2qITzXvTvV3y1VEtMcSjvRm9Z9KYB3kqx3VvrweYj7I
 M0dYhGm2jqvd9afKXPBJUEUoEC3VCrXy+3XvMm9I4hJJ8DheuT2DX6dvYh5c80dW
 z1qsLg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjux99uuc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:25:27 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-537548b8342so6535691cf.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129126; x=1793733926; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gKKf7t/h1QmhB1gSp3dvANRhxukEMn/ZUmcSGNatBOs=;
 b=GASOOlb3p9q+AOhOaIPSO5qjoo4bgH6gvutj2Ue78ypuKDC+9wSkiyv/RfUalsTaWC
 oG7OLaxuNGi7IRiqXG93bDj/EC1pZ7VchiWrpNwZ1jetgI0X7Ip8OecEUkglsNNNAmW/
 0ysd5zair0YVc/WmvI0vk1XykA8OJkGlHFrrtV3RmC95tfmIhcLKsukWGKyTjZu0NeS0
 M0CgBmBzEjzHxGHMDTIXtN+z8jIeeOGuZE7JAmIAncuDkBPC7kmU1U5eBdaod/nNciHD
 3cJvDEVdC37x61uB6pEAhMnwzZS3EGzmW2G/sJEAJajmOJVlmeelBATDeGu4ugzcOEMr
 fpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129126; x=1793733926;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gKKf7t/h1QmhB1gSp3dvANRhxukEMn/ZUmcSGNatBOs=;
 b=ltyuzv/A2ZJ45h0B2uXmkxG6WF0uQso2ZGXcaT6XhR5jRHNYwvjmTTpZ2s8R6SZhG0
 QeYKteIN5KtA98Y7OWrTZT32nRtvL36Mr8xspSYqAFyDdsI1vRNIQa40SHGM9tS2imY2
 e6QPotL5VN3bYyFjruxUDhBHBbnQdN+CHt0hR/NdlDp41nPTb7sYRgYj8vkaZ98Z+YXu
 K1kJIBa150y6dmx7fdrUFFa9cXW93nfKSme/AbqOLOxxUW7dXS0JHhTwrZHO7+kip2jP
 wyMFpOXYA3XdlNKkaHLScf2qIJw6JWo783zGAkzW5xgYFQ5rnk0V+1DG8npsEnX8SyCp
 iHTg==
X-Gm-Message-State: AFq9FYIQ49fHG0XlQkxyXH0hq4cCi2pSRu5l1GC2sXIJMR1kC0nhxJV8
 ZYjcDawpKUtfjww4tsD5YijqOq5sNy3Kv+y6vVDdK4bESKppaFEnyoPzlyNOubMYPybz3KfSFiX
 /FjsjRNmqhoROQ40sXz+fC/LmVmWhsyPEurvYhmzo6TxDRs8RJOJammu6rEvw1Ie3Pg==
X-Gm-Gg: AYBFou2go9xjW/fftDphDrXK6r+BCcDOhMx2TdM4ZWcNUU0LPDOA+gd57WXBFHWyZo/
 qAxpDNlSHEmqNM8h8/Lk/ucy6I0UDumFO79KhdhU16ND39Ep4J0KVKp5i/vvlhPGXsmyK0mbyhk
 AmESOsIrDeV7jpuqTAEj5P9TeqpF214C5VA2IRZK0sv7NocX8zRra7oQLxDk17lGNivkfJ7YwIq
 cqMn4/2tAiIF3c4pehbPO0D/BksrX2V2RLF7ch1tvlta8RQW7cvijF+wmx4tIxIFNpvAF72gOYb
 D4SVVH0X52YS2qH/cKavYEeoMD9GbHnhcGfPnNb4w+ZxmqNQrWiA1eUv0dvY5QJ+ecdzAIsg8sJ
 bIryi7y5Kildu3YUo1ZyfxjJvJ9XAb/QYC/O8LJh275zlz6OOiIZ3+Sw9AZwBHD5u8fnt0b7DA0
 Duc5+CG8DOnWyanDPuv3RH6Un4GfRq1w==
X-Received: by 2002:a05:620a:17a4:b0:93f:3163:3e25 with SMTP id
 af79cd13be357-940ef9014bbmr1567403585a.24.1793129126447; 
 Tue, 27 Oct 2026 12:25:26 -0700 (PDT)
X-Received: by 2002:a05:620a:17a4:b0:93f:3163:3e25 with SMTP id
 af79cd13be357-940ef9014bbmr1567400485a.24.1793129125887; 
 Tue, 27 Oct 2026 12:25:25 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94e6b8290sm3024265e9.9.2026.10.27.12.25.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:25:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/59] hw/arm/fsl-imx31: Derive from TYPE_SYS_BUS_DEVICE
Date: Tue, 27 Oct 2026 20:22:56 +0100
Message-ID: <20261027192341.9197-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GYyCDgXL c=1 sm=1 tr=0 ts=6ae0faa7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=N8E37EdMsAxyg1GpHm0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: g_cHapVjBEc608H3oSGDQSsBEF8FFUMk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX9iWDQFSq4X8B
 RtfyMp2OzCSNeo/IKJYuwgWXvZRkpmMUWg2aXsfJjgcD/KGxV1iS8lfLt1dCOS4fkSfvvjVvJiM
 qrRIpmgwBU74IknfTWnYkytZOuhURy3UL6yfuVzmES77DwUo9fSpL7jxbv3iyaph3OqKdmqWdEK
 Auyj/1tPr6SoFccpz2pwgsruUVMwgCPwglX9p9iG7xJHO4s9S2Wois2msHTHO3UrWE7kxzQ90zQ
 oPsZDXWkLpCL9Z/aP9Z/1NX3j0TiitYTlb2XDwnOXl0EgzRX83ldA9sRCvpO4t0zIBSlhTEBdsX
 L8hKlY6QuKrikJnrv14O4pT5MElM/ratXDwAY1KVcXXorpjm9cvpvhbGRgLAaEFtYQy4AmBn6Kq
 03erStMYw9K7sNMDQ719nnNCmpwTwl2fC3M5ywQSJQk/j7HnKencRVhbeoxfGhuk9OfVX0y1rUT
 qI5lCw86sjg0v8GSawA==
X-Proofpoint-GUID: g_cHapVjBEc608H3oSGDQSsBEF8FFUMk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX4aSFCBcmCNKi
 O5dioRGV0cVygQyF0ZiQ35HCSih/u95+h+KJ/e0QMJF01YE4T+Bh1wd0/GwvK8qHwayeppA6qnh
 2uraBnhjrjz5rTujdg2KdS+lVPIXe20=
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

Deriving from TYPE_SYS_BUS_DEVICE fixes the SoC object to be reset
upon machine reset.

Remove clearing user-creatable which is implicit for SysBus-based
devices.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20261006083445.30362-14-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/arm/fsl-imx31.h | 5 ++---
 hw/arm/fsl-imx31.c         | 7 +------
 hw/arm/kzm.c               | 2 +-
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/hw/arm/fsl-imx31.h b/include/hw/arm/fsl-imx31.h
index 41232a223733..ea916de15aaf 100644
--- a/include/hw/arm/fsl-imx31.h
+++ b/include/hw/arm/fsl-imx31.h
@@ -25,6 +25,7 @@
 #include "hw/i2c/imx_i2c.h"
 #include "hw/gpio/imx_gpio.h"
 #include "hw/watchdog/wdt_imx2.h"
+#include "hw/core/sysbus.h"
 #include "system/memory.h"
 #include "target/arm/cpu.h"
 #include "qom/object.h"
@@ -38,10 +39,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslIMX31State, FSL_IMX31)
 #define FSL_IMX31_NUM_GPIOS 3
 
 struct FslIMX31State {
-    /*< private >*/
-    DeviceState parent_obj;
+    SysBusDevice parent_obj;
 
-    /*< public >*/
     ARMCPU         cpu;
     IMXAVICState   avic;
     IMX31CCMState  ccm;
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 190f863355d4..dd929c108588 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -224,16 +224,11 @@ static void fsl_imx31_class_init(ObjectClass *oc, const void *data)
 
     dc->realize = fsl_imx31_realize;
     dc->desc = "i.MX31 SOC";
-    /*
-     * Reason: uses serial_hds in realize and the kzm board does not
-     * support multiple CPUs
-     */
-    dc->user_creatable = false;
 }
 
 static const TypeInfo fsl_imx31_type_info = {
     .name = TYPE_FSL_IMX31,
-    .parent = TYPE_DEVICE,
+    .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(FslIMX31State),
     .instance_init = fsl_imx31_init,
     .class_init = fsl_imx31_class_init,
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 387bf54ced18..e9cc53ce0172 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -69,7 +69,7 @@ static void kzm_init(MachineState *machine)
 
     object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_FSL_IMX31);
 
-    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     /* Check the amount of memory is compatible with the SOC */
     if (machine->ram_size > (FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM1_SIZE)) {
-- 
2.55.0


