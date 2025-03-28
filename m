Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA474C36014
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 19:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyFWU-0005Dp-Rw; Fri, 28 Mar 2025 15:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tyFWS-0005DL-DH
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 15:37:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tyFWQ-0004an-Mf
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 15:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743190661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P9stZx+Upi5N6VhPW4b01aJkQb8OdBaR/0SasYh6fOI=;
 b=gkkN4MZKG6B1Wxp//vVWoky+tZuXeb3OcmlN+IfGH+TLmCEwUsYpg0Lse6laGS/1NxlMjt
 9GmAXptff85435WQ3r0aRZn+BV9sV7QleQJ45bWffC56Gk9VqQX99oqIThH7Dl83McjABg
 3xzKAig+FYBUKlklDoymE8BFTU4ZQjg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-212-3Q5aE4ziNfufl0YZTIN34A-1; Fri,
 28 Mar 2025 15:37:36 -0400
X-MC-Unique: 3Q5aE4ziNfufl0YZTIN34A-1
X-Mimecast-MFC-AGG-ID: 3Q5aE4ziNfufl0YZTIN34A_1743190655
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E76DE1933B41; Fri, 28 Mar 2025 19:37:33 +0000 (UTC)
Received: from localhost (unknown [10.2.16.238])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D6C151801750; Fri, 28 Mar 2025 19:37:32 +0000 (UTC)
Date: Fri, 28 Mar 2025 12:36:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, maobibo@loongson.cn
Subject: Re: [PULL 0/1] bug fix for 10.0
Message-ID: <20250328163627.GA76641@fedora>
References: <20250328013516.735614-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZaAV7NyI1tMGXUno"
Content-Disposition: inline
In-Reply-To: <20250328013516.735614-1-gaosong@loongson.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--ZaAV7NyI1tMGXUno
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--ZaAV7NyI1tMGXUno
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfm0AsACgkQnKSrs4Gr
c8iulQf9FVmDVHonRw8v8FqcmZ9tE1Dx5062qVldVAdrbsY5acifFrC3AgPPl7zZ
Tydu/BDkotWLb+NzOX2UkYtwMkHUdVUv8DRnH2VP1AKGd/NNxgBBjF1ANDEO9b+g
S7u4tN/x8eRoyiTd1AWh7HIu54U6L0Bv9eOlUnk2EpnSeba++TVmRWLvLq40bwbX
NoxGJbocVpoMhoNHNYzhkILFCy/0pc81Euzm/McI3a8UlGNlnO3v23GpbCwNCGGj
eKacU7NnaAfp1uUyAyMlS9jLUtjgo9ULxI4b20WgOCW5D3PvosqE4A6/RP4kooJl
oc9voN8oZJNDwQ7dR/eRr2PD2EFu+g==
=hdMf
-----END PGP SIGNATURE-----

--ZaAV7NyI1tMGXUno--


