Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998D9606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Snz80S5X;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=APyZHSR7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmor-0004w4-3k; Tue, 27 Oct 2026 15:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmnU-0002rm-50
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:25:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmnS-00024s-Ce
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:25:23 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHVbi2997927
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W7+uEZbGkQU1TPLefcRpyrRoTDktr5VFKzI6dglIwr0=; b=Snz80S5Xl/ugyUWv
 dgGneR5FLU7ZmfCs8iYL7Lk1I/avxkrpdegK0RMnbtWqPLVyrDALxCSdRHFSX1E1
 vPtmeeM9SorTo3PrWH+FcMDZXEkV1ibdB+h1w+B5mVTXIXyQXifozK3zviPVw9T7
 C7uKfTvxRO540pfNB/ZJ0Dv/dt3svN5IUzFc/FW/HDYDLh2SM4p4XekhNmqtJFrH
 hr/W/6WVkqsrl8EnMZFSwk62aorqQb8HvXllojOfPfDFGUVhDuikvUqoP2cTBd8J
 3ZF9AM1mslHUOHvOM9ugcD41hxGipdmEuIf6Yr/T1Ab0wvWhvSELlHrOWQbiwzL7
 pELDkw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjst1jcar-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:25:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cb98809caso22284185a.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129120; x=1793733920; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W7+uEZbGkQU1TPLefcRpyrRoTDktr5VFKzI6dglIwr0=;
 b=APyZHSR7fiaNzd32qPjwTrS8UJV8zm+Vbis/cQH6FB7DhUOCmBkM5TyjT1vhpHan/e
 52fNVYML8K1wYPWwvbAT7W6iN6kM+J5p3NfBCfT41DEuzqYJrlQj3gZLJCcQd7dDlnpc
 ssxqSIfKGlxQlMcFnjaTKkaXhuCRAGOUeJxIB8n2AuAY/xzWcoPhz355MQrt7RXiEi9s
 1A9r/ga7zZwm8E8HZKBKNqxdFavsh0slZblh0Dz3vTYI06m9593L0sp5ooTJOrwgeYOx
 0JYGmHCrjVH8x0KBxmM2G+/5pWRBc0bIvp1ekU+BgEi8L54iwleS2fKz7eZR0kZagQS2
 UzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129120; x=1793733920;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W7+uEZbGkQU1TPLefcRpyrRoTDktr5VFKzI6dglIwr0=;
 b=DVr4PEpkbA/AehRcCOx04xckV7ewGQ+PjOjleVHt5Xb9Z37XG/Q283wdCT/ZUmmnQW
 LWa42VWxLgtm5FA4Yap7YNTB+r4LpXBKgIIuF9KX6Rwd24metZh1cOEOFAmFAHtbMjjh
 Kow2cd3rIJOj9r9c2Vp6xaJI5lb1ieRhuFVe0omCoju001obc9FV9tLulD2LRRBwGJVK
 yL7AxHvdY4lwGkc+z56F4fkwd5D/3eazuVevSOjXXWkoV/QXkkeiOyuCDriNGRFJXXMx
 jGSsEp9nraYI9KbkwHtGxRMOZUyjp2canJbM5JX+h4MUDAB5kz1Zaf6zZysF6ZFuGWWm
 CIVQ==
X-Gm-Message-State: AFq9FYJuVRNS08wPkf8pT1uN3Gh/4DgpS1P/dm//9e+iOPKLX5pt1Ps9
 MWVUceQRfD7rMF8pACATJD/srHFVSLUlEL0rkvqykwW4ao7sfToBsqDKSjBHf9SAEO2r1PCUGFp
 NbyWmBNomItppkdw6Dc77S9NkTGaoUBLmSQr3nAr/faXmMQ25B2jS8/CK20YfILdmpw==
X-Gm-Gg: AYBFou2p7VoS2QFvkLI1H0LX0ZFkEKjGmJGDfXLvA8VBuWC4LhZx9Ys3HRnrf9ItTqP
 nh6VWVo38qJbvOlY7/hhaMrQ+N0TsXcv9ByE6EubXSQ7c8mcWPoD+JX6xKa6yAxBt/T7mW/Ia//
 mmfU8FjglfhIBQi/+kyegzB3QwfOHFLfCiwQXdnfONjURWAiEW63VOqPgcoYuWzXeTLeywhZx5O
 T0VGJmgem51ooAkOvi1V/vPHjw+L1TkXo7vCOsQzEGzj8Z3l7byk3uAvT2GEYC6C7dsyMN3Tqjr
 uOTunZT/rQh3fV03W30YFKD2AkoJEMw8ZRLp/BeYF+R7hJuLYBQcv6Xm0TPQlFw+xEpfWXjlDnj
 imPlU1TgrLvy94cY77Ooppcbxam5FDzvOxoaB4AVTf3L+7cahgY7P7JcS
