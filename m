Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645D4C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 17:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weFyF-0008Fz-Oq; Mon, 29 Jun 2026 13:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1weFy5-00089u-Md
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 13:40:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1weFy0-0007V1-1a
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 13:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782754815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uTSB3Y1qgq1I7EI34Lf9zjPPV+EonrdR8c1o0IONw68=;
 b=eg8Ra8/EC92Q9clHEiTS+HLQXqYORayGKU2fFZBPS/Cidp0bd+1qaMTA9Eevico2eusILw
 SD+qUK4w429uXBkm5T4ChAKh81uxB+6j5QABNFAoDB2D9lNbo+hBKaW/XnqVHF05EfGTY4
 RT0aVqLQ3W44CV5cFJTxxp/hwURNf8w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-I-jDkCxWOuqUxcHRIzRJAA-1; Mon,
 29 Jun 2026 13:40:10 -0400
X-MC-Unique: I-jDkCxWOuqUxcHRIzRJAA-1
X-Mimecast-MFC-AGG-ID: I-jDkCxWOuqUxcHRIzRJAA_1782754809
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15E981955F14; Mon, 29 Jun 2026 17:40:09 +0000 (UTC)
Received: from localhost (unknown [10.2.16.195])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 09C3D19560A6; Mon, 29 Jun 2026 17:40:07 +0000 (UTC)
Date: Mon, 29 Jun 2026 19:40:06 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 cassel@kernel.org, dlemoal@kernel.org, qemu-block@nongnu.org,
 dmitry.fomichev@wdc.com, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v12 4/5] qcow2: add zoned emulation capability
Message-ID: <20260629174006.GA376767@fedora>
References: <20260623184830.373232-1-faithilikerun@gmail.com>
 <20260623184830.373232-5-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MdZFaeAXBddFKzPC"
Content-Disposition: inline
In-Reply-To: <20260623184830.373232-5-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--MdZFaeAXBddFKzPC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 23, 2026 at 08:48:29PM +0200, Sam Li wrote:
> +/*
> + * Read/Write the new wp value for zone `index` through write pointe

pointe -> pointer

> +static int coroutine_fn
> +qcow2_co_zone_report(BlockDriverState *bs, int64_t offset,
> +                     unsigned int *nr_zones, BlockZoneDescriptor *zones)
> +{
> +    BDRVQcow2State *s = bs->opaque;
> +    uint64_t zone_size = s->zoned_header.zone_size;
> +    uint64_t zone_capacity = s->zoned_header.zone_capacity;
> +    int64_t capacity = bs->total_sectors << BDRV_SECTOR_BITS;
> +    int64_t size = bs->bl.nr_zones * zone_size;
> +    unsigned int nrz;
> +    int i = 0;
> +    int si;

Should i and si be unsigned int since nr_zones is an unsigned int?

> +static int coroutine_fn GRAPH_RDLOCK
> +qcow2_reset_zone(BlockDriverState *bs, uint32_t index,
> +                            int64_t len)
> +{
> +    BDRVQcow2State *s = bs->opaque;
> +    int nrz = bs->bl.nr_zones;
> +    int64_t zone_size = bs->bl.zone_size;
> +    int n, ret = 0;
> +    bool any_dirtied = false;

nr_zones is an unsigned int. Variables holding numbers of zones like
nrz, i, and n should be unsigned int, too. That way they behave
correctly over their full range instead of behaving unexpectedly when
they become negative (e.g. in a for loop with i < n).

> +
> +    qemu_co_mutex_lock(&bs->wps->colock);
> +    uint64_t *wp = &bs->wps->wp[index];
> +    if (len == bs->total_sectors << BDRV_SECTOR_BITS) {
> +        n = nrz;
> +        index = 0;
> +        wp = &bs->wps->wp[0];
> +    } else {
> +        n = len / zone_size;
> +    }
> +
> +    for (int i = 0; i < n; ++i) {
> +        uint64_t *wp_i = (uint64_t *)(wp + i);
> +        uint64_t wpi_v = *wp_i;
> +        if (QCOW2_ZT_IS_CONV(wpi_v)) {
> +            continue;
> +        }
> +
> +        /* Reject if any write is in flight for this zone. */
> +        if (s->zone_wp_state &&
> +            !QTAILQ_EMPTY(&s->zone_wp_state[index + i].in_flight)) {
> +            ret = -EBUSY;
> +            goto unlock;
> +        }

