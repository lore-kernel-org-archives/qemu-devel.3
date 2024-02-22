Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A8FC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 09:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd5Zb-0001y1-IC; Thu, 22 Feb 2024 04:41:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rd5ZZ-0001th-Bh
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 04:40:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rd5ZX-00050P-67
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 04:40:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708594853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xT+hkLjkc/t1gSWHVfi6YqA5Z1Qh0/B0M1FRYVh7D68=;
 b=OHsT6borkaxDXVkV5G4+dxBlmIHHcjjnNlmZyBqsfzcOiRD6NbXOn0Uuz40mB6Vliv1aFf
 apne39a/h4gIzx/4XiHZQS7Y5LI95p4vJTnvItmwtzCHiUBo0O1ZbQHmPHfKmCYLotp93z
 TRsyXcdh/Kqd0UGPmapWTC3jxTO6gOA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-S4q1uq51PfKGvBcOKBQuaQ-1; Thu, 22 Feb 2024 04:40:52 -0500
X-MC-Unique: S4q1uq51PfKGvBcOKBQuaQ-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5cf53f904f9so2035112a12.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 01:40:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708594851; x=1709199651;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xT+hkLjkc/t1gSWHVfi6YqA5Z1Qh0/B0M1FRYVh7D68=;
 b=mmxpt71f/pAilKbvE2fvZ6qSJaBZVL6HT4mqWTFPkDqR7BMzJzSfoExo13dQ50oQ3H
 NLPvSzCSe3dgmGDc0fWmeJh+0fYXb4SdFpt6T8eXAfqDqSx3pNIvhSiJNzwXqO8el10k
 tFjwfPZzUuDHxJDfQA3/Dw14vqsHVT5s5tJKYotaddrxsdiadSx3vrWQP9nZlXXCTHeV
 UWW4zhrxr1UsL78fT+g4Bn0X59Q44KNaaq5frNl2WgTa7hvIU3iOAVYBh0YUoTmg7Yj8
 m+W6URrphHbTojoL+pLTpTKAWzR6Ts3xxaIhbUYHynl/Ri6jiA14R9jiHATIh/8u7H7j
 5XOQ==
X-Gm-Message-State: AOJu0Yw2DC98giHMPzmqiDEi+eymxoAPLISDoUdeNMp2E55OQQz9e1Lg
 jh5OlG1axKK9gDlPqGEr6FRKfd9SCzA530K6/27uoWSb1pkGGBQ94pT0M7pXUYlObS3/NItGEzH
 ZDNvHvuH5gu6vvNYA2hAnqLOQb3FMTvFkzCiDOzam+J1owNJPLkqOedQ3z5veRs8=
X-Received: by 2002:a05:6a00:1acf:b0:6e4:ca0c:3d15 with SMTP id
 f15-20020a056a001acf00b006e4ca0c3d15mr1446217pfv.1.1708594850888; 
 Thu, 22 Feb 2024 01:40:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGN2cFAXZMzE6XVzgX7J8Ge2PtyFA9ZsYb/oOaoED/l1lTjAGjHhtaMb9IPh7hvSWMfwSm0IA==
X-Received: by 2002:a05:6a00:1acf:b0:6e4:ca0c:3d15 with SMTP id
 f15-20020a056a001acf00b006e4ca0c3d15mr1446205pfv.1.1708594850500; 
 Thu, 22 Feb 2024 01:40:50 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 o25-20020a056a001b5900b006e3b868b8b2sm9095061pfv.156.2024.02.22.01.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 01:40:50 -0800 (PST)
Date: Thu, 22 Feb 2024 17:40:41 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: Fix qmp_query_migrate mbps value
Message-ID: <ZdcWmVffLWhNB-Q8@x1n>
References: <20240219194457.26923-1-farosas@suse.de> <ZdVlUsTDJA4hdNhg@x1n>
 <87y1beascb.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y1beascb.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
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

