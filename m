Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384E4EE369D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 16:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqZCJ-0000NR-EV; Thu, 12 Feb 2026 11:05:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vqZCI-0000Mz-Dh
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:05:42 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vqZCE-0002BB-4W
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:05:40 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61CDRxYr1074872
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 16:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zIWsR2lG7UVAh8h25jOMwtceovI5KP3xmkRyMRd8+E4=; b=WkrXgIT3s9Soekun
 swv6Bxyg3ON6Gy9lHGCK7OP1DoaAlNlDBVwDSwZd9xSU2n67sJQUNKywhDnQ5KTL
 vQyu7pNcZkKU424oI7XBKl0qdV8xRZmGNjoOi3IrAQ/zmglxwcSE7VwE1M3ZX1st
 6gLNx8yn+bOoYGM3FFQebKcMcetezE9ZiB5a7hPlGA+dNEogfshwPz8geIIUiMbm
 lTuLMAOlpP4NV2wWI0/OLRb5gzZ84VZwDMo53VqlqIatF38HWZfLXBGdRwYQI6sX
 UZnOBNe66UGrFCnnpp3dMUhEa4K/08x6p8YPYS0Pnz51Suy6QukeLF/LbVMtEAbY
 njm16Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8y8nunp0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 16:05:33 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8c70e610242so6148885a.2
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 08:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770912332; x=1771517132; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zIWsR2lG7UVAh8h25jOMwtceovI5KP3xmkRyMRd8+E4=;
 b=cjHhtAJvQjC8W8g4xk25tVHvd/0/4Kq5txrGgUUiEy21sU5UBpGT+gncN6vzlnVud7
 vSj6sZ90XfrEDYobKPnf24Iwr1cLkO6+eVF9S9SM7I6QJ1T5g8f6Y6K/HvNy0aNSX2gh
 Tp9iDuLou0k53VusU4aNjXbkW0xyYkPcAghVssS4nq2RWHsPNt0wdncPDnSQH06kAwJQ
 rFYWme5dA9wUTh8eG5CGURYBxIimz8OQHsgve3/z/Xs0hmRJWkpLky/a+mxNjUOvBAwK
 g3ndOpdhxGId0SfKh93JUAu1xAnc4zJpMHtygs4F8ma9+efX5XSKd+Mo02Mhq6k4Rwnm
 YMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770912332; x=1771517132;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zIWsR2lG7UVAh8h25jOMwtceovI5KP3xmkRyMRd8+E4=;
 b=RTRdSXe6x55zEGgDgQ+U4wibe5zbp6Zt0NxRn/UFHiy8qDdFbwv04AHnfoUQINIGx0
 py7c5bIREhZbnGFotFhfgVwHMJOhRP472sAx1VqM3uJA2SDzfQXcpm6f8KiO0QK59/FY
 begmNHEIsI11Yuft1T2+j026NBkE79CFEwV5L5OCbVGE4gWD5jdbAgYoNmprh412XRV1
 gbiWpPRwPqxasKv41BPXlsEkAJGZL8WWl7RtOMuKU4c+iVCYq6vhNp0aYfpvjKYD6kX4
 h7WA/Ox7nLEJ5bttdEqJ3OxxygcZeF9h9yDMxzm/g+KhUQ/DL5AwVcxZPtSCiX2RRTdh
 JkwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMsSGHbn/HuNkmWUxDnjmLIbE+vEpsN9BtBdtAcUDitRDqDRR+oxljnZKvzUOpg/ydZcbpfpz+2cz1@nongnu.org
X-Gm-Message-State: AOJu0Yx4AMO3cmrGam/udorllpS0SHUo07qlRkEQU1Krc5+09kyT8I3W
 W/EAJLtUklrTCbMbIk1Tei0Ahsjb4nc3YWptAlqfD2ZRfQoUUylgcfcfNQ46zuBOxt7c1x/RctZ
 pb1LgkeAyAfGUYJjkZJqwnyFOx0gs13+WYwSyJVHvLgYhcikgjBVo22MnSw==
