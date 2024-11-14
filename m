Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67491D637CF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 01:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBOS9-00010b-J5; Wed, 13 Nov 2024 20:15:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBOS5-0000ir-Er
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:15:17 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBOS3-0002Oi-Ic
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:15:17 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4316cce103dso1188905e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 17:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731546902; x=1732151702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2hAfsLa5F/wTHTnThKWfes1iOEyMXfbHgC1xYE0xNjQ=;
 b=iMVlTWVyKpfHAhvxo6HbvZo3XEa73a1aJlyby1RrKCRzdX1ycvtezXP7MJ1dtUgsan
 Zc1X9hMhIjJPTUvmvizoRq4A/gStjmkZH68ZoCknj1QpZOUqysBn4DPxQR/PNVFCv0PC
 Qhx/MZ0TgblILs7CyE6qaw2t3maTCO5cY4hUu5+9Sq9VuWFAY8792e6PgQqICwDJvV3J
 OaNDdjxmDxjfmCI9QQJrSZxOBXFP3VBqT3P6MvT2kc6RNFacaAIyPtYrWuPG7O2XJvcv
 kx97TfOm1cky46dsCWHgvbopsS8EH0xTun6tqwP5gi4MjXa4NJeDNDbdkVxT2tjopord
 4Irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731546902; x=1732151702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2hAfsLa5F/wTHTnThKWfes1iOEyMXfbHgC1xYE0xNjQ=;
 b=m3FCBOVZiChiqexEOZZuh8JsIbSYgVuJx5NCnlJiDxr56+I9k1JLs70CcXVgnAoeyl
 vYRVUDb8ZEXx/4PLgo1Fn79UAgiM6iNuM6bx4qNYZy7WX/Ml6d7TB1raM0WtbFFWBCdn
 ozK4Ba/qPNl7UYJ8HkJMGzWMkeZS76Kf2vrTIng4G1+j8l7Q8NaQ/nrsQd1t0nW8rCRF
 r1jqGXpgAY94EJquRdvjvHH6pSyKp9DSKihQwDadxhiPV9aDHyyUAOpiozSHjrJmjRkr
 CPj41Lmyn0G1oF+LH7Z/zaID6huHh34XNeiecNla7l6HFm+tUFclclpWyCqg641XLbsN
 6rtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAkshsJ1HK2mkO8iXP6lYqGaOC6sewgIsTY6z8wynqExD9M5uK8g0Ih4UpJf2eRtoze9TKOu4m6Kdn@nongnu.org
X-Gm-Message-State: AOJu0YxBJdzvdBz4vV334fovrjnEqKOAH4fb3/3isilWy9zncspwZjXn
 HjqfDKyAlsv5YF8TxTRtFCMeE6gR2BjERPK9afN+RGLxgbJyrKXxlL0S9t5eeMM=
X-Google-Smtp-Source: AGHT+IH7RFWsMnakRg5GJlnl5zZr5zJQPCLqZOnOCy/xPwCBs6cxFICDeA4XzSDQuRyqlWzDDXypCA==
X-Received: by 2002:a05:600c:444e:b0:431:52a3:d9d5 with SMTP id
 5b1f17b1804b1-432da6d6676mr3323435e9.0.1731546902007; 
 Wed, 13 Nov 2024 17:15:02 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.238])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac1fbf9sm1377125e9.41.2024.11.13.17.14.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Nov 2024 17:15:00 -0800 (PST)
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
Subject: [PATCH 13/24] exec: Declare tlb_reset_dirty*() in 'exec/cputlb.h'
Date: Thu, 14 Nov 2024 02:12:58 +0100
Message-ID: <20241114011310.3615-14-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114011310.3615-1-philmd@linaro.org>
References: <20241114011310.3615-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Move CPU TLB related methods to "exec/cputlb.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cputlb.h   | 7 +++++++
 include/exec/exec-all.h | 3 ---
 include/exec/ram_addr.h | 1 +
 system/physmem.c        | 1 +
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index ef18642a32..6cac7d530f 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -32,4 +32,11 @@ void tlb_unprotect_code(ram_addr_t ram_addr);
 
 #endif /* CONFIG_TCG */
 
+#ifndef CONFIG_USER_ONLY
+
+void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
+void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
+
+#endif
+
 #endif
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 2e4c4cc4b4..2c06e54387 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -589,9 +589,6 @@ static inline void mmap_lock(void) {}
 static inline void mmap_unlock(void) {}
 #define WITH_MMAP_LOCK_GUARD()
 
-void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
-void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
-
 MemoryRegionSection *
 address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr,
                                   hwaddr *xlat, hwaddr *plen,
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 891c44cf2d..b6d5551549 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -23,6 +23,7 @@
 #include "cpu.h"
 #include "sysemu/xen.h"
 #include "sysemu/tcg.h"
+#include "exec/cputlb.h"
 #include "exec/ramlist.h"
 #include "exec/ramblock.h"
 #include "exec/exec-all.h"
diff --git a/system/physmem.c b/system/physmem.c
index dc1db3a384..3f937a5e58 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -32,6 +32,7 @@
 #endif /* CONFIG_TCG */
 
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "hw/qdev-core.h"
-- 
2.45.2


