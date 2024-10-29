Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3D6D3A670
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 16:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5oyT-0007AK-O3; Tue, 29 Oct 2024 12:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5oyR-00079q-MW
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 12:21:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5oyP-0007ot-JQ
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 12:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730218895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=duau9z6Bnsc0LpyXqUCeu8KGx1v9eb7hlTHdnLz21vM=;
 b=NIDFmpT+rGMEWYEa+6/KEQ6v3FY9lpHKFCm11ZtkUv53LA/jKV7qCAfia6U5SkUk+mBDPs
 iElAVUq5XRmt21Powj4OpdqBY1Q+iVwgit+oa49czSeVG5N8q62FOalpNp0xTgYT0a9/Z8
 KHaGk/op+g8gHeyXErEUqKEn4iCndJo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-jVrAxT1INseUf9OOszh1Zw-1; Tue, 29 Oct 2024 12:21:33 -0400
X-MC-Unique: jVrAxT1INseUf9OOszh1Zw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6cbceb26182so91085386d6.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 09:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730218893; x=1730823693;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=duau9z6Bnsc0LpyXqUCeu8KGx1v9eb7hlTHdnLz21vM=;
 b=HRAPD/+RMM9pfKI685wKhOyoRL8HaXS+JjNMRd+nqd3KUUjnWs4LPkcuSxCDjKRhdv
 U2QG2GRM4hH/8jc2M2yZ71EmSwjoOkuO6NYpZieVik5KKGt++xRUK2hHlRfk8ZLzDhlb
 2j6TRKlkmP90idpWKvW+Qe77B49AbsFVBdssuQdF7Gz2QGranO+AeZPIE7tKeG7duLVb
 fACjZ3+J7doVSxXSz8VpEe5Ys4vEv33wGm7FAgk1Qi0t+41MH6t6W4epzB8dP0MD3Ld0
 x1YhbDiXmIz0fHnQ+hAP/qejilAEctF8cvZmmbwDFCayyD54uBn3ZSh/ZoRkK5qbq/ov
 mWyg==
X-Gm-Message-State: AOJu0YydQDg7d2oqEluS/L5Iq6H7l3B3d9upaMYCkwUgt/jAyqgLHNhl
 sGA6eM8BKzZ+z7LqU/xLi/lpI0eWcnWYSb1knOP0nX5Vs0F+05zaa9KOeqga+0q7XQEjhja7Knr
 tCRovT/3PddeWhWcRwtluqDtJkIj6rLR4Pr95zhoIyyoTChaa/0Dp
X-Received: by 2002:a05:6214:3103:b0:6cd:ef7a:8c82 with SMTP id
 6a1803df08f44-6d185854b79mr196132636d6.41.1730218893062; 
 Tue, 29 Oct 2024 09:21:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhOO2quCl2cnJgcXmgcjEE9bLj0QoGMSO0cpYQAC51BF+4w/b54RZV/OHbVgD4BfevP0CnsA==
X-Received: by 2002:a05:6214:3103:b0:6cd:ef7a:8c82 with SMTP id
 6a1803df08f44-6d185854b79mr196132366d6.41.1730218892629; 
 Tue, 29 Oct 2024 09:21:32 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d179a2c3c2sm43447506d6.118.2024.10.29.09.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 09:21:32 -0700 (PDT)
Date: Tue, 29 Oct 2024 12:21:31 -0400
From: Peter Xu <peterx@redhat.com>
To: yong.huang@smartx.com
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC 2/2] migration: Avoid doing RAMBlock dirty sync in
 the initial iteration
Message-ID: <ZyELi_ax8zM_kFbZ@x1n>
References: <cover.1729648695.git.yong.huang@smartx.com>
 <76f0ea57ac7f4c2a68203d17fec1c34bb3d16a4a.1729648695.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <76f0ea57ac7f4c2a68203d17fec1c34bb3d16a4a.1729648695.git.yong.huang@smartx.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Wed, Oct 23, 2024 at 10:09:51AM +0800, yong.huang@smartx.com wrote:
> From: Hyman Huang <yong.huang@smartx.com>
> 
> KVM always returns 1 when userspace retrieves a dirty bitmap for
> the first time when KVM_DIRTY_LOG_INITIALLY_SET is enabled; in such
> scenario, the RAMBlock dirty sync of the initial iteration can be
> skipped.
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  migration/cpu-throttle.c |  3 ++-
>  migration/ram.c          | 30 +++++++++++++++++++++++++++---
>  2 files changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c
> index 342681cdd4..06e3b1be78 100644
> --- a/migration/cpu-throttle.c
> +++ b/migration/cpu-throttle.c
> @@ -27,6 +27,7 @@
>  #include "hw/core/cpu.h"
>  #include "qemu/main-loop.h"
>  #include "sysemu/cpus.h"
> +#include "sysemu/kvm.h"
>  #include "cpu-throttle.h"
>  #include "migration.h"
>  #include "migration-stats.h"
> @@ -141,7 +142,7 @@ void cpu_throttle_dirty_sync_timer_tick(void *opaque)
>       * effect on guest performance, therefore omit it to avoid
>       * paying extra for the sync penalty.
>       */
> -    if (sync_cnt <= 1) {
> +    if (sync_cnt <= (kvm_dirty_log_manual_enabled() ? 0 : 1)) {
>          goto end;
>      }
>  
> diff --git a/migration/ram.c b/migration/ram.c
> index d284f63854..b312ebd69d 100644
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
> @@ -2751,7 +2752,17 @@ static void ram_list_init_bitmaps(void)
>                  block->file_bmap = bitmap_new(pages);
>              }
>              block->clear_bmap_shift = shift;
> -            block->clear_bmap = bitmap_new(clear_bmap_size(pages, shift));
> +            block->clear_bmap = bitmap_new(clear_bmap_pages);
> +            /*
> +             * Set the clear bitmap by default to enable dirty logging.
> +             *
> +             * Note that with KVM_DIRTY_LOG_INITIALLY_SET, dirty logging
> +             * will be enabled gradually in small chunks using
> +             * KVM_CLEAR_DIRTY_LOG
> +             */
> +            if (kvm_dirty_log_manual_enabled()) {
> +                bitmap_set(block->clear_bmap, 0, clear_bmap_pages);
> +            }

Why it needs to be relevant to whether DIRTY_LOG is enabled?

I wonder if we should always set clear_bmap to 1 unconditionally, as we
always set bmap to all 1s by default.

Then we skip sync always during setup, dropping patch 1.

>          }
>      }
>  }
> @@ -2771,6 +2782,7 @@ static void migration_bitmap_clear_discarded_pages(RAMState *rs)
>  
>  static bool ram_init_bitmaps(RAMState *rs, Error **errp)
>  {
> +    Error *local_err = NULL;
>      bool ret = true;
>  
>      qemu_mutex_lock_ramlist();
> @@ -2783,7 +2795,19 @@ static bool ram_init_bitmaps(RAMState *rs, Error **errp)
>              if (!ret) {
>                  goto out_unlock;
>              }
> -            migration_bitmap_sync_precopy(false);
> +
> +            if (kvm_dirty_log_manual_enabled()) {
> +                /*
> +                 * Bypass the RAMBlock dirty sync and still publish a
> +                 * notification.
> +                 */
> +                if (precopy_notify(PRECOPY_NOTIFY_AFTER_BITMAP_SYNC,
> +                            &local_err)) {
> +                    error_report_err(local_err);
> +                }
> +            } else {
> +                migration_bitmap_sync_precopy(false);
> +            }
>          }
>      }
>  out_unlock:
> -- 
> 2.27.0
> 

-- 
Peter Xu


