Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4005C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 11:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM3j9-0000yQ-UY; Mon, 02 Jun 2025 07:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uM3j5-0000xY-OP
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 07:53:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uM3j3-00019V-E6
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 07:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748865188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ROU+ARYao63PlvfKCUdPO8A1o7lRJAi997jxmdA5DDQ=;
 b=dWW24A8tgT1O9WCRkqqGoN3i2Q6tRe6Wx0DLoXZyHNflinwPJuVfeiJ5mcxhu3SFBD5RDP
 k+2/uyqcz9Gu8SwxQiH6y8m1yB15QgrziQJ0VEzkruL3QlJhfTNY0vTQpPsYgBD8sGWO3W
 PDaV+TIgFYzSkJvHyO7rJDeDpPD2E+I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-qVriD_HcOw2W26EGAbK7Xw-1; Mon,
 02 Jun 2025 07:53:07 -0400
X-MC-Unique: qVriD_HcOw2W26EGAbK7Xw-1
X-Mimecast-MFC-AGG-ID: qVriD_HcOw2W26EGAbK7Xw_1748865186
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 902D9195609F
 for <qemu-devel@nongnu.org>; Mon,  2 Jun 2025 11:53:06 +0000 (UTC)
Received: from localhost (unknown [10.2.16.122])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0CFDF19560A3; Mon,  2 Jun 2025 11:53:05 +0000 (UTC)
Date: Sat, 31 May 2025 19:06:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 00/25] Functional tests, Microblaze endianness & pc/q35
 cleanups
Message-ID: <20250531230602.GA268188@fedora>
References: <20250530114709.186993-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HY1ANHi/QK+YgARj"
Content-Disposition: inline
In-Reply-To: <20250530114709.186993-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIMWL_WL_HIGH=-0.015, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--HY1ANHi/QK+YgARj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--HY1ANHi/QK+YgARj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmg7i1kACgkQnKSrs4Gr
c8izpwf/TFomCRrrh7vwJDV6+ncsiJ8eI91YMgkC6jb/M9si4kY5QiK88/7BTxZe
nPnC/fQS/x98kcyH8KBpmFEqvZScylLECRipoNFXdCHzobSZFj64NdzLJOnnjPA7
jFYKNbbLrQXdr394NUvv1a4SJKDpbM9oFdtOh+9BknyJiCBoUtQz/paq8sh0J8Yr
0ExMCrRvJUEe6ayngv3qxQdojvLqmaE0xrtp00plzu0aRkZjFYLs3o5aOaBBf+wP
mhNguGYqFKakl03H1Rulp4VIhiu/oelBVxY876Rj5piAl/rqtLQIqfJJpajn21Ap
5WXBh4O3YVoY+MRKiCp3uul3u7J9XA==
=ow89
-----END PGP SIGNATURE-----

--HY1ANHi/QK+YgARj--


