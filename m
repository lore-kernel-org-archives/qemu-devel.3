Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6352CD98E6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQhU-0000vE-7n; Tue, 16 Jun 2026 06:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQhS-0000iE-9V
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:18 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQhQ-0003RN-Lt
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:18 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c85a297d2d2so2648195a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604435; x=1782209235; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fo8RfBkdy4Aa8xwG5toPk/LTT+2RXG0B985ij9QtC/Y=;
 b=XOIcZAt5EyLhlmNAa7s4JRadDnYdwUmQEl76ZiT8iZ9r7Xnm2IYqd9MLlc6Vu3h87p
 RW81VRFEPWH8JqjMzzlPw5mIYTkefS4eETjODcMbWPlruBY5ZOKLZksTDVfdpIwr3FM5
 4aH20MBA6N8VK8+QUQJPTPrUbyn8Bjhe6vgiEsrKzAn2e7Au+JvYUK2Nz2nM3o+qHrMh
 aZYaS7s8iBmkW+hDtzYOq0LqH8g8Zse7x3qjinoGcjsP2pCgGGlXVz1FoYtKULDR3tIK
 fw5R5J2fVLZa86HKEN5Z1u6fBk6nBlaQavm8IzgO4EQk7qOu5a5rcRAF/wxzvridQhOf
 0ziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604435; x=1782209235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fo8RfBkdy4Aa8xwG5toPk/LTT+2RXG0B985ij9QtC/Y=;
 b=WW1hUGH1AmHDgYZuG4rfyJ2UawwGkaP7G+0D2QhVTVCa2BK6LsWfYrLlKIVqzm2xHn
 pkIG0IFCPPFzdBqOjUUywgKnKRIbJzmotYJC6f4YzE4z1fRrDAqc7duWuvNgIxehAdgy
 flNlLUQUVOwbV4DMM254rwfGkOzzA0+Vh3o3J4XsKedDYl5o/D9w+4TLAzrgH+cl+O38
 wN3k7euEEHpWYPuxXMNIGK25KnXk6xZF2YiwtP0u/p2T/cH4HmPcO9Zr4irkUCN4kcFp
 ARvVvvTyU6CVmipHfDzuIZZq3NHLEaG9gissrB93mLrMfwFhGb1bV7Cz8kWU9tEAJIhp
 cbDg==
X-Gm-Message-State: AOJu0YxpjYyDCi1KkqoVph2ai2pFmCIjqk1KsU/SZudNKySzbHQhEF+F
 v+5k0PEM8nrjmjBbwY9eph8wP0/yjuxuk5UzgDRt7tFwwAoq9yhOtTSbbyML3eH7
X-Gm-Gg: Acq92OEJF5aQX4yNG8KFHV1dG7nUNxfKdelrUIW2iwn+218MMty7ZyGELwwK9AB9CQi
 YbEhHAYFGEsJExqf50AKSLZYv91z0LOYWfiNmCe04KK1aphbXrsiXzv0lh54puEK2VaRrBxot/B
 pDuCBqF55D/D5Di9zvHGo02mOhAU3NlCH6xFKlUrU4HJHgJp2M4ImPbX7Fou0SywCc1YLHnFpwJ
 ahupcTbQvXloa0FWsFYQmpZSKZbENA7XHOVQDcWMXN5df6QO5ITSwNeJfcAXpLTEqiodUHUPJcu
 jrmxblgt0Dwo6a1vX2CVky56rRlC8AnNWqEtAec/UBfasGg/vCv2fU9kwAzVqUBLyyBarDqEnkk
 7a3clggWbMgDzDNNHF6+W/RG/BnpN40/CXgACv+/U+XgsgK11/a4g1tbyeZ8N4EeTqDR5ufMyNK
 Dd3PG5H4weoFibm/tmgqROg+uhLWd17NJ+1S8z9Jsz
X-Received: by 2002:a05:6a20:94ce:b0:3a0:adc5:52c1 with SMTP id
 adf61e73a8af0-3b7e473ff32mr3275654637.11.1781604435243; 
 Tue, 16 Jun 2026 03:07:15 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:07:14 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 29/83] target/riscv: Replace target_ulong in
 riscv_cpu_get_trap_name()
Date: Tue, 16 Jun 2026 20:04:32 +1000
Message-ID: <20260616100527.1939565-30-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Anton Johansson <anjo@rev.ng>

Fix cause argument to 64 bit to match env->mcause.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260520125406.28693-19-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 2 +-
 target/riscv/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 6477c7de99..a92cb249fa 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -603,7 +603,7 @@ extern const char * const riscv_int_regnamesh[];
 extern const char * const riscv_fpr_regnames[];
 extern const char * const riscv_rvv_regnames[];
 
-const char *riscv_cpu_get_trap_name(target_ulong cause, bool async);
+const char *riscv_cpu_get_trap_name(uint64_t cause, bool async);
 int riscv_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
                                int cpuid, DumpState *s);
 int riscv_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c063604298..e792655cc2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -386,7 +386,7 @@ static const char * const riscv_intr_names[] = {
     [IRQ_PMU_OVF] = "counter_overflow",
 };
 
-const char *riscv_cpu_get_trap_name(target_ulong cause, bool async)
+const char *riscv_cpu_get_trap_name(uint64_t cause, bool async)
 {
     if (async) {
         if ((cause < ARRAY_SIZE(riscv_intr_names)) && riscv_intr_names[cause]) {
-- 
2.54.0


