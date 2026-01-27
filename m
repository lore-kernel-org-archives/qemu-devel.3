Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55B5D2F02F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 13:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkjKk-0004iz-RA; Tue, 27 Jan 2026 08:42:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vkjJs-0004TN-Ix
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 08:41:25 -0500
Received: from p-east2-cluster2-host10-snip4-10.eps.apple.com ([57.103.78.83]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vkjJp-0001S0-PJ
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 08:41:24 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-15 (Postfix) with ESMTPS id
 1A94518009CF; Tue, 27 Jan 2026 13:40:50 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769521255; x=1772113255;
 bh=txTB23e1hndnQCZw3z0ju6h6lBl40tZCf6hVvlftUAI=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=AW0l3LN5LVwVxuGKgBMU8rmGXFIJS1c9ph+25r2RLj9cru5OPTz9yQEwr7rV64yX3vmMoyeo4QWKuXWMdsrHIROFmtVkvfaUgHTeWZljXskwzsLqaUhg/Wuj8d9HVBUSZhXpxWXAaVvFK+udEoe7tnc5vslL3t64hHrcy5ywbAgqowGaJn0YN74EeVowOXHwYsF3Z9x4+1tL4tJdKM3uPa5U9a/0n3dLLTq+q82HBAUbRLkTnY4fhaZR9TRxfDT156e4tp8aYQWDQU16utNvu5CT5vRwLIiQ/MHxxWdYYCO0cm2bMySOCkVujzXvM3yntXSPrpUwtRYEH7SCVxKA6A==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-15 (Postfix) with ESMTPSA id
 B503E18009DD; Tue, 27 Jan 2026 13:40:47 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v17 03/21] hw: arm: virt: rework MSI-X configuration
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAFEAcA_7o-dNFUgMo=UdYD_cf=dwbMCy6b+_2SRSxVbDmmAUmw@mail.gmail.com>
Date: Tue, 27 Jan 2026 14:40:35 +0100
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Ani Sinha <anisinha@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9ECB5E0B-3BD3-47D3-9E6B-204A354CEA84@unpredictable.fr>
References: <20260121134114.9781-1-mohamed@unpredictable.fr>
 <20260121134114.9781-4-mohamed@unpredictable.fr>
 <CAFEAcA-GL9UG5MN5tKDzLwQ04cBGa99cSau4=2BLTs0+GGSdJw@mail.gmail.com>
 <51E78FA9-2C66-4E8E-947F-F009A8AEEDFD@unpredictable.fr>
 <CAFEAcA_7o-dNFUgMo=UdYD_cf=dwbMCy6b+_2SRSxVbDmmAUmw@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-ORIG-GUID: 7Aj6NOjCykQ5o2js3AcTxbWFAtUWypde
X-Proofpoint-GUID: 7Aj6NOjCykQ5o2js3AcTxbWFAtUWypde
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDExMiBTYWx0ZWRfX/vYcWmoOoxVK
 XQuJldYhwrIpwp1L/u/CBqo5a2+MuFVkINt8B0C0tXeh9ArLSsEnpwKjKKw59+FuUQVO6AVOu6i
 Pf6yjS6gs2l3HU7F6/gsvoM9+1q8qEGwX1gp781LEJ8fcKmd0FNGrxIB5jVYhkELJpClbZhuEx3
 L85Gf+3D0iidizokTZYrU8w0wm5LTiCZte9GLjgrTzq4VV0Z4SfhCGptY9aQ1ylonn4HJwW60I/
 PTb849IJkCqsddJ+7uKVE8V6LW4fwOgYtl87oaPG3dIapzAxduIeRHQr5x0osv+9mqUE2QTqFJJ
 EFQOsuCLK8dWH4B/S2r3YtOesG8f5JFMseI9C1ZVu/uJIQpxuDurLdm4EUSYw4=
X-Authority-Info-Out: v=2.4 cv=ZYoQ98VA c=1 sm=1 tr=0 ts=6978c065
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=k7SuDDSd2Ljkt1C7sC0A:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1030
 bulkscore=0 mlxlogscore=999 adultscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270112
