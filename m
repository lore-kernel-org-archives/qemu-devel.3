Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D98C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk7N-00078e-Ka; Fri, 20 Jun 2025 18:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfao-0007vq-2P
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:31:58 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfam-0006Zk-Ab
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:31:57 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45310223677so17206745e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440714; x=1751045514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=isAQZEdTqgZ8UNjR/YKnXRfa5tD0yXP76gEetx+VgOs=;
 b=cO/WY1yn6lWIQI79/EYyXFEcHU+RK9yDKEYLxctn9biVaCNOxuGlP8vpsCb19vzoNk
 rCiX9cMabcbtFfMeGTccPaLY2Ve1wM/0tKOFRrghFzRhv5/bAV9mW2ceutH1pfAi3Twm
 REcvYdX9fxwMhetZ7jLRktO49uqJy+W5C4puq5AJQzF1/PgbPzLxYg/I+LMVP8hrM8Ys
 uUH+1OaDN1Wnj8YwSRKwYsm4wvwIs2VuR7FdeLOyaisyOLIs5KWYOnH6AqY3ekYzN5wO
 +hJK5GKfQaHPxwKQEciv1sJVYlpLVhI5qBqSq59yBJohI4MrV0Nnl/27dHmg7Tm3dkal
 n8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440714; x=1751045514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=isAQZEdTqgZ8UNjR/YKnXRfa5tD0yXP76gEetx+VgOs=;
 b=Yn/aq2UXxZXjQZViTmEnyVv+J+J3JvU+Zcc/EstnB1TERfCBFmmII0TFN7EWrtE4Jq
 M2r18NRdu0DHI8zuYOoBaMnlsDdooLwDJRq6mzqbAacNbKSUZ/zK7NNnTWecL7zJXdL6
 fUTc4Eep5LICz0yeIrv+KwQDOFgnwjV32u5unb6CekpqL6fAIGkDugXb9E/mHQ6l6DAS
 D22q7iLpQTR76cW7aaMG6kkw2+aIZ4riUrTMOoR7T/frrQlbheMbVlatejNANi+zu8U/
 BBnm0s6Xp0AudXw5n5sdx7583z4eWReU0OHslL639b/WtB6uLIu3E2ZaEewJDVeXq/Ln
 K2PQ==
X-Gm-Message-State: AOJu0YyOeLq200BicghPVsv2gdi4TtniMaE2WjYLpHXu6vxZsKIGPXnf
 Vo4Aqrjcz44IgJHxbRH8eGBOx0wDHjzIH3RpI72mRCyb/a4+bD81BF+Xti7RWjL7log2mIfj9wi
 OoXAKo53ziQ==
X-Gm-Gg: ASbGncvHT+iG/N9zJBPrSHjwz63qXITKmWW6mhucafeo4Z2J+qgBIsbsn1DVbgjOGr/
 6bkp6vAl/U007GgMt5jXZJ5CGByPaL8IxwK++t7GJlHYXMWr0r2Aeq84I1uE1Erjv54xlehNsMj
 gf4nN/gtS1E351jQihCETp3c1ByJ9Lhgk4129ze+QiyX8RPl43harujrzzLKJX8sKBT0BlHmLAE
 YENZhBOTrUMIBdZIF5zCCsqgB974QMXUPI9OYD2QiMZnG5pf6wqOSAoXxFAP0azNwL+of6sjbXY
 X1P5Xl+TmlO/Nyr2L5y6OtBfDZJXR8bZ9ZamKVPVYR88fGr7ndj3/TRp4jGTp84/ilK5PHOQjtT
 15I6wyoz4BTi8U9NVnmvlCvJs1lNLfHN6olPJgVIiuYz7w9m+y4ApdFdY
X-Google-Smtp-Source: AGHT+IHcOTzrdBI+rjP8Sr6Ww/3QaNpcJpSmb6RfU/rztKS/6qF7aXVn1gQTlOldYwmTXdNyjtXQAg==
X-Received: by 2002:a05:600c:190e:b0:43c:ea1a:720c with SMTP id
 5b1f17b1804b1-453659dccc3mr40452025e9.18.1750440714026; 
 Fri, 20 Jun 2025 10:31:54 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646fd74asm31450185e9.22.2025.06.20.10.31.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:31:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 27/42] accel/split: Empty get_elapsed_ticks()
Date: Fri, 20 Jun 2025 19:27:35 +0200
Message-ID: <20250620172751.94231-28-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/split/split-accel-ops.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
index d19b4641a2e..034b5ebc96c 100644
--- a/accel/split/split-accel-ops.c
+++ b/accel/split/split-accel-ops.c
@@ -255,11 +255,6 @@ static void split_handle_interrupt(CPUState *cpu, int mask)
     }
 }
 
-static int64_t split_get_elapsed_ticks(void)
-{
-    g_assert_not_reached();
-}
-
 static int split_update_guest_debug(CPUState *cpu)
 {
     g_assert_not_reached();
@@ -307,8 +302,6 @@ static void split_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->handle_interrupt = split_handle_interrupt;
     ops->get_vcpu_stats = split_get_vcpu_stats;
 
-    ops->get_elapsed_ticks = split_get_elapsed_ticks;
-
     ops->update_guest_debug = split_update_guest_debug;
     ops->insert_breakpoint = split_insert_breakpoint;
     ops->remove_breakpoint = split_remove_breakpoint;
-- 
2.49.0


