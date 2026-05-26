Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C370FCD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 18:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRwtJ-00055a-0M; Tue, 26 May 2026 14:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wRwt0-00051E-13
 for qemu-devel@nongnu.org; Tue, 26 May 2026 14:52:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wRwsx-00061J-45
 for qemu-devel@nongnu.org; Tue, 26 May 2026 14:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779821533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L5YcobjqA1HsUQIdI3uqAkTTSUV7ojnpsQMGHEuBweg=;
 b=MWrdWwTpZNAqSwI0fePdKqHwkp0YM+FW9j78apqp9C7sRbYk9niIXSf/eNeG/HEcrBmSHO
 DJeDgGRcPfIJ35+5aGxjdsPb/1kt/K6/+l/p6R47IDjWq5Vo9Yl+mZC7hllUL1DAuQ4mjf
 seeBnR4+f9O7fYvHa2yN8BuGRrgwTn8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-Vf3GGBlbOemJy9SDBQPqYg-1; Tue,
 26 May 2026 14:52:10 -0400
X-MC-Unique: Vf3GGBlbOemJy9SDBQPqYg-1
X-Mimecast-MFC-AGG-ID: Vf3GGBlbOemJy9SDBQPqYg_1779821530
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE98A1956088
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 18:52:09 +0000 (UTC)
Received: from localhost (unknown [10.2.16.201])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 841D11800576; Tue, 26 May 2026 18:52:09 +0000 (UTC)
Date: Tue, 26 May 2026 14:52:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/6] Misc patches for 2026-05-25
Message-ID: <20260526185208.GA1763438@fedora>
References: <20260525151621.395954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Z+nxkQP1XOPt2t3i"
Content-Disposition: inline
In-Reply-To: <20260525151621.395954-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--Z+nxkQP1XOPt2t3i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--Z+nxkQP1XOPt2t3i
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoV69gACgkQnKSrs4Gr
c8haoQf9HFhfx9BTaheZgZmTujMdCjRMOdjZVw8OGig6SEakd6OEgG6+NwNEiQkn
pOWxsokgY5pABqjnPVlsEacBTqi8BnVJnPvTj4DARtNX2I/9fhxZOPQEPxqsuBUE
PBXWv7l3dyfBQENCYNXk9oZN9Rge6uo4K4mlLSmFk+zKHYEHERzqayOpJ6JazQQ8
GdLlrDCDe/JCGCDrD4kaBNadJ5ZqiNjlsGl66plU0/o/YwFbK/vSQmNxourACQUt
k81kOPqxiTCSuwIgmAbiIsjXZdzHmXTOCHqpfF6aYCRxY7EqIXUmlaYhip5oqOZ9
MrWpz32hRjytB4phUe+Cpmbv9q2n7A==
=9UDV
-----END PGP SIGNATURE-----

--Z+nxkQP1XOPt2t3i--


