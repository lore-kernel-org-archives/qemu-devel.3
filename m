Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC7EC79FA7
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Xft-0007zp-6b; Mon, 07 Sep 2026 07:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1x3Xfq-0007z8-QK
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:38:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1x3Xfo-0001j1-1t
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:38:06 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687An3ji3230474
 for <qemu-devel@nongnu.org>; Mon, 7 Sep 2026 11:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BcuMX8mUG+d
 sbQ6cqjgCndsKBhltgsCH1RoIWi0mIN4=; b=b9umomPbOLsXqPjulAmyiFUaELy
 rXfGo3+op26Yr38bUUxAXntsAU2PFkpaznGIRjum8CQ5E3/7LUWej+U0Fq3oTx0a
 /FRgMxHDj2mxdcWPQ9GiNtV0DRZGJMhbRpEL+nEE5RIywexvt/XG13NKYWHkjFpl
 44GVAu6nBOszmajbblbRmn6f39+W6yfIEdWyXxDotlqfghsx0KiNqFqrJgKHLBT7
 TWHptIoNjEqR+N7iGjVIc/X1B/lp6YTmE1Vcm79ZJqsB75RVWUzv4IRUKfe6WlIr
 +46a6Q5dO0+ONKZVjpjfQuKiAQKHuSno2lcR2dqvnw0a/O6K6z0sVoejIOA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghfxktgnn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 11:38:02 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-398d3a12589so854849a91.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 04:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788781081; x=1789385881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BcuMX8mUG+dsbQ6cqjgCndsKBhltgsCH1RoIWi0mIN4=;
 b=iAvXoaCAkkrK6v7kTkcGs1kKEd0fnqtfljvXqnaVttYHvBJxn480ZqptvILj5bvnHO
 m7DoG9x8PZijP/NmpkEYvQw8LSpsI2OVbLzv5yISzWvrOkf9JBqnBkrTz/6syCh8Fz/A
 h/mV+u5nBAOkKmnOwjNQHpj1voxX3aO+BPif56AIIp7TNhe1gtfLcsj64XXnWk+5/cum
 EGNX7xJRKMbI0EIQrZXnwo1ezEpHyFZreQ1M0SDgZke2BuHd0ugsI6ypEaCWm5Crytn7
 gAuQwGpkmIgd4H3hycTdxjJjSGTZIOL7arrVCXw306mUgpa6s36Y/18QuBUwjXINKksG
 ls6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788781081; x=1789385881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BcuMX8mUG+dsbQ6cqjgCndsKBhltgsCH1RoIWi0mIN4=;
 b=lEL2euDUjD1XM/FlR8bH2g5MttQbVARis9XPFMfixR6jpNNkEM6xZX0K0ueWAlsr2N
 P2wdHQHe+/txYfsdq0nHJZXJRtXTH2e5H0ssDVWK0agBv8Oc4fLev4kHOTupab/3OVla
 Ak0cSv/2+uRYYqj6ujBE1WcpT1q41iMGo4TDxm81/lH4+8vur4OUta2Jx+3SnidPWa03
 cpBiwPRaHDUM9BXuGJSXWCSZDbrhJ1V3z94oy1qOA5VhPTtnv34hqMhA0eGWN0oxEeiY
 ycMy1Fq2Y9LP8zeDlL6EGFcClmhKQy4Nxjb0MsoF2S9YISwNVkyCnEeDq/OBTKvrUR0J
 PJvQ==
X-Gm-Message-State: AFuF++kVD8Wyl2DuLmnGpkE82ug/7P+PMD9ihTonVDX5jZgAAJubUMBm
 9ERNpK9Z9d/lJzUbUA7dl8IV8zpjqwaiQDd+2pofQkPrgN6McFKhAqAex64RF9OMNhYJNxXCmUp
 /t76ObABj0lIzq6O6BWX77S/n8/RT/czqc5GnGx1xF7KuvzS7trGW02pRm6EXuFKWYg==
