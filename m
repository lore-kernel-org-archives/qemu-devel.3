Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7238BC02181
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 03:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbWqi-0006Or-Ky; Fri, 24 Jan 2025 22:28:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tbWqh-0006Oa-6Q
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 22:28:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tbWqf-0000wo-NZ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 22:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737775720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=av2Wsb4wLg5zUtmcbpmslmWmm08uhutkYzDRWn8LseM=;
 b=b6RacS5TaN9ASjLZ3rgs02NN3i2oJqC9gPPXJlo3Pxjvw1XLS9M/qpppDJWy9ZKbyS5XJV
 gBi5QxAhUz0pu1SsIBa1GLAVqvECX1XOjEhywcFpROFfCBmb0FKlzquLEeVorDuwcL6uzl
 ScN8Pj2n5KMUnNQHt4Os9IMLADwUPVo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-PkC9IDXENWmIHeDVi5A4Yw-1; Fri,
 24 Jan 2025 22:28:34 -0500
X-MC-Unique: PkC9IDXENWmIHeDVi5A4Yw-1
X-Mimecast-MFC-AGG-ID: PkC9IDXENWmIHeDVi5A4Yw
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4D1D19560B0; Sat, 25 Jan 2025 03:28:32 +0000 (UTC)
Received: from localhost (unknown [10.2.16.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DDE461800365; Sat, 25 Jan 2025 03:28:31 +0000 (UTC)
Date: Fri, 24 Jan 2025 22:28:30 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: deller@kernel.org
Cc: Laurent Vivier <laurent@vivier.eu>, Stefan Hajnoczi <stefanha@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PULL v3 0/6] Linux user fix gupnp patches
Message-ID: <20250125032830.GA287539@fedora>
References: <20250124130254.3134-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0qpUNiIx4A5L5jSM"
Content-Disposition: inline
In-Reply-To: <20250124130254.3134-1-deller@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--0qpUNiIx4A5L5jSM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--0qpUNiIx4A5L5jSM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeUWl4ACgkQnKSrs4Gr
c8jxEgf+M4HSiiQAoKn58kF3lN9Yg/yCFcZ/FvxK3CmJVw5c5ii+8ImJHfERHg6v
/ejDpTLUsWOgNwwB+nGIKWye5S7MeNturO6OXTmgtZbfhNYGNc5vn9ywz8SKjfaz
FfQ0P4++PpdMxX9eIZFkz7uEBDzi+5UJHPM6DMTLZQ4S4FA83U5zU19OsesiQU1P
ktVW0Jyz7YzD7Xnlpvl0UsuZo1vpPDzgs2eDWaVWEbUrMie4wH/2XP32Pcu7vopV
cc9502dJKbkIKrovAN4Z1EL8PqmVDZi1Rbp6mJp/rsy6LaM1CP1NabphzY7e1dst
lzLr5cViX3aTiVRSu5VABRbLvRDKww==
=6nNp
-----END PGP SIGNATURE-----

--0qpUNiIx4A5L5jSM--


