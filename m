Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337BEC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 17:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnL78-0002nh-Hi; Wed, 26 Feb 2025 12:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnL6x-0002mw-QW
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 12:22:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnL6v-0008CE-5U
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 12:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740590532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=M1gVM2YlnkNkQpQ194uhZ4L9/2DH9GVDpBOunLVaHtQ=;
 b=WTrq4e589G1xLqwuno7I7JKKMIf6a9o8NdjJrMtbJbmj5Bsu7B1vzPQm0GzjG07X1FdG1g
 pItxiyBTKp9gHUkGqjVOiDhFF0ujpyAIPcBFcpUQmv45UsbLLXjBxaHu8/X9RBbLortkMf
 oh+bfDSQPhjDllf6rqZ/fZPtm05pFWk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-HhMOjMYsMZ6FmYNajbj_nQ-1; Wed, 26 Feb 2025 12:22:10 -0500
X-MC-Unique: HhMOjMYsMZ6FmYNajbj_nQ-1
X-Mimecast-MFC-AGG-ID: HhMOjMYsMZ6FmYNajbj_nQ_1740590529
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38f29b4d4adso2870683f8f.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 09:22:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740590529; x=1741195329;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M1gVM2YlnkNkQpQ194uhZ4L9/2DH9GVDpBOunLVaHtQ=;
 b=H9ml9VqNCVgP6coAL+rYAYGG1gDgmwnlR96oX3MBDYTt13dRIsQggizlCZFEo6GrbW
 M+fIcTP26UYHLA/dw2KGm3TEIyNbp9fdzCgejXC7pmSlwTPVhaZx3m6R5DQK4zW7vXvq
 of52lDCJ/ktccYrBAwsLSbM99bDwiZ0k1q+HBlle5h5bCwcLcFRPt1ml5k69cCpH7HVn
 xhS95Pw4ixUDXZPPtqZBMe6O3QSAvvzlwletoh+RpfKTTVp9BypXTHnMdI+3Mlf6DQXZ
 geD/aw/CgDrV94jdWQBGrvWce34n6PargzOEHjAxBlmOlOEv3FZQaj/KqXSDGewJ/u94
 2ufg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXxP1KA6vs4BSOP71GWm3PmzcYrsSYQ0wL/xLxMykvOpnAtuKCVhfMETked5LmwzXR8trbClq4/8tV@nongnu.org
X-Gm-Message-State: AOJu0YxXz4u50tChTuxSKRidyPT4iMe1OqaF7AyhqhVHJ3hVU0MfYKMn
 xSMSy6wnhcD0HoiwS9axYfujq+llzf/HoCnJN0myzi6JIf+Hp4IScBcnHCw49yQuGJTkq2jCHzP
 3KUK7TYQYrZEV93qVvJ+N1DyS1JqSWPSNX8PR0+7eTcGn2QhZPxHo
X-Gm-Gg: ASbGnctM2YNEJ8wIOsSkI4MkkIysgVJvQulobXTR5b6YiYMTmSPPwqJ3cMUOJXkBC3B
 ewB+yzhvCuJDOB9kqtKSKGP3M1yTdOtq7C79AL3sHNVN/mnpHpmJFEnLtWzBG1sNze1ETnPAGli
 hV08zmLkIiB/uC24BiBhv8J3GBeMF62oo/V6aawduaqnsg19ujlnvLTo0wt4+OL6MFqJbvdx3pn
 K5DFrergVhQZRarod6eIy4pDCO4iawuvIDb2bSCX1fo4NHkVjmLYPuKblCKerMVf7223LlvRWyX
 0PpzUpKARKazHqBB0T34rs0zfUppudVKmZCyd3EFT4k79dQbcE1M7cAnHTs=
X-Received: by 2002:a5d:584f:0:b0:38f:1e87:cc6e with SMTP id
 ffacd0b85a97d-38f6e74f270mr18986173f8f.9.1740590528950; 
 Wed, 26 Feb 2025 09:22:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHswm7p8BhUZHfnh52ovAmP1smwAdDwM3AdVRJIjFmLKkukDM7fo7l+iJh9XcQqEz4HWlpafQ==
X-Received: by 2002:a5d:584f:0:b0:38f:1e87:cc6e with SMTP id
 ffacd0b85a97d-38f6e74f270mr18986142f8f.9.1740590528560; 
 Wed, 26 Feb 2025 09:22:08 -0800 (PST)
