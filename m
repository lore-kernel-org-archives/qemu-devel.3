Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A605AC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqCd6-0008QS-Bf; Thu, 06 Mar 2025 09:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqCd2-0008P2-Oy
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:55:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqCd0-0007E4-SN
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:55:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741272913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nE415PglqTpm4EEoyIowo0LZB7SdKFVVN6CKpNyo16U=;
 b=RSgYZbDYQyGZ9pnfuH+0K6g051uO0W9mbegm2oM5NQ6SJn8Eb6lPnql6Zn9+5c9I3751lS
 69KHe1H1mLs7GUKWB6J/U3nCQkx3l05I0y3NstZlAuXAJ+0a52fkn+ZOr0vL3NdtLrxvfF
 m3y+vq9pKFilfMIFVcxfM4/jNVNSeRo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-RUVMvFfZNGehbRfaQlqOqA-1; Thu, 06 Mar 2025 09:55:07 -0500
X-MC-Unique: RUVMvFfZNGehbRfaQlqOqA-1
X-Mimecast-MFC-AGG-ID: RUVMvFfZNGehbRfaQlqOqA_1741272906
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-390f6aa50c5so467212f8f.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 06:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741272906; x=1741877706;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nE415PglqTpm4EEoyIowo0LZB7SdKFVVN6CKpNyo16U=;
 b=G2VuzP68JPf+ixSAypga3aaEsKyj8RSV5m1NwwhjtmR7LZ77sZRtJZD72z9Svp50Q3
 LwY0msRVAHsnH6SS644wxOBApXPluanagQ/cKWI2H414UQ8oVuLujMeVoorN+3ep61Ae
 +wQ8jCwaDA0hajz/gaToWyP7P0KwuYUMmP2R3/wYBw5N+Qmbu7sVyomRv9ttkbnuO/U7
 pDhgAUO43Jjxsn8uMupR0Si3FJ2zGfPYOHtoBu/lVln1X6uALI1S2xu3UkXpitsf506+
 gm5jYAm0sDCt6QeZr4tgff72pMwj58Ie0opFUf+w12A0QbCuKSWZNS/v/Rn7UxB6ldMZ
 A11A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW79980aTYnL+psiymMHhfQMJEO30GPOiplqAKYHPiu3X02LglGp+CVZpiK1zZ/VB+pQNd4wzvWb5X@nongnu.org
X-Gm-Message-State: AOJu0YyRTEwQTDVaxeQHMzUh7j1I+yMd0M3lxtKn8Sxe5OaAwputEM0J
 4Da9xtygugLJ7VasH6Fvx1VavsJMPw6dTeC1up+P6Qxi/zZZ7eVZPUlX+kM+vpkYXa3q3pXY168
 TYFM3pkr3McKPQKOUvkz44e11p9n+Pkp5YRKuQabUYDSonYUXkIRLTnKql4RP
X-Gm-Gg: ASbGncs0H8MzHaub4xESkIQo+KF6vLnOBJ8DtYruRrr5fjESAr5SQSL1A906+8iPoQ5
 AGbARCGAvSn0QpkF8OPaD2cV/zSF9OKLJMlHSVb5LRfGJKk0OkWc/9JjoITXSv7dVU19b3cQePf
 ltb/ZrX+KBQnmzkEs9TbE2qWMOhuQNCKtfL5o178GJEKvfdUWK40DynyDEp7M6/WCmqhGPIIJlD
 kYDI5emrhDMfV1CgJHruXNTBG2WmUmNn/lQ855S0e1Is6c/oGoIAv4EmoEIlrpWWVbwleepvmLK
 9Gza4c5fOF1wf0TBgWKtI/kcwtUekpMFtR1pemc3g8cbeJk=
X-Received: by 2002:a05:6000:2cd:b0:391:13d6:c9f0 with SMTP id
 ffacd0b85a97d-3911f7bd651mr6769673f8f.47.1741272905887; 
 Thu, 06 Mar 2025 06:55:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMCeNZoaaALMe0kGvtA0HEWTtPKAqLCrrIgJNUVaTa8ZhLf/fecXIPCQu9mnS4QZMwRvaq3g==
X-Received: by 2002:a05:6000:2cd:b0:391:13d6:c9f0 with SMTP id
 ffacd0b85a97d-3911f7bd651mr6769643f8f.47.1741272905488; 
 Thu, 06 Mar 2025 06:55:05 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c103035sm2247510f8f.88.2025.03.06.06.55.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 06:55:05 -0800 (PST)
