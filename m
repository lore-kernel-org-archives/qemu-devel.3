Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608B1C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzLTD-0003gr-E0; Wed, 26 Aug 2026 17:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzLTC-0003eF-4L
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 17:47:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzLTA-0001TG-HH
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 17:47:41 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QKdNvu2001286
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 olqHdGaxzXrPitS+3jNFSUVam0sm4yRRKPUQUbIVUzk=; b=eZ8H/CELPWpMG55h
 HqBUjr1AZWbH6dIzJNzB6Im2pNu8LaEtUhCdjmmqBy7Pl7W5tog6a8voUNpRyiY1
 RVs3hyU035YSWO18yIEyEu+Nq45eYVAdToYyT1vDYjsVgOzCwovcxKCVuV2AxxET
 224G3zqD5KSplcHm6U1MVKOHu4R8NFfEFHooe4aDWDBQjlvmtrywtMHOuabV5Qbk
 ewiLR4TzOjRM831S6ActGdn3xIo9zyVeTWiEiQFwGCU1LLHVs+9rD2rR6J3S2TBr
 rMiTnd5JLjZR/cTUcUgMScy649V+ZRiYgM20Z9PtxSNVB8AI01r0uAtHUElHeAr8
 VqLbKA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4ec8w84-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:47:29 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e4f946461so132966485a.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 14:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787780848; x=1788385648; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=olqHdGaxzXrPitS+3jNFSUVam0sm4yRRKPUQUbIVUzk=;
 b=D/38+j+UFpFl9z4BFveCQinBAcnaDDZzF9o0hhwmfWEunTe4BFYPp4umadw4wSqIkp
 +y7oMBqfAR5ESUkMxXAhKYTUHB2QZxAJ+0BIhhJ1Sga0DF0o9nEhfgGhb+BFghtFVB6w
 kNMlw1tbwF7CZ2Sb1sPZxr8G+vF3jjRYO2Jyd7EVIOOfhbeWPDXKE6toMERMumS5pMdC
 Pa45Ob8Et42GfVoR+DaTpGgT6PZdDmbz5fKKl0a3Ajdw3uS4+axyPiNX7zT+NDcqckiY
 b6MzUenR8Au9jFDClzSQiX9lkN0nHxydkMPdwkq9y0/xp8H6XkjrT4czkHKIpGNQ0mN7
 45nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787780848; x=1788385648;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=olqHdGaxzXrPitS+3jNFSUVam0sm4yRRKPUQUbIVUzk=;
 b=pcEBHnvIz69HSfWuRwQHof7cImD0gbRw5xV0p206o2oyZ7Q199FJ+iS4S4/h9j28kk
 +wfDi7PmelqPUBk3Jk7SCQuvz3mai4RWh6CGEss5BOFef6wGHmaQENeKLTozJr7EBnwX
 KtAYVE95kaJDmtmKvDyPZ4MkOS3nYcDvuYzDQwmd+WRnGQ9JQjMdcMXeqbb12BfmhXIO
 Qcf+77zVA7WgY34+tUVdByXhFZGoLRTfdE5tBkG3SWndMW251+f5/c1em/gSa/h/hfJS
 93ZmH+u0TU7ShE1SUhR2UI4aPbCd0TYJXmM9wC6iN6G3QkSvNgMwRhVJXBWkEVKttv4K
 T3Sg==
X-Gm-Message-State: AFuF++m4j84SZym7iUfMQHdf/u5IJKmW12xmNL9nbpcOYdgXdpoDcByl
 4GDCzKmOpULzA0kG0AequY0x++rRJs8fRPI4dnTX7+svyelmI5fbtkjWLsIx1dWtKgfoGXGUALq
 1IyX7ct62WX5mTHmgGKG0ng/rOf73cBPFCNQYYj1XjMBhNobS3mLlRERMZeUkHvgTrw==
