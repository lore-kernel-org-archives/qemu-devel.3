Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 112A1D6EBEC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 08:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGwUj-00087n-5r; Fri, 29 Nov 2024 03:36:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tGwUc-00087W-Al; Fri, 29 Nov 2024 03:36:50 -0500
Received: from xmbghk7.mail.qq.com ([43.163.128.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tGwUQ-0007hM-V1; Fri, 29 Nov 2024 03:36:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1732869384; bh=JUZ1JvO5/7NylLAVP3fUx3InPc3mDVlQsZeagbMbhYg=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=HDALsLiTfj3B5ivn8Z5vuADunlLKzIPeOoAX3WPZSvrfzcBxEs1/ziM6+yaL04Y4I
 02uomh+OFZzIG61TKoDl6kOO29XMfgylZUVJs8Mt2YIcZq4RW6MwbqOt58oAGpeY0r
 Evqu8a0w6VroYG4Bkim72KJcjd3NUdNPGbWCIK8g=
Received: from [192.168.1.13] ([61.139.23.214])
 by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
 id 902874A1; Fri, 29 Nov 2024 16:36:02 +0800
X-QQ-mid: xmsmtpt1732869362t4o19ro26
Message-ID: <tencent_473EB04841ACAD201DCF67FB1D917DB8130A@qq.com>
X-QQ-XMAILINFO: MQ+wLuVvI2LQGGFClThddbRrfJh90B0V1RQbEcdddxPGiE+HjHbhKJ6HlHCdad
 49EQui0GF+PLmSItnOxIuYVOxL6JYyjUf15ctd5ufadHJrJbqSbcdTm+u1D82Kcjg822gBLYDDSZ
 PbVwnvxjSFaByduV7WSklPVM1eG+otWtqqu1JmBYNsNQnKi3OkTZQcxX6VKkfSwY6fUskhYj2ipO
 fF/8g+PgkHcx4oiwd5NHtvfpCnME6/3cKVxj2z7gXAcJQ2RxbgUoKKJ0YW2KsbKI0zCX4shPB72n
 UhH65Qv6gcRjiRGG9jc4vm0S5umg6qfuqcsXrmT4jnJEzrXS99cvohTUrzDlC0snzREE2x5PoyBn
 ZQQ7qkpimV4JT08L1HWdLtQS3ryRyNQOpHEDffXun4ueqNgF8Rvkel6Slr7DrK3o2O7iuSoMpYLP
 5/9i3l7nlhg/5u81n9EqczNZXaUqZFHq+glRAhtGu6CscjGjXYlxDI4QdQclyPY6qd6r3c7+CYkD
 95DDlsslKGFJrr75Uik/B2m6DBL+2hRh1zU03L5B0eKWQoT06wREp4q0BXnF+8i+JZpOFyfb5TMU
 I7+e4d2FYfn8JSeZ+bLf5gJC378WfiDObXD2MJ39k7E2XQGCgpslbpouoalcl6bZe4GcJw1LBlQu
 5EFMMsBcQ28gX0dCbJNciE63XBZNDMKnsK12dhKSaTUM8R5sPQ9TfMJ8oEpWvFRQ5HrreXmx3ASu
 tvJi5lY6OkHfTVmqMfB6HkJXoRFuiX0q8qjUg0qydDsH9uEIlFuxBpOuQbddzUPL3CYOOtTjYHvo
 2XVYDcTJfKj8v+bqwPJboxM6tamL0CJL5kY/aU0KCRWZpZcxBD7AqchYhFJOxKJyzOaagP9MVaWj
 vWdfKMIenORf9y5r3/yvOY5u01bCJYNeppvZQZSOerQLuyPUlHc9dcE1JXUwiWHXB6TSYRVYFnsd
 b8E1qk2y04DG1/Rddl6lVl8dy7ZhGu
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-OQ-MSGID: <dcc7bf4ba24b117a966c05399ccee0eec5148c95.camel@qq.com>
Subject: Re: [PATCH] include virtualization mode as part of priv
From: Yanfeng <yfliu2008@qq.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Alistair Francis
 <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Weiwei Li
 <liwei1518@gmail.com>,  Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Alistair
 Francis <alistair.francis@wdc.com>
Date: Fri, 29 Nov 2024 16:36:02 +0800
In-Reply-To: <1f2a4b6f-7a70-4f61-a073-f6c953003d32@ventanamicro.com>
References: <tencent_6FF30F7E2E640BEE260FD6523B6BA5486908@qq.com>
 <CAKmqyKMP093GyTEHdAPzaV9+O_pFSv0svQRb-31QTvn9i4fxMA@mail.gmail.com>
 <tencent_B97DED0E6971DEDD2F960CC63DFF414A2A05@qq.com>
 <CAKmqyKO6Wjknoc1sXVm6d0BGzwcuF7VBqJdg_a1gh=6zz=KZNQ@mail.gmail.com>
 <tencent_E6B51EACA466D65291C0E6BDFD34C8EADC09@qq.com>
 <CAKmqyKNOXNpfekTPNOyHyYEuCXKOewCeTSFZAHpsxuC7gUzpGQ@mail.gmail.com>
 <tencent_3335F7F1076629E3B507A48979413F43B207@qq.com>
 <CAKmqyKNS3GWKpatFMchYJM31PtgjLn9YX+m_L8Nv=qXNMXhWmw@mail.gmail.com>
 <tencent_F74852576B25481AF3647E0F647DEEEA0F08@qq.com>
 <1f2a4b6f-7a70-4f61-a073-f6c953003d32@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
Received-SPF: pass client-ip=43.163.128.50; envelope-from=yfliu2008@qq.com;
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

On Thu, 2024-11-28 at 10:02 -0300, Daniel Henrique Barboza wrote:
>=20
>=20
> On 11/28/24 3:39 AM, Yanfeng wrote:
> > On Thu, 2024-11-28 at 14:46 +1000, Alistair Francis wrote:
> > > On Thu, Nov 28, 2024 at 2:27=E2=80=AFPM Yanfeng <yfliu2008@qq.com> wr=
ote:
> > > >=20
> > > > On Thu, 2024-11-28 at 14:10 +1000, Alistair Francis wrote:
> > > > > On Thu, Nov 28, 2024 at 2:05=E2=80=AFPM Yanfeng <yfliu2008@qq.com=
> wrote:
> > > > > >=20
> > > > > > Alistair.
> > > > > >=20
> > > > > > My initial `git send-email" on Ubuntu 22.04 wasn't lukcy:
> > > > > >=20
> > > > > > ```shell
> > > > > > $ git send-email
> > > > > > git: 'send-email' is not a git command. See 'git --help'.
> > > > > > ```
> > > > > >=20
> > > > > > I need time to find a solution.
> > > > >=20
> > > > > You will need to install git-send-email (or something like that)
> > > >=20
> > > > Yes, now the "git send-email" exists and I will see how to use it
> > > > correctly.
> > > >=20
> > > > >=20
> > > > > >=20
> > > > > > As for seperate `virt` thing, my concern is that though the V a=
nd P
> > > > > > status
> > > > > > looks
> > > > > > orthogonal, they are not so independent (e.g. `P=3D3` implies `=
V=3D0`).
> > > > > > Having
> > > > > > them
> > > > > > in one `priv` register tells user that that they should be oper=
ated
> > > > > > together
> > > > > > using one command.
> > > > >=20
> > > > > True, but how can a user know what bit 8 means?
> > > >=20
> > > > Good point. Can we mention it in the user document for `priv` regis=
ter?
> > >=20
> > > AFAIK we don't really have a place to document that. Which is why a
> > > "virt" register would help as it's self documenting.
> >=20
> > Okay, I will try adding a `virt` virtual register in a [PATCH v2] later=
.
>=20
> Can you please also change the patch title/subject to:
>=20
> "riscv: include virtualization mode as part of priv"
>=20
> Adding 'riscv' at the beginning will help people from the common qemu-dev=
el ML
> to
> identify which subsystem/arch this patch is aimed at.
>=20
Sure, will do in updated versions later.

Thanks,
yf

>=20
> Thanks,
>=20
> Daniel
>=20
>=20
>=20
> > >=20
> > > Alistair
> > >=20
> > > >=20
> > > > I used bit(8) at my first try and it worked from GDB command line.
> > > > Actually
> > > > I
> > > > also tried bit(4) but found GDB command takes that bit as part of P
> > > > value so
> > > > I
> > > > withdrawed back to bit(8).
> > > >=20
> > > >=20
> >=20


