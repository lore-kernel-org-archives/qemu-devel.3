Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB700C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 22:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEz13-00041G-GN; Wed, 05 Jun 2024 18:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sEz12-00040s-7U
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 18:21:56 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sEz10-0008RX-NG
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 18:21:55 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f480624d0fso3268035ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 15:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1717626113; x=1718230913; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UbXbfJEPM1hcGvOH6+i6llvTeRYAXReonct82lRs0C0=;
 b=ajx5z00LreLE8ePx5hBIoDhkVIUqa3KikAxPBLBecHxuvETe0/RK38R/I1FUiLFfWe
 0sTE8mEgAUCom+HxsVhXkNLiBZ0as0hyuB8aOm+CAz2hPah3d7FA3P6QhB0YPk21TZ3c
 7kDXLj8OO/jXN2+BnVuECnyxhMP1sAON3+tRopnHKqO9j3cNgqEbtnU1n1LPhsaZ5L/f
 4ywxXgx60ZoJTkLx53qPugSJqEl3j+RdsFurwVO+ZLMid5suR0eOMfVLiWD2/eTw/0Md
 KnDU/NEBV9/DUI4MX1XhjSmQxuXlHWHfUkLMiJ4//EoKNcg0O0lIvRAy7BqjonKXl1Ve
 Chqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717626113; x=1718230913;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UbXbfJEPM1hcGvOH6+i6llvTeRYAXReonct82lRs0C0=;
 b=Oqmf8VESkIiwSS8FLi1RF0jrXXSfa1QbxCAo5uKghhEeMZCFVMr1UsUpJI9d+SzzlB
 pypva/8+VVKOGeTo7H2JMjLFBiKZMVkKOWP+VIA+fJ3GECHGNqHc/D7kq+H/zSFnquMq
 f+W0iTUTqq3+kA0EErVTWfMNC1fUMNPJT9Sricv+/qNfMI/Muw7pAS7AVxqex8EV4E5B
 gtRAYQpJ7hDmifWuseHRRaEj5RN7+F4T9045LUIzoIpwzHKp532kkbLO3+NTd9g4tilJ
 4YMAza4RQdPImniPaZMxUknpA/sjpQQwYDE1ORddc7R0hCJLjDj+nO9nbiGJ/nJAzhUp
 cS/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmIdobMf8F2D62QzaAnH9fjpuGdDFLpultdzawh6s5TIn0JWOq9lX96AWKBTb9PQE5H5xPOVFS0ddHnZ4YcjZeumo9tZo=
X-Gm-Message-State: AOJu0YxxD4M5Gl9q1ceQYN5brboB9RHX7t3jb5s3rXB2Ex9m2Vu0BOah
 bEHNnBYBXtYQMSlN+38i8WH4ks9ZkvmhjWceNdnJAxC9CuhLpkr+9l7iZH/Hn5M=
X-Google-Smtp-Source: AGHT+IGh1aQ4PzWeJJW/0fA55tRl3Ny5kLj+CMd7WNjA+x3n5HXAU7OUb/wz316NrxqUzshKfu2c4A==
X-Received: by 2002:a17:902:d4c2:b0:1f6:20f4:196a with SMTP id
 d9443c01a7336-1f6a5a161admr45671725ad.32.1717626112687; 
 Wed, 05 Jun 2024 15:21:52 -0700 (PDT)
Received: from [192.168.68.109] (189-69-160-78.dial-up.telesp.net.br.
 [189.69.160.78]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd7ccf33sm409815ad.125.2024.06.05.15.21.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 15:21:52 -0700 (PDT)
Message-ID: <502c0b60-21b4-4a5d-9458-32bc1ac3b3fb@ventanamicro.com>
Date: Wed, 5 Jun 2024 19:21:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/13] hw/riscv: add riscv-iommu-bits.h
To: Eric Cheng <eric.cheng.linux@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 tjeznach@rivosinc.com, ajones@ventanamicro.com, frank.chang@sifive.com
References: <20240523173955.1940072-1-dbarboza@ventanamicro.com>
 <20240523173955.1940072-3-dbarboza@ventanamicro.com>
 <2d65afbe-a480-45b3-9357-52e49c0be1e6@gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <2d65afbe-a480-45b3-9357-52e49c0be1e6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 5/28/24 3:41 AM, Eric Cheng wrote:
> On 5/24/2024 1:39 AM, Daniel Henrique Barboza wrote:
> ...
>> +/* 5.4 Features control register (32bits) */
>> +#define RISCV_IOMMU_REG_FCTL            0x0008
> 
> Looks like doesn't support RISCV_IOMMU_FCTL_BE?
> If so, need to implement it as read-only? along with other 2 bits.


Good point. Just set RISCV_IOMMU_FCTL_BE in regs_ro mask. I'll also set
FCTL_WSI given that, at this moment, we do not have wired interrupt
support (the riscv-iommu sysbus device will support it later).

FCTL_GSX is declared and used in patch 8 so we don't need to set it
as read-only. Thanks,


Daniel

> 
> IIUC,
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 1b34d226f9..6a6bf1db98 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2035,6 +2035,7 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
>       /* Set power-on register state */
>       stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_CAP], s->cap);
>       stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_FCTL], 0);
> +    stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_FCTL], ~0);
>       stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_DDTP],
>           ~(RISCV_IOMMU_DDTP_PPN | RISCV_IOMMU_DDTP_MODE));
>       stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQB],
> 
> 
>> +#define RISCV_IOMMU_FCTL_WSI            BIT(1)
>> +
> ...
> 

