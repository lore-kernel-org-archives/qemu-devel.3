Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B164C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFC4B-0006Qv-IL; Wed, 14 May 2025 09:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uFC0M-0001VM-K1
 for qemu-devel@nongnu.org; Wed, 14 May 2025 09:18:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uFC0G-00036S-Jx
 for qemu-devel@nongnu.org; Wed, 14 May 2025 09:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747228709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZNKaa+Ft57Bf96hSWPfFAgvUDPCuibLk5FSPX2PK9aU=;
 b=GQg3TeIfZo3ZrGXxFD6+6OR4Mx9eK7OFTQ+sRsoz7RVceOyT+7EUTbLukA8vu9bqZbT9oC
 8ll1dzfZcafRCbXEGBJB5XW9QJPHLEtzFVLGrVI+X7ymVmXprbzwYfcVjkL9YtdrbT5jUA
 kQRPNb08E1LzYJllPO1RRpkAEJxhHuc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-_qDxuXNqMOSMsJu4b-c_Qg-1; Wed,
 14 May 2025 09:18:26 -0400
X-MC-Unique: _qDxuXNqMOSMsJu4b-c_Qg-1
X-Mimecast-MFC-AGG-ID: _qDxuXNqMOSMsJu4b-c_Qg_1747228705
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 330B11956094; Wed, 14 May 2025 13:18:24 +0000 (UTC)
Received: from localhost (unknown [10.2.16.56])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7243718003FC; Wed, 14 May 2025 13:18:23 +0000 (UTC)
Date: Wed, 14 May 2025 09:18:22 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, maobibo@loongson.cn
Subject: Re: [PULL 00/17] loongarch-to-apply queue
Message-ID: <20250514131822.GA265263@fedora>
References: <20250514073927.2424543-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dhPci0/4hKUD/Vlz"
Content-Disposition: inline
In-Reply-To: <20250514073927.2424543-1-gaosong@loongson.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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


--dhPci0/4hKUD/Vlz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--dhPci0/4hKUD/Vlz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgkmB0ACgkQnKSrs4Gr
c8haDAf9FCCg/iuK/7Z0RVyvAtA4wKwC0FgmUTImTcojkXfCwUidQOMxbarNlQY0
snrX/4u+0zMT3ls9rV/lPJcTV7MmfMdzYgtnhKD2yHAX0sLACRd46zWMhNKC56FA
a61ZIAFV4aGFyL+IS6KbgXqqWNkNyRM2JcwIWZBfBtkFtCbE0ARprBXt9ab/sERd
Xc7pVsEEH4RT5R4KBQXTHZBw3CwZ727RvUkkOB29d7DBlwlCrjFUNu8ueG/quisN
3TSEagHKlGYyIZxVijbjAfTQ5OzlnKuRah/B4mgDGfIyDKOd3zVLKc/mULsUGxyh
g8iCNMppV0K84DK1MDjaHQpN7hi7MQ==
=zPAk
-----END PGP SIGNATURE-----

--dhPci0/4hKUD/Vlz--