X-Gm-Gg: AYBFou3u9y3DIL29aDa/VJlTev1o4H/a8o9NtqGhu4Ptmns72MA+9SLlCG7kc+xMyYw
 Sev4S6QgYpTksDHwZ3tIm1A0c8UPGuDla/G/TCzMmpReUK019BVSvpjUQrAWcpKM7v7SRpvrPWI
 AnsxNMlk/FCOB9nmfMXUtF1yUppRhAS1+gBpPYxHbPv3wJT3qsbEqCnILu1ESBANOUrJKKRtVFG
 xCEiJ6td7zJGWUvjc7cGNy/Ud6jjQNC8cvUkEQCcl5Yhsg1tL5+ts4I1wNOuPF6Od46GUHwhZ45
 k0iGTTG/2wTi+gRGU/+8F3lldwrlproIRYEhuBEu81kDZ35Hb8i4HmZIDZp+1ygg+k29+ogZS/G
 biAGCddvg0XgI3+BmAK9dtgXFVvMwsSR/L+LXkM2dgmLL05ElfSDy4/olsfSMI8fO0zNU/1aSZo
 F91ZiJKKYRLyLHk0DxGAgfVhHBOMYeK4A=
X-Received: by 2002:a17:90b:4c03:b0:398:bac7:72d0 with SMTP id
 98e67ed59e1d1-39b3d86acf2mr14261639a91.5.1788781081202; 
 Mon, 07 Sep 2026 04:38:01 -0700 (PDT)
X-Received: by 2002:a17:90b:4c03:b0:398:bac7:72d0 with SMTP id
 98e67ed59e1d1-39b3d86acf2mr14261577a91.5.1788781080614; 
 Mon, 07 Sep 2026 04:38:00 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33517b57ac8sm17169507eec.28.2026.09.07.04.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 04:38:00 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v1 1/2] hw/riscv: add RPMI support for server reference
 platform
Date: Mon,  7 Sep 2026 17:07:14 +0530
Message-ID: <20260907113715.1219775-2-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907113715.1219775-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260907113715.1219775-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEyOCBTYWx0ZWRfX9Z8+HdkRnCb3
 rMKxa5Qbap41/n4ebj3ZnO0dAl1Kp8hEayStLbkqNvEtH650sjK1qGPbcAPUp+Jj8S3hLj1/MB4
 U8i1hWCJBY3i7HdvJG9s5+MWf/byOIIq4M0rYmVaQFORmivTEp1MEASsb87hBDO5/uXaR+10qtR
 4/5xhmC1G94WX3uax8JrI639wi0iy3bRV/ZfAa8nQTxBn+xVcrxLlf02pHbJ2UcFYsPwgw1Ra1X
 fX+vuKT/g8tWSCPsxciNMu4dLfmghcypZ7dYl8Zn3jv4R+qC1voIEbjE3ZonWN9OxxDVxXUT7UT
 GX1UHf3tXL6lA7kYMocxgLe7ut3FwbOD70BlAZB88wfSO4PfGPwAJrMQx+xIlbhj0aAGSf9O4DK
 WjnIw3W1QrmwNltiwYkWICv3UuWvmYhlmTp7umn52ZEpMLeI8fF7O1BNGaOZdkLOjGmKVh13D6z
 bPYCxcX4rJDwtO9yDhQ==
X-Proofpoint-GUID: FreN1kKJgli95xP4mPVXW-AtpsvgU_iD
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEyOCBTYWx0ZWRfXybKMGcD0t+0h
 1cupCzqbESBQbrOY9o0APN9da8YnX/4XUvylT8cwV+2iEpaW3n4N8mKYR9Z8sK+RQIiDv8Q5bwo
 oQe+p/2LUi/gyaYy/qiZG9ao27176uc=
