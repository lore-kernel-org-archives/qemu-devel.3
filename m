Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D63606A326
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cajF5kSe;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TzHQbChP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLKhS-00048w-Ee; Mon, 26 Oct 2026 09:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xLKhQ-00046H-9m
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 09:25:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xLKhN-0005Ni-Lp
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 09:25:16 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAt1dU3562064
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 13:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=fF7ht9niLWg
 Yty8Au2TirlSo8VTaUpELxm0BJGCb1Ms=; b=cajF5kSee7nknd4AgpemWAOAtGm
 vgksD6j7q3GcTFXiOq+oFeyJQ1y54Ll7vNpdQPaTCC3fenc2KWlvGKw+w3UmI0dm
 LHA3f9Ye1Pb4NFRB1Bt41MkOCZOctOeI9bkATdgNC5v7FcaNc7NlYRmBuTq9C9c9
 ZiZKtHweKl1dyaZQyFm2A0ZMbKBlKSeeBcnTKMrb8n+ylz+CEt2svBoK03dTL35E
 a9SqFgJghjzmNRC2XbcIpUTmzDzrmXDgWtjgYjBBllLIvRFDkCXnE9PXWXlvWveu
 R0LbRArKiJuuBbLAW5dy3o0MFu432kGymt/hZIun6D7pUR98gvm4rDjpMEg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4s90s8x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 13:25:12 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35179e7f081so329932eec.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 06:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793021112; x=1793625912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fF7ht9niLWgYty8Au2TirlSo8VTaUpELxm0BJGCb1Ms=;
 b=TzHQbChPMegBJ2n1p6Mk6gH4+r/tGbRZtmgIiV9OjZxGtwUoi6WtkdwZN6+SakAnwW
 9imuZ95GwYMKDZgao79n+TPcuJRUMkmZSDCb4cz4/uEtvt9oskrRvGFvEHvlOLwaTRY/
 3fKnUuBF+DjtRW9k+3hDcgZekhb6Lpvr7s0t62FPDmWQ2JXprMsuFQJKmkDjN2pDDsTT
 XhAgoUiRVkPm7vZYeApn4sr2eFaM446IdLNWzxZk/kTLKUH/Mj3XSZTuWNcjLIZER1x4
 WVEjyE1gRdu0MEouLHUUGwT/eH+2TrWWjxaPCAWrspzx0bOkxByRC7GwaaNMthbc7NLW
 qtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793021112; x=1793625912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fF7ht9niLWgYty8Au2TirlSo8VTaUpELxm0BJGCb1Ms=;
 b=1NnTNLLX2IPXzKAyXidJ+P+G1MCUguy24GJs3V4KytAf5XzrP4S9S2zKT06xPkU9ii
 0/tQUR0HxaHBqolPggqcd23+qmmMagucydMYR1aYLz3QRC3t0Ae6cp56GeSRWbu1hXxa
 z9CHvBEloAyLVSBCq+Vv71NOJrRVJUGyBABgVDULRY2wEYc+AssWZxooZ/JLEwv1LSLR
 eunx+VqBaOB+xmHtcpibKZBLTCCsG9TORl8k/gkLKSWXXk9aRVOfZgor7hqKLo68pMuY
 q7LpF9tStTGWybE+2Ebd0iamS57rFpyUTha/XkjWG2WUd9pzCamPO5ajrRAODz2vpTtk
 +hKg==
X-Gm-Message-State: AFq9FYIBQHOw8fxxms1ow7hn4Z7rihVzo2D1Saz86uLzQVToDqBBgX2T
 HMGynacKn1hwt1DHzv+EHCfpywV/S5GWtlT71ulclWQvjk8ggEjEwllTEFIHWzJTWvV+eoNe0x8
 f+Tdre2Ye6nR7zCA2Ga13i1CMmULsgodD/wWtG83jp3uc5t7vQgMxdWeIDXQb8P0lcg==
X-Gm-Gg: AYBFou3Kw3dKgddAX12PY9EEtirIsoJhobQLId/Sb4gRJgW07acmOfyq+NuUTosohvt
 q2sDAdcwJY0dgVpuVmpDCh279d4ytyHCRm5OEVzoOdQreCxLKqbjUzzofLt2RojdpxrIHoFBBRj
 3HPvm2tdGlW18G6czUg0m56Cn5ZjdwseDlvVhQRwUU/Le1va4VpT4hAYUtJVWB+ZjX/5lPSB0sS
 54PPAdJrfZ6+NGUFyrPrloX7/4QpkDb30x2CISMBxnTksrCKDv11M0RjEskPQZj5xFtqgmLZXjP
 YsX830vcS9kKD+TkDNwyMwLIvj95IoOOjzpFn5/lxRVJ9TuNmRNT5vgAqYdVsPPFPRQGTYeqGw6
 MoFbM7Ipyt7kNeqZT2tPyzMoJSIIysWhnSi2JaQ+tbzum3N0gt87OTw+QqliV+EciaNaNgwEK6c
 f7BIWjJk2z/AuGrQqeqyz0gJK6YeOwAA==
