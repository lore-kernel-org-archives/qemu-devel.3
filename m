Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BD0606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vivier.eu header.i=laurent@vivier.eu header.a=rsa-sha256 header.s=s1-ionos header.b=1Yk3viDs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNqhU-0000RB-9Y; Mon, 02 Nov 2026 06:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1xNqhS-0000Qa-4i; Mon, 02 Nov 2026 06:59:42 -0500
Received: from mout.kundenserver.de ([217.72.192.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1xNqhP-0006JB-R7; Mon, 02 Nov 2026 06:59:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1793620767; x=1794225567; i=laurent@vivier.eu;
 bh=KZgPl/iGI96lsVxA6pNYSPyqYYxSw4g3yF93eHVR1V4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=1Yk3viDsNnQMhFCx4RwRg7SH0p9hYud4qrI6Cx8nHAN7/ivEBanG6vuy1AcoQXN0
 SphDhqAtzXYUr6CYLk4bp+3PyJQ0HGREFEPanxdcxwdwfMxPaJbrFRGRmPA9cmFGT
 Glc0MjLDGkZhJ9rk7zxqv7SKAZTFfZLLVnsDxPLoN+TwyPbCkuz8OJ+a3MWOWvn/R
 HZxOtOvO9/NHz7VJh3kMWS2+BlDRxHvD9ZcHbsmTJp6KHWb2Cw0jK05dmYTw+l3i+
 Z/eOrgyVZc32GSWRd6X9jIEpdRkUhCyMNlk8nTFmPHwUjLjqU745kTApnNGn8+QCN
 WpuK+jS4eOlH5eIw7g==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue109
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1MO9r5-1x8d5a1Hbd-00JlfT; Mon, 02
 Nov 2026 12:59:27 +0100
Message-ID: <9b038f45-04f7-4753-9ac9-d1836d16058a@vivier.eu>
Date: Mon, 2 Nov 2026 12:59:23 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/18] target/m68k: expose system registers to monitors
 via gdbstub
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>
References: <20261022-query-reg-v3-0-7ad902b9a7cf@redhat.com>
 <20261022-query-reg-v3-13-7ad902b9a7cf@redhat.com>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20261022-query-reg-v3-13-7ad902b9a7cf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MXurQX7WaPgdFvaYz1981PHymQgQOD2eAr+1dCAaNabWfnntp/X
 0x5LvkImXtqf4F+2kXbaVd0MbsRGnAxfOiEbmpg58oowIzVXsvdx+jj9DtTjql/SZV1/N//
 N8qMLceXUKf6bttnInB4vBUTN/OHVkfiIzlT3VUthQP86PDo6a3X9pbHwvhNNLYvPBbP05Y
 nUX5VBT9+wF2oGz1shBJg==
UI-OutboundReport: notjunk:1;M01:P0:vquT101YiRY=;eQ1637LCV7souHVHBjcJOZO/zhI
 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
Received-SPF: pass client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Le 22/10/2026 =C3=A0 12:56, Marc-Andr=C3=A9 Lureau a =C3=A9crit=C2=A0:
> Replace the HMP-specific MonitorDef with a GDB feature that exposes
> supervisor stack pointers (ssp, usp, isp), function code registers (sfc,
> dfc), MMU registers (urp, srp, dttr0/1, ittr0/1, mmusr) as read-only
> system registers through the internal GDB coprocessor interface.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   configs/targets/m68k-softmmu.mak |  2 +-
>   gdbstub/gdb-xml/m68k-system.xml  | 32 ++++++++++++++++++++++++++
>   target/m68k/cpu.c                | 22 ------------------
>   target/m68k/helper.c             | 49 ++++++++++++++++++++++++++++++++=
+++++++-
>   4 files changed, 81 insertions(+), 24 deletions(-)
>=20
> diff --git a/configs/targets/m68k-softmmu.mak b/configs/targets/m68k-sof=
tmmu.mak
> index 0bc889f326e3..f3ac9b74c862 100644
> --- a/configs/targets/m68k-softmmu.mak
> +++ b/configs/targets/m68k-softmmu.mak
> @@ -1,4 +1,4 @@
>   TARGET_ARCH=3Dm68k
>   TARGET_BIG_ENDIAN=3Dy
> -TARGET_XML_FILES=3D cf-core.xml cf-fp.xml m68k-core.xml m68k-fp.xml
> +TARGET_XML_FILES=3D cf-core.xml cf-fp.xml m68k-core.xml m68k-fp.xml m68=
k-system.xml
>   TARGET_LONG_BITS=3D32
> diff --git a/gdbstub/gdb-xml/m68k-system.xml b/gdbstub/gdb-xml/m68k-syst=
em.xml
> new file mode 100644
> index 000000000000..0a91be0edc00
> --- /dev/null
> +++ b/gdbstub/gdb-xml/m68k-system.xml
> @@ -0,0 +1,32 @@
> +<?xml version=3D"1.0"?>
> +<!--
> +  SPDX-License-Identifier: GPL-2.0-or-later
> +-->
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<!-- System-register values are read-only; writes are ignored. -->
> +<feature name=3D"org.qemu.gdb.m68k.system">
> +  <reg name=3D"ssp" bitsize=3D"32" type=3D"uint32"
> +       group=3D"qemu-debug" save-restore=3D"no"/>
> +  <reg name=3D"usp" bitsize=3D"32" type=3D"uint32"
> +       group=3D"qemu-debug" save-restore=3D"no"/>
> +  <reg name=3D"isp" bitsize=3D"32" type=3D"uint32"
> +       group=3D"qemu-debug" save-restore=3D"no"/>

I think ssp, usp and isp can be type=3D"data_ptr"

> +  <reg name=3D"sfc" bitsize=3D"32" type=3D"uint32"
> +       group=3D"qemu-debug" save-restore=3D"no"/>
> +  <reg name=3D"dfc" bitsize=3D"32" type=3D"uint32"
> +       group=3D"qemu-debug" save-restore=3D"no"/>
> +  <reg name=3D"urp" bitsize=3D"32" type=3D"uint32"
> +       group=3D"qemu-debug" save-restore=3D"no"/>
> +  <reg name=3D"srp" bitsize=3D"32" type=3D"uint32"
> +       group=3D"qemu-debug" save-restore=3D"no"/>
> +  <reg name=3D"dttr0" bitsize=3D"32" type=3D"uint32"
> +       group=3D"qemu-debug" save-restore=3D"no"/>
> +  <reg name=3D"dttr1" bitsize=3D"32" type=3D"uint32"
> +       group=3D"qemu-debug" save-restore=3D"no"/>
> +  <reg name=3D"ittr0" bitsize=3D"32" type=3D"uint32"
> +       group=3D"qemu-debug" save-restore=3D"no"/>
> +  <reg name=3D"ittr1" bitsize=3D"32" type=3D"uint32"
> +       group=3D"qemu-debug" save-restore=3D"no"/>
> +  <reg name=3D"mmusr" bitsize=3D"32" type=3D"uint32"
> +       group=3D"qemu-debug" save-restore=3D"no"/>
> +</feature>
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index 9b52ad5fc234..ad7303305848 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -25,7 +25,6 @@
>   #include "disas/capstone.h"
>   #ifndef CONFIG_USER_ONLY
>   #include "migration/vmstate.h"
> -#include "monitor/hmp.h"
>   #endif
>  =20
>   #include "cpu.h"
> @@ -666,32 +665,11 @@ static const VMStateDescription vmstate_m68k_cpu =
=3D {
>       },
>   };
>  =20
> -#ifdef CONFIG_HMP
> -static const MonitorDef m68k_monitor_defs[] =3D {
> -    { "ssp", offsetof(CPUM68KState, sp[0]) },
> -    { "usp", offsetof(CPUM68KState, sp[1]) },
> -    { "isp", offsetof(CPUM68KState, sp[2]) },
> -    { "sfc", offsetof(CPUM68KState, sfc) },
> -    { "dfc", offsetof(CPUM68KState, dfc) },
> -    { "urp", offsetof(CPUM68KState, mmu.urp) },
> -    { "srp", offsetof(CPUM68KState, mmu.srp) },
> -    { "dttr0", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR0]) },
> -    { "dttr1", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR1]) },
> -    { "ittr0", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR0]) },
> -    { "ittr1", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR1]) },
> -    { "mmusr", offsetof(CPUM68KState, mmu.mmusr) },
> -    { NULL },
> -};
> -#endif
> -
>   #include "hw/core/sysemu-cpu-ops.h"
>  =20
>   static const struct SysemuCPUOps m68k_sysemu_ops =3D {
>       .has_work =3D m68k_cpu_has_work,
>       .get_phys_addr_debug =3D m68k_cpu_get_phys_addr_debug,
> -#ifdef CONFIG_HMP
> -    .monitor_defs =3D m68k_monitor_defs,
> -#endif
>   };
>   #endif /* !CONFIG_USER_ONLY */
>  =20
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index 5f91d206f596..1a29eaaf37f6 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -123,6 +123,48 @@ static int m68k_fpu_gdb_set_reg(CPUState *cs, uint8=
_t *mem_buf, int n)
>       return 0;
>   }
>  =20
> +#ifndef CONFIG_USER_ONLY
> +static int m68k_gdb_read_system_register(CPUState *cs, GByteArray *buf,=
 int n)
