Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9675C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 09:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri9pE-0000si-FT; Thu, 07 Mar 2024 04:14:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1ri9pB-0000sX-Pg
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:14:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1ri9pA-0002Dh-1X
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709802839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4c7UbsmYBl3HqschwFt8O/rTIUbUbf1zqDquH4t1Yd4=;
 b=ijnyv68yanfrGmkWgDP5XDh9bcM5gclaJr5DbKmPKfw1ow5ZAF62tlYA1hz8s0jCiPsEqW
 hnuJnkvGqaarRdSdmRZwnp9PdVftcZlIJVkFWg8ALkVHupQxoVLSdyR3YZijEOPaz9I8b2
 t1ffduzJM+pejqEsVaVDYbYPfDdhlgk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-rOclft9YODyJF067eBQSxg-1; Thu, 07 Mar 2024 04:13:57 -0500
X-MC-Unique: rOclft9YODyJF067eBQSxg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-513182f4018so415189e87.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 01:13:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709802836; x=1710407636;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4c7UbsmYBl3HqschwFt8O/rTIUbUbf1zqDquH4t1Yd4=;
 b=seVIHZ4Rr2CREkHDr0LrVOcU9avywqdR/WWyZfdaEhy0dzJSpjsBmDoVI18Om++5Ih
 y2j9/WIbsPk93M0kNQLaZOD2VMK4nI7vgUComnMD8KkSDAxC3jzImzpzQF9xmkX9iuG6
 b5kqcTi7WltgEeO4giReYxHqjhiRuI2Aaov2CgfDTiGT9VGYYGK5EjbDDNYxIBgJO2wp
 qeyl8Dd/+QUTITOwU38S3/0FBQAlaa7B5Kwhe9k3O/GZ6Tl/e6w8asO8U/R/qXfgiOLu
 6k7P/Oeh6EMipW7bkyiZeRGX8PUGgyrKXOtHLvE6d6e1vH1smdMvfesG8pIDEXWQnpOm
 XOqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoLPylQKTVsLreOwcgQcNLPPcX7Bms+EQiBdlPI750b+9GMHXK52XTtT5iL5nJiwPNWAnH0gNR7I1+SJCyEvScqh9jQ2g=
X-Gm-Message-State: AOJu0YyK3DRGAtHcaE6eYhCDRWuxcCjgJt7xwK61FNh5yDGgQ12EZuB4
 Bngh8lak28Ql+dLg4g3X/ycR1o4Ry7BlSOlGr/PGE+SwQ0xodFUIjCPn0fQVbSgJS1Dl08+yIWm
 t3x60ebPka4mEHKwDXpRrCBRw8/50geK8c/WBB9DW0Znh+o1nDiLm
X-Received: by 2002:ac2:52ac:0:b0:513:84b6:6917 with SMTP id
 r12-20020ac252ac000000b0051384b66917mr90200lfm.15.1709802836097; 
 Thu, 07 Mar 2024 01:13:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgdiehgoOiixrSbZBsfdHmS03UrzQLabVe60yr36974aoLcRZ5+djHfkMxfd4Sn1fw8Woz+g==
X-Received: by 2002:ac2:52ac:0:b0:513:84b6:6917 with SMTP id
 r12-20020ac252ac000000b0051384b66917mr90180lfm.15.1709802835749; 
 Thu, 07 Mar 2024 01:13:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 l11-20020a05600c1d0b00b00412fc25691bsm1967683wms.38.2024.03.07.01.13.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 01:13:55 -0800 (PST)
Message-ID: <c036626a-f1ff-46fd-ae34-a2b493f1720a@redhat.com>
Date: Thu, 7 Mar 2024 10:13:53 +0100
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
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240306133441.2351700-21-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
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



On 3/6/24 14:34, Cédric Le Goater wrote:
> Use vmstate_save_state_with_err() to improve error reporting in the
> callers and store a reported error under the migration stream. Add
> documentation while at it.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>  include/hw/vfio/vfio-common.h | 25 ++++++++++++++++++++++++-
>  hw/vfio/migration.c           | 18 ++++++++++++------
>  hw/vfio/pci.c                 |  5 +++--
>  3 files changed, 39 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index b9da6c08ef41174610eb92726c590309a53696a3..46f88493634b5634a9c14a5caa33a463fbf2c50d 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -133,7 +133,30 @@ struct VFIODeviceOps {
>      int (*vfio_hot_reset_multi)(VFIODevice *vdev);
>      void (*vfio_eoi)(VFIODevice *vdev);
>      Object *(*vfio_get_object)(VFIODevice *vdev);
> -    void (*vfio_save_config)(VFIODevice *vdev, QEMUFile *f);
> +
> +    /**
> +     * @vfio_save_config
> +     *
> +     * Save device config state
> +     *
> +     * @vdev: #VFIODevice for which to save the config
> +     * @f: #QEMUFile where to send the data
> +     * @errp: pointer to Error*, to store an error if it happens.
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
> +    int (*vfio_save_config)(VFIODevice *vdev, QEMUFile *f, Error **errp);
> +
> +    /**
> +     * @vfio_load_config
> +     *
> +     * Load device config state
> +     *
> +     * @vdev: #VFIODevice for which to load the config
> +     * @f: #QEMUFile where to get the data
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
>      int (*vfio_load_config)(VFIODevice *vdev, QEMUFile *f);
>  };
>  
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 71ade14a7942358094371a86c00718f5979113ea..bd48f2ee472a5230c2c84bff829dae1e217db33f 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -190,14 +190,19 @@ static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
>      return ret;
>  }
>  
> -static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
> +static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
> +                                         Error **errp)
>  {
>      VFIODevice *vbasedev = opaque;
> +    int ret;
>  
>      qemu_put_be64(f, VFIO_MIG_FLAG_DEV_CONFIG_STATE);
>  
>      if (vbasedev->ops && vbasedev->ops->vfio_save_config) {
> -        vbasedev->ops->vfio_save_config(vbasedev, f);
> +        ret = vbasedev->ops->vfio_save_config(vbasedev, f, errp);
> +        if (ret) {
I am not familiar enough with that case but don't you still want to set
the VFIO_MIG_FLAG_END_OF_STATE to "close" the state?

Eric
> +            return ret;
> +        }
>      }
>  
>      qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> @@ -587,13 +592,14 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>  static void vfio_save_state(QEMUFile *f, void *opaque)
>  {
>      VFIODevice *vbasedev = opaque;
> +    Error *local_err = NULL;
>      int ret;
>  
> -    ret = vfio_save_device_config_state(f, opaque);
> +    ret = vfio_save_device_config_state(f, opaque, &local_err);
>      if (ret) {
> -        error_report("%s: Failed to save device config space",
> -                     vbasedev->name);
> -        qemu_file_set_error(f, ret);
> +        error_prepend(&local_err, "%s: Failed to save device config space",
> +                      vbasedev->name);
> +        qemu_file_set_error_obj(f, ret, local_err);
>      }
>  }
>  
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 4fa387f0430d62ca2ba1b5ae5b7037f8f06b33f9..99d86e1d40ef25133fc76ad6e58294b07bd20843 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2585,11 +2585,12 @@ const VMStateDescription vmstate_vfio_pci_config = {
>      }
>  };
>  
> -static void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f)
> +static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
>  {
>      VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
>  
> -    vmstate_save_state(f, &vmstate_vfio_pci_config, vdev, NULL);
> +    return vmstate_save_state_with_err(f, &vmstate_vfio_pci_config, vdev, NULL,
> +                                       errp);
>  }
>  
>  static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)


