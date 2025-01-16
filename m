Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D19C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 22:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYY4l-00045L-S6; Thu, 16 Jan 2025 17:10:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tYY4e-00041z-A5
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 17:10:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tYY4c-0004Kg-Ro
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 17:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737065446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QPkhTiiAT3cKPMclNKULVSWWfZm0gGVGNakjZ9Ptmu8=;
 b=gxr3ZK/h0Fd+ucNi+Y5UIBmXnhRR5lkW86XcbKXpHzhVcRDwrLhSRMDgB568iJzruj6FCp
 x6qOlvHBI6J8hEj/FRvc2aIns0DrnM+3KjUi4l7I8yntHddnz9oVgZb2iwtjzir+9Hff4O
 6uyhKuVEU3rIlQi3EhDQKQcv1AQuyFk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-k78UleaTNI66dt_BGMGrqA-1; Thu,
 16 Jan 2025 17:10:43 -0500
X-MC-Unique: k78UleaTNI66dt_BGMGrqA-1
X-Mimecast-MFC-AGG-ID: k78UleaTNI66dt_BGMGrqA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C528195608D; Thu, 16 Jan 2025 22:10:42 +0000 (UTC)
Received: from localhost (unknown [10.2.16.180])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E894E19560BF; Thu, 16 Jan 2025 22:10:41 +0000 (UTC)
Date: Thu, 16 Jan 2025 17:10:40 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/48] virtio,pc,pci: features, fixes, cleanups
Message-ID: <20250116221040.GA378456@fedora>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3ojoEcOK25sq+r8F"
Content-Disposition: inline
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
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


--3ojoEcOK25sq+r8F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--3ojoEcOK25sq+r8F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeJg+AACgkQnKSrs4Gr
c8gIdQf/Tc009e79GSE5FlWyRqWrt5QQfl8M2DI0dz/g9gqyYbMGySJuLR63JqdG
OWPI2RZOqUi5oUrYD+M9tZEuvqbMCCMM5rjZOGvEyQFOkaqDEC8kQJ0esXUYIShH
3c4CM4BLj9qZDAhv8Fm8C7d02dryrkUmQiJz98V7/Kwg5bEWEi7l+LOaFBMfEB0n
ZuJDBmCqyYKlVyDOLNrf2VCRl18Dg1qXPqK0zHpq04Zz+02gnkaCRR4oMSL9dgLL
+9AAhLVbc8kOGi6WERW1X4NuTmVb0ryQbsrJ/ssqbidSeTw879ZGmgxZ+IZHeAZF
3a7YcbMcufJV444z/XjolMqiptEJ2A==
=3pvX
-----END PGP SIGNATURE-----

--3ojoEcOK25sq+r8F--


