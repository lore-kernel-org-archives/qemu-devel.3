Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EF0CFB421
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 23:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxEHe-0006DP-OF; Sat, 05 Oct 2024 19:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxEHc-0006Cx-Px
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 19:33:56 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxEHb-0004EP-9h
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 19:33:56 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2e0a74ce880so2809062a91.2
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 16:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728171234; x=1728776034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wYBWpQBnXZ27uF3GVfCeocPGkAYUMjeFh2ALsFccVN8=;
 b=OFvV/hS8dqx0tGgAmQAqfe08dF1Ck76FYvyW7aMS9I/w3VdFZ85rcCSKF6MI+M0lml
 gvaaVXd+EU1YjIrhk14zkfgizwiXb4yeX08F9TuYbdy/u20qyLziGiDwcPraKSh63lkF
 L2QT+b09oUV5k1FieW2/i9JH8uy9L9Ugsdm8sX1iB49kGaChgwlnxgbI/CWr4bNvKJYI
 vOwUXTAEn78RH2ysVxjbWX84PTdGRr3SDhSw/Pnmwl06w0jE9SP+6+hkYrDKFczIvviH
 38qTtLP50XpZiQHrKzbmWcQ6sHevxuqRjRzZYG78k2alINmb1e2pywVGQ4RTyxQ8f6MJ
 T+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728171234; x=1728776034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wYBWpQBnXZ27uF3GVfCeocPGkAYUMjeFh2ALsFccVN8=;
 b=FOl9kTUjwKdFnssOXnrZgQtJ3raNyT00wXaFL0BPjC0OYPH3WkpFzSxwaUosNPieyq
 +6NhVWbva1vhjW0VsJprmiNQjYGCFP86EztcjM2DGsbSgprQvs2/y3czD0sIqg+W3/Nd
 06g2ATQZl4LHdKq+wozZjVRbGFwFY+JMuNHZOwZiGfNuybMNV6nCaEEVRjAJuD1yn0De
 XLGdNZqyTcAh4Kt1OyfGJkLo5wNLx6h2vo/WFPRybvldp3YRMUMNQFy2MrA9ibxCMXMV
 0ErgDqV4JTimaD0bxMe+ggdLm6mZew1ZPN295P9IsrddV+cJLsrx0HGtrqmqYcxoDwjw
 tP/g==
X-Gm-Message-State: AOJu0Yy4ATQwKGTj5jaA4Zg8ohCuF7DYzeyzscR23DFl9GuHXtoX9c4s
 cvRvkwm8tpWQ0cNb8anUt4kSbJ2J+zy9pYn5i522mdlpqKs92qosEXT0SUHeB2fzoKzInkEGfXm
 f
X-Google-Smtp-Source: AGHT+IFSRGaJlojSBD+v0xl0uQbyCy8P43U/QiMO11QfeXC2gEE43XqB4Ik0jJq+lt8kUtnx8FdtDA==
X-Received: by 2002:a17:90a:2ecc:b0:2cf:fe5d:ea12 with SMTP id
 98e67ed59e1d1-2e1e626c037mr9183719a91.24.1728171233936; 
 Sat, 05 Oct 2024 16:33:53 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e20b129cc2sm2394600a91.51.2024.10.05.16.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 16:33:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/10] linux-user: Add strace for recvfrom()
Date: Sat,  5 Oct 2024 16:33:43 -0700
Message-ID: <20241005233343.503426-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005233343.503426-1-richard.henderson@linaro.org>
References: <20241005233343.503426-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240807124306.52903-6-philmd@linaro.org>
[rth: Do not dump output buffers.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/strace.c    | 17 +++++++++++++++++
 linux-user/strace.list |  2 +-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 0263e6a396..c3eb3a2706 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -3142,6 +3142,23 @@ print_bind(CPUArchState *cpu_env, const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_recvfrom
+static void
+print_recvfrom(CPUArchState *cpu_env, const struct syscallname *name,
+               abi_long arg0, abi_long arg1, abi_long arg2,
+               abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_sockfd(arg0, 0);
+    print_pointer(arg1, 0); /* output */
+    print_raw_param(TARGET_ABI_FMT_ld, arg2, 0);
+    print_flags(msg_flags, arg3, 0);
+    print_pointer(arg4, 0); /* output */
+    print_pointer(arg5, 1); /* in/out */
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_sendto
 static void
 print_sendto(CPUArchState *cpu_env, const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 64d24e16d0..0d69fb3150 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1138,7 +1138,7 @@
 { TARGET_NR_recv, "recv" , "%s(%d,%p,%u,%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_recvfrom
-{ TARGET_NR_recvfrom, "recvfrom" , NULL, NULL, NULL },
+{ TARGET_NR_recvfrom, "recvfrom" , NULL, print_recvfrom, NULL },
 #endif
 #ifdef TARGET_NR_recvmmsg
 { TARGET_NR_recvmmsg, "recvmmsg" , NULL, NULL, NULL },
-- 
2.43.0


