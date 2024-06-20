Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE105C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 08:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKCwM-0008TU-VT; Thu, 20 Jun 2024 04:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sKCwK-0008TC-LY
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 04:14:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sKCwJ-0002wp-11
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 04:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718871278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ePv7F0LiouCnGAPE312nmTkhUHdw+26oBsgLYv47X+s=;
 b=fndP/83pgaiFlPA4mSqyD9Udi952oc4PPTuKlL55d/kFTA1AZHssvCLdMsgalt5WaVbYTa
 qYpv+59rki8zdgGCmUlNmeQIF4t/lI/l/3r76mEP1wfXXmIJHoCr2r5RlO1/hq23qllrqI
 mAE+TBSMSnRTHz8r7Gm4vSWHDepgRwE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-6qvSWkYTPGWdDBk6yHuB6Q-1; Thu, 20 Jun 2024 04:14:35 -0400
X-MC-Unique: 6qvSWkYTPGWdDBk6yHuB6Q-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6b077edfd2fso8757536d6.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 01:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718871275; x=1719476075;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ePv7F0LiouCnGAPE312nmTkhUHdw+26oBsgLYv47X+s=;
 b=u5rMIymXzA7A4bpx2hMVyqTDc/QUI31PDXcc5p+YF3UNRI1TZycNAIjVb2q1fFKMk9
 urViLQeerzTEHQ7hYyfsHj3kpR90p0ogihx2Vh6AK2+JGQsRiVvsxdkuWgnkdO2UslU6
 cfQG++ByOMoKlw1qF4cIhLZXC/PK92/5d9gPpxfGqiWD7xeyiCV1kcys+tzIF1l9fAdb
 XS1t37D/aCSP6Nj7O04d91UXOcxENDahR6eFNMe/e1e/nlJLEJV2HCyjZe71eLMN/Arl
 81wf3WC0cSbnItAzkg/mcITUhYWp0avzbAK7Ro50+uQQHGnkRH9FUda/KScIgNz/zch2
 TJdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKn1OJo1c3z3bYmhhTXVsZDRd87His8C4zg9o+epMiWQ0El4G/6yL8S56Xsj/d/XpIFt+7zEr4GWmgcXgJhbcrT/EGpfk=
X-Gm-Message-State: AOJu0Yx2buoKDOAoTDSHRvrmXsgsKbr4sDl+LF6aPefHKHKJ3t5lSVjz
 L6l+qJJoRiMKmSRVgXyfIP+6SOk5wBqkYpum3GfAHjY9v6iuNl7DS8BtZjCZb9irJe+NtN26ayp
 0kRVn5k89hmYke3ihLFp2gJMCroxU1q10HcYnxDkWPYBxxdin/6iZAX1xiK+8
X-Received: by 2002:a05:6214:caa:b0:6b2:bad8:b72b with SMTP id
 6a1803df08f44-6b501e3939fmr67240156d6.28.1718871275125; 
 Thu, 20 Jun 2024 01:14:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWNdqQ1brqRwbMnsvNDlQ1vlUmVgir2dV623JnlN7CtRzzsl3OKm3TC6Mk5b+DuLkS6iE8Ag==
X-Received: by 2002:a05:6214:caa:b0:6b2:bad8:b72b with SMTP id
 6a1803df08f44-6b501e3939fmr67239966d6.28.1718871274744; 
 Thu, 20 Jun 2024 01:14:34 -0700 (PDT)
Received: from [10.33.192.191] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b2a5ef9881sm85457576d6.130.2024.06.20.01.14.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 01:14:34 -0700 (PDT)
Message-ID: <cf64bc37-736b-4a55-85b4-1bd77215b13a@redhat.com>
Date: Thu, 20 Jun 2024 10:14:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] s390x: Enable and document boot device fallback on
 panic
To: Christian Borntraeger <borntraeger@linux.ibm.com>, jrossi@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com, nsg@linux.ibm.com
References: <20240529154311.734548-1-jrossi@linux.ibm.com>
 <20240529154311.734548-6-jrossi@linux.ibm.com>
 <53920fad-888c-441b-b301-ca177f04f0fa@redhat.com>
 <e742d10b-d37a-4611-a554-235ebd3e57c1@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <e742d10b-d37a-4611-a554-235ebd3e57c1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17/06/2024 16.49, Christian Borntraeger wrote:
> 
> 
> Am 05.06.24 um 15:37 schrieb Thomas Huth:
>> On 29/05/2024 17.43, jrossi@linux.ibm.com wrote:
>>> From: Jared Rossi <jrossi@linux.ibm.com>
>>>
>>> On a panic during IPL (i.e. a device failed to boot) check for another 
>>> device
>>> to boot from, as indicated by the presence of an unused IPLB.
>>>
>>> If an IPLB is successfully loaded, then jump to the start of BIOS, 
>>> restarting
>>> IPL using the updated IPLB.  Otherwise enter disabled wait.
>>>
>>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>>> ---
>>>   docs/system/bootindex.rst         | 7 ++++---
>>>   docs/system/s390x/bootdevices.rst | 9 ++++++---
>>>   pc-bios/s390-ccw/s390-ccw.h       | 6 ++++++
>>>   3 files changed, 16 insertions(+), 6 deletions(-)
>>
>> Could you please split the documentation changes into a separate patch in 
>> v2 ? ... I think that would be cleaner.
>>
>>> diff --git a/docs/system/bootindex.rst b/docs/system/bootindex.rst
>>> index 8b057f812f..de597561bd 100644
>>> --- a/docs/system/bootindex.rst
>>> +++ b/docs/system/bootindex.rst
>>> @@ -50,9 +50,10 @@ Limitations
>>>   Some firmware has limitations on which devices can be considered for
>>>   booting.  For instance, the PC BIOS boot specification allows only one
>>> -disk to be bootable.  If boot from disk fails for some reason, the BIOS
>>> -won't retry booting from other disk.  It can still try to boot from
>>> -floppy or net, though.
>>> +disk to be bootable, except for on s390x machines. If boot from disk 
>>> fails for
>>> +some reason, the BIOS won't retry booting from other disk.  It can still 
>>> try to
>>> +boot from floppy or net, though.  In the case of s390x, the BIOS will 
>>> try up to
>>> +8 total devices, any number of which may be disks.
>>
>> Since the old text was already talking about "PC BIOS", I'd rather leave 
>> that paragraph as it is (maybe just replace "PC BIOS" with "x86 PC BIOS"), 
>> and add a separate paragraph afterwards about s390x instead.
>>
>>> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
>>> index c977a52b50..de3d1f0d5a 100644
>>> --- a/pc-bios/s390-ccw/s390-ccw.h
>>> +++ b/pc-bios/s390-ccw/s390-ccw.h
>>> @@ -43,6 +43,7 @@ typedef unsigned long long u64;
>>>   #include "iplb.h"
>>>   /* start.s */
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
>> bios runs a function a second time this way. 
> 
> We jump back to _start and to me it looks like that this code does the 
> resetting of bss segment.
> So anything that has a zero value this should be fine. But static variables 
> != 0 are indeed tricky.
> As far as I can see we do have some of those :-(
> 
> So instead of jumping, is there a way that remember somewhere at which 
> device we are and then trigger a re-ipl to reload the BIOS?

If there is an easy way, this could maybe an option, but in the long run, 
I'd really prefer if we'd merge the binaries and get rid of such tricks, 
since this makes the code flow quite hard to understand and maybe also more 
difficult to debug if you run into problems later.

  Thomas


