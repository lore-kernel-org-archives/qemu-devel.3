Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7679E7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 16:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvSt-00037i-6j; Thu, 09 Jan 2025 11:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tVvSr-00037L-BQ
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:32:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tVvSp-0001x2-NN
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736440373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p8Fjvnrk2vCRwOBKcseNxCjLWR4mRSFDfEZOKL9U29U=;
 b=ipzwoee/+4iIRTYENryHMVG5yx5pNGaBp3paxpLSi0aG5qcXTnmxIuzn7euZxT52F3l7na
 NxCcd1dwF3hj/ZDmN37lqpyaFcoJcGiB55KMAkYuSDNZKSHr+f0M0QWZhBAd+4ZG+aeCMI
 g/Gn3Czbf/KiOEnEHNIlXkEQRqUiivs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-mCIdg8WhNsqekUKvuNYkxw-1; Thu,
 09 Jan 2025 11:32:50 -0500
X-MC-Unique: mCIdg8WhNsqekUKvuNYkxw-1
X-Mimecast-MFC-AGG-ID: mCIdg8WhNsqekUKvuNYkxw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C18701956053; Thu,  9 Jan 2025 16:32:48 +0000 (UTC)
Received: from localhost (unknown [10.2.16.220])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D01A519560AF; Thu,  9 Jan 2025 16:32:47 +0000 (UTC)
Date: Thu, 9 Jan 2025 11:32:46 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PULL 0/2] xenfv queue
Message-ID: <20250109163246.GA190877@fedora>
References: <20250109104837.2532259-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3WpbpWsFrY7RLEtB"
Content-Disposition: inline
In-Reply-To: <20250109104837.2532259-1-dwmw2@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


--3WpbpWsFrY7RLEtB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--3WpbpWsFrY7RLEtB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmd/+i4ACgkQnKSrs4Gr
c8gC/wf/Wl6/6+wauCDejiY1/pZJF5x0YQT4x/436+Wk2QLo2RpfdEYElXfmzrq6
IWzZFlGiufzM3tX0tIhvhGnq00vh9utHkU8IVkHQl3Vg/UPD20jn0yA9edKGardR
Be6Wu1iaCxLe3zr26OSlcZJjJXmgYQsQhmww/fUE/to0CQI+Jy+fQxsVtUfMZIvF
BwS+mZqp4dJoO4QX848YOSYM/wDWJWeSSsnMTpcwcwFWA3FYWj7DEzQtp2BT9yNv
rl8rcVru7cW6VYkwLZdcZWr7RwP9jGwvv2Blb2G/j45Es3ayLTndxSplKFxFzhOd
y4L4R8LR4Jtcwhcjf44Wf69NIm6nlg==
=TXKe
-----END PGP SIGNATURE-----

--3WpbpWsFrY7RLEtB--


