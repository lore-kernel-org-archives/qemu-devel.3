Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A3CD767D8
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 16:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Xap-0001Rh-Vg; Thu, 31 Oct 2024 12:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6Xam-0001QJ-H8
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 12:00:12 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6Xaj-00070H-ES
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 12:00:12 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e2e88cb0bbso849920a91.3
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 09:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730390407; x=1730995207; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qs3xNgUSQQcOcNqOrruuArV+bArrHOw5PL6xS6xMqcs=;
 b=MWifq30VdRr3hddQCKLBtqBaR4VinrgH4he9bvH7BxkE7vX+d53DANXkck11dhDMS8
 1YDZ4BU/c243UwKLHB7JmkSiae4p5NEPYwmFn+ciVyX5HRxqKy3sk7P8CsPk67mUoh7h
 Cbb110c3Zv8LIxqj+b5T5/QpCA533N2DlOKowmsOFq4GNxEwafxy0uGXAQEWorbAPrv5
 Kv1Ppzpc9jiiF8jAd+tKNtBG20bspFmNAMJN4uASH+RL6UWSeUGTPq9CMfkaG3JiJV67
 kKBRS8VY8uO4RK2IIlWiWCX6cVJQ0fVHdVkL4OfYlhTHv9hRN0ghRl06VpXPKw1HefBj
 pjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730390407; x=1730995207;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qs3xNgUSQQcOcNqOrruuArV+bArrHOw5PL6xS6xMqcs=;
 b=qx4qSbpslKbntP3szEdXE7YW2XBOSIuoOVar1kLRkNFJRWy9w7Bq333wwAh7v760we
 lfHmz+/hArpgYwAmZkKGh42HhsJhNiFZSK6wS6+55mPRYpsaIvH1PV84HgBEriUkKgDI
 jPmPD4FK8KAQkdp4H5bWj7q93Bvbo4Ly8kqcTQTwla85j9HnjcZWEayBpSSU0bMJuEhL
 6h6AcEOECOUuYAJvdl+9sOY7rUunYit82jXhOhPh/M3c4BSib7MHPSptXkH4DMDljfTJ
 cts2U15cSZacs8oXcmAx/wOm1+Yg6rX9e7Rp08puFLmomVcm6jnuzhMzsRqzwynIvY1T
 IjLQ==
X-Gm-Message-State: AOJu0YyzFQu6Fk3HIZh9qQNucVpHOAxcmNkYnnEw5ztaCyHgBRWgyWuv
 yjQXI9ylTXd3w5wD46U6T1Zz+yLXlNcUDtCdZ4aaeucTDEn1cprC404j8pvu0+q3bKnIOrE4fc7
 nXrY=
X-Google-Smtp-Source: AGHT+IHFePjYlx8yUS6uqa/0zDhWkd2H25rlFvqBzK665l4H7AsHuhObsc1uGlAvl9GepfUXoNU1aw==
X-Received: by 2002:a17:90b:3003:b0:2e2:c6a6:84da with SMTP id
 98e67ed59e1d1-2e8f11dcd91mr21593068a91.34.1730390407039; 
 Thu, 31 Oct 2024 09:00:07 -0700 (PDT)
Received: from [10.0.12.195] ([190.210.133.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e93daac4f1sm1311327a91.15.2024.10.31.09.00.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2024 09:00:06 -0700 (PDT)
Message-ID: <8caf45e4-0be8-46aa-923b-402c80f74060@linaro.org>
Date: Thu, 31 Oct 2024 12:59:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/riscv: Add Microblaze V 32bit virt board
To: Michal Simek <michal.simek@amd.com>,
 Alistair Francis <alistair23@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20241017072507.4033413-1-sai.pavan.boddu@amd.com>
 <CAKmqyKNfoakaJ66PCN49x5+=gVkAnQVV1UWTdPe7ARr3RA8ouA@mail.gmail.com>
 <7dbcb2de-89f9-445b-a096-2a3d03a2dfe7@amd.com>
 <34d6acf1-2106-481e-a016-375e697f31cf@linaro.org>
 <47b60bf0-e43e-43a6-b9d7-0d072cd8d4ad@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <47b60bf0-e43e-43a6-b9d7-0d072cd8d4ad@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1033.google.com
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

On 31/10/24 05:43, Michal Simek wrote:
> Hi,
> 
> On 10/31/24 05:06, Philippe Mathieu-Daudé wrote:
>> Hi Michal,
>>
>> On 30/10/24 02:53, Michal Simek wrote:
>>> Hi Alistair,
>>>
>>> On 10/30/24 03:54, Alistair Francis wrote:
>>>> On Thu, Oct 17, 2024 at 5:26 PM Sai Pavan Boddu 
>>>> <sai.pavan.boddu@amd.com> wrote:
>>>
>>>>> diff --git a/hw/riscv/microblaze-v-virt.c 
>>>>> b/hw/riscv/microblaze-v-virt.c
>>>>> new file mode 100644
>>>>> index 00000000000..6603e6d6b06
>>>>> --- /dev/null
>>>>> +++ b/hw/riscv/microblaze-v-virt.c
>>>>> @@ -0,0 +1,181 @@
>>>>> +/*
>>>>> + * QEMU model of Microblaze V (32bit version)
>>
>> Is there a 64-bit model planned?
> 
> This guide is talking about 64bit too
> https://docs.amd.com/r/en-US/ug1629-microblaze-v-user-guide

Same board, different core (synthesized with C_DATA_SIZE = 64).

> It means answer is yes. And pretty much this generic model with the same 
> layout should be possible to use with generic 64bit version too.
> 
> I expect that means that default_cpu_type should be TYPE_RISCV_CPU_BASE.
> and Kconfig should be extended
> +    depends on RISCV32 || RISCV64
> 
> Also some small updates in documentation to cover it.
> 
> Is there something else what should be updated?

No issue, I was just checking.

Regards,

Phil.