This is a coroutine function and it should yield to wait instead of
returning -EBUSY. If -EBUSY is propagated to the guest that would result
in unexpected behavior - I think real devices don't do this and the
guest will not be prepared to handle -EBUSY.

> +
> +        qemu_co_mutex_lock(&s->lock);
> +        BlockZoneState zs = qcow2_get_zone_state(bs, index + i);
> +        switch (zs) {
> +        case BLK_ZS_EMPTY:
> +            break;
> +        case BLK_ZS_IOPEN:
> +            qcow2_rm_imp_open_zone(s, index + i);
> +            trace_qcow2_imp_open_zones(BLK_ZO_RESET, s->nr_zones_imp_open);
> +            break;
> +        case BLK_ZS_EOPEN:
> +            qcow2_rm_exp_open_zone(s, index + i);
> +            break;
> +        case BLK_ZS_CLOSED:
> +            qcow2_rm_closed_zone(s, index + i);
> +            break;
> +        case BLK_ZS_FULL:
> +            break;
> +        default:
> +            ret = -EINVAL;
> +            qemu_co_mutex_unlock(&s->lock);
> +            goto unlock;
> +        }
> +        qemu_co_mutex_unlock(&s->lock);
> +
> +        if (zs == BLK_ZS_EMPTY) {
> +            continue;
> +        }
> +
> +        /*
> +         * Zero the data extent first. Date write fires before the WP cluster

Date -> Data

> +         * hits disk. So the wp advance cannot become durable while stale data
> +         * is still readable.
> +         */
> +        ret = qcow2_co_pwrite_zeroes(bs, (uint64_t)(index + i) * zone_size,
> +                                     zone_size, 0);
> +        if (ret < 0) {
> +            error_report("Failed to clear zone data at zone %u",
> +                         index + i);
> +            goto unlock;
> +        }
> +
> +        qemu_co_mutex_lock(&s->lock);
> +        qcow2_cache_depends_on_flush(s->wp_cache);
> +        qemu_co_mutex_unlock(&s->lock);
> +
> +        *wp_i = (uint64_t)(index + i) * zone_size;
> +        ret = qcow2_rw_wp_at(bs, wp_i, index + i, true);
> +        if (ret < 0) {
> +            goto unlock;

*wp_i has been modified but the operation will fail. The write pointers
in memory and the write pointers in the qcow2 cache and on disk are now
inconsistent. I expect the failure semantics to be that the write
pointers in memory are consistent with the on-disk write pointers,
although I haven't checked specs to see if they say anything about this.

> +        }
> +        any_dirtied = true;
> +    }
> +
> +    if (any_dirtied) {
> +        /* Single flush at the end. */
> +        qemu_co_mutex_lock(&s->lock);
> +        ret = qcow2_cache_flush(bs, s->wp_cache);
> +        qemu_co_mutex_unlock(&s->lock);
> +    }
> +
> +unlock:
> +    qemu_co_mutex_unlock(&bs->wps->colock);
> +    return ret;
> +}
> +
> +static int coroutine_fn GRAPH_RDLOCK
> +qcow2_co_zone_mgmt(BlockDriverState *bs, BlockZoneOp op,
> +                                           int64_t offset, int64_t len)

Indentation is off here.

> +{
> +    BDRVQcow2State *s = bs->opaque;
> +    int ret = 0;
> +    int64_t capacity = bs->total_sectors << BDRV_SECTOR_BITS;
> +    int64_t zone_size = s->zoned_header.zone_size;
> +    int64_t zone_size_mask = zone_size - 1;
> +    uint32_t index = offset / zone_size;

It would be safer to check that this qcow2 image supports zone emulation
before getting deeper into this function. zone_size could be 0 here if
zone emulation is not enabled and it would cause a divide-by-zero
exception.

All block driver zone callbacks in qcow2 should perform this check just
in case an emulated device exposes a code path where the guest can
perform a zoned operation on a non-zoned BlockDriverState.
Alternatively, you could add a generic check in bdrv_co_zone_mgmt() and
similar functions.

> +    BlockZoneWps *wps = bs->wps;
> +
> +    if (offset >= capacity) {
> +        error_report("offset %" PRId64 " is equal to or greater than the"
> +                     "device capacity %" PRId64 "", offset, capacity);
> +        return -EINVAL;
> +    }
> +
> +    if (offset & zone_size_mask) {
> +        error_report("sector offset %" PRId64 " is not aligned to zone size"
> +                     " %" PRId64 "", offset / 512, zone_size / 512);
> +        return -EINVAL;
> +    }
> +
> +    if (((offset + len) < capacity && len & zone_size_mask) ||

Here is how the capacity check is expressed without an integer overflow
in block/block-backend.c:blk_check_byte_request():

  if (offset > len || len - offset < bytes) {
                      ^^^^^^^^^^^^^^^^^^^^
      return -EIO;
  }

It would be preferrable to use that form to avoid integer overflow.

> +        offset + len > capacity) {
> +        error_report("number of sectors %" PRId64 " is not aligned to zone"
> +                     " size %" PRId64 "", len / 512, zone_size / 512);
> +        return -EINVAL;
> +    }
> +
> +    qemu_co_mutex_lock(&wps->colock);
> +    uint64_t wpv = wps->wp[index];
> +    qemu_co_mutex_unlock(&wps->colock);
> +
> +    if (QCOW2_ZT_IS_CONV(wpv)) {
> +        /*
> +         * ZONE_RESET_ALL is a global operation that is allowed when the
> +         * starting zone is conventional; the zone reset path itself skips
> +         * conventional zones.
> +         */
> +        if (op != BLK_ZO_RESET || len != capacity) {
> +            error_report("zone mgmt operation 0x%x is not allowed on "
> +                         "a conventional zone", op);
> +            return -EIO;
> +        }
> +    }
> +
> +    switch (op) {
> +    case BLK_ZO_OPEN:
> +        ret = qcow2_open_zone(bs, index);
> +        break;
> +    case BLK_ZO_CLOSE:
> +        ret = qcow2_close_zone(bs, index);
> +        break;
> +    case BLK_ZO_FINISH:
> +        ret = qcow2_finish_zone(bs, index);
> +        break;
> +    case BLK_ZO_RESET:
> +        ret = qcow2_reset_zone(bs, index, len);
> +        break;
> +    default:
> +        error_report("Unsupported zone op: 0x%x", op);
> +        ret = -ENOTSUP;
> +        break;
> +    }
> +    return ret;
> +}
> +
> +static int coroutine_fn GRAPH_RDLOCK
> +qcow2_co_zone_append(BlockDriverState *bs, int64_t *offset, QEMUIOVector *qiov,
> +                     BdrvRequestFlags flags)
> +{
> +    assert(flags == 0);
> +    int64_t capacity = bs->total_sectors << BDRV_SECTOR_BITS;
> +    int64_t zone_size_mask = bs->bl.zone_size - 1;
> +    int64_t iov_len = 0;
> +    int64_t len = 0;
> +
> +    if (*offset >= capacity) {
> +        error_report("*offset %" PRId64 " is equal to or greater than the"
> +                     "device capacity %" PRId64 "", *offset, capacity);
> +        return -EINVAL;

I'm not sure whether this should be -ENOSPC or -EINVAL. Did you look
into what is most appropriate? pwrite(2) on Linux returns ENOSPC when
writing beyond the end of the block device.

This also applies to other places in this patch that check if offset >=
capacity.

> +    }
> +
> +    /* offset + len should not pass the end of that zone starting from offset */
> +    if (*offset & zone_size_mask) {

The comment doesn't match the check that is performed here.

--MdZFaeAXBddFKzPC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpCrfYACgkQnKSrs4Gr
c8jHKggAkWNF7WnZQCzi2QbnQFbK3iMkm2Ljst/tAz1neL7hkWVTHtCnkF7wFH1D
phXEdCrM33B8DBoNDcdDuxNqejjhqG/7hgf6MjWPv+bWw3qha7AhS3ozL/CyArq9
qIL0xHO6/gP9XKZm/ZihrsaV/GarvPWv/SdNKQlyxiACtxpqHH1OrRbYr6uSCjaU
yjxrcVNG8DnDSzqQg4YAkVEn/u2KloiY/d+XRSF92Zyytl/DDOGqa7wUzpEZdhwv
wP5Rk8zBVI9Q4lEMkGWaal+oJS7t2pnCOjn66vWNDLgliWq7lfe/y0pxwhgfOG4K
qrpD0SKVraR++Qj2G33yPQTVeXHnkg==
=CK7/
-----END PGP SIGNATURE-----

--MdZFaeAXBddFKzPC--


