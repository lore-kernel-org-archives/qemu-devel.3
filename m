Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50358D65553
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 06:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGYD3-00044Z-5c; Thu, 28 Nov 2024 01:41:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tGYD0-00044G-4Z; Thu, 28 Nov 2024 01:41:02 -0500
Received: from out203-205-221-173.mail.qq.com ([203.205.221.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tGYCx-0007nO-9u; Thu, 28 Nov 2024 01:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1732776047; bh=ymW7cZg743CAuE5NLifNLNXWN7UaIkMaz5+Z9f+aHHc=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=UvecMMwSXL/L4pNHdDAB7U0s4XTGTnnsvobjZBDOLLrWTra3L0XZIuvSmCoJXrFTK
 Y7riyc/V0OswMICROICM7lQkAZd5RW6jfyfUaHif6zFIIdHhnOcpUxr7M0tby5mzoT
 EMz+qxfFgN6farBxu7v6xhBgHO70H/AHBQiAtiQw=
Received: from [192.168.1.13] ([61.139.23.214])
 by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
 id 9D10527D; Thu, 28 Nov 2024 14:39:17 +0800
X-QQ-mid: xmsmtpt1732775957tfyd2abri
Message-ID: <tencent_F74852576B25481AF3647E0F647DEEEA0F08@qq.com>
X-QQ-XMAILINFO: NGsJ5Fy+2UsSTam45mqpGTUTlUbBg90AOXW/A1rt0EfwVZsyQzStJjMkTSnnBU
 UC1PQqVa8A9vxvb7GbpoXD+cIa3xehwDlax89FaY7ZjQmWCTtTv6sqoKPHQFsbjPkECWgH0dgliC
 9vMvWg6QSyhbnPZCpYpvnDinaip9jAb1IAu640SILshQZVFKaIWKM3hGShMqRhq0VlalnGeIMaxP
 jtpYAQPdCXsjWaReQ0bX5POKv1F89tct9sCXfG/5/34S0jjhuH9F22noLwl6r0xUDvFaNRiKuh4Z
 9xIJy4RI57qf+E5Qsg/jocjEiR7W2Hhw0RIBBJz8gsPt/3+y0JXbm1bzPm/V7qRyoe4nJzDpS56I
 LF37hGeztdz5dk2pTTbM0GqhwW5Od92TGCZpJOpDMPyuPiFGTVQbMqTjbHDtb9vX7gPctuIEZ2Xh
 7iBMaporDLLLxsSBJWj1jyijLutKE47K5upccPjHtR2FtTjmTKsYaAVbEnFjyXr6r0tGM10c8ELo
 vKFpVCPcD4STQAK4IZ1yj2OnYYUwCcARFE5tVW4+XyE/7RSQM0w/1RFbxSoVwSATq7f5IbdbX4WA
 oc6jfKrdTwdEC8ywsbzkUatw5veIOjnI5H/CJDD3XXKLNlD6t2g2w8KMxOtGIK/9KhlByVqjSWdX
 L1krcLH5Oo/tz6Cup1PMfXez0anCuoxGvApLcS/fCTZntsGBeSYWPs6nfNxusnDRen7dtyJxT4tO
 /qetN1fxZ+i8iw89BGd3vrQfPa3jead8T9SaqiDrPg8YNZ1nu7pBMd1DBp0FdVmEUpUnL7exTHHi
 SOvdPmKDj/6190efZR2rdDCozH3ILHTX1iZFVV+EFjeyFEoAg/B7AuE9a3G0cm1XMLu+JwORn/ml
 M0skqHtlSWubJTKCy93FpZdjWlbhdxt3GZlPRfhxY0okG28xvx+ish2qim51eYGiXtnDZVu8HYxf
 WlvRCpN9LACALAvOex0iYQdov+jMLwfGDlcP8L9Y9cRhoGiuplgDyXX7WPCpSLueRB7LW3Gtc=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-OQ-MSGID: <ce600647e3d215447307805d5f9c23d18c0700cb.camel@qq.com>
Subject: Re: [PATCH] include virtualization mode as part of priv
From: Yanfeng <yfliu2008@qq.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Alistair Francis <alistair.francis@wdc.com>
Date: Thu, 28 Nov 2024 14:39:16 +0800
In-Reply-To: <CAKmqyKNS3GWKpatFMchYJM31PtgjLn9YX+m_L8Nv=qXNMXhWmw@mail.gmail.com>
References: <tencent_6FF30F7E2E640BEE260FD6523B6BA5486908@qq.com>
 <CAKmqyKMP093GyTEHdAPzaV9+O_pFSv0svQRb-31QTvn9i4fxMA@mail.gmail.com>
 <tencent_B97DED0E6971DEDD2F960CC63DFF414A2A05@qq.com>
 <CAKmqyKO6Wjknoc1sXVm6d0BGzwcuF7VBqJdg_a1gh=6zz=KZNQ@mail.gmail.com>
 <tencent_E6B51EACA466D65291C0E6BDFD34C8EADC09@qq.com>
 <CAKmqyKNOXNpfekTPNOyHyYEuCXKOewCeTSFZAHpsxuC7gUzpGQ@mail.gmail.com>
 <tencent_3335F7F1076629E3B507A48979413F43B207@qq.com>
 <CAKmqyKNS3GWKpatFMchYJM31PtgjLn9YX+m_L8Nv=qXNMXhWmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.205.221.173; envelope-from=yfliu2008@qq.com;
 helo=out203-205-221-173.mail.qq.com
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

On Thu, 2024-11-28 at 14:46 +1000, Alistair Francis wrote:
> On Thu, Nov 28, 2024 at 2:27=E2=80=AFPM Yanfeng <yfliu2008@qq.com> wrote:
> >=20
> > On Thu, 2024-11-28 at 14:10 +1000, Alistair Francis wrote:
> > > On Thu, Nov 28, 2024 at 2:05=E2=80=AFPM Yanfeng <yfliu2008@qq.com> wr=
ote:
> > > >=20
> > > > Alistair.
> > > >=20
> > > > My initial `git send-email" on Ubuntu 22.04 wasn't lukcy:
> > > >=20
> > > > ```shell
> > > > $ git send-email
> > > > git: 'send-email' is not a git command. See 'git --help'.
> > > > ```
> > > >=20
> > > > I need time to find a solution.
> > >=20
> > > You will need to install git-send-email (or something like that)
> >=20
> > Yes, now the "git send-email" exists and I will see how to use it corre=
ctly.
> >=20
> > >=20
> > > >=20
> > > > As for seperate `virt` thing, my concern is that though the V and P
> > > > status
> > > > looks
> > > > orthogonal, they are not so independent (e.g. `P=3D3` implies `V=3D=
0`).
> > > > Having
> > > > them
> > > > in one `priv` register tells user that that they should be operated
> > > > together
> > > > using one command.
> > >=20
> > > True, but how can a user know what bit 8 means?
> >=20
> > Good point. Can we mention it in the user document for `priv` register?
>=20
> AFAIK we don't really have a place to document that. Which is why a
> "virt" register would help as it's self documenting.

Okay, I will try adding a `virt` virtual register in a [PATCH v2] later.
>=20
> Alistair
>=20
> >=20
> > I used bit(8) at my first try and it worked from GDB command line. Actu=
ally
> > I
> > also tried bit(4) but found GDB command takes that bit as part of P val=
ue so
> > I
> > withdrawed back to bit(8).
> >=20
> >=20


