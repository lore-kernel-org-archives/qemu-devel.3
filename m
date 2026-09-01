Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634D7C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Uyp-0002Qk-5a; Tue, 01 Sep 2026 16:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1Uyl-0002Ph-EI
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:21:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1Uyi-0003Y0-8G
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:21:10 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681HgT9a2692308
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 20:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=eGBFGOFfYPQ
 EsPlo/KgSxDu8+MUTMwH1x+FUzlTDxs8=; b=Q2cLo7dBGxcKwsE0kOP7G+z+Ig4
 QTM4ynEdJMGFEZIZq9sR1cdcgf8fDEcQRmKCI+BdTqmNfsPyCcKpF15Q/h1a2nxm
 gak7V8cdt9PJgPdWDyS9qr7g08D/7UVle1U3UDwp6Yuz9l9mJ+6sNjr87WS4kz7g
 x3el/SUIQE6lBIHHFL7s+w+z93UKLhv6q6fNi7+43ki6DEp8gFLXFLPNe1nbhdey
 OCrJKorF576RWQ+7SVRM9QREGjAypY6orZYWKbmW/pMNZS/g/vB3orTKawSfiG60
 b3XMkVG61MGBA8tz2XtwM44MHje2k0f91+VjT3BJ2gKXV9obANlc/9KPP2g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge3978kde-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 20:21:07 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-398fe469aa0so377468a91.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 13:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788294066; x=1788898866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eGBFGOFfYPQEsPlo/KgSxDu8+MUTMwH1x+FUzlTDxs8=;
 b=S2ZbwDjQBtFR4I0QXnpG/wF7ObrFVkK3MNJgwmkSjdfI1969mE1LhB/ooZl9xugIY2
 U/o1IPLRgpJlGGXSR4G4/4aJSn6Idb7MttISLmvPYUT04PeqMs4ZAYFpUIUqg5f14DPq
 jX3LuvR74HVyiuLoG73MKd3dA7JN/r80+uH9ntjG1VoAFLJ8MS4jVBqIom1fGsT76TAr
 YiftWJ6PuyIb23Ir7+w5WcOz2gTrBcdhatCi5TjjrJ0tu/CfgxOYG64SJqoxJylfgust
 lwCuH09DMXm+RfMvPZeVddqSGAaOEicpK/fmaOg3m7aRapWnFZRymvNIKTqB1jwC/Na0
 ncTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294066; x=1788898866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eGBFGOFfYPQEsPlo/KgSxDu8+MUTMwH1x+FUzlTDxs8=;
 b=kGbQ5z9AUleU8pNhPGTL4AfdVJJrSNTSJtcXKxcdwiv7RQmRusJQT6ovR8oOZZJm23
 tQgfIbIZpMjy8Vx3X4+TG8gsudK7pjJtC0N4ZdXSJReRIqZftychRJLVK9w9vDQO9BLT
 rktvGylI2vw66ISa6zp4lep3K25q+HsJsS7eDa61e1N98naxjVKAhTU3KZbxjyib9D9k
 6WNZ1GXDeZNiRUSAzJY9fZEoaQJ2lrOf7mRkNxqVp4cBEKFXwdk6pYWJQXnC5+OznnUi
 UA0kod7AhM7p5c/ZaNj8BcvN7hNJOOiRH34OvCDWHOzkXglhm6YXeCpxdC98rUwqcAmc
 CBCg==
X-Gm-Message-State: AFuF++lK3ejzTeD2CvdY3LQtL6McEqbD1p9loqHEC+HzdRSKTyXPPiJ6
 mUgwI4lJc08UBMEjeYnybgzQ2YhGPHz1DS0nvdogltuczQJe+saYy8vqORBMjhfsE62qYqqQfqC
 70sOlgqS0e4pQJGYyYh82hiGjl4+E5YeZTnybdIDgLnI1SO/BqzZ1XT+7m83WJp5xXA==
X-Gm-Gg: AYBFou0kp7OGVj4GYfkf+qRMDBx3Hfnn4w/3UmAGiQ1N+j6l6H+rGK6MfBP544GN82q
 P7huZ70TpZD6P9vt4adVKYuxrf5PdJnMRUjQV6HYkComh0tx1jY+W1EUFHiXulVRXVFSYPq/dCq
 93RIom/DuSvK6zreLW29J4+pbrAAQpCuXVWnfmILQIh41xAJsp69WDdpUOU1J2CAWO/sRXeys4L
 Us10PGM/7kzFb57KyGaJymLZRnSGCQq2pjI2mhybA7ZrMFFiEvEYBKbcjuAdQ2HAQb3La0kGP7/
 1LwnHUa4jaZvLz8TB1NkB4BNEHGLFcnnnJ7XhvEjwbyPzIU8E3GtjXGpff64DMnHSgE5eHQ5oJ1
 O/WndQo0ea8j66J2HhCOnyScWqzN47CjDdFPim7m8l/Ym49OQmtKEXHCK6Os=