X-Authority-Analysis: v=2.4 cv=daOwG3Xe c=1 sm=1 tr=0 ts=6a9ea21a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=NEAV23lmAAAA:8
 a=NLiCwHATAAAA:8 a=V1jnuoLLAAAA:20 a=EUspDBNiAAAA:8 a=916E8NSIVdlGVQu2ioMA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=F9tHCgz3TLBaZgltkx5D:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: FreN1kKJgli95xP4mPVXW-AtpsvgU_iD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070128
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Wire the common RISC-V RPMI device into the riscv-server-ref machine so
firmware can discover platform management services through the generated
device tree. The board exposes RPMI unconditionally when QEMU is built
with librpmi support and does not provide an rpmi=on|off machine option.

Advertise Base, System Reset, HSM, and System Suspend service groups for
the board. Reset, shutdown, hart management, and suspend requests are
routed through the shared RPMI implementation and server-ref machine
callbacks. When RPMI is available, omit the legacy syscon reboot and
poweroff nodes so firmware uses RPMI for those operations.

Keep riscv-server-ref buildable when librpmi is not available. In that
case the board boots without RPMI support, configure reports a warning,
and the machine emits a runtime warning.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 docs/system/riscv/riscv-server-ref.rst |  41 +++++++
 hw/riscv/Kconfig                       |   1 +
 hw/riscv/server_platform_ref.c         | 146 ++++++++++++++++++++++++-
 meson.build                            |   4 +
 4 files changed, 190 insertions(+), 2 deletions(-)

diff --git a/docs/system/riscv/riscv-server-ref.rst b/docs/system/riscv/riscv-server-ref.rst
index 0573b4e07c..22b215223e 100644
--- a/docs/system/riscv/riscv-server-ref.rst
+++ b/docs/system/riscv/riscv-server-ref.rst
@@ -25,6 +25,7 @@ The main features included in the riscv-server-ref board are:
 * No fw_cfg device
 * No ACPI table
 * Minimal device tree nodes
+* RISC-V RPMI platform management
 
 There are multiple ways of using this reference board.  The spec compliant way
 is using an EDK2 image and a TPM device.  The board was tested with the TPM
@@ -57,6 +58,46 @@ And then start QEMU with:
      -device tpm-tis-device,tpmdev=tpm0 \
      -nographic
 
+RPMI support
+------------
+
+The ``riscv-server-ref`` machine always exposes RISC-V RPMI platform management
+when QEMU is built with librpmi support.  There is no ``rpmi=on|off`` machine
+option for this board.  If QEMU is built without librpmi, the board still boots
+without RPMI and reports a warning.
+
+The initial ``riscv-server-ref`` RPMI implementation exposes Base, System
+Reset, HSM, and System Suspend service groups.  System Reset handles guest
+shutdown and cold reboot requests through RPMI.
+HSM uses the machine hart IDs for hart discovery, status, start, stop, and
+suspend commands.  System Suspend uses QEMU's suspend and wakeup path.
+
+When RPMI is compiled in, the generated device tree advertises reset, shutdown,
+HSM, and suspend through RPMI service nodes.  The legacy syscon reboot and
+poweroff nodes are omitted so firmware routes reset and shutdown through the
+RPMI System Reset service.  Without RPMI support, the generated device tree uses
+the legacy syscon reboot and poweroff nodes.  RPMI is currently described
+through FDT only; this machine does not emit ACPI tables for the RPMI transport
+or service groups.
+
+RPMI support targets the RISC-V Platform Management Interface (RPMI)
+Specification v1.0 Ratified (`server-ref RPMI v1.0 specification`_).  The
+build dependency is provided by `server-ref librpmi`_.  After installing
+librpmi, configure QEMU with ``--enable-librpmi`` or ``-Dlibrpmi=enabled`` to
+make the build fail if librpmi is unavailable.
+
+.. code-block:: bash
+
+ qemu-system-riscv64 -M riscv-server-ref \
+     -bios fw_dynamic.bin \
+     -kernel EDK2.fd \
+     -drive file=nvme_disk.ext2,format=raw,id=hd0,if=none \
+     -device ahci,id=ahci \
+     -device ide-hd,drive=hd0,bus=ahci.0 \
+     -nographic
+
 
 .. _spec: https://github.com/riscv-non-isa/riscv-server-platform
 .. _tpm: https://qemu-project.gitlab.io/qemu/specs/tpm.html
