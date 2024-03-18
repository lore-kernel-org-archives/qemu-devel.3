Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBBAC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 10:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm9sf-0001IR-62; Mon, 18 Mar 2024 06:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rm9sc-0001HK-NZ
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:06:06 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rm9sb-00062i-5w
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:06:06 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d4541bf57eso54065881fa.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 03:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710756363; x=1711361163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aAPJ6Y+kJMuu6R/0QHRDn6EQ8anTjPlXcNycKPDDQr4=;
 b=wpyiEdi3RnAwIOaYW2JmRdsMsI2uYGPkfU4dlBakQ67a5gmAeuFgDb/GFdP8FsZkiS
 uckJT5789sw+6wLXVpyBTIZx3J/7aK29HXbJ+TsP2qMEwgcSvqFtL+ncL9dBd9s0JE1m
 5PuznFD7EBARaocvPJz8egvOyEBEtAN9E+M8Knp4ps9ik38z1S7dFgXGhkgjz6p8xiTI
 sArP/Jvl0lob+i3E6+iLTVC+EavOqbBb+WGyaGMMx0XA0RT+uOKT2wc18hgNkhoXKd/U
 p42S5jt3R0dg3T/ceF2WXq7T7rP+wWUZi3YiqU+RIt86GRVhCwGOYSSwcEZwSz9J7KT5
 pbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710756363; x=1711361163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aAPJ6Y+kJMuu6R/0QHRDn6EQ8anTjPlXcNycKPDDQr4=;
 b=Siz4C32lB2L5xM26IIxz3dgr9i5fgoZ1U5gnHJNYBe2vE5NmsiCsZI+dipsmIrUB15
 zCdlF2BKeTSaPfmoHVOrBKII11awaIsz0yYTPzNiyOYEV1MxbtEqfUAr2PeVazyZAYbV
 E5T2zSNadUWQKPCe4npDo8z15hFiWpr1GxirzVE3wdJXhbcWc/dK4fRJq40nWHHkscD/
 kUrgwTdLP4AiGrf8Wv9rRlNtPlWZinadoAnJqe5I5HHaV3mVBf70u+suwjfL/8zGR6Ub
 jozINSguIybGzBFWONpkkU3k+yiyUuD01qxY8Qllr38nAc2yDXtTTrDZRCk4mSYfeBSD
 mmRg==
X-Gm-Message-State: AOJu0YwQLNUZ2ONu8UrjKMcUYXHU1E4ME7J1Y5Q3oMv28pAOyN5eo7xl
 ex8w5dk1IK+glWTkNUum2oG23fUAI5qJ8hXMovthoyw78sVkwbjYIH6fP5yPSW5aEXZH+i11WLf
 +PWk=
X-Google-Smtp-Source: AGHT+IEqsw+lL9+FVAYGG+mLpHqoNjzXU00T8eEJK7vM15ygPCVUjJ/fErDrrS8XCOE5beEiEDV0yQ==
X-Received: by 2002:a2e:b8c6:0:b0:2d4:aae0:1d77 with SMTP id
 s6-20020a2eb8c6000000b002d4aae01d77mr1405796ljp.39.1710756363125; 
 Mon, 18 Mar 2024 03:06:03 -0700 (PDT)
Received: from m1x-phil.lan (vit94-h02-176-184-29-165.dsl.sta.abo.bbox.fr.
 [176.184.29.165]) by smtp.gmail.com with ESMTPSA id
 f5-20020adffcc5000000b0033e7b05edf3sm9432360wrs.44.2024.03.18.03.06.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Mar 2024 03:06:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 3/3] ui/console: Add 'rotate_arcdegree' field to allow
 per-console rotation
Date: Mon, 18 Mar 2024 11:05:42 +0100
Message-ID: <20240318100543.78846-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240318100543.78846-1-philmd@linaro.org>
References: <20240318100543.78846-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
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

Add the 'rotate_arcdegree' field to QemuConsole and remove
the use of the 'graphic_rotate' global.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/console-priv.h | 1 +
 ui/console.c      | 7 +++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/ui/console-priv.h b/ui/console-priv.h
index 88569ed2cc..6e54b476d9 100644
--- a/ui/console-priv.h
+++ b/ui/console-priv.h
@@ -31,6 +31,7 @@ struct QemuConsole {
     const GraphicHwOps *hw_ops;
     void *hw;
     CoQueue dump_queue;
+    unsigned rotate_arcdegree;
 
     QTAILQ_ENTRY(QemuConsole) next;
 };
diff --git a/ui/console.c b/ui/console.c
index 84aee76846..a36674bacf 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -37,7 +37,6 @@
 #include "trace.h"
 #include "exec/memory.h"
 #include "qom/object.h"
-#include "sysemu/sysemu.h"
 
 #include "console-priv.h"
 
@@ -210,17 +209,17 @@ void qemu_console_set_window_id(QemuConsole *con, int window_id)
 
 void qemu_console_set_rotate(QemuConsole *con, unsigned arcdegree)
 {
-    graphic_rotate = arcdegree;
+    con->rotate_arcdegree = arcdegree;
 }
 
 bool qemu_console_is_rotated(QemuConsole *con)
 {
-    return graphic_rotate != 0;
+    return con->rotate_arcdegree != 0;
 }
 
 unsigned qemu_console_get_rotate_arcdegree(QemuConsole *con)
 {
-    return graphic_rotate;
+    return con->rotate_arcdegree;
 }
 
 void graphic_hw_invalidate(QemuConsole *con)
-- 
2.41.0


