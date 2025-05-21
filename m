Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045BEC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 08:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHeh8-0007aX-KE; Wed, 21 May 2025 04:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHeh5-0007Sl-LZ
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:20:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uHeh0-0000dI-O1
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747815647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hsPJIhySWlCCWjqcrNxrF7sGvV5lk84Eg3H7594jJP4=;
 b=EiFPtBoxWSMozjCGEKxrpLNblW73DF3AgLq562tUhZsu7636KfTgtEcksQRNd8UngzPsos
 mcfr2vVnicypA4+XxVnU6itxwHv+3bYKSsXLBhGPHcHBvnnWQNGoAHAVBMrYGIZsrKXqT4
 v09rAqfkj+dW7rCpOe8xLhlI3ZlG1F8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-IHN936FMNMqmX_XwwDwHcQ-1; Wed, 21 May 2025 04:20:46 -0400
X-MC-Unique: IHN936FMNMqmX_XwwDwHcQ-1
X-Mimecast-MFC-AGG-ID: IHN936FMNMqmX_XwwDwHcQ_1747815645
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a371fb826cso1444473f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 01:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747815645; x=1748420445;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hsPJIhySWlCCWjqcrNxrF7sGvV5lk84Eg3H7594jJP4=;
 b=CmTmUw9+or9UXGawINExOyhPoqv10HgZlimU7y5FYkHm96XTbUarLO2PTniBDoTpDD
 RshUenqWKpYrPlsD4T6cBG4DIiD9hrBzMrPRFxAk9SV+EawA2HknWTQlu9Udk5Ob5YV3
 NVOl/2LNXFqLAHmue5slquLiIjeLbtT+JRwZrkqXBxjnqQGUolcNmNXHfNB5c6TpQva2
 JzNZ2+EgPX4k6CGydCJvK1efAr0e5ktq9FIKeG3cKIcvi2sy1Gt38yUQ4bAL839Ha1CP
 8enjzvDKND434H9OMWzS1WENtiurotm1NDcav0XIz4feD41pTG/sUIvViFO6LXWYgpwn
 EpJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPW+8vWXigJzEmyQ5J0Jt0iP+kZPto+ohT2cAXKJIto9FJsGEot7XkcWPOClJad6iV7HPb2rCASsZJ@nongnu.org
X-Gm-Message-State: AOJu0YyViY/T0ZKa2dUVljJGheMzgbwoW7jcV4auWrAD6OhXngyfoLHZ
 gcUyiBjE39aciAeLFeVdvu1UsEfkNy2OyiJa1S0IUcXQpAcKqWHQlvkVtfK9zr5fnxl1doy7Gsy
 sAhzx2VIbSFeNgaGJzZ2LpzeHoajgJwi0Kgqt+Q6j3fH6AEY94CAIFvWa
X-Gm-Gg: ASbGnctGqJ27Na03J0xE6zJvub2NqJ2m0+Gc0wY896WDj9nThhZo8IudJozOtjfbh4K
 2dXifw0DWikaqaeM6S+EeIqSPGwoA7tXmkrEvf/jc6sIvaq+9TVLpdRPYJuYGZTWjebQwX0zner
 EUoM/RV/t1OETC5W7cgyT7OUpltk8r3IaZiYt3kSevxwClpJD61MYRS9tjTfogQxVlGiHEDKcwQ
 AJFtXBxo5maJd7Qg+xhK6MI8YplShZ6f65vIMM79Ww+Q/kuU6b6LcIaVVU1dCscJ91Ys47BryVj
 +yTEda48YzRUYay53j2GsJPMO453S6GN4mflpjkaGpgrYzqhIQ==
X-Received: by 2002:a05:6000:2012:b0:3a1:f68b:60a8 with SMTP id
 ffacd0b85a97d-3a35c834d65mr18221345f8f.10.1747815644772; 
 Wed, 21 May 2025 01:20:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRnERVcHM20mHiEt7Fo31OButDRVhYfjOIXKTd1r6Ioh62KseIVNqPLOGD3MRU4BSNFwXXZQ==
