Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E01C282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 09:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpkwa-00052Y-SQ; Wed, 05 Mar 2025 04:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpkwW-0004yM-78
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:21:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpkwS-0000cT-VA
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:21:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741166487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7iF5qzP84ZFYLXKA9DITKoJ06JUq4B2/rXcP+mc3QtM=;
 b=LPlbJr2RFv/e3buPIzlW/2wMzNck+hE+jCDp5aRKuTyBHTYM65Oz5K7a5vVNfcPtfzfM/o
 kf/Dnn7vhqoNY4WVBLvipeQd1neL4Tx4r0z33DPWYodTCw5nOOFzqCH4leqEZpCCLvzkBp
 S4xeKRHIGBgeN28vF3LgnQhHfQ/sjxY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-5uv3CCvoM9iuX_besLXFYg-1; Wed, 05 Mar 2025 04:21:16 -0500
X-MC-Unique: 5uv3CCvoM9iuX_besLXFYg-1
X-Mimecast-MFC-AGG-ID: 5uv3CCvoM9iuX_besLXFYg_1741166475
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43943bd1409so47607705e9.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 01:21:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741166474; x=1741771274;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7iF5qzP84ZFYLXKA9DITKoJ06JUq4B2/rXcP+mc3QtM=;
 b=ndaO/fuzl1mg0ZeQrZwLlaZwRp0JgUQ69SYtcm56X4pAprksqtUk2efJdkVbXXY+V5
 4ts7VOLEvYK4nDwWF/ktDF6bWDeWOllQ+pw2fQCOo0Hy28GyJy/LvrnVma45UaaTRo9p
 fAe0aTYggmlvgqrVWfbeaiQy/aDzU9wIdRBfX7hkTFRFxCcphbhvuucO+4jpTra7Yylc
 fThZK2pbLGg9n/QL6KUmcznxoeSgoY/bwZY7NKeXQMQ64RUB6ogOZCtm05rVBgBuHTgU
 UxH6ncGFtFCx64b7m7q7cLPjmMyyjzUzNhJDyHw3GrFqIlwqS8w6yw/rdRtE0dSvbPbK
 GtZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjwiYTi4H1MHlyZJmyQ79PrLNIbq+vwPsAq+exvEevqtm/DwY+6oxsIcsZROvbFTbgUKAFumgTn31F@nongnu.org
X-Gm-Message-State: AOJu0YyzGpvH/BH+Aj33g1ddQggf1XNiVqSERnnN2omdXzGxTwKuXzgt
 TLKwl0H+QvOQap6QgK+MP9zqZJgmlD6e6IgJ0KrpAaPYgakWmwkbwjojaiij8dxG4VJsy4kwrCD
 oBh/qSREn322pq126NThaDj6830bmhtk6ZSkiX2ZBo0VeqT93T1jMyCApMkHuvsk=
X-Gm-Gg: ASbGnctQ3kHr6DhrIc4jCN6RuQNvXI9JKuAKiYRS5lhn75Cf5Vi/QmdvvXl7yQn86bD
 Gp5agkS0iuw66yneHt0FPv48nr+8hEXQI3VJTHv/g5ypGPeZTU8VeNGRPH9jBgLE0W/d6dHgUrc
 EWK/SlLeMDUDomBSiBlVi+gDwaLG8vsa5Gwv8NKZvNeDZAd4zXpjVwYTJUC1Vs/ew6xFDS1GKMb
 OEBtGt0GuqjRnMkshgScKEFKG2+UyXH5QLtunP4eciT8uV2QVJJxuKl+2wE+vl1I8YBcuwasCrT
 orzcVnPhd1vDxXFr58qtXy6J/6M6/FFQ0io9fVyRjy4rMkHo1uqLpg==
X-Received: by 2002:a05:600c:3ba6:b0:439:643a:c8d5 with SMTP id
 5b1f17b1804b1-43bd28a6ce5mr17941555e9.0.1741166474141; 
 Wed, 05 Mar 2025 01:21:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLzFFx0TZog4ClJzN9JYIqOwHCkvKsKrK3kO5S8Ne+Z1D18Facd6BnFn1Quqr8uMbRD9c7xw==
