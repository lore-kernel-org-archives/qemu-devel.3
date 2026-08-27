Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CECC61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzZOC-0003Rx-F3; Thu, 27 Aug 2026 08:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzZOA-0003Rg-Sk
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 08:39:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzZO8-0006n7-VW
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 08:39:26 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RCBpmd3906457
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 12:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QNMrGvbzLvuTnmNV9aMEJacPzbEYhh27HZYipwd/+ik=; b=f5gLAYiG8BOiiDnN
 0zSXSjFnH6cEmYW1qEDhRs8cQN9LEAQOtoAdBbmR26gxa1lbY8c61KrheiT4a3Ul
 JEve4NX8vwMsMhA4VIHQInpPOg5ECy9FDlw3DllcbOdn3PkSfMHGcmcnxOl+eGs6
 IK9gHwOUa6Uw0BqXPjzWYuDbEWH1NAgeGNkLdppDSlo/4sjW5D/1l/29dLuqK6mo
 HHeo1UIWPniW+Du3xwAkiIa9kaT/6kXGrtF2uWbcErA1ykGtSDo34MLwrWvpJ/Zd
 IJpyLUlfiBzxXGBq0czEewz/l3ZyD5jKG90CYqZOrrTHVrQEJKgiH+Ezgmkd2O21
 RBkqiA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gagjfs8tm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 12:39:23 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52d827597fbso21117151cf.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 05:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787834363; x=1788439163; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QNMrGvbzLvuTnmNV9aMEJacPzbEYhh27HZYipwd/+ik=;
 b=aAhUjdXD/H8FtWnoZkO8FAC8urceuSxNlA/Ug9D1jObh/BZmGDuZBgq4rAkI76044r
 7pcl1LL1kcOy3ded1FBFQE1v+vdeCC3tLLqeAu10Ob7dXkafRj78HPRTJ4kUFCRNm0j4
 LvruuCunBxpdDJtl+jCgqPBmP8lxvcC3lf6DBQ/6l9/mdZt5I8d0ojNiOFMYI0JLW3M8
 y4uVf6INVjvalegJPJawTzHXponmwn14nVNq2iyqIlzYq/ancxg35ThTkrDy1SXmyUpD
 Zzokr4uKwpZX96+J9oojnQY+X8QSec90QjUzSOdDsim4+cqcYP2sC4ZTjBrsnvE1lNQW
 4xbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787834363; x=1788439163;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QNMrGvbzLvuTnmNV9aMEJacPzbEYhh27HZYipwd/+ik=;
 b=jTHfGBQmWul4wpkrOm7BdprMR4AfTKwKA6wEUypoKW4CmAS1FuM/MOvZNW4ajkn5UE
 JSWERxLATJlfop47HXSWQDLz28p3Y1UGpitBR4GEMDLtYa8BSOhzod1s2vy1QyTb6KkZ
 RP8K0Ks4C3h6qaHLX+jx3pUc/t0Q32xmB2GI2n0U6lRI9NK3ZnFs9SgBQBmkNoX0sJNE
 iotgdmBQ9FZKdixsNoWoCS3R5YN3tMStNrrSzfLie40M46tc/8CZAUxR2h2pjdNVyaE9
 Fx1I4CNMIOAfjyhQLQTvwwH8le6A4J5UUhQKgntjgop9EZL0dYAiJ3nJoExoBAFrs+nq
 3cuA==
X-Gm-Message-State: AFuF++lTN9CECdzCoRFPxsY10NOLdVu67yqeAthaNBiM+uaGRITyv7kz
 xpkLCb0Hl/qkb1uHR4aABfDfA5lu0LqoGirNoabhTDxu+B61MWFAejJaHb0syIprjRE769GFiIM
 n1WUohymukhn8Nbzd5qqLtea6YB4jCcIxGkzkQsYeMEZ4/XMfmO7DI+lHOQ==
X-Gm-Gg: AR+sD10nmCIlUbNju/3qsb6CrMvH7g/gFxDivxT9wv4IVRhOrt8Ogx0sn3F59TBOKK4
 xDhcYYtFdaappJiELyuc5HxUx/gqLXFBvZ+/dfOhvqlq4udfJsHgJ31CypyGOPlRcjzV9cggJ3f
 zAL5J6dDaxfUdKWQKANPfKsHnokRQXZLJDu5atb5/MrhhbuepNhXWVpYA1F+zzcUoRT/tvTcLsS
 PvWlm/zTOgXAzUqvuaI8YD4znv5muuHxhi/GmGJs0DArvnAxh7CrLzwhAAEfxxMfLu0C/P49Gu7
 v6ml4KP5uSCz7v1/9xTtsxSd3116rHNZMSaFC4Q7ty1iYYI0J9+FoGZ9lRDSqaQ+OYVKq/8kC5z
 LTPg6HLDru/rmffr2iMgjbjc6qVK8oH783x/+
X-Received: by 2002:a05:622a:598e:b0:52d:ca81:e5b7 with SMTP id
 d75a77b69052e-52e4222cc04mr154529811cf.8.1787834362935; 
 Thu, 27 Aug 2026 05:39:22 -0700 (PDT)
X-Received: by 2002:a05:622a:598e:b0:52d:ca81:e5b7 with SMTP id
 d75a77b69052e-52e4222cc04mr154529201cf.8.1787834362421; 
 Thu, 27 Aug 2026 05:39:22 -0700 (PDT)
