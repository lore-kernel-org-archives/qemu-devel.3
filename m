Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3802D6D25F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 04:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGVsY-0005lV-52; Wed, 27 Nov 2024 23:11:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tGVsU-0005lE-It; Wed, 27 Nov 2024 23:11:42 -0500
Received: from xmbghk7.mail.qq.com ([43.163.128.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tGVrz-0000BO-AA; Wed, 27 Nov 2024 23:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1732766736; bh=lozs/Xcb/ma0ryQJ/lZMbb1LtEkSP5C87heNRJGQM7c=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=rmWen9AUcIirAKqCN2TygqmeFmj952zMi9m+RotbhgDIyAZrcSroOrH9mgDBzvtt9
 ZHBpGakxwebO+sdcApTxdLqxeoQWveocPNVMy7txGnLoaYYRoXJbss83nBnLXK/QdS
 LDbI16c/n6I3jsiRD9ESS+L5OGeEISebViUu1rM8=
Received: from [192.168.1.13] ([61.139.23.214])
 by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
 id 16208E2B; Thu, 28 Nov 2024 12:05:34 +0800
X-QQ-mid: xmsmtpt1732766734ts82me3oc
Message-ID: <tencent_E6B51EACA466D65291C0E6BDFD34C8EADC09@qq.com>
X-QQ-XMAILINFO: MAehWEgsdgwGC6b42kritvo2uDoVKNuK0sge30ZuAZyIrO7ULG9v6/LGHNb71v
 zIZgjm9bo8/1wLDkFsCQa7oo5EG9tUW0HXsp5Tus2BGnS2NldAK7PtWT/belOLvQ1gwpFldeCQ0k
 /orv/W+SMcCTADJhrZjG6Hi+UxAh1htMFo92UxeNUfTW1zP2KfUMEb04eEDHOzJwOW/zYhstlSta
 HVxhbb020cxrKweqwZvhcdKZQXLoSnM+8wlrqmdvtamlcbyPN6M75nIA0009IzyYIYVGgcc7Yy6L
 oAIKfU0iK73glrUDmjJmv3M0r58IJ/Zr3xLONQo9LOJ+FbpyGrQ3u7vr9/YB485flijZiKGSlY8d
 FfmtPKI6yHqlHel12BId5m1ejGp5OI42RWcF8sFLXk8Wwli0SZgr3QihEc5widebnXVWK1keJC6o
 RXYWEJvE9Wl6EgpRqnicPE1SR7Nr7xp6casjQhPsyHLmvL/tVIA7ftW9dqVup1fF+aiHKBnBMCuY
 nAi5rnZXQiHF1KuIoieunbScQjYP+oARrEFIx0T/9IfNLr+lRknYJUPk9/OoAbI2QTJpV+uc1EPo
 vRwQUMa4dr59Wcp77obxD0MBJhl9JbvLJ2U4KrrCNaEGtRJZuUqo6aqcBIbJXu01lhh0VqiebylO
 qYcuvVin0wMx/LKrspKX0zHMH09heOydNjdZPaznUkIgQSRmLhP1Ubg8sXwGWUMkzkBxbrv2EyUm
 sXz0gqHh93LRk1GKAJr0KK/odb+Ioij7Pfcjp6oMZ4bem9tYfgIE2bZvxSWWweQVp+PHUnzDFmEp
 1gsipyA6lkuv1YfEeU3IFMJHuYXPhPjAG7eQDv1+NenPWuEtnes1uLndZdq9ST9x77e95geUEUdz
 wdeJTE2Cb9j6jhAtssIscSGiiFpw9kvrzeHDymmHvS9qrUOdQvyT8acZ3VAxYFwXmGZZCKqKilbI
 pZoas1UQyc35066+i0NpZSk5VwbRUpVOkGRaQXHHqWuunkri1M+1qhBbFGSwHH
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-OQ-MSGID: <06ea1672da7a93e5f0078cb2f8648e76ddd8d0b3.camel@qq.com>
Subject: Re: [PATCH] include virtualization mode as part of priv
From: Yanfeng <yfliu2008@qq.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Alistair Francis <alistair.francis@wdc.com>
Date: Thu, 28 Nov 2024 12:05:34 +0800
In-Reply-To: <CAKmqyKO6Wjknoc1sXVm6d0BGzwcuF7VBqJdg_a1gh=6zz=KZNQ@mail.gmail.com>
References: <tencent_6FF30F7E2E640BEE260FD6523B6BA5486908@qq.com>
 <CAKmqyKMP093GyTEHdAPzaV9+O_pFSv0svQRb-31QTvn9i4fxMA@mail.gmail.com>
 <tencent_B97DED0E6971DEDD2F960CC63DFF414A2A05@qq.com>
 <CAKmqyKO6Wjknoc1sXVm6d0BGzwcuF7VBqJdg_a1gh=6zz=KZNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
Received-SPF: pass client-ip=43.163.128.48; envelope-from=yfliu2008@qq.com;
 helo=xmbghk7.mail.qq.com
X-Spam_score_int: 48
X-Spam_score: 4.8
X-Spam_bar: ++++
X-Spam_report: (4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_PBL=3.335,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Alistair.

My initial `git send-email" on Ubuntu 22.04 wasn't lukcy:

```shell
$ git send-email=20
git: 'send-email' is not a git command. See 'git --help'.
```

I need time to find a solution.

As for seperate `virt` thing, my concern is that though the V and P status =
looks
orthogonal, they are not so independent (e.g. `P=3D3` implies `V=3D0`). Hav=
ing them
in one `priv` register tells user that that they should be operated togethe=
r
using one command.

On Thu, 2024-11-28 at 12:43 +1000, Alistair Francis wrote:
> On Thu, Nov 28, 2024 at 11:43=E2=80=AFAM Yanfeng <yfliu2008@qq.com> wrote=
:
> >=20
> > On Thu, 2024-11-28 at 10:39 +1000, Alistair Francis wrote:
> > > On Thu, Nov 28, 2024 at 12:09=E2=80=AFAM Yanfeng <yfliu2008@qq.com> w=
rote:
> > > >=20
> > > >=20
> > > > When debugging hypervisor extension based programs, it is convenien=
t to
> > > > see
> > > > the
> > > > current virtualization mode from GDB debugger.
> > > >=20
> > > > This patch shares the virtualization mode as part of the existing "=
priv"
> > > > virtual
> > > > register, or more specifically via bit(8).
> > >=20
> > > Interesting concept. This seems fine to me, I don't think this will
> > > break any existing user.
> > >=20
> > > Another option though is to add a "virt" virtual register, which migh=
t
> > > be easier for people to figure out as it isn't obvious from GDB what
> > > bit 8 means. That might be a better approach as then it's really clea=
r
> > > what the register means.
> > >=20
> > > >=20
> > > >=20
> > > > > From 0d82561b11e1c2835f14ba5460cfff52f0087530 Mon Sep 17 00:00:00=
 2001
> > > > From: Yanfeng Liu <yfliu2008@qq.com>
> > > > Date: Mon, 18 Nov 2024 08:03:15 +0800
> > > > Subject: [PATCH] riscv/gdb: share virt mode via priv register
> > >=20
> > > It seems like something strange happened when you submitted the patch=
.
> > > Can you fix this up?
> > >=20
> > I prepared a patch file via the following steps:
> >=20
> > =C2=A0- Did=C2=A0 `git format-patch --stdout -1 > /tmp/patch`,
> > =C2=A0- Pasted the /tmp/patch content to email composer window,
> > =C2=A0- Filled in email receipts, subject line and a few lines before t=
he patch
> > context in composer window.
>=20
> You should use `git send-email` instead, see the QEMU documentation
> for more details:
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html#submitting=
-your-patches
>=20
> >=20
> > I am wondering if the lines added before the formatted patch content in=
 last
> > step caused trouble?
> > When resending email, should I use [patch v2] in subject line? I guess =
it is
> > unnecessary as it is the same patch.
>=20
> Ideally I think a "virt" virtual register would be a better approach,
> so if you could do that instead and send a v2 that would be great :)
>=20
> Alistair


