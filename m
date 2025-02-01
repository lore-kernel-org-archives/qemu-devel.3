Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77136C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 14:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1texDM-0000VA-Oc; Mon, 03 Feb 2025 09:14:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1texDK-0000UT-Ee
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:14:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1texDH-0007vP-Bx
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:14:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738592048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZfSfrbWlMqM90gwwN6cy4cwGvi+KiThiSgl64hHB5hU=;
 b=hUhHX11kv+eVwsRhHarTPhszOnRzUcsGxfi8pM5ZlXpIeaykoFfM3MShc9ZFqD1SAiPLzi
 lHcLwXjoU6DsHzMGfM+8jT7Ptqquacm+p4UTKkWIufW31rqU9T+PeU8MOrPZT/z8WkBuYF
 7aEv0YpLpT8fAUupfr2sgUDXzetzZ1M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-da8N0j3zN8Ws8lFkoUL_0w-1; Mon,
 03 Feb 2025 09:14:07 -0500
X-MC-Unique: da8N0j3zN8Ws8lFkoUL_0w-1
X-Mimecast-MFC-AGG-ID: da8N0j3zN8Ws8lFkoUL_0w
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7F821801F28; Mon,  3 Feb 2025 14:14:06 +0000 (UTC)
Received: from localhost (unknown [10.2.16.93])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C19BC18009A6; Mon,  3 Feb 2025 14:14:05 +0000 (UTC)
Date: Fri, 31 Jan 2025 22:03:14 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PULL 00/42] Migration patches for 2025-01-29
Message-ID: <20250201030314.GA24429@fedora>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pzL9W6bMjKOash4J"
Content-Disposition: inline
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--pzL9W6bMjKOash4J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--pzL9W6bMjKOash4J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmedjvIACgkQnKSrs4Gr
c8inzwgAp4V6y+VLN4VrwVBAKRL8NNj33nQit9PzeYoTHY5Tcb3vWixiJ3FmvseI
wEX4tnxAP35lo7uC8OEkTaviJqriMwLIU7Y9Qbh5CkKFo2rJpF+vhjI9f9gJP6Os
wi5jL/yweV1NsGr5IE15267J1KN3/ZO2Pb5QWCBM6+06HJ8LUYaCo9v2QnPKbCRp
3ck/xLem5p/DFGWY3JbJVHxPwJ/u/8CHn7EHDsX8NEO9S/NxRatbF20G4+U1mSsi
0Z17eAVjw9DvxoV9C+AUi6FwI0Owfbx147Q2LhKbDMtMfykOia8gH1jWtbfvucXC
Ok2Vp9ymDYTuHsGjzkx3qMFqH1kIag==
=LQwr
-----END PGP SIGNATURE-----

--pzL9W6bMjKOash4J--


