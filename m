Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE43A606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N6iUjz05;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iZvPWgMt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLKfx-0001Up-8F; Mon, 26 Oct 2026 09:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xLKfq-0001T5-F3
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 09:23:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xLKfo-0005Eu-A1
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 09:23:38 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAt5NH3034427
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 13:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=JY6PW36Ycz6
 PF6cSIf5XDLnEYJidKUv3EsSSHn5rJqw=; b=N6iUjz05aQngnswcnFEHfaPRSks
 0zxIUfbC4n14sjXpXcviyPQpDsFCosq/WK+n1ermCwIbtmXLbPwuAbQGBm1KjqJT
 D3LjCCjiuEoo2CQ69GQGLbBmpYx2BeES+ayBUtKGb9KaZMQrRRQz7JBmxeInHzZF
 VWNLiCmXYQoLhohrCyi/uXOmPFPHYSBCBoqskzF7tBh9Z/Sfp3XQzrxVYMqiDqAf
 5QziLwJQ20mFNCaE8e0qTuk6yu3P6DhDA2y9wufXqsrVCY/FlDv4CMNbyxr0z0VG
 SjGY17N6mHiHRfH2SZG9UeYf/2ZhyoNAydHjiWkZJmVz4b3GOj89fD/v6WQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj56y0knu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 13:23:35 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34edae32c04so433813eec.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 06:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793021014; x=1793625814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JY6PW36Ycz6PF6cSIf5XDLnEYJidKUv3EsSSHn5rJqw=;
 b=iZvPWgMtbc3E5Eazz+9CeGEWnr/TNqfuRPfEeqBFXRIAVt/MW9xrDCXeBs6f1blbJA
 kQ0d8Y9qa0nM+LyIaI12aM0atWK/jAKHkP4BZqphHPxWjiwKY/cLG6TAzIJyY/B6q14V
 yKjADtXkPxUG9F0p45q5TdB1INbzxUW9nPcnL2x1Xq5b99Cb3vlWOJ/PJ30Fo51yqYP8
 Y495BDxUUW78Z3NVqR9+7cBiIIAwvZ/ScPvBeW88peoioPuRLPkE54Aewe6WgSl6SQuX
 S3C8Dx4PMMFUUB+3aAujBL7EAb+vYmoZA2Zh9e4Gs49ITrpsrJFATc2COzfzqYplndMv
 GBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793021014; x=1793625814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JY6PW36Ycz6PF6cSIf5XDLnEYJidKUv3EsSSHn5rJqw=;
 b=YtpQ1xKXbpRU7mvyV0tlS8ObmBdkBEZnsR4e5rZbF7Uq8p+/2xX35uWYOk5mxtZy8i
 ZdjqqNzvXpso6QdeuI46QwU9h3f2z4DhKgyrGCvLLZWXVmO5Y+tlgiwkSg/bKWVqf4BZ
 Q4w/4+3XAoUi4F3sIVMgbHOIdgzlahw3kLvwDE1FWpEiDkwm/58X1+z45T+3Dlp1axLg
 R4at2JLiXfszH8bpnuTP3O5wz+6/pQblPTIlQwr8nYd3065HKOzcS4rykCTxLe7WLnja
 NaW8STK0TIOKl1/9o4kYwqVZ3lxzhrjwORjWua0pFjXsbKbK8rJj9/7tbUOeS2iqmNw+
 NrMA==
X-Gm-Message-State: AFq9FYJWME2/q9Mc+v64hFmHiWGwicmu03OAVcyKq5N9vz3LZ9tc09Fp
 Wc5+bvKB6fN9FP3GbhR+JZbZdYhSa5na+i4kHpAk/Q14p5s5GRCasZ9ActB95lf+WqUGQHj8hBO
 /Wen+f1LbGeCLrFn0HP8eDv4vp3/paGsu4bgrsgXWPf0f2snXjh9CK14kzNuEmTzFEw==
