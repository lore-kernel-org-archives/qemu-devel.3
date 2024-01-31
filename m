Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8265C47DB3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 11:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV8g5-0006yV-PI; Wed, 31 Jan 2024 06:22:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rV8g4-0006x9-63
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 06:22:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rV8g2-0005ji-BQ
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 06:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706700165;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xoZeNTfDJkpavBmLfMquoZlHC2BBV8svy71fzl6+Ipk=;
 b=FRwzW+GD/XWuzaF0JXkD5w4la9zHAJgU65LNUvuve+4vUUW6tLPhCyXo34i6nu0xnas4Bj
 ssjt9OzSXljgHGKhjEVAg3LXUftZJyVW7rKpdcgBo0kSHFuzYL2AiE7tk2thkIqfG+0IbV
 eNWh9f7dC59LP7IhYD+dj1KEYfgaeyc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-DjN5mMYHPAKaoEuUO2Q2yg-1; Wed, 31 Jan 2024 06:22:43 -0500
X-MC-Unique: DjN5mMYHPAKaoEuUO2Q2yg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33aef37ee4dso1401705f8f.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 03:22:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706700162; x=1707304962;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xoZeNTfDJkpavBmLfMquoZlHC2BBV8svy71fzl6+Ipk=;
 b=ieAfRrz5JXe4Amf4eKdnYfYajaUGX5MqYA/pQMg2QDEbHKNjVj0qo7JhtmgW455snt
 oVRV4+iPDU2HmJC5JeMt6WoyZCXcULrFuEtOei9xGPZ0XPMeaBhQ+Pr0AVoEUAxDJhip
 mV//ZVWBMEdIAZzR4A/lLJ/k0KO2IXfYICdIRAoC+4qWMmqZBTZGPCtgtoh8FkBb0my3
 qaFtFp0QGDfW9jHKzbDtnnjfnF7nChKZfy+oHWm9/36oxI2rGyNswXxOfgU0t4kMshmK
 e0vnX9+8qbqUpyNcmn6mS5KKcoju3EX9ak7w6UZ0Guo+duTfKqECl9eCQvJZ7kZAoQwi
 3pvg==
X-Gm-Message-State: AOJu0YybiwrjvkvanaGulGqKRZassFJfN2R2t/Pp4XwtnygUMGFuFV/g
 DK/ZrTy7tOA81HaKwwfxG4ls9c602sAoeKgoEJh/cxirbQ3tyfiQaAvAFbdt/FhYVjN8g8sXNdO
 O5Yc3T5WbV1tpUXUVALGfu127SxEwNlJZ5eTU5xY0P69jP2tdjwLI
X-Received: by 2002:a05:6000:1150:b0:33a:e9d8:189b with SMTP id
 d16-20020a056000115000b0033ae9d8189bmr901704wrx.71.1706700162268; 
 Wed, 31 Jan 2024 03:22:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvD1rwaPVn6wkjM/0bBS6ZLwrXrrp7XemdEwvh0gBSfepwue1Rz/QAzjqQsKeNNN/6RF1QRg==
X-Received: by 2002:a05:6000:1150:b0:33a:e9d8:189b with SMTP id
 d16-20020a056000115000b0033ae9d8189bmr901689wrx.71.1706700161904; 
 Wed, 31 Jan 2024 03:22:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 cx18-20020a056000093200b0033935779a23sm13177241wrb.89.2024.01.31.03.22.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jan 2024 03:22:40 -0800 (PST)
Message-ID: <f139efc5-c34c-4c83-9954-a37bffcb5c90@redhat.com>
Date: Wed, 31 Jan 2024 12:22:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/7] VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling for
 hotplugged devices
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "yanghliu@redhat.com" <yanghliu@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "clg@redhat.com" <clg@redhat.com>
References: <20240117080414.316890-1-eric.auger@redhat.com>
 <SJ0PR11MB6744C50921CC63221A93C75492712@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <7bc955a1-f58d-43b1-8e95-c452bb11f208@redhat.com>
 <20240125184822.GB122027@myrica>
 <db8d6171-acd2-4e1e-9c25-c7d12fa26de4@redhat.com>
 <20240130182239.GA1392966@myrica>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240130182239.GA1392966@myrica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Jean,

On 1/30/24 19:22, Jean-Philippe Brucker wrote:
> On Mon, Jan 29, 2024 at 05:38:55PM +0100, Eric Auger wrote:
>>> There may be a separate argument for clearing bypass. With a coldplugged
>>> VFIO device the flow is:
>>>
>>> 1. Map the whole guest address space in VFIO to implement boot-bypass.
>>>    This allocates all guest pages, which takes a while and is wasteful.
>>>    I've actually crashed a host that way, when spawning a guest with too
>>>    much RAM.
>> interesting
>>> 2. Start the VM
>>> 3. When the virtio-iommu driver attaches a (non-identity) domain to the
>>>    assigned endpoint, then unmap the whole address space in VFIO, and most
>>>    pages are given back to the host.
>>>
>>> We can't disable boot-bypass because the BIOS needs it. But instead the
>>> flow could be:
>>>
>>> 1. Start the VM, with only the virtual endpoints. Nothing to pin.
>>> 2. The virtio-iommu driver disables bypass during boot
>> We needed this boot-bypass mode for booting with virtio-blk-scsi
>> protected with virtio-iommu for instance.
>> That was needed because we don't have any virtio-iommu driver in edk2 as
>> opposed to intel iommu driver, right?
> Yes. What I had in mind is the x86 SeaBIOS which doesn't have any IOMMU
> driver and accesses the default SATA device:
>
>  $ qemu-system-x86_64 -M q35 -device virtio-iommu,boot-bypass=off
>  qemu: virtio_iommu_translate sid=250 is not known!!
>  qemu: no buffer available in event queue to report event
>  qemu: AHCI: Failed to start FIS receive engine: bad FIS receive buffer address
>
> But it's the same problem with edk2. Also a guest OS without a
> virtio-iommu driver needs boot-bypass. Once firmware boot is complete, the
> OS with a virtio-iommu driver normally can turn bypass off in the config
> space, it's not useful anymore. If it needs to put some endpoints in
> bypass, then it can attach them to a bypass domain.

yup
>
>>> 3. Hotplug the VFIO device. With bypass disabled there is no need to pin
>>>    the whole guest address space, unless the guest explicitly asks for an
>>>    identity domain.
>>>
>>> However, I don't know if this is a realistic scenario that will actually
>>> be used.
>>>
>>> By the way, do you have an easy way to reproduce the issue described here?
>>> I've had to enable iommu.forcedac=1 on the command-line, otherwise Linux
>>> just allocates 32-bit IOVAs.
>> I don't have a simple generic reproducer. It happens when assigning this
>> device:
>> Ethernet Controller E810-C for QSFP (Ethernet Network Adapter E810-C-Q2)
>>
>> I have not encountered that issue with another device yet.
>> I see on guest side in dmesg:
>> [    6.849292] ice 0000:00:05.0: Using 64-bit DMA addresses
>>
>> That's emitted in dma-iommu.c iommu_dma_alloc_iova().
>> Looks like the guest first tries to allocate an iova in the 32-bit AS
>> and if this fails use the whole dma_limit.
>> Seems the 32b IOVA alloc failed here ;-)
> Interesting, are you running some demanding workload and a lot of CPUs?
> That's a lot of IOVAs used up, I'm curious about what kind of DMA pattern
> does that.
Well nothing smart, just booting the guest with the assigned NIC. 8 vcpus

Thanks

Eric
>
> Thanks,
> Jean
>


