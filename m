Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B64C25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 17:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7I8h-0000Ij-GS; Wed, 15 May 2024 13:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7I8f-0000Ha-Ee
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:10:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7I8d-0001jZ-JI
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715792998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NLyTHJ25uWTtkkGXFY/I0xFLlX9MpkofnHBgyQ8eBNU=;
 b=ARvWSoo6+4v4og4mmhoCna2R700l7ve0l+LThp6+JFwj7r4ATApUEeVYDWo/2tiFOSnfEO
 V2TzwKpjJ/6JymsF2sL5PLUxNt/2HgiwihAdEvLkKOteC161jfJBwBGixEOLCullkzy1aL
 vlpP8s1tPteyWGxLlQWh6b5laZ15kEA=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-nj0sTXqQNnu8PFeYYq8RmA-1; Wed, 15 May 2024 13:09:57 -0400
X-MC-Unique: nj0sTXqQNnu8PFeYYq8RmA-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5aa350b43ecso9919898eaf.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 10:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715792996; x=1716397796;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NLyTHJ25uWTtkkGXFY/I0xFLlX9MpkofnHBgyQ8eBNU=;
 b=IE2FwxgNevLND6jOOtixTfOxC4VGprrvWEy/SCKO7bJpXxoHc1M5aiMpul1NEhLZ2t
 EbrsB1Xm1KxcaSWtFeqFkJIp1btG0udl2C9KD2IN5X/c4gpEmCnb18z++Dvm7GjhGv5y
 izx9jJhrBrNwPUjXTbd0xipB9NTZqSStssqweC0+ubjLTLwgEl89qOCZbkrtRinUdfKs
 Sj8bysRRCTpRhsvXDGz+enBOJVqAe5IDNsR1RXo9Su17FDQNA/Fl/iY/0Skdmvr7H7vo
 UVso4nqvcDjKXh1FeKtz3wOSUH+auJ+NEQyqN3tSkJkrbF3RBpN0OUjmQiz36/4fYhTB
 n1xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc6AD+u75EBTDdtDyIc8XAf2hUqIfYgt/VwTv9UqdDrOTVZFDxm1P9GnLtU92WHgcUCHioH/9u8Puhc5OrznW+CyFiVO8=
X-Gm-Message-State: AOJu0YxP5BQc11OKysW5YHmp9EPP9eaPfWcVTfGpD/HPQHUf3GWTsY+R
 StsZ0Mw/9nP2bo6CjbFxrplYWirvz5xXDaoPLmOB+sNDBqudfIheZvHIROS+02UWvPkCkt7KaSl
 EeQsa9ukKk9ozHSCKJVegSdxgdZJ/37NiLqbggsL9E7lGUqzSKyAu
X-Received: by 2002:a05:6870:7b51:b0:239:6841:dabc with SMTP id
 586e51a60fabf-24172f76af4mr19120273fac.48.1715792996549; 
 Wed, 15 May 2024 10:09:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpGliT98BRUMsTq7qjqbBS7h4Omu+oFVOiJ9oyuJS2rnN7V3n+6Hrxf+x3T40wvUAv2nAppw==
X-Received: by 2002:a05:6870:7b51:b0:239:6841:dabc with SMTP id
 586e51a60fabf-24172f76af4mr19120233fac.48.1715792996187; 
 Wed, 15 May 2024 10:09:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf34060csm695233985a.134.2024.05.15.10.09.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 10:09:55 -0700 (PDT)
Message-ID: <ccec0165-d09e-4642-a738-156262ed7f0b@redhat.com>
Date: Wed, 15 May 2024 19:09:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/9] vfio: Add Error** argument to
 vfio_devices_dma_logging_start()
To: Eric Auger <eauger@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>
References: <20240514153130.394307-1-clg@redhat.com>
 <20240514153130.394307-3-clg@redhat.com>
 <9cb94f2a-7274-45c7-b440-75b9a537e533@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <9cb94f2a-7274-45c7-b440-75b9a537e533@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
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

On 5/15/24 08:53, Eric Auger wrote:
> Hi Cédric,
> On 5/14/24 17:31, Cédric Le Goater wrote:
>> This allows to update the Error argument of the VFIO log_global_start()
>> handler. Errors for container based logging will also be propagated to
>> qemu_savevm_state_setup() when the ram save_setup() handler is executed.
> nit: also now collect & print errors from
> vfio_container_set_dirty_page_tracking()

OK. To avoid resending, I amended the commit log with :

"Also, errors from vfio_container_set_dirty_page_tracking() are now
collected and reported."


Thanks,

C.



>>
>> The vfio_set_migration_error() call becomes redundant in
>> vfio_listener_log_global_start(). Remove it.
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Avihai Horon <avihaih@nvidia.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>
>>   Changes in v6:
>>
>>   - Commit log improvements (Avihai)
>>   
>>   Changes in v5:
>>
>>   - Used error_setg_errno() in vfio_devices_dma_logging_start()
>>   
>>   hw/vfio/common.c | 26 +++++++++++++++-----------
>>   1 file changed, 15 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 485e53916491f1164d29e739fb7106c0c77df737..b5102f54a6474a50c6366e8fbce23812d55e384e 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1027,7 +1027,8 @@ static void vfio_device_feature_dma_logging_start_destroy(
>>       g_free(feature);
>>   }
>>   
>> -static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer)
>> +static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
>> +                                          Error **errp)
>>   {
>>       struct vfio_device_feature *feature;
>>       VFIODirtyRanges ranges;
>> @@ -1038,6 +1039,7 @@ static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer)
>>       feature = vfio_device_feature_dma_logging_start_create(bcontainer,
>>                                                              &ranges);
>>       if (!feature) {
>> +        error_setg_errno(errp, errno, "Failed to prepare DMA logging");
>>           return -errno;
>>       }
>>   
>> @@ -1049,8 +1051,8 @@ static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer)
>>           ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
>>           if (ret) {
>>               ret = -errno;
>> -            error_report("%s: Failed to start DMA logging, err %d (%s)",
>> -                         vbasedev->name, ret, strerror(errno));
>> +            error_setg_errno(errp, errno, "%s: Failed to start DMA logging",
>> +                             vbasedev->name);
>>               goto out;
>>           }
>>           vbasedev->dirty_tracking = true;
>> @@ -1069,20 +1071,19 @@ out:
>>   static bool vfio_listener_log_global_start(MemoryListener *listener,
>>                                              Error **errp)
>>   {
>> +    ERRP_GUARD();
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
>> @@ -1091,17 +1092,20 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
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
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Eric
> 


