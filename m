Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C67C02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSMp-0005Wj-DR; Thu, 16 Jan 2025 11:05:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSL5-0003WX-3Y
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:29 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSKw-0001Fi-VC
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:21 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43635796b48so7481515e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043393; x=1737648193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q0SipZjZSJ8RGOzW6wWIIrmkUJqEseFLNGa6w4kFsPM=;
 b=r8aAlNmk8qPIKDTMOTIThybdafb6ITsKuIwyeLPXys8Kk4O+lqgofUHQgMShyLTOOa
 HR+nfZw9fu4ZDGhuH6Gdf7OHVH+bZrPR4HhbhkYiztjVkaW/27YgpjWhRvn4ztP9jabr
 xRaXQ0EUSXW5ojbXrB9fVU1VF7+XAVQMj/RAt+lETSnIfstB5f3Cwye0o3ud2z2JfdSP
 PveMUg7A7Cnabe7EF8T/c30NyqUangT9mAGn1MrErPG0Hau5XScGEHkQHT8PpyAkuczE
 ZSnhfduN2C5ZrrJoNhj6adXnZeQvOIRCZadriHnwrWRggCaIwzPvj7znzmMcwrnb8675
 sm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043393; x=1737648193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q0SipZjZSJ8RGOzW6wWIIrmkUJqEseFLNGa6w4kFsPM=;
 b=HXZblrBk3yDQbKcFOHqRgwmt4UlpmFJFqh17OCtJAWcmQSffB5w01GbAwtpzQx0NKc
 qwrAjmV4+Mt8EA4ZMEG1EP2PVhVosbeOV6a3nRn4VbHX27oS1w8IY0NbMUVgIzG9douE
 XZndeebO9VSswICYcQJQGGfZ08dlOK2fOZm4Vf/2c+38eSfGU+csnVs7QUWkUqhQSscf
 qbm3ffqurHTfpgoOh5qYj0bkW1kdSjCkwEkyrH8i3scy0UX9cvH+z7yuwHWv1D/2zwqX
 AJIdZ7wIyxQ9STkV4XKSi5V5VFSzS8pTQDPLxh8/QGipVh+ZWhWO6QHLFivcDy/Xhij4
 KLwA==
X-Gm-Message-State: AOJu0YxfL3ydwD1VNonNT2sy+6HjAbdA+g5WCigx5qsPIXsYKT3muPIm
 6Y30xQLCxv979qKl5wSKTXo4G3KFSlx4sbFE8dDlwmtfrvyhW5r5IcrTAvu2weE=
X-Gm-Gg: ASbGncvy/Exvy8cYgMXi5OkBu4RergCZk93AyIJQsyjze7OMSG2No8EHpLuH2imQSUX
 cKKH+uDTmzNOTfY3L+YoBXrLWorSCHCbxzDeIX9CXpmeQZ8gRxRm19y5Xc7ApIRmGSi8CSRCOW5
 jhJbVT9r/UIZl2+1XrUhHJsbUPTN4outXTSAudrrqw9UHtZNSk10LALlaIrCOdRitStOpWS/akS
 NKC57Xw/JLptMa0K6JRQyzDn6GMJbyAJoMn1Dur6TTBrnqIHcVvHaI=
X-Google-Smtp-Source: AGHT+IFYjp4G+8Eoy64Ai8ne/iUQBrd+D0c2rfbhOdo1KaxZ/zM1d1gjv7uorIjInXGHObkxk+PkmQ==
X-Received: by 2002:a05:600c:1e29:b0:434:e892:1033 with SMTP id
 5b1f17b1804b1-437c6b7b184mr70429135e9.2.1737043391766; 
 Thu, 16 Jan 2025 08:03:11 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4389046885esm3193275e9.36.2025.01.16.08.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:03:09 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0191A60859;
 Thu, 16 Jan 2025 16:03:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 06/37] semihosting/console: Avoid including 'cpu.h'
Date: Thu, 16 Jan 2025 16:02:35 +0000
Message-Id: <20250116160306.1709518-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The CPUState structure is declared in "hw/core/cpu.h",
the EXCP_HALTED definition in "exec/cpu-common.h".
Both headers are indirectly include by "cpu.h". In
order to remove "cpu.h" from "semihosting/console.h",
explicitly include them in console.c, otherwise we'd
get:

  ../semihosting/console.c:88:11: error: incomplete definition of type 'struct CPUState'
     88 |         cs->exception_index = EXCP_HALTED;
        |         ~~^
  ../semihosting/console.c:88:31: error: use of undeclared identifier 'EXCP_HALTED'
     88 |         cs->exception_index = EXCP_HALTED;
        |                               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250103171037.11265-5-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/semihosting/console.h | 2 --
 semihosting/console.c         | 3 ++-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/semihosting/console.h b/include/semihosting/console.h
index bd78e5f03f..1c12e178ee 100644
--- a/include/semihosting/console.h
+++ b/include/semihosting/console.h
@@ -9,8 +9,6 @@
 #ifndef SEMIHOST_CONSOLE_H
 #define SEMIHOST_CONSOLE_H
 
-#include "cpu.h"
-
 /**
  * qemu_semihosting_console_read:
  * @cs: CPUState
diff --git a/semihosting/console.c b/semihosting/console.c
index 60102bbab6..c3683a1566 100644
--- a/semihosting/console.c
+++ b/semihosting/console.c
@@ -18,14 +18,15 @@
 #include "qemu/osdep.h"
 #include "semihosting/semihost.h"
 #include "semihosting/console.h"
+#include "exec/cpu-common.h"
 #include "exec/gdbstub.h"
-#include "exec/exec-all.h"
 #include "qemu/log.h"
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
 #include "qemu/main-loop.h"
 #include "qapi/error.h"
 #include "qemu/fifo8.h"
+#include "hw/core/cpu.h"
 
 /* Access to this structure is protected by the BQL */
 typedef struct SemihostingConsole {
-- 
2.39.5


