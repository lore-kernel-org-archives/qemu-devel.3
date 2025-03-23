Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC11AC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 13:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twhky-0002va-KL; Mon, 24 Mar 2025 09:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1twhka-0002t0-Ds
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:22:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1twhkW-0007WT-Kf
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742822511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ww5szLfp30/Ix2XlUX5ttDpxctOC4expTYIeosPY+Sg=;
 b=PDds5COCGoL0ud+jK+EZ4eqONAu2aakh1hR/crrCXDFZd2yLuAtSxaFqDyt+u2o8X3OHcT
 H/ItSlsINlzYKq32ZvTZywdqkzk3TY0tXA1c2IgCdOElcBsuVVVJKg1DsHKZ2ErmRoomhz
 nCqSW60bEE4GgGvb5J1xSs3jTQoyZIw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-4nMtXecTNLi6iry8EjuOlg-1; Mon,
 24 Mar 2025 09:21:50 -0400
X-MC-Unique: 4nMtXecTNLi6iry8EjuOlg-1
X-Mimecast-MFC-AGG-ID: 4nMtXecTNLi6iry8EjuOlg_1742822509
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4C1B180AF7D
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 13:21:48 +0000 (UTC)
Received: from localhost (unknown [10.2.16.139])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E0F0D19541A5; Mon, 24 Mar 2025 13:21:47 +0000 (UTC)
Date: Sun, 23 Mar 2025 18:29:54 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 0/8] Error reporting patches for 2025-03-21
Message-ID: <20250323222954.GA41904@fedora>
References: <20250321145158.3896812-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PE1n/X3UHBh+XIgU"
Content-Disposition: inline
In-Reply-To: <20250321145158.3896812-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--PE1n/X3UHBh+XIgU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--PE1n/X3UHBh+XIgU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfgi2IACgkQnKSrs4Gr
c8jdSQf/UiIdbzAfi/5v/hg0k90duSfJEl9Dpx7o0r59T/2j3vhf+eMAoREcuY6s
GZ/nF6/G6S44Js2ZVw58PikgzUflNg1eNogAjK45vRBoBQuACWHi12CcIua+qTIl
Uiazoxs8ulgRMCmf67y712jXoyWljiuQKVKWMo5uzlFguaJMRJaoPcwpq9PIVgsM
cIjwwhO8iRFcsz2N2P4C6lMGNuok+KwGUvk1cl94/4Nl5sWRV+kVbJ1EyMEuI23V
5zLAQEZ7LC3QF4J4YfHTSO4FiIN+hUPK3s/SlrnLI6KWgXKL103EAtQn0ZKWnQDX
ywXfHUbX9B29oFXnIYSxgRYi2gTGvw==
=vzMv
-----END PGP SIGNATURE-----

--PE1n/X3UHBh+XIgU--


