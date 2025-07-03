Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A0EC83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNo6-0005TF-Ap; Thu, 03 Jul 2025 13:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNo1-0005Sg-Ci
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:33:05 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNnz-0007nM-KW
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:33:05 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a575a988f9so45526f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751563981; x=1752168781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zSMALvjOcbwDFxdBZhQQT9TGvgwhtr1LjNKTHw1swdk=;
 b=gpYej75Xj1bS1X8weRzAo481Z48mh+BE3AxKqHy2MG7YckZTgYrdAZKIiVUAUf/F+p
 9CeV2WqxH23qdJ1WyVvNLdtnSK7jf3ple7lUQvbaPnIXEMBDzEXjR29AzkLkHQ/jzwY4
 NbYMwywtc8TmHr6kK6nANSiv9RXuE9ixIDfnM25N2Fxjsj+IoA02fXxVBIsLvUJHAcag
 JepanPSgk7PP8HyP8JjEL0gLqaLNwAUPoLeqFxgjYmH9a0MaPkBKXTxqR2XGEcZkh5AM
 lz3c+vSJtq3MaVopCa/j2CDa1/Mrr/Y/bbz4cPlr3oiADT3I/Z6YnQLqnQJTpCY+qVXG
 PmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751563981; x=1752168781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zSMALvjOcbwDFxdBZhQQT9TGvgwhtr1LjNKTHw1swdk=;
 b=Dmn4mV+GHO2J+5J7kqqZrw8H90mlW2akDuL8NFA0NjAi3zGKZsLZExrSlJPSy0RbT6
 6yJenvOdD8zbYe3el9Kn5A5leB+dOZm/8FvNGC6A+cP994RG9x0vF5jk9IVn17hVIjl9
 y5avsLax4pENLpwbpTzxl+R/+YP5wrRWqWtW5rn4Ug2pHXk3zFDlJUnedYwkbPQxma2N
 z9bsqkwkNMQd1HgUVPfAhQSxXpRFrD4tKLmVSIqmfAO6iNh1Wcee9rbYmRFwAucmKdKU
 d5Z2MiGP0LgJh+jxTE7Arj2WmSpCF1xyp3SYpRlEy4As7sel4UHW8mugn9r8xDNkCY3E
 O4VA==
X-Gm-Message-State: AOJu0Yzau92vF4o+B19JkQX8Egqohwy6wjgn3UefRQIjmcBZ2npiiZq5
 nkFPmLjwopvPjWRzjyrv3cRoOm8F84YhYMOHmwlgA8UvlZRw3VvMNtI9sZkaJjv2VhBw2zhOC1P
 PgVgbPro=
X-Gm-Gg: ASbGnctQcLcamGPCgf+ef9hNNbr0heiRMbPbnYwx2qbLJuFhIxSRMneP+oFRKAeZUjC
 PxsGQ3/OH80ZROY+O6N/Mp51PK0Sn9PUG6psWK12fT8otmxyTolRtw/Hh8e1bYFWcMDdooypBGj
 31pH2pPP5TqB3qSJbLPLjapA3/0joG5Ld+o2lReL05N5+Kl9kPFer/xpdPP2gHO2qeneTBisXtn
 ocr/4JQA9ihApUIXWwIigDtyB67aZ5CzIKOXufYt8ljTBuivmA+QOTADeCUF81rd7rERuIG9L87
 UNf40I1ADdouTZBZkF6YQwsQ3XsMJRx/uQ2KPb6GMV4TLtzIvsjBsWoLtSNrZEzue2DD/PxZqeI
 pV5mf70kC8H13MOdA07gnN/NGQMTPQtRmrjyX
X-Google-Smtp-Source: AGHT+IGFu80crPNQoEIjjt6dkLl56V2F1tSkb0BEa/Vn6eF8EhrmaihENxnjtBeptWNpVQGwn+pzQA==
X-Received: by 2002:a05:6000:2711:b0:3a5:39be:c926 with SMTP id
 ffacd0b85a97d-3b32ebd78efmr2469546f8f.32.1751563980898; 
 Thu, 03 Jul 2025 10:33:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bea4a9sm31666605e9.37.2025.07.03.10.32.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:33:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PATCH v6 02/39] system/memory: Restrict eventfd dispatch_write() to
 emulators
Date: Thu,  3 Jul 2025 19:32:08 +0200
Message-ID: <20250703173248.44995-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Commit 8c56c1a592b ("memory: emulate ioeventfd") added a !KVM
check because the only accelerator available back then were TCG,
QTest and KVM. Then commit 126e7f78036 ("kvm: require
KVM_CAP_IOEVENTFD and KVM_CAP_IOEVENTFD_ANY_LENGTH") suggested
'!KVM' check should be '(TCG || QTest)'. Later more accelerator
were added. Implement the suggestion as a safety measure, not
dispatching to eventfd when hardware accelerator is used.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/memory.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 76b44b8220f..4f713889a8e 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -25,7 +25,7 @@
 #include "qom/object.h"
 #include "trace.h"
 #include "system/ram_addr.h"
-#include "system/kvm.h"
+#include "system/qtest.h"
 #include "system/runstate.h"
 #include "system/tcg.h"
 #include "qemu/accel.h"
@@ -1530,12 +1530,7 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
 
     adjust_endianness(mr, &data, op);
 
-    /*
-     * FIXME: it's not clear why under KVM the write would be processed
-     * directly, instead of going through eventfd.  This probably should
-     * test "tcg_enabled() || qtest_enabled()", or should just go away.
-     */
-    if (!kvm_enabled() &&
+    if ((tcg_enabled() || qtest_enabled()) &&
         memory_region_dispatch_write_eventfds(mr, addr, data, size, attrs)) {
         return MEMTX_OK;
     }
-- 
2.49.0


