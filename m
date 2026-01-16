Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53726D48981
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghrT-0008NE-9U; Fri, 16 Jan 2026 06:19:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghrF-00087d-7Y
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:19:17 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghrD-0005sE-Db
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:19:12 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa9so983550f8f.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768562349; x=1769167149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FJKnxppWAC/n1eSB1d1Olh3eK3qa6g9cnmgeq7kmKnk=;
 b=QrA6FZ04erDB+CuzLIUdrUEMiTf1P3uXjEp35btjIcUG15WAW1p9hCtLYyLBbYfWjw
 DVRqmmfS/DWFeWsplvr5tEk6S/E4xRNGl/43MRNEVus+FIUXDKX+KS5u+ElhezBndnTD
 YFQn2yjMOMq7bPoUkvVB/qxVgv+j493GZupWmZ+BGsdUcGB/Zv6tWnYXew3cJ5B0AxPN
 6C3UDtwNz9Fj+T7ZoLZhAWeDa6sh6jFkmwiVHBL8LAcIyKyVoIeDuTfSduBte72uYtBm
 FBKS0KuHfUyKKRSewZGOXv9PRMpalmRsxE+LJ+Wri2vgPbixTmn7GcwqNkennJ6NZZS5
 OYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562349; x=1769167149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FJKnxppWAC/n1eSB1d1Olh3eK3qa6g9cnmgeq7kmKnk=;
 b=gVr9cqqVbXo2XiOuy6GYgAbm7Uac6+4SEpViOjYr/uDg/wfFyR6pylZQowFfmXiJ06
 fYXR6/qESDpk6bEzM89lvG1PzYs0Zc30G8l9ccrHheJ0BdvTD2sGHuvqkpPplV5i2S8r
 E7oQrCRobtegDyDARZut/a3mdn0FLsFrIwM0FqkeFeV4T/tyo3uB3Iv+yc7G9+YZbmS3
 Tnp25D1nxns7mKLKAwTmsR9Z/cUIhvdGjty+gTF4lFwXZ8R0gvF/slT8Hg1XnsY6oT/g
 13hRqDOWcrZc6N4qqrmtTKd7dZTRuZfakr0pFlFRJ59+yTkPyRoiDBiZGrPB7aivzjfj
 JZ5Q==
X-Gm-Message-State: AOJu0Ywk/0xHvXWC6CWMUiOKP4RYO+rMWRo6I/dXTO9nur1EO0mxzTzT
 KfZq8pFsmm5V77juzD3LNgfqmuq7rI1nMcWvjJSGZ09d6DuoyxWsSjfM+N3O1kH7+u4k6knuwYy
 pLRdd71I=
X-Gm-Gg: AY/fxX60c3RiDKZmCzg2xrBFbF5Bmsk/E+4Tx2Liob/bfHLziWr69G6Y8ka4mGSalBq
 CxpY2J5nFqf1hMQFYq7HYlOrj6DrTmJgJRCFGjgYVJawOdHJfZl7EQbfu9WAozBgI3OnGUl8fqq
 4v7O2vrLl1iWxBurzLfHLzYbgHD/QJX1MvFCUU0LbG9Ntwp+ODUFMMil1SkUdQmRvKmpbvGAUOn
 aLI09QvwKUjZ1cPC73v75zOUpjzvkqqki6lOhdVL7HzDV1rYTaXQ2EkORRAaxuDhi/WgIjMFRu/
 Ucowo2tB+U8AosLHCqg0s/9/i3iCU32rN2sUDYxz4Bg1WvUe1lwZ4N9q5uossWXmuKwqn4xHYYu
 igN7WNI67Hpzr3rAUyLA77KMpjF/b6RUGB+dRaKZ2bGB3GPQrqAnoRmqE6i6PD1MBN5xGf8shts
 eWxERApOvjOZTVf6PukzoCCeH4ydSamlKZO2uZip+8wFfTzJNbiEcYmf3WGck7ar5uCNxsQzM=
X-Received: by 2002:a05:6000:2281:b0:430:f40f:61b9 with SMTP id
 ffacd0b85a97d-4356a024c7amr3136262f8f.4.1768562349435; 
 Fri, 16 Jan 2026 03:19:09 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356999810bsm4690869f8f.40.2026.01.16.03.19.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 03:19:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/30] target/i386/hvf: Use host page alignment in
 ept_emulation_fault()
Date: Fri, 16 Jan 2026 12:17:46 +0100
Message-ID: <20260116111807.36053-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116111807.36053-1-philmd@linaro.org>
References: <20260116111807.36053-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

While on x86 the host page size is fixed to 4KB, it is
better to call qemu_real_host_page_size() for consistency.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20251103101034.59039-3-philmd@linaro.org>
---
 target/i386/hvf/hvf.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 2023a7bfbb0..731cd954630 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -76,7 +76,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/accel.h"
 #include "target/i386/cpu.h"
-#include "exec/target_page.h"
+#include "exec/cpu-common.h"
 
 static Error *invtsc_mig_blocker;
 
@@ -137,9 +137,12 @@ static bool ept_emulation_fault(hvf_slot *slot, uint64_t gpa, uint64_t ept_qual)
 
     if (write && slot) {
         if (slot->flags & HVF_SLOT_LOG) {
-            uint64_t dirty_page_start = gpa & ~(TARGET_PAGE_SIZE - 1u);
+            uintptr_t page_size = qemu_real_host_page_size();
+            intptr_t page_mask = -(intptr_t)page_size;
+            uint64_t dirty_page_start = gpa & page_mask;
+
             memory_region_set_dirty(slot->region, gpa - slot->start, 1);
-            hv_vm_protect(dirty_page_start, TARGET_PAGE_SIZE,
+            hv_vm_protect(dirty_page_start, page_size,
                           HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC);
         }
     }
-- 
2.52.0


