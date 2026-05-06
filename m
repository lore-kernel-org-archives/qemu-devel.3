Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476C6FF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcjt-0001K2-H9; Wed, 06 May 2026 09:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcjf-00018s-6g
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:56:26 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcjd-0007xd-RA
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:56:22 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488ba840146so57298255e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075779; x=1778680579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BJYP6Q40kzmLEXYiWzHY7XT6SbhPhEOvlpV5vyUR24Y=;
 b=Tz4X7h4aZKssn+Qa3VpP5ERYHN8uQ03O/J61gTRBxACFRlaU1qP7R9hsOUxC8H1G0/
 b3CjsUMscA1Stu7J7PR+mbo5GJ09aUSLSa5EM7dKVW3oSbnCQLaTTWTCcKFkRa6dnUAx
 0zzdwBYx525j0FkWuhKg25KB9+fmuT7lwukk/gs5FNh5T84vgkRXbkZE0je0cDwdk+Cf
 TDuN556T5KRXm4N0rBVfei3PxZAfgMwniYaYaYKoyob1xIkvtW+fW2iRTW1SkTXrtyvq
 euKMVMeXpz8UDaPjvoGuVCiI6utSohuJtUUNdCpNMk0yEQEUdoW+QYIUv3ya0YP2YEM3
 +qqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075779; x=1778680579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BJYP6Q40kzmLEXYiWzHY7XT6SbhPhEOvlpV5vyUR24Y=;
 b=drARoImRkZjCaTVH8bm6IwzFM56V9Rt50W2w2u4VtQSWcPgz+om+SZXBYpo9I5LpGg
 gJQfPuATMOguR24wMnKgV22GNxdlTKrKqjMMHzpjKrAuTYwbMk41ekXsd6HhggORJsE6
 jHFo/kotiM2+wNRB1ScFxkE+w6F5cyxqQXtgwzG2pndzek36HUt1G4Lef9zo3ZfrJQam
 nBuxeSE54+foLIVP+Tw1JMZDR69hSKF5PU2evtf+GCSl/GjB3nO5xuxJ8mae11NKZTD1
 uW/AP6VGhrjILnDA5vYavyVk3Z5NMLITabal/RsJlFiekHyjtbETLf3RrBcHWltXb5CS
 dFuA==
X-Gm-Message-State: AOJu0YyUUNyiLC+mxOnpBKhHJP8mtkIyupEyKq4FyC+ME8lNXXyvPf5U
 olpabR7qlLK6GTL3Yw6seQOMZtWzu32d0KkYwHA/q6aj0VjCWqt7qAoPqlh+CHnHwUf07u1cmWR
 rJhUJODc=
X-Gm-Gg: AeBDiesVARt0gG1kIiuUCYCqoT3V0wJotFwhcd6bFyNlK7fTkpEdG6+4TVrOgPidekv
 BNFinH3H3DCYAucVjTlmnvyqdO05CZfTOv4iNU97EsFAW6bVgGsK/xrFqCY3sFeRlagSjEEgdRc
 GhJSduCbR3VnzLvr+/XY7oeGDdtWOz4ysMhrs7m6xMYsiGAyWOF6W1LJENgaRwIdYK1Fp6Mw6nn
 U4hmoHYOyNvVFIwk8CBi7jbCWWdO+RQdagnljC9XjYFdxs7JAhxqNc1uvRArjOwI8kIfmstF/dy
 PC3vvs238CZ/eOWH4BBHQnoXmmt25ATLmFGEbOfI5T8dEKwTthCNMv4niDCC+PqONGTt+9cnI3M
 wZSQRPqk2kTODhF9ZdXpiyfzhJGXPkE4A27sSw/dudfivN5f+UCRGoX3Ysc+ZBfULB300f97I4K
 UfBay1c3oUs7TfsSCRuqTL2+EGoJE3fFaroxGHCltB84FYj44rGMWWLcVW2fkt6E0W5mJBhrFOv
 b6GDfafmCE=
X-Received: by 2002:a05:600c:8b8b:b0:489:1aed:1658 with SMTP id
 5b1f17b1804b1-48e51f3fd03mr64028945e9.23.1778075779225; 
 Wed, 06 May 2026 06:56:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055f249bbsm11314292f8f.36.2026.05.06.06.56.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:56:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 007/110] target/m68k: Include missing 'exec/target_long.h'
 header
Date: Wed,  6 May 2026 15:53:39 +0200
Message-ID: <20260506135524.20617-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
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

The "exec/target_long.h" header is indirectly included, pulled
via "exec/cpu-defs.h". Include it explicitly otherwise we'd get
when removing the latter:

  ../target/m68k/m68k-semi.c:53:5: error: use of undeclared identifier 'target_ulong'
     53 |     target_ulong args = env->dregs[1];
        |     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-11-philmd@linaro.org>
---
 target/m68k/m68k-semi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
index bdc798a28cb..d2a071ea677 100644
--- a/target/m68k/m68k-semi.c
+++ b/target/m68k/m68k-semi.c
@@ -22,7 +22,7 @@
  */
 
 #include "qemu/osdep.h"
-
+#include "exec/target_long.h"
 #include "cpu.h"
 #include "gdbstub/syscalls.h"
 #include "gdbstub/helpers.h"
-- 
2.53.0


