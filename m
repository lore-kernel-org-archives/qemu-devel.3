Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB6EC44503
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 09:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whkhF-00009q-8O; Thu, 09 Jul 2026 05:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1whkhE-00009P-1V
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 05:05:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1whkhC-0003Co-KL
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 05:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783587926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rIKP4WlXKw8t1m5qsQXK/ofsOSirsCQyqlzpduqKTSM=;
 b=enZ8NBRAQ6XEggcobfXFohDk+hX7i6FhlhIBbWtXCPW6WlK9wJIjThdmml42kyYeSLv94v
 NpfDDq7vTnBOP1uSpEvIz44UHxyTz+dK2toCb7feXinFjur5KMSkpKVlF4zPuuv9Myex0/
 ccE1uzk89gvWbozHUsSXeLrOicqgLZA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-4g6JlS0OPkue-jZZOd5UbQ-1; Thu,
 09 Jul 2026 05:05:22 -0400
X-MC-Unique: 4g6JlS0OPkue-jZZOd5UbQ-1
X-Mimecast-MFC-AGG-ID: 4g6JlS0OPkue-jZZOd5UbQ_1783587921
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE4C019560BF; Thu,  9 Jul 2026 09:05:20 +0000 (UTC)
Received: from localhost (unknown [10.2.16.11])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5A3973692B; Thu,  9 Jul 2026 09:05:20 +0000 (UTC)
Date: Wed, 8 Jul 2026 17:32:34 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/6] tcg patch queue
Message-ID: <20260708153234.GA572387@fedora>
References: <20260707205810.303376-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IkAS1nFTKwWDSill"
Content-Disposition: inline
In-Reply-To: <20260707205810.303376-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 18
X-Spam_score: 1.8
X-Spam_bar: +
X-Spam_report: (1.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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


--IkAS1nFTKwWDSill
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--IkAS1nFTKwWDSill
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpObZIACgkQnKSrs4Gr
c8i5aAf+IyZJ39Mp9DUHdr6sAAzp2tgb03BiiumruD8v+T4uupFI8lkfHplTM80N
noW8Fvl0hzL4SOyj+juY7ySpfhp2VM+khpSuQtjkFOW5nV3PKct3cx2v2QyR49Lc
r4Ic3PzPtyZI6Ek0ePlg8FEe1+B8m4obZbl2NlFY3HK6mLNl/e+wYlrJg1igf0PQ
uwABbdqXLAtwXCr0eGTihx74cZkGE3rqmVll1XjmcmcGG9EaSq0VliTYDZlU8/LE
wPC9v5IGv87RpnjjSfJFfElI2cbFr8WK4nJPxT2CaEuZ8KsCCNcfZlCYJcV/1Kfo
I3J76IpzyTt1qbkwAC7ip+uIIWPWNQ==
=D3cE
-----END PGP SIGNATURE-----

--IkAS1nFTKwWDSill--


