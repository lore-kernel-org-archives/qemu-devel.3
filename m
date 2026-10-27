Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7BC606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Te7i8O3L;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gf1Eehs6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmoP-0003vm-VQ; Tue, 27 Oct 2026 15:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmnj-0002z7-8e
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:25:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmnf-00026A-N3
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:25:38 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHrPg1459828
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 K0hykQOdNC4EM6IKZ5fHty3CUKYvgSwkosziRW1YYYo=; b=Te7i8O3Lrny1xoF2
 nYs7HA46La15pt+VA+x/PC5xDonpWVHNmZbICVcmrnvjQLza5LHPjwVwpl8K9pVA
 7pwN920SfphzuwLQBxVY2IDasWs/QPUzxwg15HOjNZbFf3Mc7I9H0yUhrXwa6z3j
 3Ihm0prY/1fU4NC+Xnq9gMGHBau6xyf9b5ZlHxYwgMGrX5iRTq2zeFfQAWrkuc0e
 2a7Z+07YPO2AcIy3+yIDDgRIEMfZHY93lP6R/wYl6jVFRjMfqkO9Qv7jA990RH0T
 UUdratIBoMfO610L9EZSRJrFKrqoy5YRiEKb5ZPwtAiZggH6LheboWf9XlYIQsBi
 XHQmCQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy710v64-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:25:34 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91c70349f65so5280836d6.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129133; x=1793733933; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K0hykQOdNC4EM6IKZ5fHty3CUKYvgSwkosziRW1YYYo=;
 b=gf1Eehs6FhQRqxIh7NqYb535KmB7y1HvmpHlaOBNWq/ry61/uQhMklo+0bvGgsDtqQ
 A9bUM4gAo5cg8jv6pSpNgNK2+0BzcPmpwBlLeBORTGpNEBrWjCl1Xnc0OZDc6O+wYkmk
 FGa6zt+44N8bu0ljswpf/jimAM+tg9dFxLZbC++3kfCmYm/vbPDjlz57BvER8kiGX132
 jphdADmpxo14WvDoVA49QLtvAX4PXuCnzwIXWcSINz2BoV6MfRn8Nsc9odeMrSbTzERe
 4xn/k/H05EAW95xFymlOdEU49UC9p8K8xcT9EM5qCVjFUDLdCu6s1OYN42FijHGWJyHP
 w/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129133; x=1793733933;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K0hykQOdNC4EM6IKZ5fHty3CUKYvgSwkosziRW1YYYo=;
 b=Uac07BAwxPqc6m+3+Hk6fbFZyhIzZ7/nIFmHEbt0CsJdMYjOTq+yqpneeBBnEe+td6
 j/RgGwobO/THinvKaGdwBnDD8MCPkyEVUS+vLlGqeAgo+eJngj3zvgGAUqj+eH10a/LS
 1FjJl+xNXGU8+2raPxaKV5iwpEeTcSllaYELf71q+nD0KNAyzIsxi5dgwlQr8ZzwdUjm
 P2dYeYBwLF37nkqfEpozX0WgopOp5CfU0pn7kUKN6EN0z5jWatzVIddX4UXNfjaZr2be
 SmS8/N0REXFB46+BMvwz4eC5J5S3+qF7jgAKJpIbogLix+bcd69NOyxofk6V9XBOkiFe
 974A==
X-Gm-Message-State: AFq9FYI8Cf2gOF6h4U6tfJkWqPQP3o9mTU3WNZJHHU+paJFit7o9KUJV
 wcyOvqwvAq4DNRjSTw5Z2Pa8kHKiP67lZ11BJIVwdQ5uHQYd3G+4wuVXt8nhBP2ccCAR9UQJGFE
 lCLB98s8uRc+wLBOGR12fwt33k7ydcNlkj0ig+aFWErUGZJMymi/FNA6mvcl2o45uzw==
X-Gm-Gg: AYBFou0Espn1QyxptXEs/A0Rx/QyR6/y6nHVoKza34fUszKK4k0dT8RJy8ApMDTeu3o
 AeJuAYGctU5uaIr0BEebf72PZL45aMP7f8IRj06JJuh1QPEstwcjUa1zspFDfLLsDrrrrGOUOoc
 /mAKG+4tLxxYpBkMGwbvf0TOCIAH683uu87pZuBK4yAEaXwet4OT0x046Q4DvNz35PwXEerjtEJ
 oMmzfJh1bdPtajeMMzAqVk8qVP/V3ESsmmoA4qVZbaaL+PSH05L57Cu94vVZhNXtyHhtBbgWqsy
 mxT4+2klSx/J1Z4fahkDIIIS36OzFQfLWrBTdYBsio70xXFv8+xE5fXVdkSkD1u00R/73fGMT05
 EpZuzeJO/5zt9lkbP7b1TJzlxG/iKCbgjvqjwSDTQ6QoEkbPUAa0Q/bR1
