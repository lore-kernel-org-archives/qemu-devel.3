Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838C7C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 13:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpTIZ-0008Ca-SR; Wed, 27 Mar 2024 09:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpTIY-0008CK-Lu
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:26:34 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpTIW-0005Xe-Vw
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:26:34 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41485fcb8ccso24339365e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 06:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711545991; x=1712150791; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4dCw7HH6eL2/wh/se0db0+w3WDUYFh/wkPQjXWNfVDQ=;
 b=iU6p4MH35fKRvGVr99MumyHJeTDPkBsmjGInRqx0X5ujLoVJr0gf+BnrRqcQU9zWjs
 dK4GU1m/1Fbf/LJDDqjBc38TwFCzptVrfW++z7uHqFHSm0OkU8ycozkUlKcug8H5tGH6
 wyhqHsTdnIKcYA3gJJVGlDigckYwPVbxrQz2gZHQ+q9tMx8QPXx+jHnd8XcU+b4FYPiO
 v2nhGdIottimd/OINUdemzyKucaGonG/iDDJNSu7mM/41dAfNei/ZxSqWxt3qIL+xggA
 MYekUbhqzwRkRdKcnDj2ROHwwnCAfyFfVwf/w/GONVgM1E8igWNi3d/YFAexuxF/Liif
 MtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711545991; x=1712150791;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4dCw7HH6eL2/wh/se0db0+w3WDUYFh/wkPQjXWNfVDQ=;
 b=gLu8yQBnGLZLON5QV9McnDOXzFGQqUSA29qR4ZnEGyPUT2FZe9g4LhWG1nFvzr+Z66
 pjlP2pcqROMnExiBD16F3KXu+oX+2JD9WJbjCJyCudHMikSE2xxzfGL/mPyKRiHubBd9
 Y40Aj2mgEZJQHdtRpH/Hn80eACZoZ5l/EwXmk7vjTl5xrwD4NmS8i3HTVuwXsA/T6ruB
 UqoYqe1guVW+jpEF5s+gGqfHFhjC0KvuEk8DHJZOiIVQ+3BbNV1QIWB9AKUhht86zNNh
 Op21rucmxkDKmjAmJLnC3u8AzAnLA6I5+MDoeKTmMSRvtVriv6XEy0Zw6xaQoquqIZu4
 ZGCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm2pnUkz8KrUeg5ldgUriWbupOABcA9MPPMI94epVXtJN8kyE6YlHrKJBsw7P4BfhnC7tK+AN7XKXMZxcTr8OCgRC12AI=
X-Gm-Message-State: AOJu0YzSn1xB/XJaKSDtvJ0+xNCuGq4XeMfvYmo0yFuiIOpZQkYZLxWH
 M0e1bwdf+wAZ5E/j1zWbbTkOs87ssZmzDTTKuihp2jG+EOV3kUz0uF8xWD4xkz4=
X-Google-Smtp-Source: AGHT+IF/CVsIGMaFEYPxIhMBN8G5NfhVfITI5jc1zuSkD706h5e3S2M3bpybLX6I1yn8qz1uhxyrCg==
X-Received: by 2002:a05:600c:35cb:b0:414:255:c6a7 with SMTP id
 r11-20020a05600c35cb00b004140255c6a7mr25880wmq.32.1711545991222; 
 Wed, 27 Mar 2024 06:26:31 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 d17-20020a05600c34d100b004146e631a81sm2174872wmq.5.2024.03.27.06.26.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 06:26:30 -0700 (PDT)
Message-ID: <40360cb9-71f5-43c1-9c10-edf6b7ecbc81@linaro.org>
Date: Wed, 27 Mar 2024 14:26:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0] docs/about: Mark the iaspc machine type as
 deprecated
To: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, pbonzini@redhat.com,
 devel@lists.libvirt.org, richard.henderson@linaro.org, mst@redhat.com,
 qemu-trivial@nongnu.org
