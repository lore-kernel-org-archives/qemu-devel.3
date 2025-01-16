Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C622DC02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 12:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYPAU-0008N9-Hv; Thu, 16 Jan 2025 07:40:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tYPAS-0008L1-8E
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 07:40:12 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tYPAP-0003Yd-Qb
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 07:40:11 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3eba0f09c3aso298301b6e.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 04:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1737031208; x=1737636008; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/xLMPzQyXvXz+ptTxrogISCmzpKSoUCycg6DigtV/0s=;
 b=Ih6OsqVLijThMMeKqBqvoIduxeNNg1NYkMmceViPMTRPVk2HbOGRzH/pwMbKResTVc
 R5v6p1l/8fsKaI8vr50oT6lnnyaDj/+sDcpSTU3s+ewuXDBUkbSknkUuYMcf8TEaFQk8
 DdvrOmXKTZPoYs0GxxcbvBNPpHCzKyuA4UlkKwEIEU91V72VslvMVMs8NWP0H9KdLCWd
 f1R4SmbnH2udhdvqory77IHesp8h4S7hDR5w1exB2V/2dxCGbM6quv1a3FehmtJp9kkM
 r/COJDwQ4zZKnccjDLzEtE+7Vqhl9r7AAoeJ17sfL2rSG65PSL2pXHja891xzGpeEf/O
 5EhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737031208; x=1737636008;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/xLMPzQyXvXz+ptTxrogISCmzpKSoUCycg6DigtV/0s=;
 b=WgF9/BELmu+NOVwrV9ubRDHqVQ7HTiTmqiO4+WrhoGo38XdZvMsaIuLCpx6GuxXv2u
 9MT5AkxcGrike+QaYMnRQjBGcx1Ap6lbs7ZqJHetYj3pn/z9zwyiW9kq4AibfkK2UP52
 BxoNgn8zVQek6PDLo04Lr1N9KRcIw3yfHP/bXE80pwOfYrRwbb73onJBLQ6f2YSi5f3z
 y1inoShs+OLW8j/nVSTIb32QkgJwaiuGJ2/Ex9fJDq7GoNztWJr2O2+QPzVvR8+FqVhR
 Yg5kAkblxJZO3mR6UQFgOlFv4CIsKOo+bF1Shss2APTmktstD1bzs/BzUOFgfC8GM+G5
 4D2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUUAChxoRF6fWxf+cGc80uWNnPYSKkf8l1OFI8fUTqcUGTOg+z1vRpQe/BkX4pjXTYVtoyEv7TKO+g@nongnu.org
X-Gm-Message-State: AOJu0Yx5mEyXQ4olEhNNXPmjt9Av4YkqNUitE8ybRBIiikLi6UZv83+V
 dS6guThrWMAvD80LuWeiXDJDW36U8cxKHYWVy0eUJnc5+1DepRJ3ANIRtnoOkas=
X-Gm-Gg: ASbGnctSsObVIanA+xDUFfMn+9tD3b5kAIAmg32LlOq+u6ejbYDOCZcrTRxaX0amhbR
 aBPw/qkIH3iAzWap2rtVnZAMOflMFa2+z6VmIGOzpZaeOQwZi3I4qexeFbNkEdzknCixQM1463D
 caC6w22GY6wJ/dzWANCPUyEdpUVnIpvkEIBaVBfXteUbDsEFV1tKUfCXs7h9L0Uvw2tbhC8KRB9
 MqhaU7hJcSXtV1WlZ7OnsUVE2WYPaqBWoVT+QGsXY/G18W/0cwjtG1Q6AqIF+FHn3bNfz4=
X-Google-Smtp-Source: AGHT+IGgHS/6K4vVArbsqvsK43X2vjugxb7ooK9bPwwSrTaLiv6t8ZLpA5XZYfA1IRd+1OAT0Wr4WA==
X-Received: by 2002:a05:6808:3a18:b0:3ea:6415:c44 with SMTP id
 5614622812f47-3ef2ec6c3bdmr24815637b6e.8.1737031208342; 
 Thu, 16 Jan 2025 04:40:08 -0800 (PST)
Received: from [192.168.68.110] ([191.202.238.10])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f03769a5aesm5759635b6e.28.2025.01.16.04.40.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 04:40:07 -0800 (PST)
Message-ID: <60002f0e-559b-4c00-92b2-a1e5928b20ea@ventanamicro.com>
Date: Thu, 16 Jan 2025 09:40:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/6] hw/riscv/riscv-iommu: Allow PCI hosts with
 iommu_ops registered connecting to the IOMMU
To: Jason Chien <jason.chien@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:MCIMX7D SABRE / i..." <qemu-arm@nongnu.org>
References: <20241216004857.9367-1-jason.chien@sifive.com>
 <20241216004857.9367-5-jason.chien@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241216004857.9367-5-jason.chien@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x22d.google.com
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



On 12/15/24 9:48 PM, Jason Chien wrote:
> pci_setup_iommu_downstream_mem() is called to set the downstream memory
> region of the PCIe devices.
> 
> Signed-off-by: Jason Chien <jason.chien@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


>   hw/riscv/riscv-iommu.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index e9a0775d6e..f5d53a36b2 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2436,6 +2436,14 @@ void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
>           QLIST_INSERT_AFTER(last, iommu, iommus);
>       } else if (!bus->iommu_ops && !bus->iommu_opaque) {
>           pci_setup_iommu(bus, &riscv_iommu_ops, iommu);
> +    } else if (bus->iommu_ops && bus->iommu_ops->set_memory_region) {
> +        /*
> +         * TODO:
> +         * All memory transactions of this bus will be directed to this AS.
> +         * We need to distinguish the source device dynamically.
> +         */
> +        AddressSpace *as = riscv_iommu_space(iommu, 0);
> +        pci_setup_iommu_downstream_mem(bus, as->root);
>       } else {
>           error_setg(errp, "can't register secondary IOMMU for PCI bus #%d",
>               pci_bus_num(bus));


