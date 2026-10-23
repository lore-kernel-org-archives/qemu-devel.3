Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3620D606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TxzpJRS2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gIdA2h00
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHq5-0000dS-DN; Fri, 23 Oct 2026 12:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKHq1-0000ct-NJ
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:09:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xKHpj-0001Ts-FJ
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:09:35 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG3okw3811881
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=W1uOu9Yvs0L
 HCsnnPQSnHDv3YzrhA3fkZ0uCqoasB/0=; b=TxzpJRS2w6CoVK8gD51rZrQauYm
 zywcuCYNedXpg8X8fIRHZIqdthPlrkyNHxe0jdzqVhGcfcuAEzN43BA14/0G9pq7
 5CPuXd8++HrTq6gQqbblwiqWJzg9fAScPmLhYinG835ubtdxPymLYX04B+1aC5bm
 ykGDyGnflBO7bM3H02k/ihxUcwZgIEYgr/pUT8xdN9NpIEcRybAUaHt7YTurnCvM
 osx6jcLQ8HSs/2IjL95+bIhuw0UBRzRjNPDbIid65OuDCLua1upGKLm2/OcMAVt5
 So6RovlU1VnVFvUcthNMiXIlzJ20Ve59cnjevvQOhkKuxR1EIgTlT1+mxvw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgas880t8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:09:22 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91bc57d4d11so26626856d6.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792771762; x=1793376562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W1uOu9Yvs0LHCsnnPQSnHDv3YzrhA3fkZ0uCqoasB/0=;
 b=gIdA2h00dhf632vHuRwOJp1U6iiwmdkOSWYW7OFWVKBo4sqNsFoqratDohQ1j8+kNO
 CHITuRLRrya1mMDK8NTatSagiIsbt2vhF0UkIifWx4Dx2RKD+b5VoTcsX5t4CTEld3/H
 Ba+WjtBNXK2nwvLVnKK15Q+0MlBcBiYU4gLhHMF+eptGupi8sXdDhxb4Mf58XIY4xp7k
 rDmgpF7PUT6Npj4SAhsrstoI7JCTP1tzocRTEqGxaJpO7onAXtfWCjUbZyWn7xALqUaP
 2+6bi0bctyjevTRTZGV/1xmYABHPB+uLIlyDro22t9s4qLhlGbPEiiiyV15EID5FTp10
 PPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792771762; x=1793376562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=W1uOu9Yvs0LHCsnnPQSnHDv3YzrhA3fkZ0uCqoasB/0=;
 b=PcXQRz6LTh3RuLR19CTfUjlaAw7HCV02gElUgprxztPJMdoh1KaOws5Igypk6Q2jme
 CbflSwTYjjxX4IdwtYcMNG5+stqmT2LtjlpDR4ITuD0dLd0eEp+/pi3O005wcO2kb2nL
 n4GySCUwCxU0FhdydeZmENnQ4Rw5rbRXdfju/395YFtguBL+vx4pBBWdmf2oNkVGGgLk
 5xTVsmye4BtjDvOpV27t/xdARQfWtoKVd95lq4b3WQmtRewE+3GXLfsaSrqLYVBmq+7T
 YWhu3g27SwhP8shgUsOPJ8JyOnZGaTOmvpzE0t2nt3QsvrsaszIfwRio7KQ+IimoF0av
 9pvg==
X-Gm-Message-State: AFq9FYL21n9Ym7lPbHULBx4SHzODaEiFE9vuX8o+CpEP5SPgQvpeyfGB
 gwKs99VASi0JOvw1RAg/NqDOs1XVL7Jl30S2ZXMIsVe9lDC02m0YpLsqFuPP8VwMlTxufneelhH
 O106/yqSRHT2XbSinfxkzIcgqKl/Q5vGyWdZ0ziLqFrayb57aWQ5LmYWbbA5D3WWf1A==
X-Gm-Gg: AYBFou0diIaAT6B55ZZONDf2t1krm2+kKWPM6Chy0Am14JPEvA/lFvF7ZP8Eymhs4nk
 8PRnSQoLJPvzvURsqQifUB4cWIceqPwqZ1c52+E8XZcQUG942Lgion3S+F11DefeXsyp0PAOdsH
 0OugYDYFpxQnPUK3jtG9G3C5NBNUmp5nRcG74irjer4pGFKxjJOeUIbrLwuBV01OxUdGANPYC4q
 kb2vXUdE86qIorglnOq5b1NoluERoxuFJBzy2HPeOFfasV8fSqsg7CPMK4xGG3b/0uZJuFJ5fZG
 gX+/qbE7hFfwx0CktYrwnP1dLuxIH29gbZ9GNCudgT67k1tHxSMhAJsvm04nvTjhajCYcu1FqNZ
 t+kks4rM0uKisMte/Zi0xQgOvSw9M6Fj3BO0GUA==
X-Received: by 2002:a05:6214:29e6:b0:917:a615:3741 with SMTP id
 6a1803df08f44-91c3a8a52femr40172966d6.32.1792771762399; 
 Fri, 23 Oct 2026 09:09:22 -0700 (PDT)
X-Received: by 2002:a05:6214:29e6:b0:917:a615:3741 with SMTP id
 6a1803df08f44-91c3a8a52femr40172346d6.32.1792771761915; 
 Fri, 23 Oct 2026 09:09:21 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([152.234.125.162])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c4524f226sm5063406d6.27.2026.10.23.09.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 09:09:21 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 1/6] hw/riscv: do not realize the device in
 riscv_create_iommu_sys()
