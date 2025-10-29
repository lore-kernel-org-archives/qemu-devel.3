Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D08ACCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEA5O-0003VS-MP; Wed, 29 Oct 2025 13:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5K-0003UP-Qy
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:35:47 -0400
Received: from p-east2-cluster1-host7-snip4-10.eps.apple.com ([57.103.76.73]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5C-0003JZ-8I
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:35:46 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 36A9D1800316; Wed, 29 Oct 2025 17:35:21 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=tZPXOL+uIWMOEt6HxsooL4DtZPhoOOqc0cyEH40+x1w=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=Ad8dYuLjDBlQ5Z5K6hZq5Cnp8i8mnWqdjOQi+KFBw14jKpe5jr+Emg25OO0H98lc+q4x0yMMBYjxv5yhslA2Tjhc8PPaFEHm6V6CaScy2tEoWzrapkgnG7wIAWfLzF9hg+pD0Pazxrpf9XPjcAllwjS9C5v/RTyk3RdtZ8WS/BUJKqPw0pVwLvNi/VAN9MxFMY8UAq1ABoTaULF24A7iA+Yk39jgU94nc/76S/tsV8fyG4sF1LpccXz9LG4Ox1tePJW2Qt6+imzXqsmMvXmHkitbpRe5Am6t98OD7x963DRBXJ5AYVdfEkWDhHYmc7WRVFyZJcO4jr1XVx49QHYkgQ==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 904071859E44; Wed, 29 Oct 2025 16:55:26 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v10 06/28] whpx: Move around files before introducing AArch64
 support
Date: Wed, 29 Oct 2025 17:54:48 +0100
Message-ID: <20251029165510.45824-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251029165510.45824-1-mohamed@unpredictable.fr>
References: <20251029165510.45824-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDE0MCBTYWx0ZWRfX4HLaR5BZtoDe
 XkgZjfLOrYgNJUw8hDBcfIT5iQ3WDBPKJLbP27ffRUEmLJZVilUxlGzbXpnTkTnHzcQiDZWqXkt
 TEXpcH7T/vlmXF65zw4XSdlycoJyeLU+ChnATv2pmltqlD2+mK9ZN5lLV8Xia+B/Zvl2SdzmkCi
 /rff/d8WfSRQEdvw1TWyXuJ6YR/xAUGKo1941fRs07c2Mx+QHgiq7PNwPAFU4c+J0Khwvz53IH4
 xgOmXpMvd+RF1pbqTeRHJ37JCnMlOwDhCOywYgi1qMdu8zGKsFtEE3UZhIQm9VdidVh2rBOo/Um
 fL9Da0xDb/6HRDa8GUI
X-Proofpoint-GUID: ggOxSInIvkevspp9OhMgksOecCBTRiJz
X-Proofpoint-ORIG-GUID: ggOxSInIvkevspp9OhMgksOecCBTRiJz
X-Authority-Info: v=2.4 cv=WfoBqkhX c=1 sm=1 tr=0 ts=6902505a cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=yMhMjlubAAAA:8
 a=5-iGLm-LtT_B5TT3xKgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2509250000 definitions=main-2510290140
X-JNJ: AAAAAAABuEyOIja3iIA8lCGzPc9CDsLvSxoSYPT/sXBoqEKkFwgmjAefNWbWjsEl9hFsoU5DUIBbpOTmolLhCbCLwKOG64iwSTqNPZ3hdYQ9OnAkRcvrbuycdE5YHkCrQLWKVUm3Vc/Yu44nWAD0ysUu8iqgE/ok1VWERdqQZI+lH4LCP1dLu5vxKPPgM9pG4qK/qYCN0qxl6DruHS37MPpBVkc7P6fYgUiDtqVjWQhLgOkKPoCXbV+QXPsNvQE/tf4Q7apjUMUbwFcA1+Oa9HGjVM44DpVB1UDg+8X3apu9IIrBZO2ldZJ9n2JczE1eW7WYRMYkiNxWWzH3pdoj9M9jBXnQ7HDyaC+5Qx/y0cM8Rq5UvzDAdSd/pvz6izvzDvjWLBOvvegUuP+ZysKkd1nzRfHYR9iYhRz+i1h8qh5wmS7uwBqFid5ZwEQLReKSE+f2pU3G/vDOAu4kq8pBGu13yhe3nGiaOqCO3jCjXX3NSgpuCOIviZFOxJWO1s6Bis3CAhWiPee3ptUoFgvKvx4MUBDR03xYl3RZiIFhRaPO+wnQwEo2m+3JfBf9KsGSiKUI1FR/bwLGcLD0GM3XUzLzMdVcU3sS1vbdM1rAHILYLDjiWfD6CimRR3y8T9M35IbGqfOA9BLFoacDc48s4udYTyqd0Mrl6tqSMqopOBqNcK19aqr3ERIOtg2HOvM75FNeL7mRSOmRvPMMtskdiou8Ad1x89Inl6PKoaBdGzAnmutAEMvHLWz7khoScsU4jEnoHYw4+Xb2rxiG9IfLPVgQBg==
Received-SPF: pass client-ip=57.103.76.73;
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
index 64491c800c..4ea4c48a2a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -549,9 +549,11 @@ F: include/system/hvf_int.h
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
index 2dcad1f565..c59f9de091 100644
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
index 6bf8d5f4bb..c0bd429d19 100644
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


