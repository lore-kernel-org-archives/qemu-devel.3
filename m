Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D847CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 12:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGyoU-0001Wr-6o; Thu, 06 Nov 2025 07:10:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vGyoS-0001WK-Rx
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 07:10:00 -0500
Received: from p-east3-cluster5-host8-snip4-7.eps.apple.com ([57.103.86.208]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vGyoQ-0001z2-Kv
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 07:10:00 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPS id
 B91561800130; Thu,  6 Nov 2025 12:09:53 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=bTR8DcHlBo4/PEdqpQRrgkcmIdSXDbGRfLCtzvF8BAw=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=f/5rkznJdTsglZQ9Ct7CI0irYp30DHNEYCfkxgDyTF/uUDvRAKQorcPORicmgpJ1I9xxERQJUH0Aqun6LEfhk95u6h5MtQpWTL0s76mhqKbZGC2KroPl+koRlGwdalWcH6KBh9qkYY7cynNf/K98odtYKK3Qfob/Io0FC7eglnr0or60IYx9S2oKRyMo7JBOjC3slLScfk3ti8GL3vxQy7wNZV6BdBxiTO4uvUTrDD7w773Wu0VtL+RQZwxLVFNkhyy5Bz4e2fhiu0/cRlIygJO8C5XsADqS+QGGo3ZESNezzdrnUG7/8nuvKzxtuiW3/UvoLm8fuGuBaUG93M2+ZA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPSA id
 273C618000A9; Thu,  6 Nov 2025 12:09:52 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.200.81.1.6\))
Subject: Re: [PATCH v10 17/28] hw: arm: virt-acpi-build: add hack
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <e52c8dd0-d284-4dc0-ad0c-3832ce996884@linaro.org>
Date: Thu, 6 Nov 2025 13:09:40 +0100
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <50C705D7-5DEC-4B3F-A603-25551C8A964C@unpredictable.fr>
References: <20251029165510.45824-1-mohamed@unpredictable.fr>
 <20251029165510.45824-18-mohamed@unpredictable.fr>
 <e52c8dd0-d284-4dc0-ad0c-3832ce996884@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
X-Mailer: Apple Mail (2.3864.200.81.1.6)
X-Proofpoint-ORIG-GUID: DI5TIAIBwArfqUpndIr-LsLFaccMYiFu
X-Proofpoint-GUID: DI5TIAIBwArfqUpndIr-LsLFaccMYiFu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA5NiBTYWx0ZWRfXwqG6rhwYYSSy
 bH6MILj6nKRVxqlvk36hTL75NEqJ+GUo4KqDPaXnUpwO0blQ04VOmf16kI4zxZ5Wk4W44Ebny23
 hMPDSNJVO/ERfE/bCsNXkJeWLMD3SEpS85t+dc7ErYQiFPGJFt7TJcoCfPJhCg2S0/VtGbntaU8
 xjWgTYe9R3kHp9Nbm4sxqoOiRQtx5wqVVOxTmolFBIhCNf+J++mv+LZYgYwePJJt+Eiw2pLbRk8
 ceLFxDQzKtp2fVDLqDC7USPksGUNQk03CnC7Y6AA46aEfGyVcuRORGujIRYSodX+8rbNcf7Ncni
 YRRegD1NMn0NAFvQUbp
X-Authority-Info: v=2.4 cv=IdyKmGqa c=1 sm=1 tr=0 ts=690c9012 cx=c_apl:c_pps
 a=bsP7O+dXZ5uKcj+dsLqiMw==:117 a=bsP7O+dXZ5uKcj+dsLqiMw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=KKAkSRfTAAAA:8 a=nPwZXD_PinSu4dW7AjYA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 bulkscore=0 clxscore=1030 spamscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2509250000 definitions=main-2511060096
