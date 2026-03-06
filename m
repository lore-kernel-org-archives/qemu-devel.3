Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F5CF513F6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 05:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyNXn-0007XI-3g; Fri, 06 Mar 2026 00:16:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyNXj-0007X0-1F
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 00:16:07 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyNXg-0001Lo-MJ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 00:16:06 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c737d3a51bdso1004140a12.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 21:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772774162; x=1773378962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dsBT40L5Kio9aj+ttGst+u5bikeAKdLXfj7F/2y97LU=;
 b=aANwoJhopuqUw0v9wGiJa6onrpYsS8mebCd2FPya1tXfpfEK6CbOM/83Ozu+FT2Bch
 ISsIs5VGjpgDBqV0T+9l0p5gVWdyG0Oo4VC5fjPfSjSvnmlG28NSu1OTkYG2Sv+ilX2c
 0CV822LSinjzL1sf9oJfSkw8mZH2LbfZPW7/Fb9TSm5q4VXCRNIqqnNqmUU9+eUNjVUr
 aOX6DZmMG/Si1W52HNjLpEx/tCOcabWIOEmu5qc2GFMlfcd+URptvCxJDJ4H5gM5dTuy
 2C9m3nGUnfZ1WxsGKKUaEo2IhEnHd09WyBBULlSkB/jdYqDL6X4w045AKhmFwdJZENkp
 l1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772774162; x=1773378962;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dsBT40L5Kio9aj+ttGst+u5bikeAKdLXfj7F/2y97LU=;
 b=KvhD3WFLXBHHEjKBEMLfjZ4urU4wgF2OhwEpG13ZBb1Lgi9DBIIUe1z/5gVmHPnqAM
 NMc9Fej9vNtJo4X4mzS2MLkfgV1iHUB4vBthBUeo/on0NUKqLDJTj4KRtTuDHWktcJ9y
 IoQr79Ao1RPbmrdfGqxhY6ejx6bYSHDUXXIIanGsVPBK81foa9K0BWuj0/5STJkHl4A7
 hQJMHSwLW856yNg8Bfmb8qRq1E/S1mDjo+9oWI3fegnHxTwKUk97oUe1MRronvv397az
 MpW/hTi8cipkgzpszlkUhsEg7zhMXJrjUtxBN4rs7AlpMrvmQMLCVdafftVNk2odv4w3
 IB9g==
X-Gm-Message-State: AOJu0Yw4aYWlSN2WGe9VvdDvBX9H6AaGmSgGHHlkrzNPp151iUJqjVGA
 b9ayKFPCCeqDBkpDJHy49swEYzalIifjiLMVElOe9nDeMLndHcDJCBnFaqNhAFsKkZX660qpoMS
 WTk7y
X-Gm-Gg: ATEYQzwDyYL62DTRlrh8vb9FXOf+ucOuIfnpWvwrof5Ad3zkz09fDXWcHl9LPWM8nJn
 j8f7acVdsYirLf6epaR03kUyMvOufl8Q4i8RtkmOOzDgdvZquAEqUgBpizC226o3DHSLOBvLwNy
 q/vde6knEHuiUj4nbddPTWWu+XgLx0zxAWHhWPjh/n8fdhGuKby7TFzb+5CcTiC5wulSrSPrObi
 g4jf2DnGKg7vgJQMEDX+sak1VRxuNFJh5zLEh+AnszBa67qFhjG8/+JFodMYa/0RLVICfh0WXL2
 aS6g4kvEa9gOP0pgpikacyY1C6wj7zsSW8fEgsLopo22LpGtP4pXSxsU8w7vvqdcqD4egDQq0LS
 SpXU5YYJaDZZFAJeezKsoX+/2/DdLKsrObmnLztwss492DsfScoU5jPtrtpEk5jo+8bs2t0+5eJ
 NIb9z7hCh7FRiy2kJ9a6NiwB3cIhsPB4g0Xdn8bVVctByvRGbtOUO1P8tmO26kf3dkv9KWUZKro
 lRh
X-Received: by 2002:a05:6a21:4603:b0:395:7fb:9362 with SMTP id
 adf61e73a8af0-39858fdf098mr1160061637.19.1772774161607; 
 Thu, 05 Mar 2026 21:16:01 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c739e0c9666sm364776a12.14.2026.03.05.21.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 21:16:01 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH] contrib/plugins/uftrace_symbols.py: ignore zero sized symbols
Date: Thu,  5 Mar 2026 21:15:53 -0800
Message-ID: <20260306051553.2778652-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
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

When using llvm-addr2line in replacement of addr2line, it will output
zero sized symbols, which can shadow other binaries depending on where
there location is (happens with arm-trusted-firmware and its different
binaries). Thus, those symbols.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace_symbols.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftrace_symbols.py
index 7d79b81cdec..02d1221228c 100755
--- a/contrib/plugins/uftrace_symbols.py
+++ b/contrib/plugins/uftrace_symbols.py
@@ -45,6 +45,8 @@ def get_symbols(elf_file):
             continue
         addr = int(addr, 16)
         size = int(size, 16)
+        if size == 0:
+            continue
         symbols.append(Symbol(name, addr, size))
     symbols.sort(key = lambda x: x.addr)
     return symbols
-- 
2.47.3


