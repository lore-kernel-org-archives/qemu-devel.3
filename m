Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F711CD6E44
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 22:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSN4e-0002Sj-43; Wed, 27 May 2026 18:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wSN4d-0002SB-CF
 for qemu-devel@nongnu.org; Wed, 27 May 2026 18:50:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wSN4b-00007j-I9
 for qemu-devel@nongnu.org; Wed, 27 May 2026 18:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779922199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hnR7l/B6RXnB/fwaqvhIvahzzhCRWB2ndp1PYJYqtHw=;
 b=Y9wojhvlSXa2qfxbjbtTlX6DhRr3qV2XgHzujdxkqspTC8hmU0VxLDA8Qcn/UZL0dXgMYq
 vFfoZIcp7e+V02TI9F8lGHZzBv/3oAhyfg0Q6sATlo5TQBIxG+a++vARkCG3zz5vytyFZJ
 8IP7y5fQ8lWC3XqT+LW+9OEo5lx8Gmg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-IPaKn0QwPIe8IzPPFDz2Xg-1; Wed,
 27 May 2026 18:49:55 -0400
X-MC-Unique: IPaKn0QwPIe8IzPPFDz2Xg-1
X-Mimecast-MFC-AGG-ID: IPaKn0QwPIe8IzPPFDz2Xg_1779922194
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 978DF1800371; Wed, 27 May 2026 22:49:54 +0000 (UTC)
Received: from localhost (unknown [10.2.16.38])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 028E41800357; Wed, 27 May 2026 22:49:53 +0000 (UTC)
Date: Wed, 27 May 2026 18:49:50 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/32] Single binary patches for 2026-05-27
Message-ID: <20260527224950.GA13366@fedora>
References: <20260527103037.4461-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DSAJDs/hHKwk49Hx"
Content-Disposition: inline
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--DSAJDs/hHKwk49Hx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--DSAJDs/hHKwk49Hx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoXdQ0ACgkQnKSrs4Gr
c8ibAwf9G6EqXfpgca7LA5aQToKJqsgmD2t1yUm3UNsFN6KsJbkD9MryWywJA+Q9
aLePle8ebb6Cn9dvZyVIB/LILbDv1RVP0Dwe2OYtjJDsPeBb+DV/p7EH/y3xAl3Z
R2yYOY1pvffecYfFStMoaaIvXY870pok/T4gQQwbMx4A19wRBFq7iTQVsHc1/S5j
sobUH+hc56c42uEeQjFRCMoW0lACWiZkdv3jQEvt71CP1VxYS4Qqr65SWO6TeqiU
jv6M5CYG6lxEoLPYZ1X1qJkgFBYkA2/CQsMYsMo55PzkkemPDzw3TAZxPEn2a1B/
0L1692kvIDdqtWsRkIj1v863WWU5vA==
=h+y3
-----END PGP SIGNATURE-----

--DSAJDs/hHKwk49Hx--