X-Received: by 2002:a17:90a:10c9:b0:39a:e002:f192 with SMTP id
 98e67ed59e1d1-39ae00301efmr2705221a91.22.1788294066092; 
 Tue, 01 Sep 2026 13:21:06 -0700 (PDT)
X-Received: by 2002:a17:90a:10c9:b0:39a:e002:f192 with SMTP id
 98e67ed59e1d1-39ae00301efmr2705155a91.22.1788294065459; 
 Tue, 01 Sep 2026 13:21:05 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990d7bb9d7sm7734802a91.15.2026.09.01.13.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:21:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 14/14] hw/riscv: remove machines-qom.h
Date: Tue,  1 Sep 2026 20:20:43 +0000
Message-ID: <20260901202043.26532-15-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfX4SONIEQybe02
 BNk8K9yBGLjBi9loA6OSyJpkFlU8C0uuUIFqsO9zIBo7jRAU6Lb1wwbQ+G2i6zijDv12Oum/A2c
 TYedwJZFgoezRWGcyH3t9N2ZWimDUaMJYY7IaOgCPgpVeDsNh/RYf/+1EFKJ1Q1PeS6WM6kHPdH
 lDz8y5sG3iApnCWBmvzy05CNicoX1NNPzSoPakOB1jvStrf4XqhNQlWWLcRkWwjCRnZlJRE9Wte
 KtrrvUxwX7UcMypBWGpYIjbX3FWxB1J9u/1ZZvx66ZlGtiQp8yUQ/tnzTf7GoZv60v6Cy3NeQ4C
 EcuAtp67ZBYRZs3yr+x1SZsTK8O+l0ZgHaXJqoDckSYJMiwfv3awFmBf89OyLx73VuYwk3278vb
 GsApCuKjuegGWjNcqfKOCxiHkA62YfDhj7PvFTwsOxHhkg/CFVSlqo33/uN6JuiZw6xNTg6OUXA
 hC+vgRQIFsB/vypP4xQ==
X-Proofpoint-GUID: 5FipBW3-zBG_5XWbxinAvVBtEsHbAUwd
X-Proofpoint-ORIG-GUID: 5FipBW3-zBG_5XWbxinAvVBtEsHbAUwd
X-Authority-Analysis: v=2.4 cv=Re6gzVtv c=1 sm=1 tr=0 ts=6a9733b3 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=iIsWfukyHDVU2tHd-88A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfX0EoNQ6vQeAkL
 vK00Q80iV5+3WpPqN90/RmJcu4tFsdhMw9JO/v5LXovIWeMvZysRsONTg/X0vAn3+KQ5ED8ScGH
 0bOSHkpAG4hW2MH7cVC3xtmN2KIsaHE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010178
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/core/null-machine.c          |  1 -
 hw/riscv/boston-aia.c           |  1 -
 hw/riscv/k230.c                 |  1 -
 hw/riscv/microblaze-v-generic.c |  1 -
 hw/riscv/microchip_pfsoc.c      |  1 -
 hw/riscv/opentitan.c            |  1 -
 hw/riscv/shakti_c.c             |  1 -
 hw/riscv/sifive_e.c             |  1 -
 hw/riscv/sifive_u.c             |  1 -
 hw/riscv/spike.c                |  1 -
 hw/riscv/tt_atlantis.c          |  1 -
 hw/riscv/virt.c                 |  1 -
 hw/riscv/xiangshan_kmh.c        |  1 -
 include/hw/riscv/machines-qom.h | 14 --------------
 target-info-qom.c               |  1 -
 target/riscv/machine.c          |  1 -
 16 files changed, 29 deletions(-)
 delete mode 100644 include/hw/riscv/machines-qom.h

diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index 2f008c4a702..60254913019 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -16,7 +16,6 @@
 #include "hw/core/boards.h"
 #include "system/address-spaces.h"
 #include "hw/core/cpu.h"