Date: Fri, 23 Oct 2026 13:09:08 -0300
Message-ID: <20261023160913.24992-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023160913.24992-1-daniel.barboza@oss.qualcomm.com>
References: <20261023160913.24992-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfXyRaAYdq7LneB
 tLV9sh+Q0oAb84SATx/iGk1w1Lg6S1rxY9D0WWaxVybW7pbozBnHyLZGuw6GeEc9EPO/ptx8bLU
 zH2RhnYL2KRj0f73cAA2sOOB4xT9V0M=
X-Authority-Analysis: v=2.4 cv=OPqyTiaB c=1 sm=1 tr=0 ts=6adb86b3 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=AgQEunjic7gIBKSbIeB6Ag==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=vAOAkzTg_3GT8N5SIgEA:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfX5sDEPfz06Jkh
 Lis+LCGY34bSsTCnxYoAtN99qGzibsy4EaLyxH1fAEij9su+kYXZcrn+sVYgq6Fv8CpTu/t9MFR
 W3X1qh9WhLAKebQycru/GBln07CPEpX6hC5P1X9Kyvkm0rZac3SlI6Ur6ULca1Yp7Oj7t/A8Rcf
 0dxIErxDOeyJiKCKkYUwl3n8sSb2qH0cCLDmwJaxwpqJOKxGlUfUwrlbyvS6RyAoiPWcs7Guy2+
 VWERWsO0VnIQiVbsE6hlxNCKh7JfidmD8w8GtY6f5SiDT1GJx3yZeg+mG3uhbK9z0dsVykYw4r9
 dI/kls/Vy1RDfZEk0kfP+/pyykjixbZN4wvYVFEWElGxpF8/jBnYMOQM1hPBc+pwuvC13bPU0Ud
 M+gmM48/yr6aG/EWRa4l7SQz4J+QIKRt/7j9UixsQfg1UxYNZm9HuFlVrdWQ8rxbM4/At/dg52E
 5rfCeBdvKTUPw23dTqA==
X-Proofpoint-GUID: PLQQLW8kpY3e3zozlDafIt3Olgm-kYBt
X-Proofpoint-ORIG-GUID: PLQQLW8kpY3e3zozlDafIt3Olgm-kYBt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230062
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The riscv-iommu-sys device inherits all properties from its associated
riscv-iommu device via qdev_alias_all_properties() during sys_init().

We're also providing riscv_create_iommu_sys(), a helper to instantiate
the device and avoid duplicating code between boards.  In its current
state the helper is realizing the device before returning it to the
caller, prevents any additional setup of the device (we can't change
device props after realize).

Split the realization code from the helper and make the boards realize
the device manually.  It's a small inconvenience to pay to be able to
config the iommu-sys device.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/riscv-iommu-sys.c     | 3 +--
 hw/riscv/server_platform_ref.c | 7 +++++--
 hw/riscv/virt.c                | 9 +++++++--
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
index 258c171efd..190ab0b646 100644
--- a/hw/riscv/riscv-iommu-sys.c
+++ b/hw/riscv/riscv-iommu-sys.c
@@ -217,6 +217,7 @@ static void riscv_iommu_sys_init(Object *obj)
     riscv_iommu_set_cap_igs(iommu, RISCV_IOMMU_CAP_IGS_BOTH);
 }
 
+/* Note: the returned iommu_sys device needs to be realized.  */
 DeviceState *riscv_create_iommu_sys(DeviceState *mmio_irqchip,
                                     hwaddr addr, int base_irq,
                                     bool is_32_bit)
@@ -237,8 +238,6 @@ DeviceState *riscv_create_iommu_sys(DeviceState *mmio_irqchip,
                              is_32_bit ? 34 : 56,
                              &error_fatal);
 
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu_sys), &error_fatal);
-
     return iommu_sys;
 }
 
diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
index 5f485b1c79..e9536515da 100644
--- a/hw/riscv/server_platform_ref.c
+++ b/hw/riscv/server_platform_ref.c
@@ -481,6 +481,7 @@ static void rvserver_ref_machine_init(MachineState *machine)
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     MemoryRegion *reset_syscon_io = g_new(MemoryRegion, 1);
     DeviceState *mmio_irqchip, *pcie_irqchip;
+    DeviceState *iommu_sys;
     int i, base_hartid, hart_count;
     int socket_count = riscv_socket_count(machine);
     int imsic_bits;
@@ -635,8 +636,10 @@ static void rvserver_ref_machine_init(MachineState *machine)
         create_fdt(s, memmap);
     }
 
-    riscv_create_iommu_sys(mmio_irqchip, s->memmap[RVSERVER_IOMMU_SYS].base,
-                           IOMMU_SYS_IRQ, false);
+    iommu_sys = riscv_create_iommu_sys(mmio_irqchip,
+                                       s->memmap[RVSERVER_IOMMU_SYS].base,
+                                       IOMMU_SYS_IRQ, false);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu_sys), &error_fatal);
 
     s->machine_done.notify = rvserver_ref_machine_done;
     qemu_add_machine_init_done_notifier(&s->machine_done);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d4b501802f..39381cb21d 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -940,8 +940,13 @@ static void virt_machine_init(MachineState *machine)
     }
 
     if (virt_is_iommu_sys_enabled(s)) {
-        riscv_create_iommu_sys(mmio_irqchip, s->memmap[VIRT_IOMMU_SYS].base,
-                               IOMMU_SYS_IRQ, riscv_is_32bit(&s->soc[0]));
+        DeviceState *iommu_sys;
+
+        iommu_sys = riscv_create_iommu_sys(mmio_irqchip,
+                                           s->memmap[VIRT_IOMMU_SYS].base,
+                                           IOMMU_SYS_IRQ,
+                                           riscv_is_32bit(&s->soc[0]));
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu_sys), &error_fatal);
     }
 
     s->machine_done.notify = virt_machine_done;
-- 
2.43.0


