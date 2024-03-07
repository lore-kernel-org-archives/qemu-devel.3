Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0708C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 08:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri8oW-0005Cw-QC; Thu, 07 Mar 2024 03:09:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1ri8oS-00058x-Mu
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 03:09:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1ri8oO-0006pu-LD
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 03:09:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709798946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pzAWm958cd5iL7lRYHiHYf7ezJdqkP5u+o9xCGtfjIw=;
 b=TRzbbRLTQGyet9FFwI1sB2Jg8jE1wnH7SNa1LoOxjJyGk1bUcVDJS7VmsT7k6eWw41uSf9
 8ZpjbiH3102yqY4+svcXnLVGGxXiFjmTEjInXTcZcMnGZnehwpPZzvGxLqHVtxVersIzYp
 gt7TMwGXgzv930i7tjdOcgK5nibunfo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-Dq1SU0GGNbeXPnbdK3lODA-1; Thu, 07 Mar 2024 03:09:04 -0500
X-MC-Unique: Dq1SU0GGNbeXPnbdK3lODA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33d308b0c76so875939f8f.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 00:09:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709798943; x=1710403743;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pzAWm958cd5iL7lRYHiHYf7ezJdqkP5u+o9xCGtfjIw=;
 b=fORiZTfgZ5M7n+8aeI9QoNn5gr3U9mNwNdtsV770WChSLvToHNL6Fxfs41qHpy9Csj
 SqBk+/lygj10oYTX1u/OVcpfZNM2bYAETVbCQMnMeNaTigW2hsfiJAtPKyVIcWMeuXII
 pKqiMQGqVAJVwzX98zR16VJ5P5TuxNvdf5W3IRFcAbBq9nslyhzqR2MXbq3aZCxPgoH1
 Onif6ZQI/AN+rt3LYm71SMMB2l6psFcSruj/6lkLgj+eoBtPhMmccG/6p0qYq35HsaEb
 ByQi3hQBeSoU6gZp97vl5B6J2QmtPstQTSMhZb7h8v48Kyu+iFIpeqLYOHOY9vInP6o8
 UZWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCtiE2Q3NTlsrDzotDfV2z5Ia/xvWRu17/qUoLiUt5RwIYk7ycK+QYFi3GXvckglaeCgU/fKjc0aL5fUpIuP36+a81SOM=
X-Gm-Message-State: AOJu0Yw5M0AC5pQMc9DAEWF3ZDNxN8jhAzCJ/MTV3p/kUn+jR5sRiMsO
 qdCTXohoJgfi7dpS7KmXo6BjtEEzYD9dvKgJE2AyS4enKrR8P0AAgVGHFZ5ifLRaxz3RWlsygDD
 OGg0Y8WogSOcjW58C60mcNxp7Onw0R+1deEjVqE/JQ7IKLgNgdRma
X-Received: by 2002:adf:a111:0:b0:33e:6a81:d8b9 with SMTP id
 o17-20020adfa111000000b0033e6a81d8b9mr269842wro.20.1709798943456; 
 Thu, 07 Mar 2024 00:09:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjEZrk2dezyu94N53RJJ06N200keWc4DvwcsFF4uiXVeCUow6V1GhMS6ip6E+Ec3g015E+bg==
X-Received: by 2002:adf:a111:0:b0:33e:6a81:d8b9 with SMTP id
 o17-20020adfa111000000b0033e6a81d8b9mr269814wro.20.1709798943061; 
 Thu, 07 Mar 2024 00:09:03 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 bt12-20020a056000080c00b0033e3a110d7fsm11354225wrb.71.2024.03.07.00.09.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 00:09:02 -0800 (PST)
Message-ID: <9250446e-c48b-4465-b50c-da4fe3c1ee2f@redhat.com>
Date: Thu, 7 Mar 2024 09:09:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/25] vfio: Add Error** argument to
 .set_dirty_page_tracking() handler
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-17-clg@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240306133441.2351700-17-clg@redhat.com>
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
> We will use the Error object to improve error reporting in the
> .log_global*() handlers of VFIO. Add documentation while at it.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
> 
>  Changes in v3:
> 
>  - Use error_setg_errno() in vfio_legacy_set_dirty_page_tracking()
>  
>  include/hw/vfio/vfio-container-base.h | 18 ++++++++++++++++--
>  hw/vfio/common.c                      |  4 ++--
>  hw/vfio/container-base.c              |  4 ++--
>  hw/vfio/container.c                   |  6 +++---
>  4 files changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 3582d5f97a37877b2adfc0d0b06996c82403f8b7..c76984654a596e3016a8cf833e10143eb872e102 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -82,7 +82,7 @@ int vfio_container_add_section_window(VFIOContainerBase *bcontainer,
>  void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>                                         MemoryRegionSection *section);
>  int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
> -                                           bool start);
> +                                           bool start, Error **errp);
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
> +     *              pages tracking
s/pages/page?
for my education is the "#"VFIOContainerBase formalized somewhere?
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
> index 800ba0aeac84b8dcc83b042bb70c37b4bf78d3f4..5598a508399a6c0b3a20ba17311cbe83d84250c5 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1085,7 +1085,7 @@ static bool vfio_listener_log_global_start(MemoryListener *listener,
>      if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>          ret = vfio_devices_dma_logging_start(bcontainer);
>      } else {
> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, true);
> +        ret = vfio_container_set_dirty_page_tracking(bcontainer, true, NULL);
It is not obvious why we don't pass errp here. Also there is ana
error_report below. Why isn't the error propagated? (not related to your
patch though)
>      }
>  
>      if (ret) {
> @@ -1105,7 +1105,7 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
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
> index 096d77eac3946a9c38fc2a98116b93353f71f06e..6524575aeddcea8470b5fd10caf57475088d1813 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -210,7 +210,7 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>  
>  static int
>  vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
> -                                    bool start)
> +                                    bool start, Error **errp)
>  {
>      const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>                                                    bcontainer);
> @@ -228,8 +228,8 @@ vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
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

Thanks

Eric


