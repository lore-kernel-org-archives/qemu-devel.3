Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E2DC87FDB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 13:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulShV-0006Y1-8r; Mon, 11 Aug 2025 09:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ulSgh-0006Fr-W1
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 09:35:47 -0400
Received: from p-east3-cluster5-host11-snip4-2.eps.apple.com ([57.103.86.233]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ulSgY-0005DE-4W
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 09:35:43 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-11 (Postfix) with ESMTPS id
 4DE6118001B9; Mon, 11 Aug 2025 13:35:24 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=cCMy52rWPN6zVMGOFW7WEatatWZrbdK06kVts+zihQM=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Mws25wXFVcKJ40WZ7h+r4A3ixcutaP79eVyIdq3MckiCYcTmUFe7G/lTxyq51j5GsBOBZBo7boW86xj+7ViMo8HvPY66TH0BnpBkHEpGIEDZIWFoZBhOC31yiNuuK9NvbmRxotyrCEv+P0dFMB4cj33pZsrQThKkzdh/pajULSIhTzwGopL2Zb0XJHMPWw9SCI55eSeNXluW4MCjQnuXAZRDd56BUmw3H+mJ4BXqJ4We5+089A2oMcuC7cSVbzY93Hknf2QNZ+iul/K4a1Bs2cmoW4MkHTk0px9L5EQTAebgo5cb2GvW+9CWOrmP8s/UaL8WqwwfWyfEF32yTiQ2+Q==
X-Client-IP: 46.189.47.18
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-11 (Postfix) with ESMTPSA id
 106081800164; Mon, 11 Aug 2025 13:35:17 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3863.100.1\))
Subject: Re: [PATCH v6 05/13] hw/arm, target/arm: nested virtualisation on HVF
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <caeafe09-4c2c-48bf-9f46-f6e739931b26@linaro.org>
Date: Mon, 11 Aug 2025 15:35:04 +0200
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <92BA9519-F39C-4D7C-A5AD-B23E734417BE@unpredictable.fr>
References: <20250808070137.48716-1-mohamed@unpredictable.fr>
 <20250808070137.48716-6-mohamed@unpredictable.fr>
 <caeafe09-4c2c-48bf-9f46-f6e739931b26@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3863.100.1)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA4NiBTYWx0ZWRfX8kLR9IZ5xrl9
 oorbUABtcwsGsiYe/ZIk/UagsGMnOuIoEOjQfuigU2AlVOFE42KS3stUBYF4lJNAmHdhQyrO/AN
 iHbrvEEc2LZRAntcRfuxocUwZze5EMj8UZ84ksTo6jy7QB2z/Ld23/vxwxv7I4XYL433rNiQ0Nv
 KaohYtiAIHOxexyxJkvYIr6UVu1W9ayPtbHlbX+rXX27ZXMvm4aIxXQAZ6oCWpaUyjN0/hjjoDd
 Mv0eJ+5dUAqp2IkwLFWjcrxOglegApLMVGWEPnFrZbMrVLEzWK6eQ7k4QCOVXUBtoN3FN35Ko=
X-Proofpoint-GUID: DtU_Af0FyzaabdeJUEISrE04ywOdyqWo
X-Proofpoint-ORIG-GUID: DtU_Af0FyzaabdeJUEISrE04ywOdyqWo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1030 mlxlogscore=999 adultscore=0
 mlxscore=0 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508110086
Received-SPF: pass client-ip=57.103.86.233;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, KHOP_HELO_FCRDNS=0.399, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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



> On 11. Aug 2025, at 14:56, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> On 8/8/25 09:01, Mohamed Mediouni wrote:
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>>  hw/arm/virt.c         |  9 ++++++---
>>  target/arm/hvf-stub.c | 15 +++++++++++++++
>>  target/arm/hvf/hvf.c  | 41 +++++++++++++++++++++++++++++++++++++++--
>>  target/arm/hvf_arm.h  |  3 +++
>>  4 files changed, 63 insertions(+), 5 deletions(-)
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 59e6c2b9df..91d8cd9363 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -817,8 +817,7 @@ static void create_gic(VirtMachineState *vms, =
MemoryRegion *mem)
>>          g_assert_not_reached();
>>      }
>>  -    if (kvm_enabled() && vms->virt &&
>> -        (revision !=3D 3 || !kvm_irqchip_in_kernel())) {
>> +    if (kvm_enabled() && vms->virt && (revision !=3D 3 || =
!kvm_irqchip_in_kernel())) {
>>          error_report("KVM EL2 is only supported with in-kernel =
GICv3");
>>          exit(1);
>>      }
>> @@ -2281,7 +2280,8 @@ static void machvirt_init(MachineState =
*machine)
>>          exit(1);
>>      }
>>  -    if (vms->virt && !kvm_enabled() && !tcg_enabled() && =
!qtest_enabled()) {
>> +    if (vms->virt && !kvm_enabled() && !tcg_enabled()
>> +       && !hvf_enabled() && !qtest_enabled()) {
>>          error_report("mach-virt: %s does not support providing "
>>                       "Virtualization extensions to the guest CPU",
>>                       current_accel_name());
>> @@ -2553,6 +2553,9 @@ static void virt_set_virt(Object *obj, bool =
value, Error **errp)
>>      VirtMachineState *vms =3D VIRT_MACHINE(obj);
>>        vms->virt =3D value;
>> +#if defined(CONFIG_HVF) && defined(__aarch64__)
>> +    hvf_arm_el2_enable(value);
>> +#endif
>>  }
> We don't have hvf_arm_el1_enable(). I think we just want to always
> provide the most performant configuration to users.
> IOW, we don't need hvf_arm_el2_enable(). I'd just always enable EL2
> (if supported) in hvf_arm_get_host_cpu_features().
A different feature set is exposed when EL2 is enabled. For example, SME =
is not currently exposed in that mode.

(We currently disable SME in Qemu anyway but that=E2=80=99s something I =
plan to take care of)=

