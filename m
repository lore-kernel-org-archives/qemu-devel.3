Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096D8C02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 20:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXnvq-0008Ps-Rc; Tue, 14 Jan 2025 15:54:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tXnvk-0008PT-9N
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 15:54:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tXnve-0003bj-K7
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 15:54:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736888061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=05Z1aHs339w1QGeaQTetJCP6M5Kxz3UgBkx/P+q31vE=;
 b=Ak4o6Wdl4Jw4q1bbpkaDBcgt90rrp8NTSpOkUxIRIotNPycVXRG3iS4xI/MdMwz8Qwykk2
 r3bwm5lqSOjm5OC20z9+YRMXgeN9LXZ8ncmLL5smnRfH3McyhFoV0jRPitWYaQ1sBw8AhP
 BZPUP7y8jOrWB1oibJqx782FyOPzKYE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-fs8UpFwMP3m-arYdMQFBOw-1; Tue,
 14 Jan 2025 15:54:15 -0500
X-MC-Unique: fs8UpFwMP3m-arYdMQFBOw-1
X-Mimecast-MFC-AGG-ID: fs8UpFwMP3m-arYdMQFBOw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE2C91977039; Tue, 14 Jan 2025 20:53:27 +0000 (UTC)
Received: from localhost (unknown [10.2.16.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F10061955BE3; Tue, 14 Jan 2025 20:53:15 +0000 (UTC)
Date: Tue, 14 Jan 2025 15:53:14 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PULL v2 00/55] Misc HW patches for 2025-01-12
Message-ID: <20250114205314.GA164208@fedora>
References: <20250113173604.46931-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="drFDGnFIAf/nnO9q"
Content-Disposition: inline
In-Reply-To: <20250113173604.46931-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
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


--drFDGnFIAf/nnO9q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--drFDGnFIAf/nnO9q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeGzroACgkQnKSrs4Gr
c8jBtAf+LuNJYpHz6a2p57u0ltvdcd/jOsPyqRrVC95CkgvqOlbqgB9rZ0125Hg/
1oQyWzuSJwCsp/blIuLq+yMr0qzBg2l37xZkqtpVxoGQPONH0Ex9OazjB1JrPA6w
vsIyIXptLrI2DZU4qeZ7nMEa9+oh7qnkR5/8HtpBzGegj4xsjFFHb2BiOyDga5uW
nwhrftJmPYZ8gl16AQiukas8sSrXvU55Zo8yUIE0z1Nnh2RVgeu/QsOo9ah+5gXb
hAPFNPT5bYo+jPSfsTdULUZVONCX2NodHnRWHCwcJrS7MXtg9723zBVyCPxpigg+
o3YhHk4WRaSH0sBNXLUT7GFxrGxOkw==
=cTap
-----END PGP SIGNATURE-----

--drFDGnFIAf/nnO9q--


