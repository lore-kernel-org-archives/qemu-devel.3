Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8039CC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 18:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udvIf-00072f-7V; Mon, 21 Jul 2025 14:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udvIW-0006m1-5h
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 14:31:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udvIU-00059r-9D
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 14:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753122689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BNQjPdX1NsBkrl82keyrJXhotThwZ0d9lqr7zxNvhLw=;
 b=E1elomdHuhXLKDY3CohCogIh6fXcYnFaOlhJMFlXbqe9fv738Glbzp8jaHq5G/Xp3UJoVZ
 WloG8Hv+THdMCmRLw7nb+0Ig0usLntvyv1po35JiX0Ld5HoGQkQysaf+M+1852zFHxq+bz
 1oLAYhSrj3nKnaySBOf7VxshuVW0aCs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-3G3PzJvYPWufwVVTpmoFuQ-1; Mon,
 21 Jul 2025 14:31:26 -0400
X-MC-Unique: 3G3PzJvYPWufwVVTpmoFuQ-1
X-Mimecast-MFC-AGG-ID: 3G3PzJvYPWufwVVTpmoFuQ_1753122685
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3537C1800872
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 18:31:25 +0000 (UTC)
Received: from localhost (unknown [10.2.16.31])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 70CC4195608D; Mon, 21 Jul 2025 18:31:24 +0000 (UTC)
Date: Mon, 21 Jul 2025 14:31:23 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PULL v2 0/4] Misc crypto & UI patches
Message-ID: <20250721183123.GA77943@fedora>
References: <20250721104536.2856423-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dB+VIcIMRAnoJbpc"
Content-Disposition: inline
In-Reply-To: <20250721104536.2856423-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--dB+VIcIMRAnoJbpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--dB+VIcIMRAnoJbpc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh+h3sACgkQnKSrs4Gr
c8hSsQf/Tp1RL4uyDdX0QzmX8Js0I7CRMVW3Kdah3aXd8/mngrK/C3m773HGiUK1
/mqKmuEQkZz0778jJcgw5i6NIfNVrXKs10JvzZ6WrkYynModqv6k5dGc76gSqdKk
4jHAdYN0IAeMLvSb7fKBGu993KczVi7TJSbCNflDEbnCawsq0NRFIpLpz+hTmDPG
SVGLx2TiGsvsK0Pf5go69qvtESP99Rb+6G6d6lgiVwCvzkJCqo9vmUDY2xvauhg+
0eZf+39mB/PmsCbEAXk1OD37TAg7dZBu4T/k/MQOq3uC3HXrcFXtMQA3OFdj5881
92myLKiB3cW08TOJx+jKYxMJzzfNuQ==
=reuv
-----END PGP SIGNATURE-----

--dB+VIcIMRAnoJbpc--


