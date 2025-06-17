Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A570C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 15:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYeQ-0000qh-SO; Tue, 17 Jun 2025 11:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uRYL2-00015x-9J
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:35:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uRW5N-0006H7-RT
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 09:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750165842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dlz4cnXkEU/HhvjfdrOLPvvSXn0MrgwSdD4mkVEyGlQ=;
 b=aEpaQN3BJlpv9ZGaTrqJLecW8z0mEGmt2CO9dmdU2WoX0UbttZvCjSOQQzkdS7N6eSLpsB
 zU3Ksaw0esPJZHi9jWYg9rsbWtXQbhC6Q9OFqsgDxYRhAqGNvmXtIP8/g4BMV7qqcwHNNR
 W8KoSPw/BA3yyk/ULOMtzkCZ5ErrEP4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-WBWfIVExMRm8z5KRcCXBfQ-1; Tue,
 17 Jun 2025 09:10:40 -0400
X-MC-Unique: WBWfIVExMRm8z5KRcCXBfQ-1
X-Mimecast-MFC-AGG-ID: WBWfIVExMRm8z5KRcCXBfQ_1750165840
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D40321956088; Tue, 17 Jun 2025 13:10:39 +0000 (UTC)
Received: from localhost (unknown [10.2.16.91])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 502711956094; Tue, 17 Jun 2025 13:10:39 +0000 (UTC)
Date: Tue, 17 Jun 2025 09:10:37 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/9] target-arm queue
Message-ID: <20250617131037.GA114598@fedora>
References: <20250616140630.2273870-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J1CzRKsL+OqhfPjV"
Content-Disposition: inline
In-Reply-To: <20250616140630.2273870-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--J1CzRKsL+OqhfPjV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--J1CzRKsL+OqhfPjV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhRaU0ACgkQnKSrs4Gr
c8gcOAf+JmToTpbVq0/c7/u0GGiH4wEtAEr85beOHgwHD5MFmIP+HhhjX73lgYxC
F2emLOP0MPM5l/UhT61X27aX08q/G0pKpRrxKwcfC09cN+yXza/tgWhW9y97/xF8
RtU0c0ZWXTxtkE7XkUjXN8sxc1cIvr3FDdIJ4v0wZRuBdmwLqaFGgi5oRk6gmdkN
xAXBoXJ33hoNy2XyVk5tDGmowrhBwQA+fpE4w9ss4sFJ/FxxSJJcasbJ+lOJR9Bh
p95BWSuzmPg6W5YJMszqo6NX+UbSWbSGMk0+6aB6XXh9CPHiqydZXxHoS670qdh1
EvUk/MUCp1iYkvRsE/SmBsZywjlKDQ==
=pMHs
-----END PGP SIGNATURE-----

--J1CzRKsL+OqhfPjV--


