Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06ECCC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 15:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0jBF-0003in-Hl; Fri, 04 Apr 2025 11:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u0jBD-0003iA-MS
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 11:42:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u0jBC-0008RY-9d
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 11:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743781321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4OhEFMF5Wa7rkUkrJ8Kpb5bATogJewk7UQWmx7eVG+Q=;
 b=VSBs4SVyE+L8fYp6Da5kOsEdrCpVoTkcl1i4sHu84SzeDXeLLzIJrF/CqUl6ea24E7QF/6
 I8oi75Q0LMX8Y/G8xO3EQYvcL+JRmCmQqEKA8bOw+B9ZyBta70l6woNtqnnRUCjy6PAyiC
 XaFOO5D3Hbq6+5FNiyhQZx1pLhWTrrI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-oL0enqgFP-iv1uUfKxLF9A-1; Fri, 04 Apr 2025 11:41:57 -0400
X-MC-Unique: oL0enqgFP-iv1uUfKxLF9A-1
X-Mimecast-MFC-AGG-ID: oL0enqgFP-iv1uUfKxLF9A_1743781317
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43bd0586a73so14684175e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 08:41:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743781316; x=1744386116;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4OhEFMF5Wa7rkUkrJ8Kpb5bATogJewk7UQWmx7eVG+Q=;
 b=iE9Jduj1BmCxSBpukU8iOuf8gEiazL/TqlyWYPL2qZ4wC7SuidRaG4e+GwQj4hAFRE
 10G3fzdMJtWhCqQGYgnKFMpkgy1HA6qgzhwuLcwlfcHKVsHE3al0/lc54Fu8UGRZWE0z
 1g21dGcSjNxXciI4Au64QGpzPOn7wUFq+iTYDyIKQqh0C/TY8s/7N1l/Dp6qeBll82D+
 fiqcDP+XkVWvh4Z6WiyMCJNZwVoqqeVS2kEMDbHOp0qmLl9e9oJ8z6tYCwt9d2mUD8Q/
 4XZaFkuIe7yZ0sSF0p7ctq8o4qvjR4rr5YAqT38RmMSfIWj2qqEXuIOPS1p1QXBg5Ce5
 cB/g==
X-Gm-Message-State: AOJu0YyhDmb8Gc4PPqPYTX89UMTyPW/EabTjR0MKDWOcnByXQe+PFpNn
 gZN++r6PqHR5VbZILNrRYf6MudRpyfLG392izdSFdpbPlaDW3269kgeW6Ka06BToRkal+/Ryab/
 RMNLBmpIVHafpaX7w9eUMa+j1TMsDhe0gb8O8/mhH7NAyMnkXiUaF
X-Gm-Gg: ASbGncvGgR/dSBMMVb5bMucm3rysc99MmUB6gKUF5LtTS1Z3zZeyP1H3yvx8Fi3I0ZL
 +rHvvvBAPMzDRNte8mrDxfOU1bmRgzqUR7SbEjPboVHMKTEdsntgXoGfhv1KRrGALn2NBgjUlxk
 uE7jxWQ074J4zcZdcOFDcANUnGKU6dLSWkfrLGrkr2UBgPCvw996SXaMRq5gq9Q4Z/naWyXxibV
 y+vM5ETPvo3fhGo7RFvnFe6b2XwP7zzQeFZQCLMwO9XRe+gdSUsY1YlV0C2ze+4R+OjkZSw4H8+
 xRf5RGg63rb2iNxIMtJd+fph7esdIRS9rR8RjmVNGSbDKD40QbY+ZQ==
X-Received: by 2002:a7b:cc83:0:b0:43c:f8fe:dd82 with SMTP id
 5b1f17b1804b1-43ed6615607mr21141385e9.18.1743781316594; 
 Fri, 04 Apr 2025 08:41:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEojZjhXf7t34g1YrzMTFtdzRlGole4sJN4TnyheekF2X9sFWy5KV9B7XsNwl61og8Qgx/ooQ==
X-Received: by 2002:a7b:cc83:0:b0:43c:f8fe:dd82 with SMTP id
 5b1f17b1804b1-43ed6615607mr21141035e9.18.1743781316237; 
 Fri, 04 Apr 2025 08:41:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec364a0c7sm48750855e9.29.2025.04.04.08.41.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 08:41:55 -0700 (PDT)
Message-ID: <46d85400-7073-463e-b61a-73731270a6c0@redhat.com>
Date: Fri, 4 Apr 2025 17:41:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/28] vfio: add vfio_prepare_device()
To: John Levon <levon@movementarian.org>
Cc: qemu-devel@nongnu.org, Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
 <20250219144858.266455-6-john.levon@nutanix.com>
 <3369ecab-21ea-4198-9ffa-73307a795f69@redhat.com>
 <Z+5WLqQRqrxSpNBV@movementarian.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <Z+5WLqQRqrxSpNBV@movementarian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 4/3/25 11:34, John Levon wrote:
> On Thu, Apr 03, 2025 at 11:19:34AM +0200, Cédric Le Goater wrote:
> 
>> On 2/19/25 15:48, John Levon wrote:
>>> Commonize some initialization code shared by the legacy and iommufd vfio
>>> implementations (and later by vfio-user).
>>>
>>> Signed-off-by: John Levon <john.levon@nutanix.com>
>>> ---
>>>    hw/vfio/common.c              | 19 +++++++++++++++++++
>>>    hw/vfio/container.c           | 14 +-------------
>>>    hw/vfio/iommufd.c             |  9 +--------
>>>    include/hw/vfio/vfio-common.h |  2 ++
>>>    4 files changed, 23 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index eefd735bc6..4434e0a0a2 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -1569,6 +1569,25 @@ retry:
>>>        return info;
>>>    }
>>> +void vfio_prepare_device(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
>>> +                         VFIOGroup *group, struct vfio_device_info *info)
>>
>> I would prefer that the first version did not have a 'group' parameter.
>> Let's add it when needed.
> 
> I think you mean something like this in hw/vfio/container.c:
> 
> vfio_prepare_device(vbasedev, &group->container->bcontainer, info);
> 
> vbasedev->group = group;
> QLIST_INSERT_HEAD(&group->device_list, vbasedev, next);
> 
> As it's the only consumer that actually wants a group.
yes. It's a vfio legacy only construct. We will see what to do
if vfio-user needs it.


Thanks,

C.




