Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D19C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 14:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKeTC-0004Jn-FT; Thu, 29 May 2025 10:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uKeT9-0004JW-Rs
 for qemu-devel@nongnu.org; Thu, 29 May 2025 10:42:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uKeT7-0006jq-Pu
 for qemu-devel@nongnu.org; Thu, 29 May 2025 10:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748529768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KQlfEGL8OSHvmHqEEipqA2nERo7D7K73Y0u1JiKoDVg=;
 b=Q0bvIQSKyedwHgR18sOs4IFqAoGGPYNWOPoznj4ihqx9yhFIWVnfGDzTLD0IT9QJB4GhIA
 +F9atvXBumThhwijFJH8uo7o0+vc8uLHq5nH9kHkgONayT2dCNpyG7A3OVbUIb9wdorbvW
 SR7XV4FUKwdjWzh2wRABYSBtp6YERGk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199--YFwKnsvMh6c6F3Mky70dA-1; Thu, 29 May 2025 10:42:46 -0400
X-MC-Unique: -YFwKnsvMh6c6F3Mky70dA-1
X-Mimecast-MFC-AGG-ID: -YFwKnsvMh6c6F3Mky70dA_1748529765
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4edf5bb4dso572213f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 07:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748529765; x=1749134565;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQlfEGL8OSHvmHqEEipqA2nERo7D7K73Y0u1JiKoDVg=;
 b=mVgWlSFX2EN38dm1YCP7Zu7HkkiOTj0MyYa2G8CPO+ZD2Zq63z5rFce7Snu1cGc3Mf
 XaC2AO6UNaTzF1QSczP9D28QYAQrCjYNKJiX+5UuGRJrq1Gr4CE6oVA69UH7YV9UZT/B
 efNH7SZRFFpWYwm1S0l/y1kVwaptfnZYoeAfy0ht/9GYPP/tJtUiKwTr6W62GUev90pe
 P9L0BSxNbArWVjF/c+0a0ZLlYhdECBsjHlSDrPbgDNzmXvVVY99a2J+iOkQA3YJhAxIQ
 4aHzKeZCnBhMfu3rbr7HUmnIs+/tSeNoazAL3IkFnJpgbKiHafbHuLGkl4dzWf7o1GEX
 i8zg==
X-Gm-Message-State: AOJu0YztWcihaH04Jf+gp79+Bv6GFyNyrO6KXt3px8C+EZEFx8aYrSR0
 oSeKj2ls8nPej7bU8m03gk43BiomcnO68c9RXQfLT1AzMhubBu3Wp40q4QF/ZTc0e9DFvv24S6H
 LoNzy8b13dv0Tp7R5T2vAhp0hfv1jc6iNNw1QAwx/EZnVZ68yc1U6B6lY
X-Gm-Gg: ASbGnctbbZpd4Rw1JyXtZ/9+rzk3YK0vg7NhafujrjjknEdoCRDXq3N91d0SA6JpfkS
 TqMbWg836YL1XrmAZgVUcIl+ehefQ/ZakIlIFn7MguR1CXEXeOLoVlaGx2YOaFnTV822K6yvL/v
 9sGUpG6klhFc3y9iEeSHG+PSmgVZhc7wPMZipPjlufnKAcsvd/5hzfONvehNJtK8JozcN9OQZub
 NcG5s62M3INdc1wZYjMrn96HFjijqu5DbWIe97EYYQPgTPDb5wzBITzDbfPVENGEs7rsbE1Xd7S
X-Received: by 2002:a05:6000:288c:b0:3a4:ef00:a7ba with SMTP id
 ffacd0b85a97d-3a4f33a1ea9mr2036788f8f.2.1748529765327; 
 Thu, 29 May 2025 07:42:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4LCvnzD5t3koDxHtdwcmcAzIJXMsabbIvZxcPI3qvXxnV3Cv9LgWM1lZstp3SF4Lbo659JQ==
X-Received: by 2002:a05:6000:288c:b0:3a4:ef00:a7ba with SMTP id
 ffacd0b85a97d-3a4f33a1ea9mr2036767f8f.2.1748529764861; 
 Thu, 29 May 2025 07:42:44 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe6c7adsm2161348f8f.26.2025.05.29.07.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 07:42:44 -0700 (PDT)
Date: Thu, 29 May 2025 16:42:42 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 05/11] migration: Drop save_live_complete_postcopy hook
Message-ID: <tew2ucyvg2z37rn6fvzwg6kj44crycegpc5jt4kd7unnyy3oqw@qaqb6towtfev>
References: <20250527215850.1271072-1-peterx@redhat.com>
 <20250527215850.1271072-6-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527215850.1271072-6-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Peter

On 2025-05-27 17:58, Peter Xu wrote:
> The hook is only defined in two vmstate users ("ram" and "block dirty
> bitmap"), meanwhile both of them define the hook exactly the same as the
> precopy version.  Hence, this postcopy version isn't needed.
> 
> No functional change intended.

Could be some future users, that would benefit from separate hooks for
precopy and postcopy?

In case we are going to drop it, I think the '_precopy' suffix could be
dropped too, as the handler would be used for postcopy too.

Best regards

Juraj Marcin

> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/migration/register.h   | 24 ++++++++----------------
>  migration/block-dirty-bitmap.c |  1 -
>  migration/ram.c                |  1 -
>  migration/savevm.c             |  9 ++++-----
>  4 files changed, 12 insertions(+), 23 deletions(-)
> 
> diff --git a/include/migration/register.h b/include/migration/register.h
> index b79dc81b8d..e022195785 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -77,26 +77,18 @@ typedef struct SaveVMHandlers {
>       */
>      void (*save_cleanup)(void *opaque);
>  
> -    /**
> -     * @save_live_complete_postcopy
> -     *
> -     * Called at the end of postcopy for all postcopyable devices.
> -     *
> -     * @f: QEMUFile where to send the data
> -     * @opaque: data pointer passed to register_savevm_live()
> -     *
> -     * Returns zero to indicate success and negative for error
> -     */
> -    int (*save_live_complete_postcopy)(QEMUFile *f, void *opaque);
> -
>      /**
>       * @save_live_complete_precopy
>       *
>       * Transmits the last section for the device containing any
> -     * remaining data at the end of a precopy phase. When postcopy is
> -     * enabled, devices that support postcopy will skip this step,
> -     * where the final data will be flushed at the end of postcopy via
> -     * @save_live_complete_postcopy instead.
> +     * remaining data at the end phase of migration.
> +     *
> +     * For precopy, this will be invoked _during_ the switchover phase
> +     * after source VM is stopped.
> +     *
> +     * For postcopy, this will be invoked _after_ the switchover phase
> +     * (except some very unusual cases, like PMEM ramblocks), while
> +     * destination VM can be running.
>       *
>       * @f: QEMUFile where to send the data
>       * @opaque: data pointer passed to register_savevm_live()
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index f2c352d4a7..6ee3c32a76 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -1248,7 +1248,6 @@ static bool dirty_bitmap_has_postcopy(void *opaque)
>  
>  static SaveVMHandlers savevm_dirty_bitmap_handlers = {
>      .save_setup = dirty_bitmap_save_setup,
> -    .save_live_complete_postcopy = dirty_bitmap_save_complete,
>      .save_live_complete_precopy = dirty_bitmap_save_complete,
>      .has_postcopy = dirty_bitmap_has_postcopy,
>      .state_pending_exact = dirty_bitmap_state_pending,
> diff --git a/migration/ram.c b/migration/ram.c
> index fd8d83b63c..8b43b9e1e8 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -4545,7 +4545,6 @@ void postcopy_preempt_shutdown_file(MigrationState *s)
>  static SaveVMHandlers savevm_ram_handlers = {
>      .save_setup = ram_save_setup,
>      .save_live_iterate = ram_save_iterate,
> -    .save_live_complete_postcopy = ram_save_complete,
>      .save_live_complete_precopy = ram_save_complete,
>      .has_postcopy = ram_has_postcopy,
>      .state_pending_exact = ram_state_pending_exact,
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 006514c3e3..26d32eb5a7 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1485,9 +1485,8 @@ bool should_send_vmdesc(void)
>  }
>  
>  /*
> - * Calls the save_live_complete_postcopy methods
> - * causing the last few pages to be sent immediately and doing any associated
> - * cleanup.
> + * Complete saving any postcopy-able devices.
> + *
>   * Note postcopy also calls qemu_savevm_state_complete_precopy to complete
>   * all the other devices, but that happens at the point we switch to postcopy.
>   */
> @@ -1497,7 +1496,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
>      int ret;
>  
>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> -        if (!se->ops || !se->ops->save_live_complete_postcopy) {
> +        if (!se->ops || !se->ops->save_live_complete_precopy) {
>              continue;
>          }
>          if (se->ops->is_active) {
> @@ -1510,7 +1509,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
>          qemu_put_byte(f, QEMU_VM_SECTION_END);
>          qemu_put_be32(f, se->section_id);
>  
> -        ret = se->ops->save_live_complete_postcopy(f, se->opaque);
> +        ret = se->ops->save_live_complete_precopy(f, se->opaque);
>          trace_savevm_section_end(se->idstr, se->section_id, ret);
>          save_section_footer(f, se);
>          if (ret < 0) {
> -- 
> 2.49.0
> 


