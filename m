Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36E6E77188
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 02:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUzkG-0003I6-8U; Mon, 06 Jan 2025 21:55:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUzkE-0003Hn-Sp; Mon, 06 Jan 2025 21:55:03 -0500
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUzk9-0002pp-ND; Mon, 06 Jan 2025 21:55:02 -0500
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-4afdfd3124dso4147860137.2; 
 Mon, 06 Jan 2025 18:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736218496; x=1736823296; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/KFIdI3T+bn+iibb898K5LbeH5VJBBbe6vn22j2kA4=;
 b=RrOykfN24fuFZFOJ2BEAK8QSUpDkBhYgwb25dSQqJqsI8pjwAS/bRODYUnmRHfCOJ0
 9bYKnhdXwjuKbg/dECuN9WGngxjBYkxpBLMMG8LPtqdGnrHbgjp0eP9CRPOocuaZi+oH
 j7PSKdiNasWwbHtTPjiOj6bhP2Blx9R47LuEhDVzysTRaIp9DUvsLDMGv3x4N0bXMpMW
 DSOZXLBZVkF66wAqOAiaKbAR7FA81wrTnN5I4CF8maaj1lBnISwfGYP/a0somm8zsKOS
 8UVo/6SX0Ri4sJfEAcDmnmd9YiSoy/K50Ax+JfrMG4gpl4zqYhDrOtdBb02pgMIw/h3g
 c9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736218496; x=1736823296;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/KFIdI3T+bn+iibb898K5LbeH5VJBBbe6vn22j2kA4=;
 b=Q5tdm+/qwjoTiZU0zZUemDGHeenuoOHrQC8AohUIO1Ck5uU2kXoNqW+F1eEWMN6HBZ
 1i35euqGee63LwcRIqYemcBxUWpMcVOxKb+7wxsiLVzT9XRsBb8ULX8rFLCpZKOVQgzQ
 CjGF06z1zDXlSY1WDkoa2m1BVmc2144Yj3uVt9GZ86QJs7hdH5c7jGeIbzh6gaMR3Zs3
 oUI/RJYoRKBBKrKpgi6HzIILiroI+BFX0JTK9WOseb6r7xbNYDhsroC8C34bAsJH9YRA
 ZbUgkLHO6cnGna5S5hLUDGU6Egz1nr6/a6BmEwKZPbyA+T5kTltyj8XEeJMdXktMbiWk
 Jpzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvT9Zd5Pjw0ICDE7yiVw3jmM72ZL5xbb94pB+/vdtqWtbDSaiB5m4MxaoDlYs0rmbs7bEyHeXQooBA@nongnu.org
X-Gm-Message-State: AOJu0Yzz6Yuu13DCpNrc9SJE1MpRqZeU36t41gVA/kYhzikZvgRLtMUg
 P3PShTTvqdEZxi/6hqOS9E8dl+QyuX8Gt2pNUh7yuDDGJAvxTcnKCuTwRh3KbUZy50IGh7w62MS
 C061cEDt78ZL7FTvtnl1RE8T2uHI=
X-Gm-Gg: ASbGncus4VSgME4nARY37f9GsTUqtRTu2CML81HEV4ci4h+HOGJ0V66iQJqdzWw9qCQ
 u6C1noClik9Xal0m5h4CLycJncriJiIhcN+Kb7YUpVks4Sqi1lpS7U4UWyLkFf7lQx40=
X-Google-Smtp-Source: AGHT+IFwdjhNSXFEm9E/NzaE7xWRj50PqoLSdYtrEg01sZc/6R4gDyQzsApXrJK/L1dxMob+tCgu26qnIIXuWnfJ5jk=
X-Received: by 2002:a05:6102:5122:b0:4af:f892:e9f0 with SMTP id
 ada2fe7eead31-4b2cc387ca7mr45874122137.14.1736218495737; Mon, 06 Jan 2025
 18:54:55 -0800 (PST)
MIME-Version: 1.0
References: <20250106054336.1878291-1-frank.chang@sifive.com>
In-Reply-To: <20250106054336.1878291-1-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 7 Jan 2025 12:54:29 +1000
X-Gm-Features: AbW1kvYcKsppGOJsgK1oTrqck2K4gILhttfM8DzZgNwDxdgUb9hEqKcn9mAO1Mg
Message-ID: <CAKmqyKOtJ6gHgEzKt5K8py32owQPey_kVTn3qT1Uz85gJUS=ZA@mail.gmail.com>
Subject: Re: [PATCH v12 0/6] Add Smrnmi support
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2e;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2e.google.com
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

