Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB86C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 11:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfeQ5-0006ut-Fv; Thu, 29 Feb 2024 06:17:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rfeQ0-0006rx-Lj
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 06:17:42 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rfePx-0003QU-E3
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 06:17:39 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5D3FF40706
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 11:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709205454;
 bh=f51D4iskqg4WHajUfsEmmYJBhtTrwqg5hAVMvBXWnVk=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=LJ/1W/I9eFsYR880eXmF2oAUJlfXCuGgPi8VD2KcSyv8BY95SHziBuOv1hPbBQFMl
 3kG2GR8wrs1ghnHTnic1PntVK/D+IwarzPg5ekrK7GecrQITQtdfv9sE6kdQeYRAn3
 haVamfM2iOUdPC3z1/fSLAguh6/V39M0U3k7ROLk2fMDl/DM31iEuKIsdAge5DI8bj
 Zc6k6pzAwxYVou9NzgiPw7x6vWSYo7waHtZqctBjl3pq2jqegKWLUrS1PmlAkdFh49
 d8bC41yFLIn9TXOU8XENdK+n+QQPufjniXcitMSALXPhX7jo4JDz9tz6tmfEtLFgem
 7Cm+Jnf6l5juw==
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-563ec73081eso635783a12.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 03:17:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709205454; x=1709810254;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f51D4iskqg4WHajUfsEmmYJBhtTrwqg5hAVMvBXWnVk=;
 b=UpigkVomgFZDgse9USd7BP4toxqRvVIl7snCwKKp6kndC8EmdIRTaaC873wCZplWH9
 QRCPNjpXpPmI4g/ctO0yga+C6kkHML6rt0ppf9zEH2s15gY3dqfjKxpwMaEIIQc/MDS6
 FXsDJWWAGBefnGU166adB4659aDD1ggz2NzxNOrlSCURFUz31FSE1EFleiZzmeR8X+Q2
 Yra/y2Gr2u9+u4j61bj5Cicy+AiUSoQJp6uHK7kpw337lnP3ViYUihr74dMyZk+ZTBtJ
 YZtHY4E2eOldq5xoz/3cAzi8C3+G3MJSmaJOT3QbY0/e46up2UVrhNyLTNoeWqxOofnT
 zCgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWF5EGEPQmIUpVsK9VvWyXZDR49yY9oQToEbafMtntnAZS0dF/61xyzDsQJ//A3kpikly4wniAzIFd/dGJD1SkRRpnctw=
X-Gm-Message-State: AOJu0YxffaMX4tgIGz1m3q8Cshba1as6YHZdB8qJ44a5oUzLMqufUXYG
 wCrutyUp6v+Z4zxk/Vbc5ehXR31fnb5ffltZ9o/ccBe83/vlrEI99QL+QaNFjmu+WINSyJ6ht1z
 8x/8OV+iLrCVjackGywVJeAP0wQ7ZGUJgSxD2UIi0qiSuxOnwjLW5V2wo0h206OOZaSdE
X-Received: by 2002:a50:8d8d:0:b0:563:c54e:ee with SMTP id
 r13-20020a508d8d000000b00563c54e00eemr1324433edh.2.1709205453935; 
 Thu, 29 Feb 2024 03:17:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvLCWCwh8n/ekUIM1aU+bgh8JOQUUhggcgBqmtT4hHk06vLGF2oDUkFDK/KoFAGua6mte9Sw==
X-Received: by 2002:a50:8d8d:0:b0:563:c54e:ee with SMTP id
 r13-20020a508d8d000000b00563c54e00eemr1324411edh.2.1709205453587; 
 Thu, 29 Feb 2024 03:17:33 -0800 (PST)
Received: from ?IPV6:2a00:20:10:8f6:23ea:cac0:4a99:bcbf?
 ([2a00:20:10:8f6:23ea:cac0:4a99:bcbf])
 by smtp.gmail.com with ESMTPSA id
 m18-20020aa7c492000000b005662d3418dfsm515150edq.74.2024.02.29.03.17.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 03:17:33 -0800 (PST)
