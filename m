Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 653BCC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 11:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJWuz-00082I-Pb; Tue, 18 Jun 2024 07:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJWuw-00081y-Ul
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:22:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJWuv-0006ky-23
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718709743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PKyT5iAXzsXt/u3rp0WLy5M6y+SEhTxaicjtOp6Xay8=;
 b=DD0lzhXPApc7w0exnu8h+Ce+iAjuLQcm+hyhKXEs0YmUcqi2AUPYs6AnyKHm3Boxw/vZva
 Qo8lebd/AEzV9wpVy+UovxErBrnKL3S3CJfV2GVKaIuV19bdHjNvM3prJJdqRqS9l3/cI/
 6exMWw+GOEiEMamd+IYajo4oRUegMqg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-7dXdNpjcOTi5k1nyUEgsyg-1; Tue, 18 Jun 2024 07:22:20 -0400
X-MC-Unique: 7dXdNpjcOTi5k1nyUEgsyg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-35f27bfa618so2765586f8f.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 04:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718709739; x=1719314539;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PKyT5iAXzsXt/u3rp0WLy5M6y+SEhTxaicjtOp6Xay8=;
 b=oRO8rxdDaOErsLLXqO2Qrtwi6bLINnroXZvS1m3znioOiRdSWELqVAJLuS904Bs5p/
 jTlCq32IZ2OBsUCerOhYdzGqyps0MlnphY1uooBQm1i7N1nsgsi3JdLZSRWX0JaLKniP
 ZmICDDWAl5a5MPJwwxl00+GJm0z/wBg5Hb5dBTmX44GoVKYh8Jnalpcnfv1Pvwlw7XR4
 yyhzajICRD5gifUzi7TVsSEsTpxOUv0vsJ82OLIw+iwQ+UeGIwgaVDLi+ynTHf8PW1Wa
 pDoxkxVa8r30IMc6sOZ0f4ByyIn/3iNSCeZ7ZVtZoDqxmBlxTxSoTxv4RBXHe7n28IYw
 6dqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlhUtyk0FWsSf8N2Kd9Nw41CcgOGoWjF95uLaHsgdfawgDxlDtjJOFykXV6BD3DCSOzvNY0IPRZi1PvZQ1fQ3yQEe9GPE=
X-Gm-Message-State: AOJu0Ywuv0OpHr3HnWhJLwLpx8MwP+p/OebeKjy9fwbcm+O8QbUyz6iI
 23/mpWjJOjoRM6gYlTx4/lP4EgwiNZf0Ti6DPzAyzuZ3pJvb1ApbFJlZ8J9mtkmFKymqwYuh3j+
 FEq88EPuNw4qJhoDsaQ1DfFt8SLNNu+aJ+JnAUfHhtmXbD3wKCg2Z
X-Received: by 2002:adf:cd09:0:b0:35f:d6e:f7bd with SMTP id
 ffacd0b85a97d-3607a76ae7emr7825274f8f.29.1718709739421; 
 Tue, 18 Jun 2024 04:22:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENywWz9o9O59DwNgBz8MOb9ZUfHnhgxW1bdbmaD/obRa14HPmfZkyIS4fsM+IV5TpP6i/DyQ==
X-Received: by 2002:adf:cd09:0:b0:35f:d6e:f7bd with SMTP id
 ffacd0b85a97d-3607a76ae7emr7825261f8f.29.1718709739034; 
 Tue, 18 Jun 2024 04:22:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36289a4faeasm490251f8f.95.2024.06.18.04.22.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 04:22:18 -0700 (PDT)
Message-ID: <9fa557c2-ad9f-47f0-ab40-17332badcb15@redhat.com>
Date: Tue, 18 Jun 2024 13:22:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/17] vfio/common: Move dirty tracking ranges update
 to helper
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20240617063409.34393-1-clg@redhat.com>
 <20240617063409.34393-4-clg@redhat.com>
 <81fa58ce-a4e6-41f1-8d9a-75ad674fe472@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <81fa58ce-a4e6-41f1-8d9a-75ad674fe472@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

On 6/17/24 1:39 PM, Eric Auger wrote:
> Hi Cédric,
> On 6/17/24 08:33, Cédric Le Goater wrote:
>> From: Joao Martins <joao.m.martins@oracle.com>
>>
>> Separate the changes that updates the ranges from the listener, to
> s/updates/update

fixed.

>> make it reusable in preparation to expand its use to vIOMMU support.
>>
>> [ clg: - Rebased on upstream
>>         - Introduced vfio_dirty_tracking_update_range() ]
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   hw/vfio/common.c | 38 ++++++++++++++++++++++----------------
>>   1 file changed, 22 insertions(+), 16 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index d48cd9b9361a92d184e423ffc60aabaff40fb487..fe215918bdf66ddbe3c5db803e10ce1aa9756b90 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -839,20 +839,11 @@ static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
>>       return false;
>>   }
>>   
>> -static void vfio_dirty_tracking_update(MemoryListener *listener,
>> -                                       MemoryRegionSection *section)
>> +static void vfio_dirty_tracking_update_range(VFIODirtyRanges *range,
>> +                                             hwaddr iova, hwaddr end,
>> +                                             bool update_pci)
>>   {
>> -    VFIODirtyRangesListener *dirty = container_of(listener,
>> -                                                  VFIODirtyRangesListener,
>> -                                                  listener);
>> -    VFIODirtyRanges *range = &dirty->ranges;
>> -    hwaddr iova, end, *min, *max;
>> -
>> -    if (!vfio_listener_valid_section(section, "tracking_update") ||
>> -        !vfio_get_section_iova_range(dirty->bcontainer, section,
>> -                                     &iova, &end, NULL)) {
>> -        return;
>> -    }
>> +    hwaddr *min, *max;
>>   
>>       /*
>>        * The address space passed to the dirty tracker is reduced to three ranges:
>> @@ -873,8 +864,7 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
>>        * The alternative would be an IOVATree but that has a much bigger runtime
>>        * overhead and unnecessary complexity.
>>        */
>> -    if (vfio_section_is_vfio_pci(section, dirty->bcontainer) &&
>> -        iova >= UINT32_MAX) {
>> +    if (update_pci && iova >= UINT32_MAX) {
>>           min = &range->minpci64;
>>           max = &range->maxpci64;
>>       } else {
>> @@ -889,7 +879,23 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
>>       }
>>   
>>       trace_vfio_device_dirty_tracking_update(iova, end, *min, *max);
> don't you want to update the name of the trace point?

There is only one caller. Let's reconsider when there are more users of this
routine.

Thanks,

C.

  
>> -    return;
>> +}
>> +
>> +static void vfio_dirty_tracking_update(MemoryListener *listener,
>> +                                       MemoryRegionSection *section)
>> +{
>> +    VFIODirtyRangesListener *dirty =
>> +        container_of(listener, VFIODirtyRangesListener, listener);
>> +    hwaddr iova, end;
>> +
>> +    if (!vfio_listener_valid_section(section, "tracking_update") ||
>> +        !vfio_get_section_iova_range(dirty->bcontainer, section,
>> +                                     &iova, &end, NULL)) {
>> +        return;
>> +    }
>> +
>> +    vfio_dirty_tracking_update_range(&dirty->ranges, iova, end,
>> +                      vfio_section_is_vfio_pci(section, dirty->bcontainer));
>>   }
>>   
>>   static const MemoryListener vfio_dirty_tracking_listener = {
> Besides
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Eric
> 


