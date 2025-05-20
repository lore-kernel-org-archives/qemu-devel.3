Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297CDC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 14:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHNWo-0005oI-Ce; Tue, 20 May 2025 10:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uHNWm-0005nn-9O
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:01:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uHNWh-0006RY-CK
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747749660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M6qAKxXdncRTcXYVwtyYa9UW/kyXYPPYjM085agxNVg=;
 b=Hipkv7MQvK1xH/3zK4YgO1NrGP3yKsu54OCQUaqVJ9t2WgRy6cshurIrqp1iumP17GhilF
 eTEuT66iulPCcNqU/daME1YUacgoApgT8XA59Byve2md0jvrnJWPZgfiyqzKrPs44hEt7Y
 A/TGEerYMnOf9FDeLQ8zKSk6yqV2DB4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-eIRM1W55O0KgfVKvvbDe9w-1; Tue,
 20 May 2025 10:00:58 -0400
X-MC-Unique: eIRM1W55O0KgfVKvvbDe9w-1
X-Mimecast-MFC-AGG-ID: eIRM1W55O0KgfVKvvbDe9w_1747749657
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A0D01800995; Tue, 20 May 2025 14:00:57 +0000 (UTC)
Received: from localhost (unknown [10.2.16.246])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2166D19560AB; Tue, 20 May 2025 14:00:56 +0000 (UTC)
Date: Tue, 20 May 2025 10:00:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>
Subject: Re: iotest 240 is failing
Message-ID: <20250520140055.GB82528@fedora>
References: <20250311160021.349761-1-kwolf@redhat.com>
 <20250311160021.349761-21-kwolf@redhat.com>
 <a6b01ce7-e1a0-46bc-8c12-f3e439486f82@redhat.com>
 <8cb149ee-57fe-4e67-8ab9-f95244ebcb33@redhat.com>
 <a0d4dd1b-19e8-4b18-85c3-57f867993d69@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dkzpZjQjVb/GMvBL"
Content-Disposition: inline
In-Reply-To: <a0d4dd1b-19e8-4b18-85c3-57f867993d69@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--dkzpZjQjVb/GMvBL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 09:21:32AM +0200, Thomas Huth wrote:
> On 24/04/2025 11.39, Thomas Huth wrote:
> > On 26/03/2025 11.43, Thomas Huth wrote:
> > > On 11/03/2025 17.00, Kevin Wolf wrote:
> > > > From: Stefan Hajnoczi <stefanha@redhat.com>
> > > >=20
> > > > Allow virtio-scsi virtqueues to be assigned to different IOThreads.=
 This
> > > > makes it possible to take advantage of host multi-queue block layer
> > > > scalability by assigning virtqueues that have affinity with vCPUs to
> > > > different IOThreads that have affinity with host CPUs. The same fea=
ture
> > > > was introduced for virtio-blk in the past:
> > > > https://developers.redhat.com/articles/2024/09/05/scaling-virtio-bl=
k-
> > > > disk- io-iothread-virtqueue-mapping
> > >=20
> > > =A0=A0Hi Stefan!
> > >=20
> > > This patch seems to cause some troubles with iotest 240 in raw (and
> > > some other) mode:
> > >=20
> > > 240=A0=A0 fail=A0=A0=A0=A0=A0=A0 [11:41:33] [11:41:34]=A0=A0 0.8s=A0=
=A0 (last: 0.8s)=A0 output
> > > mismatch (see tests/qemu-iotests/scratch/raw-file-240/240.out.bad)
> > > --- tests/qemu-iotests/240.out
> > > +++ tests/qemu-iotests/scratch/raw-file-240/240.out.bad
> > > @@ -46,11 +46,11 @@
> > > =A0=A0{"execute": "device_add", "arguments": {"bus": "scsi0.0", "driv=
e":
> > > "hd0", "driver": "scsi-hd", "id": "scsi-hd0"}}
> > > =A0=A0{"return": {}}
> > > =A0=A0{"execute": "device_add", "arguments": {"bus": "scsi1.0", "driv=
e":
> > > "hd0", "driver": "scsi-hd", "id": "scsi-hd1"}}
> > > -{"error": {"class": "GenericError", "desc": "Cannot change iothread
> > > of active block backend"}}
> > > +{"return": {}}
> > > =A0=A0{"execute": "device_del", "arguments": {"id": "scsi-hd0"}}
> > > =A0=A0{"return": {}}
> > > =A0=A0{"execute": "device_add", "arguments": {"bus": "scsi1.0", "driv=
e":
> > > "hd0", "driver": "scsi-hd", "id": "scsi-hd1"}}
> > > -{"return": {}}
> > > +{"error": {"class": "GenericError", "desc": "Duplicate device ID
> > > 'scsi- hd1'"}}
> > > =A0=A0{"execute": "device_del", "arguments": {"id": "scsi-hd1"}}
> > > =A0=A0{"return": {}}
> > > =A0=A0{"execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
> > > Failures: 240
> > > Failed 1 of 1 iotests
> > >=20
> > > Could you please have a look?
> >=20
> > Ping!
> >=20
> > The problem still persists in QEMU 10.0 :-(
>=20
> Ping^2 !
>=20
> It's still failing. Could anybody please have a look?

Hi Thomas,
I will take a look on Thursday.

Stefan

--dkzpZjQjVb/GMvBL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgsixcACgkQnKSrs4Gr
c8hVnQgAk32ie8eW3Pddo78xhbi4UB8AxOV94iE90SujMuCPOlcd2kPt2EMR60TF
d1vtnfhOQiWdIYMZ/TUo0KDIgrWsdfuKZXgzykpp01AoYWelizgO+xA8AyWcE2P1
HFpCXeJgpoDRJ328l3eRFbCGgxMuwXBBgePq1CWvr9vmbAELNl+8e8qfYDUgAnH5
M7mQj/Rdi2d4TSs05JC5zViRYhGYPnkD+KNzXwhaRLDsarOmuiLsS1vAqBsYwooc
nOf5Z2q0CtKKfnmT3w0ei5m0U/nU6sbazPn25lziKOHtb1GY9p6sk6VecFhJRSTg
cKlZKrCZAbuToeX9uXtH3CkaLZR4xg==
=eaJO
-----END PGP SIGNATURE-----

--dkzpZjQjVb/GMvBL--


