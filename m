Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8C3C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt7u-0001y5-9h; Mon, 08 Apr 2024 13:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt7o-0001vF-LP
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:47 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt7m-0003cX-3N
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:43 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2a2e5d86254so2843431a91.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598581; x=1713203381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Qew14nZN1wX0iqwNUmvetvShYAajmyZbQ1f420VzBg=;
 b=iwHzkw4pzzQ7c3GDiaxYPb5tT+v8uc9OVBQ7450iPDqc5vrBueaIdzuFRCV3pz7Mmo
 9eyAUXretJDJXn425r8/rBpbc6bC2VGpK0awp/C+CgyhYSdZOQXVStdWIX5qk2cxJmEi
 5QHeWqD83XXWfuLoRYpDVeOp90D6d5PWpXD/lmJzJmnPWzj6XPW5id430+oHAD1stZ/j
 EKewZuYz0tUADq58rcC2qapdZHhjkOkQ9k384r/wtY5P/bIbFWa4Jnpp5LxUL1IB6V6D
 9xUcV9vgDJ164jaw40lRqG6RbOkIhfzOOAm+1sD4FrBBfUuQloaGYkxmiORqSuXTY6Yy
 VPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598581; x=1713203381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Qew14nZN1wX0iqwNUmvetvShYAajmyZbQ1f420VzBg=;
 b=kqLtlnznakzJFhpETOZwSHsTavMhVKAES743hxRa3bjEoLV579o8n+HQUh3vO0nrxd
 PpECH9LyXdsktLe21qcvaZeldCjJrpVsrHmJ6t8UjHMi9kYDFAm1PpEtZ2csHtq45225
 Xs8xemO3lRl89UzRU8rMRSq6OVSrYAJqD1VqH4OeMQwq+0o/z0RVIz+DNAukKh1FCmAo
 IiVAdpWhobyVRgr8xFZEV0djI8hYvjE9rZM7YmU0g/KL+OXa4PxVb6I64WTbpRjE5+88
 7oLaabyOUxBpuZRCOs6SllZcw44GWs6razDbFM3Sdnp9Ctq29k3UCuKbRdoHYrIhu5/E
 a6eA==
X-Gm-Message-State: AOJu0YzA0ygR2lyIRRTuSj0cYVbxDLgdGBc/hEBNfG4uVlJi9MvWzNQt
 FOtkSgUlWWr1C0R2QKcZAoLXmurI10DlGoHmCKl8iE0GMsWcibq8KC91b+TTvUFxNxFaWMNQkFo
 1
X-Google-Smtp-Source: AGHT+IHmHnMtXl4S03sg3R4v8rU+hx0IboggSdJJ5/PA4KVEurOug3xnOtW7GR8TCnnzr4sLTzti7A==
X-Received: by 2002:a17:90b:4c12:b0:2a5:242:6761 with SMTP id
 na18-20020a17090b4c1200b002a502426761mr487799pjb.23.1712598580721; 
 Mon, 08 Apr 2024 10:49:40 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:49:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/35] linux-user: do_setsockopt: eliminate goto in switch for
 SO_SNDTIMEO
Date: Mon,  8 Apr 2024 07:49:00 -1000
Message-Id: <20240408174929.862917-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

From: Michael Tokarev <mjt@tls.msk.ru>

There's identical code for SO_SNDTIMEO and SO_RCVTIMEO, currently
implemented using an ugly goto into another switch case.  Eliminate
that using arithmetic if, making code flow more natural.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <20240331100737.2724186-5-mjt@tls.msk.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1fedf16650..41659b63f5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2301,12 +2301,10 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
     case TARGET_SOL_SOCKET:
         switch (optname) {
         case TARGET_SO_RCVTIMEO:
+        case TARGET_SO_SNDTIMEO:
         {
                 struct timeval tv;
 
-                optname = SO_RCVTIMEO;
-
-set_timeout:
                 if (optlen != sizeof(struct target_timeval)) {
                     return -TARGET_EINVAL;
                 }
@@ -2315,13 +2313,12 @@ set_timeout:
                     return -TARGET_EFAULT;
                 }
 
-                ret = get_errno(setsockopt(sockfd, SOL_SOCKET, optname,
+                ret = get_errno(setsockopt(sockfd, SOL_SOCKET,
+                                optname == TARGET_SO_RCVTIMEO ?
+                                    SO_RCVTIMEO : SO_SNDTIMEO,
                                 &tv, sizeof(tv)));
                 return ret;
         }
-        case TARGET_SO_SNDTIMEO:
-                optname = SO_SNDTIMEO;
-                goto set_timeout;
         case TARGET_SO_ATTACH_FILTER:
         {
                 struct target_sock_fprog *tfprog;
-- 
2.34.1


