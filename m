Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3078EC28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 07:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tscZr-0006b2-5p; Thu, 13 Mar 2025 03:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tscZk-0006NQ-2Z
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 03:01:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tscZe-00072w-UP
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 03:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741849306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+SOBC4F/KjbW2Mxc30vluZAoOPslVzXluNwBqMG4k8I=;
 b=Wnroh9scmY3+82OKdS0ZHx3+jepj/U4ZyRcMypGOFokVYrDC06UGEIdXYiHk4pCDoLdLrt
 iLoDfd4I09icHrma20U+tgEVkV7GSu3TTTqhLX5MXIM+jiIURGSfqYOSQlB8d35aACnEBI
 CK7r8sYj/vCS2eyBMDOAgM1egN7SVMA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-qL33q7S3PDaovrUBsoZctA-1; Thu,
 13 Mar 2025 03:01:39 -0400
X-MC-Unique: qL33q7S3PDaovrUBsoZctA-1
X-Mimecast-MFC-AGG-ID: qL33q7S3PDaovrUBsoZctA_1741849297
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F8A71956046; Thu, 13 Mar 2025 07:01:37 +0000 (UTC)
Received: from localhost (unknown [10.2.16.45])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4419E1800268; Thu, 13 Mar 2025 07:01:35 +0000 (UTC)
Date: Thu, 13 Mar 2025 12:25:08 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: zoudongjie <zoudongjie@huawei.com>
Cc: zhuyangyang14@huawei.com, qemu-devel@nongnu.org, fam@euphon.net,
 hreitz@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 luolongmin@huawei.com, suxiaodong1@huawei.com,
 wangyan122@huawei.com, yebiaoxiang@huawei.com,
 wangjian161@huawei.com, mujinsheng@huawei.com, alex.chen@huawei.com,
 eric.fangyi@huawei.com, chenjianfei3@huawei.com, renxuming@huawei.com
Subject: Re: [PATCH 2/2] qapi: Fix qmp_block_set_io_throttle blocked for too
 long
Message-ID: <20250313042508.GD1074020@fedora>
References: <20250308101618.721954-1-zoudongjie@huawei.com>
 <20250308101618.721954-3-zoudongjie@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="So/AeFwZ0klPdpAy"
Content-Disposition: inline
In-Reply-To: <20250308101618.721954-3-zoudongjie@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--So/AeFwZ0klPdpAy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 08, 2025 at 06:16:18PM +0800, zoudongjie wrote:
> From: Zhu Yangyang <zhuyangyang14@huawei.com>
>=20
> bdrv_drained_begin() is blocked for a long time when network storage is u=
sed
> and the network link has just failed.
> Therefore, the timeout period is set here.
>=20
> Signed-off-by: Zhu Yangyang <zhuyangyang14@huawei.com>
> ---
>  block/block-backend.c                       | 14 +++++++++++++-
>  block/qapi-system.c                         |  7 ++++++-
>  include/system/block-backend-global-state.h |  1 +
>  3 files changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 9288f7e1c6..409d4559c3 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -2691,20 +2691,32 @@ void blk_set_io_limits(BlockBackend *blk, Throttl=
eConfig *cfg)
>  }
> =20
>  void blk_io_limits_disable(BlockBackend *blk)
> +{
> +    blk_io_limits_disable_timeout(blk, -1);
> +}
> +
> +int blk_io_limits_disable_timeout(BlockBackend *blk, int64_t timeout_ms)
>  {
>      BlockDriverState *bs =3D blk_bs(blk);
>      ThrottleGroupMember *tgm =3D &blk->public.throttle_group_member;
> +    int ret =3D 0;
> +
>      assert(tgm->throttle_state);
>      GLOBAL_STATE_CODE();
>      if (bs) {
>          bdrv_ref(bs);
> -        bdrv_drained_begin(bs);
> +        ret =3D bdrv_drained_begin_timeout(bs, timeout_ms);
> +        if (ret < 0) {
> +            goto out;
> +        }
>      }
>      throttle_group_unregister_tgm(tgm);
> +out:
>      if (bs) {
>          bdrv_drained_end(bs);
>          bdrv_unref(bs);
>      }
> +    return ret;
>  }
> =20
>  /* should be called before blk_set_io_limits if a limit is set */
> diff --git a/block/qapi-system.c b/block/qapi-system.c
> index 54b7409b2b..96fa8e5e51 100644
> --- a/block/qapi-system.c
> +++ b/block/qapi-system.c
> @@ -39,6 +39,8 @@
>  #include "system/block-backend.h"
>  #include "system/blockdev.h"
> =20
> +#define QMP_BLOCKING_TIMEOUT 5000 /* ms */
> +
>  static BlockBackend *qmp_get_blk(const char *blk_name, const char *qdev_=
id,
>                                   Error **errp)
>  {
> @@ -502,7 +504,10 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg,=
 Error **errp)
>          blk_set_io_limits(blk, &cfg);
>      } else if (blk_get_public(blk)->throttle_group_member.throttle_state=
) {
>          /* If all throttling settings are set to 0, disable I/O limits */
> -        blk_io_limits_disable(blk);
> +        if (blk_io_limits_disable_timeout(blk, QMP_BLOCKING_TIMEOUT) < 0=
) {

Please add a timeout parameter to the QMP command instead of hardcoding
the timeout. It should also support an infinite timeout and that should
be the default (so that existing users aren't surprised with a new error
they don't handle).

> +            error_setg(errp, "Blk io limits disable timeout");
> +            return;
> +        }
>      }
>  }
> =20
> diff --git a/include/system/block-backend-global-state.h b/include/system=
/block-backend-global-state.h
> index 9cc9b008ec..e55ea9dc64 100644
> --- a/include/system/block-backend-global-state.h
> +++ b/include/system/block-backend-global-state.h
> @@ -111,6 +111,7 @@ int blk_probe_geometry(BlockBackend *blk, HDGeometry =
*geo);
> =20
>  void blk_set_io_limits(BlockBackend *blk, ThrottleConfig *cfg);
>  void blk_io_limits_disable(BlockBackend *blk);
> +int blk_io_limits_disable_timeout(BlockBackend *blk, int64_t timeout_ms);
>  void blk_io_limits_enable(BlockBackend *blk, const char *group);
>  void blk_io_limits_update_group(BlockBackend *blk, const char *group);
>  void blk_set_force_allow_inactivate(BlockBackend *blk);
> --=20
> 2.33.0
>=20

--So/AeFwZ0klPdpAy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfSXiQACgkQnKSrs4Gr
c8jweQgAw/4fTMlxJA3digBb1uaI2YsWh+ThC4GMoPliFDGK5ZVoOBYfNWJUTLX0
4i1ypr7fYRqPMKBWjTXbmApULYImf3J1Z9sd7/ImX5CEwIpNJzhUOX2lOg9QaXb0
8ZtWQLosK+RRLLJH5NNudfsGXrvV6UILJXubollo5QEre5pLrhahLjeQGHDZ6+5a
kpzwpWutp1Gy28V33T8pSN7TqJAIQKVq6BejQnR2T80WEcOJjsDmt7OAJELJcbbq
Ax9DYVLtONwGO+ZBN5RWwnfuapShwr3nEhQr5UaWNV5g8RWHqv0hv18wgM+Gousf
cZhYn8NS4DV0CIi3fuJwBmKRN7YDuQ==
=27Kv
-----END PGP SIGNATURE-----

--So/AeFwZ0klPdpAy--


