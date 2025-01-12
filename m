Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA597E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 15:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX01d-0003iI-H5; Sun, 12 Jan 2025 10:37:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tX01b-0003iA-Ip
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 10:37:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tX01Z-00040v-TC
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 10:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736696231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FK0Lby4w7BGXF/teWMHEHtTqaeRXfWoXrEaYGIbAqZM=;
 b=LOG2W5Ygo7PKguqhf9xQsj39++5+8vs3yqCxkz0MEmQARbzflwvAa7ksyc3rOasFDq3vn2
 Vs9HwXct0b6afJVma/sjTpWjFa5BI7+7/5JUsEhfxVIvM29lX5Nik0lvr5uqsLFar38tyS
 b7Rt4hQ7TFQMdnkz/5eHnpGKkyLWK48=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-laq3CyRvNaSeBrYk5nHzBg-1; Sun,
 12 Jan 2025 10:37:09 -0500
X-MC-Unique: laq3CyRvNaSeBrYk5nHzBg-1
X-Mimecast-MFC-AGG-ID: laq3CyRvNaSeBrYk5nHzBg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FD551955D80; Sun, 12 Jan 2025 15:37:07 +0000 (UTC)
Received: from localhost (unknown [10.2.16.12])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 842831956056; Sun, 12 Jan 2025 15:37:06 +0000 (UTC)
Date: Sun, 12 Jan 2025 10:37:05 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PULL 00/11] QOM / QDev patches for 2025-01-09
Message-ID: <20250112153705.GA31002@fedora>
References: <20250109171948.31092-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kHibkCYk4BLp81K/"
Content-Disposition: inline
In-Reply-To: <20250109171948.31092-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.025,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--kHibkCYk4BLp81K/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--kHibkCYk4BLp81K/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeD4aAACgkQnKSrs4Gr
c8gRwAf/dPiB5xsxJCpwk5wWQz4G1TbTlZlGHKNA0I08MKkX4Ky2kKX0h4SX0Bk4
RwdWGTHri1SXtS4GQ8YB78Q+XEEjYO9bSvRPoQmzAD+yreZuZkInOjPZ1kru3/9D
9B41AQnpTXWWoQaOoUpb7r/kaPwZDQpDwSNMfR272HJ6tZPQVRjEwPP5rE4WiVey
9jPalqnaHoVvSK9MlFBe9hwWVVQzgm4xw4ZmJyxnZuJlPSd+xScimMizHOqt5D8E
M6xroIqG4KLF7Fsd0ebehtrjU2+MxVzyxCE/o5CousQys+jZ/qiP3HNKFS95Qbfi
AztWwjFpBE2WLVV1X2J3ECE5h5Sgmg==
=ATPB
-----END PGP SIGNATURE-----

--kHibkCYk4BLp81K/--


