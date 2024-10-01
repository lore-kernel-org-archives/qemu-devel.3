Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61299CEACDD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 15:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sveo0-0003Ai-B8; Tue, 01 Oct 2024 11:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svenx-000398-PU
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:28:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svenv-0005DG-GP
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727796525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MAH0+haTaGYMyu5IuJT2r6zBtgh4mN9I4nu2eu6Fed8=;
 b=GxJnFWemHZZc0VBt3js8K35KobMczmimecqbkJcI2bTcKF8PVbnKOUCc+Sp291G6/4q0c7
 GOzo8loh0hIZfKTUebi3Fp2HxoHOeuk/3yMmsEC1iratWHGR1xVcKli+ZiBj3v6UBFTXpL
 nDhankFp9aJQVbAs817CnacQ24ZxWnE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-GyVULk-1Mt-HFwRla3kIOg-1; Tue, 01 Oct 2024 11:28:44 -0400
X-MC-Unique: GyVULk-1Mt-HFwRla3kIOg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7a9aae6728aso1270776485a.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 08:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727796524; x=1728401324;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MAH0+haTaGYMyu5IuJT2r6zBtgh4mN9I4nu2eu6Fed8=;
 b=HN3ApJfcwFW3ORXuPDgJeU3nZSEMkTExhAd4bPMOsYOE0NOicY+WhiOt+Adf2K7oAf
 rpww66M9e4nO4K4sXF4nE5s3k0zOvLGmCo/Pqgj6bxoekESQhgnuuonj+60uHrPU4TJr
 muDJSsoZNoIlcdVAMbTSSYw8y57Y6Ofjwh4yf1JxbJKVUNmCfGKaBVf4ZK7O+0SXQrZr
 uYyMfhaJ2umfwcCR66gk30HPZwVqUkWbjvGimT42i7phgGwzESdFHQEXHJ9DfMj8ssuG
 IptkrjOOF+VUxjEMQ5a1+5Z/PPHgilWOZS0AW3Az1MKwXbAVcfuqbLUluNjrMLkU1tkw
 Bi/w==
X-Gm-Message-State: AOJu0YzWIf8n/OdQ5JBjdViEd+MRg7U6cb5MOgbOj4LMwxhL+9N4vU9+
 m/v6L1E88ZlAo71dEo87hIjn8VwqrmE5z0xQC6FC2JVCUfcEYhbMxs41NQZnwX0T2mknw4yUItk
 6TUic29N2dRRcabz3gJAj3t1o0UsD80XAut043ZV0LgHcr/p4PP3+
X-Received: by 2002:a05:620a:3945:b0:7a9:95f6:e372 with SMTP id
 af79cd13be357-7ae5b801728mr657738985a.2.1727796523747; 
 Tue, 01 Oct 2024 08:28:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2N1jRJNXNrsgZjaK5WuisXENYXE8LCLVxywpgUMxoqRdioq2nR7iv964/q4DtYpuPm2PJPQ==
X-Received: by 2002:a05:620a:3945:b0:7a9:95f6:e372 with SMTP id
 af79cd13be357-7ae5b801728mr657734085a.2.1727796523220; 
 Tue, 01 Oct 2024 08:28:43 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae377b860esm520914085a.22.2024.10.01.08.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 08:28:42 -0700 (PDT)
Date: Tue, 1 Oct 2024 11:28:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 1/3] migration: Support background ramblock dirty sync
Message-ID: <ZvwVKDK8doaYDoIu@x1n>
References: <cover.1727630000.git.yong.huang@smartx.com>
 <f36590f60307ce9647d3506e55dcbc2405c98ee2.1727630000.git.yong.huang@smartx.com>
 <ZvsM8LObQlYy6H_O@x1n>
 <CAK9dgmY+88dsg+=rqaWy_E0KX7qyCcr-r4DX8ATyRYB_QOw0WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK9dgmY+88dsg+=rqaWy_E0KX7qyCcr-r4DX8ATyRYB_QOw0WQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Tue, Oct 01, 2024 at 10:02:53AM +0800, Yong Huang wrote:
