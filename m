Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4CBF45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 20:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBI8q-0003fZ-JM; Fri, 10 Apr 2026 16:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBI8f-0003U4-AK
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 16:07:38 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBI8d-00009w-Qi
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 16:07:37 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso29079385e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 13:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775851653; x=1776456453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W2vRHiJbej126NbiS5zPSIz+zk3p9OdpjvnZSWOVICA=;
 b=PHKbxTVjlg7Bcc0evQ4KAEQ9X7e1R2TQMz8T1LbaA8BAjk8OReAkbqBvNKIT6ijQjl
 wI2lGGquiFp6sPy2uIoPq/pfuc0edCLz5RAeJ09N2unNLwgkAiDnf1QdrqUTghu8Sbh4
 8y3M/itessbYZ9SR28x+PxrdL+nzYUROmqzwBZtOWOb06xmKgyEgpN7sm+yBpkvcFxYR
 LlD7x0BWCReNELn9U3Saqi15zLKvxaixBLrhFFLZFIoTBCWgkWpt7ZNR9kfIJ/I6+NGG
 5zjbNh69shSF4pZ/B1MDqVCXawe52I6NPbYBT28AKHC/P2LpW7tned7y7UyYLKXxgurq
 eMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775851653; x=1776456453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W2vRHiJbej126NbiS5zPSIz+zk3p9OdpjvnZSWOVICA=;
 b=Qe+0tmVr/aQiclx75jGs5/WrJlMEaZGiO89qOqCs8TJU85ADB8oRyba1tf9ediu0QK
 NSdOC1bO4JY7+sqtnnSoPIXHZok6dwvxGwDgD7ooMOmrwMAH1SdLfUToEKZgYI5+ZuMN
 kNQifNhKVTWGI7HXngJqKmpn/3qB+rRccu0xGoW9+eLXRD7dKysa9J8yLZlW9EkjyrFO
 n3XHZ/B0S7xAdsMZzhxb2UZPVtm0Vvn/u+gJpa+aSTLH4ZKeY+iX1s2Jgmwg/dLGA6/X
 ux/u0w7E1ZjtPX6KBaHb+So4sU+/69mcRgVaMwDPTH5uvO/42DlcHDtalhMJR97NlP7w
 ednQ==
X-Gm-Message-State: AOJu0YxiFo1EZVjqhKb9XrVQIHCo6iNzk1NZmzZ/6N826apIx2zDOS4M
 CjLTNF5xLIU+pGUmuZZm7Qerfmw0QlZ3SAXfRWrEgs/VdQ2sYYqJFcJjCRUVvyy8nnxdyWpHU0F
 1R8bBvFs=
X-Gm-Gg: AeBDieuJ9eik+HctfMZ7bagnMSadXW5zxuTbyGKh7B/BfWbVKtBoF1Yf1TxtFInAcPr
 fCzBKi7v3a22tTdplTldC6QFjd1XZZcyz8QWoW1aeoLBqUYmJ17AWKwGnAWi//vjcNaKDjhDq6O
 fzrVj88Txa26y+0Dvp67B9FRET1sTUfI6vm641RTBIDJ1f5ph9zpORED7mZQvBINjVShAyvEDxd
 HpC8SPOe3j6fwVfcoIdatD55/qEUqPs7vLZOtwQAhndL+4kbJ5u5LPE/KJ7syHZQC97zl19GqyA
 dKjUH0T0RsIzHCcCvwYTLz8IsuIX/TtWDytXfMWzHa8d9rnKc/w1hRrd7ogPa3sykgTG12xpff+
 s+8HX01Ap16A2aUPnpBPhLSsxlODOswHYHPebzyOxyg86ST7D4xyqSxvT9LNO5RGPcNQMVbLNZz
 xg6VjVbm09pBXXSO40hRwdVyTh6Dxz0LUsmAnueDiuIQppOvsfROo+g673RgU5ptzkcoBbVbFV
X-Received: by 2002:a05:600c:698d:b0:487:22ad:403e with SMTP id
 5b1f17b1804b1-488d6ac9ce5mr60035575e9.14.1775851653320; 
 Fri, 10 Apr 2026 13:07:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d681edc7sm25603175e9.17.2026.04.10.13.07.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 13:07:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 9/9] target/arm: Compile m_helper.c once
Date: Fri, 10 Apr 2026 22:06:28 +0200
Message-ID: <20260410200628.19378-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410200628.19378-1-philmd@linaro.org>
References: <20260410200628.19378-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/m_helper.c  | 2 +-
 target/arm/tcg/meson.build | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 1bec8e9aea3..f2059ed8b03 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -17,7 +17,7 @@
 #include "qemu/log.h"
 #include "exec/page-protection.h"
 #ifdef CONFIG_TCG
-#include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-ldst-common.h"
 #include "semihosting/common-semi.h"
 #endif
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 95e9da151e5..02774409e56 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -32,7 +32,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_false: files('stubs32.c'))
 
 arm_ss.add(files(
   'cpu32.c',
-  'm_helper.c',
 ))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
@@ -70,6 +69,7 @@ arm_common_system_ss.add(
   'debug.c',
   'hflags.c',
   'gengvec.c',
+  'm_helper.c',
   'mve_helper.c',
   'neon_helper.c',
   'op_helper.c',
@@ -94,6 +94,7 @@ arm_user_ss.add(
   'debug.c',
   'gengvec.c',
   'hflags.c',
+  'm_helper.c',
   'mve_helper.c',
   'neon_helper.c',
   'op_helper.c',
-- 
2.53.0