X-Received: by 2002:a05:7301:4288:b0:351:6d7f:e2bc with SMTP id
 5a478bee46e88-369e84220bdmr16090992eec.2.1793021111007; 
 Mon, 26 Oct 2026 06:25:11 -0700 (PDT)
X-Received: by 2002:a05:7301:4288:b0:351:6d7f:e2bc with SMTP id
 5a478bee46e88-369e84220bdmr16090927eec.2.1793021110010; 
 Mon, 26 Oct 2026 06:25:10 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8db450bsm24312725eec.17.2026.10.26.06.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 06:25:09 -0700 (PDT)
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
Subject: [PATCH v2 1/2] hw/riscv: add RPMI support for server reference
 platform
Date: Mon, 26 Oct 2026 18:54:48 +0530
Message-ID: <20261026132450.2697115-2-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026132450.2697115-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20261026132450.2697115-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1MyBTYWx0ZWRfXyW/op60f+Wun
 2zD1rtjMiSJETinE6KRApU8zFqR8bn1jeZ8fIdhP3BZapdRnsPWvA7ABkwv3Hl//BYVjNRr4lpI
 NMwNRKVyqTZRyDGLdnXvueoNwbSkRHFNDQtGe0gigW4g2E4bvfeXXOlwlqUvB3lFlIFFvZoFGEO
 Qigbb560W1I869nfMIern/d2xD1r/juNVm/A5b+MyuFijSOF0hG7uY07aiC67URe4BwMJTm6iU3
 us5pjnif9/R8GkufpFDe/v9aIeUGPQQHny0kMAolunM8clZl2ogC39yX1bfxY0i0FcglPbuu3Re
 H8K3oZG92QseijWxv/5T7+VW0VbiIAgJqFafs4j8d8m1EsG/nYekjQHgqGiKkoeNK6iy+un1byZ
 T5n34p21L6c4KuwpKjp+od1R6hqhXcGgna6iP4EC77ywXVR8L87gkLHSo7hkIqTgZc+Ech74P9Y
 Y7QBVtre82tLbYB0OcQ==
X-Proofpoint-ORIG-GUID: 46kfB8M5-lB6u5H8cIV4gfuMLLynkh68
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1MyBTYWx0ZWRfX3WzTJIuvDxix
 nJXiypRKy7IDCdxHMDODDGwCIPEleXmpqh08zxw2i0aZ/pwOqnCLdFJB6Y30UnaQvjnvgH/ZZFD
 dxbAl6XWSY/Q7z29fdImJjz/MYYwd8I=
X-Proofpoint-GUID: 46kfB8M5-lB6u5H8cIV4gfuMLLynkh68
X-Authority-Analysis: v=2.4 cv=HKhWhYtv c=1 sm=1 tr=0 ts=6adf54b8 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=NEAV23lmAAAA:8
 a=NLiCwHATAAAA:8 a=V1jnuoLLAAAA:20 a=EUspDBNiAAAA:8 a=916E8NSIVdlGVQu2ioMA:9
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=F9tHCgz3TLBaZgltkx5D:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Wire the common RISC-V RPMI device into the riscv-server-ref machine so
firmware can discover platform management services through the generated
device tree.  The board exposes RPMI unconditionally when QEMU is built with
librpmi support and does not provide an rpmi=on|off machine option.

Advertise Base, System Reset, HSM, and System Suspend service groups for the
board.  Reset, shutdown, hart management, and suspend requests are routed
through the shared RPMI implementation and the server-ref machine callbacks.
When RPMI is available, omit the legacy syscon reboot and poweroff nodes so
firmware uses RPMI for those operations.

Keep riscv-server-ref buildable in configurations where librpmi is not
available.  In that case the board boots without RPMI support, configure
reports a warning, and the machine emits a runtime warning.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 docs/system/riscv/riscv-server-ref.rst |  41 +++++++
 hw/riscv/Kconfig                       |   1 +
 hw/riscv/server_platform_ref.c         | 144 ++++++++++++++++++++++++-
 meson.build                            |   4 +
 4 files changed, 189 insertions(+), 1 deletion(-)

diff --git a/docs/system/riscv/riscv-server-ref.rst b/docs/system/riscv/riscv-server-ref.rst
index da043ed096..b09d747aaf 100644
--- a/docs/system/riscv/riscv-server-ref.rst
+++ b/docs/system/riscv/riscv-server-ref.rst
@@ -28,6 +28,7 @@ The main features included in the riscv-server-ref board are:
 * No fw_cfg device
 * No ACPI table
 * Minimal device tree nodes
+* RISC-V RPMI platform management
 
 There are multiple ways of using this reference board.  The spec compliant way
 is using an EDK2 image and a TPM device.  The board was tested with the TPM
@@ -60,6 +61,46 @@ And then start QEMU with:
      -netdev user,id=net0 -device e1000e,netdev=net0 \
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
index dfdbc6dfe1..b5f0346962 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -86,6 +86,7 @@ config RISCV_SERVER_PLATFORM_REF
     select RISCV_IOMMU
     select RISCV_NUMA
     select SERIAL_MM
