Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E41D43377
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 16:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t95My-0006yY-Qb; Thu, 07 Nov 2024 11:28:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t95My-0006yP-1C
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:28:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t95Mw-0003LZ-90
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:28:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730996905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5KzVhbAnyV6NRm6Btc66biWMDX7e/miwG4WEDFtLGSQ=;
 b=KGywClz8H/SufkdhLIoZQlSgYZ793ENwwpyvucj3GWwm/JC5lctpxM4ybvIsfJv2bEDwAf
 VF2HagTjvTaGzqxjaivB/1o1YYg62ybwUC/y0fmamtgSSoa6VPTxkdiQYdcUuL2Ih1dgsd
 nzE2qHB4Lb/P1tcUXHeeC6pUZyHCeio=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-RAphO2yANK-vKslXnx24ow-1; Thu, 07 Nov 2024 11:28:24 -0500
X-MC-Unique: RAphO2yANK-vKslXnx24ow-1
X-Mimecast-MFC-AGG-ID: RAphO2yANK-vKslXnx24ow
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-288c2c2b5bbso979822fac.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 08:28:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730996903; x=1731601703;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5KzVhbAnyV6NRm6Btc66biWMDX7e/miwG4WEDFtLGSQ=;
 b=Uj2Zd12C53H0vHASOlld4LGksykjVkTt1bNcHHP5FqWvfXxn4mdlbrIuDZiBTHBMnY
 ugrKqAzjVeJcZ+SkhXMCp7IIafvsG/i4mPy3MGS3au3wHrtkjqUBzsgJ0W/dTWcjbSCA
 T/dwrAIbn/6dCyWruuMc1IiyD4vl1nb3DrK6iYn5Wp8lpxkGvyT/vOy9AObVPMLS3DX2
 slNu9H/7amVFiMwlXQ7ZTJ/SW+yict49GFHa0HucmGdVSfnN6L3O05LqheW35C3f4S/S
 r8GZidzk+TP7Gw8xxH2wAI5l/oa/z4jDMMuoU8HelfP/TeVC7iuf6cZl7ZrudgPE+WU9
 votw==
X-Gm-Message-State: AOJu0Yzn9rDrJkLDuaxWtblaLiVMsK8lU0qrh72TSRjCu0L+EkxKNJB7
 lm6rD9P2/vlGJQZ5VZiSo3W6e6sZiaG1YmtrbfRVdLX9kA6BU5/kOEAgG07xzt0GnfZD7aDd1KW
 Z6KI2PFJyZ30ldP7+e8kxBngkqHIH9fkgtt7fh3/QVBOnhGTKF0QiQsdX+yvh
X-Received: by 2002:a05:6870:e60b:b0:278:157:25bb with SMTP id
 586e51a60fabf-2955a24c018mr578781fac.26.1730996903111; 
 Thu, 07 Nov 2024 08:28:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESIDofGxI9V+2tq0lE5aXdm+ecpab1OgeE4UQxnRcoPN3OCGymU8EAiq0zcvoMTDMEnPjXSQ==
X-Received: by 2002:a05:6870:e60b:b0:278:157:25bb with SMTP id
 586e51a60fabf-2955a24c018mr578767fac.26.1730996902843; 
 Thu, 07 Nov 2024 08:28:22 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29546eddc9csm417895fac.36.2024.11.07.08.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 08:28:22 -0800 (PST)
Date: Thu, 7 Nov 2024 11:28:18 -0500
From: Peter Xu <peterx@redhat.com>
To: yong.huang@smartx.com
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Do not perform RAMBlock dirty sync during the
 first iteration
Message-ID: <ZyzqosT0uE6_G4as@x1n>
References: <ad543bac0eb9e7113eaec266add58c19f9f6eda0.1730973055.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad543bac0eb9e7113eaec266add58c19f9f6eda0.1730973055.git.yong.huang@smartx.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Nov 07, 2024 at 05:56:50PM +0800, yong.huang@smartx.com wrote:
> From: Hyman Huang <yong.huang@smartx.com>
> 
> The first iteration's RAMBlock dirty sync can be omitted because QEMU
> always initializes the RAMBlock's bmap to all 1s by default.
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  migration/cpu-throttle.c |  2 +-
>  migration/ram.c          | 19 ++++++++++++++++---
>  2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c
> index 5179019e33..674dc2004e 100644
> --- a/migration/cpu-throttle.c
> +++ b/migration/cpu-throttle.c
> @@ -141,7 +141,7 @@ void cpu_throttle_dirty_sync_timer_tick(void *opaque)
>       * effect on guest performance, therefore omit it to avoid
>       * paying extra for the sync penalty.
>       */
> -    if (sync_cnt <= 1) {
> +    if (!sync_cnt) {
>          goto end;
>      }
>  
> diff --git a/migration/ram.c b/migration/ram.c
> index 05ff9eb328..a0123eb93e 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2718,7 +2718,7 @@ static void ram_list_init_bitmaps(void)
>  {
>      MigrationState *ms = migrate_get_current();
>      RAMBlock *block;
> -    unsigned long pages;
> +    unsigned long pages, clear_bmap_pages;
>      uint8_t shift;
>  
>      /* Skip setting bitmap if there is no RAM */
> @@ -2736,6 +2736,7 @@ static void ram_list_init_bitmaps(void)
>  
>          RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>              pages = block->max_length >> TARGET_PAGE_BITS;
> +            clear_bmap_pages = clear_bmap_size(pages, shift);
>              /*
>               * The initial dirty bitmap for migration must be set with all
>               * ones to make sure we'll migrate every guest RAM page to
> @@ -2751,7 +2752,12 @@ static void ram_list_init_bitmaps(void)
>                  block->file_bmap = bitmap_new(pages);
>              }
>              block->clear_bmap_shift = shift;
> -            block->clear_bmap = bitmap_new(clear_bmap_size(pages, shift));
> +            block->clear_bmap = bitmap_new(clear_bmap_pages);
> +            /*
> +             * Set clear_bmap to 1 unconditionally, as we always set bmap
> +             * to all 1s by default.
> +             */
> +            bitmap_set(block->clear_bmap, 0, clear_bmap_pages);
>          }
>      }
>  }
> @@ -2771,6 +2777,7 @@ static void migration_bitmap_clear_discarded_pages(RAMState *rs)
>  
>  static bool ram_init_bitmaps(RAMState *rs, Error **errp)
>  {
> +    Error *local_err = NULL;
>      bool ret = true;
>  
>      qemu_mutex_lock_ramlist();
> @@ -2783,7 +2790,13 @@ static bool ram_init_bitmaps(RAMState *rs, Error **errp)
>              if (!ret) {
>                  goto out_unlock;
>              }
> -            migration_bitmap_sync_precopy(false);
> +            /*
> +             * Bypass the RAMBlock dirty sync and still publish the
> +             * notification.

Hmm.. Why should QEMU notify AFTER_BITMAP_SYNC if the sync didn't happen?

> +             */
> +            if (precopy_notify(PRECOPY_NOTIFY_AFTER_BITMAP_SYNC, &local_err)) {
> +                error_report_err(local_err);
> +            }
>          }
>      }
>  out_unlock:
> -- 
> 2.27.0
> 

-- 
Peter Xu


