Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61913CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWbOE-0002gg-Rd; Mon, 08 Jun 2026 10:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wWbOC-0002dt-R3
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 10:55:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wWbOA-0007tg-T8
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 10:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780930542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vivkKbYUQlgiZiBKMz4lpunyDUwRworcJCL2DLxtdqg=;
 b=FKLXsuhr9oV2djmmFay43GzDmrPaeFQpXIW4V7tblSU0sA94FKrluPQqutLEy1PcQ9dfq7
 L/eDFK+RLFlAjDZgv+TFDm0Yn5McXGVJo1JuBq9O5pSMJErpSk1e0FdR8ft4DNdNmFv07A
 M2ZSbVetjBm6LvuwjulBE4rcFPEsa6E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-5KaaFBNOP4ulEahRZQF1HQ-1; Mon,
 08 Jun 2026 10:55:36 -0400
X-MC-Unique: 5KaaFBNOP4ulEahRZQF1HQ-1
X-Mimecast-MFC-AGG-ID: 5KaaFBNOP4ulEahRZQF1HQ_1780930535
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4CDD11800590; Mon,  8 Jun 2026 14:55:35 +0000 (UTC)
Received: from localhost (unknown [10.2.16.156])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2FD7D1624; Mon,  8 Jun 2026 14:55:33 +0000 (UTC)
Date: Mon, 8 Jun 2026 10:55:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PULL 0/2] Block patches
Message-ID: <20260608145533.GA483065@fedora>
References: <20260608132524.470459-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/J9t/vPPeiVywWFE"
Content-Disposition: inline
In-Reply-To: <20260608132524.470459-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--/J9t/vPPeiVywWFE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--/J9t/vPPeiVywWFE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmom1+UACgkQnKSrs4Gr
c8gL5Qf9Fr0JtshbKI05mx5ds6/MJzYunBewIm0gIlhgbgnqAOAl9LGEWK/cDopN
M0Cm8bobHa10w6KmMBHmebRdy/fIZwIZjCwzCIu4g+Yf6jkx63li+mN1Ec1BNCvZ
R/nVmxauWdpTEDnI7ugP1AGMnIeqy4Bxh+RP6xvebIjh3WBXgq+gAxuApk+T3Ij4
KyAqRwkKqbnrhX6BzwDC498ZKIlv6cRPzHg3NBoD+omYFNpd2MVsoxsOW33Ms46l
/pYDXoZdIj5UdzmBOWlZ6pW+4Qy10N1xrE9xTbTFRsESnhYlk/x6pua0oNgUPLHc
UM+f4psqw3v63Sqfal0G93ORbAjzpQ==
=hRoA
-----END PGP SIGNATURE-----

--/J9t/vPPeiVywWFE--


