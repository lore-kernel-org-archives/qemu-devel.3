Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732ECE95396
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 13:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnck6-00087w-7q; Wed, 04 Feb 2026 08:16:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vncjw-00084i-Uj
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:16:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vncjp-00017r-Sa
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770210968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A2VEJb8N1dPg3t1FRCvYZ2PFOYUkhFcDLv0JhHTU5AQ=;
 b=QvaicRYxTZNozv9+BJqRhLDuVTjYNGGsQgjfo6k7+FQfL6xM1QEE/aU+oNSmEk0ApRcBEy
 3zNtTQPssCY2O+xScZsz7ik2T3ohnoPf6zz5OBQlyEkrs2QJIWMAd4wYsXRCdPicvATZUZ
 0485VYKILen/sA7J/BaqgrbTGeKZa1A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-wh9ZBhHFObOhdFqzys1nxw-1; Wed,
 04 Feb 2026 08:16:05 -0500
X-MC-Unique: wh9ZBhHFObOhdFqzys1nxw-1
X-Mimecast-MFC-AGG-ID: wh9ZBhHFObOhdFqzys1nxw_1770210964
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4AFF1956051; Wed,  4 Feb 2026 13:16:03 +0000 (UTC)
Received: from localhost (unknown [10.2.16.22])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 032B31800464; Wed,  4 Feb 2026 13:16:02 +0000 (UTC)
Date: Wed, 4 Feb 2026 08:16:02 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Qing Wang <qinwang@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Hannes Reinecke <hare@suse.de>, pkrempa@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>,
 Alberto Faria <afaria@redhat.com>, berrange@redhat.com
Subject: Re: [PATCH v3 0/5] scsi: persistent reservation live migration
Message-ID: <20260204131602.GB591743@fedora>
References: <20260129212035.219676-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hUE8l+RUprBjQyXP"
Content-Disposition: inline
In-Reply-To: <20260129212035.219676-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--hUE8l+RUprBjQyXP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 04:20:30PM -0500, Stefan Hajnoczi wrote:
> v3:
> - Use warn_report_err() instead of suppressing errors [Daniel Berrang=E9]
> - Wrap lines exceeding 80 characters

CCing Daniel Berrang=E9 (sorry, I forgot!)

>=20
> v2:
> - Add user documentation [Paolo]
> - Send PREEMPT on the source if migration fails. This rollback operation
>   ensures the source regains access to the LUN even if migration fails af=
ter
>   the destination issues its own PREEMPT.
>=20
> Live migration does not work for SCSI Persistent Reservations acquired on
> scsi-block devices. This patch series migrates the reservation key and
> reservation type so that the destination QEMU can take over the persistent
> reservation with the PREEMPT service action upon live migration.
>=20
> The approach involves snooping PERSISTENT RESERVE OUT replies and trackin=
g the
> scsi-block device's current reservation key and reservation type. In most=
 cases
> this involves no additional SCSI commands. This approach isn't perfect: if
> another machine modifies the reservation on the physical LUN, then QEMU's=
 state
> becomes stale. Persistent reservations are inherently cooperative, so thi=
s is
> acceptable as long as real applications don't run into problems.
>=20
> I am also working on a test suite called pr-tests that runs sg_persist(8)
> commands across multiple machines in order to exercise various scenarios:
> https://gitlab.com/stefanha/pr-tests
>=20
> Stefan Hajnoczi (5):
>   scsi: generalize scsi_SG_IO_FROM_DEV() to scsi_SG_IO()
>   scsi: add error reporting to scsi_SG_IO()
>   scsi: track SCSI reservation state for live migration
>   scsi: save/load SCSI reservation state
>   docs: add SCSI migrate-pr documentation
>=20
>  docs/system/device-emulation.rst        |   1 +
>  docs/system/devices/scsi/index.rst      |  10 +
>  docs/system/devices/scsi/migrate-pr.rst |  54 +++++
>  include/hw/scsi/scsi.h                  |  15 +-
>  include/scsi/constants.h                |  21 ++
>  hw/core/machine.c                       |   4 +-
>  hw/scsi/scsi-bus.c                      |   3 +
>  hw/scsi/scsi-disk.c                     |  90 +++++++-
>  hw/scsi/scsi-generic.c                  | 291 +++++++++++++++++++++++-
>  hw/scsi/trace-events                    |   2 +
>  10 files changed, 476 insertions(+), 15 deletions(-)
>  create mode 100644 docs/system/devices/scsi/index.rst
>  create mode 100644 docs/system/devices/scsi/migrate-pr.rst
>=20
> --=20
> 2.52.0
>=20

--hUE8l+RUprBjQyXP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmDRpEACgkQnKSrs4Gr
c8gzRwf/b1eqPwjmM1IjisMIPLVd+lh2DYuSDA5T0UctUO85dBOvzd5m6LD2qGxm
8KTzB1Rw9mepqsl+2q5Fqw1zMJ8+xoP1Ql18ruKrWjwXVFJXGFXQhgs0TsaXU0t4
1O1Eskym1ccPUNmoWbeZwrCWt/59QwU6d7USnz5IiIZ2HBpRYPMoHW7Q4Ao8KDsA
LY3E7RPMtVWfJUH3TGigMzCjnz5PPmJ0tbM9cqMlp5wqIA7DFZlin6j1CJ+0iSYU
C718KFe58OvjgZNw+7S7jD+zQA0tfWnLqfXOn3jWmo8/fRTZ78351t+sEmA6WuVG
Emzv5RF9UpwjtI697maApjTXu51O2g==
=8JEL
-----END PGP SIGNATURE-----

--hUE8l+RUprBjQyXP--


