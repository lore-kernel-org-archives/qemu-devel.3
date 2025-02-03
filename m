Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87879C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 18:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf1AK-00016e-Jc; Mon, 03 Feb 2025 13:27:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tf1A2-0000zA-Bx
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:27:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tf1A0-0002im-V8
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738607223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=oq64Ig4Gvc2/8hK+c/HYV0j4i0y/I+sBahsIe9f0NN0=;
 b=ibY3UKBdIA4Jt+obRxKo491zKSV3H7UUYd34Ak9VewI1E0WiC0g5GWMaDt2A/OHDdJfcrx
 bH1XJWoC7ZEC1NnHOjO3xVC1nYGYmt9bbcnukonOrJ6iZWQnjfxOn4/PSpkMpS37rACz7B
 BMPu8bQtTX0MSGXePCAHsXpi48bTa7I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-m-ZWbgoZPTa5_mcmopwZRw-1; Mon,
 03 Feb 2025 13:27:00 -0500
X-MC-Unique: m-ZWbgoZPTa5_mcmopwZRw-1
X-Mimecast-MFC-AGG-ID: m-ZWbgoZPTa5_mcmopwZRw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10EB4183047D; Mon,  3 Feb 2025 18:26:55 +0000 (UTC)
Received: from localhost (unknown [10.2.16.131])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 729EC1977024; Mon,  3 Feb 2025 18:26:53 +0000 (UTC)
Date: Mon, 3 Feb 2025 13:26:52 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: nirsof@gmail.com
Cc: qemu-devel@nongnu.org
Subject: qemu-iotests 302 failing
Message-ID: <20250203182652.GA268514@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6cCcwyW2l+2BC5gH"
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--6cCcwyW2l+2BC5gH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nir,
qemu-iotests 302 is failing:

  $ git show
  commit 6fccaa2fba391815308a746d68f7fa197bc93586
  ...
  $ python --version # on Fedora 41 x86_64
  Python 3.13.1
  $ tests/qemu-iotests/check -qcow2 302
  302   fail       [13:16:45] [13:16:45]   0.5s   (last: 0.5s)  failed, exi=
t status 1
  --- /home/stefanha/qemu/tests/qemu-iotests/302.out
  +++ /home/stefanha/qemu/scratch/qcow2-file-302/302.out.bad
  @@ -32,5 +32,10 @@
   Images are identical.
 =20
   Kill NBD server
  -=3D=3D=3D OVA file contents =3D=3D=3D
  -[{"name": "vm.ovf", "offset": 512, "size": 6}, {"name": "disk", "offset"=
: 1536, "size": 393216}]
  +Traceback (most recent call last):
  +  File "/home/stefanha/qemu/tests/qemu-iotests/302", line 118, in <modul=
e>
  +    tar.addfile(disk)
  +    ~~~~~~~~~~~^^^^^^
  +  File "/usr/lib64/python3.13/tarfile.py", line 2262, in addfile
  +    raise ValueError("fileobj not provided for non zero-size regular fil=
e")
  +ValueError: fileobj not provided for non zero-size regular file

Any ideas?

Thanks,
Stefan

--6cCcwyW2l+2BC5gH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmehCmsACgkQnKSrs4Gr
c8h5Fwf/W9KC0BqePzmZNEXF/EuHVXBVx6r3e+VOKWbhuA0t05tEbiGK4Wyb615V
7///p1LNi4GDOZI3mMPd10gh+0qtTZSQ3dleB7jTzuG25dLfQAcOr49N8y2PxVVO
Zn2eiaroh/ueAbmOVDgvcVODl2jrmFYmXsuXEa9zUdQ2PvT2/P1ERdYIfSE/nh8R
lYonorKpb6yWpJXh2w/0YQI+MV5CxgM0WZOnvsk8xeFWpbcQijpMUKwuodc7FqVm
PL5NreOoxMKlryAwcPoEswtec7/WHbQZM10FWAf3iXFQbVNHwdI/0G/xkl7IiXBF
t01OmzkJvuZAfDhSTwGoVYYkF2k+JA==
=GVrn
-----END PGP SIGNATURE-----

--6cCcwyW2l+2BC5gH--


