Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B441C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 15:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVv68-0007J1-Um; Mon, 22 Jul 2024 11:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sVv63-0007Fa-Ko
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 11:37:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sVv61-00026Q-A6
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 11:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721662622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qAxHiUXSF5fDIPl+OylNoc7DV5VZZR7gSf7EwkVdJ3g=;
 b=NeulkmxrnTwvYWzFKMzkHKCo/zjOrUeIdXz3XK4D0epYvnsmsaRhJYtUovWvty2W/5rzMz
 Bdjt9K+ALWeR+0ruIT72RuNnowaWHaDe4SJRTzeXyqKUhZgVt0LWeYf8DmGfKOWJeiy0HT
 Ev4d4jmrRBhG9Mk/maVf8yHoyul1RvE=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-pln49Ea5OheNM5sypBh3Jw-1; Mon, 22 Jul 2024 11:37:00 -0400
X-MC-Unique: pln49Ea5OheNM5sypBh3Jw-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7036381a452so3985856a34.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 08:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721662618; x=1722267418;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qAxHiUXSF5fDIPl+OylNoc7DV5VZZR7gSf7EwkVdJ3g=;
 b=tw8++IePhAAPrXaKShx3BNWEHhnLflmhPTh115DDkCGR8VqW5FYD0yD1jnZ8pz/7QU
 Kl2KEzbI9Ap1F0/vV2Ud2CWKHmZWgLX6mFVr8NoOdv6p7EInmbU8SfQMSMBNoA7zgOss
 dsED3lTNQTE6J3hMYefqTbm9Zl7FuWiUh5ddvqg0pV2qIIIKGwjLwPEL8Kb/9YwUZ8Mu
 ZbdmE6vgC00oUCt9PZ5D7Fpy/tvxIR3NNYQIyYX8r0iNbbU/XYnWMnAP/oAz03wIslui
 dYEpphhmSq/YhkOZ2c07af0TfMhsTI1KM/BXtoCmzhfIJz2P1RVGIRDghgOQIWoKaKOt
 N1qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYSki/ChIGyk8rbgnHPznmTwOaewgTCb5BDWMJgvBJtoStMqSw+FrZxmkP3yD1mJdZs8SfGRAm18DYThXdlF3t6m9vrrs=
X-Gm-Message-State: AOJu0YyJpVXGTVepMEjAnkrHCNTN0ayR0rswB5kYGpi6Z8E/g/jMxyEn
 RENxTIHWpN5dqd0pH0QctT7rFuNY+yMrsL3ofXOBgaZwbsEM5te6DMvVX2LjnldTAFkugk4YwDb
 Hg0dDDwxf7vddN5rxASUCaDjAXfODVNiXe/nHqLgUnOvz4QtOjAFu
X-Received: by 2002:a05:6830:6708:b0:703:6847:3ab8 with SMTP id
 46e09a7af769-70900983967mr11212086a34.25.1721662618125; 
 Mon, 22 Jul 2024 08:36:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHixRhtMU/vUgF2Qi8vnHsUGcVGlP6QdMsESRr4y8OvYGSbDicOu5epEKmkQ3V4EU4HpUsk3A==
