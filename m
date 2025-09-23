Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D0DCAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 19:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v18kI-0007XN-HA; Tue, 23 Sep 2025 15:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v18kF-0007Wz-W8
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:32:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v18kC-00084f-Ts
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758655927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e+WKigIwGr2XQXYu/tIEfiwRG9qp1q8lpIdN6HjmiSM=;
 b=UGzhELJnW3IDe2lGiovTrEAYUsKcCAKGE7TDr9Uow/JtPk4eNtoHSZio8/e+VZq1Sj4HPT
 joXtk1IUHbqZy78bIE/OQVVNe4o3CRD8C8YROqPYhl8NAo+ZF5VoJ+dya8hSmdImq95Rkb
 JL6oqbZCA7ewa1Fs7hNdgktmOESBuy8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-290-bKCGFP_HNyyc1aF_Ifnlrw-1; Tue,
 23 Sep 2025 15:32:03 -0400
X-MC-Unique: bKCGFP_HNyyc1aF_Ifnlrw-1
X-Mimecast-MFC-AGG-ID: bKCGFP_HNyyc1aF_Ifnlrw_1758655921
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A9AB180064C; Tue, 23 Sep 2025 19:31:50 +0000 (UTC)
Received: from localhost (unknown [10.2.17.69])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F28CC1800579; Tue, 23 Sep 2025 19:31:49 +0000 (UTC)
Date: Tue, 23 Sep 2025 15:31:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Tanish Desai <tanishdesai37@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 10/16] rust: qdev: add minimal clock bindings
Message-ID: <20250923193148.GN509965@fedora>
References: <20250919112536.141782-1-pbonzini@redhat.com>
 <20250919112536.141782-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kXpwvFdzgfWpFnnZ"
Content-Disposition: inline
In-Reply-To: <20250919112536.141782-11-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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


--kXpwvFdzgfWpFnnZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 01:25:30PM +0200, Paolo Bonzini wrote:
> Add the minimal support that is needed by pl011's event and tracepoint.
>=20
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/core/src/qdev.rs | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--kXpwvFdzgfWpFnnZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjS9aQACgkQnKSrs4Gr
c8h00AgAioekZ8SSWhzjXhyr26kLnfgoWiJAAPfXpwWj/OuqRI4V7wWNsUptiEb5
fPUdWc57gs3Ua8VnnURX7mDQcpbKEdXzY94rnRF2HzJAs5jv5aXtcHYEFX0UK4gU
fGkxvNjxmI6lu8aRgWqbmRVMXx6A3n5hlvHoC8SxcjxTMZ6QZf8zGbKN5b9wJNY7
r+Js4DWZOcnKeLvkNAxpMvCLiawEq9X3P8FjkcpUAGZ6VwoXn/xe6nRmYeYDOnQu
6aiNrU87Mv4j7L3zdHcEq75Xpr0v4DobFL9ubVNAHgvjFRsEwMhikE8mHG5jtUcB
OgWFSQPp9NBg/SSCjryE/SMTwF8bmw==
=QZbe
-----END PGP SIGNATURE-----

--kXpwvFdzgfWpFnnZ--


