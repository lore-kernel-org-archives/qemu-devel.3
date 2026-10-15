Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E41CC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHEjU-0008Lt-9W; Thu, 15 Oct 2026 02:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHEjR-0008Ie-1V
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:14:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHEjO-0004eH-TG
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:14:24 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F3xmq92739406
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 06:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gd1Fx2wEdC+n+5kj89cGBNzkO2yK4ty9WSvc7MGr96Y=; b=jf4dEL7tJiikOfGO
 f37wkZTDlIiaDqPZAyY/8j5/LNDZkL7AEujoEyKubfYeuww+El2rDFK135T1L6EE
 bZx/ycefBbb8zus34utcQTi6+q+5n8r2uDrU3AdJ9CWnYZi6rgJL/HofP7JYL3U3
 iLq1gEmfWjCAWqgEGYDNIwcqcU61Rer6VpeYXJ6/etSLyNN2nRDrDn9eezr3K0Dj
 uwjFIQLqS0DZFp/+F6ehFbmWaj/jxQCTKD8TqLMxzv1Dqg0YBI5UDIg/Qi/aEJ14
 MWVK/g7iOdLq+DJF3WBRr2SaIAEpPETTMSaxSJ0nR5N7EiRZ5qx3blZ/oODNI7/r
 +yMlvg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqds8dsm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 06:14:20 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cbb20f82a0eso3437825a12.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792044860; x=1792649660; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gd1Fx2wEdC+n+5kj89cGBNzkO2yK4ty9WSvc7MGr96Y=;
 b=E6Ot1L/Nyqdjr3xUdrpWkppHzOliieMBZiv+c3FxCVufi0PA8w59gDtBn2N+OPsBki
 ANxT8lEWfYPxhc2BXf1T2xGEOgZnWYrMRUXkEp3MknVC9pDpVs132Th4Ykbu3omFHz5Z
 2EcTOIwYWgHpivqsG5tixoD3v4rbegSzgYG2hlToOSHG5anLQXR0wZFOQROl8E1xT5J5
 ivK0zvDnfCbM36oBYlGeNa8YKQFM51KjHYKJ5CNO1VgvEHLzCmvX7JsNT47t4r+y3Vux
 vvznmO7Kf+f8i40FbJ+c2eOGEje+XtUAqvVY4TGqmA2ClZ/GV0hvV/1BhQ/Hvd+4Rvk7
 rUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792044860; x=1792649660;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gd1Fx2wEdC+n+5kj89cGBNzkO2yK4ty9WSvc7MGr96Y=;
 b=Qp17B7hNHyIK9VlH93BTQNlb6k1t4TV+yXMllgLtUxuUxMCnSHANJqVnLyVSqTDTPM
 0fc0wcdYE1EFDeYFUfPri7qwIbo2uEb7YJPYwctEgSmd/vVr4oipcGgrZS+R5UbPem/b
 JKFgxbLJdHpwxhQ0Op0I3OLleN0Z4iDJLWb9BCQ7g7v+m6rgRefOObQnvL0KeZkRhGQ3
 cFp7xL28DQ7Zft4u47iwxJmdGMAPcoh0E6kQyDs5B/iDeWOVsbNV6rKoU48nfJegrJqJ
 6004TAJATek18P6KAHFVRBwmRibrO9XKQbVEN/iqR0k/9b5ylxSycfH4FK8HXp3qdp7q
 TwZw==
X-Gm-Message-State: AFq9FYJURk/7yY7aO+B94uMnhBhlR70Q+szcxivRK06L5F0G+w1I0Awu
 vKASlvKgc/7MMq3vEcSklv5ZBRNu7rt7fn3L27N4bpvBdwuyjY5n32Vf35chHKEAr7AMl2uUYje
 C54Vhf4TPpv4Wb5g37HKBUHoLBXD4cKwOEdin0A9uPKlvLcBIlN1PlJ9LFw==
