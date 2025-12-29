Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFE8E92FC4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 18:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaIIh-0004Bf-1Z; Mon, 29 Dec 2025 13:49:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaIHE-0003fS-4S
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:47:35 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaIHB-0008E1-Gf
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:47:31 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BTAlwQk1461913
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=oAJGVkzFfOQ
 IiDXh0qMlqrI8SbjU24rOP1b1tZiWHA8=; b=A7mG5xgj2wNjzV8rFy58wE+MF1t
 5k7g3U7MMgzTKzc0UYq78POmsEpmoKVVQgOS7Bv1QHe7goKTLU+76HeGXgoAdR+K
 6F3Gl9sO7+b0ItGmqhIYm+M/dJUeGej1TFgDCss5XJkYXL87q/4hhO72EnrY9JO8
 /8ipE4wZqZKE29s0MC5QPlZi25GG8QQgFD85et3JLHZ+kScjgNiET1kNnq5xlkLR
 dUTocdhTsd2eycTZejlFYYWCxOSThupUv7XSUqQIN1d4pABVNLQyDEZd6Mqa/98E
 cHfbVQMKl/gsEfr1Vxm/1LzuwbNEWSbwC2qk0qkMOXP3hiFqXJAHP/nP2VA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bavrj3mfu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a08cbeb87eso155586135ad.3
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 10:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767034047; x=1767638847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oAJGVkzFfOQIiDXh0qMlqrI8SbjU24rOP1b1tZiWHA8=;
 b=S3jDO6G53V5tF+PUikefqrdo0qZSkaXtKApFxuhxQf/uUvaLeRCZIlZEkreTP/qlRq
 nNXZQ3uGaxhiUBo9O/E6pHgqcy+VKnA5tAhqSOinGDf6pyLf6SFdXY6+zu8RE6x03j6D
 wI/PMFy7jYnu3YZJ2pM0oja8AxgJaOTo8rbR34Zzur0aVEGssiv8FMSHVlPNhWuMW+Vk
 FS39E5PGtt6qpxRAOtODr8HFvMhgl9rAU0wKDdJoMElo1X34qUZDxmdY6gArtQf/5S/u
 R4gFAM6bEB+cQYBTiuZtZg1bZsiTGtSFz6uIozUwhp/S4Akyij+CM/wfUWkytpcNMN4R
 lsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767034047; x=1767638847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oAJGVkzFfOQIiDXh0qMlqrI8SbjU24rOP1b1tZiWHA8=;
 b=qrLFIMhtBVnjuapcHdZxw5tgXEKKveP0f3tBahETxEgYyb4L6DxvTSZCb/UhSlikI9
 RphtHedbUnXe3Fhpo662oi0O7uTcO6LlU3Wdx7EmFBFil8vkwfSbpLm1ZLqPF0/5j6ey
 FH+d3cF0Etp1g/GF9P5pbIWGMLmbYQFJrGI16gSTl8YgqjlFEQFsxZIxmhuz4nhods0B
 QIIN7JFr+H5oZz80JN4EX1yYxRolLvl+QDvl8aBlm35pp1NHxm8WYXbpX+mzWBCqoR9W
 zXkec0vxocAGMC0MIo6UvZevTd2PulOGyDjCY4KRI6Dir2GWvtbwE0vhyUZMfmTmFycb
 ohiA==
X-Gm-Message-State: AOJu0Yws2C5QkjeKeomNh4PfHy1SoZKEsSrGmeCmmz6G6IAZuYpNqg+h
 cO62Vgkq3XNzYv66Cih61ZFPCD/8GbhV2dlz5ZPH4Dy5eJ25HmeetfPV6Q23m8b3S0/Fe8Hynas
 IxHeXp5UyN4gCa/dCZyb9nwGtUEiUzZAsl2pOljV4Mw0nEgiqZoPzCnbg87K3/et3vA==
