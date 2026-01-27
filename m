Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C350D2FEDA
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vknp9-0004AR-Bg; Tue, 27 Jan 2026 13:29:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vkno7-0001vy-UH
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:29:01 -0500
Received: from p-west2-cluster1-host3-snip4-2.eps.apple.com ([57.103.68.65]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vkno4-0003VP-HV
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:28:55 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPS id
 147D418001C1; Tue, 27 Jan 2026 18:28:50 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769538531; x=1772130531;
 bh=bHD6bcGbBg1Zjyih1r9AXWBDXEOfhYM6tzw/D4SnxqQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=GN1qeGX6U7cymsdWKx7BpYpsnZRFNkQCTzeWXpPsdJ+S69MADvDlXuvV425Bk2zjK1InHH9xz99egUDOnlMQeTIGLx52e5cNmyKPh2VqYaMICX26UlbIMngcdwe0P4qknloZPw8HjYuVgZzwPppdRTRrRb4l1RBaGgwc8a3E6hObwbnmxFuwfrjTLsjGAdbYXxPRdHbgcLDNOAJZVJN0O3+sJ2lJmYzoxhZgVbEjnCA3DCQGrutDkMgHFSomrFARYIyWSaLawutSN2Zp4Jmc5vaY3Z8o+rhfgJKsvscWsJaPz97Y/JpIWLmYULiyatMRZMQVaUkaenb/cb7RmpvjsQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPSA id
 7AE351800104; Tue, 27 Jan 2026 18:28:45 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v18 08/22] whpx: Move around files before introducing AArch64
 support
Date: Tue, 27 Jan 2026 19:27:48 +0100
Message-ID: <20260127182805.73212-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127182805.73212-1-mohamed@unpredictable.fr>
References: <20260127182805.73212-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE1MCBTYWx0ZWRfXzZ/+YqKToUSj
 ceJ7kEc16MHzzlujgcmDAcwOfYDFvBJxuyUU1Dk2BpM/S/PFbBVZ8vkIvmQlEU7DIx0ptJl6G/e
 N0W/tpJdlXIe9A5inFi+eETP+sNbyWFvk8bG+bKb3wvkaE0QKxyV2jKaqSdi0S/gNb0220VTGRS
 HqLNpIJQ4N4woBlHheiAS5e5fuUZuAeO/4vzWvLVKIPir/bf0HfkzMvjNvPpDkfg5wDpkZ0uyeB
 R3/6kpijxNoXo8Vz8kv4DEOfjMxHwfWJ9/TkAIL9h2jE8ArPEC4ZVl0KUEMMtuaQ7OyaaGwhmfm
 08HqgFzhTPxU8Lc3/JuWuQTjEqJ6hVQKkA5J2uqvkMcA5oBAwIYq2Am/+wJNQM=
X-Proofpoint-ORIG-GUID: K9NKOXLSGNaCKuqCdXsKXBGjJlT1lW3b
X-Proofpoint-GUID: K9NKOXLSGNaCKuqCdXsKXBGjJlT1lW3b
X-Authority-Info-Out: v=2.4 cv=FPAWBuos c=1 sm=1 tr=0 ts=697903e2
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=yMhMjlubAAAA:8
 a=5-iGLm-LtT_B5TT3xKgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 clxscore=1030 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270150
X-JNJ: AAAAAAABd2011Rn0kKi6rc2P7iz13TDQRvYaTYZ6g/pQBbiC+LRc0fqWVqhbgfNkhBIMIoFlRb11UPEjnjyTSk0/4JvQ+K4K7wUwR3CT/B+ucqEiBDFH9pkBft2rKgkmtE3fGPF0bHeCRl0GXjtMFh/wcxMvsfYrZuzFfNIkLn7hmNc/eTrpsSrEfQhBFcaXwH7h1Yelg0WGHVXirrNvDAT4pCAIKeOxK8nsDLJdcEwyC0B/xurO72Y5Fc8tkQ4A/nqqv2yXCqSBBNfbBSF7ocf5PAGtfO1kEikbZYCMQIAGEmZrGOPvXHX7tsOvI3TQZlEOgtt4M4bZOL4feIVtfSY7AFtfUbXSYNly4BqrwqU4BuKtGCONlVikWlOe5COMxL2aC0FOvGrnRPRGJW4/o/zPLGkXBrLAsvSsD+ilb+lIUnkR9KHjGU56IQnCo4HVRzmAw6XOQ9K0chKnPzA8GXb4LT0vGPWUV1afXjIc4yPAPAGpeBmq8InrjT2N5OeAc7k/hY/wz09foogTW0RXmCYl3j+9u2NBsB+4MoCa+aln+hluuFG2XTFDSpn5+5JvvdCmJvABx5sC681FXXldfMcbvHmJgpcnSZtdt0axrzdh3qZx1cdJXzzqWGcpf4ngjUXjsYzdbgnzQNXdZi2PmPrcvbOG+KeYPN5KIQART2UKABFUtB5tr8qYK+su8X5/Wh+PAle20nRTgPcABZj601C2yDTs+YHbNZjItlUXdprdi+uf4D1jiF15UBlXSVAnc4/vjL+rGneXfou9W6emB2NnXUr79p04ze0mO+Be5XEYldN5ms4sgA2v/BvUAQi7n+NByCFicOHRDqZXFk/07L0NBvrqjUZPNxvPqkU6dD6QHuZshBFGD2EGBgJfU3VZ/iLPypYkr0YmIbkwnkCZASfioIQPVYh4xGOl8wuJU64zxdVyLTKt/CGU20X9ZJ4KWnv8MAk=
Received-SPF: pass client-ip=57.103.68.65;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index e23354235d..ba565ca5fb 100644
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


