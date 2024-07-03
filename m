Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89A4C30658
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 02:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOpqu-00034Q-MS; Tue, 02 Jul 2024 22:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOpqk-00032U-MT; Tue, 02 Jul 2024 22:36:05 -0400
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOpqi-0001Uq-27; Tue, 02 Jul 2024 22:36:01 -0400
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-4f286fe23e1so1520112e0c.2; 
 Tue, 02 Jul 2024 19:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719974158; x=1720578958; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sFDAsskzOsmr5ef990OhQ72z3SPyVigF03mSALRVvEQ=;
 b=k5EHe41Qi0gRD2ntnI4+godcIaLN0lPWPqv3ACMWIW3W81yYT/NL5B92+L4XJlH9Dh
 MemNdBo/2zkZzkX9EvehddkbcQ5A6p4igc1vd3LmJRQQePoVP08V3cAGBokIKG0KH22L
 qVhM/G97i8osjixcwuFHq1MnYtURtEVr+NcHY9ptNVwkI6rXTTvqu0sMf0eeT5dCutRs
 syjocb+go5Ee9yqE2dZAecu604XZgcuW92XpTGB6srCghIni1SLBSjHkSg1f+sT1feZU
 OMnHoKcL9EFlySu1tbDxdVo2feA+K3HYJufz+Nb5r3gHoAA1Gbysu8f0OgRv2miQY1MG
 L+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719974158; x=1720578958;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sFDAsskzOsmr5ef990OhQ72z3SPyVigF03mSALRVvEQ=;
 b=OMBG9fvlS1i/7/zmgOfcXrD7OsMRQQqpROa3NyMYRs2n2/fmGH3nzNgMMZS7MEEBtC
 rYipUBnXi1hWCJl4ZViFzcOD9vNElE+sCywnfjKW5lb+pWS4AFEXKT6Vn6m0QU360ALG
 09YFQ0hkAkH5E9zAwI30bPJFoAz2s4j927rSCqAbpr3G0AO21Jr5JW3RC9ZTNHs0MuTx
 t0Rmiz/MLLkJeyOwm6yv/dE9mrzY+S3OCJBjXQXBdVQbLzgFdjlHRSMvo87QnPvfzXv8
 iGUYrK2OeEvD0NDzRtpYJapBuh8PkDi6nUI6xPFTsD/nYSnw2Y21RNILGP4TI8i0kvEP
 sp/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwMGj1Zu7cbpd+Cy5PtD1sI5TH4mF2HnNB/sa/1jvWaBo3OycFxuEd4VhbaQgo+DokDbfWI66PvUQRZXtmHr3JQxb+g2Yt22a5ct5Obh8oYgNfN/6PrD1fD8+Bpw==
X-Gm-Message-State: AOJu0YwcKGecFIH1UruPaRXBNODkhsEqiiWUKOgklnoH4LqKpDBQzs2S
 znlkAJMN9iNlOHx0882jhQKG1Mb5LFfmyfNM+6gXCmc+jauSMWPGopIMFNccAWX8dNP9KgvUDqO
 DrT9N+bbDQ9KQV1+g95yrgaXPjOo=
X-Google-Smtp-Source: AGHT+IFZuAo45n6J3QNiHLmux8i4DZT7yhSCJOiW83owX5zD4rei2boAlfxp5lKiMNUYHgN/YaBb+QXyvUHgrDNJyp8=
X-Received: by 2002:a05:6122:4888:b0:4ed:14e:9342 with SMTP id
 71dfb90a1353d-4f2a563fb25mr14974432e0c.1.1719974157767; Tue, 02 Jul 2024
 19:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240701033722.954-1-zhiwei_liu@linux.alibaba.com>
 <cad162ba-db4e-4acb-b45e-39053ebb02b0@linaro.org>
