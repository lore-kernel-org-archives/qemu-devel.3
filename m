Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEEB7C44501
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 20:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whCs1-0004Nj-6v; Tue, 07 Jul 2026 16:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1whCrz-0004MU-Mr
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 16:58:19 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1whCrx-0003Tl-W2
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 16:58:19 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2cc891373e0so191555ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783457897; x=1784062697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ONeQxTX6zVeyaqgGj5YDAsOZioB0I+Oo3ukHN35N4cQ=;
 b=hMiNti7cVlPaXxco9S9DlWIkpQFa27fCOH4JnKP68+HFcfJJpwOG8XRESy8yo8M5ZD
 9OeN+Q8zuVjRwwBrywiydx5wl0MJWabxGDW3uyMBmbPRAZfcUoa1S1mGJorzaon19Dm6
 J3cEBOIsYgTwJtOt1mgZWhmaovdUyXmcPr/IN9IpAoyQwR91SC5Asn8yxe2Zjly56NN7
 AomlJSwzGSzluQE7Esv+ewJbsJPHeMmcS0KmvYPsYR6K0DTerAKucg0B4qcjfYesliMh
 69Buzs+ZbQ/dMww+hnUXj/sjUjDRk8ZworFSuT5xjWVztfmKwfdP/ZdxQtXu5fUXLBie
 EiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783457897; x=1784062697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ONeQxTX6zVeyaqgGj5YDAsOZioB0I+Oo3ukHN35N4cQ=;
 b=Cah8LNnC09+8LY4yB1fc4DgCkQ5kOO3j2yscNuZ8GCAh/oVdqShhscE6TjEymNnq6O
 kUijqRTTOmZcoFKG8+sC6VB/wBod5OUe1mnZc0dX5Fk7hzvI6UQfO8o1vI+2ToeoyNQ0
 XNWVT1UoxPwATzdyJZr1EDnY+XcTzJM8gyp3S2z+M10BS3wQ9mUFlsAKw11jjj1G71YM
 YvawSXKqEzTLv3iwglXmNWG1ZhH6I/yb+SKkgWHROquIZ7Wmx8rVda5twsGh2iFxg5me
 e0dk6egNewp2NR/64ozMf8b0gpL0GSnr9RJky4xCjeXi6ec+4CpIHBL73lBOnQqe7OzH
 zoCA==
X-Gm-Message-State: AOJu0Yyb3hCGztEIzDiNfKlXblqsfM5SzWCzk02btgdZE0+rfcG2Ceqj
 IRNu+6lrO6nD/kGPxEXCqRsI7c4VOJbdh2RDIEHFBQmIjm89BWcHhjLpRINazggYjBVD00lQ0h3
 LWJby
X-Gm-Gg: AfdE7cmpmyoMQtT3nu4IodR+J+lDs/Sux/lhbMHo9LwpvKFx6yKPrz3AHLpGOgKCtAE
 TuHruFsAKQYq1R0o+d4EWFH4dQtV5rHrSeJhU0iaBG+vnpryqdqg1cT7YjsuaZ9uR1s2bKyJJ0t
 X/Ar7Ih6SOg5r1/DrkNk2jypl6+dT0bkH6yvzeQZ/O15sp6k0dYenNOYuOjn44P3jFhFOPKhBND
 KVMhdJCDiYvbOtEjhvqQ8Sp3++V/Prf2mpW458om8fKdtAVQJZ+NNmqIhRQrvn3JUQ0hwl9urNm
 a/E5QhgrFnCkTnYgoWelvgE+WHPmpyr2odlex9h4dZF2GB7JZywcvqfS22N0yyrV9lpJDzz4cuk
 aUDFatou+aa+3yvcfO8xfo5Ce+/PqO6nfJ08qp2pzIVdsuejjaJVzoPO1a+vuCKV9iekuQI9w99
 v/hPfsagGHVvhSf5hTcfYJI5qo01TfuW9raDUYnpopXJUGMeg=
X-Received: by 2002:a17:903:2986:b0:2cc:ae2b:b6d2 with SMTP id
 d9443c01a7336-2ccbe615d32mr63129715ad.15.1783457896559; 
 Tue, 07 Jul 2026 13:58:16 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bc2asm17980575ad.69.2026.07.07.13.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 13:58:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 4/6] Revert "tests/tcg: skip the vma-pthread test on CI"
Date: Tue,  7 Jul 2026 13:58:08 -0700
Message-ID: <20260707205810.303376-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707205810.303376-1-richard.henderson@linaro.org>
References: <20260707205810.303376-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Now that the page_check_range() race condition is fixed, let
vma-pthread run on CI again.

This reverts commit 5842de51573fdbd7299ab4b33d64b7446cc07649.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260706165445.57418-4-iii@linux.ibm.com>
---
 tests/tcg/multiarch/Makefile.target | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 508149d57b..ab4bf9c5d5 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -60,15 +60,6 @@ tb-link: LDFLAGS+=-lpthread
 # code to work around the compiler.
 sha1: CFLAGS+=-Wno-stringop-overread -Wno-unknown-warning-option
 
-# The vma-pthread seems very sensitive on gitlab and we currently
-# don't know if its exposing a real bug or the test is flaky.
-ifneq ($(GITLAB_CI),)
-run-vma-pthread: vma-pthread
-	$(call skip-test, $<, "flaky on CI?")
-run-plugin-vma-pthread-with-%: vma-pthread
-	$(call skip-test, $<, "flaky on CI?")
-endif
-
 run-test-mmap: test-mmap
 	$(call run-test, test-mmap, $(QEMU) $<, $< (default))
 
-- 
2.43.0