References: <20240326125104.90103-1-imammedo@redhat.com>
 <a4a0bb13-d6a0-4665-810d-ecd9a9fb89b1@redhat.com>
 <8dbba6ae-5910-4a62-9a08-a56e20dfb480@linaro.org>
 <20240326171632.3cc7533d@imammedo.users.ipa.redhat.com>
 <ZgP5x3ECYGevla1-@redhat.com>
 <20240327140917.69d86539@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240327140917.69d86539@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 27/3/24 14:09, Igor Mammedov wrote:
> On Wed, 27 Mar 2024 10:49:43 +0000
> Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
>> On Tue, Mar 26, 2024 at 05:16:32PM +0100, Igor Mammedov wrote:
>>> On Tue, 26 Mar 2024 14:29:58 +0100
>>> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>    
>>>> Hi Igor,
>>>>
>>>> On 26/3/24 14:08, Thomas Huth wrote:
>>>>>
>>>>> s/iaspc/isapc/ in the subject
>>>>>
>>>>> On 26/03/2024 13.51, Igor Mammedov wrote:
>>>>>> ISAPC machine was introduced 25 years ago and it's a lot of time since
>>>>>> such machine was around with real ISA only PC hardware practically
>>>>>> defunct.
>>>>>> Also it's slowly bit-rots (for example: I was able to boot RHEL6 on
>>>>>> RHEL9 host
>>>>>> in only TCG mode, while in KVM mode it hung in the middle of boot)
>>>>
>>>> I'm quite opposed to this patch. QEMU models various very-old /
>>>> defunct hardware. I'm pretty sure Bernhard and myself are OK to
>>>> keep maintaining it, besides we are working in separating it from
>>>> the i440fx+piix machine. Also, this machine is particularly
>>>> interesting for my single-binary experiments.
>>>
>>> it would not be fair to ask you or Bernard to deal with every
>>> case where ISAPC related code gets in a way, nor it's fair to
>>> ask other contributors to ensure that their patches don't break
>>> semi-working ISAPC or refactor code that relates to it.
>>>
>>> [
>>> for example I'd like to refactor smbios parts in the image
>>> ACPI table builder, but the I'd have to do it for legacy
>>> part as well without means to verify that. Sure it can be
>>> done but at cost of extra time spent to rewrite something
>>> that would never be used and to find test env to verify
>>> touched code.
>>> ]
>>
>> Is SMBIOS even relevant for isapc ? IIUC, the first SMBIOS spec
>> is from 1999, while PCI has been around since 1992.
> 
> Theoretically SMBIOS can still be used with isapc,
> (that's how I've tested factoring out legacy part by running
> RHEL6 in TCG mode)
> Whether it's used in practice somewhere else is unknown.
> 
>> IOW, we shouldn't even be exposing SMBIOS with the isapc
>> machine type. If we address that, then isapc has no impact
>> on your ability to refactor SMBIOS code.
> 
> It's question of whether we are willing to do unthinkable,
> i.e. to break QEMU <-> guest ABI for isapc case by removing
> corresponding fwcfg entries.
> 
> With migration ignored it shouldn't be a problem.
> Question is: does anyone care about migration with isapc?
> If not, I'd gladly axe smbios legacy parts in 9.1
> 
> 
> But given how easy one can spawn old qemu environment to
> run something on isapc, we are loosing a chance to cleanup
> QEMU code base touching following
> 
>      m->option_rom_has_mr = true;
>      m->rom_file_has_mr = false;
>      pcmc->pci_enabled = false;
>      pcmc->has_acpi_build = false;
>      pcmc->smbios_defaults = false;
>      pcmc->gigabyte_align = false;
>      pcmc->smbios_legacy_mode = true;

My plan is to split the legacy part of fw_cfg_build_smbios() out
of it as fw_cfg_build_smbios_legacy().

>      pcmc->has_reserved_memory = false;
> 
> they are all marginal but in shared code, and removing them
> makes code a bit more easier to follow (especially when it
> comes to memory layout).
> 
>> With regards,
>> Daniel
> 


