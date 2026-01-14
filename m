Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BF7D3CC88
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 23:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg9zI-0008Em-1b; Wed, 14 Jan 2026 18:09:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg9zF-0008EM-H2
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 18:09:14 -0500
Received: from p-west3-cluster1-host10-snip4-10.eps.apple.com ([57.103.73.231]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg9zC-0007D3-Bb
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 18:09:13 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPS id
 2172118000E3; Wed, 14 Jan 2026 23:09:03 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=8VIp/LlrgckQFzAMk1G82WnEp8fdBOifd7CrgWGKpJs=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=GaILhzcUk7ywLlsY3hF1ivipI8K8/szQ90e6FLzf8IajmAMSeviZvSDk3BVAKfezJskMfP7mXz/fM6pEI08Cl1ZkoZDQuDRYRPD4BPWTlU5qoBBwS4VapcfAkqCMHKInEuRuCr4HaR3Il/enL+Uu2/a//+ZWrLgLtC0mO3cOZb9K7pEd/Rzc+1106om08wddiWOyPjgvlvnLdvMsiwlxV91HNM905d6aG/iGMBFCPZLDh/0I1nV3JvSai5iBRP+8vUVaGHfMyJT4OLedLFV4m10SiYVx7ne8Np2i83WbaikinKl5+AHdqqzZvf6jYv1mIpzbaZsbcwiAK00hzRJB5Q==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPSA id
 329F918000A3; Wed, 14 Jan 2026 23:08:58 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <07C6A459-5708-4403-B3CE-125A088B3F06@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_4A6B8B2F-D822-46BA-8F37-1B300188141B"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v14 07/26] hw: arm: virt: rework MSI-X configuration
Date: Thu, 15 Jan 2026 00:08:45 +0100
In-Reply-To: <05EEED6C-5A59-4DCB-9836-942E5C6505AD@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>
To: Bernhard Beschow <shentey@gmail.com>
References: <20260114134143.26198-1-mohamed@unpredictable.fr>
 <20260114134143.26198-8-mohamed@unpredictable.fr>
 <05EEED6C-5A59-4DCB-9836-942E5C6505AD@gmail.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-ORIG-GUID: UsFCaP9wwGjn2evkE-bprEHfiMIrYH4U
X-Authority-Info: v=2.4 cv=OPQqHCaB c=1 sm=1 tr=0 ts=69682211
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=uPZiAMpXAAAA:8 a=pGLkceISAAAA:8
 a=v6dsw3bOp3NyfC-JBMgA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
 a=lvAQSFIgS-BOeQv-avsA:9 a=cElv932fU-Q-zxAG:21 a=_W_S_7VecoQA:10
X-Proofpoint-GUID: UsFCaP9wwGjn2evkE-bprEHfiMIrYH4U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE5MSBTYWx0ZWRfX+ZGldpbAAgMS
 ZHqVBsIIHgM/yNvr86EKz1T6NOKHtDR/BD0RiSuU+ZVT9Op4clG764oddZixG5eNG3oAiIqYO5Q
 t4tIyEwkm1mdJGOJ/6wlI9jKEKzklyWqpzqJCraPUqAQXLQbLVATA57DkCi3ZAZNotcGJvqn79q
 x6Cm9twI9Uj9i4XZXIk9vdD7DbVNeOgYPk6qWUv1R5ST5ZSwLBRezzjk/iBVNGlythFegQs/4Ha
 uUjrATrf8rYEzDaNaUI/mUSp8ArTlrA6o4sHIEhCCFi6SNkhrRxmALQM6FHHWfS+QWuDFN7cCkK
 hv4AdEj/UuMMw73joNk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_07,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1030 mlxlogscore=999
 suspectscore=0 spamscore=0 adultscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601140191
X-JNJ: AAAAAAABQxuIGvshxDAMSWQEsIMEQ1sJQcoNYKxf2YtDYoZBmkiQOp53Z8qH54gnQ1oq58JedJK4d0wqWvLYWmoGtZswzQFCXmkc6AcX76hWGZBLQ6YBClQ42FWgG0gNxAtLwYdjaKmWyiiRN6r2uXxgCKhcFu04mQfulBFIlrF7t+GYPxipXobVZ5ZMRNhHC2aLt1iX+SWN13l4m+ylGIaS93gDfdDs5jrH0DoxHkQrVuTOGNw0zEvl8AA+p6/yxCDEj5DMLOdpdmFUHf9SKJZ9v/tXe0rGqY1Iv53JESAsl0FqICXXBiTkGvElBM8i5zHqD7SaU9O8cqLkPLM9mcO+VOcW5X36whM/IhrvyWMTnJDota/1ulMKHaPupKAKtAEifHe0886igYLZkvEMMZSd1gNvewM60//1n4AaHjZbsDjA57teZgar3OqGJxBa1F5JW4jwHoBbvG7xBRnE5xOsG9BkK2uyAsFBL8/M5oGTThHwbzqBMaXCFxzHpyd2/hmeHdnWv3BEWWtcw/FRV3MmiCWOAryjIteji0XU/X0PtF9ls4GsSGeXDyOivkD/g1yaORTTOs/XrtIHfh4g7GtHJk93GyxaapvCLQWLD0Jq8fKFbVTW4hBlvkXdj28aG9YwR7UBLGF5LEIZAfWQMHzTeeHHsuTR11rmhkcwsGL/MXQBCNqm+wtYF8NdafN1GRrB//jPIru53M0SwYhHDJkBbeVXj3GnGGdGNul1hoRx+9AvvrwsKAXmfJvCR24+9oihbuuQerWy09BuztguBIUSMXn0FxtU/tv/vLIPd400+d+p+ZPDS/ztKD+pcdONe4Azd6CG7Cz1Qedn6LAAq/bgWeOdyO1V+ELOo7B35PAUsX9moQKh4SbESccEWX4X9jf9xuzJKizIlQAYXzG9430vKBkrSe+NlJ486SWvudvMXq2F65H9c4qJ+GC5yUiyzWa1
Received-SPF: pass client-ip=57.103.73.231;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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


--Apple-Mail=_4A6B8B2F-D822-46BA-8F37-1B300188141B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 14. Jan 2026, at 21:51, Bernhard Beschow <shentey@gmail.com> wrote:
>=20
>=20
>=20
> Am 14. Januar 2026 13:41:24 UTC schrieb Mohamed Mediouni =
<mohamed@unpredictable.fr <mailto:mohamed@unpredictable.fr>>:
>> Introduce a -M msi=3D argument to be able to control MSI-X support =
independently
>> from ITS, as part of supporting GICv3 + GICv2m platforms.
>>=20
>> Remove vms->its as it's no longer needed after that change.
>>=20
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>> hw/arm/virt-acpi-build.c |  24 ++++++---
>> hw/arm/virt.c            | 108 =
+++++++++++++++++++++++++++++++--------
>> include/hw/arm/virt.h    |   4 +-
>> 3 files changed, 108 insertions(+), 28 deletions(-)
>>=20
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 86024a1a73..187dd4e272 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -440,6 +440,17 @@ static void create_rc_its_idmaps(GArray =
*its_idmaps, GArray *smmuv3_devs)
>>    }
>> }
>>=20
>> +/*
>> + * In the prior Qemu ACPI table handling, GICv2 configurations
>> + * had vms->its=3D1... That's broken.
>> + *
>> + * Match that assumption to match the existing ACPI tables that
>> + * have been shipping for quite a while.
>> + */
>> +static int is_gicv2_acpi_workaround_needed(VirtMachineState *vms) {
>> +    return vms->gic_version =3D=3D 2;
>> +}
>> +
>> /*
>> * Input Output Remapping Table (IORT)
>> * Conforms to "IO Remapping Table System Software on ARM Platforms",
>> @@ -473,7 +484,7 @@ build_iort(GArray *table_data, BIOSLinker =
*linker, VirtMachineState *vms)
>>        nb_nodes =3D num_smmus + 1; /* RC and SMMUv3 */
>>        rc_mapping_count =3D rc_smmu_idmaps_len;
>>=20
>> -        if (virt_is_its_enabled(vms)) {
>> +        if (virt_is_its_enabled(vms) || =
is_gicv2_acpi_workaround_needed(vms)) {
>>            /*
>>             * Knowing the ID ranges from the RC to the SMMU, it's =
possible to
>>             * determine the ID ranges from RC that go directly to =
ITS.
>> @@ -484,7 +495,7 @@ build_iort(GArray *table_data, BIOSLinker =
*linker, VirtMachineState *vms)
>>            rc_mapping_count +=3D rc_its_idmaps->len;
>>        }
>>    } else {
>> -        if (virt_is_its_enabled(vms)) {
>> +        if (virt_is_its_enabled(vms) || =
is_gicv2_acpi_workaround_needed(vms)) {
>>            nb_nodes =3D 2; /* RC and ITS */
>>            rc_mapping_count =3D 1; /* Direct map to ITS */
>>        } else {
>> @@ -499,7 +510,7 @@ build_iort(GArray *table_data, BIOSLinker =
*linker, VirtMachineState *vms)
>>    build_append_int_noprefix(table_data, IORT_NODE_OFFSET, 4);
>>    build_append_int_noprefix(table_data, 0, 4); /* Reserved */
>>=20
>> -    if (virt_is_its_enabled(vms)) {
>> +    if (virt_is_its_enabled(vms) || =
is_gicv2_acpi_workaround_needed(vms)) {
>>        /* Table 12 ITS Group Format */
>>        build_append_int_noprefix(table_data, 0 /* ITS Group */, 1); =
/* Type */
>>        node_size =3D  20 /* fixed header size */ + 4 /* 1 GIC ITS =
Identifier */;
>> @@ -518,7 +529,7 @@ build_iort(GArray *table_data, BIOSLinker =
*linker, VirtMachineState *vms)
>>        int smmu_mapping_count, offset_to_id_array;
>>        int irq =3D sdev->irq;
>>=20
>> -        if (virt_is_its_enabled(vms)) {
>> +        if (virt_is_its_enabled(vms) || =
is_gicv2_acpi_workaround_needed(vms)) {
>>            smmu_mapping_count =3D 1; /* ITS Group node */
>>            offset_to_id_array =3D SMMU_V3_ENTRY_SIZE; /* Just after =
the header */
>>        } else {
>> @@ -611,7 +622,7 @@ build_iort(GArray *table_data, BIOSLinker =
*linker, VirtMachineState *vms)
>>            }
>>        }
>>=20
>> -        if (virt_is_its_enabled(vms)) {
>> +        if (virt_is_its_enabled(vms) || =
is_gicv2_acpi_workaround_needed(vms)) {
>>            /*
>>             * Map bypassed (don't go through the SMMU) RIDs (input) =
to
>>             * ITS Group node directly: RC -> ITS.
>> @@ -962,8 +973,7 @@ build_madt(GArray *table_data, BIOSLinker =
*linker, VirtMachineState *vms)
>>        }
>>    }
>>=20
>> -    if (!(vms->gic_version !=3D VIRT_GIC_VERSION_2 && =
virt_is_its_enabled(vms))
>> -     && !vms->no_gicv3_with_gicv2m) {
>> +    if (virt_is_gicv2m_enabled(vms)) {
>>        const uint16_t spi_base =3D vms->irqmap[VIRT_GIC_V2M] + =
ARM_SPI_BASE;
>>=20
>>        /* 5.2.12.16 GIC MSI Frame Structure */
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 553c7f62cc..0e84ccd82c 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -966,12 +966,12 @@ static void create_gic(VirtMachineState *vms, =
MemoryRegion *mem)
>>=20
>>    fdt_add_gic_node(vms);
>>=20
>> -    if (vms->gic_version !=3D VIRT_GIC_VERSION_2 && =
virt_is_its_enabled(vms)) {
>> +    if (virt_is_its_enabled(vms)) {
>>        create_its(vms);
>> -    } else if (vms->gic_version !=3D VIRT_GIC_VERSION_2 && =
!vms->no_gicv3_with_gicv2m) {
>> -        create_v2m(vms);
>> -    } else if (vms->gic_version =3D=3D VIRT_GIC_VERSION_2) {
>> +    } else if (virt_is_gicv2m_enabled(vms)) {
>>        create_v2m(vms);
>> +    } else {
>> +        vms->msi_controller =3D VIRT_MSI_CTRL_NONE;
>>    }
>> }
>>=20
>> @@ -2710,32 +2710,93 @@ static void virt_set_highmem_mmio_size(Object =
*obj, Visitor *v,
>>=20
>> bool virt_is_its_enabled(VirtMachineState *vms)
>> {
>> -    if (vms->its =3D=3D ON_OFF_AUTO_OFF) {
>> +    switch (vms->msi_controller) {
>> +    case VIRT_MSI_CTRL_NONE:
>>        return false;
>> -    }
>> -    if (vms->its =3D=3D ON_OFF_AUTO_AUTO) {
>> -        if (whpx_enabled()) {
>> +    case VIRT_MSI_CTRL_ITS:
>> +        return true;
>> +    case VIRT_MSI_CTRL_GICV2M:
>> +        return false;
>> +    case VIRT_MSI_CTRL_AUTO:
>> +        if (whpx_enabled() && whpx_irqchip_in_kernel()) {
>> +            return false;
>> +        }
>> +        if (vms->gic_version =3D=3D VIRT_GIC_VERSION_2) {
>>            return false;
>>        }
>> +        return true;
>>    }
>> -    return true;
>=20
> With the last return statement removed, I get a spurious warning from =
MSYS2/x86_64 GCC 15.2: "control reaches end of non-void function".
>=20
>> }
>>=20
>> -static void virt_get_its(Object *obj, Visitor *v, const char *name,
>> -                          void *opaque, Error **errp)
>> +bool virt_is_gicv2m_enabled(VirtMachineState *vms)
>> +{
>> +    switch (vms->msi_controller) {
>> +    case VIRT_MSI_CTRL_NONE:
>> +        return false;
>> +    default:
>> +        return !virt_is_its_enabled(vms);
>> +    }
>> +}
>> +
>> +static char *virt_get_msi(Object *obj, Error **errp)
>> +{
>> +    VirtMachineState *vms =3D VIRT_MACHINE(obj);
>> +    const char *val;
>> +
>> +    switch (vms->msi_controller) {
>> +    case VIRT_MSI_CTRL_NONE:
>> +        val =3D "off";
>> +        break;
>> +    case VIRT_MSI_CTRL_ITS:
>> +        val =3D "its";
>> +        break;
>> +    case VIRT_MSI_CTRL_GICV2M:
>> +        val =3D "gicv2m";
>> +        break;
>> +    case VIRT_MSI_CTRL_AUTO:
>> +        val =3D "auto";
>> +        break;
>> +    }
>=20
> Similar to the above I get a spurious warning: "'val' may be used =
uninitialized in this function".
>=20
> Apparently the compiler doesn't notice that both switch statements =
handle all enums. I wonder why it can figure that out in other cases=E2=80=
=A6
>=20
Hello,

I didn=E2=80=99t see this on Clang but I do see this on GCC. Will see =
what I can do=E2=80=A6

Apparently it=E2=80=99s =
https://stackoverflow.com/questions/33607284/control-reaches-end-of-non-vo=
id-function-with-fully-handled-case-switch-over-a and the best way to go =
seems to be to add an unreachable assert


> Other than that the series works for me!
>=20
> Best regards,
> Bernhard
>=20
>> +    return g_strdup(val);
>> +}
>> +
>> +static void virt_set_msi(Object *obj, const char *value, Error =
**errp)
>> {
>> +    ERRP_GUARD();
>>    VirtMachineState *vms =3D VIRT_MACHINE(obj);
>> -    OnOffAuto its =3D vms->its;
>>=20
>> -    visit_type_OnOffAuto(v, name, &its, errp);
>> +    if (!strcmp(value, "auto")) {
>> +        vms->msi_controller =3D VIRT_MSI_CTRL_AUTO; /* Will be =
overriden later */
>> +    } else if (!strcmp(value, "its")) {
>> +        vms->msi_controller =3D VIRT_MSI_CTRL_ITS;
>> +    } else if (!strcmp(value, "gicv2m")) {
>> +        vms->msi_controller =3D VIRT_MSI_CTRL_GICV2M;
>> +    } else if (!strcmp(value, "none")) {
>> +        vms->msi_controller =3D VIRT_MSI_CTRL_NONE;
>> +    } else {
>> +        error_setg(errp, "Invalid msi value");
>> +        error_append_hint(errp, "Valid values are auto, gicv2m, its, =
off\n");
>> +    }
>> }
>>=20
>> -static void virt_set_its(Object *obj, Visitor *v, const char *name,
>> -                          void *opaque, Error **errp)
>> +static bool virt_get_its(Object *obj, Error **errp)
>> {
>>    VirtMachineState *vms =3D VIRT_MACHINE(obj);
>>=20
>> -    visit_type_OnOffAuto(v, name, &vms->its, errp);
>> +    return virt_is_its_enabled(vms);
>> +}
>> +
>> +static void virt_set_its(Object *obj, bool value, Error **errp)
>> +{
>> +    VirtMachineState *vms =3D VIRT_MACHINE(obj);
>> +
>> +    if (value) {
>> +        vms->msi_controller =3D VIRT_MSI_CTRL_ITS;
>> +    } else if (vms->no_gicv3_with_gicv2m) {
>> +        vms->msi_controller =3D VIRT_MSI_CTRL_NONE;
>> +    } else {
>> +        vms->msi_controller =3D VIRT_MSI_CTRL_GICV2M;
>> +    }
>> }
>>=20
>> static bool virt_get_dtb_randomness(Object *obj, Error **errp)
>> @@ -3062,6 +3123,8 @@ static void =
virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>>            db_start =3D base_memmap[VIRT_GIC_V2M].base;
>>            db_end =3D db_start + base_memmap[VIRT_GIC_V2M].size - 1;
>>            break;
>> +        case VIRT_MSI_CTRL_AUTO:
>> +            g_assert_not_reached();
>>        }
>>        resv_prop_str =3D =
g_strdup_printf("0x%"PRIx64":0x%"PRIx64":%u",
>>                                        db_start, db_end,
>> @@ -3452,13 +3515,18 @@ static void =
virt_machine_class_init(ObjectClass *oc, const void *data)
>>                                          "guest CPU which implements =
the ARM "
>>                                          "Memory Tagging Extension");
>>=20
>> -    object_class_property_add(oc, "its", "OnOffAuto",
>> -        virt_get_its, virt_set_its,
>> -        NULL, NULL);
>> +    object_class_property_add_bool(oc, "its", virt_get_its,
>> +                                   virt_set_its);
>>    object_class_property_set_description(oc, "its",
>>                                          "Set on/off to =
enable/disable "
>>                                          "ITS instantiation");
>>=20
>> +    object_class_property_add_str(oc, "msi", virt_get_msi,
>> +                                  virt_set_msi);
>> +    object_class_property_set_description(oc, "msi",
>> +                                          "Set MSI settings. "
>> +                                          "Valid values are =
auto/gicv2m/its/off");
>> +
>>    object_class_property_add_bool(oc, "dtb-randomness",
>>                                   virt_get_dtb_randomness,
>>                                   virt_set_dtb_randomness);
>> @@ -3515,7 +3583,7 @@ static void virt_instance_init(Object *obj)
>>    vms->highmem_redists =3D true;
>>=20
>>    /* Default allows ITS instantiation if available */
>> -    vms->its =3D ON_OFF_AUTO_AUTO;
>> +    vms->msi_controller =3D VIRT_MSI_CTRL_AUTO;
>>    /* Allow ITS emulation if the machine version supports it */
>>    vms->tcg_its =3D !vmc->no_tcg_its;
>>    vms->no_gicv3_with_gicv2m =3D false;
>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>> index 394b70c62e..ff43bcb739 100644
>> --- a/include/hw/arm/virt.h
>> +++ b/include/hw/arm/virt.h
>> @@ -101,6 +101,8 @@ typedef enum VirtIOMMUType {
>>=20
>> typedef enum VirtMSIControllerType {
>>    VIRT_MSI_CTRL_NONE,
>> +    /* This value is overriden at runtime.*/
>> +    VIRT_MSI_CTRL_AUTO,
>>    VIRT_MSI_CTRL_GICV2M,
>>    VIRT_MSI_CTRL_ITS,
>> } VirtMSIControllerType;
>> @@ -147,7 +149,6 @@ struct VirtMachineState {
>>    bool highmem_ecam;
>>    bool highmem_mmio;
>>    bool highmem_redists;
>> -    OnOffAuto its;
>>    bool tcg_its;
>>    bool virt;
>>    bool ras;
>> @@ -217,5 +218,6 @@ static inline int =
virt_gicv3_redist_region_count(VirtMachineState *vms)
>> }
>>=20
>> bool virt_is_its_enabled(VirtMachineState *vms);
>> +bool virt_is_gicv2m_enabled(VirtMachineState *vms);
>>=20
>> #endif /* QEMU_ARM_VIRT_H */


--Apple-Mail=_4A6B8B2F-D822-46BA-8F37-1B300188141B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 14. Jan 2026, at 21:51, Bernhard Beschow =
&lt;shentey@gmail.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Am 14. Januar 2026 13:41:24 UTC schrieb =
Mohamed Mediouni &lt;</span><a href=3D"mailto:mohamed@unpredictable.fr" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;">mohamed@unpredictable.fr</a><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">&gt;:</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: =
none; text-decoration-thickness: auto; text-decoration-style: =
solid;">Introduce a -M msi=3D argument to be able to control MSI-X =
support independently<br>from ITS, as part of supporting GICv3 + GICv2m =
platforms.<br><br>Remove vms-&gt;its as it's no longer needed after that =
change.<br><br>Signed-off-by: Mohamed Mediouni =
&lt;mohamed@unpredictable.fr&gt;<br>---<br>hw/arm/virt-acpi-build.c | =
&nbsp;24 ++++++---<br>hw/arm/virt.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 108 =
+++++++++++++++++++++++++++++++--------<br>include/hw/arm/virt.h =
&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;4 +-<br>3 files changed, 108 =
insertions(+), 28 deletions(-)<br><br>diff --git =
a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c<br>index =
86024a1a73..187dd4e272 100644<br>--- a/hw/arm/virt-acpi-build.c<br>+++ =
b/hw/arm/virt-acpi-build.c<br>@@ -440,6 +440,17 @@ static void =
create_rc_its_idmaps(GArray *its_idmaps, GArray =
*smmuv3_devs)<br>&nbsp;&nbsp;&nbsp;}<br>}<br><br>+/*<br>+ * In the prior =
Qemu ACPI table handling, GICv2 configurations<br>+ * had =
vms-&gt;its=3D1... That's broken.<br>+ *<br>+ * Match that assumption to =
match the existing ACPI tables that<br>+ * have been shipping for quite =
a while.<br>+ */<br>+static int =
is_gicv2_acpi_workaround_needed(VirtMachineState *vms) {<br>+ =
&nbsp;&nbsp;&nbsp;return vms-&gt;gic_version =3D=3D =
2;<br>+}<br>+<br>/*<br>* Input Output Remapping Table (IORT)<br>* =
Conforms to "IO Remapping Table System Software on ARM Platforms",<br>@@ =
-473,7 +484,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, =
VirtMachineState =
*vms)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nb_nodes =3D =
num_smmus + 1; /* RC and SMMUv3 =
*/<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rc_mapping_count =3D =
rc_smmu_idmaps_len;<br><br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (virt_is_its_enabled(vms)) =
{<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
(virt_is_its_enabled(vms) || is_gicv2_acpi_workaround_needed(vms)) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/*<=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;* Knowing the ID ranges from the RC to the SMMU, it's possible =
to<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;* determine the ID ranges from RC that go directly to ITS.<br>@@ =
-484,7 +495,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, =
VirtMachineState =
*vms)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;rc_mapping_count +=3D =
rc_its_idmaps-&gt;len;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>&=
nbsp;&nbsp;&nbsp;} else {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (virt_is_its_enabled(vms)) =
{<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
(virt_is_its_enabled(vms) || is_gicv2_acpi_workaround_needed(vms)) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nb_=
nodes =3D 2; /* RC and ITS =
*/<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rc=
_mapping_count =3D 1; /* Direct map to ITS =
*/<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} else {<br>@@ -499,7 =
+510,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, =
VirtMachineState =
*vms)<br>&nbsp;&nbsp;&nbsp;build_append_int_noprefix(table_data, =
IORT_NODE_OFFSET, =
4);<br>&nbsp;&nbsp;&nbsp;build_append_int_noprefix(table_data, 0, 4); /* =
Reserved */<br><br>- &nbsp;&nbsp;&nbsp;if (virt_is_its_enabled(vms)) =
{<br>+ &nbsp;&nbsp;&nbsp;if (virt_is_its_enabled(vms) || =
is_gicv2_acpi_workaround_needed(vms)) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* Table 12 ITS Group =
Format =
*/<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;build_append_int_noprefix(=
table_data, 0 /* ITS Group */, 1); /* Type =
*/<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;node_size =3D &nbsp;20 =
/* fixed header size */ + 4 /* 1 GIC ITS Identifier */;<br>@@ -518,7 =
+529,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, =
VirtMachineState *vms)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int =
smmu_mapping_count, =
offset_to_id_array;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int irq =
=3D sdev-&gt;irq;<br><br>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
(virt_is_its_enabled(vms)) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (virt_is_its_enabled(vms) =
|| is_gicv2_acpi_workaround_needed(vms)) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;smm=
u_mapping_count =3D 1; /* ITS Group node =
*/<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;of=
fset_to_id_array =3D SMMU_V3_ENTRY_SIZE; /* Just after the header =
*/<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} else {<br>@@ -611,7 =
+622,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, =
VirtMachineState =
*vms)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;}<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (virt_is_its_enabled(vms)) =
{<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if =
(virt_is_its_enabled(vms) || is_gicv2_acpi_workaround_needed(vms)) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/*<=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;* Map bypassed (don't go through the SMMU) RIDs (input) =
to<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;* ITS Group node directly: RC -&gt; ITS.<br>@@ -962,8 +973,7 @@ =
build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState =
*vms)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;=
}<br><br>- &nbsp;&nbsp;&nbsp;if (!(vms-&gt;gic_version !=3D =
VIRT_GIC_VERSION_2 &amp;&amp; virt_is_its_enabled(vms))<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&amp;&amp; !vms-&gt;no_gicv3_with_gicv2m) {<br>+ =
&nbsp;&nbsp;&nbsp;if (virt_is_gicv2m_enabled(vms)) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;const uint16_t spi_base =3D=
 vms-&gt;irqmap[VIRT_GIC_V2M] + =
ARM_SPI_BASE;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* =
5.2.12.16 GIC MSI Frame Structure */<br>diff --git a/hw/arm/virt.c =
b/hw/arm/virt.c<br>index 553c7f62cc..0e84ccd82c 100644<br>--- =
a/hw/arm/virt.c<br>+++ b/hw/arm/virt.c<br>@@ -966,12 +966,12 @@ static =
void create_gic(VirtMachineState *vms, MemoryRegion =
*mem)<br><br>&nbsp;&nbsp;&nbsp;fdt_add_gic_node(vms);<br><br>- =
&nbsp;&nbsp;&nbsp;if (vms-&gt;gic_version !=3D VIRT_GIC_VERSION_2 =
&amp;&amp; virt_is_its_enabled(vms)) {<br>+ &nbsp;&nbsp;&nbsp;if =
(virt_is_its_enabled(vms)) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;create_its(vms);<br>- =
&nbsp;&nbsp;&nbsp;} else if (vms-&gt;gic_version !=3D VIRT_GIC_VERSION_2 =
&amp;&amp; !vms-&gt;no_gicv3_with_gicv2m) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;create_v2m(vms);<br>- =
&nbsp;&nbsp;&nbsp;} else if (vms-&gt;gic_version =3D=3D =
VIRT_GIC_VERSION_2) {<br>+ &nbsp;&nbsp;&nbsp;} else if =
(virt_is_gicv2m_enabled(vms)) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;create_v2m(vms);<br>+ =
&nbsp;&nbsp;&nbsp;} else {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vms-&gt;msi_controller =3D =
VIRT_MSI_CTRL_NONE;<br>&nbsp;&nbsp;&nbsp;}<br>}<br><br>@@ -2710,32 =
+2710,93 @@ static void virt_set_highmem_mmio_size(Object *obj, Visitor =
*v,<br><br>bool virt_is_its_enabled(VirtMachineState *vms)<br>{<br>- =
&nbsp;&nbsp;&nbsp;if (vms-&gt;its =3D=3D ON_OFF_AUTO_OFF) {<br>+ =
&nbsp;&nbsp;&nbsp;switch (vms-&gt;msi_controller) {<br>+ =
&nbsp;&nbsp;&nbsp;case =
VIRT_MSI_CTRL_NONE:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
false;<br>- &nbsp;&nbsp;&nbsp;}<br>- &nbsp;&nbsp;&nbsp;if (vms-&gt;its =
=3D=3D ON_OFF_AUTO_AUTO) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (whpx_enabled()) {<br>+ =
&nbsp;&nbsp;&nbsp;case VIRT_MSI_CTRL_ITS:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return true;<br>+ =
&nbsp;&nbsp;&nbsp;case VIRT_MSI_CTRL_GICV2M:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return false;<br>+ =
&nbsp;&nbsp;&nbsp;case VIRT_MSI_CTRL_AUTO:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (whpx_enabled() &amp;&amp; =
whpx_irqchip_in_kernel()) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
false;<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (vms-&gt;gic_version =3D=3D =
VIRT_GIC_VERSION_2) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret=
urn false;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
true;<br>&nbsp;&nbsp;&nbsp;}<br>- &nbsp;&nbsp;&nbsp;return =
true;<br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">With the last return statement removed, I =
get a spurious warning from MSYS2/x86_64 GCC 15.2: "control reaches end =
of non-void function".</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: =
none; text-decoration-thickness: auto; text-decoration-style: =
solid;">}<br><br>-static void virt_get_its(Object *obj, Visitor *v, =
const char *name,<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;void *opaque, Error **errp)<br>+bool =
virt_is_gicv2m_enabled(VirtMachineState *vms)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;switch (vms-&gt;msi_controller) {<br>+ =
&nbsp;&nbsp;&nbsp;case VIRT_MSI_CTRL_NONE:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return false;<br>+ =
&nbsp;&nbsp;&nbsp;default:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
!virt_is_its_enabled(vms);<br>+ =
&nbsp;&nbsp;&nbsp;}<br>+}<br>+<br>+static char *virt_get_msi(Object =
*obj, Error **errp)<br>+{<br>+ &nbsp;&nbsp;&nbsp;VirtMachineState *vms =3D=
 VIRT_MACHINE(obj);<br>+ &nbsp;&nbsp;&nbsp;const char *val;<br>+<br>+ =
&nbsp;&nbsp;&nbsp;switch (vms-&gt;msi_controller) {<br>+ =
&nbsp;&nbsp;&nbsp;case VIRT_MSI_CTRL_NONE:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;val =3D "off";<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;case VIRT_MSI_CTRL_ITS:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;val =3D "its";<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;case VIRT_MSI_CTRL_GICV2M:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;val =3D "gicv2m";<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;case VIRT_MSI_CTRL_AUTO:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;val =3D "auto";<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>+ =
&nbsp;&nbsp;&nbsp;}<br></blockquote><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Similar to the above I get a spurious =
warning: "'val' may be used uninitialized in this function".</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Apparently the compiler doesn't notice that =
both switch statements handle all enums. I wonder why it can figure that =
out in other cases=E2=80=A6</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"><br></div></blockquote>Hello,</div><div><br></div><div>I =
didn=E2=80=99t see this on Clang but I do see this on GCC. Will see what =
I can do=E2=80=A6</div><div><br></div><div>Apparently it=E2=80=99s&nbsp;<a=
 =
href=3D"https://stackoverflow.com/questions/33607284/control-reaches-end-o=
f-non-void-function-with-fully-handled-case-switch-over-a">https://stackov=
erflow.com/questions/33607284/control-reaches-end-of-non-void-function-wit=
h-fully-handled-case-switch-over-a</a>&nbsp;and the best way to go seems =
to be to add an unreachable =
assert</div><div><br></div><div><br><blockquote type=3D"cite"><div><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Other than that the series works for =
me!</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Best regards,</span><br style=3D"caret-color:=
 rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Bernhard</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: =
none; text-decoration-thickness: auto; text-decoration-style: solid;">+ =
&nbsp;&nbsp;&nbsp;return g_strdup(val);<br>+}<br>+<br>+static void =
virt_set_msi(Object *obj, const char *value, Error **errp)<br>{<br>+ =
&nbsp;&nbsp;&nbsp;ERRP_GUARD();<br>&nbsp;&nbsp;&nbsp;VirtMachineState =
*vms =3D VIRT_MACHINE(obj);<br>- &nbsp;&nbsp;&nbsp;OnOffAuto its =3D =
vms-&gt;its;<br><br>- &nbsp;&nbsp;&nbsp;visit_type_OnOffAuto(v, name, =
&amp;its, errp);<br>+ &nbsp;&nbsp;&nbsp;if (!strcmp(value, "auto")) =
{<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vms-&gt;msi_controller =
=3D VIRT_MSI_CTRL_AUTO; /* Will be overriden later */<br>+ =
&nbsp;&nbsp;&nbsp;} else if (!strcmp(value, "its")) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vms-&gt;msi_controller =3D =
VIRT_MSI_CTRL_ITS;<br>+ &nbsp;&nbsp;&nbsp;} else if (!strcmp(value, =
"gicv2m")) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vms-&gt;msi_controller =3D =
VIRT_MSI_CTRL_GICV2M;<br>+ &nbsp;&nbsp;&nbsp;} else if (!strcmp(value, =
"none")) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vms-&gt;msi_controller =3D =
VIRT_MSI_CTRL_NONE;<br>+ &nbsp;&nbsp;&nbsp;} else {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_setg(errp, "Invalid msi =
value");<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_append_hint(errp, "Valid =
values are auto, gicv2m, its, off\n");<br>+ =
&nbsp;&nbsp;&nbsp;}<br>}<br><br>-static void virt_set_its(Object *obj, =
Visitor *v, const char *name,<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;void *opaque, Error **errp)<br>+static bool virt_get_its(Object *obj, =
Error **errp)<br>{<br>&nbsp;&nbsp;&nbsp;VirtMachineState *vms =3D =
VIRT_MACHINE(obj);<br><br>- &nbsp;&nbsp;&nbsp;visit_type_OnOffAuto(v, =
name, &amp;vms-&gt;its, errp);<br>+ &nbsp;&nbsp;&nbsp;return =
virt_is_its_enabled(vms);<br>+}<br>+<br>+static void virt_set_its(Object =
*obj, bool value, Error **errp)<br>+{<br>+ =
&nbsp;&nbsp;&nbsp;VirtMachineState *vms =3D VIRT_MACHINE(obj);<br>+<br>+ =
&nbsp;&nbsp;&nbsp;if (value) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vms-&gt;msi_controller =3D =
VIRT_MSI_CTRL_ITS;<br>+ &nbsp;&nbsp;&nbsp;} else if =
(vms-&gt;no_gicv3_with_gicv2m) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vms-&gt;msi_controller =3D =
VIRT_MSI_CTRL_NONE;<br>+ &nbsp;&nbsp;&nbsp;} else {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vms-&gt;msi_controller =3D =
VIRT_MSI_CTRL_GICV2M;<br>+ &nbsp;&nbsp;&nbsp;}<br>}<br><br>static bool =
virt_get_dtb_randomness(Object *obj, Error **errp)<br>@@ -3062,6 +3123,8 =
@@ static void virt_machine_device_pre_plug_cb(HotplugHandler =
*hotplug_dev,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;db_start =3D =
base_memmap[VIRT_GIC_V2M].base;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;db_end =3D db_start + =
base_memmap[VIRT_GIC_V2M].size - =
1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;br=
eak;<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case =
VIRT_MSI_CTRL_AUTO:<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;g_assert=
_not_reached();<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;resv_prop_str =3D =
g_strdup_printf("0x%"PRIx64":0x%"PRIx64":%u",<br>&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;db_start, =
db_end,<br>@@ -3452,13 +3515,18 @@ static void =
virt_machine_class_init(ObjectClass *oc, const void =
*data)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"guest CPU which implements the ARM =
"<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"Memory Tagging Extension");<br><br>- =
&nbsp;&nbsp;&nbsp;object_class_property_add(oc, "its", "OnOffAuto",<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;virt_get_its, =
virt_set_its,<br>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NULL, =
NULL);<br>+ &nbsp;&nbsp;&nbsp;object_class_property_add_bool(oc, "its", =
virt_get_its,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;virt_set_its);<br>=
&nbsp;&nbsp;&nbsp;object_class_property_set_description(oc, =
"its",<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"Set on/off to enable/disable =
"<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"ITS instantiation");<br><br>+ =
&nbsp;&nbsp;&nbsp;object_class_property_add_str(oc, "msi", =
virt_get_msi,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;virt_set_msi);<br>+ =
&nbsp;&nbsp;&nbsp;object_class_property_set_description(oc, "msi",<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;"Set MSI settings. "<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;"Valid values are =
auto/gicv2m/its/off");<br>+<br>&nbsp;&nbsp;&nbsp;object_class_property_add=
_bool(oc, =
"dtb-randomness",<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;virt_get_dtb_randomness,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;virt_set_dtb_randomness);<br>@@ -3515,7 +3583,7 @@ static =
void virt_instance_init(Object =
*obj)<br>&nbsp;&nbsp;&nbsp;vms-&gt;highmem_redists =3D =
true;<br><br>&nbsp;&nbsp;&nbsp;/* Default allows ITS instantiation if =
available */<br>- &nbsp;&nbsp;&nbsp;vms-&gt;its =3D =
ON_OFF_AUTO_AUTO;<br>+ &nbsp;&nbsp;&nbsp;vms-&gt;msi_controller =3D =
VIRT_MSI_CTRL_AUTO;<br>&nbsp;&nbsp;&nbsp;/* Allow ITS emulation if the =
machine version supports it */<br>&nbsp;&nbsp;&nbsp;vms-&gt;tcg_its =3D =
!vmc-&gt;no_tcg_its;<br>&nbsp;&nbsp;&nbsp;vms-&gt;no_gicv3_with_gicv2m =3D=
 false;<br>diff --git a/include/hw/arm/virt.h =
b/include/hw/arm/virt.h<br>index 394b70c62e..ff43bcb739 100644<br>--- =
a/include/hw/arm/virt.h<br>+++ b/include/hw/arm/virt.h<br>@@ -101,6 =
+101,8 @@ typedef enum VirtIOMMUType {<br><br>typedef enum =
VirtMSIControllerType {<br>&nbsp;&nbsp;&nbsp;VIRT_MSI_CTRL_NONE,<br>+ =
&nbsp;&nbsp;&nbsp;/* This value is overriden at runtime.*/<br>+ =
&nbsp;&nbsp;&nbsp;VIRT_MSI_CTRL_AUTO,<br>&nbsp;&nbsp;&nbsp;VIRT_MSI_CTRL_G=
ICV2M,<br>&nbsp;&nbsp;&nbsp;VIRT_MSI_CTRL_ITS,<br>} =
VirtMSIControllerType;<br>@@ -147,7 +149,6 @@ struct VirtMachineState =
{<br>&nbsp;&nbsp;&nbsp;bool highmem_ecam;<br>&nbsp;&nbsp;&nbsp;bool =
highmem_mmio;<br>&nbsp;&nbsp;&nbsp;bool highmem_redists;<br>- =
&nbsp;&nbsp;&nbsp;OnOffAuto its;<br>&nbsp;&nbsp;&nbsp;bool =
tcg_its;<br>&nbsp;&nbsp;&nbsp;bool virt;<br>&nbsp;&nbsp;&nbsp;bool =
ras;<br>@@ -217,5 +218,6 @@ static inline int =
virt_gicv3_redist_region_count(VirtMachineState *vms)<br>}<br><br>bool =
virt_is_its_enabled(VirtMachineState *vms);<br>+bool =
virt_is_gicv2m_enabled(VirtMachineState *vms);<br><br>#endif /* =
QEMU_ARM_VIRT_H =
*/</blockquote></div></blockquote></div><br></body></html>=

--Apple-Mail=_4A6B8B2F-D822-46BA-8F37-1B300188141B--

