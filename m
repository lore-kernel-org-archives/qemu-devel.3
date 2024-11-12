Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D664BD42B85
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 14:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAsDi-0004cZ-4s; Tue, 12 Nov 2024 09:50:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1tAsDd-0004aN-0D; Tue, 12 Nov 2024 09:50:13 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1tAsDb-0001yk-49; Tue, 12 Nov 2024 09:50:12 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20cdb889222so57557505ad.3; 
 Tue, 12 Nov 2024 06:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731423006; x=1732027806; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=chDV7Dn9RtL2qF7ryUXtam4P1gC87SoHR2wDq24iu18=;
 b=DN9RjAq2Y/Db1SCGwdRwGIRNxEi58ufb5cVAKSychTlAdqd/R54g5oYdHY8MCaliO4
 qWaW4onlIe8pfgjcRqwneKQf3ZGEIVPp6P83JOX3ZW+TeZ827p7meSRfvT+wKuT7mfV/
 sh4uV1HgFb9VcMAemMtqVMnZiHZkfDvHgIDJnRFopFt8nMeXD5IZEYPfh3q1ViaLmklZ
 /T770JnXX/sqgDNbYUoqoLg3I8yc0bjC9s7j81RPFRJcPKYtFRsUP6OAGADarNtxW3YR
 9P/DfVdpzqqL1Oupr1uulKwbsgnyV4tF6H65qdgXM/7Gp5lzvho0pj/BQhlZ1OI6Fc8E
 5wOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731423006; x=1732027806;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=chDV7Dn9RtL2qF7ryUXtam4P1gC87SoHR2wDq24iu18=;
 b=tVKLO5hBMUP2D7bg08lpWCtwlAmz0NT0tiq3k7ym1icv3wn9VcmANu+HPjCQaJuMSB
 iHS9bzlz3gXD1F+CyPkdpqea5iC+j3hIoRvHEaFg+8XXsFXNJ0poWxREk3wesVuMcopX
 ZYLmlJTXmeuXW8j/2dygW6sdKcbA1zLY90ka/HD8K4jVx33C1zx78l45bp5OBf3htw3n
 dNXEn4RvhlEt6/8JIj0iF2ckGMknvmlPQFqhiavxGd7w/IRrEzBBKoD8n38nBTozXnQi
 88FdCsB6y9iSGAF0S3IjVLMHI2J2jcSPAojK1jAQqUcS9qa0696gtxRCzsueB7MSVgUu
 R9Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5o2EILDoXTaID+NFp1wZlWG0HFS0l4fNQg5tvwtZeq8ubGSoC+IHS/YbpkWsuKAeNOsIFWg7yToam2w==@nongnu.org,
 AJvYcCUiv4y/q0JEgkBSsvi3Y5/3+EIvtWWIY+uMBJkWlQoquWNRjRRustd+MfsUMhyp3v7gB0Ggsr8OAg==@nongnu.org
X-Gm-Message-State: AOJu0Yy5G18zOnFC92660veeBCI2b9cg8JZyCzGP5RCyZwVokwHQowMN
 Q0RwZW7x69r0pyvu9LfqQDGM37TvOZ45ncq3YFGOz4PLJTZF4Mvj
X-Google-Smtp-Source: AGHT+IGP1Ep5libKrIkMYFe6kp6xLRQmwTIYLnrW+5Onzrvc0/Nw4dnFjUX8t1feXdOwQbmfOe76gw==
X-Received: by 2002:a17:902:db02:b0:20b:7be8:8eb9 with SMTP id
 d9443c01a7336-211835ee323mr233089045ad.54.1731423005462; 
 Tue, 12 Nov 2024 06:50:05 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177e590fcsm92776805ad.202.2024.11.12.06.50.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 06:50:04 -0800 (PST)
Message-ID: <ee184371-68f0-4982-8f94-2170332fbc8a@roeck-us.net>
Date: Tue, 12 Nov 2024 06:50:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/8] usb/uhci: Move PCI-related code into a separate
 file
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 BALATON Zoltan <balaton@eik.bme.hu>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
References: <20240906122542.3808997-1-linux@roeck-us.net>
 <20240906122542.3808997-4-linux@roeck-us.net>
 <2a318a7f-dd37-4fce-9106-7a85236c9408@redhat.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <2a318a7f-dd37-4fce-9106-7a85236c9408@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Thomas,

On 11/11/24 22:32, Thomas Huth wrote:
> On 06/09/2024 14.25, Guenter Roeck wrote:
>> Some machines (like Aspeed ARM) only have a sysbus UHCI controller.
>> The current UHCI implementation only supports PCI based UHCI controllers.
>> Move the UHCI-PCI device code into a separate file so that it is possible
>> to create a sysbus UHCI device without PCI dependency.
> 
>   Hi Guenter,
> 
> I think there's a bug in here ...
> 
>> diff --git a/hw/usb/vt82c686-uhci-pci.c b/hw/usb/vt82c686-uhci-pci.c
>> index 6162806172..7fdb4697f9 100644
>> --- a/hw/usb/vt82c686-uhci-pci.c
>> +++ b/hw/usb/vt82c686-uhci-pci.c
>> @@ -1,17 +1,17 @@
>>   #include "qemu/osdep.h"
>>   #include "hw/irq.h"
>>   #include "hw/isa/vt82c686.h"
>> -#include "hcd-uhci.h"
>> +#include "hcd-uhci-pci.h"
>>   static void uhci_isa_set_irq(void *opaque, int irq_num, int level)
>>   {
>> -    UHCIState *s = opaque;
>> +    UHCIPCIState *s = opaque;
> 
> You use UHCIPCIState as parameter for the irq-related functions...
> 
>>       via_isa_set_irq(&s->dev, 0, level);
>>   }
>>   static void usb_uhci_vt82c686b_realize(PCIDevice *dev, Error **errp)
>>   {
>> -    UHCIState *s = UHCI(dev);
>> +    UHCIPCIState *s = UHCI_PCI(dev);
>>       uint8_t *pci_conf = s->dev.config;
>>       /* USB misc control 1/2 */
>> @@ -21,12 +21,12 @@ static void usb_uhci_vt82c686b_realize(PCIDevice *dev, Error **errp)
>>       /* USB legacy support  */
>>       pci_set_long(pci_conf + 0xc0, 0x00002000);
>> -    usb_uhci_common_realize(dev, errp);
>> -    object_unref(s->irq);
>> -    s->irq = qemu_allocate_irq(uhci_isa_set_irq, s, 0);
>> +    usb_uhci_common_realize_pci(dev, errp);
>> +    object_unref(s->state.irq);
>> +    s->state.irq = qemu_allocate_irq(uhci_isa_set_irq, &s->state, 0);
> 
> ... but you set it up with UHCIInfo as parameter here. I think this line should rather be:
> 
>      s->state.irq = qemu_allocate_irq(uhci_isa_set_irq, s, 0);
> 
> Shouldn't it?
> 

Yes, you are correct. Thanks for reporting it. Turns out I had fixed that in the
meantime, but did not remember to send another version. Is there any interest,
and should I resend ?

Thanks,
Guenter


