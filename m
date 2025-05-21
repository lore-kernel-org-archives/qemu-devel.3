Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EBDC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 14:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHk6G-0007U0-Fl; Wed, 21 May 2025 10:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uHk62-0007Sr-L3
 for qemu-devel@nongnu.org; Wed, 21 May 2025 10:07:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uHk5z-0008UT-1a
 for qemu-devel@nongnu.org; Wed, 21 May 2025 10:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747836414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hkdVJD+vDR30z22RiMdyXgBRXYsfS4GMehZe3oVrkwM=;
 b=YgjtDd/5af/rQeafpksKKYxfmyhhSUJQfZ/ZWG0ylwdBo/ijTi3FKXcKLYieq1SHkJZnFP
 33aNE+CQJ1+2GykilK9LD6RVNocryCtrwuK9cTGvmQZsEZduzd+mEJ52D1lQCwBMdQvLcm
 HV81GfTOXQgj6HrDKT1iVOkxArg2KZU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-LUf-HOQuOTSQSVC6sL0vnA-1; Wed,
 21 May 2025 10:06:51 -0400
X-MC-Unique: LUf-HOQuOTSQSVC6sL0vnA-1
X-Mimecast-MFC-AGG-ID: LUf-HOQuOTSQSVC6sL0vnA_1747836410
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 715B018004AD
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 14:06:50 +0000 (UTC)
Received: from localhost (unknown [10.2.16.85])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0FC39195608F; Wed, 21 May 2025 14:06:49 +0000 (UTC)
Date: Wed, 21 May 2025 10:06:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/35] RISCV, i386, endianness fixes for 2025-05-20
Message-ID: <20250521140648.GA118436@fedora>
References: <20250520110530.366202-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZozLkpHWo36n+m5h"
Content-Disposition: inline
In-Reply-To: <20250520110530.366202-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--ZozLkpHWo36n+m5h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--ZozLkpHWo36n+m5h
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgt3fgACgkQnKSrs4Gr
c8hXtgf7B3+Uizc4lZVOU9IO1Ub2zgci1YeSjP4J6g6dOzVrFpwUUsf2ihU51xtv
7mwrNskAJ0tVdsy+gyBtbrXHiHk+p2GCH/mZfld8x2fP2+VyJmlA03QcnzhtPDD0
GdyD7X2dNCP38rnmwfJTEIFMeJorfq+esHT+0KHbd4c2HtZO1LKIZgI0/DUiC0Si
F2rDUox0vO/D2HXlDQ8j40boz1hfDC+oM1MFFNEpKZ8uAFyooRodiHsDW5GpsLnC
IVjWSvghr7rwIHmq0TY7XOMFcDUI8lGU9iatasNZZ6s/N1NejaUgPSjwhw3VuroY
O7eCggWGTe0tsFqqm1yJmZSdNnSWwA==
=iXjt
-----END PGP SIGNATURE-----

--ZozLkpHWo36n+m5h--


