Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4A9CA0EC4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 20:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulZNK-0007wJ-Ul; Mon, 11 Aug 2025 16:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ulZN4-0007vx-Ge
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 16:43:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ulZMv-0007Oe-B5
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 16:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754945020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=crnsHnECw9lgt0dqYZOhVXsbGxlzyHeu4qLk+y0ypiU=;
 b=Kx0mZ7YBy3caB3Jko+Yp7G2hehxCtPH9Im2OLQPK6e15UoXcSwML4rQGAgqDiJHVxLWsys
 BBTC+uosQ65WG0rQ2KChm3NJRRPARKHzUwWj3JtaCBKDcuuiP9vSg09PulJPyqHNVenGWF
 b6DDTmfezh5ACTj0DcVh1XxSqDV36GA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-Hf76xu9HOw-OTfMa3zObWQ-1; Mon,
 11 Aug 2025 16:43:38 -0400
X-MC-Unique: Hf76xu9HOw-OTfMa3zObWQ-1
X-Mimecast-MFC-AGG-ID: Hf76xu9HOw-OTfMa3zObWQ_1754945017
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45DB9195608A
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 20:43:37 +0000 (UTC)
Received: from localhost (unknown [10.2.16.174])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8234C18004A3; Mon, 11 Aug 2025 20:43:36 +0000 (UTC)
Date: Mon, 11 Aug 2025 16:43:34 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 0/3] QAPI patches for 2025-08-09
Message-ID: <20250811204334.GA77912@fedora>
References: <20250809055026.2944835-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="A4oO3LRqQRnzEnTR"
Content-Disposition: inline
In-Reply-To: <20250809055026.2944835-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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


--A4oO3LRqQRnzEnTR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--A4oO3LRqQRnzEnTR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiaVfYACgkQnKSrs4Gr
c8iV5AgAuNjiBUQ1qDONt0FowJC8rXP1//rt5APZcby2VqBE1D7FwY26qKl9Tk1l
ihRuyHxlnJhkjeU8XRO7ixqLvtPdqAsaD20VLOSiNF6yYUrVyLfFS+2ZVRS0OSR/
e16hreQchaUf6qBi6OOPjCXc/tqDGPeRIN8oq2MA3a7GhNDM4N3jhiDRrTRMF3uS
sX4ATJxlSHY/HTniluwvj6K+DsSDSl1VGjBye/MNtXQeN/TAjgu+F1BgzUO1BWTv
Sh/i60+SJBTO4/NpgSp2g6FFRWjzrAW5nI2zVDGs+PAV0olRQSWyYE8SPReoRdGL
Dwed4wOJYN+N4NbhaI9HuZgA4WYZaQ==
=gx+o
-----END PGP SIGNATURE-----

--A4oO3LRqQRnzEnTR--


