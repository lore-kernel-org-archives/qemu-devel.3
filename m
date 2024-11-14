Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C29DD637D5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 01:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBORG-0007sh-Gd; Wed, 13 Nov 2024 20:14:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBORA-0007lt-8G
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:14:23 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBOR4-00022X-6e
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:14:18 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-432d866f70fso952015e9.2
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 17:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731546852; x=1732151652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YzuvHkgFNpoK/g6N/GhAbq9D9bCDxAJSB1ivyjDA1qE=;
 b=aQnfWdM9oUqbizCzYhJjNbp8xrFa9/tb4ZWqmgHal3+yBBjYNABz5XiRscg5VcdRcs
 ZRBaEqzw8j9k16cudcI0ZxdJANG3smrjOFEOsnmf2zIMAO8G5xjQNuKXS7k+tMtAimqB
 MUeIA+isXQhcvk6SFGvgr5ocv+8hWYfjhvhKx0rhLTx3Snw9tfwyI0c4DGuswcJVIevv
 MF8psvDNJLq4hlcdzUkB6L1OwnARYLtxuo8iuxxR+Lujs0MDgbv3EyIw4giX7Or9ORop
 qwYg88kWc3+rla9uVJWQht+omGJ3WnZ6zwqztwQklvk0IXtWl3r5b66xDlInTHw5f5ZK
 2www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731546852; x=1732151652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YzuvHkgFNpoK/g6N/GhAbq9D9bCDxAJSB1ivyjDA1qE=;
 b=bl9c/dsEQ+OR4Zx3Nm+ZPFseNO3RnMuEFWNSMJ/lCNWZ2/Iw0fw6/W2X+dXASDgZhm
 tzSpQstwodTaDzpo/Pdi0PWhmzbtjMH9EmyUc2bLbX/kgOvLD9cPQ4EfRQB0Sm0OjXL2
 7gHn7C7BznjFZnJLKACkqBBh5JNtiqaOXRHTIzGZZrqGIXYKhWksM/R2x3BUjL8LGWDt
 wALZqZ5pvuau2IvMT9iw4yQOZ1Gr4An6PwiIak6uxcrTV75iJwT60/oYta21WPZVokAw
 f+KCodHvATEQtgUi82uxZOMSBXm5f5lBnCSf+IOTHXd/0gXB8wiAYuoAQm/PDxs0BCC+
 fkeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa1OjjnZCSOZSJ7j5bSca/wqISpyPLCfa5CSjEu8ELRpebyprKelTaJhq5hpZOeTJxOOkHNATqy0h1@nongnu.org
X-Gm-Message-State: AOJu0YzIlVy+Sueeu6QDBDgDvVtAnc1itn0ipMgMxwXOg+iqikcSRMSg
 uPnr1Ac5okHDKsmKbHGhRGMzkKQ6+N6t+KiVHkWGgDzXBdYapSPzZLqqefLvJas=
X-Google-Smtp-Source: AGHT+IGEpPcB2Ra92T20v+BX6rXD4nwtmCydz5vInWSdcDRLMyfilK5Pfw6s6wv0d0N8yzY4Z7WyWA==
X-Received: by 2002:a05:600c:19c8:b0:42f:7ed4:4c26 with SMTP id
 5b1f17b1804b1-432b75002b7mr202791785e9.12.1731546852174; 
 Wed, 13 Nov 2024 17:14:12 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.238])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab78881sm1520105e9.13.2024.11.13.17.14.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Nov 2024 17:14:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/24] target/rx/cpu: Include missing
 'exec/translation-block.h' header
Date: Thu, 14 Nov 2024 02:12:51 +0100
Message-ID: <20241114011310.3615-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114011310.3615-1-philmd@linaro.org>
References: <20241114011310.3615-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

The TranslationBlock structure is declared in
"exec/translation-block.h", along with the TB
compile flag definitions. Include the header
in order to avoid when refactoring:

  target/rx/cpu.c:50:42: error: use of undeclared identifier 'CF_PCREL'
     50 |     tcg_debug_assert(!tcg_cflags_has(cs, CF_PCREL));
        |                                          ^
  target/rx/cpu.c:51:21: error: incomplete definition of type 'struct TranslationBlock'
     51 |     cpu->env.pc = tb->pc;
        |                   ~~^
  include/qemu/typedefs.h:116:16: note: forward declaration of 'struct TranslationBlock'
    116 | typedef struct TranslationBlock TranslationBlock;
        |                ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/rx/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 65a74ce720..945ae6e9e5 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -23,6 +23,7 @@
 #include "migration/vmstate.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
+#include "exec/translation-block.h"
 #include "hw/loader.h"
 #include "fpu/softfloat.h"
 #include "tcg/debug-assert.h"
-- 
2.45.2


