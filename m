Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE23D2A52C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 15:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t16IT-0002Zo-HP; Wed, 16 Oct 2024 11:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t16IR-0002Zg-Kf
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 11:50:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t16IO-0003CB-9z
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 11:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729093840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3+cEWLegSxEivrY5Sv3t2xYsKKAD64MuwTkp99tjmNs=;
 b=FgLy++xSeKNaXfwwfq1g2bm3cpUPNj/q7RqfLKSpuqk88JKtk3HO+TaktNogbm/iUR33U3
 G/Jl2Vf8RaEK0FJpdgQ03kgkQgTsvM7ju/YCz56mtIEE37qITOnbxULsLpFhMkjjC75jfZ
 Aio4G1EKAr9UKcUy7sXHwF6lXOBCbNY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-kTLtz5h6Njmvpfm4h1Kgmg-1; Wed, 16 Oct 2024 11:50:35 -0400
X-MC-Unique: kTLtz5h6Njmvpfm4h1Kgmg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6cc10cd78e4so58250586d6.3
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 08:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729093835; x=1729698635;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3+cEWLegSxEivrY5Sv3t2xYsKKAD64MuwTkp99tjmNs=;
 b=IfA73pT/Zt5mzBvrq/86yjbalyNXDwT6T27ZqzZF6MlPW2qLvRUGBAbrCHj6W6HFtC
 xg4e+JKvVDLEUWamAomCTxQcGpp2TAaeuVhfTyLgJnVDQhinBMq0D6OG0sbLH5QqjwzA
 YZFiM7bIOvro/jcQUxDmYAYkPyxVMZEOYjnjqHaXx2wF9uPYnnQTXNp2etXw3BINPbZY
 d+Kd5OG3921UW6JQ/dn5oL5lOmRvGpSLipLnM4khh0gPwwsLcs/igW9u7TPtb+k/6TkC
 Bsogy3LFwt7aEhxyxwtjTxTZ5m6YlMX/W+8kQ6fdmBMd65sqEHZWEE31Y2eGfbIBmSdL
 VaMQ==
X-Gm-Message-State: AOJu0YyD6K+ZYdTP+CZmuIAAnF1A1AtEwtBjfMPKYarAroxtIVyQZjP0
 GJ+WJHFtyFFRCk59klNYDmU4ZvSSWxtO5RkjA/FG0enOqjFNEqGhvy2Yor7Ae39JUm1KN3cKwii
 IWssh2s3fp99aRqF2oS0kVjhKl9v7Hw+D4rvyNO08vvU4mGg2n5q7
X-Received: by 2002:a05:6214:3204:b0:6cb:f40c:b868 with SMTP id
 6a1803df08f44-6cc2b92dcb0mr56152126d6.46.1729093835270; 
 Wed, 16 Oct 2024 08:50:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+fh7GgkSD6ho+jsndmMk6ebuCtxegwBoFqghZxYqOi2S5lJs7SzWf49a+9G/rBEEuPz1jrw==
X-Received: by 2002:a05:6214:3204:b0:6cb:f40c:b868 with SMTP id
 6a1803df08f44-6cc2b92dcb0mr56151936d6.46.1729093834882; 
 Wed, 16 Oct 2024 08:50:34 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cc2291da52sm19172906d6.39.2024.10.16.08.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 08:50:34 -0700 (PDT)
Date: Wed, 16 Oct 2024 11:50:32 -0400
From: Peter Xu <peterx@redhat.com>
To: yong.huang@smartx.com
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 1/4] migration: Move cpu-throttole.c from system to
 migration
Message-ID: <Zw_gyHy-F7_bZNfD@x1n>
References: <cover.1729064919.git.yong.huang@smartx.com>
 <e41bdd8dde51403a25b817ec49e860f9b515b793.1729064919.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e41bdd8dde51403a25b817ec49e860f9b515b793.1729064919.git.yong.huang@smartx.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Oct 16, 2024 at 03:56:42PM +0800, yong.huang@smartx.com wrote:
