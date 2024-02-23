Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE14C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 03:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdLqL-0002cX-He; Thu, 22 Feb 2024 22:03:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdLqJ-0002bn-1N
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 22:03:19 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdLqH-0000cZ-GD
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 22:03:18 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so312858a12.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 19:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708657396; x=1709262196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0U9PMwHiZszNU3T0CkEUezw6dw3Df8531lwjpQDns4A=;
 b=BKx4zSW3MZzsNG0GXPG5NEG6dmzppnWSyeuy/Qcp+Tq8WmHFvnqbRweTTE7wEWp+cX
 lKtim/8+BJN8kPzJKw78NH5ue60ZLrI+6SyNltVLs515DKeZsUcCkXX5SJ0UFbOOIma3
 7atWYmEmOEk9is1PJ4mW/RuO/1pDmyCq4+FmAeSxJ6jNZ/jyQh6xKjDtkobaCdn3ABxv
 c9vcUaXCTaDqQGEiM1uVbWp/ytV4papwFixQhGjXcVecbW+7SQH2NiE9Xb9qEqQXwzLs
 PpnMd1ErNqhxtljifXIZosdHwGUMZKPv4yk/6pW2vUBbfSYd5h5hv0Kaz0+aDyzk36gw
 Qoyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708657396; x=1709262196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0U9PMwHiZszNU3T0CkEUezw6dw3Df8531lwjpQDns4A=;
 b=QDlMBR3Omtk6OB597gu+aoU6JMtSDs5Ex0K0ohdYxwQ9GMB6CjterIYDH3lNgWnTA2
 /02tTGXdLKteBP0VOsJIJ1InthwkBnWRuJbeGnY67FQ5gSZitOanX5UnkhNeWpElMn+1
 /oXX7v2nnD9oxr2gB0Kt3JI/+aI9zuHclAgHeduhdzd8VfLF/+wBwSimg4FF7/hmwBSV
 AKMJZPUbo1LVi9xqwjE1KGu9f+cE0XtecL1Xe3NQz/mkULBQg46TrbsfqGLDMWbK+/N9
 G2TG6Nn46Mf0ClvEJzRDkSojnyy8Sc4YCkdWrMCV71wDxHSNC48gnJzMuVCJiIVdi1ZX
 dxhg==
X-Gm-Message-State: AOJu0YzHoTVg4MCwzVlpmhsfeeWt6jdAouCCPN3pNFr52Mox2rlmUxms
 pl96AvfX7aHxAZIPTKPkAgXs5SwObDXAV0xhWAc+zbizSsk/cUahPPTLoYW+TXNGLObYpG6qHmI
 K
X-Google-Smtp-Source: AGHT+IEyiYZsWR0ItLn2PqSjyODHyv9Zwk0JSuw30OZnY0pEmSHAWRa5yd5vllbqKMr4vKMOBD27IA==
X-Received: by 2002:a05:6a20:ce4a:b0:1a0:6c87:9197 with SMTP id
 id10-20020a056a20ce4a00b001a06c879197mr731687pzb.58.1708657395827; 
 Thu, 22 Feb 2024 19:03:15 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 n38-20020a056a000d6600b006e31f615af6sm11594159pfv.17.2024.02.22.19.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 19:03:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, iii@linux.ibm.com, richard.purdie@linuxfoundation.org,
 mjt@tls.msk.ru
Subject: [PATCH 2/3] linux-user: Add strace for shmat
Date: Thu, 22 Feb 2024 17:03:08 -1000
Message-Id: <20240223030309.458451-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223030309.458451-1-richard.henderson@linaro.org>
References: <20240223030309.458451-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/strace.c    | 23 +++++++++++++++++++++++
 linux-user/strace.list |  2 +-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index cf26e55264..47d6ec3263 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -670,6 +670,25 @@ print_semctl(CPUArchState *cpu_env, const struct syscallname *name,
 }
 #endif
 
+static void
+print_shmat(CPUArchState *cpu_env, const struct syscallname *name,
+            abi_long arg0, abi_long arg1, abi_long arg2,
+            abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    static const struct flags shmat_flags[] = {
+        FLAG_GENERIC(SHM_RND),
+        FLAG_GENERIC(SHM_REMAP),
+        FLAG_GENERIC(SHM_RDONLY),
+        FLAG_GENERIC(SHM_EXEC),
+    };
+
+    print_syscall_prologue(name);
+    print_raw_param(TARGET_ABI_FMT_ld, arg0, 0);
+    print_pointer(arg1, 0);
+    print_flags(shmat_flags, arg2, 1);
+    print_syscall_epilogue(name);
+}
+
 #ifdef TARGET_NR_ipc
 static void
 print_ipc(CPUArchState *cpu_env, const struct syscallname *name,
@@ -683,6 +702,10 @@ print_ipc(CPUArchState *cpu_env, const struct syscallname *name,
         print_ipc_cmd(arg3);
         qemu_log(",0x" TARGET_ABI_FMT_lx ")", arg4);
         break;
+    case IPCOP_shmat:
+        print_shmat(cpu_env, &(const struct syscallname){ .name = "shmat" },
+                    arg1, arg4, arg2, 0, 0, 0);
+        break;
     default:
         qemu_log(("%s("
                   TARGET_ABI_FMT_ld ","
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 6655d4f26d..dfd4237d14 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1398,7 +1398,7 @@
 { TARGET_NR_sgetmask, "sgetmask" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_shmat
-{ TARGET_NR_shmat, "shmat" , NULL, NULL, print_syscall_ret_addr },
+{ TARGET_NR_shmat, "shmat" , NULL, print_shmat, print_syscall_ret_addr },
 #endif
 #ifdef TARGET_NR_shmctl
 { TARGET_NR_shmctl, "shmctl" , NULL, NULL, NULL },
-- 
2.34.1


