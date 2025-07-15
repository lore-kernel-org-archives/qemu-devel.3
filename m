Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A72C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublnB-0007rG-EB; Tue, 15 Jul 2025 15:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ublkZ-0002dO-8g
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:55:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ublkV-0005QU-ED
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752609334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nbQEl3WHZAfN2EZa4mWc88goqYFqDLWwZ5pxYRqdIT0=;
 b=HvEeD6W4AMnm1GC5eMF4kZZANYrxXxpEvr1tnDnIntiRUkVEp5riYWjOUPgzUguv2Je51E
 C37a1XeyMXTxckC7hpLfzxZGhF+DTHzPKa79vFnAsG0ZSA4LHbbIzyImFEfadLrIUjaQxT
 0gFYyCxn7emb4r5R/bMpVaOJ8wrZ5Zs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-oXsjruP9P_Gcpx9hT-8kpA-1; Tue,
 15 Jul 2025 15:55:32 -0400
X-MC-Unique: oXsjruP9P_Gcpx9hT-8kpA-1
X-Mimecast-MFC-AGG-ID: oXsjruP9P_Gcpx9hT-8kpA_1752609331
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BB7918001E1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 19:55:31 +0000 (UTC)
Received: from localhost (unknown [10.2.16.12])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8A8101803AFF; Tue, 15 Jul 2025 19:55:30 +0000 (UTC)
Date: Tue, 15 Jul 2025 15:50:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/77] Rust, target/i386 changes for QEMU 10.1 soft freeze
Message-ID: <20250715195042.GA242410@fedora>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SPRGNeWsINdrzrkU"
Content-Disposition: inline
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--SPRGNeWsINdrzrkU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--SPRGNeWsINdrzrkU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh2sREACgkQnKSrs4Gr
c8ilPwgAqkfzWcsXYnE3vjgCvJbxge3j7huKmXZ3Ua3eA7dR0Shro4g3OF1J+unK
CPLIfvIMIAtnNDPv4rFpNWRdSYoPoVABkw7RRdxPzjvKYig4t3eHS2BJnBjgsOnV
eLhG5NaqD2XjWySlzqhxvijQZPunMr5YS5gIOF9LYWho8UkAlCtMCValoPY8/uPV
pIDuH1WnuL743rcHJgNqhqbTUEmMMawM30VUJMVr8RFtTEuMx67PWEyDgQxJ/km+
v/CEn8Jc7ZtSrX3gZZJObeL0IVSAHvD1loUDYmZVsx7bmjTNRmNE7nf8QLKfLjg5
zk0SpEaw1URHf2Sk2OY/IJ77ZM+QRw==
=ytnm
-----END PGP SIGNATURE-----

--SPRGNeWsINdrzrkU--


