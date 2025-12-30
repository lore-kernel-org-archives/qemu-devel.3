Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB42E94104
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 00:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaNFE-0007Ay-PG; Mon, 29 Dec 2025 19:05:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNEj-0006Ru-Vh
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:05:23 -0500
Received: from p-east2-cluster2-host1-snip4-10.eps.apple.com ([57.103.78.13]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNEf-0003v3-Dy
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:05:16 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 C96EA180010E; Tue, 30 Dec 2025 00:05:02 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=1zFYtxGhq0VuOqIx4HS+RS5UNcitCPNW8rhTvyPPr5c=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=EYzJp0RU3Bb8SAL2FmJHM42HchCAffPCg2NAopl6NVduPKc85MuHr4Xws4nD9R2CSidYLNdIFXRHxhj7ga3D7I5gO3lMKssgzMOjq0KtH2DKQ4oGhxE8kbOzbFYUK9lqNGxbafh6VEVQNBXaN2K1u32EYwNmTOV8DH4g95RlU3i2XerxhphMuo+TE4q70xJVF8MUqkN/l2L6NP49e4tRTYeUmTWb/EG09MFdNu/AnfuuAI+sM0mhDCkJHD3F43w3QHykMrpb4J0NMLO/V/+hGG7PcVBbj4ZKMJf3pPAFSDYF3o/JM0KtSXNmIuPAuAeHAOYkq8NFt6KRVmoo6lALXw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 8B7B3180046E; Tue, 30 Dec 2025 00:04:57 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Xu <peterx@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v13 10/28] whpx: Move around files before introducing AArch64
 support
Date: Tue, 30 Dec 2025 01:03:42 +0100
Message-ID: <20251230000401.72124-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251230000401.72124-1-mohamed@unpredictable.fr>
References: <20251230000401.72124-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDIyMiBTYWx0ZWRfX80WOdJuZspIr
 7bl2Wkc6QVY5DRnEitUsFyhtmqONXlkQaCcRKMsDzniSrIJTiXjJgdRQ2rnyZCjtlBB8zidOZWA
 1qAfVg/u6hJUN3yNEd3lkmrIrf8GixNJCbeZITIflzoyyVYPqt7LwxdjwcLze+kA/dmMlhSQedU
 SAelV7QsgUh8op58qH94g1B0eTHE8c4HSm4w0Y5q9bJyRK6OOQGiPaksr2ixTTkj1QaIlQ3x1U8
 2OAwZ18+6XU5sE91LtW1plT0ClbRUnycRk1hgZ5q2b/pJ/2Bk/wkRd/OXUGXb+sW4lysIHTLaIM
 q44dfGQk973nkB8YRO6
X-Proofpoint-ORIG-GUID: swzBjZ56bxAyAeL9YLic-rR0bRHaViwX
X-Authority-Info: v=2.4 cv=RfOdyltv c=1 sm=1 tr=0 ts=69531732 cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=yMhMjlubAAAA:8 a=5-iGLm-LtT_B5TT3xKgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: swzBjZ56bxAyAeL9YLic-rR0bRHaViwX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0
 clxscore=1030 mlxlogscore=999 spamscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512290222
X-JNJ: AAAAAAAB0pDhyk0YfV2Mcq/Ay5O97pftrHRAjitlkPlL0M3DTxkpsxBrX3eY/p+tzwzfnGNgN/oWWcmmlANUSaJTIm9yUbMKz+X9X4MKUOPfqwDVbI4oIUezIhymj4V8eg9ClzEh9FM/e4NH1RxGYiEPROPYLBBtmmOceCq2Ph8ZzaZaQBw3suhu1eI4/1mwPLEQ94ZriDDCgZRBN3Kdacy83vMzzE/l5ieXpY6q7esSYGwDQ/cNG7GBFhPbYQUsphirSyETLlId4OlvQx4T/sxWGQLzMfyHb/QYytpDc6bLkvB0scF7K06bHMp0ZxsfoHF7d+70UUa0bLbzy3WXDCA2E6ow4HnJd+u2e5bgDPwPw2PkQPnp1/hwyuyLqXxRDJD9VlhfirU2OkA8MXNWdpbukq1WF0a8l5nmOO1Gn0LsFlUU6Mj9VXN+QZ+iGYmCq6Zf+McskGgEcdcLyHee7l7mIDBk+SuuvdQHqEkxx99xnFvBrygm90QJEQqJhXLqHOBy2G9JsxQgTsfzBCNYMppRSWrWYGQOhSDXA5mpnxkZOSVT1DDlKA737P8LhsswxOQA2ka3HShbKQ5H195D80csRPRCzNBmtMFV1d8PwSw46syttKluGCRFZwNYxGnP/8vt5YXT0mhtNu4zyDKiB/t9sVE6XKVLGstC+VByTwd4v6fdva1BN7M7KahHADmUTRqibk3hf5VBhr9Mzj813xFs4Qpssc4lkZWxax/j2br2f7CvB6pIs/1WivvKNvN+jTJurFmxsKgXjl9xSvZfHqizhoRfTvdyTdWUmnGE+gAu2MdwJ/cLS02MNXFlH+bRgNaWmCWG9Mw0Rq+232HT6711UlxqKfjgMtMQjhmhxQ+WzaKATbePE99voRb7D7Hj4YaYTg8qXhoZrJSj1CSHmZIVunQPAVJP0zV1RZPf64cj45Y+qSgGOv9Wz5fS+prmu/0E/lFzr0hBqJdpC/qSnEBSpA==
Received-SPF: pass client-ip=57.103.78.13;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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
index cbae7c26f8..6b045fb3f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -550,9 +550,11 @@ WHPX CPUs
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


