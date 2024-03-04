Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67363C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 07:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh32K-0002sS-GJ; Mon, 04 Mar 2024 02:47:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rh32C-0002ri-9q
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 02:46:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rh32A-0003Ip-8J
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 02:46:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709538408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vdYQUvi5hyxOLkwWHkCJ8sw+T0JOy9OCSm8WFukCp6o=;
 b=Hv31vFfo3Jg51YSj7ArLsAx1ughOuuDXuR0wfuDD4LR0NWnOJGPVfvqyhxYNYvJpD47HYw
 NHr4PstluDtqha3sOs7IVT5IWMSS+cHhGpDrfkXiMKbPHAR5ACFZ6gLd83VpFKIOPxZUj/
 B3qXY4XGUrAVQ2LC25R/Q3fKtVEwZW0=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-aM70ahfrMWCXc_ksV1EbXQ-1; Mon, 04 Mar 2024 02:46:46 -0500
X-MC-Unique: aM70ahfrMWCXc_ksV1EbXQ-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-21e63661790so774414fac.1
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 23:46:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709538406; x=1710143206;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vdYQUvi5hyxOLkwWHkCJ8sw+T0JOy9OCSm8WFukCp6o=;
 b=gIEJqJx+LSuYcfqVsDo2DmGXYRnZluAiY03c0zql8VV67Casv19Jos7z0tFwiU651C
 UyKu0h8wnjYrK2bjHDYCVWnNBki3FPvhZvE+J66E1JLRxVsM2bzbZFIm5uxHVfLqo5VP
 lX0GSye/+1Vl17BNGd9vSrs2KQo7ScnbPGMcFCwIuat3Zq5VwB9K0h+pHrqQB3QJTG8H
 YVbBSoTSMJ8AccmbF+3dHapE4BgZozZfKHM8GI0DsiAI3Ld/ofd13zaBQEyKEjq1NsLv
 Q1T9hv2XMyDUleGyyTDexSBa/caCpMEZprvYTX62r5msuQXqILLAD2jx7U7sC1zJopmG
 a/PA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoLz78dF4Yvhbf4ECyb4b+PG9kfeaIBRbgHyvMBrI0qhjxlhm8vaKxRGwZDI6cEITgN+dS5F09yOr2UkUELWR6Bxr7FUk=
X-Gm-Message-State: AOJu0YzMn3+9EOQMhCe0wqX7Mi+b5aEdMal8p0srMeVZnMh5Pvw63t/V
 puvl4Z/umIdAcf6LcED2UTtUi9cYWvuq8bGtIFsl0Ixa+KT2VnkBtNnaLm1fcrrn78EVvgywegk
 7rg2bXCE0UqP2bGxBiVxwKVo3qDnfb0rjUtk8F7CWbDkuzs8xtRHw
X-Received: by 2002:a05:6808:f16:b0:3c1:e710:466a with SMTP id
 m22-20020a0568080f1600b003c1e710466amr4545748oiw.1.1709538405798; 
 Sun, 03 Mar 2024 23:46:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXgU6nNtyyxKfXpz2ErUoDlRHjesLufqLXl6AUqUniY3eryoWTGo9IihjW/PxZMXmhEpnBvw==
X-Received: by 2002:a05:6808:f16:b0:3c1:e710:466a with SMTP id
 m22-20020a0568080f1600b003c1e710466amr4545733oiw.1.1709538405533; 
 Sun, 03 Mar 2024 23:46:45 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 w62-20020a636241000000b005e485fbd455sm6832267pgb.45.2024.03.03.23.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Mar 2024 23:46:45 -0800 (PST)
Date: Mon, 4 Mar 2024 15:46:33 +0800
From: Peter Xu <peterx@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 3/7] migration/multifd: Implement
 ram_save_target_page_multifd to handle multifd version of
 MigrationOps::ram_save_target_page.
Message-ID: <ZeV8WaKyKEfw-em-@x1n>
References: <20240301022829.3390548-1-hao.xiang@bytedance.com>
 <20240301022829.3390548-4-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240301022829.3390548-4-hao.xiang@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Mar 01, 2024 at 02:28:25AM +0000, Hao Xiang wrote:
> 1. Add a dedicated handler for MigrationOps::ram_save_target_page in
> multifd live migration.
> 2. Refactor ram_save_target_page_legacy so that the legacy and multifd
> handlers don't have internal functions calling into each other.
> 
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Message-Id: <20240226195654.934709-4-hao.xiang@bytedance.com>
> ---
>  migration/ram.c | 43 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 30 insertions(+), 13 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index e1fa229acf..f9d6ea65cc 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1122,10 +1122,6 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss,
>      QEMUFile *file = pss->pss_channel;
>      int len = 0;
>  
> -    if (migrate_zero_page_detection() == ZERO_PAGE_DETECTION_NONE) {
> -        return 0;
> -    }

We need to keep this to disable zero-page-detect on !multifd?

> -
>      if (!buffer_is_zero(p, TARGET_PAGE_SIZE)) {
>          return 0;
>      }
> @@ -2045,7 +2041,6 @@ static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
>   */
>  static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
>  {
> -    RAMBlock *block = pss->block;
>      ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
>      int res;
>  
> @@ -2061,17 +2056,34 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
>          return 1;
>      }
>  
> +    return ram_save_page(rs, pss);
> +}
> +
> +/**
> + * ram_save_target_page_multifd: send one target page to multifd workers
> + *
> + * Returns 1 if the page was queued, -1 otherwise.
> + *
> + * @rs: current RAM state
> + * @pss: data about the page we want to send
> + */
> +static int ram_save_target_page_multifd(RAMState *rs, PageSearchStatus *pss)
> +{
> +    RAMBlock *block = pss->block;
> +    ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
> +
>      /*
> -     * Do not use multifd in postcopy as one whole host page should be
> -     * placed.  Meanwhile postcopy requires atomic update of pages, so even
> -     * if host page size == guest page size the dest guest during run may
> -     * still see partially copied pages which is data corruption.
> +     * Backward compatibility support. While using multifd live

We can also avoid mentioning "compatibility support" here - it's a
parameter, user can legally set it to anything.

> +     * migration, we still need to handle zero page checking on the
> +     * migration main thread.
>       */
> -    if (migrate_multifd() && !migration_in_postcopy()) {
> -        return ram_save_multifd_page(block, offset);
> +    if (migrate_zero_page_detection() == ZERO_PAGE_DETECTION_LEGACY) {
> +        if (save_zero_page(rs, pss, offset)) {
> +            return 1;
> +        }
>      }
>  
> -    return ram_save_page(rs, pss);
> +    return ram_save_multifd_page(block, offset);
>  }
>  
>  /* Should be called before sending a host page */
> @@ -2983,7 +2995,12 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>      }
>  
>      migration_ops = g_malloc0(sizeof(MigrationOps));
> -    migration_ops->ram_save_target_page = ram_save_target_page_legacy;
> +
> +    if (migrate_multifd()) {
> +        migration_ops->ram_save_target_page = ram_save_target_page_multifd;
> +    } else {
> +        migration_ops->ram_save_target_page = ram_save_target_page_legacy;
> +    }
>  
>      bql_unlock();
>      ret = multifd_send_sync_main();
> -- 
> 2.30.2
> 

-- 
Peter Xu


