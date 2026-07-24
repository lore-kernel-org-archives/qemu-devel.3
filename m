Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032BAC531FF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:12:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn3V6-00055b-3m; Thu, 23 Jul 2026 20:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3V0-0004zE-W6
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3Uy-0006BU-6t
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:45 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLeGg31055296
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qvoZJSNlk/Z
 mjz50J0xrOrXagWFbcW5GjLDGJuhRCtM=; b=EtnzDtt5g7aWYbJPMNVgE/j7gmg
 AeQjmQTu8FLpUXjVSbrbDnh2+s4n6SDHY4DbuN76OFvR1ZjxsrS6rXBrD6PhD4CX
 qFOnOZ3+U7D8fN8oFt1jLXLXvnGbySrRAe14qETddXJSd2CUwHfsZO/iPpfIsAku
 RpHFGRlxvzCQTUzaRaUGzPouo8MAYx4LXQBkMnh3Xs2dci9IEEBatycMCnz4rVyh
 KgaokPnw+v+wfv4h+uhYcXjAvc3pXKC1FQ3O8q3uEUs8xO8uqXreLNN46f5IgdBw
 jNQ/1EGIyPnpnHWe1d8OeMLX/lWe0HbqRu+yiS0ezv1EQ3D8M0JMbM9iZrg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fknbmj2gm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:33 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb7049fa552so974606a12.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784851832; x=1785456632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qvoZJSNlk/Zmjz50J0xrOrXagWFbcW5GjLDGJuhRCtM=;
 b=C3wHkgqFx1xOxghzgAxdfR9mWJxDMdTHFSEgfzzbUqtXI3IZezcRhSjz/vanzji/3q
 ZDO5oPIb4P67buRf9Lv2JDqpfqlckK2oL4ZoID11Nw7uvrbvZK6s2UWG7YsTLbT655J0
 APW3c2/cmfHCVhIn+wVdZwUi5of4emqPksYXzPJFYNjpjoQ+pQgJiHi3OTE8nEMrutvH
 WJfDC1c5FyTqBRg/as3B5yGd5rYjzGDO6bGdzUiT1pcW0Yawcs0yZl2rzw/cL7Z2B0Db
 WLwdkcLHiz0Cz8/6fAHAKcMgvh5o7bePArFvBKKZfaHO1RzWMnc7oYHqBnppmjsp9sJf
 hoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784851832; x=1785456632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qvoZJSNlk/Zmjz50J0xrOrXagWFbcW5GjLDGJuhRCtM=;
 b=qWrGuX434N6dOgvY554RCp/aKDIyeFaTWy2un0tRxIXJGn2/0iXnEZXYG75s/rhJY2
 dpDXj0FCxrGi2wnKtwuqZSVwNBpPYiLJopdUWLHaj+uRhln5cAxEVwwVuUw32J5sUX95
 qX5xnpgSOfCYcniB9js194cT1xVhi1t5/xI0ptxo35YBjvKfM3HP1iu6NNIJ8Cs6gz92
 1RlxgP0MpYsElgVqe7DdOU//wqKWT+eNbA7KBpQ/2HIhp2qhxdySyPggdeZ1wO/yzq3i
 127O6ibUIX6HRB5NcUqbSY1wZu7j6+RAyvnNOAuBACO0MEACvLECfdUZUxu2v9UgPn3r
 LbwA==
X-Gm-Message-State: AOJu0Ywm0N5huaeGUykVKP5zo80uOI4ipVS23UGU168B3ptIUgeY94dI
 HVlTtRZUFl7N07jmeJhuwkI19p/zoFFRoIL+FGkVzk3FNzZgFUrQW6oO+ndUkdMTYin71lrVaAq
 raFEqyZYIwz45l7waBRSI50ZjX2R8nz7QhTAmBxe9x5QXNjhSBmiF6PbeN8CHbIVITw==
