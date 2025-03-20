Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A86C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 12:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvbTL-0007m5-6Z; Fri, 21 Mar 2025 08:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tvbTJ-0007lR-1n
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 08:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tvbTG-0004he-KY
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 08:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742560046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BnE34XkShg2fCAXYAPZUZCqM7eXGhnzXnv0QsGUv56w=;
 b=eRhnzFwhOWML80ct1CyYu4+CQlgI2pDII9q8TdBTIZ1Rcn1dWYnqSdd8bHQTjxXo8A58Ms
 W7/V580DB7x2lqd0r/s2V2WYbBcQzddNCv4OizApTR+hgtueUEWePW25N0TK/HtJWBPj81
 6U+cbCjqz101qMw+7wtdQ864BD8O3KM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-gnjryYGHNNqgcRI-v3-gFw-1; Fri,
 21 Mar 2025 08:27:23 -0400
X-MC-Unique: gnjryYGHNNqgcRI-v3-gFw-1
X-Mimecast-MFC-AGG-ID: gnjryYGHNNqgcRI-v3-gFw_1742560042
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED1AA1801A06; Fri, 21 Mar 2025 12:27:21 +0000 (UTC)
Received: from localhost (unknown [10.2.16.134])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 34E781801764; Fri, 21 Mar 2025 12:27:20 +0000 (UTC)
Date: Thu, 20 Mar 2025 15:17:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, fam@euphon.net
Subject: Re: QEMU Userspace NVMe driver and multiple iothreads
Message-ID: <20250320191746.GB2541643@fedora>
References: <0fe1ff1e-2388-453e-9fd9-b550b6be0c41@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="l9uerOyi60XZZC7j"
Content-Disposition: inline
In-Reply-To: <0fe1ff1e-2388-453e-9fd9-b550b6be0c41@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.332, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--l9uerOyi60XZZC7j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 11:13:04AM -0700, Farhan Ali wrote:
> Hi,
>=20
> I have been experimenting with the QEMU Userspace NVMe driver on s390x
> architecture. I have noticed an issue when assigning multiple virtqueues =
and
> multiple iothreads to the block device. The driver works well with a sing=
le
> iothread, but when using more than one iothread we can hit a problem wher=
e 2
> iothreads can update the completion queue head doorbell register with the
> same value within microseconds of each other. As far as I understand this
> would be an invalid doorbell write as per NVMe spec (for eg spec version =
1.4
> section 5.2.1 defines this as an invalid write). This causes the NVMe dev=
ice
> not to post any further completions. As far i understand this doesn't seem
> to be specific to s390x architecture.
>=20
> I would appreciate some guidance on this to see if there is some known
> limitations with the userspace NVMe driver and multi queue/multi iothread?

Yes, the block driver only supports 1 IOThread. The code uses
bdrv_get_aio_context(bs) rather than qemu_get_current_aio_context(), so
it will only operate in one AioContext.

Code changes would be necessary to support multiple IOThreads.

By the way, this block driver is experimental. There are several bugs
filed against it in bugzilla.redhat.com. It's currently only useful to
QEMU developers and I wouldn't rely on it for production VMs.

Stefan

> This is an example xml snippet i used to define the nvme block device
>=20
> ...
>=20
> <disk type=3D'nvme' device=3D'disk'>
> =A0=A0=A0=A0=A0 <driver name=3D'qemu' type=3D'raw' queues=3D'8' packed=3D=
'on'>
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0 <iothreads>
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 <iothread id=3D'1'/>
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0 </iothreads>
> =A0=A0=A0=A0=A0 </driver>
> =A0=A0=A0=A0=A0 <source type=3D'pci' managed=3D'yes' namespace=3D'1'>
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0 <address domain=3D'0x0004' bus=3D'0x00' s=
lot=3D'0x00' function=3D'0x0'/>
> =A0=A0=A0=A0=A0 </source>
> =A0=A0=A0=A0=A0 <target dev=3D'vde' bus=3D'virtio'/>
> =A0=A0=A0=A0=A0 <address type=3D'ccw' cssid=3D'0xfe' ssid=3D'0x0' devno=
=3D'0x0002'/>
>=20
> </disk>
> ....
>=20
> Appreciate any help on this!
>=20
> Thanks
> Farhan
>=20

--l9uerOyi60XZZC7j
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfcadoACgkQnKSrs4Gr
c8gBjAgAvqxEQcoaIR5ETmRV2cjlXbgP4MdzTrB9/7f9K++HJvyfJGqFaSdzjRam
1hn9psfEuaxAiNxKd3azQ5+HU4JHYH+sIa7p4Ruk4Ewqvs9khKJmxkNYh6QYDW6s
DqAR/QNZzogbKtLQ4bUDFFB77qYLeqn/VQOM1Jnx4h2YrBCMjvqlkT4KtC4eNoF8
x+iiXmM+8wkFF4U6w2KkGbSI2HNmSLhpkioKSoD9Bqvw1IhrVYchYW3BmRl/kmbs
ttg/EkONpr40pX8FOWdtOBzAgnkM2Md+kH58iBcNybRUMLKE09UXlXjUW5brIRKD
i/pnKT0UlqDcctFGfEuUw4vATb8NSw==
=IqED
-----END PGP SIGNATURE-----

--l9uerOyi60XZZC7j--


