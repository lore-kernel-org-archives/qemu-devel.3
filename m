Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60858C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 02:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tka8o-0006X3-Uz; Tue, 18 Feb 2025 21:48:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tka8n-0006WZ-GL
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 21:48:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tka8l-0000qH-Sz
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 21:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739933327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nZnL28YGcJtPlaN0yRCyUOjxsm8Wn+un5EqacPlzE50=;
 b=i9e8nHi/MjAPSTHFOPA+h8YQ3FdQEN8vaKlQpDQ/+L7tnEZQvQIrmEXwhVrV06pA3GOwyX
 mFRLQk7mDDrirnxy45b7+EKR7iLAZdIv0Kb6+juB1OglnrGEFnx+6gxs/Cw7utHIjlpNK2
 LZjS7VYpO2xY9IQTpRE7s0TFhdkgCzM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-iXu11m_kNaiWBtUTKI_C5g-1; Tue,
 18 Feb 2025 21:48:42 -0500
X-MC-Unique: iXu11m_kNaiWBtUTKI_C5g-1
X-Mimecast-MFC-AGG-ID: iXu11m_kNaiWBtUTKI_C5g_1739933321
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9600F1800879; Wed, 19 Feb 2025 02:48:41 +0000 (UTC)
Received: from localhost (unknown [10.2.16.53])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2CEF1180056F; Wed, 19 Feb 2025 02:48:39 +0000 (UTC)
Date: Wed, 19 Feb 2025 10:48:37 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, peterx@redhat.com,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PULL v2 00/14] Mem next patches
Message-ID: <20250219024837.GA44099@fedora>
References: <20250212173823.214429-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cuDdNHhImMe55F6M"
Content-Disposition: inline
In-Reply-To: <20250212173823.214429-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
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


--cuDdNHhImMe55F6M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--cuDdNHhImMe55F6M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAme1RoUACgkQnKSrs4Gr
c8gZEgf5AZ4TsXua8rQpb7Cz5r3xqoTKhpeEnacEq9KQXNOU4bC8VfF8qHsmCwQW
KEAJxCzjm6KB6aas7mzdvOldNKOZT/exdFg9HWPS+Bt4kdKv07CNHIecPwSmjaCE
SDnsdgu8li1q+h0ww4BFj9ZJjmWYUdfmrNQXv6V/VrRgAwRyyhlJQgDme43+KJqp
CJANP6X3g+/kZ0YoJipKwtYRtEFIEsEbCycZexqtyl3XLuzLbE5FtyvvCZANGUku
iw/Xo/G8niIjOaeBWJ7FCCLix6olMHJnQJfYJpbISbg5UEKu8/W5KzuLbnHuv2wC
/0gEfDtw15UEKfMWfO/qFG7YWgr1Cw==
=6lFM
-----END PGP SIGNATURE-----

--cuDdNHhImMe55F6M--


