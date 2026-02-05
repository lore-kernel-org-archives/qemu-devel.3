Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057F3EC1EB3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 13:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnz19-000696-Fq; Thu, 05 Feb 2026 08:03:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnz18-00068p-8D
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:03:30 -0500
Received: from p-west1-cluster3-host3-snip4-4.eps.apple.com ([57.103.66.67]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnz15-0008DT-Ou
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:03:29 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-11 (Postfix) with ESMTPS id
 E59F01802B52; Thu,  5 Feb 2026 13:03:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770296604; x=1772888604;
 bh=NmeWYQOZK1LwiVf0V/Ut11XoSDrd0pmn72unzlb54JA=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=HRwpaatq7L0oQOu2thCIXFfGp4WrYymWmgKURa5N5w5roD8sHs8FOkpDQ9XMLoGq1SV61MOjl1ALSDc+lGeceCB9ChtOXnoaPsEG0U2XzGwvvTiQ0jn2D41Egdy4u9DinFtzjTEhzunE2uJPo8gMzIaok6W5l0EOcxmTFxpNHvNq8mLR5gy5sXo7NMfq4vryQIsYROIjCT0ty+ixAW7KfgKwKy8ebmMuyS98VVc6T8qDpgewKWIdoAgEIq9L0mYcuWC6oax3JCMsTQc0QSLzGkf6tDkqLUci1NWdolqAw4J3L2hk/aQPW48qX4ErQ2102nm5OJzkx2s96LVF5SXGsg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-11 (Postfix) with ESMTPSA id
 E019E1800861; Thu,  5 Feb 2026 13:02:38 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v2] target/arm: implement FEAT_E2H0
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <877bsrnzvd.fsf@draig.linaro.org>
Date: Thu, 5 Feb 2026 14:02:26 +0100
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <10F9A8B0-27FD-40B3-9299-E27883823423@unpredictable.fr>
References: <20260204131353.2977855-1-alex.bennee@linaro.org>
 <3e6ab807-37df-40ba-840e-4693071691f7@linaro.org>
 <877bsrnzvd.fsf@draig.linaro.org>
To: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5NyBTYWx0ZWRfXwGyk+fVKR/y5
 VgXyJnPMb5H+pqBQpk1XFGgeHOhbKqHBwYs6c/SN3CVMz/c+t4XKb7O+rot4rWGYDSnWXnqvDCi
 pAIZNgsxMc7P7JQEy8NC4qmBMWdup+WO5Cqa8NgY+zIQM9jqDofh2g95Yqv9LWHiw1Vt/t8a6Lc
 ypGHKAtmbWWjCBvPjnHMeGVg8/1DefFxFiKFs3CrZsYsCEoHYcgQF/LdhLyrIr9O2QzMkm5Vg3a
 zR7aGBCyd7UUwfVsHq+/89mSW/wOL6LV5+WFy97hFWI65iGhRX8urTXVMDUZI0HSElsCk3tE5Ya
 fdhuj6c3PJPWalf/nMfgGxcCzDoa+Gf3Tf2DjgHY2u+BjrDTzW7SwHtZdKiLus=
X-Authority-Info-Out: v=2.4 cv=LdgxKzfi c=1 sm=1 tr=0 ts=6984951b
 cx=c_apl:c_apl_out:c_pps a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7CQSdrXTAAAA:8 a=KKAkSRfTAAAA:8
 a=rZRj8MeRHMk8l422HKYA:9 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ZJFHKjkSyZhoOFfOsvxUU8J1eFt8ZKfT
X-Proofpoint-GUID: ZJFHKjkSyZhoOFfOsvxUU8J1eFt8ZKfT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 clxscore=1030 spamscore=0 malwarescore=0 mlxlogscore=773
 adultscore=0 suspectscore=0 bulkscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050097
