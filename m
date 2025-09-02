Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88202CA100B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI7D-00049x-Ex; Mon, 01 Sep 2025 23:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI79-0003nK-8q
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:55:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI76-0005kL-0f
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:55:23 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SH42013393
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MNeYAYe4BLMKW+ByRGuwLsDSEP5rzdQGGX1BzmkAPNU=; b=SWdmaPAq8BpQ5tLn
 kUHAsBhog4VBLkTeq/4Ida29n0oKFgvaKTpuvZW4rguR7xnFwxYcJmff9pbQA8o8
 gtZyeSmQ/G5BaUAk92RfiWpFLWTilt44IlD6g+mdfh0bI5HarJ1Q/2NWVXgd1lcm
 9BfobgNSeFTKVrRixPRnzI7WnPTduVH+8Svaj0POcVTVe1f+XWlPCKm+LqA9d7Ph
 A9/RCZT7wplKUqyjKvMFcMWXtEb6JniRPPO/EAqzfweOKhTpcrFctylq5YUN9IGt
 YIr5lN4mQkp/2gT5zJAtAIsPd7YQZU222vXFTpzl8l4F1svio8h5eKb0ZdLeFHUP
 HlBSXA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2feajw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:55:18 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b4f705186bbso1441008a12.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785314; x=1757390114;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MNeYAYe4BLMKW+ByRGuwLsDSEP5rzdQGGX1BzmkAPNU=;
 b=uiy8TPXCM4fOoYUz26R71GJXJgwDUi5Va7if86D88SDi9hwxLt5LSCm7rAhOOM1B1l
 zs0z8g6snwPtY7wHfzdCBnGZS/tAYukFxmIhwrQUwMjG4f2THtgR7ce+cw3xwAoDo7oX
 UEVdN1T2QS3fnnI8Yliz+DIhFBWzoEYl7GoUJjQ5vJgsditTj2yEvzwgR3MA633mxh+q
 eUMKf63SgLRTNTqtKx2VF1GMq/8UbaOU0IyWwI29VVz7+5n2Fk5tKyhFNQxzbfYdzO/4
 fehHQAdkoNY80pn9/D3qO3hRk0hVKp12C5fvdj4o9H7fprl7pKnuWTOWwcXLgDAJ2K9F
 VCGQ==
X-Gm-Message-State: AOJu0YwjF4DdJSXn4xxxWanty+XZT2+9Oe60f/o6QWTkbZyvpWSiAHxd
 1LYHNRje0gBVeSxttwHbQSkG/X371sp7F8VV4KQEPUSRkCCS9eW5KSymhMiGtwsFWl0kuMitwaf
 upjL2ng+q5iUaNY44bnOE7b4ZJmV/rW1y6qrdNhMlGKzqeK7PYKfSMCfJwt4FbxrX2IGv
X-Gm-Gg: ASbGncthRSVeDeTDP9P44OJEkbqDfSrAyctwi7d1X82vngZE3EJnU/qakL8D+t9k0yP
 HVEJYybrKYBgfKJIjcHFp1iWc5ozeJ3yZVnzT9UWtYarlLVyoiu+PcCCso3CmKH6Wp7yWzDbS1e
 vpXmA/DadU1MdjTnTdPZmOij/DXnXhfIhAhcyLtwOsyw8/W0MuLG2SKmQSmdVoFnL13yA3Z1GhD
 6mdQxuZYY2PyXk0r4rKBd5os9/fsykjIyYebRL7PV31A9icGyEifuTwC6zoyIqG2a/JpKpU4FIE
 cYJ9TvswAOFHB/iQbbpoWTZK+IGMk5CjUTM7EXyz0IO6tK1RHw5mdTmTKtYWUg==
X-Received: by 2002:a17:903:b10:b0:246:d769:2fe7 with SMTP id
 d9443c01a7336-24944a96cafmr125916595ad.28.1756785313604; 
 Mon, 01 Sep 2025 20:55:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpojhMiWLPgkzLTXRwrVET9cR59qoSDM4wBJYjGbp6NwTbbYSAC5WbSO1+Kr4VVr62VRxeNQ==
