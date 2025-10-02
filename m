Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59806CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 09:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4FN1-000628-Aq; Thu, 02 Oct 2025 05:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4FMy-00061I-8E
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 05:13:01 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4FMT-0002X4-MK
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 05:12:59 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e4ad36541so8924115e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 02:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759396333; x=1760001133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IEeqVVZCXvDFNqYv/N2G5N9g66ILo9wUViTH03vloTk=;
 b=CWu7HH8HNq4kEKSSfoSmK4QQIgEC9MVp9FQEJvrT8WI62Bqi4oRyfc1NvDLxaDwK88
 uwWYa0c5X9RpF8oG/JjgL6tGpLlEY3jE1q+VUrnzglhfqB4DNt/CA9S4u83FsvbCpDad
 6v21j+FO5Xg7UJ2pt0QBGc3dD7vU5iw4Y4cxIOCGTLUIJiM6r0gX7I9SdClZ3UI+YGK9
 mvfVoiIjYTSx8WsZ/X3lTkAvf0J/4e1k5nrE6hPY/KmQSOQfxEMeZCe9SAMb3DXr63w8
 ei5HCjuBJcSOIrxhE1TTKTdWqEwMl+X6FgtzcH6CTb6AvGwDjh/9frTMJvcEl7uafDTI
 y+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759396333; x=1760001133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IEeqVVZCXvDFNqYv/N2G5N9g66ILo9wUViTH03vloTk=;
 b=ssKYlxGjBA9iq46rfB7quq88Nltg8a4/hxsZCYeqjUiG856W/ZEY2GG7Hinqe1EkjB
 /iMHxuKyaoXIksw0JY7YGpcIEpGILCC+VUrzt2i6jm1MB2+Lv2NWSAeY+K/chx2zENNH
 gs/n5zf9W08UTSKw9lqyJixHrKX3GZ03iLwmMWUDfI26skPPNuf1eMVLeVsHkuDTbcRZ
 Hf8LWvZZ0oUxJulq9LZwuhWWaqEJWxM6QgVG0kVo/KE0oAYfDaeCRFLv739QhsBfmM7B
 DMQavszHE1ZUcsPT1ClM2HUlRtGW8MoQia3WNxlf4ADicxNxtgZJ6tiOoKd3BLwfXgdH
 thWg==
X-Gm-Message-State: AOJu0YycISl0XEPUSma0Hlp5eEWBeECKjKXaGroiRb2/uTIolLUb0GnF
 A5muH45se9+FkXHcjL6T//QLG/IPlqrIiRhhJHIzKYkFVb2xidKfZVff7dbE9cGc4/pjw58ueLm
 Pl5rdxcFX5Q==
X-Gm-Gg: ASbGncstDbkTxd/4OtdXtDBMACyj+I74cXax9PvQJOrm/jMO9dxceU3M2OlODcdrgvH
 ZWHl3MYCBDG64HhRm3vpTv3ww2AqYBJLarOTm652HvoYaYZH+7q6yhxOZ12KCLPMjtGMV2UmZEh
 IGCW3iO39bRibag4HgcASDwogNtMHGf0l7VYfixMWj0EXCmhcefv8K/2gcDi+ZGnHJmazD2CaGB
 dCfj9ZToMMlwfozq89ytpNLDAPfkUlVDi+dbp1flKI9vCcYLWl0jsBEW7x+CIISVRwLcsPUffwG
 kXL0WJcQ59E+a7pwmXSJT5KL9g/d5ZCMNUBqALgOxebFT/4EABo87pahBfwP1tDCsenydoxZ666
 6hqZmQBk+MTCl2JePywZUKzkeM28l7DM8/Op/Qj7BhDioaug4Oy0xjE13m+PkC5E//oY8WAdAA4
 pIO66Gg8z2MHXi5JUQRYARN9oRxuI2Sg==
X-Google-Smtp-Source: AGHT+IGuvkL9oyMXqmeGoA/v9xVJn/jWKUYjOo7oMwhfZIfdiDLTib0WqCDLY6En5a8LmcpZUydzfA==
X-Received: by 2002:a05:600c:1f91:b0:46e:1d01:11dd with SMTP id
 5b1f17b1804b1-46e6126a7b7mr47703595e9.2.1759396332875; 
 Thu, 02 Oct 2025 02:12:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e693bcc93sm26083465e9.13.2025.10.02.02.12.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 02:12:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 8/9] target/s390x: Reduce s390_store_status() scope