X-Received: by 2002:a05:6830:6708:b0:703:6847:3ab8 with SMTP id
 46e09a7af769-70900983967mr11212066a34.25.1721662617871; 
 Mon, 22 Jul 2024 08:36:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e?
 ([2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b7ac9c3c17sm36770876d6.86.2024.07.22.08.36.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 08:36:57 -0700 (PDT)
Message-ID: <4369ce16-0b40-4df3-8db0-276bb0887fa0@redhat.com>
Date: Mon, 22 Jul 2024 17:36:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] vfio/ccw: Don't initialize HOST_IOMMU_DEVICE with mdev
To: Joao Martins <joao.m.martins@oracle.com>,
 Eric Farman <farman@linux.ibm.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com, 
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>,
 qemu-devel@nongnu.org
References: <20240722070713.1342711-1-zhenzhong.duan@intel.com>
 <20240722070713.1342711-3-zhenzhong.duan@intel.com>
 <40cf2370a1838b1aa1e9eb2cfc75a0543ceb45bd.camel@linux.ibm.com>
 <3072c39e-fd1b-4cc1-a189-2aa64a1d5984@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <3072c39e-fd1b-4cc1-a189-2aa64a1d5984@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

On 7/22/24 17:09, Joao Martins wrote:
> On 22/07/2024 15:57, Eric Farman wrote:
>> On Mon, 2024-07-22 at 15:07 +0800, Zhenzhong Duan wrote:
>>> mdevs aren't "physical" devices and when asking for backing IOMMU info,
>>> it fails the entire provisioning of the guest. Fix that by setting
>>> vbasedev->mdev true so skipping HostIOMMUDevice initialization in the
>>> presence of mdevs.
>>
>> Hmm, picking the two commits that Cedric mentioned in his cover-letter reply [1] doesn't "fail the entire provisioning of the guest" for me.
>>
>> Applying this patch on top of that causes the call from vfio_attach_device() to hiod_legacy_vfio_realize() to be skipped, which seems odd. What am I missing?
>>
>> [1] https://lore.kernel.org/qemu-devel/4c9a184b-514c-4276-95ca-9ed86623b9a4@redhat.com/
>>
> 
> If you are using IOMMUFD it will fail the entire provisioning i.e. GET_HW_INFO
> fails because there's no actual device/IOMMU you can probe hardware information
> from and you can't start a guest. This happened at least for me in x86 vfio-pci
> mdevs (or at least I reproduced it when trying to test mdev_tty)
> 
> But if you don't support IOMMUFD, then it probably makes no difference as type1
> doesn't do anything particularly special besides initializing some static data.
> The realize is skipped because you technically don't have a physical host IOMMU
> directly behind the mdev, but rather some parent function related software
> entity doing that for you.
> 
> Zhengzhong noticed there were some other mdevs aside from vfio-pci and in an
> attempt to prevent regression elsewhere it posted for the other mdevs in qemu.


yes. I confirm with :

   -device vfio-ap,id=hostdev0,sysfsdev=/sys/bus/mdev/devices/8eb8351a-e656-4187-b773-fea4e926310d,iommufd=iommufd0 \
   -object iommufd,id=iommufd0 \
   -trace 'iommufd*'

iommufd_cdev_getfd  /dev/vfio/devices/vfio4 (fd=28)
iommufd_backend_connect fd=27 owned=1 users=1
iommufd_cdev_connect_and_bind  [iommufd=27] Successfully bound device 8eb8351a-e656-4187-b773-fea4e926310d (fd=28): output devid=1
iommufd_backend_alloc_ioas  iommufd=27 ioas=2
iommufd_cdev_alloc_ioas  [iommufd=27] new IOMMUFD container with ioasid=2
iommufd_cdev_attach_ioas_hwpt  [iommufd=27] Successfully attached device 8eb8351a-e656-4187-b773-fea4e926310d (28) to id=2
iommufd_backend_map_dma  iommufd=27 ioas=2 iova=0x0 size=0x200000000 addr=0x3fd9ff00000 readonly=0 (0)
iommufd_cdev_device_info  8eb8351a-e656-4187-b773-fea4e926310d (28) num_irqs=1 num_regions=0 flags=33
iommufd_cdev_detach_ioas_hwpt  [iommufd=27] Successfully detached 8eb8351a-e656-4187-b773-fea4e926310d
iommufd_backend_unmap_dma  iommufd=27 ioas=2 iova=0x0 size=0x200000000 (0)
iommufd_backend_free_id  iommufd=27 id=2 (0)
iommufd_backend_disconnect fd=-1 users=0

qemu-kvm: -device vfio-ap,id=hostdev0,sysfsdev=/sys/bus/mdev/devices/8eb8351a-e656-4187-b773-fea4e926310d,iommufd=iommufd0: vfio 8eb8351a-e656-4187-b773-fea4e926310d: Failed to get hardware info: No such file or directory



Thanks,

C.