X-Gm-Gg: AYBFou2gEj8yGqOoe9xIaQrypvWxQTFiA1SkvzpOM2SHjTFG2lK4mKc0wN8ykjEhq/w
 weu74c1pCUI2tgnVXvSpuIb488DCgmQsZ9Mwondlf3OsAHIqhZjbZ3zY0e5dfxZ0G/Fmwok9+bc
 +kmH6Hu3oLnbo9X1M1I9BFpiqzH53doB2syhQvenVqKMsv7Ea6fD3HAQ7pyfbvYNfRoFRQhpNZj
 qz9LdTjD7xpjdfj3CrpyQOgavDAPZxbEEMBQtkqhuZ6ZwKxw1jhJWGmKofKqCWp1a34VySRt0e9
 HmVxXiuj/bstcJFg0tPC9JfwS6oGSqeGphjE6NkR43/U4OMfNH1t/JvEe8WR1xjkA2zy31WGJug
 UMYvBaSckGh2tZH7FmBLtO0e/+IaXh3XLhcjgLW52fAg5n7DKKL433k9LrDeg72h7GMKT3aYaOj
 87+LZEhyadsdbhyjuAsKNUlzv5oIVLG8g=
X-Received: by 2002:a05:7022:5f07:b0:146:ffa9:2117 with SMTP id
 a92af1059eb24-1993639e5f7mr14995238c88.1.1793021013971; 
 Mon, 26 Oct 2026 06:23:33 -0700 (PDT)
X-Received: by 2002:a05:7022:5f07:b0:146:ffa9:2117 with SMTP id
 a92af1059eb24-1993639e5f7mr14995180c88.1.1793021013251; 
 Mon, 26 Oct 2026 06:23:33 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a21bc6cbsm24360931c88.16.2026.10.26.06.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 06:23:32 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v12 04/10] hw/riscv/virt: add opt-in RPMI base support
Date: Mon, 26 Oct 2026 18:52:47 +0530
Message-ID: <20261026132254.2652399-5-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026132254.2652399-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20261026132254.2652399-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1MyBTYWx0ZWRfX/HzfW7SAjcDX
 DQUq5ZG5P6kmqbq9CTIZxpq/k5UuXFFneKcwkHUNV3H9UCAd+FgFtVfjapgr9VOK65cd7DduoGo
 heL3scg5eBWLOISh4+x1pvgfyd4UROY=
X-Authority-Analysis: v=2.4 cv=eMeGH3p1 c=1 sm=1 tr=0 ts=6adf5457 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=UqCFv9FlzdzCN5i-bQEA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1MyBTYWx0ZWRfX813TEoKTwfHX
 P7KtQVBNgZO2zlW7Eu/yedcAjWrry3bzUSVYNrV/oFNIfpYZzfc7xGBZr+CK6wCgXmzBlwbcJgr
 zomw+u/UGWbAcCZ05OHhqeDZbS1dbbDa4Fb/ic54sbVhWC+M+oqEOOUfMQo+QGhW/jguYCNP9S4
 pRFYT1laCIp9/FwucaYOkNU/UgHsrQwJebqqEo7Y3nPedAoWijyQ7lVT1yQvFZTGl461Zq147rK
 SVWWW8lJyY5Js9Il05hG160GTR2n9CUNDq0Q92A8Ap6+Q/2Q3uz4W/yu0yZVVo+aMj83MbCHgcM
 sC+deaTbu1KDPxVtE80IHhsABxOSw7DGuAs2ukxiuo6AUIGdSE9plagJ5fp+5pp1QpdTcJCrJ1p
 URPrAVYw396fI685iPiIkcT0cAWpFHt/sK0S5E3rIYcwjuADm2vJYQ4kGACKwWZRw8amQA6LEYJ
 Ad4VRzy9xjF4I1gatqg==
X-Proofpoint-GUID: MwZVtwRAPUK88bo3aeepO0OTDpLnvE1S
X-Proofpoint-ORIG-GUID: MwZVtwRAPUK88bo3aeepO0OTDpLnvE1S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260053
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Add the virt machine rpmi=on/off option and wire the initial RPMI Base
transport into machine realization.

