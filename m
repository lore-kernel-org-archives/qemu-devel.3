Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BB7C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 18:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weGkB-0003kf-Bm; Mon, 29 Jun 2026 14:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1weGk3-0003Yc-Gj
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 14:29:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1weGk2-00047X-0M
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 14:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782757797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=66dD5Cpy2sRKYkVXHIfb8FGcBXLKlR5GT2FZyhkPh6U=;
 b=elwdHn6ZjBb4FdleDYuDqjJyimPk0FNSYlH7S5tpiPqr8oTGWqBaxXcUiB09v/h6ZmInzo
 Qlh/YuCj/yQyQe2Toc11hGqiPGRscLcKgBqqClqZxZuFU5Jys/FgMIONM6aEyELANkuEF9
 lpGBfWQHANphuACENKEJP0xx4aezlOA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-FIiuKTxuNdySJWPwvv_TlA-1; Mon,
 29 Jun 2026 14:29:53 -0400
X-MC-Unique: FIiuKTxuNdySJWPwvv_TlA-1
X-Mimecast-MFC-AGG-ID: FIiuKTxuNdySJWPwvv_TlA_1782757792
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 113A41800601; Mon, 29 Jun 2026 18:29:52 +0000 (UTC)
Received: from localhost (unknown [10.2.16.195])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E1A2919560A6; Mon, 29 Jun 2026 18:29:48 +0000 (UTC)
Date: Mon, 29 Jun 2026 20:29:42 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, jasowangio@gmail.com,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PULL 0/1] Net patches
Message-ID: <20260629182942.GA383388@fedora>
References: <20260629134033.31893-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CePzfiXEBZrLVWJ2"
Content-Disposition: inline
In-Reply-To: <20260629134033.31893-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--CePzfiXEBZrLVWJ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--CePzfiXEBZrLVWJ2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpCuZUACgkQnKSrs4Gr
c8j7YggAwrB9h8hsJZS3xMIT+8jLEUbN5eQ1212x9N3QzNRsFo4pnIJ46kVjgNxb
loMdxafc4kCQPplR7gGsNSjK2Ohh7930+0ZW7FcVeO+A9rrdngy3wt+k7tawsoGr
lWSTOhnwxF1LgLOrXVNGEVrKTdG4oH7BoQLjI9yaNRGYiCtbG1r+SE2U7VxD1AE0
qvI/jUtiRRyWCrDSnJr5XfvJqVpCxCiJmhgJbbuIe285EZG2M4a6PJxifgJWABFW
FYI26IOCIm81tuMLlvlnf3MG/JS/qMfTTAw38FEnWgPbi123TWhI5nnva6Dd7oFV
aXZ5Zg4hNMgpj+6rpjfnepQCcbBLdw==
=DZfx
-----END PGP SIGNATURE-----

--CePzfiXEBZrLVWJ2--


