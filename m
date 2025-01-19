Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C3EC02183
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 13:54:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZVkW-0003TA-TF; Sun, 19 Jan 2025 08:54:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tZVkU-0003Si-DO
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 08:53:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tZVkS-00082B-UH
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 08:53:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737294833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TcqpvuxOdI3hXbzvfH0sjfPvlJokuUa3nN8d5eDBCiA=;
 b=gsSSXqcZraXl/x5oQKzVXXEXmHxdj18HGaoV73QXUQ2EsmP3dNzdAH+fpyzZWn5k0StwWt
 2WVb2gmDkvFwfOREkP78TGgQlB3vBEsPd6uZGtTRTJdsoB/oMafM1+FbR7hAF514G8/SEp
 kxuhUuTuc3RKdC5jBm57HaEQ62fNBxs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-KjvpZyJjMBWlXiN4uPqHrA-1; Sun,
 19 Jan 2025 08:53:50 -0500
X-MC-Unique: KjvpZyJjMBWlXiN4uPqHrA-1
X-Mimecast-MFC-AGG-ID: KjvpZyJjMBWlXiN4uPqHrA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 364CD19560A3; Sun, 19 Jan 2025 13:53:47 +0000 (UTC)
Received: from localhost (unknown [10.2.16.13])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A926B19560A3; Sun, 19 Jan 2025 13:53:45 +0000 (UTC)
Date: Sun, 19 Jan 2025 08:53:44 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/5] QTest patches for 2025-01-17
Message-ID: <20250119135344.GA454720@fedora>
References: <20250117164936.22223-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QR/wAugfeIK8HL6w"
Content-Disposition: inline
In-Reply-To: <20250117164936.22223-1-farosas@suse.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.024,
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


--QR/wAugfeIK8HL6w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--QR/wAugfeIK8HL6w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeNA+gACgkQnKSrs4Gr
c8h8twf+M7etMqe5JddjYSLzQQAR8IM23aGWVGWaLLhqmAs2ATmPhmnUNrGBebBn
AJZoB3BeSEDiKYgzhMWqV+Ho6zffKjwTjIZvrM+fjTv+idseqoJrgL2XzGx4rfIK
4CC66v2WNsyOSEk0T5fGRS2ZrArl05EvJDPXePCgD7n7C2x62wvxT1Zeo4OEFhI4
uUFt8cvIwee4h90i6s0RUuZog4CE7NmqpzjuHOG1uTzs10KUoxZ6/6D12g5LfBEm
9YYrHwbyjjS6N+4miPY6442QJuwQxPRs4hdb2y09p6Zdfx1C2SKs05kxZ5/PXW+S
+QrXtX5kykYvpPFGRyj3BZUBqPV3jA==
=+FZv
-----END PGP SIGNATURE-----

--QR/wAugfeIK8HL6w--


