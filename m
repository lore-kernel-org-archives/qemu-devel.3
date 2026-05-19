Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4E9CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLhw-0007pP-Hi; Tue, 19 May 2026 10:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPLhu-0007oT-F1
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:46:06 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPLhs-0007ew-K8
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:46:05 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488ad135063so29223125e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 07:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779201963; x=1779806763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K1V+GWtucxSZl1YZ8nu1MtklisKojriGnpVCnzAvOg4=;
 b=xkn6a+qV+avhcrRTRKNN2qMlXjRY/eh0qKNxbGbnrc6cVtskrcPAwuyAMu4PKqvIW2
 VhjxYHY2n4mBuRNndvOP0toHcfZD6EY8ebYOG0F5Sdel7JWABQr8Q2iCbB4MdcRt2DB7
 8spTb5YuOGWEWZPvsRZ+lbGCiHIy0IreMRB82vuY3Yx8Odo/fukpax5YwIsR0p4TNeij
 V6xWbkGuhdESDsML40vjBSqwHsaL9KQVT4xB66oPHIibtqJfvfNIx4TIcCvpOtutdeZH
 SXSgs7IOu9/qaD9GWb4gbNsUEOe/McXmDjYOMs43T0OkS7+8RZWZQhdSs1yaKuV4LM2U
 1nWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779201963; x=1779806763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K1V+GWtucxSZl1YZ8nu1MtklisKojriGnpVCnzAvOg4=;
 b=XMYDSLRDvQcG1tNYf7QPLJlwYvk8hjKouMp4nRiqMF1+eyYDBxUwFKU1sdGdZqP3qC
 I5VIbZ+zoTDSuKaYxZizhnSaNoS0FtdvcMHx61KKcAGZHkmD/yfmGwH6K24Kx8RkFEAb
 88IdlbfsliUE/nDmzbynXmByuSPbYlRf5Jtl7rMh53zRUogHrZf2glJ3lKoelv4udlPc
 0O0ppsNLV9HrHTMXsLJFNoc2M25uPOmIBUN8d/aQ8VcTq6McFmT4oEdDu7MrGEbDhgUS
 vkCGgQpHX1cOvFeVP9FaGCXpv1m0RgfHJCsxK1E6VWnY24/zT84iAsesjg2LNtkiCQPb
 9lKw==
X-Gm-Message-State: AOJu0YzIKZDlOjc0JdwRvIXjpAksZA9rePgMSZQq88WfVTRhJ5Gc6sn3
 17k0Ev7QvxzjrLkZSZBOm7eCTErObkYwBYkCsHC23MulPWb89X108oLBA95WkYjFMjC0KsA7lQc
 EP50LD/4=
X-Gm-Gg: Acq92OFzkVIyKWglUuLp93L3qiK9FvzK11gpZULTc7HUMHeTOGU8XtHW2oKzlz0PkIZ
 fcSWR+g+/P3fQHMuGMVmEPnFp1dqsCKAP/+g24uQrg99/lBZzh9mqxJBtmjN1ytHlmPvTXZIdCg
 XX/X3xV0Pzj2IVdfWdPC7ZXqP/QbgHDo6Df1jZVQAKmKGp4Usy52AWoI7V5Fp7zFmvBazCK50Uw
 /mbs0YdrC4Py6YU7rsb92efKZd15Ew1L+4VJ3P+iDSK/woc68XAKtGETA82i2NL9MOeXp3XkNnb
 TU0acHgjEedQpi3lpiZoogtFCR6IlkXZyQsW+2CtC6LbAs8eO+3CGkNP4hPNznS5aMSKBbJc1bm
 mxQAIjQDVYJpf2hJbP/NnGd9/kt4ZgRafYn0zMGP6Ew/83+p3LrnjvytlbVtNxic3zLMGFyMfk2
 EBruEEs3/3Uv7LDpwsG4BxnMQ42nClNYG8qRlkzNkauL10TISaWo63aoumiyvPrPtFKUctAooi
X-Received: by 2002:a05:600c:4fc9:b0:48a:5821:5ffc with SMTP id
 5b1f17b1804b1-48fe60e473bmr275437895e9.2.1779201962193; 
 Tue, 19 May 2026 07:46:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feae166dasm124982975e9.9.2026.05.19.07.46.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 May 2026 07:46:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 01/18] tests/qtest: fix discarded const qualifier warning
Date: Tue, 19 May 2026 16:45:36 +0200
Message-ID: <20260519144553.91483-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519144553.91483-1-philmd@linaro.org>
References: <20260519144553.91483-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: Matthew Penney <matt@matthewpenney.net>

Modern compilers warn that the result of strstr() may discard
const qualifiers when assigned to a non-const pointer.

Make 'found' a const char * to fix the warning.

Signed-off-by: Matthew Penney <matt@matthewpenney.net>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260514191844.105888-1-matt@matthewpenney.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/libqtest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index bf9284b9a13..b1e06ea364e 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -2146,7 +2146,7 @@ bool mkimg(const char *file, const char *fmt, unsigned size_mb)
 bool qtest_verbose(const char *domain)
 {
     const char *log = getenv("QTEST_LOG");
-    char *found;
+    const char *found;
 
     assert(domain);
 
-- 
2.53.0


