Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BD8606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 23:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pD+orM9/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TMohTIRe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJfVg-0007UK-W9; Wed, 21 Oct 2026 19:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfVe-0007Ty-S4
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfVc-0004y3-Us
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:14 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKeRe21502571
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bdN8gpFlkwM
 erf3PXBCI0/AZ4mp6NhyzqrQZk/FHQ0E=; b=pD+orM9/zJqzyzEeNtwf6po09h2
 2LgY5UUi3ZG6VRTykLZQEL3tQT0Baz3VVSS8/huNXA4n5ubo09Blemt7AyNnBN6L
 rn2J92G/OVhO+aBL+7J4jKvUOtWvYL+2LBcg0vpZzaga/oum9eEFvhrctAkDBrBU
 qTAEckJ79ifA6yGiZ7cbVL0vAIIC2Hd9aPBREW89wRpcPyI2DWOoQyGBDxxROqEg
 krvEYVXAXnnlQDzOeYjKYh6MQ7vWvjLPMb/nMvtDCOwSA2jSlnjSsKUSM4dVG8Jl
 7alT0kYljshOvmE+RIaXxF0M8Q7nYCVvltGPB+aodOx+2qPjaKMS4LMUhoA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0k2hg8t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:11 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5338ff2cf14so26768971cf.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792624451; x=1793229251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bdN8gpFlkwMerf3PXBCI0/AZ4mp6NhyzqrQZk/FHQ0E=;
 b=TMohTIReTuzWMdUgg520mmdmE8XYdsPeyAEEzojyJerVlt/JIKGPYDKQNKfXWwiUQw
 3r5/aYbMnhajmfaM7dk1ZIB63eMNL7H11vL04IOuaDA5L8cxU9KYPy7xHf6H9/8R02F8
 u9uQboH6DdF94v+A1M1f3gqWAowkIjVmoNWRWelEnvS3jiuiY48RuM3RMrjos9u2aGXj
 IhIHVVLQePjwOFM95YjCslMbecRuyDxCkpQaA9cTRwQVPEtsi+ttgNKWgeMCLblTmAyQ
 lYSzhPT80IftaZijolxdeXal+8yzpxfckBSAZTJxLJ0lx6SPz8SIKRVQI0IpW7cWwIsw
 WEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792624451; x=1793229251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bdN8gpFlkwMerf3PXBCI0/AZ4mp6NhyzqrQZk/FHQ0E=;
 b=HyD1cgxfRu/FVe2TssxiQF+z/i6JoTA3gom27dbP+tmm29l4tm7j8uqldyLYTNoUvo
 cD9dBhqU1xYqN8i7s7lZRInjxDW/AD4ATfGfzAG6KQigBcDiceXtqBk0gRrzx+6o1FPx
 ogoFwoAW4xErJTk9+F0RPfGqgJtMS4JujWqOEiL0Xduwtf/R5fveYKKWQJG0qOsXW+gO
 ph7hrI8qhzKFOqkAl9Q3molcWCfGgPqYlmGe++NIozlN9ZzQmLEoif9ycZW3n6WXiVGN
 RF+WG+V0FRoqREQvwwxI2T2rBZgJarKq4o6iMkQsgAsuN66FVCwIDoW5GLAZFzFf3Otu
 q7YA==
X-Gm-Message-State: AFq9FYJD1vpH8PCq54rW93LVsGlUL53Ng1RyriIsHL0Fu7zbQMYtHQ44
 q7xB3A3uFTb6xMFR8EZCpCn5TyevoWCTB/kYSo+GDdN3Kx/1VxJ4LcGEJHODLuQHBG7E3lXLjC8
 DBSnhQD/x42DRNoxekmxEYMlTwoLix2ZhQT53jcdEfeUmWqUHM7N0d4bxyynxlDzBAg==
