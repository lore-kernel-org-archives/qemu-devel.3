Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F35CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 22:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPpHs-0005ch-W6; Wed, 20 May 2026 18:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wPpHq-0005bY-3w
 for qemu-devel@nongnu.org; Wed, 20 May 2026 18:21:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wPpHo-00009P-Ft
 for qemu-devel@nongnu.org; Wed, 20 May 2026 18:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779315666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=acIh9Jnw7ovLiHOFWiIwrbAtyhR+QTAsKudLb/WMXdU=;
 b=aFeBlfGV6TQyMVR+BEP2ZQp+xy8iwthLHiHOQ6umcoU5v9aqWZma0+obaxUi9ctrUuvXGz
 nDiXqHzKCOqC9nl7zBbQpujQMIM6LVKsFGnDU9kxHBqz0ncTk2zCcxBGVVW0MRxvrpqFan
 9vksJJW1cCFxzGThx1x86yjQ/uwzauI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-DScphJf2MoC7aGSbSotLUg-1; Wed,
 20 May 2026 18:21:04 -0400
X-MC-Unique: DScphJf2MoC7aGSbSotLUg-1
X-Mimecast-MFC-AGG-ID: DScphJf2MoC7aGSbSotLUg_1779315664
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7AA11956096
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 22:21:03 +0000 (UTC)
Received: from localhost (unknown [10.2.16.222])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 51C3F19560A2; Wed, 20 May 2026 22:21:02 +0000 (UTC)
Date: Wed, 20 May 2026 18:21:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 00/11] vfio queue
Message-ID: <20260520222102.GA403994@fedora>
References: <20260520162115.1613601-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yAEYM0JjSTJhq4RU"
Content-Disposition: inline
In-Reply-To: <20260520162115.1613601-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--yAEYM0JjSTJhq4RU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--yAEYM0JjSTJhq4RU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoOM84ACgkQnKSrs4Gr
c8gpvwgAsjSgdgWwv9qLu2bBvJ3zKz1zSM5Vym62Z3kZsPT+KyoSBgqkoAgFszTQ
BwBGsFA39/Ipq2eszLo7tIjaI2DMNnDiHMaPC6uHFaBwcegfpB73qTmUNtR8pqIT
3yUi0FQJLkdlYECpldJI/AI4XrXLUTO1UU+DGWerHY+je2WfNRC8okprxp7UZG2E
mmN4Ftvdejpn1DOFTpvQ83aQCsFLih7yOMPwC3zGxLphIqHlDMjcCDLio/Nv8UE7
ex086yFjf+iV66NgWFYKSrG7/t3xh0+wfBzUVudLVhovBEHl7K6eiB5ma+wFByQx
7n5wErUbaW/99lxub9aFc4Ctt0ApnA==
=dwa9
-----END PGP SIGNATURE-----

--yAEYM0JjSTJhq4RU--


