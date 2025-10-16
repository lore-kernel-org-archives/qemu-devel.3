Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6A5CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 17:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Rw9-0006Mx-Sn; Thu, 16 Oct 2025 13:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9Rvx-0006HA-KD
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:38:41 -0400
Received: from p-east2-cluster2-host1-snip4-10.eps.apple.com ([57.103.78.13]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9Rvt-0007dd-Vi
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:38:37 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPS id
 6CA6A1800141; Thu, 16 Oct 2025 17:38:29 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=/6NY7U3Atkanr4qfTcQ0H73EJM7+21eqXZpVtymAXL0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=ELIoXM0MsTIRC3rXtmRl3FCZbuGuLO1OngpHMd+pPbGVLdwCZ6/LtwtZsmEGpfngjHxmxQQw5gLVf0PM4ejs/SSjGGj0VSLwjouuBg7DutiOgRRRmgefEM4a6J4a6oVwNzAJ/N22CHqVG/dSixVB5GqsKoUEgRh1C63oMT/8kB72D2kDpF9Oqbw59aOdfdhBlZatIn25ycqB2uDinrw4Ij8aUolGDVlGtKd/u25S19rs8Fv86xw4LZ95xgNCeN7iZYW8gYoHE+8cA4WZ54pI0SwikCL6HI5olodVVHdUgOIk1+STkxOBfVEBKbiayJzMDvkOjhtQ3NZmvMxS3pYsVg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPSA id
 C0E7618002D2; Thu, 16 Oct 2025 17:38:25 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 Zhao Liu <zhao1.liu@intel.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 06/24] whpx: Move around files before introducing AArch64
 support
Date: Thu, 16 Oct 2025 19:37:45 +0200
Message-ID: <20251016173803.65764-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016173803.65764-1-mohamed@unpredictable.fr>
References: <20251016173803.65764-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5rFM2QL64ru08HDO5gW3wzY0GlFQAZ0F
X-Proofpoint-ORIG-GUID: 5rFM2QL64ru08HDO5gW3wzY0GlFQAZ0F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyOCBTYWx0ZWRfX2LQLZ8Hblrqn
 TXcL6R3t4yebby8PjIHNOePNix5EKmHMMREN87JPyWRd0fpN8iU/dieeTGFJdv2kq3W7yRhDt2z
 Y+QAPqDkiqns8dpflgjELvg53TgW4k6/qhZnTsTlxsXt4Udf5WgTKLFldQ/+hSbks0pKr6FbhQC
 nT6kh34wR+Vsg8xIwKSQCpvOVKa1sfcgy8u028oS6oTJdEL+jI48GV8i+sgXHl82LDj8zWvs7U4
 dyYA0s1rTm05zf/U8yqHQ+S7879WfXP1i+EhN3AwFJY5p9jo6+jH4GOn5LPQgT1chr8Bvf0og=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 clxscore=1030 suspectscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510160128
X-JNJ: AAAAAAABRPGaJD7x4pIs3HKmoeUPAYRAVuhrIQGyhpCkHpAl48BFwD2Nq5bAVp9w+C4fQQ9eXwKHzRhlnpPr2zpQHtgfN+J0bs1efMR3tMJ25kXiW5WuYlVOsRDkUy/ImZzb0rU8It7GoTND8eYc09+/PE8/jp4Ow6xlT7zOwWecJUmbhHGZO0Y86j+bzdxksopCDQHI4LiAB+dza6/nJkORt/wosJBXKYOnBq2gNJfuFc8yvisJcPP9rZUPmm1YDVeIPGGV6k+RyZysbcmsjTPWXhh600lK9uYHGPRebjuCYfB6ttW7CPs34QbBXYtLPkfm27gy8UeyoXraTpReW4Jv3a+5gcFLqrrxSkgxePT5GT/0l51OBtP4vJ/aoUX8FfzRYh2xW5Z2LllaWyGVhmJxTI7mPB6FoMcD1L64pWRMF8l2RllJ8wCQ4/gggRSG2yisHTIvx9XTi5FCeQATmtFhCWH9H9A0hKDhA24TyelMM/nmGnoM79uFaQu06eNLRCayyWQhR9S8JWI9ups9K6xP33JkqZ1fa/xnHQV06ky3NjnfTOE0u57mKTPFaQpf0WYo+K37GXf9r2M0cCqkg0bp+B41NWcHGTq7KxDDADhoiX7MOLNspv5pqdlPONXqWfXFXdJGaE14ms2LWz4C7FZ2M0w+CZ4h8Jqm0pWCL6rRA+Qv611I2uPlo8Y/MpijHEPEU640vF1WzjVaTdhyBDeay9ZVgkS6FsFToz3+JkxxYNIHKrW8HNiWEC8AXPzk9lp/oGt2jlgWNUwZkgkAO+9p+WIHoUc5x9h+b+L576HfJeb7Mi73tXKy6xrv2OaSgn0R8BPRF0+zWjDF8kE3mEjIGNHG4MPCzSzuyVl3Qkkz3onfJml482y7NrfRZk6EjYMx5JY7cX3n+G38UYiyvVhFbtDmYsTgtY+JdiEanhecxw==
Received-SPF: pass client-ip=57.103.78.13;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 {target/i386/whpx => include/system}/whpx-internal.h  | 5 +++--
 target/i386/whpx/meson.build                          | 1 -
 target/i386/whpx/whpx-all.c                           | 4 ++--
 target/i386/whpx/whpx-apic.c                          | 2 +-
 9 files changed, 19 insertions(+), 10 deletions(-)
 create mode 100644 accel/whpx/meson.build
 rename {target/i386 => accel}/whpx/whpx-accel-ops.c (97%)
 rename {target/i386/whpx => include/system}/whpx-accel-ops.h (92%)
 rename {target/i386/whpx => include/system}/whpx-internal.h (98%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0c766961f3..c25e22ffdb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -547,9 +547,11 @@ F: include/system/hvf_int.h
 WHPX CPUs
 M: Sunil Muthuswamy <sunilmut@microsoft.com>
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
similarity index 98%
rename from target/i386/whpx/whpx-internal.h
rename to include/system/whpx-internal.h
index 6633e9c4ca..e61375d554 100644
--- a/target/i386/whpx/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -1,5 +1,6 @@
-#ifndef TARGET_I386_WHPX_INTERNAL_H
-#define TARGET_I386_WHPX_INTERNAL_H
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef SYSTEM_WHPX_INTERNAL_H
+#define SYSTEM_WHPX_INTERNAL_H
 
 #include <windows.h>
 #include <winhvplatform.h>
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
index 256761834c..106a352980 100644
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
index e1ef6d4e6d..badb404b63 100644
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