X-Gm-Gg: AYBFou1XDc/SMdMBxDWq8PzzLUJOX0lYpfVZOytsRb8VbSWbjvRd2ocGa2Dv2SDeRVu
 vsJ5ui4A+fDc0cIi1zGel0YnPLD4Af1ji6/ZlEopAl1L8kgI3dGkArIK+BYPL3AD/Uba+z25KbI
 Q+HLrYq4PG7Jqhc4/dAZSi2yMbLVM95DFHsAaWEoi/95texU8pghob/tRC2/wlt4BFgiVDqgPW6
 VXcCx6e8PgyeC7Z+2CKTQ5NtwobZ1Ho8e0cKj4sahdx9tV1e6GL5mW38BL94vSzZr0CZzE6Qy4D
 yg+bl4eFHPcqKmlhGptgz8f8xODuUfrFLk607549+HLcvWPk3IBcUDffdFI4QwwMCIAKuSBCxin
 3GHgl1nmBl6ynE6L86rIBaq/LiOBn2+mWOjiZJRqq9f44cPXrOHu21vbAXjQ63bIfIKalphNoTg
 ==
X-Received: by 2002:a05:622a:588e:b0:532:9a2a:f37 with SMTP id
 d75a77b69052e-5369b677beemr55774611cf.18.1792624451174; 
 Wed, 21 Oct 2026 16:14:11 -0700 (PDT)
X-Received: by 2002:a05:622a:588e:b0:532:9a2a:f37 with SMTP id
 d75a77b69052e-5369b677beemr55774351cf.18.1792624450735; 
 Wed, 21 Oct 2026 16:14:10 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com
 (200-204-190-237.dsl.telesp.net.br. [200.204.190.237])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536ab6cd0dcsm11995651cf.6.2026.10.21.16.14.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 16:14:10 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 antikostya2@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 04/18] hw/riscv/virt.c: add trace encoders and trace ram
 sinks
Date: Wed, 21 Oct 2026 20:13:31 -0300
Message-ID: <20261021231346.2452179-5-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfXwXI3gIs6eE5G
 h+MyU4fu87nu/GvVw7M2fCBZOdGXZzsH+25w410rddVP8PvEfjaajS9vG4D5bzAfu890ZCZqAr6
 JXrojKW/r7oTrHG/hn65JcBwCEk56FI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfX0288bTcZIAuG
 li6ki3rjq3OuUIuz6HeD98fllJwGn9nYwFovz7afQAXCs+ARNtHXFusmhq3j6sl9PqZpcsJtU8E
 PTsOdutfB3wTGuhtkPDxid8r0BIveSi8+XT8B7QrqXNcvfMvwNk+KCw5f+nr9QxrbVeC55WVk6n
 zoxvQJrovyCXpAFlFep/L6frGOguXyWgaOg/u84t3EL278G1ZZxCov33bTh6Q4spuXbQCe6CxoP
 IFeoWbGpS3JD3A+JTYCYBwW51c1U7954d8zsp7yii37Pq8XBIizo1xP5mpAwYnCQKZmIj2Y1z0h
 K9HYLw78i2XLLgd9CQGMwVfxQfu1n/H1SFpq2CNEqCx1Kk26XmX+E6p0LRE2tfjn/nvk7Dtf5qR
 5yy5oNGpXbcvhWe06VFeTanGNLTs8ZaT4LbYWojcFBCfD0Ku4BlJXksXYjYmWadw7bHVxFnEY5z
 fFgdwRso6+4Ifvk28Qw==
X-Proofpoint-ORIG-GUID: K3SsIY9UuOllNIJPdSIaKPjcUcUpuPiY
X-Proofpoint-GUID: K3SsIY9UuOllNIJPdSIaKPjcUcUpuPiY
X-Authority-Analysis: v=2.4 cv=K/+3jCWI c=1 sm=1 tr=0 ts=6ad94743 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=QmVDPCq3bE4LYXGvZ20s0w==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=GcwozZFMniDO5iVAK48A:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210092
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

Add the minimal topology required for e-trace support in the virt
machine, e.g. each CPU will have a single trace encoder, and each trace
encoder will communicate to a single associated trace ram sink.

