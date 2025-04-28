Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510D5C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 17:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Sjg-0004gq-Bh; Mon, 28 Apr 2025 13:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u9SjA-00048E-Ra
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 13:57:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u9Sj9-0001ap-2Z
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 13:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745863030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rmwj2EjMkXtakJCL7mw7L/jf7HGjC2WHaGOIjksrjec=;
 b=H80XhYSVCke74+rNSoDXInyb5C4mYZcTIrzk1Ivfn6HTck8N5BKrHReXHUO29YzZSazVaV
 BK9miPpRC/2bmn/kXmUG4GxuFc2ZWNaHByo2V3gVwhOC71OGqU+K0Mkn0zVLW0muYsBYIa
 Jr7LmEJpBFKdfoLr4I1ehXaNnTf2iKk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-9YUNjgCMO-S1H2fp1t-9RA-1; Mon,
 28 Apr 2025 13:57:03 -0400
X-MC-Unique: 9YUNjgCMO-S1H2fp1t-9RA-1
X-Mimecast-MFC-AGG-ID: 9YUNjgCMO-S1H2fp1t-9RA_1745863022
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F0D1180120C; Mon, 28 Apr 2025 17:56:55 +0000 (UTC)
Received: from localhost (unknown [10.2.17.24])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1C0A919560A3; Mon, 28 Apr 2025 17:56:53 +0000 (UTC)
Date: Mon, 28 Apr 2025 13:56:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PULL 00/58] Misc single binary patches for 2025-04-25
Message-ID: <20250428175653.GA634450@fedora>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Atk5PG9FvaF6Ze8e"
Content-Disposition: inline
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--Atk5PG9FvaF6Ze8e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--Atk5PG9FvaF6Ze8e
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgPwWUACgkQnKSrs4Gr
c8jctAf9Gg8tUW05XqTfPGVzNI3BSmo8kIXJwF9BAYsyjUGJxgg4JMHWFaDAvqHY
IRy1VX2/fJxeb9HpoKm4yWDdPn178vAdFCDtHzGJgZn++LCbRzMAu5fJ3UWQvUmI
BHo53sY95rY5zIbe3d2aufee6STxL9dZQOXjjOTwA2N5j9zVyah/puo6dxL0Wv8D
imDKtRNmSiJk4mz4RZaF4wzPgRRckk6FmJxfNwhEwE6AECYEo33zKGBgwpIf4RsX
a0R8GFchYmDgfnOKPHKwEFD8OYtHN+tskoO/4T3P0jkucs4jaM/AAIpzKDd2RvGQ
2Cm/pbdDkB5PMTNG7vnODjXG3MQwCw==
=svac
-----END PGP SIGNATURE-----

--Atk5PG9FvaF6Ze8e--


