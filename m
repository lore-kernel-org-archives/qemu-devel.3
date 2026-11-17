Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4419606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CwGW5rUs;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=bEtQigMO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTGwz-00081J-HI; Tue, 17 Nov 2026 06:02:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xTGwy-000819-Ca
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 06:02:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xTGww-0001yd-Kw
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 06:02:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794913324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tZ/lVmCr8hXWWdIDQ3e+oN31m9fEXi1r7/UZV1C0Oe8=;
 b=CwGW5rUsMgTSOgSVj+SSiWQyJHboDbudLVV5lwTw1nJ+GD/v53+HCaeOLvreywc/BPvElC
 EYl260GsP//7n/oBeAKxkrl+j3auFbWG3LzZ2K7Mnv5lsQeJVt/+ewcKLcoZYXhsFzCOEw
 u2WM5uGT7VoSENYdHes+mg2VEogW4nI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-OGHU8bqROKq5CGuKWJmOlA-1; Tue, 17 Nov 2026 06:02:03 -0500
X-MC-Unique: OGHU8bqROKq5CGuKWJmOlA-1
X-Mimecast-MFC-AGG-ID: OGHU8bqROKq5CGuKWJmOlA_1794913322
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4ad3d35e899so33874025e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 03:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794913322; x=1795518122; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tZ/lVmCr8hXWWdIDQ3e+oN31m9fEXi1r7/UZV1C0Oe8=;
 b=bEtQigMOYh6TP6ET0eEyXHkclUsA9ZLe/MqpRniEiAjr5SK6ZRtfyKcbQMjdOApvVR
 dkPPNVsTrroiW6YK8+WY/6rffS+l76/SSlzoOqoogaD9Y5cMNaKKsjEP3QB3pVBMJEDr
 uMiEpFqVeaxWqZtXqGr3sFHQvMz8a9kbBiQ2WX6dlvhVI4X1CpIp+TSz56xikZCuZPNt
 ErEHKXF2eOlcIT0AoGHXTohiZ0+X/UZJceJunIxSVOyby9HgmRtA8yTNjbWfpstXdC0x
 sY1MJ39hycSn50+02BLFHbTEVeCoCULEQw0/WL04EO3nmAUXqOv82j4ARPj9fWmHAUw+
 6How==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794913322; x=1795518122;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tZ/lVmCr8hXWWdIDQ3e+oN31m9fEXi1r7/UZV1C0Oe8=;
 b=jHuvCtbfyHymj3Sn3UdRpWC3Z/85+2NxZBs71UrkB8Gr7Pa2IrWg3MMd2M+ZT9l5uw
 hLkMbG/KpCEaZiWhhxOKC1VLIQvVrgK4I5bVXJENcYZrkjg6ImueahuWcutXkHbvr65/
 /GAoUXMX3aXWq7480Csenc4GOTK1jqgfge3ZiZJkPT8Ff+Cl8oEkvwJKES+mrE0HRHEV
 PcukbYqZfYVerUuGgZ5r5OilUPQL3DGQMCH/NRwOrRcs7UJQlNRpjHvGgk8TpFaMo0JZ
 W/bogJ8qVX2Qgze6xiYh7NSyYPmcA7sSkpsUjUTGrG48e/sd9SL2b5lpMRvs1BJHkIYo
 L/Dw==
X-Gm-Message-State: APuU4Z+HGJzXQgQlAXJcewqzuKQn9SyZ7fdg855mZnMOwvIX76DiRWaP
 Z6f50mfPX2N9HSNvXw709xi7dHxSEgcj2XBK8AHy0lALUB5jUMQfflLOt2/ZA4JxRalcSp1aZ+e
 wRhZ3hyZ/OKOfg0Zkum6+3QfEBDcIKAE+jfNWlXrhNtU/3jrq8mNgO2jg
X-Gm-Gg: AYBFou3Hx+V37FjnqxQFFC26/l1I5nhN7ixWKBltz1+PCathhqdJDvBgZy6uEn/nVyG
 EPPc/vrbdYfmRXroUIsHCH0JL7PhfXBGcJcWu83rXjoLB2TMiVMiHmSSx3xjpmV3jWlB3VOdHIJ
 AZuAOAjTrWVQ/4Rmx7w3VWLgY9gbjfVzX7PJEwNZR0pRro00Xs8dxqPJ2Svv4r5QMkdTw6S+VAh
 GfMpzQ6u6bEa17NyhRdgKvuzc5g3noJrFZbXW+J5323E4wBPyuQsQPYbuKJxfIh6HgSAGP/fy5o
 aXcWQxqTBPiticqD8lthFNJ+kOOdYOsVpFlpYUeXWRuxZH/oWJga0wytQQCx6dNrcEUrH9cyslO
 ZuUN7DqrUR0p70/96toBAatQdaYxv7q5+fW4OpOVsOScAQQ==
X-Received: by 2002:a05:600c:548f:b0:4bb:7033:c938 with SMTP id
 5b1f17b1804b1-4bb7033ce24mr124805475e9.14.1794913322112; 
 Tue, 17 Nov 2026 03:02:02 -0800 (PST)
