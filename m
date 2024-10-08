Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B03CED253
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 02:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxzxU-0001ZI-A0; Mon, 07 Oct 2024 22:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sxzxR-0001Z2-J5
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 22:28:17 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sxzxN-0006jj-6p
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 22:28:17 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5e1b50fea4bso2695811eaf.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 19:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1728354490; x=1728959290;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aG2/cIcPqVp23YjFlE8R1b1qK71JJpSYkgQX6ny/kIQ=;
 b=ZuTlsIUlp5wgXAWHQ+eXsRMrTY8RUrYyz5qxUpBbQ/xdjDrz2zRg4dvrlysTP1m+5K
 twHc3wLQ+zYKXiq/qsFgHco2InJEvGRwQv3f9khXDE0tqD9LsssDANWvkd9jy990OSU7
 ISHrZaRPdKfCMvxaT9ckwADTovWIQvAONElZbEFHQBx/IAvcsaHyo+Fd3iVapZMt5EyC
 TIT+wd0b8HNt5k+jTnaW16xWSvj7oBnqpTCV/siTrDftEFbN/RrPy/IQSqftb0X+9GbH
 FBM0Fc57OmmGp3lowvR3f4XNOD7EqxueFDhXKlDFlYpTUwH55nmcuNbxOkE2zf5U7loU
 AUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728354490; x=1728959290;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aG2/cIcPqVp23YjFlE8R1b1qK71JJpSYkgQX6ny/kIQ=;
 b=RhUMvqe1Nve+xIVxSa/ov4sQkd3kuHa04u/BZkiJq1sn8caM1zI/xALAOg51anx2Yo
 5goGqEKY4daFC1BEeq2QFoHP5vv7xxJVH5SzxOL5IFjMFdCUtckGhebNnSjFag2tTaAp
 Ub1fjnzRglIhRImL4g9rbqfze7bqcWVe2A1ntioAr903v2M5+09j7k9PAXznbQVlU8v8
 ggnUoDa6FAcmL7w8FYsnzdHW2q4Sy0noQ3/lVXelY/WKfXDujq18fa0961SxSmifMGJk
 BkmRXkrIOO4JUAbV4xjKUp1pF1d9Y+A+4P/WOnhU8Pru8XFUsqNnCPAHLKajEsj/ggs/
 vL2w==
X-Gm-Message-State: AOJu0YxrNdLeUdNHqX0CBc8fA8W0cD5owhMtvy2LIlFTNsHufOmduavP
 NXp/mXT4fzgfi1U+6mHydUFXjECPFZjqBG9BBQxOp40DMtBpjmBshvAvrrv5Q3jY4126dmCRcb1
 lOs1J0kzpN+XJX9P75h9vMdQgncA8cxN7iew//Q==
X-Google-Smtp-Source: AGHT+IFrrvbyLbhvn5DMglRnFMygr3mkG0n94dGm1PUAH/kX1w9lf69qR3Uj/u1O+KHRxmFyT/rQtu6MIG+7OAJGiuU=
X-Received: by 2002:a05:6871:441:b0:260:ee13:e665 with SMTP id
 586e51a60fabf-287c214ff76mr8851882fac.37.1728354489861; Mon, 07 Oct 2024
 19:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1727630000.git.yong.huang@smartx.com>
 <f36590f60307ce9647d3506e55dcbc2405c98ee2.1727630000.git.yong.huang@smartx.com>
 <ZvsM8LObQlYy6H_O@x1n>
 <CAK9dgmY+88dsg+=rqaWy_E0KX7qyCcr-r4DX8ATyRYB_QOw0WQ@mail.gmail.com>
 <ZvwVKDK8doaYDoIu@x1n>
In-Reply-To: <ZvwVKDK8doaYDoIu@x1n>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 8 Oct 2024 10:27:53 +0800
Message-ID: <CAK9dgmZuWnS3goeVBvEYHJy3LgYOeqFD4cu0Vneuu_dxPFwZoQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] migration: Support background ramblock dirty sync
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006a23970623ede3e3"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=yong.huang@smartx.com; helo=mail-oo1-xc36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

--0000000000006a23970623ede3e3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 11:28=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:

