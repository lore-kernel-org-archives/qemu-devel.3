Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB85C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 13:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6W9x-0000LK-OY; Mon, 13 May 2024 09:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1s6W9v-0000Ke-I0
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:56:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1s6W9t-0003MZ-Pw
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715608562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i+nhtBC5YZ3baXbA9zDxbgVzhViy97TsucEvvvZhL/I=;
 b=KGcVteFbdYxA0DetOYZEw5Cr4By4LoUnkLoW9QAIfvucdpR5BZGEyiC7zSYTnoPKFgU2W6
 eUcqmFx3ujN0kQPqF6v5oHw2c+o2AwuglmAQCNLtZwQEr+FrJkgh612UM6f/SsZs8WAQMF
 pX+7wBOXdte5lCnOAVap+bUyezlDLuM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-nmsk0Y1VPbGX-o0PRyH8mA-1; Mon, 13 May 2024 09:54:05 -0400
X-MC-Unique: nmsk0Y1VPbGX-o0PRyH8mA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F33881227E;
 Mon, 13 May 2024 13:54:04 +0000 (UTC)
Received: from fedora (unknown [10.45.224.110])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EECB32026D68;
 Mon, 13 May 2024 13:54:01 +0000 (UTC)
Date: Mon, 13 May 2024 15:53:59 +0200
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 devel@lists.libvirt.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Krempa <pkrempa@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH 0/2] hw/core: revert deprecation of 'parameter=1' for SMP
 topology
Message-ID: <ZkIbd1B9PQOi60gP@fedora>
References: <20240513123358.612355-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KMBx+CMLht41t/qf"
Content-Disposition: inline
In-Reply-To: <20240513123358.612355-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jtomko@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--KMBx+CMLht41t/qf
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On a Monday in 2024, Daniel P. Berrang=E9 wrote:
>Since QEMU 9.0, users are complaining that depecation messages are shown
>for every VM libvirt starts. This is due to the newly introduced
>deprecation of 'parameter=3D1' for -smp. This proposes reverting that, see
>the 1st patch for further commentary.
>
>Daniel P. Berrang=E9 (2):
>  hw/core: allow parameter=3D1 for CPU topology on any machine
>  tests: add testing of parameter=3D1 for SMP topology
>
> docs/about/deprecated.rst   | 14 -------
> hw/core/machine-smp.c       | 82 ++++++++++++-------------------------
> tests/unit/test-smp-parse.c | 16 ++++++--
> 3 files changed, 38 insertions(+), 74 deletions(-)
>

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--KMBx+CMLht41t/qf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQT+Rn5j0qdK2hQgnuAU0rOr/y4PvAUCZkIbcgAKCRAU0rOr/y4P
vNNTAQDEXAR5xP+hgnHjTy1A+KL/YZ7coXyQ8QyRtcdMjtXByAEAz6VhIeKcdYo1
1rIGbVwCIxqwMpHXzjG8+HIOr9avnAk=
=57D5
-----END PGP SIGNATURE-----

--KMBx+CMLht41t/qf--


