Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70614C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03Mz-0007kg-QL; Fri, 28 Aug 2026 16:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x03Mx-0007jl-U2
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:40:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x03Mw-0006pY-3s
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:40:11 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SJ7NPW2761659
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 20:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Jn9iXpKYNS1L6RaSzUDnHO6ijMZ0oIaALhAL7v8dv7E=; b=KM/wX79uvSmfIywl
 PhyCNFGyszYGioKO5jN56hZnvMo2OAkPVNMjv1Ef37yUt0aH5+jlC7MCaOv131LK
 FThvKvaiE9w+qt001J/UpdP6drqHMSQSzuhADxde015sTI9QKpKpQGofcTmglxY0
 +enoVDCnJxKCWZihigHb0806z4usaDoJVQFb0hOVpNUZtTTq3TuAwdRHX5sTuLBS
 /Av7hX071AO7lv1BbZ9PGjjZ9If6iR7XI3sWreTxwgf4OiFjAHIh+C2MtpiOZOlV
 qzDh3/33mJGg3yvIhEgN34im01sExYh4xx4kobUqef+X2Pn7/W223o4XUNN/0JOy
 0cUTvw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbag9sqq3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 20:40:08 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-933023a5980so250296485a.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 13:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787949607; x=1788554407; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Jn9iXpKYNS1L6RaSzUDnHO6ijMZ0oIaALhAL7v8dv7E=;
 b=MhWtxo01i4dsUzS8WztMUfdRvduv1qgBlqVD6vOirHLmCS8sS1UMa4V7KygN/Jv5Bq
 mtVBGx76sU08GlRKlzW94VRQRXOHLT/9BsjXe7c8PxZ2NbqcwA8bXka9cgwg23jXPOGn
 rpE4ke+Dgm+xmyeNXDNSxPaYoJl3drJPIrzZDXREg9qsN3rCWBN79oK2fJM4G892MJyz
 W6P2gMArHvBDcU10b/+HWU9uG1NFMWPTUZ+8dci+fz7nT9vauz3JdvxQ3b4UB/5NQZ/9
 uhRMkNxX+UnO5KVE8a4cJVYX6tHxEtFVCTjm6f6mK3bpoacj4LOMHgVZ7gyBKZ8fiRcV
 JaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787949607; x=1788554407;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Jn9iXpKYNS1L6RaSzUDnHO6ijMZ0oIaALhAL7v8dv7E=;
 b=d0Vrgia5Clpc6JVlQVcbYpx4ObFC+XdZw2rSprLgXOyZcRU1bAo4deiKvs06uTBQPT
 G5fkS2GBwzs8CfyLqL8/dAchnVnS7Rpt9WIiM8511AGVRE/8kC/8cSU47f3DOE74QrEN
 v6EsWm39ZnSRxsUigZKdqstSNkusY5oS8MqLiNPMN8p+32kgnX47pxhQ30QfYo2SdQPS
 UkF8+ZM9nxL283kkXQvVQ82ddCGiXRaAo/1afPKbmN4iSinaO2PhAQAWVhu1e7qBYYbL
 BHFohu4RVpdrpgHgI7GpkKhBPfWLxIiGynjdSvD8kNFripZD4lr6iHtyRBNSKWyniZk5
 Tf1w==
X-Gm-Message-State: AFuF++lgb8jSZLxa0iis4hetveebIb4ueO0LtyhXLpzH3eviwHO03zxU
 AOeDmJSEV8Q+XbgR51BxFQqC+18JPsr/lIa4P0L8Ey5LGrtcAWoVoUHvYEQv49SmMrbXaOIY9ZO
 fKgdCOEBwv8SdEXSxZkHAvbHcjnugLt+Y/MyU531TQRTFs0Fn+fAm8s9JkMGeRhSXWw==