Date: Thu,  2 Oct 2025 11:11:31 +0200
Message-ID: <20251002091132.65703-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002091132.65703-1-philmd@linaro.org>
References: <20251002091132.65703-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

s390_store_status() is only called within sigp.c,
move it and the SigpSaveArea structure definition
there where it belongs, with other SIGP handling
code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/s390x-internal.h |  2 --
 target/s390x/helper.c         | 67 ----------------------------------
 target/s390x/sigp.c           | 68 +++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 69 deletions(-)

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index a49dca94a75..9691366ec91 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -323,8 +323,6 @@ void s390x_cpu_timer(void *opaque);
 void s390_handle_wait(S390CPU *cpu);
 hwaddr s390_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 hwaddr s390_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
-#define S390_STORE_STATUS_DEF_ADDR offsetof(LowCore, floating_pt_save_area)
-int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch);
 LowCore *cpu_map_lowcore(CPUS390XState *env);
 void cpu_unmap_lowcore(CPUS390XState *env, LowCore *lowcore);
 #endif /* CONFIG_USER_ONLY */
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 84321e1d68e..184428c6d9d 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -24,7 +24,6 @@
 #include "gdbstub/helpers.h"
 #include "qemu/timer.h"
 #include "hw/s390x/ioinst.h"
-#include "target/s390x/kvm/pv.h"
 #include "system/hw_accel.h"
 #include "system/memory.h"
 #include "system/runstate.h"
@@ -182,69 +181,3 @@ void s390_cpu_recompute_watchpoints(CPUState *cs)
                               wp_flags, NULL);
     }
 }
-
-typedef struct SigpSaveArea {
-    uint64_t    fprs[16];                       /* 0x0000 */
-    uint64_t    grs[16];                        /* 0x0080 */
-    PSW         psw;                            /* 0x0100 */
-    uint8_t     pad_0x0110[0x0118 - 0x0110];    /* 0x0110 */
-    uint32_t    prefix;                         /* 0x0118 */
-    uint32_t    fpc;                            /* 0x011c */
-    uint8_t     pad_0x0120[0x0124 - 0x0120];    /* 0x0120 */
-    uint32_t    todpr;                          /* 0x0124 */
-    uint64_t    cputm;                          /* 0x0128 */
-    uint64_t    ckc;                            /* 0x0130 */
-    uint8_t     pad_0x0138[0x0140 - 0x0138];    /* 0x0138 */
-    uint32_t    ars[16];                        /* 0x0140 */
-    uint64_t    crs[16];                        /* 0x0384 */
-} SigpSaveArea;
-QEMU_BUILD_BUG_ON(sizeof(SigpSaveArea) != 512);
-
-int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
-{
-    static const uint8_t ar_id = 1;
-    SigpSaveArea *sa;
-    hwaddr len = sizeof(*sa);
-    int i;
-
-    /* For PVMs storing will occur when this cpu enters SIE again */
-    if (s390_is_pv()) {
-        return 0;
-    }
-
-    sa = cpu_physical_memory_map(addr, &len, true);
-    if (!sa) {
-        return -EFAULT;
-    }
-    if (len != sizeof(*sa)) {
-        cpu_physical_memory_unmap(sa, len, 1, 0);
-        return -EFAULT;
-    }
-
-    if (store_arch) {
-        cpu_physical_memory_write(offsetof(LowCore, ar_access_id), &ar_id, 1);
-    }
-    for (i = 0; i < 16; ++i) {
-        sa->fprs[i] = cpu_to_be64(*get_freg(&cpu->env, i));
-    }
-    for (i = 0; i < 16; ++i) {
-        sa->grs[i] = cpu_to_be64(cpu->env.regs[i]);
-    }
-    sa->psw.addr = cpu_to_be64(cpu->env.psw.addr);
-    sa->psw.mask = cpu_to_be64(s390_cpu_get_psw_mask(&cpu->env));
-    sa->prefix = cpu_to_be32(cpu->env.psa);
-    sa->fpc = cpu_to_be32(cpu->env.fpc);
-    sa->todpr = cpu_to_be32(cpu->env.todpr);
-    sa->cputm = cpu_to_be64(cpu->env.cputm);
-    sa->ckc = cpu_to_be64(cpu->env.ckc >> 8);
-    for (i = 0; i < 16; ++i) {
-        sa->ars[i] = cpu_to_be32(cpu->env.aregs[i]);
-    }
-    for (i = 0; i < 16; ++i) {
-        sa->crs[i] = cpu_to_be64(cpu->env.cregs[i]);
-    }
-
-    cpu_physical_memory_unmap(sa, len, 1, len);
-
-    return 0;
-}
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index 1464be76983..2487acdb49e 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -19,6 +19,7 @@
 #include "system/tcg.h"
 #include "trace.h"
 #include "qapi/qapi-types-machine.h"
