Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C51FCEE8A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 11:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvDF7-0008AO-2R; Wed, 25 Feb 2026 06:39:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vvDEx-000863-F1
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:39:39 -0500
Received: from qs-2003c-snip4-11.eps.apple.com ([57.103.86.33]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vvDEt-0008Na-Mr
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:39:37 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-8 (Postfix) with ESMTPS id
 DFA0118009C4; Wed, 25 Feb 2026 11:39:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772019570; x=1774611570;
 bh=He53tVLVknMUuhasVxGCzNxBBlTiXUYgGHinnT94OOw=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=ZmVXbQC+2BQ5CJ+fQYkoRFFRYiBaYaGxdxja6hx808Gl3CzJOzTunvgxbYjRk94iPAtnN1ljE+u+kRJmpgmWyreDW1JUvf7bib4HpCjZCYMWxRbjiWQPQYJmPj0rRARKsR0kehh3mWveQaZW0Y2mt4hlWtt7KyEsj9qeEAuQ134vGBQSjieA0323ol1QmHLEAPuVdiIdJgIMrdU4267w9QSRKXjgm2hLkCvgmvLlOi+U+lUqVNlMx/3E1zjYkjmPxscKNyjSwTFXOzXrPkp0r6celLXL8PTqcIv2HUvtZMGYfUKuNmGmhJJYDz7axdXqPNdRWIXq5tp/qi/wcJuyyQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-8 (Postfix) with ESMTPSA id
 E03A11800109; Wed, 25 Feb 2026 11:39:26 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v2 00/16] Add RISC-V big-endian target support
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
Date: Wed, 25 Feb 2026 12:39:14 +0100
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A02120BF-779D-4B2C-B29D-A9CB044EA895@unpredictable.fr>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDExNCBTYWx0ZWRfX16qQDRJhMd0T
 /hBwBkXGf0DZYv1mfMxucAPwCi1Q3Vog6EGw/wriBRXS4ZNJbgtgUIvU7whvYzWH2tjaDQczvxJ
 qUWWWTQWr42nVnpZrnfoDJzBlBwnqKWag8d8qtDpdM0QJKTQg0seK9fLx6xP2rHuQwG1nBkuDuR
 p5fMnoVEb+MUEI5WEhndapJXfh/CJ5WTaugNTWJwZ6wcZJAR1D72rTAf9gPyl5mSKIsplTaPfae
 dip2/Wl+DQz/FJP7rrWLFGKuOgy2cOsXuUQepejRschO4+oY6d1gwoH2bXoEmkU0Y6r6FfhpkFF
 2T8S1SZHmm4oafr2HZe2Gt+dcCXL9gJ5hKkw8sasUg0hjO+VER+wpDfECUABHU=
X-Proofpoint-GUID: XZMMc7uxqRGvOVn98DmeyLFQSVbUyJtp
X-Authority-Info-Out: v=2.4 cv=bPkb4f+Z c=1 sm=1 tr=0 ts=699edf71
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=gPJu0pBYAAAA:8 a=ALku5c8DAAAA:8 a=vQKd5WLVvRtLwYuElykA:9 a=QEXdDO2ut3YA:10
 a=AlIIF0cMT2hfDT4axODj:22 a=Skunnq644UPbuD6fT1yj:22
X-Proofpoint-ORIG-GUID: XZMMc7uxqRGvOVn98DmeyLFQSVbUyJtp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=656
 bulkscore=0 adultscore=0 clxscore=1030 spamscore=0
 phishscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602250114
X-JNJ: AAAAAAABEj9o1BtwdD924VPJeHlSPs7xVPKUQJmx5MOKl4K8s0RiXjg+z2EhQfHSjVU9cn99/GA/Uo5EH+NCJ/IYv48qYu0ViMgA/s7Pir/S8C/MZGPl8SSoz7I1O2sZaE5LOJX+4+FCALV7uWmsRWeAKnZ1E94H+0c+Xz91Q4M9FohVI1kmtSjcHfHojwlyxwm0yosKN//aT/yqtJ4QfT3Ua7U1Q21A8QGUhe/16oVHVoVvLidcmnTRHDpkT19iDhLlKuCoCQNFC6RbU6vIN8YaGJzg91p4akCXwq/x4pM+5gU6rsGznufLzky/jh88Jf7+V94oZ97eAFZDkiJvw6GxiysADCPz76U708/wSkraQJm1/Lu0qcRDLuKSUhtQdfFtzTzGzOOKG8qIMxsVN1bVKF4f/ToOxsomPrJm/utrO3iF6Nkx9X4oCKj3ZLG+82hbgiFFG53fQZfSCZmtitim0WYLDqEQMyHcmmAvwh6McDWuuwIAarq7GXIjpm2cR2ewBOWWbFWwUE1i+jXfo4lyYhoOQwh+/CiW6cAt+w2MAx8CRtQJeVfHeNQaDaVL9dPMhi7ngQZcsfUq93lGxQqc6eqRAEI/ZIEqjyrQylspULR4nMnxTHAnEJ7cIrxvl8CNeOdUXccjOjSr05PALwBI3Hx/BZvRG5LJ0ObX/EVlat72Mk+Us9QZG1eiertSYmc5rwRzcG+sZK5tuBsWzY4kSj3CdbiyguMpiDLP+YAJ28fEFah86EWSmO5dfC1JwX3uGnvcsHRejeoc+Sk=
Received-SPF: pass client-ip=57.103.86.33;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> On 25. Feb 2026, at 11:20, Djordje Todorovic =
<Djordje.Todorovic@htecgroup.com> wrote:
>=20
> This series adds big-endian (BE) RISC-V target support to QEMU,
> covering both softmmu and linux-user emulation for riscv32be and
> riscv64be.
Hello,

