Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D5EE7717F
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 02:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMHTk-0005Lo-8q; Fri, 13 Dec 2024 21:02:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tMHTi-0005LM-Rm; Fri, 13 Dec 2024 21:01:58 -0500
Received: from out203-205-221-231.mail.qq.com ([203.205.221.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>)
 id 1tMHTd-0005a1-TP; Fri, 13 Dec 2024 21:01:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1734141692; bh=kDLUMkjjzYKh6GiL9pmLN4IOqKgzN2FcvSUdTyQ48ok=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=zm5gWOp6TZrZbJdlFWW7BsJ9mm8xXxF35fuCovAl4zyKHh1DxY59CxbldkeVXeyW/
 rWX77xZp5Nee/Mar/j0iiixNtFu1iV6vsoS3FXzDTrQ4vxvXYsfHsu7niwcea2yFay
 uTNOy2gc24qBScGf411CxdNX9LNBxauOzACybuIM=
Received: from [192.168.1.13] ([220.167.33.182])
 by newxmesmtplogicsvrszc25-0.qq.com (NewEsmtp) with SMTP
 id 5D06E9A; Sat, 14 Dec 2024 10:01:29 +0800
X-QQ-mid: xmsmtpt1734141689tm76lh56s
Message-ID: <tencent_20FAAD91C9BA033D18489DAD01233DCD6B0A@qq.com>
X-QQ-XMAILINFO: NZFlUIrZ4HCZx9fCutvCLLryKEjtOnfziBU53CfbE4adybuTN9CZKluH508FfG
 IL3bDApmYmdMm5oBStPRYQAwKu6WFajrTAXkdf0grtiYRbQLn6xH2tlBCMCtjwvMRVwfwbB7lmhz
 rQK4CtQl8+WVkbCpxAWsYjYPS8IOQM+3c36PjWRXKps0DMB5EzxFFUKYV7GU7L3F7g6rp1PCOIvM
 A725zS0hTpTrXMl8KegibM5Sxm1piIUxcf77rD9xQ1AKWbU+f4VLIdtOqvTcfOF+asm9dcvrDrfi
 Z4bFtFkJBmH5wjicMjpdhiNkhwZe71MFlONxxr7EZyWHSwa1fHX50C9TZjIPMweGgOV1vVqCQ02P
 sjv7FZchyWXfGeEEIFnNlr0Db++ZsdGzC0qbRBVcgWJnYf0bwqjP9POyUuCkkhgUmDc9b8dxiIB8
 H+X3Punt3BX6TswoJeUkX1ginqT7S9rRxgaH208YPA7+6sO/vBum2IeBNFWQ/al9qFmFnkGFRrTA
 KnZDGBnZS8Z3BA9JO+dbHdEhvH+pJ4ZItkggobbZXnr20cxTlKmGG5h8KLyEhHyjEXI7/KtzVXNC
 xvpJgAfKgYXGg+xRspZT+OrUq6OIqPx+1Zs9daD6M9nVfx+gG7arQSIxS7Md0RMIFyYfQk9HBBh9
 LtarZ8EMrnIHiUxebhMDpvvsbmBdl1/lUmz4TJro/IcDWuH/3ep/cK8P9ANvp1JvhHe2fSTTpWcv
 XiMVWhZb9gao/ER9YhtW3dlTw2tn5cP3PPdiKTa4ZXpIJ2jfh4IXo/VjasqgH9oOW+OIPdC+DO7F
 6I8wP5sEciq82P3OfqMUDOye6PIfZed6akLWBS8xE2JtW6mALJlbJaraP2iCRTOKR4RbRIkdCp7Q
 YdvE4HhrVXAuQMPb3idUKEXRSnY6YbPv4lydrAv3Xj2cboXanu7+zHd5QmSV5n9vlpDZyxaclKDo
 XMplPf20785ArpPjJycg==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-OQ-MSGID: <418e65d0dc751130a624a63c0620aa042414a5f9.camel@qq.com>
Subject: Re: [PATCH v3] riscv/gdb: add V bit to priv register
From: Yanfeng Liu <yfliu2008@qq.com>
To: Mario Fleischmann <mario.fleischmann@lauterbach.com>, 
 qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com, alex.bennee@linaro.org
Date: Sat, 14 Dec 2024 10:01:28 +0800
In-Reply-To: <5d28f5aa-bb59-4198-a6ff-495a0ea9a16a@lauterbach.com>
References: <tencent_D006B250779A0740A99BB51DA4A8F95EBF07@qq.com>
 <5d28f5aa-bb59-4198-a6ff-495a0ea9a16a@lauterbach.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.205.221.231; envelope-from=yfliu2008@qq.com;
 helo=out203-205-221-231.mail.qq.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, HELO_DYNAMIC_IPADDR=1.951, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, 2024-12-13 at 10:04 +0100, Mario Fleischmann wrote:
> Hi,
>=20
> apologies for the delayed review; I've just gotten to it now.
>=20
> On 06.12.2024 01:14, Yanfeng Liu wrote:
> > This adds virtualization mode (V bit) as bit(2) of register `priv`
> > per RiscV debug spec v1.0.0-rc3. Checked with gdb-multiarch v12.1.
> >=20
> > Note that GDB may display `INVALID` tag for the value when V bit
> > is set, this doesn't affect accessing to the bit.
> >=20
> > Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
> > ---
> > =C2=A0 target/riscv/gdbstub.c | 7 ++++++-
> > =C2=A0 1 file changed, 6 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> > index c07df972f1..8cc095cda3 100644
> > --- a/target/riscv/gdbstub.c
> > +++ b/target/riscv/gdbstub.c
> > @@ -213,7 +213,10 @@ static int riscv_gdb_get_virtual(CPUState *cs,
> > GByteArray *buf, int n)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RISCVCPU *cpu =
=3D RISCV_CPU(cs);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPURISCVState *e=
nv =3D &cpu->env;
> > =C2=A0=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return gdb_get_regl(buf, en=
v->priv);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Per RiscV debug spec v1.=
0.0 rc3 */
>=20
> Now that rc4 is released, you might also cite "RISC-V Debug
> Specification v1.0.0 rc4".
Okay, will do.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_ulong vbit =3D (env-=
>virt_enabled) ? BIT(2) : 0;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return gdb_get_regl(buf, en=
v->priv | vbit);
> > =C2=A0 #endif
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > @@ -230,6 +233,8 @@ static int riscv_gdb_set_virtual(CPUState *cs, uint=
8_t
> > *mem_buf, int n)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env->priv =
=3D=3D PRV_RESERVED) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 env->priv =3D PRV_S;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->virt_enabled =3D (env-=
>priv =3D=3D PRV_M) ? 0 :
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ((ldtul_p(mem_buf) & BIT(2)) >> 2);
>=20
> Looking at the other places in the source code where virt_enabled is=20
> set, we should also check here if the H extension is active.
> Alternatively, you might also consider using riscv_cpu_set_mode():
>=20
> Message-ID: <20240711-smcntrpmf_v7-v8-1-b7c38ae7b263@rivosinc.com>
> Date: Thu, 11 Jul 2024 15:31:04 -0700
> Subject: [PATCH v8 01/13] target/riscv: Combine set_mode and set_virt=20
> functions.
> From: Atish Patra <atishp@rivosinc.com>
>=20
Thanks for this, I will check both and see what is easier for a QEMU newbie
later.

> >=20
> > =C2=A0 #endif
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return sizeof(ta=
rget_ulong);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> In addition, we need to swap the virtual supervisor registers from the H=
=20
> extension, e.g. vsstatus:
>=20
> "When V=3D1, vsstatus substitutes for the usual sstatus, so instructions=
=20
> that normally read or modify sstatus actually access vsstatus instead."=
=20
> (privileged spec)
>=20
> With the current patch, I was able to read and modify V, but the=20
> registers were not changing:
>=20
> (gdb) info register $priv
> priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x4=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 prv:4 [INVALID]
> (gdb) info register $sstatus
> sstatus=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x200004022=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 8589951010
> (gdb) set $priv =3D 0x0
> (gdb) info register $priv
> priv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 prv:0 [User/Application]
> (gdb) info register $sstatus
> sstatus=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x200004022=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 8589951010
>=20
> Take a look at riscv_cpu_swap_hypervisor_regs() which I believe does the=
=20
> thing we need here. Note that the function is supposed be called before=
=20
> the mode switch.

thanks again, I will check that swapping method and use it before changing =
the v
bit.=20

Regards,
yf



