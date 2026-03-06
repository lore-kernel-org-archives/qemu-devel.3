Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748DDF01822
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 10:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vySHS-0004ax-5F; Fri, 06 Mar 2026 05:19:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vySHH-0004a0-5f
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 05:19:28 -0500
Received: from p-west2-cluster1-host9-snip4-1.eps.apple.com ([57.103.68.104]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vySHF-0002tg-2J
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 05:19:26 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-10 (Postfix) with ESMTPS id
 7274C1800165; Fri,  6 Mar 2026 10:19:19 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772792362; x=1775384362;
 bh=EqwQB3y4hXSutmL4vWnprQ1R4H/+K/VOa7DWyR+tJBE=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=QfvGfnEwAdsc84quM+UQ7sWVblYkW8ni6S5fVj87JGryBo/YcAHs8cG2m7WaMuIRGFvchZ+5bjLG4UHi93ZMCtA07a4FB6kpNW+ll6HaRWeDG8dUnXlhQN6BeqKVgkqsFb6kja+wcAMCOoHVXYRX8nX0PimgpzeFo50zqiccmmIwZwr+kdorKa0ZhVc954xxAK0uyj9A1/P4tZKzHxLWaPs5NCH00Z5HmCWlIWHSM4/6g4dhXqYgXUG3r3pY+aUpOjB5NOZ1nf6wt6PnQTmhD/bb71DYQv53AOCf6yNS+Th9GF4bZOo5oKI0GvNZdYJwyIMpGQS+c70r3yHun8pW6w==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-10 (Postfix) with ESMTPSA id
 C70F31800097; Fri,  6 Mar 2026 10:19:16 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v6 1/2] hvf/arm: handle FEAT_SME2 migration
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAAjaMXbq9A1NCO4jnF4aSL0XM2pzHsPsPyWfmqSCg_+2ZQpEHA@mail.gmail.com>
Date: Fri, 6 Mar 2026 11:19:04 +0100
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?utf-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <35FDE44D-63E2-426E-912C-6EB6CDA52116@unpredictable.fr>
References: <20260303-sme2-hvf-v6-0-b473702d8287@linaro.org>
 <20260303-sme2-hvf-v6-1-b473702d8287@linaro.org>
 <CAFEAcA8zTkc4pyHQKoDkTMhGPLQmxBaJS3bZiGRrPgux3rDLzw@mail.gmail.com>
 <CAAjaMXbXdrW9N1xLMPxL9OmjLqti6A3rqAmYipu6OkdBY8JPNQ@mail.gmail.com>
 <CAFEAcA_MuZH8d=Z=NfrNQ78k+Kv9mSx+=DLLt8AxZeEjccN8yw@mail.gmail.com>
 <CAAjaMXbq9A1NCO4jnF4aSL0XM2pzHsPsPyWfmqSCg_+2ZQpEHA@mail.gmail.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-ORIG-GUID: 3q_Q4MmOAFlAxNwsVNbwJWr0JwZTD7Eo
X-Authority-Info-Out: v=2.4 cv=cbXfb3DM c=1 sm=1 tr=0 ts=69aaaa28
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=GPNH9i1AwAkuKBFjiZoA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA5OCBTYWx0ZWRfX3Nhi414fqt+J
 moAcPruBiGNU/p5WT16GOCXoxQQXckOBGz4R3hQ2ATITgqGngdJH0UEuLjge/6MuLokzpmMV+La
 pFapTJRXXHt9cORBTTmFwljlHi071+o5RhGEL1gGBLFjhhTb8Z4kFPfKDqrYep/w36ETa1k7XBh
 ikfQ7WNQmFbgB2RGg3kHivRrV9Qsfmwy8bFlGSOEUkjEw9Sd5SenW9GLiVBlFVBV2ID3jPzfSHr
 G1mHUP9DUj10hm4IPot7uaJKIt08ql5EhX2sEgIFW3oKE9ONsynl/FGH8hrBlSp80MuIN4VHqMo
 3Tys0hxQ00A4scNcnDnO4otZYNPb5sF6EqTW8kwezflOhGr5wHrBJQmp0c2K8g=