X-Gm-Gg: AY/fxX5wkkuZUTHg2q9QZXSliEBF8yw/Duq0oz+y46WHLq2z6X/thfWtd4XhxIFB23B
 T8pgPmvk4ySk7ePYx0n3z/D2JpVeF4KlyBf4Vhd0IkTFoKaJ3nGvU0zNR9ErDopkVQ2kU5KWkPI
 Uv9wYC4qJFp9Ijy1M8tD68K0eyQ1DB5UW1nrpEADZwvWH9lq5/p/ClvBObDIvvdHryveB1q5MX8
 VwhBmzazwr05fvFfHss5U/EzALoiZehcBB/mRAIGKydVQ25Iy+a8kR3AhLOiLulqDN3lKwC8wGj
 SMmlEX8Ugx9/iuWHPh9mzyJmTT6XQ8qLSyriPkEZMTq7PzWAOLxrmp0Uuz0LchsBC0yzmN3dMa3
 HcVe8+bctbMaEfLd+cIKvAI+WCJ8G+krbxWe8JMXi1EqG1sQ=
X-Received: by 2002:a17:902:cf0b:b0:29e:c2dd:85ea with SMTP id
 d9443c01a7336-2a2f22049b9mr336303875ad.11.1767034046986; 
 Mon, 29 Dec 2025 10:47:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyd1Z5D2V0kG5oiJrXgVDBpPInn69qoMITF6nXP9hsVieTAYDAM1A5VQ1yvyivVgUTLo8dVA==
X-Received: by 2002:a17:902:cf0b:b0:29e:c2dd:85ea with SMTP id
 d9443c01a7336-2a2f22049b9mr336303725ad.11.1767034046409; 
 Mon, 29 Dec 2025 10:47:26 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.184.177])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c82aa8sm282198705ad.31.2025.12.29.10.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 10:47:25 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v3 04/17] hw/riscv/virt.c: add trace encoders and trace ram
 sinks
Date: Mon, 29 Dec 2025 15:46:43 -0300
Message-ID: <20251229184656.2224369-5-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
References: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LzxkbRwi0q4tHk9sRpP97xW72NeRxpNH
X-Proofpoint-GUID: LzxkbRwi0q4tHk9sRpP97xW72NeRxpNH
X-Authority-Analysis: v=2.4 cv=coiWUl4i c=1 sm=1 tr=0 ts=6952ccbf cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=cW5wcbexNO3A0Ml9TiDm9w==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=MVOyIR3Nq1xdiiQTEeAA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE3MiBTYWx0ZWRfX5F+B/ueforMx
 QavBnN1ts1QdTSHZ+udO5ChaML8yLvCLTMU6dLNiLl7oPSticVodoUW5ZAPQtR8o42gUtXijrtH
 rmyTFbRveq7JjO2cuplowJDxuFs03lNIvKoGI3FIKHUiyV2PjGVaztEGjDlCxvg2UieDz/SZkuo
 HDEeJOxgrA3HHML5KFDFAlM3lj8cwlRocuH4XFCwj/DKLYXlWL5CNyRrj7hBaQBaGtl1pkU0/tn
 YlFOqnt50UxcKUTUEqN/jKKLI5f102QodDowWl8q9H9giMl6NXbCcDFt6qUQXE1/a9404FSZdHH
 dt9bqMGk/iQ5P1R7gL0AhwS2fC3mpGb/HU1IuQRG/GTiKeoLUn9eCbk4WGlXIu3x0jvY0JHIBwp
 G+P+PViQIkUxI3+RjXh7dKs5PEGF7kLeL+DASeKYZwFofDgCV16pQDEudVJHAUm6pfGSWEmvGOf
 zuipujBpSmxuqlD6M+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_06,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512290172
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add the minimal topology required for e-trace support in the virt
machine, e.g. each CPU will have a single trace encoder, and each trace
encoder will communicate to a single associated trace ram sink.

