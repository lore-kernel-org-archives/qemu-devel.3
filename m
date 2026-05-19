Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99EFECD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 19:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPPwS-0005oe-TL; Tue, 19 May 2026 15:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wPPwO-0005gv-5W
 for qemu-devel@nongnu.org; Tue, 19 May 2026 15:17:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wPPwM-0006hR-DD
 for qemu-devel@nongnu.org; Tue, 19 May 2026 15:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779218237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+DTIdgO0+3y5qTvP8Bi2ZjWX17GTGZ3HOX36U6eNqOk=;
 b=QAAuMWKodMXV8rvXyyTEPnob62+5C9ffTc2aRi0glf6/gTbSjCEyxamHrr6fSODqx3Tik8
 ZVlaWqScyR5GoKC4/vK46QtuBwT24QqBSGRyy7zT39J0f3sjWT0VcO1hNQN5N43lKupGUS
 c1MPCrTD3xZMnvJ7WS4JBp252umBiLc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-plDeigltM3eqcbNViaDQIA-1; Tue,
 19 May 2026 15:17:13 -0400
X-MC-Unique: plDeigltM3eqcbNViaDQIA-1
X-Mimecast-MFC-AGG-ID: plDeigltM3eqcbNViaDQIA_1779218232
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA936180034A; Tue, 19 May 2026 19:17:12 +0000 (UTC)
Received: from localhost (unknown [10.2.16.118])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5F2141800465; Tue, 19 May 2026 19:17:12 +0000 (UTC)
Date: Tue, 19 May 2026 15:17:11 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/1] Qtest patches for 2026-05-18
Message-ID: <20260519191711.GA335334@fedora>
References: <20260518155344.5945-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YYnrWGzcF1kMFnGb"
Content-Disposition: inline
In-Reply-To: <20260518155344.5945-1-farosas@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--YYnrWGzcF1kMFnGb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--YYnrWGzcF1kMFnGb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoMtzcACgkQnKSrs4Gr
c8hQRQgAtdIuwDA7AZeo6bgi9gTqCS7r5XV3jY+WIfG9TRGOJFDeic5t2keBXN+L
bhsXkMK9bZ4fyZpHYHvUgF2hKEknA/WhOmR4lVXVVjaTsll2svVDsoXscrEhzc/y
5JshjC+PImGjCjQgW3Hsue+J6+jAFgkC4Rr9N+hRYmPoP9pr7Noi0IWYG4zLIFhI
q2qVZlF5eOfY9+DKZb3ITWn9T8s2sPGA7k8ii4q/PCKgHMWp6UatVVPEMhM5XEBU
GNcKRF6bB46QdgWK60T+guZJ6xki8CbuNbkjGRwH/l1CivxwT+t0BvHrrQGf2xJu
XMVJStAYmo8WxGbFA1plkmvJkzWbIQ==
=4vd5
-----END PGP SIGNATURE-----

--YYnrWGzcF1kMFnGb--


