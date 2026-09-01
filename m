Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC3AC61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Uya-0002Jc-Cj; Tue, 01 Sep 2026 16:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1UyY-0002If-Qh
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:20:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1UyW-0003Ur-Qx
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:20:58 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681HgRH03980086
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 20:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Js1oWEh/Sz0
 7oya0oFsWgdVkl1V+2S1EN6yqVtXd7p8=; b=CG8Z8gKW0xEupna7g5732HAgDN4
 vqyLrg0haxfhl5wsnJdTurnIezhVXYplyu9yuYZyTnHpo72fvwzDFNjEuXUCla85
 PcLBJtsU8OZSHFVlhwxDVTqEpMa192vlj/TTbLCkEdts013ythONii+c8GIlywSt
 S2HVqni5Aj+z8AeqdEuwVNiwCBeF0WCbKHNQCjyB0qdKM+ZVN62h03KAsCYaKDb2
 W1rxebUUJr95dbJYVR9TqmvVt8ZSskX4S+m5hm3fMORSo7nGQ2GYgwgCQx+e7A34
 ivCZYEg8NpTg7f7M1o7ytdE5BetttNqp+51N2epDiAPRZ5Tjr1KvxHuJxpg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdy9nj5e6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 20:20:55 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e8e864ef0so436226a91.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 13:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788294054; x=1788898854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Js1oWEh/Sz07oya0oFsWgdVkl1V+2S1EN6yqVtXd7p8=;
 b=fQV26dNBLfCHoswUrz+IaZle0QWFYMy8jnnTcIfVQ/ajhYs6RyfM6pMYdRTQMMZ9mM
 4zU+0hkwKiDNk+4MndYRCMM3beZseWqB+138RXxoywDuJX0IxOOZSiA6FSdv1mc7EVDP
 QAn/ppDLHBDpSd1tF09WXdrcbRg9KA5j2Tl6dkWCCKNGLDaCCjMyZH7kWfR3h4jS/tqI
 f59/IE68kS5z+l9Iuzs1CF4o8bgnVcUeSALBuy713U88Qc3tLBhXzL1RG1UKbxrgDbQs
 GrXDNRa4EWL2WFdQjhOAS6pAanRbzTtQrnwhknnT+J9JTNUPRBG/4yVx+JsXcVY6yzQ1
 b2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294054; x=1788898854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Js1oWEh/Sz07oya0oFsWgdVkl1V+2S1EN6yqVtXd7p8=;
 b=eP8iDeH3bBy18Ov/X34KF59PJUAY2ij9zVynYni3DkCuGn3UGpxclAwzRW6VDLnAKY
 WpYYQUbmUF9g5hGgpAB/WuUHQ4EQyGkKML+yHqypkueVS1aOHeTf3TR+7n3kNaZ+bsY+
 gus51Z9l9Y38rL83m3oGK8+8lr3OJxfvVWMbadZIn437ERjPXAETs+XMvZzkyHBMIWnJ
 d9ZtIJBTAVaOnsTay/K3T46DoOD2poFkH7Cotb7j+cdSgp8tmK1AhqcdRX/enuNNryvu
 9fQmiWt2XByoMpcjpo4CtFc+SJsileiDnAWXE6cRJTwuIWE2Bgh2FsDRNnLwYSetuk0e
 COdg==
X-Gm-Message-State: AFuF++lUl/f2BsiQCZaiJr6kstr8VgRhU8hf8bqRVjAL3AcG6w3MnM+J
 OjUFRk0q46IROGbx6vQD3yEK+PmrWOPWI1GHIOmSOTQjsEqXIUIZA4ezjlTZFRSP1hc8jb7/wBs
 tOXgR3pCmQrSC0rnDuSy3cWhOxy73qZWThpoHNviesZWN2Guqrc4W3zHQhoSaslIFtw==
X-Gm-Gg: AYBFou34sJBDV8f/08x6Vz2Jd6EYTCVX6MGT1QK4xb3hwKXk5xwiRxUMIUiUn43+Pze
 e1HrTu+z1EfoIQyoROYadAf5n1bCciFeddZQQWz3sJHFUEGXK8t5i5unn3g2X4fH71ksKK8y4xN
 omC4E7lGXKcvCmkA5WC4zGGf2LVp1iSbcwefqAL4AQiKPp7fCjBkGRGMp0yp/m3ovQ7eelly3OF
 pPJXdDgORb4/+DNlLAa9JO8sgAzKQ5IL/YX0TZ2OpUH5cAGlGh624lu/4YYkzqDpbmNYxY2dqub
 mKBx5DBtRI50qAkW1iMTGT2SHu6GbaTJnjhcLfClGR2XlisChcokdJjAA8QVPeMdg+LbuUuFz5W
 Ytxh3q+s++7n1BzfW79Bi+rIEXYrZVy42l+mwfLzmjJftx4gIrXC+wLT54NU=
