Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B125CC3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 02:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUGch-0001pe-7U; Wed, 17 Jul 2024 22:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGcL-0000F5-Qz
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:39 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGcI-0003Wo-Gm
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:36 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fb1c918860so11488625ad.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 19:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721268693; x=1721873493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SigXo9JFKeTNramL+H42np6aFUN6W3LsbIdms9vmOc4=;
 b=MkA+zambbCQBFTi3Ui0cLYeQEPoqRUWw6VFNduT5qqzY1K62t4zxVHRML4/7haJ7aJ
 guDPC6Yr+A+Fari2UqIushdA0Jyv+KjuI9t24N9v6J+HEF9MSQOd++ZrPzkqZxVICmFq
 EM3O2wOGoQwCqAed++jf3xj7bbhAwAZGU8hURDeVoxZIqwEVgNzWKls19CK6TUx2hm+/
 OlgWstmtlFryuXynWRRMzcvFFsNuEf7usJPsn1eVDXaSb1fYJCZREX/ekq8TNzDYqKdP
 iDd3zrdSS6QRk4xQg+Qa5nglQVt7QCKfYpX2GgwQnsyDcYwQ5iv1aWtdjpyQ6iVMZC9j
 gzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721268693; x=1721873493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SigXo9JFKeTNramL+H42np6aFUN6W3LsbIdms9vmOc4=;
 b=nBT3VSj1z/Lf8qpHEv9HfUTTlChoAECl17QnTGnO7OTlPNBYN/e9YDSsRKUMbhFiQB
 ioKYRfjRPfQqviqYY+joKHe32aPgCXgq1S8p6MGxOqNz/hFIj6slrXQCBNvzM1+OWsbh
 m4Dk4jphGKatCXnt6HsLOJmj2e807jwn/M5A0qGBnhKHYuMvoFpfFOLMJrb8AWMntXLf
 Q5XxXglH3PspYYT8/Usoi+Rr+cLcYokUGj7KHEDuUms5OS8j/mji2jcIuTyiPnkTvhqJ
 XzxWeQH7ECN1CHvvDtPh7ik8emkJlFJ+vrnMjZr/Smb+l+Zw+rcpNM0jzXpu90uW5viM
 GvWg==
X-Gm-Message-State: AOJu0YxLd3bF/kCBQkOQ8rFM2fCU9yGnicY55e8GaQslb0yxhW5YcbT7
 YDwv6it/hq2D+gMsu22BDjZv7c0IgI/6TL7t+IzDUVd8D3oqAndl8bUfE1nw
X-Google-Smtp-Source: AGHT+IHfHZfqY9K/uWj8mAqvwMsqKQquLAGwJflCLd9IhMfUuIFBrGVhQE0JcZcUJ2t7384vMzA/mA==
X-Received: by 2002:a17:902:f651:b0:1fb:9cb0:3e46 with SMTP id
 d9443c01a7336-1fc5b5dd433mr24532875ad.7.1721268692755; 
 Wed, 17 Jul 2024 19:11:32 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bba949bsm81999385ad.69.2024.07.17.19.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 19:11:32 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Atish Patra <atishp@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 23/30] target/riscv: Enforce WARL behavior for
 scounteren/hcounteren
Date: Thu, 18 Jul 2024 12:10:05 +1000
Message-ID: <20240718021012.2057986-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718021012.2057986-1-alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
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

From: Atish Patra <atishp@rivosinc.com>

scounteren/hcountern are also WARL registers similar to mcountern.
Only set the bits for the available counters during the write to
preserve the WARL behavior.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240711-smcntrpmf_v7-v8-9-b7c38ae7b263@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index b7a24f9c60..d6c5b73afd 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3063,7 +3063,11 @@ static RISCVException read_scounteren(CPURISCVState *env, int csrno,
 static RISCVException write_scounteren(CPURISCVState *env, int csrno,
                                        target_ulong val)
 {
-    env->scounteren = val;
+    RISCVCPU *cpu = env_archcpu(env);
+
+    /* WARL register - disable unavailable counters */
+    env->scounteren = val & (cpu->pmu_avail_ctrs | COUNTEREN_CY | COUNTEREN_TM |
+                             COUNTEREN_IR);
     return RISCV_EXCP_NONE;
 }
 
@@ -3722,7 +3726,11 @@ static RISCVException read_hcounteren(CPURISCVState *env, int csrno,
 static RISCVException write_hcounteren(CPURISCVState *env, int csrno,
                                        target_ulong val)
 {
-    env->hcounteren = val;
+    RISCVCPU *cpu = env_archcpu(env);
+
+    /* WARL register - disable unavailable counters */
+    env->hcounteren = val & (cpu->pmu_avail_ctrs | COUNTEREN_CY | COUNTEREN_TM |
+                             COUNTEREN_IR);
     return RISCV_EXCP_NONE;
 }
 
-- 
2.45.2


