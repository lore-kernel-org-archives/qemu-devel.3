Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32463C624DB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 06:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2k2h-0004RQ-LW; Sat, 05 Sep 2026 02:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x2k2e-0004Qz-Hb
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 02:38:20 -0400
Received: from st-2005f-snip6-11.eps.apple.com ([2a01:b747:3001:202::3d]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x2k2c-0007Fk-8l
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 02:38:20 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-0 (Postfix) with ESMTPS id
 9895A180051E; Sat, 05 Sep 2026 06:38:11 +0000 (UTC)
X-ICL-RepId: 01a07049-f9e6-77a5-b11f-5ba297658846
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0MWFsIWwQPH0wMUQJCBVZeSgwdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkB4Owpeclp3XQ1IBl0aX3BGAFVxKAVdH0Z/O3BUDioCNQFABS1CBUICXBxaDkMKUBxcVlUfCUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1788590292; x=1791182292;
 bh=6w7MaFz6KOY4yY68KiwGIWMvBCKfDc8jGrYDBhI8Tr8=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=mVQa85IQpynJpqoP+3g/zwbOfaesHqle0TqOg6oWGhqpYPpJWgXVm2ytoRm6bIV1bQ55LQtM2twFHq448152q8gHnRXp+BNqUBvU1pEa4Vyyaj5HU9aKUU31mmmwy/NwWsJcBXRS5Ap3XdEbDb36fBmMHpoJvbtPn1/xphxe7vpHLqeJfs/yDF07Szz7RDA6sLJ5qYklwAGcY+uxBJ92PLMD41xUuBzGKMvZQlV0GTNir389cijm8ZmWUvXaFKbFMx/78X6VnABAN2/HSLJm3PRKouj2KjIwNEk31ACEXUC+xJC7JUtWvRZ4nKt4MgvObZGo+JohttHpa4r0Nk16Gw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-0 (Postfix) with ESMTPSA id
 3F35E180079F; Sat, 05 Sep 2026 06:38:10 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH] target/arm/hvf: implement MDCCSR_EL0 as RAZ
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260905004800.5B560C92F2@bambi.snowrabbit.org>
Date: Sat, 5 Sep 2026 08:37:57 +0200
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0AC93E1E-4050-4B69-BE26-6FCC99A0E886@unpredictable.fr>
References: <20260905004800.5B560C92F2@bambi.snowrabbit.org>
To: Showta Ishizaki <zakinko@snowrabbit.org>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-Proofpoint-ORIG-GUID: BgMDTgzTF8do9OOtDCSVWxrfO_wGGXj4
X-Proofpoint-GUID: BgMDTgzTF8do9OOtDCSVWxrfO_wGGXj4
X-Authority-Info-Out: v=2.4 cv=ZOHaWH7b c=1 sm=1 tr=0 ts=6a9bb8d4
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=L9C5IM_eAAAA:8 a=L21GyXeTruXqJ9aIticA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=CjuIK1q_8ugA:10 a=d8_PwHeUR2dB5DzxAQPm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDA2OCBTYWx0ZWRfX3qNiIV+tsiRu
 MNP6LESRFq0TIeeQfHPMxcKlGmtvLPXe8I4S4YwWiKBrxosWN79O/l/l54TNamYbf+l7CnUQku9
 6qa2DdHXPfKF/TDFZbbNPxbCrBhzFhjGhBJ8HLlI1jVlTWCawEkkIWEdvc8f+s6X6zEcMvb9y+x
 6JGzTFJVTidT6oI5JZ3t4jULFo3Hgof6XoZ83cTupaTofK1hsbHqdq2mwffzBFrpEhr5MYgAV1Z
 xps0o+bZN1MmJgn6efilSgDMOIiAg7xPANUI2BsVLbhWm6f7GzWyS2JqfBDMi+ZVvmx5BdUjb6a
 JoLX9s6Cw4Vt/27Fl1Hq4d7sPnsE0CcUYSxAXEcyMHxRuD4hGRyUhP7BxfrFqs=
