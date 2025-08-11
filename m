Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805A5CA0EC4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 20:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulZNQ-0007yS-3X; Mon, 11 Aug 2025 16:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ulZNM-0007xk-Pj
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 16:44:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ulZNA-0007QE-39
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 16:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754945035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VzQCFKMhqEh/PVUsTrvblcN34EXJlsBwSnx0OgA2+gM=;
 b=GGUM5cvhVlVp4d9EuIZfhy/iOnq/5Fj3rtxDLEtkWZaMxdaxUnpPt07X7BbGzmeY/Bqkl6
 4Y/HGUFtW+0ciFyt0UTOfwyJ9cqGkl6p9gbcGwFWjcTJTgp+P9D54lPv5/JZwajapspuhc
 9FgCjxWzHu66dBCZNsJn5iOzMg00ISM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-uE-r-EsdPBWRtv7eb9Q_hQ-1; Mon,
 11 Aug 2025 16:43:51 -0400
X-MC-Unique: uE-r-EsdPBWRtv7eb9Q_hQ-1
X-Mimecast-MFC-AGG-ID: uE-r-EsdPBWRtv7eb9Q_hQ_1754945030
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7514A1800286; Mon, 11 Aug 2025 20:43:50 +0000 (UTC)
Received: from localhost (unknown [10.2.16.174])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ABAE11800446; Mon, 11 Aug 2025 20:43:49 +0000 (UTC)
Date: Mon, 11 Aug 2025 16:43:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PULL 0/3] nvme fixes
Message-ID: <20250811204348.GA77977@fedora>
References: <20250811112557.521-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7CwjE2Y3EZRKBuvF"
Content-Disposition: inline
In-Reply-To: <20250811112557.521-1-its@irrelevant.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--7CwjE2Y3EZRKBuvF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--7CwjE2Y3EZRKBuvF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiaVgQACgkQnKSrs4Gr
c8jkTAgAjNhVp8mBNihRD6GMPh/v/EIHBPY7/SQYfRaCBiKewmcW5GHpm3sgGZnu
D5BofshBI8Nt4Tdaws1wXyZJ8NS8wBWtzZHKY9glYCVyj+Wr/oIHSu/aqmRrkPo/
VYflmETIdSJbsguoAbK8eiXkGp5tKfk1PLM6qFpRJzhw6QA0AcIkNK5jbH/6l0Yp
tkUAXFAIh8tpCg1Mvh1aAaViqbC15VmhS8oB2r+ci9OmPjI0O+LWCyxaMj08oTE/
FkGiGc4tGHp+T69GrUw85LpcG1tnE7xTnTclwTg5Dwb1yuo0/P5+3d5pxSbeKI93
+iDFLYNJRIgrN6ACUYxmsQuauYWrAw==
=MbZc
-----END PGP SIGNATURE-----

--7CwjE2Y3EZRKBuvF--