X-Gm-Gg: AR+sD116JZS4bRXuirYv4NaIndSEZAQ7AWC1nP3PLiQtdPZbMq7r2gGS+vLcvLiHcEe
 q054040YEqIf+FnO+Jm0giQytYZK/aN4u0QVlkh8ARloA064XkZJYzz4322KwiG74Wakjf9cedX
 IzcOa3Tw1cy0EzIG2LN6yN2/X3hU1UQuIG8yAKq4SfiRmIS2Sw5agB188lpUzmvnF3R8OQMJrTZ
 sNVewIsDC3te3fupotcrzJuREWFase3Xh3fTj8mD4e3dZlTcm/TdwciHBYoyiS0OhzJjm7DMfBD
 XyT9aud6gOflTzDd03QAT75vPo1SKwuiNAZ1WAluEvPZ3ZtxPc9E+FtnbrcX7LCYpljKmXhaix7
 LENVsY1esPv6ZjV1cA52ammoH9Ed01NK9zv4hrw==
X-Received: by 2002:a05:620a:d41:b0:92b:8a7c:f71e with SMTP id
 af79cd13be357-939137d2438mr942872485a.15.1787949607030; 
 Fri, 28 Aug 2026 13:40:07 -0700 (PDT)
X-Received: by 2002:a05:620a:d41:b0:92b:8a7c:f71e with SMTP id
 af79cd13be357-939137d2438mr942868185a.15.1787949606531; 
 Fri, 28 Aug 2026 13:40:06 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939173f2758sm218063985a.37.2026.08.28.13.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 13:40:05 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v5 15/15] hw/riscv/riscv-iommu-sys.c,
 virt.c: add riscv_create_iommu_sys()
Date: Fri, 28 Aug 2026 17:39:17 -0300
Message-ID: <20260828203918.350131-16-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UalhjqSN c=1 sm=1 tr=0 ts=6a91f228 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=sIvX0uTPz6KFyc5RlFwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDE3OSBTYWx0ZWRfX+otWOxP7cz9N
 13n/kIK/EB0lnCTRow6sSxzWeUQwuzOAxOsbsFOJlT+hqkrq0LjGq4P5WSXbecDz88fgCHXZ1Q0
 g5Xub0iGrcY59wXK9Lf4JpXMqnSgiBg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDE3OSBTYWx0ZWRfX40Tfmpf4+ahV
 c7d5w8KYEHddvAOYnXUvZ349O0jm3k49jvVt1O624FycRIqfGnOcKYr/djDcbN8m8IQQeJVpl9t
 wF9hCPp86kr3065by9eS/3Hmqy9/ZASMMOgxuBI7SH1RlQQt4epYUfNPUMXYuyGyAxGHm0Eb8Rm
 SNTMeuDLF6c/9QO1E99aZQ77Qn3rTQjWj9fkTSctCZM6BVEsSDWyPIkOajZymD0n03ojxM3fyKg
 dZ9XPgJjYXkpa+eMVX9v2tvngQ+dHmlbvDLv+vwugGFf0QfZRSfIJFd5N4NrT263m+35KkeJccL
 NQmwJrDEHIoo+qbzXDJLGCfqMrfJgQF9jcpZjQyJA+o3fdOIkvBqblyHmtDvLPR9FOWujP9k318
 D/LAZJyQbrKbQYi5ZGomsOJH5ZYev4MhOw+lrbLPBiq7n/V8qiGuGWvAMO+si1mIPFMevlOdg/9
 tajnOdwXAqGuGJyBCGw==
X-Proofpoint-ORIG-GUID: YTd0tQid4DbJmhqOnxIG9iUAZbpn08qT
X-Proofpoint-GUID: YTd0tQid4DbJmhqOnxIG9iUAZbpn08qT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_06,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280179
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Move the creation of riscv-iommu-sys to its own file instead of open
coding it in the 'virt' board.  Other boards in the future might want to
use this device and we want to avoid code duplication.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/riscv/riscv-iommu-sys.c | 25 +++++++++++++++++++++++++
 hw/riscv/riscv-iommu.h     |  3 +++
 hw/riscv/virt.c            | 23 +++--------------------
 3 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
index 3314adeed2..258c171efd 100644
--- a/hw/riscv/riscv-iommu-sys.c
+++ b/hw/riscv/riscv-iommu-sys.c
@@ -217,6 +217,31 @@ static void riscv_iommu_sys_init(Object *obj)
     riscv_iommu_set_cap_igs(iommu, RISCV_IOMMU_CAP_IGS_BOTH);
 }
 
