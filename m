Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86943CA9EBB
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFJ1m-0003AC-N5; Fri, 09 Oct 2026 18:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJ1k-00039m-L3
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:25:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJ1i-0000QV-I3
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:25:20 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699KhwEM3880048
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 22:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wvxFHj1HaowhauqCUDkPcLFtmwalB3vqLYT6bUX/Mkk=; b=Qnnh7WoNr/19ZOQo
 TLu45paHQDOatdzn9/LyOTnKhWuIZVbdkBhrETMgDNeOGeQcChdNO4m2eYakns/L
 JjYFjXnsSJAMt7XsB3d8v8tkanVTuILWab+8Co4jtKqox9C6kgOIl8oDHtEElyU9
 o7Cgy4G7JvBb/ZXhPxS1Dbqkfq7OgXxVahDdLuNq6N4sRia+dc53YnIM/GgWe8i0
 GmlOsdVsrpgt55312/ZwFtqpBRGSZVXFbYXQSLdYttzTyVtdcx6LG09bDunufIUj
 EZZFxNgnCREJWgeYCaV1/TJFcCYUz5Xw7GpkmeMA6esccbCE0M8gCgC4A3YonQB0
 ISFQnw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t80xaq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 22:25:16 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35158d674e1so712037eec.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 15:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791584716; x=1792189516; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wvxFHj1HaowhauqCUDkPcLFtmwalB3vqLYT6bUX/Mkk=;
 b=LEk7H3bCVSSG7qID0sOhuCdMNC1VA0vqYK2r/2jYAcdppVTMj7avgak1alT0Q7Wzni
 /HAd23zVdxnIh2d25YZSDR1Hcn3I9W2aJTc4QJ5gymcEEE8rKpFVm5MCO9n4ImquflCw
 6J6J1QXywf0Sb2h+WF/P2b3/VNnP3/HEmi7iaBwvEMH01UaG/2iEtCqp5j95NGImct00
 RaFLJqls1EjvMp9UZtGRNhRKKVqAgfCE+OwiO3VrOvuAyxIpC7gUWoQT0YwyzVJfbP7K
 hKXhVBCWgB+Ijn9XZG63I2OdyLTjFHtqvzym44e2FJJZi10dYCFM0YRZLBpUYgz1bD8a
 up/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791584716; x=1792189516;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wvxFHj1HaowhauqCUDkPcLFtmwalB3vqLYT6bUX/Mkk=;
 b=z9Lf4HUxVHIEcKp4RSeHJdMl0Pz7Qpxu/m1wGb+dxI3JRqtioNh9JhWvkjDqa4VvXO
 rlKi8+pE9edyIknI36TQ0C+DDQvURmVXHqs6pQNVFYv9rSQ2lZkrcMNy/fLEHqbpEwyl
 G/HL4ngjmYAEG2ThOf9IZA1rxjuxokgbdgn3zAb+h6ELbLTTcAyQN9BA9q8Or4ffi9x8
 J8A2tNWkmMTd4qPg1POSLc7ELrN+0n+irR3O7Ol5UcZiwQV4U+NMt0tCKWVf5Aq8fSkv
 UACRYFUmkxyH60xmD+y+dhbMdWqgUPaGN8SvE1wK8CXzYFxhXAy9JLUIbfsperkVTr0Z
 4F9g==
X-Gm-Message-State: AFq9FYKA3TQp1CY0iVFoWyEdgXx5XFS9FovJ4BlT3U9gBs9z7LRx/nUo
 vJD/G5lsAk932B/jtvkYsNQZskwjOMkI2eOERXjJTuKREhnTXd6LBlcP8klRcbSxwjLtAN4aZZ7
 1HbVGn4GafI2ENzQXfQVUII8gCEXeLk0BTkayvEGyRtJ97uFEKW+dUR9q5WMavSwYAA==
X-Gm-Gg: AYBFou1PLHxXDxdIl2r9vhqLDha2xHn+wl8tlLn9yCAahlEONLuh1rvohyK0UmLd9bY
 /L2UfOsReY8KqRDgCrIXwysUwVQubYiATBfzeJY2yYzjHrWi0wH/ksYoagJ/9JCzE8NXcnHJtlu
 0GKvfemDtit+5YAbTz1bWcbP/CzzeVvm5IZWFBwEXP/Vsfx1v9WOk9vVzt/uJ+dGBv93t+bw/hy
 WUeyVc8PHuvJpKhvlsfHKyoicCbSQ92XshgY4d2Yf9Ezv6mL7BtzIugMkO+UeBnPqfL5aZ5Ycon
 GsziucK24DjBJmSbq6JwXk7XuNEPq7DWTdD39HvlKXq+Nj9y4BxeTnO97PrZI7bcDLr5aOpvTVj
 APhZPAfGEHjlamytaKq9wuT+nO1U1hW0q1WoOZ824woA7QgGJWsngYf2u6TU8
