Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A615FC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 13:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riEDi-0007iL-77; Thu, 07 Mar 2024 08:55:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1riEDX-0007Vs-Vt
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:55:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1riEDS-0005PX-97
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709819718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2CPg7bsrl/BYqLPV76YSeJhIDVct9vlYCbAC3t7TImA=;
 b=X89tP1CHZ87J7oizbu3xcqN8Yo6F0N2R8qrNuDfPHBoIPzHVEudodm1ljGj6Pr3ZOX+hM8
 A3cElbNI4wEfZ9JFujjh0CNqf6La6w6z1rWxeAIlIyVUn+3UorOGtxufQRFes1M0ssn8N/
 sGbEYHfKqkw4Rc0MBVgAqa1cnelBh0k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-t9Rx0YPdPl64tNQcozSL_A-1; Thu, 07 Mar 2024 08:55:16 -0500
X-MC-Unique: t9Rx0YPdPl64tNQcozSL_A-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33e41caf403so400137f8f.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 05:55:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709819715; x=1710424515;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2CPg7bsrl/BYqLPV76YSeJhIDVct9vlYCbAC3t7TImA=;
 b=kFJ/jfOa3ybWafWiiirgcrgjbqqxS2wMAGVyjwxLIN3zZxu/VKI7Rc1HGVPxXzQWa3
 Km29HGcVTwdjXfROvwIni+pD24l5xndGk9YjfhNs1Wm7J/axOGmbgLNapGmAD6AH5J//
 xAnB38v6a3F3GPSFvOxTO14yArZZARSC1dTFNggS7edYqasHyxTONSOckl4sp83GLa/L
 et7miZWeFORXIeccCrUR0ecoFyyDEDEwoETKyXzdZWo9IsQcakLq1O5M1zyEUzMamvJy
 aDXRGjcEiAelWa3Q8z1bazJsJF3RZ+HG60U46FDZ+nTEtZk1PUyPliOkp9M1aNi0dUST
 98dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyJDOI+DqBjraJyqoFTvRp203tSbe3yOlDuuEHlWaDhBNybdpVaSii2xCub01MYHZuY88bk8qH+KpMvD+a8KnZognlpyI=
X-Gm-Message-State: AOJu0YyI5GI/O6XlB4SZPdhV7lOO+4owS4IqaX4C1dcUav0JSPy4pRjJ
 13rzm6c74lpzsEQKQmqARncPPeeEenxCAaDZI6FBALBWICLTSUfvywLJF11jCbkhkywR+BEQCF7
 Z/qjh48h/QppZpdYdGwpi7CsyafvJH63wHD66h2Dd+xm2eEbjCOp1
X-Received: by 2002:a5d:550f:0:b0:33d:f883:4fae with SMTP id
 b15-20020a5d550f000000b0033df8834faemr12675129wrv.64.1709819715501; 
 Thu, 07 Mar 2024 05:55:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFNiBJ9WQKUgu2aRVBBuMBz2EuNfCRBaHymjzs+DCfdMiNfCeA3Q4pKVeLWqcM7y3W939a7g==
X-Received: by 2002:a5d:550f:0:b0:33d:f883:4fae with SMTP id
 b15-20020a5d550f000000b0033df8834faemr12675111wrv.64.1709819715144; 
 Thu, 07 Mar 2024 05:55:15 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 i8-20020adfb648000000b0033e0ed396bdsm20264179wre.106.2024.03.07.05.55.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 05:55:14 -0800 (PST)
Message-ID: <dd7a8253-39f0-477e-88a0-2592a9134bbc@redhat.com>
Date: Thu, 7 Mar 2024 14:55:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/25] vfio: Add Error** argument to
 .vfio_save_config() handler
Content-Language: en-US, fr
To: Eric Auger <eauger@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-21-clg@redhat.com>
 <c036626a-f1ff-46fd-ae34-a2b493f1720a@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <c036626a-f1ff-46fd-ae34-a2b493f1720a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/7/24 10:13, Eric Auger wrote:
