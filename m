Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC831C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 06:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBqWu-0002dR-Ic; Tue, 28 May 2024 02:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.cheng.linux@gmail.com>)
 id 1sBqWs-0002d4-33; Tue, 28 May 2024 02:41:50 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eric.cheng.linux@gmail.com>)
 id 1sBqWp-0000gj-IL; Tue, 28 May 2024 02:41:49 -0400
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-1f480624d10so3943775ad.1; 
 Mon, 27 May 2024 23:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716878505; x=1717483305; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y1CZJFsdCS577hIoVhwsKkxxRgAGqh6uVY02avAIx7Y=;
 b=LGAsO1Rk8HiYS2nMLgWWGc8Ez9ZJlVGsBx/2Hh1iNsnWifxMheO4NCuQiCdJuCq6YK
 8XofHl83ot24LecaKgIKhKqrkEJ8bDw2IlOxE59tfsjuQMK09pmQPl7QhGM5nCLM9Cg9
 gAosDnNCYQE0q+UOM5ctVv5HTjvjAp+pZX9M/Jo733EpKoxjCiGCF6QkTIOT6RR0jKzW
 x1YKpjRRLSaLtFuyKzrX5U443jP3wbNhO/T/NLSEIMZDtA7TsPorWLc1iT0eNilVNryA
 D9XcSU5oRwzqdJzapPIpyfcz6qcMQdoHpEcAiUIl6CIoN2LKrd7uTjoyAtj8QmQvxK5u
 +N2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716878505; x=1717483305;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y1CZJFsdCS577hIoVhwsKkxxRgAGqh6uVY02avAIx7Y=;
 b=cIRC8Fo8Avf8EcwP/hfOaNl75GZQ9ebJWb4J/ooEp+BOGPe+MDhfjTfvYEZgCrFLU3
 /AW6Jdv4RVCXuV1AOsmmxgrGHo2GHhAiJqlEpNb/9YRcE6/80zIgUadfvw5mXfa9C6tk
 PrEVf3LXNyPjC+QpDBorD+vjv10+k0VrQZRb0v3syDjJwI+cwqpEK3OiN2NA1BDZnVQ/
 VN/NnsMCeLb3oGYIZCaR0To4cRSXezacXWjhLEuedFmPy8s0+Oswj31rd0q/wroTXL88
 /kgzckkYEPscfS34fHToOLuCdRwIUkOivDip5o39sspak8O6NaUxi2Clb7H6fCNE2rVj
 o2cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrklh9FNz1lPgMubhfXtzAwFJqu5iYU/JRby6EQzKDrEOTGwHePcbj4KpR6UFgArHn71Fz1YDkZaSdznjl+PHKWiGVNwM=
X-Gm-Message-State: AOJu0YzpmbKHZK1Q+TzE5iI5PZH9gzQ3/FyPc4Y/pDDMaEPjcH8Wllej
 ZG4okVzyjflwImX0X/HqWhRN4yaY/ckC38cSrjqwHf2BackAvk9h
X-Google-Smtp-Source: AGHT+IHbxYDDWTPkGa1A5Qzh5t5QC75ZGpWBpXgnppl/UJmPy/BJhYi7/4jDCdAV7sX5eAP0qIFNVA==
X-Received: by 2002:a17:902:c408:b0:1f3:29f1:76be with SMTP id
 d9443c01a7336-1f4497d8af4mr141356455ad.56.1716878505244; 
 Mon, 27 May 2024 23:41:45 -0700 (PDT)
Received: from [172.27.234.210]
 (ec2-16-163-40-128.ap-east-1.compute.amazonaws.com. [16.163.40.128])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f4850a62e2sm39847915ad.99.2024.05.27.23.41.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 23:41:44 -0700 (PDT)
Message-ID: <2d65afbe-a480-45b3-9357-52e49c0be1e6@gmail.com>
Date: Tue, 28 May 2024 14:41:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/13] hw/riscv: add riscv-iommu-bits.h
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 tjeznach@rivosinc.com, ajones@ventanamicro.com, frank.chang@sifive.com
References: <20240523173955.1940072-1-dbarboza@ventanamicro.com>
 <20240523173955.1940072-3-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Eric Cheng <eric.cheng.linux@gmail.com>
In-Reply-To: <20240523173955.1940072-3-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=eric.cheng.linux@gmail.com; helo=mail-pl1-x641.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 5/24/2024 1:39 AM, Daniel Henrique Barboza wrote:
...
> +/* 5.4 Features control register (32bits) */
> +#define RISCV_IOMMU_REG_FCTL            0x0008

Looks like doesn't support RISCV_IOMMU_FCTL_BE?
If so, need to implement it as read-only? along with other 2 bits.

IIUC,

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 1b34d226f9..6a6bf1db98 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2035,6 +2035,7 @@ static void riscv_iommu_realize(DeviceState *dev, Error 
**errp)
      /* Set power-on register state */
      stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_CAP], s->cap);
      stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_FCTL], 0);
+    stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_FCTL], ~0);
      stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_DDTP],
          ~(RISCV_IOMMU_DDTP_PPN | RISCV_IOMMU_DDTP_MODE));
      stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQB],


> +#define RISCV_IOMMU_FCTL_WSI            BIT(1)
> +
...


