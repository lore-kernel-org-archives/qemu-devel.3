Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B02E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 11:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN96h-0006oX-5t; Mon, 16 Dec 2024 06:17:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tN96f-0006o8-Cm
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 06:17:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tN96d-0000zP-LU
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 06:17:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734347861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=I5DjKj14OX5oOaCGEUlywL/Vb2jWBEJAo7bPTddEDrg=;
 b=COAl/xW05CokzGGK8YuxD87oauGIATCbFLvps/bhqtnKxi803npCrd4B02/XLb/tK8faBm
 Ze6Rtc6XorCdgr1mFhwQhbKJU69HUPXp8yaOI8URk4m1Ne+0B3p/HVz26qaTHJmX7kDkM8
 TJkEXKlOenVnU3OkkqTq54LoCrg/i/g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-6mldbKhUM-Oe5-2ESuNeog-1; Mon, 16 Dec 2024 06:17:40 -0500
X-MC-Unique: 6mldbKhUM-Oe5-2ESuNeog-1
X-Mimecast-MFC-AGG-ID: 6mldbKhUM-Oe5-2ESuNeog
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d8e891a5f7so47145876d6.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 03:17:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734347859; x=1734952659;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I5DjKj14OX5oOaCGEUlywL/Vb2jWBEJAo7bPTddEDrg=;
 b=XbjydB/EFGeaB0JiF38wpvoUXXra0xSeZ3oe4ENNv8yecD7KKl9OqJ+2dFnIv+h9ua
 B1fHnDLLP0YxGOhE/X1D9MBiV/ggpMRG7udA6EgG6HLMi5MvqpfRcozGGjcd6lBZ7GVE
 GlL6Qe2roCzqiwX8Hb4DAp6WyDX0hodEnAf42WF6SiN62OWT2H7OPJS23iBPDjY/JZaK
 fhwsDNSKeV07VCEs/7MyiaKATcl4A3uz6KKDZKuuTkIMriHdXLsmLyXcfdFgRUCfq4+P
 Ae2/450kem1vYKtkn0HBGGZIgRb0BOoc7pIhNDWT1bKSn9KTe+2WXygN0vGjT6HicZ4F
 eyRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkoD2fQ6xqb96burw/rgNzhvsGjO3oAIEuUlWF3duv1rJ9q5A/VmF7ky6YALL6QwHbUW2hSYhUJCbe@nongnu.org
X-Gm-Message-State: AOJu0Yy4NyAUdXPkbixejlnHeOYv4mZK5UqqTMY18skr2RiGerDivsS8
 9QSMolN6X9PTp6q6W+Airic+LFLWxORRxDRwvwB/YLgzb6s5HFQ7E8LQW5xhbZc6ZVkeIjuW2ci
 5J9npz0zal4n0GNusinG7HfuQIx9wgsYmURUxMkUJpMqzdqzI1zvL
X-Gm-Gg: ASbGncviX9RIqYkPqw2JJX47/ESJX3GGnD7bFjr6fZyKR34Q816O2tU+5y+3y8ykYyJ
 wQr+qXgzn20ozYQV0SRtdsXUquctgspqmPk/aAD3QY+T5PhmybvvN4pSXor+klAKb30htFHAOVP
 U4iuxRpcEZOZHm3lU56ScDxn9waKhSuFaoYTB7NoDKrzom/2M5vYRxu1AXr2d9Tbkwimf241m5M
 L7WUe/EdxyupXO8x1k/x54/5yA6LPdTAVZ8p2CEZzxb1ZacTYTzQ5A+rxp7fMCxSnztwSd7LaDe
 Kld9jkpI/Q==
X-Received: by 2002:a05:6214:20a3:b0:6d8:899e:c3bf with SMTP id
 6a1803df08f44-6dc9032067bmr214133726d6.34.1734347859712; 
 Mon, 16 Dec 2024 03:17:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpAanT/eXxgYKZg1TS94esigBhQjjzF+A2ixt9EjXe5uTurqluwKMCUbgW2BvqyGCPCslGUg==