There=E2=80=99s no Linux RISC-V big endian. Maybe the right thing to do =
is to not
support it unless we=E2=80=99re sure that it can get to Linux upstream =
(for the linux-user mode)?

Thank you,
-Mohamed=20
>=20
> The RISC-V ISA supports big-endian operation via the mstatus =
SBE/MBE/UBE
> bits. While instructions are always little-endian, data accesses =
follow
> the configured endianness. This series implements the necessary QEMU
> infrastructure.
>=20
> Furthermore, MIPS announced cores with BE configuration:
>  https://mips.com/products/hardware/i8500/
>=20
> Patches 01-03: Build system and config for new BE targets
> Patches 04-07: Core emulation fixes (instruction fetch, boot ROM, ELF
>               loading, fw_dynamic endianness)
> Patches 08-11: Linux-user BE targets and vDSO handling
> Patch  12:     Set SBE/MBE mstatus bits at CPU reset
> Patch  13:     Fix PTE A/D atomic update endianness in page table =
walker
> Patch  14:     Clean up instruction fetch to use MO_LE directly
> Patch  15:     Fix virtio-mmio legacy device register endianness
> Patch  16:     Add riscv32be and riscv64be to SysEmuTarget
>=20
> Djordje Todorovic (9):
>  meson: Add BE RISCV targets
>  config/targets: Add BE RISCV softmmu targets
>  config/devices: Add BE riscv configs
>  target/riscv: Ensure LE instruction fetching
>  hw/riscv: Ensure bootrom has correct endianess
>  hw/riscv: Ensure proper ELF endian expectation
>  hw/riscv: Check endianness for fw_dynamic fields
>  config/targets: Add RISC-V userspace targets
>  arch/riscv: Set UBE bit on BE target
>=20
> djtodoro (7):
>  config/targets: Add missing fields to BE linux-user targets
>  linux-user/riscv: Disable vDSO for big-endian targets
>  target/riscv: Set SBE and MBE bits at CPU reset for BE targets
>  target/riscv: Fix PTE A/D atomic update endianness
>  target/riscv: Use MO_LE for instruction fetch
>  hw/virtio: Use DEVICE_LITTLE_ENDIAN for virtio-mmio legacy ops
>  qapi: Add riscv32be and riscv64be to SysEmuTarget
>=20
> configs/devices/riscv32be-softmmu/default.mak | 15 +++++++
> configs/devices/riscv64be-softmmu/default.mak | 16 ++++++++
> configs/targets/riscv32be-linux-user.mak      | 11 +++++
> configs/targets/riscv32be-softmmu.mak         |  8 ++++
> configs/targets/riscv64be-linux-user.mak      | 11 +++++
> configs/targets/riscv64be-softmmu.mak         |  8 ++++
> hw/riscv/boot.c                               | 41 ++++++++++++++++---
> hw/virtio/virtio-mmio.c                       |  2 +-
> include/hw/riscv/boot.h                       |  5 +++
> linux-user/riscv/target_elf.h                 | 10 ++++-
> meson.build                                   |  7 +++-
> qapi/machine.json                             |  3 +-
> target/riscv/cpu.c                            |  3 ++
> target/riscv/cpu_bits.h                       |  2 +
> target/riscv/cpu_helper.c                     |  9 ++--
> target/riscv/translate.c                      | 16 ++++----
> 16 files changed, 145 insertions(+), 22 deletions(-)
> create mode 100644 configs/devices/riscv32be-softmmu/default.mak
> create mode 100644 configs/devices/riscv64be-softmmu/default.mak
> create mode 100644 configs/targets/riscv32be-linux-user.mak
> create mode 100644 configs/targets/riscv32be-softmmu.mak
> create mode 100644 configs/targets/riscv64be-linux-user.mak
> create mode 100644 configs/targets/riscv64be-softmmu.mak
>=20
> --=20
> 2.34.1
>=20


