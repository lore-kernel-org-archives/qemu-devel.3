Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBE7E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 14:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNBvj-0003Xq-4N; Mon, 16 Dec 2024 09:18:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tNBvd-0003Wl-20
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:18:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tNBva-00009N-MG
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734358708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MmDDrI/hohhb/qo/m+Rj/1STnR5VPrcfjcSicXhCwHM=;
 b=QjeOFdQRtWmP7uNTqmd2SaPd98QIp9nofPQb37AdKTIkSCmZYXgX4WWKhcYpLLDb1/jaUz
 fSeb11YozJ0gVWxhxcQ4qaZozsTyzkUz3QiiULhpLM0VX3ZTWR5W5P9RNZ0mPLg9EIROit
 tnPo1Z892eoxBOiSw7MuSj5OvtzpPdg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-UBI2_bdXMp6tnHMVB4PDrw-1; Mon,
 16 Dec 2024 09:18:22 -0500
X-MC-Unique: UBI2_bdXMp6tnHMVB4PDrw-1
X-Mimecast-MFC-AGG-ID: UBI2_bdXMp6tnHMVB4PDrw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7534C1956069; Mon, 16 Dec 2024 14:18:19 +0000 (UTC)
Received: from localhost (unknown [10.2.16.118])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E51131956086; Mon, 16 Dec 2024 14:18:17 +0000 (UTC)
Date: Sun, 15 Dec 2024 07:33:07 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, philmd@linaro.org,
 peter.maydell@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng,
 anjo@rev.ng, quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com
Subject: Re: [PULL 0/5] hex queue
Message-ID: <20241215123307.GA496091@fedora>
References: <20241213041836.39986-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="15NaFofls5spBMna"
Content-Disposition: inline
In-Reply-To: <20241213041836.39986-1-brian.cain@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--15NaFofls5spBMna
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--15NaFofls5spBMna
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdezIMACgkQnKSrs4Gr
c8h1DQf/V9snxwlF03uEHep5rQ4GlQKb/F14s3RloRwUS3EBnuNutf+nQabRSTTk
RW0RQXT+/pvZR0J5hEqiDMX1jGSXVc9+numdfUdr4iFN2o2tK+tkGWRzdco5nOGr
k0tVd+qRil/ZLh8e18/vUV2/AJ7ZXc2WHUFfAWmUBxgdSPHAOhu8X1UE4hljQjsT
LNylE5OHTkwLDPHgBR75AOxAJoa2/W++ynPFY+ZNSyl82gvlsrFtAt7i3S6YYerV
kAPdmrtvqzSaXhUsDofazFQqA4B7HDlGwoiMQAVv2egKvafb4IFBKRQ5S5/fO9mI
bwd3wMGrxTosm3t+SGP6W0Qldk8y6Q==
=hqzi
-----END PGP SIGNATURE-----

--15NaFofls5spBMna--