X-JNJ: AAAAAAABksIFX+LzL1H8UVogRTtf4tCtDJut2oaDkNR/Gn1f0p98dIgYMJBIK+P+xHcSIXRJNaZzYbelPaYfsb2oYWVirABj1vfqFXGKlOOnsD837ufXfUYMaApVrYVsrWuZCYT3Ik81cbrqE5/oogBmtmtB0stXBUhFZzGFu8OXll6E4S66I42XjvbYIeFL9OMbDufK4DxuTXWF1sgm3HeZBV8WhwEOLgfc5+Xzf9aMJ5mB7HVtpzaM7Jv+PFP6C6wBdk/DxfuHXYneiY0prqQ6VZm2hea/JEFp7nLXy/vjvxhZE64Ny7ATp0lkm1pNeYiFQvl7rEtqf4YsgWqfrNWQlLCfk9VqOSdYAXkDhFTtY+eW2beh508LMftYovRNbCrV88YgLXL6CkuRezHDDfSCkraYSROyxXaexXaImA+Jm6OUyQD80Jyd6XMseiYKGO/u43ujwO/101LyRk6BE5NIeboqRBroyrSMRuKAtEG71l792MwuQkzbfEh1R/MT+N7qLU16y3AjfHixXD9WG+cy/fl0V6xpWvimCYHxF5IlMX2AlcOQYYIcfwpjvfEVvVqTTLqmMPgpW1K9P4L+AE2194y8Yh8OjnSEMyQsi//SIQsQMA/8KoVQEi0bl3c4ln6nLyLgbfibJJ5ZfhzgrgEe5JNyhfOBJoarxcKj4620szYnIaxjIb8Xk8/thU6l+h2zkG1l/yVMBB4wN6i4UrAP+F3XxdM4cXSTaoP9GK1ctkPXT9/HhPu3VgLntgxqAUrfdPqRI6wUrWUKytaotUM5grr8AviDrt2hrmk5QHU2RLdZ07CrY2+ftsqYCJJHYRjWIh1RXrI5vKXbNLHDembIVdxfxHbKcb6Vz04DDiZXW4BKlw5NodD2u3uz3aq8amP887CDXVNZI5HQnG+5MhenmdxqKQxiuan0ttU0nPIWim020vkjJHFCXpHAC0US5o/TQP2X2J7NutTE5W1sFvy6gxBykwm
 XcUz/1NfXWGdJm6OIfJG2+ZvZ8QUyTnQ7IdtT0QJVlphZK7Zysd6D2nWtOEWkposm9EwaWIDf9wXYNfSXue/pAP9XHUAH8a/rueqRwJtFqIyevBKMNeTD2DLBS+/EWsl7R6OqJ8yJMJhpEMb2KWyFywVGwstlNzzqIMbDSkH6d6h5lrsocxfrH2gaSUeS5oOULeIRw0I3ZsZ65oyJBEaEqnSidA7KYXyoNZVBKM1BSjzCG0RrEqOzLxZcQBRG3BH8Juil2qaa8BYvLh92AwQt1fpeIVDeYh7u/NojllxOCHFKXMdExFAscd8KP7eQTLxY58Qo08Ad2xxKRQpHqiFIhUsvqtSbilTsWrFOU5sE/2Q6wP1/LGrHUmuXwl5lDpJ3vN4wadB06maE9L/PSOV5IzF3HL2yO3eQUbA/DU/uyc0/16FauyPUspQfKm2a
Received-SPF: pass client-ip=2a01:b747:3001:202::3d;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



