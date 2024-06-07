Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A70DC27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 06:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFSpU-0002Ys-8m; Fri, 07 Jun 2024 02:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sFSpS-0002YD-Do
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 02:11:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sFSpQ-0005j4-12
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 02:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717740713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pX5wxqfuVRjKvrHWJ8B8wKnTAC1T4pQ08KdqL5ryOK0=;
 b=SH4WyocRbh7xI/bffKRkMCq+63N3R8FNHY5eEDrvWrVIccQ8MMZGVnLUFmbonDiKn/WyjY
 QlKdxQc4BcOsFrXTY9GHpyechX4RwWj686UZ2y8nNub8Upt2rFDXasvpW8gLQgrVmQ5seC
 508tBIgJtBAia7rJpbGpISoz4iRY+OA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-jYCgbycLMOy2tWGYZXeOrA-1; Fri, 07 Jun 2024 02:11:49 -0400
X-MC-Unique: jYCgbycLMOy2tWGYZXeOrA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4210d151c5bso14443165e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 23:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717740708; x=1718345508;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pX5wxqfuVRjKvrHWJ8B8wKnTAC1T4pQ08KdqL5ryOK0=;
 b=USbY8PPTOtut+w4TVF79lJnAiHuOZ1DUGVEGvEYu3CSMMv3ToimVr6x8mp4mPlq1U/
 OQGW2mRX80OgKdI1sPH1YYnMSRFOduNxXIZRwJWWLfv1+8GF0ER38vTO3mRUsRJugUOh
 DF1iqqsXFgYjezsgg1eMyXuxGXJa8ozjueYyWXWw/UYiYntGIl0YIFbSzpvGhZjN8IcM
 mMNetMx3XJqLMei9h+Rj33ORfEBidEn1jE4P4MrqfWfYZuttkf/q+gqXMaFpo4dE5+D9
 otFT8ZjgV25zWQGOPD1vf/OycGnVzcP2q+fRMnk6fZbWT0srLOn/UdNsGNjaiKrfMcZ6
 IWlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0HB74Y2jMp5v5zSQ8fJffcoR131v5y/FsvW9zHtJxSHQL1LO0vZbDKmstVrdASGqNmFj8gQY27x0e6XJnwJnnF+iODQU=
X-Gm-Message-State: AOJu0Yw5o7akEfQFJ2gMXIHL1Gsw5egWX46r0JJftsKFaGbqepz5Bd5g
 a8gtBhGOZWuH55iA/zlrPq7xN9xS8+f9vBge5ITCh4EotlKUbctEC8AV1dTkaNQ/Qx4uuY95itG
 t49MHLWGqOu3b5726OvIAlDs5As/Q/7Gd6PQWUN57KCHK5+pZC09W
X-Received: by 2002:a05:600c:4588:b0:41b:cb18:e24b with SMTP id
 5b1f17b1804b1-421649f0fe9mr12505395e9.9.1717740708118; 
 Thu, 06 Jun 2024 23:11:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBR0HguqPevnASbK+adr5Gp6jnxfuy5MDPU8lhxxAoH+gibh3BrKXq9mm6wq1v8/6ZB36+yA==
X-Received: by 2002:a05:600c:4588:b0:41b:cb18:e24b with SMTP id
 5b1f17b1804b1-421649f0fe9mr12505195e9.9.1717740707700; 
 Thu, 06 Jun 2024 23:11:47 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-176-192.web.vodafone.de.
 [109.43.176.192]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42158102a69sm77171875e9.15.2024.06.06.23.11.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 23:11:47 -0700 (PDT)
