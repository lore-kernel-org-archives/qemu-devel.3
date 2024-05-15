Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91533C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 06:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78Wg-00012E-0H; Wed, 15 May 2024 02:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1s78We-00011u-9f
 for qemu-devel@nongnu.org; Wed, 15 May 2024 02:54:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1s78Wc-0007zW-9t
 for qemu-devel@nongnu.org; Wed, 15 May 2024 02:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715756045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2qC2IcdQmDKtSdNPEecfW69rVC7ptcaxynS4005GSvM=;
 b=bfrSdhSqDCxrzCNP0PIUU1C2dmzGTApYMMZFEr+4HRnQNoB3juKtJCFj1oaLaLr/24bOe3
 /r0NyuNVejzLA4ZQL+qQeicDsTQ/XTqSie9yG3xT2v3vMtypokl4EIm8jl5n40/dvdC6Hl
 LeLuoSzLytNdRdxJLGm8uuNC1HIngo4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-SYLcvqlwMv2nRVzHL7JXaQ-1; Wed, 15 May 2024 02:54:02 -0400
X-MC-Unique: SYLcvqlwMv2nRVzHL7JXaQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6a097848a56so61430936d6.0
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 23:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715756042; x=1716360842;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2qC2IcdQmDKtSdNPEecfW69rVC7ptcaxynS4005GSvM=;
 b=B6hubRqkqDcQCBO+6y0NnJok+9xRikjE22gsFNFBzu8oWn7sVQKRMnAH7B9uJBGqx6
 5HFZq7A7Zpe8dceYdM6IJH2l9xA1qoBc3/x+kXvWmQNOKMVyrtGcLZcisCN13XMVAA50
 DI0yGUW7gyRtMTbOq1g3ZzP0zkJi8f+ku2kwl+j1Jn8WMPnv251fv8G/jMUP/u8S9DE+
 j716J2vhTtZkfwbC1w0TUAHOyhL1pO01Hig7J9pWDumkwiAnYYOOu+TyGZA/xuZr9k/i
 feExcWzXeFbhY02IiLzEaYIudBuZG40v4GJ91WVLTMB0P0SZPfEcDb6dDOvnJsj4S7yn
 UuVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTxSXljYF8+5X1KSMibxbhgwWmt1ymxwEWG1Tzao0FDXfctNC9ZVeW1AT63N01KYSLc7keDNTcEVrHDkof3PIHz8O45CA=
X-Gm-Message-State: AOJu0Yxt99Fa/kXwFiwCL7ahIcCkISqmXC7OejO+jDsYXhqeLuIsM7ZQ
 Dv4+4XYNjakrBdw4rVZUBvNIOk8VKEmehuUqab68EAPKmffTdKEZlRAIBT5rLp6grOCfGv4r4dN
 aHcGgqd3bSZ0FTZX1vHDacUs7DV+9j7y8IvHOOdhi9CNynfvMu+aL
X-Received: by 2002:a05:6214:3d8d:b0:6a0:b9bf:3cb3 with SMTP id
 6a1803df08f44-6a1681da9a9mr193088386d6.34.1715756042266; 
 Tue, 14 May 2024 23:54:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSnaZqXphZp7aO0jVCaP5K4aXc7TCICRH3SoiVUMbRAcvPLwacLgrfNZJf7e20G4ZIvfDclg==
X-Received: by 2002:a05:6214:3d8d:b0:6a0:b9bf:3cb3 with SMTP id
 6a1803df08f44-6a1681da9a9mr193088256d6.34.1715756041933; 
 Tue, 14 May 2024 23:54:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1cd3desm61529896d6.88.2024.05.14.23.53.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 23:54:01 -0700 (PDT)
Message-ID: <9cb94f2a-7274-45c7-b440-75b9a537e533@redhat.com>
Date: Wed, 15 May 2024 08:53:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/9] vfio: Add Error** argument to
 vfio_devices_dma_logging_start()
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>
References: <20240514153130.394307-1-clg@redhat.com>
 <20240514153130.394307-3-clg@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240514153130.394307-3-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
On 5/14/24 17:31, Cédric Le Goater wrote:
> This allows to update the Error argument of the VFIO log_global_start()
> handler. Errors for container based logging will also be propagated to
> qemu_savevm_state_setup() when the ram save_setup() handler is executed.
nit: also now collect & print errors from
vfio_container_set_dirty_page_tracking()
> 
> The vfio_set_migration_error() call becomes redundant in
> vfio_listener_log_global_start(). Remove it.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Avihai Horon <avihaih@nvidia.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
> 
>  Changes in v6:
> 
>  - Commit log improvements (Avihai)
>  
>  Changes in v5:
> 
>  - Used error_setg_errno() in vfio_devices_dma_logging_start()
>  
>  hw/vfio/common.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 485e53916491f1164d29e739fb7106c0c77df737..b5102f54a6474a50c6366e8fbce23812d55e384e 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1027,7 +1027,8 @@ static void vfio_device_feature_dma_logging_start_destroy(
>      g_free(feature);
>  }
>  
> -static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer)
> +static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
> +                                          Error **errp)
>  {
>      struct vfio_device_feature *feature;
>      VFIODirtyRanges ranges;
> @@ -1038,6 +1039,7 @@ static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer)
>      feature = vfio_device_feature_dma_logging_start_create(bcontainer,
>                                                             &ranges);
>      if (!feature) {
> +        error_setg_errno(errp, errno, "Failed to prepare DMA logging");
>          return -errno;
>      }
>  
> @@ -1049,8 +1051,8 @@ static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer)
>          ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
>          if (ret) {
>              ret = -errno;
> -            error_report("%s: Failed to start DMA logging, err %d (%s)",
> -                         vbasedev->name, ret, strerror(errno));
> +            error_setg_errno(errp, errno, "%s: Failed to start DMA logging",
> +                             vbasedev->name);
>              goto out;
>          }
>          vbasedev->dirty_tracking = true;
> @@ -1069,20 +1071,19 @@ out:
>  static bool vfio_listener_log_global_start(MemoryListener *listener,
>                                             Error **errp)
>  {
> +    ERRP_GUARD();
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
> @@ -1091,17 +1092,20 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
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

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


