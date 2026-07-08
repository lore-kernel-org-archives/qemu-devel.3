Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAB9C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 08:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whNR1-0008Ur-Pg; Wed, 08 Jul 2026 04:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1whNQk-0007zn-Rt
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 04:14:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1whNQj-0003dq-FV
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 04:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783498492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AeEyo8uCc0SIZfhWFtRFTP4x4eeomAR0KfoXIMaEuD8=;
 b=WrZH6ho2xN1OmVHX0/TQ+IQ6A/pbEh88lRPlin2HuUqArkfx0pYyho21FzZN9B4PKpVBeC
 KsS59TqwW0pwsDw7g3z7Y3dHrUeiUlIo00bCo7rUGNf6TTpmAv4FbOlIs7nHDvNqiXnk0x
 0PyI7oDJJ7Er0dSV7Y9F5FQSPPtQoGc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-7v7FvmYoNoWP9l5wguiYxg-1; Wed,
 08 Jul 2026 04:14:49 -0400
X-MC-Unique: 7v7FvmYoNoWP9l5wguiYxg-1
X-Mimecast-MFC-AGG-ID: 7v7FvmYoNoWP9l5wguiYxg_1783498488
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 253F51956062; Wed,  8 Jul 2026 08:14:48 +0000 (UTC)
Received: from localhost (unknown [10.2.16.35])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 83F2538590; Wed,  8 Jul 2026 08:14:47 +0000 (UTC)
Date: Wed, 8 Jul 2026 07:54:23 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL v2 00/36] Misc HW patches for 2026-07-07
Message-ID: <20260708055423.GA553721@fedora>
References: <20260707151351.57769-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DPpfk6bX2LvSWT1H"
Content-Disposition: inline
In-Reply-To: <20260707151351.57769-1-philmd@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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


--DPpfk6bX2LvSWT1H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--DPpfk6bX2LvSWT1H
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpN5g8ACgkQnKSrs4Gr
c8g93Qf9EvhxEzqt+uvLuDkMXJOYbVoZuw/1Q7J7XvmSRjIF1pzvz6FAhfkwnjYw
AmGMH2wSjzhlp4Vso6czW08CftPfnesSI+OmJEj2QaAZGT4ThJG6MESmOS+cqhnj
95wmWkbtxG0aIgJth1wy3cr7DsZH8pHybk70mSfLAOE10t6LKUoFTO4q6j1Rvef9
L7HRVhfHMYh7ZpYGxI1ZoKOg8Z6zg/fc4AxbyLs89V6pVODh47EnbIYbElEcD1hz
4K8Qk+qYW4mH4OF1zHSpuP/ARzfYY2R+6yriOPzXUjc0Lz6q5KOsKhkgMgzhmCac
ABXpficRg08Usiy21e8NNWEgTLo24A==
=VI2v
-----END PGP SIGNATURE-----

--DPpfk6bX2LvSWT1H--


