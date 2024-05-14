Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9A6C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 14:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6tFm-00016J-0n; Tue, 14 May 2024 10:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6tFk-00015v-JF
 for qemu-devel@nongnu.org; Tue, 14 May 2024 10:35:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6tFh-0003IX-Ga
 for qemu-devel@nongnu.org; Tue, 14 May 2024 10:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715697336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8bULT45aZSr/KkQ2bLnKSVVpO03bkmZP3x1KKEQgVmY=;
 b=aN5BCK4RZJdaB4sPh64Z3pJuor9VBxXUDwNAFQVVaXJ5MBjawmQ3L1YRVsKa7QYxYvXyLJ
 c64odIxYooEpkNuUrxf66UDeXE9/gk4qzfNN51Z6lvPse4TUgjlBdyz9wLCL9T+cU0AhFO
 o3HO72i0FNISj2CeJ0F9JNhyNvgxP4g=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-T1kEfHs1MwevsKiStEdyfw-1; Tue, 14 May 2024 10:35:30 -0400
X-MC-Unique: T1kEfHs1MwevsKiStEdyfw-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-43e1af4fbc4so24919401cf.3
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 07:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715697330; x=1716302130;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8bULT45aZSr/KkQ2bLnKSVVpO03bkmZP3x1KKEQgVmY=;
 b=kTmdh7QkNKyEkHp4Z2Jh8/wAldE3R0fcr9BugxnTeC0s02dMZt3xa3mEfgiDyF5SOu
 HWfeHMvuBw8u8kFk8Ap1XlLKt2aTREw60lm3iG8akFHiPHSPbXrJZOJh9BqfzOhGZwOP
 yWBSO8EL0jm/vth1sNRgJgU9T39ygZYXcHGYYAudwdk+ZfRA47likPwOVB42zEyR/nYu
 dQJfog+ifAwSCrjFR7YKemKDTF5V8+wX/guMA2BkycGvcs4E+IiHdKveb5JP2SfwmiVO
 9occn59aUyf7mPV7/p76pH6Xrv3YZ53OU7TnnQaC07/+ChORUWgQ45l3mHvuZWr9ZNly
 2N/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJjUQPgZTlLHXUCt0vxGlPT0UHUDxV10/vgnrhfXI5Kbzc4pGHRC4sL1LKs9OVOoe9lMCamWs7829At3bpIATz7iso8qM=
X-Gm-Message-State: AOJu0YwhAJpUpi9K1WfHcgIpBYkx0Wklz9E/u9bicdKMhAq49dqsRzek
 PX9qEBsHcoclDV8uYfTQuANBjtpClNsT6D/7ZNYfxkkCCiIPi7Q4YL6IQbYG3KFKzaJO/s8Fc+t
 oM8V5nExrhEma+Lj1DekMWbhps2wz7t8JsfP7BtT6+7SNzQCsygyX
X-Received: by 2002:ac8:5a49:0:b0:43a:d5b4:e169 with SMTP id
 d75a77b69052e-43dfdd0dc46mr152975981cf.61.1715697329724; 
 Tue, 14 May 2024 07:35:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2dt9DuY8qBKVDHuerjcKRrpMJNphfceh5HEXxFiBe6PD8KMNWZFGNci2ye0UDmW4qLo4j/g==
X-Received: by 2002:ac8:5a49:0:b0:43a:d5b4:e169 with SMTP id
 d75a77b69052e-43dfdd0dc46mr152975791cf.61.1715697329382; 
 Tue, 14 May 2024 07:35:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43df54dda3dsm69148201cf.29.2024.05.14.07.35.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 07:35:28 -0700 (PDT)
Message-ID: <28bc9d97-b937-469e-9b04-0487cf1ba1bf@redhat.com>
Date: Tue, 14 May 2024 16:35:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/10] vfio: Extend vfio_set_migration_error() with
 Error* argument
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240506092053.388578-1-clg@redhat.com>
 <20240506092053.388578-11-clg@redhat.com>
 <c06e8de4-a3ad-4044-a4ca-f45d404314fb@nvidia.com>
 <d7122cae-8e84-4ea3-987b-107f44bee937@redhat.com>
Content-Language: en-US, fr
In-Reply-To: <d7122cae-8e84-4ea3-987b-107f44bee937@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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

On 5/14/24 13:20, Cédric Le Goater wrote:
> On 5/13/24 16:26, Avihai Horon wrote:
>>
>> On 06/05/2024 12:20, Cédric Le Goater wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> vfio_set_migration_error() sets the 'return' error on the migration
>>> stream if a migration is in progress. To improve error reporting, add
>>> a new Error* argument to also set the Error object on the migration
>>> stream, if a migration is progress.
>>>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>
>>>   Changes in v5:
>>>
>>>   - Rebased on 20c64c8a51a4 ("migration: migration_file_set_error")
>>>
>>>   hw/vfio/common.c | 37 ++++++++++++++++++-------------------
>>>   1 file changed, 18 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index c3d82a9d6e434e33f361e4b96157bf912d5c3a2f..4cf3e13a8439bd1b9a032e9d4e75df676eba457b 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -147,10 +147,10 @@ bool vfio_viommu_preset(VFIODevice *vbasedev)
>>>       return vbasedev->bcontainer->space->as != &address_space_memory;
>>>   }
>>>
>>> -static void vfio_set_migration_error(int err)
>>> +static void vfio_set_migration_error(int ret, Error *err)
>>>   {
>>>       if (migration_is_setup_or_active()) {
>>> -        migration_file_set_error(err, NULL);
>>> +        migration_file_set_error(ret, err);
>>>       }
>>>   }
>>>
>>> @@ -295,9 +295,10 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>>                                   iova, iova + iotlb->addr_mask);
>>>
>>>       if (iotlb->target_as != &address_space_memory) {
>>> -        error_report("Wrong target AS \"%s\", only system memory is allowed",
>>> -                     iotlb->target_as->name ? iotlb->target_as->name : "none");
>>> -        vfio_set_migration_error(-EINVAL);
>>> +        error_setg(&local_err,
>>> +                   "Wrong target AS \"%s\", only system memory is allowed",
>>> +                   iotlb->target_as->name ? iotlb->target_as->name : "none");
>>> +        vfio_set_migration_error(-EINVAL, local_err);
>>>           return;
>>>       }
>>>
>>> @@ -330,11 +331,12 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>>           ret = vfio_container_dma_unmap(bcontainer, iova,
>>>                                          iotlb->addr_mask + 1, iotlb);
>>>           if (ret) {
>>> -            error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>>> -                         "0x%"HWADDR_PRIx") = %d (%s)",
>>> -                         bcontainer, iova,
>>> -                         iotlb->addr_mask + 1, ret, strerror(-ret));
>>> -            vfio_set_migration_error(ret);
>>> +            error_setg(&local_err,
>>> +                       "vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>>> +                       "0x%"HWADDR_PRIx") = %d (%s)",
>>> +                       bcontainer, iova,
>>> +                       iotlb->addr_mask + 1, ret, strerror(-ret));
>>
>> Use error_setg_errno()?
> 
> sure.
> 
>>
>>> +            vfio_set_migration_error(ret, local_err);
>>
>> Now dma unmap errors (and also the error before it) are not reported if they happen not during migration.
>>
>> This makes me think, maybe vfio_set_migration_error() is redundant and can be replaced by migration_file_set_error()?
> 
> 
> yes. Good suggestion. I would like to get rid of vfio_set_migration_error(),
> so that's a good start.

After taking a closer look, I will drop this patch from v6 because
it needs further splitting and some rework.

Thanks,

C.




