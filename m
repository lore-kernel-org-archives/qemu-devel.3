Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7156DC2BA18
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 11:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJAaK-0003h1-Rj; Mon, 17 Jun 2024 07:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJAaH-0003gW-GA
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 07:31:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJAaE-0004At-Pp
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 07:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718623893;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XLJWGJ4JOZIZGVtYZby1/Jc9YM7udL2uvwBFx1ecEvQ=;
 b=JSw1cwBQ62iqHrNicuaU8NDw668IXPFYUlYePvUtgfYH4fSYa8jq5jE4YIP636oHIncJ2U
 Ts/FwyF6SCIn611X7gofLJbdUzvs+jZ5LnfVEd5Y7tiMdNHmEuqL8YAehkDpjqwfS0O0uf
 yKGmOrIhb0BE4eJe5wAtDos/B97C0Is=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-jE2samdxNk-W1_xwj-knSw-1; Mon, 17 Jun 2024 07:31:31 -0400
X-MC-Unique: jE2samdxNk-W1_xwj-knSw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-35f06558bc3so2859564f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 04:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718623890; x=1719228690;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XLJWGJ4JOZIZGVtYZby1/Jc9YM7udL2uvwBFx1ecEvQ=;
 b=pT3Hm79VB0jGarNWGayLsKWxIrHiOxBRjc38QPGcrG7hHW/loKWj/ktouzmulizP4T
 8nkRm+sMCqrazmy0sLeosHb1vrlcwPX/UfgxgvbVw6cpG8tMm4pClMfW/kY28sCGNNUC
 A2YI1hcA+tVJ3f5CrHpDvXCoMIYNIzM9Oo9FWSx+mnzF4gQWxRA93FtNtO11arM5cVgZ
 XQ7notdvpqpdDsouVbslpQyIJl2sYym/kNRwPOhRHy7hWMuR6prLoEjxFYSwdUmyDYkv
 hbuofo+tWWnfVgVbOiAOyv3uYKcrvHCFq4mNdTucdnTHUdtkHFj5Hl5JmmObo3ArnE/c
 zXyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK1X84/lb8j7GE1vKHIDzZqnXeubgXdPaqwSs2xIFRmGNtI3WMf4hEXtqYwEGONSsaSM5ESatiEVmaNKNfirTy3cs4vbE=
X-Gm-Message-State: AOJu0Yza0iDzZMKmGXFCoGE3u0KH+N21Uvq04/Qem2qWXH9+m8p92hyp
 cJo1CyiUSPpsrHnL3fhf+QnFcbEgCO5y26Qk9/m2k6mfZwWwYhkHQbfD6q4WszlxUoAVedVdjS5
 pzCVnzFhgYThtN5/zjuhT+PeCoRCbtusvYoauOHuaniZG0q7M4Cwu
X-Received: by 2002:adf:e68d:0:b0:35f:2935:7d04 with SMTP id
 ffacd0b85a97d-3607a7817f8mr6724806f8f.59.1718623890515; 
 Mon, 17 Jun 2024 04:31:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrdi+/NlC3TpU/f2iB703Fks+qQ8GsR5TJC4kX+TNA8UGUMghprPfdRx97j73z2SVrZnCa+w==
X-Received: by 2002:adf:e68d:0:b0:35f:2935:7d04 with SMTP id
 ffacd0b85a97d-3607a7817f8mr6724793f8f.59.1718623890140; 
 Mon, 17 Jun 2024 04:31:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36079d78ce2sm10403350f8f.19.2024.06.17.04.31.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 04:31:29 -0700 (PDT)
Message-ID: <a1c5811d-f376-483f-8ab4-e09ca8f874b6@redhat.com>
Date: Mon, 17 Jun 2024 13:31:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/17] vfio: Make vfio_devices_dma_logging_start()
 return bool
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240617063409.34393-1-clg@redhat.com>
 <20240617063409.34393-2-clg@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240617063409.34393-2-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Cédric,

On 6/17/24 08:33, Cédric Le Goater wrote:
> Since vfio_devices_dma_logging_start() takes an 'Error **' argument,
> best practices suggest to return a bool. See the api/error.h Rules
> section. It will simplify potential changes coming after.


As I already mentionned the Rules section does not say that, as far as I
understand:
It is allowed to either return a bool, a pointer-value, an integer,
along with an error handle:

"
 *   • bool-valued functions return true on success / false on failure,
 *   • pointer-valued functions return non-null / null pointer, and
 *   • integer-valued functions return non-negative / negative.
"

Personally I don't like much returning a bool as I think it rather
complexifies the code and to me that kind of change is error prone.



>
> vfio_container_set_dirty_page_tracking() could be modified in the same
> way but the errno value can be saved in the migration stream when
> called from vfio_listener_log_global_stop().
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/common.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 9e4c0cc95ff90209d3e8184035af0806a2bf890b..d48cd9b9361a92d184e423ffc60aabaff40fb487 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1020,7 +1020,7 @@ static void vfio_device_feature_dma_logging_start_destroy(
>      g_free(feature);
>  }
>  
> -static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
> +static bool vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
>                                            Error **errp)
>  {
>      struct vfio_device_feature *feature;
> @@ -1033,7 +1033,7 @@ static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
>                                                             &ranges);
>      if (!feature) {
>          error_setg_errno(errp, errno, "Failed to prepare DMA logging");
> -        return -errno;
> +        return false;
>      }
>  
>      QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
> @@ -1058,7 +1058,7 @@ out:
>  
>      vfio_device_feature_dma_logging_start_destroy(feature);
>  
> -    return ret;
> +    return ret == 0;
>  }
>  
>  static bool vfio_listener_log_global_start(MemoryListener *listener,
> @@ -1067,18 +1067,18 @@ static bool vfio_listener_log_global_start(MemoryListener *listener,
>      ERRP_GUARD();
>      VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
>                                                   listener);
> -    int ret;
> +    bool ret;
>  
>      if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>          ret = vfio_devices_dma_logging_start(bcontainer, errp);
>      } else {
> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, true, errp);
> +        ret = vfio_container_set_dirty_page_tracking(bcontainer, true, errp) == 0;

why vfio_container_set_dirty_page_tracking(bcontainer, true, errp) doesn't return a bool then?

Eric

>      }
>  
> -    if (ret) {
> +    if (!ret) {
>          error_prepend(errp, "vfio: Could not start dirty page tracking - ");
>      }
> -    return !ret;
> +    return ret;
>  }
>  
>  static void vfio_listener_log_global_stop(MemoryListener *listener)