The option remains disabled by default and requires TCG plus librpmi.
Invalid accelerator/build combinations fail during machine
initialization. When enabled, virt allocates the RPMI shared-memory
transport, creates the RPMI device, configures Base service metadata,
and emits the corresponding device-tree nodes for firmware discovery.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 hw/riscv/Kconfig        |  1 +
 hw/riscv/virt.c         | 97 +++++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/virt.h |  3 ++
 3 files changed, 101 insertions(+)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index fb05031228..dfdbc6dfe1 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -49,6 +49,7 @@ config RISCV_VIRT
     imply VIRTIO_VGA
     imply TEST_DEVICES
     imply TPM_TIS_SYSBUS
+    imply RISCV_RPMI
     select DEVICE_TREE
     select RISCV_NUMA
     select GOLDFISH_RTC
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d4b501802f..3209e09e00 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -45,6 +45,8 @@
 #include "hw/intc/riscv_aplic.h"
 #include "hw/intc/sifive_plic.h"
 #include "hw/misc/sifive_test.h"
+#include "hw/misc/riscv_rpmi.h"
+#include "hw/riscv/rpmi-fdt.h"
 #include "hw/core/platform-bus.h"
 #include "chardev/char.h"
 #include "system/device_tree.h"
@@ -101,6 +103,8 @@ static const MemMapEntry virt_memmap[] = {
     /* UART1 supports page isolation from UART0 */
     [VIRT_UART1] =        { 0x1000a000,         0x100 },
     [VIRT_FW_CFG] =       { 0x10100000,          0x18 },
+    [VIRT_RPMI_SHMEM] =   { 0x10200000,       0x20000 },
+    [VIRT_RPMI_DOORBELL] = { 0x10230000,        0x1000 },
     [VIRT_FLASH] =        { 0x20000000,     0x4000000 },
     [VIRT_IMSIC_M] =      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
     [VIRT_IMSIC_S] =      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
@@ -464,6 +468,40 @@ static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
     s->pci_iommu_bdf = bdf;
 }
 
+
+static RiscvRpmiConfig virt_rpmi_config(RISCVVirtState *s,
+                                        const uint32_t *hart_ids,
+                                        uint32_t hart_count)
+{
+    return (RiscvRpmiConfig) {
+        .doorbell_base = s->memmap[VIRT_RPMI_DOORBELL].base,
+        .shmem_base = s->memmap[VIRT_RPMI_SHMEM].base,
+        .shmem_size = s->memmap[VIRT_RPMI_SHMEM].size,
+        .a2p_req_size = VIRT_RPMI_A2P_REQ_SIZE,
+        .p2a_req_size = VIRT_RPMI_P2A_REQ_SIZE,
+        .platform_info = "QEMU RISC-V virt RPMI",
+        .hart_ids = hart_ids,
+        .hart_count = hart_count,
+    };
+}
+
+static void create_fdt_rpmi(RISCVVirtState *s, uint32_t *phandle,
+                            uint32_t msi_phandle)
+{
+    RiscvRpmiConfig rpmi_cfg = virt_rpmi_config(s, NULL, 0);
+    uint32_t rpmi_mbox_handle;
+    RiscvRpmiFdtMboxConfig cfg = {
+        .shmem_base = rpmi_cfg.shmem_base,
+        .doorbell_base = rpmi_cfg.doorbell_base,
+        .a2p_req_size = rpmi_cfg.a2p_req_size,
+        .p2a_req_size = rpmi_cfg.p2a_req_size,
+        .doorbell_size = s->memmap[VIRT_RPMI_DOORBELL].size,
+    };
+
+    riscv_rpmi_fdt_add_mbox(MACHINE(s)->fdt, &cfg, phandle,
+                            &rpmi_mbox_handle);
+}
+
 static void finalize_fdt(RISCVVirtState *s)
 {
     uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
@@ -500,6 +538,11 @@ static void finalize_fdt(RISCVVirtState *s)
                             s->memmap[VIRT_TEST].base,
                             s->memmap[VIRT_TEST].size,
                             FINISHER_RESET, FINISHER_PASS, true);
