Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CE9C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 06:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3893-00015A-W0; Fri, 11 Apr 2025 02:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u388m-00013A-7T
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 02:45:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u388k-00017m-A9
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 02:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744353920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JcsF23GGzQ0EayBTYA2oncrn4FLpmUqIc696jtJAqjg=;
 b=bozCj7nIERI2ctx717cmhiqvNawx/TPxY3k2N7jSBwhuoWW0Ay3HlvNXI0wNMcN2wOngd4
 52MON6d+T4FINYd5VOqxnP57C+5q2XFITQD+XBhohPibQHn1vpTrznngZLaf2pQmmEEJ8A
 kREvMk/IvxnjjGXZPruSeCJbD5CCIlQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-4Uu_JigKOSSS4RN-XxzuJA-1; Fri, 11 Apr 2025 02:45:17 -0400
X-MC-Unique: 4Uu_JigKOSSS4RN-XxzuJA-1
X-Mimecast-MFC-AGG-ID: 4Uu_JigKOSSS4RN-XxzuJA_1744353916
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5edc07c75efso1572612a12.1
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 23:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744353916; x=1744958716;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JcsF23GGzQ0EayBTYA2oncrn4FLpmUqIc696jtJAqjg=;
 b=WaA3Ci805JHBjLMbvezWoYWAvJKWnWIJdS4N/d+xANKjSxueZpGozyiAc1Uv9e0Vrv
 hAQvP8g6mNdzLe+i4Y8MO/0dptr3/c+MtzSgXi56J0PdvK+aKvAD3490RlBNK0kOnSFZ
 CFaqRUnkNvdKucUC7Cxgu6TUsakIZOyxHd3Psm0/wPGUR+GNOuAm/06mv6rWglXZCYwW
 P4m+18msJa70SYGYjCNfH1h9Is/ARgXiGyn3Cvkw14ni/hpZZ3IijWiQm4gELx0bMVVd
 U0Is6wniHryHGJhU6+nBXFSDoUJzOHp/Ay0AmnNpTNt266KYFJyp72j2OOafiAsR8s5y
 KsIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeNVHGpWq9pJU9GiAZYrQxvrjnhFkCDwwVb5JHqCNWRVtDIF3JKsqPnD1bW8EkVu6UsxUlGSFdwS4J@nongnu.org
X-Gm-Message-State: AOJu0YyCA2NiB7NPF3r+c2/BYWOu8hgUMz2ruGe8Tsd8zDIe8DzTw6N+
 8Bn2ncuvIUql+mjB8noytA8yVY4SLZByLjisETBXxcStShVPRPHfoaONwuKjALCvl4biCFBGI8w
 tjMvNdRUJnUxyZ4pt08eERYDXpchTGp2MZbLd7wcgWyWf9GGptPlC
X-Gm-Gg: ASbGncs8otekDUyS5qXmE0rmyXpL573MRM9p3eQci/6KXG4qyUY5sCHrvcCvtzrM/Vu
 BDLSpN7fIfXUWUgX/OUG0X4jbfjo0fFMqD3ynMOZGuv6aKcgYF8b9Ad8N4DH2NDSIx2D7kg1p91
 78kmD+cpI07YktQbyc6H0+D3s1SCSL9qzrCwT1/cYd66sjLX1D4z7btHj3Pf0Nddu5Pg3Lru1fD
 T9USMbL3Cy+MwFy3oqpjWj7u16oX+kL2gvCK1VMzIODj1qGx156Tp+8XAnFyo6EvxZvEBqRSf8t
 aMfcWBkJGRodKXswImrJ9wynynK8lsz4bly9tr+L2Q8=
X-Received: by 2002:a05:6402:210f:b0:5eb:ca97:7c60 with SMTP id
 4fb4d7f45d1cf-5f36f52b966mr1007987a12.6.1744353916372; 
 Thu, 10 Apr 2025 23:45:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAchyXek3Jxq/pJ3441+eO4ilLtc7bQoHjjHlQWkuJmLzZEIqiCqaD4NEx8A9uo+ec1U8neg==
X-Received: by 2002:a05:6402:210f:b0:5eb:ca97:7c60 with SMTP id
 4fb4d7f45d1cf-5f36f52b966mr1007963a12.6.1744353915925; 
 Thu, 10 Apr 2025 23:45:15 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-221.web.vodafone.de.
 [109.42.49.221]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f36f527ee8sm527108a12.73.2025.04.10.23.45.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 23:45:15 -0700 (PDT)
