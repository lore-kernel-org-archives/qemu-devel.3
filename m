Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7466C624D6
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 06:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2k4d-0005E3-CN; Sat, 05 Sep 2026 02:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x2k4c-0005Cp-C1
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 02:40:22 -0400
Received: from ms-2002f-snip6-11.eps.apple.com ([2a01:b747:3002:204::3d]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x2k4Z-0007Wp-GK
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 02:40:21 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPS id
 86F46180036D; Sat, 05 Sep 2026 06:40:16 +0000 (UTC)
X-ICL-RepId: 01a0704b-e13b-74e2-9e3b-6a627ccbcc95
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0MWFsIWwQPH0wMUQJCBVZeVAsdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkZ4SXVUDi12XQE7ClsaXws1eFVxWwBTHzJ7TgpUAC0BNX9PCi1CBUICXBxaDkMKUBxcVlUfCUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1788590418; x=1791182418;
 bh=wmDHaAv+1JiGYgDVdA62su6MpbNW3BrYO5ny8yRIEAU=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Eu+UiK5b5J29zIBSexSkIAHO5xiUyR/3GtNCZkNW8tIoeOtrzQeB3MkEv+VXPH3TfRt+K2T/2dUdAPS+jgo9eh/YggA9mlHNs7t6vIBNGsXs2Qskia6pNxApdhb/ZX2Ixr0hO5UfvXx5iNbaCoEL8Ga2O/scihnDl9G3tPDaEzh/WFwYxxTrJuL4FzVw7nJ4P0dhJ2p8OWPURtrFGkQP8ZxNm06by0l0+2lPGHPU2mHzpAMe/XJH7aGlh4dr//TopgYmS9LsLaYAt/6P89smVizJ3lNXPYaM6+yzeULJukiSL1qSMkCRaVZNpws5y8PsF9so0yfHYadlpy2y6v4fkg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.208.39])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPSA id
 B55EB1800124; Sat, 05 Sep 2026 06:40:14 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH] target/arm/hvf: implement MDCCSR_EL0 as RAZ
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <0AC93E1E-4050-4B69-BE26-6FCC99A0E886@unpredictable.fr>
Date: Sat, 5 Sep 2026 08:40:02 +0200
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6A1F99FD-8C96-49EA-B678-BB6997F3EF79@unpredictable.fr>
References: <20260905004800.5B560C92F2@bambi.snowrabbit.org>
 <0AC93E1E-4050-4B69-BE26-6FCC99A0E886@unpredictable.fr>
To: Showta Ishizaki <zakinko@snowrabbit.org>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDA2OCBTYWx0ZWRfX+UXelNYqTnJa
 kblkDXDHcrM6IwHlKXvpJkwqWFzya+zNK1JdP/o4oDXDn+yFX4G8RVFGf37hZAuk2SFi44Csj/o
 6wqrXQvIAM5ln1u8xmuOSvPVZikv9Dd5Ns+2JgDaQBjef8Oeb28I919hF3+oyK1vdHWgELEosUf
 0Yps/lZz++7uzgcUR2X2dw3m+DDDXqR9o/kinLq0N57BGMzNt/BbnIhl58MtgNdmoKmJjSgGvC+
 HO63K780YIRMl9KfZ5QBSX2D/DAyRdwXfjZgrnRLJ4y8e0IlCWnuBWsHgyYOqDWh8AdCoJiMWFl
 6k1W9ymy1Gr1cUkbxlVtaoOV/L6Ii7aAJLhyxNEvhrkV+3f5WxZ7ldMvD1OG6U=
X-Proofpoint-ORIG-GUID: 8Pq8oQi4bcM8pFN3Q5wtSQkJyG8T2Cax
X-Authority-Info-Out: v=2.4 cv=D+FK6/Rj c=1 sm=1 tr=0 ts=6a9bb951
 cx=c_apl:c_pps:t_out a=kRaGL2Q7qLiahLf3O6OaIA==:117
 a=kRaGL2Q7qLiahLf3O6OaIA==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=L9C5IM_eAAAA:8 a=RGPeLiVDzh6DSidvj3oA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=d8_PwHeUR2dB5DzxAQPm:22
