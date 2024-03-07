Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAFDC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 14:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riENo-0001z5-Dg; Thu, 07 Mar 2024 09:06:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1riENm-0001yf-PQ
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 09:06:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1riENj-00058b-UY
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 09:06:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709820358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iNSbuumSe4tGdJSMXLtnLXXbcWoC8LN0SQvwDX4XPOQ=;
 b=c1cvbP/Cpy/4JjfVxY7qUufJfn3bKzK7YeqXLVviDNihJ18CDD3iREEoBX5T3fAdLqTYkJ
 wHXzHt1eDv9t59q0w26y0OvfQNFkaSORPofRU5Ka7XtYOXnrYV8HU4muAPa2plSthQE+Wv
 Ha3nztukS4/6BoYT2yybICbdtEzqo8Q=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-plnlnjAMPGKJO76fY58KWQ-1; Thu, 07 Mar 2024 09:05:56 -0500
X-MC-Unique: plnlnjAMPGKJO76fY58KWQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-42ef02a3861so9975871cf.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 06:05:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709820356; x=1710425156;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iNSbuumSe4tGdJSMXLtnLXXbcWoC8LN0SQvwDX4XPOQ=;
 b=JiSJDrYU04TuSJASicVnUJ8epJ71LJE+L5mlQsItE4z1E6ck08+P7q87qZLdHvui2o
 +Akb0+7fUTBgE4DwvRV3J3m8dbW4PaGDdPOCxTOxgRaP/T/I4iM0BzicNj5LOrKiL4BZ
 GzmhjdzSbNY1d5nt6Odr3fxiT12OSTNcu4afH76FVNQKfMyE2QWsCZL4Gqw2UCYtHd8h
 mTecS6MHm2ILqbd0t16D+eEUipOsCjEMDijgurEASCu3UOT3epxMG/P5wxlb/S01/cz7
 I3cFBTGOYxGWd97AhI6AeRzAu3WpDr4Gpjl+9HNgZGauZN3OpXFd0JSXZnp+LbniyGlX
 Ps8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO4WhVSZowJuisrg916gzyPM0pbqYxmPvbi9xjivIeQSTVGmj+dYQ0jKd7JbqZVPKrUnKv/BkWrpaiAYNZ4nlMOuUFVFo=
X-Gm-Message-State: AOJu0Yzmz2KYWlN61hOuAAAdw6uPLhRTXGrS/RNwfxeaEKkm5+SYNpeN
 HWvOVCSIEUAoMXjHZBQmlMJnZUOo+gZwgarSnqLvFgff9x7t1LmxCN8UqTjOuCCznY6VzxbwKSm
 uVY8gIuse+JRl76qwklW1e0C+cRr4tzSCAwVacRpGQUp9Qi3eIJPO
X-Received: by 2002:a05:622a:1805:b0:42e:efce:136a with SMTP id
 t5-20020a05622a180500b0042eefce136amr9795199qtc.57.1709820355687; 
 Thu, 07 Mar 2024 06:05:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGg867z+7eC+JxjLbheZtpctswwLtT6LsLyMUxCS4PF71wfj+OuERmXaj5rKiB6IRK1/x64PA==
X-Received: by 2002:a05:622a:1805:b0:42e:efce:136a with SMTP id
 t5-20020a05622a180500b0042eefce136amr9795151qtc.57.1709820355103; 
 Thu, 07 Mar 2024 06:05:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 b15-20020ac85bcf000000b0042e6093ff31sm7575367qtb.63.2024.03.07.06.05.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 06:05:54 -0800 (PST)
Message-ID: <1f370b66-1b28-4a4e-a84d-735b6f2f1716@redhat.com>
Date: Thu, 7 Mar 2024 15:05:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/25] vfio: Add Error** argument to
 vfio_devices_dma_logging_stop()
Content-Language: en-US, fr
To: Eric Auger <eauger@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-19-clg@redhat.com>
 <a1836566-0757-4b1b-84af-228e848c7a48@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <a1836566-0757-4b1b-84af-228e848c7a48@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/7/24 09:53, Eric Auger wrote:
> 
> 
> On 3/6/24 14:34, Cédric Le Goater wrote:
>> This improves error reporting in the log_global_stop() VFIO handler.
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
>>   - Use error_setg_errno() in vfio_devices_dma_logging_stop()
>>   
>>   hw/vfio/common.c | 19 ++++++++++++++-----
>>   1 file changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index d6790557da2f2890398fa03dbbef18129cd2c1bb..5b2e6a179cdd5f8ca5be84b7097661e96b391456 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -938,12 +938,14 @@ static void vfio_dirty_tracking_init(VFIOContainerBase *bcontainer,
>>       memory_listener_unregister(&dirty.listener);
>>   }
>>   
>> -static void vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
>> +static int vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer,
>> +                                          Error **errp)
>>   {
>>       uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
>>                                 sizeof(uint64_t))] = {};
>>       struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
>>       VFIODevice *vbasedev;
>> +    int ret = 0;
>>   
>>       feature->argsz = sizeof(buf);
>>       feature->flags = VFIO_DEVICE_FEATURE_SET |
>> @@ -955,11 +957,17 @@ static void vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
>>           }
>>   
>>           if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
>> -            warn_report("%s: Failed to stop DMA logging, err %d (%s)",
>> -                        vbasedev->name, -errno, strerror(errno));
>> +            /* Keep first error */
>> +            if (!ret) {
>> +                ret = -errno;
>> +                error_setg_errno(errp, errno, "%s: Failed to stop DMA logging",
>> +                                 vbasedev->name);
> maybe you can keep the previous warn_report in case errp is NULL
> (rollback) or for subsequent failures?

Hmm, I wonder if we should keep this patch. It made sense when
vfio_listener_log_global_stop() had an Error ** parameter. We
dropped it in v4 for the sake of simplicity, so we might as
well keep the previous behavior and simply warn the user when
dirty tracking fails to stop. I will check for v5.

Thanks,

C.



> 
> Eric
>> +            }
>>           }
>>           vbasedev->dirty_tracking = false;
>>       }
>> +
>> +    return ret;
>>   }
>>   
>>   static struct vfio_device_feature *
>> @@ -1068,7 +1076,8 @@ static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
>>   
>>   out:
>>       if (ret) {
>> -        vfio_devices_dma_logging_stop(bcontainer);
>> +        /* Ignore the potential errors when doing rollback */
>> +        vfio_devices_dma_logging_stop(bcontainer, NULL);
>>       }
>>   
>>       vfio_device_feature_dma_logging_start_destroy(feature);
>> @@ -1104,7 +1113,7 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
>>       int ret = 0;
>>   
>>       if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>> -        vfio_devices_dma_logging_stop(bcontainer);
>> +        ret = vfio_devices_dma_logging_stop(bcontainer, &local_err);
>>       } else {
>>           ret = vfio_container_set_dirty_page_tracking(bcontainer, false,
>>                                                        &local_err);
> 