> On 5. Sep 2026, at 02:48, Showta Ishizaki <zakinko@snowrabbit.org> =
wrote:
>=20
>=20
> A guest that reads MDCCSR_EL0 under hvf is killed.  The register has =
no
> case in hvf_sysreg_read(), so it reaches the unhandled path and hvf
> injects an undefined instruction:
>=20
>    trace_hvf_unhandled_sysreg_read(env->pc, reg, ...);
>    hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized(), 1);
>=20
> The TCG path does not do this.  debug_helper.c defines MDCCSR_EL0 as
> ARM_CP_CONST with resetvalue 0, and the comment on the neighbouring =
DCC
> registers gives the reason:
>=20
>    However we implement RAZ/WI behaviour with trapping to prevent
>    spurious SIGILLs if the guest OS does access them as the support
>    cannot be probed for.
>=20
> That argument holds for hvf as much as for TCG, so do the same there.
>=20
> The read only reaches QEMU since 37863fff59 ("hvf: arm: enable vGIC by
> default for virt-11.1 and later").  With -M virt,kernel-irqchip=3Doff =
the
> trace point does not fire at all, so before that change the register =
was
> never trapped out.
>=20
> NetBSD/aarch64 hits this on every boot.  vmt(4) probes for the VMware
> backdoor, which on arm64 is a read of MDCCSR_EL0 with a magic value in
> x7, and the injected undefined instruction is fatal in kernel mode:
>=20
>    [   1.0000000] cpu0 at acpi0: unknown CPU (ID =3D 0x610f0000), id =
0x0
>    [   1.0000000] panic: Trap: fatal Unknown Reason (Illegal =
Instruction):
>      pc=3Dffffc000003fa318 sp=3Dffffc000010262e0 esr=3D02000000
>    [   1.0000000] fp ffffc000010262f0 vmt_probe() at =
netbsd:vmt_probe+0x3c
>    [   1.0000000] fp ffffc00001026340 vmt_match() at =
netbsd:vmt_match+0x1c
>=20
> The pc in the panic is the same pc the trace point reports, and the
> encoding it reports is MDCCSR_EL0:
>=20
>    hvf_unhandled_sysreg_read unhandled sysreg read at =
pc=3D0xffffc000003fa318:
>      0x0020c002 (op0=3D2 op1=3D3 crn=3D0 crm=3D1 op2=3D0)
>=20
> With this patch the same image boots to login on -M virt -accel hvf, =
and
> the trace point does not fire.
>=20
> Fixes: 37863fff59e0 ("hvf: arm: enable vGIC by default for virt-11.1 =
and later")
> Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
> target/arm/hvf/hvf.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>=20
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index da3ec521fc..b00a7e1a84 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -234,6 +234,7 @@ void hvf_arm_init_debug(void)
> #define SYSREG_ICC_SRE_EL1       SYSREG(3, 0, 12, 12, 5)
>=20
> #define SYSREG_MDSCR_EL1      SYSREG(2, 0, 0, 2, 2)
> +#define SYSREG_MDCCSR_EL0     SYSREG(2, 3, 0, 1, 0)
> #define SYSREG_DBGBVR0_EL1    SYSREG(2, 0, 0, 0, 4)
> #define SYSREG_DBGBCR0_EL1    SYSREG(2, 0, 0, 0, 5)
> #define SYSREG_DBGWVR0_EL1    SYSREG(2, 0, 0, 0, 6)
> @@ -1756,6 +1757,15 @@ static int hvf_sysreg_read(CPUState *cpu, =
uint32_t reg, uint64_t *val)
>     case SYSREG_MDCCINT_EL1:
>         assert_hvf_ok(hv_vcpu_get_sys_reg(cpu->accel->fd, =
HV_SYS_REG_MDCCINT_EL1, val));
>         return 0;
> +    case SYSREG_MDCCSR_EL0:
> +        /*
> +         * The Debug Communications Channel is not implemented, so =
RAZ,
> +         * which is what the TCG path in debug_helper.c does.  A =
guest
> +         * cannot probe for DCC support, so injecting an undefined
> +         * instruction here turns a legal read into a fatal trap.
> +         */
> +        *val =3D 0;
> +        return 0;
>     case SYSREG_ICC_AP0R0_EL1:
>     case SYSREG_ICC_AP0R1_EL1:
>     case SYSREG_ICC_AP0R2_EL1:
> --=20
> 2.50.1 (Apple Git-155)
>=20
>=20


