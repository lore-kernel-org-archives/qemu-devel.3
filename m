Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70CFC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziZ1-000618-1Z; Thu, 27 Aug 2026 18:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wziYy-0005rB-11
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:27:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wziYw-0001Ll-AU
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:27:11 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLr3K653769
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Jn9iXpKYNS1L6RaSzUDnHO6ijMZ0oIaALhAL7v8dv7E=; b=CFM962C9ngXLZcAC
 WskpTBFFoLwQopKDw0++iwcV5RhSTIcwcYZTTRt+zy42pfvYq45cqa5kQwo3t9Md
 LDA0MuC+6xkVt9273lMaS6Akc+apT6dMyS5Er4wFe6OKTzBsaWsCMx7cd+XJODzO
 Aaz17CpCTyUcO9SDSEWUxAN1WxzrG6hH/UWm+WqcWIlvCr71AfBzPawSeREfynYG
 D8ZWxMgJTESBtRC165FO5CeLGfKR0tlj9HpjWPIhimKI17yslUXwFuBHNfCrdRgj
 /RRm9VHxiFCL/ZsWbxRek/zlAlHUJzQnt2IzKsXXmFJBybFLlqVD1MJTxa4mKF1h
 BfpM+g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gagjfum66-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:26:59 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93494cce712so45330385a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869619; x=1788474419; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Jn9iXpKYNS1L6RaSzUDnHO6ijMZ0oIaALhAL7v8dv7E=;
 b=WkkTkd8XetiWMU6yy6y6dtK2AwzwR8/YJ/aj7U0qeJIfkAb71KvVFedqjXrYzI82be
 mDrKMX9YrQEg++PgLLv4kFe6tTj2Tvh/HWpD9IjfGVlgGC/hHqjZh1ricjZtbjv9qQRs
 zkRfS1n0NnYmuHI4l4RiiYX5GSYHL+EaWhc22UdCNsLGVu5guHHJi93OOUhLtRuDR512
 MUfAD2tzQdhd52JeXaUatLwr9TyZ6RZHVMlpAqRpr1u4eLAdDCajR5ZxcHnc1FvGntWz
 wViISvusXKadW7MFc2VhluA2LRs7ubhd7DBsaAPJmay0o1BHRP7mpy/9LEtS4CZCgWG+
 Usig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869619; x=1788474419;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Jn9iXpKYNS1L6RaSzUDnHO6ijMZ0oIaALhAL7v8dv7E=;
 b=iiV81sCw1L/mJZIs+BrOui7jLqlrv3FGdPgNAiKbzxdY4Eb0SajJopHE4mihEyHbO/
 kxVHcpjxSLPVF8/FEGV7Zuw+lQ+tUGgxMrPJ+vMABLTD20yzN4te+WHeWqZyD0X/LcYX
 iUgkYgexyEd7qgs41DOLwmaiGcxmm/hiJWba2I9/LyJiuRLRm+dZ2LZh498YltT0zEXl
 zfoVDedjqNHYv/vbFQznBocac2Wm6gw3dNgchouEXo6JgKccamN0HNySTQj9mJQOddXA
 jLxjfI1xlbfZxaAHeUCnX3gioFpoiyJYmDV5rBIXLDViVAjkGX15yxLCXjBfvs4CPL38
 JOzA==
X-Gm-Message-State: AFuF++lU9rtOpVSt1BP2KKvQRHzDU1WRHiA9HHufAgERcMNMRYnGqrQ5
 1YWt6+TyYeSBKyjAbwKIDd1Vah4jsKr9WUqfIPC2L6vYmEJ4T2A0ZoGTdXgVpJS0W+PmmMEcEbt
 vLhc1ISf+HQpEO3Unw1T5NTrWaI6kMfBDw5BISqKjAZS8aD+ur7KJtw5gTGO/B4hFfA==
X-Gm-Gg: AR+sD13aokH+ePRXJd1Yi31OsJnv06GIOSt1aJY8aYqpdo4vW+y7YrXSWPr43vYQDEc
 Bi4+OtYMbRySVRStKGcYPSfzWRIt01lvtrcqzKwT/S/653MpkO2DdnOnoEKp+SJ+VZiG6O9HBDL
 VloxaPSYpEXhmSJt5nwUZGN5HsUmF81uXi357NlcLsJ3ZxUXDYrLErtMqgn7JaD51/erjwIzQI/
 CsXd0Yu4WfCKw5kL8Wp0t44GY9z3t2GUWUPaHT8cuM6U1osdCx5hkvxj06/qMSOBTPBnHjj8tQy
 9NHS+JPZoUg/DGJLRZeEn+lLNLaHUKLjqR5iXdjG6Rr33V7QQcoq8clwr+nL5hoTsX40Vwqp+7D
 z2dlCSNzE6YSBaR7mIxRhBCa4rMo4KYTpfY5V5w==
X-Received: by 2002:a05:620a:26a2:b0:936:a407:98bb with SMTP id
 af79cd13be357-9391379816bmr268329685a.9.1787869618647; 
 Thu, 27 Aug 2026 15:26:58 -0700 (PDT)
X-Received: by 2002:a05:620a:26a2:b0:936:a407:98bb with SMTP id
 af79cd13be357-9391379816bmr268324585a.9.1787869618127; 
 Thu, 27 Aug 2026 15:26:58 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939173a734dsm8924985a.26.2026.08.27.15.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:26:57 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 14/14] hw/riscv/riscv-iommu-sys.c,
 virt.c: add riscv_create_iommu_sys()
Date: Thu, 27 Aug 2026 19:26:07 -0300
Message-ID: <20260827222608.329788-15-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827222608.329788-1-daniel.barboza@oss.qualcomm.com>
References: <20260827222608.329788-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BGJ2X4DCkbzly8GEPcvlNaOdlCx_hTI3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfXz4Twcv4H+mme
 e/N6yAXTZW0MSm8gmqrZt/0Dtd5glSIb7h097LpruLXfzgh1C+K51bZ7EyBTEN9aevIj2DuWtjV
 fcA/dA9/r8Ok4/s41NtT06cMgrR6jwqd/ohl9vTp57qXkIjdequToxWqDh6vgsyMa1dQNJ3/3Iy
 XCYuMW9xAZsyi+85r+R6iVoqxF96Shtn3WQgiPUpYoDrH2f0ApKxjHpxS/6jzznlGz7nFQjt0M4
 u+LOWVLRJe2eRDjfSdbh0WUEotuq9WqKBLuchyrnFW8INBsPsLh266NxNpHr5MyYWF18FbBsF7Y
 /n9H/ghmk/JIZ1p88z6Nhm+uhAHTqW5Be5fpEQ8Gyp9pIGlX2cGmLNVZM8qUagVhgT58kVIlUab
 uMqkyFqm30bEMAcq5RUQzVf9yQJvHVOoYCRZE1Zgo3KHXVLrSGgRfTD91Sc+d1a1ZOdzD1COFv6
 l69BOtUKhXdx2R2jO9A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX0TOTDfEG2ycL
 le07OAv2dgTcyyySw5B0MnuxSol0QxSADNRY5J7H3Zvm6MmEXOhkSInj2BYAJp8HYbcL+e6/q5B
 SbOPfFy8W1wBIkb3VVpiIS+6+oFKDwM=
X-Proofpoint-GUID: BGJ2X4DCkbzly8GEPcvlNaOdlCx_hTI3
X-Authority-Analysis: v=2.4 cv=dd+wG3Xe c=1 sm=1 tr=0 ts=6a90b9b3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=sIvX0uTPz6KFyc5RlFwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270190
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