> On Tue, Oct 01, 2024 at 10:02:53AM +0800, Yong Huang wrote:
> > On Tue, Oct 1, 2024 at 4:41=E2=80=AFAM Peter Xu <peterx@redhat.com> wro=
te:
> >
> > > On Mon, Sep 30, 2024 at 01:14:26AM +0800, yong.huang@smartx.com wrote=
:
> > > > From: Hyman Huang <yong.huang@smartx.com>
> > > >
> > > > When VM is configured with huge memory, the current throttle logic
> > > > doesn't look like to scale, because migration_trigger_throttle()
> > > > is only called for each iteration, so it won't be invoked for a lon=
g
> > > > time if one iteration can take a long time.
> > > >
> > > > The background dirty sync aim to fix the above issue by synchronizi=
ng
> > > > the ramblock from remote dirty bitmap and, when necessary, triggeri=
ng
> > > > the CPU throttle multiple times during a long iteration.
> > > >
> > > > This is a trade-off between synchronization overhead and CPU thrott=
le
> > > > impact.
> > > >
> > > > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > > > ---
> > > >  include/migration/misc.h     |  3 ++
> > > >  migration/migration.c        | 11 +++++++
> > > >  migration/ram.c              | 64
> ++++++++++++++++++++++++++++++++++++
> > > >  migration/ram.h              |  3 ++
> > > >  migration/trace-events       |  1 +
> > > >  system/cpu-timers.c          |  2 ++
> > > >  tests/qtest/migration-test.c | 29 ++++++++++++++++
> > > >  7 files changed, 113 insertions(+)
> > > >
> > > > diff --git a/include/migration/misc.h b/include/migration/misc.h
> > > > index bfadc5613b..67c00d98f5 100644
> > > > --- a/include/migration/misc.h
> > > > +++ b/include/migration/misc.h
> > > > @@ -111,4 +111,7 @@ bool migration_in_bg_snapshot(void);
> > > >  /* migration/block-dirty-bitmap.c */
> > > >  void dirty_bitmap_mig_init(void);
> > > >
> > > > +/* migration/ram.c */
> > > > +void bg_ram_dirty_sync_init(void);
> > >
> > > IMO it's better we don't add this logic to ram.c as I mentioned.  It'=
s
> > > closely relevant to auto converge so I think cpu-throttle.c is more
> > > suitable.
> >
> >
> > > > +
> > > >  #endif
> > > > diff --git a/migration/migration.c b/migration/migration.c
> > > > index 3dea06d577..224b5dfb4f 100644
> > > > --- a/migration/migration.c
> > > > +++ b/migration/migration.c
> > > > @@ -3285,6 +3285,9 @@ static void
> > > migration_iteration_finish(MigrationState *s)
> > > >  {
> > > >      /* If we enabled cpu throttling for auto-converge, turn it off=
.
> */
> > > >      cpu_throttle_stop();
> > > > +    if (migrate_auto_converge()) {
> > > > +        bg_ram_dirty_sync_timer_enable(false);
> > > > +    }
> > >
> > > Please avoid adding this code.  When it's part of auto-converge,
> > > cpu_throttle_stop() should already guarantee that timer disabled
> > > altogether.
> >
> >
> > > >
> > > >      bql_lock();
> > > >      switch (s->state) {
> > > > @@ -3526,6 +3529,14 @@ static void *migration_thread(void *opaque)
> > > >
> > > >      trace_migration_thread_setup_complete();
> > > >
> > > > +    /*
> > > > +     * Tick the background ramblock dirty sync timer after setup
> > > > +     * phase.
> > > > +     */
> > > > +    if (migrate_auto_converge()) {
> > > > +        bg_ram_dirty_sync_timer_enable(true);
> > > > +    }
> > >
> > > Might be good to still stick the enablement with auto-converge; the
> latter
> > > was done in migration_trigger_throttle().  Maybe also enable the time=
r
> only
> > > there?
> > >
> >
> > Ok.
> >
> >
> > > > +
> > > >      while (migration_is_active()) {
> > > >          if (urgent || !migration_rate_exceeded(s->to_dst_file)) {
> > > >              MigIterateState iter_state =3D migration_iteration_run=
(s);
> > > > diff --git a/migration/ram.c b/migration/ram.c
> > > > index 67ca3d5d51..995bae1ac9 100644
> > > > --- a/migration/ram.c
> > > > +++ b/migration/ram.c
> > > > @@ -110,6 +110,12 @@
> > > >   */
> > > >  #define MAPPED_RAM_LOAD_BUF_SIZE 0x100000
> > > >
> > > > +/* Background ramblock dirty sync trigger every five seconds */
> > > > +#define BG_RAM_SYNC_TIMESLICE_MS 5000
> > > > +#define BG_RAM_SYNC_TIMER_INTERVAL_MS 1000
> > >
> > > Why this timer needs to be invoked every 1sec, if it's a 5sec timer?
> > >
> >
> > The logic is stupid :(, I'll fix that.
> >
> >
> > > > +
> > > > +static QEMUTimer *bg_ram_dirty_sync_timer;
> > > > +
> > > >  XBZRLECacheStats xbzrle_counters;
> > > >
> > > >  /* used by the search for pages to send */
> > > > @@ -4543,6 +4549,64 @@ static void
> > > ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
> > > >      }
> > > >  }
> > > >
> > > > +static void bg_ram_dirty_sync_timer_tick(void *opaque)
> > >
> > > Please consider moving this function to cpu-throttle.c.
> > >
> >
> > Yes, I got your idea, but, IMHO, the cpu-throttle.c only implements the
> CPU
> > throttle, not the ramblock dirty sync, the migration_bitmap_sync_precop=
y
> > could or should not be called in the cpu-throttle.c.Do we want to chang=
e
> > this code level?
> >
> > Another way is we define the bg_ram_dirty_sync_timer in cpu-throttle.c
> > and modify it in bg_ram_dirty_sync_timer_tick as a extern variable in
> ram.c
> > I prefer the latter, What do you think of it?
>
> I think it's better all logic resides in cpu-throttle.c.
>
> You can have one pre-requisite patch remove "rs" parameter in
> migration_bitmap_sync_precopy(), then export it in migration/misc.h.
>
> Maybe you also need to export time_last_bitmap_sync, you can make another
> helper for that and also put it in misc.h too.
>
> Said that all, I wonder whether we should move cpu-throttle.c under
> migration/, as that's only used in migration.. then we can avoid exportin=
g
> in misc.h, but export them in migration.h (which is for internal only).


> >
> >
> > >
> > > Also please prefix the functions with cpu_throttle_*(), rather than
> bg_*().
> > > It should be part of auto converge function.
> > >
> > > > +{
> > > > +    static int prev_pct;
> > > > +    static uint64_t prev_sync_cnt =3D 2;
> > > > +    uint64_t sync_cnt =3D stat64_get(&mig_stats.dirty_sync_count);
> > > > +    int cur_pct =3D cpu_throttle_get_percentage();
> > > > +
> > > > +    if (prev_pct && !cur_pct) {
> > > > +        /* CPU throttle timer stopped, so do we */
> > > > +        return;
> > > > +    }
> > >
> > > Didn't follow why this is not needed if cpu throttle is 0.
> > >
> >
> > The sequence in my head is:
> >
> > bg dirty sync -> mig_throttle_guest_down -> throttle -> throttle stop->
> bg
> > dirty sync stop
> >
> > The bg dirty sync may be invoked before throttle, and
> > the throttle is also 0 at that time, if we code like:
> >
> > if (!cpu_throttle_get_percentage()) {
> >     return;
> > }
> >
> > The bg dirty sync timer can tick only once and stop.
> >
> > If we change the sequence as following, we can ignore this case:
> >
> > mig_throttle_guest_down -> bg dirty sync -> throttle -> throttle stop->
> bg
> > dirty sync stop
> >
> > But as the code in migration_trigger_throttle indicate:
> >
> >   if ((bytes_dirty_period > bytes_dirty_threshold) &&
> >         ++rs->dirty_rate_high_cnt >=3D 2) {
> >      ...
> >   }
> >
> > Since the 1st iteration can not satisfy the condition
> rs->dirty_rate_high_cnt
> > >=3D 2
> > as usual, the mig_throttle_guest_down gets invoked in 3nd iteration wit=
h
> > high
> > probability. If the 2nd iteration is very long, the bg dirty sync can n=
ot
> > be invoked and
> > we may lose the chance to trigger CPU throttle as I mentioned.
>
> I wonder whether it's working if we simply put:
>
>   if (!migrate_auto_converge()) {
>       return;
>   }
>
> I think this timer should kick even if !cpu_throttle_active(), becuase
> !active doesn't mean the feature is off.  In this case the feature is
> enabled as long as migrate_auto_converge()=3D=3Dtrue.
>
> This addes another reason that maybe we want to move system/cpu-throttle.=
c
> under migration/.. because otherwise we'll need to export
> migrate_auto_converge() once more.
>
> >
> >
> > > It means dirty rate is probably very low, but then shouldn't this
> > > background sync still working (just to notice it grows again)?
> > >
> > > > +
> > > > +    /*
> > > > +     * The first iteration copies all memory anyhow and has no
> > > > +     * effect on guest performance, therefore omit it to avoid
> > > > +     * paying extra for the sync penalty.
> > > > +     */
> > > > +    if (sync_cnt <=3D 1) {
> > > > +        goto end;
> > > > +    }
> > > > +
> > > > +    if (sync_cnt =3D=3D prev_sync_cnt) {
> > > > +        int64_t curr_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIM=
E);
> > > > +        assert(ram_state);
> > > > +        if ((curr_time - ram_state->time_last_bitmap_sync) >
> > > > +            BG_RAM_SYNC_TIMESLICE_MS) {
> > > > +            trace_bg_ram_dirty_sync();
> > > > +            WITH_RCU_READ_LOCK_GUARD() {
> > > > +                migration_bitmap_sync_precopy(ram_state, false);
> > > > +            }
> > > > +        }
> > > > +    }
> > > > +
> > > > +end:
> > > > +    prev_sync_cnt =3D stat64_get(&mig_stats.dirty_sync_count);
> > > > +    prev_pct =3D cpu_throttle_get_percentage();
> > > > +
> > > > +    timer_mod(bg_ram_dirty_sync_timer,
> > > > +        qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) +
> > > > +            BG_RAM_SYNC_TIMER_INTERVAL_MS);
> > >
> > > IIUC we only need to fire per 5sec, not 1s?
> > >
> >
> > Thanks to point out, I'll refine this logic.
> >
> >
> > >
> > > > +}
> > > > +
> > > > +void bg_ram_dirty_sync_timer_enable(bool enable)
> > > > +{
> > > > +    if (enable) {
> > > > +        bg_ram_dirty_sync_timer_tick(NULL);
> > > > +    } else {
> > > > +        timer_del(bg_ram_dirty_sync_timer);
> > > > +    }
> > > > +}
> > > > +
> > > > +void bg_ram_dirty_sync_init(void)
> > > > +{
> > > > +    bg_ram_dirty_sync_timer =3D
> > > > +        timer_new_ms(QEMU_CLOCK_VIRTUAL_RT,
> > > > +                     bg_ram_dirty_sync_timer_tick, NULL);
> > > > +}
> > >
> > > IMHO all these functions should move to cpu-throttle.c.
> > >
> > > > +
> > > >  static RAMBlockNotifier ram_mig_ram_notifier =3D {
> > > >      .ram_block_resized =3D ram_mig_ram_block_resized,
> > > >  };
> > > > diff --git a/migration/ram.h b/migration/ram.h
> > > > index bc0318b834..9c1a2f30f1 100644
> > > > --- a/migration/ram.h
> > > > +++ b/migration/ram.h
> > > > @@ -93,4 +93,7 @@ void ram_write_tracking_prepare(void);
> > > >  int ram_write_tracking_start(void);
> > > >  void ram_write_tracking_stop(void);
> > > >
> > > > +/* Background ramblock dirty sync */
> > > > +void bg_ram_dirty_sync_timer_enable(bool enable);
> > > > +
> > > >  #endif
> > > > diff --git a/migration/trace-events b/migration/trace-events
> > > > index c65902f042..3f09e7f383 100644
> > > > --- a/migration/trace-events
> > > > +++ b/migration/trace-events
> > > > @@ -90,6 +90,7 @@ put_qlist_end(const char *field_name, const char
> > > *vmsd_name) "%s(%s)"
> > > >  qemu_file_fclose(void) ""
> > > >
> > > >  # ram.c
> > > > +bg_ram_dirty_sync(void) ""
> > > >  get_queued_page(const char *block_name, uint64_t tmp_offset,
> unsigned
> > > long page_abs) "%s/0x%" PRIx64 " page_abs=3D0x%lx"
> > > >  get_queued_page_not_dirty(const char *block_name, uint64_t
> tmp_offset,
> > > unsigned long page_abs) "%s/0x%" PRIx64 " page_abs=3D0x%lx"
> > > >  migration_bitmap_sync_start(void) ""
> > > > diff --git a/system/cpu-timers.c b/system/cpu-timers.c
> > > > index 0b31c9a1b6..64f0834be4 100644
> > > > --- a/system/cpu-timers.c
> > > > +++ b/system/cpu-timers.c
> > > > @@ -25,6 +25,7 @@
> > > >  #include "qemu/osdep.h"
> > > >  #include "qemu/cutils.h"
> > > >  #include "migration/vmstate.h"
> > > > +#include "migration/misc.h"
> > > >  #include "qapi/error.h"
> > > >  #include "qemu/error-report.h"
> > > >  #include "sysemu/cpus.h"
> > > > @@ -274,4 +275,5 @@ void cpu_timers_init(void)
> > > >      vmstate_register(NULL, 0, &vmstate_timers, &timers_state);
> > > >
> > > >      cpu_throttle_init();
> > > > +    bg_ram_dirty_sync_init();
> > > >  }
> > > > diff --git a/tests/qtest/migration-test.c
> b/tests/qtest/migration-test.c
> > > > index d6768d5d71..3296f5244d 100644
> > > > --- a/tests/qtest/migration-test.c
> > > > +++ b/tests/qtest/migration-test.c
> > > > @@ -468,6 +468,12 @@ static void migrate_ensure_converge(QTestState
> *who)
> > > >      migrate_set_parameter_int(who, "downtime-limit", 30 * 1000);
> > > >  }
> > > >
> > > > +static void migrate_ensure_iteration_last_long(QTestState *who)
> > > > +{
> > > > +    /* Set 10Byte/s bandwidth limit to make the iteration last lon=
g
> > > enough */
> > > > +    migrate_set_parameter_int(who, "max-bandwidth", 10);
> > > > +}
> > > > +
> > > >  /*
> > > >   * Our goal is to ensure that we run a single full migration
> > > >   * iteration, and also dirty memory, ensuring that at least
> > > > @@ -2791,6 +2797,7 @@ static void test_migrate_auto_converge(void)
> > > >       * so we need to decrease a bandwidth.
> > > >       */
> > > >      const int64_t init_pct =3D 5, inc_pct =3D 25, max_pct =3D 95;
> > > > +    uint64_t prev_dirty_sync_cnt, dirty_sync_cnt;
> > > >
> > > >      if (test_migrate_start(&from, &to, uri, &args)) {
> > > >          return;
> > > > @@ -2827,6 +2834,28 @@ static void test_migrate_auto_converge(void)
> > > >      } while (true);
> > > >      /* The first percentage of throttling should be at least
> init_pct */
> > > >      g_assert_cmpint(percentage, >=3D, init_pct);
> > > > +
> > > > +    /* Make sure the iteration last a long time enough */
> > > > +    migrate_ensure_iteration_last_long(from);
> > >
> > > There's already migrate_ensure_non_converge(), why this is needed?
> > >
> >
> > I'm feeling that migrate_ensure_non_converge cannot ensure the
> > iteration lasts greater than 5s, so i and an extra util function.
>
> non_converge sets it to 3MB/s, while all qtest mem should be >=3D100MB on=
 all
