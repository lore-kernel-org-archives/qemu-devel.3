Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA1E8C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 11:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl5pm-0001cA-4B; Fri, 15 Mar 2024 07:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rl5pg-0001Zm-JS
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:34:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rl5pe-0002oT-Hw
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710502475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e4I4qdtJY5GanHprVljL9ylvCf+YpRIYlwzQ/fUQUak=;
 b=PaZ4rSxdrlfyrrpR1ocZ22V/WeBb6KvXffqp17fNY2O3KyU5TqnGPdc+qsoC+Mp9Nlbgdl
 c9Rcjx8xMAaG8Wp/VA+rUNWpdj741bR36hEIEgmriS7UtkDVCxZ8c2f1k/z0NWXrmA0vPc
 FjZi8rMYpdRM7G/42LleKW9T5cezoM0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-AkV0ejbDOzGew06t7Bs9ZQ-1; Fri, 15 Mar 2024 07:34:33 -0400
X-MC-Unique: AkV0ejbDOzGew06t7Bs9ZQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-430a062d60bso1755451cf.0
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 04:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710502473; x=1711107273;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e4I4qdtJY5GanHprVljL9ylvCf+YpRIYlwzQ/fUQUak=;
 b=SMtnwPexNRBcvwui8jG3iuC9JcepOUkA9OrqSH5ZgS2ZUs53XdKAX+/Y25q60z29bn
 ddVi+QT/pODrH7CBGIspOyMzq+4KiaHQgzDZeUvL2h4iB3Yj1OuowmPMCRc5uVCZ3uq5
 mQmssIle5XTxVU3ebaLMIxwUypiH/Ekm2YTxdJ3oe7+cZs83HD2zUXnx/G98OK4OarkG
 KivL7xtPXk9YP7rYnsqnJy/4xPjyTOqsO+qsZVTcPrKRJNxz+vyuYcUw92chGd2kvQQB
 j7m2NISMJls4IuZCRhyMgfDRU1rwYaRlJJv7QK/YICKxMbGHQQVHSI+resdRlHNycc/C
 z8Jw==
X-Gm-Message-State: AOJu0YyW2OiI8NsFl/Qp7ab82+ag1bou4GB4ZErj3Clv3x6x6bf1Z/bc
 lX0oKFnXNOQrm5+mOQtHRkjCP7fxhsMonGd6kK/dFvBBJwjwjZMZWAlo/DqBnwVYgzFET+xqRcm
 pOW2Rz/zW7+jWkFD702hkNViyjiVFQYF9ZC8+Wvd6iVvyWC2v7V96
X-Received: by 2002:a05:620a:8396:b0:789:dc90:21b0 with SMTP id
 pb22-20020a05620a839600b00789dc9021b0mr1870428qkn.0.1710502473237; 
 Fri, 15 Mar 2024 04:34:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/FeNkoTPVmoQuzOTD3U/wPSWcPplk+AqWfpjEpO5dTP6V54+1w1zG9hBDR4ZjLmk7Lu/uZg==
X-Received: by 2002:a05:620a:8396:b0:789:dc90:21b0 with SMTP id
 pb22-20020a05620a839600b00789dc9021b0mr1870402qkn.0.1710502472886; 
 Fri, 15 Mar 2024 04:34:32 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 bp10-20020a05620a458a00b00789e8860ef7sm187949qkb.121.2024.03.15.04.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 04:34:32 -0700 (PDT)
Date: Fri, 15 Mar 2024 07:34:30 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: Re: [PATCH v4 14/25] memory: Add Error** argument to the
 global_dirty_log routines
