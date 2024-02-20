Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C576BC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYQz-0008Gr-QK; Tue, 20 Feb 2024 17:17:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rcYQx-0008Gg-Ii
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:17:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rcYQv-0002Gu-V7
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708467468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to; bh=p12E+vavt+IK1hWDdH3gFAQtdo6do1C+Hzq1OeA+DJk=;
 b=IEAvncJ954BBZGoXy1LgnmOMKeeY9w8gimR9RVmhSUWFWJHWuM5+P0+cOKjbf2j50QzZWh
 fG1awF8Ubmvna1q72uf8tHRg0xddropft4LmX/Tmidl9AMNbVoDjZOQ9+jLOdn+PnuaTEy
 8eOlXSDTlqem/AI4aLwQlMy1ythN7P0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-odEyxbnHNGaT21EmHjZk2w-1; Tue, 20 Feb 2024 17:17:44 -0500
X-MC-Unique: odEyxbnHNGaT21EmHjZk2w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9AB6106D060;
 Tue, 20 Feb 2024 22:17:43 +0000 (UTC)
Received: from localhost (unknown [10.39.192.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B35C1814;
 Tue, 20 Feb 2024 22:17:42 +0000 (UTC)
Date: Tue, 20 Feb 2024 17:17:41 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: jakob.breu@mercedes-benz.com
Cc: qemu-devel@nongnu.org
Subject: Re: Sponsorship via Github
Message-ID: <20240220221741.GA1517516@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uZbZjexdh9eFA7TK"
Content-Disposition: inline
In-Reply-To: <DB9PR07MB92726E235941C78516CE617EC6512@DB9PR07MB9272.eurprd07.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--uZbZjexdh9eFA7TK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jakob,
Thanks for the generous offer to sponsor QEMU. It's great to hear you
are finding QEMU useful!

I am forwarding the request to Software Freedom Conservancy, which
handles donations and expenses for the QEMU project.

I'll let you know when we have an answer.

Thanks,
Stefan

--uZbZjexdh9eFA7TK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXVJQUACgkQnKSrs4Gr
c8g3Vwf+Nqu/C4TTNDKvaznuj+p9qHgVXvoRzXhL4klP9bz7g3XbCGab4digYKf0
hlN1BEynNWHQuoZKyhgx3WOO1cRPgdNJptH7s26bTI3f3WJCe+yRrL9kd9sgp19Y
DsvXW6kuUALXgPMjG7iYanG4TlwvvTSw3yJJ9sQe1+4FyJOXqhlnaHljaO6ldE17
AQPftetXLxmmGQ8gNKYEwdFVNysAWFwTK74r0jwMsomQHOcvP6nroskGksiaiT7k
bMJ4BoyyQ9k4tMOhLWVTLae7NCGBK4vpItjB2+EaK5RiPEXcSD/kGvftapQxDBh1
50CtBQUYmy09OGhyK1OHI1CI75896w==
=ITu2
-----END PGP SIGNATURE-----

--uZbZjexdh9eFA7TK--


