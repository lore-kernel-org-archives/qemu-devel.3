Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8EBF9D0ED
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 18:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCiDn-00042w-R2; Tue, 14 Apr 2026 14:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wCiDk-00042F-H8
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 14:10:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wCiDi-0003Ji-1y
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 14:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776190240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hC3hglsIuuefdBh7fRgFEjFXTuExkwGdWlRP9pmdHkE=;
 b=W8H0gfYYSohLE/JM2Q49jPV6pDc6lq9vPSHJku+PDonCPgbpPR73G8a8dsiUSlH2wA1k19
 RjMpSmgTOM1/1V4C4Zxj+Ud73nSwlEpYkRpmtRsv7G9b/fO3t5aNRr15dDDCaYuleosBa6
 oOsCOpDY9I4gR+nGVFYUYlmh2d+dpIU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-CFQPMbZ6NfmOMUgk-Q8Q9w-1; Tue,
 14 Apr 2026 14:10:36 -0400
X-MC-Unique: CFQPMbZ6NfmOMUgk-Q8Q9w-1
X-Mimecast-MFC-AGG-ID: CFQPMbZ6NfmOMUgk-Q8Q9w_1776190235
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F4CA1955E7B; Tue, 14 Apr 2026 18:10:34 +0000 (UTC)
Received: from localhost (unknown [10.44.50.237])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E39F83000C1D; Tue, 14 Apr 2026 18:10:32 +0000 (UTC)
Date: Tue, 14 Apr 2026 14:10:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Matthieu Rolla <matthieu@minio.io>
Cc: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, kbusch@kernel.org, mr-083 <matthieu@min.io>,
 John Meneghini <jmeneghi@redhat.com>
Subject: Re: [PATCH 0/2] NVMe namespace hotplug and drive reconnection support
Message-ID: <20260414181030.GB136064@fedora>
References: <20260409060155.94704-1-matthieu@min.io>
 <ad0lMYOrRa-K1Ach@AALNPWKJENSEN.aal.scsc.local>
 <20260414124221.GB111076@fedora>
 <A0EE1F55-E562-4315-BE08-1D3CF70706AD@minio.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G1B6vQFpht2Pb12F"
Content-Disposition: inline
In-Reply-To: <A0EE1F55-E562-4315-BE08-1D3CF70706AD@minio.io>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--G1B6vQFpht2Pb12F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 03:36:19PM +0200, Matthieu Rolla wrote:
> Regarding `drive_insert`,  I found that `device_del` + `device_add` works=
 well when no filesystem is mounted on the namespace.=20
>=20
> However, when XFS is mounted (e.g. via DirectPV/CSI), the Linux kernel do=
esn't reuse the block device number (nvme0n1 becomes nvme0n2) because the s=
tale mount holds a reference to the old `nvme_ns_head`, preventing `ida_fre=
e()`.=20

Can you use the stable device names in /dev/disk/by-*/ instead of the
/dev/nvmeCnN names to access the new namespace? Then it won't matter
that ida_free() hasn't been called yet.

> This causes XFS "duplicate UUID" errors on remount.

(I have to admit that using stable device names doesn't solve this
because the guest kernel still potentially has multiple XFS mounts for
the file system.)

> `drive_insert` avoids this by keeping the namespace device alive which me=
ans no ida cycle, same block device name.=20

Are you sure this is safe? Even if PCIe AER somehow kills the old XFS
mount, then there is still a race condition between drive_insert and
PCIe AER injection when the guest kernel sees the new underlying storage
through the old XFS mount.

Getting this wrong could cause data corruption, so it needs to be well
understood. I don't really understand and would need to look at the
guest kernel code path. Can you describe what happens to the guest
kernel blkdev and the XFS mount in the drive_insert workflow?

Thanks,
Stefan

--G1B6vQFpht2Pb12F
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnegxYACgkQnKSrs4Gr
c8gisggAyJfV5TYOKMO/hGVCYRtoONXrSrG3G1KAUF4S3jxQFJbKMYA+2MoxgGZ/
hholuZW0n2UvnSC/JuXcYZlGSvyyS0/AYLEag97745zFyDb7s/aSEhYuqCgBaPLZ
QpV64jagzdTE55vbdI4pEP7/kky1rNn+HU6Og/QfScLTEMSdvlx63zihGRHmM+8J
12TDGEeQk5xlV3lO7G/holCsbaVvG7I/yyZPCFN9WxYZy7/X1fmxcFRQSMJ9DT4/
qn/9uHMV75Gpg0lBdik+5t4Qb92oJCv1vSUweo0G6DNyPD+sIbbwoP0CSovHGF7x
NKSi5nsct9DCHbdrwt+mDDSj8JIZkQ==
=QWqP
-----END PGP SIGNATURE-----

--G1B6vQFpht2Pb12F--


