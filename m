Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751F4C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 14:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taFEA-0005wO-2J; Tue, 21 Jan 2025 09:27:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFCC-0002Mm-Vz
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:25:41 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFC9-0003Yw-Lw
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:25:35 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso39945625e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 06:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737469524; x=1738074324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PSfO83fjWsnWHDr8uFKNeFyF3V9Fa6fmQk5hnrhkQ0M=;
 b=NzEyyoU/CLnm9tCPLVy9tDhBvVwSgt0VJVmvzQDqVAPqq5ecjcgwkIlYt2HpyhaEJ/
 0vBpH9TvtpmGTcqpynsL18PqrMaZVEwJ4J9TkTZxA2k+X9ZBoSdqOEbsmhxpxHU034Wz
 Rb6bLQm9EWQWED+s95MqeVPY1xRofiuJ7tyn2rYxjpGJ9+5eILJmbU9vAI6RrxdSVORR
 5IhrdFEgpTguhS6OFXlS3rxyCZ+89ocvaWYPtVji+peoFAuIP70Zhe8WW2rNb8DrkRSy
 d1cSZFP2wNEc/kL3FaSk49BnK91KesgvX/JM2RshPC9562xVrK+dscDXad85/dfIN5Hg
 9uRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737469524; x=1738074324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PSfO83fjWsnWHDr8uFKNeFyF3V9Fa6fmQk5hnrhkQ0M=;
 b=AKM6+gS5EOmJJ7lEPPtaAcXWxcFoChXdooLI4iCEf1cNkMgzq1xOKXd5krtUC2Yn5t
 B1Vmlj+hXPlU05UtyiEvneicogAtZ6t/KR64NC9u9TswRTtorM0DOkVcOaQtE/IkZ6aV
 BTHWV+GjvNmwlhBa4tMc/nBiipwl0udgInNj4p3mwGONBzPlJqYOrAgJqiSXewl9Xlu1
 VxiIHTfdYkzXnB3xOVAJTb3R15gH657gT0GSPA6RYbRMjU+YxB5znf3ubU6JYCpSezlh
 g4njwrVc0ZhOECMu3a0lT4NJsWwVbFL4S+u2UbKEdPZaH/JiZ6aW0h7CK3RfAE+RuYNC
 8q/Q==
X-Gm-Message-State: AOJu0Yz0KjT4yU+0UIBhgdHPNeKDrExYvRWiy/cPJClQ3v40rpIINju4
 V1VXZszpXjYXiyCm+/06htDjLHJWdZ52DPME2pd/weIcizdmKmHzGmrJseab1FulE1b9PYFLEjS
 D3Us=
X-Gm-Gg: ASbGncvkRtiUqLouKRcwhyro2hyGZsVVqvpzUthIDus7s8raJ8QCyU7CJfIuRbcxlyO
 jSRI24uf7W+UrAFtUkCUXBTH+37Jca1/FF5hCCC686FEBRqAoXIPNWtTyrfP6q5fFYvY3UgxRCD
 Sj0yz+uivncmgF2DOzXY8KaEYzeyatJbHmWYPd4nCeo29RjtZxitGs42FaHZnJUhTBeJixBD2oD
 QGTkkjZcrDNZUP72lB3UF5f8HOP70tFJelvkX3D/9cuo6XBqb0TnqMQdKmV0xsvBgJ/IkxHMRKI
 BAzP4z3KP3f45EkM03Qs5/2WEBNP/ctJiXqJfEXpeo1D
X-Google-Smtp-Source: AGHT+IF2omPRSjnWN9jhrxVc6jEnwsOGEAA0Rr/Lp2vLVo+a3b31TLCUPOMWoPdHRg2s7zVe2kC5Gw==
X-Received: by 2002:a05:600c:4e0c:b0:434:a802:e9b2 with SMTP id
 5b1f17b1804b1-438913bd972mr157194245e9.4.1737469523913; 
 Tue, 21 Jan 2025 06:25:23 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf32221a8sm13684934f8f.37.2025.01.21.06.25.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 06:25:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 21/28] target/rx: Move has_work() from CPUClass to SysemuCPUOps
Date: Tue, 21 Jan 2025 15:23:34 +0100
Message-ID: <20250121142341.17001-22-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121142341.17001-1-philmd@linaro.org>
References: <20250121142341.17001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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


