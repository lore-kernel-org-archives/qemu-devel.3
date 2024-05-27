Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41A3C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 05:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBTGe-0003Qj-F3; Mon, 27 May 2024 01:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sBTGU-0003MX-Av
 for qemu-devel@nongnu.org; Mon, 27 May 2024 01:51:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sBTGS-0006op-MT
 for qemu-devel@nongnu.org; Mon, 27 May 2024 01:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716789080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XZVsMxU1q8ns2+uk2Z4IlSl2LbqRSgvNAXqv3cPqTpI=;
 b=LqWhUBUtmptscAXAcclPzx1oL6V0mj45ja+we94TZqhdYh7GDtDiBCr1dKwdYkdP9JeA68
 zYfAJBj4JQQJ1TNmihmUPJX0hKifLm7SYR7+yiZtntmoOwSp8cw/bm3s+UrobgGxf0w5ja
 U5zVh+1c5gbIK0EvWTvS5a23COIHbxA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-ZCm8Q4J3M6OOh5BdtAbR4Q-1; Mon, 27 May 2024 01:51:18 -0400
X-MC-Unique: ZCm8Q4J3M6OOh5BdtAbR4Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4211239ed3eso2309025e9.1
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 22:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716789077; x=1717393877;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XZVsMxU1q8ns2+uk2Z4IlSl2LbqRSgvNAXqv3cPqTpI=;
 b=EhV2BXPEdOBIffq1Ng52bhxVNpd7clprfN0bVMOyjKlLLVSqdcfpYxbJPzbJ4rl8/R
 eHKgzE4JumAl7C8kh1e97yDgZUsGVQEi2hOf/ngYBisxzZpw7Ar0Le4o9JGirhhT7fKq
 tsRhZJiPFmG6sv0vueDwYfxqdBPgzITsATSlDFpDAvDE0BgB+Qq5MofFGoq5It+kPtlU
 p1ar7P7MB7Sjwb2ABFuA5GTZnLRZ+5CI6fsGuuO0QQ8g8WEyGhIbsOQPLHPalwJxh1DO
 47QYLuuI+wN+VkXHLvrCH3KlKKut0dN/yoKcuYV2RVtD+iOgVF8UPrgXAvq6YmT6msor
 VfkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGGjY/wFSLSpBiRcMcMNzjRAJyNvJ8g8a2nvT08UMNhbKAFb7H9FdWrUSvFvy85JOyk7qCr8VJfLfLTC0/L4ewrzo52/8=
X-Gm-Message-State: AOJu0YxwHF8P2m/DfKRUaDTu2pPoaXkQupLZ9a4Wy1fi0VjnSGlTKisc
 c3NEifI2c1qUbw1x6yZ/oz6xSoc6rHC9jq022i0Le0Y8XG7IsG5jomceiForj/lswkJirxrvmj8
 OI+IKRhrZ0heh76GtDtICX5LmU+F4e/e/W591kBS8W4WSxHwRsRQx
X-Received: by 2002:a05:6000:1a44:b0:354:fbc2:5cf6 with SMTP id
 ffacd0b85a97d-35526c5a119mr5689194f8f.30.1716789077216; 
 Sun, 26 May 2024 22:51:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwyv1E8vS0rL1PPafnkk6JQ2HM5I6hUo5AMaE+xx1YP+AEaxZOkm+QT3duCr0ft4SiH02I0g==
X-Received: by 2002:a05:6000:1a44:b0:354:fbc2:5cf6 with SMTP id
 ffacd0b85a97d-35526c5a119mr5689176f8f.30.1716789076810; 
 Sun, 26 May 2024 22:51:16 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-179-90.web.vodafone.de.
 [109.43.179.90]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100f15f66sm127576575e9.14.2024.05.26.22.51.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 May 2024 22:51:16 -0700 (PDT)
Message-ID: <88f79ea3-8b83-45c2-bd15-cdf16ffeac9a@redhat.com>
Date: Mon, 27 May 2024 07:51:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] hw/intc/s390_flic: Migrate pending state
To: David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-s390x@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
References: <20240525131241.378473-1-npiggin@gmail.com>
 <20240525131241.378473-2-npiggin@gmail.com>
 <3bf1025b-021a-42fa-a4cc-d3cd9ea90676@redhat.com>
 <10e876de-b973-4016-9155-960383d46297@linaro.org>
 <22e05fc7-6256-41b3-9f0d-f983f169b08c@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <22e05fc7-6256-41b3-9f0d-f983f169b08c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 26/05/2024 22.33, David Hildenbrand wrote:
> Am 26.05.24 um 21:44 schrieb Richard Henderson:
>> On 5/26/24 08:53, David Hildenbrand wrote:
>>> Am 25.05.24 um 15:12 schrieb Nicholas Piggin:
>>>> The flic pending state is not migrated, so if the machine is migrated
>>>> while an interrupt is pending, it can be lost. This shows up in
>>>> qtest migration test, an extint is pending (due to console writes?)
>>>> and the CPU waits via s390_cpu_set_psw and expects the interrupt to
>>>> wake it. However when the flic pending state is lost, s390_cpu_has_int
>>>> returns false, so s390_cpu_exec_interrupt falls through to halting
>>>> again.
>>>>
>>>> Fix this by migrating pending. This prevents the qtest from hanging.
>>>> Does service_param need to be migrated? Or the IO lists?
>>>>
>>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>>> ---
>>>>   hw/intc/s390_flic.c | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
>>>> index 6771645699..b70cf2295a 100644
>>>> --- a/hw/intc/s390_flic.c
>>>> +++ b/hw/intc/s390_flic.c
>>>> @@ -369,6 +369,7 @@ static const VMStateDescription 
>>>> qemu_s390_flic_vmstate = {
>>>>       .fields = (const VMStateField[]) {
>>>>           VMSTATE_UINT8(simm, QEMUS390FLICState),
>>>>           VMSTATE_UINT8(nimm, QEMUS390FLICState),
>>>> +        VMSTATE_UINT32(pending, QEMUS390FLICState),
>>>>           VMSTATE_END_OF_LIST()
>>>>       }
>>>>   };
>>>
>>> Likely you have to handle this using QEMU compat machines.
>>
>> Well, since existing migration is broken, I don't think you have to preserve 
> 
> Migration is broken only in some case "while an interrupt is pending, it can 
> be lost".
> 
>> compatibility.  But you do have to bump the version number.
> 
> Looking at it, this is TCG only, so likely we don't care that much about 
> migration compatibility. But I have no idea what level of compatibility we 
> want to support there.

Yes, this seems to only affect the TCG-only flic device, where migration has 
never been working very reliably. So I think we don't really need the whole 
compat-machine dance here. But I think we should at least bump the 
version_id to 2 now and then use

    VMSTATE_UINT32_V(pending, QEMUS390FLICState, 2);

for the new field. That way we would at least support forward migrations 
without too much hassle.

  Thomas


