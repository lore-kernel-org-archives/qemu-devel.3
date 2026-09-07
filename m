Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62C9C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Tx4-0002iz-GG; Mon, 07 Sep 2026 03:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1x3Tx2-0002iY-QR; Mon, 07 Sep 2026 03:39:36 -0400
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1x3Tx1-0003KT-3C; Mon, 07 Sep 2026 03:39:36 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id C763AEC024A;
 Mon,  7 Sep 2026 03:39:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Mon, 07 Sep 2026 03:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1788766771; x=
 1788853171; bh=63Gj0ulYMLky5EniaFQNi8fw1gHkIuq99iyUBx/RmFI=; b=K
 qmDfH75zYp9KthSA41zd2N1Ne1g18XVgyI/nvF1WrdQ/oyNUFJPRISBkciDLPkZ0
 pYbQGHY2bUMWzEYfcrYQHEBK38Ywz0y2allajQ1XU09Mej+s+wYON81xgbz8Ibjs
 CIvEjk9in02GeJkPwonv/BX+JceHVm3Cg1gGtZ7Y8VuLyOh+7awSyTLjQ3gLJNbS
 zCYBYfMgRehMhBcdcZ8caqOwhjN2lnBIEoh626lM4bpcqF6I6Jtm4L2+34bMD3SB
 5JPwbMVLAgjspfU4Ej8VWQohO/qyK/omgAe/KsmmRoV9QHfDgw6M9metPIREhObe
 ovp0w1X/fbAM1JB37v1rA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1788766771; x=1788853171; bh=63Gj0ulYMLky5EniaFQNi8fw1gHkIuq99iy
 UBx/RmFI=; b=OrgdYilueyV4H6V2Kw6TCxERoxR9vYEgYjVZumVuGXOjwnzx9v8
 N1Dq/GObV8Wc2U58Th9iAEVip3ENPWSYol3zJ8vorWq+VN4ila3wyPXaQkRFHLWx
 0fkRa2tTJE/b2I229T4V8mahLZfxgQjiFRIvBL+eBWX0Qjog9g9aMhWguB3b1Ev8
 2Be2RabDTIhtqPs63kGIvmlmCGv+8wVPu721tzdUx38qzq3v6MD1vU5kqbMksfBF
 k+08bCs4lGlgfuEYa+d6xLqnuQl6e7pWrp8B+rkrF5IEbgHn7cIxg06lt/HXKR+y
 nq2wG9Ws4iGE12Y6zF9WCAxbVcj92FGjvLA==
X-ME-Sender: <xms:MmqeajAXa946QSDI387Tmy-uxWgUFXoFyZRWuVrOlgfu2XJez-50lQ>
 <xme:Mmqeajlf-zzciwNV8eibTl8CNEzT7B96Irm1l_XLhlCxjX1kkN6HhEayiIwD8nHoS
 XgTPiSPjUO9m1vUA37PXZbPU6ImySFnU1-szvs9led3Hj8tpQJQSBni>
X-ME-Received: <xmr:Mmqeaucc-3gXx43G_1f62oI5AjyvUX8xq2sTDrzHVFeG2PsEgohX6jaFEyCnIw>
X-ME-Proxy-Cause: dmFkZTF47XAg1O/FJ40IB6vuQirsJRe4HlkvtyiJBN02Z88XQB80Gej6kn3kOHcuGTbdh2
 DGn3C6llRBI0szaDiA+oty+XDuPAABPDHwoGB9Z7pFrOud/s5YmeHe3xSO6AN/f39eueS8
 l0ztbi8S+LzpD2xyOrjrkNPHKSjr66z7MPtfXXTsLQsCeJixb6HTyC786ZWjZIUFPqjjdx
 VyYA/nqzOyjQ6r8AkgAY8+8gp7tpofI9nZr2LXrv5PgsYLWfeuTi0FUesHbxF4LPvIpZ13
 ZeguW7z7eeUP6qWTmHEX1HQAilHwSx+H9JruRDzmQYote578ySG7y/iektSWKi/dVyGZMV
 HxHAw79z86wbOAtXCpbbZ5G0UUMPx6yppNGYevwxjSdtFvhg4d3JPIg3+wrzFuIlrjXgqA
 6nJZWrJuVXgz0fkcm9yxGDbNmOO1wsNSrJmw9wBMwIkW/lgIsaKqvSJ9nEPDcr3OSe8pdt
 UQStnDqdnMZl0DxGMLqBFwYXkiePQX0Lq97tvy5VuasByArTUgZR/j2RYwXXFEBzCDEKEC
 8QyDrEvoTNXVzDJEtc1HjqTpYnjMMXRg3zB+1iUsGDPeoyFwqahI5iXvkJg9jORX+RaFms
 AFcuVYmk8Rd7T+OfbtOiF/+XnaFiXjC3ilyuf+HREpishqP+4AHvH2HaKCTw
