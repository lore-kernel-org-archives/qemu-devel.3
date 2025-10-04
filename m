Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298AECAC5BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wVS-0002VI-JH; Sat, 04 Oct 2025 03:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wUe-0001eI-CX
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:15:48 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wUc-0005MX-EL
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:15:48 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e6c8bc46eso18464535e9.3
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562144; x=1760166944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zBqOIBzEwsKR+1wO6ks/lkspgjnzsfbGz5FmRHKZ/7A=;
 b=znTtGCmSn6BcOn7smBx92C/vObqg1x4rEzrKjDvnlWP+oGeEzNV1nmQrUg5t3KFKlG
 jPnmMlQuOZSU3rL7OvNaCT77Z++FopoYenoG6DI4nVddrlnTIjI1jshIVeDncX9FN2ck
 KZ3QVsWa1v7szvXPZ8/jphSg5Ki0HJh5y6csZiCAGbFrqidPo6tkwICr1e8dnHCRkeUF
 9uFK8+F58UOLAusKD2IYGOfyMC5uHf4uJ7zjkldRhWRHnY0adnZ1m72rQSPIkbHavF3p
 +R8rW9NQJOVfSQ3ZFmcdcOBP04dq52FSj6el6VkF5ZQ+7neWEvHT2jS/EuoDnsdZ4Bxu
 jTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562144; x=1760166944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zBqOIBzEwsKR+1wO6ks/lkspgjnzsfbGz5FmRHKZ/7A=;
 b=wN3+ZaUC/BRFRh1fTtFz2jLTRAmMbbT4l0GJd6ViZaR8pa4SSwPLibxL6QRH+P4gTJ
 s4cVdzNrCNeB2qLa+bG+YLGKZRRx55pTvRky7rQnXk3DWTbZRC3Q4jYDSOy9UHCxexGp
 uTeVuT6DVyJ5n2Uaus4+Ig7WlTs6ejveasAnLU3BqkGbtB8JXGjLtWKw+f7PkTX5/VGH
 1wWU+DSTuaCv4g/IoR18HL8mQinLr3d7yTCopXRYwmrNiOHf5fw11Q/f+E9e12XwR5/Q
 ma1WN+0zTF/svHzvUlyCfujMpjDHQeTufS0+2rOuVW+L7mhqOzivRAFd8hNEs/PliICF
 MLjQ==
X-Gm-Message-State: AOJu0YyhiA/HEFwI6CQ2jdf2U7Qp8K3h3Za48QdiohRVGS6amcS1Kebb
 Odt96JtFeXRp1Ar1sfNTotkbkBsLnhxkrruHDVbwOdQ5mVXDYhArASeblfMuIw7YV4yMEFz6g2v
 Q/IZD0tZOfg==
X-Gm-Gg: ASbGncvHitqFD0Sve3X4MAFu4R6ozr9UCBcIQWoIelXLvyIxEZNcPJTqW6GVQ/rJ+wE
 AeBzLevGM8JtgSoUUwypTOfcRd1AWrwroFbjsckxKGKBbdH5mQ/usv/kZS+xRUjjOfV9Xj/7LE0
 55XQZdKjuycsM1W5AqNdO+GEO+NJCJC3IpgZd8y96nMRFmijSO5n7/wakwkY9gNbF6N+Dm/SAfZ
 6I5k9EMjjF1qxMJqYFZMQRF34eOpvLWg6hzLlqxIKSxfEmFjJ1ax0Xr1GRGgvrS8M/kS7fGjkdm
 fhlnqrp98rLW+ZpjMqv/zhVr3E2Q6rEHHRvcYiQF3ihlsQSNSWZiIfP9vZ37Kr2MNa3iNYTPBxi
 uwuz6Kb67K/swvNdHvEATx24lOhWzL2qQ6Gz1042sN637swpMqn1AqCDFACTEQxqWaQyryfkjrE
 gIRQA3kMu9Vt+rUcd6eb9HRmqXw91IQNSjiqk=
X-Google-Smtp-Source: AGHT+IFelW1btsyUqzfrYGasVGTBu5QoLMXErbuSJpBDrS+JKz4glTtTNY22dLLSLcdlWG0xuAjWgQ==
X-Received: by 2002:a05:600c:c162:b0:46e:5100:326e with SMTP id
 5b1f17b1804b1-46e711440bemr35354825e9.23.1759562143985; 
 Sat, 04 Oct 2025 00:15:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619b8343sm161223655e9.2.2025.10.04.00.15.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:15:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/41] system/physmem: Un-inline
 cpu_physical_memory_set_dirty_flag()
Date: Sat,  4 Oct 2025 09:12:59 +0200
Message-ID: <20251004071307.37521-34-philmd@linaro.org>
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
Message-Id: <20251001175448.18933-11-philmd@linaro.org>
---
 include/system/ram_addr.h | 19 +------------------
 system/physmem.c          | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index 2dcca260b2b..81d26eb1492 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -150,24 +150,7 @@ uint8_t cpu_physical_memory_range_includes_clean(ram_addr_t start,
                                                  ram_addr_t length,
                                                  uint8_t mask);
 
-static inline void cpu_physical_memory_set_dirty_flag(ram_addr_t addr,
-                                                      unsigned client)
-{
-    unsigned long page, idx, offset;
-    DirtyMemoryBlocks *blocks;
-
-    assert(client < DIRTY_MEMORY_NUM);
-
-    page = addr >> TARGET_PAGE_BITS;
-    idx = page / DIRTY_MEMORY_BLOCK_SIZE;
-    offset = page % DIRTY_MEMORY_BLOCK_SIZE;
-
-    RCU_READ_LOCK_GUARD();
-
-    blocks = qatomic_rcu_read(&ram_list.dirty_memory[client]);
-
-    set_bit_atomic(offset, blocks->blocks[idx]);
-}
+void cpu_physical_memory_set_dirty_flag(ram_addr_t addr, unsigned client);
 
 static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
                                                        ram_addr_t length,
diff --git a/system/physmem.c b/system/physmem.c
index 2667f289044..96d23630a12 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1014,6 +1014,24 @@ uint8_t cpu_physical_memory_range_includes_clean(ram_addr_t start,
     return ret;
 }
 
+void cpu_physical_memory_set_dirty_flag(ram_addr_t addr, unsigned client)
+{
+    unsigned long page, idx, offset;
+    DirtyMemoryBlocks *blocks;
+
+    assert(client < DIRTY_MEMORY_NUM);
+
+    page = addr >> TARGET_PAGE_BITS;
+    idx = page / DIRTY_MEMORY_BLOCK_SIZE;
+    offset = page % DIRTY_MEMORY_BLOCK_SIZE;
+
+    RCU_READ_LOCK_GUARD();
+
+    blocks = qatomic_rcu_read(&ram_list.dirty_memory[client]);
+
+    set_bit_atomic(offset, blocks->blocks[idx]);
+}
+
 /* Note: start and end must be within the same ram block.  */
 bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
                                               ram_addr_t length,
-- 
2.51.0