In-Reply-To: <cad162ba-db4e-4acb-b45e-39053ebb02b0@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jul 2024 12:35:31 +1000
Message-ID: <CAKmqyKMt16YdS5+Xqab4aqHainwk5rHHQ67b+FA5zZoxDuCAfw@mail.gmail.com>
Subject: Re: [PATCH 0/6] target/riscv: Expose RV32 cpu to RV64 QEMU
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com, 
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com, 
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 3, 2024 at 12:25=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi Zhiwei,
>
> On 1/7/24 05:37, LIU Zhiwei wrote:
> > From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> >
> > This patch set aims to expose 32-bit RISC-V cpu to RV64 QEMU. Thus
> > qemu-system-riscv64 can directly boot a RV32 Linux.
> >
> > This patch set has been tested with 6.9.0 Linux Image.
> >
> > - Run RV64 QEMU with RV32 CPU
> > qemu-system-riscv64 -cpu rv32 -M virt -nographic \
> >      -kernel Image \
> >      -append "root=3D/dev/vda ro console=3DttyS0" \
> >      -drive file=3Drootfs.ext2,format=3Draw,id=3Dhd0 \
> >      -device virtio-blk-device,drive=3Dhd0 -netdev user,id=3Dnet0 \
> >      -device virtio-net-device,netdev=3Dnet0
> >
> > OpenSBI v1.4
> > QEMU emulator version 9.0.50 (v9.0.0-1132-g7799dc2e3b)
> > [    0.000000] Linux version 6.9.0 (developer@11109ca35736) (riscv32-un=
known-linux-gnu-gcc (gc891d8dc23e-dirty) 13.2.0, GNU ld (GNU Binutils) 2.42=
) #3 SMP Fri May 31 08:42:15 UTC 2024
> > [    0.000000] random: crng init done
> > [    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80400000
> > [    0.000000] Machine model: riscv-virtio,qemu
> > [    0.000000] SBI specification v2.0 detected
> > [    0.000000] SBI implementation ID=3D0x1 Version=3D0x10004
> > [    0.000000] SBI TIME extension detected
> > [    0.000000] SBI IPI extension detected
> > [    0.000000] SBI RFENCE extension detected
> > [    0.000000] SBI SRST extension detected
> > [    0.000000] SBI DBCN extension detected
> > [    0.000000] efi: UEFI not found.
> > [    0.000000] OF: reserved mem: 0x80000000..0x8003ffff (256 KiB) nomap=
 non-reusable mmode_resv1@80000000
> > [    0.000000] OF: reserved mem: 0x80040000..0x8004ffff (64 KiB) nomap =
non-reusable mmode_resv0@80040000
> > [    0.000000] Zone ranges:
> > [    0.000000]   Normal   [mem 0x0000000080400000-0x0000000087ffffff]
> > [    0.000000] Movable zone start for each node
> > [    0.000000] Early memory node ranges
> > [    0.000000]   node   0: [mem 0x0000000080400000-0x0000000087ffffff]
> > [    0.000000] Initmem setup node 0 [mem 0x0000000080400000-0x000000008=
7ffffff]
> > [    0.000000] On node 0, zone Normal: 1024 pages in unavailable ranges
> > [    0.000000] SBI HSM extension detected
> > [    0.000000] riscv: base ISA extensions acdfhim
> > [    0.000000] riscv: ELF capabilities acdfim
> > [    0.000000] percpu: Embedded 17 pages/cpu s37728 r8192 d23712 u69632
> > [    0.000000] Kernel command line: root=3D/dev/vda ro console=3DttyS0
> > [    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 =
bytes, linear)
> > [    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 by=
tes, linear)
> > [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 3=
1465
> > [    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap fre=
e:off
> > [    0.000000] Virtual kernel memory layout:
> > [    0.000000]       fixmap : 0x9c800000 - 0x9d000000   (8192 kB)
> > [    0.000000]       pci io : 0x9d000000 - 0x9e000000   (  16 MB)
> > [    0.000000]      vmemmap : 0x9e000000 - 0xa0000000   (  32 MB)
> > [    0.000000]      vmalloc : 0xa0000000 - 0xc0000000   ( 512 MB)
> > [    0.000000]       lowmem : 0xc0000000 - 0xc7c00000   ( 124 MB)
> > [    0.000000] Memory: 95700K/126976K available (9090K kernel code, 884=
5K rwdata, 4096K rodata, 4231K init, 341K bss, 31276K reserved, 0K cma-rese=
rved)
> > ...
> > Welcome to Buildroot
> > buildroot login: root
> > # cat /proc/cpuinfo
> > processor       : 0
> > hart            : 0
> > isa             : rv32imafdch_zicbom_zicboz_zicntr_zicsr_zifencei_zihin=
tntl_zihintpause_zihpm_zfa_zba_zbb_zbc_zbs_sstc
> > mmu             : sv32
>
> Please provide an Avocado test (i.e. checking /proc/cpuinfo
> contains "isa             : rv32"). See for reference
> tests/avocado/boot_linux_console.py.

Awesome! Thanks for this, this is very exciting.

I agree we should add an Avacado test, that way this will be regularly
tested as it's something that seems prone to breakage.

Alistair

>
> Thanks!
>

