Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E830C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 09:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riA4r-0008TM-7B; Thu, 07 Mar 2024 04:30:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1riA4p-0008TC-Dw
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:30:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1riA4n-0006HK-QV
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:30:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709803808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lJ2G7X0LgzcD1SgjxtSfZqXvXj+DhRp6IfmWb62h2Ts=;
 b=fH8wnqs6AXNE1932qjft0eH9ZWgk35l4F/WyZ3WXunjV+GEZpNGv2yXZN3g2r+JVLLiY50
 uw8J6jeiXwQvqN62YCi0oue6VdIQjb1FwD/AkCz8bfbrbxC/iBu7zmfUa557NUp32sMPNJ
 hfTi4LRMDV1n2z45Sat9k4H7K4sdefs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-0s_nFmrfPt2v-GCznRidMw-1; Thu, 07 Mar 2024 04:30:04 -0500
X-MC-Unique: 0s_nFmrfPt2v-GCznRidMw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4130b4b6676so3367885e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 01:30:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709803803; x=1710408603;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lJ2G7X0LgzcD1SgjxtSfZqXvXj+DhRp6IfmWb62h2Ts=;
 b=EXamHU/Auw8Z6mZuNZvu+Z82+We3hd5nO7WP5/1kvnKkW1kK1M40cMjiNK9TMl3k5z
 pCnQ/BUNgeGf8nZyk5ayuFJiTH8l+vpRmDiLs7EF56rkF4qUfrFGUsqT+CbQ9dYH6cQO
 IcBkMudg0k+3LpOh5BLY37fUsKkhjjFUyikonFUgxOvyJ0zWPY78nB7kKr6Htm7iw2B+
 APuGNcXd2/luedrQ3Qqhjaz/1bZQYo1uiL8RTC9LE/NV4hGzfTDRqlEP1h8AuTeXBeeY
 7ga1ZNz2u9e/GIH6AvhCoOYdw6V7beKYUM670etDl6JjT8CCW5a9uODqu0wBO252DLuW
 7btA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFu+ui9AfjpN4lNe8vsYootEnK/JI/XjWjanNHDmTSM2pEONiuXIS2jQYaeDmxT81YH+4o0fu6jdlmbfg/McwzfrgKqM8=
X-Gm-Message-State: AOJu0YwomDIExvv1ev66cdCgbyPaVwr0MLOJlHfkmNJFti3F76ND2qLx
 TfHZqlxDXiBZYUHYqEWvdVkdeM0IcFb3GYdJsC2eWJsxQMw/fFecIv6VIY309bFWEbwGt6RwbNd
 W9WVlh2+q6lNusVcUOu9IEGCtk6hqVYPTeaGddmianwY2aKwC5a3g
X-Received: by 2002:a05:600c:1c23:b0:412:dcae:9c10 with SMTP id
 j35-20020a05600c1c2300b00412dcae9c10mr9752026wms.37.1709803803188; 
 Thu, 07 Mar 2024 01:30:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHT9mQt2gr0IvyINBd7wxCj24nTki/DSrBi8a1hA/9KNtWZwSxW1KSa0lOSd1Dv5d6e5NBGXQ==
X-Received: by 2002:a05:600c:1c23:b0:412:dcae:9c10 with SMTP id
 j35-20020a05600c1c2300b00412dcae9c10mr9752009wms.37.1709803802803; 
 Thu, 07 Mar 2024 01:30:02 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 m21-20020a05600c4f5500b004130db58a97sm1931158wmq.39.2024.03.07.01.30.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 01:30:02 -0800 (PST)