Message-ID: <bf3e44c8-a6ad-48b6-8825-ba8ce0dd19f8@canonical.com>
Date: Thu, 29 Feb 2024 12:17:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH, v2] physmem: avoid bounce buffer too small
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Mattias Nissler
 <mnissler@rivosinc.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20240228125939.56925-1-heinrich.schuchardt@canonical.com>
 <fb6ef90d-4a3e-4bdd-8516-8b15c1f2329f@linaro.org>
 <b9937680-8c0b-46f6-86ef-55139562e2c4@canonical.com>
 <CAFEAcA_Bshua2BQTfOb3D1aF27ayELEt9TcQM8hkQdKaih3xHw@mail.gmail.com>
 <9c64be5c-25b8-421d-966a-bdac03dfe37c@canonical.com>
 <CAFEAcA92s+3Q3ud=zOjsyvuqZ=BjwXt3OY0n5mO_iDXovQpoRQ@mail.gmail.com>
 <20240229105900.0000490e@Huawei.com>
 <CAFEAcA_O2QPwCPE0HS9g0saEA3XbuVS_UGtRpe_o4tLRrc6Ksg@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFEAcA_O2QPwCPE0HS9g0saEA3XbuVS_UGtRpe_o4tLRrc6Ksg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 29.02.24 12:11, Peter Maydell wrote:
> On Thu, 29 Feb 2024 at 10:59, Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
>>
>> On Thu, 29 Feb 2024 09:38:29 +0000
>> Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>>> On Wed, 28 Feb 2024 at 19:07, Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>
>>>> On 28.02.24 19:39, Peter Maydell wrote:
>>>>> The limitation to a page dates back to commit 6d16c2f88f2a in 2009,
>>>>> which was the first implementation of this function. I don't think
>>>>> there's a particular reason for that value beyond that it was
>>>>> probably a convenient value that was assumed to be likely "big enough".
>>>>>
>>>>> I think the idea with this bounce-buffer has always been that this
>>>>> isn't really a code path we expected to end up in very often --
>>>>> it's supposed to be for when devices are doing DMA, which they
>>>>> will typically be doing to memory (backed by host RAM), not
>>>>> devices (backed by MMIO and needing a bounce buffer). So the
>>>>> whole mechanism is a bit "last fallback to stop things breaking
>>>>> entirely".
>>>>>
>>>>> The address_space_map() API says that it's allowed to return
>>>>> a subset of the range you ask for, so if the virtio code doesn't
>>>>> cope with the minimum being set to TARGET_PAGE_SIZE then either
>>>>> we need to fix that virtio code or we need to change the API
>>>>> of this function. (But I think you will also get a reduced
>>>>> range if you try to use it across a boundary between normal
>>>>> host-memory-backed RAM and a device MemoryRegion.)
>>>>
>>>> If we allow a bounce buffer only to be used once (via the in_use flag),
>>>> why do we allow only a single bounce buffer?
>>>>
>>>> Could address_space_map() allocate a new bounce buffer on every call and
>>>> address_space_unmap() deallocate it?
>>>>
>>>> Isn't the design with a single bounce buffer bound to fail with a
>>>> multi-threaded client as collision can be expected?
>>>
>>> Yeah, I don't suppose multi-threaded was particularly expected.
>>> Again, this is really a "handle the case where the guest does
>>> something silly" setup, which is why only one bounce buffer.
>>>
>>> Why is your guest ending up in the bounce-buffer path?
>>
>> Happens for me with emulated CXL memory.
> 
> Can we put that in the "something silly" bucket? :-)
> But yes, I'm not surprised that CXL runs into this. Heinrich,
> are you doing CXL testing, or is this some other workload?

I am running the UEFI Self-Certification Tests (SCT) on EDK 2 using:

qemu-system-riscv64 \
       -M virt,acpi=off -accel tcg -m 4096 \
       -serial mon:stdio \
       -device virtio-gpu-pci \
       -device qemu-xhci \
       -device usb-kbd \
       -drive 
if=pflash,format=raw,unit=0,file=RISCV_VIRT_CODE.fd,readonly=on \
       -drive if=pflash,format=raw,unit=1,file=RISCV_VIRT_VARS.fd \
       -drive file=sct.img,format=raw,if=virtio \
       -device virtio-net-device,netdev=net0 \
       -netdev user,id=net0

This does not invoke any CXL related stuff.

Best regards

Heinrich

> 
>> I think the case I saw
>> was split descriptors in virtio via address space caches
>> https://elixir.bootlin.com/qemu/latest/source/hw/virtio/virtio.c#L4043
>>
>> One bounce buffer is in use for the outer loop and another for the descriptors
>> it is pointing to.
> 
> Mmm. The other assumption made in the design of the address_space_map()
> API I think was that it was unlikely that a device would be trying
> to do two DMA operations simultaneously. This is clearly not
> true in practice. We definitely need to fix one end or other of
> this API.
> 
> (I'm not sure why the bounce-buffer limit ought to be per-AddressSpace:
> is that just done in Matthias' series so that we can attach an
> x-thingy property to the individual PCI device?)
> 
> -- PMM


