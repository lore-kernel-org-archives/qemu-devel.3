Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231B0C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 06:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78JJ-0004q1-Ld; Wed, 15 May 2024 02:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1s78JH-0004pi-Qu
 for qemu-devel@nongnu.org; Wed, 15 May 2024 02:40:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1s78JF-0007vq-NN
 for qemu-devel@nongnu.org; Wed, 15 May 2024 02:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715755215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1PKvOs9aWvFdO2K60ygG9X7ogKOO6MbcYfEwNs4xcU4=;
 b=HK97kHDbmWzxIKMp9sJVMWdeFLqyfafBbJg1QVRSRjJ9DaojBoVw4hBm3b4pfkiScQmKtv
 K8blFiIp6QCdSnnJm0YXiz72+PsgZWNIGTYlFe6fTwjTPHrKZ8aOzinBi6QYlrCK6+8QQe
 EzW1IkEn7mhPkTu/OX0qjW+6ZV8yIKM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-13vJcDTROfCd9BaJfeFafA-1; Wed, 15 May 2024 02:40:14 -0400
X-MC-Unique: 13vJcDTROfCd9BaJfeFafA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-43de2f59d09so78478551cf.0
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 23:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715755214; x=1716360014;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1PKvOs9aWvFdO2K60ygG9X7ogKOO6MbcYfEwNs4xcU4=;
 b=bj6Yj4U7tsTNjFeMd0ljoLXK1IF9DJQppVTHCxsvucKKmtoca5FBWr4FOhR1EZNRm3
 2iEfqPArShVgxRzpM3hMklFVhsVLHBgjUrChzn8QS5iJulzoEYjWyfd/uZ47RaJCrNZV
 sKnxb57BNAxq5Hpbu5AQLWqvBV2gDiNFQF9MzBcLC4mU8lbTR2lQl5PgraMMZ/L9D1XR
 4pzupJ+qynNDmIcTtGiyqh2dzXXmmGSWISJPtf0BlFfhth2KjV5Xxey2TMSIj/dzHLAa
 iYma3UumspLIPK/7yq2orn18veFDRmt2D6qD6acOFpL0z5h75146L2youbO1Qqvu58sF
 sjOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW8oSqqjaY2EsT6jFL9fBG2QGrKajADoxG4quhu7rBsI8kTsorRzCU1Z6NRRBVZQ0ed7wk6g6tfAgz5HpGoe6AcunhpRw=
X-Gm-Message-State: AOJu0YzeexWAmm5XgA08rM+CVHLrnFC76XVY+B171Rtbr27wPeA5TgvV
 4hlrY9DUAdz+CfEetDDA5EvwW04e6vjzAqAC5pUGlQZ7N0Z5qpdKxOHb1ON/kqPAzJuharQ1wiA
 QoqP1xcSsEDbnaWKMBsuMsFcukIPj06l9xWhXERTTIXBNLekB359U
X-Received: by 2002:a05:622a:588:b0:43a:4bb7:409a with SMTP id
 d75a77b69052e-43dfdae12ecmr153185391cf.19.1715755212328; 
 Tue, 14 May 2024 23:40:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGldppruuqm3OchWyFeD/FgCiuCQMY1o3+qtfnLOgfIJSY77OlFNWlHl6fK9JZBuOt4xPNPHg==
X-Received: by 2002:a05:622a:588:b0:43a:4bb7:409a with SMTP id
 d75a77b69052e-43dfdae12ecmr153185131cf.19.1715755211707; 
 Tue, 14 May 2024 23:40:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43e15b37e83sm40013861cf.1.2024.05.14.23.40.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 23:40:10 -0700 (PDT)
Message-ID: <123206c7-37e0-4e0a-9e04-49ed3f0cbc15@redhat.com>
Date: Wed, 15 May 2024 08:40:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/9] vfio: Add Error** argument to
 .set_dirty_page_tracking() handler
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>
References: <20240514153130.394307-1-clg@redhat.com>
 <20240514153130.394307-2-clg@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240514153130.394307-2-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
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

Hi Cédric,

