Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1352C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 13:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riDbO-0002g2-Pe; Thu, 07 Mar 2024 08:16:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1riDbN-0002fc-6G
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:16:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1riDbL-0003XI-AB
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:16:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709817357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZVrk87CG78JQ/FWBiw43JCq6YKgNfgUS+FFfsChSBWs=;
 b=Jlp8sXsgM9efmRwMiIVzUu9Ae8nEBOpcWiEgB5yP8mTRJI/KjuNimVvFDEdelajn7iLRaR
 vTISDKBkO13AJYLRNv2Pgq0TNmMvxQMcCGRW4VcNG4dPaN6D4WZnsVfbImSaAc7wgcHwbS
 9MtQ+rWsGrecR7HcGiH5Vz+z+LgS1lY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-fEURXpfRN2GPesoHgQi0Yw-1; Thu, 07 Mar 2024 08:15:56 -0500
X-MC-Unique: fEURXpfRN2GPesoHgQi0Yw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-69082c5877dso36312626d6.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 05:15:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709817355; x=1710422155;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZVrk87CG78JQ/FWBiw43JCq6YKgNfgUS+FFfsChSBWs=;
 b=FdKQi/9LTtJGgebOHS6xU86qR42ipCfmo1cJGOZfoH28oBhfEXVHhmKTiDfMtEMxpn
 WFXOl6MDK2XxUN3Go3At4OjAXdSOa/qOmNfg/QwvUQgPHegrIVrthkjHzif4F/2EE6bL
 sBm5BQjw7AVtNDaFH23ES7NpXAPQGRM1aubDSaPxh7UOpUI+PQsL/QpFK8U8WMgludyz
 WBqTBAq/qrApKFreTrpZ1g8YjQyTexSitanwCYPq+kvY+RKZrXBlZECmN5NFsPsuuU1L
 zpaHipsElfKGnNxS3cbxXIZ3S4LFuLG8E8ZTYuDRmv36jeRhAktgl4mFB9PZ2CBj6Ly+
 zL1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhC/+Z59oUVLBSxlryonqwMDHqqz1M3/7/PD/iq2Q0h8J3/sJKipwYb9XCOLfIrsyXoPLMbGFmvaRt14udv3J4NvrrfOY=
X-Gm-Message-State: AOJu0YyBfhnwFdGu3FLvMWsvhxe2PhU/E07QEaa3m8iz4pG73wUakOiN
 P0K8Av7QjeHCNkAwU9z+rLidfy/PzjF2kjzrBsdF/u2OU9Tl3Z0qN9tvWmF+CktNfmNELE74rwE
 0LD0Ts/pQR5dppYhalB7sL+ECHZYRXIsUI2OI7lxJEeY83ot4iWmz
X-Received: by 2002:a05:622a:1651:b0:42f:1145:71f6 with SMTP id
 y17-20020a05622a165100b0042f114571f6mr2091405qtj.13.1709817355710; 
 Thu, 07 Mar 2024 05:15:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEinJCwsfFDXG5hx10cJT3VG9HhKZaeUUTrlGHpuxFyzj1j2r1SWkAIZH3w2OfI7g4RjdeTqw==
X-Received: by 2002:a05:622a:1651:b0:42f:1145:71f6 with SMTP id
 y17-20020a05622a165100b0042f114571f6mr2091373qtj.13.1709817355391; 
 Thu, 07 Mar 2024 05:15:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 h24-20020ac85058000000b0042ee02f7b92sm5175681qtm.89.2024.03.07.05.15.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 05:15:54 -0800 (PST)
Message-ID: <671ae175-48c0-4cb9-b4e2-7c935c2d6ae0@redhat.com>
Date: Thu, 7 Mar 2024 14:15:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/25] vfio: Add Error** argument to
 vfio_devices_dma_logging_start()
Content-Language: en-US, fr
To: Eric Auger <eauger@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-18-clg@redhat.com>
 <43a4b87e-cfa6-4d5d-884f-e4307d9b5fc5@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <43a4b87e-cfa6-4d5d-884f-e4307d9b5fc5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/7/24 09:15, Eric Auger wrote:
