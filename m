Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DC5C54E90
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 08:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHefa-0004sh-I7; Wed, 21 May 2025 04:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHefS-0004qB-UV
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:19:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHefQ-0000ER-Vq
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747815551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jS2sW6ZnhoFnKZqLiB3ORuKkw6hoCR0zX3q+CcslJI4=;
 b=GCFhiowtMBD8WwjtPkDyAcYG7iV6VZJBYFfdaqs98W8rBUy8TJttY8xYlXUahXINLysXxO
 COiGgFpr69HRC2yx03CMSXHPttkeeDfdnPB4epD2Azal0THMsS5pfQjIka5SUUch+jB8bJ
 WbcjTDIIW7TiZILy7coZOOGNuerHXTU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-NyXR6FA0NwSrMGiNxKMZog-1; Wed, 21 May 2025 04:19:10 -0400
X-MC-Unique: NyXR6FA0NwSrMGiNxKMZog-1
X-Mimecast-MFC-AGG-ID: NyXR6FA0NwSrMGiNxKMZog_1747815549
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-442ffaa7dbeso16572525e9.3
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 01:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747815549; x=1748420349;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jS2sW6ZnhoFnKZqLiB3ORuKkw6hoCR0zX3q+CcslJI4=;
 b=F6mY3+O6i8GM+Z2x8kbrZsC2acdXQVhkXJ9FGRuIKi59QUsw/CpIQNV82myV0xTUp0
 1mMWQBvr346vYEE6gTKl2w/5N+q1z81aIU9XD9drOTs5SfAdGLO7ZUQTfK9uNAWPHLaT
 Vy0ef5ntadTfHXQL79OsYtllqHRcrDwfpzaJFbtsKMmh0hCW7s5xGyuqSxKsEAgyPcVK
 HzL6Om9hkhWjmGQpKa7ATN2BXvcY78TkmI75uAwVZGqKpporUNcngcpJaGFZSo9AVRHv
 QsZvBZPJxFJNS+VPCrgwnkje3VpaAjjxHlUN+FuztJLRabOhV8qF4891ot+1pcYKCuLE
 4kwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgZ6QcepeL1k54H2Zeao1WcZvDP4ovFoNINlYdesfqt4ttOLsnys/UxOywiXUpb9COkqkwi9sdC5xl@nongnu.org
X-Gm-Message-State: AOJu0Yy05Xo9Qh2+S18Dg6MDRqE8NApKPFdfdtmpkf5PuWAQ/MD2l4aA
 jDMIOKzA4YzA9zRa+lLjYqp4RDQRm7WXiyS/a0Xvz3nnFVL4ymYLnUjM2ydNh/5onpPw46IoGzo
 2RvMLsQyyEmibX/cOJe0zi5tiQcxLbfK7HKeulE34OzQTCCOP5qSy9L2c
X-Gm-Gg: ASbGnctZD8AfykriTTIb3MXOQ1tJ8VV4UXTsbY44WRg5DqTbo+Alx3DwcU5VbLHzhEu
 0npCJcqbXb8v+llD3JMfm5OTGegnctfCSexHmxon+rtNdaLVreMkKHuq3HDHbOX23TOC96kYZIx
 QpWHae9CyuIcC4nxjyFAaEcqfP9RwjR5F/UpwiPjOzQBD+yJpi+W8blfuNk/Wim72Wz1NGIfwzN
 h/g58Mk3dXvgOXgUgf591qgTJM6OWOfAnBuClCXvtSkicYv1k6kwRBMmmxjXCPXlpaJDYhNPcNO
 qOf7LovGUpz3yjVmR/L+ubBOMUPLlB4CbMSwzs+xg5MHJdrWVA==
X-Received: by 2002:a05:600c:8597:b0:43c:fe15:41cb with SMTP id
 5b1f17b1804b1-442fd780527mr201195605e9.15.1747815548812; 
 Wed, 21 May 2025 01:19:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeTfnJ7XoiyuCO/IM6774uj6+YxF3eQ0PTw2PL7vpq4y1l/sm6cfkW/XfP7yIN7z5DkhBH4A==
X-Received: by 2002:a05:600c:8597:b0:43c:fe15:41cb with SMTP id
 5b1f17b1804b1-442fd780527mr201195345e9.15.1747815548436; 
 Wed, 21 May 2025 01:19:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a36749f622sm15154808f8f.93.2025.05.21.01.19.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 01:19:07 -0700 (PDT)
Message-ID: <b60c3eb3-6d1b-441b-9266-616e8f4debee@redhat.com>
Date: Wed, 21 May 2025 10:19:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 33/42] vfio/iommufd: define hwpt constructors
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-34-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB6744C9ABCAFF7FB3204BA6549293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <a61b557c-5cee-4a6d-bc68-973582b797c4@redhat.com>
 <SJ0PR11MB674429DE6E6421031651D44A929EA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <SJ0PR11MB674429DE6E6421031651D44A929EA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/21/25 04:48, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH V3 33/42] vfio/iommufd: define hwpt constructors
>>
>> On 5/16/25 10:55, Duan, Zhenzhong wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Steve Sistare <steven.sistare@oracle.com>
>>>> Subject: [PATCH V3 33/42] vfio/iommufd: define hwpt constructors
>>>>
>>>> Extract hwpt creation code from iommufd_cdev_autodomains_get into the
>>>> helpers iommufd_cdev_use_hwpt and iommufd_cdev_make_hwpt.  These will
>>>> be used by CPR in a subsequent patch.
>>>>
>>>> Call vfio_device_hiod_create_and_realize earlier so
>> iommufd_cdev_make_hwpt
>>>> can use vbasedev->hiod hw_caps, avoiding an extra call to
>>>> iommufd_backend_get_device_info
>>>
>>> We had made consensus to realize hiod after attachment,
>>> it's not a hot path so an extra call is acceptable per Cedric.
>>
>> We also placed the realize call where it is in preparation for
>> nested IOMMU support, and avoid a late_realize handler AFAICR
>>
>>
>>>> No functional change.
>>
>>
>> We should add a comment before to make sure the code is not moved
>> around.
> 
> Yes, I should have done that last time. Do you want me to send a patch to fix it?

Sure. I will handle the conflicts if needed.

Thanks Zhenzhong,

C.


