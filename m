Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7122D6D25F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 04:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGW8c-0000EO-Jn; Wed, 27 Nov 2024 23:28:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tGW8a-0000E6-PU; Wed, 27 Nov 2024 23:28:20 -0500
Received: from out203-205-221-202.mail.qq.com ([203.205.221.202])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tGW8X-0000NL-9x; Wed, 27 Nov 2024 23:28:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1732768083; bh=wykbL8wRBWbXe1D+ZTKyfI8h18CPqgA/cH3onDOFv4c=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=ziOStmOsHqJLOhZeli9gzCoZhPSMDl4hKeSprrc65Rc5AycLkQx8D+1gjaYQwp8N4
 vuLtRjLa7MBvZMu4RtSGWTAZqrOeLohkGf4evyV42BUKCk5NU6C/TtYEeQ0ho/EKAm
 S2Gye1EYk8VIwo2GJCswrgziyddke5JLQXxqfgcM=
Received: from [192.168.1.13] ([61.139.23.214])
 by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
 id 6E9990AA; Thu, 28 Nov 2024 12:27:41 +0800
X-QQ-mid: xmsmtpt1732768061tp5jcw90h
Message-ID: <tencent_3335F7F1076629E3B507A48979413F43B207@qq.com>
X-QQ-XMAILINFO: MYnm/zSYYhX10knOWcNVXzb7LwvrkGy66FDvUFKcGVTZKwT6CXcb6iylAojTey
 UydanzSIGWxwxEdyS0kjhyKrNL5YqZsSl3Boi3JqFA/05fOKZ1LOREobxC2OM6mENv33MhDqtt7k
 3R4mJXaPyKO+P23YnpGyxvRBeZiQLblMGz3RKtw7Z8oSRcAEc54sCvim1PgTIy9/nynCKUMv5kTd
 uUlm6iZzhijbgWL4ng/fdTFLjrfpDj+a2yVB/Hw6WyuPSgOJxLQ/qU1Ne9dcrQp+XCuYak8d9rJ0
 4Z2dl0vOtYXM92fbFZ93ieSkFvx+vRJbH9o5aTy5bnUp98xHd7SzeFWUY5kZaR5xwjCAzO8H1CZb
 YWRIuKodnsEIgFBorfCMcDeb7p8/xWbaL3xKAi702JD1/0EmEA4BSFiz3qWcXsKjkcoqvmM0BS0w
 qMfKtfUHTMMVgxvb03kNH12Bx6Fdh2wf6DJZwSFLSbkqL99EX35dUO8/8v5XesQbB+SMKjbD+6MH
 KLN+skCBjKVsRfv1Wp3Guq31lgYVL4402lFdbVfVbG8CxGEv0uRAZ4tw2ANYVGVBxwMg6b9vDgCU
 UW8ZnwEO/bXt6sOVmKqFaOzdogcZi9qcba4Y9K11iUsUuIZZKixAAKkgh9ou1aQJjQDBVVQ881T7
 ez3TzsyQ/EjQAIF6KkSQvWl9YjAllvBIZyIFTJL7iURvQpq7yZsT7OT0pZPJ2/RHuotNlRHA+WO/
 OOcG9ZonNDyLxb090fkkboZFAT2Dt0ZWugwKJJg4R87ACpKzMI8MJedBeUzCJNwcDBX4Dg6qORzK
 9E4HgL/RjrmedpAUAwRml2ab4wi4Hy5KuFBFzI7R/F4KeSIf2yIh3Shn8tCzXwTYUa6UUIkvN8gz
 8zU1mtINYrZ6pfJJL8G7Akp04L4JYUXuJuF7uya3yoBcvJ7GKs03RI4B/hFjjOHlffu1YMF6r5x+
 kBxT3dhW46M/idYamxMYNQ/CLDIhoN
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-OQ-MSGID: <9db0645b109dc9485c77710d5978698ab38713e8.camel@qq.com>
Subject: Re: [PATCH] include virtualization mode as part of priv
From: Yanfeng <yfliu2008@qq.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Alistair Francis <alistair.francis@wdc.com>
Date: Thu, 28 Nov 2024 12:27:41 +0800
In-Reply-To: <CAKmqyKNOXNpfekTPNOyHyYEuCXKOewCeTSFZAHpsxuC7gUzpGQ@mail.gmail.com>
References: <tencent_6FF30F7E2E640BEE260FD6523B6BA5486908@qq.com>
 <CAKmqyKMP093GyTEHdAPzaV9+O_pFSv0svQRb-31QTvn9i4fxMA@mail.gmail.com>
 <tencent_B97DED0E6971DEDD2F960CC63DFF414A2A05@qq.com>
 <CAKmqyKO6Wjknoc1sXVm6d0BGzwcuF7VBqJdg_a1gh=6zz=KZNQ@mail.gmail.com>
 <tencent_E6B51EACA466D65291C0E6BDFD34C8EADC09@qq.com>
 <CAKmqyKNOXNpfekTPNOyHyYEuCXKOewCeTSFZAHpsxuC7gUzpGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.205.221.202; envelope-from=yfliu2008@qq.com;
 helo=out203-205-221-202.mail.qq.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, HELO_DYNAMIC_IPADDR=1.951, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001,
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