X-Gm-Gg: AYBFou2vJnwl75OpQQI7Ur+gaO1fv7nk6EkHB2ecAOKU3DrSQnu5H5AprS2Dv7WexuR
 lFSzls43o6fxoqMd3FSKDvZuPcnRT0RUxUgih17V4GtfuYs5rjUa7FBw6o9euY4lpjud7SAYRJC
 xzdlr8DjR+B86JcgdDEOLoX7+EvcEzPnt0fOl4HiIjuD1mghbYUSN+cqxSCekZjrfpgfCjR4/Ce
 gfRsIHGzi4vSBse3Fhblifxw6/279U2V59gMlJdXigQg91oUZepsmLmIjw2YEgvsQ55bBFLk2FG
 /O2B6dxGjsOJl2DkTP2720eqo2ypio07IPvaeNJy74qMsgwdt3OkHR6kLZsNQnxfj5z9MqFz1aE
 6EvsYGGZam3g94T/KDsE+cRaW6zt4Xy2M/nJHGWVPlMoC5umVnTxWczkZ
X-Received: by 2002:a05:6a20:6a0e:b0:3e0:c5f5:626c with SMTP id
 adf61e73a8af0-3e16be43d18mr13070083637.40.1792044859896; 
 Wed, 14 Oct 2026 23:14:19 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a0e:b0:3e0:c5f5:626c with SMTP id
 adf61e73a8af0-3e16be43d18mr13070070637.40.1792044859374; 
 Wed, 14 Oct 2026 23:14:19 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89d803cc0a5sm1862908b3a.30.2026.10.14.23.14.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 23:14:18 -0700 (PDT)
Message-ID: <e6c39225-d713-4bef-af49-a451a64fa4db@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 23:14:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] qmp: reimplement qmp_query_cpu_definitions as a
 dispatcher function
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
 <20261015005355.62406-9-pierrick.bouvier@oss.qualcomm.com>
 <87cxtbbj5i.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <87cxtbbj5i.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: E-kopXPsoxxt1hsu2kbrD1Boxgul_Sfz
X-Authority-Analysis: v=2.4 cv=fNusTpae c=1 sm=1 tr=0 ts=6ad06f3c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=XfvIXIaxakq8nYA5joAA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAyNCBTYWx0ZWRfXxCpJLCqR51JN
 AKnBYZhlHfWoA5UvZFhyYE2aVSU2Lf81878uHPBduCrnxkL3MYZAWH2LgVKcDSMaibIlCoz4TzI
 POPL0ZmEOa6CJhsys3YnoggKyzBRGSrRAYubod+w0kUDE73PtuO2RmekX0q4U+Pxk6TEU2gPGrU
 A3xFVF3QkblGFp/kS49RBCimijuslDElUOErsV5f9KvWT22t/WTkxvvbUd/uibKjt5PqCGCGtyr
 TXUOQutQ5KeWAboXPPDqBulJcbYOYleA/+y6sXHYoQWHsr+8KzNXo/tI4iLKBzmIerBJXAGPOvk
 7an+YTgfHisc/S4wETuTD/PrhcCbE/cM2jNBF4Y7PDfGTzbpD/JXrnXTvp1+R399qnSPKyrfth9
 2k62Y6MHDTDu5AECy5Fas7Yj7J7Jz/LMh42RW62rj4pLx6bKkIRV4tVm9oZRmJRKzBFWnnpCfdE
 zixlNdmeTmOA1Nhm/3w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAyNCBTYWx0ZWRfX09wrs1haky3d
 BLRcVPNSDCD5p1+fwI81fi191WD9uaUPVjY47sMU1Jq54m63ViwjZYGLMDBLD1Tc9GjAj3C6+RW
 P8afeNZXgglqHYlvIfG4aVp4Wehjt3o=
