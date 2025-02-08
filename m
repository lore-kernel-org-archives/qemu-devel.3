Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CC7C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thV6z-0006JW-I3; Mon, 10 Feb 2025 09:50:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1thV6x-0006Hi-NZ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:50:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1thV6u-0002jv-SV
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:50:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739199006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ryrObfp/UuE4SHuGoBWHhr9AAt/ck4bJVFVIQ8p7t8U=;
 b=di+i2EP4FC8f/9CT6gQJI7St5b0b31iQ34tfxjzEqFoEVdK4vl2vMAgyV4ek0geZCfBki5
 iK/dJUcEd6sZze7TB5bZ5kB37rhNg51DXfmnGIUKjqHT5dIkCapsm8M4UPT7sdwKMldrWU
 x928eqVvY2r3eXQYqF4UoOAK2vd3ExI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-ViplXmF0Oq2VWFg-VcFtRg-1; Mon,
 10 Feb 2025 09:50:02 -0500
X-MC-Unique: ViplXmF0Oq2VWFg-VcFtRg-1
X-Mimecast-MFC-AGG-ID: ViplXmF0Oq2VWFg-VcFtRg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBBED1800871; Mon, 10 Feb 2025 14:50:00 +0000 (UTC)
Received: from localhost (unknown [10.2.16.124])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 02A7B1800365; Mon, 10 Feb 2025 14:49:59 +0000 (UTC)
Date: Sat, 8 Feb 2025 11:08:39 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL v2 0/4] 9p queue 2025-02-06
Message-ID: <20250208160839.GA59515@fedora>
References: <cover.1738921999.git.qemu_oss@crudebyte.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tpdPXnYzV7Q24cyz"
Content-Disposition: inline
In-Reply-To: <cover.1738921999.git.qemu_oss@crudebyte.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIMWL_WL_HIGH=-1.388, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--tpdPXnYzV7Q24cyz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--tpdPXnYzV7Q24cyz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmengYYACgkQnKSrs4Gr
c8jOHAf+Oo40QUJO+VFhOCz5EVqz7p6p0OI/xS3UJt2s757RAo5Nui/FCA/B38Iw
BnYwBOBDmRzw5dy/8lj1P6W/uFggioOtHAVZEcbQh3PwdixRP2IfobXa6qj1U7he
h1s9oowd0xrkuYju4CMn4OoJ2ZgBRr9NMCCvYUYDYQZ/pJq6Bjn/FQbcTSpEWAb5
MCccvkf5zgCMTBpiWc0jTsa7O1/4sfsb8vPulIDOXuIMCVC/55EoqWXRh846JhPQ
VI1tXNkI1r7apmFC3krYw8mRLgdlZngRx5LCuibF/VLwcbYrVBnmRfdj1qgu23C3
Efnsh5cxJgwF/R2xuNeXlttpyZqzcA==
=/+Br
-----END PGP SIGNATURE-----

--tpdPXnYzV7Q24cyz--


