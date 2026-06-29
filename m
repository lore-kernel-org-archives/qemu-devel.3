Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5309EC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCGW-00033i-HO; Mon, 29 Jun 2026 09:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1weCGU-000329-So
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:43:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1weCGS-0005yu-Kt
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782740587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=k0f/x7Q1eGmd41OwUbZixhPfdvPYrBA43BVZuZAXcW4=;
 b=CB+p3HIbsJDiOC6IEObdSc8cVxcwy11Ovk8ZyMPkFWa5JOH8/hBjdlTweEyJ8TnM01tvRt
 zlbkYhWxA82OsuB1is1Ce3XeXeZuwp9UwBIDG4DHokrpocwSTjGCSciuqr9ayCSeGlzNOa
 64LO2R87b4z9RY/JsK/M+AKxciotUsI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-uEbd--TGMHWnYaEKLXS6kA-1; Mon, 29 Jun 2026 09:43:04 -0400
X-MC-Unique: uEbd--TGMHWnYaEKLXS6kA-1
X-Mimecast-MFC-AGG-ID: uEbd--TGMHWnYaEKLXS6kA_1782740583
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490bae3a39bso24806425e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782740583; x=1783345383; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=k0f/x7Q1eGmd41OwUbZixhPfdvPYrBA43BVZuZAXcW4=;
 b=V3A9ob7MP3WLAcnKKMYFqBp6uRMp6iOsKtOapuOLlSPoYukEkPZC3sMx3e6f9TY/aY
 Bb4fgFbY1UyfUBsRGmppinCT1XqvpLOGfLmr54qyFXvwJipPq8tvN+u+GvphBMxe1DP3
 jQwClYvyXcTzQ1MvhkaL8yyfpQgO9kwhIunMaFN/qNCxuKNxKlTRxcPv826I9yc3IBJ+
 4CMMm5UVGm8GlPujitz1s87osIRrvto3n29c3VjhrMOmu0QF8IiW0lj7jQffJewr0ttq
 xqyWByhvsKyUOBnHcbB+5pxhnlQ/HYy+B0Q9YwDzwosuZU/+YjOq2ka9xWvTBdv7CKbZ
 spVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740583; x=1783345383;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k0f/x7Q1eGmd41OwUbZixhPfdvPYrBA43BVZuZAXcW4=;
 b=kj09CYa0ffuZWd88RsrEOngzDhtQKa3AHcBR/3fOmaQsPcMOJXu7x40XmtfFJsf4ly
 3umkkZBMI8D7vhi3NmnW0s83QRfSYzG52uoo+yTjRWguj0aAWSD6aqJm+FmhYMLqF9d1
 fIinz17gfQlt1ppWoVYSzRxJWE4m720bWxj0bhxATLietFQA102JsS51IvlVmME/2Ajr
 L0nvtraQuAn2kN0rAHp/40Hcryjfkch8IYEOo6XOT1uYfe91IueLBDb2wBjEz35WZTbk
 7qGBivS/mKix8efEMb15x0mpGClm9Sv8pPWYKwUPAiIF36aPpnPjvAa4cMGMzvzuSJcb
 p6XQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9X/zJKtwU1O6s8HmxQBfqZCN+5LDH1YmZguCAYJeZ4EerMBfFgqG+WdPE0kcBaf2I4VWk8mc6/VZ4a@nongnu.org
X-Gm-Message-State: AOJu0Yz9UAoytWMqaQztheHGtYP6nr/xup0buEFvEV8BMk5XTuUhpaNe
 CPTdp+/81Yt9P0dHzpJZ/iO/Q2SbSJGZANmWHmiQNLLNKcjFZVgcPoKuQ0YPKvbsbMKHrMkatB0
 C5LiDx/iZufwDeDe+3990gXWVTIFz2Qu4E/IhZ0JFbRZ8zVfmn6zT+neZ
X-Gm-Gg: AfdE7cnEhXVhPDSg8YzAkukihN9y86HM9ddZexp40ttqi41UljXHqWLii57QFiFBGrA
 h75p5RUtdzSWc/eR43CTxN9YJ3iPNPNqvRPNpyN6bPuJtcuA/B1UJGXvlxhMfFZCsp02bQpSiwu
 swhaFdFRL7mj7nZAi76va7pcrMRLU4GBYDRupA7Ce9GK0minNm7NiPSiBuRZtIAHIMP/F0zVi5h
 9IOrSVEowG99AfHGBv/EBLA6DcfIWYW8B9BA8OGicu85FpKRvDy1N5hsQ0nOgHaknnKF869XaDN
 mhrbutQhnYR8+2jys5kQTgiDmDgkIgTScMI0OAssBC5/1aVxcncUVkZtoCVyVCVJUHZPTgzz5Kk
 lQ6OIHxU=