X-Proofpoint-GUID: E-kopXPsoxxt1hsu2kbrD1Boxgul_Sfz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150024
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 10/14/26 10:57 PM, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> Now that we have per target implementations of this function, we simply
>> dispatch the call to relevant implementation.
>> This eliminates duplication of qmp_query_cpu_definitions symbol.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   hw/core/machine-qmp-cmds.c            | 32 +++++++++++++++++++++++++++
>>   stubs/meson.build                     |  6 +++++
>>   stubs/qmp-cpu-arm.c                   |  9 ++++++++
>>   stubs/qmp-cpu-i386.c                  |  9 ++++++++
>>   stubs/qmp-cpu-loongarch.c             |  9 ++++++++
>>   stubs/qmp-cpu-mips.c                  |  9 ++++++++
>>   stubs/qmp-cpu-ppc.c                   |  9 ++++++++
>>   stubs/qmp-cpu-riscv.c                 |  9 ++++++++
>>   stubs/qmp-cpu-s390x.c                 |  6 +++++
>>   stubs/qmp-cpu.c                       |  7 ------
>>   target/arm/arm-qmp-cmds.c             |  5 -----
>>   target/i386/cpu.c                     |  5 -----
>>   target/loongarch/loongarch-qmp-cmds.c |  5 -----
>>   target/mips/system/mips-qmp-cmds.c    |  5 -----
>>   target/ppc/ppc-qmp-cmds.c             |  5 -----
>>   target/riscv/riscv-qmp-cmds.c         |  5 -----
>>   target/s390x/cpu_models_system.c      |  5 -----
>>   17 files changed, 98 insertions(+), 42 deletions(-)
>>   create mode 100644 stubs/qmp-cpu-arm.c
>>   create mode 100644 stubs/qmp-cpu-i386.c
>>   create mode 100644 stubs/qmp-cpu-loongarch.c
>>   create mode 100644 stubs/qmp-cpu-mips.c
>>   create mode 100644 stubs/qmp-cpu-ppc.c
>>   create mode 100644 stubs/qmp-cpu-riscv.c
>>
>> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
>> index 9c08b17510a..3fee45d568d 100644
>> --- a/hw/core/machine-qmp-cmds.c
>> +++ b/hw/core/machine-qmp-cmds.c
>> @@ -27,6 +27,7 @@
>>   #include "system/hostmem.h"
>>   #include "system/hw_accel.h"
>>   #include "system/numa.h"
>> +#include "system/qmp-cpu.h"
>>   #include "system/ramlist.h"
>>   #include "system/runstate.h"
>>   #include "system/system.h"
>> @@ -93,6 +94,37 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
>>       return head;
>>   }
>>   
>> +CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
>> +{
>> +    switch (target_arch()) {
>> +    case SYS_EMU_TARGET_AARCH64:
>> +    case SYS_EMU_TARGET_ARM:
>> +        return qmp_query_arm_cpu_definitions(errp);
>> +    case SYS_EMU_TARGET_I386:
>> +    case SYS_EMU_TARGET_X86_64:
>> +        return qmp_query_i386_cpu_definitions(errp);
>> +    case SYS_EMU_TARGET_LOONGARCH64:
>> +        return qmp_query_loongarch_cpu_definitions(errp);
>> +    case SYS_EMU_TARGET_MIPS:
>> +    case SYS_EMU_TARGET_MIPS64:
>> +    case SYS_EMU_TARGET_MIPS64EL:
>> +    case SYS_EMU_TARGET_MIPSEL:
>> +        return qmp_query_mips_cpu_definitions(errp);
>> +    case SYS_EMU_TARGET_PPC:
>> +    case SYS_EMU_TARGET_PPC64:
>> +        return qmp_query_ppc_cpu_definitions(errp);
>> +    case SYS_EMU_TARGET_RISCV32:
>> +    case SYS_EMU_TARGET_RISCV64:
>> +        return qmp_query_riscv_cpu_definitions(errp);
>> +    case SYS_EMU_TARGET_S390X:
>> +        return qmp_query_s390x_cpu_definitions(errp);
>> +    default:
>> +        error_setg(errp,
>> +                   "CPU model definitions are not supported on this target");
>> +        return NULL;
>> +    }
>> +}
>> +
>>   MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
>>                                       Error **errp)
>>   {
>> diff --git a/stubs/meson.build b/stubs/meson.build
>> index 29b6644b254..dcb67ce5295 100644
>> --- a/stubs/meson.build
>> +++ b/stubs/meson.build
>> @@ -86,6 +86,12 @@ if have_system
>>     stub_ss.add(files('qmp-i386-sgx.c'))
>>     stub_ss.add(files('qmp-i386-xen.c'))
>>     stub_ss.add(files('qmp-cpu.c'))
>> +  stub_ss.add(files('qmp-cpu-arm.c'))
>> +  stub_ss.add(files('qmp-cpu-i386.c'))
>> +  stub_ss.add(files('qmp-cpu-loongarch.c'))
>> +  stub_ss.add(files('qmp-cpu-mips.c'))
>> +  stub_ss.add(files('qmp-cpu-ppc.c'))
>> +  stub_ss.add(files('qmp-cpu-riscv.c'))
>>     stub_ss.add(files('qmp-cpu-s390x.c'))
>>     stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
>>     if have_hmp
>> diff --git a/stubs/qmp-cpu-arm.c b/stubs/qmp-cpu-arm.c
>> new file mode 100644
>> index 00000000000..6249d7bde8d
>> --- /dev/null
>> +++ b/stubs/qmp-cpu-arm.c
>> @@ -0,0 +1,9 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +
>> +#include "qemu/osdep.h"
>> +#include "system/qmp-cpu.h"
>> +
>> +CpuDefinitionInfoList *qmp_query_arm_cpu_definitions(Error **errp)
>> +{
>> +    g_assert_not_reached();
>> +}
>> diff --git a/stubs/qmp-cpu-i386.c b/stubs/qmp-cpu-i386.c
>> new file mode 100644
>> index 00000000000..4858951f8c2
>> --- /dev/null
>> +++ b/stubs/qmp-cpu-i386.c
>> @@ -0,0 +1,9 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +
>> +#include "qemu/osdep.h"
>> +#include "system/qmp-cpu.h"
>> +
>> +CpuDefinitionInfoList *qmp_query_i386_cpu_definitions(Error **errp)
>> +{
>> +    g_assert_not_reached();
>> +}
>> diff --git a/stubs/qmp-cpu-loongarch.c b/stubs/qmp-cpu-loongarch.c
>> new file mode 100644
>> index 00000000000..695b6558d7e
>> --- /dev/null
>> +++ b/stubs/qmp-cpu-loongarch.c
>> @@ -0,0 +1,9 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +
>> +#include "qemu/osdep.h"
>> +#include "system/qmp-cpu.h"
>> +
>> +CpuDefinitionInfoList *qmp_query_loongarch_cpu_definitions(Error **errp)
>> +{
>> +    g_assert_not_reached();
>> +}
>> diff --git a/stubs/qmp-cpu-mips.c b/stubs/qmp-cpu-mips.c
>> new file mode 100644
>> index 00000000000..4d251d5f078
>> --- /dev/null
>> +++ b/stubs/qmp-cpu-mips.c
>> @@ -0,0 +1,9 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +
>> +#include "qemu/osdep.h"
>> +#include "system/qmp-cpu.h"
>> +
>> +CpuDefinitionInfoList *qmp_query_mips_cpu_definitions(Error **errp)
>> +{
>> +    g_assert_not_reached();
>> +}
>> diff --git a/stubs/qmp-cpu-ppc.c b/stubs/qmp-cpu-ppc.c
>> new file mode 100644
>> index 00000000000..315461c7db7
>> --- /dev/null
>> +++ b/stubs/qmp-cpu-ppc.c
>> @@ -0,0 +1,9 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +
>> +#include "qemu/osdep.h"
>> +#include "system/qmp-cpu.h"
>> +
>> +CpuDefinitionInfoList *qmp_query_ppc_cpu_definitions(Error **errp)
>> +{
>> +    g_assert_not_reached();
>> +}
>> diff --git a/stubs/qmp-cpu-riscv.c b/stubs/qmp-cpu-riscv.c
>> new file mode 100644
>> index 00000000000..ce500ffa3f3
>> --- /dev/null
>> +++ b/stubs/qmp-cpu-riscv.c
>> @@ -0,0 +1,9 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +
>> +#include "qemu/osdep.h"
>> +#include "system/qmp-cpu.h"
>> +
>> +CpuDefinitionInfoList *qmp_query_riscv_cpu_definitions(Error **errp)
>> +{
>> +    g_assert_not_reached();
>> +}
>> diff --git a/stubs/qmp-cpu-s390x.c b/stubs/qmp-cpu-s390x.c
>> index 71e794482b5..4556072a226 100644
>> --- a/stubs/qmp-cpu-s390x.c
>> +++ b/stubs/qmp-cpu-s390x.c
>> @@ -3,6 +3,12 @@
>>   #include "qemu/osdep.h"
>>   #include "qapi/error.h"
>>   #include "qapi/qapi-commands-machine.h"
>> +#include "system/qmp-cpu.h"
>> +
>> +CpuDefinitionInfoList *qmp_query_s390x_cpu_definitions(Error **errp)
>> +{
>> +    g_assert_not_reached();
>> +}
>>   
>>   CpuModelCompareInfo *
>>   qmp_query_cpu_model_comparison(CpuModelInfo *infoa,
> 
> I believe the stubs are needed to make hw/core/machine-qmp-cmds.c link
> when targets are compiled out.  Suggest to briefly explain that in the
> commit message.
>

That's correct.
I'll add it to commit message so it's clearer.

> [...]
> 

Thanks,
Pierrick