Received: from [192.168.68.100] ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cd7415ffesm15598106d6.46.2026.08.27.05.39.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 05:39:21 -0700 (PDT)
Message-ID: <aef785c3-9be9-417c-bef6-37de0387c7fb@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 09:39:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/14] hw/riscv/fdt-common, virt.c: add
 riscv_create_fdt_flash()
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260826214643.122728-1-daniel.barboza@oss.qualcomm.com>
 <20260826214643.122728-3-daniel.barboza@oss.qualcomm.com>
 <CACPK8XehmqwQVKjvfGNdVQjApBQJNxrO0JHywabqRUiucCP92Q@mail.gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CACPK8XehmqwQVKjvfGNdVQjApBQJNxrO0JHywabqRUiucCP92Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LrzIXQPkPExy4ZS1Q_eow-NRP8bl5KFu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEwNSBTYWx0ZWRfX7MgkTD4x4TCW
 Et/B6oVesVMmw7arELqWy0i3pyt/KJvoD1bIFk4CrfBecL6dq5yPYQn63riineuvecHDNVmEC2p
 yxvgjfns8HYWzyQ4hGmHPFGi8KF3YwFNL2QtKuKJ1Qw1QXyyo9Mby4Ku/zJkku/IB4QrIge1tt3
 CLXzP5d2142g/ZSc3VCpbBGf7qC7Zwm4BvsYjacl97ZYrjfqiVMSzZVFhzNz2MBeF/cOCYGg5Ja
 d3S51OlFqJqjfQERcTjv/wbYOH9AumcZCIJJ9CpmYCWdhwNP/YObTUfQN/wTeTErlf9GxWFk1EJ
 COPrKZ+QsJ4YWeI0m8Tzv5jNksgIRE6MW7gfwLA96DN6HNyiU6k+GsmRI7erhm9KD/oQIuaQueL
 tYQmIPSZcTT1AB2l8XmhKcbLYnuQPnWHCSVdsD/fNQJRfKtPebaIBBsTkupMj70uMEc+EYEhAH5
 Sllyraa7zyCg/AAqYxQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEwNSBTYWx0ZWRfXxktlhHjnPGy7
 BMkKbgNr4mZXfQZAVL6x6ZYAGxu9ddxGgN1lHWV5k7ve2NI8laiHFVXv/K4mnRLp60AbAupuv2v
 TM8eNihGDyEtdg/gDA6tVNjB0/nxjU8=
X-Proofpoint-GUID: LrzIXQPkPExy4ZS1Q_eow-NRP8bl5KFu
X-Authority-Analysis: v=2.4 cv=dd+wG3Xe c=1 sm=1 tr=0 ts=6a902ffb cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=bSZpjF1_JBF3rytW8nsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270105
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 8/27/2026 2:44 AM, Joel Stanley wrote:
> On Thu, 27 Aug 2026 at 07:16, Daniel Henrique Barboza
> <daniel.barboza@oss.qualcomm.com> wrote:
>>
>> Add a common helper to create a cfi-flash compatible flash subnode.
>>
>> This change only affects the existing 'virt' board for now but it will
>> be used by the future 'riscv-server-ref' board in the future.
> 
> Why do we have two flash devices?
> 
> (I know why ARM does, where the code was copied from, but why does RISC-V?)


The first RISC-V 'virt' board was a port of ARM 'virt' board and ended up inheriting
lots of stuff from it.  The RISC-V port would try to match the same use cases that
the ARM board already.

So the second CFI-flash exists in RISC-V for the same reason it exists in ARM: secure
flash memory for trust boot.

> 
>>
>> No FDT changes intended.
>>
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   hw/riscv/fdt-common.c         | 12 ++++++++++++
>>   hw/riscv/virt.c               | 18 ++----------------
>>   include/hw/riscv/fdt-common.h |  1 +
>>   3 files changed, 15 insertions(+), 16 deletions(-)
>>
>> diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
>> index 3a8da03cfb..6fcc1ce21f 100644
>> --- a/hw/riscv/fdt-common.c
>> +++ b/hw/riscv/fdt-common.c
>> @@ -283,3 +283,15 @@ void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name)
>>      qemu_fdt_setprop(fdt, pmu_name, "riscv,event-to-mhpmcounters",
>>                       fdt_event_ctr_map, sizeof(fdt_event_ctr_map));
>>   }
>> +
>> +void riscv_create_fdt_flash(void *fdt, hwaddr flashbase, hwaddr flashsize)
>> +{
>> +    g_autofree char *name = g_strdup_printf("/flash@%" PRIx64, flashbase);
>> +
>> +    qemu_fdt_add_subnode(fdt, name);
>> +    qemu_fdt_setprop_string(fdt, name, "compatible", "cfi-flash");
>> +    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
>> +                                 2, flashbase, 2, flashsize,
>> +                                 2, flashbase + flashsize, 2, flashsize);
>> +    qemu_fdt_setprop_cell(fdt, name, "bank-width", 4);
>> +}
> 
> This is a copy of the code in hw/arm/virt.c, which was also copied by
> hw/loongarch/virt-fdt-build.c.

I discussed in the past the possibility of delegating FDTs to devices instead of
boards/helpers. This would be an example where the CFIFlash device could create
its own DT.


Can't recall the conclusion back then.  Probably something we can revisit.  For now
we can at least not copy/paste this code in other RISC-V boards.

Thanks,
Daniel




