Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598DDC0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 19:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcV03-0004NO-2R; Mon, 27 Jan 2025 14:42:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tcUzq-0004LJ-Fc
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 14:42:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tcUzo-0003b1-S4
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 14:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738006924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xt1h9uu4i+m7IHMY5FQocYtEwkUdG/eomZQsy4CTWOc=;
 b=D704y6cncBK8/ZHdwQpC7It2WeRRQ2w3G38mRCKcpY3LqfDzK66UzKR+NALJKx5TcNjsQK
 tylH1K3PlG3Y8M0lvBxIb4XXsXjSwpKQFmVDa6ER4LXrCTyf5vLCvdRXEZi/WWEwgKj/IG
 cxCt+aMBKhKonKoRCouwRdYBttqva0A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-oba_l_0oMVCBnEct1ZPMEA-1; Mon,
 27 Jan 2025 14:42:02 -0500
X-MC-Unique: oba_l_0oMVCBnEct1ZPMEA-1
X-Mimecast-MFC-AGG-ID: oba_l_0oMVCBnEct1ZPMEA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69092180036E; Mon, 27 Jan 2025 19:42:01 +0000 (UTC)
Received: from localhost (unknown [10.2.17.47])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D7E8330001BE; Mon, 27 Jan 2025 19:41:59 +0000 (UTC)
Date: Mon, 27 Jan 2025 14:41:58 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: deller@kernel.org
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: Re: [PULL 0/2] Hppa system for v10 patches
Message-ID: <20250127194158.GA39544@fedora>
References: <20250124195345.15118-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gWb48dmxQFz34fkV"
Content-Disposition: inline
In-Reply-To: <20250124195345.15118-1-deller@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--gWb48dmxQFz34fkV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--gWb48dmxQFz34fkV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeX4YUACgkQnKSrs4Gr
c8h9QwgArgnIwUo/GjGrNydXAIZsnw06oIw3CzldM7voLyhFY/9jwuqE0lDEW+b5
BIuC2bsXAgDryf+320tW4pZYMDuYoQ7qHZiNaUFAgzkps81e24PuhQ4SlX0Sje5F
195yJrLwxV6/a/ZoI44TBWqd3M+4R811MDWO4S2aTJVYcAN/dpw4sLvzQE5cRiXk
y7YGm3SdcuCwlpfyrGgoqOTJGriASujhnUJMWmuqs75t7HM9lkXHt3fKfmMXJbaA
UZbt8vmHnE2W+4n6hDs/kujbQH7wgR78lZqTN50cjKONtvSUF2wBZQYYkqZTmySI
JqR6tw5HuoaX4rHcPq0FjKbSAgkzDA==
=/vmp
-----END PGP SIGNATURE-----

--gWb48dmxQFz34fkV--


