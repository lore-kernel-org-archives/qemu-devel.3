Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4AAC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 17:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0kWT-0007bF-8y; Fri, 04 Apr 2025 13:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u0kWQ-0007aM-TE
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:08:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u0kWO-0005BZ-OM
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743786476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9dqN5Ijqi53OLMTs2bsfK8WVwmDXT+xFpkCQ3uzGyNE=;
 b=eIQtwWWqaMT89n3WfQM1mpWTYMxZYRDkqiQ1/p+Yn0mmgrajsfexPe7S7iJNDrBIsyRO6C
 KlmbPcxNZ/Hr2OtOjw+vqTySHh/ASrQfVqImgfRSfJDNbg/KIJLx8LfOkzrDMSqULaE9ul
 SHO13JNuV5fBcs33IU3dagjOnjlgFPE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-0Ef5RPehPC--Iw0xG9baqA-1; Fri,
 04 Apr 2025 13:07:53 -0400
X-MC-Unique: 0Ef5RPehPC--Iw0xG9baqA-1
X-Mimecast-MFC-AGG-ID: 0Ef5RPehPC--Iw0xG9baqA_1743786472
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9C5D19560BD; Fri,  4 Apr 2025 17:07:51 +0000 (UTC)
Received: from localhost (unknown [10.2.16.156])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E8E9C180A803; Fri,  4 Apr 2025 17:07:50 +0000 (UTC)
Date: Fri, 4 Apr 2025 13:07:49 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PULL 0/1] Migration patches for 2025-04-01
Message-ID: <20250404170749.GA378893@fedora>
References: <20250401195353.803-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VaS9cEywjvPSdZr0"
Content-Disposition: inline
In-Reply-To: <20250401195353.803-1-farosas@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
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


--VaS9cEywjvPSdZr0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--VaS9cEywjvPSdZr0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfwEeUACgkQnKSrs4Gr
c8i79gf9F6xEOOXyrp1up8Gk2ZrHhTf4lWOu1LC4qqq145G2vlVhEp7FnzWVpTFb
FbwqIjhX5DBfzVQF25tXigTWdg84lXGHmwbn1zrt/4HcMS5Y+jWfLUCDMkGXYyTL
ZLTs7XWIgmDCiFU0LvxthhWPXa0bCCpHF4gzvIOPcedDDvXAekGrT1BDH3uoM3ek
e6UxR30lEE/KL9FbCewxeI4kPKdVi9Ipj5GTFGmztkmtbSEnrSq2VRRttTIQY7/t
TkrVB6Mah337QVVif0di4kJjpLIA/0hoIQJ5rdi4FXLKVHjKCS9JkUkYh0qm1pin
hLVb2ZBq7KTK+9p0oJYkafTvn4y4OA==
=FdpF
-----END PGP SIGNATURE-----

--VaS9cEywjvPSdZr0--


