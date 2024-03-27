Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30FBC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 08:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpOHi-0007N3-Cc; Wed, 27 Mar 2024 04:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rpOHg-0007MD-Cr
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 04:05:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rpOHe-0002CM-AY
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 04:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711526715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=y6liTsfG4a088AbdPZ6KIVRvsd4uq4WHCniUZlXxmSg=;
 b=G4bLBTU5d/1nUL6iDcOtzgU0S7O1kfAXKy4VU2jiA0i8YFCLt2IVKDzhBMUjAji+k2BuEa
 kJq2ICJDcUNTQELTKLh1CHJ1D0bR2Bns9fW21RsKJE7AOJEwZk5zMlpyODlwi68rffnIHQ
 GeSxpNo+g/vZLyJRnCS6F/x20QffMn8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-ZqKmkkXxN0GSd9ty3gL8AA-1; Wed, 27 Mar 2024 04:05:13 -0400
X-MC-Unique: ZqKmkkXxN0GSd9ty3gL8AA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-568a088c211so4118307a12.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 01:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711526712; x=1712131512;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y6liTsfG4a088AbdPZ6KIVRvsd4uq4WHCniUZlXxmSg=;
 b=DvfSAGTKW5zoV3ztB1Ty78X+AC8zapGoSWaGy1YOPC35PZSf0Y8/dFox/PoaFDhZYU
 LG/NHITZTFNpMbEv1Rlw02ify3G91e7hPgT1sKuDf/mXbNGE+1QkiGcXHo1EZKjJP37A
 sfOoyETnISoxQpQu3axgUSeKeoS9uchPEvMxNMK7vvGC3p93sI9obPv2jCKX9oPByUw7
 tGjqzgQeT4oDdL1fRRz6pVBdw9dlCxhpQaRRdbxMlJK0MMAdGRYs4RXnzTe5haUgm81n
 SuotGUgZpoK6uGKpairbjqdIFL1Lu6MtZBiGsmhRGTkxYb3MRbrrIv8oDhqIUnKXJ2m7
 Tm7g==
X-Gm-Message-State: AOJu0Ywy17LDc7ozLPVvhvO7+0SV9PJMYzyz0wGifHZd9dmjaLglIOXr
 BbMXFlrZ0AC8K4DCt6M9BqJZvblOniada+NxzEyc/VWp8VXQDfFVsoPJc0dwRQ7ajICJm0T8vrG
 R6blTsAl49Jvllubp1PdpZs3eQcsleT+6iyeqSkayGkRyuhuonmoE
X-Received: by 2002:a50:d5cb:0:b0:56b:a7b0:bbc with SMTP id
 g11-20020a50d5cb000000b0056ba7b00bbcmr3457068edj.22.1711526712274; 
 Wed, 27 Mar 2024 01:05:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3+i8oJ2dUJ/STHQB+VbUIXyFlJxJAjqpVncVQfF6rQxb4BrHxQ5u2mkV/0F207o9gkuywMA==
X-Received: by 2002:a50:d5cb:0:b0:56b:a7b0:bbc with SMTP id
 g11-20020a50d5cb000000b0056ba7b00bbcmr3457055edj.22.1711526711977; 
 Wed, 27 Mar 2024 01:05:11 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-37.web.vodafone.de.
 [109.43.177.37]) by smtp.gmail.com with ESMTPSA id
 d12-20020a50fe8c000000b0056a033fa007sm4961667edt.64.2024.03.27.01.05.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 01:05:11 -0700 (PDT)
Message-ID: <eb1a5114-b8a9-4438-abd8-278c0abf67b0@redhat.com>
Date: Wed, 27 Mar 2024 09:05:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 35/38] spapr: nested: Introduce H_GUEST_[GET|SET]_STATE
 hcalls.
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Neuling <mikey@neuling.org>
References: <20240312165851.2240242-1-npiggin@gmail.com>
 <20240312165851.2240242-36-npiggin@gmail.com>
 <CAFEAcA9dLHYvY7-zCntKFZGr1VJUW6b3y5UqFAq-XN8zgVe2WQ@mail.gmail.com>
 <1bc2bb17-23a5-4b36-a11b-bc7384a54a1d@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <1bc2bb17-23a5-4b36-a11b-bc7384a54a1d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 27/03/2024 06.41, Harsh Prateek Bora wrote:
> 
> 
> On 3/26/24 21:32, Peter Maydell wrote:
>> On Tue, 12 Mar 2024 at 17:11, Nicholas Piggin <npiggin@gmail.com> wrote:
>>>
>>> From: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>>
>>> Introduce the nested PAPR hcalls:
>>>      - H_GUEST_GET_STATE which is used to get state of a nested guest or
>>>        a guest VCPU. The value field for each element in the request is
>>>        destination to be updated to reflect current state on success.
>>>      - H_GUEST_SET_STATE which is used to modify the state of a guest or
>>>        a guest VCPU. On success, guest (or its VCPU) state shall be
>>>        updated as per the value field for the requested element(s).
>>>
>>> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>
>> Hi; Coverity points out a problem with this code (CID 1540008, 1540009):
>>
>>
>>
>>> +static target_ulong h_guest_getset_state(PowerPCCPU *cpu,
>>> +                                         SpaprMachineState *spapr,
>>> +                                         target_ulong *args,
>>> +                                         bool set)
>>> +{
>>> +    target_ulong flags = args[0];
>>> +    target_ulong lpid = args[1];
>>> +    target_ulong vcpuid = args[2];
>>> +    target_ulong buf = args[3];
>>> +    target_ulong buflen = args[4];
>>> +    struct guest_state_request gsr;
>>> +    SpaprMachineStateNestedGuest *guest;
>>> +
>>> +    guest = spapr_get_nested_guest(spapr, lpid);
>>> +    if (!guest) {
>>> +        return H_P2;
>>> +    }
>>> +    gsr.buf = buf;
>>> +    assert(buflen <= GSB_MAX_BUF_SIZE);
>>> +    gsr.len = buflen;
>>> +    gsr.flags = 0;
>>> +    if (flags & H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
>>
>> flags is a target_ulong, which means it might only be 32 bits.
>> But H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE has a bit set in the
>> upper 32 bits only. So Coverity complains about this condition
>> being always-zero and the body of the if being dead code.
>>
>> What was the intention here?
> 
> Hi Peter,
> Ideally this is intended to be running on a ppc64 where target_ulong
> should be uint64_t. I guess same holds true for existing nested-hv code
> as well.
> 
> Hi Nick,
> Do you think keeping both nested APIs (i.e. entire spapr_nested.c)
> within #ifdef TARGET_PPC64 would be a better choice here?

spapr_numa.c is only included with CONFIG_PSERIES in hw/ppc/meson.build, so 
that should already take care that this code is only compiled with a 64-bit 
target ... Can we somehow teach Coverity to take that into consideration?

  Thomas



