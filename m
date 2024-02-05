Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91826C48295
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 13:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWz9B-00047n-Ew; Mon, 05 Feb 2024 08:36:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexghiti@rivosinc.com>)
 id 1rWz93-00047P-Cr
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 08:36:21 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexghiti@rivosinc.com>)
 id 1rWz90-0005TA-PQ
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 08:36:21 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56003c97d98so2914729a12.3
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 05:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707140177; x=1707744977;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b0ZtVQORBrD8LLr5A8rIcUnxyVikBQjEvTyWZZdZ1m4=;
 b=hYQrypoN9fMcDE07DQ552Eu/j396ceQEAwesLsPeYvy+Oe1/rWt4jGxovrNYQDn8wD
 0FR0xAo2JnaxugTHxadkBdRVYNiGTH+ZwOqhnBWUK8qNnKYd8yfrlruN2eo4QcMb3tr2
 UxoUrWnytu6HdrU0RuNIQF2Vfm9fkRsHyD7gICM/XovUvjXPW42AmeZoRTJjZXtLXxj+
 36aRzMVa3d0nV+tcZCvTgliiA81rxkaJoQYYcrATGrCKGFZmgjIc+yjEzxg3v9bUgqbu
 iWUfFnvwWeqqNp6SIIx3umWfMSQkHGnEiJ/BZz85t8VUn9lRRdsq4f1L+Hs/KV1FmuJd
 cL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707140177; x=1707744977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b0ZtVQORBrD8LLr5A8rIcUnxyVikBQjEvTyWZZdZ1m4=;
 b=c7sYwmWOhYVp/Q+N/AQiOFKG2fNUIQmwyBqwptcXzvX0pEhGK/muVJuBgCBjDPxS/v
 ubYr1e5NGdtsnjx6QyKgPsjzlnDVOgOV5mWO0Xl2L/C6yE//o+hlKHB5IkOGPMui+sYi
 8oLrj0Fv50u/TZ7zrt2ysf3OZOzz8b4+uOBCzAbcpDO+4D+R977Jb+RQxc8A9SrBqWB/
 Dy3PJqdh9anqWHkshBd4r9RrKt/J2Q0Ra3HuvfPd4BjGBy1rqgebCjr5RI3xrwN+mT7X
 SVYKf6PlN550zwZwvKX1NxtMQ6uMjFepqsQsRfMGj1wsia+RqqbwGMhcLuIuR+34xsfJ
 Qzbg==
X-Gm-Message-State: AOJu0YxOAVTl4yS6YbCNmPOeHgglMLTTD+4jPuDVrrqx7VWR7kFliqCj
 mv4fqf/EkqojUv3F8NMyXbkJUDye53cn+/KRj073RfN71XilbS4j5hT4tuCJIct6WqVrZXlA8w3
 Vh7N0EUd+4s8pu2idi+kzJ8y36GQzG6BpMF0jrg==
X-Google-Smtp-Source: AGHT+IE6x8fHQdR1GfMFQU6okvCqQbJDJ2987FIEFAahkQrD5eFr9UfGCJ2ODOxdz1V23SukRixf60iGGYF5BzWUjtQ=
X-Received: by 2002:a05:6402:1847:b0:560:3a3:0 with SMTP id
 v7-20020a056402184700b0056003a30000mr5424585edy.30.1707140176782; Mon, 05 Feb
 2024 05:36:16 -0800 (PST)
MIME-Version: 1.0
References: <20240205070040.367541-1-alexghiti@rivosinc.com>
 <624964b1-d0e7-42b2-b4c2-690107882d01@ventanamicro.com>
In-Reply-To: <624964b1-d0e7-42b2-b4c2-690107882d01@ventanamicro.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Mon, 5 Feb 2024 14:36:05 +0100
Message-ID: <CAHVXubicir4xetoFxmESNW=jjM7gUrkwwaeLyEiSGrB7m1nyTQ@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alexghiti@rivosinc.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Feb 5, 2024 at 1:17=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 2/5/24 04:00, Alexandre Ghiti wrote:
> > Currently, the initrd is placed at 128MB, which overlaps with the kerne=
l
> > when it is large (for example syzbot kernels are). From the kernel side=
,
> > there is no reason we could not push the initrd further away in memory
> > to accomodate large kernels, so move the initrd at 512MB when possible.
>
> typo: accommodate
>
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
>
> Patch looks good - just tested with an Ubuntu guest and nothing bad happe=
ned.
>
> But I wonder ... what if there's an even bigger kernel we have to deal wi=
th?
> Move initrd even further away to fit it in?
>
> Instead of making assumptions about where initrd starts, we could grab th=
e kernel
> size loaded in the board and use it as a reference. This would be done by=
 storing
> the return of load_elf_ram_sym/load_uimage_as/load_image_targphys_as from
> riscv_load_kernel() an passing as argument to riscv_load_initrd().
>
> initrd start would then be:
>
>      start =3D kernel_entry + MIN(mem_size / 2, kernel_size);
>
> However, I believe we would like to keep the existing 128Mb minimum initr=
d start,
> even if the kernel is smaller than 128Mb, to avoid breaking existing conf=
igs that
> might be making this assumption. initrd start would then become:
>
>
>      start =3D kernel_entry + MIN(mem_size / 2, MAX(kernel_size, 128 * Mi=
B));

Great, I agree with you, thanks for the pointers. I'll just align the
size on a 2MB boundary to make sure the kernel mapping (which in the
case of Linux uses PMD) does not overlap with the initrd.

I'll get back soon with a v2.

Thanks again,

Alex

>
>
>
> Thanks,
>
>
>
> Daniel
>
>
> >   hw/riscv/boot.c | 12 ++++++------
> >   1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> > index 0ffca05189..9a367af2fa 100644
> > --- a/hw/riscv/boot.c
> > +++ b/hw/riscv/boot.c
> > @@ -188,13 +188,13 @@ static void riscv_load_initrd(MachineState *machi=
ne, uint64_t kernel_entry)
> >        * kernel is uncompressed it will not clobber the initrd. However
> >        * on boards without much RAM we must ensure that we still leave
> >        * enough room for a decent sized initrd, and on boards with larg=
e
> > -     * amounts of RAM we must avoid the initrd being so far up in RAM
> > -     * that it is outside lowmem and inaccessible to the kernel.
> > -     * So for boards with less  than 256MB of RAM we put the initrd
> > -     * halfway into RAM, and for boards with 256MB of RAM or more we p=
ut
> > -     * the initrd at 128MB.
> > +     * amounts of RAM, we put the initrd at 512MB to allow large kerne=
ls
> > +     * to boot.
> > +     * So for boards with less than 1GB of RAM we put the initrd
> > +     * halfway into RAM, and for boards with 1GB of RAM or more we put
> > +     * the initrd at 512MB.
> >        */
> > -    start =3D kernel_entry + MIN(mem_size / 2, 128 * MiB);
> > +    start =3D kernel_entry + MIN(mem_size / 2, 512 * MiB);
> >
> >       size =3D load_ramdisk(filename, start, mem_size - start);
> >       if (size =3D=3D -1) {