On Wed, Feb 21, 2024 at 09:56:36AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Feb 19, 2024 at 04:44:57PM -0300, Fabiano Rosas wrote:
> >> The QMP command query_migrate might see incorrect throughput numbers
> >> if it runs after we've set the migration completion status but before
> >> migration_calculate_complete() has updated s->total_time and s->mbps.
> >> 
> >> The migration status would show COMPLETED, but the throughput value
> >> would be the one from the last iteration and not the one from the
> >> whole migration. This will usually be a larger value due to the time
> >> period being smaller (one iteration).
> >> 
> >> Move migration_calculate_complete() earlier so that the status
> >> MIGRATION_STATUS_COMPLETED is only emitted after the final counters
> >> update.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >> CI run: https://gitlab.com/farosas/qemu/-/pipelines/1182405776
> >> ---
> >>  migration/migration.c | 10 ++++++----
> >>  1 file changed, 6 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/migration/migration.c b/migration/migration.c
> >> index ab21de2cad..7486d59da0 100644
> >> --- a/migration/migration.c
> >> +++ b/migration/migration.c
> >> @@ -102,6 +102,7 @@ static int migration_maybe_pause(MigrationState *s,
> >>                                   int new_state);
> >>  static void migrate_fd_cancel(MigrationState *s);
> >>  static bool close_return_path_on_source(MigrationState *s);
> >> +static void migration_calculate_complete(MigrationState *s);
> >>  
> >>  static void migration_downtime_start(MigrationState *s)
> >>  {
> >> @@ -2746,6 +2747,7 @@ static void migration_completion(MigrationState *s)
> >>          migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> >>                            MIGRATION_STATUS_COLO);
> >>      } else {
> >> +        migration_calculate_complete(s);
> >>          migrate_set_state(&s->state, current_active_state,
> >>                            MIGRATION_STATUS_COMPLETED);
> >>      }
> >> @@ -2784,6 +2786,7 @@ static void bg_migration_completion(MigrationState *s)
> >>          goto fail;
> >>      }
> >>  
> >> +    migration_calculate_complete(s);
> >>      migrate_set_state(&s->state, current_active_state,
> >>                        MIGRATION_STATUS_COMPLETED);
> >>      return;
> >> @@ -2993,12 +2996,15 @@ static void migration_calculate_complete(MigrationState *s)
> >>      int64_t end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> >>      int64_t transfer_time;
> >>  
> >> +    /* QMP could read from these concurrently */
> >> +    bql_lock();
> >>      migration_downtime_end(s);
> >>      s->total_time = end_time - s->start_time;
> >>      transfer_time = s->total_time - s->setup_time;
> >>      if (transfer_time) {
> >>          s->mbps = ((double) bytes * 8.0) / transfer_time / 1000;
> >>      }
> >> +    bql_unlock();
> >
> > The lock is not needed?
> >
> > AFAIU that was needed because of things like runstate_set() rather than
> > setting of these fields.
> >
> 
> Don't we need to keep the total_time and mbps update atomic? Otherwise
> query-migrate might see (say) total_time=0 and mbps=<correct value> or
> total_time=<correct value> and mbps=<previous value>.

I thought it wasn't a major concern, but what you said makes sense; taking
it one more time doesn't really hurt after all to provide such benefit.

> 
> Also, what orders s->mbps update before the s->state update? I'd say we
> should probably hold the lock around the whole total_time,mbps,state
> update.

IMHO that's fine; mutex unlock implies a RELEASE.  See atomic.rst:

- ``pthread_mutex_lock`` has acquire semantics, ``pthread_mutex_unlock`` has
  release semantics and synchronizes with a ``pthread_mutex_lock`` for the
  same mutex.

> 
> I'm not entirely sure, what do you think?
> 
> > See migration_update_counters() where it also updates mbps without holding
> > a lock.
> 
> Here it might be less important since it's the middle of the migration,
> there will proabably be more than one query-migrate which would see the
> correct values.

Yep.  I queued this.

Thanks,

-- 
Peter Xu


