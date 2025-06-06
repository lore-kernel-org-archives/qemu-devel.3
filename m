Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8045EC61CE7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 19:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNcfH-0003aU-NB; Fri, 06 Jun 2025 15:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uNcfC-0003a9-Go
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 15:23:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uNcfA-0004xA-H7
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 15:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749237810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TLjQOizuILz2P45uzS1OiMOxo7DibcaAYI1EV02vLTc=;
 b=ddYBzpb/LwHf0hyViiKPNKC0Mz6d7a1K1sUkUV8wk3jNB8czU368Lt8lvItPwOM9qm0IzA
 sKQi9ZfD7vySzZluDYJ81TeBv5LRFZQqhVUNL7J9oueNChOc+AvmJtO8m/4Ikn129hEIbx
 ap1tlYJFj20lOs8fP3S9ZxsBrVVFZFA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-FdSleGe6Ne-bWPBGAQ0_Ow-1; Fri,
 06 Jun 2025 15:23:27 -0400
X-MC-Unique: FdSleGe6Ne-bWPBGAQ0_Ow-1
X-Mimecast-MFC-AGG-ID: FdSleGe6Ne-bWPBGAQ0_Ow_1749237806
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5D8A1800DA5
 for <qemu-devel@nongnu.org>; Fri,  6 Jun 2025 19:23:25 +0000 (UTC)
Received: from localhost (unknown [10.2.16.87])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B2811956087; Fri,  6 Jun 2025 19:23:25 +0000 (UTC)
Date: Fri, 6 Jun 2025 11:27:56 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/31] Threading, Rust, i386 changes for 2025-06-06
Message-ID: <20250606152756.GA524514@fedora>
References: <20250606123447.538131-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MJ3dJ55OQjnUokKo"
Content-Disposition: inline
In-Reply-To: <20250606123447.538131-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.104, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--MJ3dJ55OQjnUokKo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--MJ3dJ55OQjnUokKo
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhDCPwACgkQnKSrs4Gr
c8juQwf/Vcpz88jLmvAHPyYhaROYyUXGhlx005mrQRNRztPkNn8iS1ksToBKKv3S
lp5TxH9h9ejZUpmOfieYuJMKCQxQVdsOGjL1lm4yzXS/FUN6ERvAOsz7imqfKU9f
doIlhIQGjpW7zF2rcWkSH69Ry4xZF8cHoeDzjneYVh1FF9Idj2AAjNi3x9K79iXA
VcP9NtMFmkh0Xrdfy0hgscdcnoGvKO/vzPC0yugxo7oj+A+fpRBLpq00ioOSglP/
H0OpPXzut8osUd82498v3wDnl58ZexEye9l0BtQUbDiZtIunCdayEl9eXqHx7fc8
YdTMKw2wLEncgyv9Mzizl0/FmchOGA==
=uTwO
-----END PGP SIGNATURE-----

--MJ3dJ55OQjnUokKo--


