Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975A0C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 08:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri9V6-000462-Vz; Thu, 07 Mar 2024 03:53:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1ri9V5-00045m-2U
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 03:53:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1ri9V3-0004WN-Jv
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 03:53:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709801592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=leZogyP0pvRhSW3XxBaQO1tJMAOXsKR0oZsrSqT5uSo=;
 b=U6yOcA+Z9o5YvO9644rdID5M0tm6cfZudBluoUYBbZo+C9EdN2611lG9Lj5vObXJ6GXmxr
 rgfJww94G/6PW2jCReoyX8n0FF2fy0UDu8w3IHfH4bcZPz0GtU5CExNSTVfGdxwi0C4ILK
 hGRJGeKrLsKm+1HWtIj0kndsgBx50/Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-GJ4xG0_KOpK5rzbUbAJbnQ-1; Thu, 07 Mar 2024 03:53:11 -0500
X-MC-Unique: GJ4xG0_KOpK5rzbUbAJbnQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-412f18b75faso3958065e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 00:53:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709801590; x=1710406390;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=leZogyP0pvRhSW3XxBaQO1tJMAOXsKR0oZsrSqT5uSo=;
 b=Zs0H9czw/t1KiHvV5DFdKi0PyIAocV2le6VYSX7X0edoU6F5PKe3o+acCFpIaWh5op
 Im4b2O4ae9PN9RkpP+lH2uRTKRQ5I9zbZexljtK586Nq+XDELm1r5Uk6i70WgI3OKROP
 ZC0XSpF0niMcSXWh/OmY4xs+M4Sa8i8h8zpXg/I/eMUe/1fuv9X64Gb0BkqxFJ7nsFct
 ewAHLbIAkN3EA/xQgsP/IWxkSAFEd7Jlsu2z4kdaV+T2YBLajyF5ROcz8XQFgl+kFKK3
 KuoHeXuHLXT/VyasdtPRc7TvLSJ/dOZ3f4qRIgEUSozQDnO6trYKWxqMIfK6AQWQnkgP
 qjJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDJ2FxnWMf/MEEAt3cIIJ8YoFr+lOOeGJOuFPBdCM7RxJLeypXrHSDPKu1im505wUjMqlZaSaTfitwHFvRr017G1kosJ8=
X-Gm-Message-State: AOJu0Yz9MpIT/kvDAbIBzPqjMYg6HNawyG/BDSt1QHkdTp/h2STRJkUc
 AQqWa0lShAfRmqUENq0gNGrgCSfGYpzgnVRmmWxfldNbIm6S1yCwGz9VNaMWQuzoZBpLSduTpTP
 6dydL7kin3I5CehvXYUA64qb2pNwl38icimi8J+ZWiFb5+NI62/iP
X-Received: by 2002:a05:600c:4e8b:b0:412:b83c:d97d with SMTP id
 f11-20020a05600c4e8b00b00412b83cd97dmr13548544wmq.16.1709801590139; 
 Thu, 07 Mar 2024 00:53:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwmWY97HfBAEgmBrmAhKQ2RUuBEb/cX3wSaX2yrVBjUEVLEhkec25LZ/C9Mc1JuYLSfLKO7Q==
X-Received: by 2002:a05:600c:4e8b:b0:412:b83c:d97d with SMTP id
 f11-20020a05600c4e8b00b00412b83cd97dmr13548534wmq.16.1709801589819; 
 Thu, 07 Mar 2024 00:53:09 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a05600c180800b00413011933e6sm1866758wmp.39.2024.03.07.00.53.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 00:53:09 -0800 (PST)
Message-ID: <a1836566-0757-4b1b-84af-228e848c7a48@redhat.com>
Date: Thu, 7 Mar 2024 09:53:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/25] vfio: Add Error** argument to
 vfio_devices_dma_logging_stop()
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-19-clg@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240306133441.2351700-19-clg@redhat.com>
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
> This improves error reporting in the log_global_stop() VFIO handler.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
> 
>  Changes in v4:
> 
>  - Dropped log_global_stop() and log_global_sync() changes
>    
>  Changes in v3:
> 
>  - Use error_setg_errno() in vfio_devices_dma_logging_stop() 
>  
>  hw/vfio/common.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index d6790557da2f2890398fa03dbbef18129cd2c1bb..5b2e6a179cdd5f8ca5be84b7097661e96b391456 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -938,12 +938,14 @@ static void vfio_dirty_tracking_init(VFIOContainerBase *bcontainer,
>      memory_listener_unregister(&dirty.listener);
>  }
>  
> -static void vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
> +static int vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer,
> +                                          Error **errp)
>  {
>      uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
>                                sizeof(uint64_t))] = {};
>      struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
>      VFIODevice *vbasedev;
> +    int ret = 0;
>  
>      feature->argsz = sizeof(buf);
>      feature->flags = VFIO_DEVICE_FEATURE_SET |
> @@ -955,11 +957,17 @@ static void vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
>          }
>  
>          if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
> -            warn_report("%s: Failed to stop DMA logging, err %d (%s)",
> -                        vbasedev->name, -errno, strerror(errno));
> +            /* Keep first error */
> +            if (!ret) {
> +                ret = -errno;
> +                error_setg_errno(errp, errno, "%s: Failed to stop DMA logging",
> +                                 vbasedev->name);
maybe you can keep the previous warn_report in case errp is NULL
(rollback) or for subsequent failures?

Eric
> +            }
>          }
>          vbasedev->dirty_tracking = false;
>      }
> +
> +    return ret;
>  }
>  
>  static struct vfio_device_feature *
> @@ -1068,7 +1076,8 @@ static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
>  
>  out:
>      if (ret) {
> -        vfio_devices_dma_logging_stop(bcontainer);
> +        /* Ignore the potential errors when doing rollback */
> +        vfio_devices_dma_logging_stop(bcontainer, NULL);
>      }
>  
>      vfio_device_feature_dma_logging_start_destroy(feature);
> @@ -1104,7 +1113,7 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
>      int ret = 0;
>  
>      if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
> -        vfio_devices_dma_logging_stop(bcontainer);
> +        ret = vfio_devices_dma_logging_stop(bcontainer, &local_err);
>      } else {
>          ret = vfio_container_set_dirty_page_tracking(bcontainer, false,
>                                                       &local_err);


