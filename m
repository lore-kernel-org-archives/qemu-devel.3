Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01483C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 17:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiGhI-0003Dw-80; Wed, 12 Feb 2025 12:38:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tiGhG-0003Dg-VQ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:38:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tiGhF-0005Xj-LQ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739381929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Y6dBbDyvZ4FYif1CDW6FjXsmGWl/SFMNx5v82ANlU0=;
 b=GldgyRwHTxz1JMg9lbNLA3fXcww001PYzscURWNuMae3QWoEeTzMCx5xdZjVhdYL1xmod/
 /fsKMYwmSb3xdfDW39HC/rNFbCPv5sFs1OniIsQM6twwNHfax1iQxHk9xO5dY+D3VKgWE8
 6ZASsLa3gOkEo6mwbQAQHAzunpd1nL0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-IYeNfXM6NkOCIViLSXcnSw-1; Wed,
 12 Feb 2025 12:38:47 -0500
X-MC-Unique: IYeNfXM6NkOCIViLSXcnSw-1
X-Mimecast-MFC-AGG-ID: IYeNfXM6NkOCIViLSXcnSw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7164A1800873; Wed, 12 Feb 2025 17:38:46 +0000 (UTC)
Received: from localhost (unknown [10.2.16.66])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD62A1800352; Wed, 12 Feb 2025 17:38:45 +0000 (UTC)
Date: Wed, 12 Feb 2025 12:38:44 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/68] target-arm queue
Message-ID: <20250212173844.GA211882@fedora>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ggW0+lnD3qtlfnZ6"
Content-Disposition: inline
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


--ggW0+lnD3qtlfnZ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--ggW0+lnD3qtlfnZ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmes3KQACgkQnKSrs4Gr
c8iQ1ggAhKW2G/wI7o3swkfrnIwTQxdpi92HnQQvECONLB0Q/uqmEF8R9UkKiaqa
yw1cnzlfr1G7QIa9HF8uURqT0KPUjIaV0Nk1yKbKLDVuyBFvxwNnG76Dk/gfIWxn
i+Xfguu+cpOgjG3FbqiQPehlfJCX71SztGdeOUZ0bNITVtzfcpPdEgptnLgEOj1x
iLbpa3+upH7XBLxflFFGw8NR/GsAhdJsrYc4txb2b2Z5icASdFLyW01P6/w2pFAF
QT4CckVTuc9weTzOZF1RNCN9FrKASWwDT98yClKQI+0baSl+J+48qjNG0vZV5xlr
MJUHu5v/vG87j7LIKh1GK+mCFPdW/Q==
=Ysk/
-----END PGP SIGNATURE-----

--ggW0+lnD3qtlfnZ6--


