Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45110C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 04:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiPdl-0005db-N6; Sat, 11 Jul 2026 00:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wiPdY-0005d7-1K
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 00:48:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wiPdV-0005LH-Mf
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 00:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783745298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X9Qkiiy8uqLljb8rNBCGWNZb3MKP0DkFmn2lNzKVBrQ=;
 b=Yhagb5C/jK763L0v3aJMFHtNNM8b0ZPZtM25Nu7CuDZixiBmZez2ruIWT3QIWPLfoEXri8
 CKcFG6sCMwdtE3SO0N0RWKmm9L8QZknw4MC1cYrK+Y99bIQv/+hWUBghYchs7DbxLLGLRZ
 l6Ss+vbEy6+kMwdMoqCPQ1qMhRIEg8w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-OphUQES8PJ-8Zwn6T32ViQ-1; Sat,
 11 Jul 2026 00:48:13 -0400
X-MC-Unique: OphUQES8PJ-8Zwn6T32ViQ-1
X-Mimecast-MFC-AGG-ID: OphUQES8PJ-8Zwn6T32ViQ_1783745292
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10B391800EF3; Sat, 11 Jul 2026 04:48:12 +0000 (UTC)
Received: from localhost (unknown [10.2.16.3])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DFEF019560A0; Sat, 11 Jul 2026 04:48:10 +0000 (UTC)
Date: Sat, 11 Jul 2026 06:42:41 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: alistair23@gmail.com
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PULL 00/40] riscv-to-apply queue
Message-ID: <20260711044241.GA634212@fedora>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Kv1zF53iOOplVGfi"
Content-Disposition: inline
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--Kv1zF53iOOplVGfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--Kv1zF53iOOplVGfi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpRycEACgkQnKSrs4Gr
c8jHHwgAgv5QAdWU+0I9PFw6HB3s0iMUM7TeeJQ7V9Ta0l3BTfCJJVufM5M9bEif
dIOsaEP/ulEZQE4dRqIIgQ9/TAuwzxCmKnNfGpF/z/eI17pPJ+JOLY6He6NqL0km
B3aDKg7Ye58nv+iO4Jz1k6tse6qbJLGlVb69TzlQYSQ70Xqc3NRrZAekVE1O7zII
tq4fx1ywDY3ooZfzti4eo/wmISS42SinbtLt9Zpki9HbtgqehWZyqHTxWv9zGPat
MKMw2qR5rG7R3MXeSOMmMN9FMRVDu1gY4o1BBRDVT/s19n1B0zcUb0bJjcrpefvw
iHGNoyPoibPBd8yw2EfwmbgMzYlPDw==
=K/Yp
-----END PGP SIGNATURE-----

--Kv1zF53iOOplVGfi--