X-Received: by 2002:a05:600c:548f:b0:4bb:7033:c938 with SMTP id
 5b1f17b1804b1-4bb7033ce24mr124805105e9.14.1794913321548; 
 Tue, 17 Nov 2026 03:02:01 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.156])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a2e6c765dfsm6264105f8f.33.2026.11.17.03.02.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 03:02:00 -0800 (PST)
Message-ID: <f04c5eb3-80c0-424c-a9ed-3a1f7df3922c@redhat.com>
Date: Tue, 17 Nov 2026 12:01:59 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/rtl8139: Limit DMA transfers to plain memory
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowangio@gmail.com>
References: <20261113165015.1150646-1-peter.maydell@linaro.org>
 <66899f0f-8f36-4963-a899-6a960dd3f963@oss.qualcomm.com>
 <CAFEAcA-YC4siSNtZUXdMzFWh6fZWPKBbQKctX9rUWT9hghduBA@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA-YC4siSNtZUXdMzFWh6fZWPKBbQKctX9rUWT9hghduBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 17.11.26 um 10:49 schrieb Peter Maydell:
> On Mon, 16 Nov 2026 at 22:19, Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> On 13/11/26 17:50, Peter Maydell wrote:
>>> There's no reason for the RTL8139 to be doing a DMA transfer to
>>> something that isn't memory, and allowing it can cause weird
>>> re-entrancy problems, such as a DMA to the PCI hot-unplug register
>>> causing the device to be deleted while it's halfway through doing
>>> something.
>>>
>>> Replace the calls to pci_dma_read() and pci_dma_write() with
>>> local functions that are identical except that they pass
>>> a MemTxAttrs that forbids non-memory accesses.
>>>
>>> This is the same approach we took to a similar problem with
>>> the hcd-xhci USB controller in commit 89e653b7736 (but differs
>>> from what we did for lsi53c895a in commit 4862d2c95104d).
>>>
>>> The known trigger for this bug requires that you turned off
>>> ACPI hotplug on the QEMU commandline with
>>>     -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off
>>> so most configurations won't run into it.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Fixes: 3ada003aee2004d24f2 ("rtl8139: Use PCI DMA stub functions")
>>> Fixes: CVE-2026-128868
>>> Reported-by: VictorCHEN <ahchen-yz@outlook.com>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>> I'm also wondering whether there's an approach to this class of
>>> bugs that would avoid us having to modify specific devices to
>>> insist on DMA-to-memory. It seems a bit dubious that writing to
>>> the PCI hot-unplug register can cause us to unrealize the plugged
>>> device even if lots of other things are still holding a reference
>>> to it. Or else we need to be more specific that you can still
>>> validly (in the sense of "doesn't break things") do things on or
>>> as part of an unrealized-but-not-yet-freed device, and move
>>> things like pci_config_free() from unrealize to deinit.
>>
>> While still thinking about that, ...
>>
>>>
>>>    hw/net/rtl8139.c | 98 +++++++++++++++++++++++++++++-------------------
>>>    1 file changed, 60 insertions(+), 38 deletions(-)
>>>
>>> diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
>>> index 16479284eea..6644c1b62c5 100644
>>> --- a/hw/net/rtl8139.c
>>> +++ b/hw/net/rtl8139.c
>>> @@ -513,6 +513,28 @@ struct RTL8139State {
>>>        int rtl8139_mmio_io_addr_dummy;
>>>    };
>>>
>>> +/*
>>> + * There's no reason for the RTL8139 to do DMA to something that
>>> + * isn't memory, and it can cause weird re-entrancy problems if e.g.
>>> + * a DMA write targets the PCI hot-unplug register for the device.
>>> + * Set memory=1 in the memory attributes to avoid that kind of thing.
>>> + */
>>> +static MemTxResult rtl8139_dma_write(PCIDevice *dev, dma_addr_t addr,
>>> +                                     const void *buf, dma_addr_t len)
>>> +{
>>> +    const MemTxAttrs attrs = { .memory = true };
>>> +    return pci_dma_rw(dev, addr, (void *)buf, len,
>>> +                      DMA_DIRECTION_FROM_DEVICE, attrs);
>>> +}
>>> +
>>> +static inline MemTxResult rtl8139_dma_read(PCIDevice *dev, dma_addr_t addr,
>>
>> (drop inline)
> 
> Agreed. This was a cut and paste from the pci_dma_read() prototype.
> 
>>> +                                           void *buf, dma_addr_t len)
>>> +{
>>> +    const MemTxAttrs attrs = { .memory = true };
>>> +    return pci_dma_rw(dev, addr, buf, len,
>>> +                      DMA_DIRECTION_TO_DEVICE, attrs);
>>
>> ... these new helpers correctly return a MemTxResult but the
>> callers still ignore it. I appreciate this would be a larger
>> rework, unlikely worth it. What is your plan?
> 
> I don't care enough about the rtl8139 to do that kind of spring
> cleaning on it (and a memory transaction error will only happen
> if the guest is doing something stupid, in which case we don't
> care as long as it doesn't cause actual security problems).
Maybe you could change the return type to "void" if it's ignored anyway, and 
simply do a qemu_log_mask(LOG_GUEST_ERROR ...) in the new function in case 
the pci_dma_rw failed?

  Thomas


