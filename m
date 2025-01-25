Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99476C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbjYz-00014s-9G; Sat, 25 Jan 2025 12:03:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjYc-0000fB-Bd
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:03:05 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjYa-0000ZU-Rr
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:02:54 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4363dc916ceso26620145e9.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737824571; x=1738429371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jJ0qtgTntar3QVC5dx8kSZPa0KtS/nd9q7NwrkDQJ3Y=;
 b=jeIIqwa6s7kzfbzx/TlpELFAHWoZwjPZ3BWj8CH6pnzAm2Jqz1cr/BSNF0y95p9Zmj
 MfnWQulrjyDLlr7oZghRrgUFvkC3qZ5JKL7EoKaGHsxVdO72iWLxvLjpqYP7Kge0FJ3W
 r332UjQk3VFzECFqJkMi3ofF+lwnQHiEd1Xoat3T9Jle0wSxa99yVnMzNjQmtaNoDHfW
 HycYz/17EYqQIBatJGYjU88ciV2DK0eIbAVGZhZ9Yba5RPfLwHRVn1XRmqCqEKnA5exf
 ociRJAldYRknkTC8ZX1XOWdPllT2Turhr5bymawEluMaFSLnihp9s64BJXYlkqMoJ15J
 QTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737824571; x=1738429371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jJ0qtgTntar3QVC5dx8kSZPa0KtS/nd9q7NwrkDQJ3Y=;
 b=QmcaQ/M/1EEPtXvTdB8aQyTo880hbvD0MwzmDiFWYgP2LylXGYoRq0tkY76FO3mDnY
 GZ7VjFMxnRdoNNT1mQwZxTk7HngTWNbr22sSHTlo6f+W1XvBQ1Q/ETLaQDt4q5yA0Yuf
 I5Mwnb33Nb7UkKLMhBil97D+6IPhMuOqaG9v9xZb3cUJ0LeMnDgX5z3HmwEIbzmEq84E
 pPvgcMCQDoJIDDreLj8pWnBkqP5hn7aOgYeDu7g3ttqp+7i+yKJP9os48YSQZuL8Vmq3
 P9DyTxRPThp7Zc0EFsxlu2IRPAw2PS59DTJ45MTM4FixEI4AphRKPnQeoB4beroZsLHK
 hetQ==
X-Gm-Message-State: AOJu0Yzz+g9ftGkr90CPrjDCS+EMD1k8Ee9uVQdJhEW5V/DWvZHXeCjS
 qlqgZCZCdnLE9cKQohwhB/+2dkVW57+aUe46VlS5ZuVMFApPf7gD+oPOP1TaiBt0QUQUoy3HmJZ
 SB4o=
X-Gm-Gg: ASbGncvjfJsLt56wSGSVen0YvaGG+5Ygx2OntjQn9zMZziDOyrrPrNS1YYk9o7LXquV
 GaIpns7oUPdVIry+SrCdO1kG2bSjGr/6TnK2PWac/0GYgFnnmiwQ4kfsf6AYhKv9lec75x7U4WV
 9olewLWRvR7VGj9+KpF+p+tnJqoSxeFPE4rE5D9QHlC8TNfcG4e8XsE+A863uE3Tz3YPuOESeGl
 nYo2cEr26IbZXz+NFQuk/dtNLw7QLX/1cffXzcM6lXDLxZVeUKAkvyEiWSU26Q2dAQUQBTBs4wx
 +sOiDV8ZdPd0tmQb6jQTGPD9o3olFOpvQ6HgaiT7n/659hjnWaBjH0Q=
X-Google-Smtp-Source: AGHT+IEv3Hzt/kTZI8gbmwC3Ks01IT10ixTeOhpPeNaRHP4VYTWkCqP1WpzyXJMc5CdLtXAbedgA1w==
X-Received: by 2002:a05:600c:3c85:b0:434:f3d8:62db with SMTP id
 5b1f17b1804b1-438b8841d2cmr112892245e9.2.1737824570910; 
 Sat, 25 Jan 2025 09:02:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd485007sm67899905e9.12.2025.01.25.09.02.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 09:02:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 17/24] target/rx: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 18:01:18 +0100
Message-ID: <20250125170125.32855-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125170125.32855-1-philmd@linaro.org>
References: <20250125170125.32855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 target/rx/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index aa310bd6144..79b95090e7a 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -187,6 +187,7 @@ static void rx_cpu_init(Object *obj)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps rx_sysemu_ops = {
+    .has_work = rx_cpu_has_work,
     .get_phys_page_debug = rx_cpu_get_phys_page_debug,
 };
 
@@ -217,7 +218,6 @@ static void rx_cpu_class_init(ObjectClass *klass, void *data)
                                        &rcc->parent_phases);
 
     cc->class_by_name = rx_cpu_class_by_name;
-    cc->has_work = rx_cpu_has_work;
     cc->mmu_index = riscv_cpu_mmu_index;
     cc->dump_state = rx_cpu_dump_state;
     cc->set_pc = rx_cpu_set_pc;
-- 
2.47.1


