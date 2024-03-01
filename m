Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E4FC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgC2a-0005BU-G4; Fri, 01 Mar 2024 18:11:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1U-0003rJ-39
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:43 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1R-0005gb-Dm
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:35 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e5e4b1d1f1so206791b3a.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334632; x=1709939432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vaUyQsnvahk8PvCDA8gukGjHfbLFzwV+mi5B0BNbUsQ=;
 b=pYE8/6ZNEihwLPHTBDrDs8dAqsHYmYUS59UB1CcMkgjoaFwV1Hsp7uVlsebhiKVK98
 H91s0QfB5SylMhSzrjCE/yOsiVX6Ml6OTRoxBVRoTrtm2u1atEOzjnfDM9hkjI9LHm8M
 /qUkwCTDe5EpjrzgD7kHoQNxqIhlpMxYh4Rd5oQRRzzr8kSk7rxB/urPeWwXkeB7zSBL
 8zc0mFLkaJ34BRDW4Sh6NL9lVwqtIhLXFQZSRQ6//nNjKSjdtoYEwF0Cqwi5qxkZArHh
 tTF2+UfG4+9pNB5+uflEEZjTNUuDEm5tW8tOovPSNBmPmqSquC1UHZkyy2NrMrmkJjgC
 PJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334632; x=1709939432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vaUyQsnvahk8PvCDA8gukGjHfbLFzwV+mi5B0BNbUsQ=;
 b=Rx6YyDpT8U/oLhQScTZ2/9EzBr5C92oXk6DMlT8+xr3X0h5lYpzwhRZp0sBBhSpth+
 it+voT0N03dg8E+DHMJSzZTihNJkD0Qg5q8Lj3FoEZCR90VB/lqYwnBoqIGBT4rIR6Ez
 T61XgX29zglx8WL8SpVYF+1Tftd2dV+X4SntXS+OqbTD+ODhOLR5cPSm5dsn/4DeWUuM
 WkoCWEHNAo/EELeH5mhINBbfzhRhkPOaFB+yYkX+DBz2GLpisVLMB2Uh07RX978ep+MN
 MDTforgbPi26RAx9g2nA2TpDOFYbiOMn7bCuLJKLjFzC/iBDZAQZJdvQjphOij6w8NQQ
 1wag==
X-Gm-Message-State: AOJu0YxL0iWrBbW1TGYppPSN/BqZgHG7iWupsaGMzzlT2zhb39Oq9xzQ
 iMFz6C/EhRCL38H/ACh42uiL6gwxa8Ej5LxZQXXvUCLgFrgGJguq5XeTuuriVCvjz0/MAYO/Y8B
 m
X-Google-Smtp-Source: AGHT+IHzytfeo1KzHwzjvk2R45CX0MIdneT35YaK1VTzknlzVAdlRi0hco/rbpmkBkNQ6mwXEPvT8g==
X-Received: by 2002:a05:6a20:3d22:b0:19e:ba42:4ed9 with SMTP id
 y34-20020a056a203d2200b0019eba424ed9mr4598452pzi.1.1709334632155; 
 Fri, 01 Mar 2024 15:10:32 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a634e02000000b005e438fe702dsm3449407pgb.65.2024.03.01.15.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:10:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH 47/60] cpu: Remove page_size_init
Date: Fri,  1 Mar 2024 13:06:06 -1000
Message-Id: <20240301230619.661008-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Move qemu_host_page_{size,mask} and HOST_PAGE_ALIGN into bsd-user.
It should be removed from bsd-user as well, but defer that cleanup.

Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-28-richard.henderson@linaro.org>
---
 bsd-user/qemu.h           |  7 +++++++
 include/exec/cpu-common.h |  7 -------
 include/hw/core/cpu.h     |  2 --
 accel/tcg/translate-all.c |  1 -
 bsd-user/main.c           | 12 ++++++++++++
 cpu-target.c              | 16 ----------------
 system/vl.c               |  1 -
 7 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index dc842fffa7..c05c512767 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -39,6 +39,13 @@ extern char **environ;
 #include "qemu/clang-tsa.h"
 
 #include "qemu-os.h"
