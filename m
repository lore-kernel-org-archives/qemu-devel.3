Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D68C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28MN-0005Vg-Pt; Thu, 03 Sep 2026 10:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x28ML-0005V1-RW
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:24:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x28MI-0006xr-Qh
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788445446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RxYdUQrBSqehc6eGs6lFDTKh91mMQZhWs5pBuysicBw=;
 b=TILaJ2lsWSL3xq1B+fLM6nABcOU0V/pE3v2xg0NDgdUvTfJHvYHrMGfUwrM8mXtQ0HJ8gM
 b+dzmIrWvqMgBY12V4n0HLlW4+tcW2pLE0ffIgPGseVhMF92848es6sJ/IfEOSS8RoZ3uk
 C+MHvzKuRtIBzHvWUTwOFXRkBNU+nPQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-SgipflnGPza2y4xuhC8ZXg-1; Thu,
 03 Sep 2026 10:24:02 -0400
X-MC-Unique: SgipflnGPza2y4xuhC8ZXg-1
X-Mimecast-MFC-AGG-ID: SgipflnGPza2y4xuhC8ZXg_1788445441
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 786661944A88; Thu,  3 Sep 2026 14:24:01 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B74E47DA; Thu,  3 Sep 2026 14:24:00 +0000 (UTC)
Date: Thu, 3 Sep 2026 10:23:59 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 6/9] block/accounting: Emit BLOCK_IO_DELAY event
Message-ID: <20260903142359.GD825275@fedora>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260831135206.126184-7-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vASYC52uuNyaIHRL"
Content-Disposition: inline
In-Reply-To: <20260831135206.126184-7-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--vASYC52uuNyaIHRL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 03:52:02PM +0200, Hanna Czenczek wrote:
> When a request finishes with a higher latency than a predefined
> threshold, emit the BLOCK_IO_DELAY event.
>=20
> Note there would be an alternative, more precise solution: We could keep
> all active cookies per BlockBackend in a list and repeatedly iterate
> over it in a background coroutine (woken on a timer so it would wake
> always exactly when the next request would time out, so it generally
> stays asleep until there is actually a timeout). This way, we could emit
> the event exactly when a request crosses the delay threshold, while it
> is still running; and we could hypothetically even take actions like
> pausing the VM until the request is done so the guest operating system
> is shielded from extreme latency spikes.
>=20
> In practice, this is very complicated because latency cookies are
> created and finalized all over the place, so it is very hard to
> guarantee that every `block_acct_start()` is matched by the right
> finalization to ensure that cookies are properly removed from the list
> when they are done. Even if we fix all non-matching places now, there is
> hardly a guarantee this will be kept in order in the future.

I think this patch series already couples the accounting so closely with
BlockBackend (i.e. adding the offset field into the cookie struct and
adding a BB pointer into the stats struct) that we might as well fully
integrate the two. Then callers don't need to manually manage cookies
because BlockBackend does that internally and the concerns about
lifetimes go away.

>=20
> So, for now, just implement the simpler solution of only notifying the
> management layer when the request does complete, so VMs with high
> latency spikes can at least be identified when they happen without
> having to regularly check the latency histogram.
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  include/block/accounting.h | 10 ++++++++-
>  block/accounting.c         | 42 +++++++++++++++++++++++++++++++++++++-
>  blockdev.c                 |  2 +-
>  hw/block/block.c           |  2 +-
>  4 files changed, 52 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/block/accounting.h b/include/block/accounting.h
> index 025536239e6..ba3a6859cf4 100644
> --- a/include/block/accounting.h
> +++ b/include/block/accounting.h
> @@ -92,6 +92,7 @@ struct BlockAcctStats {
>      QSLIST_HEAD(, BlockAcctTimedStats) intervals;
>      bool account_invalid;
>      bool account_failed;
> +    int64_t delay_threshold_ns;
>      BlockLatencyHistogram latency_histogram[BLOCK_MAX_IOTYPE];
>  };
> =20
> @@ -103,9 +104,16 @@ typedef struct BlockAcctCookie {
>  } BlockAcctCookie;
> =20
>  void block_acct_init(BlockBackend *blk, BlockAcctStats *stats);
> +/**
> + * Set up accounting for a block device in @stats.
> + * @alert_ns specifies a latency so that if any request takes longer tha=
n that
> + * threshold, a BLOCK_IO_DELAY event will be generated (when that request
> + * completes). Pass 0 to disable.
> + */
>  bool block_acct_setup(BlockAcctStats *stats, enum OnOffAuto account_inva=
lid,
>                        enum OnOffAuto account_failed, uint32_t *stats_int=
ervals,
> -                      uint32_t num_stats_intervals, Error **errp);
> +                      uint32_t num_stats_intervals, int64_t alert_ns,

There are a few names for the same thing:
- delay_threshold_ns
- alert_ns
- BLOCK_IO_DELAY

Pick one and use it consistently?

