Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88435CDB466
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbk8d-0004xr-PQ; Mon, 22 Jun 2026 15:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wbk8b-0004xU-PV
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wbk8Z-0006kr-O5
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782155809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2cc+GWQoUNYp1HXZtIfkTzGhB61kY/InpVSlhcKI+xQ=;
 b=GGz/+UuJZ46t4ncwLkMdFYM6lu4SJ0q6gFUwUhrM34CjPcsv62u8/XYe7VEVZBV3guCsvu
 YRnIXzLgDsm29HKv6LljQ3cQoGfGl/rdPz4WelwnMbrH7stqJskAXbGhYp068RUatUdRTm
 qwELG6p1J0P7qfndRCizPALLu6bkDME=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-QFDiXRseOTKIVFoOV8U37g-1; Mon, 22 Jun 2026 15:16:48 -0400
X-MC-Unique: QFDiXRseOTKIVFoOV8U37g-1
X-Mimecast-MFC-AGG-ID: QFDiXRseOTKIVFoOV8U37g_1782155808
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-91ed0e140c5so1316670385a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782155808; x=1782760608; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2cc+GWQoUNYp1HXZtIfkTzGhB61kY/InpVSlhcKI+xQ=;
 b=sV18AUClu0Gk6pHYD8KLAnyhvFIKjOKL/yOOCD019H1QogJYBw9zP5c00uPB/EhJSl
 paQkErknVtAEw4RPk5XjM9CHoAT2FXupLKT4Wzbt21IH3KgNF3sklHbnGi7SbFu05OP/
 u0y6gWMohJGL6ai/d1DDvSvGbmVWRLb1iJZMiv0Jwlorqj3e4HdysiH6xsfvZY4laUly
 bjWezgBTxnzkGXxp81iyUbMeTeBCkqa0s+eA0LLpy+2AdvUpO7vx14+f52QUMZfruwvu
 +bhFZJ3Yn12aMOV89T9eJZjW0fv2DNcnMNm+W9uhaS1u4aCkFAk1wWwb4x98WHJ/Wpt2
 es4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782155808; x=1782760608;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2cc+GWQoUNYp1HXZtIfkTzGhB61kY/InpVSlhcKI+xQ=;
 b=NyD3cZZxxF6cBXKDkBe6zebR0XrGXaBiSkVbSqc9EtP8PAvw5zOWo5gsp892eU+yPy
 ne4Q10FMrMvgdGC/i9/CLdGAxGwbeUg9dSeV53pcKZa4BWMZvHDx0nxwOM2lCzBATfEc
 qthV2kpBf/SnEX7ynNC7KvXVETc4YPNHEXPBHHq/ZaI0puA/UvSPZ3EtcW6OUP2fs3jb
 lgX+XQwRsoIDBvdp74J+iI2hX1b9cPArZDrz9KG9N/yacPY8U+6omzKred1P4qZaGy6E
 Dqeabdk9aaawv0X8J6mqOtyF7Nb/WJ7jQr+jbrl/FDUs+7zz9ozVDUDd+ITrK3LPzwfE
 +nVw==
X-Gm-Message-State: AOJu0YwxTy4/KJMFdk4m69Sds2CVFn9oU219Yo3oa0l4eOT7Ep9JyULC
 e/OCq7b1VX1bAE3p+XD/0uZ5+DzsGwVTE6sXx7+6aQAWHcdBcU4Yvt7K54bobUJPfeC+CNF9V5J
 aldLJXpp12CJLdzXgEUcdmyCo6QHT4PnK2RDEkbwQV6Fsbf/6WdvlYaYQ
X-Gm-Gg: AfdE7cnmCM4gazAeHwCC25Qu+BNBrgNe5Go6hJSiUaS1qA61piig8JrgT5qqckkBSac
 h+6pE0oj7Anr0DRRhU3tpsEVxrrzgVpFu4BYbLXRwdNpH4gNYuasp0QEEHzB6d9l1J7Tk5n2dVK
 nOihq0HC03edvgceiuwhfm25kOw9FORrAVd2bUsDsOj1IaEB5H230ENBo2UQ2ovsEbegtObKUTp
 EOvI/MwfnFjfVTR9cXDqw8joSQzFHlwhhiQ3xSG3Sb3nQ3vNr7JiQUqdjF2YgNXQoO7yiSA7SIo
 F5xoi+meZbBtwVgYQrfwO9I9Fug2zdVz983F+dyokt1yREXrUf6Av+qFxCCeNyEZedRP7BQPX5r
 iJWML
