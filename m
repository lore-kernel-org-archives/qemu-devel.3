Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3DEC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 15:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3gH-0005Qz-El; Tue, 12 Mar 2024 11:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rk3gF-0005QZ-Vy
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:04:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rk3gC-0003xS-9M
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710255874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HfWXPz7ak1cexfRVh3vC2l/dTH9SVHXBV7BUyoRCyG0=;
 b=Xm4uCsqWejDyAGiq+qYaNOAmbsVWHC40z2QJEicD1T5gR0KijGRTtBJUbPiePe56cP3iu4
 4N0WjJ7p3xvkrFgJEaZkX0oLXM5bVlXw3y6KSoiyhQWMZlEcqAwMn14GwzZdkCLeB/zn7R
 rkKPzCcc2UvdxSCprxkLQggFIWqSF3s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-FzlFRfFSP9WtuuIjqMp76A-1; Tue,
 12 Mar 2024 11:04:31 -0400
X-MC-Unique: FzlFRfFSP9WtuuIjqMp76A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95AF82823F74;
 Tue, 12 Mar 2024 15:04:14 +0000 (UTC)
Received: from localhost (unknown [10.39.194.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A38DB40C6DAD;
 Tue, 12 Mar 2024 15:04:13 +0000 (UTC)
Date: Tue, 12 Mar 2024 11:04:12 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, dlemoal@kernel.org,
 Hanna Reitz <hreitz@redhat.com>, dmitry.fomichev@wdc.com,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, hare@suse.de,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v7 2/4] qcow2: add configurations for zoned format
 extension
Message-ID: <20240312150412.GA389553@fedora>
References: <20240122184830.40094-1-faithilikerun@gmail.com>
 <20240122184830.40094-3-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pe5MYVF059pjisCq"
Content-Disposition: inline
In-Reply-To: <20240122184830.40094-3-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--pe5MYVF059pjisCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 07:48:28PM +0100, Sam Li wrote:
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
>  block/qcow2.c                    | 252 ++++++++++++++++++++++++++++++-
>  block/qcow2.h                    |  36 ++++-
>  docs/interop/qcow2.txt           | 107 ++++++++++++-
>  include/block/block_int-common.h |  13 ++
>  qapi/block-core.json             |  67 +++++++-
>  5 files changed, 469 insertions(+), 6 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 9bee66fff5..b987f1e751 100644
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
> @@ -194,6 +195,68 @@ qcow2_extract_crypto_opts(QemuOpts *opts, const char=
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
> +qcow2_check_zone_options(Qcow2ZonedHeaderExtension *zone_opt)
> +{
> +    if (zone_opt) {
> +        uint32_t sequential_zones;
> +
> +        if (zone_opt->zone_size =3D=3D 0) {
> +            error_report("Zoned extension header zone_size field "
> +                         "can not be 0");

Please add an Error **errp argument to qcow2_check_zone_options() and
use error_setg() instead of calling error_report(). That way the caller
can decide how to print or propagate error messages.

> +            return false;
> +        }
> +
> +        if (zone_opt->zone_capacity > zone_opt->zone_size) {
> +            error_report("zone capacity %" PRIu32 "B exceeds zone size "
> +                         "%" PRIu32 "B", zone_opt->zone_capacity,
> +                         zone_opt->zone_size);
> +            return false;
> +        }
> +
> +        if (zone_opt->max_append_bytes + BDRV_SECTOR_SIZE >=3D
> +            zone_opt->zone_capacity) {
> +            error_report("max append bytes %" PRIu32 "B exceeds zone "
> +                         "capacity %" PRIu32 "B by more than block size",
> +                         zone_opt->zone_capacity,
> +                         zone_opt->max_append_bytes);
> +            return false;
> +        }
> +
> +        if (zone_opt->max_active_zones > zone_opt->nr_zones) {
> +            error_report("Max_active_zones %" PRIu32 " exceeds "
> +                         "nr_zones %" PRIu32 ". Set it to nr_zones.",
> +                         zone_opt->max_active_zones, zone_opt->nr_zones);
> +            zone_opt->max_active_zones =3D zone_opt->nr_zones;
> +        }
> +
> +        if (zone_opt->max_open_zones > zone_opt->max_active_zones) {
> +            error_report("Max_open_zones %" PRIu32 " exceeds "
> +                         "max_active_zones %" PRIu32 ". Set it to "
> +                         "max_active_zones.",
> +                         zone_opt->max_open_zones,
> +                         zone_opt->max_active_zones);
> +            zone_opt->max_open_zones =3D zone_opt->max_active_zones;
> +        }
> +
> +        sequential_zones =3D zone_opt->nr_zones - zone_opt->conventional=
_zones;
> +        if (zone_opt->max_open_zones > sequential_zones) {

Please check that conventional_zones < zone_opt->nr_zones first to avoid
integer underflow.

> +            error_report("Max_open_zones field can not be larger "
> +                         "than the number of SWR zones. Set it to number=
 of "
> +                         "SWR zones %" PRIu32 ".", sequential_zones);
> +            zone_opt->max_open_zones =3D sequential_zones;
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
> @@ -211,6 +274,7 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t =
start_offset,
>      uint64_t offset;
>      int ret;
>      Qcow2BitmapHeaderExt bitmaps_ext;
> +    Qcow2ZonedHeaderExtension zoned_ext;
> =20
>      if (need_update_header !=3D NULL) {
>          *need_update_header =3D false;
> @@ -432,6 +496,51 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t=
 start_offset,
>              break;
>          }
> =20
> +        case QCOW2_EXT_MAGIC_ZONED_FORMAT:
> +        {
> +            if (ext.len < sizeof(zoned_ext)) {
> +                /* Missing fields */
> +                error_setg(errp, "zoned_ext: len=3D%" PRIu32 " too small=
 "
> +                           "(<%zu)", ext.len, sizeof(zoned_ext));
> +                return -EINVAL;
> +            }
> +            ret =3D bdrv_pread(bs->file, offset, ext.len, &zoned_ext, 0);
> +            if (ret < 0) {
> +                error_setg_errno(errp, -ret, "zoned_ext: "
> +                                 "Could not read ext header");
> +                return ret;
> +            }
> +
> +            zoned_ext.zone_size =3D be32_to_cpu(zoned_ext.zone_size);
> +            zoned_ext.zone_capacity =3D be32_to_cpu(zoned_ext.zone_capac=
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
> +            if (!qcow2_check_zone_options(&zoned_ext)) {
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
> @@ -1968,6 +2077,15 @@ static void qcow2_refresh_limits(BlockDriverState =
*bs, Error **errp)
>      }
>      bs->bl.pwrite_zeroes_alignment =3D s->subcluster_size;
>      bs->bl.pdiscard_alignment =3D s->cluster_size;
> +    bs->bl.zoned =3D s->zoned_header.zoned;
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
> @@ -3067,6 +3185,11 @@ int qcow2_update_header(BlockDriverState *bs)
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
> @@ -3112,6 +3235,31 @@ int qcow2_update_header(BlockDriverState *bs)
>          buflen -=3D ret;
>      }
> =20
> +    /* Zoned devices header extension */
> +    if (s->zoned_header.zoned =3D=3D BLK_Z_HM) {
> +        Qcow2ZonedHeaderExtension zoned_header =3D {
> +            .zoned              =3D s->zoned_header.zoned,
> +            .zone_size          =3D cpu_to_be32(s->zoned_header.zone_siz=
e),
> +            .zone_capacity      =3D cpu_to_be32(s->zoned_header.zone_cap=
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
> @@ -3485,6 +3633,8 @@ qcow2_co_create(BlockdevCreateOptions *create_optio=
ns, Error **errp)
>  {
>      BlockdevCreateOptionsQcow2 *qcow2_opts;
>      QDict *options;
> +    Qcow2ZoneCreateOptions *zone_struct;
> +    Qcow2ZoneHostManaged *zone_host_managed;
> =20
>      /*
>       * Open the image file and write a minimal qcow2 header.
> @@ -3511,6 +3661,8 @@ qcow2_co_create(BlockdevCreateOptions *create_optio=
ns, Error **errp)
> =20
>      assert(create_options->driver =3D=3D BLOCKDEV_DRIVER_QCOW2);
>      qcow2_opts =3D &create_options->u.qcow2;
> +    zone_struct =3D create_options->u.qcow2.zone;
> +    zone_host_managed =3D &create_options->u.qcow2.zone->u.host_managed;
> =20
>      bs =3D bdrv_co_open_blockdev_ref(qcow2_opts->file, errp);
>      if (bs =3D=3D NULL) {
> @@ -3724,6 +3876,14 @@ qcow2_co_create(BlockdevCreateOptions *create_opti=
ons, Error **errp)
>          header->incompatible_features |=3D
>              cpu_to_be64(QCOW2_INCOMPAT_DATA_FILE);
>      }
> +    if (zone_struct->mode =3D=3D QCOW2_ZONE_MODEL_HOST_MANAGED) {
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
> @@ -3781,10 +3941,9 @@ qcow2_co_create(BlockdevCreateOptions *create_opti=
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
> @@ -3792,11 +3951,56 @@ qcow2_co_create(BlockdevCreateOptions *create_opt=
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
> +    if (zone_struct->mode =3D=3D QCOW2_ZONE_MODEL_HOST_MANAGED) {
> +        if (!zone_host_managed->has_size) {
> +            error_setg(errp, "Missing zone_size parameter");
> +            ret =3D -EINVAL;
> +            goto unlock;
> +        }
> +
> +        s->zoned_header.zoned =3D BLK_Z_HM;
> +        s->zoned_header.zone_size =3D zone_host_managed->size;
> +        s->zoned_header.nr_zones =3D DIV_ROUND_UP(qcow2_opts->size,
> +                                                zone_host_managed->size);
> +        if (zone_host_managed->has_capacity) {
> +            s->zoned_header.zone_capacity =3D zone_host_managed->capacit=
y;
> +        } else {
> +            s->zoned_header.zone_capacity =3D zone_host_managed->size;
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
> +        s->zoned_header.max_append_bytes =3D zone_host_managed->max_appe=
nd_bytes;
> +
> +        if (!qcow2_check_zone_options(&s->zoned_header)) {
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
> @@ -3870,6 +4074,9 @@ qcow2_co_create(BlockdevCreateOptions *create_optio=
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
> @@ -3930,6 +4137,10 @@ qcow2_co_create_opts(BlockDriver *drv, const char =
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
> @@ -6097,6 +6308,41 @@ static QemuOptsList qcow2_create_opts =3D {
>              .help =3D "Compression method used for image cluster "      =
  \
>                      "compression",                                      \
>              .def_value_str =3D "zlib"                                   =
  \
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
> index a9e3481c6e..7f37bb4034 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -236,6 +236,27 @@ typedef struct Qcow2CryptoHeaderExtension {
>      uint64_t length;
>  } QEMU_PACKED Qcow2CryptoHeaderExtension;
> =20
> +typedef struct Qcow2ZonedHeaderExtension {
> +    /* Zoned device attributes */
> +    uint8_t zoned;
> +    uint8_t reserved[3];
> +    uint32_t zone_size;
> +    uint32_t zone_capacity;
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
> @@ -256,17 +277,20 @@ enum {
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
> @@ -422,6 +446,16 @@ typedef struct BDRVQcow2State {
>       * is to convert the image with the desired compression type set.
>       */
>      Qcow2CompressionType compression_type;
> +
> +    /* States of zoned device */
> +    Qcow2ZonedHeaderExtension zoned_header;
> +    QLIST_HEAD(, Qcow2ZoneListEntry) exp_open_zones;
> +    QLIST_HEAD(, Qcow2ZoneListEntry) imp_open_zones;
> +    QLIST_HEAD(, Qcow2ZoneListEntry) closed_zones;
> +    Qcow2ZoneListEntry *zone_list_entries;
> +    uint32_t nr_zones_exp_open;
> +    uint32_t nr_zones_imp_open;
> +    uint32_t nr_zones_closed;

This patch does not use these lists and counters. Please move them (and
the Qcow2ZoneListEntry typedef) to the patch that starts using them.
That way the patch series is easier to review and patches are more
self-contained.

>  } BDRVQcow2State;
> =20
>  typedef struct Qcow2COWRegion {
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index 2c4618375a..a8dd4c3b15 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -125,7 +125,26 @@ the next fields through header_length.
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
> @@ -249,6 +268,7 @@ be stored. Each extension has a structure like the fo=
llowing:
>                          0x23852875 - Bitmaps extension
>                          0x0537be77 - Full disk encryption header pointer
>                          0x44415441 - External data file name string
> +                        0x007a6264 - Zoned extension
>                          other      - Unknown header extension, can be sa=
fely
>                                       ignored
> =20
> @@ -331,6 +351,91 @@ The fields of the bitmaps extension are:
>                     Offset into the image file at which the bitmap direct=
ory
>                     starts. Must be aligned to a cluster boundary.
> =20
> +=3D=3D Zoned extension =3D=3D
> +
> +The zoned extension must be present if the incompatible bit is set, and
> +omitted when the incompatible bit is clear. It contains fields for
> +emulating the zoned storage model (https://zonedstorage.io/). When the
> +zone model mode is not host-managed, it is regarded as incompatible
> +and reports an error to users.
> +
> +The write pointers for each zone are stored in an area called zonedmeta
> +clusters. It is 8 bytes per zone. The offset and size of the zonedmeta
> +are kept in the zoned extension header.
> +
> +The fields of the zoned extension are:
> +    Byte       0:  zoned
> +                   The bit represents the zoned model of the device. 0 i=
s for

s/bit/byte/

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
> +          4 -  7:  zone_size
> +                   Total size of each zone, in bytes. It is less than 4GB
> +                   in the qcow2 image for simplicity. The maximum zone s=
ize
> +                   of real zoned devices are 2TB. If there are usages for
> +                   emulating devices whose zone sizes are larger than 4G,
> +                   the field needs to be sized bigger then.

Can we make the field 64-bit or at least expressed in units of 512-byte
sectors so its range is sufficient for Linux BLKGETZONESZ or virtio-blk
zone sizes?

> +
> +                   The value must be power of 2. Linux currently requires
> +                   the zone size to be a power of 2 number of LBAs. Qcow2
> +                   following this is mainly to allow emulating a real
> +                   ZNS drive configuration. It is not relevant to the cl=
uster
> +                   size.
> +
> +          8 - 11:  zone_capacity
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
> +         12 - 15:  conventional_zones
> +                   The number of conventional zones. The conventional zo=
nes
> +                   allow sequential writes and random writes. While the
> +                   sequential zones only allow sequential writes.
> +
> +         16 - 19:  nr_zones
> +                   The number of zones. It is the sum of conventional zo=
nes
> +                   and sequential zones.
> +
> +         20 - 23:  max_active_zones
> +                   The number of the zones that can be in the implicit o=
pen,
> +                   explicit open or closed state. The max active zones c=
annot
> +                   be larger than the max open zones.
> +
> +         24 - 27:  max_open_zones
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
> +         28 - 31:  max_append_bytes
> +                   The number of bytes of a zone append request that can=
 be
> +                   issued to the device. It must be 512-byte aligned and=
 less
> +                   than the zone capacity.
> +
> +         32 - 39:  zonedmeta_size
> +                   The size of zoned metadata in bytes. It contains no m=
ore
> +                   than 4GB. The zoned metadata structure is the write
> +                   pointers for each zone whose size is the number of zo=
nes
> +                   multiplied by the zone size.

Does this mean the maximum value for nr_zones is (2^32 - 1) / 8 =3D
536,870,911 zones? That seems like plenty, so I don't object to the
limit, but it should be stately explicit because it's not mentioned in
the above nr_zones field.

> +
> +         40 - 47:  zonedmeta_offset
> +                   The offset of zoned metadata structure in the contain=
ed
> +                   image, in bytes.

I suggest "Offset into the image file at which the zoned
metadata starts". That phrase is used elsewhere in the spec and is
clearer than than "offset ... in the contained image".

> +
>  =3D=3D Full disk encryption header pointer =3D=3D
> =20
>  The full disk encryption header must be present if, and only if, the
> diff --git a/include/block/block_int-common.h b/include/block/block_int-c=
ommon.h
> index 151279d481..d48486f344 100644
> --- a/include/block/block_int-common.h
> +++ b/include/block/block_int-common.h
> @@ -57,6 +57,13 @@
>  #define BLOCK_OPT_DATA_FILE_RAW     "data_file_raw"
>  #define BLOCK_OPT_COMPRESSION_TYPE  "compression_type"
>  #define BLOCK_OPT_EXTL2             "extended_l2"
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
> @@ -886,6 +893,12 @@ typedef struct BlockLimits {
>      /* zone size expressed in bytes */
>      uint32_t zone_size;
> =20
> +    /*
> +     * the number of usable logical blocks within the zone, expressed
> +     * in bytes. A zone capacity is smaller or equal to the zone size.
> +     */
> +    uint32_t zone_capacity;

The Linux BLKGETZONESZ ioctl produces a uint32_t number of 512-byte
sectors. virtio-blk also reports the number of 512-byte sectors. QEMU's
zone_size and zone_capacity are in uint32_t number of _bytes_.

Damien:
I don't remember if we discussed this before, but are we sure that zone
sizes will remain <4 GB? Perhaps uint64_t is more future-proof.

> +
>      /* total number of zones */
>      uint32_t nr_zones;
> =20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index ca390c5700..e2e0ec21a5 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -5038,6 +5038,67 @@
>  { 'enum': 'Qcow2CompressionType',
>    'data': [ 'zlib', { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
> =20
> +##
> +# @Qcow2ZoneModel:
> +#
> +# Zoned device model used in qcow2 image file
> +#
> +# @host-managed: The host-managed model only allows sequential write ove=
r the
> +#     device zones.
> +#
> +# Since 8.2
> +##
> +{ 'enum': 'Qcow2ZoneModel',
> +  'data': [ 'host-managed'] }
> +
> +##
> +# @Qcow2ZoneHostManaged:
> +#
> +# The host-managed zone model.  It only allows sequential writes.
> +#
> +# @size: Total number of bytes within zones.
> +#
> +# @capacity: The number of usable logical blocks within zones
> +#     in bytes.  A zone capacity is always smaller or equal to the
> +#     zone size.
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
> +#     512-byte aligned and less than the zone capacity.
> +#
> +# Since 8.2
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
> +# Since 8.2
> +##
> +{ 'union': 'Qcow2ZoneCreateOptions',
> +  'base': { 'mode': 'Qcow2ZoneModel' },
> +  'discriminator': 'mode',
> +  'data': { 'host-managed': 'Qcow2ZoneHostManaged' } }
> +
>  ##
>  # @BlockdevCreateOptionsQcow2:
>  #
> @@ -5080,6 +5141,9 @@
>  # @compression-type: The image cluster compression method
>  #     (default: zlib, since 5.1)
>  #
> +# @zone: The zone device model modes.  The default is that the device is
> +# not zoned.  (since 8.2)
> +#
>  # Since: 2.12
>  ##
>  { 'struct': 'BlockdevCreateOptionsQcow2',
> @@ -5096,7 +5160,8 @@
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
> 2.40.1
>=20

--pe5MYVF059pjisCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXwbuwACgkQnKSrs4Gr
c8jYzQgAh8QFqVmaC3bLzQnBlm3kosN80E9/oCuF1uhL4pin3qA5Y1QsxFDy2Rak
auajoAVdRbhME7OpPv2Bdulw0jQrrjl+GzFNpy2yqjCtIQAhY88NMqgGAOZecU+j
w0R6iI3h0siFf1gB+JAVNRfnZ6JJIj+kj98BC82ndTy1zeUkoC8sXRKuecffpKXH
/CeUAny0PulA+ILtIEC7j8gVD8cjyKXl2miES9dagXbwNmygh7vTqAVzzvrW2sCH
Xyrr8IuM8vZdlKuBD7V4W9QqMDsykWW3f2DFIyuV0eWfHbGt00iK8JAb/YLRpK7f
R3IOw1kJNNXXwDNniQRE7fHcBtsf0A==
=QFnb
-----END PGP SIGNATURE-----

--pe5MYVF059pjisCq--