X-Proofpoint-GUID: 8Pq8oQi4bcM8pFN3Q5wtSQkJyG8T2Cax
X-JNJ: AAAAAAABU5kul7B2Oj5wp4TlNnzEHr9dLhUtCyNLaf3vAYI0KgeVZYuUzPQhGrgS7qKlP4IgGU5uDYxVr/cMFaX65cn6WbX2ActWm4cqbV5n20AMeTHo3YCVIHl/voElMymmDcgE+V9Okjf+2rZxiRbaJhidbLNh08jgnRZzNelROIpAlh+K7MPJ34UwxSXntiHMgRdg994d9y3ADkzCDdjL3aLEV4z4X6bWuG+OB6XWhNXl1WwhBmK2rbrkUdeTUBDHDOVtUawnCd53uvOn2ef4o06oqVE6KgKwUSiDa3DdmsPXm1NcCr3FwSWDZWJf8SlJuIWnPpjS6y+TEsf9p6MWbn+k1+glV9KYqHd9xNZ+P2kR32XpbzLphJKz9MoAyQ5zehBsdmU3hTNyKM29xzBbTXzWsGFkkPNaIcOlSeLri8NcZlH1UYNenhXPf03NMbCkrK+IcMvGsRY5EUxOKbmXH/mraFk/akJQCV5LitggTF84WeYcZJGUl43eJNDp76sTBI2xcPiahYOg4944H6/Ot0YFigaZlb1fu4UHY1Mf0ro+pzMJf2cjE1f7XJrzKVwnrQhj98AGl1FiP0u8TTa8ybvFL+GYRl/PB1CErg4a1RGJT9U6cC76CeT7Wp5zt7S64/Q1Axzqf7/LiN5BahNNe3H1MOC1ymvXvKPCayApuyTvQ6lI8WKsHiEb606pBOKd/LkfWczno+GtMnUCXRTl6OTmPnqrA/GrHEHlcOmj0CisRGjHz658jUPeiCsvKk/tC7INZ7OagJaxo+3nFhvjDF3YE4od2CjzSSjMx9v8MnGks6oVd4N4hwairTS2XxHyMOz0nZMKI18Y4kUjr84LMk8EuWmlEBNxIIXBa+e88GOzOM38/ensphu9Wk3zWJNHCnMCClBkj8ZWI5z63cd/tdpaVpRdfRnb9hx1YJm+Pe3SZUubdE2QNtbAIEWITYoCgkrQbkBPDxZT6zpaUayJejEI7fi
 mE4slh7CF5idqYmPH8vtdYAmIjJOScpmpOWgw1L21lqX6DbunbA6I5EH3Zcd7DimJGroZpXvZkPhRHjIaszB4Xmoz0aDjfAYCBFZm7+hU/PuBsgqIesyMGlLyzOhEE0J4va+kOjZztn6oFLVS1ORf5Z+MJhAJEwybH2P26zkv3sPXYVb2RuPpGUdI7+WXCgVsFllqNxT+FKiBnRzJQMUFwlRYQomlv8kNZR9PXih2ydKNhcuLuhvwsOOOsgCFGxu1hSZwQScnT1dyte3MkmkMuZ8zpf2V+3Ti6o7oMpwCCdfG2MYZ9ZER2eaFx2X50U2A7NSjUiXU9maUaagPoXpFY/eS37/ktsFgNk73t+/hbVaxgNuccb7RnD1BEe66w4dOni780cPrzqQ43QvKPN8/jsZJHUvP+yRNwA/x//n5HFnhbq4Sk4ETeOs6WD+c65mRInVN9yA=
