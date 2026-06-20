Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CECBCDB46D
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2026 13:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waw9d-0000Kg-UQ; Sat, 20 Jun 2026 09:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1waw9c-0000KT-EY
 for qemu-devel@nongnu.org; Sat, 20 Jun 2026 09:54:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1waw9b-0007Z3-1E
 for qemu-devel@nongnu.org; Sat, 20 Jun 2026 09:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781963673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vc77yw8VJqdlxqxMwuDbZpiNCmVA1Q64cNNbykdox04=;
 b=XAJqCA/q/hSql8apuFB2TSQEZ/Z0f9fX2g6VX9CwFCJH19L6ZkufbsYlHJGeTiLHROYM/C
 QHFCQw0Wwc8b0LVwjseT4DZIJYsOgpirilxTfkewmjDB7uORqOAbhA7MysJK2mbZj8tOKq
 sgmvoUKGKDUQVxCD7UzkdBTAcbm9qUs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-1gQ_WQ76NRiMNbfDpVZmnA-1; Sat,
 20 Jun 2026 09:54:31 -0400
X-MC-Unique: 1gQ_WQ76NRiMNbfDpVZmnA-1
X-Mimecast-MFC-AGG-ID: 1gQ_WQ76NRiMNbfDpVZmnA_1781963670
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D15818004A9
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 13:54:30 +0000 (UTC)
Received: from localhost (unknown [10.2.16.21])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AF749180028B; Sat, 20 Jun 2026 13:54:29 +0000 (UTC)
Date: Sat, 20 Jun 2026 08:40:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 0/1] Tracing patches
Message-ID: <20260620124026.GA74315@fedora>
References: <20260618175247.748320-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="T9RB1CfTaFOJvAv8"
Content-Disposition: inline
In-Reply-To: <20260618175247.748320-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--T9RB1CfTaFOJvAv8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--T9RB1CfTaFOJvAv8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmo2ijgACgkQnKSrs4Gr
c8iZEggAipySDqkfi6SQA1QGTHASmKw3r8qn7gljooApyw/q0v3EZEHVEE2UEuwD
B7ZmW/qO8N1d47xeqnuEYflXrUjP4L0kJcFFPO3NOR6GhJRBBe/ErEe3OZVncscI
EHx4lad4Ux1xprfuSZTm4+66t/+PQe3tC7+EXDV4g2s+Hcx2BRQjla9oovQxLJxn
IA3gv2+Doe81sI+//Ee+qviXKzdNd1CfjQv4LN866fkhbDpm/iJOXydZrPQvZnM3
AxC4sbaa1TiZ/TXShK0vZaAKXc5iHKiV/8z7Fg3bk8+NdshiSidMNu8EiOMJ7OP8
ZEgloMou8XXx5wbH8GwZRYrfqJVq7g==
=gwmD
-----END PGP SIGNATURE-----

--T9RB1CfTaFOJvAv8--


