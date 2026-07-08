Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEE5C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 08:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whNQs-0008CH-UG; Wed, 08 Jul 2026 04:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1whNQZ-0007uN-Fm
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 04:14:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1whNQW-0003bT-2t
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 04:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783498479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dTmKrxdlAZa6x9EcJzEfqDvsL3Gh9IxTZoFvOx0hU7c=;
 b=evaN7s5po/Iubh1BMpevAvJ3qcvZzFeYkfVOy89y/DAjPqzssjg7kmJ1Qd8/ab1g074yn/
 mT6g6d+XrRSQIoCk9BUnq2K480X8uVipzLwB//NL0xiO6+MZAOHAG4Y9dyqQdgLAUE9hW9
 P0og3vr6uwCYHmyFssyt/ANI3xGMXRE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-ZIkNMqujM8mcH6bX6DPxiw-1; Wed,
 08 Jul 2026 04:14:37 -0400
X-MC-Unique: ZIkNMqujM8mcH6bX6DPxiw-1
X-Mimecast-MFC-AGG-ID: ZIkNMqujM8mcH6bX6DPxiw_1783498477
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0946418005BC
 for <qemu-devel@nongnu.org>; Wed,  8 Jul 2026 08:14:37 +0000 (UTC)
Received: from localhost (unknown [10.2.16.35])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4809C1800370; Wed,  8 Jul 2026 08:14:36 +0000 (UTC)
Date: Wed, 8 Jul 2026 07:53:34 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 00/35] Monitor patches for 2026-07-07
Message-ID: <20260708055334.GA553564@fedora>
References: <20260707110300.1918153-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="w422K/XTNtjkGVwy"
Content-Disposition: inline
In-Reply-To: <20260707110300.1918153-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--w422K/XTNtjkGVwy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--w422K/XTNtjkGVwy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpN5d4ACgkQnKSrs4Gr
c8hIdQf/Zq3tI4qdibXTklKIxm26CTvxnX4GSnNzYwhQUKsD50G6t2f5r9VRfPQP
jpBPQwSkFliOPoZ4YhGN4+a5YmgbOmIo8n16hUORbCwq6DYg+FOWir0QF39waxZZ
KpwhjXHw63iLLgVOIjfz0JD06pe+sLPk9qqJeUD0aBO6zn1DAdZ0edpE7hwb0osU
pmvgOTr1yMnDo2ScHs3wtjhvqTovEExGp40nYoPKNjLRaJC+DvWR/eN2AqaqS7H9
awQgZC3gr5JeEKA1WKrwEfuNAlwnRGot7hDP5RhjiJygtvMrPcOPsSeKxYXapA/x
jfDgBr4t63LfRaxqsJ8gaZbrUlyHaw==
=4ioV
-----END PGP SIGNATURE-----

--w422K/XTNtjkGVwy--


