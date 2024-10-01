Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCDECF318A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 23:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svm63-0008Aa-0t; Tue, 01 Oct 2024 19:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1svm5x-0008AH-2C
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 19:15:54 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1svm5v-0000m0-Nu
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 19:15:52 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7e6afa8baeaso5195542a12.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 16:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1727824550; x=1728429350; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AEQyh70Abv6mHX9uoHzYe8U9lRPr/nBUDARMG9BkecA=;
 b=o+4rxKaBFZ1xBHhm5maC5vEwxJApqDpFUQltP/IMh3dBxnqJUmdxhzcEaooGcRmL35
 LGNlRGA5in4lGJYvTryS+uhq3afo8XVFBxmBVw4OXgkSdEjZMhmB1nMRjBw6HSD9O57H
 5CzM267Nfz8NWkoHizNb1rKrrqr1C4xwWg2hMk6I2r6SFm43i/N94Wbote73VguMVbL4
 z4YFcfSgRQPjhJaj8g6aylqakqixURGg6N2b4YMy0QQuZWmmdPsSu8XqI1nvGcUgTd7q
 g9CIfT3J3sRI7TLRFm/wphH/yJMbBAVM2wO1JQK8GP026Kx2yym/QlPTl7kg3b4tG01+
 1bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727824550; x=1728429350;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AEQyh70Abv6mHX9uoHzYe8U9lRPr/nBUDARMG9BkecA=;
 b=IZLc/cemVU6x5t1SIC+AhDDh/Qh38TYXdSL1w0k5/5KX+zgc/VFjFado7+duLn9p5M
 5J6Nh7ZFWJzzY+oPYlQdS5Rug5LbNSnvXmLenMTbzUQXeV95LzV3l3YhH+66Y+ZMdYV7
 Etl3i/gPMxBYR/j02uFxZR56eb5B3Z3LxGH4wVEsShB0sCcUXVamdZ4JfLuic+mnlj4k
 ZdaEp1YOffmRcO0+CQqG1TdAm5c4mxF62ZTSn6xMEgilkseg3yWAIwsa2OQmhB1ZA8qk
 wPmcdOd/JSxAB+RQEaL3kUdQbR3xLjGJy7zI3ZowwxxJMylv+1hV3BEaJnV8ejoeh1Eq
 cQfw==
X-Gm-Message-State: AOJu0Yx2zb57qDxGeAdYh13VuzBm0gPZbq7whzcRWWFr3zJQeDn7T3vq
 6hXVcLvSJasnK3bzslOFRjcoyg8rXvrGu5fli4xUK7dnBWRnuM4pcyGyCEPNICs=
X-Google-Smtp-Source: AGHT+IGnCtO6N6Yq63xSCWKZxqjdgLQIFEHtJiSsX4GuL0ylciByg1q/OFHtCWd+9gV1wks0QkhtOg==
X-Received: by 2002:a05:6a20:3b9a:b0:1d6:236f:bd6b with SMTP id
 adf61e73a8af0-1d6236fc3b4mr1653375637.0.1727824550065; 
 Tue, 01 Oct 2024 16:15:50 -0700 (PDT)
Received: from [192.168.68.110] (200-206-229-93.dsl.telesp.net.br.
 [200.206.229.93]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e6db2b9407sm7690703a12.23.2024.10.01.16.15.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2024 16:15:49 -0700 (PDT)
Message-ID: <feeea774-3031-4a02-be92-4031d08afce6@ventanamicro.com>
Date: Tue, 1 Oct 2024 20:15:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 16/47] hw/riscv: add RISC-V IOMMU base emulation
To: Tomasz Jeznach <tjeznach@rivosinc.com>,
 Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Sebastien Boeuf <seb@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
 <20240924221751.2688389-17-alistair.francis@wdc.com>
 <CAH2o1u474YJPaxkA24-JE5XpuF=3UnOMP2iWHbCu=FxTf_SvNA@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAH2o1u474YJPaxkA24-JE5XpuF=3UnOMP2iWHbCu=FxTf_SvNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x536.google.com
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



On 10/1/24 7:24 PM, Tomasz Jeznach wrote:
> On Tue, Sep 24, 2024 at 3:18 PM Alistair Francis <alistair23@gmail.com> wrote:
> 
>> +
>> +/* IOMMU index for transactions without process_id specified. */
>> +#define RISCV_IOMMU_NOPROCID 0
>> +
>> +static uint8_t riscv_iommu_get_icvec_vector(uint32_t icvec, uint32_t vec_type)
>> +{
>> +    switch (vec_type) {
>> +    case RISCV_IOMMU_INTR_CQ:
>> +        return icvec & RISCV_IOMMU_ICVEC_CIV;
>> +    case RISCV_IOMMU_INTR_FQ:
>> +        return icvec & RISCV_IOMMU_ICVEC_FIV >> 4;
> 
> Please add missing brackets to fix operator ordering bug. Here and for
> PM, PQ cases.
> It should be:  return (icvec & RISCV_IOMMU_ICVEC_FIV) >> 4


Nice catch. Changed in v8. Thanks,


Daniel

> 
>> +    case RISCV_IOMMU_INTR_PM:
>> +        return icvec & RISCV_IOMMU_ICVEC_PMIV >> 8;
>> +    case RISCV_IOMMU_INTR_PQ:
>> +        return icvec & RISCV_IOMMU_ICVEC_PIV >> 12;
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +}
>> +
> 
> thanks,
> - Tomasz

