Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35493C27C6E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 09:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ8mn-00054D-Vs; Mon, 17 Jun 2024 05:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ8mj-00053u-10
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 05:36:21 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ8mh-0000nv-Bp
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 05:36:20 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-35f1c567ae4so3208181f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 02:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718616977; x=1719221777; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z/avWU+IzGZgbM/rGmF1u0JeDoOVOXAVch7IyWFSeyU=;
 b=gWS8zvyy9HCfsaKPXlAf9yNQ7dPslj9gwvO4omQ8KTAVDHS085JwgbjYJicvxMkz6l
 gDJoVf/6ls5jKXiLu29EEsfKYHE6I9vIEUXX8LNhF2r6K2/sS6EhrRXcLXXnhH02TQLX
 w8se9hxUX8Lt4SdwR1VVhqYGNT/3j6yu2F7ufgOc45umhGTQjF/dwXtXOd8VU9yEkemA
 EXr9NR6ivN38pc1LfNZENo6jgqlfnUE5sJgveL116brAPRelh+lCUmpLWXz3ykSxkTy2
 ABdW9aeHcwbdmyNtvRAx8UPTTC+NRlBaP+MwEd/Ehv53lpIhcVcQ2ZAIFU0RWhe6CvKQ
 mxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718616977; x=1719221777;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z/avWU+IzGZgbM/rGmF1u0JeDoOVOXAVch7IyWFSeyU=;
 b=LgCflImFJLe8bo0meDKzdstX+T4StRltpWByzGrYULjSh0mNpOYYMBeqnxYs9B25zV
 ZBuJsJJEhpsYqjjWFDh97ThLwjU5RTHT6Z4AQqOzoxuxSaOchMmyxzq9gLVCOaI0E46k
 UNZY8FAOiyqkrs1SPm1f6zHAPQKs/DF+WjoTNTgEitxBsSdoXMiJcPcw9pvXcAZ5Yhwd
 ldPItHPmj9QWKli2ZT+ppJO3mh+kYejZx6k9TvDDHZPY2NiPAcuDFPNt4zslq6WtW0ZX
 kypIOknsAU69IVzXA4l/xrBOd4F4krM/iKN7UETl+I+7InaQcMJrj8X32xPV2md+6Ujg
 93Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyk8yNoeFVGEGx+WtjszLg2mvTqe50MTd4KXcj8WbNjB2VSPhlUGF1LuSRNkoUkynDj2Aw6wOaFpRSjoAbJAVDc51TWzg=
X-Gm-Message-State: AOJu0YwuZ/w4JU4H0QZNz+4JE8W3s/zXEc1JRjsZfipFV6HF205zSVew
 Uq4W/edlcam5t4lHWzynGkjrzlcaie5vE6iPeZ+6KyzR0i9GI6CklPBeeWTWCwk=
X-Google-Smtp-Source: AGHT+IE5FGLANvHOYbi+3Xm4JigtqMdm/DQmq2ctWnSy84eagGyg4iM5uQXpSP+PLls0BwDODYiOzw==
X-Received: by 2002:a5d:4a4c:0:b0:35f:1d29:db8d with SMTP id
 ffacd0b85a97d-3607a76374dmr5324132f8f.25.1718616977087; 
 Mon, 17 Jun 2024 02:36:17 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.169.90])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3609d95bc02sm32232f8f.18.2024.06.17.02.36.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 02:36:16 -0700 (PDT)
Message-ID: <c77dc7ce-a205-4dcb-a63b-451cac00de5d@linaro.org>
Date: Mon, 17 Jun 2024 11:36:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/arm/virt: Avoid unexpected warning from Linux guest
 on host with Fujitsu CPUs
To: Zhenyu Zhang <zhenyzha@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com,
 gshan@redhat.com, eauger@redhat.com, sebott@redhat.com, cohuck@redhat.com,
 ddutile@redhat.com, shahuang@redhat.com, qemu-riscv <qemu-riscv@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, Song Gao <gaosong@loongson.cn>
