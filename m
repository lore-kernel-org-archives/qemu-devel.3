Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C24CD37AC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 20:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNcap-0001XZ-AY; Thu, 14 May 2026 16:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wNcam-0001Wd-Qf
 for qemu-devel@nongnu.org; Thu, 14 May 2026 16:23:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wNcah-0006me-FV
 for qemu-devel@nongnu.org; Thu, 14 May 2026 16:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778790209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a7jGphtnZLxXPAx+ivPqIRk9SwDMRFy3QLB/86zMHQo=;
 b=Dfw9Q0xufMdOnwp7yDT/W2pMSBNJlalXKtVE8NMzwKU1pw7AoIyvHRp4LH50eZpm5WklNy
 kHx5hvgQzuYelHgLQBOKTm4ean9r2QZDqQbrJo8L1/7k/DZpaKjBuxxJfDf7fp9rzFWchv
 D/RLG1LNvuVis8Xd+p0TfxYU7HrBvS0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-ycVhlrc4MRqRQewOCDrDIQ-1; Thu,
 14 May 2026 16:23:25 -0400
X-MC-Unique: ycVhlrc4MRqRQewOCDrDIQ-1
X-Mimecast-MFC-AGG-ID: ycVhlrc4MRqRQewOCDrDIQ_1778790203
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51DE919560AA; Thu, 14 May 2026 20:23:23 +0000 (UTC)
Received: from localhost (unknown [10.2.17.3])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B6F41955F2D; Thu, 14 May 2026 20:23:21 +0000 (UTC)
Date: Thu, 14 May 2026 16:23:18 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 dmitry.fomichev@wdc.com, Kevin Wolf <kwolf@redhat.com>,
 cassel@kernel.org, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, dlemoal@kernel.org, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, hare@suse.de,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v10 3/4] qcow2: add zoned emulation capability
Message-ID: <20260514202318.GD1535937@fedora>
References: <20260510175059.311814-1-faithilikerun@gmail.com>
 <20260510175059.311814-4-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lUgwQhnIs0hdIss+"
Content-Disposition: inline
In-Reply-To: <20260510175059.311814-4-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--lUgwQhnIs0hdIss+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 07:50:58PM +0200, Sam Li wrote:
> By adding zone operations and zoned metadata, the zoned emulation
> capability enables full emulation support of zoned device using
> a qcow2 file. The zoned device metadata includes zone type,
> zoned device state and write pointer of each zone, which is stored
> to an array of unsigned integers.
>=20
> Each zone of a zoned device makes state transitions following
> the zone state machine. The zone state machine mainly describes
> five states, IMPLICIT OPEN, EXPLICIT OPEN, FULL, EMPTY and CLOSED.
> READ ONLY and OFFLINE states will generally be affected by device
> internal events. The operations on zones cause corresponding state
> changing.
>=20
> Zoned devices have limits on zone resources, which put constraints on
> write operations on zones. It is managed by active zone queues
> following LRU policy.
>=20
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> ---
>  block/qcow2.c         | 851 +++++++++++++++++++++++++++++++++++++++++-
>  block/qcow2.h         |  13 +-
>  block/trace-events    |   2 +
>  hw/block/virtio-blk.c |  22 +-
>  include/qemu/queue.h  |   1 +
>  include/qemu/range.h  |   4 +
>  6 files changed, 884 insertions(+), 9 deletions(-)

Here are is the feedback I have so far:

>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index b543bcf3e3..c84b67976e 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -195,6 +195,293 @@ qcow2_extract_crypto_opts(QemuOpts *opts, const cha=
r *fmt, Error **errp)
>      return cryptoopts_qdict;
>  }
> =20
> +#define QCOW2_ZT_IS_CONV(wp)    (wp & 1ULL << 59)

Patch 1 does not document in the file format specification that write
pointer bit 59 indicates a conventional zone.

