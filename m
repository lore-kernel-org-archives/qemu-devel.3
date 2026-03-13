Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49888106FD89
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vuq-0003yu-3f; Fri, 13 Mar 2026 02:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vuo-0003pw-1a
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:22:30 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vum-00071n-AN
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:22:29 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-439b97a8a8cso1826679f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773382946; x=1773987746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OycywTra1+LSMQWZXm0KU0ZmIW11k6I4TMh6+N0M1bU=;
 b=B2Ywlcxr5TK6SowymNn3LHr1gI1AogEftIAITDawdbHqhxvL/8Tg1qJzkplU6aN+bo
 5eDxFcuQbVHi7hLIcBYE/spFQ6bMPkficm/y1GSxNYi1N3kYA5hy7pS2/fkUUUDCUhCq
 atWRti8s+eCOe6w//n2vkL2pqAYzMEDP1E9Cem2fmUIIQ3s/ro+3HPlhi3+cVQ5x8spZ
 ANTe7p19Yy6oOoCP6bRAd04awIDcuYUuZJZmLqdz8jyEHFdRutCWQuN7XSa3agcjvD04
 kbIwDPJiwBpiukURjTa6WIwgFzvXFubU7N0eqGKlVOvNfngjYfExA4TtDMRgEvjVX839
 BEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773382946; x=1773987746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OycywTra1+LSMQWZXm0KU0ZmIW11k6I4TMh6+N0M1bU=;
 b=C+/yywzSQLfG12jLq845Ra79ytWMBWOOOhl1QN8sZ/BKoUEWyWSbV3aK7JAASw+JcZ
 NgzRyo++isHJ9Iizan9c8h0RgIDFQOVGHpZX+nRPmzCVTevW6gQ9Fm4ylp4ZWIEKxz3l
 1ewrxOlqjPV3VK6w2BwbUliUzU+KRBl1mJAvNE85QJH/E3enCSMOG+FZqO37AGwqlr4/
 mZnCeJoFjmitYzwj8/RHP37dYzGQHNx8msWgotPH2druwywdGWgPacQNKLTBKG84q56C
 mES45dWy3yRTHf9z6geTU5T8xjb2eHYjkAYoBtffQjxAcNSqqJhB2YDm4rfuILmcv6oi
 Tbaw==
X-Gm-Message-State: AOJu0Yyhq48C9Izs7MBzP2dP86V93N0z+1mogFfZ/eWaVGJtfINdDUga
 E6HaIemvCzmu9khlzG21ZHNpgl7LVcebBa5T1RZoEHINVnR5/vBsJU4L+JYg2tWlTjm5lSK8Ul2
 BfCC8QQE=
X-Gm-Gg: ATEYQzxV/cRa7bjqW7WB+VRcPHnX5jZ3sjkDWeAKFss8zEr7/H1W/Kgimhnfly9tNSt
 dpiCFcK9q06/mPAT8mbOOH/Ta8d1EGmqQDEr9Ucgo3c7Vb2Jg0/hooZ8WWTo1CJeo4bzp5RHBss
 rFYTpOrcrFmB/oOj81teqcwXozkZbq8YLGvOJZ7gdZCtl4DPSH7BbtwApGKcpANBgC3TzaEdUpQ
 c4rHYDDC+s/jzmsFktjqJUaZur/tlkQA0oRhPr9JqLHyUaIfa+IKYp0ufsgJB6S1r/X9ovGkTJM
 zwX8TzFwOdr+OKFdW2TEIYa5YNQX35oyYjjt9snNyVNGctlp774dS0SOffYo3jxQ9/PGb7qo9B0
 1MYzlEpWgBinZv3BBfewvE0hMYlHakNQkVGePqJnRFkHdnTG7DTaM4HzdZiThib63Y42UAqXjnz
 vZNuFoaYnmnyohMbvVltbig3UPq9OFcq+tdmnDT1uJXSSc6liY4TE2rx/rF3fC5YmYzIGPCG2l1
 ARk3g==
X-Received: by 2002:a05:6000:40db:b0:439:cb5f:8395 with SMTP id
 ffacd0b85a97d-43a04d87385mr4167388f8f.16.1773382946347; 
 Thu, 12 Mar 2026 23:22:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19acbbsm15354134f8f.2.2026.03.12.23.22.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:22:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 13/38] target/riscv: Include missing 'exec/target_long.h'
 header
Date: Fri, 13 Mar 2026 07:20:29 +0100
Message-ID: <20260313062055.2188-14-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

The "exec/target_long.h" header is indirectly included, pulled
via "exec/cpu-defs.h". Include it explicitly otherwise we'd get
when removing the latter:

  ../target/riscv/cpu.h:605:1: error: unknown type name ‘target_ulong’
    605 | target_ulong riscv_cpu_get_geilen(CPURISCVState *env);
        | ^~~~~~~~~~~~
  ../target/riscv/pmp.h:73:1: error: unknown type name 'target_ulong'
     73 | target_ulong mseccfg_csr_read(CPURISCVState *env);
        | ^
  ../target/riscv/debug.h:139:1: error: unknown type name 'target_ulong'
    139 | target_ulong tselect_csr_read(CPURISCVState *env);
        | ^
  ../hw/misc/riscv_cmgcr.c:112:15: error: unknown type name 'target_ulong'
    112 | static inline target_ulong get_exception_base(RISCVGCRVPState *vps)
        |               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu.h    | 1 +
 target/riscv/debug.h  | 1 +
 target/riscv/pmp.h    | 1 +
 hw/misc/riscv_cmgcr.c | 1 +
 4 files changed, 4 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 35d1f6362ca..f30d3006166 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -27,6 +27,7 @@
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/gdbstub.h"
+#include "exec/target_long.h"
 #include "qemu/cpu-float.h"
 #include "qom/object.h"
 #include "qemu/int128.h"
diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index f76b8f944a2..066e9c585f1 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -23,6 +23,7 @@
 #define RISCV_DEBUG_H
 
 #include "exec/breakpoint.h"
+#include "exec/target_long.h"
 
 #define RV_MAX_TRIGGERS         2
 
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index 271cf241699..97ceddc0013 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -22,6 +22,7 @@
 #ifndef RISCV_PMP_H
 #define RISCV_PMP_H
 
+#include "exec/target_long.h"
 #include "cpu.h"
 
 typedef enum {
diff --git a/hw/misc/riscv_cmgcr.c b/hw/misc/riscv_cmgcr.c
index b0294e76635..a4d56e3b308 100644
--- a/hw/misc/riscv_cmgcr.c
+++ b/hw/misc/riscv_cmgcr.c
@@ -19,6 +19,7 @@
 #include "migration/vmstate.h"
 #include "hw/misc/riscv_cmgcr.h"
 #include "hw/core/qdev-properties.h"
+#include "exec/target_page.h"
 
 #include "cpu.h"
 
-- 
2.53.0


