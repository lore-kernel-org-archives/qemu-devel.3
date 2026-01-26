Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD485C88E5A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 07:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkGzC-0004Hf-71; Mon, 26 Jan 2026 02:26:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGeD-0002jr-Ib
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:05:05 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGe6-000441-PY
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:04:26 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-81f4c0e2b42so2062130b3a.1
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 23:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769411052; x=1770015852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T2xUEoYpnLX+y7kFhG9JXWkUeGWlapfsje21sWW5Bcs=;
 b=bRzN3zRfCqYHxLRYzZXXwDivnHVZquUwbJqLtqyDhJtZidE2+6byVatS6BX0X8nVHp
 6RMLjAXw14g/CqM05/iUABa3xfYwkHxhIlPFYGC/hB5y85hpB1NEkU9OCbG0hzEjIlKZ
 OacGPsMVi24SX8U3c99FWYeFubyr2XGNqHHPWnPL4Jlh1j9Y6QKmwtSSXahXbx/w1cI6
 WGYDl1vAQHJLPhau6i8okQxpKpEqAyjjxS14T9l++UV+ii+lrPy2mZR+nw4QpsC5aK7l
 u44ZC0DxiAW49pZ+25IV4Z9rVLMfzoeliNxDWQEFiAK/RCUqprh9CX0YzjxhPm9M4Q+P
 9adg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769411052; x=1770015852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T2xUEoYpnLX+y7kFhG9JXWkUeGWlapfsje21sWW5Bcs=;
 b=ReAQwv1/NKceNdFnXkzUXfT64UdpVEdJmgTGEp0vIiIgAOe/zAPNcicxZmxi/n40p3
 QNtlU/TXNfBwOdPKrWsjWbenUQFYMuHIYkY9qE9rKsLTNmzWB7e49zJDfeTQyqAXqjQz
 Nyudp3eimXK9O/ZSBiDDVoWH3jvxiLgzj5JGiBfETShEe0M8TNbm+MAklmD6D0YKhNL9
 r8dqLx3pa+EZH0WXP15fY6Dd0viFZEfuVclTUgj0A0NX4TyNmJRBkRNbNZ6z1mT1IqTD
 c6Ei1P+YzyoPvnN1hbCwQ6ZACCu8L02M9taRmZJVLGdXUcA6yTD+U7CnV8bGP6p1l1cd
 G97g==
X-Gm-Message-State: AOJu0YzDpvEjEapG4QrsHkO11jiVP/q3mXJ3nQ7IrLS92207vYd/lbeN
 WJPUVNysGz2quio8DzPYwXAgTDuqxfjCOgqSibywjYclH5wx5c6kTUTpn8ylbfg5
X-Gm-Gg: AZuq6aItxYOOuBUMV1HevPtQGOnKh8we6hNMz20Xb8U7Lm4Uff1jRl5P6oJNUryHecP
 3D7HyIbjOuLZ2hj1PVMVeUf/MyNZXjQL0YsZ0WM991nvpdtD0SHQdDE+WaRL1NcACba1fky1hT2
 jy0ncMozKpBCr76Xs+FRzckU7bpVlGI9zbNDtcPytOYLeMqm34THOcYF3lQW0vrAV3tBSSZP93e
 8GxqwVwB3ZfHzu89AGmYxGqTCWWHufADbxVekHMMSPrOwUL9rIROD92Qaf/GPqb+u7r2zGc/UvM
 Xk0Pqa5HWa56X6tKyy0BpvfWVjKQ0GogO6f3Ase6gM6t8OKhso5P234xyyMbgwi0qj9OSKtK1St
 yzHAvjVq0+TeT/1df/BbOPd/SYBKGTiAKqtuSAEF5eY1atjbZrh9kky1UwdgHNc898ZT8qLxhVw
 /USyxKJSXPWwqw7ulugGYkA8oLG2xuaSAQWAwcOX0F5w==
X-Received: by 2002:a05:6a00:12e2:b0:81e:8e66:38d8 with SMTP id
 d2e1a72fcca58-823411dbc89mr3190318b3a.10.1769411052479; 
 Sun, 25 Jan 2026 23:04:12 -0800 (PST)
Received: from brahms.. (fp93c00990.tkyc601.ap.nuro.jp. [147.192.9.144])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-823187716ebsm8661487b3a.66.2026.01.25.23.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 23:04:12 -0800 (PST)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 01/33] tcg/wasm64: Add tcg-target.h
Date: Mon, 26 Jan 2026 07:03:14 +0000
Message-ID: <1061c734ff63e09ea0544ebecf09abfd6fc25b11.1769407033.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769407033.git.ktokunaga.mail@gmail.com>
References: <cover.1769407033.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since WebAssembly instructions vary in size and can include single-byte
instructions, TCG_TARGET_INSN_UNIT_SIZE is set to 1.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 MAINTAINERS             |  5 ++++
 tcg/wasm64/tcg-target.h | 61 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)
 create mode 100644 tcg/wasm64/tcg-target.h

V4:
- Removed tcg-target-reg-bits.h as the 32bit support has been removed and
  TCG_TARGET_REG_BITS is no longer needed.

diff --git a/MAINTAINERS b/MAINTAINERS
index c1e586c58f..470b15eeb7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4107,6 +4107,11 @@ F: tcg/tci/
 F: tcg/tci.c
 F: disas/tci.c
 
+WebAssembly TCG target
+M: Kohei Tokunaga <ktokunaga.mail@gmail.com>
+S: Maintained
+F: tcg/wasm64/
+
 Block drivers
 -------------
 VMDK
diff --git a/tcg/wasm64/tcg-target.h b/tcg/wasm64/tcg-target.h
new file mode 100644
index 0000000000..f00761d19f
--- /dev/null
+++ b/tcg/wasm64/tcg-target.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Tiny Code Generator for QEMU
+ *
+ * Based on tci/tcg-target.h
+ *
+ * Copyright (c) 2009, 2011 Stefan Weil
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef TCG_TARGET_H
+#define TCG_TARGET_H
+
+#define TCG_TARGET_INSN_UNIT_SIZE 1
+#define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
+
+/* Number of registers available. */
+#define TCG_TARGET_NB_REGS 16
+
+/* List of registers which are used by TCG. */
+typedef enum {
+    TCG_REG_R0 = 0,
+    TCG_REG_R1,
+    TCG_REG_R2,
+    TCG_REG_R3,
+    TCG_REG_R4,
+    TCG_REG_R5,
+    TCG_REG_R6,
+    TCG_REG_R7,
+    TCG_REG_R8,
+    TCG_REG_R9,
+    TCG_REG_R10,
+    TCG_REG_R11,
+    TCG_REG_R12,
+    TCG_REG_R13,
+    TCG_REG_R14,
+    TCG_REG_R15,
+
+    TCG_REG_TMP = TCG_REG_R13,
+    TCG_AREG0 = TCG_REG_R14,
+    TCG_REG_CALL_STACK = TCG_REG_R15,
+} TCGReg;
+
+#endif /* TCG_TARGET_H */
-- 
2.43.0


