Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73552C02185
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2025 23:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZIZd-0006fO-7h; Sat, 18 Jan 2025 18:49:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tZIZa-0006en-0H
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 18:49:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tZIZY-0002EK-54
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 18:49:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737244183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to; bh=62SQkMmioZEm/dyD+BRtmJWTudVhjWXbX4pwXw5tH/E=;
 b=Z/P1Ta+UG4swcrzfmIQU+u8gQrSAM9/se4yW1CVGo+tQbqIlUk82uUGG7rtGx7d9QI0AQi
 INM9FXEcIBJ+PSoU9y5sFZeRHe5Qm5cGxBgTm4R4JXi07g40x2vZKSieySbaH0xnDC81RI
 SLW1Y1CD3q/AGnsczxf92UeOvssdIm0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-agq5Xb8FPtiSkOdsLy2Y9g-1; Sat,
 18 Jan 2025 18:49:39 -0500
X-MC-Unique: agq5Xb8FPtiSkOdsLy2Y9g-1
X-Mimecast-MFC-AGG-ID: agq5Xb8FPtiSkOdsLy2Y9g
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F3DC1956087; Sat, 18 Jan 2025 23:49:38 +0000 (UTC)
Received: from localhost (unknown [10.2.16.37])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 90C42195608A; Sat, 18 Jan 2025 23:49:32 +0000 (UTC)
Date: Sat, 18 Jan 2025 18:49:30 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/68] tcg patch queue
Message-ID: <20250118234930.GA448811@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uHI82H1mNS8uRzSb"
Content-Disposition: inline
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.787,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--uHI82H1mNS8uRzSb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Richard,
1. This pull request is not a signed tag. Please push a signed tag.
2. I can't find a key for richard.henderson@linaro.org on
   keys.openpgp.org. Please check again and send the key fingerprint.

Thanks,
Stefan

--uHI82H1mNS8uRzSb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeMPgoACgkQnKSrs4Gr
c8jh7wf/QAujDrbhfCzGgTi1OYhT6N8pB6xO0VxpmMPqTBAl7r9N5JnHjdKLY3DZ
vw9Skk1bMeD2nj9MLuc0dRYm55sWsmGjw8KGT3GLDKamdALdWao1nnrEoVrT/gp5
m6RU/pfSjpPgAIcrstgaof1CB1TikgVO7YTBU2IQVFdg8Qko+N7Ka1pV0cnJEpoJ
eJfyikHbNqZg3kQOTHTAnHs1hWiISh+dyqX8UvjCksRDMq6ewG9gMDTXC3vAV9+N
HcLPBrLRy2eZu9+WDRb8axxhVc2XFo7+g3BB7xTZmLyx4n9RMkDjM4R7IVRGjAr0
hf+LiBKDq8TVlEarOhYOeBE547yzMw==
=mVSN
-----END PGP SIGNATURE-----

--uHI82H1mNS8uRzSb--


