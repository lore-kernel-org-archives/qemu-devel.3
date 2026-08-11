Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C066C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtuA7-0004jE-EZ; Tue, 11 Aug 2026 17:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wtuA3-0004iN-CB
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 17:37:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wtuA1-0006AR-P2
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 17:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786484243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/alNiWzNxc06w0ZK2p/+QudKKRzJG3I7JJ+SiOuqoko=;
 b=LyAf/OQoaZN0xS3DZ0eYnw7XZOEEFzh93ArP3ZC2r2m1gWcMGmiJvyU/MFPOl9ozIenhH6
 efuE5cGQ/5jemcdLohPToB/dn4CwaqEP6FbEbz6M/ccu4IPtnBIxEogsH5flMz6vXiavR1
 zbqNeVUEX8lNoAWg3hmEcj/si+nz+2E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-FbaWZmHUNfWGWlhLHnIGBQ-1; Tue,
 11 Aug 2026 17:37:22 -0400
X-MC-Unique: FbaWZmHUNfWGWlhLHnIGBQ-1
X-Mimecast-MFC-AGG-ID: FbaWZmHUNfWGWlhLHnIGBQ_1786484241
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D699C1956096
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 21:37:20 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3BF5F426; Tue, 11 Aug 2026 21:37:20 +0000 (UTC)
Date: Tue, 11 Aug 2026 17:37:16 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/1] target/i386 change for QEMU 11.1-rc4
Message-ID: <20260811213716.GA200944@fedora>
References: <20260807144136.2637416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oSSA3wzln4/Pg+sp"
Content-Disposition: inline
In-Reply-To: <20260807144136.2637416-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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

--oSSA3wzln4/Pg+sp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--oSSA3wzln4/Pg+sp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmp7lgwACgkQnKSrs4Gr
c8ig9QgApQXNp6/Qdqwboytfe36BbGwNNbFWwfympE4rzKZLWlOUZkXpfT3ixBOP
RIdtX3OT3K+xRsc8y2imk+21LNSicnPiP+i7PyuenKONkp75Mz+cLTMUwJB3s4PE
jIJTDvsLx1nzt2CRVZahy6pkEwvg/LrKdNQ2hvesSJAjmSRf7REQ5C83Mf4jC6Uq
9vqYZCBixzn2x1FE7k7ZwIUkCZH1hFcmGD6sqYgXgZB3RjQ+N1HpI49MsZoBtovA
Nhd8OSGvfqsrtR85N+0cvZMfPWoOtcn8ojnx98U3luynQ1yUwd5LK+ZLtiT7YCIH
rgPGW2YPOPv1SB9H58zGRZSXl9trZQ==
=4o4h
-----END PGP SIGNATURE-----

--oSSA3wzln4/Pg+sp--


