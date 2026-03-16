Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4ABF53D98
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 20:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Ee0-0005sH-AH; Mon, 16 Mar 2026 16:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prestwoj@gmail.com>)
 id 1w2A6T-0004OW-7M
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 11:43:37 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <prestwoj@gmail.com>)
 id 1w2A6Q-0002XP-Ol
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 11:43:36 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c73e9e4cdf7so1342072a12.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 08:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773675813; x=1774280613; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OUJsBlIgUApje1fV9jF7YVlGvh9bq+NPczCyWOUxzn0=;
 b=isXJBO4iS99BFRV8DKP9/GJQIEPXHU69+mzj99fcS/PkihoCHgM6mE4s0n94mGrDGN
 8HoTEfeRk6GhKLofVzD9ztU7KQP63s8g+jr4Czt438mdlbZzWUoJTcCTaE8LCJUQ6pf/
 k9+3mDH13mGop9WXxU1BMy8k8ZGVPv2zUBC0Gw3c3IYfPXewDNob/NSE6QaDFsvL82HI
 2GXfK64Rc3tDvmrG2h6+g/g2Zj9UXiHlnyLEstrMqfrMd9oYX6jfVbiy6pmvn1BPk0ki
 oGsUfBhGUHTlPn0yQ/XJ4YWq4Itvl1sEg/rbdsN/9lsrAKm6P5Hqxfvk/7TMsVCEOTYM
 l9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773675813; x=1774280613;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OUJsBlIgUApje1fV9jF7YVlGvh9bq+NPczCyWOUxzn0=;
 b=Cxe1YFyI6YZA+nNVbzyQPJQIBIQHmbojc76DvwwP7qtbV6oHn57JZWqabWDM8gFhL9
 +lD8SOujsuvqx2YEOWX2OZC8K3TXF0kG9yzFthLKQZ/DRvomeg+sRmbzD3sIPNHHjB2D
 VM921gPJ4nm6b/j/dZoY8FFqdwGVSioC5LaDQYIvyq07KRmgm5rL1HJGERp89AKOyXw1
 Plm3Os6LT2xT92wKDhg5endb11gkunz7yeHSgiPyByP6vfsr35juVnBbJng6FsZ/VJyv
 GpnZXR6dUJJbTBIkhbbHNd2jsS6/aDKqYsLTMYeWgpJq6jpLqGDYmizvWGWzgyc3k5SR
 Prvg==
X-Gm-Message-State: AOJu0YxwmKvp6+8EQJEqmz0ZgloX9mnlWPxB4xdVqXcgbiOU9SqbKB69
 aYQadtHRB4t3ChDgB1UOp312h8+I14YJegRsgYQ3O1z8s6p0Zgh3mFsA
X-Gm-Gg: ATEYQzxZmyGJ1eH7vx7zUWpzTRIk3f/7BnKZ34Rrog/eFPmGjtdd6kBphtZkqPBQ0xf
 o+7BOEuawz4miDYji1/jjdOLbV+46KjB+4FUwm8MUvuKKKnm3dktoNGwsr0fRUqr0tYlr/Vk/WX
 P8Az6/c7dZnSIrHUOMvrexV189opG96iXe/fXEaiL9Mzl5bwUB03uneNzH69ugC3TBToZS1+yBZ
 QhLhbv6kGiaEKQkQQd0xa/YaillJqwpmKzDggLLztar6da2A9ZkElKqJTEss2mt2SHFLURbfAvj
 gIJzKjxhq34sp0PtJuqxz6XeKDVLH/ThzkRPgYGG3fLtkhC+0V1gRd3FU0Yp5n0gFKLGp6wXowk
 QgE/NgjsGTQAS8Ct5L3Q/og9k8E3FFOutrl8gZMOijFYSeA7Xj0SBgfkvuyxW1fLONFJ3LTiOiK
 TkiuKELbOqZ32NU4TA5CZzDOw4twoAOliGDzPohXb/O8WhCAORoPKwjBxi3GdndL8qD3EB5DIyO
 +GHjaS0VVML8imCZmKO0u1F318Bnk/XgwDd
X-Received: by 2002:a05:6a21:2c12:b0:35d:7f7:4aac with SMTP id
 adf61e73a8af0-398eccf5230mr12827288637.47.1773675812990; 
 Mon, 16 Mar 2026 08:43:32 -0700 (PDT)
