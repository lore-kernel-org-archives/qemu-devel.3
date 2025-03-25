Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC235C36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 05:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twwO4-0003vr-KK; Tue, 25 Mar 2025 00:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwNs-0003kK-Bs
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:28 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwNp-0005o9-TS
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:27 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-301c4850194so7514839a91.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 21:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742878764; x=1743483564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jR5zdvst1499BI4mZMYVh63tqJtsj49dtruLLQFFpJU=;
 b=W8sLISSmEjFnu59CZE7HWpAmFYwJAqCmvuXAF2UAWmUhNCekQu8ZvMBc69gClH72MZ
 F4RlP+aserkmrORWYkJrcX77Rwxf32p5HjEW3QrQ4sa//YhvPEu9dVtIYLgOGglhdZZR
 4+oIf4ohOfSJF3iy0QeTlYdTrsH/OIZoYHb4wixoTEHwWnoSS4dCxgs5Of0fVwQtXUJQ
 LDxRPMvWObdZWbxQD8R5PDO1/6G3m5GLN9LSfSASQkHxj3rvLCNms5mn/x6KqBZ0O5/8
 VQm48us51OUyHYRNsyZ2MHrj85KvqRaMwVErPalsuBKFeQKNjfl2cYFBG0YSg/Qybd7Q
 eYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742878764; x=1743483564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jR5zdvst1499BI4mZMYVh63tqJtsj49dtruLLQFFpJU=;
 b=CQTPXDeEL/q7+u1n45BOY6wHraTZr/dRWJlMVVNVyGJ/INaPuw7qACIaYqtvrCcSmP
 hLpToFjiuNgzv3ifNh7TCRGVs8A8DpTC3kZeiswZ+gPeMMQaIprUku8zME4SLVUJKH9I
 xGcEUSte1HoPN9LLPaChqBV57pvaKD/0vfwOIoh8GLScGvzksqWxyrdRaoVHPhDQgow/
 PRC+WUDWRZ8lNutx5ucGoYK19kMCu3g2jAssliIGJzZ5kuDfnuJsyGmPKbqNWtiM4xZq
 W1xcGtaR+ibNjP2/9jU6EY/YD6taNiC+gXhosMQZjedhYicFytuSvehceZl7R5hNot/p
 ejJw==
X-Gm-Message-State: AOJu0YyoNPbTKUA4kbNXnHsKbOLV+/gO+kgq+Svv6bVDtS6MXTeyCh1h
 RHwBSj+H6lfGzEf3u6LScE7SZ+qH9daG2LZexUc4jRJG2SbZ2/gsl0HCT5YyfaHSPyTw9c8Ek1K
 O
X-Gm-Gg: ASbGncthD9DhHnMGz0sG1GtnDc/IjG+RWEO+s9yUg0VY2CI9o8zcoSHWom/ogy6Isft
 0wCw+yd4jsBdOGyAT5+FW1Dbt416fEriOSgKlF0coGO8MVJXLPmr9er75RY6FUxnLE1lukpu/JT
 IW8n5iVWkBgVTUziP0d7RxUvbfSQze00JoRxew2zz0sW1W8L3lWKIcjXB7Eqozew0jMZImislfd
 /Ht1f/Z9EVYXo1x09+XLqegXzOxI3JrNpap7ibEQTZ707gfaWFg936nrxdcZRnSvf7g7F62FJmH
 O4fcD7TGtlqvG7LcrXeAnk8nefTVbtDLeXdw2a5MXGyU
X-Google-Smtp-Source: AGHT+IF09e4GpcORPL+fT4DQZe28sf2+KbqBTnwWuE5q2cPmPm29mL0bJJJ9ciPPSpM9sPRBfLk61w==
X-Received: by 2002:a17:90a:e185:b0:2ff:52e1:c4b4 with SMTP id
 98e67ed59e1d1-3031002b8b9mr20134582a91.32.1742878763623; 
 Mon, 24 Mar 2025 21:59:23 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b413sm14595120a91.13.2025.03.24.21.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 21:59:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 02/29] exec/cpu-all: move cpu_copy to linux-user/qemu.h
Date: Mon, 24 Mar 2025 21:58:47 -0700
Message-Id: <20250325045915.994760-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h | 2 --
 linux-user/qemu.h      | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index d2895fb55b1..74017a5ce7c 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -32,8 +32,6 @@
 #include "exec/cpu-defs.h"
 #include "exec/target_page.h"
 
-CPUArchState *cpu_copy(CPUArchState *env);
-
 #include "cpu.h"
 
 /* Validate correct placement of CPUArchState. */
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 5f007501518..948de8431a5 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -362,4 +362,7 @@ void *lock_user_string(abi_ulong guest_addr);
 #define unlock_user_struct(host_ptr, guest_addr, copy)		\
     unlock_user(host_ptr, guest_addr, (copy) ? sizeof(*host_ptr) : 0)
 
+/* Clone cpu state */
+CPUArchState *cpu_copy(CPUArchState *env);
+
 #endif /* QEMU_H */
-- 
2.39.5


