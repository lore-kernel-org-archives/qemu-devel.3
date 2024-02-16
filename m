Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB49BC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 09:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rauMY-0000F8-IV; Fri, 16 Feb 2024 04:18:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rauMX-0000Ex-H0
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 04:18:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rauMW-000694-12
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 04:18:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708075106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l8FWaeGv1q0g9QFHO+gn0EkjN7HN3aBNvo4Kr3VxHco=;
 b=GpKiUfCOEKIC75Jl9ixAhzTIKTeYaYjASkeLL9V8yIaKZl/5Skivwwg37EEd1ZuFGIrrK+
 iLIpeyJmH3bn9FIjRgEdFoC2ngDinXOqfrOBnhk+BGneQex/hUDsOQHqky5GjARs2d60Rf
 9BMsYHZNxQotkcW3PUGSVja5aCzQd+M=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-LLXgFQlZPQ-CEmCG-dm2ow-1; Fri, 16 Feb 2024 04:18:24 -0500
X-MC-Unique: LLXgFQlZPQ-CEmCG-dm2ow-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-680b2c9b0ccso8014216d6.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 01:18:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708074800; x=1708679600;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l8FWaeGv1q0g9QFHO+gn0EkjN7HN3aBNvo4Kr3VxHco=;
 b=m36POESbWWFAr/yyYnyY2iNf2aAbPLWk5IujcgQTmrUs4BuMm2r1kxhR74DTX3vKyI
 S5oTIERrQS4ddOijf0b+9jp9dM8v6x5ohKG8mtiWLVpT1PhfjfoTQdnH4Pd3LSSBLvyQ
 VcovT8OUaqJUXCS+kkbT79LuiDkFG1sfIhHHp/KR8jLQDu9nSQbNkyQXEjd0ED3n8T7i
 Z6SYKBDIBYiAKLHLgKhm4uD9/VK6PETK8xz3SCxBZHzuTfX51MLUN8DbJiFDrQUNDCjf
 x66+trsfylHR8sJIxmTaoSIWNNWUcHFxk8I4MmdqioGn9ZCAbbwJvI3o9XFO/+KVBGP5
 oWFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeFOJgPh9ZcNOCHzQoBtG5/8FVZAkRsk8gFEAL5ZyRI2YC4SrCcBLUcsJ2q3iQiRtwb8OEqz1e9ixibYT8lm1MJweqidc=
X-Gm-Message-State: AOJu0YyabYxSJKXW0CA4eqqQ82BrdARQo24S7dkNtkwzU0T8pNeUuI7t
 0TguNcRXDOmRSc959halVxFNFStJ+4FrZUfxgMOKi3LCAhm0l4H+2JEbczdTWqGJB2CJOor8xyy
 cJBzzkXWMWG4dF/LNc7RFKKnP//hXKI4MhEHI2A9gtyzmORsK3K6c
X-Received: by 2002:a05:6214:e61:b0:68c:95ed:8d2d with SMTP id
 jz1-20020a0562140e6100b0068c95ed8d2dmr5318388qvb.23.1708074800162; 
 Fri, 16 Feb 2024 01:13:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoe462vBHlCH2Ntj7224IXK0TyTBS477w0QiLGL7ZCw/kFKBsQcdpCIBliVSS1jIMoGV1dpg==
X-Received: by 2002:a05:6214:e61:b0:68c:95ed:8d2d with SMTP id
 jz1-20020a0562140e6100b0068c95ed8d2dmr5318375qvb.23.1708074799912; 
 Fri, 16 Feb 2024 01:13:19 -0800 (PST)
Received: from ?IPV6:2a01:cb19:853d:fa00:f59e:918a:6675:6332?
 ([2a01:cb19:853d:fa00:f59e:918a:6675:6332])
 by smtp.gmail.com with ESMTPSA id
 lz8-20020a0562145c4800b0068f1223e3e2sm1580077qvb.1.2024.02.16.01.13.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Feb 2024 01:13:19 -0800 (PST)
Message-ID: <2fbf0024-3a2c-4656-8407-fa271a8bb7ec@redhat.com>
Date: Fri, 16 Feb 2024 10:13:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] hw/vfio/common: Use RCU_READ macros
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Greg Kurz <groug@kaod.org>, Richard Henderson
 <richard.henderson@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240124074201.8239-1-philmd@linaro.org>
 <20240124074201.8239-6-philmd@linaro.org> <7reip.7d0x82au0t9p@linaro.org>
 <887a8b74-423f-4c4c-8cdd-d29fcb4f14b8@linaro.org>
 <a55d793c-3d61-4bda-8213-12a1de65c85f@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <a55d793c-3d61-4bda-8213-12a1de65c85f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.772,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 2/16/24 09:49, Philippe Mathieu-Daudé wrote:
> On 24/1/24 15:09, Philippe Mathieu-Daudé wrote:
>> On 24/1/24 10:25, Manos Pitsidianakis wrote:
>>> On Wed, 24 Jan 2024 09:42, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>> Replace the manual rcu_read_(un)lock calls by the
>>>> *RCU_READ_LOCK_GUARD macros (See commit ef46ae67ba
>>>> "docs/style: call out the use of GUARD macros").
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>> hw/vfio/common.c | 34 ++++++++++++++++------------------
>>>> 1 file changed, 16 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>>> index 4aa86f563c..09878a3603 100644
>>>> --- a/hw/vfio/common.c
>>>> +++ b/hw/vfio/common.c
>>>> @@ -308,13 +308,13 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>>>         return;
>>>>     }
>>>>
>>>> -    rcu_read_lock();
>>>> +    RCU_READ_LOCK_GUARD();
>>>>
>>>>     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>>>>         bool read_only;
>>>>
>>>>         if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only)) {
>>>> -            goto out;
>>>> +            return;
>>>
>>> Since this is the only early return, we could alternatively do:
>>>
>>> -         if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only)) {
>>> +         if (vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only)) {
>>>
>>> remove the goto/return, and wrap the rest of the codeflow in this if's brackets. And then we could use WITH_RCU_READ_LOCK_GUARD instead. That'd increase the code indentation however.
>>
>> If the maintainer agrees with the style & code churn, I don't
>> mind respining.
> 
> Alex, Cédric, any preference?

my choice would be to keep the 'goto' statement and protect
the vfio_get_xlat_addr() call with :

+        WITH_RCU_READ_LOCK_GUARD() {
+            if (vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL)) {
+                ret = vfio_get_dirty_bitmap(bcontainer, iova,
+                                            iotlb->addr_mask + 1,
+                                            translated_addr);
+                if (ret) {
+                    error_report("vfio_iommu_map_dirty_notify(%p,"
+                                 " 0x%"HWADDR_PRIx
+                                 ", 0x%"HWADDR_PRIx") = %d (%s)",
+                                 bcontainer, iova, iotlb->addr_mask + 1, ret,
+                                 strerror(-ret));
+                }
+            }
          }



Thanks,

C.




