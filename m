Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E82FF885A
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 20:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGjAG-0004Vc-EG; Sat, 25 Apr 2026 15:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wGjAE-0004VJ-HC
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 15:59:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wGjAD-0002cR-3Q
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 15:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777147180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Fh6zn3FndQjfraUmFe9BrbFQIN2ke+MQ0D/7QCoKOY=;
 b=D14HnKZnMXshGui+j2GIQXZbN8pfqBG4pPgBYVasivOepRvNUAO55wS/KmIDmBEEXCVZSb
 Jp0QaKTsv/X27ifxKTT7hrOfA8HpUf/+2Bt/kvR8bGgYZ1C85GP0LGjQpLmmex4qGVK7gi
 fKOvys325HdVxvZUdaZ+NemGIXvr4DE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-YENmtdR_NRiBFmVe3NOBRw-1; Sat,
 25 Apr 2026 15:59:36 -0400
X-MC-Unique: YENmtdR_NRiBFmVe3NOBRw-1
X-Mimecast-MFC-AGG-ID: YENmtdR_NRiBFmVe3NOBRw_1777147175
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7169A1800473; Sat, 25 Apr 2026 19:59:35 +0000 (UTC)
Received: from localhost (unknown [10.44.32.15])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6E8CC1800351; Sat, 25 Apr 2026 19:59:34 +0000 (UTC)
Date: Sat, 25 Apr 2026 12:59:00 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, brian.cain@oss.qualcomm.com
Subject: Re: [PULL 0/9] hex queue
Message-ID: <20260425165900.GA144145@fedora>
References: <20260424023606.2556830-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mWHIAhUmW2DB9riq"
Content-Disposition: inline
In-Reply-To: <20260424023606.2556830-1-brian.cain@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


--mWHIAhUmW2DB9riq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--mWHIAhUmW2DB9riq
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmns8tQACgkQnKSrs4Gr
c8ieJwgApW6hJCjNiJwEU3A+jVHPvKguLLdauCXcPgRdsDd67/zJFNIfA16CG4C2
W8UOP/c/XN91Oa+0yeKRd7nt6JT7oLQ/0l/d0XfdlTkxefuZdK5On9xIgTpC9/ZR
C3TFozIjcTnPoyaq3acxLu8ikBU7n1LzU6GJNqLUk05WUd8/xBwx5KOF2F9kX272
xtI72Bl+bfWjkvo7DovRYKFsLwfJKW3+fIxKylGVIEclMvvt385WKUSfPuvaxXKt
wJoZuclwyvRR7JyzXCyq1WnOZ74j88YCdiVbElLRF8pVvBPq2GEMS1VvHwsIZv9s
FodHmzUH90RslRB1093mH+rWl7e1SQ==
=l9As
-----END PGP SIGNATURE-----

--mWHIAhUmW2DB9riq--


