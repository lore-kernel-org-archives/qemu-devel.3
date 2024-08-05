Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98148C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 07:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sarn6-0005TE-RA; Mon, 05 Aug 2024 03:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sarmz-0005Rw-3b
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 03:05:54 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sarmu-0006Pq-D9
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 03:05:52 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5d80752933bso1067426eaf.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 00:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1722841425; x=1723446225;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ptfD4qW6hwJe4KpE4zqI5+jWUJaVeeiI8vz9O4s0kC8=;
 b=AXoTDsR4Bhdbf0d+6RkRZof1c1lCrcYdK0ljLgyTHuyJX92UNOJrAL3FwKATO+NZCH
 lUgWhEGZ5wsxDa2tEvMAa1Uv8nnF0Ly5s2OFVl7wsxKsWnzCWjtwD0DU7Ods2IXQijm6
 k0IKDyaOhyUDNdi71oNjGeUMvy93mlemQ7416Q28H8iLX0pdKHCHAJByG1/hq0KnUSh6
 SiUHlzfwO4EjWF78PZ3WD1i0mN8jBp0BNWCwRDDcSKlQqeFRGFwevqI7tdK7xZcWGpP9
 s6oZ/kFC2AKW8TRDnLiNSbcn8ArqkteuXhZYVknrOhKDE54YsmpmavKPiVyp5G3ASHrr
 4MsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722841425; x=1723446225;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ptfD4qW6hwJe4KpE4zqI5+jWUJaVeeiI8vz9O4s0kC8=;
 b=ud7SH8cEsiDNK/ZJyUPu22l/b2G46stcj54bRky20uJ/S0zxbzQLdDuDSu650ptzSX
 7X1GDh3obNstR1HvhTXzqhG2UQ/ig9IDDnVFw7DUpEwlaErrb2fZNBgQ1YLPyXFdHOpr
 9yWXZhJUP14AB0cJhOAJWE7nbgFnPcPigj1n4PPz8SfXydl/rukExiYQBkqOh3zByYhY
 6MwRpxnyGOlglXQrZOi9W5vvIDYZ82Pj/ovtURcTaws5PWHa08H3USN0RprfIHY9AgKI
 zHfl6PhybX5eob4uMy5ub9KOa/MGr+OvfrOKeWW6XbknYOfb57mj2X2D63JhJ5yOXxtl
 2ayA==
X-Gm-Message-State: AOJu0YxtuxZHxyM9PXq6QG3aPNvoMW1+Zyfyobj76+E6p+q0O8U6I2yj
 SMKPDVjVBpnNv1s6BhAtlF72pu3c9nOkGgdSRgrmzdaf6ddLuk+AdYY2+vl7FjaSbEbjL0Li/Z2
 qox2c+ePRL7LvUgxuTZ3eOsEl4IAbedQFuFa7ag==
X-Google-Smtp-Source: AGHT+IH86UkkEMzu/uWs0avojco8tFKstH0IkWMw0cZ2R4Dh79LzWg0CTg123lBHsb2100jBrCxNWFkyYfzAG5b3mSc=
X-Received: by 2002:a05:6870:970c:b0:261:65f:ca5e with SMTP id
 586e51a60fabf-26891a41387mr13988122fac.8.1722841424119; Mon, 05 Aug 2024
 00:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <89555383887355d848c1005bfde1641bcddff024.1721821071.git.yong.huang@smartx.com>
 <ZqlGjaleFHdnJUZy@x1n>
In-Reply-To: <ZqlGjaleFHdnJUZy@x1n>
From: Yong Huang <yong.huang@smartx.com>
Date: Mon, 5 Aug 2024 15:03:27 +0800
Message-ID: <CAK9dgmbkKPDTYv0i1jpASgTR5iN+_4+DrZUxo5VxQF3NdZewaQ@mail.gmail.com>
Subject: Re: [PATCH] migration: Refine the convergence detection
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Content-Type: multipart/alternative; boundary="00000000000016e3a9061eea473b"
Received-SPF: none client-ip=2607:f8b0:4864:20::c35;
 envelope-from=yong.huang@smartx.com; helo=mail-oo1-xc35.google.com
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

--00000000000016e3a9061eea473b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the late reply.

On Wed, Jul 31, 2024 at 4:01=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:

> On Wed, Jul 24, 2024 at 07:39:29PM +0800, Hyman Huang wrote:
> > Currently, the convergence algorithm determines that the migration
> > cannot converge according to the following principle:
> > The dirty pages generated in current iteration exceed a specific
> > percentage (throttle-trigger-threshold, 50 by default) of the number
> > of transmissions. Let's refer to this criteria as the
> > "transmission speed," If this criteria is met more than or equal to
> > twice (dirty_rate_high_cnt >=3D 2), the throttle percentage needs to
> > be increased.
> >
> > In most cases, above implementation is appropriate. However, for a
> > VM with a huge memory and high memory overload, each iteration is
>
> When you're talking about huge memory, I do agree the current throttle
> logic doesn't look like to scale, because migration_trigger_throttle() is
> only called for each iteration, so it won't be invoked for a long time if
> one iteration can take a long time.
>
> I wonder whether you considered fixing that for a huge VM case in some wa=
y,
> so that we may need to pay for the sync overhead more, but maybe the
> throttle logic can still get scheduled from time to time.