X-Received: by 2002:a05:620a:470d:b0:915:7e22:6f2e with SMTP id
 af79cd13be357-920900f9a6bmr2494852385a.24.1782155807628; 
 Mon, 22 Jun 2026 12:16:47 -0700 (PDT)
X-Received: by 2002:a05:620a:470d:b0:915:7e22:6f2e with SMTP id
 af79cd13be357-920900f9a6bmr2494848685a.24.1782155807034; 
 Mon, 22 Jun 2026 12:16:47 -0700 (PDT)
Received: from x1.local ([174.91.117.157]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-925fda626adsm59708085a.12.2026.06.22.12.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 12:16:46 -0700 (PDT)
Date: Mon, 22 Jun 2026 15:16:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com
Subject: Re: [RFC PATCH 4/5] migration: write up code to run fast snapshot
 load in qemu_loadvm_state
Message-ID: <ajmKE0Klj2aZpjmq@x1.local>
References: <20260618032010.88755-1-aadeshveer07@gmail.com>
 <20260618032010.88755-5-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260618032010.88755-5-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jun 18, 2026 at 08:50:09AM +0530, Aadeshveer Singh wrote:
> When both mapped-ram and postcopy-ram are set, divert from
> qemu_loadvm_state to run fast snapshot load
> 
> Initialize postcopy RAM state and register RAM Blocks with userfaultfd
> via ram_postcopy_incoming_init() and postcopy_ram_incoming_setup().
> Launch fault thread before VM to serve faults for some hardwares
> emulation that need to read RAM (like vapic devices). Populate bitmaps
> and offset tables while reading file in qemu_loadvm_state_main. Call to
> qemu_loadvm_state_postcopy() which starts the VM using
> loadvm_postcopy_handle_run_bh() and launches eager load thread.
> 
> Skip scheduling process_incoming_migration_bh() in
> process_incoming_migration_co(), for fast snapshot load as the state
> cleanup is managed by eager load thread on completion.
> 
> Skip setting migration status to ACTIVE in process_incoming_migration_co
> and set set it to POSTCOPY_DEVICE in qemu_loadvm_state() itself.
> 
> Remove the capability check that rejected mapped-ram and postcopy-ram
> being set simultaneously, as this combination now corresponds to fast
> snapshot load. The corresponding test will be updated in following
> patch.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> ---
>  migration/migration.c | 10 ++++++---
>  migration/options.c   |  6 -----
>  migration/savevm.c    | 52 +++++++++++++++++++++++++++++++++++++++++--
>  migration/savevm.h    |  2 ++
>  4 files changed, 59 insertions(+), 11 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 074d3f2c69..e1ac310e20 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -756,8 +756,10 @@ process_incoming_migration_co(void *opaque)
>  
>      mis->largest_page_size = qemu_ram_pagesize_largest();
>      postcopy_state_set(POSTCOPY_INCOMING_NONE);
> -    migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
> -                      MIGRATION_STATUS_ACTIVE);
> +    if (!migrate_fast_snapshot_load()) {
> +        migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
> +                          MIGRATION_STATUS_ACTIVE);
> +    }

Is this really needed?  The less common code we touch the better.

I think it's OK having ACTIVE during early load, set POSTCOPY_ACTIVE only
until postcopy setup.

>  
>      mis->loadvm_co = qemu_coroutine_self();
>      ret = qemu_loadvm_state(mis->from_src_file, &local_err);
> @@ -786,7 +788,9 @@ process_incoming_migration_co(void *opaque)
>          colo_incoming_co();
>      }
>  
> -    migration_bh_schedule(process_incoming_migration_bh, mis);
> +    if (!migrate_fast_snapshot_load()) {
> +        migration_bh_schedule(process_incoming_migration_bh, mis);
> +    }

IMHO we should reuse as much postcopy path as possible, like:
 
