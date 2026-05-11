Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C606CCD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRX8-00026t-Ip; Mon, 11 May 2026 10:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wMRWk-0001fa-3h
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:22:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wMRWh-0002lG-CZ
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778509350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TJCNFt8WvDgpje5rDnGo/iJNx3Tqbjmx4AnD7o4ZqSA=;
 b=HRjdF5fzDNbJWoRIfC6hQSviDqfQVMwVHcxt4/0ozv5KbxZGa674Hz7g9KBjXW+r9oau55
 ZaanpLBffMHxmqTh3WL5m6pv6gxfKjTYMsaLPZe6g674yWK9vxBiPWDOdbXT146KHjAEuw
 PoDqZSnKkL+iPDRA8NlOg61iI9tflRI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-mWKUOLKrP7GOA0B-tkYgnA-1; Mon,
 11 May 2026 10:22:28 -0400
X-MC-Unique: mWKUOLKrP7GOA0B-tkYgnA-1
X-Mimecast-MFC-AGG-ID: mWKUOLKrP7GOA0B-tkYgnA_1778509347
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AE2618002DD
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 14:22:27 +0000 (UTC)
Received: from localhost (unknown [10.2.16.157])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 381AC1800352; Mon, 11 May 2026 14:22:27 +0000 (UTC)
Date: Mon, 11 May 2026 10:22:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/5] SCSI changes for 2026-05-08
Message-ID: <20260511142226.GA520672@fedora>
References: <20260509052304.2159829-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="44rKRBtxoKT4wEtu"
Content-Disposition: inline
In-Reply-To: <20260509052304.2159829-1-pbonzini@redhat.com>
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


--44rKRBtxoKT4wEtu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--44rKRBtxoKT4wEtu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoB5iIACgkQnKSrs4Gr
c8jNLAf/aPykm7t3dwZ8AQhMkxANOQUkjg8v2OOkzxVq3nGMBXkJtilFlLf2bUeY
vSR4bR8AISQp3rUL7UphgYOiPjleH61hMBduSX9m1kJk6/VHFq7i8LPyZOLiu5Yj
UXWbVoc5lulW0t2v/l3gzL6IYEdGRRuS8d/U66I+fYLNmeE7lcknVEf153N32Wqd
jiCKZNjGisPi85+M9C+X8LUdYvxkMei8IoY9eTLWtS8pI2hzxgFLMkh5nZQo3OWr
8RBADXaOwhwPQuVRe4wVOOx6JzNmInzeRCW7klWKss7L0Q5A5HuSdVAV3nEMHQX4
JKokPQbqrDib/u1lDxz+XmoUY0R8dg==
=0/23
-----END PGP SIGNATURE-----

--44rKRBtxoKT4wEtu--


