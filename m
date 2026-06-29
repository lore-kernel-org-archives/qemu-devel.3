Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB559C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 18:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weGeK-00019e-Ln; Mon, 29 Jun 2026 14:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1weGeJ-00019N-7L
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 14:24:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1weGeH-00034W-8E
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 14:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782757440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t3xqu7r0lx3Q5Z2iF2GTIdXt6WQ688/GON/Y68xAs5Q=;
 b=US6qqOM19RaL8JhnesMzFc5X5CD5+/EtbFReFuKW1r2q91h8mKdhTgFN4yoNp5OfPUzM2Y
 xNj8qFBBD9cFe2mf+Kwl4bmgVwyBaCDSrcgQldnUIHmpC9I2jDrsr1S20bN/AbZ1e7jPmO
 wCdMa239xd6B5b0EuGH5VAa2gJdVvCY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-VviuOasZONGg1F2PZBi6zA-1; Mon,
 29 Jun 2026 14:23:59 -0400
X-MC-Unique: VviuOasZONGg1F2PZBi6zA-1
X-Mimecast-MFC-AGG-ID: VviuOasZONGg1F2PZBi6zA_1782757437
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6AFC0180064A; Mon, 29 Jun 2026 18:23:57 +0000 (UTC)
Received: from localhost (unknown [10.2.16.195])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5913319560A6; Mon, 29 Jun 2026 18:23:54 +0000 (UTC)
Date: Mon, 29 Jun 2026 20:23:47 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 cassel@kernel.org, dlemoal@kernel.org, qemu-block@nongnu.org,
 dmitry.fomichev@wdc.com, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v12 4/5] qcow2: add zoned emulation capability
Message-ID: <20260629182347.GB376767@fedora>
References: <20260623184830.373232-1-faithilikerun@gmail.com>
 <20260623184830.373232-5-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e4MmvKKuxRorkUkN"
Content-Disposition: inline
In-Reply-To: <20260623184830.373232-5-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--e4MmvKKuxRorkUkN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 23, 2026 at 08:48:29PM +0200, Sam Li wrote:
> +static int coroutine_fn GRAPH_RDLOCK
> +qcow2_rw_wp_at(BlockDriverState *bs, uint64_t *wp,
> +                  int32_t index, bool is_write)
> +{
> +    BDRVQcow2State *s = bs->opaque;
> +    uint64_t wp_byte_off = sizeof(uint64_t) * index;
> +    uint64_t cluster_file_off =
> +        s->zoned_header.zonedmeta_offset +
> +        (wp_byte_off & ~((uint64_t)s->cluster_size - 1));
> +    size_t off_in_cluster = wp_byte_off & (s->cluster_size - 1);
> +    void *cluster_buf;
> +    uint64_t *slot;
> +    int ret;
> +
> +    assert(s->wp_cache != NULL);
> +
> +    qemu_co_mutex_lock(&s->lock);
> +    ret = qcow2_cache_get(bs, s->wp_cache, cluster_file_off, &cluster_buf);
> +    if (ret < 0) {
> +        qemu_co_mutex_unlock(&s->lock);
> +        error_report("Failed to %s WP slot (zone %d): %s",
> +                     is_write ? "write" : "read", index, strerror(-ret));
> +        return ret;
> +    }
> +
> +    slot = (uint64_t *)((char *)cluster_buf + off_in_cluster);
> +    if (is_write) {
> +        *slot = *wp;

Missing cpu_to_be64()?

> +        qcow2_cache_entry_mark_dirty(s->wp_cache, cluster_buf);
> +    } else {
> +        *wp = *slot;

Missing be64_to_cpu()?

> +static inline int coroutine_fn GRAPH_RDLOCK
> +qcow2_refresh_zonedmeta(BlockDriverState *bs)
> +{
> +    int ret;
> +    BDRVQcow2State *s = bs->opaque;
> +    uint64_t wps_size = s->zoned_header.nr_zones * sizeof(uint64_t);
> +    g_autofree uint64_t *temp = NULL;
> +
> +    temp = g_new(uint64_t, s->zoned_header.nr_zones);
> +    ret = bdrv_pread(bs->file, s->zoned_header.zonedmeta_offset,
> +                     wps_size, temp, 0);
> +    if (ret < 0) {
> +        error_report("Cannot read metadata");
> +        return ret;
> +    }
> +
> +    memcpy(bs->wps->wp, temp, wps_size);

Missing be64_to_cpu()?

bs->wps->wp[] is in QEMU's format while temp is in qcow2's format. The
representations are not guaranteed to remain the same. An explicit
conversion from qcow2's representation to QEMU's representation would be
best. You could also use build-time assertions (QEMU_BUILD_BUG_ON()) to
check that the qcow2 constants match the QEMU constants.

> @@ -559,8 +874,34 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
>                             "is wrong");
>                  return -EINVAL;
>              }
> -            if (!qcow2_check_zone_options(&zoned_ext, errp)) {
> -                return -EINVAL;
> +
> +            bs->wps = g_malloc(sizeof(BlockZoneWps)
> +                + s->zoned_header.nr_zones * sizeof(uint64_t));
> +            ret = qcow2_refresh_zonedmeta(bs);

Is bs->wps freed when qcow2_refresh_zonedmeta() fails?
> @@ -4161,6 +4879,45 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
>              ret = -EINVAL;
>              goto unlock;
>          }
> +
> +        uint32_t nrz = s->zoned_header.nr_zones;
> +        zoned_meta_size =  sizeof(uint64_t) * nrz;
> +        g_autofree uint64_t *meta = NULL;
> +        meta = g_new0(uint64_t, nrz);
> +
> +        for (i = 0; i < s->zoned_header.conventional_zones; ++i) {
> +            meta[i] = i * s->zoned_header.zone_size;
> +            meta[i] |= 1ULL << 59;
> +        }
> +
> +        for (; i < nrz; ++i) {
> +            meta[i] = i * s->zoned_header.zone_size;
> +        }

Missing cpu_to_be64()?

--e4MmvKKuxRorkUkN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpCuDMACgkQnKSrs4Gr
c8jixggAqTpcZshvmbH+klX6ZuyKRBTDpLzWyML4ib7rTMFD/uvpSU0xkLfWZTpe
9r9wCqm9F1FLR2O3hHCvDKTAoFgMNb05wjmCbzRjNLVV0j6anhJEi+GtgTfkAlos
GF6JqJr2nXyPDZe0vP3eCi52OObU6HAkSWuj7k1MMtnUNaHhGAXFklZx0JxkJxxr
jCSroNwdmup4pI8nPY2cRsb46kpfc5K02xQIKekFpQUBsF6j4m3ubLG/jW9p26Pj
gpXL6NBltETp8m6h0O5My/y+//kadRn87RQCUp8sv2iC+gpSI8IstaRkR+yAagPE
Tq0SLUryfqtguYhfT19GdVyIiNgTSg==
=oN0O
-----END PGP SIGNATURE-----

--e4MmvKKuxRorkUkN--


