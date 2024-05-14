Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A17C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 08:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6ns3-0001Kb-VP; Tue, 14 May 2024 04:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6ns2-0001K6-DX
 for qemu-devel@nongnu.org; Tue, 14 May 2024 04:50:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6nry-0007CN-80
 for qemu-devel@nongnu.org; Tue, 14 May 2024 04:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715676644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A6Au5KTDRy7dpgtGRRI/YbATj4c0iineuhkxRsryMGQ=;
 b=O2mTBVbQnqS2kwunQeuwZTipGgoQSSBrHGFvAFBnFvXNRVi0Nxj1lMbMSDKcsbXvgmoUXd
 yZgkWdzY9BJiE3dGqJQFlEP84MIDakMM/PwtBr2kdjPuXUFczzgEBLp0RhzWsciujlopVA
 bHM6ahXQO0oTMqvY86BraclANHpLbVM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-koLKvybgOnaRzyAY-83P4w-1; Tue, 14 May 2024 04:50:43 -0400
X-MC-Unique: koLKvybgOnaRzyAY-83P4w-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6a0e1d67928so75002526d6.3
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 01:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715676643; x=1716281443;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A6Au5KTDRy7dpgtGRRI/YbATj4c0iineuhkxRsryMGQ=;
 b=l9YX16RndVhZP2qjgLI3DzImXguhe6v9M0Ts5neGNnAxdRuICxBQn7QA0Sh/RFjWGa
 4ofdEm63dV8XDLeVnxbQNRhKGy2V/xj2uF2isDKSPMuA/sDRd+1eh9NSXBXjScEVbvww
 QrAH4TawZFVdWGRoFbs0Jt47gzpzbAk8EJ90m/XSDn+lzhdLvp+WjLhWM4aiZH5efir/
 D0gMCPh8FFaO7BcHxMOEVnqsWglnz3R7+Rp+HT7oP1RNcRIUvcczr/YILyRroEilJrwb
 Q6TBxaIGcY8p6WPo2Wpx39+zgmtJgVgZlEgoxHaQIoH0407f0H4DUSE6GU8oDL6YOJ9h
 5pRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUGj68W9ByIIBKtvQNarkWPn79xrSQW9OwSl7t/RdZ01tyIwrOeMvnR2FxLm6Gfgf94x/gEZAqWFLMpf7FyoxQr5PF5P4=
X-Gm-Message-State: AOJu0YyFqpqzJhSWw6J9BIOKVn0Fx0isFG5y7L4QHBerpNWW6jJ+VNse
 GVnnuvzSN1onF3M19bAl66hO7b9IoWw+vxTVEqf3wXDn4+d/dAIo+ZidJwEIX6sL674MwJVYo+F
 yISB1UOfQt6yFY8GUgNDOGPWcSb5eenPzar0IVPo9VeCO9NHnVy+2
X-Received: by 2002:a05:6214:5542:b0:6a0:c8de:f78b with SMTP id
 6a1803df08f44-6a168165f81mr150691916d6.24.1715676642747; 
 Tue, 14 May 2024 01:50:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF1vZWLRNVHcxSh0nPMDzoqZlx0DwBL6XFKEdksTWSUhZImc1IobM6/mjY6eW+wUHGXnHu8w==
X-Received: by 2002:a05:6214:5542:b0:6a0:c8de:f78b with SMTP id
 6a1803df08f44-6a168165f81mr150691786d6.24.1715676642296; 
 Tue, 14 May 2024 01:50:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1cd266sm51221096d6.80.2024.05.14.01.50.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 01:50:41 -0700 (PDT)
Message-ID: <1e5b25d1-a9df-4854-b474-9dfb190fe376@redhat.com>
Date: Tue, 14 May 2024 10:50:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/10] vfio: Add Error** argument to
 .vfio_save_config() handler
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240506092053.388578-1-clg@redhat.com>
 <20240506092053.388578-6-clg@redhat.com>
 <894a958e-f804-46e9-a511-c7f62d3ec414@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <894a958e-f804-46e9-a511-c7f62d3ec414@nvidia.com>
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

