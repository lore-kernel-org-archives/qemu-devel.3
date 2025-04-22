Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56723C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JRa-0002XA-PP; Tue, 22 Apr 2025 15:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JP3-0005G2-0L
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:33 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JP1-00075F-3a
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:32 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-224019ad9edso79435865ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350529; x=1745955329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mc2cOAtXM3sBslJrk/AmmYQiAoPWaBHBs7smPxcUAZA=;
 b=IDgH9UXyxCrPURFpc1ZUfFDlY9bJtQSFkHxdXaex9JbGEswsirV/7+P4f2DJBwlhea
 JDPMlgl0X+8NHzxuapFP/JBCSGeM6cVPm/zXfWGA33e5spUiLY5oFzY7C65dIGh74FPU
 +yZuTVwhFZLs7pN0gMqW7c6Oa6GVpPhoxiNgIZU/+OdvFWpH2c+9g8Ou5OMvso2fA+me
 DFwHsLnFX0+3v7ip4UaQDbBfIZi0Knze5V8dVunUoqcdlLZ3Y8EuyqPFfUSsHiQnaQxF
 w2COVbTQ2Pd2BFZYxBdDL2djSBUlWYAEN2qXzmNKXMW/bqugk0KonWEto0uG1Ta6Wi7q
 3UxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350529; x=1745955329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mc2cOAtXM3sBslJrk/AmmYQiAoPWaBHBs7smPxcUAZA=;
 b=bjZNctDJmupw0v/7pgtMgeKrpJ7m4W1qwZOzb87F9SsVueu0pUP9FQUfVDcK0BPH8n
 foe/VWKDtTaLvKH39HE0rhRffw6Q4zAPYQ+Xl+PsQaBSqAzhxPKeSGYezr07OlKPHprC
 PJKce7pwoLRyUMoKrF2lxl8w+xfJs+KWad2YGM1MaEw6kJqogUQMd8JjmjSFYOBXdP6m
 Xp49ahHogb1nIDgiJ9yBS9HvBWDS/1YVaeRw0A+UQFgwtApvJ54wCD/E2Z2Z8I1inesT
 8R2LVjTzAOQbDycBtMsUGYwL8lT+4qxWl8BlVjUDL4p3dmPzI4qUL1JmF/Ueao6GYQvp
 ZWsw==
X-Gm-Message-State: AOJu0YyJ4LdIWNWGtNk/AGY/CANwXV2zQBaTeYPnJf4j6P6gJbfYcSAj
 HIVVABDAl3PG4xG+YKIq8iCOeXvsxmvSR+coxpgs1W7XrsfNx1bLIj+Oj9wc2hqWQ710kpHH7Re
 A
X-Gm-Gg: ASbGncs8ybUVUlbzMHbxlQCXglS0yp4B5B3FBV3SWf6MsfpxUIp8Q6XKKQ5Fa9nCSkg
 grzCcdSL1Z2F/7HLbZ8YzoTa4963JNghTTZK/kCFZ7dUJrXpgIbMvLsLx4rCYU8nPsq6KzJDF00
 6dHqbe64qMy+6UMiqg9NVFnAEUlWpwzg7G+1Ta4qn31cUXxC5geKhy8ssqEW5tviA4Sv6Ckkry/
 zueT9r4lAeyNdioZKofGPnULDSx4eJBXOfrUl5bhnogcnmKtMgUMWL+o+eD7jnlWQ39OohoHYEp
 n+l3eppDuEKYKqR3jtp+aQwIt7BbGQItnTOd9hX8ngP68MIdFYGpC2UImpfD+ZComU3jUIPub6m
 krLNikBFM7g==
X-Google-Smtp-Source: AGHT+IEFssmf8hBjl14eYgpVHHyx+ZGFIswvemlx2SHEr62jXRdCqa97cLfLrL8ZWcb67DZSczV6Zw==
X-Received: by 2002:a17:903:3c6f:b0:216:644f:bc0e with SMTP id
 d9443c01a7336-22c535c9db1mr280366795ad.24.1745350528668; 
 Tue, 22 Apr 2025 12:35:28 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 104/147] exec/cpu-all: remove exec/page-protection include
Date: Tue, 22 Apr 2025 12:27:33 -0700
Message-ID: <20250422192819.302784-105-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-6-pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 399fcbb9d1..957c86886e 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -19,7 +19,6 @@
 #ifndef CPU_ALL_H
 #define CPU_ALL_H
 
-#include "exec/page-protection.h"
 #include "exec/cpu-common.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/tswap.h"
-- 
2.43.0