> archs, it looks ok as of now.  Maybe add a comment would suffice?
>
> It's not extremely bad to even miss one here in unit test, if we target
> this feature as pretty much optional on top of auto converge.  If you wan=
t
> to provide a solid test, you can add a stat counter and check it here wit=
h
> query-migrate.  But again it'll be better move cpu-throttle.c over first,
> or it requires another export in misc.h..
>
> >
> >
> > > > +
> > > > +    /*
> > > > +     * End the loop when the dirty sync count greater than 1.
> > > > +     */
> > > > +    while ((dirty_sync_cnt =3D get_migration_pass(from)) < 2) {
> > > > +        usleep(1000 * 1000);
> > > > +    }
> > > > +
> > > > +    prev_dirty_sync_cnt =3D dirty_sync_cnt;
> > > > +
> > > > +    /*
> > > > +     * The dirty sync count must changes in 5 seconds, here we
> > > > +     * plus 1 second as error value.
> > > > +     */
> > > > +    sleep(5 + 1);
> > > > +
> > > > +    dirty_sync_cnt =3D get_migration_pass(from);
> > > > +    g_assert_cmpint(dirty_sync_cnt, !=3D , prev_dirty_sync_cnt);
> > > > +
> > > >      /* Now, when we tested that throttling works, let it converge =
*/
> > > >      migrate_ensure_converge(from);
> > >
> > > Please move the test change into a separate patch.  I had a feeling
> 5+1 sec
> > > might still easily fail on CIs (even though this test is not yet run)=
.
> > > Maybe it needs to still provide a loop so it waits for a few rounds
> just in
> > > case.
> > >
> >
> > OK.
> >
> >
> > >
> > > Thanks,
> > >
> > > --
> > > Peter Xu
> > >
> > >
> > Thanks,
> > Yong
> >
> > --
> > Best regards
>
>
Sorry for the late reply,  The whole suggestions above are OK for me and
I'll try that in the next version.


