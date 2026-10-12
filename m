Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC90CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 23:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGPLK-0000fm-3J; Mon, 12 Oct 2026 19:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGPLA-0000fB-Dm
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:21:56 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGPL8-0001od-OI
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:21:56 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a16bc2278aso16180565e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 16:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791847313; x=1792452113; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D0Q5PGrYyI0FbZz84Oara9Qnk96RusVvamlC0D8BXx0=;
 b=iQW2UnvDYfV6GRItM1qGeY36o3XOMt3cYAFz00n6MCI5S2xdyV/TuUhEiZKRfpHKsP
 eSP8ajbZq5Nki4l1ZBgy5DLNfMtLMMlei7Uhw+4esASvWbJAa08OijkGSkjBLXd9Gbss
 2JNDEXxyeVvBGaXIfY9Yf9fWFGMEFq9DB18cOYC7hz8ygrfA+LtOf8fAvz4pw6b6Nhkd
 OMsd+egvagrLXDrZAiuQdMoxqgLtyJ8qNF3oyvihCDrIc5UKqaBa0rdcfW1URuybvB3n
 LD90CHSauHK5cgKNQSzdrNved8JQtjNLpV8bSAPoeh2YqfP9Jt1xFMfdDbL7vvBVXP5Q
 79NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791847313; x=1792452113;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D0Q5PGrYyI0FbZz84Oara9Qnk96RusVvamlC0D8BXx0=;
 b=CbLMr4IpibG5PEFtv7eEJ835UkWN5qap4lJX3l+BwP4c2QvqEJ4SD9ErGgGz7ue1Py
 mJ5pJOTcE0DpPZhlG9roMN4AvHIvT1t++R7VAidoJ44ZzMfGDaQya3m35Gw5LlipFe6O
 0GUh4EeClVl4rrMDC0467Bg3fwjTiPW+Ut/cAi0ymFSMbXBLK2Y9bc2esZJ9KdmlJmb9
 J9rRTNc9kEZbcot/zUTqcgn+Z6E9MHjNBonv6glkr+m19mAVchyLJvACRH8WDCXbDjDl
 AZ9AiPkEaCRokmJ4wwTxnoBKV21SbJ2/LLwPdlMcJ54rYrJLW0K0kozZJeuufk8UHElu
 xHAA==
X-Gm-Message-State: AFq9FYKkOkdoXO0Nk8gVRH2S3siwEt81DlrZJAxvNhGUs7cqhtHZZO+9
 /2C346WZJOTZwRpKu9Q29NyjUa0a8J+f+P7X6oliy8T/6aJkCwPc64OJ
X-Gm-Gg: AYBFou2jNTPTY1oSWNgqCDIU2dgeCUAAX4AAQwXAQ1BOpLlEHn8jcNBVMZiclXOZtiO
 22zpb2ONRdRh/jterWkxoz5aiXPjQ5rJRQ4QyUvonTwKeRLLzpRvToQxD4Jl5NuZhWvUFz5PDG+
 fkyVUmdBTI8cyhUfdNPjGbNCslwoWUSGT9YYNyAhhfe0o3w3owlrY5KYCTSZG6pgRfq1hEKMCRD
 g3uPLSzG1S8cLyNhEwXaBTA6gDou7u9wykewu8Z+utLxuoYhXNynd98cZp//Px4PLQLf9A6J/2h
 eB4NbAjsEBpG30DyXaycW5oMNxic+yhsHPs3bdpJz2UZgVVjXAoI7dwyZ5NSkKBl06SHnJGa99O
 BQo0uCqp73GqnC0XbhelG5m+h9MtVU0Fdkq5icgmett+dj4eyqqPe6oLhEgndIl1JSdDCKiqFoJ
 x0v4XB9QN8Ex++pGAr3BOKgOerruuqZOOdivxIlCjlw3KnLpm2rr16a6BBNLrir/xL5KEIXT4+X
 Bc9xeuPGj9ALvBZcTxqaLW0/daVdi5Xvg96PA==
X-Received: by 2002:a05:600c:64c8:b0:49d:1df6:2592 with SMTP id
 5b1f17b1804b1-4a18e4c41b0mr193132275e9.21.1791847313342; 
 Mon, 12 Oct 2026 16:21:53 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a19c8244edsm151614775e9.2.2026.10.12.16.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 16:21:52 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Tue, 13 Oct 2026 01:21:38 +0200
Subject: [PATCH 2/2] io: report a warning when a file channel is created
 from a stdio fd
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-fix-stdio-close-v1-2-4ecfa416c7bc@gmail.com>
References: <20261013-fix-stdio-close-v1-0-4ecfa416c7bc@gmail.com>
In-Reply-To: <20261013-fix-stdio-close-v1-0-4ecfa416c7bc@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791847309; l=1009;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=c8aQQz8+BdprVVUan6DsxODQ2fZacZAeacmfsct7E0c=;
 b=WsA/U6wsX6Z+D3jVDDnJTgZmzeAfAYP7JdvaLwvfGegp2OkoXu5xbISF4J+He0sNv8zaRgJhP
 Qk1VIAx8UEzCHUS7fP0uXYDOxVwUg0Qq6m7xzTrNFBUZJ6XTAVAFo4P
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

A channel closes its fd when the last reference to it is dropped.
Closing stdio fds is typically unwanted, so warn when they are passed to
qio_channel_file_new_fd().

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 io/channel-file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/io/channel-file.c b/io/channel-file.c
index 5cef75a67c..98ed8a973e 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "io/channel-file.h"
 #include "io/channel-util.h"
 #include "io/channel-watch.h"
@@ -32,6 +33,11 @@ qio_channel_file_new_fd(int fd)
 {
     QIOChannelFile *ioc;
 
+    if (fd <= STDERR_FILENO) {
+        warn_report("potential bug: creating a channel from stdio fd %d; "
+                    "the fd will be closed when the channel is destroyed", fd);
+    }
+
     ioc = QIO_CHANNEL_FILE(object_new(TYPE_QIO_CHANNEL_FILE));
 
     ioc->fd = fd;

-- 
2.56.0


