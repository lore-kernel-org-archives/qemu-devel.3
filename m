Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD07C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfa5o-0001Jt-2x; Fri, 03 Jul 2026 05:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wfa5m-0001JS-Rd
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:21:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wfa5l-00056v-EL
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783070507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tVe4/0OMC7Bfqvs7b7AMH8OQighmN3D0d3DYhiqkUVU=;
 b=SWtmNijpkwMN/Q8iATGB+RiPUcIx6Tc8OHPKPmcCxEj4XHZns+2lV9clAu5ZCCnQC+zcT4
 4k12D9HuThDCMwdTqPtoSBQ+v3dW58hWXie8yw7w4XED0N01hi8rqXY+edzCCxGbkXME/5
 vbLA4l8NqjSNo8XDfwRkmh2GoTeuIOc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-sN26igF9MuOoDpy3kgxqEw-1; Fri,
 03 Jul 2026 05:21:45 -0400
X-MC-Unique: sN26igF9MuOoDpy3kgxqEw-1
X-Mimecast-MFC-AGG-ID: sN26igF9MuOoDpy3kgxqEw_1783070504
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 076711953964
 for <qemu-devel@nongnu.org>; Fri,  3 Jul 2026 09:21:44 +0000 (UTC)
Received: from localhost (unknown [10.2.16.23])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4536A30030D5; Fri,  3 Jul 2026 09:21:43 +0000 (UTC)
Date: Fri, 3 Jul 2026 11:20:38 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 0/7] QObject patches for 2026-07-02
Message-ID: <20260703092038.GA457173@fedora>
References: <20260702123954.1284221-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IU5R+QMyHtgpdbnk"
Content-Disposition: inline
In-Reply-To: <20260702123954.1284221-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--IU5R+QMyHtgpdbnk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--IU5R+QMyHtgpdbnk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpHfuYACgkQnKSrs4Gr
c8g0fQgAjmEsj4QqNcZXe0kMLw/pQUueqmhQjT2fNS/kLyKTXmBF+GlVSvL6F78u
OExefORh9b9DhqPjdp70ChELAPAvUJea8f4fi6vwBPlOOtxXvZdiHtWH4K414UYD
Ca1a5Qwoy9QSh1NL5LbVSuoQCAyJfIjKHllCsu9uyBQS6S8hbHJTFZ3eixAGPMjR
746zbykBx4jmOTt5jU0AKK3N0aUrj7fNXFefItzCemwKO5K3RohM6i21l56y7auq
eGtjaup0wma0keMN/ZtputC8VyLg2fpXlynyImjSI4qfVutIDbln2kIqhgIwbz6I
b1pi2aBFeOyN11cQ0leqdKGOakD+sQ==
=XBRo
-----END PGP SIGNATURE-----

--IU5R+QMyHtgpdbnk--