X-JNJ: AAAAAAABlkIy0wY7n+AZm4T78A5e5Bmc7V1CRayakldEbZ0sqYOTIYjpLMVwTYu9dFjAJBWv+EMGBaB59ceBP6ACyfNqJGwn6GhgjHA90toXgLmY53RaVasMnTKqAUr06wiEDq/QZfCp7xRgpBba6k11LZyx9dZcbzFSVdQj0etDJPaJ403np1xvZBewMF5TyqxL3dS89tjGPm40ksYGIwPtg2Z8PYxH1MNXRTD/InGPPnLrIHqpwGRfdLDeSt5pkZ7u01QAfuOu3brB8jm+P4i8NT+l22ykLAWHkuQlhV40hRRuth6JYfGDR5YdhBnrNaCRvjOuJgDfjbqhLCYPY4CsZzhJR1u4TvhAVSX/+WV/Y6SVWCd4svDPrpS0HeRY1o9PV/bo4X4G6B2nEQxPvhaM6Vqj70BS44ZCp3goofEoM4jjxJHyuLTnUIwBSmoiyRxao1TA6NdlYrg6ltnKXOC1lcpjRvslsUDqbiS9qr3VagUvrnBHqxbDJFlZ3Qd+NHBHjtbSoIyS4sHSlwybtZFr56kcOknLJ4EwYEZeKi+8tMT3PoO0pWrSIOr1+W8tH31jbq15BuGH2r3+1aU8dQzmVBDPP52IF7d2EFmrNKzvNvFNJLu541zKlevT8wocgV0ZCUPdLbzytq/w80UinV7H6CtvEeTl8PzRdql1DRgzSHnzr8dT2R/8w+2MNCZbFkpnFSw/qzd6ejoPiI0=
Received-SPF: pass client-ip=57.103.86.208;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> On 6. Nov 2025, at 10:40, Gustavo Romero <gustavo.romero@linaro.org> =
wrote:
>=20
> Hi Mohamed and Phil,
>=20
> On 10/29/25 17:54, Mohamed Mediouni wrote:
>> Looks like in the prior Qemu ACPI table handling, GICv2 =
configurations
>> had vms->its=3D1...
>=20
> To me, ITS should not be present on machines that have GICv2, so we =
should not generate
> any ACPI table advertising ITS when GICv2 is used.
>=20
The problem is breaking migration/backwards compatibility=E2=80=A6 is it =
an ignorable concern or
should be the new behaviour be quirked to apply to only Qemu 11.0 =
onwards?

Thank you,
-Mohamed
> Cheers,
> Gustavo
>=20
>> Match that assumption to not make the test suite fail. Probably not =
merge-worthy...
>> And then maybe see what to do for older releases too?
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>>  hw/arm/virt-acpi-build.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index a6a56455a9..39dd3d1020 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -472,7 +472,7 @@ build_iort(GArray *table_data, BIOSLinker =
*linker, VirtMachineState *vms)
>>          nb_nodes =3D num_smmus + 1; /* RC and SMMUv3 */
>>          rc_mapping_count =3D rc_smmu_idmaps_len;
>>  -        if (virt_is_its_enabled(vms)) {
>> +        if (virt_is_its_enabled(vms) || vms->gic_version =3D=3D 2) {
>>              /*
>>               * Knowing the ID ranges from the RC to the SMMU, it's =
possible to
>>               * determine the ID ranges from RC that go directly to =
ITS.
>> @@ -483,7 +483,7 @@ build_iort(GArray *table_data, BIOSLinker =
*linker, VirtMachineState *vms)
>>              rc_mapping_count +=3D rc_its_idmaps->len;
>>          }
>>      } else {
>> -        if (virt_is_its_enabled(vms)) {
>> +        if (virt_is_its_enabled(vms) || vms->gic_version =3D=3D 2) {
>>              nb_nodes =3D 2; /* RC and ITS */
>>              rc_mapping_count =3D 1; /* Direct map to ITS */
>>          } else {
>> @@ -498,7 +498,7 @@ build_iort(GArray *table_data, BIOSLinker =
*linker, VirtMachineState *vms)
>>      build_append_int_noprefix(table_data, IORT_NODE_OFFSET, 4);
>>      build_append_int_noprefix(table_data, 0, 4); /* Reserved */
>>  -    if (virt_is_its_enabled(vms)) {
>> +    if (virt_is_its_enabled(vms) || vms->gic_version =3D=3D 2) {
>>          /* Table 12 ITS Group Format */
>>          build_append_int_noprefix(table_data, 0 /* ITS Group */, 1); =
/* Type */
>>          node_size =3D  20 /* fixed header size */ + 4 /* 1 GIC ITS =
Identifier */;
>> @@ -517,7 +517,7 @@ build_iort(GArray *table_data, BIOSLinker =
*linker, VirtMachineState *vms)
>>          int smmu_mapping_count, offset_to_id_array;
>>          int irq =3D sdev->irq;
>>  -        if (virt_is_its_enabled(vms)) {
>> +        if (virt_is_its_enabled(vms) || vms->gic_version =3D=3D 2) {
>>              smmu_mapping_count =3D 1; /* ITS Group node */
>>              offset_to_id_array =3D SMMU_V3_ENTRY_SIZE; /* Just after =
the header */
>>          } else {
>> @@ -610,7 +610,7 @@ build_iort(GArray *table_data, BIOSLinker =
*linker, VirtMachineState *vms)
>>              }
>>          }
>>  -        if (virt_is_its_enabled(vms)) {
>> +        if (virt_is_its_enabled(vms) || vms->gic_version =3D=3D 2) {
>>              /*
>>               * Map bypassed (don't go through the SMMU) RIDs (input) =
to
>>               * ITS Group node directly: RC -> ITS.
>=20
>=20