Message-ID: <53c86686-23a4-44ab-9433-fa6c5a0ed66e@redhat.com>
Date: Fri, 7 Jun 2024 08:11:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] s390x: Build IPLB chain for multiple boot devices
To: Jared Rossi <jrossi@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com, nsg@linux.ibm.com
References: <20240529154311.734548-1-jrossi@linux.ibm.com>
 <20240529154311.734548-4-jrossi@linux.ibm.com>
 <722f7af6-a5f0-4528-a327-a897255f7ea8@redhat.com>
 <0f90fc59-7c49-4ceb-a97a-2f5f07230f09@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <0f90fc59-7c49-4ceb-a97a-2f5f07230f09@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 05/06/2024 22.01, Jared Rossi wrote:
> 
> On 6/4/24 2:26 PM, Thomas Huth wrote:
>> On 29/05/2024 17.43, jrossi@linux.ibm.com wrote:
>>> From: Jared Rossi <jrossi@linux.ibm.com>
>>>
>>> Write a chain of IPLBs into memory for future use.
>>>
>>> The IPLB chain is placed immediately before the BIOS in memory at the 
>>> highest
>>> unused page boundary providing sufficient space to fit the chain. Because 
>>> this
>>> is not a fixed address, the location of the next IPLB and number of 
>>> remaining
>>> boot devices is stored in the QIPL global variable for later access.
>>>
>>> At this stage the IPLB chain is not accessed by the guest during IPL.
>>>
>>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>>> ---
>>>   hw/s390x/ipl.h              |   1 +
>>>   include/hw/s390x/ipl/qipl.h |   4 +-
>>>   hw/s390x/ipl.c              | 129 +++++++++++++++++++++++++++---------
>>>   3 files changed, 103 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
>>> index 1dcb8984bb..4f098d3a81 100644
>>> --- a/hw/s390x/ipl.h
>>> +++ b/hw/s390x/ipl.h
>>> @@ -20,6 +20,7 @@
>>>   #include "qom/object.h"
>>>     #define DIAG308_FLAGS_LP_VALID 0x80
>>> +#define MAX_IPLB_CHAIN 7
>>>     void s390_ipl_set_loadparm(char *ascii_lp, uint8_t *ebcdic_lp);
>>>   void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp);
>>> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
>>> index a6ce6ddfe3..481c459a53 100644
>>> --- a/include/hw/s390x/ipl/qipl.h
>>> +++ b/include/hw/s390x/ipl/qipl.h
>>> @@ -34,7 +34,9 @@ struct QemuIplParameters {
>>>       uint8_t  reserved1[3];
>>>       uint64_t netboot_start_addr;
>>>       uint32_t boot_menu_timeout;
>>> -    uint8_t  reserved2[12];
>>> +    uint8_t  reserved2[2];
>>> +    uint16_t num_iplbs;
>>> +    uint64_t next_iplb;
>>>   }  QEMU_PACKED;
>>>   typedef struct QemuIplParameters QemuIplParameters;
>>>   diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>>> index 2d4f5152b3..79429acabd 100644
>>> --- a/hw/s390x/ipl.c
>>> +++ b/hw/s390x/ipl.c
>>> @@ -55,6 +55,13 @@ static bool iplb_extended_needed(void *opaque)
>>>       return ipl->iplbext_migration;
>>>   }
>>>   +/* Start IPLB chain from the boundary of the first unused page before 
>>> BIOS */
>>
>> I'd maybe say "upper boundary" to make it clear that this is at the end of 
>> the page, not at the beginning?
> 
> The chain does start at the beginning of a page.  That being said, the 
> comment still needs to be reworded, I'm just not sure exactly how. "Start 
> the IPLB chain from the nearest page boundary providing sufficient space 
> before BIOS?"  Basically because each IPLB is 4K, the chain will occupy the 
> N unused pages before the start of BIOS, where N is the number of chained 
> IPLBS (assuming 4K pages).

Ah, right, I missed that sizeof(IplParameterBlock) == 4096 (I guess I was 
looking at the old version in pc-bios/s390-ccw/iplb.h that does not seem to 
have the padding), sorry for the confusion! It's really good that you now 
unify the headers in your first patch!

  Thomas


