Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81661C19F4F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 19:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0RWi-0004CT-1a; Fri, 26 Apr 2024 15:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RWI-0003wH-Tj
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:46:12 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RW0-0004rv-GW
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:46:05 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-516d2b9cd69so3107340e87.2
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 12:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714160746; x=1714765546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q7YRlrLoDVqcKqwJc5XUnzy4U8ujSMb/8xBf3PSdyhk=;
 b=MnmuAFn3RzMmtPudj0mPg2amQIkZWLEM2+EKcx5M6L0cngtng5QrnyBkDK5/h1XCMY
 JVAKSQ6hueIEemEYOnjNopUWkObg97IvpgguhkM7izJjvtNgHa5c1EPZsYCQHSd4Rd47
 a1nPvrNqLwEJT5OqWF5StRw3qMx0qLnp78xFPrvRYqJID6My0WkAH98/tywjWeaL85jP
 Luibf3m1KAs2uqwNXRMGv81BlbRZYTGXa1erjOQaxqkZ/aFA/XgcDNflmRaoc9A9naQg
 eRnnBBPT7+WW8DGvqJCG3oJFP6qMZz+Y9ZD2TxLlsBCF5aqiYKQkEmGSkBb8pBCnwNt3
 7nwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714160746; x=1714765546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q7YRlrLoDVqcKqwJc5XUnzy4U8ujSMb/8xBf3PSdyhk=;
 b=WNwTGXPKRolfozlU7x3idzRaAGFgg/eDSBwgoKWEPI24+XbQRUxHkaw7odCKlOmvu9
 A6tPXLbsSFw3V4W7XUu1s+yPileqYrR6iZRWhTyCWOumsJJXLsAIiPpKx7QqtD79v376
 p2AbEkVBu7HP00HECC2mGo8sYg2urKlc6eKb9kzR0tCidhvIAzTkucq4DxYk9Kgf+GqF
 qaaSG6+cjwHtA0ovBdi7YKlQct4hivu4NiuusgG3CmJcZal1puCnV2lvL538Nq3d2XqU
 e5zLR4xZtiR2WfS2cgQrmLTmkovz4BeqEX8eR+bCSP3pcaQ3zrBzHyp4KnBAEZLtruIB
 R44Q==
X-Gm-Message-State: AOJu0Yw6ytRj/mcBkgAFeuEjXV6lx7XmuPW6RwPnAXBKWCbDd1zWRugt
 BEME2BGZ8bwccncmyUCOrygNYvbdv9+uz9L4EUO82MSeVmpppPS1zQuTu3XtgZRRsVcvWcQEkw/
 9ul0=
X-Google-Smtp-Source: AGHT+IEizWECJiHFY2lqs+yjor1DElScPSkGynXQo4U3KncjdruIEQM1SaflMnx6CBfEWAUsmEZv3A==
X-Received: by 2002:a05:6512:2c99:b0:51c:ee04:3732 with SMTP id
 dw25-20020a0565122c9900b0051cee043732mr969913lfb.7.1714160746403; 
 Fri, 26 Apr 2024 12:45:46 -0700 (PDT)
Received: from m1x-phil.lan (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 g4-20020a056402320400b00572593ddf22sm854298eda.58.2024.04.26.12.45.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Apr 2024 12:45:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 38/38] plugins: Include missing 'qemu/bitmap.h' header
Date: Fri, 26 Apr 2024 21:41:58 +0200
Message-ID: <20240426194200.43723-39-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240426194200.43723-1-philmd@linaro.org>
References: <20240426194200.43723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Since commit c006147122 ("plugins: create CPUPluginState and
migrate plugin_mask") "qemu/plugin.h" uses DECLARE_BITMAP(),
which is declared in "qemu/bitmap.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240418192525.97451-19-philmd@linaro.org>
---
 include/qemu/plugin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 12a96cea2a..41db748eda 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -13,6 +13,7 @@
 #include "qemu/queue.h"
 #include "qemu/option.h"
 #include "qemu/plugin-event.h"
+#include "qemu/bitmap.h"
 #include "exec/memopidx.h"
 #include "hw/core/cpu.h"
 
-- 
2.41.0


