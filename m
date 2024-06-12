Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAFAC27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 12:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNQk-0007Dw-7h; Wed, 12 Jun 2024 08:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHNQh-0007Cs-Om
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 08:50:19 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHNQd-0006JY-Te
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 08:50:18 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-35f1cb7a40fso3590919f8f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 05:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718196614; x=1718801414; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UiekToTWPow3vHTwnb6CkZoHJAihJQce2rVWuOyp1hI=;
 b=vNfrZB/6ZAfBPEGtgR6ZepUDEHNms5YtdvjKIAqb7qZgcf+bW1NZQW8XQMd2UxTmv4
 PPWsTmy8ioqEmzw+zXA+mWIQaP6lD55rOb9a6xevr5yzdjfMolJfuvst71jUGieXL/Dw
 hDJipFHZxExSwaIcWYa763uxlLIQiNxMFMeyLSs3oQLYLKo+Xs8eDOikpipX7DytsQ0z
 a7cetZdDAHzeK4tjHLABEOg60ZJTz9BTfg10im1vyXrO0yPYjf+8P1UjQMQ6zPfFwbrV
 OEnWFxF/XqHcAtW9ikLyNk92u+T/fXfvvV1Cw9/wT8emur0j6LEgLDGMdBdWNjzlwku/
 gyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718196614; x=1718801414;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UiekToTWPow3vHTwnb6CkZoHJAihJQce2rVWuOyp1hI=;
 b=ncHGVnDO/GZl8sLjQPJ2xO8lBMpMjvdu0pkZRjc18uCIjflWY2m/7+vypXE0KTzpkN
 pZ60uiHRK/7OES48O29P+LDH6sPZv52DI02uAHgQCgNvb6ueXjnAZLddfI3lTCpGNU8h
 BYpJckn0EEOtZJ6Y0UzVyg9WvMilip6SladwAkP7cSC6NIjMyCQFy4aFv1BVfK8j7BAW
 17WBOwQCAu/eZkM+RZqg9ZqkXNJeWESs17Xs4Y073JXqS4onyuoMYXM0XT43L0zgJJ1I
 F8od+D3yYiI/pn4wedN2iSrKLpdVQTeZUMqOn0nee+B+pFWxqUMOAfo6GMT4jGesO5k4
 nWfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtbvM7vA+5MbcGVmLoIOC12WAlkwu7JiTOuKM4MdeQsEADJr3SHvpGYcnVuf1A0ILmCnq5Z/EBf4qe88YK/23MZhHr3EA=
X-Gm-Message-State: AOJu0YwTmBvzA7lKqtapoh++Zwui2FIwTx5PCe+yJdK8rP4VCdlLYGLy
 T0/2RxlAkLv54OJMlTSbysc0kGdmj/unqlDTuGYSiWqLvr+Fw2i9iLUXJOwRMdM=
X-Google-Smtp-Source: AGHT+IEQ3IpLR8I7EWKPq9ZW7bkOGfuc3+kxg7/fbOBCIEe1ZjsLCCQw2kVOja4xotqhe/zZyn+yhA==
X-Received: by 2002:a5d:5185:0:b0:35f:caa:1ebc with SMTP id
 ffacd0b85a97d-35fdf79bcd7mr1488952f8f.7.1718196614071; 
 Wed, 12 Jun 2024 05:50:14 -0700 (PDT)
Received: from [192.168.69.100] (ram94-h02-176-184-0-172.dsl.sta.abo.bbox.fr.
 [176.184.0.172]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42285317d46sm20622325e9.1.2024.06.12.05.50.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jun 2024 05:50:13 -0700 (PDT)
Message-ID: <8d7e111b-4f74-4a67-b01b-2af5ce009a06@linaro.org>
Date: Wed, 12 Jun 2024 14:50:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/arm/virt: Avoid unexpected warning from Linux guest
 on host with Fujitsu CPUs
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Zhenyu Zhang <zhenyzha@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, robin.murphy@arm.com, Jonathan.Cameron@huawei.com,
 gshan@redhat.com, eauger@redhat.com, sebott@redhat.com, cohuck@redhat.com,
 ddutile@redhat.com, shahuang@redhat.com, qemu-riscv <qemu-riscv@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, Song Gao <gaosong@loongson.cn>
References: <20240612020506.307793-1-zhenyzha@redhat.com>
 <69649622-e52c-4d24-809b-3d8a97786a69@linaro.org>
 <CAFEAcA9wEjONgLfTObNYwJbwn5Gs1BDJiDivc9PEwmfOeZW6ww@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9wEjONgLfTObNYwJbwn5Gs1BDJiDivc9PEwmfOeZW6ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 12/6/24 14:48, Peter Maydell wrote:
> On Wed, 12 Jun 2024 at 13:33, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi Zhenyu,
>>
>> On 12/6/24 04:05, Zhenyu Zhang wrote:
>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>> index 3c93c0c0a6..3cefac6d43 100644
>>> --- a/hw/arm/virt.c
>>> +++ b/hw/arm/virt.c
>>> @@ -271,6 +271,17 @@ static void create_fdt(VirtMachineState *vms)
>>>        qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
>>>        qemu_fdt_setprop_string(fdt, "/", "model", "linux,dummy-virt");
>>>
>>> +    /*
>>> +     * For QEMU, all DMA is coherent. Advertising this in the root node
>>> +     * has two benefits:
>>> +     *
>>> +     * - It avoids potential bugs where we forget to mark a DMA
>>> +     *   capable device as being dma-coherent
>>> +     * - It avoids spurious warnings from the Linux kernel about
>>> +     *   devices which can't do DMA at all
>>> +     */
>>> +    qemu_fdt_setprop(fdt, "/", "dma-coherent", NULL, 0);
>>
>> OK, but why restrict that to the Aarch64 virt machine?
>> Shouldn't advertise this generically in create_device_tree()?
>> Or otherwise at least in the other virt machines?
> 
> create_device_tree() creates an empty device tree, not one
> with stuff in it. It seems reasonable to me for this property
> on the root to be set in the same place we set other properties
> of the root node.

OK. Still the question about other virt machines remains
unanswered :)