X-Received: by 2002:a05:693c:26c7:b0:34c:1f07:2d5 with SMTP id
 5a478bee46e88-3537df8cea8mr4519309eec.6.1791584715975; 
 Fri, 09 Oct 2026 15:25:15 -0700 (PDT)
X-Received: by 2002:a05:693c:26c7:b0:34c:1f07:2d5 with SMTP id
 5a478bee46e88-3537df8cea8mr4519277eec.6.1791584715352; 
 Fri, 09 Oct 2026 15:25:15 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca0e64csm9094339eec.10.2026.10.09.15.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 15:25:14 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/3] configs/targets: remove target info definitions
Date: Fri,  9 Oct 2026 22:24:57 +0000
Message-ID: <20261009222459.32364-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009222459.32364-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261009222459.32364-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA4OSBTYWx0ZWRfX8fPDUgKqvVQA
 iCi3+72WOFNCrkAFxT1T8jwXVkFlm80ycYcuVrw60PxJ4wyHwVDw0U/SBZxuNkJS6VL30Gr+KWF
 ZELPsxZ5kk39eUU6XUtJfKJLr23rLCA=
X-Authority-Analysis: v=2.4 cv=NPtAaE6g c=1 sm=1 tr=0 ts=6ac969cc cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=irYT5Wv2FT5WfXMUIzwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: SrAB8vzAmdnePJtPQTsOJmHwRl1Nwz8S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA4OSBTYWx0ZWRfXwlzzruGpA1iy
 XdDDalsRDh/UKkEzg2aKYNMSYMFRcfj8uVVR7D4NrXIzjCydwZSNFU58RrgDbio5b79fJEe/rns
 29LOLtHaV+xUAdUwU4C1SpXuhtdm4eYJLfpLEs3y8OSvTobRAe9BjrwoWJdef15Sn/6KHJxIYHv
 5eH0YTIYeF5cdfwfm00hslbActSKD0GP/s6xtOqPijNxXA1Z0LEStKPihH1hScTZnzoVqeKAZQU
 /z5fjx0T2V0soXVlCmIAq0/UOT83prlUQY+mRkvstWxVFLMkLtWGVBUQiREz3GSN9KJjSsGWoyi
 fupT/f31fMqhuqATY2E7Eqv/uepL2W6jw2XJMlNPQRtfQNRx56sDxXxKAa5wUszSLr3lJmJ/qqm
 lz0uWl13CxKmoGkVWTyAkLATWUixk1HLhTzzsOhbbl+nk6pbvDwPaCjEUFHrWXP6wAzou0U3uNX
 4o0TpVreM/DHt6OQECw==
X-Proofpoint-ORIG-GUID: SrAB8vzAmdnePJtPQTsOJmHwRl1Nwz8S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090089
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Now that we remove machine_typename, we don't need to keep duplicated
file per target anymore. So we can just rely on target-info-stub.c.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Link: https://lore.kernel.org/qemu-devel/20261007115253.328-2-luoyonggang@gmail.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 MAINTAINERS                       |  1 -
 configs/targets/aarch64-softmmu.c | 25 -------------------------
 configs/targets/arm-softmmu.c     | 25 -------------------------
 configs/targets/meson.build       |  6 ------
 configs/targets/riscv32-softmmu.c | 24 ------------------------
 configs/targets/riscv64-softmmu.c | 24 ------------------------
 meson.build                       |  7 +------
 7 files changed, 1 insertion(+), 111 deletions(-)
 delete mode 100644 configs/targets/aarch64-softmmu.c
 delete mode 100644 configs/targets/arm-softmmu.c
 delete mode 100644 configs/targets/meson.build
 delete mode 100644 configs/targets/riscv32-softmmu.c
 delete mode 100644 configs/targets/riscv64-softmmu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1312bbd1bd8..cfe39dc2883 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2148,7 +2148,6 @@ M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 S: Supported
 F: include/qemu/target-info*.h
 F: target-info*.c
