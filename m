Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327F2C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 17:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGifG-0001A9-Sx; Mon, 10 Jun 2024 13:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sGifE-00018A-Iw
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:18:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sGifD-00023o-1Y
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718039914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mFuQhmj9T7Z+nWcvOfuTcgoiI+lA5QosiNtUTx9l5Vk=;
 b=OgXY76Jt05h/BCiB/AYH7SxkEQAaWoC3EdwjXSOlCfqaJ0FVkj8UjDVggUDRT5GVF1qadI
 pTlrcLHDZRrg+FF8Ppm5pOyxzF7nPeDth1Fe4DLF8u9KfBbKLg3IQpquH06Cintgx87Jln
 Q2xHJXzSEpz+cof9bmFVRPVN0OvFav8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-qs9IxC0aPhSvTeA4rhTaSA-1; Mon,
 10 Jun 2024 13:18:30 -0400
X-MC-Unique: qs9IxC0aPhSvTeA4rhTaSA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A5E619560BF; Mon, 10 Jun 2024 17:18:28 +0000 (UTC)
Received: from localhost (unknown [10.39.195.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2FD2219560AB; Mon, 10 Jun 2024 17:18:25 +0000 (UTC)
Date: Mon, 10 Jun 2024 13:18:23 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com
Subject: Re: [PATCH v5 00/10] Support persistent reservation operations
Message-ID: <20240610171823.GA334653@fedora.redhat.com>
References: <20240606122444.2914576-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gxnLNSZVCcpzHxFt"
Content-Disposition: inline
In-Reply-To: <20240606122444.2914576-1-luchangqi.123@bytedance.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


--gxnLNSZVCcpzHxFt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 08:24:34PM +0800, Changqi Lu wrote:
> Hi,
>=20
> patchv5 has been modified.=20
>=20
> Sincerely hope that everyone can help review the
> code and provide some suggestions.
>=20
> v4->v5:
> - Fixed a memory leak bug at hw/nvme/ctrl.c.
>=20
> v3->v4:
> - At the nvme layer, the two patches of enabling the ONCS
>   function and enabling rescap are combined into one.
> - At the nvme layer, add helper functions for pr capacity
>   conversion between the block layer and the nvme layer.
>=20
> v2->v3:
> In v2 Persist Through Power Loss(PTPL) is enable default.
> In v3 PTPL is supported, which is passed as a parameter.
>=20
> v1->v2:
> - Add sg_persist --report-capabilities for SCSI protocol and enable
>   oncs and rescap for NVMe protocol.
> - Add persistent reservation capabilities constants and helper functions =
for
>   SCSI and NVMe protocol.
> - Add comments for necessary APIs.
>=20
> v1:
> - Add seven APIs about persistent reservation command for block layer.
>   These APIs including reading keys, reading reservations, registering,
>   reserving, releasing, clearing and preempting.
> - Add the necessary pr-related operation APIs for both the
>   SCSI protocol and NVMe protocol at the device layer.
> - Add scsi driver at the driver layer to verify the functions

My question from v1 is unanswered:

  What is the relationship to the existing PRManager functionality
  (docs/interop/pr-helper.rst) where block/file-posix.c interprets SCSI
  ioctls and sends persistent reservation requests to an external helper
  process?

  I wonder if block/file-posix.c can implement the new block driver
  callbacks using pr_mgr (while keeping the existing scsi-generic
  support).

Thanks,
Stefan

>=20
>=20
> Changqi Lu (10):
>   block: add persistent reservation in/out api
>   block/raw: add persistent reservation in/out driver
>   scsi/constant: add persistent reservation in/out protocol constants
>   scsi/util: add helper functions for persistent reservation types
>     conversion
>   hw/scsi: add persistent reservation in/out api for scsi device
>   block/nvme: add reservation command protocol constants
>   hw/nvme: add helper functions for converting reservation types
>   hw/nvme: enable ONCS and rescap function
>   hw/nvme: add reservation protocal command
>   block/iscsi: add persistent reservation in/out driver
>=20
>  block/block-backend.c             | 397 ++++++++++++++++++++++++++
>  block/io.c                        | 163 +++++++++++
>  block/iscsi.c                     | 443 ++++++++++++++++++++++++++++++
>  block/raw-format.c                |  56 ++++
>  hw/nvme/ctrl.c                    | 326 +++++++++++++++++++++-
>  hw/nvme/ns.c                      |   5 +
>  hw/nvme/nvme.h                    |  84 ++++++
>  hw/scsi/scsi-disk.c               | 352 ++++++++++++++++++++++++
>  include/block/block-common.h      |  40 +++
>  include/block/block-io.h          |  20 ++
>  include/block/block_int-common.h  |  84 ++++++
>  include/block/nvme.h              |  98 +++++++
>  include/scsi/constants.h          |  52 ++++
>  include/scsi/utils.h              |   8 +
>  include/sysemu/block-backend-io.h |  24 ++
>  scsi/utils.c                      |  81 ++++++
>  16 files changed, 2231 insertions(+), 2 deletions(-)
>=20
> --=20
> 2.20.1
>=20

--gxnLNSZVCcpzHxFt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZnNV8ACgkQnKSrs4Gr
c8hKKAf5AVkZxIpC8B0k9eX9sopzM0mI2ar2lY7Tu8DYHycwuX5ZNrdKiOg3VW1h
ufbdahg1Cpth7PhGbz+EXykZbxNQIyK7zTneu0fgAORw0KBdqFpmfC2Tyi8y8fbV
xzavWTVO97GYStScf/by6Kq7ddb/t6GGGRlqJO7la2NfsYlLJJehB0oBjLtk5xqu
1GDnq4VIGaScNLxbcTklHxH1RarJkMzv/D1Ddwj0eCAzlqhQxpq/mhjU/kT3+Tjo
FX0/I+tczJHimkLw6ruDya3KZ7Zy4hqRLt6XlOPf49Fy5jbk8e9AoSMRp1AaWrew
/HICXVMdReqVh6H+q0sMq/2LSS1Kgw==
=34FX
-----END PGP SIGNATURE-----

--gxnLNSZVCcpzHxFt--


