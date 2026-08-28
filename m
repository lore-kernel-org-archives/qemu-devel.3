Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74494C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Xt-0000GM-Ev; Fri, 28 Aug 2026 18:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Xs-0000Fx-EB
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Xq-0005kH-BG
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:36 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTBx4144941
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Js1oWEh/Sz0
 7oya0oFsWgdVkl1V+2S1EN6yqVtXd7p8=; b=MAnOc2rwcKuU8VmRkYAzJ1yqVLt
 kAkkBxO5SDUQ4ad9d8q4jsfy7eXsE92xulJAhht/GGWYPENSTDoz+L4cpr8l6cIv
 Jyrf5I1oRnmCnyES/SPrrUCB8CKIuXF9DNRKyYI3YjbhD/cweNjkSdzF+1HT+k45
 kfVZAu4VqxG0z/aSA3PewVz+3zFgvrDd1ze8NVFEaOTsyHcnQQNTwB8VjZVfo5+S
 HYRPRYC4oASACKuh+2/EJuFPLbuDpPlqxaRyEpYdRy6c0Kx7zJkW4+EBUFT3gCWZ
 tPvTrIkJKXQTxVzgNoXVwe/woStMbqp7ftLly0jIc511vGhnEq7+qpQstEw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb7eh2s2j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:22 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3968bb86fb7so2208321a91.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957962; x=1788562762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Js1oWEh/Sz07oya0oFsWgdVkl1V+2S1EN6yqVtXd7p8=;
 b=SN4IXXsXpVdUqKQShKS3C12g2DeA5/vaO5rt2vVgqHMM7Ik7STuVeLGJ2aJxlKPOs5
 0/auXywnoZAQFNmCMl9Yqo2qvxSy/UTQrFID8fE+YPimnszlT3ryBi/x9dJaZoANvyyw
 SkOVg/A8HG1X8PWjO480BWgxGKMNT2ZoT18oDzxHoill8fKlHHXGG23Vy3h1XnxB/Lnl
 raNB3kgwuY6ll4UrnrhYYiZzGtdViasZL6/A6VTvPI+4ile4fqeeVLGqlHhhvyJWhZUb
 fvneIAhqe2cXzBUVQze1kja6UE2A5dDVZ/reKPnD6BxSmEpOM6f3g6p7+brr6Q9lzcDe
 PrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957962; x=1788562762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Js1oWEh/Sz07oya0oFsWgdVkl1V+2S1EN6yqVtXd7p8=;
 b=oZIq0+oWEIgtgEK/eMFsQfCVbgqeup0N2h1uA7extUh9tCguWhqSJIuo2vDwT7QAO5
 4Yulg7SA8tVB2vKKSRK846iBUxcq9sLKnjgmkLOJL1jStYMq6CnM1ru+HWXtgYZ/92lK
 GqXvjRHbinrvOOMoCqREQjJ4KnxtlQaBEPmZwxc5gof/VhbBiZn0YZBJCi6ldkAIEjmL
 Rj6pN2aK03wu4C2iwf7Rpr1oVsuupM38VDwnIePehyT9CW3XitzirHQC77huwNq76YrS
 M7ByY6tM6Oavv5mt2x7z520YH7dkVLiEKApuqi8s95BeZ8HzqlyP0dJUF0u+U6T4/zml
 qKRQ==
X-Gm-Message-State: AFuF++mZyhE+G941wpOQZ05/gCzSYQPYjjkZx/K79CfTpbq7EMrAbGw/
 lrKQftGKT7DvGW+VpmUheQR2KDwniBzBo56+EV0HVmRlgxWsX3OHhzE+8ziVAD09f7zJGA5QhD5
 Ec8kUNUcJnrSAnmbLGEF0fM44Z7djxl7yZOKWzlCzVl0WUK8HJYjwyENFqDNTlKzRBA==
X-Gm-Gg: AYBFou1/BdsOB3p1NhIWLMZy+91XTl4TJxEhkvwQwPr3S5pasbbf2rKbk7nlzDs6q3Q
 /Tka4wNDqf0TXsbf+yRt+hCwcML9+drTvoHQO/s2W0ZPCVc2TVCJYIalPYFK0Uik1yboVZNhB5q
 l5sirFa8hoIAordoq0OrB6AdQAEqyIsVRgwkc+olnj3pl9vhx/DphXeAqe6vP+E1Q6GYl288MkO
 /b/TBKx8ALdcSll/x0H5oOqaAwfvor0EfwRR7JhdeWPAfWLdZ09Cbk9vO19t/vxuFSTmVQJXuTH
 cR6dsGy4W7+13hUNYjB4VwiHYyHe9fqonMrmuyPF5T2TKdV9B7t3QrH60HSivEowzkywuPin9z0
 AtUJlqFCokCqHAVmOT6YDTm08G+W6DFw4CHa8XdUCPbvyxum0l7WeLd/pHrw=
X-Received: by 2002:a17:90b:4a8c:b0:392:6638:2e6a with SMTP id
 98e67ed59e1d1-396d0f69d10mr15339203a91.13.1787957961929; 
 Fri, 28 Aug 2026 15:59:21 -0700 (PDT)
X-Received: by 2002:a17:90b:4a8c:b0:392:6638:2e6a with SMTP id
 98e67ed59e1d1-396d0f69d10mr15339147a91.13.1787957961402; 
 Fri, 28 Aug 2026 15:59:21 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 13/47] configs/targets: remove target info definitions
Date: Fri, 28 Aug 2026 22:58:27 +0000
Message-ID: <20260828225901.367438-14-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dc8N1N-s9fb2m5adWEqYPW5iEg_pDRTW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX9G2QLX/FHvLb
 IPcRsQ0n2tCqqwY0X7nqc8XM1fdoOGo2WLZ32js/tpDgLYlOfaSJR8zafzrrFHvhGIDcwPpmeLZ
 bFg29yhaPKjCQwVEY5bWA5AlWDE8dZMExYakxrPx/u1gaHL/wl6wf7DqrPIHKZSKI3Tnaqq0zqX
 7GJ6j10+0C5qOTJn906GJe2jBwvQ2/WGlJo7VQ1ACgnPIco3x0Ww3Z89dPGUFzGxKDQft4rd+L6
 WWX12y55ePiK+nXSO3crR4K/hbpBmqyl0J7/0EuEx1dbjhTfGBIYFMXRITTKJfAdba0LogpZ7cP
 edDffgssNhYQ4n2wSbMaWYZFjK+5otMdYk1F1wfkLqLIzUmVRp4ShgWQZ4bbC60lB/rNkUm4yLC
 iQMay7jukndO08VIpbQ5MG26qWpbdnEl5YKWQ4+T46GSZHVjrE8eNZ1Yf0H5J8O4Okw0SqDxZqr
 Qy+QM3gSdfSUF/Wyiqg==
X-Proofpoint-ORIG-GUID: dc8N1N-s9fb2m5adWEqYPW5iEg_pDRTW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfXx2+6lHsBp49L
 ZTqePIBEd7abFHD+8I/7jwXbQ+ZH/qC97fMTiy7zR3AN/ZvQar3b2wgkSlVW9N1oTdjv0BBJ4KC
 4YroUpwEyBvA9TR3CR9cGryuEpiPqxo=
X-Authority-Analysis: v=2.4 cv=RoP16imK c=1 sm=1 tr=0 ts=6a9212ca cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=rCt224tj-FXkyGmv2awA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
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