On 5/14/24 17:31, Cédric Le Goater wrote:
> We will use the Error object to improve error reporting in the
> .log_global*() handlers of VFIO. Add documentation while at it.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Avihai Horon <avihaih@nvidia.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>  Changes in v5:
> 
>  - Fixed typo in set_dirty_page_tracking documentation
>  
>  include/hw/vfio/vfio-container-base.h | 18 ++++++++++++++++--
>  hw/vfio/common.c                      |  4 ++--
>  hw/vfio/container-base.c              |  4 ++--
>  hw/vfio/container.c                   |  6 +++---
>  4 files changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 3582d5f97a37877b2adfc0d0b06996c82403f8b7..326ceea52a2030eec9dad289a9845866c4a8c090 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -82,7 +82,7 @@ int vfio_container_add_section_window(VFIOContainerBase *bcontainer,
>  void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>                                         MemoryRegionSection *section);
>  int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
> -                                           bool start);
> +                                           bool start, Error **errp);
I am a bit confused now wrt [PATCH v2 03/11] vfio: Make
VFIOIOMMUClass::attach_device() and its wrapper return bool & co

Shall we return a bool or a int?

Looking at ./include/qapi/error.h I have not found any stringent requirement

 * - Whenever practical, also return a value that indicates success /
 *   failure.  This can make the error checking more concise, and can
 *   avoid useless error object creation and destruction.  Note that
 *   we still have many functions returning void.  We recommend
 *   • bool-valued functions return true on success / false on failure,
 *   • pointer-valued functions return non-null / null pointer, and
 *   • integer-valued functions return non-negative / negative.



>  int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                                        VFIOBitmap *vbmap,
>                                        hwaddr iova, hwaddr size);
> @@ -121,9 +121,23 @@ struct VFIOIOMMUClass {
>      int (*attach_device)(const char *name, VFIODevice *vbasedev,
>                           AddressSpace *as, Error **errp);
>      void (*detach_device)(VFIODevice *vbasedev);
> +
>      /* migration feature */
> +
> +    /**
> +     * @set_dirty_page_tracking
> +     *
> +     * Start or stop dirty pages tracking on VFIO container
> +     *
> +     * @bcontainer: #VFIOContainerBase on which to de/activate dirty
> +     *              page tracking
> +     * @start: indicates whether to start or stop dirty pages tracking
> +     * @errp: pointer to Error*, to store an error if it happens.
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
>      int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
> -                                   bool start);
> +                                   bool start, Error **errp);
>      int (*query_dirty_bitmap)(const VFIOContainerBase *bcontainer,
>                                VFIOBitmap *vbmap,
>                                hwaddr iova, hwaddr size);
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 8f9cbdc0264044ce587877a7d19d14b28527291b..485e53916491f1164d29e739fb7106c0c77df737 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1076,7 +1076,7 @@ static bool vfio_listener_log_global_start(MemoryListener *listener,
>      if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>          ret = vfio_devices_dma_logging_start(bcontainer);
>      } else {
> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, true);
> +        ret = vfio_container_set_dirty_page_tracking(bcontainer, true, NULL);
>      }
>  
>      if (ret) {
> @@ -1096,7 +1096,7 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
>      if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>          vfio_devices_dma_logging_stop(bcontainer);
>      } else {
> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, false);
> +        ret = vfio_container_set_dirty_page_tracking(bcontainer, false, NULL);
>      }
>  
>      if (ret) {
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 913ae49077c4f09b7b27517c1231cfbe4befb7fb..7c0764121d24b02b6c4e66e368d7dff78a6d65aa 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -53,14 +53,14 @@ void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>  }
>  
>  int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
> -                                           bool start)
> +                                           bool start, Error **errp)
>  {
>      if (!bcontainer->dirty_pages_supported) {
>          return 0;
>      }
>  
>      g_assert(bcontainer->ops->set_dirty_page_tracking);
> -    return bcontainer->ops->set_dirty_page_tracking(bcontainer, start);
> +    return bcontainer->ops->set_dirty_page_tracking(bcontainer, start, errp);
>  }
>  
>  int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 77bdec276ec49cb9cd767c0de42ec801b4421572..c35221fbe7dc5453050f97cd186fc958e24f28f7 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -209,7 +209,7 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>  
>  static int
>  vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
> -                                    bool start)
> +                                    bool start, Error **errp)
>  {
>      const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>                                                    bcontainer);
> @@ -227,8 +227,8 @@ vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
>      ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, &dirty);
>      if (ret) {
>          ret = -errno;
> -        error_report("Failed to set dirty tracking flag 0x%x errno: %d",
> -                     dirty.flags, errno);
> +        error_setg_errno(errp, errno, "Failed to set dirty tracking flag 0x%x",
> +                         dirty.flags);
>      }
>  
>      return ret;

Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric




