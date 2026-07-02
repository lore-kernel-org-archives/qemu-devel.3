Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11C6C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 05:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfW1R-0007Fh-V7; Fri, 03 Jul 2026 01:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wfW1P-0007FU-15
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 01:01:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wfW1N-00076c-KM
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 01:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783054859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gj1h4aqTMqklydgomnALwCo4Zptglih8XAoQ6YGvqhc=;
 b=WUKlSF4FpVoAGV+ICIjZDLlZDgCRrVkgYyU7L5gyzNFvOjcZQNNNg3GGiNaud5cCda/Ecr
 TxyA9FJmY5uh0wENiGePCW7w/MV0+LWZaZwa85MzSdGeYddfhc7nsQ0ILCdbkSLDiDVLde
 cmIjyjY3X9U0cGvKdLzhGXguVp7NOxc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-R3VxHDjSPhmFsWJ2Wg8B_g-1; Fri,
 03 Jul 2026 01:00:57 -0400
X-MC-Unique: R3VxHDjSPhmFsWJ2Wg8B_g-1
X-Mimecast-MFC-AGG-ID: R3VxHDjSPhmFsWJ2Wg8B_g_1783054857
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDC8718CC4AA
 for <qemu-devel@nongnu.org>; Fri,  3 Jul 2026 05:00:56 +0000 (UTC)
Received: from localhost (unknown [10.2.16.24])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DDD2D30030D1; Fri,  3 Jul 2026 05:00:55 +0000 (UTC)
Date: Thu, 2 Jul 2026 20:49:30 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [GIT PULL 0/8] Dump patches for 2026-06-30
Message-ID: <20260702184930.GA439863@fedora>
References: <20260630-dump-v1-0-7df3087dffc9@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Jv3DXxvj37KaT7zA"
Content-Disposition: inline
In-Reply-To: <20260630-dump-v1-0-7df3087dffc9@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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


--Jv3DXxvj37KaT7zA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--Jv3DXxvj37KaT7zA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpGsrkACgkQnKSrs4Gr
c8jC8wf/XWU6tzwgfyaUDYSo+o6FLLmrHX7tv4sFgfZWlpdNQ5JdjAgII974p1z2
eSXaqRv+tEEN1/anPvXxSW4YI3FX/k929nURE2WhrstBLL7nWzqGa/hpKCyRIbgF
1gkRUutZMKFRtZoFEMXW8yUrV9rqF73Kp/Lk/6IguO0vQNq6JAW2+LURuCswjqV6
75fAYQY3k6myzU2y47BV4ZphvsL7rBDK7fRhnNt0mUOWv5ksj7GJN0GEhyWWiJcN
GWXf4G/m4I1dJEKbT3k9M7vrHlPjUGCk/Z0hsOwJii4vFl0p15gF+nzejqQwRY94
cPFDlQ6vna76f2EMcwiZone4OHmdSw==
=kliY
-----END PGP SIGNATURE-----

--Jv3DXxvj37KaT7zA--


