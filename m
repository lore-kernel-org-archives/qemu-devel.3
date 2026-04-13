Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED77DF34C78
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 17:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCKwE-0001aC-7U; Mon, 13 Apr 2026 13:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wCKwD-0001Zt-65
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 13:19:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wCKwB-0005Wu-5p
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 13:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776100741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6LzxU4YHZUM8BM6AOLCu0wCognEC2MYJVQf5Jl0xX4s=;
 b=goGTmBhsPtnOZhb/Fa5HZNevhAXgg+KHVJhz7dANMt4G4FDM1mwfZaOfb5QIx5lYd+zt5t
 5+YshonVsrGcTGBEIpKbQ4BDltT2RcjEl+mLaxbVau+FkwYrACB9ucxTqZszORUmIqoGJO
 rPOy+c+/Eutdh6wR68tuB3DgVh2r4wQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-M1Zt-HuCNamrc2jBvjSsJA-1; Mon,
 13 Apr 2026 13:18:56 -0400
X-MC-Unique: M1Zt-HuCNamrc2jBvjSsJA-1
X-Mimecast-MFC-AGG-ID: M1Zt-HuCNamrc2jBvjSsJA_1776100734
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5934219560BC; Mon, 13 Apr 2026 17:18:54 +0000 (UTC)
Received: from localhost (unknown [10.44.35.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5728D18002A6; Mon, 13 Apr 2026 17:18:52 +0000 (UTC)
Date: Mon, 13 Apr 2026 13:18:51 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Matthieu Rolla <matthieu@minio.io>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3] hw/nvme: add namespace hotplug support
Message-ID: <20260413171851.GA42769@fedora>
References: <CAPSO8MwceccK3gHgbeZi0A9=p8B9VV85whYmN1D343gV=9PucA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uVynRK3CCs5Kc/T5"
Content-Disposition: inline
In-Reply-To: <CAPSO8MwceccK3gHgbeZi0A9=p8B9VV85whYmN1D343gV=9PucA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


--uVynRK3CCs5Kc/T5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 04:13:38PM +0200, Matthieu Rolla wrote:
> Hello Stefan,
>=20
> Thanks let me know how it goes.

[Resending to qemu-devel so others are aware too.]

Hi Matthieu,
Windows Server 2022 Build 20348 successfully handles NVMe Namespace List
changes with your QEMU patch.

When adding the disk a new drive appears as expected.

When removing the disk the drive disappears and there is a Windows Event
Log event about a surprise removal. Windows probably has a procedure for
safely removing drives, but this basic test seems like enough
confirmation that it is working.

Drive letters are preserved across hotplug, so I think everything is
working as expected.

Stefan

--uVynRK3CCs5Kc/T5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmndJXsACgkQnKSrs4Gr
c8jodAf+N4I3WvebVSFwlHI3lsXHLgLeaF9M0goznZy21v3UGQDGWtC6RGxQST8z
srUQ0it9zIN1jpWkZ/R8j26UG5g0JfD8AHyqKw3E2puTWNSLaRsUEDxGCtTGCdRe
3sqnkMkOz4YLfjAYjOJdQRoIp5hBqkoYJMI9krWbCpJeAelhmmSrpok3ZVPqR9ET
ciiFNgh/5RPUnmRTtEzNDMbM/WhY/knA7hEEXK/OYE6ZN9Qkb3vTGyFywpDFs5iL
mdg9K3+vL4iOAgECAnKo5KR3BBgOoTXk7kYR9LRFDaPn7kdpVS1k7sbKUgUWRlYv
l9g9SPtpogNF7IKtGUcYT79gejzyAA==
=mL7b
-----END PGP SIGNATURE-----

--uVynRK3CCs5Kc/T5--