> +{
> +    CPUM68KState *env =3D cpu_env(cs);
> +    static const int stacks[] =3D { M68K_SSP, M68K_USP, M68K_ISP };
> +
> +    if (n >=3D 0 && n < ARRAY_SIZE(stacks)) {
> +        int sp =3D stacks[n];
> +
> +        return gdb_get_reg32(buf, env->sp[sp]);
> +    }

Why do we need stacks[]?

Could it be:

> +    switch (n) {

        case 0: case 1: case 2:
            return gdb_get_reg32(buf, env->sp[n]);

> +    case 3:
> +        return gdb_get_reg32(buf, env->sfc);
> +    case 4:
> +        return gdb_get_reg32(buf, env->dfc);
> +    case 5:
> +        return gdb_get_reg32(buf, env->mmu.urp);
> +    case 6:
> +        return gdb_get_reg32(buf, env->mmu.srp);
> +    case 7:
> +        return gdb_get_reg32(buf, env->mmu.ttr[M68K_DTTR0]);
> +    case 8:
> +        return gdb_get_reg32(buf, env->mmu.ttr[M68K_DTTR1]);
> +    case 9:
> +        return gdb_get_reg32(buf, env->mmu.ttr[M68K_ITTR0]);
> +    case 10:
> +        return gdb_get_reg32(buf, env->mmu.ttr[M68K_ITTR1]);
> +    case 11:
> +        return gdb_get_reg32(buf, env->mmu.mmusr);
> +    default:
> +        return 0;
> +    }
> +}
> +
> +static int m68k_gdb_write_system_register(CPUState *cs, uint8_t *buf, i=
nt n)
> +{
> +    /* These registers are exposed for inspection only. Ignore writes. =
*/
> +    return 4;
> +}
> +#endif
> +
>   void m68k_cpu_init_gdb(M68kCPU *cpu)
>   {
>       CPUState *cs =3D CPU(cpu);
> @@ -135,7 +177,12 @@ void m68k_cpu_init_gdb(M68kCPU *cpu)
>           gdb_register_coprocessor(cs, m68k_fpu_gdb_get_reg, m68k_fpu_gd=
b_set_reg,
>                                    gdb_find_static_feature("m68k-fp.xml"=
));
>       }
> -    /* TODO: Add [E]MAC registers.  */
> +    /* TODO: Add [E]MAC registers. */
> +#ifndef CONFIG_USER_ONLY
> +    gdb_register_internal_coprocessor(cs, m68k_gdb_read_system_register=
,
> +                                      m68k_gdb_write_system_register,
> +                                      gdb_find_static_feature("m68k-sys=
tem.xml"));
> +#endif
>   }
>  =20
>   void HELPER(cf_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val=
)
>=20

Otherwise it looks good to me.

Thanks,
Laurent

