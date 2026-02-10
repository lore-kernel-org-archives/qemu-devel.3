Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F42EA812F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 15:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vppkp-0005OF-Vd; Tue, 10 Feb 2026 10:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vppkn-0005Np-JK
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:34:17 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vppkl-0001Q3-SI
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:34:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770737652; x=1771342452; i=lukasstraub2@web.de;
 bh=QxDGJrdCMRNdvLVqblauj701XlRMzyK68fvMO0GYz1s=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=WDdn/6xMf9LPFpEUMIZUM+hLVbo63AJk1lBqZpqm5WLP1Zh1vKFRj4MxuSVhkL8w
 fknjoZNxpVyLchx+UDTxfD4wJKNZzXcbHGuRURSFXwxVGCC0aWeIHSPz96rpCamE0
 2ZBN/42aSVVre4dnAnLH3U8hDW7b5zfaKWbMJW6IAfPVSYRLj14TAYRP0hAYErWpw
 kD27ZJZm2/scgFWWXPuJCutMgmx50L+eW+E1oVay+gbvns0bcESZJNT8fnwu+jHIn
 vkIwVfxO9FysKBvHhmRkdze9ntzbto+C10QhDc1zIpLGOK9dyJyGQ0l/Ey8Q2WIU3
 UAIJbdkz4XYvfnzknQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([141.58.43.188]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHmq2-1w3cyw2pd8-002h1d; Tue, 10
 Feb 2026 16:34:12 +0100
Date: Tue, 10 Feb 2026 16:34:00 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen
 <zhangckid@gmail.com>, Hailiang Zhang <zhanghailiang@xfusion.com>, Markus
 Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, "Dr.
 David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v5 05/16] colo: Remove ENABLE_COLO loadvm command functions
Message-ID: <20260210163400.3697f364@penguin>
In-Reply-To: <aYtC8yxRQPxh7tKn@x1.local>
References: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
 <20260203-colo_unit_test_multifd-v5-5-57508b7389f6@web.de>
 <aYoHn5DSsia4mxMW@x1.local> <20260210142835.6622e72e@penguin>
 <aYtC8yxRQPxh7tKn@x1.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2Dwc2nHkslfDqS3HyKmXXf8";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:Wh02bDqUNEABKCsKZfYwnSYaROKo0H+zZU59ElFB6+/EVa7NQnV
 eFU4y9bxUYmqmh65XS9XhFMYxC8ZpgS5p9HW2F1QRVXOLqXAk3Vr3yAZOdvmJgum69bUXAE
 aS42d5niau9Vv2wmdrscbny+ICVb3xIehJZByHjZoauiFfbwZaOcT48M1X9uPVn9XWxaxQ9
 ISLzm19r33eAqnnFh5laQ==
UI-OutboundReport: notjunk:1;M01:P0:XWph2uYMedw=;fmODHqQiSPu+pUBzoS84a02GA4o
 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
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--Sig_/2Dwc2nHkslfDqS3HyKmXXf8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Feb 2026 09:38:43 -0500
Peter Xu <peterx@redhat.com> wrote:

> On Tue, Feb 10, 2026 at 02:28:35PM +0100, Lukas Straub wrote:
> > On Mon, 9 Feb 2026 11:13:19 -0500
> > Peter Xu <peterx@redhat.com> wrote:
> >  =20
> > > On Tue, Feb 03, 2026 at 11:15:11AM +0100, Lukas Straub wrote: =20
> > > > No need for it anymore now that x-colo capability is required
> > > > on incoming side.
> > > >=20
> > > > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>   =20
> > >=20
> > > IIUC this patch needs to be squashed into the next or it will break C=
OLO..
> > >  =20
> >=20
> > No it's fine actually. Now when we receive the MIG_CMD_ENABLE_COLO
> > command, we just go to the return 0 at the end of
> > loadvm_process_command(). =20
>=20
> Indeed, but we should actually raise an error when receiving deprecated
> commands because they're unexpected.
>=20
> Please still consider merging these two patches.  When at it, we could
> change the previous check into a "default" here:
>=20
>     if (cmd >=3D MIG_CMD_MAX || cmd =3D=3D MIG_CMD_INVALID) {
>         error_setg(errp, "MIG_CMD 0x%x unknown (len 0x%x)", cmd, len);
>         return -EINVAL;
>     }

We can't remove this since we use cmd as an index into an array below
and this can lead to out of bounds access if it is invalid.

>=20
> Or we just add a "default" to cover deprecated commands.

I will add a default case in the switch to error out for deprecated
commands,

>=20
> Thanks,
>=20


--Sig_/2Dwc2nHkslfDqS3HyKmXXf8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmmLT+gACgkQNasLKJxd
slgdSg//RWMGYc/1m6P5dIHealbX78Wdu7SOZmHAsxKlQOea6N+GQFCgbzlZR9Nm
XisLg8wFjcQ9D2E5mq/YGWVAl5liOooylZAOIhY1hUnniA3B5/PNnTxGcRF7DtnQ
sOEjvhEZz/rOuu77El//v8TF0lEUwEsPGZ4T+UieExN15KsqG8gAVAImT2EXPXGf
M+sL52Z26KeIn/8kLTJWe0nfOFSxbXhwqAGv8Qb6u/yuwf+GdLe5gCvmDj+tfJgF
DapcqNwZRU18W0Tt6HFTrFR5yrSFrrfY+8N2nF7GjxS3FY9WOwtdOiWUQ9REEpQz
vkBphKuvK1/ha9o3cgGroVm5i/XtcIqleFp3tPiEMK4W8F6rXC/P7oJp368VSEe9
lDK5tm9CRWsyEmBBPl7AQ8gtIQ7/d1U4i0w07lPY76P7XcdFxKh453GmwIBI7ZDd
ZUO40dzUY2gC7dBLvOPdPMlNuTW++V+OngUj3fsJBpT/xFvi1p88d9/hMJKlf6GC
I6QCdDpbxW9B/lJ4kEb2UvWhR5J2/2/evpP+G53CMmmXYyQ65hVSn//+7pbaotyv
5lNteJDf04QlD8exXWDRsCqUz4EX8AsuRhluwy72PZMiWhz72Sj5Uk8ikUwqu5Z9
YvsTJzlhFKciClL38qDe1my7WSgRrcUgiaZaPzA/C7/bKKbgi78=
=t875
-----END PGP SIGNATURE-----

--Sig_/2Dwc2nHkslfDqS3HyKmXXf8--

