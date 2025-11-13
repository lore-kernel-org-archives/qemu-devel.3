Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAC3CD6E7D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 15:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJYuZ-0007ju-8R; Thu, 13 Nov 2025 10:06:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vJYuX-0007e8-Jq
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 10:06:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vJYuU-0008E2-HB
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 10:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763046413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rH6BIYpIofK5dZ6L9x3pMX79Z0MhJ+2ozqsez6rYKlM=;
 b=Xyiq4VFCgxm1MBLcClKmGdC/SWX/28mPBTny4uv9SqrrlKINGXtZsaw7wLSpIiTnxu6odw
 U1XX4i+B04O00tvmS/ENqWPWhRPrDI76kJJJmhLhORnO34NA2CcxA9ChE+Dg6peR2TlyDG
 wqH+NEdKoKhjbiOp6WnRHvcixWpDbQw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-3JJBQq1RPTOP-9FSjWHO5w-1; Thu,
 13 Nov 2025 10:06:48 -0500
X-MC-Unique: 3JJBQq1RPTOP-9FSjWHO5w-1
X-Mimecast-MFC-AGG-ID: 3JJBQq1RPTOP-9FSjWHO5w_1763046399
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D1781956088; Thu, 13 Nov 2025 15:06:38 +0000 (UTC)
Received: from localhost (unknown [10.2.16.177])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 81B2B180049F; Thu, 13 Nov 2025 15:06:36 +0000 (UTC)
Date: Thu, 13 Nov 2025 10:06:35 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alberto Faria <afaria@redhat.com>
Cc: Changqi Lu <luchangqi.123@bytedance.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 fam@euphon.net, ronniesahlberg@gmail.com, pbonzini@redhat.com,
 pl@dlhnet.de, kbusch@kernel.org, its@irrelevant.dk,
 foss@defmacro.it, philmd@linaro.org, pizhenwei@bytedance.com,
 k.jensen@samsung.com
Subject: Re: [PATCH v14 00/10] Support persistent reservation operations
Message-ID: <20251113150635.GB189474@fedora>
References: <20241011121231.18333-1-luchangqi.123@bytedance.com>
 <CAELaAXwByXS0=c6m8Vx-A7Fa_q5XV7_cjPdcLa+M3w4NJR8R2g@mail.gmail.com>
 <CAELaAXwDrkp4V=32o3SxjOKMOZSsfE6_2ZxGg-AF1KT29_wKkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bPPNkelM6sOYwv/Z"
Content-Disposition: inline
In-Reply-To: <CAELaAXwDrkp4V=32o3SxjOKMOZSsfE6_2ZxGg-AF1KT29_wKkw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--bPPNkelM6sOYwv/Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 10:39:03AM +0000, Alberto Faria wrote:
> It seems Changqi Lu might have left ByteDance, the email is bouncing
> with a user not found error.
>=20
> Any tips on how to proceed?

You can resume development of the series. Apply the patches, work on
them until they are ready, and send them crediting the author:
- It's easiest to add new patches that are authored by yourself, but
  often you'll also need to fix up the original patches.
- If the change to an original patch is small, keep the authorship
  information and add your Signed-off-by, noting that you made changes.
- If you change the majority of a patch, you might decide to make
  yourself author, but note that the patch is based on the original
  author's work.

You may keep the patch series subject or pick a new one, depending on
how relevant the original subject is to the scope of your new series.

If you're unsure, try searching the web for advice on taking over patch
series. There are multiple ways of doing it, and as long as you give
credit to the author of the original code, it's up to you which approach
you choose.

Stefan

