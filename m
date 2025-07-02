Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65328C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWyX5-0002sL-VY; Wed, 02 Jul 2025 10:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uWyWv-0002kz-NX
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:33:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uWyWs-0003gQ-1s
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751466819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1J61tS3HTvnaGgVvxp9Y078e+BQpkrrbNJPq4FRZSBY=;
 b=SrommfmfbeNqSoLlHmYJD+6XxFjZSKjTJZEtSLAS4COP3k1x7G5AfPUSTAI4HJIx/1Pvyi
 fOSdOcG5/v6pH8iabkyndOsygadci3MauhAxY4FXxgmrFDFzpRa6NniiQrKsdoEcHFnpvo
 uhF9m/m+9/BfHzMO8Wh69CP2Z9tPn58=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-378YnuaLMvmvHzrDKMl0mQ-1; Wed,
 02 Jul 2025 10:33:36 -0400
X-MC-Unique: 378YnuaLMvmvHzrDKMl0mQ-1
X-Mimecast-MFC-AGG-ID: 378YnuaLMvmvHzrDKMl0mQ_1751466815
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 779AF1801212; Wed,  2 Jul 2025 14:33:35 +0000 (UTC)
Received: from localhost (unknown [10.2.16.102])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2CB3119560B3; Wed,  2 Jul 2025 14:33:33 +0000 (UTC)
Date: Wed, 2 Jul 2025 10:33:32 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Yan Vugenfirer <yvugenfi@redhat.com>, Dehan Meng <demeng@redhat.com>,
 Elizabeth Ashurov <eashurov@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PULL 0/3] Misc QGA fixes for 2025-07-01
Message-ID: <20250702143332.GA59122@fedora>
References: <20250701122558.31556-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TdPgoRDC9YpuwzLd"
Content-Disposition: inline
In-Reply-To: <20250701122558.31556-1-kkostiuk@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--TdPgoRDC9YpuwzLd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--TdPgoRDC9YpuwzLd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhlQzsACgkQnKSrs4Gr
c8iyUggAkxyUIIhbDZKPJKiNFi9vEHU34HGNL8gWDiCpUlKyaW2LWe2rmc3r/XCw
3VyrEWAB2Exve7UOT3JyVeyuV/ID+4EX/YL3B/92TCJtIsW1yIxpQjf2X6DOPyLg
p2kVN2Mxqr33iKqXzRCqRWsKng2OrjPS1PHKeSbwa/o79oV1OlB31svGw0qbY2NN
nU+tnCg0ZrDOyvx/sgbnKlzIiGcgTD7zif4/XnvFf6Nq/RfZl0H/xWh6p4KaEVNp
x6pFUhFJmuyFiotRdan4d24568Y9BruA+hC3Ooe/DjNE8cONN4w696raHNU8VLeX
++5XlTlbTu1HowVNMfELipA1Pqpaew==
=B/Ii
-----END PGP SIGNATURE-----

--TdPgoRDC9YpuwzLd--


