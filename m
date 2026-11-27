Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C5D606A335
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 22:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=w/1pAmSK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX4E5-000798-T7; Fri, 27 Nov 2026 17:15:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xX4E3-00075a-CC
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 17:15:27 -0500
Received: from ms-2001b-snip6-10.eps.apple.com ([2a01:b747:3002:203::14]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xX4E0-0004zm-KJ
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 17:15:27 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-9 (Postfix) with ESMTPS id
 34CFD18004D2; Fri, 27 Nov 2026 22:15:15 +0000 (UTC)
X-ICL-RepId: 01a21f13-b89e-7199-8336-09699f93c3af
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1795817718; x=1827353718;
 bh=uzI/+yZgwarnR5CMY3hoAe7ieGC49GpvSToOpef7K0E=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=w/1pAmSKEkwkJpoSTH0/h7BqLLSGtZzpa5lk9fFxsAa6nv/sAyO81bK3qwgTmbyGY/mkcs5g0iRx3NUcjv/tQ7kVa8dBuT5bd/FGDD9U3/m5+EjpKsnvDjNiVvpej2bmGt4wRa8B23ycibtvP/Su0vMIgquoEIiJUB4yCXuVWSAgl/oAmlfFYjHv+14KvdzyBKwDFpbu2GoyiPxsV639GpKRkYBjE3EA+fblruPjtSxuH8O7A2p80ajU9VBpCFbr7n4l3/JTBzYItfcd/I45G5X5JY4P9FWK/y+CGCOyYmTczIGf7uSi5e+KcnGDJs1Wjcaf9IYcLt6YInmEnH7nFQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.208.39])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-9 (Postfix) with ESMTPSA id
 3A4FC1800130; Fri, 27 Nov 2026 22:15:14 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH for-12.0 v2 5/5] target/hexagon: dump vector and sys regs
 in cores
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20261127203209.42752-6-brian.cain@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 23:15:01 +0100
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Ani Sinha <anisinha@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <92CF59D1-37E4-4F89-AB96-B332F2DBD64A@unpredictable.fr>
References: <20261127203209.42752-1-brian.cain@oss.qualcomm.com>
 <20261127203209.42752-6-brian.cain@oss.qualcomm.com>
To: Brian Cain <brian.cain@oss.qualcomm.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4OCBTYWx0ZWRfXyyGg6H5PFIfS
 Ji4oQS5t8ng+wsLiRxDJFx5W1tonhTmdYP7bK6zUL0KyxeIw5U4SFoBVGqe08GXZYgfLFxlLaxH
 oPJhKT2mFj7onGLEXy+JaoFMge57p7awQhGreJefmGSfOdwAcUyjWDXdkpcgZd6bq9WoChkAddy
 rldwccE3sMlE/aUzPOppEwkm1VBhbwTzSy3b5JvvaT7q0l08G49KKn/3IUW2uzc8mIAIfI8kCh+
 yuyFAUWK1BBXdV8J7HKmpBXkh7g0XAhA32DayVmVKzASSMU+QMMrMOM3uELo51lYaq8mDshu8nT
 RTfGrRpYGqepAwK/6j6MTYf5mt2F6ZMbkPbPne9H0bopkRB97N6lru+u+3JbOE=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4OCBTYWx0ZWRfX0WQ5FukHs476
 0jMJ78izAa38XkWvlaSdkuYUh76CS7GywhKJtxm2Wn2k/W9iYYgsuO2OhiKPwsebVcfLqoktU+H
 Oc/XvBFMiALWszeozyaKEiVr/b0OkIw=