> On Tue, Oct 1, 2024 at 4:41 AM Peter Xu <peterx@redhat.com> wrote:
> 
> > On Mon, Sep 30, 2024 at 01:14:26AM +0800, yong.huang@smartx.com wrote:
> > > From: Hyman Huang <yong.huang@smartx.com>
> > >
> > > When VM is configured with huge memory, the current throttle logic
> > > doesn't look like to scale, because migration_trigger_throttle()
> > > is only called for each iteration, so it won't be invoked for a long
> > > time if one iteration can take a long time.
> > >
> > > The background dirty sync aim to fix the above issue by synchronizing
> > > the ramblock from remote dirty bitmap and, when necessary, triggering
> > > the CPU throttle multiple times during a long iteration.
> > >
> > > This is a trade-off between synchronization overhead and CPU throttle
> > > impact.
> > >
> > > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > > ---
> > >  include/migration/misc.h     |  3 ++
> > >  migration/migration.c        | 11 +++++++
> > >  migration/ram.c              | 64 ++++++++++++++++++++++++++++++++++++
> > >  migration/ram.h              |  3 ++
> > >  migration/trace-events       |  1 +
> > >  system/cpu-timers.c          |  2 ++
> > >  tests/qtest/migration-test.c | 29 ++++++++++++++++
> > >  7 files changed, 113 insertions(+)
> > >
> > > diff --git a/include/migration/misc.h b/include/migration/misc.h
> > > index bfadc5613b..67c00d98f5 100644
> > > --- a/include/migration/misc.h
> > > +++ b/include/migration/misc.h
> > > @@ -111,4 +111,7 @@ bool migration_in_bg_snapshot(void);
> > >  /* migration/block-dirty-bitmap.c */
> > >  void dirty_bitmap_mig_init(void);
> > >
> > > +/* migration/ram.c */
> > > +void bg_ram_dirty_sync_init(void);
> >
> > IMO it's better we don't add this logic to ram.c as I mentioned.  It's
> > closely relevant to auto converge so I think cpu-throttle.c is more
> > suitable.
> 
> 
> > > +
> > >  #endif
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index 3dea06d577..224b5dfb4f 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -3285,6 +3285,9 @@ static void
> > migration_iteration_finish(MigrationState *s)
> > >  {
> > >      /* If we enabled cpu throttling for auto-converge, turn it off. */
> > >      cpu_throttle_stop();
> > > +    if (migrate_auto_converge()) {
> > > +        bg_ram_dirty_sync_timer_enable(false);
> > > +    }
> >
> > Please avoid adding this code.  When it's part of auto-converge,
> > cpu_throttle_stop() should already guarantee that timer disabled
> > altogether.
> 
> 
> > >
> > >      bql_lock();
> > >      switch (s->state) {
> > > @@ -3526,6 +3529,14 @@ static void *migration_thread(void *opaque)
> > >
> > >      trace_migration_thread_setup_complete();
> > >
> > > +    /*
> > > +     * Tick the background ramblock dirty sync timer after setup
> > > +     * phase.
> > > +     */
> > > +    if (migrate_auto_converge()) {
> > > +        bg_ram_dirty_sync_timer_enable(true);
> > > +    }
> >
> > Might be good to still stick the enablement with auto-converge; the latter
> > was done in migration_trigger_throttle().  Maybe also enable the timer only
> > there?
> >
> 
> Ok.
> 
> 
> > > +
> > >      while (migration_is_active()) {
> > >          if (urgent || !migration_rate_exceeded(s->to_dst_file)) {
> > >              MigIterateState iter_state = migration_iteration_run(s);
> > > diff --git a/migration/ram.c b/migration/ram.c
> > > index 67ca3d5d51..995bae1ac9 100644
> > > --- a/migration/ram.c
> > > +++ b/migration/ram.c
> > > @@ -110,6 +110,12 @@
> > >   */
> > >  #define MAPPED_RAM_LOAD_BUF_SIZE 0x100000
> > >
> > > +/* Background ramblock dirty sync trigger every five seconds */
> > > +#define BG_RAM_SYNC_TIMESLICE_MS 5000
> > > +#define BG_RAM_SYNC_TIMER_INTERVAL_MS 1000
> >
> > Why this timer needs to be invoked every 1sec, if it's a 5sec timer?
> >
> 
> The logic is stupid :(, I'll fix that.
> 
> 
> > > +
> > > +static QEMUTimer *bg_ram_dirty_sync_timer;
> > > +
> > >  XBZRLECacheStats xbzrle_counters;
> > >
> > >  /* used by the search for pages to send */
> > > @@ -4543,6 +4549,64 @@ static void
> > ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
> > >      }
> > >  }
> > >
> > > +static void bg_ram_dirty_sync_timer_tick(void *opaque)
> >
> > Please consider moving this function to cpu-throttle.c.
> >
> 
> Yes, I got your idea, but, IMHO, the cpu-throttle.c only implements the CPU
> throttle, not the ramblock dirty sync, the migration_bitmap_sync_precopy
> could or should not be called in the cpu-throttle.c.Do we want to change
> this code level?
> 
> Another way is we define the bg_ram_dirty_sync_timer in cpu-throttle.c
> and modify it in bg_ram_dirty_sync_timer_tick as a extern variable in ram.c
> I prefer the latter, What do you think of it?

I think it's better all logic resides in cpu-throttle.c.

You can have one pre-requisite patch remove "rs" parameter in
migration_bitmap_sync_precopy(), then export it in migration/misc.h.

Maybe you also need to export time_last_bitmap_sync, you can make another
helper for that and also put it in misc.h too.

Said that all, I wonder whether we should move cpu-throttle.c under
migration/, as that's only used in migration.. then we can avoid exporting
in misc.h, but export them in migration.h (which is for internal only).

> 
> 
> >
> > Also please prefix the functions with cpu_throttle_*(), rather than bg_*().
> > It should be part of auto converge function.
> >
> > > +{
> > > +    static int prev_pct;
> > > +    static uint64_t prev_sync_cnt = 2;
> > > +    uint64_t sync_cnt = stat64_get(&mig_stats.dirty_sync_count);
> > > +    int cur_pct = cpu_throttle_get_percentage();
> > > +
> > > +    if (prev_pct && !cur_pct) {
> > > +        /* CPU throttle timer stopped, so do we */
> > > +        return;
> > > +    }
> >
> > Didn't follow why this is not needed if cpu throttle is 0.
> >
> 
> The sequence in my head is:
> 
> bg dirty sync -> mig_throttle_guest_down -> throttle -> throttle stop-> bg
> dirty sync stop
> 
> The bg dirty sync may be invoked before throttle, and
> the throttle is also 0 at that time, if we code like:
> 
> if (!cpu_throttle_get_percentage()) {
>     return;
> }
> 
> The bg dirty sync timer can tick only once and stop.
> 
> If we change the sequence as following, we can ignore this case:
> 
> mig_throttle_guest_down -> bg dirty sync -> throttle -> throttle stop-> bg
> dirty sync stop
> 
> But as the code in migration_trigger_throttle indicate:
> 
>   if ((bytes_dirty_period > bytes_dirty_threshold) &&
>         ++rs->dirty_rate_high_cnt >= 2) {
>      ...
>   }
> 
> Since the 1st iteration can not satisfy the condition rs->dirty_rate_high_cnt
> >= 2
> as usual, the mig_throttle_guest_down gets invoked in 3nd iteration with
> high
> probability. If the 2nd iteration is very long, the bg dirty sync can not
> be invoked and
> we may lose the chance to trigger CPU throttle as I mentioned.

I wonder whether it's working if we simply put:

  if (!migrate_auto_converge()) {
      return;
  }

I think this timer should kick even if !cpu_throttle_active(), becuase
!active doesn't mean the feature is off.  In this case the feature is
enabled as long as migrate_auto_converge()==true.

This addes another reason that maybe we want to move system/cpu-throttle.c
under migration/.. because otherwise we'll need to export
migrate_auto_converge() once more.

> 
> 
> > It means dirty rate is probably very low, but then shouldn't this
> > background sync still working (just to notice it grows again)?
> >
> > > +
> > > +    /*
> > > +     * The first iteration copies all memory anyhow and has no
> > > +     * effect on guest performance, therefore omit it to avoid
> > > +     * paying extra for the sync penalty.
> > > +     */
> > > +    if (sync_cnt <= 1) {
> > > +        goto end;
> > > +    }
> > > +
> > > +    if (sync_cnt == prev_sync_cnt) {
> > > +        int64_t curr_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> > > +        assert(ram_state);
> > > +        if ((curr_time - ram_state->time_last_bitmap_sync) >
> > > +            BG_RAM_SYNC_TIMESLICE_MS) {
> > > +            trace_bg_ram_dirty_sync();
> > > +            WITH_RCU_READ_LOCK_GUARD() {
> > > +                migration_bitmap_sync_precopy(ram_state, false);
> > > +            }
> > > +        }
> > > +    }
> > > +
> > > +end:
> > > +    prev_sync_cnt = stat64_get(&mig_stats.dirty_sync_count);
> > > +    prev_pct = cpu_throttle_get_percentage();
> > > +
> > > +    timer_mod(bg_ram_dirty_sync_timer,
> > > +        qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) +
> > > +            BG_RAM_SYNC_TIMER_INTERVAL_MS);
> >
> > IIUC we only need to fire per 5sec, not 1s?
> >
> 
> Thanks to point out, I'll refine this logic.
> 
> 
> >
> > > +}
> > > +
> > > +void bg_ram_dirty_sync_timer_enable(bool enable)
> > > +{
> > > +    if (enable) {
> > > +        bg_ram_dirty_sync_timer_tick(NULL);
> > > +    } else {
> > > +        timer_del(bg_ram_dirty_sync_timer);
> > > +    }
> > > +}
> > > +
> > > +void bg_ram_dirty_sync_init(void)
> > > +{
> > > +    bg_ram_dirty_sync_timer =
> > > +        timer_new_ms(QEMU_CLOCK_VIRTUAL_RT,
> > > +                     bg_ram_dirty_sync_timer_tick, NULL);
> > > +}
> >
> > IMHO all these functions should move to cpu-throttle.c.
> >
> > > +
> > >  static RAMBlockNotifier ram_mig_ram_notifier = {
> > >      .ram_block_resized = ram_mig_ram_block_resized,
> > >  };
> > > diff --git a/migration/ram.h b/migration/ram.h
> > > index bc0318b834..9c1a2f30f1 100644
> > > --- a/migration/ram.h
> > > +++ b/migration/ram.h
> > > @@ -93,4 +93,7 @@ void ram_write_tracking_prepare(void);
> > >  int ram_write_tracking_start(void);
> > >  void ram_write_tracking_stop(void);
> > >
> > > +/* Background ramblock dirty sync */
> > > +void bg_ram_dirty_sync_timer_enable(bool enable);
> > > +
> > >  #endif
> > > diff --git a/migration/trace-events b/migration/trace-events
> > > index c65902f042..3f09e7f383 100644
> > > --- a/migration/trace-events
> > > +++ b/migration/trace-events
> > > @@ -90,6 +90,7 @@ put_qlist_end(const char *field_name, const char
> > *vmsd_name) "%s(%s)"
> > >  qemu_file_fclose(void) ""
> > >
> > >  # ram.c
> > > +bg_ram_dirty_sync(void) ""
> > >  get_queued_page(const char *block_name, uint64_t tmp_offset, unsigned
> > long page_abs) "%s/0x%" PRIx64 " page_abs=0x%lx"
> > >  get_queued_page_not_dirty(const char *block_name, uint64_t tmp_offset,
> > unsigned long page_abs) "%s/0x%" PRIx64 " page_abs=0x%lx"
> > >  migration_bitmap_sync_start(void) ""
> > > diff --git a/system/cpu-timers.c b/system/cpu-timers.c
> > > index 0b31c9a1b6..64f0834be4 100644
> > > --- a/system/cpu-timers.c
> > > +++ b/system/cpu-timers.c
> > > @@ -25,6 +25,7 @@
> > >  #include "qemu/osdep.h"
> > >  #include "qemu/cutils.h"
> > >  #include "migration/vmstate.h"
> > > +#include "migration/misc.h"
> > >  #include "qapi/error.h"
> > >  #include "qemu/error-report.h"
> > >  #include "sysemu/cpus.h"
> > > @@ -274,4 +275,5 @@ void cpu_timers_init(void)
> > >      vmstate_register(NULL, 0, &vmstate_timers, &timers_state);
> > >
> > >      cpu_throttle_init();
> > > +    bg_ram_dirty_sync_init();
> > >  }
> > > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> > > index d6768d5d71..3296f5244d 100644
> > > --- a/tests/qtest/migration-test.c
> > > +++ b/tests/qtest/migration-test.c
> > > @@ -468,6 +468,12 @@ static void migrate_ensure_converge(QTestState *who)
> > >      migrate_set_parameter_int(who, "downtime-limit", 30 * 1000);
> > >  }
> > >
> > > +static void migrate_ensure_iteration_last_long(QTestState *who)
> > > +{
> > > +    /* Set 10Byte/s bandwidth limit to make the iteration last long
> > enough */
> > > +    migrate_set_parameter_int(who, "max-bandwidth", 10);
> > > +}
> > > +
> > >  /*
> > >   * Our goal is to ensure that we run a single full migration
> > >   * iteration, and also dirty memory, ensuring that at least
> > > @@ -2791,6 +2797,7 @@ static void test_migrate_auto_converge(void)
> > >       * so we need to decrease a bandwidth.
> > >       */
> > >      const int64_t init_pct = 5, inc_pct = 25, max_pct = 95;
> > > +    uint64_t prev_dirty_sync_cnt, dirty_sync_cnt;
> > >
> > >      if (test_migrate_start(&from, &to, uri, &args)) {
> > >          return;
> > > @@ -2827,6 +2834,28 @@ static void test_migrate_auto_converge(void)
> > >      } while (true);
> > >      /* The first percentage of throttling should be at least init_pct */
> > >      g_assert_cmpint(percentage, >=, init_pct);
> > > +
> > > +    /* Make sure the iteration last a long time enough */
> > > +    migrate_ensure_iteration_last_long(from);
> >
> > There's already migrate_ensure_non_converge(), why this is needed?
> >
> 
> I'm feeling that migrate_ensure_non_converge cannot ensure the
> iteration lasts greater than 5s, so i and an extra util function.