X-Received: by 2002:a05:6000:2012:b0:3a1:f68b:60a8 with SMTP id
 ffacd0b85a97d-3a35c834d65mr18221308f8f.10.1747815644313; 
 Wed, 21 May 2025 01:20:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a367205338sm15417968f8f.98.2025.05.21.01.20.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 01:20:43 -0700 (PDT)
Message-ID: <c3fdd753-a692-4252-bb9c-6a08a2e5c63d@redhat.com>
Date: Wed, 21 May 2025 10:20:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 34/42] vfio/iommufd: invariant device name
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-35-git-send-email-steven.sistare@oracle.com>
 <c92954d8-f70b-470a-9e12-890c9bf63d4c@redhat.com>
 <513443f4-aaf7-464f-b39b-a22391f069a4@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <513443f4-aaf7-464f-b39b-a22391f069a4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 5/20/25 23:00, Steven Sistare wrote:
> On 5/20/2025 9:55 AM, Cédric Le Goater wrote:
>> On 5/12/25 17:32, Steve Sistare wrote:
>>> cpr-transfer will use the device name as a key to find the value
>>> of the device descriptor in new QEMU.  However, if the descriptor
>>> number is specified by a command-line fd parameter, then
>>> vfio_device_get_name creates a name that includes the fd number.
>>> This causes a chicken-and-egg problem: new QEMU must know the fd
>>> number to construct a name to find the fd number.
>>>
>>> To fix, create an invariant name based on the id command-line
>>> parameter.  If id is not defined, add a CPR blocker.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>   hw/vfio/cpr.c              | 21 +++++++++++++++++++++
>>>   hw/vfio/device.c           | 10 ++++------
>>>   hw/vfio/iommufd.c          |  2 ++
>>>   include/hw/vfio/vfio-cpr.h |  4 ++++
>>>   4 files changed, 31 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
>>> index 6081a89..7609c62 100644
>>> --- a/hw/vfio/cpr.c
>>> +++ b/hw/vfio/cpr.c
>>> @@ -11,6 +11,7 @@
>>>   #include "hw/vfio/pci.h"
>>>   #include "hw/pci/msix.h"
>>>   #include "hw/pci/msi.h"
>>> +#include "migration/blocker.h"
>>>   #include "migration/cpr.h"
>>>   #include "qapi/error.h"
>>>   #include "system/runstate.h"
>>> @@ -184,3 +185,23 @@ const VMStateDescription vfio_cpr_pci_vmstate = {
>>>           VMSTATE_END_OF_LIST()
>>>       }
>>>   };
>>> +
>>> +bool vfio_cpr_set_device_name(VFIODevice *vbasedev, Error **errp)
>>> +{
>>> +    if (vbasedev->dev->id) {
>>> +        vbasedev->name = g_strdup(vbasedev->dev->id);
>>> +        return true;
>>> +    } else {
>>> +        /*
>>> +         * Assign a name so any function printing it will not break, but the
>>> +         * fd number changes across processes, so this cannot be used as an
>>> +         * invariant name for CPR.
>>> +         */
>>> +        vbasedev->name = g_strdup_printf("VFIO_FD%d", vbasedev->fd);
>>
>> The code above should be in vfio_device_get_name() proposed in its own path.
> 
> I understand, "in its own patch".  Will do.

yes. This typo could clearly be misunderstood :/ Sorry for the noise.


> 
>>> +        error_setg(&vbasedev->cpr.id_blocker,
>>> +                   "vfio device with fd=%d needs an id property",
>>> +                   vbasedev->fd);
>>> +        return migrate_add_blocker_modes(&vbasedev->cpr.id_blocker, errp,
>>> +                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
>>
>> The cpr blocker should proposed in a second patch, maybe with a small
>> wrapper to set the 'Error *'.
> 
> will do.


Thanks,

C.



