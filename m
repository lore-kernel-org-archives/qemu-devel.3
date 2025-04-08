Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F830C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 00:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1wzf-0004eB-1B; Mon, 07 Apr 2025 20:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u1wza-0004dA-K8
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 20:39:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u1wzZ-0000nx-0G
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 20:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744072743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nv6znmSkgHCwo9KDCJIL5L1t6ga8etgKQeMNfWntINc=;
 b=UeIAnpetoK4TAO2dm0S84zd90hwN8ZqkFUQAFXqwjHr4K/2dCuYlhHb6NEBYRXKfiwwVF+
 BIgg/uUpID4nvh19aRlV3EJ+BGGToZWxiPkEFrV2QgwnbWrp2yJ3lLwtuyIRJJsN61L1d9
 1yKiE+BJQvEI/lCpOxpYUCijJ530wNw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-2_G6ofmGOOKip9Iqp1wb0g-1; Mon,
 07 Apr 2025 20:38:59 -0400
X-MC-Unique: 2_G6ofmGOOKip9Iqp1wb0g-1
X-Mimecast-MFC-AGG-ID: 2_G6ofmGOOKip9Iqp1wb0g_1744072738
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A9B519560AB; Tue,  8 Apr 2025 00:38:58 +0000 (UTC)
Received: from localhost (unknown [10.2.17.100])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9C53B1801752; Tue,  8 Apr 2025 00:38:57 +0000 (UTC)
Date: Mon, 7 Apr 2025 20:38:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PULL 0/1] riscv-to-apply queue
Message-ID: <20250408003855.GA512352@fedora>
References: <20250407051214.95248-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GWCJMuAooyKOsBcw"
Content-Disposition: inline
In-Reply-To: <20250407051214.95248-1-alistair.francis@wdc.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--GWCJMuAooyKOsBcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--GWCJMuAooyKOsBcw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmf0cB8ACgkQnKSrs4Gr
c8ic9wgAv8gvQ/GsdFE+fREkippLEelSl0eOnnAT7b5qrzUrgjjlarjlbpZFm95d
FcKn0t+K86S8bVfuA3QyN86wEx3Y71Mqgif/qErwI1kQjY3NZQXqkler7iVN7lwE
mVWMVgrCAdma2qmtAaZRUqe9rbMhvzfE9nO62O2yg7U1tG7TkQJDchMh7h9z0L9B
4MjHIk6pPno+X9CTKzQFbKaYGOEhvx6CXmeAG+nZe0l8weUYXxvCHs5qY1k/ftuS
mEaurQbvBZG1gcEJiS+1wiVXqYf3RTSPaJ7Mi9XHvpxtlfVkjE8g3TP4VaCewxhe
dLs5RiAMsfE7TaVy/N1yRm2pkJeNKg==
=XiB6
-----END PGP SIGNATURE-----

--GWCJMuAooyKOsBcw--


