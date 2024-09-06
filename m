Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E98CE7AA5
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 00:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smMz7-0005qK-65; Thu, 05 Sep 2024 20:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smMz5-0005pF-Ha; Thu, 05 Sep 2024 20:37:55 -0400
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smMz3-0002pd-L9; Thu, 05 Sep 2024 20:37:55 -0400
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-846c4ec2694so396496241.2; 
 Thu, 05 Sep 2024 17:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725583072; x=1726187872; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3+xNjAn91Ueo4S583R+CIb7sndFPRhjqXF34qAaLuSg=;
 b=D+XJiD8iXM6x7/ydo7DeMcuY6wymrVJ49cYySybOFweOWmj8GMh3exHPa2TlDCGASR
 BfeZ8z0aYQ8RAfzfwCu8U/ZBMu0G5TVkpZu15xXjaBzx6hl1jzFLL+KvW8PbovCKr1DR
 PD4yfDDu/gJGty5LJFw5SGgLVWp+8lQcI3EjcIZ578xhOJRNUJ2K8WYGFpQEVGbXT7B+
 UhLbQbujrSonwF4a20gwGR/2YH8TtG1HXUdIRLBfHTw2yCIhRlKK839EjzLAPzfzzF0J
 V0rBpSZqn29eQx4spOjFJdFB6RtNAfcBvh/5KsP4xg94AkmoCJZf8W6f1hYqRlzCNnbv
 VHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725583072; x=1726187872;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3+xNjAn91Ueo4S583R+CIb7sndFPRhjqXF34qAaLuSg=;
 b=NVFoR0HLXDFP2llgfNKMXYLUX744bk4tzwlTwOssT/NnJwwe2UBD7bNqJDvtZ8QBFw
 csg+QIqAbdL98CVww/nrym6gS6Ab+76iJytHEEBj1m7O90AV+oGkdL/9rJGhR8VBRSwC
 q2Cb6WV9Lk7m0C/ePl4hHIc1MxVpzuS/eifHDHaYcQnFIxBinyLjWO8BF8sWFDbzqNwA
 U6OcnoNnSp4795iNm/oQU3hguH6r01bkkFAgGxV94NM+VUVsDv/2Crdl/iG/l8EzVaHh
 uDSuJv7WwsDzAC0NApT75donPTdyyFi+ULSc4Uqg1r7iMYUTF6A8qlsMclBtxhTjpR+H
 6Nkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV81iwmtDX5VCzUf1NVk1TvpIt8qMpV4DkgQPlUdQOf2gLwTXMrlcOEAYbSxctq2F8ckOTiDSuz9odC@nongnu.org
X-Gm-Message-State: AOJu0YzHdD+fn4ISMC1Zyr78XFDUYR8HRpLsLAMnPXCoaCTdkTgpxnCz
 qQmbCkozpKsZqzDssShxyHVStOkdhR++j9OPBbxqmdmAWuUbk6WyUjkcxrW8d3hgutBdULiRnBV
 IpGmH6bT4YHSVbEisBkN/Lum3rG8=
X-Google-Smtp-Source: AGHT+IFEfvhQqrjl1bsmWGFyZgfAVdgmonoqOEiHT4mayW00syDWf7RbFBjYKchcXhayO4ALKvfHMayYYA8PTS+Mvm8=
X-Received: by 2002:a05:6102:370e:b0:48f:e111:4ee1 with SMTP id
 ada2fe7eead31-49bde2f487cmr1319655137.28.1725583071631; Thu, 05 Sep 2024
 17:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240902071358.1061693-1-tommy.wu@sifive.com>
In-Reply-To: <20240902071358.1061693-1-tommy.wu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 6 Sep 2024 10:37:25 +1000
Message-ID: <CAKmqyKPEsmYUYN0-tbQCpx84qoZSWy3pFrVt9vmhoV1UMSAO3w@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] target/riscv: Add Smrnmi support.
To: Tommy Wu <tommy.wu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, frank.chang@sifive.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com, 
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Sep 2, 2024 at 5:14=E2=80=AFPM Tommy Wu <tommy.wu@sifive.com> wrote=
:
>
> This patchset added support for Smrnmi Extension in RISC-V.

Thanks!

Can you please include a link to the exact spec version used for this?

We have had issues where there are multiple conflicting ratified
versions of a spec, so we are trying to be explicit in the cover
letter about exactly what version is supported

The exact commit from `src/rnmi.adoc` or ideally a tagged release of
the spec would be great