X-Received: by 2002:a05:620a:8089:b0:93e:4e27:359b with SMTP id
 af79cd13be357-940ef8bce1bmr1663826985a.24.1793129119764; 
 Tue, 27 Oct 2026 12:25:19 -0700 (PDT)
X-Received: by 2002:a05:620a:8089:b0:93e:4e27:359b with SMTP id
 af79cd13be357-940ef8bce1bmr1663823285a.24.1793129119155; 
 Tue, 27 Oct 2026 12:25:19 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94e6b8290sm3018205e9.9.2026.10.27.12.25.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:25:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/59] hw/arm/fsl-imx25: Derive from TYPE_SYS_BUS_DEVICE
Date: Tue, 27 Oct 2026 20:22:55 +0100
Message-ID: <20261027192341.9197-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HJ1WhYtv c=1 sm=1 tr=0 ts=6ae0faa0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=ChhGJ802N_1bxoR23yMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: bs2OkQwjMMrH03kR6Hju6cfKLo2z7WdZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX7FXKtotBOmdD
 hC49qyU5S2pYn/Lfa21OUMR4w506ipD+ynAvePzEN5JNnd/Yftrd4kqIj5ri8t7I6Sxw58iUwkD
 Ed0ZY8Hj1UgoUdpfihaXt1ZUODqEa4s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX73vJ9bkLcRLN
 4LxAQZpww37kL/MsWNAqVJypq68VCyY9Y3l60k38nwZXn6Kws5xEaGafe3HWRSqHNwqHGSZoWCl
 bBH9gA43r0vfCG68DL8dKkc3SgPNaRQTTF96r/hv/s+t25dUuN9HPQupTwcN+c7llR5TdgGREED
 zp2gMNbSb0wuUdidc7YHdAJh8eKrWWSTgUBKcUychIIuBbjHqqKklJrlwoVldiCc8hW5Hyi/0hB
 FIrkQnJKBg34Gp2w/J2J1A3V0ZfseVRp0DN8CPat4KMmO3wUubHeyDAVIjy7JVSw11XSKS1YUtp
 WG5bV1Wso54Ma7nuA4JyerLkf4vgxRa72Bh5V2kFgX09fz9HLOR3FzUGXwhQtGB+o6NqWzIOsKu
 Ix1NtxpK2scqbAK8Q89gkLcMuuLuza0qC/UGnfA+ioSVs8LSL/DhiFerjb0k4f+nt7ScD5X9qcC
 4TiZcoCQmmoDxl4K8TA==
X-Proofpoint-GUID: bs2OkQwjMMrH03kR6Hju6cfKLo2z7WdZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270078
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
Message-ID: <20261006083445.30362-13-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/arm/fsl-imx25.h | 5 ++---
 hw/arm/fsl-imx25.c         | 7 +------
 hw/arm/imx25_pdk.c         | 2 +-
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
index b68d4334a0c3..4bb4d5b3e53f 100644
--- a/include/hw/arm/fsl-imx25.h
+++ b/include/hw/arm/fsl-imx25.h
@@ -29,6 +29,7 @@
 #include "hw/sd/sdhci.h"
 #include "hw/usb/chipidea.h"
 #include "hw/watchdog/wdt_imx2.h"
+#include "hw/core/sysbus.h"
 #include "system/memory.h"
 #include "target/arm/cpu.h"
 #include "qom/object.h"
@@ -45,10 +46,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslIMX25State, FSL_IMX25)
 #define FSL_IMX25_NUM_USBS 2
 
 struct FslIMX25State {
-    /*< private >*/
-    DeviceState parent_obj;
+    SysBusDevice parent_obj;
 
-    /*< public >*/
     ARMCPU         cpu;
     IMXAVICState   avic;
     IMX25CCMState  ccm;
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 7f65f4ca4bbc..efb22359c5b3 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -317,16 +317,11 @@ static void fsl_imx25_class_init(ObjectClass *oc, const void *data)
     device_class_set_props(dc, fsl_imx25_properties);
     dc->realize = fsl_imx25_realize;
     dc->desc = "i.MX25 SOC";
-    /*
-     * Reason: uses serial_hds in realize and the imx25 board does not
-     * support multiple CPUs
-     */
-    dc->user_creatable = false;
 }
 
 static const TypeInfo fsl_imx25_type_info = {
     .name = TYPE_FSL_IMX25,
-    .parent = TYPE_DEVICE,
+    .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(FslIMX25State),
     .instance_init = fsl_imx25_init,
     .class_init = fsl_imx25_class_init,
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 243c30a67e7e..a33050788c32 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -72,7 +72,7 @@ static void imx25_pdk_init(MachineState *machine)
 
     object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_FSL_IMX25);
 
-    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     /* We need to initialize our memory */
     if (machine->ram_size > (FSL_IMX25_SDRAM0_SIZE + FSL_IMX25_SDRAM1_SIZE)) {
-- 
2.55.0