At this moment we're not going to support more complex topologies with
trace funnels and so on.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/virt.c            | 81 ++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/virt.h    |  2 +
 target/riscv/cpu.h         |  9 +++++
 target/riscv/tcg/tcg-cpu.c |  5 +++
 4 files changed, 97 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d4b501802f..d47b295f0c 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -60,6 +60,8 @@
 #include "qapi/qapi-visit-common.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/uefi/var-service-api.h"
+#include "hw/riscv/trace-encoder.h"
+#include "hw/riscv/trace-ram-sink.h"
 
 #include "aia.h"
 
@@ -83,6 +85,17 @@ static bool virt_aclint_allowed(void)
     return tcg_enabled() || qtest_enabled();
 }
 
+#define TR_DEV_REGMAP_SIZE 0x1000
+/* For VIRT_CPUS_MAX = 512: TRACE_DEV_REG_MAX = 0x200000 */
+#define TRACE_DEV_REG_MAX (TR_DEV_REGMAP_SIZE * VIRT_CPUS_MAX)
+
+/*
+ * 64k for the RAM Sink that includes the 4k (0x1000)
+ * for regs, for each possible CPU. For 512 max CPUs,
+ * total size = 0x2000000.
+ */
+#define TRACE_RAM_SINK_SIZE (1UL << 16)
+
 static const MemMapEntry virt_memmap[] = {
     [VIRT_DEBUG] =        {        0x0,         0x100 },
     [VIRT_MROM] =         {     0x1000,        0xf000 },
@@ -92,7 +105,9 @@ static const MemMapEntry virt_memmap[] = {
     [VIRT_ACLINT_SSWI] =  {  0x2F00000,        0x4000 },
     [VIRT_PCIE_PIO] =     {  0x3000000,       0x10000 },
     [VIRT_IOMMU_SYS] =    {  0x3010000,        0x1000 },
+    [VIRT_TR_ENCODERS] =  {  0x3020000, TRACE_DEV_REG_MAX },
     [VIRT_PLATFORM_BUS] = {  0x4000000,     0x2000000 },
+    [VIRT_TR_RAM_SINKS] = {  0x6000000, TRACE_RAM_SINK_SIZE * VIRT_CPUS_MAX },
     [VIRT_PLIC] =         {  0xc000000, VIRT_PLIC_SIZE(VIRT_CPUS_MAX * 2) },
     [VIRT_APLIC_M] =      {  0xc000000, APLIC_SIZE(VIRT_CPUS_MAX) },
     [VIRT_APLIC_S] =      {  0xd000000, APLIC_SIZE(VIRT_CPUS_MAX) },
@@ -710,6 +725,68 @@ static void virt_machine_done(Notifier *notifier, void *data)
     }
 }
 
