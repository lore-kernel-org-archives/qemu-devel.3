Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17DECD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVF2w-0002Na-80; Thu, 04 Jun 2026 16:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wVF2u-0002N7-J6
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 16:52:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wVF2s-0002XG-FO
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 16:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780606325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ktq+NUS0PNNzW5MI9cWa1tFMEfiOLdTUlGIA0De2Uvg=;
 b=AF52tlcktWWCFvydqsZiICRlMtRdi8flwMXtIuENZzaeKc8zbWERg5dQAsgUHzmL2GMN0T
 ZUxtZcAXE65IIewRAWqAAx8VQOm9cq+JAAWd99RO2kIuIZ6z3DgO6U9AyWlDhyB7wrIiXH
 EW5Bi1Ck3T+KSw8ruWxX1YIrw3fJxP4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-t_BMPGUHNhS5PiMW2ZcB0w-1; Thu,
 04 Jun 2026 16:52:01 -0400
X-MC-Unique: t_BMPGUHNhS5PiMW2ZcB0w-1
X-Mimecast-MFC-AGG-ID: t_BMPGUHNhS5PiMW2ZcB0w_1780606319
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01D321956050; Thu,  4 Jun 2026 20:51:57 +0000 (UTC)
Received: from localhost (unknown [10.2.17.68])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EC470763; Thu,  4 Jun 2026 20:51:55 +0000 (UTC)
Date: Thu, 4 Jun 2026 16:51:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 dmitry.fomichev@wdc.com, Hanna Reitz <hreitz@redhat.com>,
 hare@suse.de, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, cassel@kernel.org, dlemoal@kernel.org
Subject: Re: [PATCH v11 4/5] qcow2: add zoned emulation capability
Message-ID: <20260604205153.GA250536@fedora>
References: <20260601214405.252818-1-faithilikerun@gmail.com>
 <20260601214405.252818-5-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vXH2uc7fmNlgSL3T"
Content-Disposition: inline
In-Reply-To: <20260601214405.252818-5-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--vXH2uc7fmNlgSL3T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 01, 2026 at 11:44:04PM +0200, Sam Li wrote:
> By adding zone operations and zoned metadata, the zoned emulation
> capability enables full emulation support of zoned device using
> a qcow2 file. The zoned device metadata includes zone type,
> zoned device state and write pointer (WP) of each zone, which is
> stored to an array of unsigned integers.
>=20
> WP accessor (qcow2_rw_wp_at) routes reads and writes of an 8-byte
> WP slot through the write pointer cache. The write pointer cache is
> written to disk after the qcow2 metadata is written, thus guaranteeing
> that the write pointer is updated after the corresponding data is
> written. Per-completion cache flush is deferred. The WP cluster reaches
> disk on the next flush.
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
>  block/qcow2-cache.c    |    8 +
>  block/qcow2-refcount.c |    7 +
>  block/qcow2.c          | 1137 +++++++++++++++++++++++++++++++++++++++-
>  block/trace-events     |    2 +
>  4 files changed, 1149 insertions(+), 5 deletions(-)
>=20
> diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
> index 23d9588b08..bdfb11ce88 100644
> --- a/block/qcow2-cache.c
> +++ b/block/qcow2-cache.c
> @@ -275,6 +275,14 @@ int qcow2_cache_set_dependency(BlockDriverState *bs,=
 Qcow2Cache *c,
>  {
>      int ret;
> =20
> +    /*
> +     * If the dependency graph is unchanged, nothing to do. This avoids
> +     * a synchronous flush on every call below.
> +     */
> +    if (c->depends =3D=3D dependency) {
> +        return 0;
> +    }

This makes part of the expression below tautologous:

    if (c->depends && (c->depends !=3D dependency)) {
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^
        ret =3D qcow2_cache_flush_dependency(bs, c);
        if (ret < 0) {
            return ret;
        }
    }

That sub-expression could be dropped, but it makes me worry that the
earlier if (dependency->depends) statement is needed even when
c->depends =3D=3D dependency.

Kevin: Any thoughts on this?

> +
>      if (dependency->depends) {
>          ret =3D qcow2_cache_flush_dependency(bs, dependency);
>          if (ret < 0) {
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 6512cda407..f551726609 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -1239,6 +1239,13 @@ int qcow2_write_caches(BlockDriverState *bs)
>          }
>      }
> =20
> +    if (s->wp_cache) {
> +        ret =3D qcow2_cache_write(bs, s->wp_cache);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +    }
> +
>      return 0;
>  }
> =20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 29eec33e34..bdc8923b71 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -195,6 +195,300 @@ qcow2_extract_crypto_opts(QemuOpts *opts, const cha=
r *fmt, Error **errp)
>      return cryptoopts_qdict;
>  }
> =20
> +#define QCOW2_ZT_IS_CONV(wp)    (wp & 1ULL << 59)
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

I guess this function requires bs->wps->colock or s->lock, otherwise the
TAILQ accesses could race? Please check and document the locking
requirements.

I/O requests may be processed in multiple threads simultaneously.
s->lock protects qcow2 state.

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

This is a uint32_t * uint32_t multiplication that can overflow. Avoid
that with:

  zone_start =3D (uint64_t)index * bs->bl.zone_size;

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

Locking requirements here and in the functions that follow?

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

There is an assumption that zone_entry is no NULL when zs =3D=3D
BLK_ZS_IOPEN? I think that make sense and it means NULL dereferences
cannot happen, but I wanted to check. You could add an assert(zone_entry
!=3D NULL) here to make that explicit.

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

Is the goto and label necessary? Maybe move this inside the if
statement instead to simplify the function.

> +}

I've reviewed up to here for now.

--vXH2uc7fmNlgSL3T
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoh5WgACgkQnKSrs4Gr
c8gV2wf/VV+8ekdvWcnqbsoB3Y7XSb1RWT4RzAm/FUokQ0dOq2ro6gYNCnmUYut+
DD9GBP6xsg9PuDPbwzXzKGlw2Pssc19zebfyofyVZphKE36eybZYlm0X8x8Igp76
MhKKbl7ob1kLgQdNO4jI4t3mfoa0hhdOnRgTFt7IrFiXXVfbYAyTYsg5t33DS7l7
xYR2Azpk2bYaGIjtPOZK3msSf+bZWbEU5IjGPhGMWVQa0dCVSmQpbnI7Gf8iL+2Z
g31/8P+KgtuIELgG/+VuWs8pIMzY+NIcg6bbdQqUgoCwdOLq9kgN76sEERiUa+fQ
EdObpP5iETDFLKZ0Su2yhBSHoc/5cQ==
=kYSv
-----END PGP SIGNATURE-----

--vXH2uc7fmNlgSL3T--


