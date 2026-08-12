Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A25DC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuA10-0007C5-2F; Wed, 12 Aug 2026 10:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wuA0u-0007BR-KY
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:33:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wuA0s-0001AX-VR
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786545181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=seuUHy68rkvcyr4mUCQ72qekm9DYFqJv5AGcn3F8jmA=;
 b=ARhMlQjAG6kILqc3PNax1gWr5i8gqSMjPq9R/Oboyau5v1d2k0VRov0wQyFRZhZPnOy8UR
 u5uUhiEDE1rPP8jX2x7FeV1cg5U2NJ324buh4shL1AV/L3aA6P/5MAvNSXhvhNcPpV9FFZ
 g4t+3ebDju1zI9OcWJPL3HHO+O8jZY4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-fbCUv0PuOSe9zCY4qIDOiw-1; Wed,
 12 Aug 2026 10:32:58 -0400
X-MC-Unique: fbCUv0PuOSe9zCY4qIDOiw-1
X-Mimecast-MFC-AGG-ID: fbCUv0PuOSe9zCY4qIDOiw_1786545177
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E56019560A1; Wed, 12 Aug 2026 14:32:56 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E082E423; Wed, 12 Aug 2026 14:32:55 +0000 (UTC)
Date: Wed, 12 Aug 2026 10:32:54 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: Re: [PULL v2 0/7] IDE patches
Message-ID: <20260812143254.GD244786@fedora>
References: <20260804170015.3128363-1-den@openvz.org>
 <20260805005513.GA582272@fedora>
 <72361406-f846-42ac-a3bf-a09985794bf1@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="T6mDnnMSp1bvqBFu"
Content-Disposition: inline
In-Reply-To: <72361406-f846-42ac-a3bf-a09985794bf1@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

--T6mDnnMSp1bvqBFu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 02:48:45PM +0200, Denis V. Lunev wrote:
> On 8/5/26 02:55, Stefan Hajnoczi wrote:
> > Applied, thanks.
> >
> > Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for=
 any user-visible changes.
> Hi, Stefan!
>=20
> It is kinda strange but I do not see this series neither
> in master, no in staging today.
>=20
> The head for me is
>=20
> commit e8d693e12af9cbb89d724baadfcc08559669e279 (upstream/staging,
> upstream/master, upstream/HEAD)
> Author: Stefan Hajnoczi <stefanha@redhat.com>
> Date:=A0 =A0Tue Aug 11 14:31:44 2026 -0400
>=20
> I see only this patch merged:
>=20
> athena ~/src/qemu $ git log --author openvz.org hw/ide/
> commit d9f78431d8ebdc2d03ad74461138c1c9eb076aa5
> Author: Denis V. Lunev <den@openvz.org>
> Date:=A0 =A0Fri Jun 19 13:21:49 2026 +0200
>=20
> =A0 =A0 hw/ide/ahci: cancel in-flight buffered reads on command engine re=
start
>=20
> Does something missed/goes wrong?

I see the same thing. Sorry, I must have messed up when building the
staging tree and dropped your series.

Richard Henderson is handling qemu.git pull requests for the 11.2
release and I've asked him to merge your series.

Stefan

--T6mDnnMSp1bvqBFu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmp8hBYACgkQnKSrs4Gr
c8g0sAgAi/pY5wp0hFGwgFfJgZyn+QbXfdwtzBYwqD4M/g8JztAEtiMtEfTQxtOv
aNxV518J9KaQBfkgJnLdznxhwxNi8TbKwJDGsOpJ8Mu/DhEd1IwnW9AMQ13lOaz6
a13G8KfKFOKZZMdEO053jn47MDQsc7+4aX4VmABjXOxe0fmDWDhkuhbPis1v7btZ
gNptpb4dKVDfwbAmY/HWSFqFlGVh4tjuHVuPOxreiPVR6s8vZFZVINl8N3E+QA1/
4y9GTFSGoRgpw2HgPpqNfNjUb1NxJlwuP//yeJCKt/9yQiIprvgN4I7aGw+Co85p
gfJ2/pUFOvsIia2LCVxhaB53CoAn+w==
=L7K+
-----END PGP SIGNATURE-----

--T6mDnnMSp1bvqBFu--


