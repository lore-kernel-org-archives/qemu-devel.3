Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2D6C83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 16:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh9v0-0006eE-Uw; Wed, 30 Jul 2025 12:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uh8XL-00020Y-5E
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 11:16:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uh8XH-0000Pt-Nn
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 11:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753888565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RQ1PCQHky+cgRPyEbWCtK1rNhsKsR139jw9J7V36mUE=;
 b=fJt/BqPqs9uu7JhQE3WY9pdAOZxqwPFeRgoimBcaAgml4zOZjNgg9r/wyUYSAJ+2uM9Can
 ULvqUl040YvusM+9PQh9Cv4ONobACdtU/r1XQz/C5rDI9cfn+lvc1r1f+3w5nHKYBPtrH5
 0LUINsQ/pzQ76OssnwMg7Hp5pgmLSxo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-k5O-FQ40MOaZlk7qfjSh2w-1; Wed,
 30 Jul 2025 11:16:02 -0400
X-MC-Unique: k5O-FQ40MOaZlk7qfjSh2w-1
X-Mimecast-MFC-AGG-ID: k5O-FQ40MOaZlk7qfjSh2w_1753888562
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC0B61800370; Wed, 30 Jul 2025 15:16:01 +0000 (UTC)
Received: from localhost (unknown [10.2.16.136])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0FECD1800285; Wed, 30 Jul 2025 15:16:00 +0000 (UTC)
Date: Wed, 30 Jul 2025 11:15:59 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: alistair23@gmail.com
Cc: qemu-devel@nongnu.org, alistair23@gmail.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PULL 00/11] riscv-to-apply queue
Message-ID: <20250730151559.GA67721@fedora>
References: <20250730010122.4193496-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pWAdSRMNMNiMm6X1"
Content-Disposition: inline
In-Reply-To: <20250730010122.4193496-1-alistair.francis@wdc.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--pWAdSRMNMNiMm6X1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--pWAdSRMNMNiMm6X1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiKNy8ACgkQnKSrs4Gr
c8gk8wgAlng3wkbzZWHZW1FFkXwwyNFR8A9fBPt0Pp3yJL3SjrFomGnVvcTKkqRz
G5NdpmR8F8UFlEY+yR4kWvCMkc0hVh10PlVNcUquw73ETrndPrYWi6/3Wg9eBQAD
B2H7NNdhnXhQG3gOznTsVVhSW/nBL5qOPPL0RXwafu8t2LyScx3edtL9eTQ1ocEz
a0VAi6UVbpON8rkHH92Hsdb8y0OalPDomJuy2O323HKl32r/ce5e3BZ0iVL2GZ6r
6J7Fs59GqoSzLAlUAADK6Rxl6+rXX9ooi0Ih2lfv6y9ybj8TE8ppEudZ5Bt0AIsq
xQYSPXXIKpr4whsBFeE1vYApGhG9Jg==
=+q2I
-----END PGP SIGNATURE-----

--pWAdSRMNMNiMm6X1--


