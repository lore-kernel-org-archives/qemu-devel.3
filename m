Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08208C44532
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 13:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viYSq-0004d2-T6; Wed, 21 Jan 2026 08:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYSp-0004bC-NC
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:41:39 -0500
Received: from qs-2003h-snip4-11.eps.apple.com ([57.103.86.83]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYSo-0001Ci-2O
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:41:39 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-14 (Postfix) with ESMTPS id
 5E616180017A; Wed, 21 Jan 2026 13:41:36 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769002897; x=1771594897;
 bh=cLf1mPRjZV91P2OvpEcC0kLLM+MdbbjlqvarB0If30I=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=KLcq3UVO1jjqPIw/g+Az4naxejMXBqXxBzxAG5TbdLaEf6GfcMw9k3WWsN7yBJ9IoEG5q9PxtUziTaJCRQbtDZVsCLoRGijlyQpgCTmzukRdCEhVTqhMaYjYaz0pVrzWvYAGKLNtADXsgrz5JzZU/BcVcQn9PrwsghkLoS5PJWoPq7WvhU/DuXF5XUyWeDgrT4uv4n+6XYbYdXz7nCYIK/3Fvwg2AolDy3XAs7qE6yPfetVXqsFSfmyhSUpbraSvFBM+NF52ACfPmksLngO6JnLiHYzvlR8su5QgehU2ikFvHKuGSrS7HsixM2F6g6IWXVzY9MjGzqXLIQIbetflCQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-14 (Postfix) with ESMTPSA id
 850BD1800187; Wed, 21 Jan 2026 13:41:33 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Ani Sinha <anisinha@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v17 06/21] whpx: Move around files before introducing AArch64
 support
Date: Wed, 21 Jan 2026 14:40:57 +0100
Message-ID: <20260121134114.9781-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121134114.9781-1-mohamed@unpredictable.fr>
References: <20260121134114.9781-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=Vd36/Vp9 c=1 sm=1 tr=0 ts=6970d790
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=yMhMjlubAAAA:8
 a=5-iGLm-LtT_B5TT3xKgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: -YWwUkwuw_2cYH3A23i16b5YXicudHUn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDExNSBTYWx0ZWRfX8EVhpYJb47cC
 EuXYgSy/cqcKrBND35Sp4xLp8ixdx1Bj75JSAsJ2ZZPlZzspWxayAGpnMvixfua5K1sJwiQyjVT
 Prv/q+1tWxEKrwcTJ7AyWuvjLv746bQM7F43UnHfGwqiBbpAya9kTgI525DPpUN1OHxJQvUcVmi
 FUifGQUGnDcs3okz58IRg1R86yKvCAf3DuyUT21r+gcJZbC9MfKX9sHPjhQIS0AdLTmH89ufEjn
 x6a9nOdt/qVe4dWoSkv191/6Ec/jcDjMshqf5u1xqzeC2O1n5hYaqGt6qRBVo4yvipWJJfQRG1e
 pSGYHNVGG1+DuHFj/+O
X-Proofpoint-GUID: -YWwUkwuw_2cYH3A23i16b5YXicudHUn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0
 clxscore=1030 phishscore=0 bulkscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601210115
