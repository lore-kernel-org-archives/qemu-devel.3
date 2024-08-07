Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C5AC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 06:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbaTk-0003r4-Kc; Wed, 07 Aug 2024 02:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sbaTh-0003pd-MR
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 02:48:58 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sbaTb-0002Kr-6T
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 02:48:56 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7093c94435bso615736a34.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 23:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1723013206; x=1723618006;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yFSzSkDS3u4gcMiEcFA4GMsKtasFiicCpfBEuJlHna4=;
 b=rZI7d41v/1o7W/0iAscYr+QkrciuKIUABTRafJCXjV5rr+h7yS8xZJ/2Q6eZEaO96m
 iwXVUVcDUyLw3rcksBC/Ghif2lfDwa/TSr05r3YXC8FlH5suvo0oFuMs4Qv2Oo8Rnq0/
 lXUlAQ1Zavc3YVztwGz72shHyI0FMZUAdwd8CVy+rmVkqFZcuUyaA7Rp3bQRflgTzzP4
 Eey63/TJJU8Dya8eUDWrXsVA0fvB4DB+DswgfYCbI8upCwnAQ1zNOw3CXWZtyZOBpN95
 GQk2g9sKLG33mxJOTB4qHnliFFWtsGWADnrl8RA/x1DnOs3OgwF39YTwF6viecYJEBWa
 t8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723013206; x=1723618006;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yFSzSkDS3u4gcMiEcFA4GMsKtasFiicCpfBEuJlHna4=;
 b=cTWblH37r/h3WEXN47OWY/4UxAfUHws6L/BCkuDohZ7kwwHQk5Kq74Bt0TZYve1ICC
 59rdvx5+VtYKs+559ag1YCRMGghBUYMhEGqElUkRzOsE6MSBXu1FaF9MiCatXF/ayoo5
 WBnFhDrP4rWoHnqJ5svkUQtrGktr8qKCMP4M6hj4HzrFMqTUl1bB0MM838BGIKaRlZf9
 xn04vz1QcPblyBlcY8lXXOuDRbMGSoPjvGgX4OYKoF2VIF5llnp2X0KMLt0Thxl+UDkz
 1LYzkEC5AGI7eCFXz63jRgfK6MEZ8msPy8aKMAKzudukqe/S2IDZa0q60cOONmj67VAZ
 I+mw==
X-Gm-Message-State: AOJu0YxxzYjpn9NI2a5WQTtzZOq4wRiW9q+MNh8zWrqzjumcCnY74K1W
 tNQP1nGfNv9xkB7BLS/pIsm3FFaCB0vDW+3BE1nFTwUUSmpa3Z60Kr7CDaIUByG9Jwd+MUaopQN
 vhdLwAtEnXG5FEAEiKCj/6XDc86mlxVl76zINfg==
X-Google-Smtp-Source: AGHT+IF2AgiL43EjEPQ/jq6WPseQKyxNGZSKallLKZ/Jvab3lUoI2GRXaFln5b/gfJcY5AhzqHa99UhZhtQlr0ZeZ4A=
X-Received: by 2002:a05:6870:9a29:b0:254:94a4:35d0 with SMTP id
 586e51a60fabf-26891ee1b54mr17379364fac.48.1723013205796; Tue, 06 Aug 2024
 23:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <89555383887355d848c1005bfde1641bcddff024.1721821071.git.yong.huang@smartx.com>
 <ZqlGjaleFHdnJUZy@x1n>
 <CAK9dgmbkKPDTYv0i1jpASgTR5iN+_4+DrZUxo5VxQF3NdZewaQ@mail.gmail.com>
 <ZrJTDhyRdjEL9VTV@x1n>
In-Reply-To: <ZrJTDhyRdjEL9VTV@x1n>
From: Yong Huang <yong.huang@smartx.com>
Date: Wed, 7 Aug 2024 14:46:29 +0800
Message-ID: <CAK9dgmYcW7C9i+KGMH1pN_QRWy_A1ZGXixi49Unt6VhaP6DVzw@mail.gmail.com>
Subject: Re: [PATCH] migration: Refine the convergence detection
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Content-Type: multipart/alternative; boundary="0000000000001342d2061f12468d"
Received-SPF: none client-ip=2607:f8b0:4864:20::336;
 envelope-from=yong.huang@smartx.com; helo=mail-ot1-x336.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--0000000000001342d2061f12468d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 12:45=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:

> On Mon, Aug 05, 2024 at 03:03:27PM +0800, Yong Huang wrote:
> > Sorry for the late reply.
> >
> > On Wed, Jul 31, 2024 at 4:01=E2=80=AFAM Peter Xu <peterx@redhat.com> wr=
ote:
> >
> > > On Wed, Jul 24, 2024 at 07:39:29PM +0800, Hyman Huang wrote:
> > > > Currently, the convergence algorithm determines that the migration
> > > > cannot converge according to the following principle:
> > > > The dirty pages generated in current iteration exceed a specific
> > > > percentage (throttle-trigger-threshold, 50 by default) of the numbe=
r
> > > > of transmissions. Let's refer to this criteria as the
> > > > "transmission speed," If this criteria is met more than or equal to
> > > > twice (dirty_rate_high_cnt >=3D 2), the throttle percentage needs t=
o
> > > > be increased.
> > > >
> > > > In most cases, above implementation is appropriate. However, for a
> > > > VM with a huge memory and high memory overload, each iteration is
> > >
> > > When you're talking about huge memory, I do agree the current throttl=
e
> > > logic doesn't look like to scale, because migration_trigger_throttle(=
)
> is
> > > only called for each iteration, so it won't be invoked for a long tim=
e
> if
> > > one iteration can take a long time.
> > >
> > > I wonder whether you considered fixing that for a huge VM case in som=
e
> way,
> > > so that we may need to pay for the sync overhead more, but maybe the
> > > throttle logic can still get scheduled from time to time.
> >
> >
> > > E.g., on a 10TB system with even a 100Gbps network, one iteration can
> take:
> > >
> > >   10TB / ~10GB/s =3D ~1000 seconds =3D ~17min
> > >
> > > It means migration_trigger_throttle() will only be invoked once every
> 17
> > > mins.
> >
> >
> > Agree, and another case, VM is at a high dirty rate when migrating,
> > similarly making the iteration take a long time.
> >
> >
> > > > time-consuming. The VM's computing performance may be throttled at
> > > > a high percentage and last for a long time due to the repeated
> > > > confirmation behavior. Which may be intolerable for some
> > > > computationally sensitive software in the VM. The refinement is for
> > > > this scenario.
> > > >
> > > > As the comment mentioned in the migration_trigger_throttle function=
,
> > > > in order to avoid erroneous detection, the original algorithm
> confirms
> > > > the criteria repeatedly. Put differently, once the detection become
> > > > more reliable, it does not need to be confirmed twice.
> > > >
> > > > In the refinement, in order to make the detection more accurate, we
> > > > introduce another criteria, called the "valid transmission ratio"
> > > > to determine the migration convergence. The "valid transmission
> ratio"
> > > > is the ratio of bytes_xfer_period and bytes_dirty_period, which
> > > > actually describe the migration efficiency.
> > > >
> > > > When the algorithm repeatedly detects that the current iteration
> > > > "valid transmission ratio" is lower than the previous iteration,
> > > > the algorithm determines that the migration cannot converge.
> > > >
> > > > For the "transmission speed" and "valid transmission ratio", if one
> > > > of the two criteria is met, the penalty percentage would be
> increased.
> > > > This saves the time of the entire iteration and therefore reduces
> > > > the time of VM performance degradation.
> > > >
> > > > In conclusion, this refinement significantly reduces the processing
> > > > time required for the throttle percentage step to its maximum while
> > > > the VM is under a high memory load.
> > > >
> > > > The following are test environment:
> > > >
> ----------------------------------------------------------------------
> > > > a. Test tool:
> > > > guestperf
> > > >
> > > > Refer to the following link to see details:
> > > > https://github.com/qemu/qemu/tree/master/tests/migration/guestperf
> > > >
> > > > b. Test VM scale:
> > > > CPU: 10; Memory: 28GB
> > >
> > > Isn't 28GB not a huge VM at all?  It'll be nice to know exactly what'=
s
> the
> > > problem behind first.  So are we talking about "real huge VM"s (I'd
> say at
> > > least a few hundreds GBs), or "28GB VMs" (mostly.. every VM QEMU
> invokes)?
> > >
> > > >
> > > > c. Average bandwidth between source and destination for migration:
> > > > 1.53 Gbits/sec
> > > >
> ----------------------------------------------------------------------
> > > > All the supplementary test data shown as follows are basing on
> > > > above test environment.
> > > >
> > > > We use stress tool contained in the initrd-stress.img to update
> > > > ramsize MB on every CPU in guest, refer to the following link to
> > > > see the source code:
> > > > https://github.com/qemu/qemu/blob/master/tests/migration/stress.c
> > > >
> > > > We run the following command to compare our refined QEMU with the
> > > > original QEMU:
> > > >
> > > > $ ./migration/guestperf.py --cpus 10 --mem 28 --max-iters 40 \
> > > > --binary $(path_to_qemu-kvm) \
> > > > --dst-host $(destination_ip) \
> > > > --transport tcp --kernel $(path_to_vmlinuz) \
> > > > --initrd $(path_to_initrd-stress.img) \
> > > > --auto-converge \
> > > > --auto-converge-step 10 \
> > > > --max-iters 40
> > >
> > > So this is for aut-converge.  How's the dirty limit solution?  I am
> > >
> >
> > This patch is a general solution, not just for auto-convergence, here
> > I missed the dirty limit test case, i'll post the dirty limit test resu=
lt
> > in the next version.
> >
> >
> > > surprised you switched to the old one.  Does it mean that
> auto-converge is
> > > better in some cases?
> > >
> >
> > Since for non-x86 hardware platforms, auto-converge is still the only
> > solution
> > to throttle the guest.  It still reap the benefits from this patch.
>
> ARM should have that too now, if that's what you're talking about.
>

Ok, thanks for the tip, i missed the important series:

https://patchew.org/QEMU/20230509022122.20888-1-gshan@redhat.com/
https://lore.kernel.org/kvmarm/20220819005601.198436-1-gshan@redhat.com/#r