X-Gm-Gg: AR+sD12ZbyT+5OymZCNlp6yQ6MCGhqOEgiSaYcmYvLvFg04zGZEEsTWSePRNhw9VOTo
 XVud7XRlazcSxfQqmY2+/7kq2EwesMOgCUlwFo1v5X9dBXay91ff/wuKTWTff7YZ5JJpBEcOESq
 QyTsBy2sgSTPHjbDAi2iBo7/og0kDoF3lSYer8XYjPAXdR8ER9Hhf2gevxLj4RBxOq7PJSClMEM
 1MIfCj57t+4HI7OwwL7wACMs7GIDsusBKomhHnPZ8yPh8aXKAgGB5ITH4eiyOqiTzWbpNNDxTtM
 /1McegzMhkNVw7Xt+9Sy/+zor15kMEB7y8GH1YNAgniXjmHxB8UDSA7cxIrfwYtKf6jkfxmNpiE
 0Oz3cYmQjz4IZW+zDTChwsaU5gRGO2NamHcaz6g==
X-Received: by 2002:a05:620a:a717:b0:930:9585:e08e with SMTP id
 af79cd13be357-937800c854amr982065585a.10.1787780848053; 
 Wed, 26 Aug 2026 14:47:28 -0700 (PDT)
X-Received: by 2002:a05:620a:a717:b0:930:9585:e08e with SMTP id
 af79cd13be357-937800c854amr982059885a.10.1787780847448; 
 Wed, 26 Aug 2026 14:47:27 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cd73e4117sm490916d6.24.2026.08.26.14.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 14:47:26 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 14/14] hw/riscv/riscv-iommu-sys.c,
 virt.c: add riscv_create_iommu_sys()
Date: Wed, 26 Aug 2026 18:46:42 -0300
Message-ID: <20260826214643.122728-15-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826214643.122728-1-daniel.barboza@oss.qualcomm.com>
References: <20260826214643.122728-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KIBqylFo c=1 sm=1 tr=0 ts=6a8f5ef1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=sIvX0uTPz6KFyc5RlFwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: HziU0mWVTmQDU_KdK3S3Tmptaklyz9DD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE4MyBTYWx0ZWRfX1Bm+kRicFNP3
 oEZpxbAswksvjPeWa/UjrwwO1B5KmipdVV6AiI+ISKZJZA6ZEP+L+bziZ/EXAI2Rz2kfLGvsPEI
 9E55XYqWw8/aXiIg8RLLG5pQzLfbRawoBvbtIhdBgxOZbO2iG7dD3aqH1KRdxHg2n2rFh9mEOhh
 rlGPEqMWGH8KdgKRAVgOIJVUFCr6I27dtr67dWTXmej/l3G9+s0nJD4bN5m7TGQVUFZ15LrbYMu
 /fjwrCOZMKCN78QCi27FpAf0bRL1wen2NB7mb48sjoMV+QE9l2E16EynYKADE9vvvOacMTMK3oE
 YJzl6zbhri+gZkos3aIyVtBABx0BLC/9OllQoJV6qmLW+vSqTOoud3y0IhuVp+VNtxhxi1VSYD8
 DsHT0ctzIILlziW7NaEOhTGTwSsTbsGiWeXmfv7YUXKqlph+JTCcnGydkDZKoeOLHLOIxDpXVc3
 kWrAzdCkbeZbfMNMbkA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE4MyBTYWx0ZWRfX/7zpU0gCnGVl
 kxxg3sQeQnaiRbX9F8sywTZ0TljArBsGg6ETHM0ubTEQF3LF0RZXJZHxlU+1Ysfi6HYVz9Yd5SQ
 VVA8jkqccdn99t2sLa0/tep4TmjMgkI=
X-Proofpoint-GUID: HziU0mWVTmQDU_KdK3S3Tmptaklyz9DD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_06,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260183
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index c1cb98fab0..0da7b8b1d9 100644
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
@@ -917,26 +918,8 @@ static void virt_machine_init(MachineState *machine)
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