X-Received: by 2002:a05:600c:8b31:b0:493:a84a:ec5a with SMTP id
 5b1f17b1804b1-493b71a1951mr12463455e9.12.1782740582977; 
 Mon, 29 Jun 2026 06:43:02 -0700 (PDT)
X-Received: by 2002:a05:600c:8b31:b0:493:a84a:ec5a with SMTP id
 5b1f17b1804b1-493b71a1951mr12462925e9.12.1782740582454; 
 Mon, 29 Jun 2026 06:43:02 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.50]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4728072188fsm16425787f8f.29.2026.06.29.06.43.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 06:43:01 -0700 (PDT)
Message-ID: <c7d6b801-449e-4f55-9c1d-ebec7a0e9595@redhat.com>
Date: Mon, 29 Jun 2026 15:43:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/sparc64/sun4u: Mark unusable PCI busses as full to
 ease device plugging
From: Thomas Huth <thuth@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20260309181452.83702-1-thuth@redhat.com>
 <00c4ab4b-a58b-4de4-8e41-566b2cb7f920@redhat.com>
 <124bd918-f2ab-43e2-bd2d-fc824de62c40@tls.msk.ru>
 <fcbe3d7f-64d4-4b13-b930-a81e77db4784@ilande.co.uk>
 <df7a091c-a8a1-416a-acf3-28a0cbd8dd2f@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <df7a091c-a8a1-416a-acf3-28a0cbd8dd2f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 09/06/2026 08.02, Thomas Huth wrote:
> On 08/06/2026 23.29, Mark Cave-Ayland wrote:
>> On 08/06/2026 09:26, Michael Tokarev wrote:
>>
>>> On 30.04.2026 12:50, Thomas Huth wrote:
>>>> On 09/03/2026 19.14, Thomas Huth wrote:
>>>>> From: Thomas Huth <thuth@redhat.com>
>>>>>
>>>>> When trying to plug a PCI device to a Sparc64 machine, you currently
>>>>> have to specify the right bus ("bus=pciB"), otherwise you get this error:
>>>>>
>>>>>   $ qemu-system-sparc64 -device virtio-scsi-pci
>>>>>   qemu-system-sparc64: -device virtio-scsi-pci: PCI: no slot/function
>>>>>   available for virtio-scsi-pci, all in use or reserved
>>>>>
>>>>> This is quite annoying for the unexperienced users, and it also breaks
>>>>> e.g. the iotests ("make check-block") when running with qemu-system- 
>>>>> sparc64.
>>>>>
>>>>> Mark the non-usable PCI busses as full now, so that QEMU can automatically
>>>>> plug new PCI devices to the right "pciB" bus.
>>>>>
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>   v2: Do the change in the machine code, not in the sabre device
>>>>>
>>>>>   hw/sparc64/sun4u.c | 7 +++++++
>>>>>   1 file changed, 7 insertions(+)
>>>>>
>>>>> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
>>>>> index b8bda1eb816..37539535c6c 100644
>>>>> --- a/hw/sparc64/sun4u.c
>>>>> +++ b/hw/sparc64/sun4u.c
>>>>> @@ -723,6 +723,13 @@ static void sun4uv_init(MemoryRegion 
>>>>> *address_space_mem,
>>>>>       fw_cfg_add_i16(fw_cfg, FW_CFG_SPARC64_DEPTH, graphic_depth);
>>>>>       qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);
>>>>> +
>>>>> +    /*
>>>>> +     * Mark internal PCI busses as full so that the plugging of 
>>>>> additional
>>>>> +     * PCI devices happens on the right bus that still has free slots:
>>>>> +     */
>>>>> +    qbus_mark_full(&pci_bus->qbus);
>>>>> +    qbus_mark_full(&pci_busA->qbus);
>>>>>   }
>>>>>   enum {
>>>>
>>>> Friendly ping!
>>>
>>> This, being a simple change, somehow has not been reviewed still, so
>>> it's sitting in the queue...
>>
>> Yes, apologies - I've been absolutely flat out recently, and I've got a 
>> note to take a look at this and Peter's patch as soon as I can.
>>
>> Is this fixing an urgent issue with "make check-block" or similar?
> 
> It's not urgent since this has been broken forever, but yes, it fixes "make 
> check-block" for the case where sparc64 is the only available target during 
> "configure --target-list=sparc64-softmmu" and thus the iotests run with 
> qemu-system-sparc64.
Ping!

While it's not urgent, soft-freeze date is in a week, so it would be nice to 
get this merged before it misses another release ... WDYT?

  Thanks,
   Thomas


