Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5DBD49C9E
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Jan 2026 15:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmDBB-0005lM-Jc; Sat, 31 Jan 2026 10:46:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vmDB5-0005kU-6U
 for qemu-devel@nongnu.org; Sat, 31 Jan 2026 10:46:27 -0500
Received: from p-west2-cluster1-host12-snip4-10.eps.apple.com ([57.103.68.43]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vmDB2-0004np-Lw
 for qemu-devel@nongnu.org; Sat, 31 Jan 2026 10:46:26 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-2 (Postfix) with ESMTPS id
 28FFA18001A7; Sat, 31 Jan 2026 15:46:17 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769874381; x=1772466381;
 bh=H6joVGuvE/X15FhFEzuViaCJgb2+hKv5Sm/vONzF3fg=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=HsAA2T19GvUN52X+1A3LPKepgQ8ioIYqh6mjvH7AQ6ZstdKFHXoqrKoR+9uysa6cn/gLs6o1HFoNuLj87d2CZx9c5k7xin+lhuzeZcu6wv/osg/TgyAlz3uTZJPWW2tZVPHOxTyYqcowntM3o2UMWyFc1C72HdgUWvhZd9ofWQS2HTSZ+a/wJuEzNdCx8FvOAVQ5YsrqFow4y2ULJh/wu2owK20ADo2uOhuCjWaceoDVM8pNZV44h1Rr5sjfUdHychhB2pZU7d1uWAVciOitYXoIaAUcsSDokbuoLzwxaMJi9OQM0tDvFgCivztgX6Xr3BStpDbtocl25l788tiVbw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-2 (Postfix) with ESMTPSA id
 093061800AB8; Sat, 31 Jan 2026 15:46:15 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [RFC PATCH] target/arm: implement FEAT_E2H0
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260130181648.628364-1-alex.bennee@linaro.org>
Date: Sat, 31 Jan 2026 16:46:03 +0100
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3E90610C-79A1-41D0-82A0-67CCEEC5EB7C@unpredictable.fr>
References: <20260130181648.628364-1-alex.bennee@linaro.org>
To: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-GUID: NcwT1A3jm6c-j3Au3rIBp-S3pHPEbZRT
X-Authority-Info-Out: v=2.4 cv=MIttWcZl c=1 sm=1 tr=0 ts=697e23ca
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=AMEpwmUF_oxudWCCCUUA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: NcwT1A3jm6c-j3Au3rIBp-S3pHPEbZRT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMxMDEzMiBTYWx0ZWRfX9nLdZCJUqolv
 tPeuwG6HCxgn3WRYdWwFyYYogECXtJCRN6vcT0sAKw3stWMyalnhk0ZfiWaCvtObiqT2vfPqk4q
 l9iUZIm42HSd6XTb75MllvkBUgWEU7r/+BxO8ejIgcq53eJnhuiKRQu6Bn+glLxaHxtUl9jb16/
 zeMoOqb8AtY1PfmC39CN3gb4xw9Ix0cJ0P8VGn+LwQrqs7Z0rx7wUfEL44hKdBGUjPS9YIsO96I
 JW4zwjbRKx48uwgJA1jEYhkXdHJkNFzo7z2Eja2kqst508bWgUmAGn4I5bnv8fUe1lP1Hmhl9V+
 a6EiuUKR2uSRpE+saUy1jXnl083HnmUWb6G9ZQrGq43BZH6Y2MAo3H1f+o0y70=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-31_02,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601310132
X-JNJ: AAAAAAABgQrNb/Kj1fla+5ijrPvt1+ogQwzyICSQH8c4N/w6bthFpU3KrgUi9Aqprl5uYhkeBe7ovUY5fUnMyuGFjVdegYONqM8CNFeryP0uSkuEiBkLSirPf29zkh8UxtpJLQLRwe9QkSHNl78hTGbNVBrCl2ux2JVBVRGf0Sr0xbQSUljYvUawQ78l8SYtoz0UU16lPOkAwjKi3sAqqNEosG8ozKO5Fg0eKt8hm+UeDlqLMN8KeaOqpov7ubYUx9tQJNTUJFzldHwtd6Cb/QPvYhUQRhXkzwwk+k6IMZsQA7erohylBc2d959ZMDgHmcYp1p9mveUcZ4MF2HRmY9VxpJ6jwdHn7XzKvGQjOqyKrEfquMUCZObcs+EhPSji2gqJfTYN1wacd4IZaQPGmBVMKXHHx5CNt4hRmErPx6jN9N2Hn1oQOxgPZ79JowptMwzJGXyx1FCUGvvM0XjaBAfR/Rf+cH73RSq3jCTP2qn3c0QlHWGEj6vPiAmPSIIUmdVLWYdgznudwMzt6S4g24RELTSh2H0UWVX6Agq3NOGiZLtddWrsquxvh3Hbyyo8z5EUD/oaYi2hwIAgP38pUhumnz8027xLuBI+z3c1oxr10GLvBKGmVMqm
Received-SPF: pass client-ip=57.103.68.43;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 30. Jan 2026, at 19:16, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>=20
> FEAT_E2H0 is a formalisation of the existing behaviour of HCR_EL2.E2H
> being programmable to switch between EL2 host mode and the
> "traditional" nVHE EL2 mode. This implies at some point we might want
> to model CPUs without FEAT_E2H0 which will always have EL2 host mode
> enabled.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
> ---
> comment: I've left a fixme? for HCR_EL2.NV1, I await guidance on if
> I'm reading the spec wrong.
> ---
> docs/system/arm/emulation.rst |  1 +
> target/arm/cpu-features.h     |  6 ++++++
> target/arm/helper.c           | 14 +++++++++++++-
> 3 files changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/docs/system/arm/emulation.rst =
b/docs/system/arm/emulation.rst
> index 3f30ea5a30e..74359f3e844 100644
> --- a/docs/system/arm/emulation.rst
> +++ b/docs/system/arm/emulation.rst
> @@ -53,6 +53,7 @@ the following architecture extensions:
> - FEAT_DotProd (Advanced SIMD dot product instructions)
> - FEAT_DoubleFault (Double Fault Extension)
> - FEAT_E0PD (Preventing EL0 access to halves of address maps)
> +- FEAT_E2H0 (Programming of HCR_EL2.E2H)
> - FEAT_EBF16 (AArch64 Extended BFloat16 instructions)
> - FEAT_ECV (Enhanced Counter Virtualization)
> - FEAT_EL0 (Support for execution at EL0)
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index a7ca410dcb4..b6ef328fe0a 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -347,6 +347,7 @@ FIELD(ID_AA64MMFR3, ADERR, 56, 4)
> FIELD(ID_AA64MMFR3, SPEC_FPACC, 60, 4)
>=20
> FIELD(ID_AA64MMFR4, ASID2, 8, 4)
> +FIELD(ID_AA64MMFR4, E2H0, 24, 4)
>=20
> FIELD(ID_AA64DFR0, DEBUGVER, 0, 4)
> FIELD(ID_AA64DFR0, TRACEVER, 4, 4)
> @@ -1376,6 +1377,11 @@ static inline bool =
isar_feature_aa64_asid2(const ARMISARegisters *id)
>     return FIELD_EX64_IDREG(id, ID_AA64MMFR4, ASID2) !=3D 0;
> }
>=20
> +static inline bool isar_feature_aa64_e2h0(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64_IDREG(id, ID_AA64MMFR4, E2H0) =3D=3D 0;
> +}
> +
> static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
> {
>     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, MEC) !=3D 0;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 655ce73ee1b..27b5fb01827 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3773,7 +3773,8 @@ static void do_hcr_write(CPUARMState *env, =
uint64_t value, uint64_t valid_mask)
>     }
>=20
>     if (arm_feature(env, ARM_FEATURE_AARCH64)) {
> -        if (cpu_isar_feature(aa64_vh, cpu)) {
> +        if (cpu_isar_feature(aa64_vh, cpu) &&
> +            cpu_isar_feature(aa64_e2h0, cpu)) {
>             valid_mask |=3D HCR_E2H;
>         }
>         if (cpu_isar_feature(aa64_ras, cpu)) {
> @@ -3797,6 +3798,11 @@ static void do_hcr_write(CPUARMState *env, =
uint64_t value, uint64_t valid_mask)
>         if (cpu_isar_feature(aa64_rme, cpu)) {
>             valid_mask |=3D HCR_GPF;
>         }
> +        /*
> +         * FIXME? HCR_EL2.NV1 is only meant to be RES0 if
> +         * FEAT_E2H0 is not implemented with 0b1110 although the Arm
> +         * ARM doesn't explicitly state it is RES1 with 0b1111.
> +         */

Hello,

With 0b1111 both VHE and nVHE guests work.

KVM in that case supports both (with an nVHE cap opt-in), and I can=E2=80=99=
t find a mention of RES1 for this in the spec,
So this comment might be a bit confusing.

0b1111 =3D E2H being RES1, but NV1 supporting both 0 and 1
0b1110 =3D Removes the NV1 =3D 1 support

It=E2=80=99s highlighted further in the ID_AA64MMFR2_EL1.NV bit =
documentation, where both 0b0001 and 0b0010 define
the HCR_EL2.NV1 bit as implemented.

>         if (cpu_isar_feature(aa64_nv, cpu)) {
>             valid_mask |=3D HCR_NV | HCR_NV1 | HCR_AT;
>         }
> @@ -3820,6 +3826,12 @@ static void do_hcr_write(CPUARMState *env, =
uint64_t value, uint64_t valid_mask)
>         value |=3D HCR_RW;
>     }
>=20
> +    /* Strictly E2H is RES1 unless FEAT_E2H0 relaxes the requirement =
*/
> +    if (arm_feature(env, ARM_FEATURE_AARCH64) &&
> +        !cpu_isar_feature(aa64_e2h0, cpu)) {
> +        value |=3D HCR_E2H;
> +    }
> +
>     /*
>      * These bits change the MMU setup:
>      * HCR_VM enables stage 2 translation
> --=20
> 2.47.3
>=20
>=20


