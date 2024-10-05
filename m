Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58748CFB421
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 23:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxEHc-0006Ci-C4; Sat, 05 Oct 2024 19:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxEHa-0006Bq-Qk
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 19:33:54 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxEHZ-0004Dz-BN
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 19:33:54 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2e18856feb4so2807800a91.3
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 16:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728171232; x=1728776032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=280plYgj9pKDnH+V9HZdJ+ePLYDZqB5eIDcpDzTLK4I=;
 b=D6Jz87m3IxHmMjgpUgCgxFBNVnhsM5yu36b3KoUcAT8T8Fr9MEw8YmzWtBobjSLYcA
 1FeUJ4PqCNqFp9x/q4yzdbqHUR0lKiLCAaZIaI+IwqIkozHElRhhnucGKcQUp7zOmQKO
 2FHWOxmHoPYQ8eiqjiAbPLXmMDi0TAmkEr65+85BBHbRD5MbJbne27vSYZ+vRQGzqdHT
 7l7LGydYbI7r05vJ70mg+1+GpJkq5baxdVmwYaS8TkjUDmT5Vfq/Ny8HjigcSOaMhFnN
 Ebw/HsS0kzJRJajwmwEooicOqBnHEodt8OAhnxfgygOm6FRl203o4/KFL7A0AU4rjDr1
 o6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728171232; x=1728776032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=280plYgj9pKDnH+V9HZdJ+ePLYDZqB5eIDcpDzTLK4I=;
 b=gV0+V5+3/HaQRwEnlxXobWY8szZnRv06u1PQn/x10Qeg+QTs9k3nrI1UNyfkzLSAvC
 199FdJjjdyTvOqJhcawShszwCfy6dN53tRE68K1a1pkMctolTIR4LAEMPCoSEUD9G6r3
 gZdF57NL9vebBPBm+Os+isXDu7XOXoDc5XcDCj495JqAISwm4KQ5Fh8i0s13Tg8Ey5VG
 0qBI2299Zl+uS40ahM+R5WWSFM64+gZDmhtCv4cMpJkBypeKNXbeOl1MEq614rnCtu0Q
 XkbePXqlCPyTW3s5Kzn9U4q/TOXEDncu3owxSiLGJex0kQheGb9M9qsRp4fXn7wxtw4L
 j54Q==
X-Gm-Message-State: AOJu0YxwVImJXnI7zSs6sp2Pxg4A1DGUR0EJA+wBAEBkK2qvvkZpLYqd
 4czwz3LaGj+yJ1s1KWFaWE53wYTmqcRQr/sNUq9ASL7GviWbZHz/XkLnaMieGu4PaiocH3Z6ad9
 i
X-Google-Smtp-Source: AGHT+IHeVUFhAOKjMoVYlMYITPl9jlUwiiBBQyqNrfmAXoHVx70TtF0cwi5jKySCxbuREZur2DqfIg==
X-Received: by 2002:a17:90a:2ecc:b0:2cf:fe5d:ea12 with SMTP id
 98e67ed59e1d1-2e1e626c037mr9183664a91.24.1728171232101; 
 Sat, 05 Oct 2024 16:33:52 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e20b129cc2sm2394600a91.51.2024.10.05.16.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 16:33:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 08/10] linux-user: Factor print_buf_len() out
Date: Sat,  5 Oct 2024 16:33:41 -0700
Message-ID: <20241005233343.503426-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005233343.503426-1-richard.henderson@linaro.org>
References: <20241005233343.503426-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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
Message-ID: <20240807124306.52903-4-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/strace.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index b72fcd515f..245153c1ce 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1670,6 +1670,13 @@ print_buf(abi_long addr, abi_long len, int last)
     }
 }
 
+static void
+print_buf_len(abi_long addr, abi_long len, int last)
+{
+    print_buf(addr, len, 0);
+    print_raw_param(TARGET_ABI_FMT_ld, len, last);
+}
+
 /*
  * Prints out raw parameter using given format.  Caller needs
  * to do byte swapping if needed.
@@ -2757,8 +2764,7 @@ static void do_print_sendrecv(const char *name, abi_long arg1)
 
     qemu_log("%s(", name);
     print_sockfd(sockfd, 0);
-    print_buf(msg, len, 0);
-    print_raw_param(TARGET_ABI_FMT_ld, len, 0);
+    print_buf_len(msg, len, 0);
     print_flags(msg_flags, flags, 1);
     qemu_log(")");
 }
@@ -2776,8 +2782,7 @@ static void do_print_msgaddr(const char *name, abi_long arg1)
 
     qemu_log("%s(", name);
     print_sockfd(sockfd, 0);
-    print_buf(msg, len, 0);
-    print_raw_param(TARGET_ABI_FMT_ld, len, 0);
+    print_buf_len(msg, len, 0);
     print_flags(msg_flags, flags, 0);
     print_sockaddr(addr, addrlen, 0);
     qemu_log(")");
-- 
2.43.0


