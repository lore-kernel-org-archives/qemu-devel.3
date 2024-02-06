Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DDAC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 09:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXHxx-0001Fx-OK; Tue, 06 Feb 2024 04:42:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexghiti@rivosinc.com>)
 id 1rXHxv-0001Fh-Mh
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:42:07 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexghiti@rivosinc.com>)
 id 1rXHxt-0000Gv-I7
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:42:07 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-55f0b2c79cdso6531724a12.3
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 01:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707212523; x=1707817323;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vW1kXf495KS7TjgbMOED8J85PUSQJA+eBXVejU2D75Q=;
 b=GpNM7T3WKTWqu2U0UgZ89IKKmzfDfrrO3OPTcuBGYF6OVxvQtc5LumMked5/0nkiuF
 J4TKAlKsUXVtlrmKpFcouor/z/ZeGmIlp2KMsUvI1e+KSoTGcfD3BspV+t+dn7s1iPMu
 Vq6+/M93ZdEyfIrC7790QXv7lqx6fp7a+g1ipR0WpLleX7IpyiWdJeZtCLKI0e/P3J60
 9DeUXI7+PfLw7azgusW6m4BFddnLCTEUT8MtvR8BBx3ld28XHc5DaBGytg/tAcoTXNtT
 6A3ze1ta8Xv8l9rZ6If7iod8YOnA6XztNwljhyKi8WcBtXPPvhc2rs51BOVs7zt1csqW
 lv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707212523; x=1707817323;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vW1kXf495KS7TjgbMOED8J85PUSQJA+eBXVejU2D75Q=;
 b=pkJHW/MZJ4wv76MEYMKzkjM9GhrWggYlcGGkauKTTpITszas3FLod9+ABdbc+cwu/h
 LDp0bAqUwYGsWoo0vmldcYKNb1v4NGRiojYB13KXpK0aDSuKCeSEjpnU57cd9duaCnmv
 tajTSt09R7gdrvh4eGdt4r2iCm1c0SeguEbGF0D5CIA5r2Hf3nJGhvF4ZZ+3+xc87nzE
 QcDDNCgwt5SFO+twmtUmq050iPmwjffxXQXsQYfOTZ3sGxvVCkSvpfy4/GXmhmpF3PM8
 n0pa7ZpyiLdfEZVwHLDZBEFV88ACwBbwMrvi0R/75IuqQyfSTLUgmhTH9Z/eMBP5uCxR
 ejyg==
X-Gm-Message-State: AOJu0Yxzog/9JgTV9oFQfl01Kmqa1rFZtZGabRIeIb1TDax1sPRADntr
 I7GMH6NG6WyYMYBCAXWT0Hv7fDGmVaBO/XH9mSwRrDFKVVgerKBKB/iT8i9gi6CBqaPxFDN2sAL
 en7OCeOB1hhvOSEuXFJVnn4D+F4h2Ms35/kcESw==
X-Google-Smtp-Source: AGHT+IGfJHXJUSO2hEqm4Tv67On9Dkmzh2Oys2M9EJfcSuJj2cdr/QlRI3HRpJeM+e927+SediLDEYZXeqYKNkWNJbQ=
X-Received: by 2002:a17:906:3e56:b0:a36:71d9:7986 with SMTP id
 t22-20020a1709063e5600b00a3671d97986mr1127324eji.2.1707212523177; Tue, 06 Feb
 2024 01:42:03 -0800 (PST)
MIME-Version: 1.0
References: <20240205070040.367541-1-alexghiti@rivosinc.com>
 <624964b1-d0e7-42b2-b4c2-690107882d01@ventanamicro.com>
 <CAHVXubicir4xetoFxmESNW=jjM7gUrkwwaeLyEiSGrB7m1nyTQ@mail.gmail.com>
In-Reply-To: <CAHVXubicir4xetoFxmESNW=jjM7gUrkwwaeLyEiSGrB7m1nyTQ@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 6 Feb 2024 10:41:52 +0100
Message-ID: <CAHVXubixZe9RfCow7t6Xq4T+62sj7-AGKmwG2K8JZUD2TfFmkA@mail.gmail.com>
Subject: Re: [PATCH] hw: riscv: Allow large kernels to boot by moving the
 initrd further way in RAM
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alexghiti@rivosinc.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Daniel,