+.. _server-ref RPMI v1.0 specification: https://github.com/riscv-non-isa/riscv-rpmi/releases/download/v1.0/riscv-rpmi.pdf
+.. _server-ref librpmi: https://github.com/riscv-software-src/librpmi
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index e147c830be..ee87be1d2a 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -85,6 +85,7 @@ config RISCV_SERVER_PLATFORM_REF
     select RISCV_APLIC
     select RISCV_IMSIC
     select RISCV_IOMMU
+    select RISCV_RPMI if LIBRPMI
 
 config SHAKTI_C
     bool
diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
index 4d27dcd6c0..97a191de65 100644
--- a/hw/riscv/server_platform_ref.c
+++ b/hw/riscv/server_platform_ref.c
@@ -30,18 +30,20 @@
 #include "hw/riscv/fdt-common.h"
 #include "hw/riscv/machines-qom.h"
 #include "hw/riscv/numa.h"
+#include "hw/riscv/rpmi-fdt.h"
 #include "hw/riscv/iommu.h"
 #include "hw/riscv/riscv-iommu.h"
 #include "hw/riscv/riscv-iommu-bits.h"
+#include "hw/misc/riscv_rpmi.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/riscv_aplic.h"
 #include "hw/intc/riscv_imsic.h"
 #include "chardev/char.h"
 #include "hw/char/serial-mm.h"
 #include "system/device_tree.h"
+#include "system/kvm.h"
 #include "system/runstate.h"
 #include "system/system.h"
-#include "system/kvm.h"
 #include "system/tcg.h"
 #include "kvm/kvm_riscv.h"
 #include "system/tpm.h"
@@ -70,6 +72,9 @@
 
 #define RVSERVER_PLATFORM_BUS_NUM_IRQS 8
 
+#define RVSERVER_RPMI_A2P_REQ_SIZE (16 * RPMI_QUEUE_SLOT_SIZE)
+#define RVSERVER_RPMI_P2A_REQ_SIZE 0
+
 #define TYPE_RISCV_SERVER_REF_MACHINE MACHINE_TYPE_NAME("riscv-server-ref")
 OBJECT_DECLARE_SIMPLE_TYPE(RISCVServerRefMachineState, RISCV_SERVER_REF_MACHINE)
 
