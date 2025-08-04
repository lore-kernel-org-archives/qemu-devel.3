Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B293C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj0jv-0002JM-1M; Mon, 04 Aug 2025 15:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj06R-00018W-5S
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:40:09 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj06M-0000va-96
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:40:06 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-76bc55f6612so4175596b3a.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 11:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754332800; x=1754937600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Q4dcWPl9MBqqc8IwHAkUcZ6ENPKqu7XF6ON8ISL2zo=;
 b=UidgLR5DaTqqVXqBxwqy3og5YtWUwHJEv+1FtRcg/+di3jZo9hj135eJxJhHHj+p6H
 9RKx7xk2s8qlVJZxJUtcDMnNKh3rP7MQzQkQV8/j0XpcmPqs723VTZ8LRn0slaj1UMQ3
 x03mqW6zmnQeFBJfHEdJwS9wpna2MnbvsbHE7oVAJNjyAuKoL9tZDIeK29EO8lr46CjK
 K+SZ7Y5SsAMLDiFLJHnWfZozkBvy9R/ebs7c4CNMDlY3v1grfhjcdM6is8Bj3gKzYTh/
 GmCsEetcqnXiCyuAem++zcMoJMJEb+GIysm7x/pJ/SsKDrThqkcOH7a6yH6cPagb+Ajr
 1JHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754332800; x=1754937600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Q4dcWPl9MBqqc8IwHAkUcZ6ENPKqu7XF6ON8ISL2zo=;
 b=WmtWJO13P+BLWYB8Vld9UkOgX/DVcSTA26jMq4a5Yp/9oUGPT9YZzd6KtNLRDBU3uf
 tjGbCc5MtLQNw48UGDii1V8pdK+hwB+5r7C28xCo0F752pO6pEQTxJ6p3OvVo8z5/LHv
 vExs674ZeY4w5iYc+d8yFZweS5ifEupm+0oLdvj+4i8dvrm8XQ0x7CuUkRiWRd2mwY87
 ExJTMzEJ7I1VLP/3/6EEUCRFZzhQFRC2KMsf+nR4DVnJarTpYaCZme5AZiqGlHpyx9o9
 bw/HgUYL5b3zW+uMiglBqeZM7IYtgmuQci/s2YnV8AN1GeeHC8NOZdvEuG1latgXOULT
 60Ag==
X-Gm-Message-State: AOJu0YwSurAUP9eTDrPywz1vf3G8hus44tnZXKuBNVATWkzwznkiXI1q
 1Z2mbwqaPTh4RUg4fBQXcNxxKI1Wql8u6jLj88xKTAVPe1LOkR4o5TJwQBXrRQv9bco4istIqAS
 pIbl2
X-Gm-Gg: ASbGncuq9PQissXfnnCqSq5vteOWIbsNRfN2CFisZN9HAeXWc7oBOesFMEZdHkmCdcF
 VKuTF7DFwDmfJWxlEQOHtiB9etwgc/25T/+28Y0M4BmLApCAMVbpOZR2gqXOMiWz8XVfdDn4/Nv
 g/5ZHHXHW949lioVX8ChYb1w1xS0Wtmes2rUHc2RbNbIP3l0IgtxYmND6X24sHUnaxnCQ7E8LO8
 m9Yo7jpvseFEU+ooNRxa0xrX9FY3VuvJIqvc08DMBgz9YHqsaYP4aZ61GlblafJroUwTk+I5Tv2
 BEKtR8bPaLG79y8yt4gaHxpOFgQJFbgRUuXrdouaVrdLp4c5xeg15YehRGi8YwrdCElvJkTkDon
 F5z6dI0ZpKTZW9yFuYujDqQ==
X-Google-Smtp-Source: AGHT+IFhIzYzyLyq54TrG5CiHKFw1ZxpDWNpDOgO8eEtf99d5440BU3vSVekKo+UB3Dhk/l6LOBA6g==
X-Received: by 2002:a05:6a00:3909:b0:748:a0b9:f873 with SMTP id
 d2e1a72fcca58-76c1939300dmr676548b3a.9.1754332800423; 
 Mon, 04 Aug 2025 11:40:00 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bd78875cesm9940171b3a.15.2025.08.04.11.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 11:40:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, Weiwei Li <liwei1518@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 04/12] semihosting/arm-compat-semi: change
 common_semi_sys_exit_extended
Date: Mon,  4 Aug 2025 11:39:42 -0700
Message-ID: <20250804183950.3147154-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804183950.3147154-1-pierrick.bouvier@linaro.org>
References: <20250804183950.3147154-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

We now check only is sys_exit is extended.
This allows to break dependency to TARGET_SYS_EXIT_EXTENDED which will
not be available anymore from this code.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/common-semi-target.h   | 4 ++--
 target/riscv/common-semi-target.h | 4 ++--
 semihosting/arm-compat-semi.c     | 3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/arm/common-semi-target.h b/target/arm/common-semi-target.h
index da51f2d7f54..7bb442f24ca 100644
--- a/target/arm/common-semi-target.h
+++ b/target/arm/common-semi-target.h
@@ -34,9 +34,9 @@ static inline void common_semi_set_ret(CPUState *cs, target_ulong ret)
     }
 }
 
-static inline bool common_semi_sys_exit_extended(CPUState *cs, int nr)
+static inline bool common_semi_sys_exit_is_extended(CPUState *cs)
 {
-    return nr == TARGET_SYS_EXIT_EXTENDED || is_a64(cpu_env(cs));
+    return is_a64(cpu_env(cs));
 }
 
 static inline bool is_64bit_semihosting(CPUArchState *env)
diff --git a/target/riscv/common-semi-target.h b/target/riscv/common-semi-target.h
index 7c8a59e0cc3..ba40e794dcc 100644
--- a/target/riscv/common-semi-target.h
+++ b/target/riscv/common-semi-target.h
@@ -25,9 +25,9 @@ static inline void common_semi_set_ret(CPUState *cs, target_ulong ret)
     env->gpr[xA0] = ret;
 }
 
-static inline bool common_semi_sys_exit_extended(CPUState *cs, int nr)
+static inline bool common_semi_sys_exit_is_extended(CPUState *cs)
 {
-    return (nr == TARGET_SYS_EXIT_EXTENDED || sizeof(target_ulong) == 8);
+    return sizeof(target_ulong) == 8;
 }
 
 static inline bool is_64bit_semihosting(CPUArchState *env)
diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 3f653c6e7a9..1c593d5e0dc 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -755,7 +755,8 @@ void do_common_semihosting(CPUState *cs)
     {
         uint32_t ret;
 
-        if (common_semi_sys_exit_extended(cs, nr)) {
+        if (nr == TARGET_SYS_EXIT_EXTENDED ||
+            common_semi_sys_exit_is_extended(cs)) {
             /*
              * The A64 version of SYS_EXIT takes a parameter block,
              * so the application-exit type can return a subcode which
-- 
2.47.2


