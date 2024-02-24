Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2BAC54798
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 01:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdgTq-0006Ft-Ol; Fri, 23 Feb 2024 20:05:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdgTo-0006FI-1f
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 20:05:28 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdgTm-0006qd-3u
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 20:05:27 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e4e7e2594cso794888b3a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 17:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708736724; x=1709341524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4p3730s1ZW+5tccU/rwEB7GvlawtPCatyb8CYdCU2hc=;
 b=fd5pV9hJsgOkq88HcJsVQLIPUdcY/aCJe6p2xzXj6qDRAHfZaJQ0NGQhVvQfNj7Dkt
 Zjj8TQ+v2spSrzwKB1QHheJNlcIVGs7qL/Lkp8nRks6q1mFRw1kv7XdGo4aG/ZGMYdwj
 w6/ZL/0wqsCOFMzA4UrI8coMGv+wLCJsB8EiZ1LZfCpgKVdHSH25MQ0aq2TAm/0DGcVv
 sbu+SqM6nL3iqS4DtGHU88g57wPdU086mXoS8amvJx9B/uZwYkkDsNBSi7U5ATw0GZ+2
 pZEpASrHuY9KhDKbwu1IAa85HZM7kSiYXnC4Pvu5c0Ym7YPKMje3BormUt3BfsDCU2cr
 PLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708736724; x=1709341524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4p3730s1ZW+5tccU/rwEB7GvlawtPCatyb8CYdCU2hc=;
 b=HdxM/8GlsXP1Mqx9SAkFW2cyuHjRR8KkGSEzvZcrkA6ALI7LtyEz1MA9p2AL5StmTs
 P17exW54WTk23t3sBP4h0LdnupJc8xU65IUenCRVWNqE8aCVbXXiuY2Q4KU5izE453/8
 /Hzxo1XUROaxPS0iIKoO9lNc0ojNqbmgi7ShQTrfKAQqba9wNNRV6YqfA9K+mXzmI8Vp
 848bXRYvtwC9AlnL7b8MQbst65QCPZ8PUjyFwaU/By0mkFspcB4WgUQOaMnd0zfWAdbd
 VfeT2VokxoEz2uthSY/4OIH1dtwMoKh99HJjg0OSHDcfoyPDNC5Bi86wLV8hFI8A/oFJ
 j6ig==
X-Gm-Message-State: AOJu0YzxH075wXxANmXXJkPUM6EYGYvboPNgjWDn5KG6wXrFMsVMzhff
 PLEfzx9XA4VECtPTCpaSf3+fC4Yi5T50GMQz7465ii7X9GrQwsnLHGYH8W1q+Dx/USKJvHxiwgn
 E
X-Google-Smtp-Source: AGHT+IEKinhZUKCRO+f+9ql5o4Uxw5k8d2l2n8inQR+LsKQL+v8cNP8f7zksozQ2HPdAvFlUDzOZlw==
X-Received: by 2002:a05:6a00:9a8:b0:6e4:890a:7af with SMTP id
 u40-20020a056a0009a800b006e4890a07afmr1844471pfg.26.1708736724356; 
 Fri, 23 Feb 2024 17:05:24 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a62e311000000b006ddc7ed6edfsm93513pfh.51.2024.02.23.17.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 17:05:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PULL v2 32/39] cpu: Remove page_size_init
Date: Fri, 23 Feb 2024 15:05:17 -1000
Message-Id: <20240224010517.619640-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240224010517.619640-1-richard.henderson@linaro.org>
References: <20240224010517.619640-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
index 4385ce54c9..5c2d55f6d2 100644
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
index b8469d9965..7913cc28aa 100644
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


