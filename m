Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0471CCD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 20:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPQuz-0005Uo-3F; Tue, 19 May 2026 16:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wPQuw-0005Tk-Nh
 for qemu-devel@nongnu.org; Tue, 19 May 2026 16:19:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wPQut-0004lp-JW
 for qemu-devel@nongnu.org; Tue, 19 May 2026 16:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779221990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=30p8igqGmf+oJukoBzNA4qvEt7GtCTMH3ZBSwrYiNzI=;
 b=VUEGuSrklifjKb+iZhmOFJtCyPnj2BeZY2tTE7aNW9F5HEb61lE9kEE/k8B7JrdcYj73K3
 QLCqS4wmhRH+9SrxZXcugYaSQpZ+sLBpy7EFhM5luOo5MArDSTc86MEAOSv0RPbno2dGqF
 QgqsQA5Dpv0nhWEuI3quNFtIsbsdZTE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-sjd1g0AcMICL-lch6kcrHw-1; Tue,
 19 May 2026 16:19:46 -0400
X-MC-Unique: sjd1g0AcMICL-lch6kcrHw-1
X-Mimecast-MFC-AGG-ID: sjd1g0AcMICL-lch6kcrHw_1779221985
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E748195605C; Tue, 19 May 2026 20:19:45 +0000 (UTC)
Received: from localhost (unknown [10.2.16.118])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3736D1800347; Tue, 19 May 2026 20:19:44 +0000 (UTC)
Date: Tue, 19 May 2026 16:19:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/1] block/linux-aio: bound ioq_submit() recursion depth
Message-ID: <20260519201942.GA335826@fedora>
References: <20260428105811.1325119-2-den@openvz.org>
 <9fc3e8ab-c2a3-4573-9fb4-764d8321bae5@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+97dwblFgN4DM/PV"
