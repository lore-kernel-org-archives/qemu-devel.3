Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 583F9105F794
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 10:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0zsO-0003ls-L2; Fri, 13 Mar 2026 06:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0zsL-0003la-8z
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 06:36:14 -0400
Received: from p-west3-cluster1-host3-snip4-7.eps.apple.com ([57.103.73.158]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0zsG-00042b-AM
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 06:36:11 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPS id
 5A09E18000F1; Fri, 13 Mar 2026 10:36:04 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773398166; x=1775990166;
 bh=fxgfRdILvlzByfz3jxmGyrXitphNOUrqyYZui95nFSY=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Z+miYyKwMP4uzkVofuzOdUxxcpC6Dh/DpromUjH5tfzCe9e5k5fXd8fms7kuQxUlyk6KoUcTactPEnvSvbXaS/u8vrKfN4ExlQtbhCBMbRYE5sXTTHNECaLCPQqQm1ZhJUlB5yprO7bHvMEKYgGDjSRTTqrN1rU2/gATVlK9mZCcgtZZEvPLBSf9JiAJJ62/kuS1Zfsw7e8wXWgTHI0YbsGtfpzrcJD96cPNV1waQoDzdSZfhtTgVTdKV+AUXxjeNg3lQVA7wcOARdU10EP5e6xrNmErAdVly3s7jMGUbXHkjRVuBR8+d/h6IhjkUeCDVzJdigCEa0VQTWabD3fKBw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPSA id
 91BCC18000B5; Fri, 13 Mar 2026 10:36:02 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v2] hvf: arm: fix Windows boot with kernel-irqchip=on
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAFEAcA9GctVQo_Xc7EyfhinXza-8Kw0SOxwrwpyB1=Br+XjHpQ@mail.gmail.com>
Date: Fri, 13 Mar 2026 11:35:50 +0100
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4511C71E-EC35-450F-887F-6339EEBBD96E@unpredictable.fr>
References: <20260309114651.18825-1-mohamed@unpredictable.fr>
 <CAFEAcA9GctVQo_Xc7EyfhinXza-8Kw0SOxwrwpyB1=Br+XjHpQ@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA4MyBTYWx0ZWRfX04zaEZTcq/gK
 qaMoRdAOVc3BC8mmbb3myNwSrInY8EGsv++K0E3fiUlx0LTyPmqZW+hUU0/ZpPr0MFg9WwW9c+I
 rTB8+2IrIi+2uJvzg7uY1zrgB4Sc4rYXJkb3f0NCb6XX5V+94KrXV6voiU4Q87p2nSJAvwuyzQG
 +Z4/AfDWm8wVoplrmwuTeh6tJLXFUa0OGuiiRyGwVRfksvQ3ypF1w34lSTaqjD9tOqS1ZrnYjvA
 ZGAY/d2Zl49O+uNWdOzAm9GQfFc+3mqCv4A0j+sRle3tvGfPvPuJQDv6GQBBAwGIH7YzsfyCjyY
 /oFAn5e3imX86kUp1D69ee63A7Y+NCp612vQbKWun4b5rdOfNxCDjmdRZxTPFk=
X-Proofpoint-GUID: NqeylhQGrrDB4-Ig_H7wwz8tl3D8oQRy
X-Authority-Info-Out: v=2.4 cv=Yb+wJgRf c=1 sm=1 tr=0 ts=69b3e894
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=de_huAmjUc65hNcE37IA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: NqeylhQGrrDB4-Ig_H7wwz8tl3D8oQRy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=946 clxscore=1030 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603130083
X-JNJ: AAAAAAABD1JtkGhuTAlkVwr2VsUq13b49J5pdFmGNQLg132pCH77Ulq9ZMklC4/8yeHFrvydSduqVEgvxtlzN5HU1pdzcQhN3a9ZbF1uPAC0nxT+xnj3QBgzaY3eE34FV+laqpVc10tQ0S+OA2859FEdj1SomwB2GJtJk/0aUq7s0Be86DNUYaiL7GDu6LhY3FKUeYCr/97bqYvJdz/kk0xU8344lHU2/OTx6H5MeRGfImOaBsHSideYbnsD44RZBNKeinTR4+ZHVx4iqhwECyoT0IFZJkx+hqO14vI/Mz2DJcSX8b2XPU7VfroShL81bl6FSqUNDGfz7uzsxY/nJnDLvBbAOB+WcQlbNcg+Ejq0PLyXlSCW8f+7xfhZXI52jaodmUfPYy8rR3q3SUvMdDmcO2XfAtSt7pMNi+1ScCOtghsgcHUVoe6kvHJaFMgBfqL9Kve/fbLU/yTpSYDTfgvITNF1rsDR2RbBKYVctouHLJOPDY5cwgyUZn1dWs3JPEw6MNcyyQP2KYwkSlhHsO2Oj/bh2VnpHcawdzle2NAx46aXDSE0hTFKUGboAwZaCtOJit5hBIssWtl5JCNeqGOEPG9Y6gO6rD35/MDmxt3jfCaSQnBDgkxkj/iqAYbbtQ==
Received-SPF: pass client-ip=57.103.73.158;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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



