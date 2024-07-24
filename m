Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7F5C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 22:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWk8J-0001x0-RR; Wed, 24 Jul 2024 18:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWk8F-0001cj-UX
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 18:06:47 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWk8E-0006f1-9O
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 18:06:47 -0400
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7f70a708f54so12523339f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 15:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721858805; x=1722463605;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tlPxaf48ESlCF6z303PSbBfya6HxzRZ782+k35fLNmg=;
 b=fxx7QMxVEn/hGx3Z5WzUC4WOa3IXuhi2T9lNAUuQckrp/L6YegnNabSvWfS77KhjrV
 joJ2mlk7af5joyktCYQanrqxrGgO3eJ188eG7p0KW1gNY7iGjvF/8lN9EzExQeRMRfVJ
 y2NEnpsxjqulJwW7zeccmb7mCvkXIEZNQ8Q0BtlXtC0vMzZpohQOKY/97MsZCsd4dUew
 6tvl/W8OVjfxCEAfDnGFZs4GkA/cAEStalYAKbUxH0Hbsm8mTm4PbQc9qw9q2fIruI3j
 yokR9QoQ2411JSYtlB0ddT9ywBA1sgYqP7GHFIiNarv5fjHp3USP+ZQi0I8HNJ7MnOOk
 DY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721858805; x=1722463605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tlPxaf48ESlCF6z303PSbBfya6HxzRZ782+k35fLNmg=;
 b=nBi25dmTPdJc7W2uNkpZXvJF/+ySfJp+nymHJUIJdqQLOWIPnnIuHf9q1d0YX7rEK8
 uwWhSHHCCzD4FycrCIi2cYKBs9VUahZ6uC1gqbggWJqHtGujoIOZU/3mhH67BwztzZDh
 lVyWBga68qdITzZZ3A2ITAjBCKbh/7UKs/CPPDI8fu4CzfYe608TTbEk3+hYlBvLK8Y7
 9O14mUqkApGAGd+3fzlgRYYLhDT74MgYm2hOh62l4hElfB0+EC6lO9S440FY7R6WetaO
 Z0SEp1tX1I/XTwHy5Ky2JbbdCd7yUsQsXWT+7nufIAIDOoUMClfjvnMU7uRHOc2PPiFt
 Gysw==
X-Gm-Message-State: AOJu0YxrBeuP35U804x6aVG5WH23HpEgxoiE7JvQ8BqK1SKPUrgsoAwx
 ktfoHQMCJk/h+wHcDy/V7BhqowtYLl3l09TDaTe5WEf7UAhojg7zHbJN4GHj2/VZr7nO96D9DIc
 QSX0=
X-Google-Smtp-Source: AGHT+IEEDJyC9YOGHODsW8O+uRIMRt7uYzOsva1xjOBFYbFnhWIlF91mswEA7XwB2BsvZQpzKtvEPA==
X-Received: by 2002:a05:6602:6342:b0:7f9:1b3b:8465 with SMTP id
 ca18e2360f4ac-81f7be7104dmr137960439f.11.1721858804899; 
 Wed, 24 Jul 2024 15:06:44 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c29fa983f8sm10086173.47.2024.07.24.15.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 15:06:44 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 14/15] bsd-user: Add aarch64 build to tree
Date: Wed, 24 Jul 2024 16:04:47 -0600
Message-ID: <20240724220449.10398-15-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240724220449.10398-1-imp@bsdimp.com>
References: <20240724220449.10398-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d35;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd35.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

Add the aarch64 bsd-user fragments needed to build the new aarch64 code.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 configs/targets/aarch64-bsd-user.mak | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 configs/targets/aarch64-bsd-user.mak

diff --git a/configs/targets/aarch64-bsd-user.mak b/configs/targets/aarch64-bsd-user.mak
new file mode 100644
index 00000000000..8aaa5d8c802
--- /dev/null
+++ b/configs/targets/aarch64-bsd-user.mak
@@ -0,0 +1,3 @@
+TARGET_ARCH=aarch64
+TARGET_BASE_ARCH=arm
+TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch64-pauth.xml
-- 
2.45.1