X-Received: by 2002:a17:903:b10:b0:246:d769:2fe7 with SMTP id
 d9443c01a7336-24944a96cafmr125916305ad.28.1756785312986; 
 Mon, 01 Sep 2025 20:55:12 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24905da25dbsm119720745ad.68.2025.09.01.20.55.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 20:55:12 -0700 (PDT)
Message-ID: <04f31a1c-e1a1-40fd-a892-2a149ac4998e@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 19:56:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/38] target/hexagon: Initialize htid, modectl regs
To: qemu-devel@nongnu.org
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-29-brian.cain@oss.qualcomm.com>
 <44e23197-a2ec-4477-a4b8-a526f83e47c2@linaro.org>
 <b84bcd2d-9974-41f0-b9f5-2d416ed16d0d@oss.qualcomm.com>
 <67b33d51-b8c8-421c-8aba-efa9a0b46bf5@linaro.org>
 <008601db9448$601bc370$20534a50$@gmail.com>
 <e1216ec5-c542-4a7d-a3d7-880e7e57130e@linaro.org>
 <IA0PR02MB94864DC1BE7E60105E66EC09BED92@IA0PR02MB9486.namprd02.prod.outlook.com>
 <52a6fd90-bce7-47fd-bb93-aa88f8f3bb82@linaro.org>
 <IA0PR02MB9486FD682111B54F09E6296FBED82@IA0PR02MB9486.namprd02.prod.outlook.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <IA0PR02MB9486FD682111B54F09E6296FBED82@IA0PR02MB9486.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX3ZN9jX6X+cUu
 kb3rycQFHhGvL50oABsXHUGzqFn7jn7er3u7hN6ajUm/RSudOOlhLaNa9lkMlWARVR/c5a9+jNu
 rkL9EcKmsDa3yD1UssrNk3Kmt+5WIqLrXqWkfrpTffKcVW2wUALxVdRWe8kLlrME09Z6F6A3sgg
 fGqSgqlBPy2EnRwgQbAE+Wg1jvd3Vt86gUBrMCU8ZJMGE63sCQiOXbaqtEYfMJSfeRWUrjHogXO
 yvqEY68o+F4fM4Ms0QAJsVjhZedwILjVYnYsRcFFERfWhCvMQ6Fgh6t0XsIazZnIK1iLIC0L+RN
 n21eydUTInKqYb7vcCg5sMiyXpOyAVRCmFNDLYaDDoPwuLYhAUZAALv41GPvY6noSMKjEe6r/ER
 1ZWblvSU
