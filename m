Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8F5CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 19:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNc3c-0008Nb-46; Thu, 14 May 2026 15:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wNc3a-0008NF-Ho
 for qemu-devel@nongnu.org; Thu, 14 May 2026 15:49:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wNc3W-0008DW-7O
 for qemu-devel@nongnu.org; Thu, 14 May 2026 15:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778788152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=54TlfLjj32VaJniXecAFkPVEKVFMNj6LHINUEJeOksI=;
 b=L29GcFKQR0946mSAwYxC20uhRJGYu/UfQT9U75DZIxu4YzrKfbXkMjSO6gdil+GHAdBMkY
 gVjNSRi5xN4FXhmiDvq2zeNjz3zKBlxa4AugfHwDZAYhyvGD2cRqXVZD/ic30Jdw7UhH2S
 kMFuAV3BvGK05LkveovPFIEZmYnRQdA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-E7qFGyo7MK-lMAYWzwPaIw-1; Thu,
 14 May 2026 15:49:10 -0400
X-MC-Unique: E7qFGyo7MK-lMAYWzwPaIw-1
X-Mimecast-MFC-AGG-ID: E7qFGyo7MK-lMAYWzwPaIw_1778788149
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C276C195609F; Thu, 14 May 2026 19:49:08 +0000 (UTC)
Received: from localhost (unknown [10.2.17.3])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 248B518001D2; Thu, 14 May 2026 19:49:07 +0000 (UTC)
Date: Thu, 14 May 2026 15:49:06 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 dmitry.fomichev@wdc.com, Kevin Wolf <kwolf@redhat.com>,
 cassel@kernel.org, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, dlemoal@kernel.org, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, hare@suse.de,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v10 2/4] qcow2: add configurations for zoned format
 extension
Message-ID: <20260514194906.GC1535937@fedora>
References: <20260510175059.311814-1-faithilikerun@gmail.com>
 <20260510175059.311814-3-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v9DkBshOR2pUCoCf"
Content-Disposition: inline
In-Reply-To: <20260510175059.311814-3-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


