Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D615EC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 19:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udwHv-0003Zc-KW; Mon, 21 Jul 2025 15:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1udwGv-0002ev-2O
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 15:34:06 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1udwGr-0003VF-5Q
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 15:34:00 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-23694cec0feso43868845ad.2
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 12:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753126435; x=1753731235; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6LQZIHbBuXid8iCd4uQRcE8cD4Q27Dve1/07zd+zCHI=;
 b=HtNmKbh2L3alZlNY5q1TvSEsjhU2dZxNByvSnOu2tJVXeed47aYa8q31sVlugRZx9J
 1gaPfnNeIJBLnxKiwaj/salesiBGjda7SjmfjksbCgsq3pJ6v4HqwgMlBpS9NpjOypmj
 /7BTL5wkrO5EUNd+olc59tfYZ+cn+1AwHQRo/65XJ7YY4dt+K+cjtoIQBaASx9aQkyzh
 thzHZc+r5mXJxRgbodukttHgKlmgMxOQj6jSfSLVBaK5NeQRanzLg0a9ZomAgcczttmt
 inulfjOq13yP9o2GNHpyUXffw2uS1VfSbfiQst1ih/Rg4UNzqyGC0G7WejLr9MH8ad9D
 Fpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753126435; x=1753731235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6LQZIHbBuXid8iCd4uQRcE8cD4Q27Dve1/07zd+zCHI=;
 b=Ogyql0J1B4dUL1PASZJU+6dDg4YaAg3nSrpbQ7or60+iZXKvZZpKkYcCju3zP86Buy
 FaGxt/Sinwu24Yqq4TFB6fNEpOrkQK0lyCQzCpmP1A00IxAeyeSL5Ab8EPhjCUUTPy5u
 FYlqqzer7SKtMvsIZLwvVweo7jcFrr9YR8h44aWaWvrbRBueC8ScGDwhhk6M/9gRC3Kn
 abD6NqzGR7NtmbFiWuyD1psiUsyMKMm77HUCGsEz/WZSLA+cCCbztQgY0Nj488Ofaz8I
 TMrMae4/Wy7aTLaytLBORwng9KdUbG9HII2XVXRNX+Wi6AwXROoPkdqY3zFvLhQkUCgH
 P7Xw==
X-Gm-Message-State: AOJu0Yz4YVIGS93Wq+DuByoiU6V/BxzSBdBCDZX2PbqDr+FpZrIQlW1c
 9wrSzTgb98F0bGajxa5QccXtHySV2kfNus5Ug3CLeoXbUoMYvlMShtjSuVvYd1Up4eUQ5JupOAN
 iqUgH
X-Gm-Gg: ASbGnctaqWJDCmK79hJDU6hoV5XC1nWPJv+KjPWdAaMzaBtGu328NF2SPs9GSWcvQ92
 v+NJiCbYKxuZ8GNwMFGlrOcg2AqLXzODCFsx98ENOeJHk3KAGLhvZJ926QF01on6SfvplSm39EO
 4iuapV0E+jlLAO1rKX6PeJ2M3k3yf4PPxs92acNpGuZfX1cjVRLK9thPHVlQD1ledScu2E2kLbx
 zcQTPbJuSjiKaK6NknHXBFjxX+w8C+wXRgLyu1TBg9TMqjOvIJy5hT5bE51QSzrNv8H7izrRyFb
 3b5oq62Y7IgDWzqthGh2G55HIN7BQy0RX0Pj8qThADtevRiF2gRri5MRxV9kz4wAkANnxQVSgnG
 +Gw2kQBb0SyKsziqqxoRbOw==
X-Google-Smtp-Source: AGHT+IG/azbmMlf7krgDA7Rr1usvx9g/0JbWNNdw5xiQ5QSop8Y0DuGFFAIADfG3PPEcXzThKYfOGw==
X-Received: by 2002:a17:903:2d1:b0:234:d2fb:2d28 with SMTP id
 d9443c01a7336-23e24ec73b2mr344169515ad.2.1753126435455; 
 Mon, 21 Jul 2025 12:33:55 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e4750sm62238685ad.6.2025.07.21.12.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 12:33:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, rowan Hart <rowanbhart@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v2 5/6] contrib/plugins/uftrace_symbols.py
Date: Mon, 21 Jul 2025 12:33:39 -0700
Message-ID: <20250721193340.1059019-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250721193340.1059019-1-pierrick.bouvier@linaro.org>
References: <20250721193340.1059019-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

usage:  contrib/plugins/uftrace_symbols.py \
        --prefix-symbols \
        arm-trusted-firmware/build/qemu/debug/bl1/bl1.elf \
        arm-trusted-firmware/build/qemu/debug/bl2/bl2.elf \
        arm-trusted-firmware/build/qemu/debug/bl31/bl31.elf \
        u-boot/u-boot:0x60000000 \
        u-boot/u-boot.relocated:0x000000023f6b6000 \
        linux/vmlinux

Will generate symbols and memory mapping files for uftrace, allowing to
have an enhanced trace, instead of raw addresses.

It takes a collection of elf files, and automatically find all their
symbols, and generate an ordered memory map based on that.

This script uses the python (native) pyelftools module.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace_symbols.py | 152 +++++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)
 create mode 100755 contrib/plugins/uftrace_symbols.py

diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftrace_symbols.py
new file mode 100755
index 00000000000..b49e03203c8
--- /dev/null
+++ b/contrib/plugins/uftrace_symbols.py
@@ -0,0 +1,152 @@
+#!/usr/bin/env python3
+# -*- coding: utf-8 -*-
+#
+# Create symbols and mapping files for uftrace.
+#
+# Copyright 2025 Linaro Ltd
+# Author: Pierrick Bouvier <pierrick.bouvier@linaro.org>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import argparse
+import elftools # pip install pyelftools
+import os
+
+from elftools.elf.elffile import ELFFile
+from elftools.elf.sections import SymbolTableSection
+
+def elf_func_symbols(elf):
+    symbol_tables = [(idx, s) for idx, s in enumerate(elf.iter_sections())
+                  if isinstance(s, SymbolTableSection)]
+    symbols = []
+    for _, section in symbol_tables:
+        for _, symbol in enumerate(section.iter_symbols()):
+            if symbol_size(symbol) == 0:
+                continue
+            type = symbol['st_info']['type']
+            if type == 'STT_FUNC' or type == 'STT_NOTYPE':
+                symbols.append(symbol)
+    symbols.sort(key = lambda x: symbol_addr(x))
+    return symbols
+
+def symbol_size(symbol):
+    return symbol['st_size']
+
+def symbol_addr(symbol):
+    addr = symbol['st_value']
+    # clamp addr to 48 bits, like uftrace entries
+    return addr & 0xffffffffffff
+
+def symbol_name(symbol):
+    return symbol.name
+
+class BinaryFile:
+    def __init__(self, path, map_offset):
+        self.fullpath = os.path.realpath(path)
+        self.map_offset = map_offset
+        with open(path, 'rb') as f:
+            self.elf = ELFFile(f)
+            self.symbols = elf_func_symbols(self.elf)
+
+    def path(self):
+        return self.fullpath
+
+    def addr_start(self):
+        return self.map_offset
+
+    def addr_end(self):
+        last_sym = self.symbols[-1]
+        return symbol_addr(last_sym) + symbol_size(last_sym) + self.map_offset
+
+    def generate_symbol_file(self, prefix_symbols):
+        binary_name = os.path.basename(self.fullpath)
+        sym_file_path = f'./uftrace.data/{binary_name}.sym'
+        print(f'{sym_file_path} ({len(self.symbols)} symbols)')
+        with open(sym_file_path, 'w') as sym_file:
+            # print hexadecimal addresses on 48 bits
+            addrx = "0>12x"
+            for s in self.symbols:
+                addr = symbol_addr(s)
+                addr = f'{addr:{addrx}}'
+                size = f'{symbol_size(s):{addrx}}'
+                name = symbol_name(s)
+                if prefix_symbols:
+                    name = f'{binary_name}:{name}'
+                print(addr, size, 'T', name, file=sym_file)
+
+def parse_parameter(p):
+    s = p.split(":")
+    path = s[0]
+    if len(s) == 1:
+        return path, 0
+    if len(s) > 2:
+        raise ValueError('only one offset can be set')
+    offset = s[1]
+    if not offset.startswith('0x'):
+        err = f'offset "{offset}" is not an hexadecimal constant. '
+        err += 'It should starts with "0x".'
+        raise ValueError(err)
+    offset = int(offset, 16)
+    return path, offset
+
+def is_from_user_mode(map_file_path):
+    if os.path.exists(map_file_path):
+        with open(map_file_path, 'r') as map_file:
+            if not map_file.readline().startswith('# map stack on'):
+                return True
+    return False
+
+def generate_map(binaries):
+    map_file_path = './uftrace.data/sid-0.map'
+
+    if is_from_user_mode(map_file_path):
+        print(f'do not overwrite {map_file_path} generated from qemu-user')
+        return
+
+    mappings = []
+
+    # print hexadecimal addresses on 48 bits
+    addrx = "0>12x"
+
+    mappings += ['# map stack on highest address possible, to prevent uftrace']
+    mappings += ['# from considering any kernel address']
+    mappings += ['ffffffffffff-ffffffffffff rw-p 00000000 00:00 0 [stack]']
+
+    for b in binaries:
+        m = f'{b.addr_start():{addrx}}-{b.addr_end():{addrx}}'
+        m += f' r--p 00000000 00:00 0 {b.path()}'
+        mappings.append(m)
+
+    with open(map_file_path, 'w') as map_file:
+        print('\n'.join(mappings), file=map_file)
+    print(f'{map_file_path}')
+    print('\n'.join(mappings))
+
+def main():
+    parser = argparse.ArgumentParser(description=
+                                     'generate symbol files for uftrace')
+    parser.add_argument('elf_file', nargs='+',
+                        help='path to an ELF file. '
+                        'Use /path/to/file:0xdeadbeef to add a mapping offset.')
+    parser.add_argument('--prefix-symbols',
+                        help='prepend binary name to symbols',
+                        action=argparse.BooleanOptionalAction)
+    args = parser.parse_args()
+
+    if not os.path.exists('./uftrace.data'):
+        os.mkdir('./uftrace.data')
+
+    binaries = []
+    for file in args.elf_file:
+        path, offset = parse_parameter(file)
+        b = BinaryFile(path, offset)
+        binaries.append(b)
+    binaries.sort(key = lambda b: b.addr_end());
+
+    for b in binaries:
+        b.generate_symbol_file(args.prefix_symbols)
+
+    generate_map(binaries)
+
+if __name__ == '__main__':
+    main()
-- 
2.47.2