+    select RISCV_RPMI if LIBRPMI
 
 config SHAKTI_C
     bool
diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
index d18550b48d..3e4ee0c831 100644
--- a/hw/riscv/server_platform_ref.c
+++ b/hw/riscv/server_platform_ref.c
@@ -29,18 +29,20 @@
 #include "hw/riscv/device-common.h"
 #include "hw/riscv/fdt-common.h"
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
 #include "system/qtest.h"
 #include "system/tcg.h"
 #include "kvm/kvm_riscv.h"
@@ -68,6 +70,9 @@
 
 #define RVSERVER_PLATFORM_BUS_NUM_IRQS         8
 
+#define RVSERVER_RPMI_A2P_REQ_SIZE (16 * RPMI_QUEUE_SLOT_SIZE)
+#define RVSERVER_RPMI_P2A_REQ_SIZE 0
+
 #define TYPE_RISCV_SERVER_REF_MACHINE MACHINE_TYPE_NAME("riscv-server-ref")
 OBJECT_DECLARE_SIMPLE_TYPE(RISCVServerRefMachineState, RISCV_SERVER_REF_MACHINE)
 
@@ -93,6 +98,8 @@ enum {
     RVSERVER_RESET_SYSCON,
     RVSERVER_RTC,
     RVSERVER_IOMMU_SYS,
+    RVSERVER_RPMI_SHMEM,
+    RVSERVER_RPMI_DOORBELL,
     RVSERVER_ACLINT,
     RVSERVER_APLIC_M,
     RVSERVER_APLIC_S,
@@ -143,6 +150,8 @@ static const MemMapEntry rvserver_ref_memmap[] = {
     [RVSERVER_RESET_SYSCON] =   {   0x100000,        0x1000 },
     [RVSERVER_RTC] =            {   0x101000,        0x1000 },
     [RVSERVER_IOMMU_SYS] =      {   0x102000,        0x1000 },
+    [RVSERVER_RPMI_SHMEM] =     {   0x110000,       0x20000 },
+    [RVSERVER_RPMI_DOORBELL] =  {   0x140000,        0x1000 },
     [RVSERVER_ACLINT] =         {  0x2000000,       0x10000 },
     [RVSERVER_PCIE_PIO] =       {  0x3000000,       0x10000 },
     [RVSERVER_PLATFORM_BUS] =   {  0x4000000,     0x2000000 },
@@ -283,6 +292,100 @@ static void create_fdt_sockets(RISCVServerRefMachineState *s,
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
+        riscv_rpmi_fdt_add_service_node(MACHINE(s)->fdt,
+                                        &rpmi_cfg.services[i],
+                                        rpmi_mbox_handle);
+    }
+}
+#endif
+
 static void finalize_fdt(RISCVServerRefMachineState *s)
 {
     uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
@@ -307,10 +410,18 @@ static void finalize_fdt(RISCVServerRefMachineState *s)
                           irq_pcie_phandle, msi_pcie_phandle,
                           iommu_sys_phandle, RVSERVER_PCIE_IRQ);
 
+#ifdef CONFIG_LIBRPMI
+    create_fdt_rpmi(s, &phandle);
+    riscv_create_fdt_syscon(ms->fdt, &phandle,
+                            rvserver_ref_memmap[RVSERVER_RESET_SYSCON].base,
+                            rvserver_ref_memmap[RVSERVER_RESET_SYSCON].size,
+                            SYSCON_RESET, SYSCON_POWEROFF, false, false);
+#else
     riscv_create_fdt_syscon(ms->fdt, &phandle,
                             rvserver_ref_memmap[RVSERVER_RESET_SYSCON].base,
                             rvserver_ref_memmap[RVSERVER_RESET_SYSCON].size,
                             SYSCON_RESET, SYSCON_POWEROFF, false, true);
+#endif
 
     riscv_create_fdt_uart(ms->fdt, &rvserver_ref_memmap[RVSERVER_UART0],
                           RVSERVER_UART0_IRQ, AIA_TYPE_APLIC_IMSIC,
@@ -516,6 +627,12 @@ static void rvserver_ref_machine_init(MachineState *machine)
     }
 
     imsic_bits = imsic_num_bits(s->aia_guests + 1);
+#ifdef CONFIG_LIBRPMI
+    if (kvm_enabled()) {
+        error_report("RISC-V RPMI support is not available with KVM");
+        exit(1);
+    }
+#endif
 
     /* Initialize sockets */
     mmio_irqchip = pcie_irqchip = NULL;
@@ -598,6 +715,31 @@ static void rvserver_ref_machine_init(MachineState *machine)
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
     riscv_gpex_pcie_init(system_memory, pcie_irqchip,
                          &rvserver_ref_memmap[RVSERVER_PCIE_ECAM],
                          &rvserver_ref_memmap[RVSERVER_PCIE_MMIO],
diff --git a/meson.build b/meson.build
index 9c4d501687..5b8ea24714 100644
--- a/meson.build
+++ b/meson.build
@@ -3438,6 +3438,10 @@ foreach target : target_dirs
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


