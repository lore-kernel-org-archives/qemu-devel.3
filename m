Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6901BC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 15:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKJlc-0003Ea-Nb; Thu, 20 Jun 2024 11:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKJlb-0003EA-PQ
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:32:03 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKJla-0001Ut-0T
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:32:03 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-424720e73e1so8986415e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 08:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718897520; x=1719502320; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wSAA01ELNxgIGxuLWBbFGxIiTlI22d605+ok6En+1yo=;
 b=Aqb+xOenD+Ml0mxFledae7BV9DU5dI2QN09Fc3erM07Eer1c+PuuzlTQGmqJ3DYFyY
 jAkWUFnC5kFPNKmMVIq6z1th3aitVcSgKAgRnJ1udmtY3MLCdkJqBQPaupJZcH9pTXtt
 kc0tmqAnQU4ljrftoGfkRC9A7Mt+XlPN0l7tM8CNwz+sE2ELt+vJGwVa3No+bW6zPx0K
 o3oNCVJ0kOoqB84yGmi2ABcMb3ZNG49KWYx9ix9hvnGa06KMACJoHIOmNx0D72bplX2C
 4e0fIU+YFBxiY7bxM34LXn/gtVMnvW2kzniBazNS0resINc/lDFreBRjs2Y3J8g6eIST
 2JIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718897520; x=1719502320;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wSAA01ELNxgIGxuLWBbFGxIiTlI22d605+ok6En+1yo=;
 b=bd5f2bf9/MpoP6erbdSEczfK6UJU9hrKE+QdA/mK4h6uBIvmsY5Q3/mdIVqy4f8zm/
 3XgG2L2eJkN+Mz9lAMoGmHmJi5Hi6QuUQT9odmiaJsgGKAwu6liy4hinMlbgi+MUuIC9
 Dw9Udir+nqrsKafvhFSrFOvyYlhHlMIrCRkyzrqh0kpC0FHGn7tyG/ghM8BA3KdIBBw9
 sfjvdZRt3q7OLrTn7V9h+fbkQZg0ajLe8XdpMmlthtsFSzi2O7H7WpqU59rfzTQZVD2D
 j9SkI5BAgn3gIiIyu4fYVnQ4Lv4/4RCAYnQztc+0Qco0LO/NHAAiIN2En+OQjjgcwgjh
 +diA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrgNu1pnWT2/rhHR+wjasWu6OZuqobHn8AooEW8mhWVWxUqqg0rQdlpn5gLPbgu+jw/E5eRbOGS1HGwvDMNCAFFMYp/Vg=
X-Gm-Message-State: AOJu0YwvzaFkOCZZvkXAGeie7QT8vvgyy5HbbYch4ClQp0xk0+NRItxi
 wONeW47yq27VJKmqqBJJ73yiZCHVbHlvCRd2dehX+UMsEJsrn+Bdt3N73DPhhJ0=
X-Google-Smtp-Source: AGHT+IGw7F5u8PReGLBAcBgF0an4vLI28GJX9HM8OQZIOdWl6XeisbmfpLvk5+Z+/qdMpi775sp5Xg==
X-Received: by 2002:a05:600c:5c4:b0:421:5ada:c137 with SMTP id
 5b1f17b1804b1-4247529b439mr45318865e9.33.1718897519600; 
 Thu, 20 Jun 2024 08:31:59 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.151.40])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d212254sm29391105e9.45.2024.06.20.08.31.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 08:31:59 -0700 (PDT)
Message-ID: <86fe9f27-6289-4918-a30e-c9577495a21c@linaro.org>
Date: Thu, 20 Jun 2024 17:31:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hw/gpio/aspeed: Add reg_table_count to AspeedGPIOClass
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Zheyu Ma <zheyuma97@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240620140239.375338-1-zheyuma97@gmail.com>
 <6a817f44-27fe-432a-8118-bbcec790535f@linaro.org>
Content-Language: en-US
In-Reply-To: <6a817f44-27fe-432a-8118-bbcec790535f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 20/6/24 16:20, Philippe Mathieu-Daudé wrote:
> On 20/6/24 16:02, Zheyu Ma wrote:
>> ASan detected a global-buffer-overflow error in the aspeed_gpio_read()
>> function. This issue occurred when reading beyond the bounds of the
>> reg_table.
>>
>> To enhance the safety and maintainability of the Aspeed GPIO code, 
>> this commit
>> introduces a reg_table_count member to the AspeedGPIOClass structure. 
>> This
>> change ensures that the size of the GPIO register table is explicitly 
>> tracked
>> and initialized, reducing the risk of errors if new register tables are
>> introduced in the future.
>>
>> Reproducer:
>> cat << EOF | qemu-system-aarch64 -display none \
>> -machine accel=qtest, -m 512M -machine ast1030-evb -qtest stdio
>> readq 0x7e780272
>> EOF
>>
>> ASAN log indicating the issue:
>> ==2602930==ERROR: AddressSanitizer: global-buffer-overflow on address 
>> 0x55a5da29e128 at pc 0x55a5d700dc62 bp 0x7fff096c4e90 sp 0x7fff096c4e88
>> READ of size 2 at 0x55a5da29e128 thread T0
>>      #0 0x55a5d700dc61 in aspeed_gpio_read hw/gpio/aspeed_gpio.c:564:14
>>      #1 0x55a5d933f3ab in memory_region_read_accessor 
>> system/memory.c:445:11
>>      #2 0x55a5d92fba40 in access_with_adjusted_size 
>> system/memory.c:573:18
>>      #3 0x55a5d92f842c in memory_region_dispatch_read1 
>> system/memory.c:1426:16
>>      #4 0x55a5d92f7b68 in memory_region_dispatch_read 
>> system/memory.c:1459:9
>>      #5 0x55a5d9376ad1 in flatview_read_continue_step 
>> system/physmem.c:2836:18
>>      #6 0x55a5d9376399 in flatview_read_continue system/physmem.c:2877:19
>>      #7 0x55a5d93775b8 in flatview_read system/physmem.c:2907:12
>>

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2355

>> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
>> ---
>> Changes in v4:
>> - Change the variable name to 'reg_table_count'
>> - Change the 'reg_table_count' type to unsigned
> 
> Thanks,
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>> Changes in v3:
>> - Add the reproducer
>> ---
>>   hw/gpio/aspeed_gpio.c         | 17 +++++++++++++++++
>>   include/hw/gpio/aspeed_gpio.h |  1 +
>>   2 files changed, 18 insertions(+)
> 