X-Received: by 2002:a05:620a:7102:b0:93c:b33a:5ee0 with SMTP id
 af79cd13be357-940ef953f91mr1749939585a.41.1793129133234; 
 Tue, 27 Oct 2026 12:25:33 -0700 (PDT)
X-Received: by 2002:a05:620a:7102:b0:93c:b33a:5ee0 with SMTP id
 af79cd13be357-940ef953f91mr1749935485a.41.1793129132695; 
 Tue, 27 Oct 2026 12:25:32 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb902sm25661165f8f.24.2026.10.27.12.25.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:25:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/59] hw/arm/fsl-imx6: Derive from TYPE_SYS_BUS_DEVICE
Date: Tue, 27 Oct 2026 20:22:57 +0100
Message-ID: <20261027192341.9197-17-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX4n65uqoVUoZS
 cksqQru0LL8TbyJ+tGaJWklOK8iwiJGbJ0KiVK7NDfsjG3ijNkYnB7JeNVJVpNIEYNWSvcDBE71
 CJaF4J+rEMPT3cdoxxyxZmhUWgiTchtVF+eb5yPPppY3hJsGIO6uK2cdtUquXSK7U1KrKcj/1hi
 Fs0bkK0iSFUnysEqKDN4CrK4fMu9ya28qAqcjKk/8ke1Uv3+VdtY8r1zyOKzcyVzoIAaPOv8+Re
 +ibwfqqwWY2awQ903xbJr3lNoiwsFFry/jN8qegCD6UkxNmoqK2iVbXD6yTyC7REPDpchHlGuY3
 AMNE1O/4bhEZR4GtUPVent1rrlaR7TkPq1E8DKjbs/FpgKkTyJAVc9AtyjbcakWL4cqFQw3fbW8
 81OPV3EGr2Q84XiRuDlN6RierO0BfRCIeRdCDIiPOpKqiZbrHnV7UfWR9XdctGLtQ/m35X42znb
 iDzvAtbFaILbLnie8gQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX5wyZJcVg2htZ
 e2szte3tQ76AgAxMqXr5uPMRw0fNaoOGw4opDf45BqIfFNOlt3UeDpQKRd41mgsnCngqIq3uCUL
 31bENo3glnfag93zD9HhAulT3+Hz0PU=
X-Authority-Analysis: v=2.4 cv=JspkP84C c=1 sm=1 tr=0 ts=6ae0faae cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=CeVRZcwpJvGh8Rv3chsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-GUID: Xh-e7Scx0bcgd5WzSo2p7CeTtXyvVvPm
X-Proofpoint-ORIG-GUID: Xh-e7Scx0bcgd5WzSo2p7CeTtXyvVvPm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
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
Message-ID: <20261006083445.30362-15-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/arm/fsl-imx6.h | 5 ++---
 hw/arm/fsl-imx6.c         | 4 +---
 hw/arm/sabrelite.c        | 2 +-
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 376deea3a49f..4cf26f1fbc3b 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -35,6 +35,7 @@
 #include "hw/usb/imx-usb-phy.h"
 #include "hw/pci-host/designware.h"
 #include "hw/core/or-irq.h"
+#include "hw/core/sysbus.h"
 #include "system/memory.h"
 #include "target/arm/cpu.h"
 #include "net/can_emu.h"
@@ -56,10 +57,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslIMX6State, FSL_IMX6)
 #define FSL_IMX6_NUM_CANS 2
 
 struct FslIMX6State {
-    /*< private >*/
-    DeviceState parent_obj;
+    SysBusDevice parent_obj;
 
-    /*< public >*/
     ARMCPU             cpu[FSL_IMX6_NUM_CPUS];
     A9MPPrivState      a9mpcore;
     IMX6CCMState       ccm;
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index eec9673c6fbf..7ba9b85a2eac 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -519,13 +519,11 @@ static void fsl_imx6_class_init(ObjectClass *oc, const void *data)
     device_class_set_props(dc, fsl_imx6_properties);
     dc->realize = fsl_imx6_realize;
     dc->desc = "i.MX6 SOC";
-    /* Reason: Uses serial_hd() in the realize() function */
-    dc->user_creatable = false;
 }
 
 static const TypeInfo fsl_imx6_type_info = {
     .name = TYPE_FSL_IMX6,
-    .parent = TYPE_DEVICE,
+    .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(FslIMX6State),
     .instance_init = fsl_imx6_init,
     .class_init = fsl_imx6_class_init,
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 34f302f83c6c..201766d8ea31 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -66,7 +66,7 @@ static void sabrelite_init(MachineState *machine)
                                  OBJECT(s->canbus[i]), &error_fatal);
     }
 
-    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX6_MMDC_ADDR,
                                 machine->ram);
-- 
2.55.0