@@ -96,6 +101,8 @@ enum {
     RVSERVER_RESET_SYSCON,
     RVSERVER_RTC,
     RVSERVER_IOMMU_SYS,
+    RVSERVER_RPMI_SHMEM,
+    RVSERVER_RPMI_DOORBELL,
     RVSERVER_ACLINT,
     RVSERVER_APLIC_M,
     RVSERVER_APLIC_S,
@@ -147,6 +154,8 @@ static const MemMapEntry rvserver_ref_memmap[] = {
     [RVSERVER_RESET_SYSCON] =   {   0x100000,        0x1000 },
     [RVSERVER_RTC] =            {   0x101000,        0x1000 },
     [RVSERVER_IOMMU_SYS] =      {   0x102000,        0x1000 },
+    [RVSERVER_RPMI_SHMEM] =     {   0x110000,       0x20000 },
+    [RVSERVER_RPMI_DOORBELL] =  {   0x140000,        0x1000 },
     [RVSERVER_ACLINT] =         {  0x2000000,       0x10000 },
     [RVSERVER_PCIE_PIO] =       {  0x3000000,       0x10000 },
     [RVSERVER_PLATFORM_BUS] =   {  0x4000000,     0x2000000 },
@@ -287,12 +296,107 @@ static void create_fdt_sockets(RISCVServerRefMachineState *s,
     riscv_socket_fdt_write_distance_matrix(ms);
 }
 
+#ifdef CONFIG_LIBRPMI
+static const RiscvRpmiServiceConfig rvserver_ref_rpmi_services[] = {
+    {
+        .node_name = "sysreset",
+        .compatible = "riscv,rpmi-system-reset",
+        .service_group = RPMI_SRVGRP_SYSTEM_RESET,
+    },
+    {
+        .node_name = "hsm",
+        .compatible = "riscv,rpmi-hsm",
+        .service_group = RPMI_SRVGRP_HSM,
+    },
+    {
+        .node_name = "suspend",
+        .compatible = "riscv,rpmi-system-suspend",
+        .service_group = RPMI_SRVGRP_SYSTEM_SUSPEND,
+    },
+};
+
+static void rvserver_ref_rpmi_system_reset(void)
+{
+    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+}
+
+static void rvserver_ref_rpmi_system_shutdown(void)
+{
+    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+}
+
+static void rvserver_ref_rpmi_system_suspend(void)
+{
+    qemu_system_suspend_request();
+}
+
+static void rvserver_ref_rpmi_register_wakeup_support(void)
+{
+    qemu_register_wakeup_support();
+}
+
+static bool rvserver_ref_rpmi_system_can_resume(void)
+{
+    return runstate_check(RUN_STATE_RUNNING);
+}
+
+static const RiscvRpmiMachineOps rvserver_ref_rpmi_machine_ops = {
+    .system_reset = rvserver_ref_rpmi_system_reset,
+    .system_shutdown = rvserver_ref_rpmi_system_shutdown,
+    .system_suspend = rvserver_ref_rpmi_system_suspend,
+    .register_wakeup_support = rvserver_ref_rpmi_register_wakeup_support,
+    .system_can_resume = rvserver_ref_rpmi_system_can_resume,
+};
+
+static RiscvRpmiConfig rvserver_ref_rpmi_config(
+    RISCVServerRefMachineState *s, const uint32_t *hart_ids,
+    uint32_t hart_count)
+{
+    return (RiscvRpmiConfig) {
+        .doorbell_base = s->memmap[RVSERVER_RPMI_DOORBELL].base,
+        .shmem_base = s->memmap[RVSERVER_RPMI_SHMEM].base,
+        .shmem_size = s->memmap[RVSERVER_RPMI_SHMEM].size,
+        .a2p_req_size = RVSERVER_RPMI_A2P_REQ_SIZE,
+        .p2a_req_size = RVSERVER_RPMI_P2A_REQ_SIZE,
+        .platform_info = "QEMU RISC-V server-ref RPMI",
+        .machine_ops = &rvserver_ref_rpmi_machine_ops,
+        .hart_ids = hart_ids,
+        .hart_count = hart_count,
+        .services = rvserver_ref_rpmi_services,
+        .service_count = ARRAY_SIZE(rvserver_ref_rpmi_services),
+    };
+}
+
+static void create_fdt_rpmi(RISCVServerRefMachineState *s, uint32_t *phandle)
+{
+    RiscvRpmiConfig rpmi_cfg = rvserver_ref_rpmi_config(s, NULL, 0);
+    uint32_t rpmi_mbox_handle;
+    RiscvRpmiFdtMboxConfig cfg = {
+        .shmem_base = rpmi_cfg.shmem_base,
+        .doorbell_base = rpmi_cfg.doorbell_base,
+        .a2p_req_size = rpmi_cfg.a2p_req_size,
+        .p2a_req_size = rpmi_cfg.p2a_req_size,
+        .doorbell_size = s->memmap[RVSERVER_RPMI_DOORBELL].size,
+    };
+
+    riscv_rpmi_fdt_add_mbox(MACHINE(s)->fdt, &cfg, phandle,
+                            &rpmi_mbox_handle);
+
+    for (uint32_t i = 0; i < rpmi_cfg.service_count; i++) {
+        riscv_rpmi_fdt_add_service_node(MACHINE(s)->fdt, rpmi_cfg.shmem_base,
+                                        &rpmi_cfg.services[i],
+                                        rpmi_mbox_handle);
+    }
+}
+#endif
+
 static void finalize_fdt(RISCVServerRefMachineState *s)
 {
     uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
     uint32_t irq_pcie_phandle = 1, iommu_sys_phandle;
     g_autofree char *name = NULL;
     MachineState *ms = MACHINE(s);
+    bool create_reset_nodes = true;
 
     create_fdt_sockets(s, rvserver_ref_memmap, &phandle, &irq_mmio_phandle,
                        &irq_pcie_phandle, &msi_pcie_phandle);
@@ -311,10 +415,16 @@ static void finalize_fdt(RISCVServerRefMachineState *s)
                           irq_pcie_phandle, msi_pcie_phandle,
                           iommu_sys_phandle, RVSERVER_PCIE_IRQ);
 
+#ifdef CONFIG_LIBRPMI
+    create_fdt_rpmi(s, &phandle);
+    create_reset_nodes = false;
+#endif
+
     riscv_create_fdt_syscon(ms->fdt, &phandle,
                             rvserver_ref_memmap[RVSERVER_RESET_SYSCON].base,
                             rvserver_ref_memmap[RVSERVER_RESET_SYSCON].size,
-                            SYSCON_RESET, SYSCON_POWEROFF, false, true);
+                            SYSCON_RESET, SYSCON_POWEROFF, false,
+                            create_reset_nodes);
 
     riscv_create_fdt_uart(ms->fdt, &rvserver_ref_memmap[RVSERVER_UART0],
                           RVSERVER_UART0_IRQ, AIA_TYPE_APLIC_IMSIC,
@@ -523,6 +633,13 @@ static void rvserver_ref_machine_init(MachineState *machine)
 
     s->memmap = rvserver_ref_memmap;
 
+#ifdef CONFIG_LIBRPMI
+    if (kvm_enabled()) {
+        error_report("RISC-V RPMI support is not available with KVM");
+        exit(1);
+    }
+#endif
+
     /* Initialize sockets */
     mmio_irqchip = pcie_irqchip = NULL;
     for (i = 0; i < socket_count; i++) {
@@ -604,6 +721,31 @@ static void rvserver_ref_machine_init(MachineState *machine)
                                 memmap[RVSERVER_RESET_SYSCON].base,
                                 reset_syscon_io);
 
+#ifdef CONFIG_LIBRPMI
+    {
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
+        rpmi_cfg = rvserver_ref_rpmi_config(s, rpmi_hart_ids,
+                                            machine->smp.cpus);
+        if (!riscv_rpmi_create(&rpmi_cfg, &local_err)) {
+            error_report_err(local_err);
+            exit(1);
+        }
+    }
+#else
+    warn_report("riscv-server-ref: RPMI support is not compiled in; "
+                "booting without RPMI");
+#endif
+
     gpex_host = riscv_gpex_pcie_init(system_memory, pcie_irqchip,
                                      &rvserver_ref_memmap[RVSERVER_PCIE_ECAM],
                                      &rvserver_ref_memmap[RVSERVER_PCIE_MMIO],
diff --git a/meson.build b/meson.build
index 1e1e19e655..00584d0eba 100644
--- a/meson.build
+++ b/meson.build
@@ -3423,6 +3423,10 @@ foreach target : target_dirs
     foreach k, v: config_devices
       config_devices_data.set(k, 1)
     endforeach
+    if target == 'riscv64-softmmu' and get_option('default_devices') and \
+       not librpmi.found()
+      warning('riscv-server-ref machine will be built without RPMI support; install librpmi and configure with --enable-librpmi to enable RPMI')
+    endif
     config_devices_mak_list += config_devices_mak
     config_devices_h += {target: configure_file(output: target + '-config-devices.h',
                                                 configuration: config_devices_data)}
-- 
2.43.0