X-JNJ: AAAAAAABU8+voHRh7p42JdWl974yV1UphmgjkGAeCTT7NlI3qd7yN2QIG0ktDfm+Mxnizc1AI3pef098NWzkk++VzFY658X6M1hOgRhpK98ziMvchdd01LLhKaIThYYURCf6uLLaQyR/BznvVF2D+Inyx+SQ6kFRtxrMexIZ3UByyokV6W3+amJURWQUZqDqce6kgwOR9IrMR22/5qX/QEAMzA6NksQ1EHWOxUHHwB8fywAhq4wivuKTduXYCwlFNBVQPsnGgygTX8B5WEy2IRc92S2zeo8W8teZQgxMKVF9j0bmNiqvb7ehncfANQM/pxmwj7u9Hi1GLTt9Dbk0yVnLcz1iw/WZ3PCV+hUrO8wLXydONzAtRGXPHgIQJUf5Y1Fh1LAEnT+tx1FST/gQ+TTxGjB9z0upYYVis7GCR5s2e3FTQM6TId/IMKQEJ/AjkpH0VPYCNT1w6UvEbZevh6IMndudaXk2y4hYJkkB5LWldVqeTEmDCZ8Wb4zuIYgl18KSx8Y59nVWm6Nvfz1WVyS1C18xxSerNik2zHUwwQmPFYI7+9LNEbdV8RcTIQPrFeekN10bjFbdvzNSKkpfWyw0jOtFjFv/q29xDWjOFOp0HIR9gs2lhx7q4OM1jt9UwuFwGnbld+HvT6cahzY2cUqmikTmvg++SMa44brkOXElh2ACat6QWUlkfAJMqoMEmJdFBea1QPYQT22Rerj2SZLdlIVeO4F0GaLc/k1k0wntqgk3uUI1YTAR5r5pPrhfeTUhExbDfWqCnCVinmF2VChKJNwbbdVF3QJUXOU3Pc9dFKkp/CtdQy4zwHnmMvFuuHJrLklxyonn7L8wV0kELXRnxi2JuIo/JiCntJOYOQP0vuHI4HhCQCkNEIfd8DIOL7t5Lg4114o4tSpCdxKdRO+5++g+ag==
Received-SPF: pass client-ip=57.103.86.83;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Switch to a design where we can share whpx code between x86 and AArch64 when it makes sense to do so.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 MAINTAINERS                                           | 2 ++
 accel/meson.build                                     | 1 +
 accel/whpx/meson.build                                | 6 ++++++
 {target/i386 => accel}/whpx/whpx-accel-ops.c          | 4 ++--
 {target/i386/whpx => include/system}/whpx-accel-ops.h | 4 ++--
 {target/i386/whpx => include/system}/whpx-internal.h  | 6 ++++--
 target/i386/whpx/meson.build                          | 1 -
 target/i386/whpx/whpx-all.c                           | 4 ++--
 target/i386/whpx/whpx-apic.c                          | 2 +-
 9 files changed, 20 insertions(+), 10 deletions(-)
 create mode 100644 accel/whpx/meson.build
 rename {target/i386 => accel}/whpx/whpx-accel-ops.c (97%)
 rename {target/i386/whpx => include/system}/whpx-accel-ops.h (92%)
 rename {target/i386/whpx => include/system}/whpx-internal.h (97%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 36a2be3ddb..7365094cd7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -565,9 +565,11 @@ WHPX CPUs
 M: Pedro Barbuda <pbarbuda@microsoft.com>
 M: Mohamed Mediouni <mohamed@unpredictable.fr>
 S: Supported
+F: accel/whpx/
 F: target/i386/whpx/
 F: accel/stubs/whpx-stub.c
 F: include/system/whpx.h
+F: include/system/whpx-accel-ops.h
 
 MSHV
 M: Magnus Kulke <magnus.kulke@linux.microsoft.com>
diff --git a/accel/meson.build b/accel/meson.build
index 983dfd0bd5..289b7420ff 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -6,6 +6,7 @@ user_ss.add(files('accel-user.c'))
 subdir('tcg')
 if have_system
   subdir('hvf')
+  subdir('whpx')
   subdir('qtest')
   subdir('kvm')
   subdir('xen')
diff --git a/accel/whpx/meson.build b/accel/whpx/meson.build
new file mode 100644
index 0000000000..7b3d6f1c1c
--- /dev/null
+++ b/accel/whpx/meson.build
@@ -0,0 +1,6 @@
+whpx_ss = ss.source_set()
+whpx_ss.add(files(
+  'whpx-accel-ops.c',
+))
+
+specific_ss.add_all(when: 'CONFIG_WHPX', if_true: whpx_ss)
diff --git a/target/i386/whpx/whpx-accel-ops.c b/accel/whpx/whpx-accel-ops.c
similarity index 97%
rename from target/i386/whpx/whpx-accel-ops.c
rename to accel/whpx/whpx-accel-ops.c
index f75886128d..c84a25c273 100644
--- a/target/i386/whpx/whpx-accel-ops.c
+++ b/accel/whpx/whpx-accel-ops.c
@@ -16,8 +16,8 @@
 #include "qemu/guest-random.h"
 
 #include "system/whpx.h"
-#include "whpx-internal.h"
-#include "whpx-accel-ops.h"
+#include "system/whpx-internal.h"
+#include "system/whpx-accel-ops.h"
 
 static void *whpx_cpu_thread_fn(void *arg)
 {
diff --git a/target/i386/whpx/whpx-accel-ops.h b/include/system/whpx-accel-ops.h
similarity index 92%
rename from target/i386/whpx/whpx-accel-ops.h
rename to include/system/whpx-accel-ops.h
index 54cfc25a14..ed9d4c49f4 100644
--- a/target/i386/whpx/whpx-accel-ops.h
+++ b/include/system/whpx-accel-ops.h
@@ -7,8 +7,8 @@
  * See the COPYING file in the top-level directory.
  */
 
-#ifndef TARGET_I386_WHPX_ACCEL_OPS_H
-#define TARGET_I386_WHPX_ACCEL_OPS_H
+#ifndef SYSTEM_WHPX_ACCEL_OPS_H
+#define SYSTEM_WHPX_ACCEL_OPS_H
 
 #include "system/cpus.h"
 
diff --git a/target/i386/whpx/whpx-internal.h b/include/system/whpx-internal.h
similarity index 97%
rename from target/i386/whpx/whpx-internal.h
rename to include/system/whpx-internal.h
index 2dcad1f565..041fa958b4 100644
--- a/target/i386/whpx/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -1,11 +1,13 @@
-#ifndef TARGET_I386_WHPX_INTERNAL_H
-#define TARGET_I386_WHPX_INTERNAL_H
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef SYSTEM_WHPX_INTERNAL_H
+#define SYSTEM_WHPX_INTERNAL_H
 
 #include <windows.h>
 #include <winhvplatform.h>
 #include <winhvemulation.h>
 
 #include "hw/i386/apic.h"
+#include "exec/vaddr.h"
 
 typedef enum WhpxBreakpointState {
     WHPX_BP_CLEARED = 0,
diff --git a/target/i386/whpx/meson.build b/target/i386/whpx/meson.build
index 9c54aaad39..c3aaaff9fd 100644
--- a/target/i386/whpx/meson.build
+++ b/target/i386/whpx/meson.build
@@ -1,5 +1,4 @@
 i386_system_ss.add(when: 'CONFIG_WHPX', if_true: files(
   'whpx-all.c',
   'whpx-apic.c',
-  'whpx-accel-ops.c',
 ))
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index db184e1b0d..cef31fc1a8 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -31,8 +31,8 @@
 #include "accel/accel-cpu-target.h"
 #include <winerror.h>
 
-#include "whpx-internal.h"
-#include "whpx-accel-ops.h"
+#include "system/whpx-internal.h"
+#include "system/whpx-accel-ops.h"
 
 #include <winhvplatform.h>
 #include <winhvemulation.h>
diff --git a/target/i386/whpx/whpx-apic.c b/target/i386/whpx/whpx-apic.c
index afcb25843b..b934fdcbe1 100644
--- a/target/i386/whpx/whpx-apic.c
+++ b/target/i386/whpx/whpx-apic.c
@@ -18,7 +18,7 @@
 #include "hw/pci/msi.h"
 #include "system/hw_accel.h"
 #include "system/whpx.h"
-#include "whpx-internal.h"
+#include "system/whpx-internal.h"
 
 struct whpx_lapic_state {
     struct {
-- 
2.50.1 (Apple Git-155)