+#include "target/s390x/kvm/pv.h"
 
 QemuMutex qemu_sigp_mutex;
 
@@ -126,6 +127,73 @@ static void sigp_stop(CPUState *cs, run_on_cpu_data arg)
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
 }
 
+typedef struct SigpSaveArea {
+    uint64_t    fprs[16];                       /* 0x0000 */
+    uint64_t    grs[16];                        /* 0x0080 */
+    PSW         psw;                            /* 0x0100 */
+    uint8_t     pad_0x0110[0x0118 - 0x0110];    /* 0x0110 */
+    uint32_t    prefix;                         /* 0x0118 */
+    uint32_t    fpc;                            /* 0x011c */
+    uint8_t     pad_0x0120[0x0124 - 0x0120];    /* 0x0120 */
+    uint32_t    todpr;                          /* 0x0124 */
+    uint64_t    cputm;                          /* 0x0128 */
+    uint64_t    ckc;                            /* 0x0130 */
+    uint8_t     pad_0x0138[0x0140 - 0x0138];    /* 0x0138 */
+    uint32_t    ars[16];                        /* 0x0140 */
+    uint64_t    crs[16];                        /* 0x0384 */
+} SigpSaveArea;
+QEMU_BUILD_BUG_ON(sizeof(SigpSaveArea) != 512);
+
+#define S390_STORE_STATUS_DEF_ADDR offsetof(LowCore, floating_pt_save_area)
+static int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
+{
+    static const uint8_t ar_id = 1;
+    SigpSaveArea *sa;
+    hwaddr len = sizeof(*sa);
+    int i;
+
+    /* For PVMs storing will occur when this cpu enters SIE again */
+    if (s390_is_pv()) {
+        return 0;
+    }
+
+    sa = cpu_physical_memory_map(addr, &len, true);
+    if (!sa) {
+        return -EFAULT;
+    }
+    if (len != sizeof(*sa)) {
+        cpu_physical_memory_unmap(sa, len, 1, 0);
+        return -EFAULT;
+    }
+
+    if (store_arch) {
+        cpu_physical_memory_write(offsetof(LowCore, ar_access_id), &ar_id, 1);
+    }
+    for (i = 0; i < 16; ++i) {
+        sa->fprs[i] = cpu_to_be64(*get_freg(&cpu->env, i));
+    }
+    for (i = 0; i < 16; ++i) {
+        sa->grs[i] = cpu_to_be64(cpu->env.regs[i]);
+    }
+    sa->psw.addr = cpu_to_be64(cpu->env.psw.addr);
+    sa->psw.mask = cpu_to_be64(s390_cpu_get_psw_mask(&cpu->env));
+    sa->prefix = cpu_to_be32(cpu->env.psa);
+    sa->fpc = cpu_to_be32(cpu->env.fpc);
+    sa->todpr = cpu_to_be32(cpu->env.todpr);
+    sa->cputm = cpu_to_be64(cpu->env.cputm);
+    sa->ckc = cpu_to_be64(cpu->env.ckc >> 8);
+    for (i = 0; i < 16; ++i) {
+        sa->ars[i] = cpu_to_be32(cpu->env.aregs[i]);
+    }
+    for (i = 0; i < 16; ++i) {
+        sa->crs[i] = cpu_to_be64(cpu->env.cregs[i]);
+    }
+
+    cpu_physical_memory_unmap(sa, len, 1, len);
+
+    return 0;
+}
+
 static void sigp_stop_and_store_status(CPUState *cs, run_on_cpu_data arg)
 {
     S390CPU *cpu = S390_CPU(cs);
-- 
2.51.0