X-ME-Proxy: <xmx:MmqeanTTP6SFBoXXEzS94TVXHq-vJFWsyESnVJEtAH251BZKtaIe-w>
 <xmx:Mmqealv-o2EFvDLeyoR4ZrqCxmJ0JbpkHTi_06GYgE8tBGFqOU7viw>
 <xmx:MmqeaocsJsQzvHap66oQS7iRyg7kvRKSwh-_F0jR3IpW8r7mEnguBQ>
 <xmx:MmqeavbN9BZON96weBCflqNp6USm6Xw5wT_tk5iHEoCUZ3XFp0nD5A>
 <xmx:M2qeaoC2PkEbeg3GQe6JrCLRM3YrLU7yRA_RLXDcmSjMFxnwr6vnvTRw>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 03:39:30 -0400 (EDT)
Date: Mon, 7 Sep 2026 09:39:29 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>,
 Keith Busch <kbusch@kernel.org>, qemu-block@nongnu.org,
 Jesper Devantier <foss@defmacro.it>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v3 0/2] hw/nvme: support online resize
Message-ID: <ap5qLvPWxSXcJv2Y@AALNPWKJENSEN.aal.scsc.local>
References: <20260803083046.110121-1-alexander@mihalicyn.com>
 <anCasYYUJBhDqOKS@AALNPWKJENSEN.aal.scsc.local>
 <CAJqdLroHb7mwMx57zEpfhPcXsHwL0jCeEawCL1_f_ZYOytofRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QiDvEBkdPamMjknq"
Content-Disposition: inline
In-Reply-To: <CAJqdLroHb7mwMx57zEpfhPcXsHwL0jCeEawCL1_f_ZYOytofRQ@mail.gmail.com>
Received-SPF: pass client-ip=103.168.172.144; envelope-from=its@irrelevant.dk;
 helo=fout-a1-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--QiDvEBkdPamMjknq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 31 09:04, Alexander Mikhalitsyn wrote:
> Am Mo., 3. Aug. 2026 um 15:42 Uhr schrieb Klaus Jensen <its@irrelevant.dk=
>:
> >
> > On Aug  3 10:30, Alexander Mikhalitsyn wrote:
> > > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> > >
> > > Dear friends,
> > >
> > > This patchset is aimed to support online resize for NVMe emulated
> > > device. My approach is simple - I just implement (BlockDevOps *)->res=
ize_cb()
> > > callback and ensure that AER notification is fired to all controllers=
 using
> > > a namespace that is being resized.
> > >
> > > Testing.
> > >
> > > I manually validated this with Debian 13 VM (a resized disk was a roo=
t disk) and
> > > Windows Server 2022 (a resized disk was a secondary one).
> > >
> > > Git tree:
> > > https://gitlab.com/mihalicyn/qemu/-/commits/nvme-resize
> > >
> > > Changelog for version 3:
> > > - rebased
> > >
> > > Changelog for version 2:
> > > - checkpatch fixes
> > > - rebased
> > > - CI is green (https://gitlab.com/mihalicyn/qemu/-/pipelines/26021027=
50)
> > >
> > > Kind regards,
> > > Alex
> > >
> > > Alexander Mikhalitsyn (2):
> > >   hw/nvme: initialize ns->subsys for n->namespace
> > >   hw/nvme: support online resize
> > >
> > >  hw/nvme/ctrl.c | 10 ++++++++
> > >  hw/nvme/ns.c   | 68 ++++++++++++++++++++++++++++++++++++++++++++++++=
+-
> > >  hw/nvme/nvme.h |  2 ++
> > >  3 files changed, 79 insertions(+), 1 deletion(-)
> > >
> > > --
> > > 2.47.3
> > >
> > >
>=20
> Hi Klaus,
>=20
> >
> > LGTM.
> >
> > Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
>=20
> Thank you, I wonder if you have a plan to take this into nvme.next soon?
>=20
> Kind regards,
> Alex
>=20

Hi Alex,

Applied to nvme.next. Thanks!

I dropped the assert on ctrls (always true).


Thanks,
Klaus

--QiDvEBkdPamMjknq
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmqeai4ACgkQTeGvMW1P
Dek/Agf/Qs5bQfp8oaF7dtdD7xHmGy2/n0sMhGmq0zalLnpgd5zrt6W7K4njtFXH
UGj7s0Npz6IXFeFtkPRwZFfaVo1ma9E456K6M3MpFgmENn2mZW6rNeiWjxjT88Ld
dcLphSfpQBwpCgznNXldGI4rOEIh49k2gURnQfdEuRR0kJo3TMWsL9w2p5UGkGih
2GHmd3Bnj516oYuQxu6HtPp47E/OUGbuU0D2rYCZh1IE7EaKm65wwoGrnfO6HETn
749XG5fQnQGRQBrZnyYDkOeg+RE0gVtniKwaOyXcdMEmQcLXU7He2PYeSdiyVpLV
jD6FEG+UEQb0Oq1qYxRvx7mWoz7PdA==
=DHmu
-----END PGP SIGNATURE-----

--QiDvEBkdPamMjknq--