> From: Hyman Huang <yong.huang@smartx.com>
> 
> Move cpu-throttle.c from system to migration since it's
> only used for migration; this makes us avoid exporting the
> util functions and variables in misc.h but export them in
> migration.h when implementing the background ramblock dirty
> sync feature in the upcoming commits.
> 
> Additionally, make the two modifications below:
> 
> 1. Delay the timer registering of CPU throttle until
>    migration starts since it is only used in migration.
> 
> 2. Stop CPU throttle if auto converge capability is
>    enabled since it only happens with auto converge.
> 
> 3. Remove the unused header file reference in
>    accel/tcg/icount-common.c.

Please consider split the things into smaller patches, especially when it
involves file movements.

> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  accel/tcg/icount-common.c                    |  1 -
>  {system => migration}/cpu-throttle.c         |  2 +-
>  {include/sysemu => migration}/cpu-throttle.h |  0
>  migration/meson.build                        |  1 +
>  migration/migration.c                        | 11 +++++++++--
>  migration/ram.c                              |  2 +-
>  migration/trace-events                       |  3 +++
>  system/cpu-timers.c                          |  3 ---
>  system/meson.build                           |  1 -
>  system/trace-events                          |  3 ---
>  10 files changed, 15 insertions(+), 12 deletions(-)
>  rename {system => migration}/cpu-throttle.c (99%)
>  rename {include/sysemu => migration}/cpu-throttle.h (100%)
> 
> diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
> index 8d3d3a7e9d..30bf8500dc 100644
> --- a/accel/tcg/icount-common.c
> +++ b/accel/tcg/icount-common.c
> @@ -36,7 +36,6 @@
>  #include "sysemu/runstate.h"
>  #include "hw/core/cpu.h"
>  #include "sysemu/cpu-timers.h"
> -#include "sysemu/cpu-throttle.h"
>  #include "sysemu/cpu-timers-internal.h"
>  
>  /*
> diff --git a/system/cpu-throttle.c b/migration/cpu-throttle.c
> similarity index 99%
> rename from system/cpu-throttle.c
> rename to migration/cpu-throttle.c
> index 7632dc6143..fa47ee2e21 100644
> --- a/system/cpu-throttle.c
> +++ b/migration/cpu-throttle.c
> @@ -27,7 +27,7 @@
>  #include "hw/core/cpu.h"
>  #include "qemu/main-loop.h"
>  #include "sysemu/cpus.h"
> -#include "sysemu/cpu-throttle.h"
> +#include "cpu-throttle.h"
>  #include "trace.h"
>  
>  /* vcpu throttling controls */
> diff --git a/include/sysemu/cpu-throttle.h b/migration/cpu-throttle.h
> similarity index 100%
> rename from include/sysemu/cpu-throttle.h
> rename to migration/cpu-throttle.h
> diff --git a/migration/meson.build b/migration/meson.build
> index 66d3de86f0..d53cf3417a 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -13,6 +13,7 @@ system_ss.add(files(
>    'block-dirty-bitmap.c',
>    'channel.c',
>    'channel-block.c',
> +  'cpu-throttle.c',
>    'dirtyrate.c',
>    'exec.c',
>    'fd.c',
> diff --git a/migration/migration.c b/migration/migration.c
> index 021faee2f3..7e71184257 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -24,7 +24,7 @@
>  #include "socket.h"
>  #include "sysemu/runstate.h"
>  #include "sysemu/sysemu.h"
> -#include "sysemu/cpu-throttle.h"
> +#include "cpu-throttle.h"
>  #include "rdma.h"
>  #include "ram.h"
>  #include "migration/global_state.h"
> @@ -3289,7 +3289,9 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>  static void migration_iteration_finish(MigrationState *s)
>  {
>      /* If we enabled cpu throttling for auto-converge, turn it off. */
> -    cpu_throttle_stop();
> +    if (migrate_auto_converge()) {
> +        cpu_throttle_stop();
> +    }
>  
>      bql_lock();
>      switch (s->state) {
> @@ -3508,6 +3510,11 @@ static void *migration_thread(void *opaque)
>          qemu_savevm_send_colo_enable(s->to_dst_file);
>      }
>  
> +    if (migrate_auto_converge()) {
> +        /* Start cpu throttle timers */
> +        cpu_throttle_init();
> +    }

Might this leak the timer object? 

I think it perhaps needs to be moved to migration_object_init().

> +
>      bql_lock();
>      ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
>      bql_unlock();
> diff --git a/migration/ram.c b/migration/ram.c
> index 326ce7eb79..54d352b152 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -52,7 +52,7 @@
>  #include "exec/target_page.h"
>  #include "qemu/rcu_queue.h"
>  #include "migration/colo.h"
> -#include "sysemu/cpu-throttle.h"
> +#include "cpu-throttle.h"
>  #include "savevm.h"
>  #include "qemu/iov.h"
>  #include "multifd.h"
> diff --git a/migration/trace-events b/migration/trace-events
> index c65902f042..9a19599804 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -378,3 +378,6 @@ migration_block_progression(unsigned percent) "Completed %u%%"
>  # page_cache.c
>  migration_pagecache_init(int64_t max_num_items) "Setting cache buckets to %" PRId64
>  migration_pagecache_insert(void) "Error allocating page"
> +
> +# cpu-throttle.c
> +cpu_throttle_set(int new_throttle_pct)  "set guest CPU throttled by %d%%"
> diff --git a/system/cpu-timers.c b/system/cpu-timers.c
> index 0b31c9a1b6..856e502e34 100644
> --- a/system/cpu-timers.c
> +++ b/system/cpu-timers.c
> @@ -35,7 +35,6 @@
>  #include "sysemu/runstate.h"
>  #include "hw/core/cpu.h"
>  #include "sysemu/cpu-timers.h"
> -#include "sysemu/cpu-throttle.h"
>  #include "sysemu/cpu-timers-internal.h"
>  
>  /* clock and ticks */
> @@ -272,6 +271,4 @@ void cpu_timers_init(void)
>      seqlock_init(&timers_state.vm_clock_seqlock);
>      qemu_spin_init(&timers_state.vm_clock_lock);
>      vmstate_register(NULL, 0, &vmstate_timers, &timers_state);
> -
> -    cpu_throttle_init();
>  }
> diff --git a/system/meson.build b/system/meson.build
> index a296270cb0..4952f4b2c7 100644
> --- a/system/meson.build
> +++ b/system/meson.build
> @@ -10,7 +10,6 @@ system_ss.add(files(
>    'balloon.c',
>    'bootdevice.c',
>    'cpus.c',
> -  'cpu-throttle.c',
>    'cpu-timers.c',
>    'datadir.c',
>    'dirtylimit.c',
> diff --git a/system/trace-events b/system/trace-events
> index 074d001e90..2ed1d59b1f 100644
> --- a/system/trace-events
> +++ b/system/trace-events
> @@ -44,6 +44,3 @@ dirtylimit_state_finalize(void)
>  dirtylimit_throttle_pct(int cpu_index, uint64_t pct, int64_t time_us) "CPU[%d] throttle percent: %" PRIu64 ", throttle adjust time %"PRIi64 " us"
>  dirtylimit_set_vcpu(int cpu_index, uint64_t quota) "CPU[%d] set dirty page rate limit %"PRIu64
>  dirtylimit_vcpu_execute(int cpu_index, int64_t sleep_time_us) "CPU[%d] sleep %"PRIi64 " us"
> -
> -# cpu-throttle.c
> -cpu_throttle_set(int new_throttle_pct)  "set guest CPU throttled by %d%%"
> -- 
> 2.27.0
> 

-- 
Peter Xu