> --
> Peter Xu
>
>
Thanks, Yong

--=20
Best regards

--0000000000006a23970623ede3e3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 1, 202=
4 at 11:28=E2=80=AFPM Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com">pet=
erx@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:sol=
id;border-left-color:rgb(204,204,204);padding-left:1ex">On Tue, Oct 01, 202=
4 at 10:02:53AM +0800, Yong Huang wrote:<br>
&gt; On Tue, Oct 1, 2024 at 4:41=E2=80=AFAM Peter Xu &lt;<a href=3D"mailto:=
peterx@redhat.com" target=3D"_blank">peterx@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Mon, Sep 30, 2024 at 01:14:26AM +0800, <a href=3D"mailto:yong.=
huang@smartx.com" target=3D"_blank">yong.huang@smartx.com</a> wrote:<br>
&gt; &gt; &gt; From: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.co=
m" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; When VM is configured with huge memory, the current throttle=
 logic<br>
&gt; &gt; &gt; doesn&#39;t look like to scale, because migration_trigger_th=
rottle()<br>
&gt; &gt; &gt; is only called for each iteration, so it won&#39;t be invoke=
d for a long<br>
&gt; &gt; &gt; time if one iteration can take a long time.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The background dirty sync aim to fix the above issue by sync=
hronizing<br>
&gt; &gt; &gt; the ramblock from remote dirty bitmap and, when necessary, t=
riggering<br>
&gt; &gt; &gt; the CPU throttle multiple times during a long iteration.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; This is a trade-off between synchronization overhead and CPU=
 throttle<br>
