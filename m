Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA4CC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 14:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpU62-0003RM-IY; Wed, 27 Mar 2024 10:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpU61-0003Qn-Bp
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 10:17:41 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpU5z-0000Ok-QO
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 10:17:41 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-56a2bb1d84eso1645048a12.1
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 07:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711549058; x=1712153858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YrN2TiabhmRyI9HcWwqOzKKM88od4U5ulMzv3IN7/WY=;
 b=er4fynFHfTwvUAhypodsiWGYIS8Ohziv65LzxJZbviCGUL8PW4lAYj/hFMtYk4sTg7
 Ea2n0YQjE1pfkA6CFw9v5UicsafXsF1dtCckoKucYyur3thvb21Ahb4akKJ1j4TAIgRC
 ArZBKDIMUy5GtpaBqKovzthKyr9x9+Tc63sLyZEhRuCvTi6cdtxgX4n+JuE8VPA4FFGB
 qXf5jvichL3FXQXdQJLD5BIPczMmazOi+RfkXljnzWeq1wH3VeA/djubQIOmr/Oeds5v
 HXMQu28xF1jl2HRqbIiutAHb2F9AsLsuKc1uaEIjZllIY3AN762QKdRdqt8sWp9RE696
 HAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711549058; x=1712153858;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YrN2TiabhmRyI9HcWwqOzKKM88od4U5ulMzv3IN7/WY=;
 b=m2YSFJfswu2le0Rvb0uaWYoAXwAOkCi9Ek5geyy7TpP17TkckRLnE4cuZz9YUyW8Ep
 G20DaljkpsvPrcWUfNeSvkLKacl4P6w93ytbG4l6iM6yw31t/cgsfnVPP1kYPQvgyvhf
 Z8MZpBVSUv+yxflc2pWX7X3KO3hcB4he38VWQPkkMmm+38hh9t/JfcAirS8/3S4oaCfL
 9jlevG7bTkv9PfD5bU/rNGWQhIdnJ9R3dE8muDLawUUGFvQ3R/NHqxOjjGUvpjFS41KO
 I4wYyu+zQ8gAvRVYJ1/m722MEZZp3XGDk5NgyyTBS7EFwiuPwg2OcFt5zCYzwQ70nTJw
 OXDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVx/qg8PvsB71s1QQppoUCR1u408eIzyAm485U/O0fxe256MQgRTB8Y80H5yKL8cu0/qsKmo5oPA64B3TA4qpR3pu9ai8=
X-Gm-Message-State: AOJu0Yy2NvTafgh1apRWf+b/1O/8lOj12PSvSiqucqUORY7qtfbpJt9W
 HHhoh6Do29cgauCAKmxTfv1bZaMYmthA2AfPhCxZ1AEpsgKq/ZQ4IsOQDVC7KwY=
X-Google-Smtp-Source: AGHT+IGWdIEzawrGYP4x6Ik51f4FOstO69KAiCfdNB6dnMHwytZodFAmmX+pQKWCabrocVvJwCBRMg==
X-Received: by 2002:a50:8a8a:0:b0:567:e0e:dda5 with SMTP id
 j10-20020a508a8a000000b005670e0edda5mr38598edj.17.1711549058213; 
 Wed, 27 Mar 2024 07:17:38 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 j26-20020aa7de9a000000b0056c08268768sm4171537edv.10.2024.03.27.07.17.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 07:17:37 -0700 (PDT)
Message-ID: <c7af214f-c446-4092-aaad-017a4d3ea2a8@linaro.org>
Date: Wed, 27 Mar 2024 15:17:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 10/21] hw/smbios: Remove 'uuid_encoded'
 argument from smbios_set_defaults()
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 devel@lists.libvirt.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Song Gao <gaosong@loongson.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
References: <20240327095124.73639-1-philmd@linaro.org>
 <20240327095124.73639-11-philmd@linaro.org> <ZgQoTF3FUOpIZAix@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZgQoTF3FUOpIZAix@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 27/3/24 15:08, Zhao Liu wrote:
> On Wed, Mar 27, 2024 at 10:51:12AM +0100, Philippe Mathieu-Daudé wrote:
>> Date: Wed, 27 Mar 2024 10:51:12 +0100
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Subject: [PATCH-for-9.1 v2 10/21] hw/smbios: Remove 'uuid_encoded' argument
>>   from smbios_set_defaults()
>> X-Mailer: git-send-email 2.41.0
>>
>> 'uuid_encoded' is always NULL, remove it.
> 
> It's a boolean, so,
> 
> s/NULL/true/.

Oops, thanks ;)

> 
> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/firmware/smbios.h | 3 +--
>>   hw/arm/virt.c                | 3 +--
>>   hw/i386/fw_cfg.c             | 2 +-
>>   hw/loongarch/virt.c          | 2 +-
>>   hw/riscv/virt.c              | 2 +-
>>   hw/smbios/smbios.c           | 6 ++----
>>   6 files changed, 7 insertions(+), 11 deletions(-)
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 


