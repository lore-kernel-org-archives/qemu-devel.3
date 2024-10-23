Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DA4D2E011
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 03:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3S9S-0007N4-3f; Tue, 22 Oct 2024 23:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S9B-00071s-Iq
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:58 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S96-0008Nh-3A
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:57 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5ebbed44918so1985777eaf.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 20:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729654491; x=1730259291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PRTNYIArZlatikgGnSAF/8SMvAQGqtGeoRmJZH7Ys0w=;
 b=BBY6f9sEefxc8LbxwwHeftUi6jmEoZQbL5OtGerQeO72CYtT9D5RFlbDjdS8wGMesZ
 +VHEZHH1zo9X8qvRNCHxb5G7Tlg+9wb7HDzzNjxREprzI38p3Rt7Rg7TSROay0RXWd/5
 0KTJ07MuFizewLwTZ9SSB1YxxBkpBpiSgrcOYB3hAdIIsxLQNsI/JsnZl9RmThzB+DN5
 vXsHCQDF8Y6cri0aAHCa7P94Q/NH1n83SEHlTmUwTHEcPr8ryqzrihP/aOvJdg7a9uIu
 jyloYRo7+Vwq2Px/3dwvb1Pmv2jeW3i9Pr3Zb01/8c3U5qtJO8EjzQhaDw+og8x/XfbJ
 4Njg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729654491; x=1730259291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PRTNYIArZlatikgGnSAF/8SMvAQGqtGeoRmJZH7Ys0w=;
 b=gHGr67Q4qI/rvWM+uFjAVOblP6BQ35cTmg6eWWE+d8RAw8OwsBGqCVCS1zEJ6PYodK
 nvjm0wFZJYBxFuHmDtIOEbxtjAfwAkXvYfDXH77fLRCZxxQeVvuU+ye3Lg0+gBEvbKjZ
 E2nF0ce8tI7ZPrArqih7S7JmPShvFIi0O0sLEvW526u93bIF/0yOfq6ZmWJ8xrPTfl4W
 nPO907opaUa2/BQP6CuO+F1zRkIouKH7GAyz44bBNUPv9lb07fX2FXMjgxpEALKKkrCg
 1qLT2fM2TVAGFHCRv7OceGkWi+KDOJDjiN+RX1XgmdVjKEnP356ROjh5qew8ZRcf8E8o
 eFhg==
X-Gm-Message-State: AOJu0Ywj7BjoPRiCPdDmem33na39R0rwbuByhjcfTE4d+wkakb7RwpF9
 uZo+58CHATiI9zp3oJXi1dXuM/CdTM56zUE9FjeWGEKBz2aSFEPVo8Ixa3OPdICGmNZTTAF6IPQ
 9
X-Google-Smtp-Source: AGHT+IHJp3GnFaq+vGJWGa0tInLc/mjq6zY4RJj0NQhn81IlEkvk9rIBiMcUARNxCot++wwjFXvm8A==
X-Received: by 2002:a05:6870:55cd:b0:27b:8902:5ac9 with SMTP id
 586e51a60fabf-28ccb72efe2mr1181726fac.40.1729654490895; 
 Tue, 22 Oct 2024 20:34:50 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d73b1sm5438338b3a.105.2024.10.22.20.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 20:34:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 22/24] linux-user: Trace rt_sigprocmask's sigsets
Date: Tue, 22 Oct 2024 20:34:30 -0700
Message-ID: <20241023033432.1353830-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023033432.1353830-1-richard.henderson@linaro.org>
References: <20241023033432.1353830-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
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

Add a function for formatting target sigsets. It can be useful for
other syscalls in the future, so put it into the beginning of strace.c.
For simplicity, do not implement the strace's ~[] output syntax.

Add a rt_sigprocmask return handler.

Example outputs:

    753914 rt_sigprocmask(SIG_BLOCK,[SIGCHLD SIGTSTP SIGTTIN SIGTTOU],0x00007f80fddfe380,8) = 0 (oldset=[SIGTTOU])
    753914 rt_sigprocmask(SIG_SETMASK,[SIGCHLD],NULL,8) = 0
    753914 rt_sigprocmask(SIG_BLOCK,NULL,0x00007f80fddff3c0,8) = 0 (oldset=[])

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20241022102726.18520-1-iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/strace.c    | 88 ++++++++++++++++++++++++++++++++++++------
 linux-user/strace.list |  3 +-
 2 files changed, 78 insertions(+), 13 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index c3eb3a2706..b70eadc19e 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -160,20 +160,21 @@ static const char * const target_signal_name[] = {
 #undef MAKE_SIG_ENTRY
 };
 