non_converge sets it to 3MB/s, while all qtest mem should be >=100MB on all
archs, it looks ok as of now.  Maybe add a comment would suffice?

It's not extremely bad to even miss one here in unit test, if we target
this feature as pretty much optional on top of auto converge.  If you want
to provide a solid test, you can add a stat counter and check it here with
query-migrate.  But again it'll be better move cpu-throttle.c over first,
or it requires another export in misc.h..

> 
> 
> > > +
> > > +    /*
> > > +     * End the loop when the dirty sync count greater than 1.
> > > +     */
> > > +    while ((dirty_sync_cnt = get_migration_pass(from)) < 2) {
> > > +        usleep(1000 * 1000);
> > > +    }
> > > +
> > > +    prev_dirty_sync_cnt = dirty_sync_cnt;
> > > +
> > > +    /*
> > > +     * The dirty sync count must changes in 5 seconds, here we
> > > +     * plus 1 second as error value.
> > > +     */
> > > +    sleep(5 + 1);
> > > +
> > > +    dirty_sync_cnt = get_migration_pass(from);
> > > +    g_assert_cmpint(dirty_sync_cnt, != , prev_dirty_sync_cnt);
> > > +
> > >      /* Now, when we tested that throttling works, let it converge */
> > >      migrate_ensure_converge(from);
> >
> > Please move the test change into a separate patch.  I had a feeling 5+1 sec
> > might still easily fail on CIs (even though this test is not yet run).
> > Maybe it needs to still provide a loop so it waits for a few rounds just in
> > case.
> >
> 
> OK.
> 
> 
> >
> > Thanks,
> >
> > --
> > Peter Xu
> >
> >
> Thanks,
> Yong
> 
> -- 
> Best regards

-- 
Peter Xu


