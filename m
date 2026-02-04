Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBD3EA7943
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 22:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnlKW-0001Jc-83; Wed, 04 Feb 2026 17:26:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vnlKU-0001JM-P0
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 17:26:34 -0500
Received: from k62.kb8c70eb.use4.send.mailgun.net ([204.220.184.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vnlKR-00068n-He
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 17:26:34 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 1933c59a14224e5cf95fb1cdada9a2ff1f1f95ad0c1f7101bb2ff79632b2e744 with SMTP id
 6983c78c28aee0c2faf57c18; Wed, 04 Feb 2026 22:26:20 GMT
X-Mailgun-Sending-Ip: 204.220.184.62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1770243979;
 bh=42M3jYuOBwCEeszKUkHWdzzriDyip+bJJYEw379DRlI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 X-Mailgun-Dkim:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=eml4JvMyItlgkaIsmYcAYtOsO2o0awKNEXtXudJOs+FbOGrb1kGkjOLe00+LLMTh3
 XSQKAQeNBhuZj8QUXui9BZDGsyMIpexWlY0kxlkocZ3OxguHpehjByzHQCUEiFXkpk
 tWTHsVX08p9TLufIQRrFtn3/g6aoRbejvEs1FBocxyUX6eqdnd5UASxFkYi2LnrfSr
 0N96B0kObbdKRpDM4DYcH2Bj1GtmL5d+JXXtwvevH0UNlpGVFQFwN5rno4nssdf6Ja
 wCYzvhE1nECjrBjbBMxVzdAgLVpHbV+jOLB/btnb4f0THa6iKIjp1+WF/J+90NOEYL
 dBKLDdS4MSUYQ==
Message-ID: <82b54068-8abe-401f-ae03-121daf09e003@yodel.dev>
Date: Wed, 4 Feb 2026 16:26:18 -0600
MIME-Version: 1.0
Subject: Re: [PATCH] hw/pci: Use correct bus aperture for device container size
To: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Gustavo Romero
 <gustavo.romero@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20251124114754.79831-1-philmd@linaro.org>
 <20260204071045-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Autocrypt: addr=yodel.eldar@yodel.dev; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 I1lvZGVsIEVsZGFyIDx5b2RlbC5lbGRhckB5b2RlbC5kZXY+wpkEExYKAEECGwMFCQOcG00F
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTTzRjNQG27imap+N+V7k+3NmVNrAUCaNWASwIZ
 AQAKCRCV7k+3NmVNrNnSAPoDjQXa6v7ZzdQSaLdRfAQy/5SsUucv+zp3WAP4pXdgJQEAzMMC
 Ctx4l6b13Fs2hZdRXEnF/4BZ9t1K68nwzZOV3QnOOARnGpd2EgorBgEEAZdVAQUBAQdAKPIy
 3W/DKFsm1e+31zoqmOY0pqz8vjIM846wM6lEY2QDAQgHwn4EGBYIACYCGwwWIQTTzRjNQG27
 imap+N+V7k+3NmVNrAUCaNWG7QUJA5wi9wAKCRCV7k+3NmVNrPusAQCQDQwETy7VT6UhHPho
 TkrQnsNqQfFU3tXqCTiViToktQD7B/U2/to97hQIJCWbK6yd3T+KPZJPMcHMg2XRyedUvgA=
In-Reply-To: <20260204071045-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=204.220.184.62;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=k62.kb8c70eb.use4.send.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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



On 04/02/2026 06:29, Michael S. Tsirkin wrote:
> On Mon, Nov 24, 2025 at 12:47:54PM +0100, Philippe Mathieu-Daudé wrote:
>> Before commit 3716d5902d7 ("pci: introduce a bus master container")
>> device view of the bus address space was correctly sized to the
>> bus aperture, but then it always used a 64-bit aperture. Restore
>> the previous behavior, so devices on 32-bit PCI only see 32-bit
>> address space.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> 
> Wait I am confused. Is there a problem this is trying to fix?
> 
> 
>> ---
>>   hw/pci/pci.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index b1eba348e06..64f33b9de04 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -1375,7 +1375,8 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>>       pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
>>   
>>       memory_region_init(&pci_dev->bus_master_container_region, OBJECT(pci_dev),
>> -                       "bus master container", UINT64_MAX);
>> +                       "bus master container",
>> +                       memory_region_size(bus->address_space_mem));
> 
> as far as I can tell this does more than it says it does.
> 
> 
> Look at raven.c:
>                                                                                                                                           
>    h->bus = pci_register_root_bus(d, NULL, raven_set_irq, raven_map_irq,
>                                   s, &s->pci_memory, &s->pci_io, 0, 4,
>                                   TYPE_PCI_BUS);
>                                                                                                                                           
>    The bus is created with &s->pci_memory (1G) as the address space.
>                                                                                                                                           
>    But the actual bus master space (&s->bm at line 285) is 4 G.
>                                                                                                                                           
>    Your patch limits DMA to 1G. No?
> 
> failures here (definitely the ppc one)
> 
> https://gitlab.com/mstredhat/qemu/-/jobs/12984084992
> 
> reverting fixed it:
> 
> https://gitlab.com/mstredhat/qemu/-/jobs/12984187692
> 
> 
> 
>

Thanks for the catch, Michael.

Sorry, I wasn't aware of this quirk in raven when I acked. Looking into
it now, it seems that prior to 97db0466788 its pci_memory had size
0xff000000 as a workaround, and that would indeed "fix" the regression
here, too, but is probably not preferable to leaving the bus master
container maxed out. What do you think, Philippe?

  

>>       address_space_init(&pci_dev->bus_master_as,
>>                          &pci_dev->bus_master_container_region, pci_dev->name);
>>       pci_dev->bus_master_as.max_bounce_buffer_size =
>> -- 
>> 2.51.0
> 
> 


