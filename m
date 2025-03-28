Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4612EC28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 20:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyG3T-0001Do-E6; Fri, 28 Mar 2025 16:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tyG3Q-0001DV-US
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:11:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tyG3O-0000s9-NC
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743192703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PN3KZaiPlBR8mT8J+I11mlumpZhHUZYsaC0t0v2Yzos=;
 b=SgZHNzJK0tplxmbWwn54jmYeK19HGpGhxe8i0uLl2beqlWbWPi29RCloaZdNMXbwyBXuvR
 fm6i8GAUGVw8w28XfXupS+3UtHYz/kCyXyssptUGi2dBUsdEOSHNky/KtTE/f+QSJnhigg
 foWhVFFuUJ6ppD0/cFa18tjmuSI6www=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-4yyszgE0Oh-PNiXQtys8aA-1; Fri, 28 Mar 2025 16:11:41 -0400
X-MC-Unique: 4yyszgE0Oh-PNiXQtys8aA-1
X-Mimecast-MFC-AGG-ID: 4yyszgE0Oh-PNiXQtys8aA_1743192700
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39149cbc77dso2070394f8f.3
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 13:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743192700; x=1743797500;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PN3KZaiPlBR8mT8J+I11mlumpZhHUZYsaC0t0v2Yzos=;
 b=KLf0Ro4QZU/HidgUchnfbg3+y/AcKd/mhFWr5lVPDowfcDik/rkqO0RVXa4JJSDvnh
 Z88ITEtWVbYHIU9evP41flWEPwdnNQ8QKgrltvlUGE76Chv2YcX3l0+KzvNcvSTESl9m
 rtYBuLVfp+H/wyf5oMC/kjm9Q4FwpPVsXJxf7sQK5dS8Xv0akP/7Q3JAd1ZgnwsusHio
 vNZmV7r7LcZUT1abHysPPgn227uIBpKgZcXbUzi5WZp+a3DNGggjVASJlylIi5PpjfvD
 S8qNruNg4HsCckDf9ZqPjHD03cn9hNhHhDNKuE7gXZ3UtyYkRip6a0In5lni4uY030ui
 JtSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpsfXv2H+x0ETv050s1xv3dqs6eS8Sj+hEuwheCT9xCOaNxLqNf0kRPxqITmtvIStxpR/6GCkmtm73@nongnu.org
X-Gm-Message-State: AOJu0Yxs+X59z3R9Of/EiIVnymHbfgTN7/qZBfeF3GQpTKzKbxQpR0rA
 qYlYYxEMyjZ4iArRwyrnFgjNKMrkcmppsyJIjAwegBQwfbZw998tyHkEkIjLj+voLajNaN4btTh
 U1QzatRGo1wG6bmlo0Iqxkepx5Ha/dgrLjkHBiLZ82LR3D2B03ZZR
X-Gm-Gg: ASbGncsuGHFJm/DEHFcctzMhv53pJHzXPEPFLvX+J8ODJ2+h7uB3cJpxbKL/hGCIhyg
 SZzDbRVTGhGin9307to7g6IApJEx4bTgnIXYjPHgsY0dgwhh4Yo6UYvAUSeADgYXe/t1iHnUO3I
 zhY2sv1vCpOu9NWdG3ZS9cTIHPocTkFC8pQ5oonEgiStWpzixBLJa5ZwhloKpx9R+qWagmBZlUz
 5BdBvx1a8W8cqA+MpMd1J15UwCQ2RjTMNlr+4mGzPDRHP4/cPZyvkeAT+lmuvH5IwTPSxG3s5vL
 1SLSao4gb7I16/SzdmWK7kaSYGAemRtx0ApujNz2vswJkl4=
X-Received: by 2002:a05:6000:40cd:b0:38d:d666:5457 with SMTP id
 ffacd0b85a97d-39c12118f51mr328067f8f.42.1743192699990; 
 Fri, 28 Mar 2025 13:11:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTqDIRwOeJCmVtxDDcBfNPn4ZY0sjzTog5lF/Go1uWqwS7OWawIaFvKwEoHgO/xaXYBu+tWA==
X-Received: by 2002:a05:6000:40cd:b0:38d:d666:5457 with SMTP id
 ffacd0b85a97d-39c12118f51mr328054f8f.42.1743192699536; 
 Fri, 28 Mar 2025 13:11:39 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-43-49-206.web.vodafone.de.
 [109.43.49.206]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a41c0sm3477587f8f.88.2025.03.28.13.11.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 13:11:38 -0700 (PDT)