+/*
+ * Must be called after 'soc' realize since it
+ * uses CPU objs.
+ */
+static void virt_init_socket_trace_hw(RISCVVirtState *s, int socket_num)
+{
+    int hartid_base = s->soc[socket_num].hartid_base;
+
+    for (int cpu = 0; cpu < s->soc[socket_num].num_harts; cpu++) {
+        RISCVCPU *cpu_ptr = &s->soc[socket_num].harts[cpu];
+        DeviceState *trencoder, *ram_sink;
+        uint64_t trencoder_addr, ram_sink_addr, smem_addr;
+        uint32_t smem_size = TRACE_RAM_SINK_SIZE - TR_DEV_REGMAP_SIZE;
+        int cpu_id = hartid_base + cpu;
+
+        ram_sink = qdev_new(TYPE_TRACE_RAM_SINK);
+
+        ram_sink_addr = virt_memmap[VIRT_TR_RAM_SINKS].base +
+                        TRACE_RAM_SINK_SIZE * cpu_id;
+        /* smem is located right after ram sink base */
+        smem_addr = ram_sink_addr + TR_DEV_REGMAP_SIZE;
+
+        object_property_set_uint(OBJECT(ram_sink), "baseaddr",
+                                 ram_sink_addr, &error_fatal);
+        object_property_set_uint(OBJECT(ram_sink), "smemaddr",
+                                 smem_addr, &error_fatal);
+        object_property_set_uint(OBJECT(ram_sink), "smemsize",
+                                 smem_size, &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(ram_sink), &error_fatal);
+
+        /*
+         * We can't do object_property_set_link() because we're
+         * coming after cpu.realize() (the riscv_hart obj creates
+         * the CPU objs in its realize() since it has no init).
+         * We need changes in how riscv_hart works to use
+         * set_link() and to not manually realize the trace
+         * encoder.
+         *
+         * For now do everything manually.
+         */
+        trencoder = qdev_new(TYPE_TRACE_ENCODER);
+        cpu_ptr->trencoder = OBJECT(trencoder);
+
+        trencoder_addr = virt_memmap[VIRT_TR_ENCODERS].base +
+                         TR_DEV_REGMAP_SIZE * cpu_id;
+
+        object_property_set_link(OBJECT(trencoder), "cpu",
+                                 OBJECT(cpu_ptr), &error_fatal);
+        object_property_set_int(OBJECT(trencoder), "cpu-id", cpu_id,
+                                &error_fatal);
+        object_property_set_uint(OBJECT(trencoder), "baseaddr",
+                                 trencoder_addr, &error_fatal);
+        object_property_set_uint(OBJECT(trencoder), "dest-baseaddr",
+                                 ram_sink_addr, &error_fatal);
+        object_property_set_uint(OBJECT(trencoder), "ramsink-ramstart",
+                                 smem_addr, &error_fatal);
+        object_property_set_uint(OBJECT(trencoder), "ramsink-ramlimit",
+                                 smem_addr + smem_size, &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(trencoder), &error_fatal);
+    }
+}
+
 static void virt_machine_init(MachineState *machine)
 {
     RISCVVirtState *s = RISCV_VIRT_MACHINE(machine);
@@ -765,6 +842,10 @@ static void virt_machine_init(MachineState *machine)
                                 hart_count, &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&s->soc[i]), &error_fatal);
 
+        if (tcg_enabled()) {
+            virt_init_socket_trace_hw(s, i);
+        }
+
         if (virt_aclint_allowed() && s->have_aclint) {
             if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
                 /* Per-socket ACLINT MTIMER */
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index e516898f9a..f3744f48c2 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -91,6 +91,8 @@ enum {
     VIRT_PLATFORM_BUS,
     VIRT_PCIE_ECAM,
     VIRT_IOMMU_SYS,
+    VIRT_TR_ENCODERS,
+    VIRT_TR_RAM_SINKS,
 };
 
 enum {
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b65d631994..e2ded4c257 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -593,6 +593,15 @@ struct ArchCPU {
     GHashTable *misa_ext_user_opts;
     GHashTable *multi_ext_user_opts;
     const GPtrArray *decoders;
+
+#ifndef CONFIG_USER_ONLY
+    /*
+     * Associated Trace Encoder. It will not be NULL if
+     * we're running with TCG and initialized manually by
+     * the board.
+     */
+    Object *trencoder;
+#endif
 };
 
 typedef struct RISCVCSR RISCVCSR;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index e07ca95e49..6e74d6a4de 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -39,6 +39,7 @@
 #include "exec/icount.h"
 #include "target/riscv/tcg/debug.h"
 #include "target/riscv/tcg/csr.h"
+#include "hw/riscv/trace-encoder.h"
 #endif
 
 static GHashTable *multi_ext_implied_rules;
@@ -1366,6 +1367,10 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
     if (riscv_has_ext(env, RVH)) {
         env->mideleg = MIP_VSSIP | MIP_VSTIP | MIP_VSEIP | MIP_SGEIP;
     }
+
+    if (cpu->trencoder) {
+        qdev_realize(DEVICE(cpu->trencoder), NULL, &error_fatal);
+    }
 #endif
 
     return true;
-- 
2.43.0


