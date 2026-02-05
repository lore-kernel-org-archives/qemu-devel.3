Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B835EC1EB5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 13:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnzA9-0007ho-DC; Thu, 05 Feb 2026 08:12:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnzA4-0007gy-1U
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:12:45 -0500
Received: from p-west2-cluster3-host6-snip4-10.eps.apple.com ([57.103.69.103]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnzA0-0001ZN-Qr
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:12:43 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPS id
 45F4618001EC; Thu,  5 Feb 2026 13:12:39 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770297159; x=1772889159;
 bh=sO3DeOdDF0q2emZBYAvL0FcscHw/mIyq8LvXFFYHnvo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=FyBZ8VCdJK27P0AVzn22qPYFR4KbQGKuN820WzY87O7cqT9VWC6AgkIS4ICRHSUGaxonVj8OcCGSxtQE6J5NMNyr6AWPun4ceb1paPBJjvQWAd9CXI5HJEaJJXSnGBmiczHtUJasLY1kxgqkCEIboZPDwE3qgaEHkuF4stJ1lOdhqNPwOCx+znmFR91cEjnIoECoQEVVBRRV9JdlLXDHEegPpYAVuYR8HK5QQ16Z0ZrrJxgIQQVxxC+C+lokX+fuqsarPzywo9gVMW4QDu+UcmWPO3wcicov2zngDExQr9Vr+gn3U8H8Z6xQV3YJBfN5gxFwbFYbffML7EBiaD/RCg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPSA id
 E7B4F180015F; Thu,  5 Feb 2026 13:12:34 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v20 08/22] whpx: Move around files before introducing AArch64
 support
Date: Thu,  5 Feb 2026 14:11:37 +0100
Message-ID: <20260205131155.22780-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205131155.22780-1-mohamed@unpredictable.fr>
References: <20260205131155.22780-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5OCBTYWx0ZWRfX89yKWa830V4k
 6dfiEwMjJoNAxNHbiLRV+wPDUcNRbzMc1roNs4fzO8t/MaTkH78OLfEZ625a4Lcp/c8TEJ+pe08
 wdERTcgeNmA980uJmsXwhS8cRxdTVcabYKG+H0axyopiNjZ0lg0OOyf9bYD/MmUmPGV8frj9KPa
 tqBGHvKMsnI58uXxP4ELA+tH6sl9JcgTDw5cRNCtcwlI3h10CxL0tay2xBv7PczG5zgKYVTv4yU
 qOq/lpxhXwgtclIVUEVQwSj6dj+3IFwraMiLE3lyI9XdxDhrjhwRc9zKIznHhwkNXvjJFZBKoUI
 aoY5bOm232D2AJQv3nl69eSrq/Ebkedx5qqT4VO8hLukn7trroGRcbCr511q9w=
X-Proofpoint-GUID: AH22e0_pX6Lu7sQe84hQJ1N9n-o3Ja8E
X-Authority-Info-Out: v=2.4 cv=c9OmgB9l c=1 sm=1 tr=0 ts=69849747
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=yMhMjlubAAAA:8
 a=5-iGLm-LtT_B5TT3xKgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: AH22e0_pX6Lu7sQe84hQJ1N9n-o3Ja8E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050098
X-JNJ: AAAAAAABwVtYTfRXdjrjtTUQWqjp2L8swZVDteTPftzimfMEPk4Nl0abDhO581gb6iGeCpoUvs3JRg3UTHm2vaKNs6bUQMJIwG7S96MgKhonvUIe+yA8lA/dRXNQw6nqSrxxaSBfzqJz81qXbXAt6FUufSHi+/m09R/dXsPBe2QgrBD9cE6IipT6gRvnpmT4UAQ68wpS6KAZhdVY7bz0jFewD7rhA/v/VRGIiab6d1vofwGkock8+kNaOXO0Gw07IOWxMEGnO+uw2T7OLy+KsIMn6QzWnr8vbpwlzrjXNY9XYYKK/jPLt1TJXPNORSPWmuv9NZxqkBWzhG9t1VTNzzUIQrY4rjt4nUT8bBEZjeeJMhokjKFaInV+VuR513G+0c6Mbvjj9oWLfyeKA51ok1kIlRDOidKXTT/Z6VtlJKNt2o5KVbXUCBvoql/6gMDxRnJCCgCSyfAAi09G/ZXWM3hvUOHC0ojNMiZPGnVqlfp+BRv9L8mnZ1RIfC8Mp/3kh2lQlvaHkoZ2p7bkno8PCJr4ltZVFSaN+sfiwg6lrBXbeSPoLTV7go03OFnCjuTDvZsRxiO+wZne31igzlq9mlRTKBdw6jUlvGGoa0TY9870OcEhT9emJvqjdDe4+/LdBBhZah58WaoaqUVJr9OskaQ3UpHW+rEBZ3bQ6ljn4kUgpRO67fHttVxv/4Knl7xM0H6u+2Ux/uZBV27DLKu0L90lTvs3+AutEjS4wRpSHBkTkj0pUJTcBaiISb7UG2XB5Nq7+05DAghda3G1mqEzdtenQjOYWvsRrARMzoJhiOtG6+tONjVLnMV5MAzVVdQ5HGac22/ZXDjRVJZBE4+qEo9fSP69r06yc9yxnFcxLnFBtXYXundsmN8ghXGXKEshiDz+x8+qgnL+ETq+4wmxEgfOXbRKytttvaSWFEcIKCBPTLWwI5urNQeapymv0wVp08weP0RciUVSKtVttQ==
Received-SPF: pass client-ip=57.103.69.103;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
index 9b7ed4fccb..445b1b9e09 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -564,9 +564,11 @@ WHPX CPUs
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


