Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2D8D2C120
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 15:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8L6N-0000rW-C5; Tue, 05 Nov 2024 10:04:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8L67-0000qO-E5
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:04:01 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8L64-0000sK-SV
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:03:58 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-431695fa98bso44018095e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 07:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730819035; x=1731423835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eaNGgA/3s4B5UQl+uW6P+WyGFlnv2zD4SxX8VdqUOa8=;
 b=ZUkIs3VaUAJ+KUEx1dzh4PFyO4K9fk0L8XR0ZAUm/Dsl0gb71GIhEkxtcsaPfdAeow
 TfTZk7SvII0Dto4uP7KHtR7X4+dWH8WN7tHwEZEvNrZKHUt0PVWrhamsGJQgHwrog25M
 sP6yj+yvhG5yMIG4F9ZY+lqHZQWzBpdzpWCXPa1jwdbuIYRPpILAl47IvBkZtNyN82zS
 4E3a19ld7zGi/XhxhjDdfEPO2I6ip4lMCzwSRWs38L6z3Tqf13dwuFv10aS55ArqD/0m
 Y6EIVHk/2DKRULNg4u1142ijmFy01Jb1ANkC5VlCBVIqEqCxshMiKU0YrLDf3t1hvGXN
 +Sjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730819035; x=1731423835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eaNGgA/3s4B5UQl+uW6P+WyGFlnv2zD4SxX8VdqUOa8=;
 b=iH4q7HNV9rPH7Kx2kUL+XIi9l6OGpb5WKNVgA0rVTkg2Xqd4LtcwxOgjzUFKaHKDAr
 1B6XkpPljg2AVnp72dBJxK6AKFgI01Xgjla3edn8K279vg5fWDUR8NRsr3+FT0Gd0jZH
 Xg81MNi2bpnnyG+I1xJtAnsSq5fAji5ziRRMPBgrV3yAp3WQyJSxMHskvz+dt9QHa8MT
 piVwr/Mmm5bXoPZfuBTDgAFRkWkFZqx/VOsO3DBsAeq7UcUjg3wAnhIa6kGw3qhKmiI2
 f0FK8svTQFfKdLH1QAvIXaATzz7P7+1qiB+QmTBONpGkakiU5Rap2/KRM6V93SpPzWU2
 im6g==
X-Gm-Message-State: AOJu0Ywqhdng/EftJnbi1hfttJjXDV/knD1ewywfj2d7WccwuqbLjLd7
 HNUWvCU/p5ecScjpwrtmKI2gkthu+bUawV0XGFQ4/YOBi7RRhUDG9EYM6dHeOQyRLDxImd/gGdL
 aKhk=
X-Google-Smtp-Source: AGHT+IHWzIAbZlSVxFFHjnOHHu3cNfBisF0ErxpPhWoiB/fPLIOqz8ohemA3I9CH1vAIv2VSj8I3FA==
X-Received: by 2002:a05:600c:3b14:b0:426:8884:2c58 with SMTP id
 5b1f17b1804b1-4319ac6fb0amr306289915e9.4.1730819034911; 
 Tue, 05 Nov 2024 07:03:54 -0800 (PST)
Received: from stoup.. ([154.14.63.34]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9ca6f8sm221301855e9.39.2024.11.05.07.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 07:03:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 3/4] linux-user: Allow custom rt signal mappings
Date: Tue,  5 Nov 2024 15:03:47 +0000
Message-ID: <20241105150348.446982-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241105150348.446982-1-richard.henderson@linaro.org>
References: <20241105150348.446982-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Some applications want to use low priority realtime signals (e.g.,
SIGRTMAX). Currently QEMU cannot map all target realtime signals to
host realtime signals, and chooses to sacrifice the end of the target
realtime signal range.

Allow users to choose how to map target realtime signals to host
realtime signals using the new -t option, the new QEMU_RTSIG_MAP
environment variable, and the new -Drtsig_map=\"...\" meson flag.
To simplify things, the meson flag is not per-target, because the
intended use case is app-specific qemu-user builds.