On Mon, Feb 5, 2024 at 2:36=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
> Hi Daniel,
>
> On Mon, Feb 5, 2024 at 1:17=E2=80=AFPM Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
> >
> >
> >
> > On 2/5/24 04:00, Alexandre Ghiti wrote:
> > > Currently, the initrd is placed at 128MB, which overlaps with the ker=
nel
> > > when it is large (for example syzbot kernels are). From the kernel si=
de,
> > > there is no reason we could not push the initrd further away in memor=
y
> > > to accomodate large kernels, so move the initrd at 512MB when possibl=
e.
> >
> > typo: accommodate
> >
> > >
> > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > ---
> >
> > Patch looks good - just tested with an Ubuntu guest and nothing bad hap=
pened.
> >
> > But I wonder ... what if there's an even bigger kernel we have to deal =
with?
> > Move initrd even further away to fit it in?
> >
> > Instead of making assumptions about where initrd starts, we could grab =
the kernel
> > size loaded in the board and use it as a reference. This would be done =
by storing
> > the return of load_elf_ram_sym/load_uimage_as/load_image_targphys_as fr=
om
> > riscv_load_kernel() an passing as argument to riscv_load_initrd().

So this does not work because the size returned by
load_image_targphys_as() does not take into account the size of the
BSS sections (and I guess other NOBITS sections) and then we end up
loading the initrd there. I'm a bit surprised though because arm64
does just that https://elixir.bootlin.com/qemu/latest/source/hw/arm/boot.c#=
L1034.
I also tried using the highaddr parameter, but that gives the same
result. We could parse the Image header (a PE header) to get the
"Virtual Size" of the .data section, but I did not find any PE header
parser in qemu, so that would be overkill?

Any idea?

Thanks,

Alex

> >
> > initrd start would then be:
> >
> >      start =3D kernel_entry + MIN(mem_size / 2, kernel_size);
> >
> > However, I believe we would like to keep the existing 128Mb minimum ini=
trd start,
> > even if the kernel is smaller than 128Mb, to avoid breaking existing co=
nfigs that
> > might be making this assumption. initrd start would then become:
> >
> >
> >      start =3D kernel_entry + MIN(mem_size / 2, MAX(kernel_size, 128 * =
MiB));
>
> Great, I agree with you, thanks for the pointers. I'll just align the
> size on a 2MB boundary to make sure the kernel mapping (which in the
> case of Linux uses PMD) does not overlap with the initrd.
>
> I'll get back soon with a v2.
>
> Thanks again,
>
> Alex
>
> >
> >
> >
> > Thanks,
> >
> >
> >
> > Daniel
> >
> >
> > >   hw/riscv/boot.c | 12 ++++++------
> > >   1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> > > index 0ffca05189..9a367af2fa 100644
> > > --- a/hw/riscv/boot.c
> > > +++ b/hw/riscv/boot.c
> > > @@ -188,13 +188,13 @@ static void riscv_load_initrd(MachineState *mac=
hine, uint64_t kernel_entry)
> > >        * kernel is uncompressed it will not clobber the initrd. Howev=
er
> > >        * on boards without much RAM we must ensure that we still leav=
e
> > >        * enough room for a decent sized initrd, and on boards with la=
rge
> > > -     * amounts of RAM we must avoid the initrd being so far up in RA=
M
> > > -     * that it is outside lowmem and inaccessible to the kernel.
> > > -     * So for boards with less  than 256MB of RAM we put the initrd
> > > -     * halfway into RAM, and for boards with 256MB of RAM or more we=
 put
> > > -     * the initrd at 128MB.
> > > +     * amounts of RAM, we put the initrd at 512MB to allow large ker=
nels
> > > +     * to boot.
> > > +     * So for boards with less than 1GB of RAM we put the initrd
> > > +     * halfway into RAM, and for boards with 1GB of RAM or more we p=
ut
> > > +     * the initrd at 512MB.
> > >        */
> > > -    start =3D kernel_entry + MIN(mem_size / 2, 128 * MiB);
> > > +    start =3D kernel_entry + MIN(mem_size / 2, 512 * MiB);
> > >
> > >       size =3D load_ramdisk(filename, start, mem_size - start);
> > >       if (size =3D=3D -1) {

