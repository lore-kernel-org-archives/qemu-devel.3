Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3ACF0182F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 11:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyTou-0007j9-7J; Fri, 06 Mar 2026 06:58:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyTos-0007iS-QY
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 06:58:14 -0500
Received: from p-west2-cluster1-host8-snip4-3.eps.apple.com ([57.103.68.96]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyToq-0003sq-MW
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 06:58:14 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-4 (Postfix) with ESMTPS id
 A5EA418003B0; Fri,  6 Mar 2026 11:58:09 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772798290; x=1775390290;
 bh=667m3kxfQ/ll8tsvPYZ+/XsOmMg0crhuonMw3R7fu1s=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=PXFjUwZkrqk+P2/W1fyScnQh7FuJrI8Bd7C6H3QMjLa+DZvB2/tey67/UxOkJjQjCK7fRk96BMVX8wFtk/GEwHh6IA3nxcJKgtcFFxfpSU/52rJJIKJcDFTClbOnX9DRGeGF5qQ5/7mPaoX/eCgNcgcTZLlbcIUufRZN66PMg/+hK3OQX96+7agc/n5hADDhTKXz4RRHpKuu1ajsR7kLbRMi6kDEf0J2l6IbIEgwm9LuVtQjOWN6uYRQmriY1AKA1WNiMwzfCd2zJyR/8hCXevyj7cLQu59Fpk1W3QZakedqSt145oAjXCMDBujtmPlGl0cZlFCFknvuDg9NnxljsA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-4 (Postfix) with ESMTPSA id
 65A49180011D; Fri,  6 Mar 2026 11:58:07 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <64DE9AAD-2944-466E-8D77-791D313BEE71@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_637D8F3E-1AE3-4C38-959C-42AC11FFE397"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v6 1/2] hvf/arm: handle FEAT_SME2 migration
Date: Fri, 6 Mar 2026 12:57:55 +0100
In-Reply-To: <CAAjaMXa3h1abx=-ijZqf13ku-T=9+eV+XK9g85kGwxeRB-on1g@mail.gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?utf-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260303-sme2-hvf-v6-0-b473702d8287@linaro.org>
 <20260303-sme2-hvf-v6-1-b473702d8287@linaro.org>
 <CAFEAcA8zTkc4pyHQKoDkTMhGPLQmxBaJS3bZiGRrPgux3rDLzw@mail.gmail.com>
 <CAAjaMXbXdrW9N1xLMPxL9OmjLqti6A3rqAmYipu6OkdBY8JPNQ@mail.gmail.com>
 <CAFEAcA_MuZH8d=Z=NfrNQ78k+Kv9mSx+=DLLt8AxZeEjccN8yw@mail.gmail.com>
 <CAAjaMXbq9A1NCO4jnF4aSL0XM2pzHsPsPyWfmqSCg_+2ZQpEHA@mail.gmail.com>
 <35FDE44D-63E2-426E-912C-6EB6CDA52116@unpredictable.fr>
 <CAFEAcA-Zgq43KW9EC-pteOqxHcZg==GE=1TAURZP-DGRh3OoHQ@mail.gmail.com>
 <CAAjaMXa3h1abx=-ijZqf13ku-T=9+eV+XK9g85kGwxeRB-on1g@mail.gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Authority-Info-Out: v=2.4 cv=ddGNHHXe c=1 sm=1 tr=0 ts=69aac152
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8 a=IBEKtojIWfUEEpFNO-QA:9
 a=QEXdDO2ut3YA:10 a=7e7JJAVjwyWRil13J6AA:9 a=AQANcpoozF_qkyix:21
 a=_W_S_7VecoQA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: TwvQq4SIVzEfqp_unkpT-8vS_sjV_mtP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDExNCBTYWx0ZWRfX1mmNwzciIUDp
 LoXtzUMVMLjhnuFjrD4JGl9WweCyPDUfmYaK1dvIviXrAW25Mm11b9MQtRHAQ3CxErPdt+1CeVo
 VwJKX4KeUV8qWMEIxWkTVMu2g45NEDPrMhTiom3GB0sPFtwxszvGdT9WGR4UmQzoiP2+ujygNpL
 EiVsnu31aIlNsK/+r3rlk/U0CmX99lTjXEEFreDfZuZLdtU0ckrr/lmcPvbTsOmpG/jLgQXml1X
 SVoR+qdOWGhr+q5McdNgH81Fd6bYtGf8AsID4XqocYEqFiHa/gDOKR1X5FPf52oJUV2+cZTB2fo
 qCRzv1LxOZ8IX7AZebUxK3GH17qlChg3KOraGkrdasCzUqbWOX8cBoqkDVjFhM=
X-Proofpoint-ORIG-GUID: TwvQq4SIVzEfqp_unkpT-8vS_sjV_mtP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1030
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060114
X-JNJ: AAAAAAABw4j2LOPF+sqkVBtyyhhcMYBpe8J4+kiIiMcciBkll+b+FS1FZK5FeoJwwCtgeOQJI3FnyC7UFDTKjHket8Oa7BOYmYKYWmSbEcdLoCnuR9MPFiA6gj/HPJzaEniqy9CYBosPB9y6KNQibx3Z3ckj79b2MGS6pzUFVQSy3mR0VJOp86jgmx3o7gN1P5SgdxOJnWdhJdl+goiSgSVc3JQBVqJYYL/Pk3gLH4SWJ3E8M9YApe63OHI1uPmiSK9e9GVTuWLbT3QH0FSqYV1ECdsm38YunCuCQV9bAi+1c0rUDYT4yzug7OTZKIkCzi+reIoB6Xvvt8ym+EqanyB5m5WNpS5mz8P7KdOdza0XjiuHktJRCQgIARoRbnFT9qxLGkcCBLhrlTfYAndcgKd+RHQNT0GUjxmzM8LFGIqqLeiPoBh5FButeWT40ypQxVZhGg8h4eAJCA8c2wZWtfJqLgPDHLiZwkzFqzOqTIMuSI/sjxPZ+vQF8qkCWxPgLbj6PMnMszv4kjZN6CyCVM0VVlBfISSFEHKap/RNUg+WXefebKewv4aXHe+odqHvmyU2BXbQRbaNFsGKaRCQ9aU1l/8O2M3J+xzyNJjysn6JIqxrew5I9nxVXy67kb04exgpgiKw2LfYj5YGEy7qtiXW4Hf6aZxzPy9VzEdM+Ia2UVhRNzFBKhU24mzMF2FexgBVDuBfDQ==
Received-SPF: pass client-ip=57.103.68.96;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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


--Apple-Mail=_637D8F3E-1AE3-4C38-959C-42AC11FFE397
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 6. Mar 2026, at 12:49, Manos Pitsidianakis =
<manos.pitsidianakis@linaro.org> wrote:
>=20
> On Fri, Mar 6, 2026 at 1:14=E2=80=AFPM Peter Maydell =
<peter.maydell@linaro.org> wrote:
>>=20
>> On Fri, 6 Mar 2026 at 10:19, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>>> On 6. Mar 2026, at 11:05, Manos Pitsidianakis =
<manos.pitsidianakis@linaro.org> wrote:
>>>>=20
>>>> On Fri, Mar 6, 2026 at 11:48=E2=80=AFAM Peter Maydell =
<peter.maydell@linaro.org> wrote:
>>>>> While you're retesting, could you also look at / test patches
>>>>> 17 and 18 in Mohamed's series
>>>>> =
https://lore.kernel.org/qemu-devel/20260306083113.74177-18-mohamed@unpredi=
ctable.fr/T/#m2d1e3dfbfa5aecd41af6c0aa9e3b574a72c6f04d
>>>>>=20
>>>>> ?
>>>>>=20
>>>>> They look to me like bugfixes that we should be =
squashing/including
>>>>> in the "enable SME2 for hvf" handling.
>>>>=20
>>>> Had a quick look, 17 seems to be nested-virt specific so not a =
bugfix
>>>> if nested-virt was not already supported in the first place, right?
>>>=20
>>> Hello,
>>>=20
>>> This part isn=E2=80=99t:
>>>=20
>>> @@ -1370,16 +1373,22 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>>> arm_cpu->cpreg_indexes[sregs_cnt++] =3D kvm_id;
>>> }
>>> }
>>> - if (__builtin_available(macOS 15.2, *)) {
>>> - for (i =3D 0; i < ARRAY_SIZE(hvf_sreg_list_sme2); i++) {
>>> - hv_sys_reg_t hvf_id =3D hvf_sreg_list_sme2[i].sreg;
>>> - uint64_t kvm_id =3D HVF_TO_KVMID(hvf_id);
>>> - uint32_t key =3D kvm_to_cpreg_id(kvm_id);
>>> - const ARMCPRegInfo *ri =3D get_arm_cp_reginfo(arm_cpu->cp_regs, =
key);
>>> -
>>> - if (ri) {
>>> - assert(!(ri->type & ARM_CP_NO_RAW));
>>> - arm_cpu->cpreg_indexes[sregs_cnt++] =3D kvm_id;
>>> + if (hvf_arm_sme2_supported()) {
>>> + /*
>>> + * Clang doesn't allow us to combine the two checks together.
>>> + * -Wunsupported-availability-guard
>>> + */
>>> + if (__builtin_available(macOS 15.2, *)) {
>>> + for (i =3D 0; i < ARRAY_SIZE(hvf_sreg_list_sme2); i++) {
>>> + hv_sys_reg_t hvf_id =3D hvf_sreg_list_sme2[i].sreg;
>>> + uint64_t kvm_id =3D HVF_TO_KVMID(hvf_id);
>>> + uint32_t key =3D kvm_to_cpreg_id(kvm_id);
>>> + const ARMCPRegInfo *ri =3D get_arm_cp_reginfo(arm_cpu->cp_regs, =
key);
>>> +
>>> + if (ri) {
>>> + assert(!(ri->type & ARM_CP_NO_RAW));
>>> + arm_cpu->cpreg_indexes[sregs_cnt++] =3D kvm_id;
>>> + }
>>> }
>>=20
>> Yes; the patch is doing two things and really ought to be two =
patches,
>> so we can put the bit that we need for "make SME2 hvf work correctly"
>> before the "enable SME2 HVF" patch, and the bit that is nested-virt
>> specific in the nested-virt patches.
>>=20
>=20
> Patch v18 needs an adjustment, because clang prints warnings about the
> `static const struct sme_isar_regs` array.
>=20
Hello,

Put an updated version of my branch to =
https://github.com/mediouni-m/qemu/commits/hvf-irqchip-and-nested/

Feel free to pick the needed patches from it/squash as needed :)
>=20
> ../target/arm/hvf/hvf.c:1098:11: warning:
> 'HV_FEATURE_REG_ID_AA64SMFR0_EL1' is only available on macOS 15.2 or
> newer [-Wunguarded-availability-new]
>=20
> Peter,
>=20
> Maybe I should send a new revision since you haven't merged these
> patches anyway?
>=20
>> thanks
>> -- PMM
>=20
> --=20
> Manos Pitsidianakis
> Emulation and Virtualization Engineer at Linaro Ltd


--Apple-Mail=_637D8F3E-1AE3-4C38-959C-42AC11FFE397
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 6. Mar 2026, at 12:49, Manos Pitsidianakis =
&lt;manos.pitsidianakis@linaro.org&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>On Fri, Mar 6, 2026 at =
1:14=E2=80=AFPM Peter Maydell &lt;peter.maydell@linaro.org&gt; =
wrote:<br><blockquote type=3D"cite"><br>On Fri, 6 Mar 2026 at 10:19, =
Mohamed Mediouni &lt;mohamed@unpredictable.fr&gt; wrote:<br><blockquote =
type=3D"cite"><blockquote type=3D"cite">On 6. Mar 2026, at 11:05, Manos =
Pitsidianakis &lt;manos.pitsidianakis@linaro.org&gt; wrote:<br><br>On =
Fri, Mar 6, 2026 at 11:48=E2=80=AFAM Peter Maydell =
&lt;peter.maydell@linaro.org&gt; wrote:<br><blockquote type=3D"cite">While=
 you're retesting, could you also look at / test patches<br>17 and 18 in =
Mohamed's =
series<br>https://lore.kernel.org/qemu-devel/20260306083113.74177-18-moham=
ed@unpredictable.fr/T/#m2d1e3dfbfa5aecd41af6c0aa9e3b574a72c6f04d<br><br>?<=
br><br>They look to me like bugfixes that we should be =
squashing/including<br>in the "enable SME2 for hvf" =
handling.<br></blockquote><br>Had a quick look, 17 seems to be =
nested-virt specific so not a bugfix<br>if nested-virt was not already =
supported in the first place, =
right?<br></blockquote><br>Hello,<br><br>This part isn=E2=80=99t:<br><br>@=
@ -1370,16 +1373,22 @@ int hvf_arch_init_vcpu(CPUState =
*cpu)<br>arm_cpu-&gt;cpreg_indexes[sregs_cnt++] =3D =
kvm_id;<br>}<br>}<br>- if (__builtin_available(macOS 15.2, *)) {<br>- =
for (i =3D 0; i &lt; ARRAY_SIZE(hvf_sreg_list_sme2); i++) {<br>- =
hv_sys_reg_t hvf_id =3D hvf_sreg_list_sme2[i].sreg;<br>- uint64_t kvm_id =
=3D HVF_TO_KVMID(hvf_id);<br>- uint32_t key =3D =
kvm_to_cpreg_id(kvm_id);<br>- const ARMCPRegInfo *ri =3D =
get_arm_cp_reginfo(arm_cpu-&gt;cp_regs, key);<br>-<br>- if (ri) {<br>- =
assert(!(ri-&gt;type &amp; ARM_CP_NO_RAW));<br>- =
arm_cpu-&gt;cpreg_indexes[sregs_cnt++] =3D kvm_id;<br>+ if =
(hvf_arm_sme2_supported()) {<br>+ /*<br>+ * Clang doesn't allow us to =
combine the two checks together.<br>+ * =
-Wunsupported-availability-guard<br>+ */<br>+ if =
(__builtin_available(macOS 15.2, *)) {<br>+ for (i =3D 0; i &lt; =
ARRAY_SIZE(hvf_sreg_list_sme2); i++) {<br>+ hv_sys_reg_t hvf_id =3D =
hvf_sreg_list_sme2[i].sreg;<br>+ uint64_t kvm_id =3D =
HVF_TO_KVMID(hvf_id);<br>+ uint32_t key =3D =
kvm_to_cpreg_id(kvm_id);<br>+ const ARMCPRegInfo *ri =3D =
get_arm_cp_reginfo(arm_cpu-&gt;cp_regs, key);<br>+<br>+ if (ri) {<br>+ =
assert(!(ri-&gt;type &amp; ARM_CP_NO_RAW));<br>+ =
arm_cpu-&gt;cpreg_indexes[sregs_cnt++] =3D kvm_id;<br>+ =
}<br>}<br></blockquote><br>Yes; the patch is doing two things and really =
ought to be two patches,<br>so we can put the bit that we need for "make =
SME2 hvf work correctly"<br>before the "enable SME2 HVF" patch, and the =
bit that is nested-virt<br>specific in the nested-virt =
patches.<br><br></blockquote><br>Patch v18 needs an adjustment, because =
clang prints warnings about the<br>`static const struct sme_isar_regs` =
array.<br><br></div></div></blockquote>Hello,</div><div><br></div><div>Put=
 an updated version of my branch to&nbsp;<a =
href=3D"https://github.com/mediouni-m/qemu/commits/hvf-irqchip-and-nested/=
">https://github.com/mediouni-m/qemu/commits/hvf-irqchip-and-nested/</a></=
div><div><br></div><div>Feel free to pick the needed patches from =
it/squash as needed :)</div><div><blockquote =
type=3D"cite"><div><div><br>../target/arm/hvf/hvf.c:1098:11: =
warning:<br>'HV_FEATURE_REG_ID_AA64SMFR0_EL1' is only available on macOS =
15.2 or<br>newer =
[-Wunguarded-availability-new]<br><br>Peter,<br><br>Maybe I should send =
a new revision since you haven't merged these<br>patches =
anyway?<br><br><blockquote type=3D"cite">thanks<br>-- =
PMM<br></blockquote><br>-- <br>Manos Pitsidianakis<br>Emulation and =
Virtualization Engineer at Linaro =
Ltd<br></div></div></blockquote></div><br></body></html>=

--Apple-Mail=_637D8F3E-1AE3-4C38-959C-42AC11FFE397--