+/*
+ * TODO: Remove these and rely only on qemu_real_host_page_size().
+ */
+extern uintptr_t qemu_host_page_size;
+extern intptr_t qemu_host_page_mask;
+#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_host_page_size)
+
 /*
  * This struct is used to hold certain information about the image.  Basically,
  * it replicates in user space what would be certain task_struct fields in the
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 9ead1be100..6346df17ce 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -20,13 +20,6 @@
 void cpu_exec_init_all(void);
 void cpu_exec_step_atomic(CPUState *cpu);
 
-/* Using intptr_t ensures that qemu_*_page_mask is sign-extended even
- * when intptr_t is 32-bit and we are aligning a long long.
- */
-extern uintptr_t qemu_host_page_size;
-extern intptr_t qemu_host_page_mask;
-
-#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_host_page_size)
 #define REAL_HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_real_host_page_size())
 
 /* The CPU list lock nests outside page_(un)lock or mmap_(un)lock */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index af1a29526d..d0e345419f 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1179,8 +1179,6 @@ bool target_words_bigendian(void);
 
 const char *target_name(void);
 
-void page_size_init(void);
-
 #ifdef NEED_CPU_H
 
 #ifndef CONFIG_USER_ONLY
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 1c695efe02..c1f57e894a 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -256,7 +256,6 @@ bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data)
 
 void page_init(void)
 {
-    page_size_init();
     page_table_config_init();
 }
 
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 6ab3efd6c0..512d4ab69f 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -49,6 +49,13 @@
 #include "host-os.h"
 #include "target_arch_cpu.h"
 
+
+/*
+ * TODO: Remove these and rely only on qemu_real_host_page_size().
+ */
+uintptr_t qemu_host_page_size;
+intptr_t qemu_host_page_mask;
+
 static bool opt_one_insn_per_tb;
 uintptr_t guest_base;
 bool have_guest_base;
@@ -307,6 +314,9 @@ int main(int argc, char **argv)
         (void) envlist_setenv(envlist, *wrk);
     }
 
+    qemu_host_page_size = getpagesize();
+    qemu_host_page_size = MAX(qemu_host_page_size, TARGET_PAGE_SIZE);
+
     cpu_model = NULL;
 
     qemu_add_opts(&qemu_trace_opts);
@@ -404,6 +414,8 @@ int main(int argc, char **argv)
         }
     }
 
+    qemu_host_page_mask = -qemu_host_page_size;
+
     /* init debug */
     {
         int mask = 0;
diff --git a/cpu-target.c b/cpu-target.c
index 86444cc2c6..4c0621bf33 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -45,9 +45,6 @@
 #include "trace/trace-root.h"
 #include "qemu/accel.h"
 
-uintptr_t qemu_host_page_size;
-intptr_t qemu_host_page_mask;
-
 #ifndef CONFIG_USER_ONLY
 static int cpu_common_post_load(void *opaque, int version_id)
 {
@@ -474,16 +471,3 @@ const char *target_name(void)
 {
     return TARGET_NAME;
 }
-
-void page_size_init(void)
-{
-    /* NOTE: we can always suppose that qemu_host_page_size >=
-       TARGET_PAGE_SIZE */
-    if (qemu_host_page_size == 0) {
-        qemu_host_page_size = qemu_real_host_page_size();
-    }
-    if (qemu_host_page_size < TARGET_PAGE_SIZE) {
-        qemu_host_page_size = TARGET_PAGE_SIZE;
-    }
-    qemu_host_page_mask = -(intptr_t)qemu_host_page_size;
-}
diff --git a/system/vl.c b/system/vl.c
index e480afd7a0..48aae6e053 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2118,7 +2118,6 @@ static void qemu_create_machine(QDict *qdict)
     }
 
     cpu_exec_init_all();
-    page_size_init();
 
     if (machine_class->hw_version) {
         qemu_set_hw_version(machine_class->hw_version);
-- 
2.34.1


