Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC3FC10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 18:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s58ob-0006Si-Qg; Thu, 09 May 2024 14:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s58oZ-0006SD-SF
 for qemu-devel@nongnu.org; Thu, 09 May 2024 14:48:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s58oY-0004na-Cj
 for qemu-devel@nongnu.org; Thu, 09 May 2024 14:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715280501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=COp729OV2O9u+A9IoNMPas9DZM9WzT7ErmtFKE5P6RM=;
 b=DUIBm+YNs2tnYNXZAR05U7vv8+Z1e0MKjnYY/MFq+DjJLUhjUjh80UPME4Qx7sL9fM+xcr
 sgquPhE3DrBit6kzQRVMn9iL1lD/5M0xBJoTb+RdWfHQr86jFnd04cxKl50CWYGK/O398E
 iaAsUFe6kUupr4Y7kko4HLbk69Y1zyQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-N_qMKYDKN6W9M5F0xAsDhg-1; Thu, 09 May 2024 14:48:18 -0400
X-MC-Unique: N_qMKYDKN6W9M5F0xAsDhg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD8B5801211;
 Thu,  9 May 2024 18:48:17 +0000 (UTC)
Received: from localhost (unknown [10.39.192.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BC171D4642E;
 Thu,  9 May 2024 18:48:16 +0000 (UTC)
Date: Thu, 9 May 2024 14:48:15 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH 6/9] block/nvme: add reservation command protocol constants
Message-ID: <20240509184815.GH515246@fedora.redhat.com>
References: <20240508093629.441057-1-luchangqi.123@bytedance.com>
 <20240508093629.441057-7-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="n2FfpF6w3lmJv5Fm"
Content-Disposition: inline
In-Reply-To: <20240508093629.441057-7-luchangqi.123@bytedance.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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


--n2FfpF6w3lmJv5Fm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2024 at 05:36:26PM +0800, Changqi Lu wrote:
> Add constants for the NVMe persistent command protocol.
> The constants include the reservation command opcode and
> reservation type values defined in section 7 of the NVMe
> 2.0 specification.
>=20
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  include/block/nvme.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--n2FfpF6w3lmJv5Fm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmY9Gm8ACgkQnKSrs4Gr
c8iS6Qf/fk/TupgcB3rA1eSX04A3q9fdPJrOmFkkW+TOtYPHG7nvgqIayfzHt7UF
W+p2pLNUjzdv4qzj6SdnfkRz/oKfBrbN1vdA4H9hGidFQVX2pf0ZphNZBpR+zYKO
AkblGDIzoDbLwrAd5sPPs5A25UYmK1GfaEyhe8DHKvhb4NLp/Q3JqKZe5jlDG3zD
mNUD+wm59CZ0GWdnBjHaBRChThm1EaxYGwfVYHw0OVmsdTjiQvvyqHSdyNrTVoDz
c+anvW/crCUPIfGnYF8/GNOWV+uUzDDRzaRb692azHxU2k4Wr/Ju12VHvDWC6GtJ
XKMfWtyAiklRtL7ffKszgZPW1nycwQ==
=6hL1
-----END PGP SIGNATURE-----

--n2FfpF6w3lmJv5Fm--


