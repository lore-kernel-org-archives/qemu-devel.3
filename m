Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C495AC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIeb-0000DY-G6; Mon, 13 Jul 2026 11:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeK-0008Sr-Uq
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:52 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeF-00018M-UF
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:50 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so30154415e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783956764; x=1784561564; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qsZ/7tauraUAl70i9C1jrCqQWXHx1WoT3zxM8mgFt04=;
 b=HN+Q9++Sb4AST0rB0fN91ajU8trHbQl5R4m+awMxqcwaqYH67yQDRIoOKk6LExjSvD
 H+zVIQtZyMo4LbzhsDGKftt7JFNdJnYO3iK6NCNa2zFCPaW7mX+K5zDl4JGZra/6ralU
 ttTHdnyZ6sZoh8QrMtfTsjslNn5DsyNuXKpFett09aGSEzlLMaU4mvhsG1HQsdtGJt8w
 g2fUOt3j/0zPi1jzCamLzEF+9CLs+HQfZZRZdbnbjq0Qaz96wDZ32iOAVUR9q+Q5NJ1/
 BMQmmuuW80KFs6V8iTtdveuxkb+zVqKgjeYI6yeSz9dTpMgoKdSSbRKpc+0gt6Cmf8IF
 RwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956764; x=1784561564;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qsZ/7tauraUAl70i9C1jrCqQWXHx1WoT3zxM8mgFt04=;
 b=C3hCnZMBTSDwQjH0Y3jt4Ur8/ZWLJkbofkjkruOj9TU6UdyBlGO4R8E2VMTCTpBwlH
 VZor+4Ci1vnMRdVqgoWHWMay5B2JznjZ1T7oGjHjbigkg29p0G0eWNS4DUlMekzai894
 N2PQBz/nzx+7JbwpdwonYXTOR8K0Jmix37M6qnvzckkTXWzY13DkqONYOnDRM3m6Wzma
 WEtp/Ir6DbV1KJoluAo9O6JgIdTC/v+66OHTIP+kXczGuvHjUizFsIQVXA/UarHES8Jl
 a6AoUOoYiikl2Gr8bCpd+I0xjRoxuPJo05DcSo2EUoNZpRDV0v4flWltV4B9Jzl87n8e
 H96Q==
X-Gm-Message-State: AOJu0Yxxy7qgbDBsuPZdPQCE/5Zq0cFYYm4jT6CdeHEW91fgGjo6JA1M
 C7Ac1cs98uPkxfIg0G8yHekbbz2UEWccgk11870YA2fBoZrLxHJKjW0dfugojXIfhjaEgMkANWp
 SEVlT5+f9Sg==
X-Gm-Gg: AfdE7ckpv9Ko+4jD9ewM79s02F9P5iPS+QLI/BnOhrOgSbviywY+Dre34l9RQ/QUjG0
 1jkNRbiI8DUSYHcEFmhbA4rG3RiTXQGTfZgSxywBN7qm/zlD5EgUKpQ7qCkikBzQiYgIfvaI42q
 1EX/oLn3RQUagr7tLBuS2pLTJ29BjWdaV7Xe03Tuqr7qtLJ5xaFIbaqx7EF4Qf0aiiJrc3sK3Rd
 aHOui0W4SWfBDIT9elcWmR+VTcXVZpYYqNV1i+fCc9t2PiqglTxyVHvmXhZ71VFa0UMdYTkIQ6g
 HKj1IIx4KFPC8zSK2Ap19nOybFNPfJ0PIzEPs/MUrCB2r3irkgCq4LLtWXfV5TMOMwlmeUkHq9p
 kvizwr30AH5lhtrxp3EnRS56/va4dqL2nyTigM18YTbbTejF/jTWl1UAxKZSME3d89w+RyWYWD4
 yXo8lP5X/6ZXG8f3tuz40BqTY8UPpa7pJvHbnGxaPGu+/4lBMEV8aV1BikRxEBjnO0+cK8pOLKE
 N2byjSPHNSmwJXfj7E76g==
X-Received: by 2002:a05:600c:3b03:b0:493:bcba:46a4 with SMTP id
 5b1f17b1804b1-493f8818cedmr94817735e9.20.1783956763641; 
 Mon, 13 Jul 2026 08:32:43 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm3825985e9.4.2026.07.13.08.32.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:32:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/26] docs/system: declare support for FEAT_EVT2
Date: Mon, 13 Jul 2026 16:32:16 +0100
Message-ID: <20260713153233.3391818-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713153233.3391818-1-peter.maydell@linaro.org>
References: <20260713153233.3391818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

The actual implementation supports the additional trapping registers
of HCR_TTLBIS | HCR_TTLBOS. We already set the value to 2 for -cpu max
and don't currently model any CPUs that only have FEAT_EVT.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260708145841.3032079-2-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/cpu-max.c          | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 4f413d69efc..fb8d263db49 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -68,6 +68,7 @@ the following architecture extensions:
 - FEAT_EPAC (Enhanced pointer authentication)
 - FEAT_ETS2 (Enhanced Translation Synchronization)
 - FEAT_EVT (Enhanced Virtualization Traps)
+- FEAT_EVT2 (Enhanced Virtualization Traps 2)
 - FEAT_F8F16MM (8-bit floating-point matrix multiply-accumulate to half-precision)
 - FEAT_F8F32MM (8-bit floating-point matrix multiply-accumulate to single-precision)
 - FEAT_F32MM (Single-precision Matrix Multiplication)
diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index d38bdfcf811..88b7c046333 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -130,7 +130,7 @@ void aa32_max_features(ARMCPU *cpu)
     t = FIELD_DP32(t, ID_MMFR4, AC2, 1);          /* ACTLR2, HACTLR2 */
     t = FIELD_DP32(t, ID_MMFR4, CNP, 1);          /* FEAT_TTCNP */
     t = FIELD_DP32(t, ID_MMFR4, XNX, 1);          /* FEAT_XNX */
-    t = FIELD_DP32(t, ID_MMFR4, EVT, 2);          /* FEAT_EVT */
+    t = FIELD_DP32(t, ID_MMFR4, EVT, 2);          /* FEAT_EVT2 */
     SET_IDREG(isar, ID_MMFR4, t);
 
     FIELD_DP32_IDREG(isar, ID_MMFR5, ETS, 2);          /* FEAT_ETS2 */
-- 
2.43.0


