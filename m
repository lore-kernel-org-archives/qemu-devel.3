Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA59CA5FAA
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 21:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBJ5l-0002Dy-PS; Mon, 28 Sep 2026 17:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xBJ5X-0002DL-Ll
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 17:40:43 -0400
Received: from ci-2004d-snip6-3.eps.apple.com ([2a01:b747:3005:204::24]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xBJ5W-0000Tf-3k
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 17:40:43 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-7 (Postfix) with ESMTPS id
 3A8481800150; Mon, 28 Sep 2026 21:40:39 +0000 (UTC)
X-ICL-RepId: 01a0e9f6-7880-70d7-b205-ec6748721e3d
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0PWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkN7SXJccSkLXQlOdlsaXwc2fVULWw4oH0cJT3dZAlp2QQs5By1CBUICXBxaDkMKUBxcVlUfCUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1790631641; x=1793223641;
 bh=nbKQ34KUlqO+pS/NBbedJtwYkyXSlaZdhYwIOr4GXHA=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=U+T5RS2EMHtj0f12N2v7XWOMFWXSWfU49iNNWmgpzlTd/yS1f6pOWRLNGtx75TSjyOCIxBjtWGpS8gOrRNMDjWEBxZ/VAL+0tTH+Cd/zVHmJK+e1f5+XL1JAG//vNw4+N4rMOH7VbNiPYziQLnWeVCaLcNDT+JxuWutQYhE0Co7U0Gp9sVRlKuNlE1j4dUhxmQ/LfukZJCTvi2lW6I+Xh5NhdNyyBmPKSXc6IlIk5TQWcahmb8fnL7LhouySwFckxiT79qLS2/WNonKRsu+z1XmtKr+VpG6S0h3DO6OxF/HjzHRx5rldcPSMXGbYSl3ArJc4RxZXEFIOh9qCUBoh0Q==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-7 (Postfix) with ESMTPSA id
 EF43E180016F; Mon, 28 Sep 2026 21:40:37 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH v2 1/5] hvf: arm: advertise ID_AA64PFR0_EL1.GIC
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAFEAcA8XVZVehzwCAfy_a3V+KFfxOErhxo3dg1NObmco9kEj1Q@mail.gmail.com>
Date: Mon, 28 Sep 2026 23:40:26 +0200
Cc: qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3B1A1FB9-06E6-45FD-869C-707D451D12A4@unpredictable.fr>
References: <20260904043742.96613-1-mohamed@unpredictable.fr>
 <20260904043742.96613-2-mohamed@unpredictable.fr>
 <CAFEAcA8XVZVehzwCAfy_a3V+KFfxOErhxo3dg1NObmco9kEj1Q@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-Authority-Info-Out: v=2.4 cv=T9KBjvKQ c=1 sm=1 tr=0 ts=6abaded7
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=MdgNKwDIt_fzaIJBeHoA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA4NiBTYWx0ZWRfX0R5ir1uaEKFh
 fZP+qj+waqNLVJxKSZmLpkUY5RDx5f4V0iQ09SKy4MXY0hvOM4vJIgaG4jyTPHju5MPqPgRpyhO
 qlWfgRM21derga+ut+ZXoC++8d8CfKIuCOSQppX4S6HABtgTp9f4sOhWcmp5YO3Kqx2ThBM3nuf
 vmoIVQt3hK9YCkDjnIP76FNW0MPpsJUK13FA/nTXfoCdf54YM4OD4MJLKaJBSIzlO5oX4vxyXi4
 3iKiHKKvQtXwMCf0MBneHIyHzzjHKlVBv9pHK5MxztxKyE4Ilch9O1TpgXfWfJubGM3pGfDA8eu
 6bQOuYgaQp+yAhYdjRz+3JB4mawpXtqR4ZtmlGoxlyocE5Vqnk2NGK2nqU4cSU=