--v9DkBshOR2pUCoCf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 07:50:57PM +0200, Sam Li wrote:
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
>  block/qcow2.c                    | 264 ++++++++++++++++++++++++++++++-
>  block/qcow2.h                    |  32 +++-
>  docs/interop/qcow2.rst           | 110 ++++++++++++-
>  include/block/block_int-common.h |  15 +-
>  qapi/block-core.json             |  70 +++++++-
>  6 files changed, 485 insertions(+), 8 deletions(-)
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
> index 81fd299b4c..b543bcf3e3 100644
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
> @@ -194,6 +195,74 @@ qcow2_extract_crypto_opts(QemuOpts *opts, const char=
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
> +static inline bool
> +qcow2_check_zone_options(Qcow2ZonedHeaderExtension *zone_opt, Error **er=
rp)
> +{
> +    if (zone_opt) {

The zone_opt =3D=3D NULL case never happens. Remove it to simplify the
function?

> +        uint32_t sequential_zones;
> +
> +        if (zone_opt->zone_size =3D=3D 0) {
> +            error_setg(errp, "Zoned extension header zone_size field "
> +                       "can not be 0");
> +            return false;
> +        }
> +
> +        if (zone_opt->zone_capacity > zone_opt->zone_size) {
> +            error_setg(errp, "zone capacity %" PRIu64 "B exceeds zone si=
ze "
> +                       "%" PRIu64 "B", zone_opt->zone_capacity,
> +                       zone_opt->zone_size);
> +            return false;
> +        }
> +
> +        if (zone_opt->max_append_bytes + BDRV_SECTOR_SIZE >=3D
> +            zone_opt->zone_capacity) {
> +            error_setg(errp, "max append bytes %" PRIu64 "B exceeds zone=
 "
> +                       "capacity %" PRIu32 "B by more than block size",
> +                       zone_opt->zone_capacity,
> +                       zone_opt->max_append_bytes);
> +            return false;
> +        }
> +
> +        if (zone_opt->conventional_zones >=3D zone_opt->nr_zones) {
> +            error_setg(errp, "Conventional_zones %" PRIu32 " exceeds "
> +                       "nr_zones %" PRIu32 ".",
> +                       zone_opt->conventional_zones, zone_opt->nr_zones);
> +            return false;
> +        }
> +
> +        if (zone_opt->max_active_zones > zone_opt->nr_zones) {
> +            error_setg(errp, "Max_active_zones %" PRIu32 " exceeds "
> +                       "nr_zones %" PRIu32 ". Set it to nr_zones.",
> +                       zone_opt->max_active_zones, zone_opt->nr_zones);
> +            zone_opt->max_active_zones =3D zone_opt->nr_zones;
> +        }
> +
> +        sequential_zones =3D zone_opt->nr_zones - zone_opt->conventional=
_zones;
> +        if (zone_opt->max_open_zones > sequential_zones) {
> +            error_setg(errp, "Max_open_zones field can not be larger tha=
n"
> +                       "the number of SWR zones. Set it to number of SWR"
> +                       "zones %" PRIu32 ".", sequential_zones);
> +            zone_opt->max_open_zones =3D sequential_zones;
> +        }
> +        if (zone_opt->max_open_zones > zone_opt->max_active_zones) {
> +            error_setg(errp, "Max_open_zones %" PRIu32 " exceeds "
> +                       "max_active_zones %" PRIu32 ". Set it to "
> +                       "max_active_zones.",
> +                       zone_opt->max_open_zones,
> +                       zone_opt->max_active_zones);
> +            zone_opt->max_open_zones =3D zone_opt->max_active_zones;
> +        }
> +
> +        return true;
> +    }
> +    return false;
> +}
> +
>  /*
>   * read qcow2 extension and fill bs
>   * start reading from start_offset
> @@ -211,6 +280,7 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t =
start_offset,
>      uint64_t offset;
>      int ret;
>      Qcow2BitmapHeaderExt bitmaps_ext;
> +    Qcow2ZonedHeaderExtension zoned_ext;
> =20
>      if (need_update_header !=3D NULL) {
>          *need_update_header =3D false;
> @@ -432,6 +502,51 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t=
 start_offset,
>              break;
>          }
> =20
> +        case QCOW2_EXT_MAGIC_ZONED_FORMAT:
> +        {
> +            if (ext.len < sizeof(zoned_ext)) {

Should this be ext.len !=3D sizeof(zoned_ext)?

> +                /* Missing fields */
> +                error_setg(errp, "zoned_ext: len=3D%" PRIu32 " too small=
 "
> +                           "(<%zu)", ext.len, sizeof(zoned_ext));
> +                return -EINVAL;
> +            }
> +            ret =3D bdrv_pread(bs->file, offset, ext.len, &zoned_ext, 0);

=2E..otherwise we cannot read ext.len bytes into &zoned_ext because it
could overflow.

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
> @@ -2068,6 +2183,15 @@ static void qcow2_refresh_limits(BlockDriverState =
*bs, Error **errp)
>      }
>      bs->bl.pwrite_zeroes_alignment =3D s->subcluster_size;
>      bs->bl.pdiscard_alignment =3D s->cluster_size;
> +    bs->bl.zoned =3D s->zoned_header.zoned;