&gt; &gt; &gt; impact.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@=
smartx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 include/migration/misc.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 3 =
++<br>
&gt; &gt; &gt;=C2=A0 migration/migration.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 11 =
+++++++<br>
&gt; &gt; &gt;=C2=A0 migration/ram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 64 ++++++++++++++++++++++++++++++++++++<br>
&gt; &gt; &gt;=C2=A0 migration/ram.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 3 ++<br>
&gt; &gt; &gt;=C2=A0 migration/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 1 +<br>
&gt; &gt; &gt;=C2=A0 system/cpu-timers.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 2 ++<br>
&gt; &gt; &gt;=C2=A0 tests/qtest/migration-test.c | 29 ++++++++++++++++<br>
&gt; &gt; &gt;=C2=A0 7 files changed, 113 insertions(+)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/include/migration/misc.h b/include/migration/mi=
sc.h<br>
&gt; &gt; &gt; index bfadc5613b..67c00d98f5 100644<br>
&gt; &gt; &gt; --- a/include/migration/misc.h<br>
&gt; &gt; &gt; +++ b/include/migration/misc.h<br>
&gt; &gt; &gt; @@ -111,4 +111,7 @@ bool migration_in_bg_snapshot(void);<br>
&gt; &gt; &gt;=C2=A0 /* migration/block-dirty-bitmap.c */<br>
&gt; &gt; &gt;=C2=A0 void dirty_bitmap_mig_init(void);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +/* migration/ram.c */<br>
&gt; &gt; &gt; +void bg_ram_dirty_sync_init(void);<br>
&gt; &gt;<br>
&gt; &gt; IMO it&#39;s better we don&#39;t add this logic to ram.c as I men=
tioned.=C2=A0 It&#39;s<br>
&gt; &gt; closely relevant to auto converge so I think cpu-throttle.c is mo=
re<br>
&gt; &gt; suitable.<br>
&gt; <br>
&gt; <br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 #endif<br>
&gt; &gt; &gt; diff --git a/migration/migration.c b/migration/migration.c<b=
r>
&gt; &gt; &gt; index 3dea06d577..224b5dfb4f 100644<br>
&gt; &gt; &gt; --- a/migration/migration.c<br>
&gt; &gt; &gt; +++ b/migration/migration.c<br>
&gt; &gt; &gt; @@ -3285,6 +3285,9 @@ static void<br>
&gt; &gt; migration_iteration_finish(MigrationState *s)<br>
&gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* If we enabled cpu throttling for auto=
-converge, turn it off. */<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 cpu_throttle_stop();<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (migrate_auto_converge()) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bg_ram_dirty_sync_timer_enable(=
false);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; Please avoid adding this code.=C2=A0 When it&#39;s part of auto-c=
onverge,<br>
&gt; &gt; cpu_throttle_stop() should already guarantee that timer disabled<=
br>
&gt; &gt; altogether.<br>
&gt; <br>
&gt; <br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 bql_lock();<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 switch (s-&gt;state) {<br>
&gt; &gt; &gt; @@ -3526,6 +3529,14 @@ static void *migration_thread(void *o=
paque)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 trace_migration_thread_setup_complete();=
<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* Tick the background ramblock dirty sy=
nc timer after setup<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* phase.<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (migrate_auto_converge()) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bg_ram_dirty_sync_timer_enable(=
true);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; Might be good to still stick the enablement with auto-converge; t=
he latter<br>
&gt; &gt; was done in migration_trigger_throttle().=C2=A0 Maybe also enable=
 the timer only<br>
&gt; &gt; there?<br>
&gt; &gt;<br>
&gt; <br>
&gt; Ok.<br>
&gt; <br>
&gt; <br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 while (migration_is_active()) {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (urgent || !migration_r=
ate_exceeded(s-&gt;to_dst_file)) {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MigIterateSt=
ate iter_state =3D migration_iteration_run(s);<br>
&gt; &gt; &gt; diff --git a/migration/ram.c b/migration/ram.c<br>
&gt; &gt; &gt; index 67ca3d5d51..995bae1ac9 100644<br>
&gt; &gt; &gt; --- a/migration/ram.c<br>
&gt; &gt; &gt; +++ b/migration/ram.c<br>
&gt; &gt; &gt; @@ -110,6 +110,12 @@<br>
&gt; &gt; &gt;=C2=A0 =C2=A0*/<br>
&gt; &gt; &gt;=C2=A0 #define MAPPED_RAM_LOAD_BUF_SIZE 0x100000<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +/* Background ramblock dirty sync trigger every five second=
s */<br>
&gt; &gt; &gt; +#define BG_RAM_SYNC_TIMESLICE_MS 5000<br>
&gt; &gt; &gt; +#define BG_RAM_SYNC_TIMER_INTERVAL_MS 1000<br>
&gt; &gt;<br>
&gt; &gt; Why this timer needs to be invoked every 1sec, if it&#39;s a 5sec=
 timer?<br>
&gt; &gt;<br>
&gt; <br>
&gt; The logic is stupid :(, I&#39;ll fix that.<br>
&gt; <br>
&gt; <br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static QEMUTimer *bg_ram_dirty_sync_timer;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 XBZRLECacheStats xbzrle_counters;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 /* used by the search for pages to send */<br>
&gt; &gt; &gt; @@ -4543,6 +4549,64 @@ static void<br>
&gt; &gt; ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;=C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +static void bg_ram_dirty_sync_timer_tick(void *opaque)<br>
&gt; &gt;<br>
&gt; &gt; Please consider moving this function to cpu-throttle.c.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Yes, I got your idea, but, IMHO, the cpu-throttle.c only implements th=
e CPU<br>
&gt; throttle, not the ramblock dirty sync, the migration_bitmap_sync_preco=
py<br>
&gt; could or should not be called in the <a href=3D"http://cpu-throttle.c.=
Do" rel=3D"noreferrer" target=3D"_blank">cpu-throttle.c.Do</a> we want to c=
hange<br>
&gt; this code level?<br>
&gt; <br>
&gt; Another way is we define the bg_ram_dirty_sync_timer in cpu-throttle.c=
<br>
&gt; and modify it in bg_ram_dirty_sync_timer_tick as a extern variable in =
ram.c<br>
&gt; I prefer the latter, What do you think of it?<br>
<br>
I think it&#39;s better all logic resides in cpu-throttle.c.<br>
<br>
You can have one pre-requisite patch remove &quot;rs&quot; parameter in<br>
migration_bitmap_sync_precopy(), then export it in migration/misc.h.<br>
<br>
Maybe you also need to export time_last_bitmap_sync, you can make another<b=
r>
helper for that and also put it in misc.h too.<br>
<br>
Said that all, I wonder whether we should move cpu-throttle.c under<br>
migration/, as that&#39;s only used in migration.. then we can avoid export=
ing<br>
in misc.h, but export them in migration.h (which is for internal only).=C2=
=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:rg=
b(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; Also please prefix the functions with cpu_throttle_*(), rather th=
an bg_*().<br>
&gt; &gt; It should be part of auto converge function.<br>
&gt; &gt;<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 static int prev_pct;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 static uint64_t prev_sync_cnt =3D 2;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint64_t sync_cnt =3D stat64_get(&amp;mig_sta=
ts.dirty_sync_count);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 int cur_pct =3D cpu_throttle_get_percentage()=
;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (prev_pct &amp;&amp; !cur_pct) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* CPU throttle timer stopped, =
so do we */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; Didn&#39;t follow why this is not needed if cpu throttle is 0.<br=
>
&gt; &gt;<br>
&gt; <br>
&gt; The sequence in my head is:<br>
&gt; <br>
&gt; bg dirty sync -&gt; mig_throttle_guest_down -&gt; throttle -&gt; throt=
tle stop-&gt; bg<br>
&gt; dirty sync stop<br>
&gt; <br>
&gt; The bg dirty sync may be invoked before throttle, and<br>
&gt; the throttle is also 0 at that time, if we code like:<br>
&gt; <br>
&gt; if (!cpu_throttle_get_percentage()) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0return;<br>
&gt; }<br>
&gt; <br>
&gt; The bg dirty sync timer can tick only once and stop.<br>
&gt; <br>
&gt; If we change the sequence as following, we can ignore this case:<br>
&gt; <br>
&gt; mig_throttle_guest_down -&gt; bg dirty sync -&gt; throttle -&gt; throt=
tle stop-&gt; bg<br>
&gt; dirty sync stop<br>
&gt; <br>
&gt; But as the code in migration_trigger_throttle indicate:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0if ((bytes_dirty_period &gt; bytes_dirty_threshold) &amp;&=
amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0++rs-&gt;dirty_rate_high_cnt &gt;=3D =
2) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ...<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; <br>
&gt; Since the 1st iteration can not satisfy the condition rs-&gt;dirty_rat=
e_high_cnt<br>
&gt; &gt;=3D 2<br>
&gt; as usual, the mig_throttle_guest_down gets invoked in 3nd iteration wi=
th<br>
&gt; high<br>
&gt; probability. If the 2nd iteration is very long, the bg dirty sync can =
not<br>
&gt; be invoked and<br>
&gt; we may lose the chance to trigger CPU throttle as I mentioned.<br>
<br>
I wonder whether it&#39;s working if we simply put:<br>
<br>
=C2=A0 if (!migrate_auto_converge()) {<br>
=C2=A0 =C2=A0 =C2=A0 return;<br>
=C2=A0 }<br>
<br>
I think this timer should kick even if !cpu_throttle_active(), becuase<br>
!active doesn&#39;t mean the feature is off.=C2=A0 In this case the feature=
 is<br>
enabled as long as migrate_auto_converge()=3D=3Dtrue.<br>
<br>
This addes another reason that maybe we want to move system/cpu-throttle.c<=
br>
under migration/.. because otherwise we&#39;ll need to export<br>
migrate_auto_converge() once more.<br>
<br>
&gt; <br>
&gt; <br>
&gt; &gt; It means dirty rate is probably very low, but then shouldn&#39;t =
this<br>
&gt; &gt; background sync still working (just to notice it grows again)?<br=
>
&gt; &gt;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* The first iteration copies all memory=
 anyhow and has no<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* effect on guest performance, therefor=
e omit it to avoid<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* paying extra for the sync penalty.<br=
>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (sync_cnt &lt;=3D 1) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (sync_cnt =3D=3D prev_sync_cnt) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int64_t curr_time =3D qemu_cloc=
k_get_ms(QEMU_CLOCK_REALTIME);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(ram_state);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((curr_time - ram_state-&gt;=
time_last_bitmap_sync) &gt;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BG_RAM_SYNC_TIMES=
LICE_MS) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_bg_ram_dirt=
y_sync();<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 WITH_RCU_READ_LOC=
K_GUARD() {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mig=
ration_bitmap_sync_precopy(ram_state, false);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +end:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 prev_sync_cnt =3D stat64_get(&amp;mig_stats.d=
irty_sync_count);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 prev_pct =3D cpu_throttle_get_percentage();<b=
r>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 timer_mod(bg_ram_dirty_sync_timer,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_clock_get_ms(QEMU_CLOCK_VI=
RTUAL_RT) +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BG_RAM_SYNC_TIMER=
_INTERVAL_MS);<br>
&gt; &gt;<br>
&gt; &gt; IIUC we only need to fire per 5sec, not 1s?<br>
&gt; &gt;<br>
&gt; <br>
&gt; Thanks to point out, I&#39;ll refine this logic.<br>
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +void bg_ram_dirty_sync_timer_enable(bool enable)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (enable) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bg_ram_dirty_sync_timer_tick(NU=
LL);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 } else {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_del(bg_ram_dirty_sync_tim=
er);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +void bg_ram_dirty_sync_init(void)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 bg_ram_dirty_sync_timer =3D<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_new_ms(QEMU_CLOCK_VIRTUAL=
_RT,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0bg_ram_dirty_sync_timer_tick, NULL);<br>
&gt; &gt; &gt; +}<br>
&gt; &gt;<br>
&gt; &gt; IMHO all these functions should move to cpu-throttle.c.<br>
&gt; &gt;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 static RAMBlockNotifier ram_mig_ram_notifier =3D {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 .ram_block_resized =3D ram_mig_ram_block=
_resized,<br>
&gt; &gt; &gt;=C2=A0 };<br>
&gt; &gt; &gt; diff --git a/migration/ram.h b/migration/ram.h<br>
&gt; &gt; &gt; index bc0318b834..9c1a2f30f1 100644<br>
&gt; &gt; &gt; --- a/migration/ram.h<br>
&gt; &gt; &gt; +++ b/migration/ram.h<br>
&gt; &gt; &gt; @@ -93,4 +93,7 @@ void ram_write_tracking_prepare(void);<br>
&gt; &gt; &gt;=C2=A0 int ram_write_tracking_start(void);<br>
&gt; &gt; &gt;=C2=A0 void ram_write_tracking_stop(void);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +/* Background ramblock dirty sync */<br>
&gt; &gt; &gt; +void bg_ram_dirty_sync_timer_enable(bool enable);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 #endif<br>
&gt; &gt; &gt; diff --git a/migration/trace-events b/migration/trace-events=
<br>
&gt; &gt; &gt; index c65902f042..3f09e7f383 100644<br>
&gt; &gt; &gt; --- a/migration/trace-events<br>
&gt; &gt; &gt; +++ b/migration/trace-events<br>
&gt; &gt; &gt; @@ -90,6 +90,7 @@ put_qlist_end(const char *field_name, cons=
t char<br>
&gt; &gt; *vmsd_name) &quot;%s(%s)&quot;<br>
&gt; &gt; &gt;=C2=A0 qemu_file_fclose(void) &quot;&quot;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 # ram.c<br>
&gt; &gt; &gt; +bg_ram_dirty_sync(void) &quot;&quot;<br>
&gt; &gt; &gt;=C2=A0 get_queued_page(const char *block_name, uint64_t tmp_o=
ffset, unsigned<br>
&gt; &gt; long page_abs) &quot;%s/0x%&quot; PRIx64 &quot; page_abs=3D0x%lx&=
quot;<br>
&gt; &gt; &gt;=C2=A0 get_queued_page_not_dirty(const char *block_name, uint=
64_t tmp_offset,<br>
&gt; &gt; unsigned long page_abs) &quot;%s/0x%&quot; PRIx64 &quot; page_abs=
=3D0x%lx&quot;<br>
&gt; &gt; &gt;=C2=A0 migration_bitmap_sync_start(void) &quot;&quot;<br>
&gt; &gt; &gt; diff --git a/system/cpu-timers.c b/system/cpu-timers.c<br>
&gt; &gt; &gt; index 0b31c9a1b6..64f0834be4 100644<br>
&gt; &gt; &gt; --- a/system/cpu-timers.c<br>
&gt; &gt; &gt; +++ b/system/cpu-timers.c<br>
&gt; &gt; &gt; @@ -25,6 +25,7 @@<br>
&gt; &gt; &gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; &gt; &gt;=C2=A0 #include &quot;qemu/cutils.h&quot;<br>
&gt; &gt; &gt;=C2=A0 #include &quot;migration/vmstate.h&quot;<br>
&gt; &gt; &gt; +#include &quot;migration/misc.h&quot;<br>
&gt; &gt; &gt;=C2=A0 #include &quot;qapi/error.h&quot;<br>
&gt; &gt; &gt;=C2=A0 #include &quot;qemu/error-report.h&quot;<br>
&gt; &gt; &gt;=C2=A0 #include &quot;sysemu/cpus.h&quot;<br>
&gt; &gt; &gt; @@ -274,4 +275,5 @@ void cpu_timers_init(void)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 vmstate_register(NULL, 0, &amp;vmstate_t=
imers, &amp;timers_state);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 cpu_throttle_init();<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 bg_ram_dirty_sync_init();<br>
&gt; &gt; &gt;=C2=A0 }<br>
&gt; &gt; &gt; diff --git a/tests/qtest/migration-test.c b/tests/qtest/migr=
ation-test.c<br>
&gt; &gt; &gt; index d6768d5d71..3296f5244d 100644<br>
&gt; &gt; &gt; --- a/tests/qtest/migration-test.c<br>
&gt; &gt; &gt; +++ b/tests/qtest/migration-test.c<br>
&gt; &gt; &gt; @@ -468,6 +468,12 @@ static void migrate_ensure_converge(QTe=
stState *who)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 migrate_set_parameter_int(who, &quot;dow=
ntime-limit&quot;, 30 * 1000);<br>
&gt; &gt; &gt;=C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +static void migrate_ensure_iteration_last_long(QTestState *=
who)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /* Set 10Byte/s bandwidth limit to make the i=
teration last long<br>
&gt; &gt; enough */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 migrate_set_parameter_int(who, &quot;max-band=
width&quot;, 10);<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 /*<br>
&gt; &gt; &gt;=C2=A0 =C2=A0* Our goal is to ensure that we run a single ful=
l migration<br>
&gt; &gt; &gt;=C2=A0 =C2=A0* iteration, and also dirty memory, ensuring tha=
t at least<br>
&gt; &gt; &gt; @@ -2791,6 +2797,7 @@ static void test_migrate_auto_converge=
(void)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* so we need to decrease a bandwid=
th.<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 const int64_t init_pct =3D 5, inc_pct =
=3D 25, max_pct =3D 95;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint64_t prev_dirty_sync_cnt, dirty_sync_cnt;=
<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (test_migrate_start(&amp;from, &amp;t=
o, uri, &amp;args)) {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt; &gt; @@ -2827,6 +2834,28 @@ static void test_migrate_auto_converg=
e(void)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 } while (true);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* The first percentage of throttling sh=
ould be at least init_pct */<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(percentage, &gt;=3D, ini=
t_pct);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /* Make sure the iteration last a long time e=
nough */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 migrate_ensure_iteration_last_long(from);<br>
&gt; &gt;<br>
&gt; &gt; There&#39;s already migrate_ensure_non_converge(), why this is ne=
eded?<br>
&gt; &gt;<br>
&gt; <br>
&gt; I&#39;m feeling that migrate_ensure_non_converge cannot ensure the<br>
&gt; iteration lasts greater than 5s, so i and an extra util function.<br>
<br>
non_converge sets it to 3MB/s, while all qtest mem should be &gt;=3D100MB o=
n all<br>
archs, it looks ok as of now.=C2=A0 Maybe add a comment would suffice?<br>
<br>
It&#39;s not extremely bad to even miss one here in unit test, if we target=
<br>
this feature as pretty much optional on top of auto converge.=C2=A0 If you =
want<br>
to provide a solid test, you can add a stat counter and check it here with<=
br>
query-migrate.=C2=A0 But again it&#39;ll be better move cpu-throttle.c over=
 first,<br>
or it requires another export in misc.h..<br>
<br>
&gt; <br>
&gt; <br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* End the loop when the dirty sync coun=
t greater than 1.<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 while ((dirty_sync_cnt =3D get_migration_pass=
(from)) &lt; 2) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 usleep(1000 * 1000);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 prev_dirty_sync_cnt =3D dirty_sync_cnt;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* The dirty sync count must changes in =
5 seconds, here we<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* plus 1 second as error value.<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 sleep(5 + 1);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 dirty_sync_cnt =3D get_migration_pass(from);<=
br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 g_assert_cmpint(dirty_sync_cnt, !=3D , prev_d=
irty_sync_cnt);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* Now, when we tested that throttling w=
orks, let it converge */<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 migrate_ensure_converge(from);<br>
&gt; &gt;<br>
&gt; &gt; Please move the test change into a separate patch.=C2=A0 I had a =
feeling 5+1 sec<br>
&gt; &gt; might still easily fail on CIs (even though this test is not yet =
run).<br>
&gt; &gt; Maybe it needs to still provide a loop so it waits for a few roun=
ds just in<br>
&gt; &gt; case.<br>
&gt; &gt;<br>
&gt; <br>
&gt; OK.<br>
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; Peter Xu<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; Thanks,<br>
&gt; Yong<br>
&gt; <br>
&gt; -- <br>
&gt; Best regards<br>
<br></blockquote><div><br></div><div><div style=3D"font-family:&quot;comic =
sans ms&quot;,sans-serif" class=3D"gmail_default">Sorry for the late reply,=
 =C2=A0The whole suggestions above are OK for me and</div><div style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">I&#3=
9;ll try that in the next version.</div></div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1=
px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:=
1ex">
-- <br>
Peter Xu<br>
<br>
</blockquote></div><br clear=3D"all"><div><div style=3D"font-family:&quot;c=
omic sans ms&quot;,sans-serif" class=3D"gmail_default">Thanks, Yong</div><b=
r></div><span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"lt=
r" class=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"comic sans ms, =
sans-serif">Best regards</font></div></div></div>

--0000000000006a23970623ede3e3--