> On 13. Mar 2026, at 11:00, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Mon, 9 Mar 2026 at 11:46, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>=20
>> Apple headers say:
>>=20
>>> When EL2 is disabled, PMU register accesses trigger "Trapped MSR, =
MRS, or
>>> System Instruction" exceptions. When this happens, =
hv_vcpu_run()=E2=80=AFreturns, and the
>>> =E2=80=AFhv_vcpu_exit_t=E2=80=AFobject contains the information =
about this exception.
>>=20
>>> When EL2 is enabled, the handling of PMU register accesses is =
determined by the PMUVer
>>> field of ID_AA64DFR0_EL1=E2=80=AFregister.
>>> If the PMUVer=E2=80=AFfield value is zero or is invalid, PMU =
register accesses generate "Undefined"
>>> exceptions, which are sent to the guest.
>>> If the PMUVer=E2=80=AFfield value is non-zero and valid, PMU =
register accesses are emulated by the framework.
>>> The ID_AA64DFR0_EL1=E2=80=AFregister can be modified via =
hv_vcpu_set_sys_reg=E2=80=AFAPI.
>>=20
>> That documentation turns out to not be so accurate, with the =
determining factor being whether the vGIC
>> is enabled instead of nested virtualisation. If =
ID_AA64DFR0_EL1.PMUVer =3D 0, Hypervisor.framework doesn't
>> give us the luxury of having PMU sysreg accesses trapped to the VMM =
when the vGIC is enabled.
>>=20
>> As Windows really wants at least a single counter PMU, give it even =
when
>> using the kernel-irqchip with nested virt off.
>>=20
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>> target/arm/hvf/hvf.c | 10 +++++++---
>> 1 file changed, 7 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index 8aa59a1f77..136761b429 100644
>> --- a/target/arm/hvf/hvf.c
>> +++ b/target/arm/hvf/hvf.c
>> @@ -1187,8 +1187,12 @@ static bool =
hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>=20
>>     clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar);
>>=20
>> -    if (hvf_nested_virt_enabled()) {
>> +    /* Windows really wants at least a single counter PMU... */
>> +    if (hvf_irqchip_in_kernel()) {
>>         FIELD_DP64_IDREG(&host_isar, ID_AA64DFR0, PMUVER, 0x1);
>> +    }
>=20
> This comment and the code don't line up. We say "Windows wants a PMU"
> but then we only conditionally enable the PMU. If the irqchip isn't
> in the kernel then presumably the PMU is still disabled (or at least
> not advertised to the guest) and Windows still falls over ?
>=20
Hello,

If there=E2=80=99s no Apple vGIC enabled, accesses to PMU registers are =
routed to the VMM. Windows tries to access to the PMU registers anyway =
in that case. And that allows to get away with (very) stub-like handling =
that does =E2=80=9C=E2=80=9Demulate=E2=80=9D=E2=80=9D the cycle counter =
just to boot Windows: And as that has exactly zero accuracy we don=E2=80=99=
t want to expose it for anything else.

If the Apple vGIC is enabled and there wasn=E2=80=99t an ID register =
write made to enable the Apple vPMU, then instead of PMU writes=20
being trappable to the VMM, what happens is that an undefined =
instruction exception is injected to the guest. And that makes Windows =
crash early.



