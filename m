Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D80C88E5A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 07:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkGug-00073i-VA; Mon, 26 Jan 2026 02:21:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGgR-0003Qc-MF
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:06:59 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGgL-0004le-5P
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:06:44 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-81e8b1bdf0cso2223815b3a.3
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 23:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769411191; x=1770015991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oj8vRqVMDeN0JON25L/5cGpcqDkG3XOVfGvUsHWl4zU=;
 b=CaxY4BqOdyyH2UYsMdjAIDJ8U/9VZ7tAIvtbOSIBM1uNDCgHZxig9AHy1jwtf7jUwc
 HbBz7MQDFe9+bYMxd2pZ69wmPU9vCTJUx1uRO6Xkv3L7F5qAUfvHFto7vWIyEqz8/Cal
 KAcagYEaC0jcyxQDRac3o7yIVMCL2G7AoFQoXj8eN54Ii1N5DCA17gQx00VFqVK16BTw
 rM8gqQu7GNcCWuVfGsX71Tre4K9K0OveehxkMh7XTyf3JigVA7ZLrk7TN2jWEqaG/6pW
 /1zYknLhBessgi2+7xovFI+bXPeQVOTTQm22ZKRva4TPYtHfghW4TDVPh8XiPPF0BT7Q
 LCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769411191; x=1770015991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Oj8vRqVMDeN0JON25L/5cGpcqDkG3XOVfGvUsHWl4zU=;
 b=bFg6LyGHIPblwncyJ+nBmLXwJe1xYw5dAD4U7vs3hMCN/CTXIx08b6zO6Xs1FZ16Wy
 xwjEl6f+Lc5xemO5UpdPixUrAOM6SmMRx/Wr9DMGdONB+uecftUvP9TvnhY10DGdI5Ct
 cEomqIZzsSesiedSZOHeBR0TC3IiBWPebiTED74pD2LboEM5XXACIsiN7u9mRPiD+xrn
 /6YnvFSl6HLXYUdVnQ+XarxmZ/5sVOYZvIoK5eW/qhwUpgmWfimL6hGsstAEcWxAL2mr
 dgjZoQhmugVYaIhRFCDzMHN5IRqH7DBmZ3qpZ3E4MpPFJK+QyUTxK0vZijpFAIyHICoZ
 sfXw==
X-Gm-Message-State: AOJu0YytkPuQbuvoqsyzyUplxjXru/7l8+C4WLjIeLDuIcno3hygm+qN
 0bEbD/1RTLjIs0FSzA/b4PoCIPVR/OCCbyh54Pod5hRAAx0FYSRFFbcFA+isI0On
X-Gm-Gg: AZuq6aLKHI9CMocU5t7KxZosqlRbphtsZtEkiccLqOVdOJxNLl2ZIEqWAmOukPu2N+b
 6pW1E2BAiiDBFP1J89/Da/DWWLYvcPbQ5LHZ4dOVwnLM/WgMB2So+ozUoo9y04aeJp/51k71bKn
 3bMwO/5CjzCYTBG7ANk2AvS1oNF7o69ROurYBimxgvr/+gkIoZd1upsklX+KuaOL/zmsixwJrkj
 hnQcmS27e/wtJsyNbYY0zONhsSkcWauG4xjCji7UgTp0za91I412etLKl5zuk9OJ5M7RlTeCWM2
 1td8onJqhIdmI+4bDYWsyfp3IZ5mG+X+iSulAcSRbSAS53UvPAM9AZ2f6KCyAQZ/LBKHtKjCd7z
 CGI9DTBLyTko5rqBLu4vrwgZ6/en+TCI6iP74S5lE4YDMknDC3jDT/iz/tJEVzh5wU+bvCHoRYO
 KFLE0viJoWoN/F2bfkIzBG/qI/5XwedyEViHdAdloi8Q==
X-Received: by 2002:a05:6a00:2e27:b0:81c:717b:9d29 with SMTP id
 d2e1a72fcca58-823412bc9dbmr3045269b3a.51.1769411191033; 
 Sun, 25 Jan 2026 23:06:31 -0800 (PST)
Received: from brahms.. (fp93c00990.tkyc601.ap.nuro.jp. [147.192.9.144])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-823187716ebsm8661487b3a.66.2026.01.25.23.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 23:06:30 -0800 (PST)
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
Subject: [PATCH v4 32/33] scripts: Add a script to run the wasm-compiled QEMU
 on node.js
Date: Mon, 26 Jan 2026 07:03:45 +0000
Message-ID: <2af460d17a47ec69d691dfb876f834e4685f9d6d.1769407033.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769407033.git.ktokunaga.mail@gmail.com>
References: <cover.1769407033.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x429.google.com
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

run-emscripten.mjs is a Node.js script to quickly test the Wasm-compiled
QEMU. This runs directly from the terminal using the node command so the
HTTP server or the browser isn't needed.

Node.js 24 or newer is needed to run wasm64 binaries. Also note that QEMU's
"quit" monitor command doesn't work as of now because of the Emscripten's
atexit issue [1]. Send SIGINT or SIGTERM to the node process to exit QEMU.

[1] https://github.com/emscripten-core/emscripten/issues/26040

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 scripts/run-emscripten.mjs | 66 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 scripts/run-emscripten.mjs

diff --git a/scripts/run-emscripten.mjs b/scripts/run-emscripten.mjs
new file mode 100644
index 0000000000..330e31cfe3
--- /dev/null
+++ b/scripts/run-emscripten.mjs
@@ -0,0 +1,66 @@
+#!/usr/bin/env node
+
+import path from 'node:path';
+import { parseArgs } from "node:util";
+
+function help() {
+  console.log(`Usage: run-emscripten.mjs [--preload FILE] [script.js] -- [arguments]
+
+Options:
+  --preload FILE: Load the package created by Emscripten's file_packager.py`);
+}
+
+const { values, positionals } = parseArgs({
+  allowPositionals: true,
+  options: {
+    'preload': { type: 'string' },
+    'help': { type: 'boolean' },
+  },
+})
+if (values.help) {
+  help();
+  process.exit(0);
+}
+const preload = values.preload;
+const moduleFile = positionals[0];
+const moduleArgs = positionals.slice(1);
+if ((!moduleFile) || (!moduleFile.match(/.*\.m?js$/))) {
+  console.error("module JS file must be specified as the first argument");
+  help();
+  process.exit(1);
+}
+
+const targetModule = await import(path.resolve(moduleFile));
+let preloadModule;
+if (preload) preloadModule = await import(path.resolve(preload));
+
+var Module = {
+  preRun: [],
+  arguments: moduleArgs,
+  mainScriptUrlOrBlob: path.resolve(moduleFile),
+};
+Module["preRun"].push((Module) => {
+  const decoder = new TextDecoder('utf-8');
+  Module.TTY.default_tty_ops.put_char = (tty, val) => {
+    process.stdout.write(decoder.decode(new Uint8Array([val])));
+  }
+  Module.TTY.default_tty1_ops.put_char = (tty, val) => {
+    process.stderr.write(decoder.decode(new Uint8Array([val])));
+  }
+});
+if (preloadModule) preloadModule.default(Module);
+
+if (process.stdin.isTTY) {
+  process.stdin.setRawMode(true);
+}
+function restoreTTY() {
+  if (process.stdin.isTTY) {
+    process.stdin.setRawMode(false);
+  }
+  process.exit(0);
+}
+process.on('exit', restoreTTY);
+process.on('SIGINT', restoreTTY);
+process.on('SIGTERM', restoreTTY);
+
+await targetModule.default(Module);
-- 
2.43.0