X-Gm-Gg: AR+sD12DnAoVFKydxWH6BPjCAJMLrVvRUMjGxCN2mw8zMuHCiutrI5z2OOZ2JHaRuPo
 O+7nzqvAZBfXGJDDLC5PkKsTstvKHtEldEFlh0iSsqLmPhoN5EdRLRp7tSGEADDEaFaemCnPg1l
 ffOyDLM0SnEYCuv+6y+iLLybBpsGOW/H8gMVBPF4/9QcQM8F95J7iZE1pTfM9ZXGtmWdQDddwdS
 zLULL25Du8eSkEOLG0kt0qxseF3MYogbGwwFV7tB4msl9CKcFC4tyU+gbScXzaKY/W5sShF0MQG
 mHBgesEbU2nLsheG4egE3HlpFL0i1KE+ff14ukHaWdOOyAzwid7zl4RHBJexLwjV3k+KLbmXSUV
 8QL2aEz/qD+DGV1u157A9nYfMEMBCvh9QCv3wXWQQ4Kb4cjoGJ44ozKTMnRHK+NE6w5YDVRg=
X-Received: by 2002:a05:6a21:a345:b0:3bf:a1e5:ff53 with SMTP id
 adf61e73a8af0-3c44b1eb318mr5904524637.48.1784851832205; 
 Thu, 23 Jul 2026 17:10:32 -0700 (PDT)
X-Received: by 2002:a05:6a21:a345:b0:3bf:a1e5:ff53 with SMTP id
 adf61e73a8af0-3c44b1eb318mr5904477637.48.1784851831722; 
 Thu, 23 Jul 2026 17:10:31 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1bc886sm24359478eec.26.2026.07.23.17.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 17:10:31 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 25/27] hw/riscv: remove machines-qom.h
Date: Fri, 24 Jul 2026 00:09:45 +0000
Message-ID: <20260724000948.234657-26-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=e742j6p/ c=1 sm=1 tr=0 ts=6a62ad79 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=KzGqfiNxp7Nhv_o5qEAA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: o0qmopqF9_LMmhaq0tyUohESg1pE4FZE
X-Proofpoint-GUID: o0qmopqF9_LMmhaq0tyUohESg1pE4FZE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX+CMU5f8/V/S/
 uwKUVRDxNJEcH5uqsd0yaty6DGDeLywdRLAXP8lrL7sObLfBObac0BzjuhInoq4cs1r8GdgmX54
 vQ0vGdHvDLufgG2DobXGZ5MAR0blYLo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX2y4QLo7POndB
 CjRK4Sr8g3oNdrgtTnL6/eA4S0Azk4Bbyqgq47ckyWHE0mrdK7a3m2mFX1LKGtmNcjD4SaqsDc8
 xwhZwvu1VG+/AdG1BbKRNw2UrpaDkgtshfxZPGYV5f9zfGDVxDHZ5Tq/bygkWfoivoFAJb4gCbb
 YAsT73z7aK1Df5WYJTQ5S5M4+dq8pMb1rmXtvUjAN1Sj1w3B+WTvka1bM/b2GiDvFImEOxDPZPE
 HBQIM+zBaUvUH2kpgqbdyRFJaTdImRhekF+lmeNhWn+MDwTgP+O0UfFx+HqyTn9Nl4/PP0wtVF/
 EpNUFXnENOAUBBS9qESR9UfZwbULd2JMSZKjAQdScJvOaer9xaGAcczKI6CmQe/wSXuBURX7XjN
 WvpB3oJRzlO+fhrWfhLxwsLJ5zfzajj0erEPwZChlM9F6USnR01ae88BgRCJnCZLanrtj7Bja3B
 t6elACc1wQ74PJaq/WQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230233
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
 configs/targets/riscv32-softmmu.c |  1 -
 configs/targets/riscv64-softmmu.c |  1 -
 hw/core/null-machine.c            |  1 -
 hw/riscv/boston-aia.c             |  1 -
 hw/riscv/k230.c                   |  1 -
 hw/riscv/microblaze-v-generic.c   |  1 -
 hw/riscv/microchip_pfsoc.c        |  1 -
 hw/riscv/opentitan.c              |  1 -
 hw/riscv/shakti_c.c               |  1 -
 hw/riscv/sifive_e.c               |  1 -
 hw/riscv/sifive_u.c               |  1 -
 hw/riscv/spike.c                  |  1 -
 hw/riscv/tt_atlantis.c            |  1 -
 hw/riscv/virt.c                   |  1 -
 hw/riscv/xiangshan_kmh.c          |  1 -
 include/hw/riscv/machines-qom.h   | 16 ----------------
 target-info-qom.c                 |  1 -
 target/riscv/machine.c            |  1 -
 18 files changed, 33 deletions(-)
 delete mode 100644 include/hw/riscv/machines-qom.h