> E.g., on a 10TB system with even a 100Gbps network, one iteration can tak=
e:
>
>   10TB / ~10GB/s =3D ~1000 seconds =3D ~17min
>
> It means migration_trigger_throttle() will only be invoked once every 17
> mins.


Agree, and another case, VM is at a high dirty rate when migrating,
similarly making the iteration take a long time.


> > time-consuming. The VM's computing performance may be throttled at
> > a high percentage and last for a long time due to the repeated
> > confirmation behavior. Which may be intolerable for some
> > computationally sensitive software in the VM. The refinement is for
> > this scenario.
> >
> > As the comment mentioned in the migration_trigger_throttle function,
> > in order to avoid erroneous detection, the original algorithm confirms
> > the criteria repeatedly. Put differently, once the detection become
> > more reliable, it does not need to be confirmed twice.
> >
> > In the refinement, in order to make the detection more accurate, we
> > introduce another criteria, called the "valid transmission ratio"
> > to determine the migration convergence. The "valid transmission ratio"
> > is the ratio of bytes_xfer_period and bytes_dirty_period, which
> > actually describe the migration efficiency.
> >
> > When the algorithm repeatedly detects that the current iteration
> > "valid transmission ratio" is lower than the previous iteration,
> > the algorithm determines that the migration cannot converge.
> >
> > For the "transmission speed" and "valid transmission ratio", if one
> > of the two criteria is met, the penalty percentage would be increased.
> > This saves the time of the entire iteration and therefore reduces
> > the time of VM performance degradation.
> >
> > In conclusion, this refinement significantly reduces the processing
> > time required for the throttle percentage step to its maximum while
> > the VM is under a high memory load.
> >
> > The following are test environment:
> > ----------------------------------------------------------------------
> > a. Test tool:
> > guestperf
> >
> > Refer to the following link to see details:
> > https://github.com/qemu/qemu/tree/master/tests/migration/guestperf
> >
> > b. Test VM scale:
> > CPU: 10; Memory: 28GB
>
> Isn't 28GB not a huge VM at all?  It'll be nice to know exactly what's th=
e
> problem behind first.  So are we talking about "real huge VM"s (I'd say a=
t
> least a few hundreds GBs), or "28GB VMs" (mostly.. every VM QEMU invokes)=
?
>
> >
> > c. Average bandwidth between source and destination for migration:
> > 1.53 Gbits/sec
> > ----------------------------------------------------------------------
> > All the supplementary test data shown as follows are basing on
> > above test environment.
> >
> > We use stress tool contained in the initrd-stress.img to update
> > ramsize MB on every CPU in guest, refer to the following link to
> > see the source code:
> > https://github.com/qemu/qemu/blob/master/tests/migration/stress.c
> >
> > We run the following command to compare our refined QEMU with the
> > original QEMU:
> >
> > $ ./migration/guestperf.py --cpus 10 --mem 28 --max-iters 40 \
> > --binary $(path_to_qemu-kvm) \
> > --dst-host $(destination_ip) \
> > --transport tcp --kernel $(path_to_vmlinuz) \
> > --initrd $(path_to_initrd-stress.img) \
> > --auto-converge \
> > --auto-converge-step 10 \
> > --max-iters 40
>
> So this is for aut-converge.  How's the dirty limit solution?  I am
>

This patch is a general solution, not just for auto-convergence, here
I missed the dirty limit test case, i'll post the dirty limit test result
in the next version.


> surprised you switched to the old one.  Does it mean that auto-converge i=
s
> better in some cases?
>

Since for non-x86 hardware platforms, auto-converge is still the only
solution
to throttle the guest.  It still reap the benefits from this patch.


>
> >
> > The following data shows the migration test results with an increase in
> > stress, ignoring the title row, the odd rows show the unrefined QEMU
> > test data, and the even rows show the refined QEMU test data:
> >
> > |---------+--------+-----------+--------------+------------+-----------=
-|
> > | ramsize | sucess | totaltime | downtime(ms) | iterations | switchover=
 |
> > | (MB)    |        | (ms)      | (ms)         |            | throttle  =
 |
> > |         |        |           |              |            | percent   =
 |
> > |---------+--------+-----------+--------------+------------+-----------=
-|
> > |     350 |    yes |    170285 |          399 |         23 |         99=
 |
> > |     350 |    yes |     85962 |          412 |         24 |         70=
 |