Received-SPF: pass client-ip=2a01:b747:3002:204::3d;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> On 5. Sep 2026, at 08:37, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
>=20
>=20
>> On 5. Sep 2026, at 02:48, Showta Ishizaki <zakinko@snowrabbit.org> =
wrote:
>>=20
>>=20
>> A guest that reads MDCCSR_EL0 under hvf is killed.  The register has =
no
>> case in hvf_sysreg_read(), so it reaches the unhandled path and hvf
>> injects an undefined instruction:
>>=20
>>   trace_hvf_unhandled_sysreg_read(env->pc, reg, ...);
>>   hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized(), 1);
>>=20
>> The TCG path does not do this.  debug_helper.c defines MDCCSR_EL0 as
>> ARM_CP_CONST with resetvalue 0, and the comment on the neighbouring =
DCC
>> registers gives the reason:
>>=20
>>   However we implement RAZ/WI behaviour with trapping to prevent
>>   spurious SIGILLs if the guest OS does access them as the support
>>   cannot be probed for.
>>=20
>> That argument holds for hvf as much as for TCG, so do the same there.
>>=20
>> The read only reaches QEMU since 37863fff59 ("hvf: arm: enable vGIC =
by
>> default for virt-11.1 and later").  With -M virt,kernel-irqchip=3Doff =
the
>> trace point does not fire at all, so before that change the register =
was
>> never trapped out.
>>=20
>> NetBSD/aarch64 hits this on every boot.  vmt(4) probes for the VMware
>> backdoor, which on arm64 is a read of MDCCSR_EL0 with a magic value =
in
>> x7, and the injected undefined instruction is fatal in kernel mode:
>>=20
>>   [   1.0000000] cpu0 at acpi0: unknown CPU (ID =3D 0x610f0000), id =
0x0
>>   [   1.0000000] panic: Trap: fatal Unknown Reason (Illegal =
Instruction):
>>     pc=3Dffffc000003fa318 sp=3Dffffc000010262e0 esr=3D02000000
>>   [   1.0000000] fp ffffc000010262f0 vmt_probe() at =
netbsd:vmt_probe+0x3c
>>   [   1.0000000] fp ffffc00001026340 vmt_match() at =
netbsd:vmt_match+0x1c
>>=20
>> The pc in the panic is the same pc the trace point reports, and the
>> encoding it reports is MDCCSR_EL0:
>>=20
>>   hvf_unhandled_sysreg_read unhandled sysreg read at =
pc=3D0xffffc000003fa318:
>>     0x0020c002 (op0=3D2 op1=3D3 crn=3D0 crm=3D1 op2=3D0)
>>=20
>> With this patch the same image boots to login on -M virt -accel hvf, =
and
>> the trace point does not fire.
>>=20
>> Fixes: 37863fff59e0 ("hvf: arm: enable vGIC by default for virt-11.1 =
and later")
>> Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
>=20
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
*Reviewed-by

Oops.

Will submit this as part of a rollup series or it=E2=80=99ll be taken on =
its own.
>> ---
>> target/arm/hvf/hvf.c | 10 ++++++++++
>> 1 file changed, 10 insertions(+)
>>=20
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index da3ec521fc..b00a7e1a84 100644
>> --- a/target/arm/hvf/hvf.c
>> +++ b/target/arm/hvf/hvf.c
>> @@ -234,6 +234,7 @@ void hvf_arm_init_debug(void)
>> #define SYSREG_ICC_SRE_EL1       SYSREG(3, 0, 12, 12, 5)
>>=20
>> #define SYSREG_MDSCR_EL1      SYSREG(2, 0, 0, 2, 2)
>> +#define SYSREG_MDCCSR_EL0     SYSREG(2, 3, 0, 1, 0)
>> #define SYSREG_DBGBVR0_EL1    SYSREG(2, 0, 0, 0, 4)
>> #define SYSREG_DBGBCR0_EL1    SYSREG(2, 0, 0, 0, 5)
>> #define SYSREG_DBGWVR0_EL1    SYSREG(2, 0, 0, 0, 6)
>> @@ -1756,6 +1757,15 @@ static int hvf_sysreg_read(CPUState *cpu, =
uint32_t reg, uint64_t *val)
>>    case SYSREG_MDCCINT_EL1:
>>        assert_hvf_ok(hv_vcpu_get_sys_reg(cpu->accel->fd, =
HV_SYS_REG_MDCCINT_EL1, val));
>>        return 0;
>> +    case SYSREG_MDCCSR_EL0:
>> +        /*
>> +         * The Debug Communications Channel is not implemented, so =
RAZ,
>> +         * which is what the TCG path in debug_helper.c does.  A =
guest
>> +         * cannot probe for DCC support, so injecting an undefined
>> +         * instruction here turns a legal read into a fatal trap.
>> +         */
>> +        *val =3D 0;
>> +        return 0;
>>    case SYSREG_ICC_AP0R0_EL1:
>>    case SYSREG_ICC_AP0R1_EL1:
>>    case SYSREG_ICC_AP0R2_EL1:
>> --=20
>> 2.50.1 (Apple Git-155)
>>=20
>>=20
>=20
>=20