Message-ID: <ce83485a-7575-49df-a3eb-7feac3cfd675@redhat.com>
Date: Fri, 11 Apr 2025 08:45:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 5/5] s390: implementing CHSC SEI for AP config
 change
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, akrowiak@linux.ibm.com
References: <20250311151616.98244-1-rreyes@linux.ibm.com>
 <20250311151616.98244-6-rreyes@linux.ibm.com>
 <f2168937-5252-4e91-80d6-2ad344f443fa@redhat.com>
 <ed45e437-5534-4ace-8a7e-196860b43cde@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ed45e437-5534-4ace-8a7e-196860b43cde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/04/2025 22.31, Rorie Reyes wrote:
> 
> On 3/17/25 9:41 AM, Thomas Huth wrote:
>> On 11/03/2025 16.16, Rorie Reyes wrote:
>>> Handle interception of the CHSC SEI instruction for requests
>>> indicating the guest's AP configuration has changed.
>>>
>>> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
>>> Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>>> Tested-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>>> ---
>>>   target/s390x/ioinst.c | 11 +++++++++--
>>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
>>> index a944f16c25..f061c6db14 100644
>>> --- a/target/s390x/ioinst.c
>>> +++ b/target/s390x/ioinst.c
>>> @@ -17,6 +17,7 @@
>>>   #include "trace.h"
>>>   #include "hw/s390x/s390-pci-bus.h"
>>>   #include "target/s390x/kvm/pv.h"
>>> +#include "hw/s390x/ap-bridge.h"
>>>     /* All I/O instructions but chsc use the s format */
>>>   static uint64_t get_address_from_regs(CPUS390XState *env, uint32_t ipb,
>>> @@ -573,13 +574,19 @@ out:
>>>     static int chsc_sei_nt0_get_event(void *res)
>>>   {
>>> -    /* no events yet */
>>> +    if (s390_has_feat(S390_FEAT_AP)) {
>>> +        return ap_chsc_sei_nt0_get_event(res);
>>> +    }
>>> +
>>>       return 1;
>>>   }
>>>     static int chsc_sei_nt0_have_event(void)
>>>   {
>>> -    /* no events yet */
>>> +    if (s390_has_feat(S390_FEAT_AP)) {
>>> +        return ap_chsc_sei_nt0_have_event();
>>> +    }
>>> +
>>>       return 0;
>>>   }
>>
>>  Hi!
>>
>> This unfortunately fails to link when configuring QEMU with the "-- 
>> without-default-devices" configure switch:
>>
>> /usr/bin/ld: libqemu-s390x-softmmu.a.p/target_s390x_ioinst.c.o: in 
>> function `ioinst_handle_chsc':
>> /tmp/qemu-mini/target/s390x/ioinst.c:587:(.text+0x1ce1): undefined 
>> reference to `ap_chsc_sei_nt0_have_event'
>> /usr/bin/ld: /tmp/qemu-mini/target/s390x/ioinst.c:578:(.text+0x1d1c): 
>> undefined reference to `ap_chsc_sei_nt0_get_event'
>> collect2: error: ld returned 1 exit status
>>
>> I guess you have to rather use some callback mechanism, stubs or #ifdefs 
>> here instead.
>>
>>  Thomas
>>
> Hey Thomas,
> 
> Sorry for the delay. I was trying out some ways to resolve this issue but 
> I'm not sure what I would use for the macro name if I were to
> 
> go the #ifdef route. I had something roughly like this but it wasn't 
> working. Would you have any recommendations?
> 
> static int chsc_sei_nt0_get_event(void *res) { #ifdef HW_S390X_AP_BRIDGE_H 
> if (s390_has_feat(S390_FEAT_AP)) { return ap_chsc_sei_nt0_get_event(res); } 
> #endif return 1; } static int chsc_sei_nt0_have_event(void) { #ifdef 
> HW_S390X_AP_BRIDGE_H if (s390_has_feat(S390_FEAT_AP)) { return 
> ap_chsc_sei_nt0_have_event(); } #endif return 0; }

  Hi,

right, that's the wrong #ifdef that you were trying here.
The problematic function is defined in hw/vfio/ap.c, so have a look into 
hw/vfio/meson.build, and you'll see that it's conditionally included via the 
CONFIG_VFIO_AP switch, so that's what you want here, I think. To be able to 
use it, you likely have to add a:

#include CONFIG_DEVICES

at the beginning of the ioinst.c file. Then you should be able to do:

#ifdef CONFIG_VFIO_AP
     if (s390_has_feat(S390_FEAT_AP)) {
        return ap_chsc_sei_nt0_get_event(res);
     }
#endif

(or whatever the code should look like).

Alternatively, and this might even be the nicer variant, add a file 
hw/vfio/ap-stub.c and include a dummy ap_chsc_sei_nt0_get_event() function 
there. Then in hw/vfio/meson.build add this line:

vfio_ss.add(when: 'CONFIG_VFIO_AP', if_false: files('ap-stub.c'))


  HTH,
   Thomas


