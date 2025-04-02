Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B0EC36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05GF-0004ij-9K; Wed, 02 Apr 2025 17:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05GE-0004iT-ID
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:04:34 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05GC-0006CP-Ty
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:04:34 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so1044355e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627871; x=1744232671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=intihhvtn0au9vXegCy8fSkL/lPSrNvDAkqpNvHbY/0=;
 b=HPok6xfbA2g2GLrnPFSxwu2rQJrBCbr7YFnc8OheUnBmj9r/5VpStBOsQIpzpR8ENg
 yM9m4I19CRY27O0xm+5Huj8+kLp8yhqZQGvE4aRIHdwb0ArlP5gm3nNHZIaNo/gY23ny
 W/z1P5UdKHbtd+UwD3YtyHrVMUWws76Gn/XXhcqp7WzeMlkymOs0AJMTvKl+MD4Nv1S8
 JIcKXIT1WWbh+EuzYNup59Iu7VqCqlE5e4BmGXDo0AQX+RL7LOKDpng3kvBC8zhw+cpA
 TR+bOjZM4CvT6NDEPbH9KdekPjGfvu0ylvCiuEN85YPRAielHD8ibAlujfUKoxU8gbEb
 AVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627871; x=1744232671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=intihhvtn0au9vXegCy8fSkL/lPSrNvDAkqpNvHbY/0=;
 b=rWmUXkhKsaykwwAfjpOzI8SGkl3Giw3rYmXKhUxkzSckWEP6xGnbyAIh4nU24bXycy
 dXp+f5Iy5HqHq+0lbS3F95whEMv4Pa4M60V/ERIy/84jlhc5ktiWQ67CBBODtNqaePct
 LBoSUL/iquw1KU9o+Zz325ZJB+ZGNcXax+s1YeopmStBjjcQ3ASwkelZYYMRrgxulH4F
 ZQevtTqoI9aNn++ZR4ZAMVQuqFw0DkMCsTuzKSQK5MZUo19GRJKlrulzSEOU2JqUXQ+B
 LHGeG5EcSOyfs191MuvWIWN2rmjXP5qFF6Xzd9LK5OgbgCMu18Pj0RzT1xUkfTQdT/Pl
 QtVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8i4qpyTM8k4mxEserb0zbSX8ZSYIvQfodb1k5gSSOAmZ4Lzl/7SqfcSh8AOkaiKWYp/0SH5DWHLzJ@nongnu.org
X-Gm-Message-State: AOJu0Yz4aOulicJaGdvSoVh3+dhEsFKQYtqh+A3TdPtZku6hIIFRznKm
 J4pV9K0pDnAQMnVoQ/ADHMCr0F14RG5coaaRHd72lhaQ6LvVx4ZPKPj8xp4nzv6VebQhagWRyhx
 R
X-Gm-Gg: ASbGncvG6NYudr7Xg6D9Mw+xBSpnnzW9WS93SWpd/y6bwWl8hJJRu/D3U0RAt98RDT7
 b6HAn0XQjeI/Bt4z7n0pCs8yh/OgXSDTv+WbkhjRcBP09hpw6/ZY/sSwXkOZ/byCJA3hoPJSPMx
 v6Iqcob1Nf797pMhiRJdlJh7lwCzaLdjvwZmIJpK6E6FyaEnOkI0LVPI0vyz96mLFM+A6Y8J+4O
 uwKvfZ1oUc51uWboYi8MRifd4QzkwhrUHk0+1D7sv6cDUB6banxEdWJFkXvJeD0MjYF4Cbfr4C7
 lerotZ43jCD1pk87aNkt4dEjSMvnJu+ZxeOSHkgno5X1T2loWYEl0g4O6VApWPbOIQ3DwDFPstN
 IwKlu2xlEWqfOLhYyMg/5HTB27wVJhg==
X-Google-Smtp-Source: AGHT+IEVw078E/kShRiWdYSCSCgXHZu5JuVe1drCg+KLz0VxRch8MaL7YLCpyFNPf58GC0VTdQ35sQ==
X-Received: by 2002:a05:600c:5108:b0:43c:f629:66f3 with SMTP id
 5b1f17b1804b1-43db624be12mr158683295e9.18.1743627871414; 
 Wed, 02 Apr 2025 14:04:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43eb60eb01dsm31949765e9.25.2025.04.02.14.04.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:04:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 13/43] target/m68k: Restrict SoftMMU mmu_index() to
 TCG
Date: Wed,  2 Apr 2025 23:02:58 +0200
Message-ID: <20250402210328.52897-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 0065e1c1ca5..4409d8941ce 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -592,6 +592,7 @@ static const TCGCPUOps m68k_tcg_ops = {
     .initialize = m68k_tcg_init,
     .translate_code = m68k_translate_code,
     .restore_state_to_opc = m68k_restore_state_to_opc,
+    .mmu_index = m68k_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = m68k_cpu_tlb_fill,
@@ -615,7 +616,6 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = m68k_cpu_class_by_name;
-    cc->mmu_index = m68k_cpu_mmu_index;
     cc->dump_state = m68k_cpu_dump_state;
     cc->set_pc = m68k_cpu_set_pc;
     cc->get_pc = m68k_cpu_get_pc;
-- 
2.47.1