Message-ID: <d1d8f5d6-0f08-48b9-932d-eeee72cffeeb@redhat.com>
Date: Thu, 7 Mar 2024 10:30:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 25/25] vfio: Extend vfio_set_migration_error() with
 Error* argument
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-26-clg@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240306133441.2351700-26-clg@redhat.com>
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
> vfio_set_migration_error() sets the 'return' error on the migration
> stream if a migration is in progress. To improve error reporting, add
> a new Error* argument to also set the Error object on the migration
> stream, if a migration is progress.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
> 
>  Changes in v4:
> 
>  - Dropped log_global_stop() and log_global_sync() changes
>    
>  hw/vfio/common.c | 39 ++++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 65a11dc088524647541db97b7b8d6f07e5044728..e26574617e5ef75c27a84dc9bb13c8f040353b6c 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -148,16 +148,18 @@ bool vfio_viommu_preset(VFIODevice *vbasedev)
>      return vbasedev->bcontainer->space->as != &address_space_memory;
>  }
>  
> -static void vfio_set_migration_error(int err)
> +static void vfio_set_migration_error(int ret, Error *err)
>  {
>      MigrationState *ms = migrate_get_current();
>  
>      if (migration_is_setup_or_active(ms->state)) {
>          WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
>              if (ms->to_dst_file) {
> -                qemu_file_set_error(ms->to_dst_file, err);
> +                qemu_file_set_error_obj(ms->to_dst_file, ret, err);
>              }
>          }
> +    } else {
does that case exist?

Eric
> +        error_report_err(err);
>      }
>  }
>  
> @@ -304,9 +306,10 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>                                  iova, iova + iotlb->addr_mask);
>  
>      if (iotlb->target_as != &address_space_memory) {
> -        error_report("Wrong target AS \"%s\", only system memory is allowed",
> -                     iotlb->target_as->name ? iotlb->target_as->name : "none");
> -        vfio_set_migration_error(-EINVAL);
> +        error_setg(&local_err,
> +                   "Wrong target AS \"%s\", only system memory is allowed",
> +                   iotlb->target_as->name ? iotlb->target_as->name : "none");
> +        vfio_set_migration_error(-EINVAL, local_err);
>          return;
>      }
>  
> @@ -339,11 +342,12 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>          ret = vfio_container_dma_unmap(bcontainer, iova,
>                                         iotlb->addr_mask + 1, iotlb);
>          if (ret) {
> -            error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> -                         "0x%"HWADDR_PRIx") = %d (%s)",
> -                         bcontainer, iova,
> -                         iotlb->addr_mask + 1, ret, strerror(-ret));
> -            vfio_set_migration_error(ret);
> +            error_setg(&local_err,
> +                       "vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> +                       "0x%"HWADDR_PRIx") = %d (%s)",
> +                       bcontainer, iova,
> +                       iotlb->addr_mask + 1, ret, strerror(-ret));
> +            vfio_set_migration_error(ret, local_err);
>          }
>      }
>  out:
> @@ -1125,8 +1129,7 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
>      if (ret) {
>          error_prepend(&local_err,
>                        "vfio: Could not stop dirty page tracking - ");
> -        error_report_err(local_err);
> -        vfio_set_migration_error(ret);
> +        vfio_set_migration_error(ret, local_err);
>      }
>  }
>  
> @@ -1243,14 +1246,14 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>      trace_vfio_iommu_map_dirty_notify(iova, iova + iotlb->addr_mask);
>  
>      if (iotlb->target_as != &address_space_memory) {
> -        error_report("Wrong target AS \"%s\", only system memory is allowed",
> -                     iotlb->target_as->name ? iotlb->target_as->name : "none");
> +        error_setg(&local_err,
> +                   "Wrong target AS \"%s\", only system memory is allowed",
> +                   iotlb->target_as->name ? iotlb->target_as->name : "none");
>          goto out;
>      }
>  
>      rcu_read_lock();
>      if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
> -        error_report_err(local_err);
>          goto out_lock;
>      }
>  
> @@ -1261,7 +1264,6 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>                        "vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
>                        "0x%"HWADDR_PRIx") failed :", bcontainer, iova,
>                        iotlb->addr_mask + 1);
> -        error_report_err(local_err);
>      }
>  
>  out_lock:
> @@ -1269,7 +1271,7 @@ out_lock:
>  
>  out:
>      if (ret) {
> -        vfio_set_migration_error(ret);
> +        vfio_set_migration_error(ret, local_err);
>      }
>  }
>  
> @@ -1389,8 +1391,7 @@ static void vfio_listener_log_sync(MemoryListener *listener,
>      if (vfio_devices_all_dirty_tracking(bcontainer)) {
>          ret = vfio_sync_dirty_bitmap(bcontainer, section, &local_err);
>          if (ret) {
> -            error_report_err(local_err);
> -            vfio_set_migration_error(ret);
> +            vfio_set_migration_error(ret, local_err);
>          }
>      }
>  }


