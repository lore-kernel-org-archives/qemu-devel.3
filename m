Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D82BD637CF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 01:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBOTf-0005AH-11; Wed, 13 Nov 2024 20:16:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBOT8-0002lZ-Qv
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:16:27 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBOT5-00033V-Hk
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:16:22 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-432d9b8558aso1338715e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 17:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731546976; x=1732151776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ziBtbUpyHfOZqiArsxZ9RJYwzJ+JBpYBES4OJcXpO28=;
 b=b9V29geIA63RWvK70AshU6nqkTu5Aao0j9jkH0Anqjh6sXLct2VVw2a6v9twfyywvd
 aoHLgmBkFK772VmW8Q4mtufQ7ZCnAom42IBTUc6ZpNt6hv39C7gfgt8/j/VltrxsquKK
 1cstdhG9/s7CK64RWmieqA7H1hVCoqk0IVZQggvLqpKXS40YNxHzZcajQV+9i1+0vI9/
 lcHNU5DI77Bz/7urLYpntH49vXCoHbulev5AcI5pa0vhVPRoZH6Iy5TxhRR+lV4H9AX8
 2Y5izbohH6JdJieVj+onA5KRolW5dktWhQnTNllJ9Z3+Nk0oHSA+rxoozGadXrwapS9g
 0Oew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731546976; x=1732151776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ziBtbUpyHfOZqiArsxZ9RJYwzJ+JBpYBES4OJcXpO28=;
 b=s0am7bK9cIU1FidyVDIKkFmYnx9K3Ezq4tCgbidPFzCyNWYSDb5I77RrdEHjV1T38A
 bvRnoKv+de9Jwn1mpfLRR0DPjZ+2sZ+LCu1OFiOl4dmOY1DH38h4PqRBQUhij9ig2nTi
 OQsAFpAHsVZcCsxZr1mb9HVCeB78Zs7pB9lui/V377W3GXNfFlE9dJ1c/clChEkRkZKI
 5biuenCKFgHUUSzeM4i5qYkf1B+/70SGoyhX1KuXnOV3LwFku1Rusvfw/qn9Ev98VQWL
 FfJ8KJ5G97YVQukU9QBMbLdxx5Tmw8LG7SovErVgXnPDiuBr/kR+pyFjJwCdDdfry+C/
 Gc5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBzwhuFlFhqjwuy4pqEIVM6lBzbagPa9ppaw4mhY89n5VxodQOIRyIX9I15X9O1sgQ9BjshDRPuKoO@nongnu.org
X-Gm-Message-State: AOJu0YzG/NdtL5u7nkj77RWIrBbk4sMzOBZU6ZlQ+FiUXewlSz0eFY13
 sdby2l3icPIyupqZJpuvWsb29o761RsqqXZqjAsVLtYRf0GSi709C28cn4pFy0o=
X-Google-Smtp-Source: AGHT+IFG/ZF691knJltVBevXFTBqGvTEtAKOLukeJC55OBRtxqlY2UQOjoHdG6QCpoUL0VTdcMqiXw==
X-Received: by 2002:a5d:47a8:0:b0:381:f443:21c6 with SMTP id
 ffacd0b85a97d-38213f80149mr1345659f8f.0.1731546976466; 
 Wed, 13 Nov 2024 17:16:16 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.238])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed97db25sm19856743f8f.41.2024.11.13.17.16.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Nov 2024 17:16:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 23/24] exec/memory: Move qemu_map_ram_ptr() declaration to
 'exec/ram_addr.h'
Date: Thu, 14 Nov 2024 02:13:08 +0100
Message-ID: <20241114011310.3615-24-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114011310.3615-1-philmd@linaro.org>
References: <20241114011310.3615-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/memory.h   | 2 +-
 include/exec/ram_addr.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 9458e2801d..58faa3eb08 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -28,6 +28,7 @@
 #include "qemu/notify.h"
 #include "qom/object.h"
 #include "qemu/rcu.h"
+#include "exec/ram_addr.h"
 
 #define RAM_ADDR_INVALID (~(ram_addr_t)0)
 
@@ -2973,7 +2974,6 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
                                    MemTxAttrs attrs, void *buf,
                                    hwaddr len, hwaddr addr1, hwaddr l,
                                    MemoryRegion *mr);
-void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
 
 /* Internal functions, part of the implementation of address_space_read_cached
  * and address_space_write_cached.  */
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index e0620ddb03..c4f220ae93 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -73,6 +73,7 @@ void qemu_ram_set_migratable(RAMBlock *rb);
 void qemu_ram_unset_migratable(RAMBlock *rb);
 bool qemu_ram_is_named_file(RAMBlock *rb);
 int qemu_ram_get_fd(RAMBlock *rb);
+void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
 
 size_t qemu_ram_pagesize(RAMBlock *block);
 size_t qemu_ram_pagesize_largest(void);
-- 
2.45.2


