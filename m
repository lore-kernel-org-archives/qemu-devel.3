Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29FE10A62DA
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 14:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5lcN-0001q3-H9; Thu, 26 Mar 2026 10:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w5lcM-0001oe-Cj
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 10:23:26 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w5lcK-0007Fq-Uw
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 10:23:26 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 4672c174be1b1dddd4b896e00e537c8606a2d15c795bb35a340774dab9ba4457 with SMTP id
 69c5415a35e5318eb8c58b96; Thu, 26 Mar 2026 14:23:22 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1774535001;
 bh=7/nGmhoH3sKOLJwyqqBuCyO5NaRJ714yeRSKynUoLeo=;
 h=Message-ID:Date:MIME-Version:Subject:To:References:X-Mailgun-Dkim:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:From:
 Reply-to:Subject:Date:Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=l12Uvc+/fOw+mBrH/JMlGTK+c3FZBoeN5zxbqt1xl7H99pR71EVJQ3QybviRCpyNT
 gaJL6QqgNh87NoEbUtf46dzlhmIObB2okd1cvQkq7hYWm81sZtC7MrP8Hr8hTHvo1T
 0Ve00zWqs4evCe0Ze0NFGi6L3pVfRniA/thIttD8F/jx7+avn4VhasWnMFArEqN32o
 MrsoZ0hCblCy1IZaY4uHrblI1Ww6a5BLolcqqezKxDNAkABSBqw0MDkbAvjAJcYA4J
 UkwA33XoxLWqCXGabLl3Z3w/XTZxWWIiyTLCBf6YGdZL5bh56xxBhg5UaDt0jqRdTx
 l7ZAj4PfIb23Q==
Message-ID: <5c3050df-20a9-4e58-b918-7ce503313780@yodel.dev>
Date: Thu, 26 Mar 2026 09:23:21 -0500
MIME-Version: 1.0
Subject: Re: [PATCH 03/15] hw/alpha/dp264: Validate kernel and initrd sizes
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
 <20260310-qomify-alpha-v1-3-4375b00a85ff@yodel.dev>
 <979d9029-c49b-4bdd-823c-ca356d63a1c3@linaro.org>
 <7cd87657-f7fc-41c5-bdde-a5e6c5bf1399@yodel.dev>
 <614e25b5-74e1-4620-947a-3c92ed6f2a9f@linaro.org>
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
In-Reply-To: <614e25b5-74e1-4620-947a-3c92ed6f2a9f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HELO_STATIC_HOST=-0.001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 25/03/2026 22:07, Richard Henderson wrote:
> On 3/26/26 12:04, Yodel Eldar wrote:
>> Hi, Richard
>>
>> On 25/03/2026 19:11, Richard Henderson wrote:
>>> On 3/11/26 08:31, Yodel Eldar wrote:
>>>> @@ -192,7 +192,15 @@ static void clipper_init(MachineState *machine)
>>>>               }
>>>>               /* Put the initrd image as high in memory as 
>>>> possible.  */
>>>> -            initrd_base = (ram_size - initrd_size) & TARGET_PAGE_MASK;
>>>> +            if (usub64_overflow(ram_size, initrd_size, 
>>>> &initrd_base)) {
>>>> +                error_report("initial ram disk exceeds allotted ram 
>>>> size");
>>>> +                exit(1);
>>>> +            }
>>>> +            initrd_base &= TARGET_PAGE_MASK;
>>>> +            if (initrd_base <= kernel_high) {
>>>> +                warn_report("initial ram disk overlaps with kernel");
>>>> +            }
>>>
>>> Why is the first an error and the second a warning?
>>>
>>
>> Initially, I had both as fatal, but then I figured a (mis)adventurous
>> user may actually want to experiment with kernel/initrd overlap, whereas
>> an underflow is something we can't allow (and initrd being larger than
>> RAM is physically impossible AFAIK). I could make the overlap fatal,
>> too, if that's better?
> 
> I can't see it being useful at all.
> 

Heh, fair enough; fatal, it is, then.

Thanks,
Yodel

> 
> r~
> 


