Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD58BC79FBF
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 18:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4NCx-0006dw-JD; Wed, 09 Sep 2026 14:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x4NC7-0006B9-DY
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 14:38:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x4NC5-000776-SF
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 14:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788979128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MO9LngQasV4u/nCKeskvQOGbJ+LWx/Ui5/UA3Z46upg=;
 b=KbYvNUdf2Gt5SPIwpEDJ99AJ/bsEVPTuGxtCMGX2/rKVVbZ2MQVKl5ltc2z/3IGJMnWihh
 1xSM4x2eSfiXK8eEncsIItGobG4vpH6fmBc374Gg/A9b1I+PbL7LHg4+h4uSSf5MesARUA
 bqPalMkRqTaERyKWl8/yKQx+D2zpt74=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-ImLamSagP_GTPgKFT7cOVw-1; Wed,
 09 Sep 2026 14:38:45 -0400
X-MC-Unique: ImLamSagP_GTPgKFT7cOVw-1
X-Mimecast-MFC-AGG-ID: ImLamSagP_GTPgKFT7cOVw_1788979124
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 655421954ACF; Wed,  9 Sep 2026 18:38:44 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 221C541A; Wed,  9 Sep 2026 18:38:43 +0000 (UTC)
Date: Wed, 9 Sep 2026 14:38:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Sam Li <faithilikerun@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 08/12] file-posix: remove the zone append write
 granularity check
Message-ID: <20260909183843.GG20134@fedora>
References: <20260907110748.1868714-1-cassel@kernel.org>
 <20260907110748.1868714-9-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jcSXfCCl1E8YdcG0"
Content-Disposition: inline
In-Reply-To: <20260907110748.1868714-9-cassel@kernel.org>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--jcSXfCCl1E8YdcG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2026 at 01:07:43PM +0200, Niklas Cassel wrote:
> The check rejects a zone append whose individual iovec lengths are not
> multiples of the zone write granularity. That is stricter than the
> constraint it is meant to enforce, which applies to the size of the
> request as a whole. A request whose total is properly aligned but which
> is split across, say, a 512 byte and a 3584 byte iovec is refused here,
> even though the iovec boundaries do not survive into the scatter gather
> list that reaches the device.
>=20
> Nor is the driver the right place to enforce it. The kernel and the
> device validate writes to a sequential zone themselves, which is why the
> same function already passes the request length down without comparing it
> against BlockLimits.max_append_sectors. The sector granularity that holds
> for every backend is now checked once in bdrv_co_zone_append(), and a
> frontend enforces the granularity it advertises to its guest.
>=20
> Drop the check. BlockLimits.write_granularity is now set in one place, by
> this driver from the zone_write_granularity queue attribute, and read in
> one place, by the frontend that reports it.
>=20
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  block/file-posix.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--jcSXfCCl1E8YdcG0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqhp7MACgkQnKSrs4Gr
c8hRfwf+J8/tYYumaHolzowPJSyOok7G9T55niN24EbHOpZb7Uyc2iq7/cnGdASX
No8G+WmWv1XEf1+G2b6WCGxcqJpiGJiNEGvJNYQv7LHsP+XHg7Bd3aPuUyNcYKj6
P45EVX7QbB53gZBqjFvZSj4t2Z5wpWoa1kcWgoc3wSzsZ2ni21pu+ydHI+K46T4W
Kzjf16BzTPnUafeuKNv0VqcrdDM/TFHLbC7vZ3IQ/yJOKskEr6UXeDENEe2he+jg
hWhtl+8mMf+UH2wA9NlUWZpanHBkkBA8Bo8x8rK78R9C/JX0v0FIJF8as6mI7h6x
wcHYm41WnHODI2s0wvaHV4oP3Svlcg==
=TBDT
-----END PGP SIGNATURE-----

--jcSXfCCl1E8YdcG0--


