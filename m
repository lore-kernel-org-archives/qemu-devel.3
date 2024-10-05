Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7793BCFB421
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 23:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxEHc-0006Cy-RN; Sat, 05 Oct 2024 19:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxEHb-0006CZ-Vu
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 19:33:55 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxEHa-0004E9-Iu
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 19:33:55 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e18293a5efso2300546a91.3
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 16:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728171233; x=1728776033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F2PtOJCUNqbnhgRp0PzmkQFuI5aOsUosexzj1Se6aBs=;
 b=murOCSQ8hvhLMnhb+ESpSC/KB1TUufVo5XSJYWzRjqR+uvh3o85zUl2TE3N+SRELf4
 QGqGWr4WjNbsW20meFia20Par8gr61SmRv12GjOH3lndGtfw4hEIKFJ9/amQe1ycR0w9
 wfsYyUbpm3m0b6mJxP/zLZEuYlggmybWgHYRWUhP3mIolkvF72NSJmobMBfu8NOsTzIP
 oRgz6LqskXK3bA3BKfjuMJRSR4YcKpxMqU5CDQp/sSiwXZ22CiqQtljEuKXnuQKmWtiI
 LaU74yMLPl9YxEldA+7JTlWA7LXBhcLi2do2FacysBuUD0bD4Lw/+DjLb7js7gCYmbm4
 Sd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728171233; x=1728776033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F2PtOJCUNqbnhgRp0PzmkQFuI5aOsUosexzj1Se6aBs=;
 b=ORKEcWCZxyKPGp83E9MvyDADb8n8FZb+5ZaFPVdmErzXhXvLl+BqaMsqZ75JUom6sc
 09GkiVwM6hKoENJ60IR2PTTLYFso6cj8T99T+Lh5ukiilf6bdwjDMraChpcsaFukkNql
 qiVds7LchBFDarOK10simtq9rFfL1wq1OvEWqM5IYKn+5g3+jV28QOETYd4P6igyPE4f
 K+lL53nhEn/HMMiCgUfPeE8NbDo2bPBq8Mrk7m7kbZKYYCPJ+41m8Y6FO31IWkMDy+Yz
 fUkJG0UgV2QW1F261iUT0dKPP1qeHC3CIu8AIiwZlM+SfReCw5G5i+xiIP26ITbJPFW3
 Uv3A==
X-Gm-Message-State: AOJu0Yy0IlNt3N4nt8zRSQoqRReHTk7Mbjjq2HmUuXH8EZOnxUn9V7Fu
 yguxeKHryYBlsHIiqO/Xy2P6ECVKkr6IsQ1lOysKb4T5WS5RGmBRZ1laHS5/vHPV0EmM41EchDL
 q
X-Google-Smtp-Source: AGHT+IEbMPSNADjINV+ga8t4OoJ/mPVhKkO64FDtEbO//PvE2yvPmqTEGOqn57vGgYyzm0AHQor0VQ==
X-Received: by 2002:a17:90a:f40a:b0:2e1:e433:767e with SMTP id
 98e67ed59e1d1-2e1e631e566mr9485663a91.28.1728171232947; 
 Sat, 05 Oct 2024 16:33:52 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e20b129cc2sm2394600a91.51.2024.10.05.16.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 16:33:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 09/10] linux-user: Add strace for sendto()
Date: Sat,  5 Oct 2024 16:33:42 -0700
Message-ID: <20241005233343.503426-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005233343.503426-1-richard.henderson@linaro.org>
References: <20241005233343.503426-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20240807124306.52903-5-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/strace.c    | 15 +++++++++++++++
 linux-user/strace.list |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 245153c1ce..0263e6a396 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -3142,6 +3142,21 @@ print_bind(CPUArchState *cpu_env, const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_sendto
+static void
+print_sendto(CPUArchState *cpu_env, const struct syscallname *name,
+             abi_long arg0, abi_long arg1, abi_long arg2,
+             abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_sockfd(arg0, 0);
+    print_buf_len(arg1, arg2, 0);
+    print_flags(msg_flags, arg3, 0);
+    print_sockaddr(arg4, arg5, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #if defined(TARGET_NR_stat) || defined(TARGET_NR_stat64) || \
     defined(TARGET_NR_lstat) || defined(TARGET_NR_lstat64)
 static void
diff --git a/linux-user/strace.list b/linux-user/strace.list
index f8899710b5..64d24e16d0 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1288,7 +1288,7 @@
 { TARGET_NR_sendmsg, "sendmsg" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_sendto
-{ TARGET_NR_sendto, "sendto" , NULL, NULL, NULL },
+{ TARGET_NR_sendto, "sendto" , NULL, print_sendto, NULL },
 #endif
 #ifdef TARGET_NR_setdomainname
 { TARGET_NR_setdomainname, "setdomainname" , NULL, NULL, NULL },
-- 
2.43.0