The mapping is specified using the "tsig hsig count[,...]" syntax.
Target realtime signals [tsig,tsig+count) are mapped to host realtime
signals [hsig,hsig+count). Care is taken to avoid double and
out-of-range mappings.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241029232211.206766-2-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/signal-common.h    |   2 +-
 linux-user/main.c             |  12 +++-
 linux-user/signal.c           | 108 +++++++++++++++++++++++++++-------
 meson.build                   |   3 +-
 meson_options.txt             |   2 +
 scripts/meson-buildoptions.sh |   2 +
 6 files changed, 106 insertions(+), 23 deletions(-)

diff --git a/linux-user/signal-common.h b/linux-user/signal-common.h
index f4cbe6185e..8584d9ecc2 100644
--- a/linux-user/signal-common.h
+++ b/linux-user/signal-common.h
@@ -56,7 +56,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
                     target_sigset_t *set, CPUArchState *env);
 
 void process_pending_signals(CPUArchState *cpu_env);
-void signal_init(void);
+void signal_init(const char *rtsig_map);
 void queue_signal(CPUArchState *env, int sig, int si_type,
                   target_siginfo_t *info);
 void host_to_target_siginfo(target_siginfo_t *tinfo, const siginfo_t *info);
diff --git a/linux-user/main.c b/linux-user/main.c
index 8143a0d4b0..b09af8d436 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -412,6 +412,13 @@ static void handle_arg_reserved_va(const char *arg)
     reserved_va = val ? val - 1 : 0;
 }
 
