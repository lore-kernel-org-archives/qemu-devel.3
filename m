Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371CBC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 08:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQjTf-0000Ti-OO; Mon, 08 Jul 2024 04:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sQjTd-0000Sr-R8
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 04:12:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sQjTc-0008QE-3P
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 04:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720426316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LmcVdHZmE7unisL2978z6Huvw2AWzbHFPKODLVXyR7Q=;
 b=CznaPcDGQmp9Ed7TL+bC/WS4Q6it8h3G09fbRkQ6W3qfBVJZ8hDS9s8Pv/BjZ8Sz7+UyH1
 OzKMxLvE/uIhg2c5AY6RFP4V2KJYinarimfgeByxX9zqOqfeovu0aDlqBw+9h2F5OYEKxU
 YqfIHHKDjvOnHAC/mhB1Fe8CifWOxaI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-2KuU5YgqPX2Saed5foRbnw-1; Mon,
 08 Jul 2024 04:11:50 -0400
X-MC-Unique: 2KuU5YgqPX2Saed5foRbnw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 410651954B37; Mon,  8 Jul 2024 08:11:48 +0000 (UTC)
Received: from localhost (unknown [10.39.192.131])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3D6F81955F40; Mon,  8 Jul 2024 08:11:45 +0000 (UTC)
Date: Mon, 8 Jul 2024 10:11:44 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com
Subject: Re: [PATCH v7 05/10] hw/scsi: add persistent reservation in/out api
 for scsi device
Message-ID: <20240708081144.GC38033@dynamic-pd01.res.v6.highway.a1.net>
References: <20240705105614.3377694-1-luchangqi.123@bytedance.com>
 <20240705105614.3377694-6-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZguDrpUomsdvHqLg"
Content-Disposition: inline
In-Reply-To: <20240705105614.3377694-6-luchangqi.123@bytedance.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--ZguDrpUomsdvHqLg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2024 at 06:56:09PM +0800, Changqi Lu wrote:
> Add persistent reservation in/out operations in the
> SCSI device layer. By introducing the persistent
> reservation in/out api, this enables the SCSI device
> to perform reservation-related tasks, including querying
> keys, querying reservation status, registering reservation
> keys, initiating and releasing reservations, as well as
> clearing and preempting reservations held by other keys.
>=20
> These operations are crucial for management and control of
> shared storage resources in a persistent manner.
>=20
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  hw/scsi/scsi-disk.c | 368 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 368 insertions(+)
>=20
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 4bd7af9d0c..f0c3ce774f 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -32,6 +32,7 @@
>  #include "migration/vmstate.h"
>  #include "hw/scsi/emulation.h"
>  #include "scsi/constants.h"
> +#include "scsi/utils.h"
>  #include "sysemu/block-backend.h"
>  #include "sysemu/blockdev.h"
>  #include "hw/block/block.h"
> @@ -42,6 +43,7 @@
>  #include "qemu/cutils.h"
>  #include "trace.h"
>  #include "qom/object.h"
> +#include "block/block_int.h"
> =20
>  #ifdef __linux
>  #include <scsi/sg.h>
> @@ -1474,6 +1476,362 @@ static void scsi_disk_emulate_read_data(SCSIReque=
st *req)
>      scsi_req_complete(&r->req, GOOD);
>  }
> =20
> +typedef struct SCSIPrReadKeys {
> +    uint32_t generation;
> +    uint32_t num_keys;
> +    uint64_t *keys;
> +    SCSIDiskReq *req;
> +} SCSIPrReadKeys;
> +
> +typedef struct SCSIPrReadReservation {
> +    uint32_t generation;
> +    uint64_t key;
> +    BlockPrType type;
> +    SCSIDiskReq *req;
> +} SCSIPrReadReservation;
> +
> +static void scsi_pr_read_keys_complete(void *opaque, int ret)
> +{
> +    int num_keys;
> +    uint8_t *buf;
> +    SCSIPrReadKeys *blk_keys =3D (SCSIPrReadKeys *)opaque;
> +    SCSIDiskReq *r =3D blk_keys->req;
> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
> +
> +    assert(blk_get_aio_context(s->qdev.conf.blk) =3D=3D
> +            qemu_get_current_aio_context());
> +
> +    assert(r->req.aiocb !=3D NULL);
> +    r->req.aiocb =3D NULL;
> +
> +    if (scsi_disk_req_check_error(r, ret, true)) {
> +        goto done;
> +    }
> +
> +    buf =3D scsi_req_get_buf(&r->req);
> +    num_keys =3D MIN(blk_keys->num_keys, ret);

The behavior of scsi_disk_req_check_error() above is strange for
pr_read_keys operations. When --drive ...,rerror=3Dignore and ret < 0 this
line is reached and we don't want a negative num_keys value. It would be
safer to use (ret > 0 ? ret : 0) instead of the raw value of ret.

Stefan

--ZguDrpUomsdvHqLg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaLn0AACgkQnKSrs4Gr
c8ijiAf9EI0IvieTjWFKOvq3B+tlEcsrVXBpHX39SWLoTgHxwCHJk/xvT5Nz6nt1
3+IWisNHNJSifSGssqGqZRqjB74G6wlM4oC+De9dT/0fd2Oflt2dCSiowudgQhgV
/uWVjVwLiaKsEXc/Rjr4SDeQcR5F1Ec/KwXlp2uG2g77tPUkxCssRrfkR5mzTKEp
Du9KwV297sSrH+tV+mBhT65t7/yhL/TZ9DFtyqyBvUiZCa6xIXMdrY5PtlKdQLxH
iZtiGWNEEktJ897735STHV3tqeFzEyY68Xf/nopzvqgMBdTo6oNVGtfae14u/Dcc
0q8b8yPpORrqlSqlGsVOvIZY/T2fDA==
=r700
-----END PGP SIGNATURE-----

--ZguDrpUomsdvHqLg--


