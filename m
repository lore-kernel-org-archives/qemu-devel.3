Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE340C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 05:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFSc2-0005jt-92; Fri, 07 Jun 2024 01:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sFSby-0005iM-8H
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 01:58:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sFSbw-0003BF-Hc
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 01:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717739878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Hl22h+8l1wylOpXQHZq/1/FPiS9+iPM2w0dMsqQLyYI=;
 b=fCMukEOu7nJI/CoUNo+2ivepr4mbFCPezdO9c0hd4VF89w5iXqf46iRb84dZ1NPNfVKMtK
 htWGOUbcgifLD7I+/BeK6OrIYarArU1oczab/k0UIWuSv1xjTG14jIo3BQ2mdo60wdUKm1
 88qKu8VaFeuFMyrI1RiVglLCnQJ8En8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-47fghdxsPTW0YhCGLcFGlA-1; Fri, 07 Jun 2024 01:57:53 -0400
X-MC-Unique: 47fghdxsPTW0YhCGLcFGlA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-35dcdb26f5eso1381255f8f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 22:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717739872; x=1718344672;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hl22h+8l1wylOpXQHZq/1/FPiS9+iPM2w0dMsqQLyYI=;
 b=D1Tlfa/RYa7gKCm5hzfue6beLpI7LV2a5eeUOhUwgom4P0BWsSeiOMhxyYXu9eOl1F
 7cnaKfLvT4yEakfWCw+p/jHd+2jWGMVlTv6lWGEKEJPSq9UDzbu34C5NxnnBYqG6VfnG
 70ZzCxfIIbPQgkzDq2MIKJbME7ZM6UOmGo4ISg1aSQCklSiDbI75VINW7yJruMsUcQcA
 3aPwWq7KZajQvhNw6JVLZQe/v9W3bhfwLkJxDUfk2S9YedRiJJbVv+PUby1KQjKOX8Ya
 f/+N0AcQdU7YJedGfVs8aMKw1rMxQ6FkU0ertnsSgtg+UQb+NuFs2imkHq4T5OBH/lhe
 XQuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwde+BuH1bgCWcS0UFY6uZLtRwFnY3KrsUR0lOPym8tBuZtbadu8+HZe0z2It7HnDqC16Gk17k2p9gBhMub8g5aPZ1sFw=
X-Gm-Message-State: AOJu0Yxa25/f8vY6DlZuIDp1ZARyYWFSK+qEe93NbOuFzz0RZGcZEL9D
 PT+nJ4T7tAUFD/IzHTLHxjrU0AoyUhchmI5Eq564su4TZSrVFzI7S/4MDl2m3F2RLJtETv3wjtG
 9tMLPopVfzXOXn7GiJ1g24gUvoHrbgG3cjAcpkfXLFef5pwc/pMZ+L0r/wVu4
X-Received: by 2002:adf:e54a:0:b0:356:4cd8:850d with SMTP id
 ffacd0b85a97d-35efed3f241mr1054329f8f.25.1717739871987; 
 Thu, 06 Jun 2024 22:57:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlQE37YwuGInsCjRCbXfJNE+aR/ZqoRoR30YFN+O+EqNkK/cv6ysMF72nHYrtH7SM/YRBdQQ==
X-Received: by 2002:adf:e54a:0:b0:356:4cd8:850d with SMTP id
 ffacd0b85a97d-35efed3f241mr1054321f8f.25.1717739871616; 
 Thu, 06 Jun 2024 22:57:51 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-176-192.web.vodafone.de.
 [109.43.176.192]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5e9b017sm3179364f8f.89.2024.06.06.22.57.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 22:57:51 -0700 (PDT)
Message-ID: <e421b171-ae66-4282-b204-f29847d6a80e@redhat.com>
Date: Fri, 7 Jun 2024 07:57:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] s390x: Enable and document boot device fallback on
 panic
To: Jared Rossi <jrossi@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: frankja@linux.ibm.com, nsg@linux.ibm.com
References: <20240529154311.734548-1-jrossi@linux.ibm.com>
 <20240529154311.734548-6-jrossi@linux.ibm.com>
 <53920fad-888c-441b-b301-ca177f04f0fa@redhat.com>
 <6407dc07-8f16-4765-9da4-fd2b0e4e94e9@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <6407dc07-8f16-4765-9da4-fd2b0e4e94e9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 05/06/2024 16.48, Jared Rossi wrote:
> 
>>> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
>>> index c977a52b50..de3d1f0d5a 100644
>>> --- a/pc-bios/s390-ccw/s390-ccw.h
>>> +++ b/pc-bios/s390-ccw/s390-ccw.h
>>> @@ -43,6 +43,7 @@ typedef unsigned long long u64;
>>>   #include "iplb.h"
>>>     /* start.s */
>>> +extern char _start[];
>>>   void disabled_wait(void) __attribute__ ((__noreturn__));
>>>   void consume_sclp_int(void);
>>>   void consume_io_int(void);
>>> @@ -88,6 +89,11 @@ __attribute__ ((__noreturn__))
>>>   static inline void panic(const char *string)
>>>   {
>>>       sclp_print(string);
>>> +    if (load_next_iplb()) {
>>> +        sclp_print("\nTrying next boot device...");
>>> +        jump_to_IPL_code((long)_start);
>>> +    }
>>> +
>>>       disabled_wait();
>>>   }
>>
>> Honestly, I am unsure whether this is a really cool idea or a very ugly 
>> hack ... but I think I tend towards the latter, sorry. Jumping back to the 
>> startup code might cause various problem, e.g. pre-initialized variables 
>> don't get their values reset, causing different behavior when the s390-ccw 
>> bios runs a function a second time this way. Thus this sounds very 
>> fragile. Could we please try to get things cleaned up correctly, so that 
>> functions return with error codes instead of panicking when we can 
>> continue with another boot device? Even if its more work right now, I 
>> think this will be much more maintainable in the future.
>>
>>  Thomas
>>
> 
> Thanks Thomas, I appreciate your insight.  Your hesitation is perfectly 
> understandable as well.  My initial design was like you suggest, where the 
> functions return instead of panic, but the issue I ran into is that netboot 
> uses a separate image, which we jump in to at the start of IPL from a 
> network device (see zipl_load() in pc-bios/s390-ccw/bootmap.c). I wasn't 
> able to come up with a simple way to return to the main BIOS code if a 
> netboot fails other than by jumping back.  So, it seems to me that netboot 
> kind of throws a monkeywrench into the basic idea of reworking the panics 
> into returns.
> 
> I'm open to suggestions on a better way to recover from a failed netboot, 
> and it's certainly possible I've overlooked something, but as far as I can 
> tell a jump is necessary in that particular case at least. Netboot could 
> perhaps be handled as a special case where the jump back is permitted 
> whereas other device types return, but I don't think that actually solves 
> the main issue.
> 
> What are your thoughts on this?

Yes, I agree that jumping is currently required to get back from the netboot 
code. So if you could rework your patches in a way that limits the jumping 
to a failed netboot, that would be acceptable, I think.

Apart from that: We originally decided to put the netboot code into a 
separate binary since the required roms/SLOF module might not always have 
been checked out (it needed to be done manually), so we were not able to 
compile it in all cases. But nowadays, this is handled in a much nicer way, 
the submodule is automatically checked out once you compile the 
s390x-softmmu target and have a s390x compiler available, so I wonder 
whether we should maybe do the next step and integrate the netboot code into 
the main s390-ccw.img now? Anybody got an opinion on this?

  Thomas


