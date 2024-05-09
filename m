Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04B4C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 19:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s598W-00066x-HC; Thu, 09 May 2024 15:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s598V-00066Z-26
 for qemu-devel@nongnu.org; Thu, 09 May 2024 15:08:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s598T-0002LR-GV
 for qemu-devel@nongnu.org; Thu, 09 May 2024 15:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715281735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D0nJVNTYNSO3rP/57JjQec04SkH1V9JD+e/0xIboHp4=;
 b=hcJdiLBTxMbCvrruKQvfuwxvFeEax+4th0gePvgZZ3aZts9mIrM2WUAPGZbfPv1JPK1sGL
 hW51m564JeMNs/QLk0y7hvRKKdpdxr14IqBYSv/YmMY4sfGYmFym9f1WOaTPOZrDQPIGXi
 jvIhL4U7rf98imgGs9QJCcnRgSZHxSQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-moDWnITqPuGoeavzAOAIng-1; Thu, 09 May 2024 15:08:50 -0400
X-MC-Unique: moDWnITqPuGoeavzAOAIng-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B12D800A03;
 Thu,  9 May 2024 19:08:49 +0000 (UTC)
Received: from localhost (unknown [10.39.192.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CB3BFA055;
 Thu,  9 May 2024 19:08:48 +0000 (UTC)
Date: Thu, 9 May 2024 15:08:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org
Subject: Re: [PATCH 0/9] Support persistent reservation operations
Message-ID: <20240509190846.GJ515246@fedora.redhat.com>
References: <20240508093629.441057-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZFgGBumbi7if5klN"
Content-Disposition: inline
In-Reply-To: <20240508093629.441057-1-luchangqi.123@bytedance.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--ZFgGBumbi7if5klN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2024 at 05:36:20PM +0800, Changqi Lu wrote:
> Hi,
>=20
> I am going to introduce persistent reservation for QEMU block.
> There are three parts in this series:
>=20
> Firstly, at the block layer, the commit abstracts seven APIs related to
> the persistent reservation command. These APIs including reading keys,
> reading reservations, registering, reserving, releasing, clearing and pre=
empting.
>=20
> Next, the commit implements the necessary pr-related operation APIs for b=
oth the
> SCSI protocol and NVMe protocol at the device layer. This ensures that th=
e necessary
> functionality is available for handling persistent reservations in these =
protocols.
>=20
> Finally, the commit includes adaptations to the iscsi driver at the drive=
r layer
> to verify the correct implementation and functionality of the changes.
>=20
> With these changes, GFS works fine in the guest. Also, sg-utils(for SCSI =
block) and
> nvme-cli(for NVMe block) work fine too.

What is the relationship to the existing PRManager functionality
(docs/interop/pr-helper.rst) where block/file-posix.c interprets SCSI
ioctls and sends persistent reservation requests to an external helper
process?

I wonder if block/file-posix.c can implement the new block driver
callbacks using pr_mgr (while keeping the existing scsi-generic
support).

Stefan

--ZFgGBumbi7if5klN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmY9Hz4ACgkQnKSrs4Gr
c8jH7gf/XBLrD6n6OWiEALImlsnRkQpl216gtigx9w0AYrZwl5l8xCTWsGhaXdHD
J2NUokinI+ecleRBEKwj3qTuSekvmm3DyAbpFi1UQ73DEZ+PMFo80WIMmq9LZ5mA
XxKGoGs0adcPBNEbEjtz5Z4EjSa+L+m2TcNc7PpKXPiD6J6EjOtd0G/jwP8P6KYv
XU9LITYmC2ck6BBoR3tPlOUsPAHi9xfbLinGijZZdpJPuwqD3ZulYOL2Xl2Khe1a
a9vGK+DCqL4n6jFAJib1GGM+959q6ehxvH+59ZLo2u5vBqREtP/7lwskdTTribvQ
ZxTKATXaKiT46iJA2g7Jmm0sLwXNjQ==
=dIsX
-----END PGP SIGNATURE-----

--ZFgGBumbi7if5klN--


