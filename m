Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3972CD2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 22:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf3SW-0005Nh-HX; Sun, 11 Jan 2026 16:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3SM-0005LL-Ak
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:58:43 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3SK-0003rj-KU
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:58:42 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a0d5c365ceso40055155ad.3
 for <qemu-devel@nongnu.org>; Sun, 11 Jan 2026 13:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768168719; x=1768773519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7WU9noscw5cu2FvkNQz+IaG1JpungMpnx4UvU4kIi8U=;
 b=ng0dZFuq61lkzoWTj103/jRNHh/QHIn1KFQ4aVUJgnEwq3UJpntxMnH6qcSuv8oTNI
 JcZbTsNOhwNnBXKADFs50n7e9ERu/UvRI57IPas6eyT3t+5kAjq1reFMrL8AmuldSgYk
 dOcKVOSo/DD4R5tHa/qTBYIThp7gqXp57izfVCREfaZyI1IZeNX1JReTaEZ0Vl40NTDc
 mczqu4/C8GDxXTKOneemaBi4b49ATI3y9RDfbdTvE0ASRgY8WDnQWX5XtRBYa99lZxdU
 MY34W78a7DPcJnXQKuqd3fWpq8JTdxEIUPd7cFfe6u1kwArdhpr1b9niCcjFDjJvZ7NX
 4buw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768168719; x=1768773519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7WU9noscw5cu2FvkNQz+IaG1JpungMpnx4UvU4kIi8U=;
 b=Y7ZZYTHOTOgaAR/aCtUGYNutMqa0dYuBWPARE1KqfhtPhO7cYdYCJZRAxAoCOGTQ9c
 3p/XiBWhesFfzjqpCMfcQTvSS6fmQkg1fwj/ZyXGCq8CTKZKDi1v7MarrZS+sc876P2k
 UWDolGLRQly/NkvCloTfV6nhGFP5fghGqH1v76AAia1qMNSl/d9nvUZ3PqX3X0JHauDr
 9Fs3yXLTXeYNWXuWXo3lTwXKOEslOG5cjk+h0NdFv7HTSTu7JGbUX06WwXQtZNNZG5Cz
 LbDiRnxCUy6AcDx7i8qaBc2beSU7v1oj14Y0j6V/oAWuUctwk4ax4w7Pqr5otS5RrS5P
 gTfA==
X-Gm-Message-State: AOJu0YwbvW5VLxDM/nB388C7ZUTnoqTeMwH9l5t9lYR4wep2WoOthkUk
 /2OwdCV1E5HN6hMazZRSWpOc7FaMsVV9IY1j28Et5nqs63CeEiVJACU9rrHXcbhcwJM0FddtO2t
 +NxKGsS8=
X-Gm-Gg: AY/fxX4TSwT/6YhTE/eMb/FLBOIR4EM/xGntlkOM8IvxbgJ34bLiajjBs2420tK3MlF
 mKpwS1KskLP1z66vwBCyrgUr0tSPd1XDZsYekD27iV7OJG4YR/1zqU+oInd0zhLekgbobinfQBp
 t329OiMg6xj/EDH5Tm0HD1vT1fzyx5F1VYkLgve0BxnolCSCojkApl/BTy/bfcl8ejnHC4dXNB5
 IQkrCkv5CR1Y20s+Pg718MCQl9Z0eKN4TOf95rK47ukasH+0YVAryy9VMQogWmtUg9/y/p0Swiz
 YJ/mXYac8mBHeI/yiWSm5NC6+ztvBK0bVaECJfaZpWeJ5HNU+V+AfI48lQPO5bijMj0epiucCe7
 okqIFwOr2smepjXDjLcJA9EfHAxt0sQ+fuDPDwyxvckaHQMz4mrAD12waaLND/YASoJflc7GRDC
 kfEywIG21g61RurRdwZOZT9x8O4g==
X-Google-Smtp-Source: AGHT+IEerdqgdN8GnGZUht5YTwUffw3px/4VXHMiSaHJN/5tJmkGwDfnAhsAnBmbsLV9CwkaEcK3RQ==
X-Received: by 2002:a17:902:ecc5:b0:2a0:a0cc:9994 with SMTP id
 d9443c01a7336-2a3ee4d9312mr164280545ad.47.1768168719108; 
 Sun, 11 Jan 2026 13:58:39 -0800 (PST)
Received: from stoup.. ([202.86.209.61]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a31dsm155272365ad.9.2026.01.11.13.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 13:58:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Jean-Christian=20C=C3=8ERSTEA?=
 <jean.christian.cirstea@gmail.com>, qemu-stable@nongnu.org
Subject: [PULL 05/13] linux-user: allow null `pathname` for statx()/fstatat()
Date: Mon, 12 Jan 2026 08:58:10 +1100
Message-ID: <20260111215819.569209-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111215819.569209-1-richard.henderson@linaro.org>
References: <20260111215819.569209-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jean-Christian CÎRSTEA <jean.christian.cirstea@gmail.com>

Since Linux 6.11, the path argument may be NULL.

Before this patch, qemu-*-linux-user failed with EFAULT when `pathname` was
specified as NULL, even for Linux kernel hosts > 6.10. This patch fixes this
issue by checking whether `arg2` is 0. If so, don't return EFAULT, but instead
perform the appropiate syscall and let the host's kernel handle null `pathname`.

Cc: qemu-stable@nongnu.org
Signed-off-by: Jean-Christian CÎRSTEA <jean.christian.cirstea@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251229121416.2209295-1-jean.christian.cirstea@gmail.com>
---
 linux-user/syscall.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2060e561a2..ee7c34027e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12141,9 +12141,13 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
             int dirfd = arg1;
             int flags = arg3;
 
-            p = lock_user_string(arg2);
-            if (p == NULL) {
-                return -TARGET_EFAULT;
+            p = NULL;
+            /* Since Linux 6.11, the path argument may be NULL */
+            if (arg2 != 0) {
+                p = lock_user_string(arg2);
+                if (p == NULL) {
+                    return -TARGET_EFAULT;
+                }
             }
 #if defined(__NR_statx)
             {
-- 
2.43.0


