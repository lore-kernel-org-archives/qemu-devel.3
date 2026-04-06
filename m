Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04E7E9D82E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 02:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9Zyb-0003Dw-JL; Sun, 05 Apr 2026 22:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1w9ZyZ-0003Cs-E6
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 22:46:07 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1w9ZyX-00036v-Ql
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 22:46:07 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-35c2fe0d90fso1962671a91.1
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 19:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775443564; x=1776048364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Oxxjox1gJ+tGqFRrxpajMy1uEJ4ChHv4Ckz6L2imF0Q=;
 b=GEh4p740d7Uk3fsB9Hgur/qUeX+7BpARA5hPcOsXMs9fBzjXiVDW8p+epbUUMlDCMI
 fo6zc+xRqBA0r01veUd+jXKNhFAHFJM/qJnBhgwJUm+KM9CJygizLhRWq877FYNqGO0y
 ybUI6IRY7+jH0MmRXwX+GB9vw+2KLuQHlopnMjk44u5LH6eipYGIm1WFgQkBU9G9m9E6
 +KXDiIsOUx7XYUgzp+L5vjhUXjMW7CykG/i6+B135XEBgGeAysvkXL6tYSM+xuJL5CKq
 I5FxpcdBb4vq/6VevGLQ3cYBpiE6AQN7g1X9dkVIgxR8+jRt1G4Wx1y8f79bagCnDpU0
 bgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775443564; x=1776048364;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oxxjox1gJ+tGqFRrxpajMy1uEJ4ChHv4Ckz6L2imF0Q=;
 b=jBLhSd8LZcnyez3Hqz97YKx0ogdE7bEbpSYBWQEGYZNjsEWHMoc4MWTr3efkF34EfG
 XKZ3vKj5MuPP7b3b3pLqavpxgjz+33UbUZESuaKxI79FMLgyy4Ci/y0dZQxTdWptGa1l
 91MGw15mfp3gklftIKVnBjESrZjJ9e3YwbkBTqwjMqhHzIT+A9DPQYfgM9BRIqogJ3BK
 k91KU8R7NwilTf0LxSjahi9NCvIN2Zo4UhfagCq4Pp47EaoarZYwf3nq//c38+o+Sb/r
 TPBnC5YdCaiaGdmZBPQoYwHMjIX7goM/qDQ6RXVtIt4XaNxjuAd1qH6MkYck6t46CriQ
 +i4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWReWw94F1gFrO58Q8JD90vAOd1MIg/8rjxtrspcGnbruzX9+wPtzV+WH7sKYf6jgugehscX9jjQrSP@nongnu.org
X-Gm-Message-State: AOJu0YxIyFjk3d51hltlUNgOKbqO5L5cc706Z2MCz8EeqMpiYkoMEFng
 D7/qR8tQGPFhur4PthH2Wu13kNV4/0blAbr61cc3cniLIPOzrlW+7DZG
X-Gm-Gg: AeBDietuv/AJ/xEypg4JvzLXHqx3r2dQDSeSlGkatT9nLw1uAGs53qvcIfEX1ko21Aw
 YK/7s9tUBQOqIGmoySR47ZQIwnQYt8a2puTzC9kq80s8eU6PPz2ngmGmyf72vAYfI0IkGy6XXWX
 8pdTMWgQzPbt25eaJsyrh2YS40wUe8HiU0mwtahrgkbmTzN6DCtEcRFV06s/YHERUEihXO4aTTB
 PwF7KBitTcjEn9NHeUn9GVX0lrJQNSmNM4ewwYg6t5jxcr/HglWhDYqk2OjLbYvjZW9KcJM/rAQ
 rByhsNPXmUFmgn4JXhbEbn+kZu2xNYC6nEoDc1rDow9yPVjD6Y7e3kFUZz3pgghoEpGVvvPob+F
 FN749A9B/mqPYMuXzi600PRb21Dd9W8YepLjWUCT3QFxdWGDMyFvew9ftNPn7tNcIIbtOytj9af
 ysgAb8dASo6Nk1BcEg6yEWLTQnx5sRqVjxyAM=
X-Received: by 2002:a17:90b:4ecc:b0:35c:30a8:32a with SMTP id
 98e67ed59e1d1-35de67e8aa9mr10043037a91.9.1775443564223; 
 Sun, 05 Apr 2026 19:46:04 -0700 (PDT)
Received: from localhost.localdomain ([147.136.157.0])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-35dd369f414sm11639760a91.15.2026.04.05.19.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 19:46:03 -0700 (PDT)
From: phind.uet@gmail.com
To: marcandre.lureau@gmail.com
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] util/readline: Fix out-of-bounds access in
 readline_insert_char().
Date: Mon,  6 Apr 2026 10:45:52 +0800
Message-ID: <20260406024552.204973-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=phind.uet@gmail.com; helo=mail-pj1-x1032.google.com
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

From: Nguyen Dinh Phi <phind.uet@gmail.com>

Currently, the readline_insert_char() function is guarded by the cursor
position (cmd_buf_index) rather than the actual buffer fill level(cmd_buf_size).
The current check is:
	if (rs->cmd_buf_index < READLINE_CMD_BUF_SIZE)

This logic is flawed because if the command buffer is full and a user moves the
cursor backward (e.g. by sending left arrow key), cmd_buf_index can be
decreased without descreasing of buffer size.
This allow subsequent insertions to increase cmd_buf_size past its maximum
limit of rs->cmd_buf.

Because in the ReadLineState struct, cmd_buf[READLINE_CMD_BUF_SIZE + 1] is
immediately followed by the cmd_buf_index integer, once the buffer size is
sufficiently inflated, the memmove() operation inside readline_insert_char()
can write past the end of cmd_buf[] and overwrites cmd_buf_index itself.

The subsequent line:
	rs->cmd_buf[rs->cmd_buf_index] = ch;

then writes the input character to an address determined by the now-corrupted
index.

By providing a specifically crafted input sequence via HMP, this flaw can be
used to redirect the write operation to overwrite any field within the
ReadLineState structure, which can lead to unpredictable behavior or
application crashes.

Fix this by adding the guard to check for buffer fullness.

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 util/readline.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
---
V2:
  use assert() to check the value of  cmd_buf_index before the
  insertion.

diff --git a/util/readline.c b/util/readline.c
index 0f19674f52..e2664e48ca 100644
--- a/util/readline.c
+++ b/util/readline.c
@@ -84,7 +84,9 @@ static void readline_update(ReadLineState *rs)
 
 static void readline_insert_char(ReadLineState *rs, int ch)
 {
-    if (rs->cmd_buf_index < READLINE_CMD_BUF_SIZE) {
+    assert(rs->cmd_buf_index <= rs->cmd_buf_size);
+
+    if (rs->cmd_buf_size < READLINE_CMD_BUF_SIZE) {
         memmove(rs->cmd_buf + rs->cmd_buf_index + 1,
                 rs->cmd_buf + rs->cmd_buf_index,
                 rs->cmd_buf_size - rs->cmd_buf_index);
-- 
2.43.0