Content-Disposition: inline
In-Reply-To: <9fc3e8ab-c2a3-4573-9fb4-764d8321bae5@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--+97dwblFgN4DM/PV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 07:13:56PM +0200, Denis V. Lunev wrote:
> On 4/28/26 12:58, Denis V. Lunev wrote:
> > qemu_laio_process_completions() wraps its body in defer_call_begin /
> > defer_call_end. Inside the section, completion callbacks wake coroutines
> > that queue new aiocbs; laio_do_submit() defers laio_deferred_fn. At the
> > bottom of qemu_laio_process_completions() the defer_call_end() fires
> > laio_deferred_fn, which calls ioq_submit(), closing the cycle:
> >
> >   ioq_submit
> >     -> io_submit(2)                           // some sync completions
> >     -> qemu_laio_process_completions          // defer_call_begin
> >          -> aio_co_wake                       // resumes coroutine
> >               -> laio_do_submit
> >                    -> defer_call(laio_deferred_fn, s)   // enqueued
> >          -> defer_call_end                    // nesting drops to 0
> >               -> laio_deferred_fn
> >                    -> ioq_submit              // +1 stack frame, loop
> >
> > When io_submit(2) returns asynchronously (O_DIRECT) the cycle
> > terminates in one extra frame: the fresh aiocb is still in flight, no
> > completion is drained, no coroutine wakes, no new submission queues.
> > When submissions complete synchronously (non-O_DIRECT, or per-descriptor
> > drivers such as vmdk) each level enqueues more work for the next
> > defer_call_end() to drain, so recursion grows without bound and QEMU
> > crashes with SIGSEGV on the thread guard page.
> >
> > The cycle was closed by two performance commits, each correct in
> > isolation:
> >
> >   076682885d ("block/linux-aio: convert to blk_io_plug_call() API")
> >     -- introduced laio_deferred_fn and wired
> >        laio_do_submit -> defer_call(laio_deferred_fn, s).
> >
> >   84d61e5f36 ("virtio: use defer_call() in virtio_irqfd_notify()")
> >     -- added defer_call_begin/end around qemu_laio_process_completions
> >        so virtio-irqfd notifications batch across a completion pass.
> >
> > The supported aio=3Dnative + cache=3Dnone pairing keeps submissions
> > asynchronous, so the cycle stays bounded; nothing in the code enforces
> > that contract. Observed in production as a SIGSEGV during a backup job
> > configured with --cached + aio=3Dnative; reproducible on upstream with
> > qemu-io against vmdk.
> >
> > Cap ioq_submit() recursion with a per-thread counter. On overflow,
> > return without submitting. The pending work is drained by
> > s->completion_bh, which qemu_laio_process_completions() has already
> > scheduled on entry -- no work is lost; one event-loop round-trip of
> > latency is paid only when the bound is hit, which cannot happen on a
> > supported configuration.
> >
> > Signed-off-by: Denis V. Lunev <den@openvz.org>
> > CC: Kevin Wolf <kwolf@redhat.com>
> > CC: Hanna Reitz <hreitz@redhat.com>
> > CC: Stefan Hajnoczi <stefanha@redhat.com>
> > CC: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  block/linux-aio.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/block/linux-aio.c b/block/linux-aio.c
> > index 0a7424fbb3..f98bb6e766 100644
> > --- a/block/linux-aio.c
> > +++ b/block/linux-aio.c
> > @@ -36,6 +36,19 @@
> >  /* Maximum number of requests in a batch. (default value) */
> >  #define DEFAULT_MAX_BATCH 32
> > =20
> > +/*
> > + * Bound on how deep ioq_submit() may recurse on a single thread via t=
he
> > + * ioq_submit -> qemu_laio_process_completions -> defer_call_end ->
> > + * laio_deferred_fn -> ioq_submit cycle. The cycle terminates naturally
> > + * when io_submit(2) returns asynchronously (O_DIRECT), but can grow
> > + * without bound when submissions complete synchronously. On overflow
> > + * the caller returns without submitting; the outermost
> > + * qemu_laio_process_completions() has already scheduled s->completion=
_bh
> > + * (via qemu_bh_schedule() at the top of that function), which resumes
> > + * submission from the next event-loop dispatch.
> > + */
> > +#define IOQ_SUBMIT_MAX_DEPTH 8
> > +
> >  struct qemu_laiocb {
> >      Coroutine *co;
> >      LinuxAioState *ctx;
> > @@ -80,6 +93,9 @@ struct LinuxAioState {
> >  static void ioq_submit(LinuxAioState *s);
> >  static int laio_do_submit(struct qemu_laiocb *laiocb);
> > =20
> > +/* Per-thread recursion counter for ioq_submit(). See IOQ_SUBMIT_MAX_D=
EPTH. */
> > +static __thread unsigned ioq_submit_depth;
> > +
> >  static inline ssize_t io_event_ret(struct io_event *ev)
> >  {
> >      return (ssize_t)(((uint64_t)ev->res2 << 32) | ev->res);
> > @@ -340,6 +356,11 @@ static void ioq_submit(LinuxAioState *s)
> >      QEMU_UNINITIALIZED struct iocb *iocbs[MAX_EVENTS];
> >      QSIMPLEQ_HEAD(, qemu_laiocb) completed;
> > =20
> > +    if (ioq_submit_depth >=3D IOQ_SUBMIT_MAX_DEPTH) {
> > +        return;
> > +    }
> > +    ioq_submit_depth++;
> > +
> >      do {
> >          if (s->io_q.in_flight >=3D MAX_EVENTS) {
> >              break;
> > @@ -385,6 +406,8 @@ static void ioq_submit(LinuxAioState *s)
> >           * pended requests will be submitted from there.
> >           */
> >      }
> > +
> > +    ioq_submit_depth--;
> >  }
> > =20
> >  static uint64_t laio_max_batch(LinuxAioState *s, uint64_t dev_max_batc=
h)
> ping

Sorry, I missed this.

Please add a field to LaioQueue instead of adding a __thread variable.
LaioQueue is only accessed from a single thread and that's where the
state lives.

Stefan


--+97dwblFgN4DM/PV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoMxd4ACgkQnKSrs4Gr
c8hPSAf+JdON4zx+s1ptAUW0CiQaHfhOYvd+5uX/8QF8qR14P5PiBzERJquNBzal
D6ll0dp8djfXF+qRciMtAOs8cwuCN8TjuR/QExxLKful3sotWiPN0r6B/DcbRCgA
DfjS+U+0h2STUL5YuWvj2ci7SkVFupsFqqt9F0/HZiLqWy8N1TWEwh49UEkEsfUd
xYCYwmAAHFM+LJNKUch7IYkVLW6dpogD+JwLJIevXkpIkHlS5d+LoOoSsG4dNXxp
PJHWkkeNg4AgxUyClbzlbDIR4m3zcCEORzRznRi2G2niRg2909tXMwst087ylupF
P0+nn4BGEVq+JObr3PPbUlmvFhEHDA==
=+OwC
-----END PGP SIGNATURE-----

--+97dwblFgN4DM/PV--