Received: from ?IPV6:2a01:cb19:9004:d500:a732:5611:7f59:8bb3?
 ([2a01:cb19:9004:d500:a732:5611:7f59:8bb3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd86c9ccsm6260432f8f.21.2025.02.26.09.22.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 09:22:07 -0800 (PST)
Message-ID: <a3217a10-4f86-431c-a934-06f1b5ff7d11@redhat.com>
Date: Wed, 26 Feb 2025 18:22:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 25/36] vfio/migration: Multifd device state transfer
 support - receive init/cleanup
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <b555ee5b753efbf2f7152f0692858802fc1bcb80.1739994627.git.maciej.szmigiero@oracle.com>
 <c164a0bd-6168-4d62-8876-ea770ff67fcf@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <c164a0bd-6168-4d62-8876-ea770ff67fcf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/26/25 11:14, Cédric Le Goater wrote:
> On 2/19/25 21:34, Maciej S. Szmigiero wrote:
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> Add support for VFIOMultifd data structure that will contain most of the
>> receive-side data together with its init/cleanup methods.
>>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> ---
>>   hw/vfio/migration-multifd.c   | 33 +++++++++++++++++++++++++++++++++
>>   hw/vfio/migration-multifd.h   |  8 ++++++++
>>   hw/vfio/migration.c           | 29 +++++++++++++++++++++++++++--
>>   include/hw/vfio/vfio-common.h |  3 +++
>>   4 files changed, 71 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
>> index 7328ad8e925c..c2defc0efef0 100644
>> --- a/hw/vfio/migration-multifd.c
>> +++ b/hw/vfio/migration-multifd.c
>> @@ -41,6 +41,9 @@ typedef struct VFIOStateBuffer {
>>       size_t len;
>>   } VFIOStateBuffer;
>> +typedef struct VFIOMultifd {
>> +} VFIOMultifd;
>> +
>>   static void vfio_state_buffer_clear(gpointer data)
>>   {
>>       VFIOStateBuffer *lb = data;
>> @@ -84,8 +87,38 @@ static VFIOStateBuffer *vfio_state_buffers_at(VFIOStateBuffers *bufs, guint idx)
>>       return &g_array_index(bufs->array, VFIOStateBuffer, idx);
>>   }
>> +VFIOMultifd *vfio_multifd_new(void)
>> +{
>> +    VFIOMultifd *multifd = g_new(VFIOMultifd, 1);
>> +
>> +    return multifd;
>> +}
>> +
>> +void vfio_multifd_free(VFIOMultifd *multifd)
>> +{
>> +    g_free(multifd);
>> +}
>> +
>>   bool vfio_multifd_transfer_supported(void)
>>   {
>>       return multifd_device_state_supported() &&
>>           migrate_send_switchover_start();
>>   }
>> +
>> +bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev)
>> +{
>> +    return false;
>> +}
>> +
>> +bool vfio_multifd_transfer_setup(VFIODevice *vbasedev, Error **errp)
>> +{
>> +    if (vfio_multifd_transfer_enabled(vbasedev) &&
>> +        !vfio_multifd_transfer_supported()) {
>> +        error_setg(errp,
>> +                   "%s: Multifd device transfer requested but unsupported in the current config",
>> +                   vbasedev->name);
>> +        return false;
>> +    }


now that I have reached patch 31 I understand better. I would put the
check above in patch 31 and simply return true for now.

Thanks,

C.


>> +    return true;
>> +}
>> diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
>> index 8fe004c1da81..1eefba3b2eed 100644
>> --- a/hw/vfio/migration-multifd.h
>> +++ b/hw/vfio/migration-multifd.h
>> @@ -12,6 +12,14 @@
>>   #include "hw/vfio/vfio-common.h"
>> +typedef struct VFIOMultifd VFIOMultifd;
>> +
>> +VFIOMultifd *vfio_multifd_new(void);
>> +void vfio_multifd_free(VFIOMultifd *multifd);
>> +
>>   bool vfio_multifd_transfer_supported(void);
>> +bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev);
>> +
>> +bool vfio_multifd_transfer_setup(VFIODevice *vbasedev, Error **errp);
>>   #endif
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 7b79be6ad293..4311de763885 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -674,15 +674,40 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
>>   static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
>>   {
>>       VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    int ret;
>> +
>> +    if (!vfio_multifd_transfer_setup(vbasedev, errp)) {
>> +        return -EINVAL;
>> +    }
> 
> This check on the consistency of the settings confused me a little. Even if
> simple, I would have put it in a separate patch for better understanding.
> The rest looks good.
> 
> 
> Thanks,
> 
> C.
> 
> 
> 
>> +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
>> +                                   migration->device_state, errp);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> -    return vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
>> -                                    vbasedev->migration->device_state, errp);
>> +    if (vfio_multifd_transfer_enabled(vbasedev)) {
>> +        assert(!migration->multifd);
>> +        migration->multifd = vfio_multifd_new();
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static void vfio_multifd_cleanup(VFIODevice *vbasedev)
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +
>> +    g_clear_pointer(&migration->multifd, vfio_multifd_free);
>>   }
>>   static int vfio_load_cleanup(void *opaque)
>>   {
>>       VFIODevice *vbasedev = opaque;
>> +    vfio_multifd_cleanup(vbasedev);
>> +
>>       vfio_migration_cleanup(vbasedev);
>>       trace_vfio_load_cleanup(vbasedev->name);
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 64ee3b1a2547..ab110198bd6b 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -78,6 +78,8 @@ typedef struct VFIORegion {
>>       uint8_t nr; /* cache the region number for debug */
>>   } VFIORegion;
>> +typedef struct VFIOMultifd VFIOMultifd;
>> +
>>   typedef struct VFIOMigration {
>>       struct VFIODevice *vbasedev;
>>       VMChangeStateEntry *vm_state;
>> @@ -89,6 +91,7 @@ typedef struct VFIOMigration {
>>       uint64_t mig_flags;
>>       uint64_t precopy_init_size;
>>       uint64_t precopy_dirty_size;
>> +    VFIOMultifd *multifd;
>>       bool initial_data_sent;
>>       bool event_save_iterate_started;
>>
> 