+DeviceState *riscv_create_iommu_sys(DeviceState *mmio_irqchip,
+                                    hwaddr addr, int base_irq,
+                                    bool is_32_bit)
+{
+    DeviceState *iommu_sys = qdev_new(TYPE_RISCV_IOMMU_SYS);
+
+    object_property_set_uint(OBJECT(iommu_sys), "addr", addr, &error_fatal);
+    object_property_set_uint(OBJECT(iommu_sys), "base-irq",
+                             base_irq, &error_fatal);
+    object_property_set_link(OBJECT(iommu_sys), "irqchip",
+                             OBJECT(mmio_irqchip),
+                             &error_fatal);
+    /*
+     * For riscv64 use a physical address size of 56 bits (44 bit PPN),
+     * and for riscv32 use 34 bits (22 bit PPN).
+     */
+    object_property_set_uint(OBJECT(iommu_sys), "pas-bits",
+                             is_32_bit ? 34 : 56,
+                             &error_fatal);
+
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu_sys), &error_fatal);
+
+    return iommu_sys;
+}
+
 static const Property riscv_iommu_sys_properties[] = {
     DEFINE_PROP_UINT64("addr", RISCVIOMMUStateSys, addr, 0),
     DEFINE_PROP_UINT32("base-irq", RISCVIOMMUStateSys, base_irq, 0),
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index da70e8bfa8..7c470ba084 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -104,6 +104,9 @@ void riscv_iommu_set_cap_igs(RISCVIOMMUState *s, riscv_iommu_igs_mode mode);
 void riscv_iommu_reset(RISCVIOMMUState *s);
 void riscv_iommu_notify(RISCVIOMMUState *s, int vec_type);
 void riscv_iommu_fault(RISCVIOMMUState *s, struct riscv_iommu_fq_record *ev);
+DeviceState *riscv_create_iommu_sys(DeviceState *mmio_irqchip,
+                                    hwaddr addr, int base_irq,
+                                    bool is_32_bit);
 
 typedef struct RISCVIOMMUContext RISCVIOMMUContext;
 /* Device translation context state. */
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d75dec2dd2..de7b99c6a5 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -32,6 +32,7 @@
 #include "hw/core/sysbus-fdt.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/iommu.h"
+#include "hw/riscv/riscv-iommu.h"
 #include "hw/riscv/riscv-iommu-bits.h"
 #include "hw/riscv/virt.h"
 #include "hw/riscv/boot.h"
@@ -933,26 +934,8 @@ static void virt_machine_init(MachineState *machine)
     }
 
     if (virt_is_iommu_sys_enabled(s)) {
-        DeviceState *iommu_sys = qdev_new(TYPE_RISCV_IOMMU_SYS);
-
-        object_property_set_uint(OBJECT(iommu_sys), "addr",
-                                 s->memmap[VIRT_IOMMU_SYS].base,
-                                 &error_fatal);
-        object_property_set_uint(OBJECT(iommu_sys), "base-irq",
-                                 IOMMU_SYS_IRQ,
-                                 &error_fatal);
-        object_property_set_link(OBJECT(iommu_sys), "irqchip",
-                                 OBJECT(mmio_irqchip),
-                                 &error_fatal);
-        /*
-         * For riscv64 use a physical address size of 56 bits (44 bit PPN),
-         * and for riscv32 use 34 bits (22 bit PPN).
-         */
-        object_property_set_uint(OBJECT(iommu_sys), "pas-bits",
-                                 riscv_is_32bit(&s->soc[0]) ? 34 : 56,
-                                 &error_fatal);
-
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu_sys), &error_fatal);
+        riscv_create_iommu_sys(mmio_irqchip, s->memmap[VIRT_IOMMU_SYS].base,
+                               IOMMU_SYS_IRQ, riscv_is_32bit(&s->soc[0]));
     }
 
     s->machine_done.notify = virt_machine_done;
-- 
2.43.0


