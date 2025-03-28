Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D91C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 11:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ty8CN-0003Gf-RN; Fri, 28 Mar 2025 07:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ty8CH-0003Fy-8h
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 07:48:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ty8CF-0004FB-6k
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 07:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743162502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9EGq3XG15nQUIV09qm5oasb44/GE+Oe/ZlfqVhLeoYE=;
 b=Nr9m5qVvYW+dYTk+8JZsKgdoiKdp1rIOb8LiSP32aAELBV2C9t4uCPbzHGPEKin4OLzoCJ
 2rDDDrtGNPgz2bVR/GKfY0uihJd64A6Ac5Dqvjcy0EOb/95FOjFgBUzVGo8OchaTtZpHuj
 UO3pwOTtzGq2DDwFs9zcUmU8POAfgKo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-8U93h9iKPEqlAoo384Od5A-1; Fri,
 28 Mar 2025 07:48:14 -0400
X-MC-Unique: 8U93h9iKPEqlAoo384Od5A-1
X-Mimecast-MFC-AGG-ID: 8U93h9iKPEqlAoo384Od5A_1743162493
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 373E619560BB
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 11:48:13 +0000 (UTC)
Received: from localhost (unknown [10.2.16.37])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 43AEA1956095; Fri, 28 Mar 2025 11:48:12 +0000 (UTC)
Date: Fri, 28 Mar 2025 07:48:11 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 0/6] Functional test fixes for 10.0-rc2
Message-ID: <20250328114811.GA65325@fedora>
References: <20250327080622.954388-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YPOgaLkl+Pi2t06F"
Content-Disposition: inline
In-Reply-To: <20250327080622.954388-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--YPOgaLkl+Pi2t06F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--YPOgaLkl+Pi2t06F
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfmjHsACgkQnKSrs4Gr
c8jkeQgAgefBgWEQGlkVBJjzAvN5789I46jtYbKScvfs6BqffcK97cTt+3xjN1i2
ygn3Foez1WAh3mWDFzABrmWX7MSBU1rVgnj9fmJ9D94C8J79as0H/AzYBmRGHbzC
qICEaguMDSfDIViqq6R3racWf1f73TewU2mHcnv7QvdOFXe/ktloEK7wn1563qrT
PO/Qqkqbcbvdgwti1mJXsH1+IgSmwFH2amdIV0D5okEOfCN2kw6zr90X/NOuGLev
nREHSE/OdrJcYpNiFX2zlVh7x6Xxb8AP0wM95f6HtH9jTkPiieBZu3M+wxI3whYq
gbjFjs58HpnHWSgK/GR7zAedRoQA2Q==
=KIU7
-----END PGP SIGNATURE-----

--YPOgaLkl+Pi2t06F--