Let's avoid the assumption that qcow2 file format constants are
identical to internal QEMU block layer API constants (see more on this
below). This will need to translate from the qcow2 zoned header
host-managed constant to the QEMU block layer constant.

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
> @@ -3170,6 +3294,11 @@ int qcow2_update_header(BlockDriverState *bs)
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
> @@ -3215,6 +3344,31 @@ int qcow2_update_header(BlockDriverState *bs)
>          buflen -=3D ret;
>      }
> =20
> +    /* Zoned devices header extension */
> +    if (s->zoned_header.zoned =3D=3D BLK_Z_HM) {
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
> @@ -3589,6 +3743,8 @@ qcow2_co_create(BlockdevCreateOptions *create_optio=
ns, Error **errp)
>      ERRP_GUARD();
>      BlockdevCreateOptionsQcow2 *qcow2_opts;
>      QDict *options;
> +    Qcow2ZoneCreateOptions *zone_struct;
> +    Qcow2ZoneHostManaged *zone_host_managed;
> =20
>      /*
>       * Open the image file and write a minimal qcow2 header.
> @@ -3615,6 +3771,8 @@ qcow2_co_create(BlockdevCreateOptions *create_optio=
ns, Error **errp)
> =20
>      assert(create_options->driver =3D=3D BLOCKDEV_DRIVER_QCOW2);
>      qcow2_opts =3D &create_options->u.qcow2;
> +    zone_struct =3D create_options->u.qcow2.zone;
> +    zone_host_managed =3D &create_options->u.qcow2.zone->u.host_managed;
> =20
>      bs =3D bdrv_co_open_blockdev_ref(qcow2_opts->file, errp);
>      if (bs =3D=3D NULL) {
> @@ -3828,6 +3986,14 @@ qcow2_co_create(BlockdevCreateOptions *create_opti=
ons, Error **errp)
>          header->incompatible_features |=3D
>              cpu_to_be64(QCOW2_INCOMPAT_DATA_FILE);
>      }
> +    if (zone_struct && zone_struct->mode =3D=3D QCOW2_ZONE_MODEL_HOST_MA=
NAGED) {
> +        /*
> +         * The incompatible bit must be set when the zone model is
> +         * host-managed
> +         */
> +        header->incompatible_features |=3D
> +            cpu_to_be64(QCOW2_INCOMPAT_ZONED_FORMAT);
> +    }
>      if (qcow2_opts->data_file_raw) {
>          header->autoclear_features |=3D
>              cpu_to_be64(QCOW2_AUTOCLEAR_DATA_FILE_RAW);
> @@ -3885,10 +4051,9 @@ qcow2_co_create(BlockdevCreateOptions *create_opti=
ons, Error **errp)
>      bdrv_graph_co_rdlock();
>      ret =3D qcow2_alloc_clusters(blk_bs(blk), 3 * cluster_size);
>      if (ret < 0) {
> -        bdrv_graph_co_rdunlock();
>          error_setg_errno(errp, -ret, "Could not allocate clusters for qc=
ow2 "
>                           "header and refcount table");
> -        goto out;
> +        goto unlock;
> =20
>      } else if (ret !=3D 0) {
>          error_report("Huh, first cluster in empty image is already in us=
e?");
> @@ -3896,11 +4061,62 @@ qcow2_co_create(BlockdevCreateOptions *create_opt=
ions, Error **errp)
>      }
> =20
>      /* Set the external data file if necessary */
> +    BDRVQcow2State *s =3D blk_bs(blk)->opaque;
>      if (data_bs) {
> -        BDRVQcow2State *s =3D blk_bs(blk)->opaque;
>          s->image_data_file =3D g_strdup(data_bs->filename);
>      }
> =20
> +    if (zone_struct && zone_struct->mode =3D=3D QCOW2_ZONE_MODEL_HOST_MA=
NAGED) {
> +        s->zoned_header.zoned =3D BLK_Z_HM;

BLK_Z_HM is a QEMU block layer constant while zoned_header.zoned is a
qcow2 file format field. Please do not mix the two, even if the constant
values are identical. Instead, define a constant for host-manager (1) in
block/qcow2.h and use that. This ensures that QEMU's interval constant
values can be changed in the future and are not tied to the qcow2 file
format.

> +
> +        if (!zone_host_managed->has_size) {
> +            s->zoned_header.zone_size =3D DEFAULT_ZONE_SIZE;
> +        } else {
> +            s->zoned_header.zone_size =3D zone_host_managed->size;
> +        }
> +        s->zoned_header.nr_zones =3D DIV_ROUND_UP(qcow2_opts->size,
> +                                                s->zoned_header.zone_siz=
e);
> +
> +        if (zone_host_managed->has_capacity) {
> +            s->zoned_header.zone_capacity =3D zone_host_managed->capacit=
y;
> +        } else {
> +            s->zoned_header.zone_capacity =3D s->zoned_header.zone_size;
> +        }
> +
> +        if (zone_host_managed->has_conventional_zones) {
> +            s->zoned_header.conventional_zones =3D
> +                zone_host_managed->conventional_zones;
> +        }
> +
> +        if (zone_host_managed->has_max_active_zones) {
> +            s->zoned_header.max_active_zones =3D
> +                zone_host_managed->max_active_zones;
> +
> +            if (zone_host_managed->has_max_open_zones) {
> +                s->zoned_header.max_open_zones =3D
> +                    zone_host_managed->max_open_zones;
> +            } else {
> +                s->zoned_header.max_open_zones =3D
> +                    zone_host_managed->max_active_zones;
> +            }
> +        }
> +
> +        if (zone_host_managed->has_max_append_bytes) {
> +            s->zoned_header.max_append_bytes =3D
> +                    zone_host_managed->max_append_bytes;
> +        } else {
> +            s->zoned_header.max_append_bytes =3D DEFAULT_MAX_APPEND_BYTE=
S;
> +        }
> +
> +        if (!qcow2_check_zone_options(&s->zoned_header, errp)) {
> +            s->zoned_header.zoned =3D BLK_Z_NONE;
> +            ret =3D -EINVAL;
> +            goto unlock;
> +        }
> +    } else {
> +        s->zoned_header.zoned =3D BLK_Z_NONE;
> +    }
> +
>      /* Create a full header (including things like feature table) */
>      ret =3D qcow2_update_header(blk_bs(blk));
>      bdrv_graph_co_rdunlock();
> @@ -3974,6 +4190,9 @@ qcow2_co_create(BlockdevCreateOptions *create_optio=
ns, Error **errp)
>      }
> =20
>      ret =3D 0;
> +    goto out;
> +unlock:
> +    bdrv_graph_co_rdunlock();
>  out:
>      blk_co_unref(blk);
>      bdrv_co_unref(bs);
> @@ -4052,6 +4271,10 @@ qcow2_co_create_opts(BlockDriver *drv, const char =
*filename, QemuOpts *opts,
>          { BLOCK_OPT_COMPAT_LEVEL,       "version" },
>          { BLOCK_OPT_DATA_FILE_RAW,      "data-file-raw" },
>          { BLOCK_OPT_COMPRESSION_TYPE,   "compression-type" },
> +        { BLOCK_OPT_CONVENTIONAL_ZONES, "zone.conventional-zones" },
> +        { BLOCK_OPT_MAX_OPEN_ZONES,     "zone.max-open-zones" },
> +        { BLOCK_OPT_MAX_ACTIVE_ZONES,   "zone.max-active-zones" },
> +        { BLOCK_OPT_MAX_APPEND_BYTES,   "zone.max-append-bytes" },
>          { NULL, NULL },
>      };
> =20
> @@ -6265,6 +6488,41 @@ static QemuOptsList qcow2_create_opts =3D {
>              .type =3D QEMU_OPT_BOOL,                                    =
  \
>              .help =3D "Assume the external data file already exists and =
" \
>                      "do not overwrite it"                               \
> +        },                                                              \
> +        {                                                               \
> +            .name =3D BLOCK_OPT_ZONE_MODEL,                             =
  \
> +            .type =3D QEMU_OPT_STRING,                                  =
  \
> +            .help =3D "zone model modes, mode choice: host-managed",    =
  \
> +        },                                                              \
> +        {                                                               \
> +            .name =3D BLOCK_OPT_ZONE_SIZE,                              =
  \
> +            .type =3D QEMU_OPT_SIZE,                                    =
  \
> +            .help =3D "zone size",                                      =
  \
> +        },                                                              \
> +        {                                                               \
> +            .name =3D BLOCK_OPT_ZONE_CAPACITY,                          =
  \
> +            .type =3D QEMU_OPT_SIZE,                                    =
  \
> +            .help =3D "zone capacity",                                  =
  \
> +        },                                                              \
> +        {                                                               \
> +            .name =3D BLOCK_OPT_CONVENTIONAL_ZONES,                     =
  \
> +            .type =3D QEMU_OPT_NUMBER,                                  =
  \
> +            .help =3D "numbers of conventional zones",                  =
  \
> +        },                                                              \
> +        {                                                               \
> +            .name =3D BLOCK_OPT_MAX_APPEND_BYTES,                       =
  \
> +            .type =3D QEMU_OPT_SIZE,                                    =
  \
> +            .help =3D "max append bytes",                               =
  \
> +        },                                                              \
> +        {                                                               \
> +            .name =3D BLOCK_OPT_MAX_ACTIVE_ZONES,                       =
  \
> +            .type =3D QEMU_OPT_NUMBER,                                  =
  \
> +            .help =3D "max active zones",                               =
  \
> +        },                                                              \
> +        {                                                               \
> +            .name =3D BLOCK_OPT_MAX_OPEN_ZONES,                         =
  \
> +            .type =3D QEMU_OPT_NUMBER,                                  =
  \
> +            .help =3D "max open zones",                                 =
  \
>          },
>          QCOW_COMMON_OPTIONS,
>          { /* end of list */ }
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 192a45d596..743f2e3e79 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -129,6 +129,9 @@
> =20
>  #define DEFAULT_CLUSTER_SIZE 65536
> =20
> +#define DEFAULT_ZONE_SIZE (256 * MiB)
> +#define DEFAULT_MAX_APPEND_BYTES (64 * KiB)

DEFAULT_ZONE_MAX_APPEND_BYTES would make it clear that this constant is
related to zones.

> +
>  #define QCOW2_OPT_DATA_FILE "data-file"
>  #define QCOW2_OPT_LAZY_REFCOUNTS "lazy-refcounts"
>  #define QCOW2_OPT_DISCARD_REQUEST "pass-discard-request"
> @@ -237,6 +240,27 @@ typedef struct Qcow2CryptoHeaderExtension {
>      uint64_t length;
>  } QEMU_PACKED Qcow2CryptoHeaderExtension;
> =20
> +typedef struct Qcow2ZonedHeaderExtension {
> +    /* Zoned device attributes */
> +    uint8_t zoned;
> +    uint8_t reserved[3];

I suggest padding to natural alignment so there is no need to worry
about misaligned loads/stores:

  uint8_t reserved[7];

> +    uint64_t zone_size;
> +    uint64_t zone_capacity;
> +    uint32_t conventional_zones;
> +    uint32_t nr_zones;
> +    uint32_t max_active_zones;
> +    uint32_t max_open_zones;
> +    uint32_t max_append_bytes;
> +    uint64_t zonedmeta_size;
> +    uint64_t zonedmeta_offset;
> +} QEMU_PACKED Qcow2ZonedHeaderExtension;
> +
> +typedef struct Qcow2ZoneListEntry {
> +    QLIST_ENTRY(Qcow2ZoneListEntry) exp_open_zone_entry;
> +    QLIST_ENTRY(Qcow2ZoneListEntry) imp_open_zone_entry;
> +    QLIST_ENTRY(Qcow2ZoneListEntry) closed_zone_entry;
> +} Qcow2ZoneListEntry;
> +
>  typedef struct Qcow2UnknownHeaderExtension {
>      uint32_t magic;
>      uint32_t len;
> @@ -257,17 +281,20 @@ enum {
>      QCOW2_INCOMPAT_DATA_FILE_BITNR  =3D 2,
>      QCOW2_INCOMPAT_COMPRESSION_BITNR =3D 3,
>      QCOW2_INCOMPAT_EXTL2_BITNR      =3D 4,
> +    QCOW2_INCOMPAT_ZONED_FORMAT_BITNR =3D 5,
>      QCOW2_INCOMPAT_DIRTY            =3D 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
>      QCOW2_INCOMPAT_CORRUPT          =3D 1 << QCOW2_INCOMPAT_CORRUPT_BITN=
R,
>      QCOW2_INCOMPAT_DATA_FILE        =3D 1 << QCOW2_INCOMPAT_DATA_FILE_BI=
TNR,
>      QCOW2_INCOMPAT_COMPRESSION      =3D 1 << QCOW2_INCOMPAT_COMPRESSION_=
BITNR,
>      QCOW2_INCOMPAT_EXTL2            =3D 1 << QCOW2_INCOMPAT_EXTL2_BITNR,
> +    QCOW2_INCOMPAT_ZONED_FORMAT     =3D 1 << QCOW2_INCOMPAT_ZONED_FORMAT=
_BITNR,
> =20
>      QCOW2_INCOMPAT_MASK             =3D QCOW2_INCOMPAT_DIRTY
>                                      | QCOW2_INCOMPAT_CORRUPT
>                                      | QCOW2_INCOMPAT_DATA_FILE
>                                      | QCOW2_INCOMPAT_COMPRESSION
> -                                    | QCOW2_INCOMPAT_EXTL2,
> +                                    | QCOW2_INCOMPAT_EXTL2
> +                                    | QCOW2_INCOMPAT_ZONED_FORMAT,
>  };
> =20
>  /* Compatible feature bits */
> @@ -426,6 +453,9 @@ typedef struct BDRVQcow2State {
>       * is to convert the image with the desired compression type set.
>       */
>      Qcow2CompressionType compression_type;
> +
> +    /* States of zoned device */
> +    Qcow2ZonedHeaderExtension zoned_header;
>  } BDRVQcow2State;
> =20
>  typedef struct Qcow2COWRegion {
> diff --git a/docs/interop/qcow2.rst b/docs/interop/qcow2.rst
> index 5948591107..7bf3a00e77 100644
> --- a/docs/interop/qcow2.rst
> +++ b/docs/interop/qcow2.rst
> @@ -128,7 +128,26 @@ the next fields through ``header_length``.
>                                  allows subcluster-based allocation. See =
the
>                                  Extended L2 Entries section for more det=
ails.
> =20
> -                    Bits 5-63:  Reserved (set to 0)
> +                    Bit 5:      Zoned extension bit. If this bit is set =
then
> +                                the file is an emulated zoned device. The
> +                                zoned extension must be present.
> +                                Implementations that do not support zoned
> +                                emulation cannot open this file because =
it
> +                                generally only make sense to interpret t=
he
> +                                data along with the zone information and
> +                                write pointers.
> +
> +                                It is unsafe when any qcow2 user without
> +                                knowing the zoned extension reads or edi=
ts
> +                                a file with the zoned extension. The wri=
te
> +                                pointer tracking can be corrupted when a
> +                                writer edits a file, like overwriting be=
yond
> +                                the write pointer locations. Or a reader=
 tries
> +                                to access a file without knowing write
> +                                pointers where the software setup will c=
ause
> +                                invalid reads.
> +
> +                    Bits 6-63:  Reserved (set to 0)
> =20
>           80 -  87:  compatible_features
>                      Bitmask of compatible features. An implementation can
> @@ -259,6 +278,7 @@ be stored. Each extension has a structure like the fo=
llowing::
>                          0x23852875 - Bitmaps extension
>                          0x0537be77 - Full disk encryption header pointer
>                          0x44415441 - External data file name string
> +                        0x007a6264 - Zoned extension
>                          other      - Unknown header extension, can be sa=
fely
>                                       ignored
> =20
> @@ -344,6 +364,94 @@ The fields of the bitmaps extension are::
>                     Offset into the image file at which the bitmap direct=
ory
>                     starts. Must be aligned to a cluster boundary.
> =20
> +Zoned extension
> +---------------
> +
> +The zoned extension must be present if the incompatible bit is set, and
> +omitted when the incompatible bit is clear. It contains fields for

The first sentence is a little vague about the "incompatible bit".
Either saying "the corresponding incompatible bit" or
"incompatible_features bit 5" is more specific and gives the reader an
indication that they need to look for a specific bit.

> +emulating the zoned storage model (https://zonedstorage.io/). When the
> +zone model mode is not host-managed, it is regarded as incompatible
> +and reports an error to users.

This sentence is unnecessary because the same information is repeated in
the zoned field description below. I suggest removing it since the zoned
field description provides more context, but if you want you could
replace it with something like:

  Currently only the host-managed zone model is supported.

> +
> +The write pointers for each zone are stored in an area called zonedmeta
> +clusters. It is 8 bytes per zone. The offset and size of the zonedmeta

Slightly more descriptive:

"It is 8 bytes per zone" -> "The zonedmeta clusters contain a table of
the zone write pointers. Each entry is 8 bytes."

> +are kept in the zoned extension header.
> +
> +The fields of the zoned extension are::
> +
> +    Byte       0:  zoned
> +                   The byte represents the zoned model of the device. 0 =
is for
> +                   a non-zoned device (all other information in this hea=
der
> +                   is ignored). 1 is for a host-managed device, which on=
ly
> +                   allows for sequential writes within each zone. Other
> +                   values may be added later, the implementation must re=
fuse
> +                   to open a device containing an unknown zone model.
> +
> +          1 -  3:  Reserved, must be zero.
> +
> +          4 -  11: zone_size
> +                   Total size of each zone, in bytes. The 64-bit field i=
s to
> +                   satisfy the virtio-blk zone_size range and emulate a =
read
> +                   zoned device, whose maximum zone size can be as large=
 as
> +                   2TB.
> +
> +                   The value must be power of 2. Linux currently requires
> +                   the zone size to be a power of 2 number of LBAs. Qcow2
> +                   following this is mainly to allow emulating a real
> +                   ZNS drive configuration. It is not relevant to the cl=
uster
> +                   size.
> +
> +          12 - 19: zone_capacity
> +                   The number of writable bytes within the zones. The by=
tes
> +                   between zone capacity and zone size are unusable: rea=
ds
> +                   will return 0s and writes will fail.
> +
> +                   A zone capacity is always smaller or equal to the zone
> +                   size. It is for emulating a real ZNS drive configurat=
ion,
> +                   which has the constraint of aligning to some hardware=
 erase
> +                   block size.
> +
> +         20 - 23:  conventional_zones
> +                   The number of conventional zones. The conventional zo=
nes
> +                   allow sequential writes and random writes. While the
> +                   sequential zones only allow sequential writes.
> +
> +         24 - 27:  nr_zones
> +                   The number of zones. It is the sum of conventional zo=
nes
> +                   and sequential zones. The maximum value for nr_zones =
is
> +                   (2^32 - 1)/8 =3D 536870911.
> +
> +         28 - 31:  max_active_zones
> +                   The number of the zones that can be in the implicit o=
pen,
> +                   explicit open or closed state. The max active zones c=
annot
> +                   be larger than the max open zones.
> +
> +         32 - 35:  max_open_zones
> +                   The maximal number of open (implicitly open or explic=
itly
> +                   open) zones. It cannot be larger than the number of S=
WR
> +                   zones of the device.
> +
> +                   If the limits of open zones or active zones are equal=
 to
> +                   the total number of SWR zones, then it's the same as =
having
> +                   no limits therefore max open zones and max active zon=
es are
> +                   set to 0.
> +
> +         36 - 39:  max_append_bytes
> +                   The number of bytes of a zone append request that can=
 be
> +                   issued to the device. It must be 512-byte aligned and=
 less
> +                   than the zone capacity.
> +
> +         40 - 47:  zonedmeta_size
> +                   The size of zoned metadata in bytes. It contains no m=
ore
> +                   than 4GB. The zoned metadata structure is the write
> +                   pointers for each zone whose size is the number of zo=
nes
> +                   multiplied by the zone size.

I can't parse the last sentence. Is this field necessary since there is
already a nr_zones field?

> +
> +         48 - 55:  zonedmeta_offset
> +                   The offset of zoned metadata structure in the contain=
ed
> +                   image, in bytes.

Do you want to say anything about the order in which metadata is
persisted to disk when zones used? I guess the data is written into the
image file first, then the non-zoned qcow2 L1/L2/refcount metadata is
updated, and finally the write pointer is written. Write pointers are
not guaranteed to be updated on disk until the write request followed by
a flush request are both completed.

(The idea is that the data must be visible in the qcow2 file before it
is safe to update the write pointer. Otherwise a power failure would
leave the file in an inconsistent state where the write pointer has
advanced but the data was not written.)

>  Full disk encryption header pointer
>  -----------------------------------
> =20
> diff --git a/include/block/block_int-common.h b/include/block/block_int-c=
ommon.h
> index 147c08155f..349876bc65 100644
> --- a/include/block/block_int-common.h
> +++ b/include/block/block_int-common.h
> @@ -57,6 +57,13 @@
>  #define BLOCK_OPT_COMPRESSION_TYPE  "compression_type"
>  #define BLOCK_OPT_EXTL2             "extended_l2"
>  #define BLOCK_OPT_KEEP_DATA_FILE    "keep_data_file"
> +#define BLOCK_OPT_ZONE_MODEL        "zone.mode"
> +#define BLOCK_OPT_ZONE_SIZE         "zone.size"
> +#define BLOCK_OPT_ZONE_CAPACITY     "zone.capacity"
> +#define BLOCK_OPT_CONVENTIONAL_ZONES    "zone.conventional_zones"
> +#define BLOCK_OPT_MAX_APPEND_BYTES      "zone.max_append_bytes"
> +#define BLOCK_OPT_MAX_ACTIVE_ZONES      "zone.max_active_zones"
> +#define BLOCK_OPT_MAX_OPEN_ZONES        "zone.max_open_zones"
> =20
>  #define BLOCK_PROBE_BUF_SIZE        512
> =20
> @@ -901,7 +908,13 @@ typedef struct BlockLimits {
>      BlockZoneModel zoned;
> =20
>      /* zone size expressed in bytes */
> -    uint32_t zone_size;
> +    uint64_t zone_size;
> +
> +    /*
> +     * The number of usable logical blocks within the zone, expressed
> +     * in bytes. A zone capacity is smaller or equal to the zone size.
> +     */
> +    uint64_t zone_capacity;
> =20
>      /* total number of zones */
>      uint32_t nr_zones;
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 508b081ac1..d771dfb4a1 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -5268,6 +5268,70 @@
>  { 'enum': 'Qcow2CompressionType',
>    'data': [ 'zlib', { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
> =20
> +##
> +# @Qcow2ZoneModel:
> +#
> +# Zoned device model used in qcow2 image file
> +#
> +# @host-managed: The host-managed model only allows sequential write
> +#     over the device zones.
> +#
> +# Since 11.0
> +##
> +{ 'enum': 'Qcow2ZoneModel',
> +  'data': [ 'host-managed'] }
> +
> +##
> +# @Qcow2ZoneHostManaged:
> +#
> +# The host-managed zone model.  It only allows sequential writes.
> +#
> +# @size: Total number of bytes within zones (default 256 MB).
> +#
> +# @capacity: The number of usable logical blocks within zones
> +#     in bytes.  A zone capacity is always smaller or equal to the
> +#     zone size (default to zone size).
> +#
> +# @conventional-zones: The number of conventional zones of the
> +#     zoned device (default 0).
> +#
> +# @max-open-zones: The maximal number of open zones.  It is less than
> +#     or equal to the number of sequential write required zones of
> +#     the device (default 0).
> +#
> +# @max-active-zones: The maximal number of zones in the implicit
> +#     open, explicit open or closed state.  It is less than or equal
> +#     to the max open zones (default 0).
> +#
> +# @max-append-bytes: The maximal number of bytes of a zone
> +#     append request that can be issued to the device.  It must be
> +#     512-byte aligned and less than the zone capacity
> +#     (default 64 KB).
> +#
> +# Since 11.0
> +##
> +{ 'struct': 'Qcow2ZoneHostManaged',
> +  'data': { '*size':          'size',
> +            '*capacity':      'size',
> +            '*conventional-zones': 'uint32',
> +            '*max-open-zones':     'uint32',
> +            '*max-active-zones':   'uint32',
> +            '*max-append-bytes':   'size' } }
> +
> +##
> +# @Qcow2ZoneCreateOptions:
> +#
> +# The zone device model for the qcow2 image.
> +#
> +# @mode: The zone device model modes.
> +#
> +# Since 11.0
> +##
> +{ 'union': 'Qcow2ZoneCreateOptions',
> +  'base': { 'mode': 'Qcow2ZoneModel' },
> +  'discriminator': 'mode',
> +  'data': { 'host-managed': 'Qcow2ZoneHostManaged' } }
> +
>  ##
>  # @BlockdevCreateOptionsQcow2:
>  #
> @@ -5310,6 +5374,9 @@
>  # @compression-type: The image cluster compression method
>  #     (default: zlib, since 5.1)
>  #
> +# @zone: The zone device model modes.  The default is that the
> +#     device is not zoned.  (since 11.0)
> +#
>  # Since: 2.12
>  ##
>  { 'struct': 'BlockdevCreateOptionsQcow2',
> @@ -5326,7 +5393,8 @@
>              '*preallocation':   'PreallocMode',
>              '*lazy-refcounts':  'bool',
>              '*refcount-bits':   'int',
> -            '*compression-type':'Qcow2CompressionType' } }
> +            '*compression-type':'Qcow2CompressionType',
> +            '*zone':            'Qcow2ZoneCreateOptions' } }
> =20
>  ##
>  # @BlockdevCreateOptionsQed:
> --=20
> 2.43.0
>=20

--v9DkBshOR2pUCoCf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoGJzIACgkQnKSrs4Gr
c8jdlwf/Ye70ngqmYkPy9akNuJbOOnxwyC9Mh69O7gGHKXDQ+a20hjIN0UNBv6dl
RQtu0Aeks3F9IuYyUo1YqKnG2pOZljk7Y8zi5jWxSfmKrH1I/pUALW5xdlJCjFe1
+3kQCowDOOOSaeTu8VUgEQ3vlxuNksu7Ky/ipB4lOOwx3gJ8KP++0nr/VjkyxbSj
/t1hwbcq51QatvCW7S0rBkctNMVbr0LhMGnsoCaJU6+U3LpCdbLe7opNwgNyzA1R
k5hW7YO27OkqGVJk2syUYVWWfwYvFPIV518qO6Ep+G6u9O9XIHjAnVaOEnMrMaDd
Suk8ovaEpwO+o6l5EAu8xziAmjr5/w==
=k6W8
-----END PGP SIGNATURE-----

--v9DkBshOR2pUCoCf--