> +                      Error **errp);
>  void block_acct_cleanup(BlockAcctStats *stats);
>  void block_acct_add_interval(BlockAcctStats *stats, unsigned interval_le=
ngth);
>  BlockAcctTimedStats *block_acct_interval_next(BlockAcctStats *stats,
> diff --git a/block/accounting.c b/block/accounting.c
> index a74551d41f2..debf1924455 100644
> --- a/block/accounting.c
> +++ b/block/accounting.c
> @@ -27,8 +27,10 @@
>  #include "block/accounting.h"
>  #include "block/block_int.h"
>  #include "qemu/timer.h"
> +#include "system/block-backend.h"
>  #include "system/qtest.h"
>  #include "qapi/error.h"
> +#include "qapi/qapi-events-block.h"
> =20
>  static QEMUClockType clock_type =3D QEMU_CLOCK_REALTIME;
>  static const int qtest_latency_ns =3D NANOSECONDS_PER_SECOND / 1000;
> @@ -62,9 +64,35 @@ static bool bool_from_onoffauto(OnOffAuto val, bool de=
f)
>      }
>  }
> =20
> +/**
> + * Convert a BlockAcctType into its QAPI equivalent IoAccountingOperatio=
n.
> + *
> + * Must only be called for valid BlockAcctType values, i.e. specifically=
 not for
> + * `BLOCK_ACCT_NONE`.
> + */
> +static IoAccountingOperation block_acct_qapi_type(enum BlockAcctType typ=
e)
> +{
> +    switch (type) {
> +    case BLOCK_ACCT_READ:
> +        return IO_ACCOUNTING_OPERATION_READ;
> +    case BLOCK_ACCT_WRITE:
> +        return IO_ACCOUNTING_OPERATION_WRITE;
> +    case BLOCK_ACCT_FLUSH:
> +        return IO_ACCOUNTING_OPERATION_FLUSH;
> +    case BLOCK_ACCT_ZONE_APPEND:
> +        return IO_ACCOUNTING_OPERATION_ZONE_APPEND;
> +    case BLOCK_ACCT_UNMAP:
> +        return IO_ACCOUNTING_OPERATION_UNMAP;
> +    case BLOCK_ACCT_NONE:
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
>  bool block_acct_setup(BlockAcctStats *stats, enum OnOffAuto account_inva=
lid,
>                        enum OnOffAuto account_failed, uint32_t *stats_int=
ervals,
> -                      uint32_t num_stats_intervals, Error **errp)
> +                      uint32_t num_stats_intervals, int64_t alert_ns,
> +                      Error **errp)
>  {
>      stats->account_invalid =3D bool_from_onoffauto(account_invalid,
>                                                   stats->account_invalid);
> @@ -79,6 +107,7 @@ bool block_acct_setup(BlockAcctStats *stats, enum OnOf=
fAuto account_invalid,
>              block_acct_add_interval(stats, stats_intervals[i]);
>          }
>      }
> +    stats->delay_threshold_ns =3D alert_ns;
>      return true;
>  }
> =20
> @@ -252,6 +281,17 @@ static void block_account_one_io(BlockAcctStats *sta=
ts, BlockAcctCookie *cookie,
>          return;
>      }
> =20
> +    if (stats->delay_threshold_ns && latency_ns > stats->delay_threshold=
_ns) {
> +        g_autofree char *dev_path =3D blk_get_attached_dev_path(stats->b=
lk);
> +        double latency =3D latency_ns / (double)NANOSECONDS_PER_SECOND;
> +
> +        qapi_event_send_block_io_delay(dev_path,
> +                                       block_acct_qapi_type(cookie->type=
),
> +                                       latency,
> +                                       cookie->offset >=3D 0, cookie->of=
fset,
> +                                       cookie->bytes);
> +    }
> +
>      WITH_QEMU_LOCK_GUARD(&stats->lock) {
>          if (failed) {
>              stats->failed_ops[cookie->type]++;
> diff --git a/blockdev.c b/blockdev.c
> index 6e86c6262f9..195bac8af01 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -618,7 +618,7 @@ static BlockBackend *blockdev_init(const char *file, =
QDict *bs_opts,
>          bs->detect_zeroes =3D detect_zeroes;
> =20
>          block_acct_setup(blk_get_stats(blk), account_invalid, account_fa=
iled,
> -                         NULL, 0, NULL);
> +                         NULL, 0, 0, NULL);
> =20
>          if (!parse_stats_intervals(blk_get_stats(blk), interval_list, er=
rp)) {
>              blk_unref(blk);
> diff --git a/hw/block/block.c b/hw/block/block.c
> index f187fa025d0..19301c6f995 100644
> --- a/hw/block/block.c
> +++ b/hw/block/block.c
> @@ -251,7 +251,7 @@ bool blkconf_apply_backend_options(BlockConf *conf, b=
ool readonly,
> =20
>      if (!block_acct_setup(blk_get_stats(blk), conf->account_invalid,
>                            conf->account_failed, conf->stats_intervals,
> -                          conf->num_stats_intervals, errp)) {
> +                          conf->num_stats_intervals, 0, errp)) {
>          return false;
>      }
>      return true;
> --=20
> 2.55.0
>=20

--vASYC52uuNyaIHRL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqZgv8ACgkQnKSrs4Gr
c8jbGQf+ODZb72rXY571xw88Vmqft34W7YA0FZWAptcMWFg0xfcd0Y0Wz2g27o9i
1SHo+PbXks9uHBG+4sawXZAwSJY17huKQ3z90W9c7nhJ5xbfAalXGd0+paTIBqFO
EmxYoHrrEU+wRFDdItuAsqPgJjL97ZzZngePYWbu2/aB8biqrsRk5JoUnGqLNKbs
zIhy7PR7uz1wnWZdXsBwR5lM4mpYLHlA6xBjzFUu6ABK6UINhwfrUk6N68IgtRh+
IbJjHBf/oAjupJOsAkNctVF4MXuReucX07SlFTju+u4Hwviq8jgXhatOMCLfJs11
i5JWzkpanClxCZ4vOEN8hT7PBruSyw==
=3c0B
-----END PGP SIGNATURE-----

--vASYC52uuNyaIHRL--


