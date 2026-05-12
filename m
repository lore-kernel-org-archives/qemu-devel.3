Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7DCCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 15:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMokA-0003MZ-Pn; Tue, 12 May 2026 11:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wMojl-0003L6-6H
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:09:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wMoji-0004WQ-J1
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778598569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oqtzmb3xbU5QS7y3aLB4EoWUkOvWbI6R9O5qlP3XWwo=;
 b=R7EdPlUELQewe/YPQv0S+cntBD+FRdmTyQu3TKsCrHwi7/KnoWa40fujrh6GnJsn5/ushs
 aDhFgfv8mvHVCfmx5+sZce19HaO4k1sgOOjv+A16SYl54UPtUu+gsBY4U56gl/d8fzF3SY
 nHaDAUca/QsF2kJK7Fd0BRR4YaCfgr4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-y_r9rdMRNWW8aUx0CeSsUA-1; Tue,
 12 May 2026 11:09:21 -0400
X-MC-Unique: y_r9rdMRNWW8aUx0CeSsUA-1
X-Mimecast-MFC-AGG-ID: y_r9rdMRNWW8aUx0CeSsUA_1778598560
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E11251806D26; Tue, 12 May 2026 15:09:05 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.152])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80F2818004A3; Tue, 12 May 2026 15:09:03 +0000 (UTC)
Date: Tue, 12 May 2026 17:09:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Peter Xu <peterx@redhat.com>, Zhang Chen <zhangckid@gmail.com>
Subject: Re: [PATCH 0/2] MAINTAINERS: Add myself as maintainer for replication
Message-ID: <agNCjVL1sSICuAMa@redhat.com>
References: <20260425-replication_maintainer-v1-0-f6ab019ff0ca@web.de>
 <agMeSMj8XETo1vMn@redhat.com> <20260512152402.0f18df61@penguin>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UL/OBnatZR3s2inL"
Content-Disposition: inline
In-Reply-To: <20260512152402.0f18df61@penguin>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--UL/OBnatZR3s2inL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 12.05.2026 um 15:24 hat Lukas Straub geschrieben:
> On Tue, 12 May 2026 14:34:16 +0200
> Kevin Wolf <kwolf@redhat.com> wrote:
>=20
> > Hi Lukas,
> >=20
> > Am 25.04.2026 um 16:08 hat Lukas Straub geschrieben:
> > > I recently took up maintainership for the orphaned COLO migraion comp=
onent.
> > > Here I take over maintainership for replication which is another impo=
rtant
> > > component for COLO. =20
> >=20
> > What are your plans with replication? Will you be sending pull requests
> > directly to the global maintainer, or should we keep taking patches
> > through the block layer queues with your Acked-by?
>=20
> I would prefer to review patches and you take them trough the block
> layer queue for now. The recent changes only have been drive-by/global
> refactorings anyway.
>=20
> I don't think I can send pull requests directly as my key is not yet
> signed for that.

The problem with the key should be solvable, but no problem, I can keep
taking things through the block tree.

> > Same question for this series, will you merge it yourself or would you
> > like someone else to pick it up?
>=20
> I would like someone else to pick it up.

I applied the series to my tree, give me a few more days for sending a
pull request.

Kevin

--UL/OBnatZR3s2inL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmoDQowACgkQfwmycsiP
L9biMw/9HOOmPMzJlPd7B6iFSDtFzeSd5OzHMsikF3H9msiDd3LKdOS5KZyGmnZY
ilfqBuAAx41alz/CnDiW9uiUTc2V0ILRFaSKBx1/ZrDOpPw/vXqByUhDgTjHr12X
CeNCstl3KGh07j6T248zZNeIMlXuuZbId9kasPbeOupO0/gCLIaciMiSuYyvP6ao
xkwMs2DfbaOsC8rpMydYKCUEh1xYDEWrdWXjt5Dn150aCMarz+2F2WRCm76D2TW0
uF50kJgfMEiiCnDmg3d6FOpIzbosJDAuWnW3BEcjQRdxVSj79RhZ0qfaWCP5TxTw
pI+rhpDiJl+JWLuZj3IOCxv9WlwB4zAhFIPDj3DrdahSRYv+Q4+1cHeyQOULnqf1
mQx6STkQJGndf2NaXkQwY2s0gnuzws5n4KS3X00hwvwR7jFk63yTFUytCAJkh1Y1
0DlqgVyv7WYLjNo9sEsN2Ga8bAN6UFcRCzf86duFjHtJV8CUTzuQ8Wbhu1WDRArE
qho7mizHHh4zoCfTfVlsOidvx4VQXT862Jl6gkkmMCaPfRLE7/sm1+iVy8W0owim
ggLnemi9KKOtpjVVtc3ofPp2aVKCTO/vXpu7+x93B9GPYJF/dYMJg6NkrvtW5J0k
zU74ZF7QP4wKsrVmRKrVtkohhIjkHvtqYTEKOxDXQhO9/JpUPuQ=
=hf5a
-----END PGP SIGNATURE-----

--UL/OBnatZR3s2inL--


