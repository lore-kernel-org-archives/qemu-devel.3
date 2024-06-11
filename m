Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AFDC27C75
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 15:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH33U-0003Gz-8J; Tue, 11 Jun 2024 11:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sH33M-0003Fl-2y
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 11:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sH33J-00085E-FS
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 11:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718118288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rGKKe0RSG0ekt7xDq0aXM9vPhPUmi9tghmU2YFyAn4g=;
 b=fLmkVs8uLOJO6S0TIGOO+RQAnxBygDM/tPmQC5JBy19oFlDKXZymF3bGClvz7sknYBMXSc
 xSQnbw8QojnlQxuWYC03oVAI0Osq4uvXZAIQanAG59Lp78XLWE/0y+m09trEMJMdmzKIgP
 nHM06gn34s2yfEzJ2dtk0o0UVsm6VW0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-JhPnEVARM4qO7IF-IpCpPA-1; Tue,
 11 Jun 2024 11:04:42 -0400
X-MC-Unique: JhPnEVARM4qO7IF-IpCpPA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 078E01956067; Tue, 11 Jun 2024 15:04:37 +0000 (UTC)
Received: from localhost (unknown [10.39.193.36])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D517C19560B0; Tue, 11 Jun 2024 15:04:29 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:04:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?utf-8?B?5Y2i6ZW/5aWH?= <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com
Subject: Re: Re: [PATCH v5 00/10] Support persistent reservation operations
Message-ID: <20240611150427.GC366375@fedora.redhat.com>
References: <20240606122444.2914576-1-luchangqi.123@bytedance.com>
 <20240610171823.GA334653@fedora.redhat.com>
 <CAO5cSZDWkoORC_LPib3b16+q8vRK7zUvzYeVp7SjZg0+EBeRNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UGEvaVH8QWKmsHGN"
Content-Disposition: inline
In-Reply-To: <CAO5cSZDWkoORC_LPib3b16+q8vRK7zUvzYeVp7SjZg0+EBeRNQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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


--UGEvaVH8QWKmsHGN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 07:55:20PM -0700, =E5=8D=A2=E9=95=BF=E5=A5=87 wrote:
> Hi,
>=20
> Sorry, I explained it in patch2 and forgot to reply your email.
>=20
> The existing PRManager only works with local scsi devices. This series
> will completely decouple devices and drivers. The device can not only be
> scsi, but also other devices such as nvme. The same is true for the
> driver, which is completely unrestricted.
>=20
> And block/file-posix.c can implement the new block driver, and
> pr_manager can be executed after splicing ioctl commands in these
> drivers. This will be implemented in subsequent patches.

Thanks for explaining!

Stefan

>=20
> On 2024/6/11 01:18, Stefan Hajnoczi wrote:
> > On Thu, Jun 06, 2024 at 08:24:34PM +0800, Changqi Lu wrote:
> >> Hi,
> >>
> >> patchv5 has been modified.
> >>
> >> Sincerely hope that everyone can help review the
> >> code and provide some suggestions.
> >>
> >> v4->v5:
> >> - Fixed a memory leak bug at hw/nvme/ctrl.c.
> >>
> >> v3->v4:
> >> - At the nvme layer, the two patches of enabling the ONCS
> >> function and enabling rescap are combined into one.
> >> - At the nvme layer, add helper functions for pr capacity
> >> conversion between the block layer and the nvme layer.
> >>
> >> v2->v3:
> >> In v2 Persist Through Power Loss(PTPL) is enable default.
> >> In v3 PTPL is supported, which is passed as a parameter.
> >>
> >> v1->v2:
> >> - Add sg_persist --report-capabilities for SCSI protocol and enable
> >> oncs and rescap for NVMe protocol.
> >> - Add persistent reservation capabilities constants and helper functio=
ns
> for
> >> SCSI and NVMe protocol.
> >> - Add comments for necessary APIs.
> >>
> >> v1:
> >> - Add seven APIs about persistent reservation command for block layer.
> >> These APIs including reading keys, reading reservations, registering,
> >> reserving, releasing, clearing and preempting.
> >> - Add the necessary pr-related operation APIs for both the
> >> SCSI protocol and NVMe protocol at the device layer.
> >> - Add scsi driver at the driver layer to verify the functions
> >
> > My question from v1 is unanswered:
> >
> > What is the relationship to the existing PRManager functionality
> > (docs/interop/pr-helper.rst) where block/file-posix.c interprets SCSI
> > ioctls and sends persistent reservation requests to an external helper
> > process?
> >
> > I wonder if block/file-posix.c can implement the new block driver
> > callbacks using pr_mgr (while keeping the existing scsi-generic
> > support).
> >
> > Thanks,
> > Stefan
> >
> >>
> >>
> >> Changqi Lu (10):
> >> block: add persistent reservation in/out api
> >> block/raw: add persistent reservation in/out driver
> >> scsi/constant: add persistent reservation in/out protocol constants
> >> scsi/util: add helper functions for persistent reservation types
> >> conversion
> >> hw/scsi: add persistent reservation in/out api for scsi device
> >> block/nvme: add reservation command protocol constants
> >> hw/nvme: add helper functions for converting reservation types
> >> hw/nvme: enable ONCS and rescap function
> >> hw/nvme: add reservation protocal command
> >> block/iscsi: add persistent reservation in/out driver
> >>
> >> block/block-backend.c | 397 ++++++++++++++++++++++++++
> >> block/io.c | 163 +++++++++++
> >> block/iscsi.c | 443 ++++++++++++++++++++++++++++++
> >> block/raw-format.c | 56 ++++
> >> hw/nvme/ctrl.c | 326 +++++++++++++++++++++-
> >> hw/nvme/ns.c | 5 +
> >> hw/nvme/nvme.h | 84 ++++++
> >> hw/scsi/scsi-disk.c | 352 ++++++++++++++++++++++++
> >> include/block/block-common.h | 40 +++
> >> include/block/block-io.h | 20 ++
> >> include/block/block_int-common.h | 84 ++++++
> >> include/block/nvme.h | 98 +++++++
> >> include/scsi/constants.h | 52 ++++
> >> include/scsi/utils.h | 8 +
> >> include/sysemu/block-backend-io.h | 24 ++
> >> scsi/utils.c | 81 ++++++
> >> 16 files changed, 2231 insertions(+), 2 deletions(-)
> >>
> >> --
> >> 2.20.1
> >>

--UGEvaVH8QWKmsHGN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZoZ3sACgkQnKSrs4Gr
c8gIsggApitziGaJ6VOIcdPjg3sMCX7z4xm5U3MJxq86m/OIcFAwVDe+QYzGxH0S
6AbdmJNPY1XTZ2sHjfME4svTw4uMLYvSM8ydAti0OBFDd240izDVsgoutFPHJXj2
a0HJ+VSE7XzKZC0HdjedFpmYLw+TSDGTflUvKkmv/3sN2qHv7sWXqa3kBmEdv2+X
87JmtkTT+E3qacx0aq+sZ20GH4XwZrVIar4Nc2sUx93U9ze9I2S1Be84+7knx+p7
OJmIP0cT9rpaqSBk7CzmEoVrKOqmFT9Tqi4lKbClKliiQamQlADrk9XWx0LWx6Nc
Xc9o2etlFyant/jcQHovUsD/d0tNZw==
=/NYd
-----END PGP SIGNATURE-----

--UGEvaVH8QWKmsHGN--


