Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A353CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wVK-0002UZ-0X; Sat, 04 Oct 2025 03:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wUV-0001Up-G0
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:15:42 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wUT-0005Lz-IJ
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:15:39 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e326e4e99so21280075e9.1
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562135; x=1760166935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0LIrYD/1mTQhCHHnRvCwr2f81Y9HY6EA2Pn1hL7pe5M=;
 b=dPfSkZ/wFOMk7PfBgq4dmODHq6nh82/sZeWXdXTTH2rqjAlxEtpew4BnvdpxSfwIPa
 n8M2pNFzulF6/JzTvOKeFW0mSLW6oYj0xVdzETsbK/rrEtJpoAmjuatnxMPXsIaLeARB
 ORmZSPiU2YnLZ00h20NEKyBItt9A/o55KQTWV6qaAvQGlu4tHHrL9/5xl+xHI3oSVHcI
 skzIN+OKbiWD6wFDiOg45cC/A2cLqdm2lLZWy0rNYFSWjTAwGGt1WHuPnGw5URNz8+2a
 hGFYp8MWIBZmEGnKAK+BWwR0V5h650WvKC6jOLULUrFrMR30XltdPHwXGresS8yhaiJj
 7sQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562135; x=1760166935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0LIrYD/1mTQhCHHnRvCwr2f81Y9HY6EA2Pn1hL7pe5M=;
 b=LUaXVIOjGIXNdblj949eO+AE+F7CKyj7MN2dQvOhyz675KDF4AKWJlRBoqOp01oTGv
 zmKvGxkEzKqCRRWNxoV/TtYLsaJs7KnL+Yg4Y7Geq4FAG40PdGPDQUF/uOCzB17zyRuQ
 NFcvlNEhf49uhfBIVzBgquCiOm0/4vdESU8Tntd5vdy5FoslRk+HNGRQboRnFWOqgZD2
 951nhXQDYWqKqhpmjPcdwY4sBpcuvFbABp4arZBq6zuBfrw5uXyxTXzNmq1x1pzrbOwm
 lNNAk9R2b3aHIgYOAWYOJiQtf/c8l2LxJq7KJ7x7Gl7iyT+jMgOyh6OSKMiYOGxiLxeO
 nsAw==
X-Gm-Message-State: AOJu0YyNVVZRrYt0CCdVLWMMJxBTUxJ2A9/mEcGPTVGF9CL7J/SSLRM3
 BV8HzpXksp2qdPahswO0CZuNJ26sOZiFUjbIW2pEaHSILoncTkH4Po9y4WVBMtxX5vQQb6Z1O+L
 He3Q3t/tkwg==
X-Gm-Gg: ASbGncuH4DU/Nq1JdX869DP1xY1ud8xE8rSIk3t9IcMi9Wyifu4SfrWSsTz0/C9UFah
 kxOxhbe9/rMEOSAntkHx96US16fHHZD0vljaEx7fqzHiii7zqBw4PnEY9PdKkAfChjItztaVZre
 TUjVCtKZ5ckhaESdbgv6Fw7/7ojatJuQD+8272jopaNmVnd7tMVhY3Y843fzMuvKQuzd+srRbjK
 HbM4I4DjE1m9v1nqr/4WE94ciCT3kBCJ3yYhao7mYnqQOXNV1mbEsBeaDgrzIrBJQJmwA2EJUQ9
 9lprKgDj6jsx8EVHOOHloBcI07OGAnq7oBIHwPwiPT5KVt1wzfKRUizoeR7OKRh1M941dvMYP4u
 wF8HS/HPvOeZpEBzoOKbmqkh43P1N14RPHZNVCVt61p1C/betg5Dy9wXPt2/TqjndKgKTdjcNMN
 cRK5rHNNgZc8i12CrCTkdM4L+G
X-Google-Smtp-Source: AGHT+IG+2YMs9EwrH/OmaWriMjbslMnC6/qV1qQxy6EY9njGU9yE+qGVZmjJcp1W9cDQEe+1C15wAg==
X-Received: by 2002:a05:600c:1d05:b0:46e:477a:f3e3 with SMTP id
 5b1f17b1804b1-46e70cb75c3mr38146045e9.18.1759562135002; 
 Sat, 04 Oct 2025 00:15:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e72374ac5sm71054795e9.18.2025.10.04.00.15.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:15:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/41] system/physmem: Un-inline cpu_physical_memory_is_clean()
Date: Sat,  4 Oct 2025 09:12:57 +0200
Message-ID: <20251004071307.37521-32-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Avoid maintaining large functions in header, rely on the
linker to optimize at linking time.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251001175448.18933-9-philmd@linaro.org>
---
 include/system/ram_addr.h | 9 +--------
 system/physmem.c          | 9 +++++++++
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index f8a307d1a3d..cdf25c315be 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -183,14 +183,7 @@ static inline bool cpu_physical_memory_all_dirty(ram_addr_t start,
 
 bool cpu_physical_memory_get_dirty_flag(ram_addr_t addr, unsigned client);
 
-static inline bool cpu_physical_memory_is_clean(ram_addr_t addr)
-{
-    bool vga = cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_VGA);
-    bool code = cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_CODE);
-    bool migration =
-        cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_MIGRATION);
-    return !(vga && code && migration);
-}
+bool cpu_physical_memory_is_clean(ram_addr_t addr);
 
 static inline uint8_t cpu_physical_memory_range_includes_clean(ram_addr_t start,
                                                                ram_addr_t length,
diff --git a/system/physmem.c b/system/physmem.c
index a8d201d7048..fb6a7378ff7 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -945,6 +945,15 @@ bool cpu_physical_memory_get_dirty_flag(ram_addr_t addr, unsigned client)
     return physical_memory_get_dirty(addr, 1, client);
 }
 
+bool cpu_physical_memory_is_clean(ram_addr_t addr)
+{
+    bool vga = cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_VGA);
+    bool code = cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_CODE);
+    bool migration =
+        cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_MIGRATION);
+    return !(vga && code && migration);
+}
+
 /* Note: start and end must be within the same ram block.  */
 bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
                                               ram_addr_t length,
-- 
2.51.0


