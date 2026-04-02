Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03580D39413
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 11:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Fly-000384-Ix; Thu, 02 Apr 2026 06:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1w8Fle-0002mu-4w
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:59:25 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1w8FlY-0005NY-DL
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:59:13 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-35c1d101355so280293a91.1
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 03:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775127545; x=1775732345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=84lxbSE2/pGx4RncQfTFwrbz2zjjlgBjhGePjquQX8s=;
 b=F4fnbADIEsutzGhEKGy5fT7moTPzEtnH9aOwDb3oFALiJ2rR7XgLjLOOsHL8BmOpQH
 8wQYlVnw3b3sy6LbHLaxjTBxlH7XVVTQ48fdOYF34O9sEE/R2ZsnLyEhxGRYcptNsD5U
 ozJuHBdHZqqfbT5kVPHIGERUKx8OtJIARbI5x3xERVm8VEBN/ZL75oLwSKwfz0MDcgIv
 lPEA9zR3CKmZQupUd8tnqICvw4ToUAhYbvvm2DuurK9PkrwVpl76+VZ/YgfHcebezgI6
 dpbfidOLSV4qJyiFqhZWEODKU6Bq/QfHCTu1JSXujuDPxuowHDSf/vMnOSo+fh1LtGbF
 ZUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775127545; x=1775732345;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=84lxbSE2/pGx4RncQfTFwrbz2zjjlgBjhGePjquQX8s=;
 b=PDRzuRKVTx3sVwMJBSxAGX8vSNgvyGye0ajF+1ANZl8khVE4zau/xzAna0YH2DJfbf
 UMBiHD2aMpX04BvDOD9WOVt0TDJXIXECmJZ1FiWgXM3f/Af1Ct5eAR6omJC1Vvvj4mjN
 svwMPXq6CljyNCi5+FjXXJxXWl2cHXOdHsxyNXxUhLN6elmidvXgCSJBnW8vzSQ3yD3n
 Qo88PldPimRxPGPNVJpdJYBPmVFyAduHCf7vcJHLLnG8JiDyFLIuH+iZukeEftizdTOp
 dctPBp9B6TRQXLDW3A3CcmhGC0M0maCOsM4lz4cPwQKT65c5DkvefjVrEdhoNSt83sOD
 781w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQPPu+jz7hNLIOMsWXCgD1KRJIA+ECFCsTERdCl6V2XvFglY+0ycpC3sTPWkskmX0Y+icPMfKKGzJU@nongnu.org
X-Gm-Message-State: AOJu0YzRfhWTmonlhA6WZY9yclYOKutqaNIXDeAlSwwO17MuCGtaQmu+
 PmvQA+RrxjiaC9uStfXSuGJ/xLrdiJ+/L1y5BNbg1+uEm1qgSIu4EAy3KmMqQg==
X-Gm-Gg: AeBDietrgZ0JnBrOlBz6JsNoNPQIcMGFYeKOGIKvPBVZSBEirQRNvz5CFKfGB8HXmnw
 OUAPtx5srU6D7WmAVTtOT+7SWP2fQjx1egu0IhNI1FR6z9IiENY8HAvT9gG+4mQzFk/onAxPcdD
 Qh8hp7lhPc+19Hvnqtpt9KvK3HA2Vt5oknYhxxxZlBa7vmCiFKOMmXp0XlsXWMiU+5YdPSmPuab
 EyTRXN0L4tbs1y3DEupsvueBCH5r6f6H47No5ejVEAOTmypnf6c/pM2zkAra5sYHywKXWr0IyAS
 LacTr9HmicQ+YLTQwgd+hFh0qQMdKlyECulF34+Fa5UHV3ZNOr1/fjfjbdfhsxigmArnMZ+/onU
 FnMMMon5Vcgc1x3hG+Mf9/pVkOl3ENLzeXSVgFFgmVuOvJucMfY1ciNkKC2GQXcMPRIHU+o5+ea
 nUj+sXGcGL/aPQyrKjBYuPd6c7BtUPO15ky+w=
X-Received: by 2002:a17:90b:1e53:b0:359:d54:846f with SMTP id
 98e67ed59e1d1-35dc6e5f96cmr6711752a91.7.1775127545433; 
 Thu, 02 Apr 2026 03:59:05 -0700 (PDT)
Received: from localhost.localdomain ([147.136.157.3])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-35dbe41b11fsm7512715a91.0.2026.04.02.03.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 03:59:04 -0700 (PDT)
From: phind.uet@gmail.com
To: 
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] util/readline: Fix out-of-bounds access in
 readline_insert_char().
Date: Thu,  2 Apr 2026 18:51:49 +0800
Message-ID: <20260402105150.274595-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=phind.uet@gmail.com; helo=mail-pj1-x1031.google.com
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
can write past the end of cmd_buf[] and overwrite cmd_buf_index itself.

The subsequent line:
	rs->cmd_buf[rs->cmd_buf_index] = ch;

then writes the input character to an address determined by the now-corrupted
index.

By providing a specifically crafted input sequence via HMP, this flaw can be
used to redirect the write operation to overwrite any field within the
ReadLineState structure, which can lead to unpredictable behavior or
application crashes.

Fix this by adding the guard to check for buffer fullness and ensuring the 
index remains valid.

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 util/readline.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/util/readline.c b/util/readline.c
index 0f19674f52..6b1de1094a 100644
--- a/util/readline.c
+++ b/util/readline.c
@@ -84,7 +84,8 @@ static void readline_update(ReadLineState *rs)
 
 static void readline_insert_char(ReadLineState *rs, int ch)
 {
-    if (rs->cmd_buf_index < READLINE_CMD_BUF_SIZE) {
+    if (rs->cmd_buf_index <= rs->cmd_buf_size &&
+            rs->cmd_buf_size < READLINE_CMD_BUF_SIZE) {
         memmove(rs->cmd_buf + rs->cmd_buf_index + 1,
                 rs->cmd_buf + rs->cmd_buf_index,
                 rs->cmd_buf_size - rs->cmd_buf_index);
-- 
2.43.0