X-Proofpoint-GUID: QG8zfuTgNc3kmk_q3hr6aCSFUl6KsPWE
X-Proofpoint-ORIG-GUID: QG8zfuTgNc3kmk_q3hr6aCSFUl6KsPWE
X-JNJ: AAAAAAABCNv/Ysnfy9FPrGS9T9GDTkKslQCCVc9wU6ZTuzhr2zvvoiDXRvaBnyfemQ/NI9gDXCiTHUunZxsojNBdHubM2ADtVlRsMyRf9GQcdpajNYoe8DdjAMd8GtwFNL6AoSrtZll4caSnSA894AvRmYa5wdBuNoNOywzovrFUKOiHCD8iDmFwAv3SHDYLf71i21QVzPWnE31X9UNw1fqiJBMENVM3DS4HLYKWaKrkye+cZtI4drzh2xv/O5hZsA/w12APbkQzq+JbzrnXwoeAL1mDNMIkleLmvFNO/GmNxjokeprogOjuJVXoQjCLzf2uYNM3VoEslGiw8laWn5tzdcNOoOSTz2ypDYRE8sQHLqMaWVp46SVIFzux6hz4eVgQbeh1Z/ANq6F+KWvGFlq1ToO3Xmc+6SVjF6GhEI4vZibBpRLpWm4u1bwbo0hSLkNW9qjVbZZv7vX12QZxtyYw1iSW5lEhVMGKrT7TZEhTGj3QOUHbnb11Sak6uM4gEEM3gHYbFWZk5LaiMfna4dkXHRJ3913QP+BjwCwUWjGIxDqm52ZyB1oeJ7Vnrtr0DcDmrPz9QKyxY4DS5Qr+qQhR/u3FVSjdUvbn1ZKaZxb7rbjp/muI4ynv/TSHPcIYG8bKkAVIX71jDfaMQU0Yol2ShqWRKGQOneWMmobaWqdlED9ZifNsYZVPKGBVVRudiFYdXnnUAt64OuZ2W6192TlNoevzzLy8n5tXthjitHdoS+dOz5MUleDymm/d/6UlAz9PlAB7tUCSNqAK62bUS96ZcrGPWl3v52S2go0FlyKK4Gwazs9y2k9tIhFhpuFE3fTVELX4GShVKjxxKwC443GiMRUcuz6pVtm2Sj3n7fAXbfcZVM+ENXnoM0gr6ankKtXa4dYTE4XF0dj8HWxm5C17OFjSBz/3J5xNwlDSZd3uE+PE984RR9KD1YJoID5SIJkcFIx+5s8RJRn//9u2snik+MeLrFF
 5nsxxtsrcjtu75YBrkaEOmsVt4FEaK03Az227OwMZ5+B6pExMAF00vV/foVwrafBJoZGtDWTW4NHvInndusO0z6jGXx2jSQfjCK8hRIWM7yTQWCtWz1jEyLI5Y0oRT9lUY5JwGpku6l+i2m7+oKvpjOVnyjPu7XKViA/ZVwiZx4RssOAAxnFEjAr+FdyZQAeikvMrIjGi82Ne6yo5AFyy+PxYmyZ6MWfVroskgs0GgF7LZ2uXiE1iJyt2eyxtB5d9YUVpMJ7FNTNbu21sKy0V63nYR7FhQKt/xXjX4Iwk9jZhejvbmFXPHjZZtrPYKvaudVPrGC4mPCEeyFJ+v8C/9oSEd+8Ltpt6M+A724K4pa6/L/TnMumjSKSG5Dzv+m30yGxrGewz71HDqowW0LrJGAdHU0QkJ59GFWTJoKlnc65rSlWr0zKS2hymt58O4P/LHyyRHjzegsEiJ7rKIMBVyzQfdgB5YXNA/6Yx
Received-SPF: pass client-ip=2a01:b747:3005:204::24;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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



> On 28. Sep 2026, at 17:54, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Fri, 4 Sept 2026 at 05:37, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>=20
>> For the kernel-irqchip=3Don case, advertise ID_AA64PFR0_EL1.GIC.
>>=20
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>> target/arm/hvf/hvf.c | 12 ++++++++++++
>> 1 file changed, 12 insertions(+)
>>=20
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index da3ec521fc..f881d6cc67 100644
>> --- a/target/arm/hvf/hvf.c
>> +++ b/target/arm/hvf/hvf.c
>> @@ -1229,6 +1229,18 @@ static bool =
hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>         FIELD_DP64_IDREG(&host_isar, ID_AA64PFR1, SME, 0);
>>     }
>>=20
>> +    /*
>> +     * On HVF, kernel-irqchip implies GICv3.
>> +     * The kernel-irqchip=3Doff,gic-version=3D3 legacy case also =
supports
>> +     * the host CPU interface but advertising it in ID_AA64PFR0_EL1
>> +     * is not implemented yet.
>> +     */
>> +
>> +    if (hvf_irqchip_in_kernel()) {
>> +        /* Advertise the GIC system register interface */
>> +        FIELD_DP64_IDREG(&host_isar, ID_AA64PFR0, GIC, 1);
>> +    }
>=20
> How does this interact with the existing code in
> hvf_arch_init_vcpu() that does:
>=20
>    pfr =3D GET_IDREG(&arm_cpu->isar, ID_AA64PFR0);
>    pfr |=3D env->gicv3state ? (1 << 24) : 0;
>    ret =3D hv_vcpu_set_sys_reg(cpu->accel->fd, =
HV_SYS_REG_ID_AA64PFR0_EL1, pfr);
>=20
> ?
>=20
> env->gicv3state should be non-NULL for both HVF and TCG
> GICv3, I think, so aren't we already advertising the GIC
> in ID_AA64PFR0 ?

Hi,

Without this patch HVF GICv3 doesn=E2=80=99t show up, will look deeper =
at why that check
you noted is not effective=E2=80=A6

Maybe it=E2=80=99s a question of ordering?
>=20
> thanks
> -- PMM
>=20