>=20
> Alberto
>=20
> On Wed, Nov 12, 2025 at 10:26=E2=80=AFAM Alberto Faria <afaria@redhat.com=
> wrote:
> >
> > Hi Changqi,
> >
> > I wonder if you plan on following through with this series? It looks
> > like it was/is very close to being merged. I can help or pick it up
> > from here if you want, as I'm interested in seeing it merged.
> >
> > Thanks, Alberto
> >
> > On Fri, Oct 11, 2024 at 6:24=E2=80=AFPM Changqi Lu <luchangqi.123@byted=
ance.com> wrote:
> > >
> > > Patch v14 has been modified, thanks to Stefan for the code review.
> > >
> > > v13->v14:
> > > - Fix some protocol and spelling related issues at hw/nvme/ctrl.c.
> > >
> > > v12->v13:
> > > - Fix byte swaps at hw/nvme/ctrl.c.
> > >
> > > v11->v12:
> > > - Fixed endian conversion during command parsing;
> > > - Add the maximum number of keys, currently limited to 128.
> > >
> > > v10->v11:
> > > - Before executing the pr operation, check whether it is supported.
> > >   If it is not supported, return NVME_INVALID_OPCODE directly.
> > >
> > > v9->v10:
> > > - When the driver does not support the pr operation, the error
> > >   code returned by nvme changes to Invalid Command Opcode.
> > >
> > > v8->v9:
> > > - Fix double-free and remove persistent reservation operations at nvm=
e_is_write().
> > >
> > > v7->v8:
> > > - Fix num_keys may be less than 0 at scsi_pr_read_keys_complete().
> > > - Fix buf memory leak at iscsi driver.
> > >
> > > v6->v7:
> > > - Add buferlen size check at SCSI layer.
> > > - Add pr_cap calculation in bdrv_merge_limits() function at block lay=
er,
> > >   so the ugly bs->file->bs->bl.pr_cap in scsi and nvme layers was
> > >   changed to bs->bl.pr_cap.
> > > - Fix memory leak at iscsi driver, and some other spelling errors.
> > >
> > > v5->v6:
> > > - Add relevant comments in the io layer.
> > >
> > > v4->v5:
> > > - Fixed a memory leak bug at hw/nvme/ctrl.c.
> > >
> > > v3->v4:
> > > - At the nvme layer, the two patches of enabling the ONCS
> > >   function and enabling rescap are combined into one.
> > > - At the nvme layer, add helper functions for pr capacity
> > >   conversion between the block layer and the nvme layer.
> > >
> > > v2->v3:
> > > In v2 Persist Through Power Loss(PTPL) is enable default.
> > > In v3 PTPL is supported, which is passed as a parameter.
> > >
> > > v1->v2:
> > > - Add sg_persist --report-capabilities for SCSI protocol and enable
> > >   oncs and rescap for NVMe protocol.
> > > - Add persistent reservation capabilities constants and helper functi=
ons for
> > >   SCSI and NVMe protocol.
> > > - Add comments for necessary APIs.
> > >
> > > v1:
> > > - Add seven APIs about persistent reservation command for block layer.
> > >   These APIs including reading keys, reading reservations, registerin=
g,
> > >   reserving, releasing, clearing and preempting.
> > > - Add the necessary pr-related operation APIs for both the
> > >   SCSI protocol and NVMe protocol at the device layer.
> > > - Add scsi driver at the driver layer to verify the functions
> > >
> > > Changqi Lu (10):
> > >   block: add persistent reservation in/out api
> > >   block/raw: add persistent reservation in/out driver
> > >   scsi/constant: add persistent reservation in/out protocol constants
> > >   scsi/util: add helper functions for persistent reservation types
> > >     conversion
> > >   hw/scsi: add persistent reservation in/out api for scsi device
> > >   block/nvme: add reservation command protocol constants
> > >   hw/nvme: add helper functions for converting reservation types
> > >   hw/nvme: enable ONCS and rescap function
> > >   hw/nvme: add reservation protocal command
> > >   block/iscsi: add persistent reservation in/out driver
> > >
> > >  block/block-backend.c             | 403 ++++++++++++++++++++++++++++
> > >  block/io.c                        | 164 ++++++++++++
> > >  block/iscsi.c                     | 428 ++++++++++++++++++++++++++++=
++
> > >  block/raw-format.c                |  56 ++++
> > >  hw/nvme/ctrl.c                    | 350 +++++++++++++++++++++++-
> > >  hw/nvme/ns.c                      |  11 +
> > >  hw/nvme/nvme.h                    |  93 +++++++
> > >  hw/scsi/scsi-disk.c               | 374 ++++++++++++++++++++++++++
> > >  include/block/block-common.h      |  40 +++
> > >  include/block/block-io.h          |  20 ++
> > >  include/block/block_int-common.h  |  84 ++++++
> > >  include/block/nvme.h              | 121 ++++++++-
> > >  include/scsi/constants.h          |  52 ++++
> > >  include/scsi/utils.h              |   8 +
> > >  include/sysemu/block-backend-io.h |  24 ++
> > >  scsi/utils.c                      |  81 ++++++
> > >  16 files changed, 2307 insertions(+), 2 deletions(-)
> > >
> > > --
> > > 2.20.1
> > >
> > >
>=20

--bPPNkelM6sOYwv/Z
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmkV8/sACgkQnKSrs4Gr
c8hjoAf7BmXwA8dZDMjVBLjoAisznIFLgYPeO+fgvkDtJhb/PCRhmv4CcdW9DgnQ
5AcJI/hi/oS5YWl5Ik8gtHhhUCBWXgZgkk2KjEOAo9RjW2xjAgynGxfGZnvnN3q+
5PVk86+8Av2i+JsIBQYz6fNxAiHQfYSK58b4Af3srbFY8hkphOrQTPTz/FmXrhkf
Xrd33PtdQooqcSx3kTbivlv/nubaBguo+8guOEs6Mh/Sd7EUijnMCjpgReBm025a
zwLJ+Lb+279gucMuXLufg4U+QttaOB+ceXKsCYUajSkqma8SodQeE4xQuTwP0cvT
bLW1sA17vV5d1wB2IreABACppRfcVw==
=qNfh
-----END PGP SIGNATURE-----

--bPPNkelM6sOYwv/Z--


