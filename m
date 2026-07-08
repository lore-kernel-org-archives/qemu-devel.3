Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B0FC43602
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 08:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whNQj-0007xn-U7; Wed, 08 Jul 2026 04:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1whNQX-0007tQ-LM
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 04:14:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1whNQU-0003bM-IJ
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 04:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783498477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gr/NtAMKkAtI0NovEK3/FpbOxlYpwskMxXfENkOqR1w=;
 b=cK4U4eXp8LqlTLJwewlRNNOgKqYZ8ZVJqlRyw2HKBsSp7WXwalJ72EW0RIOxgyrStxTlVZ
 FgvAPb9AnSkQLiXMcpUN5dOYNAhNqcagGH/7Q2JIPLFHY8JybixvkWABwnpvmHo9V4cSxI
 i8sQyJxc8/Vq1v21XCNrwV7PyhN6sYA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-TaCU5on_MLudZRm6r8qQIw-1; Wed,
 08 Jul 2026 04:14:35 -0400
X-MC-Unique: TaCU5on_MLudZRm6r8qQIw-1
X-Mimecast-MFC-AGG-ID: TaCU5on_MLudZRm6r8qQIw_1783498474
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA72B195604C
 for <qemu-devel@nongnu.org>; Wed,  8 Jul 2026 08:14:34 +0000 (UTC)
Received: from localhost (unknown [10.2.16.35])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2C3F718001D1; Wed,  8 Jul 2026 08:14:33 +0000 (UTC)
Date: Wed, 8 Jul 2026 07:53:23 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 00/27] vfio queue
Message-ID: <20260708055323.GA553529@fedora>
References: <20260707062920.317302-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uGzKCQRm3tmMDw0Q"
Content-Disposition: inline
In-Reply-To: <20260707062920.317302-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


--uGzKCQRm3tmMDw0Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--uGzKCQRm3tmMDw0Q
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpN5dIACgkQnKSrs4Gr
c8iCAAgAkBnjFR4haHgnPDj+aRmVJxlc0GnvyN9S6zjukCLp4vr1mzD4T4Pw77Dt
1tn+Sc9d98AEonG55DT3mi/AQDYNJ5ehcbqybMgs4B2KB4qSijNyIJixg4hTZQem
MsHoAMtbjLmklBupuBoO+pklEzOPH16IuimUvxOVteLqMlJ9g7pMMpnN9QHs1NRv
zdfkiF6eAwQguDHhQ657RJGMMATWooV5eXs83VRd5d6KrB+uCJcxJQ0ztwZhyv8t
EThI5yhwSur5jM+wO4a2b14fws5C1w/hwrLnQz4REiwcqNQ/Ib16fvZR2PjL3alP
c/1znIn9cb+VMaJXfqrJbt2FB9elWQ==
=QTkt
-----END PGP SIGNATURE-----

--uGzKCQRm3tmMDw0Q--


