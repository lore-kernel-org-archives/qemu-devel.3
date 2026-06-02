Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444DDCD6E57
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 20:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUVL2-000744-U3; Tue, 02 Jun 2026 16:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wUVKw-00072y-VO
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 16:03:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wUVKs-00065f-Hm
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 16:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780430617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rwVm49ZpIZqDjbdOKBAMpQAb2cIXLl98FZmQ6qahIAE=;
 b=IMh/sUPn5AEoHFzrGI2/sFbwNVtED7BU5cVa//+x5cAwiheF2ewos+z+igDn7RxjxUHrqs
 5jrYn5kiPrwptx//Toyfmx5V3YfBTX+z/ckDq8SDdx9di995yPls6HVX+6959fsv1qhWe6
 hqXCmoDpGm6I8UsExPgF8XZSHU5EqEQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-zQlSX-nKPn2RwF-yq2qgPw-1; Tue,
 02 Jun 2026 16:03:33 -0400
X-MC-Unique: zQlSX-nKPn2RwF-yq2qgPw-1
X-Mimecast-MFC-AGG-ID: zQlSX-nKPn2RwF-yq2qgPw_1780430612
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B16F4195609D; Tue,  2 Jun 2026 20:03:31 +0000 (UTC)
Received: from localhost (unknown [10.2.16.102])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8D8F21956095; Tue,  2 Jun 2026 20:03:30 +0000 (UTC)
Date: Tue, 2 Jun 2026 16:03:29 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 dmitry.fomichev@wdc.com, Hanna Reitz <hreitz@redhat.com>,
 hare@suse.de, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, cassel@kernel.org, dlemoal@kernel.org
Subject: Re: [PATCH v11 2/5] qcow2: add configurations for zoned format
 extension
Message-ID: <20260602200329.GA1043118@fedora>
References: <20260601214405.252818-1-faithilikerun@gmail.com>
 <20260601214405.252818-3-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jHI4xIGxuKK0mmth"
Content-Disposition: inline
In-Reply-To: <20260601214405.252818-3-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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