On Mon, Jan 6, 2025 at 3:46=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> This patchset added support for Smrnmi Extension in RISC-V.
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
> [2] https://github.com/sifive/qemu/tree/upstream-smrnmi-v12
> [3] https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06232.html
>
> Test commands :
> $ ./build/qemu-system-riscv64 -M virt -cpu rv64,smrnmi=3Dtrue,
> rnmi-interrupt-vector=3D{Offset of the RNMI handler in the customized
> OpenSBI.} -m 4G -smp 2 -serial mon:stdio -serial null -nographic
> -bios fw_jump.elf -kernel Image -initrd rootfs.cpio
> -qmp unix:/tmp/qmp-sock,server,wait=3Doff
>
> Use qmp command to inject the RNMI.
>
> Assert RNMI:
> $ ./scripts/qmp/qmp-shell /tmp/qmp-sock
> (QEMU) gpio-set path=3D/machine/soc0/harts[0] gpio=3Driscv.cpu.rnmi numbe=
r=3D0 value=3Dtrue
>
> De-assert RNMI:
> (QEMU) gpio-set path=3D/machine/soc0/harts[0] gpio=3Driscv.cpu.rnmi numbe=
r=3D0 value=3Dfalse
>
> Changelog:
>
> v12
>   * Replace TARGET_LONG_BITS with MXL.
>   * Add log to inform user that Smrnmi is disabled in the 'max' type CPU.
>   * Rebase to riscv-to-apply.next.
>
> v11
>   * Squash patch 7 into patch 5.
>   * Remove "DEFINE_PROP_END_OF_LIST()" from "riscv_harts_props[]" for
>     the upcoming "DEFINE_PROP_END_OF_LIST()" removal.
>
> v10
>   * Disable Smrnmi for the 'max' type CPU.
>
> v9
>   * Add Zicfilp support for Smrnmi.
>   * Change the existence checks for 'rnmi-interrupt-vector' and
>     'rnmi-exception-vector' to use 'num_rnmi_irqvec' and 'num_rnmi_excpve=
c'.
>   * Add warn_once messages for cases where the user sets
>     'rnmi-interrupt-vector' or 'rnmi-exception-vector' property without
>     enabling Smrnmi.
>
> v8
>   * Set virt to false when trapping to M-mode by RNMI.
>   (Thanks to Cl=C3=A9ment for the suggestions.)
>
> v7
>   * Rename 'nmi_execp' to 'nnmi_excep' and refactor RNMI exception
>     checking codes.
>   (Thanks to Cl=C3=A9ment for the suggestions.)
>   * Add the missing REQUIRE_SMRNMI() check and remove the redundant
>     check in 'helper_mnret'.
>   * Rebase to riscv-to-apply.next.
>   (Thanks to Alistair for the suggestions.)
>
> v6
>   * Delete the redundant code in 'riscv_cpu_do_interrupt'.
>   (Thank Alvin for the suggestion.)
>   * Split the shared code in 'helper_mret' and 'helper_mnret' into a
>     helper function 'check_ret_from_m_mode'.
>   (Thank Alistair for the suggestion.)
>
> v5
>   * Move the patch that adds the Smrnmi extension to the last patch.
>   (Thank Alistair for the suggestion.)
>   * Implement an M-mode software PoC for this with implemented handlers.
>   (Thank Andrew Jones for the suggestion.)
>   * Add a commit message to all patches of the series.
>   (Thank Andrew Jones for the suggestion.)
>
> v4
>   * Fix some coding style issues.
>   (Thank Daniel for the suggestions.)
>
> v3
>   * Update to the newest version of Smrnmi extension specification.
>
> v2
>   * split up the series into more commits for convenience of review.
>   * add missing rnmi_irqvec and rnmi_excpvec properties to riscv_harts.
>
> Frank Chang (1):
>   target/riscv: Add Zicfilp support for Smrnmi
>
> Tommy Wu (5):
>   target/riscv: Add 'ext_smrnmi' in the RISCVCPUConfig
>   target/riscv: Add Smrnmi CSRs
>   target/riscv: Handle Smrnmi interrupt and exception
>   target/riscv: Add Smrnmi mnret instruction
>   target/riscv: Add Smrnmi cpu extension

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  hw/riscv/riscv_hart.c                         | 41 ++++++++
>  include/hw/riscv/riscv_hart.h                 |  4 +
>  target/riscv/cpu.c                            | 18 ++++
>  target/riscv/cpu.h                            | 10 ++
>  target/riscv/cpu_bits.h                       | 24 +++++
>  target/riscv/cpu_cfg.h                        |  1 +
>  target/riscv/cpu_helper.c                     | 99 +++++++++++++++++--
>  target/riscv/csr.c                            | 82 +++++++++++++++
>  target/riscv/helper.h                         |  1 +
>  target/riscv/insn32.decode                    |  3 +
>  .../riscv/insn_trans/trans_privileged.c.inc   | 20 ++++
>  target/riscv/op_helper.c                      | 54 +++++++++-
>  target/riscv/tcg/tcg-cpu.c                    |  9 ++
>  13 files changed, 353 insertions(+), 13 deletions(-)
>
> --
> 2.34.1
>
>