diff --git a/configs/targets/riscv32-softmmu.c b/configs/targets/riscv32-softmmu.c
index 48d55bfc354..671772aa40c 100644
--- a/configs/targets/riscv32-softmmu.c
+++ b/configs/targets/riscv32-softmmu.c
@@ -9,7 +9,6 @@
 #include "qemu/osdep.h"
 #include "qemu/target-info-impl.h"
 #include "qemu/target-info-init.h"
-#include "hw/riscv/machines-qom.h"
 #include "target/riscv/cpu-qom.h"
 #include "target/riscv/cpu-param.h"
 #ifndef CONFIG_USER_ONLY
diff --git a/configs/targets/riscv64-softmmu.c b/configs/targets/riscv64-softmmu.c
index 01013bb5b7c..a28b99fd64e 100644
--- a/configs/targets/riscv64-softmmu.c
+++ b/configs/targets/riscv64-softmmu.c
@@ -9,7 +9,6 @@
 #include "qemu/osdep.h"
 #include "qemu/target-info-impl.h"
 #include "qemu/target-info-init.h"
-#include "hw/riscv/machines-qom.h"
 #include "target/riscv/cpu-qom.h"
 #include "target/riscv/cpu-param.h"
 #ifndef CONFIG_USER_ONLY
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
index 8c9d50ae762..d63075100a2 100644
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
index 631ea71c441..ffc0e224e8d 100644
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
index e742e67c232..97961b84ac4 100644
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
index cd0c8ca5f36..5f356dc099d 100644
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
index 0b3e02415ad..5f5a4e01575 100644
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
index b59c4035929..05c55e9aae3 100644
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
index 5b5dc812b27..2941f14aff3 100644
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
index 1fd752dfa2a..cd0b9c2da41 100644
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
index 450f5679110..1ca7106efd4 100644
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
index 896dfb1afde..cd66548c851 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -20,7 +20,6 @@
 
 #include "hw/riscv/boot.h"
 #include "hw/riscv/fdt-common.h"
-#include "hw/riscv/machines-qom.h"
 #include "hw/riscv/riscv_hart.h"
 
 #include "hw/char/serial-mm.h"
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index f9de8827624..2d242ef71a5 100644
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
index 101b441a441..a58bbd0e0bc 100644
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
index 0d30759bdd4..00000000000
--- a/include/hw/riscv/machines-qom.h
+++ /dev/null
@@ -1,16 +0,0 @@
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
-#include "qemu/target-info.h"
-#include "qemu/target-info-qom.h"
-
-#endif
diff --git a/target-info-qom.c b/target-info-qom.c
index 5e0f21a319c..68ad734049c 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -13,7 +13,6 @@
 #include "qemu/target-info-init.h"
 #include "qemu/target-info-qom.h"
 #include "hw/core/boards.h"
-#include "hw/riscv/machines-qom.h"
 
 const InterfaceInfo type_target_specific[] = {
     { TYPE_TARGET_SPECIFIC },
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 555a1f3c881..82e5206fc7d 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -25,7 +25,6 @@
 #include "migration/cpu.h"
 #include "exec/icount.h"
 #include "target/riscv/tcg/debug.h"
-#include "hw/riscv/machines-qom.h"
 
 static bool pmp_needed(void *opaque)
 {
-- 
2.43.0


