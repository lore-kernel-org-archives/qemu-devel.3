Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481BBC3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 17:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqFyd-0001nO-RB; Mon, 16 Sep 2024 13:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sqFyc-0001lM-NP
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 13:57:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sqFyb-0005gL-BJ
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 13:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726509448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2/kWQgtAe+cIi3PurlDdKDiTfsooYOodbVq9cSv8opk=;
 b=I5yKeTLlGOlNjpP2j0GvIJQ+4CgCaCzydAeS7jmqHxYECER7no3HhCX4ZV2t3Sosk3ebss
 S2ySpxVL57ucgKHQu+xWhjiXH9ED8RJKd9x/ziJEVgKElA0JpF1k70D9vLwkQaFEG10MH8
 eUCQLDlqnXYRJPQwrREp9Bwl1HPqeGI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-yDBcwoNBNcKBlBkuU18akw-1; Mon,
 16 Sep 2024 13:57:24 -0400
X-MC-Unique: yDBcwoNBNcKBlBkuU18akw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 893B11955F25; Mon, 16 Sep 2024 17:57:23 +0000 (UTC)
Received: from localhost (unknown [10.2.16.252])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F005619560A3; Mon, 16 Sep 2024 17:57:21 +0000 (UTC)
Date: Mon, 16 Sep 2024 19:57:20 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 slp@redhat.com, hi@alyssa.is, mst@redhat.com, david@redhat.com,
 jasowang@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 stevensd@chromium.org
Subject: Re: [PATCH v3 0/5] vhost-user: Add SHMEM_MAP/UNMAP requests
Message-ID: <20240916175720.GG521955@fedora.home>
References: <20240912145335.129447-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KHzdJlzuOCa6p12t"
Content-Disposition: inline
In-Reply-To: <20240912145335.129447-1-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--KHzdJlzuOCa6p12t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch series could use tests. The first two patches seem broken and
testing would have revealed that the memory allocation and pointers are
not quite right.

One testing approach is to write a test device using libvhost-user that
exposes VIRTIO Shared Memory Regions, launch QEMU in qtest mode with
--device vhost-user-device, and then use the qtest API to enumerate and
access the VIRTIO Shared Memory Regions. Unfortunately this involves
writing quite a bit of test code. I can explain it in more detail if you
want.

Does anyone have other ideas for testing?

Stefan

--KHzdJlzuOCa6p12t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmbocYAACgkQnKSrs4Gr
c8gEsAf/RC18v071m5KBnhgH9YsRcIXW0i99X7gpcxEMI6I+Unk3H+hT5ysZEsXZ
YXqFArl0NiPKvQU5Zn2VR8tjAs5JtrflpDoS0ndyt05yGztmoA/CnhEMvwdQ4cZz
1jOQM4KLGofNmyqRjdjR1N+XY/NGntl6CnkM/KWpI0jlsvDaozBGj/FLW6GKdoCN
C+JXSWsfVp9sBUODI1soAbxQBDLMZbolNNnmjCz3ebj/1CvAS7josbmWDSP1hZAj
Z02RXYbOD9+fy/A5irMttQSbMwSXxa4JIXhmitboTNpvX1e9aTqJqmMEswGh8NcC
iFAm4vUG0TSsyWu9jOHaDekHMsl9dg==
=WfGE
-----END PGP SIGNATURE-----

--KHzdJlzuOCa6p12t--


