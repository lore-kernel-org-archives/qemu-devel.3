Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17001C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 22:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwRqk-0003s2-Qn; Tue, 18 Aug 2026 18:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wwRqi-0003rD-Dh
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 18:00:00 -0400
Received: from st-2004g-snip6-3.eps.apple.com ([2a01:b747:3001:201::49]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wwRqg-0000Bc-Bj
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 18:00:00 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-7 (Postfix) with ESMTPS id
 AED2B18000B7; Tue, 18 Aug 2026 21:59:55 +0000 (UTC)
X-ICL-RepId: 01a016e3-616b-7ffd-9a57-52d52f7e3b8e
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQBIHVoORQNGCVYLWhcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0KWFsIWwQPH0wMUQJCBVZeSgwdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDjILPHdfAFMEXXpBAF0aXwpFD1UKWXZbHzZ7TnEpclNzQwE6Bi1CBUICXBxaDkMKUBxcVlUfCUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1787090396; x=1789682396;
 bh=nMx2BSqsGX24vNsd4eHJvvBZwQG+W4oR8kCT2HTUCJc=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=e+MIrrMtZ4Q80uDKsT0Tltx9c15Z5D36f9XDXWdqGS8fRfogtS4sHJYFRpHt1LmQp1JzHym/YlxoKtB4qCzjRKFks+TrkdIBBg8eEX3uOXJ25qlp8czFxVwUE+IRfA5W9Zc7qpjOoTkM7ahg+NZNK/mIKzFIBKgwXjMP7R08ERkR6WwT1KwIBS/1T/TLG+9HTJqPCzh3k6hc+RbZ6NSwhNIMNpUA9xyiPlwZCsmEWTq7pjrhEWlzyrsMETnsn8B3ZneADg+73dAdSFpWlZIiL4M2eoGt0z7rsuDVdG8LNoLEjHhYqkeb5z2FL2Nue3pIApmLIIywIQ8+9jyeomRjkg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-7 (Postfix) with ESMTPSA id
 4562E18000BD; Tue, 18 Aug 2026 21:59:47 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [EXTERNAL] [PATCH] target/arm/whpx: fix whpx-arm reset hang
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <LVXPR21MB7009AFFB5732AC523B0BAD36ADA62@LVXPR21MB7009.namprd21.prod.outlook.com>
Date: Tue, 18 Aug 2026 23:59:16 +0200
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Pedro d'Aquino Filocre F S Barbuda <pbarbuda@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B2DD2786-C930-4856-94A0-FB6BDE8A38B5@unpredictable.fr>
References: <LVXPR21MB7009095A64089AACFA91DB10ADA62@LVXPR21MB7009.namprd21.prod.outlook.com>
 <A5E79D0D-C177-4B7E-9C5B-CB015E11A1C3@unpredictable.fr>
 <LVXPR21MB7009AFFB5732AC523B0BAD36ADA62@LVXPR21MB7009.namprd21.prod.outlook.com>
To: "Doug Cook (WINDOWS)" <dcook@microsoft.com>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-Proofpoint-GUID: RB7dZ6FI5yMTjyg4OA23cVaSqtwKazC7
X-Proofpoint-ORIG-GUID: RB7dZ6FI5yMTjyg4OA23cVaSqtwKazC7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE2MiBTYWx0ZWRfXxhJH4NCSwbcM
 2/HyyJumNzhFj1P+fIk0Xav3StVNq4pI7eLMkb6t/JgIUKatYcsf+6A6lEXgT3CDhP31/6N2DEv
 N6nHaAF6aH+uCrLyumS3iEwESPgDd8WDYdBvH/pyXrpL2xmXbbdNHJX2+7NP3UVoMQgo6iXl4EP
 9UR2m3dYsfOMKRIpwuGIzm/qcr9XIPQ6FVX5evFuMnBV3QI0o12DBER9k3YJ9UgSgDZu2awAuBr
 pk9rBNRJyqy1ZMDDnRCotXidYsmqXWGjQqq3lVW2PBpgmgK2IgSJbbZ46EOKMZ0hAPDSIz40yIG
 HV3Kk5HRG80Sn3c7vA7GXjRqicSzcIgLvNMKwDF9GSMhFAIGSn8aU5lOwNeLaU=
X-Authority-Info-Out: v=2.4 cv=P7g3RyAu c=1 sm=1 tr=0 ts=6a84d5db
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yMhMjlubAAAA:8 a=x3JJ1RZFXz7dmXPYApoA:9
 a=QEXdDO2ut3YA:10
X-JNJ: AAAAAAAB5uqQTYGZtiEDb/gpZBbV3h/PfjTj+WvdpuU8uuLGinY0ftcwhrynR384v8bvtgtJ75AzA3BPmwdOd+fj+CPTGqbjoe4qwNuXiNWvVMclycL0GvoaSNPOIVp19CsOe6brHNJD/O4hzJczIQy+wDvEmyjjEi2tbt4s4oaPlFKqwoCeYd9UtQiYCHovCE/hmbrSvwQmhLCpw+q9v6LWbuLGOTSm8jQVuSOGlh404kT0vo98woT/SDEb8lOUBT0EFf4pzg/sa/MPuvARw2iqRmZ2ZfRuAsW9yrP3Wqsgd0U8Hb3mC4zRYS0i7I8ShnLaw9nHaGo6dIJOf07YfXNcm9FQNaX0gxSVWyOsspSbcZDwqeMd++6Z9qbS2CchShAD0/UoVrY8yebU/vATUk9h2z1ogF6Gfk8gOcutXXrMJWqwEBVVBPo/s/c/8KnuOPgMxuRXpNEivspGN+mwGFtg6iSLwAvZme95BXVs44siR59TnSh26j5Ld0SW8gRDELzTBjWex92ba3berRUgAo/DNfq7ca/3RiVOIEJ+79P84/VNtyuh6DhXlQ5yvk5oASBR04r0hULD3ydrp2bGnZ1n/F27xTwbb1LEK1RdUVjfgpBTurfkMrsWpe5jM/x72u2IdRcYOwt24B3zh9sZ18ig6xc0M1P9NPsnCfKAk2c/IFsliiCx1+JR5CI+s+KZUr7Qk4AcyipO3cHvRg9zS/otfcvA8y564+EpUMGPKAWHYg2mlVzcQFBlgI6/cDI6Dk8lD85m+6qg8xpfWso3x2RL5ZfulAabRzvFelp8l56PN3RW/YMu8nRWc6mZu+2WDpdD095JMeWg6f3P9q/B8kLlyw/bMYmf+4f4+FjsdrpHcEikTqj2Q8SyCVxtPKzikYFLUUDm7jN5gJyqvYVDB9ksFRoKed5+vUNFgFFDakoCNneZ62D4dPKjG1OUgf1TeocXzp/3UsAnjmmYVgPlb2aFBffIYEl
 LI6xd/FxG1AIKsXGcgGva/94UJ2VBff3i2nesqYwjr/wJVX7e5l2iQisdM3yF0H7EV2km0yMTyb+FB3kDvIof+R+910DlVekVX86SPK27sqX4nBkSW1zXjHHZzX2NWaRpPbUt8J2Zcs3BetOImVl4vFGJYXYq0wzFGE0/M0XpC1UioCOVOJNdJ1k7wU82UGNRHaRMWLFjprZaOqGeBri3XC+Mk9P8s5mHccsb+H6Yz+WsER77UH0wJRK0XlDqVVR3Izq4jB1eBXiXLP8xOnvV1hCZpaQSj1HU70eBDEEz8/2FQ9WXvw4YWCV+WZKnX4kxMdWBkbRaNNGHJYP9UA+PNlYYvRL5Qe9ocpBiOJLqSVQ+RL7NRSXJ0uflcVpjXKj4cDCc49bgzdw=
Received-SPF: pass client-ip=2a01:b747:3001:201::49;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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



> On 18. Aug 2026, at 23:05, Doug Cook (WINDOWS) <dcook@microsoft.com> =
wrote:
>=20
>>> +    { WHvArm64RegisterCntvCvalEl0, WHPX_SYSREG(14, 3, 3, 3, 2) },
>>> +    { WHvArm64RegisterSpEl1, WHPX_SYSREG(4, 1, 3, 4, 0) },
>>> };
>>=20
>> Ow, carried this mess in formats from HVF, don=E2=80=99t think we =
wanna keep this
>> really.
>>=20
>> (switching to the ENCODE_AA64_CP_REG format across the board would be
>> better)
>=20
> I'm happy to do that.
>=20
>>> +
>>> +    if (level =3D=3D WHPX_LEVEL_RESET_STATE) {
>>> +        /*
>>> +         * WHPX keeps the "vCPU is in a low-power wait" state =
(entered when
>> the
>>> +         * guest executes WFI/WFE) in =
WHvRegisterInternalActivityState, and
>> that
>>> +         * state is not affected by writing the architectural =
registers above.
>>> +         * If the guest happened to be idle when the reset was =
requested, the
>>> +         * vCPU would stay suspended forever.
>>> +         *
>>> +         * StartupSuspend is the bit WHP uses to hold a vCPU that =
has not been
>>> +         * started yet, and it is how secondary vCPUs are parked =
until PSCI
>>> +         * CPU_ON releases them.
>>> +         */
>>> +        WHV_REGISTER_NAME name =3D =
WHvRegisterInternalActivityState;
>>> +        bool powered_off =3D arm_cpu->power_state =3D=3D PSCI_OFF;
>>> +        WHV_REGISTER_VALUE ia;
>>> +        HRESULT hr;
>>> +
>>> +        clean_whv_register_value(&ia);
>>> +        hr =3D whp_dispatch.WHvGetVirtualProcessorRegisters(
>>> +            whpx_global.partition, cpu->cpu_index, &name, 1, &ia);
>>> +        if (SUCCEEDED(hr) &&
>>> +            (ia.InternalActivity.IdleSuspend ||
>>> +             ia.InternalActivity.HaltSuspend ||
>>> +             ia.InternalActivity.StartupSuspend !=3D powered_off)) =
{
>>> +            ia.InternalActivity.IdleSuspend =3D 0;
>>> +            ia.InternalActivity.HaltSuspend =3D 0;
>>> +            ia.InternalActivity.StartupSuspend =3D powered_off;
>>> +            whpx_set_reg(cpu, WHvRegisterInternalActivityState, =
ia);
>>> +        }
>>> +    }
>>> }
>>=20
>> Looks good :) Although perhaps this is better as a separate commit =
from the
>> change above.
>=20
> Happy to do that too.
>=20
>> But not this bit, which should be dropped.
>>=20
>> The CPU model gets synced through this bit and registers that error =
out
>> through ARM_CP_NO_RAW should be behind a #ifdef SYNC_NO_RAW_REGS
>> block.
>>=20
>> The former characteristic is what allows for example -cpu cortex-a72 =
to be
>> used on WHPX instead of only the native machine, while masking off =
the
>> newer feature from feature regs.
>>=20
>>> +        if (ri && !(ri->type & (ARM_CP_NO_RAW | ARM_CP_CONST))) {
>>>            whpx_sreg_match[i].cp_idx =3D sregs_cnt;
>>>            arm_cpu->cpreg_indexes[sregs_cnt++] =3D =
cpreg_to_kvm_id(key);
>>>        } else {
>=20
> I'll need a bit of advice in this case. Without this change, we start =
getting
> assertion failures after fixing ENCODE_AA64_CP_REG parameter ordering, =
due to
> register read-back not matching after write. Do you have a =
recommendation on
> how to approach this?
>=20

For HVF, the way sync is handled when read back that wasn=E2=80=99t the =
same* was to put the affected
registers outside of the sysreg sync array and do it manually for those.

Given that we don=E2=80=99t have full save/restore support yet (the GIC =
state sync is missing for now)
it=E2=80=99s ok to comment the affected sysregs from now and return to =
this later

* notably, on some HVs, the timer registers can be ones of the oddballs =
around that front, as they can keep counting when the specific vCPU is =
not running=