+    if (s->have_rpmi) {
+        create_fdt_rpmi(s, &phandle, msi_pcie_phandle);
+    } else {
+        create_fdt_reset(s, &phandle);
+    }
 
     create_fdt_uarts(s, irq_mmio_phandle);
 
@@ -733,6 +776,18 @@ static void virt_machine_init(MachineState *machine)
         exit(1);
     }
 
+
+    if (s->have_rpmi) {
+#ifndef CONFIG_LIBRPMI
+        error_report("RISC-V RPMI support is not compiled in");
+        exit(1);
+#else
+        if (kvm_enabled()) {
+            error_report("RISC-V RPMI support is not available with KVM");
+            exit(1);
+        }
+#endif
+    }
     /* Initialize sockets */
     mmio_irqchip = virtio_irqchip = pcie_irqchip = NULL;
     for (i = 0; i < socket_count; i++) {
@@ -891,6 +946,25 @@ static void virt_machine_init(MachineState *machine)
     /* SiFive Test MMIO device */
     sifive_test_create(s->memmap[VIRT_TEST].base);
 
+    if (s->have_rpmi) {
+        MachineClass *mc = MACHINE_GET_CLASS(machine);
+        const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(machine);
+        g_autofree uint32_t *rpmi_hart_ids =
+            g_new0(uint32_t, machine->smp.cpus);
+        RiscvRpmiConfig rpmi_cfg;
+        Error *local_err = NULL;
+
+        for (i = 0; i < machine->smp.cpus; i++) {
+            rpmi_hart_ids[i] = possible_cpus->cpus[i].arch_id;
+        }
+
+        rpmi_cfg = virt_rpmi_config(s, rpmi_hart_ids, machine->smp.cpus);
+        if (!riscv_rpmi_create(&rpmi_cfg, &local_err)) {
+            error_report_err(local_err);
+            exit(1);
+        }
+    }
+
     /* VirtIO MMIO devices */
     for (i = 0; i < VIRTIO_COUNT; i++) {
         sysbus_create_simple("virtio-mmio",
@@ -969,6 +1043,7 @@ static void virt_machine_instance_init(Object *obj)
 
     s->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     s->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
+    s->have_rpmi = false;
     s->acpi = ON_OFF_AUTO_AUTO;
     s->iommu_sys = ON_OFF_AUTO_AUTO;
     s->num_sources = VIRT_IRQCHIP_NUM_SOURCES;
@@ -1044,6 +1119,21 @@ static void virt_set_aclint(Object *obj, bool value, Error **errp)
     s->have_aclint = value;
 }
 
+
+static bool virt_get_rpmi(Object *obj, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
+
+    return s->have_rpmi;
+}
+
+static void virt_set_rpmi(Object *obj, bool value, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
+
+    s->have_rpmi = value;
+}
+
 bool virt_is_iommu_sys_enabled(RISCVVirtState *s)
 {
     return s->iommu_sys == ON_OFF_AUTO_ON;
@@ -1165,6 +1255,13 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "enable/disable emulating "
                                           "ACLINT devices");
 
+
+    object_class_property_add_bool(oc, "rpmi", virt_get_rpmi,
+                                   virt_set_rpmi);
+    object_class_property_set_description(oc, "rpmi",
+                                          "Set on/off to enable/disable "
+                                          "RISC-V RPMI devices");
+
     object_class_property_add_str(oc, "aia", virt_get_aia,
                                   virt_set_aia);
     object_class_property_set_description(oc, "aia",
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index e516898f9a..919a664bc2 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -55,6 +55,7 @@ struct RISCVVirtState {
 
     int fdt_size;
     bool have_aclint;
+    bool have_rpmi;
     RISCVVirtAIAType aia_type;
     int aia_guests;
     char *oem_id;
@@ -82,6 +83,8 @@ enum {
     VIRT_VIRTIO,
     VIRT_UART1,
     VIRT_FW_CFG,
+    VIRT_RPMI_SHMEM,
+    VIRT_RPMI_DOORBELL,
     VIRT_IMSIC_M,
     VIRT_IMSIC_S,
     VIRT_FLASH,
-- 
2.43.0


