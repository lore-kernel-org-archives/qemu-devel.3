Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01593C83F0B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHh2-0000tv-EU; Thu, 03 Jul 2025 07:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHeW-00060E-FB
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:58:55 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHeU-0002zT-HL
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:58:52 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-453066fad06so54076725e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540328; x=1752145128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHMs7nmOn+MVUxcnTbQfOV+3h+SOD8dybVNBbhpVafQ=;
 b=T5O5TXo+Btt7qARZhJm4KMRjMKSmk4oWrSb/HWqwGSEva0B8gNPGG8gPY4Dtx9kojV
 bFtgp+PU8oMeLMtskd9SbqvZ0rT1dLNlofkDgZ42EKUrq5CtO3uCUH0IJUV+JdZt6R0C
 m3Nj5hQJc8Tat+iZvDLjtLi0F5deld4EJVYNDDYrJ0ZpNu0e7HlkJDoSEe4c2N8Tin8C
 OoL9MxeSCbJ/Pn+lnvhuc2wK3VTPEGBmFwLaGx0aSHwhq+TN8yqwZv1aY3VlK6D7FiU+
 EaDs/mYdw7iU+LNSiNeI5P5QHKUUxIqsCOlwXW5nDWT7KLt77aKgZKCwiPRz/zhFlDw4
 wx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540328; x=1752145128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LHMs7nmOn+MVUxcnTbQfOV+3h+SOD8dybVNBbhpVafQ=;
 b=wKey0X4HhBOkAVZRi7cRkMx1CNT08tZVD2j9AHXInncCDMJ6VHCf90oiy9w9oYAH4l
 8XWcd9tNfq2XHeiSnqKAWKoOZexIBqtFp++ZeGvj6VqmST8ogxpiy9N5zEoGq9oU+tnU
 6exPWZc63lmBhbmpJXYJV6qed6kFXqv2Yqy9DOsGsJQayndaqTjPGZvKcmcAQ+FihM3B
 57obmTg3N1A6cGgpVrFAuplCseh9pjZ+6HRyAeZYNhmTxT7Nto05eIEfQ4sdwSRvyKu8
 Yr8daaUxwKXCmOAG48DUzSlzS+QFKuLvNpJdWM+SM3Gw/2KNDODxU13X8I0yxcCeqChA
 TDrA==
X-Gm-Message-State: AOJu0Yz/Pl3SYvIUA483mVqkXgGNpQeSS8l/pXnFkcRUBUe5wLF+27iq
 0SlNbzumk3NZoTQ7lCJM3LRKWylk6ssuudw3o0NvRawVfZ71+DtkGoIHTdjRIMK9rGRpsuoRPTD
 mRrEHfOI=
X-Gm-Gg: ASbGncvUS45qOdlP7HYm7pueG4C/xl2PNKjNv31LBVMGH0okXdz5Rp/e7UpkVBiRm7q
 8rKVJlNSm++gNiY2HQB3ifzNA9g8gZ0H09Q9GmccOpLZcFfMuGXXaXBkW9L1FA8fcw0qo38ocDo
 OJ6RTXJhy//ECvOe9fDzw4OBFgxbZzvsWr/SzuDo/r4O4XQ2gvH05INwytChycNje2YsTFGe5m2
 xYOk9FI0S+RlvJPwEidywdJrVkGiv30FaX9HWUrDcIveqfF57Gthq00GZhUO5BLXMXOW8evfcEH
 B1cTnqwE+k8z8LAL3AZ21FziarLYU51yjoxu4KeNC7gjscE+sAXiMrwNfTCV6sfVR6PFk2JLP/V
 v+GFR/Jd2RGo=
X-Google-Smtp-Source: AGHT+IGcb+B+2eqTUNX8uRFTTQzUgMkV/m7rHzIH497ND/XiKF/P31S+FmWv5xa9JLBwoq6QvhSzaA==
X-Received: by 2002:adf:9ccc:0:b0:3a4:ed10:c14 with SMTP id
 ffacd0b85a97d-3b32ca3f42emr1548364f8f.14.1751540328474; 
 Thu, 03 Jul 2025 03:58:48 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fa2a7sm18184359f8f.21.2025.07.03.03.58.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:58:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v5 35/69] accel/hvf: Move per-cpu method declarations to
 hvf-accel-ops.c
Date: Thu,  3 Jul 2025 12:55:01 +0200
Message-ID: <20250703105540.67664-36-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

hvf-all.c aims to contain the generic accel methods (TYPE_ACCEL),
while hvf-accel-ops.c the per-vcpu methods (TYPE_ACCEL_OPS).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/hvf/hvf-accel-ops.c | 29 +++++++++++++++++++++++++++++
 accel/hvf/hvf-all.c       | 29 -----------------------------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index ada2a3357eb..be044b9ceaa 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -50,6 +50,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "qemu/queue.h"
 #include "system/address-spaces.h"
 #include "gdbstub/enums.h"
 #include "hw/boards.h"
@@ -492,6 +493,34 @@ static void hvf_start_vcpu_thread(CPUState *cpu)
                        cpu, QEMU_THREAD_JOINABLE);
 }
 
+struct hvf_sw_breakpoint *hvf_find_sw_breakpoint(CPUState *cpu, vaddr pc)
+{
+    struct hvf_sw_breakpoint *bp;
+
+    QTAILQ_FOREACH(bp, &hvf_state->hvf_sw_breakpoints, entry) {
+        if (bp->pc == pc) {
+            return bp;
+        }
+    }
+    return NULL;
+}
+
+int hvf_sw_breakpoints_active(CPUState *cpu)
+{
+    return !QTAILQ_EMPTY(&hvf_state->hvf_sw_breakpoints);
+}
+
+static void do_hvf_update_guest_debug(CPUState *cpu, run_on_cpu_data arg)
+{
+    hvf_arch_update_guest_debug(cpu);
+}
+
+int hvf_update_guest_debug(CPUState *cpu)
+{
+    run_on_cpu(cpu, do_hvf_update_guest_debug, RUN_ON_CPU_NULL);
+    return 0;
+}
+
 static int hvf_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
 {
     struct hvf_sw_breakpoint *bp;
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 8c387fda24d..481d7dece57 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -12,7 +12,6 @@
 #include "qemu/error-report.h"
 #include "system/hvf.h"
 #include "system/hvf_int.h"
-#include "hw/core/cpu.h"
 
 const char *hvf_return_string(hv_return_t ret)
 {
@@ -41,31 +40,3 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
 
     abort();
 }
-
-struct hvf_sw_breakpoint *hvf_find_sw_breakpoint(CPUState *cpu, vaddr pc)
-{
-    struct hvf_sw_breakpoint *bp;
-
-    QTAILQ_FOREACH(bp, &hvf_state->hvf_sw_breakpoints, entry) {
-        if (bp->pc == pc) {
-            return bp;
-        }
-    }
-    return NULL;
-}
-
-int hvf_sw_breakpoints_active(CPUState *cpu)
-{
-    return !QTAILQ_EMPTY(&hvf_state->hvf_sw_breakpoints);
-}
-
-static void do_hvf_update_guest_debug(CPUState *cpu, run_on_cpu_data arg)
-{
-    hvf_arch_update_guest_debug(cpu);
-}
-
-int hvf_update_guest_debug(CPUState *cpu)
-{
-    run_on_cpu(cpu, do_hvf_update_guest_debug, RUN_ON_CPU_NULL);
-    return 0;
-}
-- 
2.49.0