+static bool                                                                                                                             
+migration_incoming_has_postcopy_thread(MigrationIncomingState *mis)                                                                     
+{                                                                                                                                       
+    return mis->have_listen_thread || mis->have_eager_load_thread;                                                                      
+}                                                                                                                                       
+                                                                                                                                        
 static void coroutine_fn
 process_incoming_migration_co(void *opaque)
 {
@@ -768,7 +774,7 @@ process_incoming_migration_co(void *opaque)
     trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
 
     trace_process_incoming_migration_co_end(ret);
-    if (mis->have_listen_thread) {                                                                                                      
+    if (migration_incoming_has_postcopy_thread(mis)) {                                                                                  
         /*
          * Postcopy was started, cleanup should happen at the end of the
          * postcopy listen thread.
@@ -788,9 +794,7 @@ process_incoming_migration_co(void *opaque)
         colo_incoming_co();
     }
 
-    if (!migrate_fast_snapshot_load()) {                                                                                                
-        migration_bh_schedule(process_incoming_migration_bh, mis);                                                                      
-    }                                                                                                                                   
+    migration_bh_schedule(process_incoming_migration_bh, mis);                                                                          
     goto out;
 

>      goto out;
>  
>  fail:
> diff --git a/migration/options.c b/migration/options.c
> index 5f80dd5b42..3f447cf7b2 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -732,12 +732,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>                         "Mapped-ram migration is incompatible with xbzrle");
>              return false;
>          }
> -
> -        if (new_caps[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
> -            error_setg(errp,
> -                       "Mapped-ram migration is incompatible with postcopy");
> -            return false;
> -        }

Maybe you can split this change into the test file change that reverts that
check, then it can be the last patch.

>      }
>  
>      /*
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 23adaf9dd9..f10cc3c2fc 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2959,6 +2959,32 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
>      return true;
>  }
>  
> +/*
> + * Starts the VM and launches the eager thread for fast snapshot load
> + */
> +int qemu_loadvm_state_postcopy(QEMUFile *f, MigrationIncomingState *mis,
> +                               Error **errp)
> +{
> +    ERRP_GUARD();
> +    int ret = 0;
> +
> +    postcopy_state_set(POSTCOPY_INCOMING_RUNNING);
> +
> +    migration_bh_schedule(loadvm_postcopy_handle_run_bh, mis);
> +
> +    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
> +                      MIGRATION_STATUS_POSTCOPY_ACTIVE);
> +
> +    ret = postcopy_ram_eager_load_setup(mis);
> +    if (ret) {
> +        error_prepend(errp,
> +                      "Failed to setup eager load for fast snapshot load: ");
> +        return ret;
> +    }
> +
> +    return ret;
> +}
> +
>  int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
>                             Error **errp)
>  {
> @@ -3067,8 +3093,30 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
>  
>      cpu_synchronize_all_pre_loadvm();
>  
> -    ret = qemu_loadvm_state_main(f, mis, errp);
> -    qemu_event_set(&mis->main_thread_load_event);
> +    if (migrate_fast_snapshot_load()) {
> +        migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
> +                          MIGRATION_STATUS_POSTCOPY_DEVICE);

Yes, switching to POSTCOPY_DEVICE seems reasonable here.

> +
> +        if (ram_postcopy_incoming_init(mis, errp)) {
> +            return -EINVAL;
> +        }
> +
> +        postcopy_state_set(POSTCOPY_INCOMING_LISTENING);
> +        if (postcopy_ram_incoming_setup(mis)) {
> +            return -EINVAL;

Careful; when returning an error we must make sure *errp is set.  See
postcopy_incoming_setup().

> +        }
> +
> +        ret = qemu_loadvm_state_main(f, mis, errp);
> +
> +        qemu_event_set(&mis->main_thread_load_event);
> +
> +        if (ret == 0) {
> +            ret = qemu_loadvm_state_postcopy(f, mis, errp);
> +        }
> +    } else {
> +        ret = qemu_loadvm_state_main(f, mis, errp);
> +        qemu_event_set(&mis->main_thread_load_event);
> +    }

This chunk may not belong here, qemu_loadvm_state() has three callers, only
process_incoming_migration_co() will use this logic.  Let's move it out
into process_incoming_migration_co() instead.

>  
>      trace_qemu_loadvm_state_post_main(ret);
>  
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 96fdf96d4e..9656acd7fe 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -67,6 +67,8 @@ void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
>  int qemu_save_device_state(QEMUFile *f, Error **errp);
>  int qemu_loadvm_state(QEMUFile *f, Error **errp);
>  void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
> +int qemu_loadvm_state_postcopy(QEMUFile *f, MigrationIncomingState *mis,
> +                               Error **errp);
>  int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
>                             Error **errp);
>  int qemu_load_device_state(QEMUFile *f, Error **errp);
> -- 
> 2.54.0
> 

-- 
Peter Xu