References: <20240612020506.307793-1-zhenyzha@redhat.com>
 <69649622-e52c-4d24-809b-3d8a97786a69@linaro.org>
 <CAFEAcA9wEjONgLfTObNYwJbwn5Gs1BDJiDivc9PEwmfOeZW6ww@mail.gmail.com>
 <8d7e111b-4f74-4a67-b01b-2af5ce009a06@linaro.org>
 <ed3df37e-fddd-465c-8ae9-1c5791966995@arm.com>
 <CAJFLiBLt4ig0XpDScq0M1EAPo1PEvZNiumf9kKMOErSE_OJ_cQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAJFLiBLt4ig0XpDScq0M1EAPo1PEvZNiumf9kKMOErSE_OJ_cQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 17/6/24 07:26, Zhenyu Zhang wrote:
> On Thu, Jun 13, 2024 at 1:48 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2024-06-12 1:50 pm, Philippe Mathieu-Daudé wrote:
>>> On 12/6/24 14:48, Peter Maydell wrote:
>>>> On Wed, 12 Jun 2024 at 13:33, Philippe Mathieu-Daudé
>>>> <philmd@linaro.org> wrote:
>>>>>
>>>>> Hi Zhenyu,
>>>>>
> Hello Philippe,
> 
>>>>> On 12/6/24 04:05, Zhenyu Zhang wrote:
>>>>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>>>>> index 3c93c0c0a6..3cefac6d43 100644
>>>>>> --- a/hw/arm/virt.c
>>>>>> +++ b/hw/arm/virt.c
>>>>>> @@ -271,6 +271,17 @@ static void create_fdt(VirtMachineState *vms)
>>>>>>         qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
>>>>>>         qemu_fdt_setprop_string(fdt, "/", "model", "linux,dummy-virt");
>>>>>>
>>>>>> +    /*
>>>>>> +     * For QEMU, all DMA is coherent. Advertising this in the root
>>>>>> node
>>>>>> +     * has two benefits:
>>>>>> +     *
>>>>>> +     * - It avoids potential bugs where we forget to mark a DMA
>>>>>> +     *   capable device as being dma-coherent
>>>>>> +     * - It avoids spurious warnings from the Linux kernel about
>>>>>> +     *   devices which can't do DMA at all
>>>>>> +     */
>>>>>> +    qemu_fdt_setprop(fdt, "/", "dma-coherent", NULL, 0);
>>>>>
>>>>> OK, but why restrict that to the Aarch64 virt machine?
>>>>> Shouldn't advertise this generically in create_device_tree()?
>>>>> Or otherwise at least in the other virt machines?
>>>>
>>>> create_device_tree() creates an empty device tree, not one
>>>> with stuff in it. It seems reasonable to me for this property
>>>> on the root to be set in the same place we set other properties
>>>> of the root node.
>>>
>>> OK. Still the question about other virt machines remains
>>> unanswered :)
>>
>>   From the DT consumer point of view, the interpretation and assumptions
>> around coherency *are* generally architecture- or platform-specific. For
>> instance on RISC-V, many platforms want to assume coherency by default
>> (and potentially use "dma-noncoherent" to mark individual devices that
>> aren't), while others may still want to do the opposite and use
>> "dma-coherent" in the same manner as Arm and AArch64. Neither property
>> existed back in ePAPR, so typical PowerPC systems wouldn't even be
>> looking and will just make their own assumptions by other means.

TIL :)

> As Robin's comment says, each platform wants to assume coherency
> by default may be different. Adding it to all virt machines may
> introduce new risks. Currently, the issue is only valid on Fujitsu CPUs
> where the cache line size is 256 bytes, meaning the combination of
> kvm+virt-platform is needed to trigger the warning. So I'd be inclined
> to add this "dma-coherent" property for the "virt" platform first
> and advertise the property to other platforms if we hit the issue
> on those platforms.

Thanks Robin & Zhenyu,

Phil.

