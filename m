Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E446C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 16:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbifi-0004G5-Kr; Sat, 25 Jan 2025 11:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbifg-0004FV-K1
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:06:08 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbife-0000ZF-MV
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:06:08 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso19813095e9.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 08:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737821165; x=1738425965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LnxgPJtNl18qpQlYyJcdV2Lpgdr/I3RQhGnRLNDQ94c=;
 b=L+ynEg59YTATX2djMwimpEAgxBPjEmIWqOBEnQyCEGf5EVnQRXxcmUyI8jl0EES8mn
 g18FKF6Pe0f6BaBGM8VW+30ZuNYun+79Urcbf/I0mvIn3DOL8GQicTUSXQS55F09lell
 NXmmjuouCqoqDx+bXkxHP3gC9ptfNQQoPXMVS7OjlMPMtrh2fLkoHy1i6H2SkHjFxJSE
 s+ePEKJa5Zxcq3jU1+J+TibUiKOUqUBugpBdw4KrEFpw/wefn5Wb5pn8jImk54UbMAQR
 9cJ6nNqu6vVFanr5ADNHJ7eSXWNGq5jW6oxFZmM+sIt0+dlQ625kwawybvBjrxeUr4+S
 0keA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737821165; x=1738425965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LnxgPJtNl18qpQlYyJcdV2Lpgdr/I3RQhGnRLNDQ94c=;
 b=hKDAth9BrEj7mNPy9nI1m2tSi88J74DtW7026VrmKoUoR8FOitEB3lZk9N7JYzextO
 iIm56pC2qu2XlkTwzvNzS3Oa7MAApPhbKI/A8zvxHKS9cJJZmGdmefgxfVzMMYeEljjZ
 lI2NB68njmqTAojLAfvvITqEkaCFKzi6amJCnNnaODMNUGOLJaxTbH/+k9c5PPIbPDka
 3ptF3tplKuxhJBOiPJtpn3qg0XlIORq8g0rEAkWthUS3L6Gx1fiep1QeJLpzNJROwYOd
 +eHlgnlMPezVQDEKCxv628swl6KzVz94V1TlENPtmqQinlZIT+RCIy1JNLZ7LVP2gdzx
 8eDw==
X-Gm-Message-State: AOJu0Yz4VAwobDxd6keZzNoGF8yFnOU5oPdTjvKEFigYUV9IeWSwL45/
 QFmReg4rNn0iq02MMXYwmArPYTNuZulyWKv5VHrpJKdlvZy1mOoHnlXeolkKbdoM5ZmLIOel1Ln
 OZc8=
X-Gm-Gg: ASbGncukV2U9YCl6eP2wW8ORWAygSxNc0ZPeYr87imHjSOGm5j9Qg/mzKN2wjpEKy60
 c/OCg/1VnaogUojAv3MxMf1Bq0h2D1/V2vunbR+Hzwppk+0uUhYDqsR7B+b6dj1x2d6eoAC1sKE
 xKXnXmsrQMjVBjyqNM9bszGlGZuvQb1Z+wUBN3MdfgBNYv3RqBS4FTtsVc1f77apyIHXQaJiXq6
 InkP+nf8ETsuH8Gs/Wm+Mn3LK/I8wnosclcYvW+awN+sV2t24ifZcUZ2E+setcT4hO+FhzJumMy
 wNDRpppRkZ2164qrKCGKUC08rMRs0F7hXWaRvSfPSiIxCG5P1aFysiVNd/8S
X-Google-Smtp-Source: AGHT+IHulbjfJra9BA5XAoqH3yZculUe+FioSiRYi/YhQqd5pcfvCZTOlnSq+AeeVFwkh8hZAwU1DQ==
X-Received: by 2002:a5d:620f:0:b0:38b:d765:7027 with SMTP id
 ffacd0b85a97d-38bf57a2675mr24349477f8f.41.1737821164688; 
 Sat, 25 Jan 2025 08:06:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17d7bfsm5942195f8f.35.2025.01.25.08.06.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 08:06:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 02/24] cpus: Un-inline cpu_has_work()
Date: Sat, 25 Jan 2025 17:05:30 +0100
Message-ID: <20250125160552.20546-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125160552.20546-1-philmd@linaro.org>
References: <20250125160552.20546-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In order to expand cpu_has_work(), un-inline it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 6 +-----
 hw/core/cpu-system.c  | 6 ++++++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index e094d54949d..d64c823e768 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -756,11 +756,7 @@ bool cpu_virtio_is_big_endian(CPUState *cpu);
  *
  * Returns: %true if the CPU has work, %false otherwise.
  */
-static inline bool cpu_has_work(CPUState *cpu)
-{
-    g_assert(cpu->cc->has_work);
-    return cpu->cc->has_work(cpu);
-}
+bool cpu_has_work(CPUState *cpu);
 
 #endif /* CONFIG_USER_ONLY */
 
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 37d54d04bf8..16d5efee12d 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -23,6 +23,12 @@
 #include "exec/tswap.h"
 #include "hw/core/sysemu-cpu-ops.h"
 
+bool cpu_has_work(CPUState *cpu)
+{
+    g_assert(cpu->cc->has_work);
+    return cpu->cc->has_work(cpu);
+}
+
 bool cpu_paging_enabled(const CPUState *cpu)
 {
     if (cpu->cc->sysemu_ops->get_paging_enabled) {
-- 
2.47.1