On Thu, 2024-11-28 at 14:10 +1000, Alistair Francis wrote:
> On Thu, Nov 28, 2024 at 2:05=E2=80=AFPM Yanfeng <yfliu2008@qq.com> wrote:
> >=20
> > Alistair.
> >=20
> > My initial `git send-email" on Ubuntu 22.04 wasn't lukcy:
> >=20
> > ```shell
> > $ git send-email
> > git: 'send-email' is not a git command. See 'git --help'.
> > ```
> >=20
> > I need time to find a solution.
>=20
> You will need to install git-send-email (or something like that)

Yes, now the "git send-email" exists and I will see how to use it correctly=
.

>=20
> >=20
> > As for seperate `virt` thing, my concern is that though the V and P sta=
tus
> > looks
> > orthogonal, they are not so independent (e.g. `P=3D3` implies `V=3D0`).=
 Having
> > them
> > in one `priv` register tells user that that they should be operated tog=
ether
> > using one command.
>=20
> True, but how can a user know what bit 8 means?

Good point.=C2=A0Can we mention it in the user document for `priv` register=
?=20

I used bit(8) at my first try and it worked from GDB command line. Actually=
 I
also tried bit(4) but found GDB command takes that bit as part of P value s=
o I
withdrawed back to bit(8).

>=20
> Alistair
>=20
> >=20
> > On Thu, 2024-11-28 at 12:43 +1000, Alistair Francis wrote:
> > > On Thu, Nov 28, 2024 at 11:43=E2=80=AFAM Yanfeng <yfliu2008@qq.com> w=
rote:
> > > >=20
> > > > On Thu, 2024-11-28 at 10:39 +1000, Alistair Francis wrote:
> > > > > On Thu, Nov 28, 2024 at 12:09=E2=80=AFAM Yanfeng <yfliu2008@qq.co=
m> wrote:
> > > > > >=20
> > > > > >=20
> > > > > > When debugging hypervisor extension based programs, it is conve=
nient
> > > > > > to
> > > > > > see
> > > > > > the
> > > > > > current virtualization mode from GDB debugger.
> > > > > >=20
> > > > > > This patch shares the virtualization mode as part of the existi=
ng
> > > > > > "priv"
> > > > > > virtual
> > > > > > register, or more specifically via bit(8).
> > > > >=20
> > > > > Interesting concept. This seems fine to me, I don't think this wi=
ll
> > > > > break any existing user.
> > > > >=20
> > > > > Another option though is to add a "virt" virtual register, which =
might
> > > > > be easier for people to figure out as it isn't obvious from GDB w=
hat
> > > > > bit 8 means. That might be a better approach as then it's really =
clear
> > > > > what the register means.
> > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > > From 0d82561b11e1c2835f14ba5460cfff52f0087530 Mon Sep 17 00:0=
0:00
> > > > > > > 2001
> > > > > > From: Yanfeng Liu <yfliu2008@qq.com>
> > > > > > Date: Mon, 18 Nov 2024 08:03:15 +0800
> > > > > > Subject: [PATCH] riscv/gdb: share virt mode via priv register
> > > > >=20
> > > > > It seems like something strange happened when you submitted the p=
atch.
> > > > > Can you fix this up?
> > > > >=20
> > > > I prepared a patch file via the following steps:
> > > >=20
> > > > =C2=A0- Did=C2=A0 `git format-patch --stdout -1 > /tmp/patch`,
> > > > =C2=A0- Pasted the /tmp/patch content to email composer window,
> > > > =C2=A0- Filled in email receipts, subject line and a few lines befo=
re the
> > > > patch
> > > > context in composer window.
> > >=20
> > > You should use `git send-email` instead, see the QEMU documentation
> > > for more details:
> > > https://www.qemu.org/docs/master/devel/submitting-a-patch.html#submit=
ting-your-patches
> > >=20
> > > >=20
> > > > I am wondering if the lines added before the formatted patch conten=
t in
> > > > last
> > > > step caused trouble?
> > > > When resending email, should I use [patch v2] in subject line? I gu=
ess
> > > > it is
> > > > unnecessary as it is the same patch.
> > >=20
> > > Ideally I think a "virt" virtual register would be a better approach,
> > > so if you could do that instead and send a v2 that would be great :)
> > >=20
> > > Alistair


