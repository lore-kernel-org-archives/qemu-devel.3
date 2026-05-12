Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BF9CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgX7-0002R5-8g; Tue, 12 May 2026 02:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgWq-0001mF-6L
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:23:46 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgWl-0004yC-Og
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:23:38 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso46665415e9.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778567011; x=1779171811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xRX/ta5VpmlOxxpOp5cKBpx5aszP815FlNSfn+k5m6A=;
 b=AKxdGeSQ7/xsJW/ekoV8GWEyXh9GoCI87OrQgsUBYzeBmOlDDxiqcjFzMHROsUfsbn
 ngdzyHl3f6mw/ggt7fIV6wy5cTe3Srkvhw2eyP9wSKrf1Beub+2/APDTnQb90zzxLjvr
 M+WkqOIvif8YIHrUoyzXaA/Ogo1/RFNZ6/Rzbd4eWFwMgs7H1pLIEivQ9KHT5Ku+GVQX
 ijqCG5WXU3KZ7k6OajbNQ+K+BUbM+1g3BzIbGKAHQdwftrN1yOePGMNpXY9zINn0ROUg
 f4lYrsReBicBfokBZdqKx3i/kwlsEEswjSR98xNgpjQHITh9IIYWOd3jz7UPpqv/AK59
 2WCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567011; x=1779171811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xRX/ta5VpmlOxxpOp5cKBpx5aszP815FlNSfn+k5m6A=;
 b=KQ1OY/+DFiMcM3u6NYcHuDo0PzBs9DLaQonsWMAd4xsgR2j/9Vk1QCT/qGYjwRhFX3
 gaJ32yywUACBYj7wGi6lJocUxY4hwTqVilHa1/8q3sL/TeI0+zS7u/sHN+ncBT/hxkBP
 RqHCWnZ+Ermgznv8nTj0UB2KQ59yfLaNsmS5faTZpnGY7ImhYnS59aJGZw1auYjnRxzk
 wY5dje6VBrvHXKL1BY9CrnkHiSMOZ64oBRbEySxgcH4gpOb/CYrdIHlWpUumRnDJPhdE
 6839xVVIM1fncsRxdXaswJpRQVHAwNQ/v4+prcTiZrJpS+XgP6+fiLmqN9y6v0SY26TK
 CjPQ==
X-Gm-Message-State: AOJu0YwnXXA4LgoSaSFnEte/3uR3JoZkvn3un5rZUjs9QuoOn+zOskMn
 4WthrLhjSZFQD0JFCHDQKv2lugUoVV6L69jvCNKy5O8IpV2qGAyohUj4GAd3aDbXPjU6Q1ksEB8
 vOmrFCpI=
X-Gm-Gg: Acq92OH3sY3b4fd1zfcK2+oomek6txEbYDbtqYal0rNR0ntnapQuW3wtqsWB0LlNtWj
 mIrhMNlZt2cz73JT9FNAJXAp3s/7ZpX2i+1EcR+PvsHDeuY7+bzfXjsggPHTbWUUXMzSp+J7KOU
 3Oj1gJ79Lie/JBcFQkgPlmHL5QxjKg7HfgS591DE66TH2eS/mPvHgtK2s04HXarETBT0EoaG8Ic
 IZmJM8ojf5gdcNseoIKoZzPrA6ajfWyocefQcH8r6/RNsToOxxJeq604x/7UeeO1Kvd+Tk0hAJX
 zlah23B5qsVvu1zOfawG1VwcjjH7Fs+B62NoCWL+CWUfgGn1KUGGrXORf+g5vtOCi5kn9qHKoR2
 BUSCo1WvbtJwcjp8qKd+EQX1gWIFPigu1HQ2d6TTgcpnZj7JhJsOzVkEz5Y5tgYtFOLgUw8QcFg
 AlLnwEP0fuupyYMXrnVPD5CMK00O+wFBAJ7168mStrhScdxj5CS0Fzx76QeoSfJLlLiRkFJcu+
X-Received: by 2002:a05:600c:8b06:b0:485:4388:3492 with SMTP id
 5b1f17b1804b1-48e51e223ccmr455451775e9.11.1778567010882; 
 Mon, 11 May 2026 23:23:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e9052c7dcsm27638575e9.2.2026.05.11.23.23.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:23:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/41] target/x86: Make get_phys_page_attrs_debug handle
 non-page-aligned addrs
Date: Tue, 12 May 2026 08:21:16 +0200
Message-ID: <20260512062142.67998-16-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
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

From: Peter Maydell <peter.maydell@linaro.org>

Currently our implementations of SysemuCPUOps::get_phys_page_debug
and SysemuCPUOps::get_phys_page_attrs_debug are a mix of "accepts a
non-page-aligned virtual address and returns the corresponding
non-page-aligned physical address" and "only returns a page-aligned
physical address".  This is awkward for callsites, which in practice
all want the physical address for an arbitrary virtual address and
have to work around the possibility of getting a page-aligned
address, and it doesn't account for protection being possibly on a
sub-page-sized granularity.  We want to standardize on the
implementation having to handle non-page-aligned addresses.

For x86 this is simple: we just need to stop rounding down the
input address to a TARGET_PAGE boundary when calculating the
result to return.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260417173105.1648172-6-peter.maydell@linaro.org
Message-ID: <20260430093810.2762539-7-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index c397a6fde5a..108b02396de 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -372,7 +372,7 @@ hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
 out:
 #endif
     pte &= PG_ADDRESS_MASK & ~(page_size - 1);
-    page_offset = (addr & TARGET_PAGE_MASK) & (page_size - 1);
+    page_offset = addr & (page_size - 1);
     return pte | page_offset;
 }
 
-- 
2.53.0