X-JNJ: AAAAAAABwnf3b3V4RzhlV92jYFu3I8rMJO70jhF2cqpXS4m3bdzNVRq6jSa/GoZuGTg0iyjnEbflTYr00hZWgjRJgOQoJsoOkT8uFMyiiL5r4+1iVgPMzrAdVZ7qKCHd7XFbI6eAiQwbi9LeMP505cnsvjkpMNAlCPuCAsE5ZKJICEN8TCTNI1Voz75iifA5pAU5YQKJ2+g6jpN9uVd417nrzhO2QZFKcCvW+zOwX7J3fnhNUle3s9lz+6ca1LPv78FA1MAa0Pe1d8M8095Ue3AFI3IjMpZ9ZS3Nsnto0v8RdTVEaTu3pETX9mbyFZvrQJZR6qwFSsYZkqDZZf4obNzmdY7KwaUwnI3luEQ0yCCtvOX1j5b1G2LPMwilGsgX8eXGvFdcXaPAPpXcmS5uQC+A1PBDt8B7GhT4ZQEsnfV6dy3Qye/fFF9ThUheUTMMeo4UFeRtyQZZTkWAGOWR+RYgj4FGKCsHnBsUH9tpUcCZEjdNT6D6jWZy2oMCeMrXNqeNMUio8k8mgyhz+RkMtK+wGRlXMM84xdy+6fjZZRDr2Xa18bHTjZFLLVDsRbmd16+B1esY9FYqbTUgtNDftszPBvUKAD7cQkNW3cO902P1tG1vg50F/p9JAJNSoaULXp8DAAR8Q6U=
Received-SPF: pass client-ip=57.103.66.67;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 5. Feb 2026, at 13:23, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>=20
> Richard Henderson <richard.henderson@linaro.org> writes:
>=20
>> On 2/4/26 23:13, Alex Benn=C3=A9e wrote:
>>> FEAT_E2H0 is a formalisation of the existing behaviour of =
HCR_EL2.E2H
>>> being programmable to switch between EL2 host mode and the
>>> "traditional" nVHE EL2 mode. This implies at some point we might =
want
>>> to model CPUs without FEAT_E2H0 which will always have EL2 host mode
>>> enabled.
>>> There are two values to represent no E2H0 systems of which 0b1110
>>> will
>>> make HCR_EL2.NV1 RES0 for FEAT_NV systems. For FEAT_NV2 the NV1 bit =
is
>>> always valid.
>>> Message-ID: <20260130181648.628364-1-alex.bennee@linaro.org>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> ---
>>> v2
>>>   - new helper and properly handling NV1
>>> ---
> <snip>
>>=20
>>> @@ -3801,10 +3802,13 @@ static void do_hcr_write(CPUARMState *env, =
uint64_t value, uint64_t valid_mask)
>>>              valid_mask |=3D HCR_GPF;
>>>          }
>>>          if (cpu_isar_feature(aa64_nv, cpu)) {
>>> -            valid_mask |=3D HCR_NV | HCR_NV1 | HCR_AT;
>>> +            valid_mask |=3D HCR_NV | HCR_AT;
>>> +            if (!cpu_isar_feature(aa64_noe2h0_and_nv1_res0, cpu)) {
>>> +                valid_mask |=3D HCR_NV1;
>>> +            }
>>>          }
>>>          if (cpu_isar_feature(aa64_nv2, cpu)) {
>>> -            valid_mask |=3D HCR_NV2;
>>> +            valid_mask |=3D HCR_NV1 | HCR_NV2;
>>=20
>> Why add NV1 here?
>=20
> My reading was if you had FEAT_NV2 then HCR_NV1 was always valid
> whatever E2H0 might say. Unless we can validate we don't get
> contradictory ID values elsewhere?
KVM with nested virt enabled out of the box exposes a virtual machine =
with
VHE-only L1 and above, with no allowance for an nVHE nested guest past =
L1.

In the Linux kernel in arch/arm64/kvm/nested.c:

case SYS_ID_AA64MMFR4_EL1:
/*
* You get EITHER
*
* - FEAT_VHE without FEAT_E2H0
* - FEAT_NV limited to FEAT_NV2
* - HCR_EL2.NV1 being RES0
*
* OR
*
* - FEAT_E2H0 without FEAT_VHE nor FEAT_NV
*
* Life is too short for anything else.
*/

And after taking a further look at the machine readable spec*, 0b1110 is =
valid together
with FEAT_NV2, as nothing there says otherwise.

* =
https://developer.arm.com/Architectures/A-Profile%20Architecture#Downloads=

>=20
>=20
> --=20
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro



