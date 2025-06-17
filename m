Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17D0C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 15:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYJf-0003qn-GF; Tue, 17 Jun 2025 11:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uRYIF-00015x-6G
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:32:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uRXc6-00042p-II
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 10:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750171715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zbB3LV+aIHyWW8tOWstHjA/p/F/mNqBDWNj8rgPcNsE=;
 b=Cy3X9xuLfqqVu3GKpv7cdiZISJm1KdY2vD4g58QXc0YDbF9rRM4ZXPVF3V2XMOoVEoj5v+
 7JYIkD9lzg6eEAX6YKLNLqzjzgA/4oikbC0lH8z8jO5pOvRWREaiQxXtZC7Qy+vVTVOJES
 vncsQ3nQ2YaGDfCg0/7ci/+CtopXDiw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-hKyJJ5xfN46GLt0pBJO9_A-1; Tue,
 17 Jun 2025 10:48:30 -0400
X-MC-Unique: hKyJJ5xfN46GLt0pBJO9_A-1
X-Mimecast-MFC-AGG-ID: hKyJJ5xfN46GLt0pBJO9_A_1750171709
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F3191956086; Tue, 17 Jun 2025 14:48:29 +0000 (UTC)
Received: from localhost (unknown [10.2.16.91])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E4D830001B1; Tue, 17 Jun 2025 14:48:28 +0000 (UTC)
Date: Tue, 17 Jun 2025 10:48:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] rust: hpet: fix new warning
Message-ID: <20250617144827.GA146772@fedora>
References: <20250617081038.115099-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/IJJF9mhg3uLj5zh"
Content-Disposition: inline
In-Reply-To: <20250617081038.115099-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
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


--/IJJF9mhg3uLj5zh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 10:10:38AM +0200, Paolo Bonzini wrote:
> Nightly rustc complains that HPETAddrDecode has a lifetime but it is not
> clearly noted that it comes from &self.  Apply the compiler's suggestion
> to shut it up.
>=20
> Cc: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/timer/hpet/src/device.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/IJJF9mhg3uLj5zh
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhRgDsACgkQnKSrs4Gr
c8jVzwf/dhTkr3gGbGj0NmjM5l7s4gOBwd5uVgIHdJzT56TxP1+H/6Fy+V6eXmnb
nfK/1QrBfSFSfchuNG6qilCjxLJev0LHJTCT4ZV/v7CL5SCXYrcAYhsULPtHfiyw
oHMdFl62PpKf8Ecu79vEDfMBxb5mPz4OeTojstVFIoBVk7L13098WQ3GkAzyej25
etVJZn3LlpEbhEDY61ppd11KAJXs16aFtQnwTRz2T/OfAZkuUFuMtzyd6EW3fv5e
RrEYhzOQuCC5MiwsBqu5+hIOXTLwv7q5B1AsrHt4OKjV7d5r7CAj+K1o/zWgweP4
lvUEiF9Fw51bDNLVAb9EjtBfCg92Lw==
=+sNr
-----END PGP SIGNATURE-----

--/IJJF9mhg3uLj5zh--