+static const char *rtsig_map = CONFIG_QEMU_RTSIG_MAP;
+
+static void handle_arg_rtsig_map(const char *arg)
+{
+    rtsig_map = arg;
+}
+
 static void handle_arg_one_insn_per_tb(const char *arg)
 {
     opt_one_insn_per_tb = true;
@@ -494,6 +501,9 @@ static const struct qemu_argument arg_table[] = {
      "address",    "set guest_base address to 'address'"},
     {"R",          "QEMU_RESERVED_VA", true,  handle_arg_reserved_va,
      "size",       "reserve 'size' bytes for guest virtual address space"},
+    {"t",          "QEMU_RTSIG_MAP",   true,  handle_arg_rtsig_map,
+     "tsig hsig n[,...]",
+                   "map target rt signals [tsig,tsig+n) to [hsig,hsig+n]"},
     {"d",          "QEMU_LOG",         true,  handle_arg_log,
      "item[,...]", "enable logging of specified items "
      "(use '-d help' for a list of items)"},
@@ -1002,7 +1012,7 @@ int main(int argc, char **argv, char **envp)
 
     target_set_brk(info->brk);
     syscall_init();
-    signal_init();
+    signal_init(rtsig_map);
 
     /* Now that we've loaded the binary, GUEST_BASE is fixed.  Delay
        generating the prologue until now so that the prologue can take
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 63ac2df53b..9b6d772882 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -18,6 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
+#include "qemu/cutils.h"
 #include "gdbstub/user.h"
 #include "exec/page-protection.h"
 #include "hw/core/tcg-cpu-ops.h"
@@ -513,20 +514,81 @@ static int core_dump_signal(int sig)
     }
 }
 
-static void signal_table_init(void)
+static void signal_table_init(const char *rtsig_map)
 {
     int hsig, tsig, count;
 
+    if (rtsig_map) {
+        /*
+         * Map host RT signals to target RT signals according to the
+         * user-provided specification.
+         */
+        const char *s = rtsig_map;
+
+        while (true) {
+            int i;
+
+            if (qemu_strtoi(s, &s, 10, &tsig) || *s++ != ' ') {
+                fprintf(stderr, "Malformed target signal in QEMU_RTSIG_MAP\n");
+                exit(EXIT_FAILURE);
+            }
+            if (qemu_strtoi(s, &s, 10, &hsig) || *s++ != ' ') {
+                fprintf(stderr, "Malformed host signal in QEMU_RTSIG_MAP\n");
+                exit(EXIT_FAILURE);
+            }
+            if (qemu_strtoi(s, &s, 10, &count) || (*s && *s != ',')) {
+                fprintf(stderr, "Malformed signal count in QEMU_RTSIG_MAP\n");
+                exit(EXIT_FAILURE);
+            }
+
+            for (i = 0; i < count; i++, tsig++, hsig++) {
+                if (tsig < TARGET_SIGRTMIN || tsig > TARGET_NSIG) {
+                    fprintf(stderr, "%d is not a target rt signal\n", tsig);
+                    exit(EXIT_FAILURE);
+                }
+                if (hsig < SIGRTMIN || hsig > SIGRTMAX) {
+                    fprintf(stderr, "%d is not a host rt signal\n", hsig);
+                    exit(EXIT_FAILURE);
+                }
+                if (host_to_target_signal_table[hsig]) {
+                    fprintf(stderr, "%d already maps %d\n",
+                            hsig, host_to_target_signal_table[hsig]);
+                    exit(EXIT_FAILURE);
+                }
+                host_to_target_signal_table[hsig] = tsig;
+            }
+
+            if (*s) {
+                s++;
+            } else {
+                break;
+            }
+        }
+    } else {
+        /*
+         * Default host-to-target RT signal mapping.
+         *
+         * Signals are supported starting from TARGET_SIGRTMIN and going up
+         * until we run out of host realtime signals.  Glibc uses the lower 2
+         * RT signals and (hopefully) nobody uses the upper ones.
+         * This is why SIGRTMIN (34) is generally greater than __SIGRTMIN (32).
+         * To fix this properly we would need to do manual signal delivery
+         * multiplexed over a single host signal.
+         * Attempts for configure "missing" signals via sigaction will be
+         * silently ignored.
+         *
+         * Reserve one signal for internal usage (see below).
+         */
+
+        hsig = SIGRTMIN + 1;
+        for (tsig = TARGET_SIGRTMIN;
+             hsig <= SIGRTMAX && tsig <= TARGET_NSIG;
+             hsig++, tsig++) {
+            host_to_target_signal_table[hsig] = tsig;
+        }
+    }
+
     /*
-     * Signals are supported starting from TARGET_SIGRTMIN and going up
-     * until we run out of host realtime signals.  Glibc uses the lower 2
-     * RT signals and (hopefully) nobody uses the upper ones.
-     * This is why SIGRTMIN (34) is generally greater than __SIGRTMIN (32).
-     * To fix this properly we would need to do manual signal delivery
-     * multiplexed over a single host signal.
-     * Attempts for configure "missing" signals via sigaction will be
-     * silently ignored.
-     *
      * Remap the target SIGABRT, so that we can distinguish host abort
      * from guest abort.  When the guest registers a signal handler or
      * calls raise(SIGABRT), the host will raise SIG_RTn.  If the guest
@@ -536,21 +598,27 @@ static void signal_table_init(void)
      * parent sees the correct mapping from wait status.
      */
 
-    hsig = SIGRTMIN;
     host_to_target_signal_table[SIGABRT] = 0;
