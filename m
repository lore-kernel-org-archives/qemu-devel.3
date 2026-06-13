Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6DACD98DE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 14:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ8cc-0007t8-Ty; Mon, 15 Jun 2026 10:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wZ8cJ-0007o4-KJ
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 10:48:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wZ8c9-0005aT-Re
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 10:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781534898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sgGZ+K1cmNieKC2xi7x004OJwDU4sM5KTO0KVH5cPws=;
 b=Hjg9egdB613TgpFNdAz2FbiyKP8LGv36tB0mPZEOzHIBQ4jOrQ6z+z2OCrRAqTPTAaqlHV
 NtdEyFrqMjNygUkkcWxroWwkIX1o16hPqixazOt7eE817FeVA2iqscXiC353hcfGVFR08+
 0Y81rWiMKqL0/1qWIwueg5IBVVPf1uY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-SzA-JGOkORy7ku_foZL1Rg-1; Mon,
 15 Jun 2026 10:48:17 -0400
X-MC-Unique: SzA-JGOkORy7ku_foZL1Rg-1
X-Mimecast-MFC-AGG-ID: SzA-JGOkORy7ku_foZL1Rg_1781534896
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0CDA11955F10; Mon, 15 Jun 2026 14:48:16 +0000 (UTC)
Received: from localhost (unknown [10.2.16.187])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 08BE03189; Mon, 15 Jun 2026 14:48:13 +0000 (UTC)
Date: Sat, 13 Jun 2026 19:40:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-trivial@nongnu.org
Subject: Re: [PULL 0/8] Trivial patches for 2026-06-12
Message-ID: <20260613234033.GA360236@fedora>
References: <20260612165957.1779082-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HRNyJwpuDbwlLvnc"
Content-Disposition: inline
In-Reply-To: <20260612165957.1779082-1-mjt@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 21
X-Spam_score: 2.1
X-Spam_bar: ++
X-Spam_report: (2.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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


--HRNyJwpuDbwlLvnc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--HRNyJwpuDbwlLvnc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmot6nEACgkQnKSrs4Gr
c8imJgf+NWHNrSz3zG8FcS6X/035nLLRNYfMa6Qfy2Suci5FKkbbHY7E8ejfeve/
RSpDpRiqQEeTYQEsqaZai1HyJ92DUDcW5nlXRbsmvvD1X5CAMZPXwAb300IeUx2V
Efk2rEB0b5j6LSXRHUjCCABYBTB/MIG/Ptvie+FjQNUasuGy8jFuxgyCAd6Wy114
aggaBoT1fyUit/aASjEIXq2ijMhKw+PkXHakOxtpRKzm2vuHZMeSlJx+Nl34pI0D
v9E2TCwg0tJwGlnomAn5nOWnnsTi4CP4j/AhEe1VLBwiPSLz6Tjmxivio9f00S/i
RmUfO28pnFFe/+7v9a8ABpnzrUqh2A==
=Dl2H
-----END PGP SIGNATURE-----

--HRNyJwpuDbwlLvnc--


