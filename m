Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3649AE77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 01:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLuQu-0000wC-JL; Thu, 12 Dec 2024 20:25:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tLuQc-0000nA-I7
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:25:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tLuQT-0003DL-RP
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734053103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BRuoOOvfoopQHQHT5zoPYLMER72/G9DJuMMfCqbfZsY=;
 b=NY3etao2AS4bp1Jx35ZhBbz3YoBxMyBLPIBUogzrhl9QlC95LjK3yh5AzZGxKLvFbgCr6b
 t0vY9pl7eO3gCv3qN54ExzSIVQFtdQ1YWcY9hQfINxBtXV8VBfT0IXTii+O69fIYr0gWjq
 87YBc0mTVabSI3OM5NDDR8ZZ1OzlSXI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-Lu5kY-KGN-6WpzNwXTcsfA-1; Thu,
 12 Dec 2024 20:25:02 -0500
X-MC-Unique: Lu5kY-KGN-6WpzNwXTcsfA-1
X-Mimecast-MFC-AGG-ID: Lu5kY-KGN-6WpzNwXTcsfA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66057195608E; Fri, 13 Dec 2024 01:25:00 +0000 (UTC)
Received: from localhost (unknown [10.2.16.40])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ECA33195394B; Fri, 13 Dec 2024 01:24:59 +0000 (UTC)
Date: Thu, 12 Dec 2024 20:20:55 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/72] target-arm queue
Message-ID: <20241213012055.GA395412@fedora>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0iW8fVa7Udk0NOC6"
Content-Disposition: inline
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


--0iW8fVa7Udk0NOC6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--0iW8fVa7Udk0NOC6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdbi/cACgkQnKSrs4Gr
c8ivyAf+OH87KK9yo35QX2Kf3vf66xhL6JvqoRKfuRL1QL3UJNmGYaXTq2k7I4tN
6/ndg52qqoKIzSOUJBWYRIhwavGxLHTbx8NfaarfMSK4S1ikiWWceDOdHZJNU5kF
isnMrjzkzzSQSkWaQIm67lG8sdtpnyPtL8j/JGAHrKe8F+/abMm/W7eBstft4pV7
lHBgP4LALQo8KyfAPvRIBpCRVAGWeM9qFJCfNvB5GIXNef9hcTeMakJ7ckOue9zG
/MyQpM+err0bYLjWGc9wlRVH1UsObTgJHS0woPPVKkDzo0vGYEkDbW2NRoAptFAA
XG6umWnlHYupsh4NokySb9kmvnu4Ag==
=o0/v
-----END PGP SIGNATURE-----

--0iW8fVa7Udk0NOC6--


