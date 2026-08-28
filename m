Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1FBC61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Y0-0000Ok-9o; Fri, 28 Aug 2026 18:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Xw-0000Ip-Gt
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Xu-0005lV-HB
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:40 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTUVV4105130
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=eGBFGOFfYPQ
 EsPlo/KgSxDu8+MUTMwH1x+FUzlTDxs8=; b=h8jNj7UGlYz1mIt+XJTNAa08+YG
 1sRWZqNJeaVQGHl9IS9H7JAi9gqJXIoRAcjWKxJE63sYXRou/qxr9VMsbO4ISr1c
 L5GPEmUezuWRb7Zci4+BbcD8rCWMnLhWkitB+D9KE90hf08H38etcOwWyn462gI5
 GQYJG/wN9fstnXb3D0bmuaTx26Ed1qUtEGNdKYAtiWREAarG+++p3Qmu9siYuj08
 9t+YZ2vd2kwkq3hO0i6XlNMVWN8bqsoY6H/YOzzW2FWcKUaZnkm6Z7NGQM1Q898j
 bYLjEEwjKh9d/3c3wPCPvIN325S6MAXc/etpZNM3lx+EzY0cRgvdSHcpRDw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb3hs3xc2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:37 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cfca8558d2so19585105ad.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957976; x=1788562776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eGBFGOFfYPQEsPlo/KgSxDu8+MUTMwH1x+FUzlTDxs8=;
 b=LX938wFs0IJL5YiWtvFl5jGNCUhghvAQcFQnZ+r0/8Oqvly2A5h5C+O1mzSKkFqX1T
 BNJnWKnKvElzBuHrvq9ismfQ2+1eNBZ7s9Bhtk9UVdgLOjz6zEF9N7RdnkEf3Rf70ahK
 MHzWx1BE19POdmQHWRnSyp0qkG/59Yb9WXPxJaTiznQmqhfVo16jBTy+S70t0Cm942q/
 32eroFf8OxsGLq1zsmsjd9I0bscz9/wYysOz0ANKNRkZ6lrxgO/QKyCIfsAqns9bdVAQ
 XpPztGNZStVZrhGV3E0cB92EzFn/m3E1m6ZVOiktG8owfbCTSMlLddnsgFa7mU4frHO1
 RTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957976; x=1788562776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eGBFGOFfYPQEsPlo/KgSxDu8+MUTMwH1x+FUzlTDxs8=;
 b=jYP8fxs0YxR4rRZhs+aTssNhpy0Xo1iyiUowTmyzTPM1syUTmOXY70dQw46bm1LXVx
 eYF/Wx3xzlyajswAe0/izJONaXKAWEFggDBoVRXAOZnYjcdTCXG3y43ag90eZq8Fp2X9
 axZ4CsJXPrJ+KYX+NVNXOPUqFDYxf50o2ziUoO7T3W+COrjwyUyMupatC6Oda/Q/cV/8
 t0sk1HuBGfurLFZkcEc//a3433aO1zMp7CTCH4Gr1yUArk+ONqsvhyC/Dey6C6OZ8HcL
 Rtw389/kI1PJyrxoWO/3FeEGaTdqsOdaP8LhSzUts7o8Ya0VT4XsdGzQsjHAc2QsjSKO
 WKiQ==
X-Gm-Message-State: AFuF++kYYhM+IL/gJyiVXzNfHyz1oD9KwD/YLZNTQL7QTaf1xfGG5l//
 mr3uLJduH6dAi5OeUgfbV+x/QJBIkx3QOPuZJitwXj1qreOaJi7FjwZnIAJQ4ND8v07Szs1IFIX
 ux8Ej2j/K236QuUBbESnZnej2nJVFJl5NULQySu+yEYEnNO9V3DHhUGCV1nq53cZytw==
X-Gm-Gg: AR+sD13kZdCNUd5Z1eL6kM0FJ/RN89mNem18y2zuvGUX+TIcbOLzB8Xc4gfPrH76abp
 8+N5p86R0dWZeiXPeLd8cZsQ0Vkbu65gE3SoBgEhsMFmdt5HUGpzotsyiEkS1qj5v6KF+yGTzj5
 K8rHMV6La5Xq30mCXWOSh6BeKPK18XHAwd0nZG8xYg/e0TO5l6P3m8pnElgERuEPMBKc4GVfFMN
 Fbn3P9ggL4lDXgw7qK1EJHgl9xYgOZe1liqBkBXq9duQqbE1iGExH58x+kWO6iGO7pPtVtEV7c7
 LhMaCo2tPrqjA0obhlDJo7Vpuod1HO9u+C9Zl/DBoHuJn4deVmwgXwaGTWkYYg6Eu3oTggTZOS9
 +mwC6f1Nu67/YjSGx96tAsTzFtrmEDfK9VR0Gb66ETjQ16TAC8DYqheMzpR8=
X-Received: by 2002:a05:6a20:158d:b0:3c8:d3a4:7b40 with SMTP id
 adf61e73a8af0-3d266ebcbb6mr15662773637.2.1787957976470; 
 Fri, 28 Aug 2026 15:59:36 -0700 (PDT)
X-Received: by 2002:a05:6a20:158d:b0:3c8:d3a4:7b40 with SMTP id
 adf61e73a8af0-3d266ebcbb6mr15662731637.2.1787957975985; 
 Fri, 28 Aug 2026 15:59:35 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 22/47] hw/riscv: remove machines-qom.h
Date: Fri, 28 Aug 2026 22:58:36 +0000
Message-ID: <20260828225901.367438-23-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XKYAjwhE c=1 sm=1 tr=0 ts=6a9212d9 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=iIsWfukyHDVU2tHd-88A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX5uFYXBmGUg71
 uAUeLYeoVWRetvKZC2qweCMfj31381Tk13Xbg8/GFOzB1YRCvbSGE1XYqtp5vL9sm7PWbdc0lXQ
 Sd2IglLhOYEtgk7R4rsxfP8AYy6RVRkKa6dYsygTkxMc177Ps+uZN9Z9VuWf/dna7Rul9NFTNPw
 5LK9J+mye+C0OnMJ9t4IGGbHG708P4kLQl7sG0+JxOvr3vpyonT20bOOq4/MJWf4iOAQjYucwKB
 7P77LtyGsZk0DdTfc2hMZbUgc2hIBWaFSx7/FdwCccVGJvmZH4hCn/VaAYqYuhm6KjwmSC6BvnS
 1bepnUeLmv2lHoaB5LJ9NGssHX1Zm03NgqlRt7BmHkhwQgj8/rdSRB8sAq7QHGuwE8+Ibx0jTP1
 RzYMyCz5Vb4Dg5wqMyiB9gnw8j+wo9bX+KGAZpHEzWRJMkTmFt/jN9bpiIsXFZVcAJ8kxe4pwu3
 jwZpGweC6mN10OtPQ3Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfXxLjl5SeHkDIT
 jxYRWoEp1Ytt7xNiNQK/v9j/cl2N3HwkZaIXF4P1zHZZD+Gt4WN5L3zK6DtZzIvgU5pXGWLQdlo
 AfUr+mm9ei96smzUaLNou884Ix7iORE=
X-Proofpoint-GUID: oK44UsmT6k7DLzsEGciKmzVdfEOdZyWV
X-Proofpoint-ORIG-GUID: oK44UsmT6k7DLzsEGciKmzVdfEOdZyWV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280200
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