Alistair

>
> There are four new CSRs and one new instruction added to allow NMI to be
> resumable in RISC-V, which are:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   * mnscratch (0x740)
>   * mnepc     (0x741)
>   * mncause   (0x742)
>   * mnstatus  (0x744)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   * mnret: To return from RNMI interrupt/exception handler.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> RNMI also has higher priority than any other interrupts or exceptions
> and cannot be disabled by software.
>
> RNMI may be used to route to other devices such as Bus Error Unit or
> Watchdog Timer in the future.
>
> The interrupt/exception trap handler addresses of RNMI are
> implementation defined.
>
> If anyone wants to test the patches, we can use the customized OpenSBI[1]=
,
> and the customized QEMU[2].
>
> We implemented a PoC RNMI trap handler in the customized OpenSBI.
> In the customized QEMU, we use the Smrnmi patches and the patch from
> Damien Hedde[3]. The patch from Damien Hedde can be used to inject
> the RNMI signal with the qmp command.
>
> [1] https://github.com/TommyWu-fdgkhdkgh/opensbi/tree/dev/twu/master
> [2] https://github.com/TommyWu-fdgkhdkgh/qemu/tree/dev/twu/master
> [3] https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06232.html
>
> Test commands :
> $ ./build/qemu-system-riscv64 -M virt -cpu rv64,smrnmi=3Dtrue,
> rnmi-interrupt-vector=3D{Offset of the RNMI handler in the customized
> OpenSBI.} -m 4G -smp 2 -serial mon:stdio -serial null -nographic
> -bios fw_jump.elf -kernel Image -initrd rootfs.cpio
> -qmp unix:/tmp/qmp-sock,server,wait=3Doff
>
> Use qmp command to inject the RNMI interrupt.
> $ ./scripts/qmp/qmp-shell /tmp/qmp-sock
> (QEMU)  gpio-set path=3D/machine/soc0/harts[0] gpio=3Driscv.cpu.rnmi
> number=3D0 value=3Dtrue
>
> (QEMU)  gpio-set path=3D/machine/soc0/harts[0] gpio=3Driscv.cpu.rnmi
> number=3D0 value=3Dfalse
>
> Changelog:
>
> v6
>   * Delete the redundant code in `riscv_cpu_do_interrupt`.
>   ( Thank Alvin for the suggestion. )
>   * Split the shared code in `helper_mret` and `helper_mnret` into a
>     helper function `check_ret_from_m_mode`.
>   ( Thank Alistair for the suggestion. )
>
> v5
>   * Move the patch that adds the Smrnmi extension to the last patch.
>   ( Thank Alistair for the suggestion. )
>   * Implement an M-mode software PoC for this with implemented handlers.
>   ( Thank Andrew Jones for the suggestion. )
>   * Add a commit message to all patches of the series.
>   ( Thank Andrew Jones for the suggestion. )
>
> v4
>   * Fix some coding style issues.
>   ( Thank Daniel for the suggestions. )
>
> v3
>   * Update to the newest version of Smrnmi extension specification.
>
> v2
>   * split up the series into more commits for convenience of review.
>   * add missing rnmi_irqvec and rnmi_excpvec properties to riscv_harts.
>
> Tommy Wu (5):
>   target/riscv: Add `ext_smrnmi` in the RISCVCPUConfig.
>   target/riscv: Handle Smrnmi interrupt and exception.
>   target/riscv: Add Smrnmi CSRs.
>   target/riscv: Add Smrnmi mnret instruction.
>   target/riscv: Add Smrnmi cpu extension.
>
>  hw/riscv/riscv_hart.c                         | 18 ++++
>  include/hw/riscv/riscv_hart.h                 |  4 +
>  target/riscv/cpu.c                            | 18 ++++
>  target/riscv/cpu.h                            | 10 +++
>  target/riscv/cpu_bits.h                       | 23 ++++++
>  target/riscv/cpu_cfg.h                        |  1 +
>  target/riscv/cpu_helper.c                     | 80 ++++++++++++++++--
>  target/riscv/csr.c                            | 82 +++++++++++++++++++
>  target/riscv/helper.h                         |  1 +
>  target/riscv/insn32.decode                    |  3 +
>  .../riscv/insn_trans/trans_privileged.c.inc   | 12 +++
>  target/riscv/op_helper.c                      | 49 +++++++++--
>  12 files changed, 291 insertions(+), 10 deletions(-)
>
> --
> 2.39.3
>