Message-ID: <2a407ab4-f648-41a1-a73f-e521acea061e@redhat.com>
Date: Fri, 28 Mar 2025 21:11:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci-host/gt64120.c: Fix PCI host bridge endianness
 handling
To: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>
Cc: rakeshj <rakeshjb010@gmail.com>, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, philmd@linaro.org
References: <20250327153627.307040-1-rakeshjb010@gmail.com>
 <364c91ef-b086-9aea-4073-e0be49b77d76@eik.bme.hu>
 <ca76bcb1-7cea-4153-ae74-02718a6a1cfb@redhat.com>
 <971ac7f1-618d-c94a-93db-9ba887bdc997@eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <971ac7f1-618d-c94a-93db-9ba887bdc997@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 28/03/2025 15.16, BALATON Zoltan wrote:
> On Fri, 28 Mar 2025, Paolo Bonzini wrote:
>> On 3/27/25 21:50, BALATON Zoltan wrote:
>>> On Thu, 27 Mar 2025, rakeshj wrote:
>>>> The GT-64120 PCI controller requires special handling where:
>>>> 1. Host bridge (device 0) must use native endianness
>>>> 2. Other devices follow MByteSwap bit in GT_PCI0_CMD
>>>>
>>>> Previous implementation accidentally swapped all accesses, breaking
>>>> host bridge detection (lspci -d 11ab:4620). This fix:
>>>>
>>>> - Adds device filtering via (phb->config_reg & 0x00FFF800)
>>>> - Preserves native endianness for host bridge
>>>> - Maintains swapping for other devices in big-endian mode
>>>>
>>>> Fixes: 145e2198 ("hw/mips/gt64xxx_pci: Endian-swap using PCI_HOST_BRIDGE 
>>>> MemoryRegionOps")
>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2826
>>>> Signed-off-by: rakeshj <rakeshjb010@gmail.com>
>>>> ---
>>>> hw/pci-host/gt64120.c | 37 ++++++++++++++++++++++++++++++++++++-
>>>> 1 file changed, 36 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
>>>> index d5c13a89b6..098f8e5988 100644
>>>> --- a/hw/pci-host/gt64120.c
>>>> +++ b/hw/pci-host/gt64120.c
>>>> @@ -320,11 +320,46 @@ static void gt64120_isd_mapping(GT64120State *s)
>>>>     memory_region_transaction_commit();
>>>> }
>>>>
>>>> +static uint64_t gt64120_pci_data_read(void *opaque, hwaddr addr, 
>>>> unsigned size)
>>>> +{
>>>> +    GT64120State *s = opaque;
>>>> +    PCIHostState *phb = PCI_HOST_BRIDGE(s);
>>>> +    uint32_t val = pci_data_read(phb->bus, phb->config_reg, size);
>>>> +
>>>> +    /* Only swap for non-bridge devices in big-endian mode */
>>>> +    if (!(s->regs[GT_PCI0_CMD] & 1) && (phb->config_reg & 0x00fff800)) {
>>>> +        val = bswap32(val);
>>>
>>> I don't know if this is the best way to fix this issue as I don't know 
>>> what the issue is in the first place (isn't PCI usually little endian?) 
>>
>> Yes but this particular PCI host bridge is the exception, as it is the 
>> only user of pci_host_data_be_ops.
>>
>>> but I think you can't just use bswap here because it also needs to take 
>>> into account the endianness of the host QEMU is running on.
>>
>> It should be fine.  You should take into account:
>>
>> - the endianness produced by pci_data_read/pci_data_write (always little 
>> endian)
>>
>> - the endianness expected by the guest (big endian under the conditions in 
>> the patch)
>>
>> - the endianness expected by memory.c (always little endian, as specified 
>> in gt64120_pci_data_ops)
>>
>> Because there is either zero or one mismatch, bswap32 is fine.
> 
> This may worth a comment but I'm still not convinced this works on big 
> endian host because I think pci_data_read returns val in host endianness and 
> if you want big endian then you only need to bswap on LE host not on BE 
> host. Was this tested on BE host and confirmed it works?

FWIW, I just checked the patch on a big endian host, and it seems to work as 
expected, with both qemu-system-mips and qemu-system-mipsel the "lspci -d 
11ab:4620" was working correctly there.

  Thomas


