Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCD4C41513
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 18:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s58VG-0000Dv-8X; Thu, 09 May 2024 14:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s58VB-0000Cs-JQ
 for qemu-devel@nongnu.org; Thu, 09 May 2024 14:28:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s58V9-0006lg-3p
 for qemu-devel@nongnu.org; Thu, 09 May 2024 14:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715279298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JAqr7oLjVxvtLCRe3Kg316wMPQCaeXkdXnTTjulRf74=;
 b=LiND+1jnZPjQGzDZzccfcPfwcOBhkJ6w0BqJqRU52syCTGj99rci6oP67CBTwCCx9PbBP6
 9OtiSxpo47YgKvAMENKk80ALOyFOl3CoL/W63ovdgdk5a4p8Flo+bPs+u2+iuryxygl32e
 Q0oNd7/NepPzXp0G51QC25OBQGIOyt8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-DJ5JTC9YNmaa2Hr9I--RrA-1; Thu, 09 May 2024 14:28:13 -0400
X-MC-Unique: DJ5JTC9YNmaa2Hr9I--RrA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C25480021D;
 Thu,  9 May 2024 18:28:13 +0000 (UTC)
Received: from localhost (unknown [10.39.192.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 80A5C139270;
 Thu,  9 May 2024 18:28:12 +0000 (UTC)
Date: Thu, 9 May 2024 14:28:11 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH 3/9] scsi/constant: add persistent reservation in/out
 protocol constants
Message-ID: <20240509182811.GE515246@fedora.redhat.com>
References: <20240508093629.441057-1-luchangqi.123@bytedance.com>
 <20240508093629.441057-4-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uO5l7VBtGF2Fe9Cf"
Content-Disposition: inline
In-Reply-To: <20240508093629.441057-4-luchangqi.123@bytedance.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
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


--uO5l7VBtGF2Fe9Cf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2024 at 05:36:23PM +0800, Changqi Lu wrote:
> Add constants for the persistent reservation in/out protocol
> in the scsi/constant module. The constants include the persistent
> reservation command, type, and scope values defined in sections
> 6.13 and 6.14 of the SCSI Primary Commands-4 (SPC-4) specification.
>=20
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  include/scsi/constants.h | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--uO5l7VBtGF2Fe9Cf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmY9FbsACgkQnKSrs4Gr
c8iT2Qf/XyeWuppTuGHJZX9v/kK6r5riq52aTKxfzq6fM+0QbRYrP+vjf/1o2EAf
VzZyj7usioPKEZhLEYPpc88d1UBEKJmi/qIjU/str0c3JS371TBrc6ASGmlHAT8u
OxzaOEueu8kApfbwWiL60UBnODLMo9kQVDlVehejNNpGTxT4645TFAdnBnt7oDip
pKr74n2n8o0nJfj+uAJdNyKhzwCsIz7UZbmE4PgIubLuHytjyZnZwgoDwZ+eylX2
FGs68bPVsZFx9zUgzr+odrBZXmfPa4CAx7yHUNGZLpZ11bByQx+BWBUCfBfiIM02
I2iMbGjB0epSZHha+seu3tYkkv2l1g==
=5Auz
-----END PGP SIGNATURE-----

--uO5l7VBtGF2Fe9Cf--


