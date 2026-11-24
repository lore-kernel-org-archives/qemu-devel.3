Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65205606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GaHoq9Bq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW0EF-0006Tk-1r; Tue, 24 Nov 2026 18:47:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xW0E1-0006Sn-8m
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:47:01 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xW0Dz-0003qe-Lg
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:47:00 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4a9be758734so3214431f8f.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795564017; x=1796168817; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+CjRTWznI/DieEMibp13lhrGBosFJP3Y8S+JTPO6RbU=;
 b=GaHoq9Bq7J3UHoKkawz8BROzTXkOuldwX0k7Wg19tixgkCfoAOQIebzITfa+jV7hkg
 Cmq8ROGcVmgCiPp6wmWeoKUZqWVTtlpMxHT4SQaorBVMno8axZ/Yz5GJBuXSIjElGPIh
 cMsz+mRUn1Oeb1Ay+o3Ozy9pyjMJ31O5D0EDOkGelc9UvXtjCHtNaw/KGQ8o2DFdJuHI
 IcZrcyT1bRqrx65tr0NLe58pKGL9h6N8QMphZSz1EfH5+GwoISUaBpiUX6OEAkJleXRf
 Ows7zpJO5BsG7VnGWSDrEg3bD7vKpcXR2xNGMTTM4brNp+fKJ73tVk/4gLTPXOCACvXi
 P81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795564017; x=1796168817;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+CjRTWznI/DieEMibp13lhrGBosFJP3Y8S+JTPO6RbU=;
 b=UAvgafYQa5HY0UDqaO0ncOueLst4J/Z0YNwO/cp/ROVMynxzw2dI4nkEiPkzerl11O
 vBtn2VRDIeHpsyWyjhtayNl8EjVjSEr4/lFSFxvKmsULImmNiQ6sO7amtgKetTEa6ONA
 UUKkRHxZvD0OlmgIlPOJcorixjOCZuA7BTTNZ8YeiF7wOFOzGnNUPmpgAByWP8lFo4ii
 6GrsBKr01yZOiL6bgnVMmkMbwDGiy5Zai7ihT5xRFwDVAhFkdQWo0oZWz/UHnUwXbvqF
 XmtkHLI2o5FeajfFnM4y2mDO4798YjZQOSpBYyuTYxYs6ZJ1+YvcVXGsdzTmU7ySt5a8
 rsnw==
X-Gm-Message-State: APuU4Z96YUGeAMkzq7+sVSNvY+AJedgitbZy7oT/bHi56KFCtz240pLI
 vrrR6p/XbC/nlS6MlmlZaPDCxyFOOgmZZo6DfrjqfKKyIF4t7ky1uribZak6hufCrKo=
X-Gm-Gg: AZFdTZfF9qwUIX51vBu+BGLbEhsTdd49zmZ+dYBWIlUna/dSZtZA6I+ufaUD1OfjPmT
 7xV5sVuI5Ak/zQf8LTUr2IOhKcC7ND4NRCmB9x2N7eGyLzpCbOT6OCfIhu6MVBpwnI1KukTi8B2
 geX8A3LrYBnpzfdC7w0YnlzFrUIWOuA5LCBUMvBUUxPStyxBKHOshJiXZ6yaZTHCeG669n/vFhy
 nyhtwH3Y3ytqSoCiQA+WwhvlzoUVUKmhwz8F2bDr5O68OJxRTmCAIxJtsjbp04t/Jl8QMeJtwRt
 rfRDD7q5SIzSzXjVt2bzZfZBkfmg4DBd/UHwbjR2s77tYW7CTPQImphOzHZQ6NYH+xVsxhvuOn+
 0lLWpe7QCTzpppWU43z60+PXhxVla8+m+R94IBzcp13oRgb2P/4u+M7waqHocDKeaVnjql+5LL9
 X6WCEwZvxLryinuDy5GauEonEYObEGWGs/sozDzUCbAeD4VowYrXlDOwrAJHxitPj6tCphuJMI+
 k1FWT5eCQ6fpdJ118lhZE1HjgDu3vKLOWnTuEvAhR6R8zWx90FZe50XQh30MXILIsLZl6v/GKNU
 MdGv+M2mTLANqMeTmi7Au9d9FU1qGlA29+cBZa598S0WcG9Gow==
X-Received: by 2002:a05:6000:186b:b0:4a6:4f35:336b with SMTP id
 ffacd0b85a97d-4abab02c60amr32233923f8f.5.1795564017309; 
 Tue, 24 Nov 2026 15:46:57 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bc8ce06sm30064948f8f.47.2026.11.24.15.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 15:46:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3A9345F7E4;
 Tue, 24 Nov 2026 23:46:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH] accel/tcg: update stale comment for cpu_io_recompile
Date: Tue, 24 Nov 2026 23:46:50 +0000
Message-ID: <20261124234650.1891639-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

since 18a536f1f8d6 ("accel/tcg: Always require can_do_io") we always
trigger a recompile when we detect i/o mid-block. Update the comment
to reflect that.

Fixes: 18a536f1f8d6 ("accel/tcg: Always require can_do_io")
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/translate-all.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index ea8257935ed..59991339620 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -566,8 +566,10 @@ void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr)
 
 #ifndef CONFIG_USER_ONLY
 /*
- * In deterministic execution mode, instructions doing device I/Os
- * must be at the end of the TB.
+ * Instructions doing device I/Os must happen at the end
+ * of the TB as they can change system state affecting following
+ * instructions. When we detect mid-block IO we trigger a re-compile
+ * with cflags
  *
  * Called by softmmu_template.h, with iothread mutex not held.
  */
-- 
2.47.3