X-Proofpoint-GUID: OrRxS3qMEtfTbYl2_rpcwO3rVgm6oW4F
X-Authority-Info-Out: v=2.4 cv=b7sncdGx c=1 sm=1 tr=0 ts=6b0a00f4
 cx=c_apl:c_pps:t_out a=kRaGL2Q7qLiahLf3O6OaIA==:117
 a=kRaGL2Q7qLiahLf3O6OaIA==:17 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=fajnDIswKVxD1YtQT70F:22 a=yaxh6YJ_awPas7vOTcGR:22
 a=EUspDBNiAAAA:8 a=Fb1Ib6qTyi3bM7WgitMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: OrRxS3qMEtfTbYl2_rpcwO3rVgm6oW4F
X-JNJ: AAAAAAABAovDeyD9lhI8wW9b2+g1pUkv9pAosak1RDSIgA4WRjmG5ROszEGPJV8CruelMO
 N0a1/UbR7Xtn+T4C/IHtdxiugcvfZ4DxTEMs/2I3rEAzNgxt//1at7jA0OLneMK5ldcnVm
 JoehDs2GFHVmDpT9/ETHnzjbk4fX035gjDKxTN7UFQJpjKc8uokFGY6saLoJ0gB9eQ6Eqe
 J48ZPl2KZ6LcVeIngHeLo1K+UJWMqpPoFe14VWJIP8WpfdYLOghdSDtnwaWZ6mBhoESrnC
 ywz2j/R1mhUmnJ9JxSIl+x5Uoxcb7bJthHFIkNNSJ50Kc5IOhhr776TixhVAzcvpIgRj69
 yS7Rw1Gr/ie+q3pAbKtVZTRd1/CWXE11RkCu93d09h56JLwBxtEfLAP8WZ6MrU+cTnUTKu
 WxtnXOTliHKz2nBquDbP5QDxM6bjfJHaFsp+SI8lNaMFK9loETehRkvPupdVHOUtD0J4Ri
 w9zJ7xExSmO8TOTT2loU0IIS7gfXmwATEqhEzj2jpLpvv/475aLy6jAH+RoMWaaF4U5V13
 aR35F9OyOom1TRIDHs15ZqOiXM6x5HtEBQbrCEtJXHYP6gIlwsQ3KcGzG5l1NRuuRev2BY
 dy2MlJbR5lmdKv5+dt5fNqNTEw2WAMdLFiKuwBD3Yzmak8TAZ6uEKFqmAs5GDeVYtkatMa
 Y2uQzXDvxwNdJKRQwjVFvoJ87VydjMS36k366UhMD5j7J9M7PU7e+qxcl22mRn9f3o0gxN
 ecaU4pqD1y5u0g2mWytSnixe1N49Pk1k7uPHaBmC2FeNMgef/GY7dwc6SV6S9sI51ntxW4
 3iSs5HghIFFHYmDcztgiTUCRwohgTQsO2Wv1rrBl3v3/kVvxctv3XZAyxYin3ga/JH01M7
 PU3b7Wv1ZKfxopPSb3kbwb42meZPxc/s3sRztiSEC24RoFk5V5vyljchjlGSXwBjjgutcW
 PL4C+3rOy66G4sBP7JZ0M+WMm5g6Wr+n5GNyaXvw2GspEh7VDku5e7xWsjvMeTLBRMa1ES
 t1OM62BQLI9BKvL3HEhznDT1aAXhcmVFwVefcfij5S67xGGAK2Nowd5f4YZ+DLNUZjWrEX
 YBKlbETe9I1X6jL1xrSscrZMxeewD637hgrytuokVaGSoKiDQrPLVfO3PAKMypoW2KzPJd
 nxzOq1VfQX/3zVKAXbQn8hWr8+R5mHIB9HfLqctVMssMIQ8UZDwm+MY1z7M1s4IQjGUSNS
 ZYj4Z8kl97Hb6b3mC1VJsGp4hT/yPzj+UYL7IGBW2D7ENtvVh2Ex0/z9dLDCkHwVzZDyNn
 zBwkFpusM2GMKrbp1L5RtWa8SnHaB+KPpT+GVB1lf4yLQIBtOjAcjrrUOcCJXiAWudkGji
 IuMJL0AaNsjlWEMak/TtdO8tPLWjqWNaIdvmwcWTHErOqSdrAJ9oBkBAJqJ20nHH60VdW2
 NnnUbe5rdmG+GdF2j/eQR4DDG3FIlCer5co+929hVK+2+sLbhs