> > |     350 |    yes |    176305 |          199 |         20 |         99=
 |
> > |     350 |    yes |     66729 |          321 |         11 |         40=
 |
> > |     400 |    yes |    183042 |          469 |         21 |         99=
 |
> > |     400 |    yes |     77225 |          421 |         10 |         30=
 |
> > |     400 |    yes |    183641 |          866 |         27 |         99=
 |
> > |     400 |    yes |     59796 |          479 |         15 |         50=
 |
> > |     450 |    yes |    165881 |          820 |         21 |         99=
 |
> > |     450 |    yes |     87930 |          368 |         20 |         90=
 |
> > |     450 |    yes |    195448 |          452 |         23 |         99=
 |
> > |     450 |    yes |     70394 |          295 |          6 |         20=
 |
> > |     500 |    yes |    112587 |          471 |         19 |         99=
 |
> > |     500 |    yes |     57401 |          299 |          5 |         30=
 |
> > |     500 |    yes |    110683 |          657 |         21 |         99=
 |
> > |     500 |    yes |     69949 |          649 |          8 |         40=
 |
> > |     600 |    yes |    111036 |          324 |         23 |         99=
 |
> > |     600 |    yes |     63455 |          346 |          4 |         20=
 |
> > |     600 |    yes |    126667 |          426 |         20 |         99=
 |
> > |     600 |    yes |    101024 |          643 |         20 |         99=
 |
> > |    1000 |    yes |    296216 |          660 |         23 |         99=
 |
> > |    1000 |    yes |    106915 |          468 |         16 |         99=
 |
> > |    1000 |     no |    300000 |              |            |           =
 |
> > |    1000 |    yes |    125819 |          824 |         17 |         99=
 |
> > |    1200 |     no |    300000 |              |            |           =
 |
> > |    1200 |    yes |    127379 |          664 |         14 |         90=
 |
> > |    1200 |     no |    300000 |              |            |           =
 |
> > |    1200 |    yes |     67086 |          793 |         11 |         50=
 |