> Hi Cédric,
> 
> On 3/6/24 14:34, Cédric Le Goater wrote:
>> This allows to update the Error argument of the VFIO log_global_start()
>> handler. Errors detected when device level logging is started will be
>> propagated up to qemu_savevm_state_setup() when the ram save_setup()
>> handler is executed.
>>
>> The vfio_set_migration_error() call becomes redundant. Remove it.
> you may precise it becomes redundant in vfio_listener_log_global_start()
> because it is kept in vfio_listener_log_global_stop

Yes. This is a leftover from v3 which still had the changes for
the .log_global_stop() handlers.


>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>
>>   Changes in v4:
>>
>>   - Dropped log_global_stop() and log_global_sync() changes
>>     
>>   Changes in v3:
>>
>>   - Use error_setg_errno() in vfio_devices_dma_logging_start()
>>   - ERRP_GUARD() because of error_prepend use in
>>     vfio_listener_log_global_start()
>>     
>>   hw/vfio/common.c | 25 ++++++++++++++-----------
>>   1 file changed, 14 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 5598a508399a6c0b3a20ba17311cbe83d84250c5..d6790557da2f2890398fa03dbbef18129cd2c1bb 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1036,7 +1036,8 @@ static void vfio_device_feature_dma_logging_start_destroy(
>>       g_free(feature);
>>   }
>>   
>> -static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer)
>> +static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
>> +                                          Error **errp)
>>   {
>>       struct vfio_device_feature *feature;
>>       VFIODirtyRanges ranges;
>> @@ -1058,8 +1059,8 @@ static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer)
>>           ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
>>           if (ret) {
>>               ret = -errno;
> there is another case of error if !feature. Don't we want t o set errp
> in that case as well?

arf. How did I miss that ... Will fix.

> I think in general we should try to make the return value and the errp
> consistent because the caller may try to exploit the errp in case or
> negative returned value.

yes. That's the goal.

Thanks,

C.


>> -            error_report("%s: Failed to start DMA logging, err %d (%s)",
>> -                         vbasedev->name, ret, strerror(errno));
>> +            error_setg_errno(errp, errno, "%s: Failed to start DMA logging",
>> +                             vbasedev->name);
>>               goto out;
>>           }
>>           vbasedev->dirty_tracking = true;
>> @@ -1078,20 +1079,19 @@ out:
>>   static bool vfio_listener_log_global_start(MemoryListener *listener,
>>                                              Error **errp)
>>   {
>> +    ERRP_GUARD(); /* error_prepend use */
>>       VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
>>                                                    listener);
>>       int ret;
>>   
>>       if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>> -        ret = vfio_devices_dma_logging_start(bcontainer);
>> +        ret = vfio_devices_dma_logging_start(bcontainer, errp);
>>       } else {
>> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, true, NULL);
>> +        ret = vfio_container_set_dirty_page_tracking(bcontainer, true, errp);
>>       }
>>   
>>       if (ret) {
>> -        error_report("vfio: Could not start dirty page tracking, err: %d (%s)",
>> -                     ret, strerror(-ret));
>> -        vfio_set_migration_error(ret);
>> +        error_prepend(errp, "vfio: Could not start dirty page tracking - ");
>>       }
>>       return !ret;
>>   }
>> @@ -1100,17 +1100,20 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
>>   {
>>       VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
>>                                                    listener);
>> +    Error *local_err = NULL;
>>       int ret = 0;
>>   
>>       if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>>           vfio_devices_dma_logging_stop(bcontainer);
>>       } else {
>> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, false, NULL);
>> +        ret = vfio_container_set_dirty_page_tracking(bcontainer, false,
>> +                                                     &local_err);
>>       }
>>   
>>       if (ret) {
>> -        error_report("vfio: Could not stop dirty page tracking, err: %d (%s)",
>> -                     ret, strerror(-ret));
>> +        error_prepend(&local_err,
>> +                      "vfio: Could not stop dirty page tracking - ");
>> +        error_report_err(local_err);
>>           vfio_set_migration_error(ret);
>>       }
>>   }
> Eric
> 