-    host_to_target_signal_table[hsig++] = TARGET_SIGABRT;
-
-    for (tsig = TARGET_SIGRTMIN;
-         hsig <= SIGRTMAX && tsig <= TARGET_NSIG;
-         hsig++, tsig++) {
-        host_to_target_signal_table[hsig] = tsig;
+    for (hsig = SIGRTMIN; hsig <= SIGRTMAX; hsig++) {
+        if (!host_to_target_signal_table[hsig]) {
+            host_to_target_signal_table[hsig] = TARGET_SIGABRT;
+            break;
+        }
+    }
+    if (hsig > SIGRTMAX) {
+        fprintf(stderr, "No rt signals left for SIGABRT mapping\n");
+        exit(EXIT_FAILURE);
     }
 
     /* Invert the mapping that has already been assigned. */
     for (hsig = 1; hsig < _NSIG; hsig++) {
         tsig = host_to_target_signal_table[hsig];
         if (tsig) {
-            assert(target_to_host_signal_table[tsig] == 0);
+            if (target_to_host_signal_table[tsig]) {
+                fprintf(stderr, "%d is already mapped to %d\n",
+                        tsig, target_to_host_signal_table[tsig]);
+                exit(EXIT_FAILURE);
+            }
             target_to_host_signal_table[tsig] = hsig;
         }
     }
@@ -573,13 +641,13 @@ static void signal_table_init(void)
     trace_signal_table_init(count);
 }
 
-void signal_init(void)
+void signal_init(const char *rtsig_map)
 {
     TaskState *ts = get_task_state(thread_cpu);
     struct sigaction act, oact;
 
     /* initialize signal conversion tables */
-    signal_table_init();
+    signal_table_init(rtsig_map);
 
     /* Set the signal mask from the host mask. */
     sigprocmask(0, 0, &ts->signal_mask);
diff --git a/meson.build b/meson.build
index c386593c52..9fa9d059ff 100644
--- a/meson.build
+++ b/meson.build
@@ -3178,7 +3178,8 @@ foreach target : target_dirs
     config_target += {
       'CONFIG_USER_ONLY': 'y',
       'CONFIG_QEMU_INTERP_PREFIX':
-        get_option('interp_prefix').replace('%M', config_target['TARGET_NAME'])
+        get_option('interp_prefix').replace('%M', config_target['TARGET_NAME']),
+      'CONFIG_QEMU_RTSIG_MAP': get_option('rtsig_map'),
     }
   endif
 
diff --git a/meson_options.txt b/meson_options.txt
index 24bf009056..ac4887a622 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -27,6 +27,8 @@ option('block_drv_ro_whitelist', type : 'string', value : '',
        description: 'set block driver read-only whitelist (by default affects only QEMU, not tools like qemu-img)')
 option('interp_prefix', type : 'string', value : '/usr/gnemul/qemu-%M',
        description: 'where to find shared libraries etc., use %M for cpu name')
+option('rtsig_map', type : 'string', value : 'NULL',
+       description: 'default value of QEMU_RTSIG_MAP')
 option('fuzzing_engine', type : 'string', value : '',
        description: 'fuzzing engine library for OSS-Fuzz')
 option('trace_file', type: 'string', value: 'trace',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 6f2bb08ecd..51ed46e46a 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -72,6 +72,7 @@ meson_options_help() {
   printf "%s\n" '                           "manufacturer" name for qemu-ga registry entries'
   printf "%s\n" '                           [QEMU]'
   printf "%s\n" '  --qemu-ga-version=VALUE  version number for qemu-ga installer'
+  printf "%s\n" '  --rtsig-map=VALUE        default value of QEMU_RTSIG_MAP [NULL]'
   printf "%s\n" '  --smbd=VALUE             Path to smbd for slirp networking'
   printf "%s\n" '  --sysconfdir=VALUE       Sysconf data directory [etc]'
   printf "%s\n" '  --tls-priority=VALUE     Default TLS protocol/cipher priority string'
@@ -460,6 +461,7 @@ _meson_option_parse() {
     --disable-replication) printf "%s" -Dreplication=disabled ;;
     --enable-rng-none) printf "%s" -Drng_none=true ;;
     --disable-rng-none) printf "%s" -Drng_none=false ;;
+    --rtsig-map=*) quote_sh "-Drtsig_map=$2" ;;
     --enable-rust) printf "%s" -Drust=enabled ;;
     --disable-rust) printf "%s" -Drust=disabled ;;
     --enable-rutabaga-gfx) printf "%s" -Drutabaga_gfx=enabled ;;
-- 
2.43.0


