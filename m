Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F57C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 16:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0kMk-0005Tz-Jt; Fri, 04 Apr 2025 12:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u0kMi-0005Sk-2H
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 12:58:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u0kMg-0003GO-EX
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 12:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743785873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EbBkz1OFa3rs8Kj+4HQ4XpBTramOUDYhrWvGuQWQ4fw=;
 b=fROGLC2GGIQB3dEbu82ntXgttC5/9Wxv2zjYZXihFxQO1osEpaV3L+xZ6vHasbEKs3cHOl
 tmeDpTAjkToZVQHdASM84RKiEKaZMQE/gx9dcrWW/LJSYXN2tR7gjQ3YYr63dETgoRUfdD
 NwEgeBAC2msTQzTWvG7XEMh8YDl1/9I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-k_cWY9INM9K3RK4cBQGLcQ-1; Fri, 04 Apr 2025 12:57:50 -0400
X-MC-Unique: k_cWY9INM9K3RK4cBQGLcQ-1
X-Mimecast-MFC-AGG-ID: k_cWY9INM9K3RK4cBQGLcQ_1743785870
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cec217977so14698505e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 09:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743785869; x=1744390669;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EbBkz1OFa3rs8Kj+4HQ4XpBTramOUDYhrWvGuQWQ4fw=;
 b=dJv720ykfQKHnUX8kdpvvDemf7CmsQYFBiVs2kdeIG8YhxWU/AUkKt2tgZdwqzLo8i
 Rpr3Y7in2S4H3/LY4dvsAiGFTDrSFAHlHkNNumlX0tLH2H1s/4DOT5wkUJDUntVtQaUz
 EUCoqZz03m1RP2bqxOuEybPv0tAbK+eRddqFW3+T0uw3eYvyq1ZGWspwG1VPmhAFxCGK
 s8860OUTMouaIURi/vImE5BhOwUcnYbawDkiDygirUd4OnbKkqQjgnCM5sJ+Knqq6CFv
 MBYE/VeGG0TUNRQyuF9Yq7r6oL5pW+H4Nex1lrQs9AshP4kTAKALCLKZYcDUF6DEOhVS
 aWAg==
X-Gm-Message-State: AOJu0YzicuRpfHwY/3GZc4V16C+ywEcnJpXtgXobyS6fXsSbKiswrJzm
 BxjZ8ERRTceuYNUUis7Os72G5gQZihlnh7z50ALOZM3+wru1VD0QL0KPsxMwsZtCZrrMgMnSKhr
 0P5k1Xf939C5seaoryZ+LrkyeFH0qPTWJ3QQ1Wv3PaeWytjFSMxEh
X-Gm-Gg: ASbGnct6l7LwpwpJy9HaesQHu5kSGRN3j028/hbZUQ4hgZdyP9P0N0iaeXkbK16IigY
 GjRlP3flOXBrDpMV7Z9111g/eYA8WpRba/qYXCiJILvqKS/rlVDz2k6E7xOWFQ9WaVs9f/udCJJ
 Bl9udTg0YNgqSxyDLXCkMLUBv8fC4kK44mlwPREK17D1G0S2q06GtEcYrCqYaExjgJ0mzkOf+KZ
 1duM8H/FfPla85/zmeqiSFvZ1I/t407nhhh3pmEbGumugLHF9zc+TBTNGLgUry6VJ7dK6GuajE0
 DuxN5Xbw4tnQ/M1+5oP0eLKlPgd/PanZH1LGfoumESq4Ho4M6l5SCQ==
X-Received: by 2002:a05:600c:1384:b0:43c:fffc:7886 with SMTP id
 5b1f17b1804b1-43ecf85f216mr41605485e9.8.1743785869652; 
 Fri, 04 Apr 2025 09:57:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJTlXj202Hil72lky3EH6bB5rxzH8STwALhDgnIn4VlBiZdpYyCcqih1uHtGU5ILpdQXe/mg==
X-Received: by 2002:a05:600c:1384:b0:43c:fffc:7886 with SMTP id
 5b1f17b1804b1-43ecf85f216mr41605205e9.8.1743785869290; 
 Fri, 04 Apr 2025 09:57:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec366a699sm50215015e9.38.2025.04.04.09.57.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 09:57:48 -0700 (PDT)
Message-ID: <33a54cce-c9a3-4724-97ef-64ac6a96e5b7@redhat.com>
Date: Fri, 4 Apr 2025 18:57:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/28] vfio: add region cache
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
 <20250219144858.266455-9-john.levon@nutanix.com>
 <d0f99d52-4d8d-4b1e-9e83-ec39b5357a44@redhat.com>
 <Z+6wtZAfSayf+CG1@movementarian.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <Z+6wtZAfSayf+CG1@movementarian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 4/3/25 18:00, John Levon wrote:
> On Thu, Apr 03, 2025 at 05:46:03PM +0200, Cédric Le Goater wrote:
> 
>>> +static void vfio_get_all_regions(VFIODevice *vbasedev)
>>> +{
>>> +    struct vfio_region_info *info;
>>> +    int i;
>>> +
>>> +    for (i = 0; i < vbasedev->num_regions; i++) {
>>> +        vfio_get_region_info(vbasedev, i, &info);
>>> +    }
>>> +}
>>> +
>>>    void vfio_prepare_device(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
>>>                             VFIOGroup *group, struct vfio_device_info *info)
>>>    {
>>> @@ -1586,6 +1596,8 @@ void vfio_prepare_device(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
>>>        }
>>>        QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
>>> +
>>> +    vfio_get_all_regions(vbasedev);
>>>    }
> 
>>> +    /* check cache */
>>> +    if (vbasedev->regions[index] != NULL) {
>>> +        *info = vbasedev->regions[index];
>>> +        return 0;
>>> +    }
>>> +
>>
>> why not populate vbasedev->regions[index] in vfio_get_all_regions() ?
> 
> Good question. I presume it's not possible for us to ever look up a region
> that has somehow appeared *after* vfio_prepare_device() ?
> 
> We'd end up off the end of the array in that case anyway.


I was confused. I thought we were caching VFIORegions ...

Anyway, this is an optimisation and I fail to understand where
the VFIO_DEVICE_GET_REGION_INFO ioctl is called on a hot path.

Is it for interrupts ? Please explain.

Do you have figures ?


Thanks,

C.





