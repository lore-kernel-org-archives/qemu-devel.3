Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83B0C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 07:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri7wP-0007o6-In; Thu, 07 Mar 2024 02:13:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ri7wN-0007mJ-VY
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 02:13:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ri7wM-0005GW-FT
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 02:13:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709795597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X9vDqLPgB48Xqd0blSYNKo2TJvLpU5+BVtJ7DuF2NJk=;
 b=F4ZULXlC43fyFVSGzvuFDx1/FprkE7FykBEyZBBDCnJ/v09vz5YhsTOsnLDOQm1OWsGtgL
 q+zqjfB2WyIP0wlsx4JEXGeVGzYJlt0jtOuqQPleVdqpXR2U4znXQq5HilSauImiEnKlkL
 kTXwo/m7IA3kwfg2UKPOEBsGmDqrkNI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-YIpuY627OOeY06JAnLAJZQ-1; Thu, 07 Mar 2024 02:13:16 -0500
X-MC-Unique: YIpuY627OOeY06JAnLAJZQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-567279be640so262763a12.2
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 23:13:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709795595; x=1710400395;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X9vDqLPgB48Xqd0blSYNKo2TJvLpU5+BVtJ7DuF2NJk=;
 b=qT6nc1Ah0D0hchXKQDML5i9CnW/tsQkW9vjL8gMlbb6g3hnNzOzeM0MZssAB9n/7qA
 6TxjLrwB02BoGF72Ljey61IdwwfCK2iTHHLMysWIvCPNgVKJEIAs7IomgvDn7pGhCE3v
 Dx12kx8CTlv+4Sz95t/3/HoYzordJd6XULkVkn7aPe7xUMKarMzS1QDJAshdaj61mjB/
 Pflhq5GjYk5PUe+mEo+/CR6Rq4WggB+eVXHWenQYMhimXjC8j9W2BJrji9dCuPkkACEV
 n5fZ4l1RjWTrO+c/qopqQVfZCQDepOOOjvz7fc+j0KU1Vu47lLJF5FaHUvu+iv513RRp
 LJzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr+E30wmbk4yvskSpqI9T774DJUrljV0mHAx0PxFQXaeqijtF7HUBg6fCQ5X67MqHMdv9VPIDHxDWPuPnYFXNYPmQDTkE=
X-Gm-Message-State: AOJu0Yz80IQw+MqfzydMKCLY/mfwMQ3tC8pOyI4obxRqc02GP/i0T/iE
 551vueoc34c6sI4tHnJN+vtJPrOTV9bcCHgdqDJa1R7fkR8z5C4qUyDZOkRX37hltDlEk88GXm5
 JRHj0jqwTTYIcW6rAAXmQMe42ajVZ9KCbWrh+ZF7xv3UzfAwo2Syn
X-Received: by 2002:a05:6402:901:b0:565:9e16:60da with SMTP id
 g1-20020a056402090100b005659e1660damr13088574edz.30.1709795594957; 
 Wed, 06 Mar 2024 23:13:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiNoNZViGdG+rv4RSDQM8lVEVLtNtRazeydgFf4sRFc1xsHkoS727267gJ4t+K6CHcFhV5+Q==
X-Received: by 2002:a05:6402:901:b0:565:9e16:60da with SMTP id
 g1-20020a056402090100b005659e1660damr13088559edz.30.1709795594594; 
 Wed, 06 Mar 2024 23:13:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 a26-20020a50c31a000000b00567f9d21b7csm1188365edb.94.2024.03.06.23.13.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 23:13:13 -0800 (PST)
Message-ID: <f6ae3a49-7c3d-4d54-9e22-2fe2d3b31e06@redhat.com>
Date: Thu, 7 Mar 2024 08:13:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 21/25] vfio: Reverse test on vfio_get_dirty_bitmap()
Content-Language: en-US, fr
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-22-clg@redhat.com>
 <bd25d169-cd34-4670-9194-04ee0ff18ef5@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <bd25d169-cd34-4670-9194-04ee0ff18ef5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
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

On 3/6/24 21:51, Philippe Mathieu-Daudé wrote:
> On 6/3/24 14:34, Cédric Le Goater wrote:
>> It will simplify the changes coming after.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/vfio/common.c | 22 +++++++++++++---------
>>   1 file changed, 13 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 5b2e6a179cdd5f8ca5be84b7097661e96b391456..6820d2efe4923d5043da7eb8deecb6ff20e1fd16 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1241,16 +1241,20 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       }
>>       rcu_read_lock();
>> -    if (vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL)) {
>> -        ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
>> -                                    translated_addr);
>> -        if (ret) {
>> -            error_report("vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
>> -                         "0x%"HWADDR_PRIx") = %d (%s)",
>> -                         bcontainer, iova, iotlb->addr_mask + 1, ret,
>> -                         strerror(-ret));
>> -        }
>> +    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL)) {
>> +        goto out_lock;
>>       }
>> +
>> +    ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
>> +                                translated_addr);
>> +    if (ret) {
>> +        error_report("vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
>> +                     "0x%"HWADDR_PRIx") = %d (%s)",
>> +                     bcontainer, iova, iotlb->addr_mask + 1, ret,
>> +                     strerror(-ret));
>> +    }
>> +
>> +out_lock:
> 
> Alternatively use WITH_RCU_READ_LOCK_GUARD() to avoid label.

Sure. I remember your patch. I will resend with your suggestion when
the first part of this series is addressed.

Thanks,

C.