+static void
+print_signal_1(abi_ulong arg)
+{
+    if (arg < ARRAY_SIZE(target_signal_name)) {
+        qemu_log("%s", target_signal_name[arg]);
+    } else {
+        qemu_log(TARGET_ABI_FMT_lu, arg);
+    }
+}
+
 static void
 print_signal(abi_ulong arg, int last)
 {
-    const char *signal_name = NULL;
-
-    if (arg < ARRAY_SIZE(target_signal_name)) {
-        signal_name = target_signal_name[arg];
-    }
-
-    if (signal_name == NULL) {
-        print_raw_param("%ld", arg, last);
-        return;
-    }
-    qemu_log("%s%s", signal_name, get_comma(last));
+    print_signal_1(arg);
+    qemu_log("%s", get_comma(last));
 }
 
 static void print_si_code(int arg)
@@ -718,6 +719,51 @@ print_ipc(CPUArchState *cpu_env, const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_rt_sigprocmask
+static void print_target_sigset_t_1(target_sigset_t *set, int last)
+{
+    bool first = true;
+    int i, sig = 1;
+
+    qemu_log("[");
+    for (i = 0; i < TARGET_NSIG_WORDS; i++) {
+        abi_ulong bits = 0;
+        int j;
+
+        __get_user(bits, &set->sig[i]);
+        for (j = 0; j < sizeof(bits) * 8; j++) {
+            if (bits & ((abi_ulong)1 << j)) {
+                if (first) {
+                    first = false;
+                } else {
+                    qemu_log(" ");
+                }
+                print_signal_1(sig);
+            }
+            sig++;
+        }
+    }
+    qemu_log("]%s", get_comma(last));
+}
+
+static void print_target_sigset_t(abi_ulong addr, abi_ulong size, int last)
+{
+    if (addr && size == sizeof(target_sigset_t)) {
+        target_sigset_t *set;
+
+        set = lock_user(VERIFY_READ, addr, sizeof(target_sigset_t), 1);
+        if (set) {
+            print_target_sigset_t_1(set, last);
+            unlock_user(set, addr, 0);
+        } else {
+            print_pointer(addr, last);
+        }
+    } else {
+        print_pointer(addr, last);
+    }
+}
+#endif
+
 /*
  * Variants for the return value output function
  */
@@ -3312,11 +3358,29 @@ print_rt_sigprocmask(CPUArchState *cpu_env, const struct syscallname *name,
     case TARGET_SIG_SETMASK: how = "SIG_SETMASK"; break;
     }
     qemu_log("%s,", how);
-    print_pointer(arg1, 0);
+    print_target_sigset_t(arg1, arg3, 0);
     print_pointer(arg2, 0);
     print_raw_param("%u", arg3, 1);
     print_syscall_epilogue(name);
 }
+
+static void
+print_rt_sigprocmask_ret(CPUArchState *cpu_env, const struct syscallname *name,
+                         abi_long ret, abi_long arg0, abi_long arg1,
+                         abi_long arg2, abi_long arg3, abi_long arg4,
+                         abi_long arg5)
+{
+    if (!print_syscall_err(ret)) {
+        qemu_log(TARGET_ABI_FMT_ld, ret);
+        if (arg2) {
+            qemu_log(" (oldset=");
+            print_target_sigset_t(arg2, arg3, 1);
+            qemu_log(")");
+        }
+    }
+
+    qemu_log("\n");
+}
 #endif
 
 #ifdef TARGET_NR_rt_sigqueueinfo
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 0d69fb3150..fdf94ef32a 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1189,7 +1189,8 @@
 { TARGET_NR_rt_sigpending, "rt_sigpending" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_rt_sigprocmask
-{ TARGET_NR_rt_sigprocmask, "rt_sigprocmask" , NULL, print_rt_sigprocmask, NULL },
+{ TARGET_NR_rt_sigprocmask, "rt_sigprocmask" , NULL, print_rt_sigprocmask,
+                            print_rt_sigprocmask_ret },
 #endif
 #ifdef TARGET_NR_rt_sigqueueinfo
 { TARGET_NR_rt_sigqueueinfo, "rt_sigqueueinfo" , NULL, print_rt_sigqueueinfo, NULL },
-- 
2.43.0