At this moment we're not going to support more complex topologies with
trace funnels and so on.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/virt.c            | 77 ++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/virt.h    |  2 +
 target/riscv/cpu.h         |  9 +++++
 target/riscv/tcg/tcg-cpu.c |  5 +++
 4 files changed, 93 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 17909206c7..b1a4d63efd 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -58,6 +58,8 @@
 #include "qapi/qapi-visit-common.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/uefi/var-service-api.h"
+#include "hw/riscv/trace-encoder.h"
+#include "hw/riscv/trace-ram-sink.h"
 
 /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QEMU. */
 static bool virt_use_kvm_aia_aplic_imsic(RISCVVirtAIAType aia_type)
@@ -79,6 +81,17 @@ static bool virt_aclint_allowed(void)
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
@@ -88,7 +101,9 @@ static const MemMapEntry virt_memmap[] = {
     [VIRT_ACLINT_SSWI] =  {  0x2F00000,        0x4000 },
     [VIRT_PCIE_PIO] =     {  0x3000000,       0x10000 },
     [VIRT_IOMMU_SYS] =    {  0x3010000,        0x1000 },
+    [VIRT_TR_ENCODERS] =  {  0x3020000, TRACE_DEV_REG_MAX },
     [VIRT_PLATFORM_BUS] = {  0x4000000,     0x2000000 },
+    [VIRT_TR_RAM_SINKS] = {  0x6000000, TRACE_RAM_SINK_SIZE * VIRT_CPUS_MAX },
     [VIRT_PLIC] =         {  0xc000000, VIRT_PLIC_SIZE(VIRT_CPUS_MAX * 2) },
     [VIRT_APLIC_M] =      {  0xc000000, APLIC_SIZE(VIRT_CPUS_MAX) },
     [VIRT_APLIC_S] =      {  0xd000000, APLIC_SIZE(VIRT_CPUS_MAX) },
@@ -1525,6 +1540,64 @@ static void virt_machine_done(Notifier *notifier, void *data)
     }
 }
 
+/*
+ * Must be called after 'soc' realize since it
+ * uses CPU objs.
+ */
+static void virt_init_socket_trace_hw(RISCVVirtState *s, int socket_num)
+{
+    for (int cpu = 0; cpu < s->soc[socket_num].num_harts; cpu++) {
+        RISCVCPU *cpu_ptr = &s->soc[socket_num].harts[cpu];
+        DeviceState *trencoder, *ram_sink;
+        uint64_t trencoder_addr, ram_sink_addr, smem_addr;
+        uint32_t smem_size = TRACE_RAM_SINK_SIZE - TR_DEV_REGMAP_SIZE;
+
+        ram_sink = qdev_new(TYPE_TRACE_RAM_SINK);
+
+        ram_sink_addr = virt_memmap[VIRT_TR_RAM_SINKS].base +
+                        TRACE_RAM_SINK_SIZE * cpu;
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
+                         TR_DEV_REGMAP_SIZE * cpu;
+
+        object_property_set_link(OBJECT(trencoder), "cpu",
+                                 OBJECT(cpu_ptr), &error_fatal);
+        object_property_set_int(OBJECT(trencoder), "cpu-id", cpu, &error_fatal);
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
@@ -1580,6 +1653,10 @@ static void virt_machine_init(MachineState *machine)
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
index 7b4c2c8b7d..e2aa6fbbcd 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -88,6 +88,8 @@ enum {
     VIRT_PLATFORM_BUS,
     VIRT_PCIE_ECAM,
     VIRT_IOMMU_SYS,
+    VIRT_TR_ENCODERS,
+    VIRT_TR_RAM_SINKS,
 };
 
 enum {
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8899bf7667..5ebf7f663e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -547,6 +547,15 @@ struct ArchCPU {
     /* Mapping of events to counters */
     GHashTable *pmu_event_ctr_map;
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
index 440626ddfa..265b460487 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -37,6 +37,7 @@
 #include "hw/boards.h"
 #include "system/tcg.h"
 #include "exec/icount.h"
+#include "hw/riscv/trace-encoder.h"
 #endif
 
 /* Hash that stores user set extensions */
@@ -1327,6 +1328,10 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
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
2.51.1