X-Received: by 2002:a05:600c:3ba6:b0:439:643a:c8d5 with SMTP id
 5b1f17b1804b1-43bd28a6ce5mr17941295e9.0.1741166473738; 
 Wed, 05 Mar 2025 01:21:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42c55e6sm11471565e9.23.2025.03.05.01.21.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 01:21:13 -0800 (PST)
Message-ID: <06439595-7691-4fd9-a2b6-52311e523dae@redhat.com>
Date: Wed, 5 Mar 2025 10:21:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 31/36] vfio/migration: Add x-migration-multifd-transfer
 VFIO property
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <d6dbb326e3d53c7104d62c96c9e3dd64e1c7b940.1741124640.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <d6dbb326e3d53c7104d62c96c9e3dd64e1c7b940.1741124640.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 3/4/25 23:03, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> This property allows configuring whether to transfer the particular device
> state via multifd channels when live migrating that device.
> 
> It defaults to AUTO, which means that VFIO device state transfer via
> multifd channels is attempted in configurations that otherwise support it.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/migration-multifd.c   | 18 +++++++++++++++++-
>   hw/vfio/pci.c                 |  8 ++++++++
>   include/hw/vfio/vfio-common.h |  2 ++
>   3 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index bfb9a72fa450..aacddc503bb8 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -476,18 +476,34 @@ bool vfio_multifd_transfer_supported(void)
>   
>   bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev)
>   {
> -    return false;
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    return migration->multifd_transfer;
>   }
>   
>   bool vfio_multifd_setup(VFIODevice *vbasedev, bool alloc_multifd, Error **errp)
>   {
>       VFIOMigration *migration = vbasedev->migration;
>   
> +    if (vbasedev->migration_multifd_transfer == ON_OFF_AUTO_AUTO) {
> +        migration->multifd_transfer = vfio_multifd_transfer_supported();
> +    } else {
> +        migration->multifd_transfer =
> +            vbasedev->migration_multifd_transfer == ON_OFF_AUTO_ON;
> +    }
> +
>       if (!vfio_multifd_transfer_enabled(vbasedev)) {
>           /* Nothing further to check or do */
>           return true;
>       }
>   
> +    if (!vfio_multifd_transfer_supported()) {
> +        error_setg(errp,
> +                   "%s: Multifd device transfer requested but unsupported in the current config",
> +                   vbasedev->name);
> +        return false;
> +    }
> +
>       if (alloc_multifd) {
>           assert(!migration->multifd);
>           migration->multifd = vfio_multifd_new();
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 89d900e9cf0c..6d6f889f59c5 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3377,6 +3377,9 @@ static const Property vfio_pci_dev_properties[] = {
>                       VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>       DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>                               vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_ON_OFF_AUTO("x-migration-multifd-transfer", VFIOPCIDevice,
> +                            vbasedev.migration_multifd_transfer,
> +                            ON_OFF_AUTO_AUTO),
>       DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
>                        vbasedev.migration_events, false),
>       DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
> @@ -3433,6 +3436,11 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>       pdc->exit = vfio_exitfn;
>       pdc->config_read = vfio_pci_read_config;
>       pdc->config_write = vfio_pci_write_config;
> +
> +    object_class_property_set_description(klass, /* 10.0 */
> +                                          "x-migration-multifd-transfer",
> +                                          "Transfer this device state via "
> +                                          "multifd channels when live migrating it");
>   }
>   
>   static const TypeInfo vfio_pci_dev_info = {
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 961931d9f457..04b123a6c929 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -91,6 +91,7 @@ typedef struct VFIOMigration {
>       uint64_t mig_flags;
>       uint64_t precopy_init_size;
>       uint64_t precopy_dirty_size;
> +    bool multifd_transfer;
>       VFIOMultifd *multifd;
>       bool initial_data_sent;
>   
> @@ -153,6 +154,7 @@ typedef struct VFIODevice {
>       bool no_mmap;
>       bool ram_block_discard_allowed;
>       OnOffAuto enable_migration;
> +    OnOffAuto migration_multifd_transfer;
>       bool migration_events;
>       VFIODeviceOps *ops;
>       unsigned int num_irqs;
> 