-#include "hw/riscv/machines-qom.h"
 
 static void machine_none_init(MachineState *mch)
 {
diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index 30eff10bc5f..b90da096ea8 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -18,7 +18,6 @@
 #include "hw/ide/ahci-pci.h"
 #include "hw/core/loader.h"
 #include "hw/riscv/cps.h"
-#include "hw/riscv/machines-qom.h"
 #include "hw/pci-host/xilinx-pcie.h"
 #include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 72d50d369a9..34905bb1702 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -26,7 +26,6 @@
 #include "hw/core/sysbus.h"
 #include "hw/riscv/k230.h"
 #include "hw/riscv/boot.h"
-#include "hw/riscv/machines-qom.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/sifive_plic.h"
 #include "hw/char/serial-mm.h"
diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index 503e8e08992..b0494b1ac50 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -25,7 +25,6 @@
 #include "system/address-spaces.h"
 #include "hw/char/xilinx_uartlite.h"
 #include "hw/misc/unimp.h"
-#include "hw/riscv/machines-qom.h"
 
 #define LMB_BRAM_SIZE (128 * KiB)
 #define MEMORY_BASEADDR 0x80000000
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 42d4fc39734..60bb96da016 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -49,7 +49,6 @@
 #include "hw/misc/unimp.h"
 #include "hw/riscv/boot.h"
 #include "hw/riscv/riscv_hart.h"
-#include "hw/riscv/machines-qom.h"
 #include "hw/riscv/microchip_pfsoc.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/sifive_plic.h"
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index c58d8993303..8cd660dd415 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -26,7 +26,6 @@
 #include "hw/core/boards.h"
 #include "hw/misc/unimp.h"
 #include "hw/riscv/boot.h"
-#include "hw/riscv/machines-qom.h"
 #include "qemu/units.h"
 #include "system/system.h"
 #include "system/address-spaces.h"
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index 9fd7856dc24..a205a213324 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -19,7 +19,6 @@
 #include "qemu/osdep.h"
 #include "hw/core/boards.h"
 #include "hw/riscv/shakti_c.h"
-#include "hw/riscv/machines-qom.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/intc/sifive_plic.h"
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index ede7cb52f00..1acfea49668 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -40,7 +40,6 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_e.h"
 #include "hw/riscv/boot.h"
-#include "hw/riscv/machines-qom.h"
 #include "hw/char/sifive_uart.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/sifive_plic.h"
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 08687cfc363..997ee91aa0e 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -51,7 +51,6 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_u.h"
 #include "hw/riscv/boot.h"
-#include "hw/riscv/machines-qom.h"
 #include "hw/riscv/fdt-common.h"
 #include "hw/char/sifive_uart.h"
 #include "hw/intc/riscv_aclint.h"
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 3786de4b0b7..e36fe996b09 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -34,7 +34,6 @@
 #include "hw/riscv/boot.h"
 #include "hw/riscv/fdt-common.h"
 #include "hw/riscv/numa.h"
-#include "hw/riscv/machines-qom.h"
 #include "hw/char/riscv_htif.h"
 #include "hw/intc/riscv_aclint.h"
 #include "chardev/char.h"
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 5e155726abf..7d02868b222 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -20,7 +20,6 @@
 
 #include "hw/riscv/boot.h"
 #include "hw/riscv/fdt-common.h"
-#include "hw/riscv/machines-qom.h"
 #include "hw/riscv/riscv_hart.h"
 
 #include "hw/char/serial-mm.h"
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d2ae321a376..dd396410178 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -36,7 +36,6 @@
 #include "hw/riscv/virt.h"
 #include "hw/riscv/boot.h"
 #include "hw/riscv/fdt-common.h"
-#include "hw/riscv/machines-qom.h"
 #include "hw/riscv/numa.h"
 #include "kvm/kvm_riscv.h"
 #include "hw/firmware/smbios.h"
diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
index e02624b62b4..247a0b5d1f2 100644
--- a/hw/riscv/xiangshan_kmh.c
+++ b/hw/riscv/xiangshan_kmh.c
@@ -41,7 +41,6 @@
 #include "hw/riscv/boot.h"
 #include "hw/riscv/xiangshan_kmh.h"
 #include "hw/riscv/riscv_hart.h"
-#include "hw/riscv/machines-qom.h"
 #include "system/system.h"
 
 static const MemMapEntry xiangshan_kmh_memmap[] = {
diff --git a/include/hw/riscv/machines-qom.h b/include/hw/riscv/machines-qom.h
deleted file mode 100644
index 79d212eeb7d..00000000000
--- a/include/hw/riscv/machines-qom.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * QOM type definitions for riscv32 / riscv64 machines
- *
- *  Copyright (c) rev.ng Labs Srl.
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#ifndef HW_RISCV_MACHINES_QOM_H
-#define HW_RISCV_MACHINES_QOM_H
-
-#include "hw/core/boards.h"
-
-#endif
diff --git a/target-info-qom.c b/target-info-qom.c
index f98d3d7698e..6965e4d1169 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -12,7 +12,6 @@
 #include "qemu/target-info-impl.h"
 #include "qemu/target-info-init.h"
 #include "qemu/target-info-qom.h"
-#include "hw/riscv/machines-qom.h"
 
 static void target_info_qom_class_init(ObjectClass *oc, const void * data)
 {
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 22a918cec95..c3f5a255099 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -24,7 +24,6 @@
 #include "migration/cpu.h"
 #include "exec/icount.h"
 #include "target/riscv/tcg/debug.h"
-#include "hw/riscv/machines-qom.h"
 #ifdef CONFIG_KVM
 #include "kvm/kvm_riscv.h"
 #endif
-- 
2.43.0


