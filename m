Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9AFC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 20:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhwff-00036u-UC; Fri, 01 Aug 2025 16:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uhvWt-0004sR-3X
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 15:34:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uhvWr-0001vS-KC
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 15:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754076894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=twEFaZdduw8BrdFxZS0z1KWXXdKIpMMyMWb08vQAL8g=;
 b=J7f8unQUt8eE+HSS8VEuWrJj5WRr3BkDYNqXhgfOdt16p9tVdr4n0CLtEdYTZ6PFkp6EVw
 jIWToPX8C+9qS+6YUzeR+DbV8YcEBsXS7n5RoXZnlxDORNA7RM7qeAnY8TYoA6YPyUPTMg
 EXt8tv+78xLKvtnzXillNvoAdDrYgek=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-67OljLEfPQKYnJogxHOzcw-1; Fri,
 01 Aug 2025 15:34:50 -0400
X-MC-Unique: 67OljLEfPQKYnJogxHOzcw-1
X-Mimecast-MFC-AGG-ID: 67OljLEfPQKYnJogxHOzcw_1754076887
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0110F19541B2; Fri,  1 Aug 2025 19:34:47 +0000 (UTC)
Received: from localhost (unknown [10.2.16.88])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 190A31955E89; Fri,  1 Aug 2025 19:34:45 +0000 (UTC)
Date: Fri, 1 Aug 2025 15:34:07 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, qemu-stable@nongnu.org
Subject: Re: [PULL 0/2] loongarch-to-apply queue
Message-ID: <20250801193407.GA185396@fedora>
References: <20250731085332.247531-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WLLGBXttziC3nWMQ"
Content-Disposition: inline
In-Reply-To: <20250731085332.247531-1-gaosong@loongson.cn>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--WLLGBXttziC3nWMQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--WLLGBXttziC3nWMQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiNFq8ACgkQnKSrs4Gr
c8iqnwgApnT59/+PQXmbOZko1XsXedvz53hpmpmtKokik5iE7Y3E81TfHlruPIds
sBbi8CFuXgRrbiAWeNEyJ0AZcnaEqYN+ssCK/GpjrqFoXjj+F2ojV3OCJO2bIqcJ
p6TCdKT/asEDw3ai22JfsCJjcqohCxBG7iL/ZiIRG1mYG1v7WGFynhQZVej10pYe
mSxamOT9+uzlA+S02+QBPZDrHvz99rbUqtbMQqt7+MSYSLregSoROQSbx2xlxB12
wk9cHjUr8P9lLGiV56lsBpd0tWKGt+/jcZUX9Cl8R2NHY8Czxc1fEA+8zn1QXFef
4Bjc/4zjUENTiN00tqbcLkYPqvqVYQ==
=ApNb
-----END PGP SIGNATURE-----

--WLLGBXttziC3nWMQ--