X-Gm-Gg: AZuq6aLUKbqPYrXGewkfUSXTUlHh6FtLfogQIHwLuD3MH/9RjvhnVq5I9pLrRC9Wf3X
 SnX2qViAvoaFEnq2r5ye5z8oUV3Z2wBsSjoVhDgiUKtVm4NZqSzZIVnW3VrhZft7YJWmcCg4pBt
 yiiLTj6D2erZqTNS0SD9fbZFVecZ4eO47GyMVRfk5yPmPqCPp5DDJrT7P9QJzb3RroJoPpNVIC9
 J8QK5TqXzLQbGWW7CGl2LQkTWKVAyerLB42gt18cSZ+zpGyWblF3XuQwmDx+X0K/sjlJwXKOOEa
 1MbzZBIoexwamwXOIuYg6IFDlnciY185OhOYmNG6Kg70rNThpdZ03BXXuYu26iWAV/nyAoTdMpi
 +99Grp+H/GIJGcg4lmhaIrTK6lEFFxCWEiWC7zGo9kX++U3KxlT9ncE5O
X-Received: by 2002:a05:620a:4451:b0:8c7:9e6:3a7e with SMTP id
 af79cd13be357-8cb32f188f2mr409112985a.0.1770912332228; 
 Thu, 12 Feb 2026 08:05:32 -0800 (PST)
X-Received: by 2002:a05:620a:4451:b0:8c7:9e6:3a7e with SMTP id
 af79cd13be357-8cb32f188f2mr409106785a.0.1770912331723; 
 Thu, 12 Feb 2026 08:05:31 -0800 (PST)
Received: from [192.168.68.103] ([179.193.9.245])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb2b20f240sm370710185a.40.2026.02.12.08.05.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 08:05:30 -0800 (PST)
Message-ID: <e5a3a69c-e719-4f2f-9ed3-ecd52d9597be@oss.qualcomm.com>
Date: Thu, 12 Feb 2026 13:05:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/kvm: implement SBI debug console (DBCN) calls
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240425155012.581366-1-dbarboza@ventanamicro.com>
 <eb6bd3d7-c66b-4300-9573-c29830a3aff4@linaro.org>
 <102e2e67-4c4d-4912-a892-20f5136f241a@ventanamicro.com>
 <47327da2-be3c-4aaa-ab3d-36e8d0c25185@linaro.org>
 <0eb5bcf9-bc2e-46c6-9f54-1514039557e0@ventanamicro.com>
 <37e6fecd-948a-4840-9189-918d44c0be72@linaro.org>
 <c2b0fb25-8b17-4a69-a128-2f8cc9bbba76@ventanamicro.com>
 <16c45b70-23cd-4522-8ece-1c268fb72a73@linaro.org>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <16c45b70-23cd-4522-8ece-1c268fb72a73@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDEyMyBTYWx0ZWRfX7Bg/PkMq9uDu
 Q5BbIHPtD0ZuvPXPNme+CcW+NdceaPErpOJMLrEc5gBlfq+yPL7lfaJZNG1urI+Tiez0GI+s8RP
 UWwtRgmqXg0X8nsi/20FVafGGSrrU4SYZFY4x09CSFLY4m+04CCEatA5z9DJX2OQeDOnCklnU37
 WENLGQu8UCp2a25Y7zzigGX2jlUR6BgOUSJDHMxiZET9PKWyjvWgcB3WwwrlT3dKV/FKpeHXTfl
 23bKC5XQo92V/8d3NouQ2XKEiS+3ltk5sbYLPpKWIBOa54nZSuUV/8ly8RCIVY3SMJ5VIYEhhQE
 kh7IWMvDRd93Ndl1VnoYShTdeSjgbzwjbGG503UwoPzjTOCxWje66ysLJKm4jfWh8pcr+jMHtdo
 DEh6IOYswj9GT+FxJHL70WaTAzJlaVXIJqtgX35zm5Hbftdl9vQIxHedcinCl5Nwpgae6t7J+Zz
 FxpqacNeC8q7Bmx5SzA==
