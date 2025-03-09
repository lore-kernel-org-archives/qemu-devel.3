Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03F8C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKrh-0001fv-Sp; Sun, 09 Mar 2025 13:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKrD-0000as-QA
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:54:41 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKrB-000554-Lw
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:54:35 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so1837395f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542871; x=1742147671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XarkUwWJ8X54NbTT76zq/O/RBy2xGUo3tRoDoM3zMg0=;
 b=XHlJWjp703uOUs/hfS7ipIOKX2vpns8+UUw/CWvgYxQglPrfF4iqHskN82LtGo8oho
 KkQk0MBHhEV2mqaKg0k2Lw3jfZNstZO7yAlOGSjncDdruH47jr79376y1wTWz2TvIhfo
 ASlTPlZnGsirg2Wp7yJaHQLe7xtv9D9vUdmc9aQmPw8KA6RUqfmfi5i3qLEdxSHOHKvN
 X8UmcliAMyvAVJx68a4Fh6vI9vaHFQeC6DXJUZvrMUwogODZw9WOLiP8pp4NdibIZ8zv
 ARhcvI/m0ViD4BegMjWvZ0QhWdC9qHfAuQplr/MHDoQdl98QPRIYhugGHw25RTSswzy/
 dVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542871; x=1742147671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XarkUwWJ8X54NbTT76zq/O/RBy2xGUo3tRoDoM3zMg0=;
 b=Z9DK4nHbMV5hWN+o0aAN2DHWteXHf8fSWT85vFA+4bZqrxDe19VoiaEYiF/SwPa1WV
 0/851ofb10jm7XfUXJtxn7giPXrtWsaWXLNtY2Aj/MdYjNnzizRM/pX83ZYf9r0N16p0
 MRD8PA/26/rPRrCeY5alRlR+AzQVN7o+EVaIi+WFcaT/vaqfQUsuFS3b+Ui+XYVCBHMV
 zFqXA5QEq9tWCJhpGcN/PZhq0hxoC9Idqt3bpZMe4McHc8tPxOLCgazNz6MaWnIEIYFs
 L5SsA411UvXG/lE2nbbeBxA7EWba+KFLVbSN9MTSkSkS+7J4K7FS+QLe2CaVuT6umJqa
 FmcA==
X-Gm-Message-State: AOJu0YwDuxrxk9o+QGopGlsrkqFu1D3ZcG5Hk35vfcAbNoigon9teDy5
 i2aP+uWPQ5Wdua+0DZ2aAh7C2jQxHYepyPRzOV5TxU385RNJ+KLXRCGjkcxq9Oq1oqfsxCNukk5
 imT8=
X-Gm-Gg: ASbGncv1a8fsQXvd7wREL5cmXsGVwUuW+4M2GeOgJ2/0JFeL/sLzpk4tHjJCPReCZHM
 UWHYw9pY4YBwsD+o7w/IJc7/K3rzpBQCTGoToxcMAFMhLhWlsk0zQDoX+zVFKy0yibt4Y18wMKH
 6JA3JUHpv1A92b4639+r/exXm6GU+9FJwAuzTHIyA1qtHB4yvQ9wa+rX4kI5gJXn6XkK/HlM39P
 1+nPikFKe8teOFqyD6g7G0mOguz0Hq4AJngswNgQBQ+LE5ZNeb29dkFTuAJhpsrreoq0gXbzBJ2
 AjagO0UEAJ1pTb/t+TEMwAH6uDQCRFV2ef4UQlSf8fNlLHyV6SI3qkqR59TvHRKsO/8f49tV/KU
 jEZdJ8FjxxCXrCeXO7u7PTjSY4mLVow==
X-Google-Smtp-Source: AGHT+IGSzMNkXvmhM7nzgIZgBLj4bTAPytaIMJ8Jf9d2LJEfk3mTh6IvHJHsLcNSXGwj2Nsv8CJD6A==
X-Received: by 2002:a5d:6482:0:b0:390:f88c:a6a2 with SMTP id
 ffacd0b85a97d-39132d986f8mr8683942f8f.39.1741542871296; 
 Sun, 09 Mar 2025 10:54:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfad7sm12355080f8f.26.2025.03.09.10.54.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:54:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/38] target/rx: Move has_work() from CPUClass to SysemuCPUOps
Date: Sun,  9 Mar 2025 18:51:59 +0100
Message-ID: <20250309175207.43828-31-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250125170125.32855-18-philmd@linaro.org>
---
 target/rx/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index f01e069a907..0ba0d55ab5b 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -196,6 +196,7 @@ static void rx_cpu_init(Object *obj)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps rx_sysemu_ops = {
+    .has_work = rx_cpu_has_work,
     .get_phys_page_debug = rx_cpu_get_phys_page_debug,
 };
 
@@ -226,7 +227,6 @@ static void rx_cpu_class_init(ObjectClass *klass, void *data)
                                        &rcc->parent_phases);
 
     cc->class_by_name = rx_cpu_class_by_name;
-    cc->has_work = rx_cpu_has_work;
     cc->mmu_index = riscv_cpu_mmu_index;
     cc->dump_state = rx_cpu_dump_state;
     cc->set_pc = rx_cpu_set_pc;
-- 
2.47.1


