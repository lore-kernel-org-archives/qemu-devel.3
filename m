Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568FDC27C41
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 17:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7IUU-0005F1-AZ; Wed, 15 May 2024 13:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1s7IUQ-0005EU-RV
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:32:31 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1s7IUO-0002PU-EC
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:32:30 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6f449ea8e37so6127838b3a.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 10:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715794347; x=1716399147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=esogItfSZKIjFBvKzqHcGNPz5akAvaVQY8PX5DqLKHw=;
 b=uWsVhxja3h2c9ptnbQkIHAUsNjvfcazb0kqweIxSuC3Gb1nsYvZCqf2Lyt/r+7whKx
 C1e/k8lOQ503PllrcmYuWyO8hJKcb5HrnN3i1CyZtw+9pFYhcAxbMUlJNJpsZnwrCanu
 T0vAojFlaFfv03kk/2iBXmjbQthNxowyZ6o9s9jlUVF5NlmeZ8gUjlDByJUSFqomUoB/
 4bw/DOCz/XvDLwIj45PpZ02/KoWYk8AP3LcgpJ8Pj/1vmXijVO9IW/9+EmactQl/1eeC
 RHXv6gNvb8DOZj/NvGO1bE/PUndFmt3NA1YBhw8s3XWjiVUjPOVpziD7d43NzwJYfUSq
 Q9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715794347; x=1716399147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=esogItfSZKIjFBvKzqHcGNPz5akAvaVQY8PX5DqLKHw=;
 b=M13uP7gYncc1DdMW9q9IZjzRONZqAF45qfEHPiFrGaodjTJybWs7pi5ZKfibFTBzyA
 mmP+iYJagF+1eZD15s78rHLIiKPtloScMzfF9B2C+nj8Hny5VbakDSZ//6HbB9fhChf/
 ESgQwJOPVBViqpYMXR/XqfEzW98jlcqpmqFliplS2AyC2dMpZwQ+T5YmBt+J7OhUvagG
 WRlwciB3qK3EU8ucULbjpBnBsEVXuvj4xpW16ieKHdvTuOPIsjQBnJuWnmJI3K8s/lF8
 4dy60yY8cVhTnfAfYS6S4IPG2SkMJ2wrB+QxW4aLHSJSxg19vyeWxwTThZxKqge/6SsY
 rmwA==
X-Gm-Message-State: AOJu0YxCRYwL4+xqFq2gwMRfSJSq8FFpmRE9Ya9mbxkLrHA9fhgX3NyN
 zPtjD9aJqC2JLrIZW5UJiW93OEODfSTp7CjWTJPKNMEjXpip1/q2+Fn6vLd7yhWsCc+EISNFMYT
 ovcI=
X-Google-Smtp-Source: AGHT+IFl06oazkiytVtHbCQh4bBqaIT+7e7oFHNX7sVqgEygqIAb9rkXj+2fPtLsqJRgKoMBbePTIw==
X-Received: by 2002:a05:6a00:1990:b0:6ed:de86:be57 with SMTP id
 d2e1a72fcca58-6f4e034850dmr26472314b3a.25.1715794346786; 
 Wed, 15 May 2024 10:32:26 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:224b:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a66c6asm11365133b3a.6.2024.05.15.10.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 10:32:25 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, peter.maydell@linaro.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH 3/4] tests: Gently exit from GDB when tests complete
Date: Wed, 15 May 2024 17:31:31 +0000
Message-Id: <20240515173132.2462201-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515173132.2462201-1-gustavo.romero@linaro.org>
References: <20240515173132.2462201-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42b.google.com
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

GDB commit a207f6b3a38 ('Rewrite "python" command exception handling')
changed how exit() called from Python scripts loaded by GDB behave,
turning it into an exception instead of a generic error code that is
returned. This change caused several QEMU tests to crash with the
following exception:

Python Exception <class 'SystemExit'>: 0
Error occurred in Python: 0

This happens because in tests/guest-debug/test_gdbstub.py exit is
called after the tests have completed.

This commit fixes it by politely asking GDB to exit via gdb.execute,
passing the proper fail_count to be reported to 'make', instead of
abruptly calling exit() from the Python script.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/guest-debug/test_gdbstub.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/guest-debug/test_gdbstub.py b/tests/guest-debug/test_gdbstub.py
index 7f71d34da1..46fbf98f0c 100644
--- a/tests/guest-debug/test_gdbstub.py
+++ b/tests/guest-debug/test_gdbstub.py
@@ -57,4 +57,4 @@ def main(test, expected_arch=None):
         pass
 
     print("All tests complete: {} failures".format(fail_count))
-    exit(fail_count)
+    gdb.execute(f"exit {fail_count}")
-- 
2.34.1


