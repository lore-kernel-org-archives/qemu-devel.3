Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B63D6D253
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 01:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGTZP-0003G3-JJ; Wed, 27 Nov 2024 20:43:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tGTZI-0003Fd-On; Wed, 27 Nov 2024 20:43:44 -0500
Received: from out203-205-221-210.mail.qq.com ([203.205.221.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tGTZF-0001hj-3e; Wed, 27 Nov 2024 20:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1732758203; bh=Y3pkN5qk0NwNN5+Bv1hlViANC9e8USj6uMh8BVfMDpY=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=pkImjuiTOyWPp0RuHoawbcNQ5ekKy5KMQCkWQGm90Y4CXIJuvd1KyLVIYKdZTCtJL
 pmxAOLkouIASn1Y/gP2B86PnB3cykRBoFzd/gJCpVzUb+gQgWG9lKdNmCgQmJrFr33
 4aCQLVsVOdPvdVj/w1JV1Y8bvWUAvvzLkFww02fw=
Received: from [192.168.1.13] ([61.139.23.214])
 by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
 id AD518EB3; Thu, 28 Nov 2024 09:43:21 +0800
X-QQ-mid: xmsmtpt1732758201t1fy8q5xf
Message-ID: <tencent_B97DED0E6971DEDD2F960CC63DFF414A2A05@qq.com>
X-QQ-XMAILINFO: MJf32pulH4817O09VOkGlfgy/mIdKvppOruy0AbEhM79iY5sM5ilk3UTp13Xyv
 LZJfbycQG2WCr0sItHw6vu492H2rXKC8EytCSYAo2sqwVyjOtA4uG860F/+BxF4liOjP9M/onmx4
 /OEz7S+AxBJnH+1odtjZe4nLSUwwo052FOxJpQ28nXjuqJ/L2iF0c4ZVK+7KGryq0fKaBgi+QpX4
 XLHR+gpCimE59D5tRVAxEL319bMONXZyl3B2ZiBjPyJhlqUB/Edfhw4PFy83TxeXShWSJT4OMUWA
 gMR8Klf1diOnsFmEg9HfDcTGVsM8L0zSzgmbtjibjR13U3deK34H/56Z1778jXOknONzm3wnXo2b
 5bK35V16sIXoGvLncdR0xdKZbfq7OpI6DN84GQn4Mqjh6wa/viqEtPN8s+C4P1/o8Ps47XGpATGR
 K0gDkalNmuPXxLWS0HDeT+gYqGBKilfkxGT8CotCsyWQMqN5y96Fl4nnhfWRw2c1/oYW/f4b/A00
 0/hRPwuFes+NBNfEBJFNTs/Ro4xWZSyuf1j+0gy2KmyC2DUHxz3nJvN2fo+xbvtq6GFAm3hG0oi1
 oA7wUr1raHaLd9d2N+PSKFu1xQSOsjm6Iu18do2AUI0PJrP5Z24MkCkWW80/c+jb+hTG5swBc7Fs
 k12y9DhBpFV4AUq43ZaGNIQ/74sly2tgGl44efiuhMFAPUn5DuJCgtL7rVFHEg+aCqV1RXA3CVNp
 eFtz+mVV4dnWpDYz+XWMmA1MwX/+lfwXMHR0I+3FyLqcHBKSWRAV/eI5CrWpjzO1DilXG9+fcgC8
 klcBBx31IIJyTv1oU0nZR7xJ1hAmgv2ZuT1vdE2qCQgIFEwWbZZJadEeqrZEUpGBdUaecdSLzHn0
 o8PWhHPcBJHPYQt8Jy+8tmUmBXcI96uZ2m50FVKaui0NeNtnFA4oGfUd5xw3zrrTBUHI2M6DYI0j
 QUnxbGqYcxcU1/X8MWRw==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-OQ-MSGID: <178f67b31d13bf33c1a94395acef91bead530853.camel@qq.com>
Subject: Re: [PATCH] include virtualization mode as part of priv
From: Yanfeng <yfliu2008@qq.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Alistair Francis <alistair.francis@wdc.com>
Date: Thu, 28 Nov 2024 09:43:20 +0800
In-Reply-To: <CAKmqyKMP093GyTEHdAPzaV9+O_pFSv0svQRb-31QTvn9i4fxMA@mail.gmail.com>
References: <tencent_6FF30F7E2E640BEE260FD6523B6BA5486908@qq.com>
 <CAKmqyKMP093GyTEHdAPzaV9+O_pFSv0svQRb-31QTvn9i4fxMA@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-K7e02pMMS878C5HgoH4+"
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.205.221.210; envelope-from=yfliu2008@qq.com;
 helo=out203-205-221-210.mail.qq.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, HELO_DYNAMIC_IPADDR=1.951, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.931, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001,
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

--=-K7e02pMMS878C5HgoH4+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2024-11-28 at 10:39 +1000, Alistair Francis wrote:
> On Thu, Nov 28, 2024 at 12:09=E2=80=AFAM Yanfeng <yfliu2008@qq.com> wrote=
:
> >=20
> >=20
> > When debugging hypervisor extension based programs, it is convenient to=
 see
> > the
> > current virtualization mode from GDB debugger.
> >=20
> > This patch shares the virtualization mode as part of the existing "priv=
"
> > virtual
> > register, or more specifically via bit(8).
>=20
> Interesting concept. This seems fine to me, I don't think this will
> break any existing user.
>=20
> Another option though is to add a "virt" virtual register, which might
> be easier for people to figure out as it isn't obvious from GDB what
> bit 8 means. That might be a better approach as then it's really clear
> what the register means.
>=20
> >=20
> >=20
> > > From 0d82561b11e1c2835f14ba5460cfff52f0087530 Mon Sep 17 00:00:00 200=
1
> > From: Yanfeng Liu <yfliu2008@qq.com>
> > Date: Mon, 18 Nov 2024 08:03:15 +0800
> > Subject: [PATCH] riscv/gdb: share virt mode via priv register
>=20
> It seems like something strange happened when you submitted the patch.
> Can you fix this up?
>=20
I prepared a patch file via the following steps:

 - Did  `git format-patch --stdout -1 > /tmp/patch`,=C2=A0
 - Pasted the /tmp/patch content to email composer window,=C2=A0
 - Filled in email receipts, subject line and a few lines before the patch
context in composer window.

I am wondering if the lines added before the formatted patch content in las=
t
step caused trouble?
When resending email, should I use [patch v2] in subject line? I guess it i=
s
unnecessary as it is the same patch.=C2=A0

I included it as attachment here as well, hoping it helps.

Regards,
yf
=20
> Alistair
>=20
> >=20
> > This shares virtualization mode together with privilege mode
> > via the `priv` virtual register over the debug interface.
> >=20
> > Check logs with gdb-multiarch 12.1:
> >=20
> > ```
> > (gdb) info registers priv
> > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x101=
=C2=A0=C2=A0=C2=A0 prv:1 [Supervisor]
> > (gdb) set $priv =3D 1
> > (gdb) info registers priv
> > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 prv:1 [Supervisor]
> > (gdb) set $priv =3D 0x101
> > (gdb) info registers priv
> > priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x101=
=C2=A0=C2=A0=C2=A0 prv:1 [Supervisor]
> > (gdb)
> > ```
> >=20
> > Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
> > ---
> > =C2=A0target/riscv/cpu_bits.h |=C2=A0 4 ++++
> > =C2=A0target/riscv/gdbstub.c=C2=A0 | 15 +++++++++++++--
> > =C2=A02 files changed, 17 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> > index 385a2c67c2..cc6dece51a 100644
> > --- a/target/riscv/cpu_bits.h
> > +++ b/target/riscv/cpu_bits.h
> > @@ -623,6 +623,10 @@ typedef enum {
> > =C2=A0#define PRV_RESERVED 2
> > =C2=A0#define PRV_M 3
> >=20
> > +/* Share virtualization mode as part of priv register */
> > +#define PRV_V=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 8)
> > +
> > +
> > =C2=A0/* RV32 satp CSR field masks */
> > =C2=A0#define SATP32_MODE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x80000000
> > =C2=A0#define SATP32_ASID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x7fc00000
> > diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> > index c07df972f1..d9e6ad969a 100644
> > --- a/target/riscv/gdbstub.c
> > +++ b/target/riscv/gdbstub.c
> > @@ -212,8 +212,14 @@ static int riscv_gdb_get_virtual(CPUState *cs,
> > GByteArray
> > *buf, int n)
> > =C2=A0#else
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RISCVCPU *cpu =3D RISC=
V_CPU(cs);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPURISCVState *env =3D=
 &cpu->env;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_ulong ret =3D env->p=
riv;
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return gdb_get_regl(buf, en=
v->priv);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* include virtualization m=
ode */
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env->virt_enabled) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 |=3D PRV_V;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return gdb_get_regl(buf, re=
t);
> > =C2=A0#endif
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > @@ -225,11 +231,16 @@ static int riscv_gdb_set_virtual(CPUState *cs, ui=
nt8_t
> > *mem_buf, int n)
> > =C2=A0#ifndef CONFIG_USER_ONLY
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RISCVCPU *cpu =3D RISC=
V_CPU(cs);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPURISCVState *env =3D=
 &cpu->env;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_ulong val =3D ldtul_=
p(mem_buf);
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->priv =3D ldtul_p(mem_b=
uf) & 0x3;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->priv =3D val & 0x3;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env->priv =3D=3D P=
RV_RESERVED) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 env->priv =3D PRV_S;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Update virtualization mo=
de */
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->virt_enabled =3D (env-=
>priv !=3D PRV_M && (val & PRV_V) !=3D 0);
> > =C2=A0#endif
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return sizeof(target_u=
long);
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > --
> > 2.34.1
> >=20
> >=20
> >=20


--=-K7e02pMMS878C5HgoH4+
Content-Disposition: attachment; filename="virt-in-priv.patch"
Content-Type: text/x-patch; name="virt-in-priv.patch"; charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSAwZDgyNTYxYjExZTFjMjgzNWYxNGJhNTQ2MGNmZmY1MmYwMDg3NTMwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZYW5mZW5nIExpdSA8eWZsaXUyMDA4QHFxLmNvbT4KRGF0ZTog
TW9uLCAxOCBOb3YgMjAyNCAwODowMzoxNSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIHJpc2N2L2dk
Yjogc2hhcmUgdmlydCBtb2RlIHZpYSBwcml2IHJlZ2lzdGVyCgpUaGlzIHNoYXJlcyB2aXJ0dWFs
aXphdGlvbiBtb2RlIHRvZ2V0aGVyIHdpdGggcHJpdmlsZWdlIG1vZGUKdmlhIHRoZSBgcHJpdmAg
dmlydHVhbCByZWdpc3RlciBvdmVyIHRoZSBkZWJ1ZyBpbnRlcmZhY2UuCgpDaGVjayBsb2dzIHdp
dGggZ2RiLW11bHRpYXJjaCAxMi4xOgoKYGBgCihnZGIpIGluZm8gcmVnaXN0ZXJzIHByaXYKcHJp
diAgICAgICAgICAgMHgxMDEJcHJ2OjEgW1N1cGVydmlzb3JdCihnZGIpIHNldCAkcHJpdiA9IDEK
KGdkYikgaW5mbyByZWdpc3RlcnMgcHJpdgpwcml2ICAgICAgICAgICAweDEJcHJ2OjEgW1N1cGVy
dmlzb3JdCihnZGIpIHNldCAkcHJpdiA9IDB4MTAxCihnZGIpIGluZm8gcmVnaXN0ZXJzIHByaXYK
cHJpdiAgICAgICAgICAgMHgxMDEJcHJ2OjEgW1N1cGVydmlzb3JdCihnZGIpCmBgYAoKU2lnbmVk
LW9mZi1ieTogWWFuZmVuZyBMaXUgPHlmbGl1MjAwOEBxcS5jb20+Ci0tLQogdGFyZ2V0L3Jpc2N2
L2NwdV9iaXRzLmggfCAgNCArKysrCiB0YXJnZXQvcmlzY3YvZ2Ric3R1Yi5jICB8IDE1ICsrKysr
KysrKysrKystLQogMiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jcHVfYml0cy5oIGIvdGFyZ2V0L3Jpc2N2
L2NwdV9iaXRzLmgKaW5kZXggMzg1YTJjNjdjMi4uY2M2ZGVjZTUxYSAxMDA2NDQKLS0tIGEvdGFy
Z2V0L3Jpc2N2L2NwdV9iaXRzLmgKKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmgKQEAgLTYy
Myw2ICs2MjMsMTAgQEAgdHlwZWRlZiBlbnVtIHsKICNkZWZpbmUgUFJWX1JFU0VSVkVEIDIKICNk
ZWZpbmUgUFJWX00gMwogCisvKiBTaGFyZSB2aXJ0dWFsaXphdGlvbiBtb2RlIGFzIHBhcnQgb2Yg
cHJpdiByZWdpc3RlciAqLworI2RlZmluZSBQUlZfViAgICAgICAgICAgICAgICAoMSA8PCA4KQor
CisKIC8qIFJWMzIgc2F0cCBDU1IgZmllbGQgbWFza3MgKi8KICNkZWZpbmUgU0FUUDMyX01PREUg
ICAgICAgICAweDgwMDAwMDAwCiAjZGVmaW5lIFNBVFAzMl9BU0lEICAgICAgICAgMHg3ZmMwMDAw
MApkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2dkYnN0dWIuYyBiL3RhcmdldC9yaXNjdi9nZGJz
dHViLmMKaW5kZXggYzA3ZGY5NzJmMS4uZDllNmFkOTY5YSAxMDA2NDQKLS0tIGEvdGFyZ2V0L3Jp
c2N2L2dkYnN0dWIuYworKysgYi90YXJnZXQvcmlzY3YvZ2Ric3R1Yi5jCkBAIC0yMTIsOCArMjEy
LDE0IEBAIHN0YXRpYyBpbnQgcmlzY3ZfZ2RiX2dldF92aXJ0dWFsKENQVVN0YXRlICpjcywgR0J5
dGVBcnJheSAqYnVmLCBpbnQgbikKICNlbHNlCiAgICAgICAgIFJJU0NWQ1BVICpjcHUgPSBSSVND
Vl9DUFUoY3MpOwogICAgICAgICBDUFVSSVNDVlN0YXRlICplbnYgPSAmY3B1LT5lbnY7CisgICAg
ICAgIHRhcmdldF91bG9uZyByZXQgPSBlbnYtPnByaXY7CiAKLSAgICAgICAgcmV0dXJuIGdkYl9n
ZXRfcmVnbChidWYsIGVudi0+cHJpdik7CisgICAgICAgIC8qIGluY2x1ZGUgdmlydHVhbGl6YXRp
b24gbW9kZSAqLworCisgICAgICAgIGlmIChlbnYtPnZpcnRfZW5hYmxlZCkgeworICAgICAgICAg
ICAgcmV0IHw9IFBSVl9WOworICAgICAgICB9CisgICAgICAgIHJldHVybiBnZGJfZ2V0X3JlZ2wo
YnVmLCByZXQpOwogI2VuZGlmCiAgICAgfQogICAgIHJldHVybiAwOwpAQCAtMjI1LDExICsyMzEs
MTYgQEAgc3RhdGljIGludCByaXNjdl9nZGJfc2V0X3ZpcnR1YWwoQ1BVU3RhdGUgKmNzLCB1aW50
OF90ICptZW1fYnVmLCBpbnQgbikKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQogICAgICAgICBS
SVNDVkNQVSAqY3B1ID0gUklTQ1ZfQ1BVKGNzKTsKICAgICAgICAgQ1BVUklTQ1ZTdGF0ZSAqZW52
ID0gJmNwdS0+ZW52OworICAgICAgICB0YXJnZXRfdWxvbmcgdmFsID0gbGR0dWxfcChtZW1fYnVm
KTsKIAotICAgICAgICBlbnYtPnByaXYgPSBsZHR1bF9wKG1lbV9idWYpICYgMHgzOworICAgICAg
ICBlbnYtPnByaXYgPSB2YWwgJiAweDM7CiAgICAgICAgIGlmIChlbnYtPnByaXYgPT0gUFJWX1JF
U0VSVkVEKSB7CiAgICAgICAgICAgICBlbnYtPnByaXYgPSBQUlZfUzsKICAgICAgICAgfQorCisg
ICAgICAgIC8qIFVwZGF0ZSB2aXJ0dWFsaXphdGlvbiBtb2RlICovCisKKyAgICAgICAgZW52LT52
aXJ0X2VuYWJsZWQgPSAoZW52LT5wcml2ICE9IFBSVl9NICYmICh2YWwgJiBQUlZfVikgIT0gMCk7
CiAjZW5kaWYKICAgICAgICAgcmV0dXJuIHNpemVvZih0YXJnZXRfdWxvbmcpOwogICAgIH0KLS0g
CjIuMzQuMQoK


--=-K7e02pMMS878C5HgoH4+--