-F: configs/targets/*.c
 F: tests/unit/test-multi-targets.c
 
 Xtensa Machines
diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
deleted file mode 100644
index fdebdcc3582..00000000000
--- a/configs/targets/aarch64-softmmu.c
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * QEMU binary/target API (qemu-system-aarch64)
- *
- *  Copyright (c) Linaro
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#include "qemu/osdep.h"
-#include "qemu/target-info-impl.h"
-#include "qemu/target-info-init.h"
-#include "target/arm/cpu-qom.h"
-#include "target/arm/cpu-param.h"
-
-static const TargetInfo target_info_aarch64_system = {
-    .target_name = "aarch64",
-    .target_arch = SYS_EMU_TARGET_AARCH64,
-    .long_bits = 64,
-    .cpu_type = TYPE_ARM_CPU,
-    .endianness = ENDIAN_MODE_LITTLE,
-    .page_bits_vary = true,
-    .page_bits_init = TARGET_PAGE_BITS_LEGACY,
-};
-
-target_info_init(target_info_aarch64_system)
diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-softmmu.c
deleted file mode 100644
index 2b98f65a0f8..00000000000
--- a/configs/targets/arm-softmmu.c
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * QEMU binary/target API (qemu-system-arm)
- *
- *  Copyright (c) Linaro
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#include "qemu/osdep.h"
-#include "qemu/target-info-impl.h"
-#include "qemu/target-info-init.h"
-#include "target/arm/cpu-qom.h"
-#include "target/arm/cpu-param.h"
-
-static const TargetInfo target_info_arm_system = {
-    .target_name = "arm",
-    .target_arch = SYS_EMU_TARGET_ARM,
-    .long_bits = 32,
-    .cpu_type = TYPE_ARM_CPU,
-    .endianness = ENDIAN_MODE_LITTLE,
-    .page_bits_vary = true,
-    .page_bits_init = TARGET_PAGE_BITS_LEGACY,
-};
-
-target_info_init(target_info_arm_system)
diff --git a/configs/targets/meson.build b/configs/targets/meson.build
deleted file mode 100644
index 2ab4d27eaf5..00000000000
--- a/configs/targets/meson.build
+++ /dev/null
@@ -1,6 +0,0 @@
-foreach target : [
-      'arm-softmmu', 'aarch64-softmmu',
-      'riscv32-softmmu', 'riscv64-softmmu'
-  ]
-  config_target_info += {target : files(target + '.c')}
-endforeach
diff --git a/configs/targets/riscv32-softmmu.c b/configs/targets/riscv32-softmmu.c
deleted file mode 100644
index 0829ab84de5..00000000000
--- a/configs/targets/riscv32-softmmu.c
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * QEMU binary/target API (qemu-system-riscv32)
- *
- *  Copyright (c) rev.ng Labs Srl.
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#include "qemu/osdep.h"
-#include "qemu/target-info-impl.h"
-#include "qemu/target-info-init.h"
-#include "target/riscv/cpu-qom.h"
-#include "target/riscv/cpu-param.h"
-
-static const TargetInfo target_info_riscv32_system = {
-    .target_name = "riscv32",
-    .target_arch = SYS_EMU_TARGET_RISCV32,
-    .long_bits = 32,
-    .cpu_type = TYPE_RISCV_CPU,
-    .endianness = ENDIAN_MODE_LITTLE,
-    .page_bits_init = TARGET_PAGE_BITS,
-};
-
-target_info_init(target_info_riscv32_system)
diff --git a/configs/targets/riscv64-softmmu.c b/configs/targets/riscv64-softmmu.c
deleted file mode 100644
index 553bd1f75fe..00000000000
--- a/configs/targets/riscv64-softmmu.c
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * QEMU binary/target API (qemu-system-riscv64)
- *
- *  Copyright (c) rev.ng Labs Srl.
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#include "qemu/osdep.h"
-#include "qemu/target-info-impl.h"
-#include "qemu/target-info-init.h"
-#include "target/riscv/cpu-qom.h"
-#include "target/riscv/cpu-param.h"
-
-static const TargetInfo target_info_riscv64_system = {
-    .target_name = "riscv64",
-    .target_arch = SYS_EMU_TARGET_RISCV64,
-    .long_bits = 64,
-    .cpu_type = TYPE_RISCV_CPU,
-    .endianness = ENDIAN_MODE_LITTLE,
-    .page_bits_init = TARGET_PAGE_BITS,
-};
-
-target_info_init(target_info_riscv64_system)
diff --git a/meson.build b/meson.build
index 48da6cf3e6b..220bc7c02b8 100644
--- a/meson.build
+++ b/meson.build
@@ -3761,7 +3761,6 @@ subdir('dump')
 subdir('accel')
 
 subdir('backends')
-subdir('configs/targets')
 subdir('disas')
 subdir('migration')
 subdir('monitor')
@@ -4353,11 +4352,7 @@ foreach target : target_dirs
     endif
   endif
 
-  if target in config_target_info
-    arch_srcs += config_target_info[target]
-  else
-    arch_srcs += files('target-info-stub.c')
-  endif
+  arch_srcs += files('target-info-stub.c')
 
   if target_base_arch in target_arch
     t = target_arch[target_base_arch].apply(config_target, strict: false)
-- 
2.43.0


