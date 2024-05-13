Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FA6C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 16:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Yra-00005S-8M; Mon, 13 May 2024 12:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6YrY-000059-2c
 for qemu-devel@nongnu.org; Mon, 13 May 2024 12:49:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6YrV-000557-H3
 for qemu-devel@nongnu.org; Mon, 13 May 2024 12:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715618955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H55F8HJDNVbBuB9/0CqqTwTRtr0GA+2LmU13rIsgKng=;
 b=KwgQt7OCpDA923ZuXC6N3+P8e8SZanXTLRM/PyKX+smhfHAmZApxA+E8YQYehKNIqAV70v
 RvdMCNnvIGL0NtT4EdjloOEBCZUm+7S/jp03MF6mHI7Ev+cSbpAVPFeCS23w0e49ctR8PY
 7EnY0IyVoSqhXpABTQZcauC7FlkULnM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563--U0iFqveN9GHqA1W9ZjoQA-1; Mon, 13 May 2024 12:49:14 -0400
X-MC-Unique: -U0iFqveN9GHqA1W9ZjoQA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6a137f8fc62so60437126d6.0
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 09:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715618953; x=1716223753;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H55F8HJDNVbBuB9/0CqqTwTRtr0GA+2LmU13rIsgKng=;
 b=CzJy/PCTg14fGj7fvSHPWgs+lJr8d9gArrS2os1OVNxQ231YrRyoSN4fTNj/k3vZaO
 7ShNx+53dxtsLKDTfr9hX5krA2iY6zoN4O1m4dbJCqPe39T5KZ4qur4SWIY18VN8dQYt
 FeMIwQyyVJivCYfzlkBRVv6neOXezNOYJbPh6UUgsR+qjRZVrlK8gjRLeEzClNKpGnsF
 a6vFgc9izmNmQUnfkVomrVF5+KtdCGopynAOE9X47lgG1zA+dvtATJse4Aj8cZ5ER2hD
 2i0aeW5zolcIQMwwEr3g359cZnov8luO1t1qXVGNPGCv5k3kvv7rxyRKthT1WYNUOHBA
 +eKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX30Kd0pGVZB+2EQajh4q1/C7hyL03rPjXx3zL0Xlj/Otr62O0SZLOqWKr+JIXPKDpgznz+/nyWVIDwUdQPXTOoQZTjqrI=
X-Gm-Message-State: AOJu0YyVlaE3sZvrcQl0cdvRQHdftcE1Ir2FyU87im+S5pW1gX/zHY/6
 CyB1F0O/xZUvO7uJJlj4QUSpOky4TPgWX3rQKXFUN73oS4TL2eiXMUFmL3OKPsAjmEtlXTXhZM3
 eq8db7IFHo1Td+3Oivy1xis9sl4GxYD+cpKEkau1UpYHJhfl8hMp6
X-Received: by 2002:a05:6214:3386:b0:6a3:3ad5:64d8 with SMTP id
 6a1803df08f44-6a33ad56519mr32029716d6.29.1715618953433; 
 Mon, 13 May 2024 09:49:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxmjkecu38vn+g6VjAM4LW3+T4nRN0WDE2e5/iSdkXhnS62VOETOplSl/hMzVUJpYA1BmUZg==
X-Received: by 2002:a05:6214:3386:b0:6a3:3ad5:64d8 with SMTP id
 6a1803df08f44-6a33ad56519mr32029546d6.29.1715618953068; 
 Mon, 13 May 2024 09:49:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f206f2esm44499336d6.145.2024.05.13.09.49.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 09:49:12 -0700 (PDT)
Message-ID: <d740fe83-a66f-4e3a-9910-32b71366aa6a@redhat.com>
Date: Mon, 13 May 2024 18:49:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/10] vfio: Add Error** argument to
 vfio_devices_dma_logging_start()
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240506092053.388578-1-clg@redhat.com>
 <20240506092053.388578-3-clg@redhat.com>
 <21449e77-5403-4d7a-af29-fedcab9a4385@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <21449e77-5403-4d7a-af29-fedcab9a4385@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 5/13/24 15:08, Avihai Horon wrote:
