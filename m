Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F50E7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 17:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOKcG-0007lm-Nu; Thu, 19 Dec 2024 12:47:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tOKcD-0007YM-71
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:47:13 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tOKcB-0003KY-Me
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:47:12 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7fc99fc2b16so610848a12.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 09:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1734630429; x=1735235229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1vVc6sg+aURFgwjT+TCaK0xxPICHe1+5pUYbWqCjbhA=;
 b=a+WUQ/hv+t3vaswTkZYIutJXde/ym6R4FOsHheKL2aXHrVmsRI4F5oHKSJx4/KtB7R
 vjv8s8Qe+SXWPPJmXQuyhVvrF6mHJW3cElvoCBTt52O8dDLEv6SMTL2QEdHSZ/CgyM9X
 ukd53+UIviBb6MeXIW48ZzEGRtXe4pUPH1+/LEcr8wneOW8MuzvFdasN3ebYATxAVDk/
 gE78f4+1cRZlYSZkhHwi/BQtL8DIuIMDcfKZWDtnFWSiaax7ryqiKHL8wBBPQsUCRuRz
 PQR7wMgLitputr/iC+0zrhOXghc+yffYr8DbryNdO1pFG4xZOfKTrOIyEnr0Jx3LCjjJ
 rP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734630429; x=1735235229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1vVc6sg+aURFgwjT+TCaK0xxPICHe1+5pUYbWqCjbhA=;
 b=xJjxzXaDNvVxbf7q665+Ly8sAGbuT0pyLSYjf2rGQCkFk6rfn7O4+EfXD4Gz7WYta4
 ZLeldZzSYSlOnEj6YEE63yxVqBIVrrbFYjvXQjxhp/dYehYRq5FzlJQBBIt5Lvo1H7Xy
 NQgshPh6mdtVjyv9M9pM2htdyfdqfUelqoKddMZDGjGIMBoWfojdmdQcEWH6zZaIM4wo
 sP88GtZK1d8eUA4c2dEgwp0hofyZ2eOyKzMZiZFTAQWFTj6Zv0tbgN8poxFirl3HGrEh
 oJBeHdJjKNcGSoKoDOmXt+cR8FAmsKyeq/1D/TySTeYQhpeFguSqRJ4rTBB4ZRKX7jWT
 PReQ==
X-Gm-Message-State: AOJu0YxXANVx+udImhEW4oWhGn3FBOVf+oZXUD2kutBGmZyz8j5dL6Mb
 /l+cZfht2+2mtTV+fYmNVyJMuU9yqKa0uT2oaCfIO4FOtKeyPtIYWAGzak8fLZrXd0wn/fVH5Wu
 LMoCG3w==
X-Gm-Gg: ASbGncsWPDXmZyDi8S4ieHCrEN452zRHk7+vjmEqLdvhvFEuOvd4XTcq16pdzrkgS0W
 HyVnnbKSuZhrVsCCx6rmuNS1JVTcQx0O5/GFUZIdvmfTheoPMz5CNnPDbhPPK0aLw9RjFR+Eqll
 6AVxTGdSYAdtuXZW1jqLOUAuAl4ItFFrS1U/SDh0PUMuKzMLhnX3Gue0YSX/4jZtHGxC8aMAN6J
 o/T1Ld+Kkgb+frzFmLgBHCEMejgSbkS6fBVVO8IrDsJpCX6SSna8SW4T+D+8udMQrUhR1v81p2Z
 nem9J5Y=
X-Google-Smtp-Source: AGHT+IHtJ9gWYSFmmYXzEbUC3A9++8qSgZaKTP71UpRY0Ie9n6k/FUfjcJZUGiNZb0MQCLo7AlEBzw==
X-Received: by 2002:a17:90b:1d43:b0:2ea:4c8d:c7a2 with SMTP id
 98e67ed59e1d1-2f452163d34mr348110a91.24.1734630429686; 
 Thu, 19 Dec 2024 09:47:09 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9f7307sm15099505ad.195.2024.12.19.09.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 09:47:09 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 2/2] target/riscv: add trace in riscv_raise_exception()
Date: Thu, 19 Dec 2024 14:46:57 -0300
Message-ID: <20241219174657.1988767-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219174657.1988767-1-dbarboza@ventanamicro.com>
References: <20241219174657.1988767-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52d.google.com
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

When using system mode we can get the CPU traps being taken via the
'riscv_trap' trace or the "-d int" qemu log. User mode does not a way of
logging/showing exceptions to users.

Add a trace in riscv_raise_exception() to allow qemu-riscv(32/64) users
to check all exceptions being thrown. This is particularly useful to
help identifying insns that are throwing SIGILLs.

As it is today we need to debug their binaries to identify where the
illegal insns are:

$ ~/work/qemu/build/qemu-riscv64 -cpu rv64 ./foo.out
Illegal instruction (core dumped)

After this change users can capture the trace and use EPC to pinpoint
the insn:

$ ~/work/qemu/build/qemu-riscv64 -cpu rv64 -trace riscv_exception ./foo.out
riscv_exception 8 (user_ecall) on epc 0x17cd2
riscv_exception 8 (user_ecall) on epc 0x17cda
riscv_exception 8 (user_ecall) on epc 0x17622
(...)
riscv_exception 2 (illegal_instruction) on epc 0x1053a
Illegal instruction (core dumped)

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/op_helper.c  | 6 ++++++
 target/riscv/trace-events | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 29c104bc23..29de8eb43d 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -24,6 +24,7 @@
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
+#include "trace.h"
 
 /* Exceptions processing helpers */
 G_NORETURN void riscv_raise_exception(CPURISCVState *env,
@@ -31,6 +32,11 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *env,
                                       uintptr_t pc)
 {
     CPUState *cs = env_cpu(env);
+
+    trace_riscv_exception(exception,
+                          riscv_cpu_get_trap_name(exception, false),
+                          env->pc);
+
     cs->exception_index = exception;
     cpu_loop_exit_restore(cs, pc);
 }
diff --git a/target/riscv/trace-events b/target/riscv/trace-events
index 49ec4d3b7d..93837f82a1 100644
--- a/target/riscv/trace-events
+++ b/target/riscv/trace-events
@@ -9,3 +9,6 @@ pmpaddr_csr_write(uint64_t mhartid, uint32_t addr_index, uint64_t val) "hart %"
 
 mseccfg_csr_read(uint64_t mhartid, uint64_t val) "hart %" PRIu64 ": read mseccfg, val: 0x%" PRIx64
 mseccfg_csr_write(uint64_t mhartid, uint64_t val) "hart %" PRIu64 ": write mseccfg, val: 0x%" PRIx64
+
+# op_helper.c
+riscv_exception(uint32_t exception, const char *desc, uint64_t epc) "%u (%s) on epc 0x%"PRIx64""
-- 
2.47.1