> +#define QCOW2_GET_WP(wp)        ((wp << 5) >> 5)
> +
> +/*
> + * To emulate a real zoned device, closed, empty and full states are
> + * preserved after a power cycle. The open states are in-memory and will
> + * be lost after closing the device. Read-only and offline states are
> + * device-internal events, which are not considered for simplicity.
> + */
> +static inline BlockZoneState qcow2_get_zone_state(BlockDriverState *bs,
> +                                                  uint32_t index)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    Qcow2ZoneListEntry *zone_entry =3D &s->zone_list_entries[index];
> +    uint64_t zone_wp =3D bs->wps->wp[index];
> +    uint64_t zone_start;
> +
> +    if (QCOW2_ZT_IS_CONV(zone_wp)) {
> +        return BLK_ZS_NOT_WP;
> +    }
> +
> +    if (QTAILQ_IN_USE(zone_entry, exp_open_zone_entry)) {
> +        return BLK_ZS_EOPEN;
> +    }
> +    if (QTAILQ_IN_USE(zone_entry, imp_open_zone_entry)) {
> +        return BLK_ZS_IOPEN;
> +    }
> +
> +    zone_start =3D index * bs->bl.zone_size;
> +    if (zone_wp =3D=3D zone_start) {
> +        return BLK_ZS_EMPTY;
> +    }
> +    if (zone_wp >=3D zone_start + bs->bl.zone_capacity) {
> +        return BLK_ZS_FULL;
> +    }
> +    if (zone_wp > zone_start) {
> +        if (!QTAILQ_IN_USE(zone_entry, closed_zone_entry)) {
> +            /*
> +             * The number of closed zones is not always updated in time =
when
> +             * the device is closed. However, it only matters when doing
> +             * zone report. Refresh the count and list of closed zones to
> +             * provide correct zone states for zone report.
> +             */
> +            QTAILQ_INSERT_HEAD(&s->closed_zones, zone_entry, closed_zone=
_entry);
> +            s->nr_zones_closed++;
> +        }
> +        return BLK_ZS_CLOSED;
> +    }
> +    return BLK_ZS_NOT_WP;
> +}
> +
> +static void qcow2_rm_exp_open_zone(BDRVQcow2State *s,
> +                                   uint32_t index)
> +{
> +    Qcow2ZoneListEntry *zone_entry =3D &s->zone_list_entries[index];
> +
> +    QTAILQ_REMOVE(&s->exp_open_zones, zone_entry, exp_open_zone_entry);
> +    s->nr_zones_exp_open--;
> +}
> +
> +static void qcow2_rm_imp_open_zone(BDRVQcow2State *s,
> +                                   int32_t index)
> +{
> +    Qcow2ZoneListEntry *zone_entry;
> +    if (index < 0) {
> +        /* Apply LRU when the index is not specified. */
> +        zone_entry =3D QTAILQ_LAST(&s->imp_open_zones);
> +    } else {
> +        zone_entry =3D &s->zone_list_entries[index];
> +    }
> +
> +    QTAILQ_REMOVE(&s->imp_open_zones, zone_entry, imp_open_zone_entry);
> +    s->nr_zones_imp_open--;
> +}
> +
> +static void qcow2_rm_open_zone(BDRVQcow2State *s,
> +                               uint32_t index)
> +{
> +    Qcow2ZoneListEntry *zone_entry =3D &s->zone_list_entries[index];
> +
> +    if (QTAILQ_IN_USE(zone_entry, exp_open_zone_entry)) {
> +        qcow2_rm_exp_open_zone(s, index);
> +    } else if (QTAILQ_IN_USE(zone_entry, imp_open_zone_entry)) {
> +        qcow2_rm_imp_open_zone(s, index);
> +    }
> +}
> +
> +static void qcow2_rm_closed_zone(BDRVQcow2State *s,
> +                                 uint32_t index)
> +{
> +    Qcow2ZoneListEntry *zone_entry =3D &s->zone_list_entries[index];
> +
> +    QTAILQ_REMOVE(&s->closed_zones, zone_entry, closed_zone_entry);
> +    s->nr_zones_closed--;
> +}
> +
> +static void qcow2_do_imp_open_zone(BDRVQcow2State *s,
> +                                   uint32_t index,
> +                                   BlockZoneState zs)
> +{
> +    Qcow2ZoneListEntry *zone_entry =3D &s->zone_list_entries[index];
> +
> +    switch (zs) {
> +    case BLK_ZS_EMPTY:
> +        break;
> +    case BLK_ZS_CLOSED:
> +        qcow2_rm_closed_zone(s, index);
> +        break;
> +    case BLK_ZS_IOPEN:
> +        /*
> +         * The LRU policy: update the zone that is most recently
> +         * used to the head of the zone list
> +         */
> +        if (zone_entry =3D=3D QTAILQ_FIRST(&s->imp_open_zones)) {
> +            return;
> +        }
> +        QTAILQ_REMOVE(&s->imp_open_zones, zone_entry, imp_open_zone_entr=
y);
> +        s->nr_zones_imp_open--;
> +        break;
> +    default:
> +        return;
> +    }
> +
> +    QTAILQ_INSERT_HEAD(&s->imp_open_zones, zone_entry, imp_open_zone_ent=
ry);
> +    s->nr_zones_imp_open++;
> +}
> +
> +static void qcow2_do_exp_open_zone(BDRVQcow2State *s,
> +                                   uint32_t index)
> +{
> +    Qcow2ZoneListEntry *zone_entry =3D &s->zone_list_entries[index];
> +
> +    QTAILQ_INSERT_HEAD(&s->exp_open_zones, zone_entry, exp_open_zone_ent=
ry);
> +    s->nr_zones_exp_open++;
> +}
> +
> +/*
> + * The list of zones is managed using an LRU policy: the last
> + * zone of the list is always the one that was least recently used
> + * for writing and is chosen as the zone to close to be able to
> + * implicitly open another zone.
> + *
> + * We can only close the open zones. The index is not specified
> + * when it is less than 0.
> + */
> +static void qcow2_do_close_zone(BlockDriverState *bs,
> +                                int32_t index,
> +                                BlockZoneState zs)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    Qcow2ZoneListEntry *zone_entry;
> +
> +    if (index >=3D 0) {
> +        zone_entry =3D &s->zone_list_entries[index];
> +    } else {
> +        /* before removal of the last implicitly open zone */
> +        zone_entry =3D QTAILQ_LAST(&s->imp_open_zones);
> +    }
> +
> +    if (zs =3D=3D BLK_ZS_IOPEN) {
> +        qcow2_rm_imp_open_zone(s, index);
> +        goto close_zone;
> +    }
> +
> +    if (index >=3D 0 && zs =3D=3D BLK_ZS_EOPEN) {
> +        qcow2_rm_exp_open_zone(s, index);
> +        /*
> +         * The zone state changes when the zone is removed from the list=
 of
> +         * open zones (explicitly open -> empty). The closed zone list is
> +         * refreshed during get_zone_state().
> +         */
> +        qcow2_get_zone_state(bs, index);
> +    }
> +    return;
> +
> +close_zone:
> +    QTAILQ_INSERT_HEAD(&s->closed_zones, zone_entry, closed_zone_entry);
> +    s->nr_zones_closed++;
> +}
> +
> +/*
> + * Read/Write the new wp value to the dedicated location of the image fi=
le.
> + */
> +static int coroutine_fn GRAPH_RDLOCK
> +qcow2_rw_wp_at(BlockDriverState *bs, uint64_t *wp,
> +                  int32_t index, bool is_write) {
> +    BDRVQcow2State *s =3D bs->opaque;
> +    g_autofree uint64_t *temp =3D NULL;
> +    uint64_t wpv =3D *wp;
> +    int ret;
> +
> +    if (is_write) {
> +        ret =3D bdrv_pwrite(bs->file, s->zoned_header.zonedmeta_offset
> +                          + sizeof(uint64_t) * index, sizeof(uint64_t), =
wp, 0);
> +        if (ret < 0) {
> +            *wp =3D wpv;
> +            goto exit;
> +        }
> +    } else {
> +        temp =3D g_new(uint64_t, 1);
> +        ret =3D bdrv_pread(bs->file, s->zoned_header.zonedmeta_offset
> +                         + sizeof(uint64_t) * index, sizeof(uint64_t), t=
emp, 0);
> +        if (ret < 0) {
> +            goto exit;
> +        }
> +
> +        *wp =3D *temp;
> +    }
> +
> +    trace_qcow2_wp_tracking(index, *wp >> BDRV_SECTOR_BITS);
> +    return ret;
> +
> +exit:
> +    error_report("Failed to %s metadata to file", is_write ? "write" : "=
read");
> +    return ret;
> +}
> +
> +static bool qcow2_can_activate_zone(BlockDriverState *bs)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +
> +    /* When the max active zone is zero, there is no limit on active zon=
es */
> +    if (!s->zoned_header.max_active_zones) {
> +        return true;
> +    }
> +
> +    /* Active zones are zones that are open or closed */
> +    return s->nr_zones_exp_open + s->nr_zones_imp_open + s->nr_zones_clo=
sed
> +        < s->zoned_header.max_active_zones;
> +}
> +
> +/*
> + * This function manages open zones under active zones limit. It checks
> + * if a zone can transition to open state while maintaining max open and
> + * active zone limits.
> + */
> +static bool qcow2_can_open_zone(BlockDriverState *bs)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +
> +    /* When the max open zone is zero, there is no limit on open zones */
> +    if (!s->zoned_header.max_open_zones) {
> +        return true;
> +    }
> +
> +    /*
> +     * The open zones are zones with the states of explicitly and
> +     * implicitly open.
> +     */
> +    if (s->nr_zones_imp_open + s->nr_zones_exp_open <
> +        s->zoned_header.max_open_zones) {
> +        return true;
> +    }
> +
> +    /*
> +     * Zones are managed one at a time. Thus, the number of implicitly o=
pen
> +     * zone can never be over the open zone limit. When the active zone =
limit
> +     * is not reached, close only one implicitly open zone.
> +     */
> +    if (qcow2_can_activate_zone(bs)) {
> +        qcow2_do_close_zone(bs, -1, BLK_ZS_IOPEN);
> +        trace_qcow2_imp_open_zones(0x23, s->nr_zones_imp_open);
> +        return true;
> +    }
> +    return false;
> +}
> +
> +static inline int coroutine_fn GRAPH_RDLOCK
> +qcow2_refresh_zonedmeta(BlockDriverState *bs)
> +{
> +    int ret;
> +    BDRVQcow2State *s =3D bs->opaque;
> +    uint64_t wps_size =3D s->zoned_header.zonedmeta_size;
> +    g_autofree uint64_t *temp =3D NULL;
> +
> +    temp =3D g_new(uint64_t, s->zoned_header.nr_zones);
> +    ret =3D bdrv_pread(bs->file, s->zoned_header.zonedmeta_offset,
> +                     wps_size, temp, 0);
> +    if (ret < 0) {
> +        error_report("Cannot read metadata");
> +        return ret;
> +    }
> +
> +    memcpy(bs->wps->wp, temp, wps_size);
> +    return 0;
> +}
> +
>  /*
>   * Passing by the zoned device configurations by a zoned_header struct, =
check
>   * if the zone device options are under constraints. Return false when s=
ome
> @@ -527,7 +814,23 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t=
 start_offset,
>                  be32_to_cpu(zoned_ext.max_active_zones);
>              zoned_ext.max_append_bytes =3D
>                  be32_to_cpu(zoned_ext.max_append_bytes);
> +            zoned_ext.zonedmeta_offset =3D
> +                be64_to_cpu(zoned_ext.zonedmeta_offset);
> +            zoned_ext.zonedmeta_size =3D be64_to_cpu(zoned_ext.zonedmeta=
_size);
>              s->zoned_header =3D zoned_ext;
> +            bs->wps =3D g_malloc(sizeof(BlockZoneWps)
> +                + s->zoned_header.zonedmeta_size);
> +            ret =3D qcow2_refresh_zonedmeta(bs);
> +            if (ret < 0) {
> +                return ret;
> +            }
> +
> +            s->zone_list_entries =3D g_new0(Qcow2ZoneListEntry,
> +                                          zoned_ext.nr_zones);
> +            QTAILQ_INIT(&s->exp_open_zones);
> +            QTAILQ_INIT(&s->imp_open_zones);
> +            QTAILQ_INIT(&s->closed_zones);
> +            qemu_co_mutex_init(&bs->wps->colock);
> =20
>              /* refuse to open broken images */
>              if (zoned_ext.nr_zones !=3D DIV_ROUND_UP(bs->total_sectors *
> @@ -2883,21 +3186,119 @@ static coroutine_fn GRAPH_RDLOCK int qcow2_co_pw=
ritev_task_entry(AioTask *task)
>                                   t->l2meta);
>  }
> =20
> +/*
> + * If it is an append write request, the offset pointer needs to be upda=
ted to
> + * the wp value of that zone after the IO completion. The unique pointer=
 is
> + * passed on to this function to prevent the value being changed in cond=
ition of
> + * multiple concurrent writes.
> + */
>  static int coroutine_fn GRAPH_RDLOCK
> -qcow2_co_pwritev_part(BlockDriverState *bs, int64_t offset, int64_t byte=
s,
> -                      QEMUIOVector *qiov, size_t qiov_offset,
> -                      BdrvRequestFlags flags)
> +qcow2_co_pwv_part(BlockDriverState *bs, int64_t *offset_ptr, int64_t byt=
es,
> +                  QEMUIOVector *qiov, size_t qiov_offset, bool is_append,
> +                  BdrvRequestFlags flags)
>  {
>      BDRVQcow2State *s =3D bs->opaque;
>      int offset_in_cluster;
>      int ret;
>      unsigned int cur_bytes; /* number of sectors in current iteration */
>      uint64_t host_offset;
> +    int64_t offset =3D *offset_ptr;
>      QCowL2Meta *l2meta =3D NULL;
>      AioTaskPool *aio =3D NULL;
> +    int64_t start_offset, start_bytes;
> +    BlockZoneState zs;
> +    int64_t end_zone, end_offset;
> +    uint64_t *wp;
> +    int64_t zone_size =3D bs->bl.zone_size;
> +    int64_t zone_capacity =3D bs->bl.zone_capacity;
> +    int index;
> =20
>      trace_qcow2_writev_start_req(qemu_coroutine_self(), offset, bytes);
> =20
> +    start_offset =3D offset;
> +    start_bytes =3D bytes;
> +    if (bs->bl.zoned =3D=3D BLK_Z_HM) {
> +        index =3D start_offset / zone_size;
> +        wp =3D &bs->wps->wp[index];
> +        if (!QCOW2_ZT_IS_CONV(*wp)) {
> +            if (offset !=3D *wp && !is_append) {
> +                /* The write offset must be equal to the zone write poin=
ter */
> +                error_report("Offset 0x%" PRIx64 " of regular writes mus=
t be "
> +                             "equal to the zone write pointer 0x%" PRIx6=
4 "",
> +                             offset, *wp);
> +                return -EINVAL;
> +            }
> +
> +            if (is_append) {
> +                /*
> +                 * The offset of append write is the write pointer value=
 of
> +                 * that zone.
> +                 */
> +                start_offset =3D *wp;
> +            }
> +
> +            end_offset =3D start_offset + start_bytes;
> +
> +            /* Only allow writes when there are zone resources left */
> +            zs =3D qcow2_get_zone_state(bs, index);
> +            if (zs =3D=3D BLK_ZS_CLOSED || zs =3D=3D BLK_ZS_EMPTY) {
> +                if (!qcow2_can_open_zone(bs)) {
> +                    error_report("no more open zones available");
> +                    return -EINVAL;
> +                }
> +            }
> +
> +            /*
> +             * Align up (start_offset, zone_size), the start offset is n=
ot
> +             * necessarily power of two.
> +             */
> +            end_zone =3D index * zone_size + zone_capacity;
> +            /* Write cannot exceed the zone capacity. */
> +            if (end_offset > end_zone) {
> +                error_report("write exceeds zone capacity with end_offse=
t:"
> +                             "0x%lx, end_zone: 0x%lx",
> +                             end_offset / 512, end_zone / 512);
> +                return -EINVAL;
> +            }
> +
> +            /*
> +             * Real drives change states before it can write to the zone=
=2E If
> +             * the write fails, the zone state may have changed.
> +             *
> +             * The zone state transitions to implicit open when the orig=
inal
> +             * state is empty or closed. When the wp reaches the end, the
> +             * open states (explicit open, implicit open) become full.
> +             */
> +            zs =3D qcow2_get_zone_state(bs, index);
> +            if (!(end_offset & (zone_capacity - 1))) {
> +                /* Being aligned to zone capacity implies full state */
> +                qcow2_rm_open_zone(s, index);
> +                trace_qcow2_imp_open_zones(0x24,
> +                                           s->nr_zones_imp_open);
> +            } else {
> +                qcow2_do_imp_open_zone(s, index, zs);
> +                trace_qcow2_imp_open_zones(0x24,
> +                                           s->nr_zones_imp_open);
> +            }
> +
> +            /*
> +             * The write pointer is update before IO completion, with the
> +             * assumption that the write IO will succeed.
> +             */
> +            qemu_co_mutex_lock(&bs->wps->colock);
> +            if (is_append) {
> +                *offset_ptr =3D *wp;
> +            }
> +            *wp =3D end_offset;
> +            ret =3D qcow2_rw_wp_at(bs, wp, index, true);
> +            qemu_co_mutex_unlock(&bs->wps->colock);
> +            if (ret < 0) {
> +                error_report("failed to update write pointer");
> +                return -EINVAL;
> +            }
> +        }
> +    }
> +
>      while (bytes !=3D 0 && aio_task_pool_status(aio) =3D=3D 0) {
> =20
>          l2meta =3D NULL;
> @@ -2943,6 +3344,7 @@ qcow2_co_pwritev_part(BlockDriverState *bs, int64_t=
 offset, int64_t bytes,
>          qiov_offset +=3D cur_bytes;
>          trace_qcow2_writev_done_part(qemu_coroutine_self(), cur_bytes);
>      }
> +
>      ret =3D 0;
> =20
>      qemu_co_mutex_lock(&s->lock);
> @@ -2961,11 +3363,32 @@ fail_nometa:
>          g_free(aio);
>      }
> =20
> +    if (ret < 0 && bs->bl.zoned =3D=3D BLK_Z_HM) {
> +        /* update the wp when write IO failed */
> +        qemu_co_mutex_lock(&bs->wps->colock);
> +        index =3D start_offset / zone_size;
> +        wp =3D &bs->wps->wp[index];
> +        if (!QCOW2_ZT_IS_CONV(*wp)) {
> +            ret =3D qcow2_rw_wp_at(bs, wp, index, false);
> +        }
> +        qemu_co_mutex_unlock(&bs->wps->colock);
> +    }
> +
>      trace_qcow2_writev_done_req(qemu_coroutine_self(), ret);
> =20
>      return ret;
>  }
> =20
> +static int coroutine_fn GRAPH_RDLOCK
> +qcow2_co_pwritev_part(BlockDriverState *bs, int64_t offset, int64_t byte=
s,
> +                      QEMUIOVector *qiov, size_t qiov_offset,
> +                      BdrvRequestFlags flags)
> +{
> +    return qcow2_co_pwv_part(bs, &offset, bytes, qiov, qiov_offset, fals=
e,
> +                             flags);
> +}
> +
> +
>  static int GRAPH_RDLOCK qcow2_inactivate(BlockDriverState *bs)
>  {
>      BDRVQcow2State *s =3D bs->opaque;
> @@ -3001,6 +3424,25 @@ static int GRAPH_RDLOCK qcow2_inactivate(BlockDriv=
erState *bs)
>      return result;
>  }
> =20
> +static void qcow2_do_close_all_zone(BDRVQcow2State *s)
> +{
> +    Qcow2ZoneListEntry *zone_entry, *next;
> +
> +    QTAILQ_FOREACH_SAFE(zone_entry, &s->imp_open_zones, imp_open_zone_en=
try,
> +                        next) {
> +        QTAILQ_REMOVE(&s->imp_open_zones, zone_entry, imp_open_zone_entr=
y);
> +        s->nr_zones_imp_open--;
> +    }
> +
> +    QTAILQ_FOREACH_SAFE(zone_entry, &s->exp_open_zones, exp_open_zone_en=
try,
> +                        next) {
> +        QTAILQ_REMOVE(&s->exp_open_zones, zone_entry, exp_open_zone_entr=
y);
> +        s->nr_zones_exp_open--;
> +    }
> +
> +    assert(s->nr_zones_imp_open + s->nr_zones_exp_open =3D=3D 0);
> +}
> +
>  static void coroutine_mixed_fn GRAPH_RDLOCK
>  qcow2_do_close(BlockDriverState *bs, bool close_data_file)
>  {
> @@ -3040,6 +3482,8 @@ qcow2_do_close(BlockDriverState *bs, bool close_dat=
a_file)
> =20
>      qcow2_refcount_close(bs);
>      qcow2_free_snapshots(bs);
> +    qcow2_do_close_all_zone(s);
> +    g_free(bs->wps);
>  }
> =20
>  static void GRAPH_UNLOCKED qcow2_close(BlockDriverState *bs)
> @@ -3357,7 +3801,10 @@ int qcow2_update_header(BlockDriverState *bs)
>              .max_active_zones   =3D
>                  cpu_to_be32(s->zoned_header.max_active_zones),
>              .max_append_bytes =3D
> -                cpu_to_be32(s->zoned_header.max_append_bytes)
> +                cpu_to_be32(s->zoned_header.max_append_bytes),
> +            .zonedmeta_offset   =3D
> +                cpu_to_be64(s->zoned_header.zonedmeta_offset),
> +            .zonedmeta_size     =3D cpu_to_be64(s->zoned_header.zonedmet=
a_size),
>          };
>          ret =3D header_ext_add(buf, QCOW2_EXT_MAGIC_ZONED_FORMAT,
>                               &zoned_header, sizeof(zoned_header),
> @@ -3766,7 +4213,8 @@ qcow2_co_create(BlockdevCreateOptions *create_optio=
ns, Error **errp)
>      int version;
>      int refcount_order;
>      uint64_t *refcount_table;
> -    int ret;
> +    uint64_t zoned_meta_size, zoned_clusterlen;
> +    int ret, offset, i;
>      uint8_t compression_type =3D QCOW2_COMPRESSION_TYPE_ZLIB;
> =20
>      assert(create_options->driver =3D=3D BLOCKDEV_DRIVER_QCOW2);
> @@ -4113,6 +4561,42 @@ qcow2_co_create(BlockdevCreateOptions *create_opti=
ons, Error **errp)
>              ret =3D -EINVAL;
>              goto unlock;
>          }
> +
> +        uint32_t nrz =3D s->zoned_header.nr_zones;
> +        zoned_meta_size =3D  sizeof(uint64_t) * nrz;
> +        g_autofree uint64_t *meta =3D NULL;
> +        meta =3D g_new0(uint64_t, nrz);
> +
> +        for (i =3D 0; i < s->zoned_header.conventional_zones; ++i) {
> +            meta[i] =3D i * s->zoned_header.zone_size;
> +            meta[i] |=3D 1ULL << 59;
> +        }
> +
> +        for (; i < nrz; ++i) {
> +            meta[i] =3D i * s->zoned_header.zone_size;
> +        }
> +
> +        offset =3D qcow2_alloc_clusters(blk_bs(blk), zoned_meta_size);
> +        if (offset < 0) {
> +            ret =3D offset;
> +            error_setg_errno(errp, -ret, "Could not allocate clusters "
> +                                         "for zoned metadata size");
> +            goto unlock;
> +        }
> +        s->zoned_header.zonedmeta_offset =3D offset;
> +        s->zoned_header.zonedmeta_size =3D zoned_meta_size;
> +
> +        zoned_clusterlen =3D size_to_clusters(s, zoned_meta_size)
> +                * s->cluster_size;
> +        ret =3D qcow2_pre_write_overlap_check(blk_bs(blk), 0, offset,
> +                                            zoned_clusterlen, false);
> +        assert(ret =3D=3D 0);
> +        ret =3D bdrv_pwrite(blk_bs(blk)->file, offset, zoned_meta_size, =
meta, 0);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Could not write zoned metadata=
 "
> +                                         "to disk");
> +            goto unlock;
> +        }
>      } else {
>          s->zoned_header.zoned =3D BLK_Z_NONE;
>      }
> @@ -4512,6 +4996,359 @@ qcow2_co_pdiscard(BlockDriverState *bs, int64_t o=
ffset, int64_t bytes)
>      return ret;
>  }
> =20
> +static int coroutine_fn
> +qcow2_co_zone_report(BlockDriverState *bs, int64_t offset,
> +                     unsigned int *nr_zones, BlockZoneDescriptor *zones)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    uint64_t zone_size =3D s->zoned_header.zone_size;
> +    int64_t capacity =3D bs->total_sectors << BDRV_SECTOR_BITS;
> +    int64_t size =3D bs->bl.nr_zones * zone_size;
> +    unsigned int nrz;
> +    int i =3D 0;
> +    int si;
> +
> +    if (offset >=3D capacity) {
> +        error_report("offset %" PRId64 " is equal to or greater than the=
 "
> +                     "device capacity %" PRId64 "", offset, capacity);
> +        return -EINVAL;
> +    }
> +
> +    nrz =3D ((*nr_zones) < bs->bl.nr_zones) ? (*nr_zones) : bs->bl.nr_zo=
nes;
> +    si =3D offset / zone_size; /* Zone size cannot be 0 for zoned device=
 */
