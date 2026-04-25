Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82798FF885A
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 20:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGjAM-0004XE-8J; Sat, 25 Apr 2026 15:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wGjAL-0004Wr-2d
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 15:59:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wGjAJ-0002d9-OX
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 15:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777147187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xXAmg7bn7BMFxw+MT2Xv2CdfBbF2wZWueFLQvjs9Gf8=;
 b=RnNTcPuBz0xzjU7ATYGnErfp0DK9bzbzisZnR3YSEMwXzRNJ+Ek+gNj8+VMSppobM/+vqc
 QOKRZmTMhtIx4dTW6qYpjnJzfXIAWS8gipjDbMbB38NxDm1Z04BPFH7x1dhe6A7NPCDWfU
 p0uaISK+jUIXwEvKVUbm9WyKHnJ4usY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-vd57OJvXNr6d0RUrGYdKOA-1; Sat,
 25 Apr 2026 15:59:43 -0400
X-MC-Unique: vd57OJvXNr6d0RUrGYdKOA-1
X-Mimecast-MFC-AGG-ID: vd57OJvXNr6d0RUrGYdKOA_1777147182
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C77E18002CA; Sat, 25 Apr 2026 19:59:42 +0000 (UTC)
Received: from localhost (unknown [10.44.32.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5101D1800347; Sat, 25 Apr 2026 19:59:40 +0000 (UTC)
Date: Sat, 25 Apr 2026 12:59:13 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com, pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PULL 0/2] Plugins update for 24/04/2026
Message-ID: <20260425165913.GA144212@fedora>
References: <20260425003140.1688666-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BVndGnbRV/8RtDVu"
Content-Disposition: inline
In-Reply-To: <20260425003140.1688666-1-pierrick.bouvier@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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


--BVndGnbRV/8RtDVu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--BVndGnbRV/8RtDVu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmns8uEACgkQnKSrs4Gr
c8ihNgf+IhrvGO0yj9E82IQhtKscIYj2F4fDXL7xrdKDVo8qp6hyQ8dxsoiBGhOn
H1Tcx8vKIlYGs/6+2tIY9Yz8reShpi2r870FJnu5JBSM+9nx+C/dTHw2RMj79XRI
i5w+ce7r5ouimSR/mWqPOHEFi2KNurIBThb7rC9WprYVVu7r/BzU38AZ+obRThHV
6fhkl5ezhWFT5I1LqyrbCYRLby2uO5pzy6qivmNQwxCoThs+fbA1AmJ/0gii1R92
fZcCKCtSF0ySHM+RHTt+3y1eqp/awiMVe4cU8wTORgxiH5zGnGgaO/wXZjrTSz8R
QqPltg4EjcdYqmaFFV93jb69BkeMMw==
=BwQ8
-----END PGP SIGNATURE-----

--BVndGnbRV/8RtDVu--


