Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3002DC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubln7-0007ja-JP; Tue, 15 Jul 2025 15:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ublkX-0002Zt-KH
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:55:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ublkU-0005QH-1E
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752609331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ou7UfE0AWlUCja2FMIJvIKEJrQcLc48z/qtwGNY6oII=;
 b=MKKgKGoQshi5/OyshrsWaj/NyJmQsAyWkX3x0Fw9BBhz4yqR7IAc+YSuX+/+8ZJWn2KeHS
 Rx81k6E2SzzMNBuSMo0aj+pBO3aeV+GfTposdk7hJIZUfUhTnJoh98FGNvtdZBgYZE4ES/
 SHmA1jmUM23gAK1BAxLdlpFWgrkS3o4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-X7B-VlsdP8e9o5OhFRxXTA-1; Tue,
 15 Jul 2025 15:55:29 -0400
X-MC-Unique: X7B-VlsdP8e9o5OhFRxXTA-1
X-Mimecast-MFC-AGG-ID: X7B-VlsdP8e9o5OhFRxXTA_1752609329
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F5E019560B0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 19:55:29 +0000 (UTC)
Received: from localhost (unknown [10.2.16.12])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A28A21956096; Tue, 15 Jul 2025 19:55:28 +0000 (UTC)
Date: Tue, 15 Jul 2025 15:50:28 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Subject: Re: [PULL 00/13] Net patches
Message-ID: <20250715195028.GA242340@fedora>
References: <20250714053423.10415-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NOlOUZkaIigfVv16"
Content-Disposition: inline
In-Reply-To: <20250714053423.10415-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--NOlOUZkaIigfVv16
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--NOlOUZkaIigfVv16
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmh2sQQACgkQnKSrs4Gr
c8gFrAgAgh6sZw0yxCS2JSbLVSsShzzRW6AHi7Sp13bRIziDTGGzDnqMLqS7pIWb
nOqUq7igZx2A8oU4qfxLB9kmnRMUsMVu7575goRpWMg8NxhmXery3gvJdPJY9xyz
JWmi97PtH3pz3VXb/qIrV/i6Oow9GU8stz7er/odVYnjFXmHke1wGViq5tuE3bmJ
Rnedzj/BIjJZWGZ/DOoHWNWZnYK8XfT2H79TtnkoHIgffxwmU3OmidvQU4UrmZXd
b6WbaXiIwwcqZAHTOn1TBQBYxBqdG97fPY40mY2qnP9iSPvKWPB8BhEOB4JlG+Te
mY9iVVlGHtLRlUhlc4q3TbBjv7uyeg==
=Us6m
-----END PGP SIGNATURE-----

--NOlOUZkaIigfVv16--


