Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F22C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 19:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpZHF-0007tB-Dm; Wed, 27 Mar 2024 15:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rpZHE-0007t3-3A
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 15:49:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rpZHC-0000gF-G3
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 15:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711568973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VGP1nbUwob6qnOGuCJrd2CfKx4tjNYD9uguN5Z08Jp4=;
 b=NnhNcClkQ4GdaVReieFyP8FP6v1TSgWSo54m1rRmJHtL72u50cKJPU3ZROYlDvGiFYyrpR
 3IGRw6PGbvtDfsISc+8DvWyYNRbsSDL418KrDf2CH/2swrqYEIsB1tlT1eU2ewJbpSZPqq
 zKzjAQDrfu6vsAXHznKUXex/i6kaIDA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-cedrxm-TMpqCD1FbcEN1Pg-1; Wed, 27 Mar 2024 15:49:29 -0400
X-MC-Unique: cedrxm-TMpqCD1FbcEN1Pg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-430c9bbe925so390441cf.0
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 12:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711568969; x=1712173769;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VGP1nbUwob6qnOGuCJrd2CfKx4tjNYD9uguN5Z08Jp4=;
 b=hOI2REboQAFvl+CVDvI0YLIJQKpBJ2PQ+NuBVkVV7UZfpw2p2ciDEVAy0DMlRzlH/J
 jbvkYv3yCcPLfVNLFLK2gGXVgQ+RkS4Vuwla1SWbKYm+/yKPlX/sMZdM21QsmG4ySDeg
 J7o62mq+bWSJ1CEdhzqfkyPPQ9Ri4AQvMcVps0186ZA2reHCnzNkZLeIdS/yD5qofBRo
 SV00bf2/mojTDAR9T+JRqDR9NuqZliTC2tyAPId4ad1QzJa5WnUSt9ymvelKEPYXWBf1
 iRLHG5Sh/xLXRIVeovWdDnmP3FoN7RgCFEqan0wD3grBOZNagSDYifoN7MYfCwublr9q
 FuLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOLFVYHEgPTfq2qWyA4a2MEGzbjuIhb5honYo7YSmNwMa6HkEReFKMu6Tn10a+7l0hUDFXx06L8PscfsTJ3IRy8NvwAjU=
X-Gm-Message-State: AOJu0YwpGJt3+nydeF5dSzKwFAaB3iYnwvIWXCqj4FvIATZYMEQpzkJb
 v22DwHVOh1M84no0iyVdjJexEhCv/rSO7k3LLhvCQ2h+r3C2s39+2lpBYY2/DA2p00VF/mh3Xs8
 i5/vgbp/PKJidP2kQZAFjbq8cupEJHoiRZBOuKy+D9tvFFjPWxLPv
X-Received: by 2002:a05:622a:181e:b0:42e:f5bd:da4d with SMTP id
 t30-20020a05622a181e00b0042ef5bdda4dmr827628qtc.5.1711568968891; 
 Wed, 27 Mar 2024 12:49:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWE24vQB+KzYWS3qGHY/Xf82YTMbkCFrXAFGi5bGJkpgwaH703rxEe7vlxumCtT8lYB5+g4g==
X-Received: by 2002:a05:622a:181e:b0:42e:f5bd:da4d with SMTP id
 t30-20020a05622a181e00b0042ef5bdda4dmr827601qtc.5.1711568968315; 
 Wed, 27 Mar 2024 12:49:28 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 gd14-20020a05622a5c0e00b0042f21fe66f7sm5100999qtb.73.2024.03.27.12.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 12:49:28 -0700 (PDT)
Date: Wed, 27 Mar 2024 15:49:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Yuan Liu <yuan1.liu@intel.com>
Cc: farosas@suse.de, qemu-devel@nongnu.org, hao.xiang@bytedance.com,
 bryan.zhang@bytedance.com, nanhai.zou@intel.com
Subject: Re: [PATCH v5 4/7] migration/multifd: add qpl compression method
Message-ID: <ZgR4Rp7J9cCtLGGF@x1n>
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
 <20240319164527.1873891-5-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240319164527.1873891-5-yuan1.liu@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Mar 20, 2024 at 12:45:24AM +0800, Yuan Liu wrote:
