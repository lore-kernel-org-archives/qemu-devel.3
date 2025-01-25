Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC7EC02181
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 03:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbWqw-0006Rb-Aq; Fri, 24 Jan 2025 22:28:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tbWqu-0006R7-BI
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 22:28:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tbWqs-0000yb-Ru
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 22:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737775733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qDSh7T+Lrnt+9Tx3bkT+uHEftan7XHP10kgx6hmbupU=;
 b=GjG2VZKWwEOH8y+ik++HE5PM4e3QbX/smOnpb8yw5Dr5VoHycIUVukl7qauY0EW+3jifJ7
 LkvUg+8+STAu/+pkr21bsHXonm5Yl6qt0CL0FUsA77dh/0H+PyKF0TqHGG3oDs64VNBtYG
 r3EtucLi9HAUe2qV16eb1Jvd/h/QYv8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-XgsicirvP_e5AtTMRUneVA-1; Fri,
 24 Jan 2025 22:28:48 -0500
X-MC-Unique: XgsicirvP_e5AtTMRUneVA-1
X-Mimecast-MFC-AGG-ID: XgsicirvP_e5AtTMRUneVA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89A36180035E; Sat, 25 Jan 2025 03:28:46 +0000 (UTC)
Received: from localhost (unknown [10.2.16.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 111341800365; Sat, 25 Jan 2025 03:28:43 +0000 (UTC)
Date: Fri, 24 Jan 2025 22:28:42 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Song Gao <gaosong@loongson.cn>
Subject: Re: [PULL 0/7] loongarch-to-apply queue
Message-ID: <20250125032842.GA287570@fedora>
References: <20250124070021.800907-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5VfpGfWcCAMygJB8"
Content-Disposition: inline
In-Reply-To: <20250124070021.800907-1-maobibo@loongson.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--5VfpGfWcCAMygJB8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--5VfpGfWcCAMygJB8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeUWmoACgkQnKSrs4Gr
c8j82wf/XDn7GobmXmKFanBHldSFNg+rWRYCfANVJnNzwR0c/GZ5QCyr9TWgkXNC
EfBaAI6ABqwJfdyr8HcpsRt6gdPgf/ed+bgkHIS9yVcaDDrgTuoo01WZUCCL0pPQ
k80TjrByQGRjZNDTXuZnhibcPfrudR2dX8hnzl18/3/PDh4hQw7AOu0G0phfL10y
XlIA+/7TkxPwUHvzeCHgU7OUX9pgV4qE+Vu56WK13yRqKj6EvQsjm4evqOEccUf6
z0td7wRG9LtSxQMipKMzVYp6FPpet0R95aae7ygl99sPa17SFm60NIX91l9yZSm2
1jKAQjzIWLWKjIgYtcHn1+BD26+g3Q==
=ut83
-----END PGP SIGNATURE-----

--5VfpGfWcCAMygJB8--


