Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34708CAC586
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 13:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvc8x-00022A-Rr; Mon, 08 Sep 2025 09:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uvc8p-000205-Ge
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 09:42:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uvc8j-0003qA-KL
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 09:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757338951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fHNoXs3poF2+/IeRcU1LAI4X7ytP+zC6vLMg8C8igco=;
 b=gQBJGFz9zmZN2qSqNBLYhSP7O4m7XLJqYonzF8vQl9PfnBoKhASvUdevACBfIrmQe7jVnH
 f3JBHBvbFGaATseXfGdKI1NoXLWxS66qoU2NjlPas51HTiPPw5Znb8NRZwd+bfoLiUbywE
 SehZPtrSRddSgeuz+Jb02OSfWUohs38=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-jmy3ZtxDM8O3MPocfXEobQ-1; Mon,
 08 Sep 2025 09:42:27 -0400
X-MC-Unique: jmy3ZtxDM8O3MPocfXEobQ-1
X-Mimecast-MFC-AGG-ID: jmy3ZtxDM8O3MPocfXEobQ_1757338945
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1135180058C; Mon,  8 Sep 2025 13:42:24 +0000 (UTC)
Received: from localhost (unknown [10.2.16.148])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0F24D1800451; Mon,  8 Sep 2025 13:42:22 +0000 (UTC)
Date: Mon, 8 Sep 2025 09:42:21 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>
Subject: Re: [RFC PATCH] docs/system/security: Restrict "virtualization use
 case" to specific machines
Message-ID: <20250908134221.GB167158@fedora>
References: <20250908125058.220973-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hASLb8l8vjxdi03l"
Content-Disposition: inline
In-Reply-To: <20250908125058.220973-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


--hASLb8l8vjxdi03l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 08, 2025 at 01:50:57PM +0100, Peter Maydell wrote:
> We don't currently restrict the "virtualization use case" to any
> particular set of machine types.  This means that we have effectively
> barred ourselves from adding KVM support to any machine type that we
> don't want to put into the "bugs are security issues" category, even
> if it would be useful for users to be able to get better performance
> with a trusted guest by enabling KVM. This seems an unnecessary
> restriction, and in practice the set of machine types it makes
> sense to use for untrusted-guest virtualization is quite small.

Makes sense to me.

Stefan

--hASLb8l8vjxdi03l
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmi+3T0ACgkQnKSrs4Gr
c8gaPQf9EX/0ObdVzixq89VC+7yp2VzdYtJ/u5UlEogJ1igEQUExBz30G4SGU4am
dJv8DDYtNmPDolfOcxcoxojed41anfx142yTXT9lCARJHaH+4GdVN0mOa/FIimWC
LkaGdmUioq9dr+zfdYH5XJRRdnJMriQo8CZTKQhEFQx9YwnEos6KSqXJRT242DNo
21+v8hgqtPF3vp5igefhl2lOuedQdCyT3im97N4aOlb8rk7LFF4q1HbBKE8pVV6s
20dJRrQdGTbjTTRIntS6HbP6/RmmZkC5tpejSj7U6SkckCtGJUQ2gYXLEGnKu4ig
zMUDovZ7FcvW3w5UA1+FoWT2ExM0Vg==
=DR/N
-----END PGP SIGNATURE-----

--hASLb8l8vjxdi03l--


