Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501B6CD484A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRW4-0001CU-Ox; Mon, 11 May 2026 10:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wMRVf-0000vT-4p
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:21:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wMRVc-0002Um-P3
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778509282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FYfSkCNLwTijKMTNG9i6hkI8r5LzO3mkiiXHMtMQbcI=;
 b=QxvC+ZPF1u4mgXrlSTpEiXkjIC7M5G37nWnzUV+r3pycDcFF6GwZbSGocn+8X/88eqE2tp
 WSdfihmFneWWLuovv952SPXHplVI96cuBXzTYDTAraFzPtd2Vs0n48xigblWzjQp/MbSxZ
 4O+RiZVzxhKfo++npnNCa/VqndYShuA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-L_pk3_V-NfapboXIqDFx9g-1; Mon,
 11 May 2026 10:21:19 -0400
X-MC-Unique: L_pk3_V-NfapboXIqDFx9g-1
X-Mimecast-MFC-AGG-ID: L_pk3_V-NfapboXIqDFx9g_1778509278
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6FC7618002EF; Mon, 11 May 2026 14:21:18 +0000 (UTC)
Received: from localhost (unknown [10.2.16.157])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D5DAB19560AB; Mon, 11 May 2026 14:21:17 +0000 (UTC)
Date: Mon, 11 May 2026 10:21:16 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>
Subject: Re: [PULL 00/25] Bsd user 2026 05 patches
Message-ID: <20260511142116.GA520470@fedora>
References: <20260507022827.44499-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XEsK8KNmwwSMqlgP"
Content-Disposition: inline
In-Reply-To: <20260507022827.44499-1-imp@bsdimp.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--XEsK8KNmwwSMqlgP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--XEsK8KNmwwSMqlgP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoB5dwACgkQnKSrs4Gr
c8ilbAf+JAIbMOIsJW9r0wBsJeKnXsw2LIfgeT4vpTSu35MhwanrYfJtL/M0qA+m
JrBMNhkXW8pvfkTQpI0YYrlQarcOcWDfsV4GyW9D6pNE5xLKJo8qLKlU5QziOrxL
yF/ottPSrlP1gN0bD/6JiJVfmza3+CSCCYKQIXp00th6gYMpMQfObgzRaukOf5Ve
0XNID6oy7WUZcOCqVH9IryFkE+OXcMexoMx+kKVUXkOVfopgVoQMceQmKSa1cKCZ
WcmP4+muFQUhYdLBE2TiO06SwJjwVsMcX+Xpki0mQCy80T37UL0F3u7ryJaOFXuM
mz1ye1HRm4auC6sFue47d4QTns1aUw==
=qcLF
-----END PGP SIGNATURE-----

--XEsK8KNmwwSMqlgP--


