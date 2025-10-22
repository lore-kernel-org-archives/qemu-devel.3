Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF3ACCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBYC1-0003tG-Io; Wed, 22 Oct 2025 08:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vBYBz-0003rn-Rj
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:43:51 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vBYBx-00018j-RO
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:43:51 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-78125ed4052so8258350b3a.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 05:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1761137027; x=1761741827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G9wpds0Q5G9A4aTo8qFgm5iQqNbXf4bZi76lWbGL9sA=;
 b=dpL0uCbcTMvfmeX1SgXHe1Fmto003M2JEh5IhWIDh5Oo7h1KY+h91y1ZYixanVk0pc
 E9VDvDyNVibUWX6AumxTWBI4mem3Sq7+Tg30Zcz5txTgX0z8XT1PoN9ktrLbFHXZVji0
 WgrhOosLx5z6ftd82TcJKrbRgHCNJxKLAqV6dhd5yfnidf8R59PlAcoqA3pWp3vX8Amn
 Nte7IbZyM5esgryALbalOOD8rWxQqLLbtmZ24vEfqv2K3plXZWsqpZgmZa/bR4KE24R/
 983VOxsf3VrZ6/+QKXAWq5tDlGJDItobdEV9i4bdgsQX30aKtQR2npCHNn97djNAZTbT
 6umg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761137027; x=1761741827;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G9wpds0Q5G9A4aTo8qFgm5iQqNbXf4bZi76lWbGL9sA=;
 b=fJnujw1aL65LwHxnjqH0hU79YO4J73jpFSx2RklGw/vo2HFWc8nDAM/RlllSSwRvWY
 PGvCFCLC94EJIG3Y1fL+pAH9dt57kcvlJol4tz7v9CQ6Kh80usrdkz1iPqy077P7THUP
 wi6ZThAPrRsgwUWKgWOpTjKcqZhR0tYpS6hRX/XQ4rpE/6JpNxYL0dqmRYNtDgtdx+G0
 yIQwVovjIOn+p7GOdPt5zetZBEW09JDb05Cbefdmk1BppSTJq+Xw7IUcv0sxtB+/rhik
 doeFaNEbqunNisy5vArubTdhxFmj1Lrr4g6wW+4X+8SchygRKCDUUrcjTNK2aq5lzrXk
 /rcw==
X-Gm-Message-State: AOJu0YzxVbA3P5QnFlmVUBxlF6krQX9TcSOVKWeMWxNLlBWPRuP5N9j4
 zrjwq4ZX8u+opjleq/g6I0AYrwRnbTGuPzAGXO5cIgXr9FVqBkztTxH2/DLGcVw/k8rK0u/DOTN
 TqFenKmQ=
X-Gm-Gg: ASbGnctVC42XccUW7KsGYGuFmyomKzWZ9XdL8SlZ37vvXPjp5q2NG3dW0s2mPUnpd/y
 lBo82uxUAKg0zF1ACSptbAaWjoRZQ4daex0KGaUXC+AnbqTpJ6HyTOzUPnkC32B6gU9uXekhcLi
 G1Y7fFQbahmeYsmjtT/oxPJmWaIfZH9dlUriOTp5fUSj8k2EYLQnNkGS/D/LXBpN/PjDINecWI4
 jeiF+xq14R0BR4x8IWHjH9Qs/oSRayb0/NWIHWzuCxEQr0OdM0pwTL1kuS3dOqYMs69o8a8z9+g
 EEH81m2NK1bCkbRHOtBcKsrn7A4/5tSFgQN0eYeAisjKWHIWqZw0lrHTT4ORvf9P4kjZ0fVbsFj
 wf/nxGOoQyZE5Aj8um7YqC6m1xLTtFoewxAs476z/plDt7v5UN9TTtl5ngPx4eNDeEXpgvAKCNU
 P+sXUEEAuwCky++IHbjS2isthfqlDqHtfxm7NZ
X-Google-Smtp-Source: AGHT+IGV8371cjx+ZRdyqDdid7iGv+FJy/JqDrInw16+kH4VlxZiPiFAcEc51h5V9CAn5zCKNmsMng==
X-Received: by 2002:a05:6a00:ac2:b0:7a2:183a:924f with SMTP id
 d2e1a72fcca58-7a220d2720amr25307752b3a.31.1761137027433; 
 Wed, 22 Oct 2025 05:43:47 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([189.38.141.22])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a22ff349bcsm14462590b3a.17.2025.10.22.05.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 05:43:46 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH] target/riscv: fix riscv_cpu_sirq_pending() mask
Date: Wed, 22 Oct 2025 09:43:40 -0300
Message-ID: <20251022124340.493358-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x436.google.com
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

We're filtering out (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP) from S-mode
pending interrupts without apparent reason. There's no special treatment
for these ints as far as the spec goes, and this filtering is causing
read_stopi() to miss those VS interrupts [1].

We shouldn't return delegated VS interrupts in S-mode though, so change
the current mask with "~env->hideleg". Note that this is the same
handling we're doing in riscv_cpu_mirq_pending() and env->mideleg.

[1] https://gitlab.com/qemu-project/qemu/-/issues/2820

Closes: https://gitlab.com/qemu-project/qemu/-/issues/2820
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu_helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 3479a62cc7..360db133e2 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -443,8 +443,7 @@ int riscv_cpu_mirq_pending(CPURISCVState *env)
 
 int riscv_cpu_sirq_pending(CPURISCVState *env)
 {
-    uint64_t irqs = riscv_cpu_all_pending(env) & env->mideleg &
-                    ~(MIP_VSSIP | MIP_VSTIP | MIP_VSEIP);
+    uint64_t irqs = riscv_cpu_all_pending(env) & env->mideleg & ~env->hideleg;
     uint64_t irqs_f = env->mvip & env->mvien & ~env->mideleg & env->sie;
 
     return riscv_cpu_pending_to_irq(env, IRQ_S_EXT, IPRIO_DEFAULT_S,
-- 
2.51.0