On 5/13/24 15:30, Avihai Horon wrote:
> 
> On 06/05/2024 12:20, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Use vmstate_save_state_with_err() to improve error reporting in the
>> callers and store a reported error under the migration stream. Add
>> documentation while at it.
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   include/hw/vfio/vfio-common.h | 25 ++++++++++++++++++++++++-
>>   hw/vfio/migration.c           | 18 ++++++++++++------
>>   hw/vfio/pci.c                 |  5 +++--
>>   3 files changed, 39 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index b9da6c08ef41174610eb92726c590309a53696a3..46f88493634b5634a9c14a5caa33a463fbf2c50d 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -133,7 +133,30 @@ struct VFIODeviceOps {
>>       int (*vfio_hot_reset_multi)(VFIODevice *vdev);
>>       void (*vfio_eoi)(VFIODevice *vdev);
>>       Object *(*vfio_get_object)(VFIODevice *vdev);
>> -    void (*vfio_save_config)(VFIODevice *vdev, QEMUFile *f);
>> +
>> +    /**
>> +     * @vfio_save_config
>> +     *
>> +     * Save device config state
>> +     *
>> +     * @vdev: #VFIODevice for which to save the config
>> +     * @f: #QEMUFile where to send the data
>> +     * @errp: pointer to Error*, to store an error if it happens.
>> +     *
>> +     * Returns zero to indicate success and negative for error
>> +     */
>> +    int (*vfio_save_config)(VFIODevice *vdev, QEMUFile *f, Error **errp);
>> +
>> +    /**
>> +     * @vfio_load_config
>> +     *
>> +     * Load device config state
>> +     *
>> +     * @vdev: #VFIODevice for which to load the config
>> +     * @f: #QEMUFile where to get the data
>> +     *
>> +     * Returns zero to indicate success and negative for error
>> +     */
>>       int (*vfio_load_config)(VFIODevice *vdev, QEMUFile *f);
>>   };
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 9b6375c949f7a8dca857ead2506855f63fa051e4..87437490bd50321b3eb27770c932078597053746 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -189,14 +189,19 @@ static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
>>       return ret;
>>   }
>>
>> -static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
>> +static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
>> +                                         Error **errp)
>>   {
>>       VFIODevice *vbasedev = opaque;
>> +    int ret;
>>
>>       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_CONFIG_STATE);
>>
>>       if (vbasedev->ops && vbasedev->ops->vfio_save_config) {
>> -        vbasedev->ops->vfio_save_config(vbasedev, f);
>> +        ret = vbasedev->ops->vfio_save_config(vbasedev, f, errp);
>> +        if (ret) {
>> +            return ret;
>> +        }
>>       }
>>
>>       qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> 
> Below we have:
> 
> return qemu_file_get_error(f);
> 
> Need to set errp in case of error.

yep. I will change the returned type to bool while at it.

> 
>> @@ -588,13 +593,14 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>>   static void vfio_save_state(QEMUFile *f, void *opaque)
>>   {
>>       VFIODevice *vbasedev = opaque;
>> +    Error *local_err = NULL;
>>       int ret;
>>
>> -    ret = vfio_save_device_config_state(f, opaque);
>> +    ret = vfio_save_device_config_state(f, opaque, &local_err);
>>       if (ret) {
>> -        error_report("%s: Failed to save device config space",
>> -                     vbasedev->name);
>> -        qemu_file_set_error(f, ret);
>> +        error_prepend(&local_err, "%s: Failed to save device config space",
> 
> Add " - " ("... device config space - "), like in the other patches?

ok. I will check how (in)consistent I was when doing these
error_prepend changes.


Thanks,

C.


> 
> Thanks.
> 
>> +                      vbasedev->name);
>> +        qemu_file_set_error_obj(f, ret, local_err);
>>       }
>>   }
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 64780d1b793345c8e8996fe6b7987059ce831c11..fc6e54e871508bb0e2a3ac9079a195c086531f21 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -2586,11 +2586,12 @@ static const VMStateDescription vmstate_vfio_pci_config = {
>>       }
>>   };
>>
>> -static void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f)
>> +static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
>>   {
>>       VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
>>
>> -    vmstate_save_state(f, &vmstate_vfio_pci_config, vdev, NULL);
>> +    return vmstate_save_state_with_err(f, &vmstate_vfio_pci_config, vdev, NULL,
>> +                                       errp);
>>   }
>>
>>   static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
>> -- 
>> 2.45.0
>>
> 