X-Proofpoint-ORIG-GUID: AEe1eWJChlEX1w4ZpcHX8siFR8NmTIbO
X-Proofpoint-GUID: AEe1eWJChlEX1w4ZpcHX8siFR8NmTIbO
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b66aa6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8 a=IWK2h7V11d4pYfwXl0wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 3/20/2025 12:38 PM, Sid Manning wrote:
>
>> -----Original Message-----
>> From: Richard Henderson <richard.henderson@linaro.org>
>> Sent: Thursday, March 20, 2025 10:34 AM
>> To: Sid Manning <sidneym@quicinc.com>; ltaylorsimpson@gmail.com;
>> 'Philippe Mathieu-Daudé' <philmd@linaro.org>; 'Brian Cain'
>> <brian.cain@oss.qualcomm.com>; qemu-devel@nongnu.org
>> Cc: Matheus Bernardino (QUIC) <quic_mathbern@quicinc.com>;
>> ale@rev.ng; anjo@rev.ng; Marco Liebel (QUIC)
>> <quic_mliebel@quicinc.com>; alex.bennee@linaro.org; Mark Burton (QUIC)
>> <quic_mburton@quicinc.com>; Brian Cain <bcain@quicinc.com>
>> Subject: Re: [PATCH 28/38] target/hexagon: Initialize htid, modectl regs
>>
>> WARNING: This email originated from outside of Qualcomm. Please be wary
>> of any links or attachments, and do not enable macros.
>>
>> On 3/19/25 09:08, Sid Manning wrote:
>>>
>>>> -----Original Message-----
>>>> From: Richard Henderson <richard.henderson@linaro.org>
>>>> Sent: Thursday, March 13, 2025 2:07 PM
>>>> To: ltaylorsimpson@gmail.com; 'Philippe Mathieu-Daudé'
>>>> <philmd@linaro.org>; 'Brian Cain' <brian.cain@oss.qualcomm.com>;
>>>> qemu- devel@nongnu.org
>>>> Cc: Matheus Bernardino (QUIC) <quic_mathbern@quicinc.com>;
>>>> ale@rev.ng; anjo@rev.ng; Marco Liebel (QUIC)
>>>> <quic_mliebel@quicinc.com>; alex.bennee@linaro.org; Mark Burton
>>>> (QUIC) <quic_mburton@quicinc.com>; Sid Manning
>> <sidneym@quicinc.com>;
>>>> Brian Cain <bcain@quicinc.com>
>>>> Subject: Re: [PATCH 28/38] target/hexagon: Initialize htid, modectl
>>>> regs
>>>>
>>>> WARNING: This email originated from outside of Qualcomm. Please be
>>>> wary of any links or attachments, and do not enable macros.
>>>>
>>>> On 3/13/25 11:47, ltaylorsimpson@gmail.com wrote:
>>>>> What we are trying to model is an instance of a Hexagon that has a
>>>>> number
>>>> of threads and some resources that are shared.  The shared resources
>>>> include the TLB and global S registers.  The initial thought was to
>>>> tie the shared resources to the thread with cpu_index == 0.  If we
>>>> were to model a Qualcomm SoC, there would be multiple ARM cores and
>>>> multiple Hexagon instances.  Each Hexagon instance would have
>>>> distinct shared resources.  So, you are correct that using cpu_index is not
>> going to scale.
>>>>> What is the recommended way to model this?  I see a "nr_threads"
>>>>> field in
>>>> CPUCore but no clear way to find the threads.  PPC has some cores
>>>> that add a "threads" field.  Should we follow this approach?
>>>>
>>>> I recommend that the shared resources be modeled as a separate
>>>> Object, which is linked via object_property_add_link to all of the cpus that
>> use it.
>>> [Sid Manning]
>>> Hi Richard,
>>> An example of shared resources would be the system registers.  They are
>> broken down into 2 regions.  Each thread has its own copy of system
>> registers 0-15 while registers 16-63 are global.  Right now CPUHexagonState
>> contains a pointer, g_sreg which points back to cpu[0]'s state thus keeping
>> one copy of the global registers, accesses are done with BQL held to avoid
>> race conditions.
>>> Your suggestion is to create a new object to represent the set of global
>> system registers, I tried this:
>>> #define TYPE_HEXAGON_G_SREG "hexagon.global_sreg"
>>> OBJECT_DECLARE_SIMPLE_TYPE(HexagonGlobalSREGState,
>> HEXAGON_G_SREG)
>>> struct HexagonGlobalSREGState {
>>>       SysBusDevice parent_obj;
>> SysBusDevice is more than you need -- Object is sufficient here.
> [Sid Manning]
> Thanks!  Will change that to Object.
>
>>>       uint32_t regs[64];
>>> };
>>>
>>> In our virtual machine init:
>>> vms->g_sreg =
>> HEXAGON_G_SREG(qdev_new(TYPE_HEXAGON_G_SREG));
>>> and
>>>    object_property_set_link(OBJECT(cpu), "global-sreg",
>>> OBJECT(vms->g_sreg), &error_abort);
>>>
>>> to attach the global regs to the cpu, but the above doesn't update cpu
>> elements the same way calls to qdev_prop_set_uint32 will do,
>> object_property_set_link doesn’t error out and returns true.
>>
>> Did you add the DEFINE_PROP_LINK to match?  I'd expect something like
>>
>>       DEFINE_PROP_LINK("global-sreg", HexagonCPU, g_sreg,
>>                        TYPE_HEXAGON_G_SREG, HexagonGlobalSREGState *),
>>
>> Beyond that, I guess I'd have to see an actual patch to work out what's
>> wrong.
> [Sid Manning]
> Yes, PROP_LINK above is almost exactly what I added.
>
> Below is a patch representing what I tried.  I hoped that cpu->global_sreg would be updated after the call to object_property_set_link but it was not, in the patch below I manually set it.
>
> diff --git a/hw/hexagon/sysreg.h b/hw/hexagon/sysreg.h
> new file mode 100644
> index 0000000000..d7204896cf
> --- /dev/null
> +++ b/hw/hexagon/sysreg.h
> @@ -0,0 +1,47 @@
> +/*
> + * Hexagon system reg
> + * FIXME
> + */
> +
> +#ifndef HW_HEXAGON_HART_H
> +#define HW_HEXAGON_HART_H
> +#if !defined(CONFIG_USER_ONLY)
> +#include "hw/sysbus.h"
> +#include "qom/object.h"
> +
> +#define NUM_SREGS 64
> +struct HexagonGlobalSREGState {
> +    struct Object parent_obj;
> +    uint32_t regs[NUM_SREGS];
> +};
> +
> +#define TYPE_HEXAGON_G_SREG "hexagon.global_sreg"
> +OBJECT_DECLARE_SIMPLE_TYPE(HexagonGlobalSREGState, HEXAGON_G_SREG)
> +
> +static void hexagon_global_sreg_init(Object *obj)
> +{
> +    HexagonGlobalSREGState *s = HEXAGON_G_SREG(obj);
> +    /*
> +     * The first 16 registers are thread local and should not come from
> +     * this structure
> +     */
> +    for (int i = 0; i < 16; i++) {
> +        s->regs[i] = 0xffffffff;
> +    }
> +}
> +
> +static const TypeInfo hexagon_sreg_info = {
> +    .name          = TYPE_HEXAGON_G_SREG,
> +    .parent        = TYPE_DEVICE,
> +    .instance_size = sizeof(struct HexagonGlobalSREGState),
> +    .instance_init = hexagon_global_sreg_init,
> +};
> +
> +__attribute__ ((unused))
> +static void hexagon_sreg_register_types(void)
> +{
> +    type_register_static(&hexagon_sreg_info);
> +}
> +#endif
> +#endif
> +
> diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
> index 1e7ac4e5b7..d2d599ac1d 100644
> --- a/hw/hexagon/virt.c
> +++ b/hw/hexagon/virt.c
> @@ -10,12 +10,14 @@
>   #include "hw/char/pl011.h"
>   #include "hw/core/sysbus-fdt.h"
>   #include "hw/hexagon/hexagon.h"
> +#include "hw/hexagon/sysreg.h"
>   #include "hw/hexagon/virt.h"
>   #include "hw/loader.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/register.h"
>   #include "hw/timer/qct-qtimer.h"
>   #include "qemu/error-report.h"
> +#include "qapi/error.h"
>   #include "qemu/guest-random.h"
>   #include "qemu/units.h"
>   #include "elf.h"
> @@ -335,6 +337,7 @@ static void virt_init(MachineState *ms)
>           cpu_model = HEXAGON_CPU_TYPE_NAME("v73");
>       }
>   
> +    vms->g_sreg = HEXAGON_G_SREG(qdev_new(TYPE_HEXAGON_G_SREG));
>       HexagonCPU *cpu_0 = NULL;
>       for (int i = 0; i < ms->smp.cpus; i++) {
>           HexagonCPU *cpu = HEXAGON_CPU(object_new(ms->cpu_type));
> @@ -356,6 +359,14 @@ static void virt_init(MachineState *ms)
>           qdev_prop_set_uint32(DEVICE(cpu), "qtimer-base-addr", m_cfg->qtmr_region);
>           qdev_prop_set_uint32(DEVICE(cpu), "jtlb-entries",
>                                m_cfg->cfgtable.jtlb_size_entries);
> +        bool rc = object_property_set_link(OBJECT(cpu), "global-sreg",
> +                                           OBJECT(vms->g_sreg), &error_abort);
> +        g_assert(rc == true);
> +
> +        /* This is doing what I think object_property_set_link should do.*/
> +        cpu->global_sreg = vms->g_sreg;
> +
> +
>   
>           if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
>               return;
> @@ -413,3 +424,5 @@ static const TypeInfo virt_machine_types[] = { {
>   } };
>   
>   DEFINE_TYPES(virt_machine_types)
> +
> +type_init(hexagon_sreg_register_types)
> diff --git a/include/hw/hexagon/virt.h b/include/hw/hexagon/virt.h
> index 0c165a786d..dcd09d50b1 100644
> --- a/include/hw/hexagon/virt.h
> +++ b/include/hw/hexagon/virt.h
> @@ -9,6 +9,7 @@
>   #define HW_HEXAGONVIRT_H
>   
>   #include "hw/boards.h"
> +#include "hw/hexagon/sysreg.h"
>   #include "target/hexagon/cpu.h"
>   
>   struct HexagonVirtMachineState {
> @@ -22,6 +23,7 @@ struct HexagonVirtMachineState {
>       MemoryRegion tcm;
>       MemoryRegion vtcm;
>       DeviceState *l2vic;
> +    HexagonGlobalSREGState *g_sreg;
>   };
>   
>   void hexagon_load_fdt(const struct HexagonVirtMachineState *vms);
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index c649aef99e..9773ee0be8 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -80,6 +80,8 @@ static const Property hexagon_cpu_properties[] = {
>       DEFINE_PROP_UINT32("exec-start-addr", HexagonCPU, boot_addr, 0xffffffffULL),
>       DEFINE_PROP_UINT64("config-table-addr", HexagonCPU, config_table_addr,
>                          0xffffffffULL),
> +    DEFINE_PROP_LINK("global-sreg", HexagonCPU, global_sreg,
> +                     TYPE_HEXAGON_G_SREG, HexagonGlobalSREGState *),
>   #endif
>       DEFINE_PROP_UINT32("dsp-rev", HexagonCPU, rev_reg, 0),
>       DEFINE_PROP_BOOL("lldb-compat", HexagonCPU, lldb_compat, false),
> @@ -378,6 +380,11 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
>       CPUState *cs = CPU(obj);
>       HexagonCPUClass *mcc = HEXAGON_CPU_GET_CLASS(obj);
>       CPUHexagonState *env = cpu_env(cs);
> +#ifndef CONFIG_USER_ONLY
> +    HexagonCPU *cpu = HEXAGON_CPU(cs);
> +    env->g_sreg = cpu->global_sreg->regs;
> +#endif
> +
>   
>       if (mcc->parent_phases.hold) {
>           mcc->parent_phases.hold(obj, type);
> @@ -389,11 +396,6 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
>       set_float_default_nan_pattern(0b11111111, &env->fp_status);
>   
>   #ifndef CONFIG_USER_ONLY
> -    HexagonCPU *cpu = HEXAGON_CPU(cs);
> -
> -    if (cs->cpu_index == 0) {
> -        memset(env->g_sreg, 0, sizeof(target_ulong) * NUM_SREGS);
> -    }
>       memset(env->t_sreg, 0, sizeof(target_ulong) * NUM_SREGS);
>       memset(env->greg, 0, sizeof(target_ulong) * NUM_GREGS);
>   
> @@ -468,13 +470,6 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
>       CPUHexagonState *env = cpu_env(cs);
>   #ifndef CONFIG_USER_ONLY
>       hex_mmu_realize(env);
> -    if (cs->cpu_index == 0) {
> -        env->g_sreg = g_new0(target_ulong, NUM_SREGS);
> -    } else {
> -        CPUState *cpu0 = qemu_get_cpu(0);
> -        CPUHexagonState *env0 = cpu_env(cpu0);
> -        env->g_sreg = env0->g_sreg;
> -    }
>   #endif
>       if (cs->cpu_index == 0) {
>           env->g_pcycle_base = g_malloc0(sizeof(*env->g_pcycle_base));
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index 8b334068e2..716dd8253b 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -19,10 +19,10 @@
>   #define HEXAGON_CPU_H
>   
>   #include "fpu/softfloat-types.h"
> +#include "hw/hexagon/sysreg.h"
>   
>   #define NUM_GREGS 32
>   #define GREG_WRITES_MAX 32
> -#define NUM_SREGS 64
>   #define SREG_WRITES_MAX 64
>   
>   #include "cpu-qom.h"
> @@ -199,6 +199,7 @@ struct ArchCPU {
>       uint32_t hvx_contexts;
>       uint32_t boot_addr;
>       uint64_t config_table_addr;
> +    HexagonGlobalSREGState *global_sreg;
>   #endif
>   };
>
>

I think the re-design of the global registers present in v2 should be a 
satisfactory resolution to this thread but please let me know if that's 
not the case.

>

