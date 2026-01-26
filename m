Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB09C88E5A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 07:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkGtv-0006Ba-FJ; Mon, 26 Jan 2026 02:20:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGg4-00039d-CQ
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:06:33 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGfu-0004R3-Bl
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:06:20 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c636487ccaeso843629a12.1
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 23:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769411155; x=1770015955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QBiuZHC2ujyOFipmh/6NFwPTzHzb15N2Yq98z1rMyKY=;
 b=GiIJEj9B7HMoskYSCrhOFVzSDCmqGrUD1s0hQJ4QxJ5CkldaUFG0Qsky5LP7o0giya
 Lwv9jsX/nC72hdN8EmFI7FC9t5E4lb/YTPNf5eD9GmPHS60/FtPFLlS/uV9OuMxkFlQ/
 xzvu5THNfd2ukZt5Bz+GzWJEUZTHJWdvwE4mLgIjFF/iEgW0g1pCY7wsEf4fQrBUNlWa
 nnzu289V9aQoCnjaNypv+zu4SZr9XeH4oh8EyAPEdEeJa2YtV4O6B2PLEQTaZ+UqBqMH
 /7EDYIfK1ub7V/WK9nD33th8zl4mZXtS0+dogvp9kqu7eaQsZnxsboUIlyIcZBDo59Wx
 wo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769411155; x=1770015955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QBiuZHC2ujyOFipmh/6NFwPTzHzb15N2Yq98z1rMyKY=;
 b=mWsx0q2hCqb684Ej4no2v3XYnfNK1v1Y/KbZ7dLtDd6+WAcKesX7opk5O4gKt1UVmZ
 Ih4IIzYIW56LfUXOy9h7EyvoHiVmM8CgToBWNxC5f2Fhn1g9ZQGC0ynMAmlqzBXNN634
 Ik84USTcbuKc38ecQqtg2oZ2pBbQZ0FOs7PFZ7RTFL+Xp4DI5NaRv0ZEGya3YYdibgTt
 n14XS1tEZrELXFxjEGiOa2bw75NLSOQR0geXnuK7C1e2tAcGEXsvwPGQdFAUqAykkdj/
 POkeAYoXoOi2kRm06FvU1OQSvfsNruEA9OndSXbZTLvuxrdjgEcbm7EuSyJOmb0WYnEV
 oLYA==
X-Gm-Message-State: AOJu0YwG18Lk+06J1fWuYgiCCHV1bxytehIYZbwY4ustxqaHkuiKwK+x
 Z9/ra1utp6tXsLXZfD3XptTlA46bzfyiCo+cdOZIE+ZQlqFb6Z6+SBV9NNor0eUo
X-Gm-Gg: AZuq6aITd7Vl3nCPt/4KaTxqMNaNtenAzfwfLWZkrDl5+i9ZI8kdntSkGKuqPuhQ2/x
 cjo87FY/NizTkaDZ76BQXTCpOP56zNea7vV3ixzq9xyL3WoPMQT10rtHZhp+qlrsldZfaX0Zo+a
 mScZb4MvSFrf4eavKqeDo80teS08HXTL/JEKYLHnQLXC9KLAtIG9ppEQoITiGSAM4W1JeMNVV9O
 XJYDP9xB5IJpLTUOSwj5quRIafqMDrzU/pAT4p16cFOHkrP9pPLlNwt8kflfN4URSqzMlkKB8/h
 4rAzN8b+NZobDk8Y+ABPn8F3Fm5cJFtWuymtETge0H0q+V1962SAq+XTXsd/AF6BeAahgSx3SCF
 F3LZJIpTZgt2t1TBmznsiSLrhDeFjsdgXHZARYc0PSDTG8m3TnPAAo0We7b41Z2X6EhJf6V/ugD
 eSopeRnYBCz0JaTG59ohYgq9Gm5vrUmx0QMZo2+3zpEA==
X-Received: by 2002:a17:90b:6c3:b0:34a:9d9a:3f67 with SMTP id
 98e67ed59e1d1-353c41a69e3mr3084073a91.33.1769411155173; 
 Sun, 25 Jan 2026 23:05:55 -0800 (PST)
