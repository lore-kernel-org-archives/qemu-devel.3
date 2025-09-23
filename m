Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209CBCAC5B6
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 19:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v18Jp-0003dj-Ur; Tue, 23 Sep 2025 15:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v18Jf-0003dU-Kw
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:04:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v18Je-0004eU-4d
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 15:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758654278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fVlCyxBU27XVkilsC3q8T8aDKCq8HV6Nn3sG4Und9Uc=;
 b=RJV9TA7wWbqOgZ6dVHrmZVWMw1W816w5O2Hm1q3zR2cVHCngIzHb2rhi9mx7l7N7j3MZaW
 03+BiIF+y1voDbHZ0dXDgfVAdyxvnPeVjvgWT4v1yDPHdBxSIlncgamBZost7p3EefjAbZ
 SmTOojKBN9mEiPySHFn4ogU81eYIlqQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-PZjubmpzNuOlaCZXzc3DXQ-1; Tue,
 23 Sep 2025 15:04:36 -0400
X-MC-Unique: PZjubmpzNuOlaCZXzc3DXQ-1
X-Mimecast-MFC-AGG-ID: PZjubmpzNuOlaCZXzc3DXQ_1758654275
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02F0B180034F; Tue, 23 Sep 2025 19:04:35 +0000 (UTC)
Received: from localhost (unknown [10.2.17.69])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5475E1800451; Tue, 23 Sep 2025 19:04:34 +0000 (UTC)
Date: Tue, 23 Sep 2025 15:04:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Tanish Desai <tanishdesai37@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 11/16] rust: pl011: add tracepoints
Message-ID: <20250923190433.GF509965@fedora>
References: <20250919112536.141782-1-pbonzini@redhat.com>
 <20250919112536.141782-12-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Fg34jTSvlhKQsktn"
Content-Disposition: inline
In-Reply-To: <20250919112536.141782-12-pbonzini@redhat.com>
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


--Fg34jTSvlhKQsktn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 01:25:31PM +0200, Paolo Bonzini wrote:
> Finally bring parity between C and Rust versions of the PL011 device mode=
l.
> Changing some types of the arguments makes for nicer Rust code; C does not
> care. :)
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/char/trace-events             | 14 ++++----
>  rust/Cargo.lock                  |  1 +
>  rust/hw/char/pl011/Cargo.toml    |  1 +
>  rust/hw/char/pl011/meson.build   |  1 +
>  rust/hw/char/pl011/src/device.rs | 57 ++++++++++++++++++++++----------
>  5 files changed, 50 insertions(+), 24 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Fg34jTSvlhKQsktn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjS70EACgkQnKSrs4Gr
c8hnDwgApVjxDwbQ6XsW6XfUVr6lDoE7q7/vA30J2V7N9ahqLVEQPOzyFWENmDNx
aHHURPNS+WU3One7x5t9x1u5X+tkO+x2qv8+s8fWiSDOUkFcLg3F6KZEWK98W0M4
S0oju/MSknzVokOsFSp/sm1jA5CrOeQevBIqtwAgXHzjrZvY0vP9eEPr9gMCozAr
PxttHN7qjATiPKFa/10bcCTlCcHxpgnx/rUsE+4KVN5MTqc0m+aLVbwHNS7DRJV+
6/rYBrIr64G2Z1pKkQ7NG3ppOvNHVXvDj3B/KEWr9Qdoe4xz33EFTe3T20ieWMoZ
dFmVWADVgCdFaMH9JmanUR6E5xmytA==
=AzfN
-----END PGP SIGNATURE-----

--Fg34jTSvlhKQsktn--


