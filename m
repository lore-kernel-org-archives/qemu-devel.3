Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85201C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 22:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqKad-00055T-Pf; Fri, 29 Mar 2024 18:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKab-00054x-Qh
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:20:45 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKaa-0001ou-7L
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:20:45 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e6ee9e3cffso1660052b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711750842; x=1712355642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qF+Rh4Z//XloQGlanOoCz61ZgUvkOnM9tqWX1k+rwd4=;
 b=Xz7eHbhUkCd9TyXkGaZ+qKhgXg9FwIw29oA9BIPtTuV+Q9oIZ5/wsCdwt0DEN2avJS
 v4F3xqvcKqJs8oISaYN9lUfHFyQlIwIh2lBCF6fa0TTLDxrMmQfivQyG++cLbdPJPyyY
 5xuUkRk1jKTUjdrdAHmcFiwX3/DZUY1jKP5dPvzpwjqkWVgoWEFp3Xkqdd24ffFQgX9j
 XOY6O/OTAvh8AKZ0CAsdLiX9rxNI43gffYEpbmPvfyXFvQU3RYfisNSR4YpsyfdyWvuq
 zI5qFYIMtrn0+Yi6YaiKXYY6iE0Q0sIs9hqXqbAlli7TS/TWI8gOf9nwO++0OGlsp2AE
 DYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711750842; x=1712355642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qF+Rh4Z//XloQGlanOoCz61ZgUvkOnM9tqWX1k+rwd4=;
 b=OwT1nGCzT25Bs1bxPZ0MCPylINSPaxiLJlB8A5W1Sjw836b1jkh/CDVdztQ3dcjFi5
 i/fdilNGSw7aBRIjV5NHey8NzBkxNjFqP9PsMSiZOo/YTjl64rSEWDnDIZnTVlcGPAlO
 u1BWxMSdYgHtevAMXmJXv/p30u4Js2kgdeRcPZigI3UNi6fK90dsD47gYO/1lMGhUgg7
 PwET+dpaCYaGRR0vKWr7PQjB/pBdExujDiil+vxlSHhHkNR92/46ec4ThvU9X9Tjr51F
 esz7sEOcRsqKYDFys9COsdHq+pl6jlmKEXM2RelG5KevRmdb2LcPEbS8Nmsz8MibKet/
 JaYA==
X-Gm-Message-State: AOJu0YxFcSAY05H6fUGCea9fZ7tjuGvEqzEmJokIhn2uWSKdzH/r4Idu
 JR/Ji2Qm/bMAmts7uib6FX89QoKkJWaubc20KZl+lBmgtgEgi95eblctehdLvzAjqEOzAQ3Jhk8
 N
X-Google-Smtp-Source: AGHT+IG0RhdooewXZV5S7wSZqjvQgtG2LAV/IdTuEFq5PWQN37a1i8WimxMt8cqQSbl0cZAwIMtKAA==
X-Received: by 2002:a05:6a00:2e22:b0:6e6:fb9a:fb45 with SMTP id
 fc34-20020a056a002e2200b006e6fb9afb45mr5145614pfb.1.1711750842349; 
 Fri, 29 Mar 2024 15:20:42 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 lc24-20020a056a004f5800b006eaacc63435sm3579811pfb.173.2024.03.29.15.20.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 15:20:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 1/7] linux-user: Fix semctl() strace
Date: Fri, 29 Mar 2024 12:20:31 -1000
Message-Id: <20240329222037.1735350-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329222037.1735350-1-richard.henderson@linaro.org>
References: <20240329222037.1735350-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

The indices of arguments used with semctl() are all off-by-1, because
arg1 is the ipc() command. Fix them. While at it, reuse print_semctl().

New output (for a small test program):

    3540333 semctl(999,888,SEM_INFO,0x00007fe5051ee9a0) = -1 errno=14 (Bad address)

Fixes: 7ccfb2eb5f9d ("Fix warnings that would be caused by gcc flag -Wwrite-strings")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240325192436.561154-2-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/strace.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 8d13e55a5b..51a5bdd95f 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -657,7 +657,6 @@ print_newselect(CPUArchState *cpu_env, const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_semctl
 static void
 print_semctl(CPUArchState *cpu_env, const struct syscallname *name,
              abi_long arg1, abi_long arg2, abi_long arg3,
@@ -668,7 +667,6 @@ print_semctl(CPUArchState *cpu_env, const struct syscallname *name,
     print_ipc_cmd(arg3);
     qemu_log(",0x" TARGET_ABI_FMT_lx ")", arg4);
 }
-#endif
 
 static void
 print_shmat(CPUArchState *cpu_env, const struct syscallname *name,
@@ -698,10 +696,8 @@ print_ipc(CPUArchState *cpu_env, const struct syscallname *name,
 {
     switch(arg1) {
     case IPCOP_semctl:
-        qemu_log("semctl(" TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld ",",
-                 arg1, arg2);
-        print_ipc_cmd(arg3);
-        qemu_log(",0x" TARGET_ABI_FMT_lx ")", arg4);
+        print_semctl(cpu_env, &(const struct syscallname){ .name = "semctl" },
+                     arg2, arg3, arg4, arg5, 0, 0);
         break;
     case IPCOP_shmat:
         print_shmat(cpu_env, &(const struct syscallname){ .name = "shmat" },
-- 
2.34.1


