Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D4CC47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 16:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSJSw-0003X9-1J; Tue, 23 Jan 2024 11:17:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rSJSr-0003VP-FA
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 11:17:31 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rSJSp-0007XW-DO
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 11:17:29 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-290d59df3f0so495989a91.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 08:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706026645; x=1706631445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kzJ+UgJJuE7W/tRb8snvZi1WjQ/6d52gsikzd4/7YbA=;
 b=Ou6svFNNPZaeNa2JwhBzkS399OgHjkGFLcMJTru9CIKZPy2uuXYmRH6KIDqBuAHGrb
 T1MwtPL63aUAEP2ttAoMY5W5R62rBTl1karQ7qSoC/LnjXTK5pab7ZL/UGbpRt1smFgU
 2knIHhtSin4wH7sEwP5fsu+57+z3Kd0YJCwALX6ctYJ3sS6jqfkPyYju1DJLFN35OcIP
 eEdE5WjDJb/kNASx9KqzIM5B29amcCMprts4bDq2nKLJHtcCoS8hRkdVRH9cDCU29kVd
 9Iof4xTRPNexYmTDhSITUjbLSEXfOwGHXL6g31H8yVSEc/kxT3b9k+hxgh0EZHtRkJWE
 oZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706026645; x=1706631445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kzJ+UgJJuE7W/tRb8snvZi1WjQ/6d52gsikzd4/7YbA=;
 b=BRdi41ukkSIh9TBR/KYpcfmUg+jswCikBzkOKHYquaFCApayjP1DF5cGRHb7hY0BcM
 rdYUovc7qCuG5xmBNP0b8hORxdHzzfvah2oVcXRNtzejKnhx/JyGGn6+7SLBMrpD1yGz
 HFnZIGlxeD09EvsSdsNLOfaEzGThJaHsQOPECI/QcGDHlm2BIG5KNYIBhOBl3r3P6Gyq
 SWPZ1v/ctgfCvHc6LqGeA5MPVYc+K0uIyqS+w1Ms4umjoyd4JHsYmfX6jKp7PjedyXFc
 b/b1mQjwf7tU3u1XTa8eXuMZcxctd2GSRAmdewhDMmYnwp2VF4SEtcVVEpzdjBMM2AuI
 dOPA==
X-Gm-Message-State: AOJu0YwCdixjIq3ywDrOCGAIjFGj4cd93aa3uh4yUC7huOnOyHt2OXvb
 s0kdtHvwrPedgcmx7vezvKxFWEjil5LutJT6Tn1NlaAq6LqFbei+y1aF6Df5CFyaaJxR30MwCaH
 C
X-Google-Smtp-Source: AGHT+IGOV0cXnOulctbjRgw7MtjLzFAwnlCcZyvm9DI0IHdvzzwniOgPKrGJt0aWDHMwKci/XSu5Sw==
X-Received: by 2002:a17:90a:9c5:b0:28f:ee89:8149 with SMTP id
 63-20020a17090a09c500b0028fee898149mr3193483pjo.79.1706026645499; 
 Tue, 23 Jan 2024 08:17:25 -0800 (PST)
Received: from grind.. ([152.234.127.94]) by smtp.gmail.com with ESMTPSA id
 u14-20020a17090ac88e00b0028bcc2a47e9sm11755686pjt.38.2024.01.23.08.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 08:17:25 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 1/3] target/riscv/kvm: change kvm_reg_id to uint64_t
Date: Tue, 23 Jan 2024 13:17:12 -0300
Message-ID: <20240123161714.160149-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123161714.160149-1-dbarboza@ventanamicro.com>
References: <20240123161714.160149-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The field isn't big enough to hold an uint64_t kvm register and Vector
registers will end up overflowing it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 4dec91740b..902180e8a5 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -145,7 +145,7 @@ typedef struct KVMCPUConfig {
     const char *name;
     const char *description;
     target_ulong offset;
-    int kvm_reg_id;
+    uint64_t kvm_reg_id;
     bool user_set;
     bool supported;
 } KVMCPUConfig;
-- 
2.43.0