X-JNJ: AAAAAAABJIRqpZ0eHs9H0Lq9VngA11k3wNOZImoNz/8ZCBR7EHni1T7oZkQH2duoidLhs/uJSH9/TH/mUHrE4W3tMPxxOu6JcVTxBoGUKHfA9eJnyAUSYttvIpzJOZT9gu0qeIgTAQEMQarsNB+wRJHD4PufyuPw449D/LybZ7MrAN9Q3jmlr4KFyXoktWYud+1jZHAQjBFSeacteGyT2djRRsjQqcvIzu52FMlOkCz8iDOtpf2vw6J3U0ctRTScXbQZaRqdx3p1VKjAi8OqXL5r6xzrEmYl7sEs/WCLOU+TUsellqYIIDeOnOJqdSCrZdz9tT4J9mgZbQqKaucCYix+9YiqaEIMwFVX9lUNgIrSicuk8QRlFNkGfgO+E16+BOeWb3/DgMcQJDnUcje3QAnucSmXQ8RtF5nV568SMK+BcLETlS5vYMfBkRRqT/6Dzqb8YDsv2ehU/yQxD4+FguDUtUTnm3MhHcLou4CeZS0VojKhcsnNUMbNTSwDVa3bNyVLNeMPCOQE185kQ0wbjSdDUQM807ydHWLSmj4LrmvCohYnixruCjp5fb8FkgUpPWIGm80QC4hYzv8Ir7pbX7BwSn0tsZ8Jjt63AOqf1Zd/xd8E3vj3MQiJeRoEqkNSdRLTaZTePqXMYBc2qsf80slInynNnmJpgnFvJH8dQlSKNk+a1KEEDmj0Sbxi5V58sbfbS8yupubQaiPqvevl45TLDOWECShZZyBEVpjDWciEc1IJQHChMOvL1dlcEUj6j1W0kG+GIPcy6/JTy3PJiooYajoU9DiPvmo9NC7ojq8kvMtbkn1d/OU28IL8p/2Ztinn4yOsnFwfykAxe4PozlOSyR6vYKPWaYIs2L3c4DUl4xTKHPb6u73H+1Cfze6rrA==
Received-SPF: pass client-ip=57.103.78.83;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



> On 27. Jan 2026, at 13:54, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Tue, 27 Jan 2026 at 12:46, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>> On 27. Jan 2026, at 11:54, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>>>=20
>>> On Wed, 21 Jan 2026 at 13:41, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>>> +/*
>>>> + * In the prior Qemu ACPI table handling, GICv2 configurations
>>>> + * had vms->its=3D1... That's broken.
>>>> + *
>>>> + * Match that assumption to match the existing ACPI tables that
>>>> + * have been shipping for quite a while.
>>>> + */
>>>> +static int is_gicv2_acpi_workaround_needed(VirtMachineState *vms) =
{
>>>> +    return vms->gic_version =3D=3D 2;
>>>> +}
>>>=20
>>> We don't need to keep identical bug-for-bug ACPI tables like that.
>>> If we were incorrectly reporting an ITS in a GICv2-only ACPI table,
>>> that was a bug and we can fix it. (This might need adjusting of the
>>> golden reference ACPI data in some of the bios-tables-tests if we
>>> were testing that, so it ought to go in its own patch.)
>>>=20
>> Hello,
>>=20
>> I=E2=80=99m a bit concerned about breaking hibernation in this =
case=E2=80=A6
>>=20
>> My intent was keeping this behavior for now and then add a machine =
model version dependent toggle in a follow-up patch.
>=20
> I'm not an ACPI table expert but my understanding is that it's
> OK to change the ACPI table contents without having to make
> those changes machine-version dependent. See e.g. commit d6afe18b7242,
> which changed the ACPI tables for the its=3Doff case and did not
> make those changes machine-version specific.
>=20

Hi,

That commit didn=E2=80=99t affect the default/regular config so it =
wouldn't have been too problematic in practice.

Have had countless issues with how brittle hibernation is* - and more or =
less subtle ACPI table changes
tend to break it.=20

* and Qemu doesn=E2=80=99t provide an FACS (nevermind one with an HW =
signature) to force a clean reboot
- which Windows ignores anyway

>>>> +bool virt_is_its_enabled(VirtMachineState *vms)
>=20
>>> Why do we need these? The idea of finalize_msi_controller()
>>> is that it fixes vms->msi_controller so that you can just
>>> directly say vms->msi_controller =3D=3D VIRT_MSI_CTRL_ITS or
>>> vms->msi_controller =3D=3D VIRT_MSI_CTRL_GICV2M rather than
>>> having to have more complicated logic.
>>>=20
>> It=E2=80=99s because of object_class_property_add_str(oc, "msi", =
virt_get_msi, virt_set_msi) (and the same applies for the its property), =
is it safe to assume that virt_get_msi/virt_get_its will never be called =
from that prior to finalize?
>=20
> The get and set property functions need to handle the
> msi_controller field not having been finalized, but
> they are only getting and setting it.
>=20
> thanks
> -- PMM
>=20


