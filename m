Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A82C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 02:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rccif-0006lw-Gp; Tue, 20 Feb 2024 21:52:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rccie-0006lg-NW
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 21:52:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcciY-000634-4f
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 21:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708483934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3YbgNQB0NpZ3lkGu2keOjqKNdp02NB9102gP5WxcT28=;
 b=iAGH5cmkrraBRozhFrDPf16Z9R8+/hQsC/TGdWiKdomup1Qa/KMuVR1GvHuzDbwZk9apY/
 6n9839TePDjFtoBKkKYwkWaeShqhJ2paKe4aGwJh/JwbrcPrDLFq8P9PSH6R+cSstCgaDm
 jqPoHqVUI0BSMF/2ZpH0ScZfEUgjmQE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-aNr5agzUO8-cF0KqDPL4BA-1; Tue, 20 Feb 2024 21:52:11 -0500
X-MC-Unique: aNr5agzUO8-cF0KqDPL4BA-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5cfccde4a54so2044369a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 18:52:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708483930; x=1709088730;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3YbgNQB0NpZ3lkGu2keOjqKNdp02NB9102gP5WxcT28=;
 b=NownzM3KqjfHCdTqDEk+KulQS2V2wnEnav8je3rryD2KfJ5TuLqDrEjodbrc7/VEra
 asnZMB8bAGBZSmkCisvrGg+tDKnKqBTbio7pzYTwAtLaDiIH28hmihbvqEumaMnyT7Ly
 rYfmeow6BQDWCpX7P3EqrwWVJgUMFQwoelQ5rw3RSuKo6IBo7V167X+8oB9WE/h+VTuq
 B7ycG7y70ETtuYQ4hIbDOUlkPnskdgnDYO/GpigZOC09mQhwasLJLs9lFAYmkOTfuaKE
 D4nuP/eGJ/PuQpWkx3689tIgXQd4P3mZEwJdC89hEn9qgFTG6Eokcf0KZQTtTolD0DE2
 uolg==
X-Gm-Message-State: AOJu0Ywq1WqQTERdzOvcyziWDQOTiLhD8KdaF98LFqc40OQa4Kc05Z7r
 YZWSQyWoyJOTf5iRlPC7N/8r5x0Jpq51O+EU8wjiUuNQupSC1wJxTM/G/kjmMFmm3oAQR05ixg2
 FSgw+v9IN8o6UrWzD6VfFrDpj2Ll3lE0Eq9cMvVM9TyHeiKT/WZSzFj4EI+b8Jfc=
X-Received: by 2002:a17:90a:70c7:b0:298:cc02:4fd2 with SMTP id
 a7-20020a17090a70c700b00298cc024fd2mr12670544pjm.2.1708483930226; 
 Tue, 20 Feb 2024 18:52:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWKApgGSxJB9sQXktjcKLCWLmPNPQo7nW5m14XwtEA4FKCje9TRPuxmJGx0hCbGFcMenlcfw==
X-Received: by 2002:a17:90a:70c7:b0:298:cc02:4fd2 with SMTP id
 a7-20020a17090a70c700b00298cc024fd2mr12670537pjm.2.1708483929905; 
 Tue, 20 Feb 2024 18:52:09 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 w13-20020a17090aea0d00b00298c17e8135sm8357857pjy.13.2024.02.20.18.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 18:52:09 -0800 (PST)
Date: Wed, 21 Feb 2024 10:52:02 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: Fix qmp_query_migrate mbps value
Message-ID: <ZdVlUsTDJA4hdNhg@x1n>
References: <20240219194457.26923-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240219194457.26923-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Feb 19, 2024 at 04:44:57PM -0300, Fabiano Rosas wrote:
> The QMP command query_migrate might see incorrect throughput numbers
> if it runs after we've set the migration completion status but before
> migration_calculate_complete() has updated s->total_time and s->mbps.
> 
> The migration status would show COMPLETED, but the throughput value
> would be the one from the last iteration and not the one from the
> whole migration. This will usually be a larger value due to the time
> period being smaller (one iteration).
> 
> Move migration_calculate_complete() earlier so that the status
> MIGRATION_STATUS_COMPLETED is only emitted after the final counters
> update.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/1182405776
> ---
>  migration/migration.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index ab21de2cad..7486d59da0 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -102,6 +102,7 @@ static int migration_maybe_pause(MigrationState *s,
>                                   int new_state);
>  static void migrate_fd_cancel(MigrationState *s);
>  static bool close_return_path_on_source(MigrationState *s);
> +static void migration_calculate_complete(MigrationState *s);
>  
>  static void migration_downtime_start(MigrationState *s)
>  {
> @@ -2746,6 +2747,7 @@ static void migration_completion(MigrationState *s)
>          migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
>                            MIGRATION_STATUS_COLO);
>      } else {
> +        migration_calculate_complete(s);
>          migrate_set_state(&s->state, current_active_state,
>                            MIGRATION_STATUS_COMPLETED);
>      }
> @@ -2784,6 +2786,7 @@ static void bg_migration_completion(MigrationState *s)
>          goto fail;
>      }
>  
> +    migration_calculate_complete(s);
>      migrate_set_state(&s->state, current_active_state,
>                        MIGRATION_STATUS_COMPLETED);
>      return;
> @@ -2993,12 +2996,15 @@ static void migration_calculate_complete(MigrationState *s)
>      int64_t end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>      int64_t transfer_time;
>  
> +    /* QMP could read from these concurrently */
> +    bql_lock();
>      migration_downtime_end(s);
>      s->total_time = end_time - s->start_time;
>      transfer_time = s->total_time - s->setup_time;
>      if (transfer_time) {
>          s->mbps = ((double) bytes * 8.0) / transfer_time / 1000;
>      }
> +    bql_unlock();

The lock is not needed?

AFAIU that was needed because of things like runstate_set() rather than
setting of these fields.

See migration_update_counters() where it also updates mbps without holding
a lock.

Other than that it looks all good.

>  }
>  
>  static void update_iteration_initial_status(MigrationState *s)
> @@ -3145,7 +3151,6 @@ static void migration_iteration_finish(MigrationState *s)
>      bql_lock();
>      switch (s->state) {
>      case MIGRATION_STATUS_COMPLETED:
> -        migration_calculate_complete(s);
>          runstate_set(RUN_STATE_POSTMIGRATE);
>          break;
>      case MIGRATION_STATUS_COLO:
> @@ -3189,9 +3194,6 @@ static void bg_migration_iteration_finish(MigrationState *s)
>      bql_lock();
>      switch (s->state) {
>      case MIGRATION_STATUS_COMPLETED:
> -        migration_calculate_complete(s);
> -        break;
> -
>      case MIGRATION_STATUS_ACTIVE:
>      case MIGRATION_STATUS_FAILED:
>      case MIGRATION_STATUS_CANCELLED:
> -- 
> 2.35.3
> 

-- 
Peter Xu


