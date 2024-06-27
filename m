Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C01C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlxM-0006lK-DM; Thu, 27 Jun 2024 06:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlxL-0006iZ-DW
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:19 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlxI-0001kx-OK
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:18 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3d55e2e0327so1343303b6e.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482535; x=1720087335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8hc3Rw3zZB7nBLeNjAJQMLk441yVfIEAPDQCPVGgw7E=;
 b=BAlzntdeuFh3kWd5WQCIoOIdU4j/5p0jwh28UHfMOqpW2oaQe2pYxP9UFWspJUwLYh
 K8jOjd8JNWZnV/zhNt4Bf0/FX6oiKhMHjhldsKkh+wMTP6d5ocwn7L+bSYiWfxMZVEag
 3uVg3HyuiVUTAoPGTYMXTK6Ua5HJd16kJZe9RlPDwCjZJQalMypQ6Hu1RE4RuM0l34Wz
 nTXUxIMDgiDQcqrteHOAfiIVb6wPrXwVtMM22gI9juWqXjxjhyfXk4ixJ0fybTYlwZ5v
 VLwbcfxnvR4sIdfxyy0rC4WW1BDbVd9BcjUBG5GIWnHHfUxLu86ShPq80KS65VfLaizi
 /qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482535; x=1720087335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8hc3Rw3zZB7nBLeNjAJQMLk441yVfIEAPDQCPVGgw7E=;
 b=o6qrhd70PSe6kAaSpqvHVpzDvJUcUSNHgNreDbRVoRIf9owZWw2PKMJIvQwmYVs/is
 GbDvWyNo59mqHjDIhEBfz6oFaUF4R2cJ5WnZHEp2rNqMInLsrpUIF/8RFqPsqiGvAybF
 YL4RYliVZNkwUIccCGg0o8qZt2oZ1Nl1v+pEMDzBe/wkdUeJ6l/2pknhUBl/Zh01mht0
 CGCzMjdEFlgOjVrBYusLpv9qbIHUAfGCE7vtE0q+1mEFP8wpojtcKhM7oYRlz9ZxuEp8
 AsOkDbxfqXUo0Q5Phz40sbXzE1I4sKWn0W0PaLwIiQPD1tqbI8etny9ISPVuwRRme51v
 ZbVg==
X-Gm-Message-State: AOJu0YyQutngg0mCeKeuCCaLr/CNJooyaYXwlTbKeR4PTO/gCQvQqfPG
 TRQwfGzaXk8zvYRcDFLkPSgw4vrkp14m0w59YoiAYpqO0pgPQJXQh9YVfwtI
X-Google-Smtp-Source: AGHT+IEmGd736Qq7Y4LelCYcKP5+YlZHytq2n78dnsUYA90un5EXbsXat4u9vpDAhM7Q1eGqoJi8Fw==
X-Received: by 2002:a05:6808:1412:b0:3d5:6575:6fe4 with SMTP id
 5614622812f47-3d56575710dmr3285784b6e.26.1719482535270; 
 Thu, 27 Jun 2024 03:02:15 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:02:14 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Branislav Brzak <brzakbranislav@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 22/32] target/riscv: Fix froundnx.h nanbox check
Date: Thu, 27 Jun 2024 20:00:43 +1000
Message-ID: <20240627100053.150937-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x233.google.com
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

From: Branislav Brzak <brzakbranislav@gmail.com>

helper_froundnx_h function mistakenly uses single percision nanbox
check instead of the half percision one. This patch fixes the issue.

Signed-off-by: Branislav Brzak <brzakbranislav@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240608214546.226963-1-brzakbranislav@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/fpu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index 871a70a316..91b1a56d10 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -676,7 +676,7 @@ uint64_t helper_fround_h(CPURISCVState *env, uint64_t rs1)
 
 uint64_t helper_froundnx_h(CPURISCVState *env, uint64_t rs1)
 {
-    float16 frs1 = check_nanbox_s(env, rs1);
+    float16 frs1 = check_nanbox_h(env, rs1);
     frs1 = float16_round_to_int(frs1, &env->fp_status);
     return nanbox_h(env, frs1);
 }
-- 
2.45.2


