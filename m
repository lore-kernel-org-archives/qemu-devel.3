Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FC7C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 14:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd7AH-0005FL-9a; Fri, 26 Jun 2026 10:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wd79Y-0005Ae-F5
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 10:03:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wd79W-0006xx-TJ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 10:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782482610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jJw0owHp24bwLGXYeNgnzk8fvSoOROo2ahv4+IrMcjg=;
 b=gWROdqxirMwYn+lKlOo1M+QcVbVZG/EUkuO+a6UPobFNmNM1zU8Y1qARyDE3oM6VaR9doD
 7Qhej5YM7gvj3DduaAqi/RzAAzkoVl70RtRflapYDSSiA2K7RT7Tv3KBPXZdyzGtswhcTK
 aiWjzJCjgXAZzBGL42Cac1awx1XvIvw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-I1OxYUp0M5abnifu4lUAOQ-1; Fri,
 26 Jun 2026 10:03:27 -0400
X-MC-Unique: I1OxYUp0M5abnifu4lUAOQ-1
X-Mimecast-MFC-AGG-ID: I1OxYUp0M5abnifu4lUAOQ_1782482606
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B7EC1955F73; Fri, 26 Jun 2026 14:03:26 +0000 (UTC)
Received: from localhost (unknown [10.2.16.186])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B2D3B1956094; Fri, 26 Jun 2026 14:03:25 +0000 (UTC)
Date: Fri, 26 Jun 2026 10:02:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com, pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PULL 0/6] CI update for 2026-06-25
Message-ID: <20260626140248.GA305491@fedora>
References: <20260625222111.1761-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7Q/c3xcEc6iGeOJP"
Content-Disposition: inline
In-Reply-To: <20260625222111.1761-1-pierrick.bouvier@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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


--7Q/c3xcEc6iGeOJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--7Q/c3xcEc6iGeOJP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmo+hogACgkQnKSrs4Gr
c8jgtQgAtxKcw0sBUctvqic86Xp0G8ff+yxkMjaQfJ6lm2bEwVnhRoogXslTAP8o
LZLpjBi9UPH9ku52iaZYgr2u0pyZLNIEnSlvHeOi9OK3rbsHUU+PwGL1HQTbjzCx
CV4jmevq1VtVsJuBUoQRVnsMsd1cUg+cFTle3+XbPqxfDBRlQvPVF5i0RMWdTqX6
YgXyGr8MfuZbvg5+r6uQtvhAaR6S6OIxkszs3UFVu+HG/50u9HcJlF/GBoA41Rhy
kI5jYV/GLQ8rTlj6HH/GgXMeOxIeN6va9F/srd41RAzPDuzdKs07xbkhyPb0FmLD
EzX/y7YO9yDVGBJy4h66GVYtw2rdng==
=xakV
-----END PGP SIGNATURE-----

--7Q/c3xcEc6iGeOJP--