I'll try to enable the dirty-limit on both arches and see how it goes.


> Said that, for quite some time I was wondering whether upstream should be
> focused on some solution that will work out for convergence, where I
> ultimately chose postcopy.  That's also why I was asking whether you
> considered postcopy.
>

Get it, so far, applying postcopy still needs more tests and practice for
our
production environment. For stability reasons, it may not be the first
choice for us.


>
> It'll be more focused for everyone if we can have one major solution over
> this problem rather than spreading the energy over a few.
>

Agree.


>
> >
> >
> > >
> > > >
> > > > The following data shows the migration test results with an increas=
e
> in
> > > > stress, ignoring the title row, the odd rows show the unrefined QEM=
U
> > > > test data, and the even rows show the refined QEMU test data:
> > > >
> > > >
> |---------+--------+-----------+--------------+------------+------------|
> > > > | ramsize | sucess | totaltime | downtime(ms) | iterations |
> switchover |
> > > > | (MB)    |        | (ms)      | (ms)         |            |
> throttle   |
> > > > |         |        |           |              |            |
> percent    |
> > > >
> |---------+--------+-----------+--------------+------------+------------|
> > > > |     350 |    yes |    170285 |          399 |         23 |
>  99 |
> > > > |     350 |    yes |     85962 |          412 |         24 |
>  70 |
> > > > |     350 |    yes |    176305 |          199 |         20 |
>  99 |
> > > > |     350 |    yes |     66729 |          321 |         11 |
>  40 |
> > > > |     400 |    yes |    183042 |          469 |         21 |
>  99 |
> > > > |     400 |    yes |     77225 |          421 |         10 |
>  30 |
> > > > |     400 |    yes |    183641 |          866 |         27 |
>  99 |
> > > > |     400 |    yes |     59796 |          479 |         15 |
>  50 |
> > > > |     450 |    yes |    165881 |          820 |         21 |
>  99 |
> > > > |     450 |    yes |     87930 |          368 |         20 |
>  90 |
> > > > |     450 |    yes |    195448 |          452 |         23 |
>  99 |
> > > > |     450 |    yes |     70394 |          295 |          6 |
>  20 |
> > > > |     500 |    yes |    112587 |          471 |         19 |
>  99 |
> > > > |     500 |    yes |     57401 |          299 |          5 |
>  30 |
> > > > |     500 |    yes |    110683 |          657 |         21 |
>  99 |
> > > > |     500 |    yes |     69949 |          649 |          8 |
>  40 |
> > > > |     600 |    yes |    111036 |          324 |         23 |
>  99 |
> > > > |     600 |    yes |     63455 |          346 |          4 |
>  20 |
> > > > |     600 |    yes |    126667 |          426 |         20 |
>  99 |
> > > > |     600 |    yes |    101024 |          643 |         20 |
>  99 |
> > > > |    1000 |    yes |    296216 |          660 |         23 |
>  99 |
> > > > |    1000 |    yes |    106915 |          468 |         16 |
>  99 |
> > > > |    1000 |     no |    300000 |              |            |
>     |
> > > > |    1000 |    yes |    125819 |          824 |         17 |
>  99 |
> > > > |    1200 |     no |    300000 |              |            |
>     |
> > > > |    1200 |    yes |    127379 |          664 |         14 |
>  90 |
> > > > |    1200 |     no |    300000 |              |            |
>     |
> > > > |    1200 |    yes |     67086 |          793 |         11 |
>  50 |
> > > >
> |---------+--------+-----------+--------------+------------+------------|
> > > >
> > > > To summarize the data above, any data that implies negative
> optimization
> > > > does not appear, and morover, the throttle algorithm seems to becom=
e
> more
> > > > responsive to dirty rate increases due to the refined detection.
> > > >
> > > > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > > > ---
> > > >  migration/ram.c        | 48
> +++++++++++++++++++++++++++++++++++++++---
> > > >  migration/trace-events |  1 +
> > > >  2 files changed, 46 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/migration/ram.c b/migration/ram.c
> > > > index edec1a2d07..18b2d422b5 100644
> > > > --- a/migration/ram.c
> > > > +++ b/migration/ram.c
> > > > @@ -414,6 +414,17 @@ struct RAMState {
> > > >       * RAM migration.
> > > >       */
> > > >      unsigned int postcopy_bmap_sync_requested;
> > > > +
> > > > +    /*
> > > > +     * Ratio of bytes_dirty_period and bytes_xfer_period in the la=
st
> > > > +     * iteration
> > > > +     */
> > > > +    uint64_t dirty_ratio_pct;
> > > > +    /*
> > > > +     * How many times is the most recent iteration dirty ratio is
> > > > +     * higher than previous one
> > > > +     */
> > > > +    int dirty_ratio_high_cnt;
> > > >  };
> > > >  typedef struct RAMState RAMState;
> > > >
> > > > @@ -1013,6 +1024,32 @@ static void migration_dirty_limit_guest(void=
)
> > > >      trace_migration_dirty_limit_guest(quota_dirtyrate);
> > > >  }
> > > >
> > > > +static bool migration_dirty_ratio_unexpected(RAMState *rs)
> > > > +{
> > > > +    uint64_t threshold =3D migrate_throttle_trigger_threshold();
> > > > +    uint64_t bytes_xfer_period =3D
> > > > +        migration_transferred_bytes() - rs->bytes_xfer_prev;
> > > > +    uint64_t bytes_dirty_period =3D rs->num_dirty_pages_period *
> > > TARGET_PAGE_SIZE;
> > > > +    uint64_t prev, curr;
> > > > +
> > > > +    /* Skip the first iterations since it isn't helpful */
> > > > +    if (stat64_get(&mig_stats.dirty_sync_count) =3D=3D 1 ||
> > > !bytes_xfer_period) {
> > > > +        return false;
> > > > +    }
> > > > +
> > > > +    curr =3D 100 * (bytes_dirty_period * 1.0 / bytes_xfer_period);
> > > > +
> > > > +    prev =3D rs->dirty_ratio_pct;
> > > > +    rs->dirty_ratio_pct =3D curr;
> > > > +
> > > > +    if (prev =3D=3D 0 || curr <=3D threshold) {
> > > > +        return false;
> > > > +    }
> > > > +
> > > > +    trace_dirty_ratio_pct(curr, prev);
> > > > +    return curr >=3D prev;
> > > > +}
> > > > +
> > > >  static void migration_trigger_throttle(RAMState *rs)
> > > >  {
> > > >      uint64_t threshold =3D migrate_throttle_trigger_threshold();
> > > > @@ -1028,9 +1065,14 @@ static void
> migration_trigger_throttle(RAMState
> > > *rs)
> > > >       * we were in this routine reaches the threshold. If that
> happens
> > > >       * twice, start or increase throttling.
> > > >       */
> > > > -    if ((bytes_dirty_period > bytes_dirty_threshold) &&
> > > > -        (++rs->dirty_rate_high_cnt >=3D 2)) {
> > > > -        rs->dirty_rate_high_cnt =3D 0;
> > > > +    if ((migration_dirty_ratio_unexpected(rs) &&
> > > > +         (++rs->dirty_ratio_high_cnt >=3D 2)) ||
> > > > +        ((bytes_dirty_period > bytes_dirty_threshold) &&
> > > > +         (++rs->dirty_rate_high_cnt >=3D 2))) {
> > >
> > > I'm afraid this is a mess.
> > >
> > > Now it's (A||B) and any condition can trigger this throttle logic.
> Both A
> > > & B make decisions on merely the same parameters.  It's totally
> > > unpredictable to me on how these cnts bumps, and not readable.
> > >
> >
> > Indeed, this is not readable. How about introducing a migration
> capability
> > like "precise-detection" to make this patch backward-compatible?
>
> If we want to do some change here anyway, I'd think it better we do it in
> the best form rather than keep adding caps.


> For now "stick with postcopy" is still one way to go, but not sure whethe=
r
> it applies in your setup.  Otherwise I'd consider we sync more for huge
> VMs.  I mean "throttle only for each sync, sync for each iteration" may
> make sense in the old days, but perhaps not anymore.  That sound like the
> real root cause of this issue.
>

These inspired me,  I'll try this way. :)


>
> >
> >
> > >
> > > What I kind of see how this could make migration shorter is that now
> either
> > > A or B can trigger the throttle, so it triggered in a faster pace tha=
n
> > > before.  E.g. IIUC if we drop dirty_rate_high_cnt completely it'll al=
so
> > > achieve similar thing at least in guestperf tests.
> > >
> >
> > Yes !  I get it, and what my original idea is to drop the
> > dirty_rate_high_cnt.
> >
> > As we mentioned above: migration needs to pay for the sync overhead mor=
e
> > once a VM is configured with huge memory or running at a high dirty rat=
e.
> >
> > Dropping the dirty_rate_high_cnt will make the iteration take less time
> > in above cases.  I think this is feasible since there is no other
> reasons to
> > retain the  dirty_rate_high_cnt once we make the detection precise,
> > let me know if i missed something.
>

I still think dropping the dirty_rate_high_cnt is a refinement. If migratio=
n
has a precise detection of convergence, what do you think of it?


> >
> >
> > >
> > > Have you considered what I mentioned above that may make auto converg=
e
> work
> > > better with "real huge VM"s (by allowing sync >1 times for each
> iteration),
> > > or have you considered postcopy?
> > >
> >
> > Yes, IMHO, this is another refinement direction for the auto-converge,
> we'll
> > try this and keep communication with upstream once it gets progress.
>
> Thanks,
>
> --
> Peter Xu
>
>

--=20
Best regards

--0000000000001342d2061f12468d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 7, 202=
4 at 12:45=E2=80=AFAM Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com" tar=
get=3D"_blank">peterx@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">=
On Mon, Aug 05, 2024 at 03:03:27PM +0800, Yong Huang wrote:<br>
&gt; Sorry for the late reply.<br>
&gt; <br>
&gt; On Wed, Jul 31, 2024 at 4:01=E2=80=AFAM Peter Xu &lt;<a href=3D"mailto=
:peterx@redhat.com" target=3D"_blank">peterx@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Wed, Jul 24, 2024 at 07:39:29PM +0800, Hyman Huang wrote:<br>
&gt; &gt; &gt; Currently, the convergence algorithm determines that the mig=
ration<br>
&gt; &gt; &gt; cannot converge according to the following principle:<br>
&gt; &gt; &gt; The dirty pages generated in current iteration exceed a spec=
ific<br>
&gt; &gt; &gt; percentage (throttle-trigger-threshold, 50 by default) of th=
e number<br>
&gt; &gt; &gt; of transmissions. Let&#39;s refer to this criteria as the<br=
>
&gt; &gt; &gt; &quot;transmission speed,&quot; If this criteria is met more=
 than or equal to<br>
&gt; &gt; &gt; twice (dirty_rate_high_cnt &gt;=3D 2), the throttle percenta=
ge needs to<br>
&gt; &gt; &gt; be increased.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; In most cases, above implementation is appropriate. However,=
 for a<br>
&gt; &gt; &gt; VM with a huge memory and high memory overload, each iterati=
on is<br>
&gt; &gt;<br>
&gt; &gt; When you&#39;re talking about huge memory, I do agree the current=
 throttle<br>
&gt; &gt; logic doesn&#39;t look like to scale, because migration_trigger_t=
hrottle() is<br>
&gt; &gt; only called for each iteration, so it won&#39;t be invoked for a =
long time if<br>
&gt; &gt; one iteration can take a long time.<br>
&gt; &gt;<br>
&gt; &gt; I wonder whether you considered fixing that for a huge VM case in=
 some way,<br>
&gt; &gt; so that we may need to pay for the sync overhead more, but maybe =
the<br>
&gt; &gt; throttle logic can still get scheduled from time to time.<br>
&gt; <br>
&gt; <br>
&gt; &gt; E.g., on a 10TB system with even a 100Gbps network, one iteration=
 can take:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A010TB / ~10GB/s =3D ~1000 seconds =3D ~17min<br>
&gt; &gt;<br>
&gt; &gt; It means migration_trigger_throttle() will only be invoked once e=
very 17<br>
&gt; &gt; mins.<br>
&gt; <br>
&gt; <br>
&gt; Agree, and another case, VM is at a high dirty rate when migrating,<br=
>
&gt; similarly making the iteration take a long time.<br>
&gt; <br>
&gt; <br>
&gt; &gt; &gt; time-consuming. The VM&#39;s computing performance may be th=
rottled at<br>
&gt; &gt; &gt; a high percentage and last for a long time due to the repeat=
ed<br>
&gt; &gt; &gt; confirmation behavior. Which may be intolerable for some<br>
&gt; &gt; &gt; computationally sensitive software in the VM. The refinement=
 is for<br>
&gt; &gt; &gt; this scenario.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; As the comment mentioned in the migration_trigger_throttle f=
unction,<br>
&gt; &gt; &gt; in order to avoid erroneous detection, the original algorith=
m confirms<br>
&gt; &gt; &gt; the criteria repeatedly. Put differently, once the detection=
 become<br>
&gt; &gt; &gt; more reliable, it does not need to be confirmed twice.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; In the refinement, in order to make the detection more accur=
ate, we<br>
&gt; &gt; &gt; introduce another criteria, called the &quot;valid transmiss=
ion ratio&quot;<br>
&gt; &gt; &gt; to determine the migration convergence. The &quot;valid tran=
smission ratio&quot;<br>
&gt; &gt; &gt; is the ratio of bytes_xfer_period and bytes_dirty_period, wh=
ich<br>
&gt; &gt; &gt; actually describe the migration efficiency.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; When the algorithm repeatedly detects that the current itera=
tion<br>
&gt; &gt; &gt; &quot;valid transmission ratio&quot; is lower than the previ=
ous iteration,<br>
&gt; &gt; &gt; the algorithm determines that the migration cannot converge.=
<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; For the &quot;transmission speed&quot; and &quot;valid trans=
mission ratio&quot;, if one<br>
&gt; &gt; &gt; of the two criteria is met, the penalty percentage would be =
increased.<br>
&gt; &gt; &gt; This saves the time of the entire iteration and therefore re=
duces<br>
&gt; &gt; &gt; the time of VM performance degradation.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; In conclusion, this refinement significantly reduces the pro=
cessing<br>
&gt; &gt; &gt; time required for the throttle percentage step to its maximu=
m while<br>
&gt; &gt; &gt; the VM is under a high memory load.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The following are test environment:<br>
&gt; &gt; &gt; ------------------------------------------------------------=
----------<br>
&gt; &gt; &gt; a. Test tool:<br>
&gt; &gt; &gt; guestperf<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Refer to the following link to see details:<br>
&gt; &gt; &gt; <a href=3D"https://github.com/qemu/qemu/tree/master/tests/mi=
gration/guestperf" rel=3D"noreferrer" target=3D"_blank">https://github.com/=
qemu/qemu/tree/master/tests/migration/guestperf</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; b. Test VM scale:<br>
&gt; &gt; &gt; CPU: 10; Memory: 28GB<br>
&gt; &gt;<br>
&gt; &gt; Isn&#39;t 28GB not a huge VM at all?=C2=A0 It&#39;ll be nice to k=
now exactly what&#39;s the<br>
&gt; &gt; problem behind first.=C2=A0 So are we talking about &quot;real hu=
ge VM&quot;s (I&#39;d say at<br>
&gt; &gt; least a few hundreds GBs), or &quot;28GB VMs&quot; (mostly.. ever=
y VM QEMU invokes)?<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; c. Average bandwidth between source and destination for migr=
ation:<br>
&gt; &gt; &gt; 1.53 Gbits/sec<br>
&gt; &gt; &gt; ------------------------------------------------------------=
----------<br>
&gt; &gt; &gt; All the supplementary test data shown as follows are basing =
on<br>
&gt; &gt; &gt; above test environment.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; We use stress tool contained in the initrd-stress.img to upd=
ate<br>
&gt; &gt; &gt; ramsize MB on every CPU in guest, refer to the following lin=
k to<br>
&gt; &gt; &gt; see the source code:<br>
&gt; &gt; &gt; <a href=3D"https://github.com/qemu/qemu/blob/master/tests/mi=
gration/stress.c" rel=3D"noreferrer" target=3D"_blank">https://github.com/q=
emu/qemu/blob/master/tests/migration/stress.c</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; We run the following command to compare our refined QEMU wit=
h the<br>
&gt; &gt; &gt; original QEMU:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; $ ./migration/guestperf.py --cpus 10 --mem 28 --max-iters 40=
 \<br>
&gt; &gt; &gt; --binary $(path_to_qemu-kvm) \<br>
&gt; &gt; &gt; --dst-host $(destination_ip) \<br>
&gt; &gt; &gt; --transport tcp --kernel $(path_to_vmlinuz) \<br>
&gt; &gt; &gt; --initrd $(path_to_initrd-stress.img) \<br>
&gt; &gt; &gt; --auto-converge \<br>
&gt; &gt; &gt; --auto-converge-step 10 \<br>
&gt; &gt; &gt; --max-iters 40<br>
&gt; &gt;<br>
&gt; &gt; So this is for aut-converge.=C2=A0 How&#39;s the dirty limit solu=
tion?=C2=A0 I am<br>
&gt; &gt;<br>
&gt; <br>
&gt; This patch is a general solution, not just for auto-convergence, here<=
br>
&gt; I missed the dirty limit test case, i&#39;ll post the dirty limit test=
 result<br>
&gt; in the next version.<br>
&gt; <br>
&gt; <br>
&gt; &gt; surprised you switched to the old one.=C2=A0 Does it mean that au=
to-converge is<br>
&gt; &gt; better in some cases?<br>
&gt; &gt;<br>
&gt; <br>
&gt; Since for non-x86 hardware platforms, auto-converge is still the only<=
br>
&gt; solution<br>
&gt; to throttle the guest.=C2=A0 It still reap the benefits from this patc=
h.<br>
<br>
ARM should have that too now, if that&#39;s what you&#39;re talking about.<=
br></blockquote><div><br></div><div><div style=3D"font-family:&quot;comic s=
ans ms&quot;,sans-serif" class=3D"gmail_default">Ok, thanks for the tip, i =
missed the important series:</div><div style=3D"font-family:&quot;comic san=
s ms&quot;,sans-serif" class=3D"gmail_default"><br></div><div style=3D"font=
-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default"><a hr=
ef=3D"https://patchew.org/QEMU/20230509022122.20888-1-gshan@redhat.com/">ht=
tps://patchew.org/QEMU/20230509022122.20888-1-gshan@redhat.com/</a></div></=
div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=
=3D"gmail_default"><a href=3D"https://lore.kernel.org/kvmarm/20220819005601=
.198436-1-gshan@redhat.com/#r">https://lore.kernel.org/kvmarm/2022081900560=
1.198436-1-gshan@redhat.com/#r</a></div><div style=3D"font-family:&quot;com=
ic sans ms&quot;,sans-serif" class=3D"gmail_default"><br></div><div style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_defaul=
t">I&#39;ll try to enable the dirty-limit on both arches and see how it goe=
s.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-c=
olor:rgb(204,204,204);padding-left:1ex">
<br>
Said that, for quite some time I was wondering whether upstream should be<b=
r>
focused on some solution that will work out for convergence, where I<br>
ultimately chose postcopy.=C2=A0 That&#39;s also why I was asking whether y=
ou<br>
considered postcopy.<br></blockquote><div><br></div><div><div style=3D"font=
-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">Get i=
t, so far, applying postcopy still needs more tests and practice for our</d=
iv><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D=
"gmail_default">production environment. For stability reasons, it may not b=
e the first</div></div><div style=3D"font-family:&quot;comic sans ms&quot;,=
sans-serif" class=3D"gmail_default">choice for us.</div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);pad=
ding-left:1ex">
<br>
It&#39;ll be more focused for everyone if we can have one major solution ov=
er<br>
this problem rather than spreading the energy over a few.<br></blockquote><=
div><br></div><div><div style=3D"font-family:&quot;comic sans ms&quot;,sans=
-serif" class=3D"gmail_default">Agree.</div></div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-wid=
th:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-l=
eft:1ex">
<br>
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The following data shows the migration test results with an =
increase in<br>
&gt; &gt; &gt; stress, ignoring the title row, the odd rows show the unrefi=
ned QEMU<br>
&gt; &gt; &gt; test data, and the even rows show the refined QEMU test data=
:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; |---------+--------+-----------+--------------+------------+=
------------|<br>
&gt; &gt; &gt; | ramsize | sucess | totaltime | downtime(ms) | iterations |=
 switchover |<br>
&gt; &gt; &gt; | (MB)=C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 | (ms)=C2=
=A0 =C2=A0 =C2=A0 | (ms)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | throttle=C2=A0 =C2=A0|<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | percent=
=C2=A0 =C2=A0 |<br>
&gt; &gt; &gt; |---------+--------+-----------+--------------+------------+=
------------|<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0350 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 1=
70285 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 399 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A023 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A099 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0350 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 =
=C2=A085962 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 412 |=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A024 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A070 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0350 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 1=
76305 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 199 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A020 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A099 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0350 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 =
=C2=A066729 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 321 |=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A011 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A040 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0400 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 1=
83042 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 469 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A021 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A099 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0400 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 =
=C2=A077225 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 421 |=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A010 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A030 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0400 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 1=
83641 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 866 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A027 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A099 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0400 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 =
=C2=A059796 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 479 |=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A015 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A050 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0450 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 1=
65881 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 820 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A021 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A099 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0450 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 =
=C2=A087930 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 368 |=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A020 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A090 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0450 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 1=
95448 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 452 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A023 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A099 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0450 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 =
=C2=A070394 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 295 |=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 6 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A020 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0500 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 1=
12587 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 471 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A019 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A099 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0500 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 =
=C2=A057401 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 299 |=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 5 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A030 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0500 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 1=
10683 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 657 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A021 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A099 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0500 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 =
=C2=A069949 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 649 |=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 8 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A040 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0600 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 1=
11036 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 324 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A023 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A099 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0600 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 =
=C2=A063455 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 346 |=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 4 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A020 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0600 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 1=
26667 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 426 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A020 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A099 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0600 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 1=
01024 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 643 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A020 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A099 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 1000 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 296216=
 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 660 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A023 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A099 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 1000 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 106915=
 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 468 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A016 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A099 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 1000 |=C2=A0 =C2=A0 =C2=A0no |=C2=A0 =C2=A0 3=
00000 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 1000 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 125819=
 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 824 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A017 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A099 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 1200 |=C2=A0 =C2=A0 =C2=A0no |=C2=A0 =C2=A0 3=
00000 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 1200 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 127379=
 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 664 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A014 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A090 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 1200 |=C2=A0 =C2=A0 =C2=A0no |=C2=A0 =C2=A0 3=
00000 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 1200 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 =C2=A0=
67086 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 793 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A011 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A050 |<br>
&gt; &gt; &gt; |---------+--------+-----------+--------------+------------+=
------------|<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; To summarize the data above, any data that implies negative =
optimization<br>
&gt; &gt; &gt; does not appear, and morover, the throttle algorithm seems t=
o become more<br>
&gt; &gt; &gt; responsive to dirty rate increases due to the refined detect=
ion.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@=
smartx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 migration/ram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 48 ++++++=
+++++++++++++++++++++++++++++++++---<br>
&gt; &gt; &gt;=C2=A0 migration/trace-events |=C2=A0 1 +<br>
&gt; &gt; &gt;=C2=A0 2 files changed, 46 insertions(+), 3 deletions(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/migration/ram.c b/migration/ram.c<br>
&gt; &gt; &gt; index edec1a2d07..18b2d422b5 100644<br>
&gt; &gt; &gt; --- a/migration/ram.c<br>
&gt; &gt; &gt; +++ b/migration/ram.c<br>
&gt; &gt; &gt; @@ -414,6 +414,17 @@ struct RAMState {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* RAM migration.<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 unsigned int postcopy_bmap_sync_requeste=
d;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* Ratio of bytes_dirty_period and bytes=
_xfer_period in the last<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* iteration<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint64_t dirty_ratio_pct;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* How many times is the most recent ite=
ration dirty ratio is<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* higher than previous one<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 int dirty_ratio_high_cnt;<br>
&gt; &gt; &gt;=C2=A0 };<br>
&gt; &gt; &gt;=C2=A0 typedef struct RAMState RAMState;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -1013,6 +1024,32 @@ static void migration_dirty_limit_gue=
st(void)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 trace_migration_dirty_limit_guest(quota_=
dirtyrate);<br>
&gt; &gt; &gt;=C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +static bool migration_dirty_ratio_unexpected(RAMState *rs)<=
br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint64_t threshold =3D migrate_throttle_trigg=
er_threshold();<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint64_t bytes_xfer_period =3D<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 migration_transferred_bytes() -=
 rs-&gt;bytes_xfer_prev;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint64_t bytes_dirty_period =3D rs-&gt;num_di=
rty_pages_period *<br>
&gt; &gt; TARGET_PAGE_SIZE;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 uint64_t prev, curr;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /* Skip the first iterations since it isn&#39=
;t helpful */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (stat64_get(&amp;mig_stats.dirty_sync_coun=
t) =3D=3D 1 ||<br>
&gt; &gt; !bytes_xfer_period) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 curr =3D 100 * (bytes_dirty_period * 1.0 / by=
tes_xfer_period);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 prev =3D rs-&gt;dirty_ratio_pct;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 rs-&gt;dirty_ratio_pct =3D curr;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (prev =3D=3D 0 || curr &lt;=3D threshold) =
{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 trace_dirty_ratio_pct(curr, prev);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 return curr &gt;=3D prev;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 static void migration_trigger_throttle(RAMState *rs)<b=
r>
&gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 uint64_t threshold =3D migrate_throttle_=
trigger_threshold();<br>
&gt; &gt; &gt; @@ -1028,9 +1065,14 @@ static void migration_trigger_throttl=
e(RAMState<br>
&gt; &gt; *rs)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* we were in this routine reaches =
the threshold. If that happens<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* twice, start or increase throttl=
ing.<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 if ((bytes_dirty_period &gt; bytes_dirty_thre=
shold) &amp;&amp;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 (++rs-&gt;dirty_rate_high_cnt &=
gt;=3D 2)) {<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 rs-&gt;dirty_rate_high_cnt =3D =
0;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if ((migration_dirty_ratio_unexpected(rs) &am=
p;&amp;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(++rs-&gt;dirty_ratio_hig=
h_cnt &gt;=3D 2)) ||<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ((bytes_dirty_period &gt; bytes=
_dirty_threshold) &amp;&amp;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(++rs-&gt;dirty_rate_high=
_cnt &gt;=3D 2))) {<br>
&gt; &gt;<br>
&gt; &gt; I&#39;m afraid this is a mess.<br>
&gt; &gt;<br>
&gt; &gt; Now it&#39;s (A||B) and any condition can trigger this throttle l=
ogic.=C2=A0 Both A<br>
&gt; &gt; &amp; B make decisions on merely the same parameters.=C2=A0 It&#3=
9;s totally<br>
&gt; &gt; unpredictable to me on how these cnts bumps, and not readable.<br=
>
&gt; &gt;<br>
&gt; <br>
&gt; Indeed, this is not readable. How about introducing a migration capabi=
lity<br>
&gt; like &quot;precise-detection&quot; to make this patch backward-compati=
ble?<br>
<br>
If we want to do some change here anyway, I&#39;d think it better we do it =
in<br>
the best form rather than keep adding caps.</blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
For now &quot;stick with postcopy&quot; is still one way to go, but not sur=
e whether<br>
it applies in your setup.=C2=A0 Otherwise I&#39;d consider we sync more for=
 huge<br>
VMs.=C2=A0 I mean &quot;throttle only for each sync, sync for each iteratio=
n&quot; may<br>
make sense in the old days, but perhaps not anymore.=C2=A0 That sound like =
the<br>
real root cause of this issue.<br></blockquote><div><br></div><div><div sty=
le=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_defa=
ult">These inspired me, =C2=A0I&#39;ll try this way. :)</div></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left-width:1px;border-left-style:solid;border-left-color:rgb(204,2=
04,204);padding-left:1ex">
<br>
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; What I kind of see how this could make migration shorter is that =
now either<br>
&gt; &gt; A or B can trigger the throttle, so it triggered in a faster pace=
 than<br>
&gt; &gt; before.=C2=A0 E.g. IIUC if we drop dirty_rate_high_cnt completely=
 it&#39;ll also<br>
&gt; &gt; achieve similar thing at least in guestperf tests.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Yes !=C2=A0 I get it, and what my original idea is to drop the<br>
&gt; dirty_rate_high_cnt.<br>
&gt; <br>
&gt; As we mentioned above: migration needs to pay for the sync overhead mo=
re<br>
&gt; once a VM is configured with huge memory or running at a high dirty ra=
te.<br>
&gt; <br>
&gt; Dropping the dirty_rate_high_cnt will make the iteration take less tim=
e<br>
&gt; in above cases.=C2=A0 I think this is feasible since there is no other=
 reasons to<br>
&gt; retain the=C2=A0 dirty_rate_high_cnt once we make the detection precis=
e,<br>
&gt; let me know if i missed something.<br></blockquote><div><br></div><div=
><div class=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">I st=
ill think dropping the=C2=A0dirty_rate_high_cnt is a refinement. If migrati=
on</font></div></div><div class=3D"gmail_default"><font face=3D"comic sans =
ms, sans-serif">has a precise detection of convergence, what do you think o=
f it?</font></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;=
border-left-color:rgb(204,204,204);padding-left:1ex">
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; Have you considered what I mentioned above that may make auto con=
verge work<br>
&gt; &gt; better with &quot;real huge VM&quot;s (by allowing sync &gt;1 tim=
es for each iteration),<br>
&gt; &gt; or have you considered postcopy?<br>
&gt; &gt;<br>
&gt; <br>
&gt; Yes, IMHO, this is another refinement direction for the auto-converge,=
 we&#39;ll<br>
&gt; try this and keep communication with upstream once it gets progress.<b=
r>
<br>
Thanks,<br>
<br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--0000000000001342d2061f12468d--