> 
> 
> On 3/6/24 14:34, Cédric Le Goater wrote:
>> Use vmstate_save_state_with_err() to improve error reporting in the
>> callers and store a reported error under the migration stream. Add
>> documentation while at it.
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   include/hw/vfio/vfio-common.h | 25 ++++++++++++++++++++++++-
>>   hw/vfio/migration.c           | 18 ++++++++++++------
>>   hw/vfio/pci.c                 |  5 +++--
>>   3 files changed, 39 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index b9da6c08ef41174610eb92726c590309a53696a3..46f88493634b5634a9c14a5caa33a463fbf2c50d 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -133,7 +133,30 @@ struct VFIODeviceOps {
>>       int (*vfio_hot_reset_multi)(VFIODevice *vdev);
>>       void (*vfio_eoi)(VFIODevice *vdev);
>>       Object *(*vfio_get_object)(VFIODevice *vdev);
>> -    void (*vfio_save_config)(VFIODevice *vdev, QEMUFile *f);
>> +
>> +    /**
>> +     * @vfio_save_config
>> +     *
>> +     * Save device config state
>> +     *
>> +     * @vdev: #VFIODevice for which to save the config
>> +     * @f: #QEMUFile where to send the data
>> +     * @errp: pointer to Error*, to store an error if it happens.
>> +     *
>> +     * Returns zero to indicate success and negative for error
>> +     */
>> +    int (*vfio_save_config)(VFIODevice *vdev, QEMUFile *f, Error **errp);
>> +
>> +    /**
>> +     * @vfio_load_config
>> +     *
>> +     * Load device config state
>> +     *
>> +     * @vdev: #VFIODevice for which to load the config
>> +     * @f: #QEMUFile where to get the data
>> +     *
>> +     * Returns zero to indicate success and negative for error
>> +     */
>>       int (*vfio_load_config)(VFIODevice *vdev, QEMUFile *f);
>>   };
>>   
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 71ade14a7942358094371a86c00718f5979113ea..bd48f2ee472a5230c2c84bff829dae1e217db33f 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -190,14 +190,19 @@ static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
>>       return ret;
>>   }
>>   
>> -static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
>> +static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
>> +                                         Error **errp)
>>   {
>>       VFIODevice *vbasedev = opaque;
>> +    int ret;
>>   
>>       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_CONFIG_STATE);
>>   
>>       if (vbasedev->ops && vbasedev->ops->vfio_save_config) {
>> -        vbasedev->ops->vfio_save_config(vbasedev, f);
>> +        ret = vbasedev->ops->vfio_save_config(vbasedev, f, errp);
>> +        if (ret) {
> I am not familiar enough with that case but don't you still want to set
> the VFIO_MIG_FLAG_END_OF_STATE to "close" the state?

This is a delimiter used on the target side when loading the state.

When QEMU fails to capture the device state, the whole migration is marked
as in error. There is no need to end cleanly the device state, it is bogus
anyhow.

Thanks,

C.


> 
> Eric
>> +            return ret;
>> +        }
>>       }
>>   
>>       qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>> @@ -587,13 +592,14 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>>   static void vfio_save_state(QEMUFile *f, void *opaque)
>>   {
>>       VFIODevice *vbasedev = opaque;
>> +    Error *local_err = NULL;
>>       int ret;
>>   
>> -    ret = vfio_save_device_config_state(f, opaque);
>> +    ret = vfio_save_device_config_state(f, opaque, &local_err);
>>       if (ret) {
>> -        error_report("%s: Failed to save device config space",
>> -                     vbasedev->name);
>> -        qemu_file_set_error(f, ret);
>> +        error_prepend(&local_err, "%s: Failed to save device config space",
>> +                      vbasedev->name);
>> +        qemu_file_set_error_obj(f, ret, local_err);
>>       }
>>   }
>>   
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 4fa387f0430d62ca2ba1b5ae5b7037f8f06b33f9..99d86e1d40ef25133fc76ad6e58294b07bd20843 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -2585,11 +2585,12 @@ const VMStateDescription vmstate_vfio_pci_config = {
>>       }
>>   };
>>   
>> -static void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f)
>> +static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
>>   {
>>       VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
>>   
>> -    vmstate_save_state(f, &vmstate_vfio_pci_config, vdev, NULL);
>> +    return vmstate_save_state_with_err(f, &vmstate_vfio_pci_config, vdev, NULL,
>> +                                       errp);
>>   }
>>   
>>   static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
> 


