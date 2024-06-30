Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FBFC3064D
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 19:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNzoA-0005Vq-Ry; Sun, 30 Jun 2024 15:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNznU-0004yM-SL
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:01:13 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNznP-0007ZR-BY
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:01:12 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5c21ba58227so1235578eaf.0
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2024 12:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719774066; x=1720378866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6nLIZwPhlbR4+HoVwsyjSvgsNERsQEppTTQuHndlMMQ=;
 b=h/ZNHLch0dyNl5zWh2TNdikIiN4kcISbg2oLf+24PurDXUo2EcZm1HrP9L9k4JJ85c
 pC33smzyUpILqXDoSqTEylfZTbTkAYuSnKLpuZlFsfj3QijX1njzYc/2VQ3ivGcxd4mQ
 pOeva/XUEoxHQe1zmGoPmzIHVcX2QK5hhTIsCuIj+hxqUJSrR1q+xyM+HYfqXaZ3Pu5e
 C7coelTQdnWaXBXPce3WBQFHvy2lcjhEMB0FNE4+VsRRI5ZBGlac7rG3b5CK8FvglkPg
 YvJO5HsBBmwCY49QF5wd37g4sL7P5kxZXbbzbnMzWPcK4lycdxrlapfNrjIc6w96b17K
 zP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719774066; x=1720378866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6nLIZwPhlbR4+HoVwsyjSvgsNERsQEppTTQuHndlMMQ=;
 b=eA+jEtsgHd+ZV5jYnSbl/5+qJja/6Mjgxq5sPLOhjiAnk8pVK93OEiy1/CtfKHLw4n
 7zZaoU8vd0x8l2su0jQYwVpEpvnImRUSoLQRK5qSGd/0G8vYx2e59UMN2YJaaH0W5cn+
 tWzl5gTfD6f6det/77B2I/pUFSd++V/ywZ5OxC39QPqYYm026D8NtZsvtNnEOu8SE9H5
 L3Km8ZJBo7eAQrFsa2pNLrYO9EJNNazLqonbh/C1SBGmff3VA75WZLVf0/Cuhd+KxSfO
 if9wC0zSEsN0J5JXxZWTU+01VImAO9545n8/1iK0amWy41mU4HOcEf/IqblB2PxRqi/7
 x/hA==
X-Gm-Message-State: AOJu0YxjxJUBiphqepLKiOK/zn7Qbcm7aLyMh/YDyZGJyJ7cJiT5AlZT
 1u4tLFDmxzklYtp2EcrvhJ+7OqTaklUIkrTXPT/wGkQfQPlTJIeWxE2/uyRBN4NpJo99UVYp0Ea
 b
X-Google-Smtp-Source: AGHT+IEqWP513l7m3XZokZvK4CqxnJ96fkduIxaMkV40JqrLQBySIAhHrU1eNkTdPS+LPu2XPqX4CQ==
X-Received: by 2002:a05:6358:6f93:b0:19f:509e:ae38 with SMTP id
 e5c5f4694b2df-1a6acccd1a7mr476425455d.5.1719774065617; 
 Sun, 30 Jun 2024 12:01:05 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3e7e4bsm5115641a91.52.2024.06.30.12.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 12:01:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com,
	alex.bennee@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH v4 14/14] linux-user/main: Suppress out-of-range comparison
 warning for clang
Date: Sun, 30 Jun 2024 12:00:50 -0700
Message-Id: <20240630190050.160642-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240630190050.160642-1-richard.henderson@linaro.org>
References: <20240630190050.160642-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

For arm32 host and arm64 guest we get

.../main.c:851:32: error: result of comparison of constant 70368744177664 with expression of type 'unsigned long' is always false [-Werror,-Wtautological-constant-out-of-range-compare]
        if (TASK_UNMAPPED_BASE < reserved_va) {
            ~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~

We already disable -Wtype-limits here, for this exact comparison, but
that is not enough for clang.  Disable -Wtautological-compare as well,
which is a superset.  GCC ignores the unknown warning flag.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index 94c99a1366..7d3cf45fa9 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -843,6 +843,7 @@ int main(int argc, char **argv, char **envp)
      */
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wtype-limits"
+#pragma GCC diagnostic ignored "-Wtautological-compare"
 
     /*
      * Select an initial value for task_unmapped_base that is in range.
-- 
2.34.1