Received-SPF: pass client-ip=2a01:b747:3002:203::14;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 27. Nov 2026, at 21:32, Brian Cain <brian.cain@oss.qualcomm.com> =
wrote:
>=20
> Add the HVX/HLX and system states to the core file as notes.


> HMX has no architectural state that software can read directly,
> so it is omitted.

Hi,

That bit doesn=E2=80=99t look like a great idea.

I mean it does have 3 sets of registers including the accumulate =
registers, and
not having those be part of the debug dump is a bit special.

Ideally, the core file ought to be a snapshot that could be (presumably) =
resumed
from, and this would be the opposite of that.

>=20
> The global registers and the TLB are the same for every thread.  They =
are
> repeated in each thread's notes so that a thread's notes are
> self-contained.
>=20
> Reviewed-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
> linux-user/hexagon/target_elf.h |   1 +
> target/hexagon/core-dump.h      |  16 +++
> target/hexagon/cpu.h            |   2 +-
> linux-user/hexagon/elfload.c    |  10 ++
> target/hexagon/arch_dump.c      |  23 ++-
> target/hexagon/core_notes.c     | 243 ++++++++++++++++++++++++++++++++
> target/hexagon/cpu.c            |   4 +-
> target/hexagon/meson.build      |   1 +
> 8 files changed, 294 insertions(+), 6 deletions(-)
> create mode 100644 target/hexagon/core_notes.c
>=20
> diff --git a/linux-user/hexagon/target_elf.h =
b/linux-user/hexagon/target_elf.h
> index daaec521a76..73d4c1e815f 100644
> --- a/linux-user/hexagon/target_elf.h
> +++ b/linux-user/hexagon/target_elf.h
> @@ -26,6 +26,7 @@
> #include "target/hexagon/core-dump.h"
>=20
> #define HAVE_ELF_CORE_DUMP      1
> +#define HAVE_ELF_CORE_EXTRA_NOTES 1
> #define elf_core_eflags(info)   ((info)->elf_flags)
>=20
> typedef HexagonUserRegs target_elf_gregset_t;
> diff --git a/target/hexagon/core-dump.h b/target/hexagon/core-dump.h
> index a14b495d04d..b0f7bf38d5d 100644
> --- a/target/hexagon/core-dump.h
> +++ b/target/hexagon/core-dump.h
> @@ -34,6 +34,22 @@ typedef struct target_elf_gregset_t {
>=20
> QEMU_BUILD_BUG_ON(sizeof(HexagonUserRegs) !=3D 48 * sizeof(uint32_t));
>=20
> +#define HEXAGON_CORE_NOTE_OWNER "QEMU"
> +#define HEXAGON_CORE_NOTE_VERSION 1
> +
> +enum {
> +    HEXAGON_NT_CTRL =3D 0x100,
> +    HEXAGON_NT_HVX =3D 0x101,
> +    HEXAGON_NT_HLX =3D 0x102,
> +    HEXAGON_NT_SYSREGS =3D 0x103,
> +    HEXAGON_NT_THREAD =3D 0x104,
> +    HEXAGON_NT_TLB =3D 0x105,
> +};
> +
> +size_t hexagon_core_notes_size(const CPUHexagonState *env);
> +
> +void hexagon_core_fill_notes(void *buf, const CPUHexagonState *env);
> +
> static inline void hexagon_core_copy_regs(HexagonUserRegs *regs,
>                                           const CPUHexagonState *env)
> {
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index 5739254f1f6..074e46d2a96 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -283,7 +283,7 @@ G_NORETURN void =
hexagon_raise_exception_err(CPUHexagonState *env,
>  * not stopped.
>  */
> bool hexagon_thread_is_enabled(const CPUHexagonState *thread_env);
> -uint32_t hexagon_greg_read(CPUHexagonState *env, uint32_t reg);
> +uint32_t hexagon_greg_read(const CPUHexagonState *env, uint32_t reg);
> void hexagon_greg_write(CPUHexagonState *env, uint32_t reg, uint32_t =
val);
> void hexagon_cpu_soft_reset(CPUHexagonState *env);
> #endif
> diff --git a/linux-user/hexagon/elfload.c =
b/linux-user/hexagon/elfload.c
> index dac8260b302..46232bae5d7 100644
> --- a/linux-user/hexagon/elfload.c
> +++ b/linux-user/hexagon/elfload.c
> @@ -11,6 +11,16 @@ void elf_core_copy_regs(target_elf_gregset_t *regs, =
const CPUHexagonState *env)
>     hexagon_core_copy_regs(regs, env);
> }
>=20
> +size_t elf_core_extra_notes_size(const CPUHexagonState *env)
> +{
> +    return hexagon_core_notes_size(env);
> +}
> +
> +void elf_core_fill_extra_notes(void *buf, const CPUHexagonState *env)
> +{
> +    hexagon_core_fill_notes(buf, env);
> +}
> +
> abi_ulong get_elf_hwcap(CPUState *cs)
> {
>     HexagonCPUClass *mcc =3D HEXAGON_CPU_GET_CLASS(cs);
> diff --git a/target/hexagon/arch_dump.c b/target/hexagon/arch_dump.c
> index c1b2892e2ad..50911503cd9 100644
> --- a/target/hexagon/arch_dump.c
> +++ b/target/hexagon/arch_dump.c
> @@ -38,18 +38,29 @@ typedef struct HexagonElfNote {
> int hexagon_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState =
*cs,
>                                  int cpuid, DumpState *s)
> {
> +    CPUHexagonState *env =3D cpu_env(cs);
>     HexagonElfNote note =3D { 0 };
>     HexagonUserRegs regs;
> +    g_autofree void *extra =3D NULL;
> +    size_t extra_size =3D hexagon_core_notes_size(env);
> +    int ret;
>=20
>     note.header.n_namesz =3D cpu_to_dump32(s, sizeof("CORE"));
>     note.header.n_descsz =3D cpu_to_dump32(s, sizeof(note.prstatus));
>     note.header.n_type =3D cpu_to_dump32(s, NT_PRSTATUS);
>     memcpy(note.name, "CORE", sizeof("CORE"));
>     note.prstatus.pr_pid =3D cpu_to_dump32(s, cpuid);
> -    hexagon_core_copy_regs(&regs, cpu_env(cs));
> +    hexagon_core_copy_regs(&regs, env);
>     memcpy(&note.prstatus.pr_reg, &regs, sizeof(regs));
>=20
> -    return f(&note, sizeof(note), s);
> +    ret =3D f(&note, sizeof(note), s);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    extra =3D g_malloc(extra_size);
> +    hexagon_core_fill_notes(extra, env);
> +    return f(extra, extra_size, s);
> }
>=20
> void hexagon_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
> @@ -67,7 +78,13 @@ void hexagon_get_dump_info(const CPUState *cs, =
ArchDumpInfo *info,
> size_t hexagon_get_note_size(const CPUState *cs, int class, int =
machine,
>                              int nr_cpus)
> {
> -    return sizeof(HexagonElfNote) * nr_cpus;
> +    CPUState *cpu;
> +    size_t size =3D 0;
> +
> +    CPU_FOREACH(cpu) {
> +        size +=3D sizeof(HexagonElfNote) + =
hexagon_core_notes_size(cpu_env(cpu));
> +    }
> +    return size;
> }
>=20
> static bool hexagon_mapping_overlaps(const MemoryMappingList *list,
> diff --git a/target/hexagon/core_notes.c b/target/hexagon/core_notes.c
> new file mode 100644
> index 00000000000..848c2ed1ebe
> --- /dev/null
> +++ b/target/hexagon/core_notes.c
> @@ -0,0 +1,243 @@
> +/*
> + * Hexagon ELF core dump notes owned by "QEMU".
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "hw/hexagon/hexagon_hlx.h"
> +#include "mmvec/mmvec_qfloat.h"
> +#ifndef CONFIG_USER_ONLY
> +#include "hw/hexagon/hexagon_globalreg.h"
> +#include "hw/hexagon/hexagon_tlb.h"
> +#include "cpu_helper.h"
> +#endif
> +#include "core-dump.h"
> +
> +typedef struct NoteCursor {
> +    uint8_t *buf;   /* NULL to only measure */
> +    size_t len;
> +} NoteCursor;
> +
> +typedef void (*NoteFill)(NoteCursor *c, const CPUHexagonState *env);
> +
> +static void put_bytes(NoteCursor *c, const void *data, size_t size)
> +{
> +    if (c->buf) {
> +        memcpy(c->buf + c->len, data, size);
> +    }
> +    c->len +=3D size;
> +}
> +
> +static void put_zeros(NoteCursor *c, size_t size)
> +{
> +    if (c->buf) {
> +        memset(c->buf + c->len, 0, size);
> +    }
> +    c->len +=3D size;
> +}
> +
> +static void put_u32(NoteCursor *c, uint32_t val)
> +{
> +    uint32_t le =3D cpu_to_le32(val);
> +
> +    put_bytes(c, &le, sizeof(le));
> +}
> +
> +static void put_u64(NoteCursor *c, uint64_t val)
> +{
> +    uint64_t le =3D cpu_to_le64(val);
> +
> +    put_bytes(c, &le, sizeof(le));
> +}
> +
> +static void put_note(NoteCursor *c, uint32_t type, NoteFill fill,
> +                     const CPUHexagonState *env)
> +{
> +    NoteCursor desc =3D { };
> +
> +    fill(&desc, env);
> +
> +    put_u32(c, sizeof(HEXAGON_CORE_NOTE_OWNER));
> +    put_u32(c, desc.len);
> +    put_u32(c, type);
> +    put_bytes(c, HEXAGON_CORE_NOTE_OWNER, =
sizeof(HEXAGON_CORE_NOTE_OWNER));
> +    put_zeros(c, ROUND_UP(sizeof(HEXAGON_CORE_NOTE_OWNER), 4) -
> +                 sizeof(HEXAGON_CORE_NOTE_OWNER));
> +    fill(c, env);
> +    put_zeros(c, ROUND_UP(desc.len, 4) - desc.len);
> +}
> +
> +/*
> + * Layout: version, FRAMELIMIT, FRAMEKEY, VFRAMELIMIT, VSP.
> + */
> +static void fill_ctrl(NoteCursor *c, const CPUHexagonState *env)
> +{
> +    put_u32(c, HEXAGON_CORE_NOTE_VERSION);
> +    put_u32(c, env->gpr[HEX_REG_FRAMELIMIT]);
> +    put_u32(c, env->gpr[HEX_REG_FRAMEKEY]);
> +    put_u32(c, env->gpr[HEX_REG_VFRAMELIMIT]);
> +    put_u32(c, env->gpr[HEX_REG_VSP]);
> +}
> +
> +static const HexagonHVXContext *note_hvx_ctx(const CPUHexagonState =
*env)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    return &env->hvx_ctx;
> +#else
> +    return env->hvx;
> +#endif
> +}
> +
> +/*
> + * Layout: version, vlen (the size of a vector register in bytes), =
nvregs,
> + * nqregs and ext, then the nvregs vector registers, then the nqregs =
predicate
> + * registers of vlen / 8 bytes each.  If ext is 1, which it is where =
qfloat
> + * has extension bits, V79 and later, the vlen / 4 bytes of extension =
bits of
> + * each vector register follow.
> + */
> +static void fill_hvx(NoteCursor *c, const CPUHexagonState *env)
> +{
> +    const HexagonHVXContext *hvx =3D note_hvx_ctx(env);
> +
> +    put_u32(c, HEXAGON_CORE_NOTE_VERSION);
> +    put_u32(c, sizeof_field(MMVector, ub));
> +    put_u32(c, NUM_VREGS);
> +    put_u32(c, NUM_QREGS);
> +    put_u32(c, qfloat_is_extended(env));
> +
> +    for (int i =3D 0; i < NUM_VREGS; i++) {
> +        for (int j =3D 0; j < ARRAY_SIZE(hvx->VRegs[i].ud); j++) {
> +            put_u64(c, hvx->VRegs[i].ud[j]);
> +        }
> +    }
> +    for (int i =3D 0; i < NUM_QREGS; i++) {
> +        for (int j =3D 0; j < ARRAY_SIZE(hvx->QRegs[i].ud); j++) {
> +            put_u64(c, hvx->QRegs[i].ud[j]);
> +        }
> +    }
> +    if (qfloat_is_extended(env)) {
> +        for (int i =3D 0; i < NUM_VREGS; i++) {
> +            put_bytes(c, hvx->VRegs[i].ext, =
sizeof(hvx->VRegs[i].ext));
> +        }
> +    }
> +}
> +
> +/*
> + * Layout: version, vlen (the size of an HLX register in bytes), =
nlregs and
> + * zero, then the nlregs registers.
> + */
> +static void fill_hlx(NoteCursor *c, const CPUHexagonState *env)
> +{
> +    const HexagonHLXContext *hlx =3D env->hlx_ctx;
> +
> +    put_u32(c, HEXAGON_CORE_NOTE_VERSION);
> +    put_u32(c, HLX_VEC_SIZE_BYTES);
> +    put_u32(c, NUM_LREGS);
> +    put_u32(c, 0);
> +
> +    for (int i =3D 0; i < NUM_LREGS; i++) {
> +        for (int j =3D 0; j < ARRAY_SIZE(hlx->LRegs[i].ud); j++) {
> +            put_u64(c, hlx->LRegs[i].ud[j]);
> +        }
> +    }
> +}
> +
> +#ifndef CONFIG_USER_ONLY
> +/*
> + * Layout: version, nsregs, ngregs and zero, then the nsregs system =
registers
> + * by register number, with the thread's own ones below =
HEX_SREG_GLB_START
> + * and the global ones from there on, then the ngregs guest =
registers.
> + */
> +static void fill_sysregs(NoteCursor *c, const CPUHexagonState *env)
> +{
> +    const HexagonCPU *cpu =3D env_archcpu(env);
> +
> +    put_u32(c, HEXAGON_CORE_NOTE_VERSION);
> +    put_u32(c, NUM_SREGS);
> +    put_u32(c, NUM_GREGS);
> +    put_u32(c, 0);
> +
> +    for (int i =3D 0; i < NUM_SREGS; i++) {
> +        if (i < HEX_SREG_GLB_START) {
> +            put_u32(c, env->t_sreg[i]);
> +        } else {
> +            put_u32(c, cpu->globalregs ?
> +                    hexagon_globalreg_read(cpu->globalregs, i,
> +                                           env->threadId) : 0);
> +        }
> +    }
> +    for (int i =3D 0; i < NUM_GREGS; i++) {
> +        put_u32(c, hexagon_greg_read(env, i));
> +    }
> +}
> +
> +/*
> + * Layout: version, the thread number, the CPU mode (HEX_CPU_MODE_*), =
the TLB
> + * lock state and count, and the K0 lock state and count.
> + */
> +static void fill_thread(NoteCursor *c, const CPUHexagonState *env)
> +{
> +    put_u32(c, HEXAGON_CORE_NOTE_VERSION);
> +    put_u32(c, env->threadId);
> +    put_u32(c, get_cpu_mode(env));
> +    put_u32(c, env->tlb_lock_state);
> +    put_u32(c, env->tlb_lock_count);
> +    put_u32(c, env->k0_lock_state);
> +    put_u32(c, env->k0_lock_count);
> +}
> +
> +/*
> + * Layout: version, the number of entries and two zeroes, then the =
entries as
> + * the 64-bit values that tlbw takes.
> + */
> +static void fill_tlb(NoteCursor *c, const CPUHexagonState *env)
> +{
> +    HexagonTLBState *tlb =3D env_archcpu(env)->tlb;
> +    uint32_t num_entries =3D hexagon_tlb_get_num_entries(tlb);
> +
> +    put_u32(c, HEXAGON_CORE_NOTE_VERSION);
> +    put_u32(c, num_entries);
> +    put_u32(c, 0);
> +    put_u32(c, 0);
> +
> +    for (uint32_t i =3D 0; i < num_entries; i++) {
> +        put_u64(c, hexagon_tlb_read(tlb, i));
> +    }
> +}
> +#endif
> +
> +static void put_all_notes(NoteCursor *c, const CPUHexagonState *env)
> +{
> +    const HexagonCPU *cpu =3D env_archcpu(env);
> +
> +    put_note(c, HEXAGON_NT_CTRL, fill_ctrl, env);
> +    if (note_hvx_ctx(env) && cpu->cfg.hex_def->hex_version >=3D =
HEX_VER_V60) {
> +        put_note(c, HEXAGON_NT_HVX, fill_hvx, env);
> +    }
> +    if (env->hlx_ctx && cpu->cfg.hex_def->hex_version >=3D =
HEX_VER_V85) {
> +        put_note(c, HEXAGON_NT_HLX, fill_hlx, env);
> +    }
> +#ifndef CONFIG_USER_ONLY
> +    put_note(c, HEXAGON_NT_SYSREGS, fill_sysregs, env);
> +    put_note(c, HEXAGON_NT_THREAD, fill_thread, env);
> +    put_note(c, HEXAGON_NT_TLB, fill_tlb, env);
> +#endif
> +}
> +
> +size_t hexagon_core_notes_size(const CPUHexagonState *env)
> +{
> +    NoteCursor c =3D { };
> +
> +    put_all_notes(&c, env);
> +    return c.len;
> +}
> +
> +void hexagon_core_fill_notes(void *buf, const CPUHexagonState *env)
> +{
> +    NoteCursor c =3D { .buf =3D buf };
> +
> +    put_all_notes(&c, env);
> +}
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 5f7f22fa2ea..a9e3f93c3c9 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -990,11 +990,11 @@ static void hexagon_cpu_class_init(ObjectClass =
*c, const void *data)
> }
>=20
> #ifndef CONFIG_USER_ONLY
> -uint32_t hexagon_greg_read(CPUHexagonState *env, uint32_t reg)
> +uint32_t hexagon_greg_read(const CPUHexagonState *env, uint32_t reg)
> {
>     uint32_t ssr =3D env->t_sreg[HEX_SREG_SSR];
>     int ssr_ce =3D GET_SSR_FIELD(SSR_CE, ssr);
> -    HexagonCPU *cpu =3D env_archcpu(env);
> +    const HexagonCPU *cpu =3D env_archcpu(env);
>=20
>     if (reg <=3D HEX_GREG_G3) {
>         return env->greg[reg];
> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
> index b9b2a2d9740..23fa3f65fdb 100644
> --- a/target/hexagon/meson.build
> +++ b/target/hexagon/meson.build
> @@ -292,6 +292,7 @@ hexagon_softmmu_ss =3D ss.source_set()
>=20
> hexagon_ss.add(files(
>     'cpu.c',
> +    'core_notes.c',
>     'translate.c',
>     'op_helper.c',
>     'gdbstub.c',
> --=20
> 2.34.1
>=20


