Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB91C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 08:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri8vN-0006dY-5W; Thu, 07 Mar 2024 03:16:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1ri8vL-0006dI-TH
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 03:16:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1ri8vK-0000Cd-DQ
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 03:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709799377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2yMiKMtmMVftqLwMOBnCBmtmD3tcvf981fV8t7JBWnk=;
 b=bBjwV4hLeTwRVZR90ZavKl0GBex/ErRuynhd8nUKuxyklSuYYTxPHzOHCpK/6kFg2YnS9b
 QMwNQtD8Y0pNKTvU+IsCLMMgWSk8cqNuO3tgEPiCOpLLVnmcUCu7g3XWnz0LPf9hqOOUYJ
 8JoY8trucLGkrc9LJhHh3yk/1AYRAEI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-VlyzwXRTNjqh7XlhpoKtWw-1; Thu, 07 Mar 2024 03:16:15 -0500
X-MC-Unique: VlyzwXRTNjqh7XlhpoKtWw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-412e79148d8so4829465e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 00:16:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709799375; x=1710404175;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2yMiKMtmMVftqLwMOBnCBmtmD3tcvf981fV8t7JBWnk=;
 b=ATBWr3K19VJp+dgTeepZaWYRIdzXRCrbWZ0d8rTukloHjD0crk0rKatOiYYyfB5p4I
 kpjAxoBSXjNV7nqtmr1kBM+YMCnGSwGZOxtITWuHoHBVOvfALj7imo9r7bytSo/MT+d5
 nOQxUapDbN1VFO8yY+rnfGn46fRDnHtXD21m5tJ97rE41aACuxVK+/PhHwAfJsrRsKXx
 /0t0kPheGx7bnkaYeSPU2SgUkQ5nRRC99U1JwjsfFOVnYAzLzjl6EwCNVrS1g03+ld89
 IOLTVFp8t49/gA5wgnmUBUfDv3ts3OYK/IQG90Nau2U8/roxqYdyddjGIcuhNCv+JewJ
 ffTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9TgiDHr2mT1/qzgpC4wcQP95lNK6rXjLaksbeUi50L/4sVW8jMYiMVwc2rrCkGCgYPEaqcda/5zKjDHHoySe2+vVb/4k=
X-Gm-Message-State: AOJu0YxIbBdPzCp0e/eHvLw3m85o22ip5XfcTkbpP4IeC8wTXJ7mUKuC
 wdtOPaFmmIpgPygBu4DXZEMzSQkNkF3q3gE6nqyU14Lx/FecH+ya38x9KR1rFoGJMLvZiV4mlep
 Eox41HccJaZZgPJBftarN+eZsztSzakePMT4+IHZGOIm5m9AY2C8Q
X-Received: by 2002:a05:600c:c14:b0:412:f5e9:3f6 with SMTP id
 fm20-20020a05600c0c1400b00412f5e903f6mr2616756wmb.21.1709799374852; 
 Thu, 07 Mar 2024 00:16:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAAX1SxARqEP63jxkRqej+eRDeEN/CCCp6cSFvyKZf6EcajByrZxP4sFLtBnu4pHtio3XkJg==
X-Received: by 2002:a05:600c:c14:b0:412:f5e9:3f6 with SMTP id
 fm20-20020a05600c0c1400b00412f5e903f6mr2616747wmb.21.1709799374537; 
 Thu, 07 Mar 2024 00:16:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 bu28-20020a056000079c00b0033dc7e50488sm20069192wrb.96.2024.03.07.00.16.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 00:16:13 -0800 (PST)
Message-ID: <43a4b87e-cfa6-4d5d-884f-e4307d9b5fc5@redhat.com>
Date: Thu, 7 Mar 2024 09:15:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/25] vfio: Add Error** argument to
 vfio_devices_dma_logging_start()
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-18-clg@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240306133441.2351700-18-clg@redhat.com>
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

Hi Cédric,

On 3/6/24 14:34, Cédric Le Goater wrote:
> This allows to update the Error argument of the VFIO log_global_start()
> handler. Errors detected when device level logging is started will be
> propagated up to qemu_savevm_state_setup() when the ram save_setup()
> handler is executed.
> 
> The vfio_set_migration_error() call becomes redundant. Remove it.
you may precise it becomes redundant in vfio_listener_log_global_start()
because it is kept in vfio_listener_log_global_stop
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
>  - Use error_setg_errno() in vfio_devices_dma_logging_start() 
>  - ERRP_GUARD() because of error_prepend use in
>    vfio_listener_log_global_start()
>    
>  hw/vfio/common.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 5598a508399a6c0b3a20ba17311cbe83d84250c5..d6790557da2f2890398fa03dbbef18129cd2c1bb 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1036,7 +1036,8 @@ static void vfio_device_feature_dma_logging_start_destroy(
>      g_free(feature);
>  }
>  
> -static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer)
> +static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
> +                                          Error **errp)
>  {
>      struct vfio_device_feature *feature;
>      VFIODirtyRanges ranges;
> @@ -1058,8 +1059,8 @@ static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer)
>          ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
>          if (ret) {
>              ret = -errno;
there is another case of error if !feature. Don't we want t o set errp
in that case as well?
I think in general we should try to make the return value and the errp
consistent because the caller may try to exploit the errp in case or
negative returned value.
> -            error_report("%s: Failed to start DMA logging, err %d (%s)",
> -                         vbasedev->name, ret, strerror(errno));
> +            error_setg_errno(errp, errno, "%s: Failed to start DMA logging",
> +                             vbasedev->name);
>              goto out;
>          }
>          vbasedev->dirty_tracking = true;
> @@ -1078,20 +1079,19 @@ out:
>  static bool vfio_listener_log_global_start(MemoryListener *listener,
>                                             Error **errp)
>  {
> +    ERRP_GUARD(); /* error_prepend use */
>      VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
>                                                   listener);
>      int ret;
>  
>      if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
> -        ret = vfio_devices_dma_logging_start(bcontainer);
> +        ret = vfio_devices_dma_logging_start(bcontainer, errp);
>      } else {
> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, true, NULL);
> +        ret = vfio_container_set_dirty_page_tracking(bcontainer, true, errp);
>      }
>  
>      if (ret) {
> -        error_report("vfio: Could not start dirty page tracking, err: %d (%s)",
> -                     ret, strerror(-ret));
> -        vfio_set_migration_error(ret);
> +        error_prepend(errp, "vfio: Could not start dirty page tracking - ");
>      }
>      return !ret;
>  }
> @@ -1100,17 +1100,20 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
>  {
>      VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
>                                                   listener);
> +    Error *local_err = NULL;
>      int ret = 0;
>  
>      if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>          vfio_devices_dma_logging_stop(bcontainer);
>      } else {
> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, false, NULL);
> +        ret = vfio_container_set_dirty_page_tracking(bcontainer, false,
> +                                                     &local_err);
>      }
>  
>      if (ret) {
> -        error_report("vfio: Could not stop dirty page tracking, err: %d (%s)",
> -                     ret, strerror(-ret));
> +        error_prepend(&local_err,
> +                      "vfio: Could not stop dirty page tracking - ");
> +        error_report_err(local_err);
>          vfio_set_migration_error(ret);
>      }
>  }
Eric