X-Authority-Analysis: v=2.4 cv=VNvQXtPX c=1 sm=1 tr=0 ts=698dfa4d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=li3dXIDAslFm3Zus54lMNg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=bDdBU3oEAAAA:8 a=en746O6BByNCThpbw7UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=DN7SgORnOiO7RqxRx1GC:22
X-Proofpoint-GUID: xSEblQqNgUS-iJZcsAMP0JfsoEuVujG2
X-Proofpoint-ORIG-GUID: xSEblQqNgUS-iJZcsAMP0JfsoEuVujG2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_04,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120123
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



On 2/12/2026 12:51 PM, Philippe Mathieu-Daudé wrote:
> Hi Daniel,
> 
> On 4/6/25 12:54, Daniel Henrique Barboza wrote:
>>
>>
>> On 6/4/25 6:38 AM, Philippe Mathieu-Daudé wrote:
>>> (+Marc-André and Paolo who I forgot to Cc first)
>>>
>>> On 4/6/25 11:17, Daniel Henrique Barboza wrote:
>>>>
>>>>
>>>> On 6/4/25 4:32 AM, Philippe Mathieu-Daudé wrote:
>>>>> On 3/6/25 20:04, Daniel Henrique Barboza wrote:
>>>>>>
>>>>>>
>>>>>> On 6/3/25 10:19 AM, Philippe Mathieu-Daudé wrote:
>>>>>>> Hi Daniel,
>>>>>>>
>>>>>>> (now merged as commit a6b53378f537)
>>>>>>>
>>>>>>> On 25/4/24 17:50, Daniel Henrique Barboza wrote:
>>>>>>>> SBI defines a Debug Console extension "DBCN" that will, in time, 
>>>>>>>> replace
>>>>>>>> the legacy console putchar and getchar SBI extensions.
>>>>>>>>
>>>>>>>> The appeal of the DBCN extension is that it allows multiple 
>>>>>>>> bytes to be
>>>>>>>> read/written in the SBI console in a single SBI call.
>>>>>>>>
>>>>>>>> As far as KVM goes, the DBCN calls are forwarded by an in-kernel 
>>>>>>>> KVM
>>>>>>>> module to userspace. But this will only happens if the KVM module
>>>>>>>> actually supports this SBI extension and we activate it.
>>>>>>>>
>>>>>>>> We'll check for DBCN support during init time, checking if get- 
>>>>>>>> reg- list
>>>>>>>> is advertising KVM_RISCV_SBI_EXT_DBCN. In that case, we'll 
>>>>>>>> enable it via
>>>>>>>> kvm_set_one_reg() during kvm_arch_init_vcpu().
>>>>>>>>
>>>>>>>> Finally, change kvm_riscv_handle_sbi() to handle the incoming 
>>>>>>>> calls for
>>>>>>>> SBI_EXT_DBCN, reading and writing as required.
>>>>>>>>
>>>>>>>> A simple KVM guest with 'earlycon=sbi', running in an emulated 
>>>>>>>> RISC-V
>>>>>>>> host, takes around 20 seconds to boot without using DBCN. With this
>>>>>>>> patch we're taking around 14 seconds to boot due to the speed-up 
>>>>>>>> in the
>>>>>>>> terminal output.  There's no change in boot time if the guest isn't
>>>>>>>> using earlycon.
>>>>>>>>
>>>>>>>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>>>>>>> ---
>>>>>>>>   target/riscv/kvm/kvm-cpu.c         | 111 +++++++++++++++++++++ 
>>>>>>>> + ++ +++++
>>>>>>>>   target/riscv/sbi_ecall_interface.h |  17 +++++
>>>>>>>>   2 files changed, 128 insertions(+)
>>>>>>>
>>>>>>>
>>>>>>>> +static void kvm_riscv_handle_sbi_dbcn(CPUState *cs, struct 
>>>>>>>> kvm_run *run)
>>>>>>>> +{
>>>>>>>> +    g_autofree uint8_t *buf = NULL;
>>>>>>>> +    RISCVCPU *cpu = RISCV_CPU(cs);
>>>>>>>> +    target_ulong num_bytes;
>>>>>>>> +    uint64_t addr;
>>>>>>>> +    unsigned char ch;
>>>>>>>> +    int ret;
>>>>>>>> +
>>>>>>>> +    switch (run->riscv_sbi.function_id) {
>>>>>>>> +    case SBI_EXT_DBCN_CONSOLE_READ:
>>>>>>>> +    case SBI_EXT_DBCN_CONSOLE_WRITE:
>>>>>>>> +        num_bytes = run->riscv_sbi.args[0];
>>>>>>>> +
>>>>>>>> +        if (num_bytes == 0) {
>>>>>>>> +            run->riscv_sbi.ret[0] = SBI_SUCCESS;
>>>>>>>> +            run->riscv_sbi.ret[1] = 0;
>>>>>>>> +            break;
>>>>>>>> +        }
>>>>>>>> +
>>>>>>>> +        addr = run->riscv_sbi.args[1];
>>>>>>>> +
>>>>>>>> +        /*
>>>>>>>> +         * Handle the case where a 32 bit CPU is running in a
>>>>>>>> +         * 64 bit addressing env.
>>>>>>>> +         */
>>>>>>>> +        if (riscv_cpu_mxl(&cpu->env) == MXL_RV32) {
>>>>>>>> +            addr |= (uint64_t)run->riscv_sbi.args[2] << 32;
>>>>>>>> +        }
>>>>>>>> +
>>>>>>>> +        buf = g_malloc0(num_bytes);
>>>>>>>> +
>>>>>>>> +        if (run->riscv_sbi.function_id == 
>>>>>>>> SBI_EXT_DBCN_CONSOLE_READ) {
>>>>>>>> +            ret = qemu_chr_fe_read_all(serial_hd(0)->be, buf, 
>>>>>>>> num_bytes);
> 
> 
> Still following up on that patch :) Do we have one SBI debug console
> per system / soc / cluster / hart? Instead of calling serial_hd(0)
> each time we should set it once when realizing the vcpu IMO. If it is
> per hart we would add this property:
> 
>    DEFINE_PROP_CHR("sbi-chardev", RISCVCPU, sbi_console),
> 
> WDYT?


We have a single SBI debug console per platform. So, using this patch 
lingo, all CPUs will use serial_hd(0). In theory this would be a board 
property, but that makes things messier to deal with - we don't want to 
keep poking at board properties when initializing CPUs.

So I think the CPU property you suggested works nicely. Thanks,

Daniel



> 
>>>>>>>> +            if (ret < 0) {
>>>>>>>> +                error_report("SBI_EXT_DBCN_CONSOLE_READ: error 
>>>>>>>> when "
>>>>>>>> +                             "reading chardev");
>>>>>>>> +                exit(1);
>>>>>>>> +            }
>>>>>>>> +
>>>>>>>> +            cpu_physical_memory_write(addr, buf, ret);
>>>>>>>> +        } else {
>>>>>>>> +            cpu_physical_memory_read(addr, buf, num_bytes);
>>>>>>>> +
>>>>>>>> +            ret = qemu_chr_fe_write_all(serial_hd(0)->be, buf, 
>>>>>>>> num_bytes);
>>>>>>>> +            if (ret < 0) {
>>>>>>>> +                error_report("SBI_EXT_DBCN_CONSOLE_WRITE: error 
>>>>>>>> when "
>>>>>>>> +                             "writing chardev");
>>>>>>>> +                exit(1);
>>>>>>>> +            }
>>>>>>>> +        }
>>>>>>>> +
>>>>>>>> +        run->riscv_sbi.ret[0] = SBI_SUCCESS;
>>>>>>>> +        run->riscv_sbi.ret[1] = ret;
>>>>>>>> +        break;
>>>>>>>> +    case SBI_EXT_DBCN_CONSOLE_WRITE_BYTE:
>>>>>>>> +        ch = run->riscv_sbi.args[0];
>>>>>>>> +        ret = qemu_chr_fe_write(serial_hd(0)->be, &ch, 
>>>>>>>> sizeof(ch));
>>>>>>>> +
>>>>>>>> +        if (ret < 0) {
>>>>>>>> +            error_report("SBI_EXT_DBCN_CONSOLE_WRITE_BYTE: 
>>>>>>>> error when "
>>>>>>>> +                         "writing chardev");
>>>>>>>> +            exit(1);
>>>>>>>> +        }