X-Received: by 2002:a17:90b:5844:b0:398:e73e:5a0c with SMTP id
 98e67ed59e1d1-39907b6b79bmr17298545a91.1.1788294054449; 
 Tue, 01 Sep 2026 13:20:54 -0700 (PDT)
X-Received: by 2002:a17:90b:5844:b0:398:e73e:5a0c with SMTP id
 98e67ed59e1d1-39907b6b79bmr17298479a91.1.1788294053908; 
 Tue, 01 Sep 2026 13:20:53 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990d7bb9d7sm7734802a91.15.2026.09.01.13.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:20:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 05/14] configs/targets: remove target info definitions
Date: Tue,  1 Sep 2026 20:20:34 +0000
Message-ID: <20260901202043.26532-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfXyJS9F+DFrgnT
 WrGRstqDMjGMS17uyVcv+d/doxptSYwQ2JYaqz+xwvyyZCNTDTI0wHLxAtGsxvmNeJZW/aI0DtM
 4J7uhGI8g35meIkjTlnTJv9/r65oZ98=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfX3Cu0cihvChYv
 71AWTl5btEqsCUuZV6CmOlF8ynjmlA3w0W1m00ODpRjtMTFQNY/8wGPSnJFgMeVioKYU1RgO3lR
 9Avy+ryYMx4vVjajrh3knNG5p/Y9Cj12eIpHgJN5lhlgBOl0yRivk7/e2NEwut2meHGnSHktXFl
 Ou84OnyHW8QEL2NSrgw5clv728k4i7hc8efar+fGsw5HrgY1G469Q1ivgBe0/j6Bu1BH6eawyv3
 wM1p1+YRttE0QZZfrvL6+wFA7JWBbvo250akTFgVUWV0r/PRJzuITO8ghY+a5mfN02whHP57K4/
 EeTiyi93Cpp9hRGJlka9B2qrg7U7HZcsenrPftqXfHJIV4QKSN0eGQp9A5kmMxn2kNnArHn4/p7
 41Dj/td2gcocguEIwXrA3v2JK+iFEN88zrE75aY5upBdsLvuUMjWmc90sUNdwaGIxIaHjF+02To
 QieTySqj2aqh0BCpL3A==
X-Authority-Analysis: v=2.4 cv=e/02j6p/ c=1 sm=1 tr=0 ts=6a9733a7 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=rCt224tj-FXkyGmv2awA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: a7i3ZHiwNLQM-jC2NdMn_3ygdW5z4q3Y
X-Proofpoint-GUID: a7i3ZHiwNLQM-jC2NdMn_3ygdW5z4q3Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010178
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 configs/targets/aarch64-softmmu.c | 26 --------------------------
 configs/targets/arm-softmmu.c     | 26 --------------------------
 configs/targets/meson.build       |  6 ------
 configs/targets/riscv32-softmmu.c | 25 -------------------------
 configs/targets/riscv64-softmmu.c | 25 -------------------------
 meson.build                       |  7 +------
 6 files changed, 1 insertion(+), 114 deletions(-)
 delete mode 100644 configs/targets/aarch64-softmmu.c
 delete mode 100644 configs/targets/arm-softmmu.c
 delete mode 100644 configs/targets/meson.build
 delete mode 100644 configs/targets/riscv32-softmmu.c
 delete mode 100644 configs/targets/riscv64-softmmu.c

diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
deleted file mode 100644
index 2200a4f19e9..00000000000
--- a/configs/targets/aarch64-softmmu.c
+++ /dev/null
@@ -1,26 +0,0 @@
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
-#include "hw/arm/machines-qom.h"
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
index 9d558a0c1a1..00000000000
--- a/configs/targets/arm-softmmu.c
+++ /dev/null
@@ -1,26 +0,0 @@
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
-#include "hw/arm/machines-qom.h"
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
index c1d94679c7e..00000000000
--- a/configs/targets/riscv32-softmmu.c
+++ /dev/null
@@ -1,25 +0,0 @@
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
-#include "hw/riscv/machines-qom.h"
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
index f648a5c8944..00000000000
--- a/configs/targets/riscv64-softmmu.c
+++ /dev/null
@@ -1,25 +0,0 @@
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
-#include "hw/riscv/machines-qom.h"
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
index 6dcfdceb507..93d495f09a0 100644
--- a/meson.build
+++ b/meson.build
@@ -3746,7 +3746,6 @@ subdir('dump')
 subdir('accel')
 
 subdir('backends')
-subdir('configs/targets')
 subdir('disas')
 subdir('migration')
 subdir('monitor')
@@ -4323,11 +4322,7 @@ foreach target : target_dirs
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


