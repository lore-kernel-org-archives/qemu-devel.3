Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F77DE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 20:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOMiY-00027a-1g; Thu, 19 Dec 2024 15:01:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tOMiW-00027M-8x
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 15:01:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tOMiU-0006FQ-Q8
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 15:01:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734638508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iBh5WMg8VHi/9SbWY+uYNvx1CeKw3PtIEP23Fv6vQa4=;
 b=Ws2il8Zw1fzRsQe7k7+wUJnLgQx89abE446w7zq04NlWshC1APokaknSiJ10v59VDvqtkG
 vhgRUdRNXzXdtaEF40D+i1AVfI1sdpY5MRPbuegQJL+EFjI3bi5hNmUFc4bhWUJfhsDYqF
 xoSp7wB8mIpuPcKC01U72YQE+HmlSWk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-mXV1p-IWMRWwZ553RXVqgQ-1; Thu,
 19 Dec 2024 15:01:42 -0500
X-MC-Unique: mXV1p-IWMRWwZ553RXVqgQ-1
X-Mimecast-MFC-AGG-ID: mXV1p-IWMRWwZ553RXVqgQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62119195605A; Thu, 19 Dec 2024 20:01:40 +0000 (UTC)
Received: from localhost (unknown [10.2.16.70])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8A97719560AD; Thu, 19 Dec 2024 20:01:39 +0000 (UTC)
Date: Thu, 19 Dec 2024 15:01:38 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: deller@kernel.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>, deller@gmx.de
Subject: Re: [PULL 0/6] Linux user fix gupnp patches
Message-ID: <20241219200138.GA722208@fedora>
References: <20241218195247.5459-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sMR71Yv/DiYsNBb9"
Content-Disposition: inline
In-Reply-To: <20241218195247.5459-1-deller@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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


--sMR71Yv/DiYsNBb9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Helge,
Will this go through Laurent or did you send a pull request to have it
merged into qemu.git/master directly?

Thanks,
Stefan

--sMR71Yv/DiYsNBb9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdke6IACgkQnKSrs4Gr
c8i0cwgArY9VVIYrS50eKwx2IZ3l5M6YL0oP3Tk2CX/I3ouzYMDK/La5bOv5EE54
b5QVrfgFmVv/scgRz+AH90k0Rn9eS4FJEzOT0d9GOgBsN97FFKHGFznpAb4PiwG1
hW4r99ANO/H2Zr01TpQhvvhaOW24rdgYBujbOnWKuqM9WTXA7l2qsOt5rVlreFyy
cTUFIsOW3jlgSWPo/foYL/OiZCgNSyNHFwJtR2C6ze2PwMTzMMLg5nt2NhYou6YA
DziQPr9ZD/Edbv9GmPrJt1qXn+sbsRRxbfz00TOBVhk8qTiOTnx7ePiUMAzkK9v1
GbOo5Dm40/FipYLqtBArIIybyTEgJg==
=wtbi
-----END PGP SIGNATURE-----

--sMR71Yv/DiYsNBb9--


