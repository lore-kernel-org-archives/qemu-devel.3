Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDD3CD5BB0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 19:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ8wh-0007Nf-Ix; Thu, 21 May 2026 15:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wQ8wf-0007MW-3z
 for qemu-devel@nongnu.org; Thu, 21 May 2026 15:20:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wQ8wd-0004aL-LU
 for qemu-devel@nongnu.org; Thu, 21 May 2026 15:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779391234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qIu5zrdUY1Vwot66BDDfDoBso4OzVLnsf1ge2IG7NQU=;
 b=UNDSUV0BwleSdhxzxpiXBDz/JBl0TqjUEYQBP9iof9ZPuhZF/O9/6j1e9nWexuKDeGJpAq
 mB+/9SaDcn9yU6n12DHDeYMM0WnstwKeWCM5uZfZLle4mweXkdU+TOaM5Oa9H4im/fofEd
 /9rglqTbD5q5Ue2OEGLUs7PRpVlpvXM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-Ia2Zlsn_PgaACsTacEYJTA-1; Thu,
 21 May 2026 15:20:31 -0400
X-MC-Unique: Ia2Zlsn_PgaACsTacEYJTA-1
X-Mimecast-MFC-AGG-ID: Ia2Zlsn_PgaACsTacEYJTA_1779391230
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DD2E1956095; Thu, 21 May 2026 19:20:30 +0000 (UTC)
Received: from localhost (unknown [10.2.16.143])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 76C80300019F; Thu, 21 May 2026 19:20:29 +0000 (UTC)
Date: Thu, 21 May 2026 15:20:28 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PULL 00/29] Next patches
Message-ID: <20260521192028.GA1309157@fedora>
References: <20260520213357.40646-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3WTQ+GLh/NfHHjoa"
Content-Disposition: inline
In-Reply-To: <20260520213357.40646-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--3WTQ+GLh/NfHHjoa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--3WTQ+GLh/NfHHjoa
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoPWvwACgkQnKSrs4Gr
c8gBEQf/bVs9+r4iRJ2QQYV+1gWkdeldlz+1agXvrqrHAZMVEfwHxIrgnp23rEym
Ku+YZa9jXXRAs8h343PxKxdgPR9liQFV4cnACJIrUdByu5j2ZNvtdgBLJag7ts+O
mpvU9+MjORkw54LsmeXdMyFFYLCrbPS0gjyId7dOdHyYRV50fxnUxaJJwPA0AtTI
b91IFY8Hpwlxy+Pf+SBDtFbkbW/JaYXxo8vwOJtmupPaRkepurY1yzkE3Vl6I4p+
43bv2p/jEkeK5lLj8T0Vd/lQn7HdNJihyhNqHbzXglnmTktRdjJCv+SD0l47CLfa
2f14cBjjnl5SNoHBLalEhWBVrW/fzA==
=6sJ6
-----END PGP SIGNATURE-----

--3WTQ+GLh/NfHHjoa--