Received: from brahms.. (fp93c00990.tkyc601.ap.nuro.jp. [147.192.9.144])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-823187716ebsm8661487b3a.66.2026.01.25.23.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 23:05:54 -0800 (PST)
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
Subject: [PATCH v4 24/33] tcg/wasm64: Implement instantiation of Wasm binary
Date: Mon, 26 Jan 2026 07:03:37 +0000
Message-ID: <00b8d87b3e0acf00b140a3f60f91c84eeae95b3b.1769407033.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769407033.git.ktokunaga.mail@gmail.com>
References: <cover.1769407033.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x535.google.com
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

instantiate_wasm is a function that instantiates a TB's Wasm binary,
importing the functions as specified by its arguments. Following the header
definition in wasm64/tcg-target.c.inc, QEMU's memory is imported into the
module as "env.memory", and helper functions are imported as "helper.<idx>".

The instantiated Wasm module is imported to QEMU using Emscripten's
"addFunction" feature[1] which returns a function pointer. This allows QEMU
to call this module directly from C code via that pointer.

Since the subarray() method doesn't accept a BigInt value which is used for
the 64bit pointer value, it is converted to a Number (i53) using
bigintToI53Checked method of Emscripten. Although this conversion (64bit to
53bit) drops higher bits, the maximum memory size of the engine
implementations is currently limited to 16GiB[2] so we can assume that the
pointers are within the Number's range.

Note that since FireFox 138, WebAssembly.Module no longer accepts a
SharedArrayBuffer as input [3] as reported by Nicolas Vandeginste in my
fork[4]. This commit ensures that WebAssembly.Module() is passed a
Uint8Array created from the binary data on a SharedArrayBuffer.

[1] https://emscripten.org/docs/porting/connecting_cpp_and_javascript/Interacting-with-code.html#calling-javascript-functions-as-function-pointers-from-c
[2] https://webassembly.github.io/memory64/js-api/#limits
[3] https://bugzilla.mozilla.org/show_bug.cgi?id=1965217
[4] https://github.com/ktock/qemu-wasm/pull/25

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm64.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tcg/wasm64.c b/tcg/wasm64.c
index 895ae062ee..41898ff867 100644
--- a/tcg/wasm64.c
+++ b/tcg/wasm64.c
@@ -23,6 +23,42 @@
 #include "tcg/tcg-ldst.h"
 #include "tcg/helper-info.h"
 #include <ffi.h>
+#include <emscripten.h>
+
+#define EM_JS_PRE(ret, name, args, body...) EM_JS(ret, name, args, body)
+
+#define DEC_PTR(p) bigintToI53Checked(p)
+#define ENC_PTR(p) BigInt(p)
+#if defined(WASM64_MEMORY64_2)
+#define ENC_WASM_TABLE_IDX(i) Number(i)
+#else
+#define ENC_WASM_TABLE_IDX(i) i
+#endif
+
+EM_JS_PRE(void*, instantiate_wasm, (void *wasm_begin,
+                                    int wasm_size,
+                                    void *import_vec_begin,
+                                    int import_vec_size),
+{
+    const memory_v = new DataView(HEAP8.buffer);
+    const wasm = HEAP8.subarray(DEC_PTR(wasm_begin),
+                                DEC_PTR(wasm_begin) + wasm_size);
+    var helper = {};
+    for (var i = 0; i < import_vec_size / 8; i++) {
+        const idx = memory_v.getBigInt64(
+            DEC_PTR(import_vec_begin) + i * 8, true);
+        helper[i] = wasmTable.get(ENC_WASM_TABLE_IDX(idx));
+    }
+    const mod = new WebAssembly.Module(new Uint8Array(wasm));
+    const inst = new WebAssembly.Instance(mod, {
+            "env" : {
+                "memory" : wasmMemory,
+            },
+            "helper" : helper,
+    });
+
+    return ENC_PTR(addFunction(inst.exports.start, 'ii'));
+});
 
 __thread uintptr_t tci_tb_ptr;
 
-- 
2.43.0


