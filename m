Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F25C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 13:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCIp3-0000OE-7R; Tue, 06 May 2025 09:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uCIp1-0000Ak-Ac
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:58:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uCIoz-0003Pd-KA
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746539936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GRtLdfIXtR3+kxwXh3UY86ip/ewA38vFl55Mt3fC1D0=;
 b=N3lbXcrkDCVdX63ows2uwe9ON0w1gXJ2xxm5VuaQ/ohQzF+NvMRm7e7hP4k5edLDL3XK+8
 YOW8/JsCyytT3Km4+k084j0R7m/xmZvD6etvF034xm8f2BuwMxh9pFZ6TQ54Vrmsyv7NPG
 QpC3nvlJVYsPmb5/477iiukDbNwB4J0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-kMKYn1C-Od2CaKQHw5oZkw-1; Tue,
 06 May 2025 09:58:52 -0400
X-MC-Unique: kMKYn1C-Od2CaKQHw5oZkw-1
X-Mimecast-MFC-AGG-ID: kMKYn1C-Od2CaKQHw5oZkw_1746539931
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EE9018009A7; Tue,  6 May 2025 13:58:51 +0000 (UTC)
Received: from localhost (unknown [10.2.16.219])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD0D71956094; Tue,  6 May 2025 13:58:50 +0000 (UTC)
Date: Tue, 6 May 2025 09:58:49 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Greg Kurz <groug@kaod.org>
Subject: Re: [PULL 0/9] 9p queue 2025-05-05
Message-ID: <20250506135849.GA302950@fedora>
References: <cover.1746438650.git.qemu_oss@crudebyte.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JhUKhOMCEUNY43Hz"
Content-Disposition: inline
In-Reply-To: <cover.1746438650.git.qemu_oss@crudebyte.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--JhUKhOMCEUNY43Hz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--JhUKhOMCEUNY43Hz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgaFZkACgkQnKSrs4Gr
c8jMwAgAmxT82MSZoV+9KNUF2v/Py5FGd0aVex34A7Uw7O39jtL4RptBIiGOKoLp
l4tFUs+n9m3vu9l3mlBcdRj4EHwSLDNAY/jHkVS+uIj/cgIzsgyt8ChrHBUYFzFI
7h+sHvOwa11e89j1k9sdbnkzlcxZNrr2rushTTZOo6jF7jGvecM5aO3YdweGr8GC
yEfKvGKZaruv4ptskCrPSk6+y8uHjiv5UBdPuyn3yrPXfQ29WvTXDgzuotGKnl5I
yAqqsP+UkKK7fCHO8dio9y+Zj0NfDGkj1HEpj/+4m702HyvYY2nWmEg0rAOp2snf
ekhxRffdj5ybnBABkzQ9tgKBVe4AFw==
=hOgb
-----END PGP SIGNATURE-----

--JhUKhOMCEUNY43Hz--