--jHI4xIGxuKK0mmth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 01, 2026 at 11:44:02PM +0200, Sam Li wrote:
> To configure the zoned format feature on the qcow2 driver, it
> requires settings as: the device size, zone model, zone size,
> zone capacity, number of conventional zones, limits on zone
> resources (max append bytes, max open zones, and max_active_zones).
>=20
> To create a qcow2 image with zoned format feature, use command like
> this:
> qemu-img create -f qcow2 zbc.qcow2 -o size=3D768M \
> -o zone.size=3D64M -o zone.capacity=3D64M -o zone.conventional_zones=3D0 \
> -o zone.max_append_bytes=3D4096 -o zone.max_open_zones=3D6 \
> -o zone.max_active_zones=3D8 -o zone.mode=3Dhost-managed
>=20
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> ---
>  block/file-posix.c               |   2 +-
>  block/qcow2.c                    | 329 ++++++++++++++++++++++++++++++-
>  block/qcow2.h                    |  83 +++++++-
>  docs/interop/qcow2.rst           | 117 ++++++++++-
>  include/block/block_int-common.h |  15 +-
>  qapi/block-core.json             |  91 ++++++++-
>  6 files changed, 628 insertions(+), 9 deletions(-)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index e49b13d6ab..14278785b9 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -3607,7 +3607,7 @@ raw_co_zone_append(BlockDriverState *bs,
> =20
>      if (*offset & zone_size_mask) {
>          error_report("sector offset %" PRId64 " is not aligned to zone s=
ize "
> -                     "%" PRId32 "", *offset / 512, bs->bl.zone_size / 51=
2);
> +                     "%" PRId64 "", *offset / 512, bs->bl.zone_size / 51=
2);
>          return -EINVAL;
>      }
> =20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 81fd299b4c..29eec33e34 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -73,6 +73,7 @@ typedef struct {
>  #define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
>  #define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
>  #define  QCOW2_EXT_MAGIC_DATA_FILE 0x44415441
> +#define  QCOW2_EXT_MAGIC_ZONED_FORMAT 0x007a6264
> =20
>  static int coroutine_fn
>  qcow2_co_preadv_compressed(BlockDriverState *bs,
> @@ -194,6 +195,93 @@ qcow2_extract_crypto_opts(QemuOpts *opts, const char=
 *fmt, Error **errp)
>      return cryptoopts_qdict;
>  }
> =20
> +/*
> + * Passing by the zoned device configurations by a zoned_header struct, =
check
> + * if the zone device options are under constraints. Return false when s=
ome
> + * option is invalid
> + */

I have trouble parsing the first sentence. Maybe replace this doc
comment with "Returns true if zone_opt is valid, false otherwise"?

> +static bool
> +qcow2_check_zone_options(Qcow2ZonedHeaderExtension *zone_opt, Error **er=
rp)
> +{
> +    uint32_t sequential_zones;
> +
> +    assert(zone_opt !=3D NULL);
> +
> +    if (zone_opt->zoned !=3D QCOW2_Z_NONE && zone_opt->zoned !=3D QCOW2_=
Z_HM) {
> +        error_setg(errp, "Zoned extension header zoned field has unknown=
 "
> +                   "value %" PRIu8, zone_opt->zoned);
> +        return false;
> +    }
> +
> +    if (!is_power_of_2(zone_opt->zone_size)) {
> +        error_setg(errp, "Zoned extension header zone_size %" PRIu64
> +                   "B is not a power of 2", zone_opt->zone_size);
> +        return false;
> +    }
> +
> +    if (zone_opt->nr_zones > UINT32_MAX / 8) {
> +        error_setg(errp, "Zoned extension header nr_zones %" PRIu32
> +                   " exceeds maximum %u",
> +                   zone_opt->nr_zones, UINT32_MAX / 8);
> +        return false;
> +    }
> +
> +    if (zone_opt->zone_capacity > zone_opt->zone_size) {
> +        error_setg(errp, "zone capacity %" PRIu64 "B exceeds zone size "
> +                   "%" PRIu64 "B", zone_opt->zone_capacity,
> +                   zone_opt->zone_size);
> +        return false;
> +    }
> +
> +    if (!QEMU_IS_ALIGNED(zone_opt->max_append_bytes, BDRV_SECTOR_SIZE)) {
> +        error_setg(errp, "max append bytes %" PRIu32 "B is not aligned "
> +                   "to %" PRIu64, zone_opt->max_append_bytes,
> +                   (uint64_t)BDRV_SECTOR_SIZE);
> +        return false;
> +    }
> +
> +    if (zone_opt->max_append_bytes + BDRV_SECTOR_SIZE >=3D
> +        zone_opt->zone_capacity) {
> +        error_setg(errp, "max append bytes %" PRIu32 "B exceeds zone "
> +                   "capacity %" PRIu64 "B by more than block size",
> +                   zone_opt->max_append_bytes, zone_opt->zone_capacity);
> +        return false;
> +    }
> +
> +    if (zone_opt->conventional_zones >=3D zone_opt->nr_zones) {
> +        error_setg(errp, "Conventional_zones %" PRIu32 " exceeds "
> +                   "nr_zones %" PRIu32 ".",
> +                   zone_opt->conventional_zones, zone_opt->nr_zones);
> +        return false;
> +    }
> +
> +    if (zone_opt->max_active_zones > zone_opt->nr_zones) {
> +        error_setg(errp, "Max_active_zones %" PRIu32 " exceeds "
> +                   "nr_zones %" PRIu32 ". Set it to nr_zones.",
> +                   zone_opt->max_active_zones, zone_opt->nr_zones);
> +        zone_opt->max_active_zones =3D zone_opt->nr_zones;
> +    }

errp is an error that must be handled by the caller, but the function
will return true. The caller may not notice the Error object and it may
be leaked.

Another issue with this approach is that error_setg(errp, "a");
error_setg(errp, "b"); is not allowed (see assert(*errp =3D=3D NULL) in
error_setv()). So if two of these conditionals are taken then QEMU will
abort.

I think the intention is to print a warning rather than to set an error
here. Use warn_report() without touching errp to avoid these issues.

> +
> +    sequential_zones =3D zone_opt->nr_zones - zone_opt->conventional_zon=
es;
> +    if (zone_opt->max_open_zones > sequential_zones) {
> +        error_setg(errp, "Max_open_zones field can not be larger than"
> +                   "the number of SWR zones. Set it to number of SWR"
> +                   "zones %" PRIu32 ".", sequential_zones);
> +        zone_opt->max_open_zones =3D sequential_zones;
> +    }
> +    if (zone_opt->max_active_zones !=3D 0 &&
> +        zone_opt->max_open_zones > zone_opt->max_active_zones) {
> +        error_setg(errp, "Max_open_zones %" PRIu32 " exceeds "
> +                   "max_active_zones %" PRIu32 ". Set it to "
> +                   "max_active_zones.",
> +                   zone_opt->max_open_zones,
> +                   zone_opt->max_active_zones);
> +        zone_opt->max_open_zones =3D zone_opt->max_active_zones;
> +    }
> +
> +    return true;
> +}
> +
>  /*
>   * read qcow2 extension and fill bs
>   * start reading from start_offset
> @@ -211,6 +299,7 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t =
start_offset,
>      uint64_t offset;
>      int ret;
>      Qcow2BitmapHeaderExt bitmaps_ext;
> +    Qcow2ZonedHeaderExtension zoned_ext;
> =20
>      if (need_update_header !=3D NULL) {
>          *need_update_header =3D false;
> @@ -432,6 +521,50 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t=
 start_offset,
>              break;
>          }
> =20
> +        case QCOW2_EXT_MAGIC_ZONED_FORMAT:
> +        {
> +            if (ext.len !=3D sizeof(zoned_ext)) {
> +                error_setg(errp, "zoned_ext: unexpected len=3D%" PRIu32 =
" "
> +                           "(expected %zu)", ext.len, sizeof(zoned_ext));
> +                return -EINVAL;
> +            }
> +            ret =3D bdrv_pread(bs->file, offset, ext.len, &zoned_ext, 0);
> +            if (ret < 0) {
> +                error_setg_errno(errp, -ret, "zoned_ext: "
> +                                 "Could not read ext header");
> +                return ret;
> +            }
> +
> +            zoned_ext.zone_size =3D be64_to_cpu(zoned_ext.zone_size);
> +            zoned_ext.zone_capacity =3D be64_to_cpu(zoned_ext.zone_capac=
ity);
> +            zoned_ext.conventional_zones =3D
> +                be32_to_cpu(zoned_ext.conventional_zones);
> +            zoned_ext.nr_zones =3D be32_to_cpu(zoned_ext.nr_zones);
> +            zoned_ext.max_open_zones =3D be32_to_cpu(zoned_ext.max_open_=
zones);
> +            zoned_ext.max_active_zones =3D
> +                be32_to_cpu(zoned_ext.max_active_zones);
> +            zoned_ext.max_append_bytes =3D
> +                be32_to_cpu(zoned_ext.max_append_bytes);
> +            s->zoned_header =3D zoned_ext;
> +
> +            /* refuse to open broken images */
> +            if (zoned_ext.nr_zones !=3D DIV_ROUND_UP(bs->total_sectors *
> +                BDRV_SECTOR_SIZE, zoned_ext.zone_size)) {

This is not safe when validating untrusted qcow2 files because
zoned_ext.zone_size could be 0 (division-by-zero kills the process) and
bs->total_sectors * BDRV_SECTOR_SIZE can integer overflow (unlikely
because the file would have to be extremely large).

Can you express this in a way that is safe? If necessary, split it into
multiple checks.

> +                error_setg(errp, "Zoned extension header nr_zones field "
> +                           "is wrong");
> +                return -EINVAL;
> +            }
> +            if (!qcow2_check_zone_options(&zoned_ext, errp)) {
> +                return -EINVAL;
> +            }
> +
> +#ifdef DEBUG_EXT
> +            printf("Qcow2: Got zoned format extension: "
> +                   "offset=3D%" PRIu32 "\n", offset);
> +#endif
> +            break;
> +        }
> +
>          default:
>              /* unknown magic - save it in case we need to rewrite the he=
ader */
>              /* If you add a new feature, make sure to also update the fa=
st
> @@ -2068,6 +2201,25 @@ static void qcow2_refresh_limits(BlockDriverState =
*bs, Error **errp)
>      }
>      bs->bl.pwrite_zeroes_alignment =3D s->subcluster_size;
>      bs->bl.pdiscard_alignment =3D s->cluster_size;
> +
> +    switch (s->zoned_header.zoned) {
> +    case QCOW2_Z_HM:
> +        bs->bl.zoned =3D BLK_Z_HM;
> +        break;
> +    case QCOW2_Z_NONE:
> +    default:
> +        bs->bl.zoned =3D BLK_Z_NONE;
> +        break;
> +    }
> +
> +    bs->bl.nr_zones =3D s->zoned_header.nr_zones;
> +    bs->bl.max_append_sectors =3D s->zoned_header.max_append_bytes
> +        >> BDRV_SECTOR_BITS;
> +    bs->bl.max_active_zones =3D s->zoned_header.max_active_zones;
> +    bs->bl.max_open_zones =3D s->zoned_header.max_open_zones;
> +    bs->bl.zone_size =3D s->zoned_header.zone_size;
> +    bs->bl.zone_capacity =3D s->zoned_header.zone_capacity;
> +    bs->bl.write_granularity =3D BDRV_SECTOR_SIZE;
>  }
> =20
>  static int GRAPH_UNLOCKED
> @@ -3170,6 +3322,11 @@ int qcow2_update_header(BlockDriverState *bs)
>                  .bit  =3D QCOW2_INCOMPAT_EXTL2_BITNR,
>                  .name =3D "extended L2 entries",
>              },
> +            {
> +                .type =3D QCOW2_FEAT_TYPE_INCOMPATIBLE,
> +                .bit  =3D QCOW2_INCOMPAT_ZONED_FORMAT_BITNR,
> +                .name =3D "zoned format",
> +            },
>              {
>                  .type =3D QCOW2_FEAT_TYPE_COMPATIBLE,
>                  .bit  =3D QCOW2_COMPAT_LAZY_REFCOUNTS_BITNR,
> @@ -3215,6 +3372,31 @@ int qcow2_update_header(BlockDriverState *bs)
>          buflen -=3D ret;
>      }
> =20
> +    /* Zoned devices header extension */
> +    if (s->zoned_header.zoned =3D=3D QCOW2_Z_HM) {
> +        Qcow2ZonedHeaderExtension zoned_header =3D {
> +            .zoned              =3D s->zoned_header.zoned,
> +            .zone_size          =3D cpu_to_be64(s->zoned_header.zone_siz=
e),
> +            .zone_capacity      =3D cpu_to_be64(s->zoned_header.zone_cap=
acity),
> +            .conventional_zones =3D
> +                cpu_to_be32(s->zoned_header.conventional_zones),
> +            .nr_zones           =3D cpu_to_be32(s->zoned_header.nr_zones=
),
> +            .max_open_zones     =3D cpu_to_be32(s->zoned_header.max_open=
_zones),
> +            .max_active_zones   =3D
> +                cpu_to_be32(s->zoned_header.max_active_zones),
> +            .max_append_bytes =3D
> +                cpu_to_be32(s->zoned_header.max_append_bytes)
> +        };
> +        ret =3D header_ext_add(buf, QCOW2_EXT_MAGIC_ZONED_FORMAT,
> +                             &zoned_header, sizeof(zoned_header),
> +                             buflen);
> +        if (ret < 0) {
> +            goto fail;
> +        }
> +        buf +=3D ret;
> +        buflen -=3D ret;
> +    }
> +
>      /* Keep unknown header extensions */
>      QLIST_FOREACH(uext, &s->unknown_header_ext, next) {
>          ret =3D header_ext_add(buf, uext->magic, uext->data, uext->len, =
buflen);
> @@ -3589,6 +3771,8 @@ qcow2_co_create(BlockdevCreateOptions *create_optio=
ns, Error **errp)
>      ERRP_GUARD();
>      BlockdevCreateOptionsQcow2 *qcow2_opts;
>      QDict *options;
> +    Qcow2ZoneCreateOptions *zone_struct;
> +    Qcow2ZoneHostManaged *zone_host_managed;
> =20
>      /*
>       * Open the image file and write a minimal qcow2 header.
> @@ -3615,6 +3799,8 @@ qcow2_co_create(BlockdevCreateOptions *create_optio=
ns, Error **errp)
> =20
>      assert(create_options->driver =3D=3D BLOCKDEV_DRIVER_QCOW2);
>      qcow2_opts =3D &create_options->u.qcow2;
> +    zone_struct =3D create_options->u.qcow2.zone;

A slightly more concise way of writing this:

  zone_struct =3D qcow2_opts->zone;

> +    zone_host_managed =3D &create_options->u.qcow2.zone->u.host_managed;

This must be moved down to avoid deferencing a NULL
create_options->u.qcow2.zone pointer:

  if (zone_struct && zone_struct->mode =3D=3D QCOW2_ZONE_MODEL_HOST_MANAGED=
) {
      Qcow2ZoneHostManaged *zone_host_managed =3D &zone_struct->u.host_mana=
ged;

--jHI4xIGxuKK0mmth
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmofNxEACgkQnKSrs4Gr
c8g+QggAk/4Jfd35/mlbptKyp5gFNO0nMXcZQQHYDOnqsBkYloedwjIcFzDkVC4v
OYWeJXLFlI+V0YdBwt5VpHLYSUc5mS7muj869juLrC+lW2y2CLFQsMioKvcMWToQ
Bupxq+mg+jLt+HS0+lA4ox6Ham19dCZKyJAETGr+mJ9NcjDNO1nHQjTN739dijQj
2znckS6ztPdE88WptjRm+YRPEq6LEaAgsM5qdh+buOvqZd+/h2ymkHS9VWoQynaO
n9PUZGbDQ7UCEEVUF5QieN+hNUShXnSwCTP08c7OlDRDPeFDU5SrTl6P5ce+scK9
GKBPfnh21UCKTly2px14B5teBHYCBg==
=bbke
-----END PGP SIGNATURE-----

--jHI4xIGxuKK0mmth--


