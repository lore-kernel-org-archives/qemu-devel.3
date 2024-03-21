Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E341C54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 16:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnL4d-00088A-NZ; Thu, 21 Mar 2024 12:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rnL4b-00087k-Q2
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 12:15:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rnL4a-0000Kb-5g
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 12:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711037718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=slRTyQp6db9vavffT9TB7Wr+s2VRVnkD1F4/do+Auko=;
 b=beOqCQ1ZNQDvGFwJl/f5hKMN5SElD44p4dNPoqWhXlQC9S+SWH6Y6wdZkCGxv7pFnrg/Mp
 ifC2VtKSRG+kClIghDwTbTyWWraBBUzoEPrA1pCGyF3JopKR3R12mX8IV0LAXIy6OBRKIj
 7kEG/U5S4RahuT67HhxWksNlDv27tv8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-Jsm8gYaZN5mz9ZEdibrtXg-1; Thu, 21 Mar 2024 12:15:15 -0400
X-MC-Unique: Jsm8gYaZN5mz9ZEdibrtXg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33ed26f20e4so705459f8f.0
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 09:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711037713; x=1711642513;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=slRTyQp6db9vavffT9TB7Wr+s2VRVnkD1F4/do+Auko=;
 b=V8ZykzN/S0XQ0y1LrJLmVcc00npvvh7P73GaWv6vk+RjwStRP28rqogQacTWDozdxw
 4DidYVuUOjWfV4xviWfGrN2MAAeKcmpBhYv6OyCEJbMgI/XrrD9IpoBuIjChn9yNIztm
 zYIu5fRSWHdUaF6H6pSDECqj38fgF4bQfNMf5zUbgxJfFCstwFXgUxfkGF5PbqLja7ai
 4+LdpG9228DIrdFnSSI68JWjkF0vJIMKN11H87uy5iXgsfFh5MtHhoNiDdtpN2qwzW2H
 vNt/Si607XW/qodLR9py499+Xj34IwIHMDT2NRq7QEip1UerH0XNRQPuPfDBQnFtQ+9I
 gWYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvYpcyEC1rcwVvcLAqmNXLqrohmR8h5ICnM9jMeDWs3eQ9ubkHUoR+7LaVEKuvoket9I6ZNQYQISpfMW+NmqPVaNJ8RrY=
X-Gm-Message-State: AOJu0YyJH5zP+eLacN88jDSZyZklb3Y3o8hnp1iSZ1fgX5Biybgy91Vl
 amH97vG2BB7pdNAearzcb2GjhQ05BX0LHD4LMg2rEjrDrdoVYCBnvscSEx8tzASiht0vheX5G4Y
 IK2aBQG0nIc8221j553lN0EcG/D4HX09gHpFmRZ7b+MnTl60CwMbM
X-Received: by 2002:adf:f4cc:0:b0:33e:2d7b:c5a8 with SMTP id
 h12-20020adff4cc000000b0033e2d7bc5a8mr2711006wrp.17.1711037713128; 
 Thu, 21 Mar 2024 09:15:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG59kqAkjKFPLvjsVqjBPHkH4VnaWzYdZrG67FLkhazc82qB+iJlDfpNub7WflgdYz0Fw3Udg==
X-Received: by 2002:adf:f4cc:0:b0:33e:2d7b:c5a8 with SMTP id
 h12-20020adff4cc000000b0033e2d7bc5a8mr2710989wrp.17.1711037712741; 
 Thu, 21 Mar 2024 09:15:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a05600c154a00b004146d7345d2sm185548wmg.46.2024.03.21.09.15.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 09:15:12 -0700 (PDT)
Message-ID: <f4bb2e2f-e145-41e2-ba89-1ae62b87db04@redhat.com>
Date: Thu, 21 Mar 2024 17:15:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc/pca9554: Fix check of pin range value in property
 accessors
Content-Language: en-US, fr
To: Miles Glenn <milesg@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240321160154.901829-1-clg@redhat.com>
 <c383d6f489022a47c6a87a250f4d44938d9ede6b.camel@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <c383d6f489022a47c6a87a250f4d44938d9ede6b.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.372,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 3/21/24 17:08, Miles Glenn wrote:
> On Thu, 2024-03-21 at 17:01 +0100, Cédric Le Goater wrote:
>> Coverity detected an "Integer handling" issue with the pin value :
>>
>>    In expression "state >> pin", right shifting "state" by more than 7
>>    bits always yields zero.  The shift amount, "pin", is as much as 8.
>>
>> In practice, this should not happen because the properties "pin8" and
>> above are not created. Nevertheless, fix the range to avoid this
>> warning.
>>
>> Fixes: CID 1534917
>> Fixes: de0c7d543bca ("misc: Add a pca9554 GPIO device model")
>> Cc: Glenn Miles <milesg@linux.vnet.ibm.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/misc/pca9554.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/misc/pca9554.c b/hw/misc/pca9554.c
>> index
>> 778b32e4430a8b618322c26b1b185ed3ead97cc4..5e31696797d9564666ece6fe177
>> 37ee2a9733e96 100644
>> --- a/hw/misc/pca9554.c
>> +++ b/hw/misc/pca9554.c
>> @@ -160,7 +160,7 @@ static void pca9554_get_pin(Object *obj, Visitor
>> *v, const char *name,
>>           error_setg(errp, "%s: error reading %s", __func__, name);
>>           return;
>>       }
>> -    if (pin < 0 || pin > PCA9554_PIN_COUNT) {
>> +    if (pin < 0 || pin >= PCA9554_PIN_COUNT) {
>>           error_setg(errp, "%s invalid pin %s", __func__, name);
>>           return;
>>       }
>> @@ -187,7 +187,7 @@ static void pca9554_set_pin(Object *obj, Visitor
>> *v, const char *name,
>>           error_setg(errp, "%s: error reading %s", __func__, name);
>>           return;
>>       }
>> -    if (pin < 0 || pin > PCA9554_PIN_COUNT) {
>> +    if (pin < 0 || pin >= PCA9554_PIN_COUNT) {
>>           error_setg(errp, "%s invalid pin %s", __func__, name);
>>           return;
>>       }
> 
> Thanks, Cédric!  I guess I should be running coverity myself.

I don't myself. I get reports from :

   https://scan.coverity.com/projects/qemu

Thanks,

C.