> add the Query Processing Library (QPL) compression method
> 
> Although both qpl and zlib support deflate compression, qpl will
> only use the In-Memory Analytics Accelerator(IAA) for compression
> and decompression, and IAA is not compatible with the Zlib in
> migration, so qpl is used as a new compression method for migration.
> 
> How to enable qpl compression during migration:
> migrate_set_parameter multifd-compression qpl
> 
> The qpl only supports one compression level, there is no qpl
> compression level parameter added, users do not need to specify
> the qpl compression level.
> 
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> ---
>  hw/core/qdev-properties-system.c |  2 +-
>  migration/meson.build            |  1 +
>  migration/multifd-qpl.c          | 20 ++++++++++++++++++++
>  migration/multifd.h              |  1 +
>  qapi/migration.json              |  7 ++++++-
>  5 files changed, 29 insertions(+), 2 deletions(-)
>  create mode 100644 migration/multifd-qpl.c
> 
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index d79d6f4b53..6ccd7224f6 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -659,7 +659,7 @@ const PropertyInfo qdev_prop_fdc_drive_type = {
>  const PropertyInfo qdev_prop_multifd_compression = {
>      .name = "MultiFDCompression",
>      .description = "multifd_compression values, "
> -                   "none/zlib/zstd",
> +                   "none/zlib/zstd/qpl",
>      .enum_table = &MultiFDCompression_lookup,
>      .get = qdev_propinfo_get_enum,
>      .set = qdev_propinfo_set_enum,
> diff --git a/migration/meson.build b/migration/meson.build
> index 1eeb915ff6..cb177de1d2 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -41,6 +41,7 @@ if get_option('live_block_migration').allowed()
>    system_ss.add(files('block.c'))
>  endif
>  system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
> +system_ss.add(when: qpl, if_true: files('multifd-qpl.c'))
>  
>  specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
>                  if_true: files('ram.c',
> diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
> new file mode 100644
> index 0000000000..056a68a060
> --- /dev/null
> +++ b/migration/multifd-qpl.c
> @@ -0,0 +1,20 @@
> +/*
> + * Multifd qpl compression accelerator implementation
> + *
> + * Copyright (c) 2023 Intel Corporation
> + *
> + * Authors:
> + *  Yuan Liu<yuan1.liu@intel.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +#include "qemu/osdep.h"
> +#include "qemu/module.h"
> +
> +static void multifd_qpl_register(void)
> +{
> +    /* noop */
> +}
> +
> +migration_init(multifd_qpl_register);
> diff --git a/migration/multifd.h b/migration/multifd.h
> index c9d9b09239..5b7d9b15f8 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -40,6 +40,7 @@ MultiFDRecvData *multifd_get_recv_data(void);
>  #define MULTIFD_FLAG_NOCOMP (0 << 1)
>  #define MULTIFD_FLAG_ZLIB (1 << 1)
>  #define MULTIFD_FLAG_ZSTD (2 << 1)
> +#define MULTIFD_FLAG_QPL (4 << 1)
>  
>  /* This value needs to be a multiple of qemu_target_page_size() */
>  #define MULTIFD_PACKET_SIZE (512 * 1024)
> diff --git a/qapi/migration.json b/qapi/migration.json
> index aa1b39bce1..dceb35db5b 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -629,11 +629,16 @@
>  #
>  # @zstd: use zstd compression method.
>  #
> +# @qpl: use qpl compression method. Query Processing Library(qpl) is based on
> +#       the deflate compression algorithm and use the Intel In-Memory Analytics
> +#       Accelerator(IAA) accelerated compression and decompression. (Since 9.0)

s/9.0/9.1/

> +#
>  # Since: 5.0
>  ##
>  { 'enum': 'MultiFDCompression',
>    'data': [ 'none', 'zlib',
> -            { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
> +            { 'name': 'zstd', 'if': 'CONFIG_ZSTD' },
> +            { 'name': 'qpl', 'if': 'CONFIG_QPL' } ] }
>  
>  ##
>  # @MigMode:
> -- 
> 2.39.3
> 

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


