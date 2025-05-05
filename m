Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E5DC3ABBF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC57F-0006Tn-67; Mon, 05 May 2025 19:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC576-0006MA-Jz
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:44 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC572-0003bF-Oi
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:44 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-af908bb32fdso4375965a12.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487239; x=1747092039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oU3hP1IM611C1WkYpOLE6kbCej9Cg8bXJlI25SZwxm4=;
 b=LLj4g4FJRA1aX8sGgVm7qp1dZ9r5pTAhRhAaEy3A34elER74ovhb1WNKtqcPvMSKQ7
 jNP0IgOCFEKAMdvqczhHqsgD5aXxL+gn7L5t+ifaVoKHzrB4OGBRBuvH8Ob2Cm+S47dh
 Us0HWO8WPkMGemVV+hcYAkf8hpJs4TNWylNsQoxAToTVdZVYNcIb//l/BVsnO0m/0mcA
 xpvtIGrZRQ5eLUfouglVQKcw4MkrEzi5UFM3Lorb1rum4EOnykmo9QmCFg46WKIIZpB5
 FEy3K2P5GKOWi567/13i7Z1o1CYJKB1CeMZED46IiJzOKOxe5okBZqIMAjmVM7hpSmiU
 bbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487239; x=1747092039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oU3hP1IM611C1WkYpOLE6kbCej9Cg8bXJlI25SZwxm4=;
 b=qhlDaG89J/9fePyM1XEzg88jyToheG9LfJNlz4mk8x5IB5Dwpll8KPKflz07Emro2M
 8jt1tfDOF0uDtUoyxnlAoX7SH3cKUdPc2toOPxE1COGQEdVdqAQoJjFPt3KoA2PJDBFB
 GpFtV+ocU6zj4zwVKM+zRrJgECXQTY36KtQWa8nDj5n0AEBCh/mKb8HnXIY6nx8ijSa4
 K/aSZS7NNobXgfVYb9oCrDwv/V8fYomcwV99or6VM7UhzOMPizzGCbOS5lTYhV0bN0Gs
 lN+SJKT+L5ddPL/iNaLkivCyqQ984oCYgDAIrgo6C25r+ApnWXeYC5v+1PQrGctLSAnW
 myEA==
X-Gm-Message-State: AOJu0Yw0qWrcttftDQjdi/nV/zbXxrKwaOrTpBnH4gaMj7zJPZIVj0UB
 /2zZ3eZUxqdgSS/6GeHauiB3U25jM5Jh2WckEoPcoV7DWkYhXrtTj8pto33Q8/us0mtpqhzoPXz
 Rk18=
X-Gm-Gg: ASbGnctjDnLh6aWGZBzLH7sluEyNePJOM84mBAnaElIbUCsWF2I+ZoWPsPRFoMb5c9G
 O7uhtu4lI+wd2fDayOmQWxVRWvRweol8/oPS2TDeQnQ0HJiQRphrLyvzMfeb5Qe8fTHgE9xq3vj
 XgAFU4BrkyKbraLCTzPkgM9n8vWIAFEwPP4z0IRWf4vFVSXOPAa/qBeBq5TblurFHa5iM2hkR3k
 J/MB5N+qHBdYW6wZnbHI6Yd1ke00Sjw73YquWgmJsPZuHQucmyzogu9bdCwP5jMgTpy6KeukxV9
 2H1cLzFYXrcW3KGxRkHF1UIcDP4BUXWrvES8UWM6
X-Google-Smtp-Source: AGHT+IEeQn5CnaDJkgJrvd4w2rWjGIxMS+SZ2bixNnuJIzYcZR/FEvQuhLkOTW8Ra8Q6iuMjA6Xc0A==
X-Received: by 2002:a17:90b:268e:b0:2fa:17e4:b1cf with SMTP id
 98e67ed59e1d1-30a7bad37a1mr1863711a91.2.1746487239310; 
 Mon, 05 May 2025 16:20:39 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 21/50] target/arm/helper: restrict include to common helpers
Date: Mon,  5 May 2025 16:19:46 -0700
Message-ID: <20250505232015.130990-22-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52b.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7fb6e886306..10384132090 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12,7 +12,6 @@
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "exec/helper-proto.h"
 #include "exec/page-protection.h"
 #include "exec/mmap-lock.h"
 #include "qemu/main-loop.h"
@@ -35,6 +34,9 @@
 #include "cpregs.h"
 #include "target/arm/gtimer.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
 
 static void switch_mode(CPUARMState *env, int mode);
-- 
2.47.2