Received: from [192.168.1.164]
 (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c73eb996257sm9417128a12.9.2026.03.16.08.43.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 08:43:31 -0700 (PDT)
Message-ID: <b25ebc98-8697-4f1c-989e-fb67d9dc6713@gmail.com>
Date: Mon, 16 Mar 2026 08:43:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/RFT] vfio/pci-quirks: Quirk for ath wireless
From: James Prestwood <prestwoj@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, quic_bqiang@quicinc.com,
 kvalo@kernel.org, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, dwmw2@infradead.org, iommu@lists.linux.dev,
 kernel@quicinc.com, johannes@sipsolutions.net, jtornosm@redhat.com
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <20240812170045.1584000-1-alex.williamson@redhat.com>
 <20240813164341.GL1985367@ziepe.ca>
 <20240813150320.73df43d7.alex.williamson@redhat.com>
 <20240813233724.GS1985367@ziepe.ca>
 <20240815105905.19d69576.alex.williamson@redhat.com>
 <20240815171935.GO3468552@ziepe.ca>
 <fb53b8fd-5d36-4df3-a9e6-fba7c0457e55@gmail.com>
Content-Language: en-US
In-Reply-To: <fb53b8fd-5d36-4df3-a9e6-fba7c0457e55@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=prestwoj@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 16 Mar 2026 16:34:24 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 3/16/26 7:58 AM, James Prestwood wrote:
> On 8/15/24 10:19 AM, Jason Gunthorpe wrote:
>> On Thu, Aug 15, 2024 at 10:59:05AM -0600, Alex Williamson wrote:
>>
>>>> This is probably the only way to approach this, trap and emulate the
>>>> places in the device that program additional interrupt sources and do
>>>> a full MSI-like flow to set them up in the kernel.
>>> Your last sentence here seems to agree with this approach, but
>>> everything else suggests disapproval, so I don't know where you're
>>> going here.
>> Trapping and emulating is fine.
>>
>> My concern is really only about skipping SET_IRQ.
>>
>> That works because of the assumption that the IMS sources are going to
>> re-use addr/data pairs setup in the MSI CAP.
>>
>> That assumption is frail, and won't work at all under the proper IMS
>> support Linux now has.
>>
>> I really don't want to go down the road and have someone tell Thomas
>> he can't convert the Linux driver to use irq_domain IMS because it
>> will break this stuff here.
>>
>>> I have no specs for this device, nor any involvement from the device
>>> vendor, so the idea of creating a vfio-pci variant driver to setup an
>>> irq_domain and augment a device specific SET_IRQs ioctls not only 
>>> sounds
>>> tremendously more complicated (host and VMM), it's simply not possible
>>> with the knowledge we have at hand.
>> It seems like you have reverse engineered alot of the necessary
>> information though??
>>
>> Maybe there is a more generic approach than a variant driver. If you
>> wanted to use IMS from userspace generically you could imagine some
>> kind of IMS focused "SET_IRQ" in generic VFIO. Where we'd create the
>> needed irq_domains and pass the addr/data pair back to userspace?
>>
>>> I observe that the device configures MSI vectors and then writes that
>>> same vector address/data elsewhere into the device.  Whether the device
>>> can trigger those vectors based only on the MSI capability programming
>>> and a secondary source piggybacks on those vectors or if this is just a
>>> hack by Qualcomm to use an MSI capability to acquire some vectors which
>>> are exclusively used by the secondary hardware, I have no idea.
>> Well at least that should be testable - but it seems crazy if the
>> device has registers for an addr/data pair and then somehow doesn't
>> use the values that get put in them??
>>
>> Copying from the MSI is almost certainly a SW hack because IMS support
>> has never really existed in an OS until now. I think your guess for
>> why it is like this is pretty good.
>>
>>> I do not believe that introducing a vfio device feature that disables
>>> virtualization of the MSI address/data _only_ at the vfio interface
>>> (not to a QEMU VM) provides some implicit support of this device
>>> behavior.  These values are already available to a privileged user in
>>> the host and the same is available for an MSI-X use case by directly
>>> reading the MSI-X vector table.
>> To be clear, I'm not really worried about showing the data to
>> userspace.
>>
>> Userspace just shouldn't be using it to implement an IMS technique!
>>
>> Jason
>
> I see this thread went stale. Wondering if there was ever a final 
> conclusion if this could get fixed for ath11k or not. I tried again on 
> a recent kernel, 6.17, and see the same behavior.
>
> Thanks,
>
> James
>
I addition, I've looked at various kernel version and see no time where 
there was ever a "hw/vfio/pci-quirks.c" file in the tree. I tried many 
versions between 6.17 and 5.11, I don't see the "hw" directory at all.

I'd like to try this patch out, but might need some guidance on what 
kernel version this was meant for and if files may have shuffled around.

Thanks,

James