X-Proofpoint-GUID: 3q_Q4MmOAFlAxNwsVNbwJWr0JwZTD7Eo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0
 mlxlogscore=944 mlxscore=0 clxscore=1030 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060098
X-JNJ: AAAAAAABgLybBr2HW//ij4ByjkwXY+fdBzX13MlStxvEoJo1i0igB99GA6H2+/GipMtoG5OKIUwtBDCjrkhLORPOnLBhwAg6ghqFw7i7nIioTLxZFOBEJynMKt9MwxMvwfEBkjznBwYxQBixLuLcJjIKHY/avm6QwUUYPQvKNTukVymS26j/QTagyqQhDeecH3csRh848uMYh8qTPzHlKRULoCrvyCZCY+nNK0hHJCKg++M+ADlQqpvUMn0n+44jw9KT1aGgyTPpu3xVLVyvt9w0Y9ZcXnQOt25f2ltfbeYCe2CsorDAIVCo00ISQEHoh/ZeW4x8o52G+gpeB42ZCW5xeIZzsKtA5e917AFPstriProTDrswbEshAwcFaKYuSrpVbkyp/wBKn9QzbHyh/TOfPpevB0+pyB6OAD6hs9KdgS0m5aXy+UaUU+WjQdlAHmIReczasA9CBJuAcwBFRgNA5wzYXBVMAR0hGwxmS6anurDAKmhwqSvMDao8hApsqBmjd3QfNeZbV3yVn/4zPB3yVTFLwB/Up3CZ2rwXCajjSPLqt86M+aQH/BqJhffgoK3ACJj95/NVlKXWNTgVxlUIWU3bD8DFPOW574mGWsWIvQAF2/bl8KIk+fYFp71oHQn5rRKIbZIMH4iNnk2wMvF/sOPQldsftfQuhDTPXK9qO8t7+1rNg5/tHUEe70mR6ix2yUuKYxdFTrfryTz6Qg==
Received-SPF: pass client-ip=57.103.68.104;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 6. Mar 2026, at 11:05, Manos Pitsidianakis =
<manos.pitsidianakis@linaro.org> wrote:
>=20
> On Fri, Mar 6, 2026 at 11:48=E2=80=AFAM Peter Maydell =
<peter.maydell@linaro.org> wrote:
>>=20
>> On Fri, 6 Mar 2026 at 09:31, Manos Pitsidianakis
>> <manos.pitsidianakis@linaro.org> wrote:
>>>=20
>>> On Fri, Mar 6, 2026 at 11:19=E2=80=AFAM Peter Maydell =
<peter.maydell@linaro.org> wrote:
>>>> Mohamed points out that this breaks the build when compiling
>>>> with GCC (which I hadn't noticed because I happen to do my testing
>>>> of target-arm with clang on Linux these days):
>>>=20
>>> Oops. same here, I was using clang.
>>=20
>>>> typedef uint8_t hv_sme_zt0_uchar64_t;
>>>>=20
>>>> Could somebody confirm that that works OK on the relevant macos
>>>> configurations ?
>>>=20
>>> I think this works. Do you want me to send a new revision?
>>=20
>> If you can test it for the macos configs I can just make the change
>> locally. I have:
>=20
> Tested it with gcc on linux and on macos, thanks.
>=20
>> +/*
>> + * The system version of this type declares it with
>> + *    __attribute__((ext_vector_type(64)))
>> + * However, that is clang specific and not supported by GCC.
>> + * Since these headers are only here for the case where the system
>> + * headers do not provide these types (including both older macos
>> + * and non-macos hosts), we don't need to make the type match
>> + * exactly, so we declare it as a plain uint8_t.
>> + */
>> +typedef uint8_t hv_sme_zt0_uchar64_t;
>=20
>=20
>>=20
>> While you're retesting, could you also look at / test patches
>> 17 and 18 in Mohamed's series
>> =
https://lore.kernel.org/qemu-devel/20260306083113.74177-18-mohamed@unpredi=
ctable.fr/T/#m2d1e3dfbfa5aecd41af6c0aa9e3b574a72c6f04d
>>=20
>> ?
>>=20
>> They look to me like bugfixes that we should be squashing/including
>> in the "enable SME2 for hvf" handling.
>=20
> Had a quick look, 17 seems to be nested-virt specific so not a bugfix
> if nested-virt was not already supported in the first place, right?

