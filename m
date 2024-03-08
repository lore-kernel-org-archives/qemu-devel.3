Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8521CC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 07:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riUrE-0004pd-3r; Fri, 08 Mar 2024 02:41:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1riUr1-0004of-S6
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 02:41:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1riUqy-0007sL-7V
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 02:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709883673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MyBCOTnr7Uq7mQ2iMN2HVNIOArVaBO+Llx5qwqLYEP4=;
 b=Jgs3Wa4VD8jEPt8WXVVDpHCDWoxPXV2nDL45/z1YEQwT0hjfFvAhOzrCGdfwHLHrzXFUdu
 gInLmHwUEU/jG9URJlr8P603c7C77yR8s0pZvuZVdP/N+rgKvokKxRQ3flfYn+xpODxWiX
 3+2d7a6L+oCyhhttDK1QoySCWwy/1hY=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-R-cMWmgCM9-xAamXEtg5-w-1; Fri, 08 Mar 2024 02:41:12 -0500
X-MC-Unique: R-cMWmgCM9-xAamXEtg5-w-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-609d95434daso30884977b3.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 23:41:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709883672; x=1710488472;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MyBCOTnr7Uq7mQ2iMN2HVNIOArVaBO+Llx5qwqLYEP4=;
 b=sVbaq4GRk5cA09F8TrvJj0+dXZe4lM/aZDywogE8s3PtQ3GaXUwwrfTAsiwoMjt5cy
 JajIRkHTJ/zUzyTN6xYSztezD/U2EyH3Yv19yhh2v6iK+Z0qdgprHDwRS90Zyp5fN/X5
 yfAtpHo7HsJMcW7Tlwi4mNMGA12j4DXn3fAGXyW1JvJrGv6yR0ojJ81pCoLuNyt9A2Z3
 gwrxvckbGRxEVTPOcGIwWFzsnbPegzRq4JNTIvmHk/83IF4/3gX32gkxi8Bm0Q2vEYWb
 lGqHtRE7s5z8FxP5RfG+Isjr8SJbLWVPqinjyKJvkMo8YEok5ki1e3FwnHL9P065N78f
 xfPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPRZHDZmoZfVW7Lu6/cVp4X7OApH4mpMPUvi+aBbqxi9K2dfv5u+srW89lsnOLacQPPjgj3dG5WiihMQCytQ7w623X81k=
X-Gm-Message-State: AOJu0YzZoPwg9h4cT5ZyD3cctUts3uORL07iWsxnq6AEfpAuxJetK8Ji
 torYmkxA7xTHvjwZmPAnzP4DD0VmkxCW3sLKeLvytrsBS8U/6t/6sZ8tKeNAcbY3Bt1Qg1W0czK
 y23WBEzC3UElEkVNeDjTDym0MjmULbsbC6l0s73b+UrQ9vpYovMSm
X-Received: by 2002:a0d:d80c:0:b0:60a:448:ff4f with SMTP id
 a12-20020a0dd80c000000b0060a0448ff4fmr1017119ywe.41.1709883670715; 
 Thu, 07 Mar 2024 23:41:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYfsFEaW1kDH8wJ7UXmgHta7Duf+krGHdHlAYxHP+Luh2QoAgvKAt1xafanzyWCM3VU2NxQQ==
X-Received: by 2002:a0d:d80c:0:b0:60a:448:ff4f with SMTP id
 a12-20020a0dd80c000000b0060a0448ff4fmr1017076ywe.41.1709883668959; 
 Thu, 07 Mar 2024 23:41:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a81830f000000b0060a015c9da0sm279077ywf.72.2024.03.07.23.41.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 23:41:08 -0800 (PST)
Message-ID: <b51fb022-4f51-4fbc-8ebc-d8aaef537286@redhat.com>
Date: Fri, 8 Mar 2024 08:41:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/25] vfio: Add Error** argument to
 .vfio_save_config() handler
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-21-clg@redhat.com>
 <c036626a-f1ff-46fd-ae34-a2b493f1720a@redhat.com>
 <dd7a8253-39f0-477e-88a0-2592a9134bbc@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <dd7a8253-39f0-477e-88a0-2592a9134bbc@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
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



On 3/7/24 14:55, Cédric Le Goater wrote:
> On 3/7/24 10:13, Eric Auger wrote:
>>
>>
>> On 3/6/24 14:34, Cédric Le Goater wrote:
>>> Use vmstate_save_state_with_err() to improve error reporting in the
>>> callers and store a reported error under the migration stream. Add
>>> documentation while at it.
>>>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>   include/hw/vfio/vfio-common.h | 25 ++++++++++++++++++++++++-
>>>   hw/vfio/migration.c           | 18 ++++++++++++------
>>>   hw/vfio/pci.c                 |  5 +++--
>>>   3 files changed, 39 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h
>>> b/include/hw/vfio/vfio-common.h
>>> index
>>> b9da6c08ef41174610eb92726c590309a53696a3..46f88493634b5634a9c14a5caa33a463fbf2c50d 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -133,7 +133,30 @@ struct VFIODeviceOps {
>>>       int (*vfio_hot_reset_multi)(VFIODevice *vdev);
>>>       void (*vfio_eoi)(VFIODevice *vdev);
>>>       Object *(*vfio_get_object)(VFIODevice *vdev);
>>> -    void (*vfio_save_config)(VFIODevice *vdev, QEMUFile *f);
>>> +
>>> +    /**
>>> +     * @vfio_save_config
>>> +     *
>>> +     * Save device config state
>>> +     *
>>> +     * @vdev: #VFIODevice for which to save the config
>>> +     * @f: #QEMUFile where to send the data
>>> +     * @errp: pointer to Error*, to store an error if it happens.
>>> +     *
>>> +     * Returns zero to indicate success and negative for error
>>> +     */
>>> +    int (*vfio_save_config)(VFIODevice *vdev, QEMUFile *f, Error
>>> **errp);
>>> +
>>> +    /**
>>> +     * @vfio_load_config
>>> +     *
>>> +     * Load device config state
>>> +     *
>>> +     * @vdev: #VFIODevice for which to load the config
>>> +     * @f: #QEMUFile where to get the data
>>> +     *
>>> +     * Returns zero to indicate success and negative for error
>>> +     */
>>>       int (*vfio_load_config)(VFIODevice *vdev, QEMUFile *f);
>>>   };
>>>   diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index
>>> 71ade14a7942358094371a86c00718f5979113ea..bd48f2ee472a5230c2c84bff829dae1e217db33f 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -190,14 +190,19 @@ static int vfio_load_buffer(QEMUFile *f,
>>> VFIODevice *vbasedev,
>>>       return ret;
>>>   }
>>>   -static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
>>> +static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
>>> +                                         Error **errp)
>>>   {
>>>       VFIODevice *vbasedev = opaque;
>>> +    int ret;
>>>         qemu_put_be64(f, VFIO_MIG_FLAG_DEV_CONFIG_STATE);
>>>         if (vbasedev->ops && vbasedev->ops->vfio_save_config) {
>>> -        vbasedev->ops->vfio_save_config(vbasedev, f);
>>> +        ret = vbasedev->ops->vfio_save_config(vbasedev, f, errp);
>>> +        if (ret) {
>> I am not familiar enough with that case but don't you still want to set
>> the VFIO_MIG_FLAG_END_OF_STATE to "close" the state?
> 
> This is a delimiter used on the target side when loading the state.
> 
> When QEMU fails to capture the device state, the whole migration is marked
> as in error. There is no need to end cleanly the device state, it is bogus
> anyhow.

OK thanks

Eric
> 
> Thanks,
> 
> C.
> 
> 
>>
>> Eric
>>> +            return ret;
>>> +        }
>>>       }
>>>         qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>>> @@ -587,13 +592,14 @@ static int vfio_save_complete_precopy(QEMUFile
>>> *f, void *opaque)
>>>   static void vfio_save_state(QEMUFile *f, void *opaque)
>>>   {
>>>       VFIODevice *vbasedev = opaque;
>>> +    Error *local_err = NULL;
>>>       int ret;
>>>   -    ret = vfio_save_device_config_state(f, opaque);
>>> +    ret = vfio_save_device_config_state(f, opaque, &local_err);
>>>       if (ret) {
>>> -        error_report("%s: Failed to save device config space",
>>> -                     vbasedev->name);
>>> -        qemu_file_set_error(f, ret);
>>> +        error_prepend(&local_err, "%s: Failed to save device config
>>> space",
>>> +                      vbasedev->name);
>>> +        qemu_file_set_error_obj(f, ret, local_err);
>>>       }
>>>   }
>>>   diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index
>>> 4fa387f0430d62ca2ba1b5ae5b7037f8f06b33f9..99d86e1d40ef25133fc76ad6e58294b07bd20843 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -2585,11 +2585,12 @@ const VMStateDescription
>>> vmstate_vfio_pci_config = {
>>>       }
>>>   };
>>>   -static void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f)
>>> +static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f,
>>> Error **errp)
>>>   {
>>>       VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice,
>>> vbasedev);
>>>   -    vmstate_save_state(f, &vmstate_vfio_pci_config, vdev, NULL);
>>> +    return vmstate_save_state_with_err(f, &vmstate_vfio_pci_config,
>>> vdev, NULL,
>>> +                                       errp);
>>>   }
>>>     static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
>>
> 