X-Received: by 2002:a05:6214:20a3:b0:6d8:899e:c3bf with SMTP id
 6a1803df08f44-6dc9032067bmr214133486d6.34.1734347859439; 
 Mon, 16 Dec 2024 03:17:39 -0800 (PST)
Received: from [192.168.0.6] (ip-109-42-51-17.web.vodafone.de. [109.42.51.17])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd257155sm26117196d6.44.2024.12.16.03.17.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 03:17:39 -0800 (PST)
Message-ID: <dbb457a1-9eb6-4d71-a5e4-84f6679cd9fe@redhat.com>
Date: Mon, 16 Dec 2024 12:17:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 34/34] next-cube: replace boiler-plate GPL 2.0 or later
 license text with SPDX identifier
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: huth@tuxfamily.org, qemu-devel@nongnu.org
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
 <20241212114620.549285-35-mark.cave-ayland@ilande.co.uk>
 <Z1sdIURVdJL8p6cC@redhat.com>
 <fa8ce465-e539-48ec-abf8-d7296ae42b8a@ilande.co.uk>
 <Z2ADHbndSn-vrYsK@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Z2ADHbndSn-vrYsK@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.168,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16/12/2024 11.38, Daniel P. Berrangé wrote:
> On Sat, Dec 14, 2024 at 08:38:06PM +0000, Mark Cave-Ayland wrote:
>> On 12/12/2024 17:28, Daniel P. Berrangé wrote:
>>
>>> On Thu, Dec 12, 2024 at 11:46:20AM +0000, Mark Cave-Ayland wrote:
>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>> ---
>>>>    hw/m68k/next-cube.c | 5 +----
>>>>    1 file changed, 1 insertion(+), 4 deletions(-)
>>>>
>>>> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
>>>> index 1e96bb02f8..3c2f3e295c 100644
>>>> --- a/hw/m68k/next-cube.c
>>>> +++ b/hw/m68k/next-cube.c
>>>> @@ -4,10 +4,7 @@
>>>>     * Copyright (c) 2011 Bryce Lanham
>>>>     * Copyright (c) 2024 Mark Cave-Ayland
>>>>     *
>>>> - * This code is free software; you can redistribute it and/or modify
>>>> - * it under the terms of the GNU General Public License as published
>>>> - * by the Free Software Foundation; either version 2 of the License,
>>>> - * or (at your option) any later version.
>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>>     */
>>>
>>> While adding a SPDX-License-Identifier alongside existing header text
>>> is acceptable, my view is that we should stay away from removing existing
>>> license headers. There are some difficult questions wrt interpretation
>>> of the GPL in this area & avoiding opening that can of worms would be
>>> nice.
>>
>> I remember you mentioned this before, but I wasn't sure if this would be
>> mitigated by the fact that the code originated from GSoC? I'm sure I've seen
>> at least one recent patch that made a similar change, but if there really
>> are legal reasons not to allow changes of this type then I shall drop it
>> from the series.
> 
> GSoC isn't really important. The challenging problem here is GPL clause 1
> which says
> 
>    "keep intact all the notices that refer to this License and to the
>     absence of any warranty"
> 
> there are differing opinions on how strictly to interpret the "keep intact"
> language there.
> 
> While we could have a debate over this and come to some project opinion
> IMHO it is a better use of our time to just not remove existing notices.

I generally agree with Daniel here ... but in this special case, I should 
maybe mention that Bryce's original file only had a "This code is licensed 
under the GPL" statement in it:

  https://github.com/blanham/qemu-NeXT/blob/next-cube/hw/next-cube.c#L12

IIRC it was me who replaced that with the usual boilerplate when I picked up 
his work to get it included in the upstream QEMU. And for me, it's fine if 
we switch to SPDX here, so in this special case, it might be OK to replace it?

  Thomas


