Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FF9C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 07:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqS85-0002zg-UM; Fri, 07 Mar 2025 02:28:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tqS7n-0002y3-O5
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 02:28:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tqS7l-0002IU-Vb
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 02:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741332481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ZtfjdCsIVjN31PJv5eaPeOcRYs1bom6v1DfvgO7pCM=;
 b=Li/JCzMhwvCzJldXMG95lDgVb1gJaQLA4N4cV7MCjonmbEMA6GFddlv1bAl2fL4vQmkZLM
 chH53fdpnd91gAZKljqAqGPKqNmDzCJfIZ31EiTApma20xZmv2tSgKv7Qmi9PH7+NqXzYf
 0b7N75K6Fa7qCf5BFo++b2TK4rK8LRA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-CfZtiwkgNDyCo6Ub3buONQ-1; Fri,
 07 Mar 2025 02:27:58 -0500
X-MC-Unique: CfZtiwkgNDyCo6Ub3buONQ-1
X-Mimecast-MFC-AGG-ID: CfZtiwkgNDyCo6Ub3buONQ_1741332478
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2548F19560BC
 for <qemu-devel@nongnu.org>; Fri,  7 Mar 2025 07:27:58 +0000 (UTC)
Received: from localhost (unknown [10.2.16.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 173BC18009BC; Fri,  7 Mar 2025 07:27:56 +0000 (UTC)
Date: Fri, 7 Mar 2025 15:18:32 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 00/10] QAPI patches patches for 2025-03-06
Message-ID: <20250307071832.GA362062@fedora>
References: <20250306093601.2264772-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jZZN15E76oCstTjF"
Content-Disposition: inline
In-Reply-To: <20250306093601.2264772-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--jZZN15E76oCstTjF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--jZZN15E76oCstTjF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfKncgACgkQnKSrs4Gr
c8gnywgAmuQw6DtnDD4MJDOmOCF/EMi3BQe6vSlV+2ujCJa4z+jKjGQBRcCytTLe
6KLn2i4RGKCIF5QzAY3sxJletHQBOCNrh08KVj73t/Dme9o8+l29Pxul/JH5JM0D
EiohB1WFpydLLjFXl6befIKEbSTtKAlreydIZKVLIAWs5YMCZ0CBa5kJhy/LViEr
XGVA9mTZg4namVXXCM0SNVgKIJU7fslzFWgcC1dXg69rbi/J6su3bGwa8lOsbXKC
0y1GuMP7MJKcdln+zhNIqEFYJ4XWc+xQZGIMyRCMU16epNUg99KYbvwxs/58SZTj
72SBbkPDVQS5OoRELQsByTWOpL+oAw==
=oX6/
-----END PGP SIGNATURE-----

--jZZN15E76oCstTjF--