> > |---------+--------+-----------+--------------+------------+-----------=
-|
> >
> > To summarize the data above, any data that implies negative optimizatio=
n
> > does not appear, and morover, the throttle algorithm seems to become mo=
re
> > responsive to dirty rate increases due to the refined detection.
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > ---
> >  migration/ram.c        | 48 +++++++++++++++++++++++++++++++++++++++---
> >  migration/trace-events |  1 +
> >  2 files changed, 46 insertions(+), 3 deletions(-)
> >
> > diff --git a/migration/ram.c b/migration/ram.c
> > index edec1a2d07..18b2d422b5 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -414,6 +414,17 @@ struct RAMState {
> >       * RAM migration.
> >       */
> >      unsigned int postcopy_bmap_sync_requested;
> > +
> > +    /*
> > +     * Ratio of bytes_dirty_period and bytes_xfer_period in the last
> > +     * iteration
> > +     */
> > +    uint64_t dirty_ratio_pct;
> > +    /*
> > +     * How many times is the most recent iteration dirty ratio is
> > +     * higher than previous one
> > +     */
> > +    int dirty_ratio_high_cnt;
> >  };
> >  typedef struct RAMState RAMState;
> >
> > @@ -1013,6 +1024,32 @@ static void migration_dirty_limit_guest(void)
> >      trace_migration_dirty_limit_guest(quota_dirtyrate);
> >  }
> >
> > +static bool migration_dirty_ratio_unexpected(RAMState *rs)
> > +{
> > +    uint64_t threshold =3D migrate_throttle_trigger_threshold();
> > +    uint64_t bytes_xfer_period =3D
> > +        migration_transferred_bytes() - rs->bytes_xfer_prev;
> > +    uint64_t bytes_dirty_period =3D rs->num_dirty_pages_period *
> TARGET_PAGE_SIZE;
> > +    uint64_t prev, curr;
> > +
> > +    /* Skip the first iterations since it isn't helpful */
> > +    if (stat64_get(&mig_stats.dirty_sync_count) =3D=3D 1 ||
> !bytes_xfer_period) {
> > +        return false;
> > +    }
> > +
> > +    curr =3D 100 * (bytes_dirty_period * 1.0 / bytes_xfer_period);
> > +
> > +    prev =3D rs->dirty_ratio_pct;
> > +    rs->dirty_ratio_pct =3D curr;
> > +
> > +    if (prev =3D=3D 0 || curr <=3D threshold) {
> > +        return false;
> > +    }
> > +
> > +    trace_dirty_ratio_pct(curr, prev);
> > +    return curr >=3D prev;
> > +}
> > +
> >  static void migration_trigger_throttle(RAMState *rs)
> >  {
> >      uint64_t threshold =3D migrate_throttle_trigger_threshold();
> > @@ -1028,9 +1065,14 @@ static void migration_trigger_throttle(RAMState
> *rs)
> >       * we were in this routine reaches the threshold. If that happens
> >       * twice, start or increase throttling.
> >       */
> > -    if ((bytes_dirty_period > bytes_dirty_threshold) &&
> > -        (++rs->dirty_rate_high_cnt >=3D 2)) {
> > -        rs->dirty_rate_high_cnt =3D 0;
> > +    if ((migration_dirty_ratio_unexpected(rs) &&
> > +         (++rs->dirty_ratio_high_cnt >=3D 2)) ||
> > +        ((bytes_dirty_period > bytes_dirty_threshold) &&
> > +         (++rs->dirty_rate_high_cnt >=3D 2))) {
>
> I'm afraid this is a mess.
>
> Now it's (A||B) and any condition can trigger this throttle logic.  Both =
A
> & B make decisions on merely the same parameters.  It's totally
> unpredictable to me on how these cnts bumps, and not readable.
>

Indeed, this is not readable. How about introducing a migration capability
like "precise-detection" to make this patch backward-compatible?


>
> What I kind of see how this could make migration shorter is that now eith=
er
> A or B can trigger the throttle, so it triggered in a faster pace than
> before.  E.g. IIUC if we drop dirty_rate_high_cnt completely it'll also
> achieve similar thing at least in guestperf tests.
>

Yes !  I get it, and what my original idea is to drop the
dirty_rate_high_cnt.

As we mentioned above: migration needs to pay for the sync overhead more
once a VM is configured with huge memory or running at a high dirty rate.

Dropping the dirty_rate_high_cnt will make the iteration take less time
in above cases.  I think this is feasible since there is no other reasons t=
o
retain the  dirty_rate_high_cnt once we make the detection precise,
let me know if i missed something.


>
> Have you considered what I mentioned above that may make auto converge wo=
rk
> better with "real huge VM"s (by allowing sync >1 times for each iteration=
),
> or have you considered postcopy?
>

Yes, IMHO, this is another refinement direction for the auto-converge, we'l=
l
try this and keep communication with upstream once it gets progress.


>
> Thanks,
>
> > +        rs->dirty_rate_high_cnt =3D
> > +            rs->dirty_rate_high_cnt >=3D 2 ? 0 : rs->dirty_rate_high_c=
nt;
> > +        rs->dirty_ratio_high_cnt =3D
> > +            rs->dirty_ratio_high_cnt >=3D 2 ? 0 :
> rs->dirty_ratio_high_cnt;
> >          if (migrate_auto_converge()) {
> >              trace_migration_throttle();
> >              mig_throttle_guest_down(bytes_dirty_period,
> > diff --git a/migration/trace-events b/migration/trace-events
> > index 0b7c3324fb..654c52c5e4 100644
> > --- a/migration/trace-events
> > +++ b/migration/trace-events
> > @@ -90,6 +90,7 @@ put_qlist_end(const char *field_name, const char
> *vmsd_name) "%s(%s)"
> >  qemu_file_fclose(void) ""
> >
> >  # ram.c
> > +dirty_ratio_pct(uint64_t cur, uint64_t prev) "current ratio: %" PRIu64
> " previous ratio: %" PRIu64
> >  get_queued_page(const char *block_name, uint64_t tmp_offset, unsigned
> long page_abs) "%s/0x%" PRIx64 " page_abs=3D0x%lx"
> >  get_queued_page_not_dirty(const char *block_name, uint64_t tmp_offset,
> unsigned long page_abs) "%s/0x%" PRIx64 " page_abs=3D0x%lx"
> >  migration_bitmap_sync_start(void) ""
> > --
> > 2.39.1
> >
>
> --
> Peter Xu
>
>

--=20
Best regards

--00000000000016e3a9061eea473b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif">Sorry for the late reply.</d=
iv></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_att=
r">On Wed, Jul 31, 2024 at 4:01=E2=80=AFAM Peter Xu &lt;<a href=3D"mailto:p=
eterx@redhat.com">peterx@redhat.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;=
border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex=
">On Wed, Jul 24, 2024 at 07:39:29PM +0800, Hyman Huang wrote:<br>
&gt; Currently, the convergence algorithm determines that the migration<br>
&gt; cannot converge according to the following principle:<br>
&gt; The dirty pages generated in current iteration exceed a specific<br>
&gt; percentage (throttle-trigger-threshold, 50 by default) of the number<b=
r>
&gt; of transmissions. Let&#39;s refer to this criteria as the<br>
&gt; &quot;transmission speed,&quot; If this criteria is met more than or e=
qual to<br>
&gt; twice (dirty_rate_high_cnt &gt;=3D 2), the throttle percentage needs t=
o<br>
&gt; be increased.<br>
&gt; <br>
&gt; In most cases, above implementation is appropriate. However, for a<br>
&gt; VM with a huge memory and high memory overload, each iteration is<br>
<br>
When you&#39;re talking about huge memory, I do agree the current throttle<=
br>
logic doesn&#39;t look like to scale, because migration_trigger_throttle() =
is<br>
only called for each iteration, so it won&#39;t be invoked for a long time =
if<br>
one iteration can take a long time.<br>
<br>
I wonder whether you considered fixing that for a huge VM case in some way,=
<br>
so that we may need to pay for the sync overhead more, but maybe the<br>
throttle logic can still get scheduled from time to time.=C2=A0</blockquote=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);=
padding-left:1ex">
<br>
E.g., on a 10TB system with even a 100Gbps network, one iteration can take:=
<br>
<br>
=C2=A0 10TB / ~10GB/s =3D ~1000 seconds =3D ~17min<br>
<br>
It means migration_trigger_throttle() will only be invoked once every 17<br=
>
mins.=C2=A0</blockquote><div><br></div><div style=3D"font-family:&quot;comi=
c sans ms&quot;,sans-serif" class=3D"gmail_default">Agree, and another case=
, VM is at a high dirty rate when migrating,</div><div style=3D"font-family=
:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">similarly ma=
king the iteration take a long time.</div><div style=3D"font-family:&quot;c=
omic sans ms&quot;,sans-serif" class=3D"gmail_default"><br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width=
:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-lef=
t:1ex">
<br>
&gt; time-consuming. The VM&#39;s computing performance may be throttled at=
<br>
&gt; a high percentage and last for a long time due to the repeated<br>
&gt; confirmation behavior. Which may be intolerable for some<br>
&gt; computationally sensitive software in the VM. The refinement is for<br=
>
&gt; this scenario.<br>
&gt; <br>
&gt; As the comment mentioned in the migration_trigger_throttle function,<b=
r>
&gt; in order to avoid erroneous detection, the original algorithm confirms=
<br>
&gt; the criteria repeatedly. Put differently, once the detection become<br=
>
&gt; more reliable, it does not need to be confirmed twice.<br>
&gt; <br>
&gt; In the refinement, in order to make the detection more accurate, we<br=
>
&gt; introduce another criteria, called the &quot;valid transmission ratio&=
quot;<br>
&gt; to determine the migration convergence. The &quot;valid transmission r=
atio&quot;<br>
&gt; is the ratio of bytes_xfer_period and bytes_dirty_period, which<br>
&gt; actually describe the migration efficiency.<br>
&gt; <br>
&gt; When the algorithm repeatedly detects that the current iteration<br>
&gt; &quot;valid transmission ratio&quot; is lower than the previous iterat=
ion,<br>
&gt; the algorithm determines that the migration cannot converge.<br>
&gt; <br>
&gt; For the &quot;transmission speed&quot; and &quot;valid transmission ra=
tio&quot;, if one<br>
&gt; of the two criteria is met, the penalty percentage would be increased.=
<br>
&gt; This saves the time of the entire iteration and therefore reduces<br>
&gt; the time of VM performance degradation.<br>
&gt; <br>
&gt; In conclusion, this refinement significantly reduces the processing<br=
>
&gt; time required for the throttle percentage step to its maximum while<br=
>
&gt; the VM is under a high memory load.<br>
&gt; <br>
&gt; The following are test environment:<br>
&gt; ----------------------------------------------------------------------=
<br>
&gt; a. Test tool:<br>
&gt; guestperf<br>
&gt; <br>
&gt; Refer to the following link to see details:<br>
&gt; <a href=3D"https://github.com/qemu/qemu/tree/master/tests/migration/gu=
estperf" rel=3D"noreferrer" target=3D"_blank">https://github.com/qemu/qemu/=
tree/master/tests/migration/guestperf</a><br>
&gt; <br>
&gt; b. Test VM scale:<br>
&gt; CPU: 10; Memory: 28GB<br>
<br>
Isn&#39;t 28GB not a huge VM at all?=C2=A0 It&#39;ll be nice to know exactl=
y what&#39;s the<br>
problem behind first.=C2=A0 So are we talking about &quot;real huge VM&quot=
;s (I&#39;d say at<br>
least a few hundreds GBs), or &quot;28GB VMs&quot; (mostly.. every VM QEMU =
invokes)?<br>
<br>
&gt; <br>
&gt; c. Average bandwidth between source and destination for migration:<br>
&gt; 1.53 Gbits/sec<br>
&gt; ----------------------------------------------------------------------=
<br>
&gt; All the supplementary test data shown as follows are basing on<br>
&gt; above test environment.<br>
&gt; <br>
&gt; We use stress tool contained in the initrd-stress.img to update<br>
&gt; ramsize MB on every CPU in guest, refer to the following link to<br>
&gt; see the source code:<br>
&gt; <a href=3D"https://github.com/qemu/qemu/blob/master/tests/migration/st=
ress.c" rel=3D"noreferrer" target=3D"_blank">https://github.com/qemu/qemu/b=
lob/master/tests/migration/stress.c</a><br>
&gt; <br>
&gt; We run the following command to compare our refined QEMU with the<br>
&gt; original QEMU:<br>
&gt; <br>
&gt; $ ./migration/guestperf.py --cpus 10 --mem 28 --max-iters 40 \<br>
&gt; --binary $(path_to_qemu-kvm) \<br>
&gt; --dst-host $(destination_ip) \<br>
&gt; --transport tcp --kernel $(path_to_vmlinuz) \<br>
&gt; --initrd $(path_to_initrd-stress.img) \<br>
&gt; --auto-converge \<br>
&gt; --auto-converge-step 10 \<br>
&gt; --max-iters 40<br>
<br>
So this is for aut-converge.=C2=A0 How&#39;s the dirty limit solution?=C2=
=A0 I am<br></blockquote><div><br></div><div><div style=3D"font-family:&quo=
t;comic sans ms&quot;,sans-serif" class=3D"gmail_default">This patch is a g=
eneral solution, not just for auto-convergence, here</div><div style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">I mi=
ssed the dirty limit test case, i&#39;ll post the dirty limit test result</=
div></div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" c=
lass=3D"gmail_default">in the next version.</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-widt=
h:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-le=
ft:1ex">
surprised you switched to the old one.=C2=A0 Does it mean that auto-converg=
e is<br>
better in some cases?<br></blockquote><div><br></div><div><div style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">Sinc=
e for non-x86 hardware platforms, auto-converge is still the only solution<=
/div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=
=3D"gmail_default">to throttle the guest.=C2=A0 It still reap the benefits =
from this patch.</div></div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-sty=
le:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; The following data shows the migration test results with an increase i=
n<br>
&gt; stress, ignoring the title row, the odd rows show the unrefined QEMU<b=
r>
&gt; test data, and the even rows show the refined QEMU test data:<br>
&gt; <br>
&gt; |---------+--------+-----------+--------------+------------+----------=
--|<br>
&gt; | ramsize | sucess | totaltime | downtime(ms) | iterations | switchove=
r |<br>
&gt; | (MB)=C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 | (ms)=C2=A0 =C2=A0 =
=C2=A0 | (ms)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | throttle=C2=A0 =C2=A0|<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | percent=C2=A0 =
=C2=A0 |<br>
&gt; |---------+--------+-----------+--------------+------------+----------=
--|<br>
&gt; |=C2=A0 =C2=A0 =C2=A0350 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 170285 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 399 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A023 |=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A099 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0350 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 =C2=A085962=
 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 412 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A024 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A070 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0350 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 176305 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 199 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A020 |=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A099 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0350 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 =C2=A066729=
 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 321 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A011 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A040 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0400 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 183042 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 469 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A021 |=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A099 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0400 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 =C2=A077225=
 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 421 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A010 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A030 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0400 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 183641 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 866 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A027 |=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A099 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0400 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 =C2=A059796=
 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 479 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A015 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A050 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0450 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 165881 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 820 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A021 |=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A099 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0450 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 =C2=A087930=
 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 368 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A020 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A090 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0450 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 195448 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 452 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A023 |=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A099 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0450 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 =C2=A070394=
 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 295 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 6 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A020 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0500 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 112587 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 471 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A019 |=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A099 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0500 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 =C2=A057401=
 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 299 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 5 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A030 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0500 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 110683 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 657 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A021 |=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A099 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0500 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 =C2=A069949=
 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 649 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 8 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A040 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0600 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 111036 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 324 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A023 |=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A099 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0600 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 =C2=A063455=
 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 346 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 4 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A020 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0600 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 126667 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 426 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A020 |=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A099 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0600 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 101024 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 643 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A020 |=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A099 |<br>
&gt; |=C2=A0 =C2=A0 1000 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 296216 |=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 660 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A023 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A099 |<br>
&gt; |=C2=A0 =C2=A0 1000 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 106915 |=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 468 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A016 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A099 |<br>
&gt; |=C2=A0 =C2=A0 1000 |=C2=A0 =C2=A0 =C2=A0no |=C2=A0 =C2=A0 300000 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
&gt; |=C2=A0 =C2=A0 1000 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 125819 |=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 824 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A017 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A099 |<br>
&gt; |=C2=A0 =C2=A0 1200 |=C2=A0 =C2=A0 =C2=A0no |=C2=A0 =C2=A0 300000 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
&gt; |=C2=A0 =C2=A0 1200 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 127379 |=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 664 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A014 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A090 |<br>
&gt; |=C2=A0 =C2=A0 1200 |=C2=A0 =C2=A0 =C2=A0no |=C2=A0 =C2=A0 300000 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
&gt; |=C2=A0 =C2=A0 1200 |=C2=A0 =C2=A0 yes |=C2=A0 =C2=A0 =C2=A067086 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 793 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A011 |=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A050 |<br>
&gt; |---------+--------+-----------+--------------+------------+----------=
--|<br>
&gt; <br>
&gt; To summarize the data above, any data that implies negative optimizati=
on<br>
&gt; does not appear, and morover, the throttle algorithm seems to become m=
ore<br>
&gt; responsive to dirty rate increases due to the refined detection.<br>
&gt; <br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 migration/ram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 48 ++++++++++++++++=
+++++++++++++++++++++++---<br>
&gt;=C2=A0 migration/trace-events |=C2=A0 1 +<br>
&gt;=C2=A0 2 files changed, 46 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/migration/ram.c b/migration/ram.c<br>
&gt; index edec1a2d07..18b2d422b5 100644<br>
&gt; --- a/migration/ram.c<br>
&gt; +++ b/migration/ram.c<br>
&gt; @@ -414,6 +414,17 @@ struct RAMState {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* RAM migration.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 unsigned int postcopy_bmap_sync_requested;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Ratio of bytes_dirty_period and bytes_xfer_peri=
od in the last<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* iteration<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 uint64_t dirty_ratio_pct;<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* How many times is the most recent iteration dir=
ty ratio is<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* higher than previous one<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 int dirty_ratio_high_cnt;<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 typedef struct RAMState RAMState;<br>
&gt;=C2=A0 <br>
&gt; @@ -1013,6 +1024,32 @@ static void migration_dirty_limit_guest(void)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 trace_migration_dirty_limit_guest(quota_dirtyrate)=
;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static bool migration_dirty_ratio_unexpected(RAMState *rs)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint64_t threshold =3D migrate_throttle_trigger_thresho=
ld();<br>
&gt; +=C2=A0 =C2=A0 uint64_t bytes_xfer_period =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 migration_transferred_bytes() - rs-&gt;by=
tes_xfer_prev;<br>
&gt; +=C2=A0 =C2=A0 uint64_t bytes_dirty_period =3D rs-&gt;num_dirty_pages_=
period * TARGET_PAGE_SIZE;<br>
&gt; +=C2=A0 =C2=A0 uint64_t prev, curr;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Skip the first iterations since it isn&#39;t helpful=
 */<br>
&gt; +=C2=A0 =C2=A0 if (stat64_get(&amp;mig_stats.dirty_sync_count) =3D=3D =
1 || !bytes_xfer_period) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 curr =3D 100 * (bytes_dirty_period * 1.0 / bytes_xfer_p=
eriod);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 prev =3D rs-&gt;dirty_ratio_pct;<br>
&gt; +=C2=A0 =C2=A0 rs-&gt;dirty_ratio_pct =3D curr;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (prev =3D=3D 0 || curr &lt;=3D threshold) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_dirty_ratio_pct(curr, prev);<br>
&gt; +=C2=A0 =C2=A0 return curr &gt;=3D prev;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static void migration_trigger_throttle(RAMState *rs)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint64_t threshold =3D migrate_throttle_trigger_th=
reshold();<br>
&gt; @@ -1028,9 +1065,14 @@ static void migration_trigger_throttle(RAMState=
 *rs)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* we were in this routine reaches the thresh=
old. If that happens<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* twice, start or increase throttling.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; -=C2=A0 =C2=A0 if ((bytes_dirty_period &gt; bytes_dirty_threshold) &am=
p;&amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 (++rs-&gt;dirty_rate_high_cnt &gt;=3D 2))=
 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 rs-&gt;dirty_rate_high_cnt =3D 0;<br>
&gt; +=C2=A0 =C2=A0 if ((migration_dirty_ratio_unexpected(rs) &amp;&amp;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(++rs-&gt;dirty_ratio_high_cnt &gt;=
=3D 2)) ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ((bytes_dirty_period &gt; bytes_dirty_thr=
eshold) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(++rs-&gt;dirty_rate_high_cnt &gt;=
=3D 2))) {<br>
<br>
I&#39;m afraid this is a mess.<br>
<br>
Now it&#39;s (A||B) and any condition can trigger this throttle logic.=C2=
=A0 Both A<br>
&amp; B make decisions on merely the same parameters.=C2=A0 It&#39;s totall=
y<br>
unpredictable to me on how these cnts bumps, and not readable.<br></blockqu=
ote><div><br></div><div><div style=3D"font-family:&quot;comic sans ms&quot;=
,sans-serif" class=3D"gmail_default">Indeed, this is not readable. How abou=
t introducing a migration capability</div></div><div style=3D"font-family:&=
quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">like &quot;pre=
cise-detection&quot; to make this patch backward-compatible?</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left-width:1px;border-left-style:solid;border-left-color:rgb(204,2=
04,204);padding-left:1ex">
<br>
What I kind of see how this could make migration shorter is that now either=
<br>
A or B can trigger the throttle, so it triggered in a faster pace than<br>
before.=C2=A0 E.g. IIUC if we drop dirty_rate_high_cnt completely it&#39;ll=
 also<br>
achieve similar thing at least in guestperf tests.<br></blockquote><div><br=
></div><div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"=
 class=3D"gmail_default">Yes !=C2=A0 I get it, and what my original idea is=
 to drop the dirty_rate_high_cnt.</div><div class=3D"gmail_default"><span s=
tyle=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><br></span></div>=
<div class=3D"gmail_default"><span style=3D"font-family:&quot;comic sans ms=
&quot;,sans-serif">As we mentioned=C2=A0above: migration needs t</span><fon=
t face=3D"comic sans ms, sans-serif">o=C2=A0pay for the sync overhead more<=
/font></div><div class=3D"gmail_default"><font face=3D"comic sans ms, sans-=
serif">once a VM is configured with huge memory or running at a high dirty =
rate.</font></div></div><div><span class=3D"gmail_default"><br></span></div=
><div><font face=3D"comic sans ms, sans-serif"><span class=3D"gmail_default=
">Dr</span><span class=3D"gmail_default">opp</span></font><span class=3D"gm=
ail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">ing=
 the=C2=A0</span><span style=3D"font-family:&quot;comic sans ms&quot;,sans-=
serif">dirty_rate_high_cnt<span class=3D"gmail_default" style=3D"font-famil=
y:&quot;comic sans ms&quot;,sans-serif"> will make the iteration take less =
time</span></span></div><div><span style=3D"font-family:&quot;comic sans ms=
&quot;,sans-serif"><span class=3D"gmail_default" style=3D"font-family:&quot=
;comic sans ms&quot;,sans-serif">in above cases.=C2=A0 I think this is feas=
ible since there is no other reasons to</span></span></div><div><span style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><span class=3D"gmail_=
default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">retain =
the =C2=A0</span></span><span style=3D"font-family:&quot;comic sans ms&quot=
;,sans-serif">dirty_rate_high_cnt<span class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"> once we make the detection =
precise,=C2=A0</span></span></div><div><span style=3D"font-family:&quot;com=
ic sans ms&quot;,sans-serif"><span class=3D"gmail_default" style=3D"font-fa=
mily:&quot;comic sans ms&quot;,sans-serif">let me know if i missed somethin=
g.</span></span></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:sol=
id;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
Have you considered what I mentioned above that may make auto converge work=
<br>
better with &quot;real huge VM&quot;s (by allowing sync &gt;1 times for eac=
h iteration),<br>
or have you considered postcopy?<br></blockquote><div><br></div><div><div s=
tyle=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_de=
fault">Yes, IMHO, this is another refinement direction for the auto-converg=
e, we&#39;ll</div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-=
serif" class=3D"gmail_default">try this and keep communication with upstrea=
m once it gets progress.</div></div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-=
left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
Thanks,<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rs-&gt;dirty_rate_high_cnt =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rs-&gt;dirty_rate_high_cnt =
&gt;=3D 2 ? 0 : rs-&gt;dirty_rate_high_cnt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rs-&gt;dirty_ratio_high_cnt =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rs-&gt;dirty_ratio_high_cnt=
 &gt;=3D 2 ? 0 : rs-&gt;dirty_ratio_high_cnt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (migrate_auto_converge()) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_migration_thrott=
le();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mig_throttle_guest_dow=
n(bytes_dirty_period,<br>
&gt; diff --git a/migration/trace-events b/migration/trace-events<br>
&gt; index 0b7c3324fb..654c52c5e4 100644<br>
&gt; --- a/migration/trace-events<br>
&gt; +++ b/migration/trace-events<br>
&gt; @@ -90,6 +90,7 @@ put_qlist_end(const char *field_name, const char *vm=
sd_name) &quot;%s(%s)&quot;<br>
&gt;=C2=A0 qemu_file_fclose(void) &quot;&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # ram.c<br>
&gt; +dirty_ratio_pct(uint64_t cur, uint64_t prev) &quot;current ratio: %&q=
uot; PRIu64 &quot; previous ratio: %&quot; PRIu64<br>
&gt;=C2=A0 get_queued_page(const char *block_name, uint64_t tmp_offset, uns=
igned long page_abs) &quot;%s/0x%&quot; PRIx64 &quot; page_abs=3D0x%lx&quot=
;<br>
&gt;=C2=A0 get_queued_page_not_dirty(const char *block_name, uint64_t tmp_o=
ffset, unsigned long page_abs) &quot;%s/0x%&quot; PRIx64 &quot; page_abs=3D=
0x%lx&quot;<br>
&gt;=C2=A0 migration_bitmap_sync_start(void) &quot;&quot;<br>
&gt; -- <br>
&gt; 2.39.1<br>
&gt; <br>
<br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--00000000000016e3a9061eea473b--

