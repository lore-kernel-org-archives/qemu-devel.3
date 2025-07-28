Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523A4C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 15:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugPeh-0007UE-0u; Mon, 28 Jul 2025 11:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ugPeX-00076G-3v
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:20:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ugPeU-0008OX-Mx
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753716033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vl7756uyXEJxcC/U1JeX/mRixLcnAc9SMVI0Q0uhgcA=;
 b=BprSAsJZ6SyyEdOTycVQri/CHhmOow8oErrg2hjWoP3ngD1K6rj1WXyF092AKcMNBupSk4
 5Ow1jpUphITn8eUk7FFvuylWhd6VVLXlAwBpPnnfoYeY4334YUjBN09KzEPx0Z41FAvHIs
 ZMjLE1O39O1EQXRZkxm89+07A/b3sVE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-a6cNHChIO2etPmwnKygu2Q-1; Mon,
 28 Jul 2025 11:20:31 -0400
X-MC-Unique: a6cNHChIO2etPmwnKygu2Q-1
X-Mimecast-MFC-AGG-ID: a6cNHChIO2etPmwnKygu2Q_1753716030
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73E5A180034A
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 15:20:30 +0000 (UTC)
Received: from localhost (unknown [10.2.16.147])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CEA321800242; Mon, 28 Jul 2025 15:20:29 +0000 (UTC)
Date: Mon, 28 Jul 2025 11:20:28 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 0/4] QGA documentation patches for 2025-07-28
Message-ID: <20250728152028.GA71344@fedora>
References: <20250728115116.2938867-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+911krlSHvTAgGXh"
Content-Disposition: inline
In-Reply-To: <20250728115116.2938867-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--+911krlSHvTAgGXh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--+911krlSHvTAgGXh
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiHlTwACgkQnKSrs4Gr
c8jcVwf9F3R4gppaWjk6ze0oTe9A+vaDFXOKDfVKG/Pt2MPmdEHMTV3eQHwS4c89
8pCHaUro5d16Lt52sEpVEZCkH2NPvSb3QmyDoFVWfIGKMcpvDYCqmNo7THJ7fBH3
q6KDqcKh7n/7raC94YZtrAhULWWEAza8UBuW7FXhta/yi/t7TthSBHLhAV8tiFdI
sjzsYcX3fUTIBn+Qfby30QVUEBMeIFPV7q4Q+6RlsP1ODED6WcWjn6dzZO++SMES
+zBncr1f56jI3SFFVdVT/T/zTSTTLRL8JNqZy/pmJIRDwT4+oOO4MnILfV77r/jS
2v5e/MNrvTT6S3VmDVOWlK+iv0UtsA==
=19SC
-----END PGP SIGNATURE-----

--+911krlSHvTAgGXh--


