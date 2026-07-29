Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D49FC54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 13:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp4C9-00064F-OH; Wed, 29 Jul 2026 09:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wp4C8-00063D-6E
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 09:19:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wp4C6-0007IZ-Tb
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 09:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785331174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sryp4hFaqfg1ik5yxQ8SR+ahHklOqvC83RwyhZtrv3k=;
 b=bLKfqATZ7yFwFfNyorkxCtvulDZG3cv7QOU/QdMMt17mq4AReS76eBwrorQ+l1tBE9135n
 qSXuXoSIyhX/d91G5nYu8as2pi97h6WiF7BFsZHN0LiJFlxiONzbW3J4qr4yb7cJkkjUjD
 NI0taKl2dRqFKZo/RLNQCvwej74SHd8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-dOhaJe3kPB6pN55vYbOv8A-1; Wed,
 29 Jul 2026 09:19:30 -0400
X-MC-Unique: dOhaJe3kPB6pN55vYbOv8A-1
X-Mimecast-MFC-AGG-ID: dOhaJe3kPB6pN55vYbOv8A_1785331169
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70986195608E; Wed, 29 Jul 2026 13:19:29 +0000 (UTC)
Received: from localhost (unknown [10.2.17.47])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B2CE519560AB; Wed, 29 Jul 2026 13:19:28 +0000 (UTC)
Date: Wed, 29 Jul 2026 09:19:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, stefanha@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PULL v2 00/17] Block layer patches
Message-ID: <20260729131927.GA1379893@fedora>
References: <20260729084046.22211-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="19sp0DQPD8stHxJm"
Content-Disposition: inline
In-Reply-To: <20260729084046.22211-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

--19sp0DQPD8stHxJm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--19sp0DQPD8stHxJm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpp/d8ACgkQnKSrs4Gr
c8g6MQgAyWLYNj8n4GRhQruMrttF8ACNdic2BsY7mDs+XAkOZGkOltRUT2WcaTT4
7RxTUVRM6S0RIAT0fzHFPWaLBD3IiIQ5pz/lc6DNM5dxgUgKSDxtiUWQx8kqXBKK
Q1ckDlBkkLzVWP4H8gX5F2WofKXtpQMmWR+xMYrYsU86WakEAPOp5u6KgJlpXn1c
Dd5iIBsh2PKdM017Iob1N38coenvN2fqVJypmQ7QgBGvNNtZNM/CfwPD4m1J5jDv
R8NS7Vf+UQ+bC7hh1HlKaAwy93teCTRB5n6XJiFp+yn/BgcRyaWhvj6Dd9yvhkFq
5d6f4GinfnUGeItQlHRLSk+qmRMQug==
=JxDy
-----END PGP SIGNATURE-----

--19sp0DQPD8stHxJm--