> 
> On 06/05/2024 12:20, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> This allows to update the Error argument of the VFIO log_global_start()
>> handler. Errors detected when device level logging is started will be
>> propagated up to qemu_savevm_state_setup() when the ram save_setup()
>> handler is executed.
> 
> Errors for container based logging will also be propagated now.
> 
>>
>> The vfio_set_migration_error() call becomes redundant in
>> vfio_devices_dma_logging_start(). Remove it.
> 
> Becomes redundant in vfio_listener_log_global_start()?


Both sentences updated.


> Other than that,
> Reviewed-by: Avihai Horon <avihaih@nvidia.com>



Thanks,

C.


>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>
>>   Changes in v5:
>>
>>   - Used error_setg_errno() in vfio_devices_dma_logging_start()
>>
>>   hw/vfio/common.c | 26 +++++++++++++++-----------
>>   1 file changed, 15 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 485e53916491f1164d29e739fb7106c0c77df737..b5102f54a6474a50c6366e8fbce23812d55e384e 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1027,7 +1027,8 @@ static void vfio_device_feature_dma_logging_start_destroy(
>>       g_free(feature);
>>   }
>>
>> -static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer)
>> +static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
>> +                                          Error **errp)
>>   {
>>       struct vfio_device_feature *feature;
>>       VFIODirtyRanges ranges;
>> @@ -1038,6 +1039,7 @@ static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer)
>>       feature = vfio_device_feature_dma_logging_start_create(bcontainer,
>>                                                              &ranges);
>>       if (!feature) {
>> +        error_setg_errno(errp, errno, "Failed to prepare DMA logging");
>>           return -errno;
>>       }
>>
>> @@ -1049,8 +1051,8 @@ static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer)
>>           ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
>>           if (ret) {
>>               ret = -errno;
>> -            error_report("%s: Failed to start DMA logging, err %d (%s)",
>> -                         vbasedev->name, ret, strerror(errno));
>> +            error_setg_errno(errp, errno, "%s: Failed to start DMA logging",
>> +                             vbasedev->name);
>>               goto out;
>>           }
>>           vbasedev->dirty_tracking = true;
>> @@ -1069,20 +1071,19 @@ out:
>>   static bool vfio_listener_log_global_start(MemoryListener *listener,
>>                                              Error **errp)
>>   {
>> +    ERRP_GUARD();
>>       VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
>>                                                    listener);
>>       int ret;
>>
>>       if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>> -        ret = vfio_devices_dma_logging_start(bcontainer);
>> +        ret = vfio_devices_dma_logging_start(bcontainer, errp);
>>       } else {
>> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, true, NULL);
>> +        ret = vfio_container_set_dirty_page_tracking(bcontainer, true, errp);
>>       }
>>
>>       if (ret) {
>> -        error_report("vfio: Could not start dirty page tracking, err: %d (%s)",
>> -                     ret, strerror(-ret));
>> -        vfio_set_migration_error(ret);
>> +        error_prepend(errp, "vfio: Could not start dirty page tracking - ");
>>       }
>>       return !ret;
>>   }
>> @@ -1091,17 +1092,20 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
>>   {
>>       VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
>>                                                    listener);
>> +    Error *local_err = NULL;
>>       int ret = 0;
>>
>>       if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>>           vfio_devices_dma_logging_stop(bcontainer);
>>       } else {
>> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, false, NULL);
>> +        ret = vfio_container_set_dirty_page_tracking(bcontainer, false,
>> +                                                     &local_err);
>>       }
>>
>>       if (ret) {
>> -        error_report("vfio: Could not stop dirty page tracking, err: %d (%s)",
>> -                     ret, strerror(-ret));
>> +        error_prepend(&local_err,
>> +                      "vfio: Could not stop dirty page tracking - ");
>> +        error_report_err(local_err);
>>           vfio_set_migration_error(ret);
>>       }
>>   }
>> -- 
>> 2.45.0
>>
> 