Message-ID: <ZfQyRu7nt6M6uzTJ@x1n>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-15-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240306133441.2351700-15-clg@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.933,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 06, 2024 at 02:34:29PM +0100, Cédric Le Goater wrote:
> Now that the log_global*() handlers take an Error** parameter and
> return a bool, do the same for memory_global_dirty_log_start() and
> memory_global_dirty_log_stop(). The error is reported in the callers
> for now and it will be propagated in the call stack in the next
> changes.
> 
> To be noted a functional change in ram_init_bitmaps(), if the dirty
> pages logger fails to start, there is no need to synchronize the dirty
> pages bitmaps. colo_incoming_start_dirty_log() could be modified in a
> similar way.
> 
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Paul Durrant <paul@xen.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Hyman Huang <yong.huang@smartx.com>
> Reviewed-by: Hyman Huang <yong.huang@smartx.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
> 
>  Changes in v4:
> 
>  - Dropped log_global_stop() and log_global_sync() changes
>  
>  include/exec/memory.h |  5 ++++-
>  hw/i386/xen/xen-hvm.c |  2 +-
>  migration/dirtyrate.c | 13 +++++++++++--
>  migration/ram.c       | 22 ++++++++++++++++++++--
>  system/memory.c       | 11 +++++------
>  5 files changed, 41 insertions(+), 12 deletions(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 5555567bc4c9fdb53e8f63487f1400980275687d..c129ee6db7162504bd72d4cfc69b5affb2cd87e8 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -2570,8 +2570,11 @@ void memory_listener_unregister(MemoryListener *listener);
>   * memory_global_dirty_log_start: begin dirty logging for all regions
>   *
>   * @flags: purpose of starting dirty log, migration or dirty rate
> + * @errp: pointer to Error*, to store an error if it happens.
> + *
> + * Return: true on success, else false setting @errp with error.
>   */
> -void memory_global_dirty_log_start(unsigned int flags);
> +bool memory_global_dirty_log_start(unsigned int flags, Error **errp);
>  
>  /**
>   * memory_global_dirty_log_stop: end dirty logging for all regions
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index 0608ca99f5166fd6379ee674442484e805eff9c0..57cb7df50788a6c31eff68c95e8eaa856fdebede 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -654,7 +654,7 @@ void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
>  void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
>  {
>      if (enable) {
> -        memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION);
> +        memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION, errp);
>      } else {
>          memory_global_dirty_log_stop(GLOBAL_DIRTY_MIGRATION);
>      }
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 1d2e85746fb7b10eb7f149976970f9a92125af8a..d02d70b7b4b86a29d4d5540ded416543536d8f98 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -90,9 +90,15 @@ static int64_t do_calculate_dirtyrate(DirtyPageRecord dirty_pages,
>  
>  void global_dirty_log_change(unsigned int flag, bool start)
>  {
> +    Error *local_err = NULL;
> +    bool ret;
> +
>      bql_lock();
>      if (start) {
> -        memory_global_dirty_log_start(flag);
> +        ret = memory_global_dirty_log_start(flag, &local_err);
> +        if (!ret) {
> +            error_report_err(local_err);
> +        }
>      } else {
>          memory_global_dirty_log_stop(flag);
>      }
> @@ -608,9 +614,12 @@ static void calculate_dirtyrate_dirty_bitmap(struct DirtyRateConfig config)
>  {
>      int64_t start_time;
>      DirtyPageRecord dirty_pages;
> +    Error *local_err = NULL;
>  
>      bql_lock();
> -    memory_global_dirty_log_start(GLOBAL_DIRTY_DIRTY_RATE);
> +    if (!memory_global_dirty_log_start(GLOBAL_DIRTY_DIRTY_RATE, &local_err)) {
> +        error_report_err(local_err);
> +    }
>  
>      /*
>       * 1'round of log sync may return all 1 bits with
> diff --git a/migration/ram.c b/migration/ram.c
> index c5149b7d717aefad7f590422af0ea4a40e7507be..397b4c0f218a66d194e44f9c5f9fe8e9885c48b6 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2836,18 +2836,31 @@ static void migration_bitmap_clear_discarded_pages(RAMState *rs)
>  
>  static void ram_init_bitmaps(RAMState *rs)
>  {
> +    Error *local_err = NULL;
> +    bool ret = true;
> +
>      qemu_mutex_lock_ramlist();
>  
>      WITH_RCU_READ_LOCK_GUARD() {
>          ram_list_init_bitmaps();
>          /* We don't use dirty log with background snapshots */
>          if (!migrate_background_snapshot()) {
> -            memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION);
> +            ret = memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION,
> +                                                &local_err);
> +            if (!ret) {
> +                error_report_err(local_err);
> +                goto out_unlock;

Here we may need to free the bitmaps created in ram_list_init_bitmaps().

We can have a helper ram_bitmaps_destroy() for that.

One thing be careful is the new file_bmap can be created but missing in the
ram_save_cleanup(), it's because it's freed earlier.  IMHO if we will have
a new ram_bitmaps_destroy() we can unconditionally free file_bmap there
too, as if it's freed early g_free() is noop.

> +            }
>              migration_bitmap_sync_precopy(rs, false);
>          }
>      }
> +out_unlock:
>      qemu_mutex_unlock_ramlist();
>  
> +    if (!ret) {
> +        return;
> +    }
> +
>      /*
>       * After an eventual first bitmap sync, fixup the initial bitmap
>       * containing all 1s to exclude any discarded pages from migration.
> @@ -3631,6 +3644,8 @@ int colo_init_ram_cache(void)
>  void colo_incoming_start_dirty_log(void)
>  {
>      RAMBlock *block = NULL;
> +    Error *local_err = NULL;
> +
>      /* For memory_global_dirty_log_start below. */
>      bql_lock();
>      qemu_mutex_lock_ramlist();
> @@ -3642,7 +3657,10 @@ void colo_incoming_start_dirty_log(void)
>              /* Discard this dirty bitmap record */
>              bitmap_zero(block->bmap, block->max_length >> TARGET_PAGE_BITS);
>          }
> -        memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION);
> +        if (!memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION,
> +                                           &local_err)) {
> +            error_report_err(local_err);
> +        }
>      }
>      ram_state->migration_dirty_pages = 0;
>      qemu_mutex_unlock_ramlist();
> diff --git a/system/memory.c b/system/memory.c
> index 3600e716149407c10a1f6bf8f0a81c2611cf15ba..cbc098216b789f50460f1d1bc7ec122030693d9e 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2931,10 +2931,9 @@ static void memory_global_dirty_log_rollback(MemoryListener *listener,
>      }
>  }
>  
> -void memory_global_dirty_log_start(unsigned int flags)
> +bool memory_global_dirty_log_start(unsigned int flags, Error **errp)
>  {
>      unsigned int old_flags;
> -    Error *local_err = NULL;
>  
>      assert(flags && !(flags & (~GLOBAL_DIRTY_MASK)));
>  
> @@ -2946,7 +2945,7 @@ void memory_global_dirty_log_start(unsigned int flags)
>  
>      flags &= ~global_dirty_tracking;
>      if (!flags) {
> -        return;
> +        return true;
>      }
>  
>      old_flags = global_dirty_tracking;
> @@ -2959,7 +2958,7 @@ void memory_global_dirty_log_start(unsigned int flags)
>  
>          QTAILQ_FOREACH(listener, &memory_listeners, link) {
>              if (listener->log_global_start) {
> -                ret = listener->log_global_start(listener, &local_err);
> +                ret = listener->log_global_start(listener, errp);
>                  if (!ret) {
>                      break;
>                  }
> @@ -2969,14 +2968,14 @@ void memory_global_dirty_log_start(unsigned int flags)
>          if (!ret) {
>              memory_global_dirty_log_rollback(QTAILQ_PREV(listener, link),
>                                               flags);
> -            error_report_err(local_err);
> -            return;
> +            return false;
>          }
>  
>          memory_region_transaction_begin();
>          memory_region_update_pending = true;
>          memory_region_transaction_commit();
>      }
> +    return true;
>  }
>  
>  static void memory_global_dirty_log_do_stop(unsigned int flags)
> -- 
> 2.44.0
> 

-- 
Peter Xu


