Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98D2D5AE60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 04:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8tr0-0006D9-GS; Wed, 06 Nov 2024 23:10:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8tqx-0006CK-6R
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 23:10:39 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8tqu-0004y9-Qg
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 23:10:38 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20e576dbc42so6178765ad.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 20:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730952635; x=1731557435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t3xiDZGW84+HFKspjqejAIoAcK1hZiO7AmVUxpMLLxQ=;
 b=h9wWqwozIT8nfwS2rqBJOjgf49mdH4bD77w7ZC3ZxA08w2JqeJNtLD0irTlZtMwHnf
 YwzTGEBiAqgrn5Ns4TtvQBh+txC45GjSkOwf3tPsTxlRV6PQvAisNDjs0oApG/NX7KQb
 mAxlnynvrPLHjMl+DS5Va1GbMA39ywhCrwoZbFpdrOsUCOYMQiZ0PgW/eBnYwimeLnlw
 fLDGm7Jf13yx0VMtMAEjX2J3zftquwEj+93qasrEyjGznDtONSOzLjcXMymPCQ5wojWl
 RD8hL2Mr8ULZ0PALHDpxUNiVWyf70MYhSXVNdUHI+kFXONXHBK7foWjaowV0P2/MZOYl
 ZiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730952635; x=1731557435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t3xiDZGW84+HFKspjqejAIoAcK1hZiO7AmVUxpMLLxQ=;
 b=oW9Hxc5uQUD6syqy18H30Zg8a35X0vkfGZWFT5uO/PDOLf+yP2O5G6uMgbXkl36Puh
 D3Fa4zGhk0+PaqVSY2obA0qYEIyShBNwgl8s6vjuPUyTIT8+wEdGqJoMiBJapY2EciZC
 05qFR9tcBGvPCxekwhGf1ZDW4P9cOwM3EuKnkd8ulQhMAuEhwkBWnwcxodCU38fYPlpG
 cFQ5UpKOqYJn95up4yZWKWrVdoSKmWxHozCb96xAXkxR4NgFaT65B+jteaEBQwLYNszk
 lCpIzwDEyMmMTqPc1ifO3txWQXNrbpcruQgBHrfBUjL7HtYs2GAP6yCWJBlzugBj9INL
 TJ8A==
X-Gm-Message-State: AOJu0YzA0bSC1X5E3WWMjC0AdLM6HbLdONjURbDX6IsTnsEhnRIlFvsj
 VpL9MFaq4NA1HW8JJ0X9rVfspaeDNgOKP9mBgF8SLiqd44j/ATDw179gfQ==
X-Google-Smtp-Source: AGHT+IHNtvT9BL398Vx9Mk4YZwkeLLxbH4aNbndbbTcyzuwjHRO70WUCcZcI8QWdJxzoBRWMyZmXGw==
X-Received: by 2002:a17:903:2308:b0:20c:d469:ba95 with SMTP id
 d9443c01a7336-211785e3373mr6790915ad.16.1730952635067; 
 Wed, 06 Nov 2024 20:10:35 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc3f12sm2789105ad.9.2024.11.06.20.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 20:10:34 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 03/12] hw/riscv/riscv-iommu: fix
 riscv_iommu_validate_process_ctx() check
Date: Thu,  7 Nov 2024 14:10:07 +1000
Message-ID: <20241107041016.40800-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107041016.40800-1-alistair.francis@wdc.com>
References: <20241107041016.40800-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

'mode' will never be RISCV_IOMMU_CAP_SV32. We are erroring out in the
'switch' right before it if 'mode' isn't 0, 8, 9 or 10.

'mode' should be check with RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV32.

Reported by Coverity via a "DEADCODE" ticket.

Resolves: Coverity CID 1564781
Fixes: 0c54acb8243 ("hw/riscv: add RISC-V IOMMU base emulation")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241104123839.533442-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 164a7160fd..bbc95425b3 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -820,7 +820,7 @@ static bool riscv_iommu_validate_process_ctx(RISCVIOMMUState *s,
     }
 
     if (ctx->tc & RISCV_IOMMU_DC_TC_SXL) {
-        if (mode == RISCV_IOMMU_CAP_SV32 &&
+        if (mode == RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV32 &&
             !(s->cap & RISCV_IOMMU_CAP_SV32)) {
                 return false;
         }
-- 
2.47.0