Message-ID: <f64b5ce4-8843-4d92-af97-24160f687698@redhat.com>
Date: Thu, 6 Mar 2025 15:55:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu v2 1/3] hw/s390x: add CPI identifiers to QOM
To: shalini <shalini@imap.linux.ibm.com>
Cc: Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
References: <20250224120449.1764114-1-shalini@linux.ibm.com>
 <48caabe7-c112-4454-96a8-742d154c77ee@redhat.com>
 <78b6c548212517ef8620fce0c6832e4f@imap.linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <78b6c548212517ef8620fce0c6832e4f@imap.linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 06/03/2025 13.23, shalini wrote:
> On 2025-03-05 16:56, Thomas Huth wrote:
>> On 24/02/2025 13.04, Shalini Chellathurai Saroja wrote:
>>> Add Control-Program Identification (CPI) to the QEMU Object
>>> Model (QOM). The CPI identifiers provide information about
>>> the guest operating system. The CPI identifiers are:
>>> system type, system name, system level and sysplex name.
>>>
>>> The system type provides the OS type of the guest (e.g. LINUX).
>>> The system name provides the name of the guest (e.g. TESTVM).
>>> The system level provides the distribution and kernel version
>>> of the guest OS (e.g. 0x50e00).
>>> The sysplex name provides the sysplex name of the guest
>>> (e.g. SYSPLEX).
>>>
>>> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>>> ---
>>>   hw/s390x/s390-virtio-ccw.c         | 29 +++++++++++++++++++++++++++++
>>>   include/hw/s390x/s390-virtio-ccw.h |  8 ++++++++
>>>   qapi/machine.json                  | 24 ++++++++++++++++++++++++
>>>   3 files changed, 61 insertions(+)
>>>
>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>> index 51ae0c133d..13ea8db1b0 100644
>>> --- a/hw/s390x/s390-virtio-ccw.c
>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>> @@ -50,6 +50,7 @@
>>>   #include "hw/s390x/virtio-ccw-md.h"
>>>   #include "system/replay.h"
>>>   #include CONFIG_DEVICES
>>> +#include "qapi/qapi-visit-machine.h"
>>>     static Error *pv_mig_blocker;
>>>   @@ -803,6 +804,26 @@ static void machine_set_loadparm(Object *obj, 
>>> Visitor *v,
>>>       s390_ipl_fmt_loadparm(ms->loadparm, val, errp);
>>>   }
>>>   +static void machine_get_control_program_id(Object *obj, Visitor *v,
>>> +                                           const char *name, void *opaque,
>>> +                                           Error **errp)
>>> +{
>>> +    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
>>> +    S390ControlProgramId *cpi;
>>> +    cpi = &(S390ControlProgramId){
>>> +        .system_type = g_strndup((char *) ms->cpi.system_type,
>>> +                       sizeof(ms->cpi.system_type)),
>>> +        .system_name = g_strndup((char *) ms->cpi.system_name,
>>> +                       sizeof(ms->cpi.system_name)),
>>> +        .system_level = g_strdup_printf("0x%lx", ms->cpi.system_level),
>>> +        .sysplex_name = g_strndup((char *) ms->cpi.sysplex_name,
>>> +                        sizeof(ms->cpi.sysplex_name)),
>>> +        .timestamp = ms->cpi.timestamp
>>> +    };
>>
>> Could you please indend the sizeof() lines with the "(" after the
>> g_strndup in the previous line?
>>
> 
> Hello Thomas,
> 
> Sure, I have provided a sample code below, please let me know if this is 
> incorrect. Thank you.
> 
>>> +    cpi = &(S390ControlProgramId){
>>> +        .system_type = g_strndup((char *) ms->cpi.system_type,
>>> +                                 sizeof(ms->cpi.system_type)),

That indentation looks fine, thanks!

...
>>> +##
>>> +{ 'struct': 'S390ControlProgramId', 'data': {
>>> +     'system-type': 'str',
>>> +     'system-name': 'str',
>>> +     'system-level': 'str',
>>
>> Not sure, but would it make sense to use a number for the system-level
>> instead? At least it's a number in ControlProgramId, not a string.
>>
> 
> The system-level, when interpreted as an int provides the output below
> 
> 'system-level': 74872343805430528
> 
> But the desired output below is obtained only when interpreted as a str. 
> please refer https://www.ibm.com/docs/en/linux-on-systems? 
> topic=identification-system-level for details on system-level. I will also 
> document this in the description of system-level as suggested by Daniel. 
> Thank you.
> 
> 'system-level': '0x10a000000060b00'

Well, the idea of QOM/QAPI is: It's an *API* for machines, not meant for 
direct consumption by the end user. So passing an integer as a string is not 
the right way here. For the user, you'd require some upper level instead 
that renders the integer in the right shape for the user. So please don't 
use a string for this at the QOM/QAPI level.

  Thanks,
   Thomas


