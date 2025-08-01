Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5812DC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 20:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhwd3-00080x-N5; Fri, 01 Aug 2025 16:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uhvWr-0004nA-TT
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 15:34:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uhvWo-0001vC-Eh
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 15:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754076891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZvKL3YxI/qC5QecFzc9csfq485Kfr9u44QZC3aq22tM=;
 b=cRXOWMxxEWp2JyYrg2Aa5OXm21BxRQ23XPvc1tCkCvr6+4IatZcBKSEKROl+NKrtKpg6BM
 nwcVocIBOWNh5lBIvEkIMe3Zj2nOx9ynoBAwH0k0PF959lMOO4SHXt8qTHxraVybYrzjdn
 FX7opdHBNK3KV3vRaQzkLa5froRrA/Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-X--_OCfENnyXSPlSsO0FJQ-1; Fri,
 01 Aug 2025 15:34:50 -0400
X-MC-Unique: X--_OCfENnyXSPlSsO0FJQ-1
X-Mimecast-MFC-AGG-ID: X--_OCfENnyXSPlSsO0FJQ_1754076889
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08CF6180048E; Fri,  1 Aug 2025 19:34:49 +0000 (UTC)
Received: from localhost (unknown [10.2.16.88])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A0E9F1800D8C; Fri,  1 Aug 2025 19:34:48 +0000 (UTC)
Date: Fri, 1 Aug 2025 15:34:15 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/17] virtio,pci,pc: bugfixes
Message-ID: <20250801193415.GA185429@fedora>
References: <cover.1754058276.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p9hgxMyufyO1J6vt"
Content-Disposition: inline
In-Reply-To: <cover.1754058276.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--p9hgxMyufyO1J6vt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--p9hgxMyufyO1J6vt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiNFrcACgkQnKSrs4Gr
c8jlBAgAhAAUl3SiU2ZLlgLXnfyUKKfDJIQwKGbmnFTwS6kChbfL4FI2+gtyqkPn
Gin1Dq5VQV39oX10OdsZjmdpWs2PTuyk6wA1Y3W4q4wDv/Of15uIUPQwpcbCzwko
lforQ1MEFxQikI36WF1scx0XwGsXhBLDF3j9K3sqpTjTmxDA+F/zZ58k0z1XRPU2
qVcv3rR5GYzu2TJPbh3ohgs5fh/3YELmvOb0FZSidMzhlyVa3UbNPLCG28PkLgL3
uz+ksdU6BVjLZDCRpw8rX8pjxdmkKf93S/2igMAKfhLajy8dklezmJUx0yUQwRDj
ATKKQCp4hLV9aM47ICDhXx6iqnzl1Q==
=1nIC
-----END PGP SIGNATURE-----

--p9hgxMyufyO1J6vt--