Hello,

This part isn=E2=80=99t:

@@ -1370,16 +1373,22 @@ int hvf_arch_init_vcpu(CPUState *cpu)
arm_cpu->cpreg_indexes[sregs_cnt++] =3D kvm_id;
}
}
- if (__builtin_available(macOS 15.2, *)) {
- for (i =3D 0; i < ARRAY_SIZE(hvf_sreg_list_sme2); i++) {
- hv_sys_reg_t hvf_id =3D hvf_sreg_list_sme2[i].sreg;
- uint64_t kvm_id =3D HVF_TO_KVMID(hvf_id);
- uint32_t key =3D kvm_to_cpreg_id(kvm_id);
- const ARMCPRegInfo *ri =3D get_arm_cp_reginfo(arm_cpu->cp_regs, key);
-
- if (ri) {
- assert(!(ri->type & ARM_CP_NO_RAW));
- arm_cpu->cpreg_indexes[sregs_cnt++] =3D kvm_id;
+ if (hvf_arm_sme2_supported()) {
+ /*
+ * Clang doesn't allow us to combine the two checks together.
+ * -Wunsupported-availability-guard
+ */
+ if (__builtin_available(macOS 15.2, *)) {
+ for (i =3D 0; i < ARRAY_SIZE(hvf_sreg_list_sme2); i++) {
+ hv_sys_reg_t hvf_id =3D hvf_sreg_list_sme2[i].sreg;
+ uint64_t kvm_id =3D HVF_TO_KVMID(hvf_id);
+ uint32_t key =3D kvm_to_cpreg_id(kvm_id);
+ const ARMCPRegInfo *ri =3D get_arm_cp_reginfo(arm_cpu->cp_regs, key);
+
+ if (ri) {
+ assert(!(ri->type & ARM_CP_NO_RAW));
+ arm_cpu->cpreg_indexes[sregs_cnt++] =3D kvm_id;
+ }
}
}
/*

For CPUs that don=E2=80=99t have SME

But the remainder of the patch is. Probably worth it to just merge it =
all as part of the nested virt stuff though...

>=20
> As for 18: I'm not sure why this is needed (I'm not that familiar with
> HVF API) and there's no commit message to explain. @Mohamed Mediouni
> can you help?

We have this in sysreg.c.inc:

DEF_SYSREG_15_02(HV_SYS_REG_SMCR_EL1, 3, 0, 1, 2, 6)
DEF_SYSREG_15_02(HV_SYS_REG_SMPRI_EL1, 3, 0, 1, 2, 4)
DEF_SYSREG_15_02(HV_SYS_REG_TPIDR2_EL0, 3, 3, 13, 0, 5)
DEF_SYSREG_15_02(HV_SYS_REG_ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
DEF_SYSREG_15_02(HV_SYS_REG_ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
DEF_SYSREG_15_02(HV_SYS_REG_SMPRI_EL1, 3, 0, 1, 2, 4)
DEF_SYSREG_15_02(HV_SYS_REG_SMCR_EL1, 3, 0, 1, 2, 6)

which means that actual sysreg state gets synced from the QEMU view =
including for the ID_AA64SMFR0_EL1 and ID_AA64ZFR0_EL1 feature =
registers.

See /proc/cpuinfo from a Linux guest with and without the patch,=20
without it the QEMU view of those ID regs is empty=E2=80=A6 and that =
empty view
gets synced in to the vCPU state.

Thank you,
-Mohamed

>>=20
>> thanks
>> -- PMM
>=20
> --=20
> Manos Pitsidianakis
> Emulation and Virtualization Engineer at Linaro Ltd
>=20