> +    qemu_co_mutex_lock(&bs->wps->colock);
> +    for (; i < nrz; ++i) {
> +        if (i + si >=3D bs->bl.nr_zones) {
> +            break;
> +        }
> +
> +        zones[i].start =3D (si + i) * zone_size;
> +
> +        /* The last zone can be smaller than the zone size */
> +        if ((si + i + 1) =3D=3D bs->bl.nr_zones && size > capacity) {
> +            uint32_t l =3D zone_size - (size - capacity);
> +            zones[i].length =3D l;
> +            zones[i].cap =3D l;
> +        } else {
> +            zones[i].length =3D zone_size;
> +            zones[i].cap =3D zone_size;
> +        }
> +
> +        uint64_t wp =3D bs->wps->wp[si + i];
> +        if (QCOW2_ZT_IS_CONV(wp)) {
> +            zones[i].type =3D BLK_ZT_CONV;
> +            zones[i].state =3D BLK_ZS_NOT_WP;
> +            /* Clear masking bits */
> +            wp =3D QCOW2_GET_WP(wp);
> +        } else {
> +            zones[i].type =3D BLK_ZT_SWR;
> +            zones[i].state =3D qcow2_get_zone_state(bs, si + i);
> +        }
> +        zones[i].wp =3D wp;
> +    }
> +    qemu_co_mutex_unlock(&bs->wps->colock);
> +    *nr_zones =3D i;
> +    return 0;
> +}
> +
> +static int coroutine_fn GRAPH_RDLOCK
> +qcow2_open_zone(BlockDriverState *bs, uint32_t index) {
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int ret;
> +
> +    qemu_co_mutex_lock(&bs->wps->colock);
> +    BlockZoneState zs =3D qcow2_get_zone_state(bs, index);
> +    trace_qcow2_imp_open_zones(BLK_ZO_OPEN, s->nr_zones_imp_open);
> +
> +    switch (zs) {
> +    case BLK_ZS_EMPTY:
> +        if (!qcow2_can_activate_zone(bs)) {
> +            ret =3D -EBUSY;
> +            goto unlock;
> +        }
> +        break;
> +    case BLK_ZS_IOPEN:
> +        qcow2_rm_imp_open_zone(s, index);
> +        break;
> +    case BLK_ZS_EOPEN:
> +        return 0;
> +    case BLK_ZS_CLOSED:
> +        if (!qcow2_can_open_zone(bs)) {
> +            ret =3D -EINVAL;
> +            goto unlock;
> +        }
> +        qcow2_rm_closed_zone(s, index);
> +        break;
> +    case BLK_ZS_FULL:
> +        break;
> +    default:
> +        ret =3D -EINVAL;
> +        goto unlock;
> +    }
> +
> +    qcow2_do_exp_open_zone(s, index);
> +    ret =3D 0;
> +
> +unlock:
> +    qemu_co_mutex_unlock(&bs->wps->colock);
> +    return ret;
> +}
> +
> +static int qcow2_close_zone(BlockDriverState *bs, uint32_t index)
> +{
> +    int ret;
> +
> +    qemu_co_mutex_lock(&bs->wps->colock);
> +    BlockZoneState zs =3D qcow2_get_zone_state(bs, index);
> +
> +    switch (zs) {
> +    case BLK_ZS_EMPTY:
> +        break;
> +    case BLK_ZS_IOPEN:
> +        break;
> +    case BLK_ZS_EOPEN:
> +        break;
> +    case BLK_ZS_CLOSED:
> +        /* Closing a closed zone is not an error */
> +        ret =3D 0;
> +        goto unlock;
> +    case BLK_ZS_FULL:
> +        break;
> +    default:
> +        ret =3D -EINVAL;
> +        goto unlock;
> +    }
> +    qcow2_do_close_zone(bs, index, zs);
> +    ret =3D 0;
> +
> +unlock:
> +    qemu_co_mutex_unlock(&bs->wps->colock);
> +    return ret;
> +}
> +
> +static int coroutine_fn GRAPH_RDLOCK
> +qcow2_finish_zone(BlockDriverState *bs, uint32_t index) {
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int ret;
> +
> +    qemu_co_mutex_lock(&bs->wps->colock);
> +    uint64_t *wp =3D &bs->wps->wp[index];
> +    BlockZoneState zs =3D qcow2_get_zone_state(bs, index);
> +
> +    switch (zs) {
> +    case BLK_ZS_EMPTY:
> +        if (!qcow2_can_activate_zone(bs)) {
> +            ret =3D -EBUSY;
> +            goto unlock;
> +        }
> +        break;
> +    case BLK_ZS_IOPEN:
> +        qcow2_rm_imp_open_zone(s, index);
> +        trace_qcow2_imp_open_zones(BLK_ZO_FINISH, s->nr_zones_imp_open);
> +        break;
> +    case BLK_ZS_EOPEN:
> +        qcow2_rm_exp_open_zone(s, index);
> +        break;
> +    case BLK_ZS_CLOSED:
> +        if (!qcow2_can_open_zone(bs)) {
> +            ret =3D -EINVAL;
> +            goto unlock;
> +        }
> +        qcow2_rm_closed_zone(s, index);
> +        break;
> +    case BLK_ZS_FULL:
> +        ret =3D 0;
> +        goto unlock;
> +    default:
> +        ret =3D -EINVAL;
> +        goto unlock;
> +    }
> +
> +    *wp =3D ((uint64_t)index + 1) * s->zoned_header.zone_size;
> +    ret =3D qcow2_rw_wp_at(bs, wp, index, true);
> +
> +unlock:
> +    qemu_co_mutex_unlock(&bs->wps->colock);
> +    return ret;
> +}
> +
> +static int coroutine_fn GRAPH_RDLOCK
> +qcow2_reset_zone(BlockDriverState *bs, uint32_t index,
> +                            int64_t len) {
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int nrz =3D bs->bl.nr_zones;
> +    int zone_size =3D bs->bl.zone_size;
> +    int n, ret =3D 0;
> +
> +    qemu_co_mutex_lock(&bs->wps->colock);
> +    uint64_t *wp =3D &bs->wps->wp[index];
> +    if (len =3D=3D bs->total_sectors << BDRV_SECTOR_BITS) {
> +        n =3D nrz;
> +        index =3D 0;
> +    } else {
> +        n =3D len / zone_size;
> +    }
> +
> +    for (int i =3D 0; i < n; ++i) {
> +        uint64_t *wp_i =3D (uint64_t *)(wp + i);
> +        uint64_t wpi_v =3D *wp_i;
> +        if (QCOW2_ZT_IS_CONV(wpi_v)) {
> +            continue;
> +        }
> +
> +        BlockZoneState zs =3D qcow2_get_zone_state(bs, index + i);
> +        switch (zs) {
> +        case BLK_ZS_EMPTY:
> +            break;
> +        case BLK_ZS_IOPEN:
> +            qcow2_rm_imp_open_zone(s, index + i);
> +            trace_qcow2_imp_open_zones(BLK_ZO_RESET, s->nr_zones_imp_ope=
n);
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
> +            ret =3D -EINVAL;
> +            goto unlock;
> +        }
> +
> +        if (zs =3D=3D BLK_ZS_EMPTY) {
> +            continue;
> +        }
> +
> +        *wp_i =3D ((uint64_t)index + i) * zone_size;
> +        ret =3D qcow2_rw_wp_at(bs, wp_i, index + i, true);
> +        if (ret < 0) {
> +            goto unlock;
> +        }
> +        /* clear data */
> +        ret =3D qcow2_co_pwrite_zeroes(bs, *wp_i, zone_size, 0);
> +        if (ret < 0) {
> +            error_report("Failed to reset zone at 0x%" PRIx64 "", *wp_i);
> +        }
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
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int ret =3D 0;
> +    int64_t capacity =3D bs->total_sectors << BDRV_SECTOR_BITS;
> +    int64_t zone_size =3D s->zoned_header.zone_size;
> +    int64_t zone_size_mask =3D zone_size - 1;
> +    uint32_t index =3D offset / zone_size;
> +    BlockZoneWps *wps =3D bs->wps;
> +
> +    if (offset >=3D capacity) {
> +        error_report("offset %" PRId64 " is equal to or greater than the"
> +                     "device capacity %" PRId64 "", offset, capacity);
> +        return -EINVAL;
> +    }
> +
> +    if (offset & zone_size_mask) {
> +        error_report("sector offset %" PRId64 " is not aligned to zone s=
ize"
> +                     " %" PRId64 "", offset / 512, zone_size / 512);
> +        return -EINVAL;
> +    }
> +
> +    if (((offset + len) < capacity && len & zone_size_mask) ||
> +        offset + len > capacity) {
> +        error_report("number of sectors %" PRId64 " is not aligned to zo=
ne"
> +                     " size %" PRId64 "", len / 512, zone_size / 512);
> +        return -EINVAL;
> +    }
> +
> +    qemu_co_mutex_lock(&wps->colock);
> +    uint64_t wpv =3D wps->wp[index];

Do we need to check that index < nr_zones?

> +    if (QCOW2_ZT_IS_CONV(wpv) && len !=3D capacity) {

Does the len !=3D capacity check cover all cases or is it just for
BLK_ZO_RESET? For example, when BLK_ZO_OPEN is called with len =3D=3D
capacity it seems possible to perform an open operation on the zone?

> +        error_report("zone mgmt operations are not allowed for "
> +                     "conventional zones");
> +        ret =3D -EIO;
> +        goto unlock;
> +    }
> +    qemu_co_mutex_unlock(&wps->colock);
> +
> +    switch (op) {
> +    case BLK_ZO_OPEN:
> +        ret =3D qcow2_open_zone(bs, index);
> +        break;
> +    case BLK_ZO_CLOSE:
> +        ret =3D qcow2_close_zone(bs, index);
> +        break;
> +    case BLK_ZO_FINISH:
> +        ret =3D qcow2_finish_zone(bs, index);
> +        break;
> +    case BLK_ZO_RESET:
> +        ret =3D qcow2_reset_zone(bs, index, len);
> +        break;
> +    default:
> +        error_report("Unsupported zone op: 0x%x", op);
> +        ret =3D -ENOTSUP;
> +        break;
> +    }
> +    return ret;
> +
> +unlock:
> +    qemu_co_mutex_unlock(&wps->colock);
> +    return ret;
> +}
> +
> +static int coroutine_fn GRAPH_RDLOCK
> +qcow2_co_zone_append(BlockDriverState *bs, int64_t *offset, QEMUIOVector=
 *qiov,
> +                     BdrvRequestFlags flags)
> +{
> +    assert(flags =3D=3D 0);
> +    int64_t capacity =3D bs->total_sectors << BDRV_SECTOR_BITS;
> +    int64_t zone_size_mask =3D bs->bl.zone_size - 1;
> +    int64_t iov_len =3D 0;
> +    int64_t len =3D 0;
> +
> +    if (*offset >=3D capacity) {
> +        error_report("*offset %" PRId64 " is equal to or greater than th=
e"
> +                     "device capacity %" PRId64 "", *offset, capacity);
> +        return -EINVAL;
> +    }
> +
> +    /* offset + len should not pass the end of that zone starting from o=
ffset */
> +    if (*offset & zone_size_mask) {
> +        error_report("sector offset %" PRId64 " is not aligned to zone s=
ize "
> +                     "%" PRId64 "", *offset / 512, bs->bl.zone_size / 51=
2);
> +        return -EINVAL;
> +    }
> +
> +    int64_t wg =3D bs->bl.write_granularity;
> +    int64_t wg_mask =3D wg - 1;
> +    for (int i =3D 0; i < qiov->niov; i++) {
> +        iov_len =3D qiov->iov[i].iov_len;
> +        if (iov_len & wg_mask) {
> +            error_report("len of IOVector[%d] 0x%" PRIx64 " is not align=
ed to "
> +                         "block size 0x%" PRIx64 "", i, iov_len, wg);
> +            return -EINVAL;
> +        }
> +    }
> +    len =3D qiov->size;
> +
> +    if ((len >> BDRV_SECTOR_BITS) > bs->bl.max_append_sectors) {
> +        error_report("len 0x%" PRIx64 " in sectors is greater than "
> +                     "max_append_sectors 0x%" PRIx32 "",
> +                     len >> BDRV_SECTOR_BITS, bs->bl.max_append_sectors);
> +        return -EINVAL;
> +    }
> +
> +    return qcow2_co_pwv_part(bs, offset, len, qiov, 0, true, 0);
> +}
> +
>  static int coroutine_fn GRAPH_RDLOCK
>  qcow2_co_copy_range_from(BlockDriverState *bs,
>                           BdrvChild *src, int64_t src_offset,
> @@ -6578,6 +7415,10 @@ BlockDriver bdrv_qcow2 =3D {
>      .bdrv_co_pwritev_compressed_part    =3D qcow2_co_pwritev_compressed_=
part,
>      .bdrv_make_empty                    =3D qcow2_make_empty,
> =20
> +    .bdrv_co_zone_report    =3D qcow2_co_zone_report,
> +    .bdrv_co_zone_mgmt    =3D qcow2_co_zone_mgmt,

This struct seems to align the equals signs so it's nicer to look at.
Please align this equals sign for consistency.

> +    .bdrv_co_zone_append    =3D qcow2_co_zone_append,
> +
>      .bdrv_snapshot_create               =3D qcow2_snapshot_create,
>      .bdrv_snapshot_goto                 =3D qcow2_snapshot_goto,
>      .bdrv_snapshot_delete               =3D qcow2_snapshot_delete,
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 743f2e3e79..4f72b8d62a 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -256,9 +256,9 @@ typedef struct Qcow2ZonedHeaderExtension {
>  } QEMU_PACKED Qcow2ZonedHeaderExtension;
> =20
>  typedef struct Qcow2ZoneListEntry {
> -    QLIST_ENTRY(Qcow2ZoneListEntry) exp_open_zone_entry;
> -    QLIST_ENTRY(Qcow2ZoneListEntry) imp_open_zone_entry;
> -    QLIST_ENTRY(Qcow2ZoneListEntry) closed_zone_entry;
> +    QTAILQ_ENTRY(Qcow2ZoneListEntry) exp_open_zone_entry;
> +    QTAILQ_ENTRY(Qcow2ZoneListEntry) imp_open_zone_entry;
> +    QTAILQ_ENTRY(Qcow2ZoneListEntry) closed_zone_entry;
>  } Qcow2ZoneListEntry;

Please squash this into the patch that introduced Qcow2ZoneListEntry or,
better yet, remove it from that patch and defer the definition of this
struct until the current patch.

> =20
>  typedef struct Qcow2UnknownHeaderExtension {
> @@ -456,6 +456,13 @@ typedef struct BDRVQcow2State {
> =20
>      /* States of zoned device */
>      Qcow2ZonedHeaderExtension zoned_header;
> +    QTAILQ_HEAD(, Qcow2ZoneListEntry) exp_open_zones;
> +    QTAILQ_HEAD(, Qcow2ZoneListEntry) imp_open_zones;
> +    QTAILQ_HEAD(, Qcow2ZoneListEntry) closed_zones;
> +    Qcow2ZoneListEntry *zone_list_entries;
> +    uint32_t nr_zones_exp_open;
> +    uint32_t nr_zones_imp_open;
> +    uint32_t nr_zones_closed;
>  } BDRVQcow2State;
> =20
>  typedef struct Qcow2COWRegion {
> diff --git a/block/trace-events b/block/trace-events
> index 950c82d4b8..30a3e303ca 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -76,6 +76,8 @@ qcow2_writev_data(void *co, uint64_t offset) "co %p off=
set 0x%" PRIx64
>  qcow2_pwrite_zeroes_start_req(void *co, int64_t offset, int64_t bytes) "=
co %p offset 0x%" PRIx64 " bytes %" PRId64
>  qcow2_pwrite_zeroes(void *co, int64_t offset, int64_t bytes) "co %p offs=
et 0x%" PRIx64 " bytes %" PRId64
>  qcow2_skip_cow(void *co, uint64_t offset, int nb_clusters) "co %p offset=
 0x%" PRIx64 " nb_clusters %d"
> +qcow2_wp_tracking(int index, uint64_t wp) "wps[%d]: 0x%" PRIx64
> +qcow2_imp_open_zones(uint8_t op, int nrz) "nr_imp_open_zones after op 0x=
%x: %d"
> =20
>  # qcow2-cluster.c
>  qcow2_alloc_clusters_offset(void *co, uint64_t offset, int bytes) "co %p=
 offset 0x%" PRIx64 " bytes %d"
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 9cb9f1fb2b..285db19ac7 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c

Please move the virtio-blk changes into a separate patch. It doesn't
seem to be directly related to qcow2 support.

> @@ -288,6 +288,9 @@ static void virtio_blk_submit_multireq(VirtIOBlock *s=
, MultiReqBuffer *mrb)
>      int i =3D 0, start =3D 0, num_reqs =3D 0, niov =3D 0, nb_sectors =3D=
 0;
>      uint32_t max_transfer;
>      int64_t sector_num =3D 0;
> +    BlockDriverState *bs =3D blk_bs(s->blk);
> +    bool zone_cross;
> +    int64_t zone_sector, end_sector;
> =20
>      if (mrb->num_reqs =3D=3D 1) {
>          submit_requests(s, mrb, 0, 1, -1);
> @@ -303,17 +306,34 @@ static void virtio_blk_submit_multireq(VirtIOBlock =
*s, MultiReqBuffer *mrb)
>      for (i =3D 0; i < mrb->num_reqs; i++) {
>          VirtIOBlockReq *req =3D mrb->reqs[i];
>          if (num_reqs > 0) {
> +            zone_cross =3D false;
> +
> +            /*
> +             * On zoned backends, a single backend write must not span a=
 zone
> +             * boundary. Bail out of merging if combining req into the c=
urrent
> +             * batch would straddle a zone.
> +             */
> +            if (bs && bs->bl.zone_size > 0) {
> +                zone_sector =3D bs->bl.zone_size / BDRV_SECTOR_SIZE;
> +                end_sector =3D req->sector_num
> +                                + req->qiov.size / BDRV_SECTOR_SIZE - 1;
> +                zone_cross =3D (sector_num / zone_sector) !=3D
> +                             (end_sector / zone_sector);
> +            }
> +
>              /*
>               * NOTE: We cannot merge the requests in below situations:
>               * 1. requests are not sequential
>               * 2. merge would exceed maximum number of IOVs
>               * 3. merge would exceed maximum transfer length of backend =
device
> +             * 4. merge would cross a zone boundary on a zoned backend
>               */
>              if (sector_num + nb_sectors !=3D req->sector_num ||
>                  niov > blk_get_max_iov(s->blk) - req->qiov.niov ||
>                  req->qiov.size > max_transfer ||
>                  nb_sectors > (max_transfer -
> -                              req->qiov.size) / BDRV_SECTOR_SIZE) {
> +                              req->qiov.size) / BDRV_SECTOR_SIZE ||
> +                zone_cross) {
>                  submit_requests(s, mrb, start, num_reqs, niov);
>                  num_reqs =3D 0;
>              }
> diff --git a/include/qemu/queue.h b/include/qemu/queue.h
> index e029e7bf66..3f0a48740e 100644
> --- a/include/qemu/queue.h
> +++ b/include/qemu/queue.h
> @@ -179,6 +179,7 @@ struct {                                             =
                   \
>  #define QLIST_EMPTY(head)                ((head)->lh_first =3D=3D NULL)
>  #define QLIST_FIRST(head)                ((head)->lh_first)
>  #define QLIST_NEXT(elm, field)           ((elm)->field.le_next)
> +#define QLIST_LAST(head, field)          (*(head)->lh_first->field.le_pr=
ev)

If QLIST_LAST() is supposed to fetch the last element in the list, then
it won't work:

  #define QLIST_INSERT_HEAD(head, elm, field) do {                        \
          if (((elm)->field.le_next =3D (head)->lh_first) !=3D NULL)       =
   \
                  (head)->lh_first->field.le_prev =3D &(elm)->field.le_next=
;\
          (head)->lh_first =3D (elm);                                      =
 \
          (elm)->field.le_prev =3D &(head)->lh_first;                      =
 \
	  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The first node's le_prev points to the head's lh_first field, not to the
last node.

> =20
> =20
>  /*
> diff --git a/include/qemu/range.h b/include/qemu/range.h
> index d446ad885d..d39ba68407 100644
> --- a/include/qemu/range.h
> +++ b/include/qemu/range.h
> @@ -213,6 +213,10 @@ static inline int range_covers_byte(uint64_t offset,=
 uint64_t len,
>  static inline bool ranges_overlap(uint64_t first1, uint64_t len1,
>                                    uint64_t first2, uint64_t len2)
>  {
> +    if (first1 + len1 =3D=3D 0 || first2 + len2 =3D=3D 0) {
> +        return false;
> +    }

What is this?

> +
>      uint64_t last1 =3D range_get_last(first1, len1);
>      uint64_t last2 =3D range_get_last(first2, len2);
> =20
> --=20
> 2.43.0
>=20

--lUgwQhnIs0hdIss+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoGLzYACgkQnKSrs4Gr
c8hAzQgAyDKTWMx6Hj+pq6PgMwrBsJ5rLIDWLfMJogwlu3B6zcnIHQK0v0uUjMOO
n/wu81/nIk5TJNM1lV2ESrE+8s52BzC4e0WDm9Qkl8/pnww1urfx8dHfFaq3L8e3
CvB0GiPzt2F8tb907azxLkplv1hmPfKwMgRMkJSDfrYEuXXHi74vBKQD+5lkY2wr
ZPn63UPWvAsgUWS0UZofWiJJAuOFfAU78txamJQdGrCOSceqp3o6O3+Ih5LbvL4F
R5SO+barDGJ5iFp7Utvt1SvLKiqksPsHKIynk2mrVVGfBGcm9JJWqo8O4tj5PeYQ
ht8drfozx8vqTC3psi/QU6rNm+CkdA==
=Fgjn
-----END PGP SIGNATURE-----

--lUgwQhnIs0hdIss+--


