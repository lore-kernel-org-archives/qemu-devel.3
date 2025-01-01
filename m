Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB156E77194
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2025 23:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tT8M2-0006bQ-KW; Wed, 01 Jan 2025 18:42:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tT8M1-0006bC-5h
 for qemu-devel@nongnu.org; Wed, 01 Jan 2025 18:42:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tT8Lz-0001Ng-BC
 for qemu-devel@nongnu.org; Wed, 01 Jan 2025 18:42:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735774936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6fRaYKxuVYEJ7YR6ywLrcg7SW+54enuc73yufmA14No=;
 b=MnE2ZGUfL2F1PeVBD9GGN79q6F3E8RB3qOWstRBWgOk2Hs9ur0lwRPwkotdBtSY+rIW0Wr
 uscS3rvt6xjjOiaFce9s3mNxzzZsLAk/kqAN/5aj/sY1ifMAmotpcdOHoM2akYf684rtVO
 y7fquoeV/T6RkTaR+Y7Suv3U6PT4CWA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-RdgUeDK5O6-RUrB_eeHBvg-1; Wed,
 01 Jan 2025 18:42:11 -0500
X-MC-Unique: RdgUeDK5O6-RUrB_eeHBvg-1
X-Mimecast-MFC-AGG-ID: RdgUeDK5O6-RUrB_eeHBvg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F183219560A2; Wed,  1 Jan 2025 23:42:09 +0000 (UTC)
Received: from localhost (unknown [10.2.16.27])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5637819560AA; Wed,  1 Jan 2025 23:42:09 +0000 (UTC)
Date: Wed, 1 Jan 2025 18:41:36 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PULL 00/29] Misc HW patches for 2024-12-31
Message-ID: <20250101234136.GA1197496@fedora>
References: <20241231202228.28819-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IfpivrAYrttXfleP"
Content-Disposition: inline
In-Reply-To: <20241231202228.28819-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


--IfpivrAYrttXfleP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--IfpivrAYrttXfleP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmd10rAACgkQnKSrs4Gr
c8hJVgf/dFJ/+H9IPl2HJmMhopFtzdV3RcxU60Ouggx+Gcj6eRz50dXGQCV0D4nJ
vFn3179kCPhYLBPcLcespso7ER6xrWG7VLJ4iB4mSmhkl2oAZgUl2P0TmwpFGEO1
tYcnT91LsFYCN+uRrdikSw/DPjxzTR/CgNjW6RBDsE7UDQRoCbKEggxnWKTc1wD1
Cq8JlBzV1OACn6YAOpYbybsb5l71+RECs0uhFl7XMPbAzDSw6oG12VggDQ6+cfrU
k5TdZKWT2xyhTzSKhRoVhK3PbqJCsktnR6RPPloVSrNBMHQk53wo7DPC2dBC8T1v
N7QtTBPtYfnIi4yFynmQ4Rtvknnygw==
=yaB8
-----END PGP SIGNATURE-----

--IfpivrAYrttXfleP--


