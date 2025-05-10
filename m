Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A4EC3ABC3
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 18:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDp52-00036V-BP; Sat, 10 May 2025 14:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uDp4s-0002xt-Ll
 for qemu-devel@nongnu.org; Sat, 10 May 2025 14:37:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uDp4r-0007f7-8f
 for qemu-devel@nongnu.org; Sat, 10 May 2025 14:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746902256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VSzADJGJ++0PPF8d7mcr5ue9YGsfKrNWWWwWm5hGEfQ=;
 b=YEV+HjuJ2NKYmmBcNAoe4BP1HY1eCE57F9fE85B1WyerpcqXYzetwvsafjD3oCv8/vm+Td
 bEbz2f0fZc6VbW7SPY4m4JVxsZFLCMl3L362IfzPCJ1DFS59AXjUQ/DCgLMFfGgK5biEDW
 MRPs5tVnq5We3l4o6ABbLEmB628+oCE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-HSy0fXl_PPiWtpPesPP8cQ-1; Sat,
 10 May 2025 14:37:34 -0400
X-MC-Unique: HSy0fXl_PPiWtpPesPP8cQ-1
X-Mimecast-MFC-AGG-ID: HSy0fXl_PPiWtpPesPP8cQ_1746902253
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 986F41956086; Sat, 10 May 2025 18:37:32 +0000 (UTC)
Received: from localhost (unknown [10.2.16.39])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C0C7319560AB; Sat, 10 May 2025 18:37:30 +0000 (UTC)
Date: Sat, 10 May 2025 14:36:21 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 devel@lists.libvirt.org, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PULL 0/6] Versioned machine type deprecation policy patches
Message-ID: <20250510183621.GA116990@fedora>
References: <20250508161536.865866-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XWGF42aSkD5QmRmM"
Content-Disposition: inline
In-Reply-To: <20250508161536.865866-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
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


--XWGF42aSkD5QmRmM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--XWGF42aSkD5QmRmM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgfnKUACgkQnKSrs4Gr
c8hW0Af/a7nzziQ9M73sC5x3ZWC3OOXh7AAEOn2nM9kcV6y/WNR1/VgchC2kZZZZ
Ho1dcRjlUAHxpXhx+IpxW3I0YI35rc/X6BFLgCAwtddd24OoHSbPruhgPdcNaNkD
CHET4Zt9K1izIid7DRv27utJ9z53u1jIX335RawkKIFLYzm/ORnZjWWZBJSOjNaB
bukW6W+ADDJGslC6O+eqFcr/fXVQP8zdcefMmY8zwkyAxVWvndjRNXhM3xMWgLYf
iZ+t26WAwv1qeg4FMfmdLERMaNsD7LO1Rd1fWdP38JDGFooQ2sztfBsHz0u8+qy/
mgBzujjovMaPc/qGBqIhmT7OBMDh+Q==
=NEvq
-----END PGP SIGNATURE-----

--XWGF42aSkD5QmRmM--


