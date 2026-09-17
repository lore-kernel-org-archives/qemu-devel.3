Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68678C982CF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Bf4-0006NZ-Vb; Thu, 17 Sep 2026 08:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x7Bf0-0006N6-SI
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 08:56:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x7Bey-00059X-9L
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 08:56:18 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H9Zo0b1862999
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 12:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8WQmZyVtliJQwYqNrz5u75N1ri7IqDeS4AuUXNM6twg=; b=KOZQbexylRu+g0NQ
 Gk1hY1lw0bbLBM8Vi+dVQd1cN2ENGl1IgbFD8LVfucefqZkLv4RseuKDPZUL2C/v
 XoQBgMAYG22/Q50RTjy4H2jHhDUQiGAwgriOcF/NKxmfChuwM9c6FNTGX7tXSQ0o
 x8RF+WuX3c99hi2a/oLU/VwmOq8Lb0xaAdKPh6YUe8+I5W/9vKx50PZcUyRZ39wl
 lYLVKOCswZilLvqb8e8oSbv6jtWeBbgdH02uDvWF96UVkmd5rBShMcLqLCQDvBp3
 1WogufgTi+pfMDWCqoohWAkwq97u68prYTRcY/QA3K6Amb0rVcRTVdGwG4/J5yy1
 TaqWOg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqy6av9ph-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 12:56:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-53000c06184so22511681cf.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 05:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789649772; x=1790254572; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8WQmZyVtliJQwYqNrz5u75N1ri7IqDeS4AuUXNM6twg=;
 b=EsaZFb5BkxLb2tMxilRYkUc65GTV8a2k+lCujBndYVDgisKiJmWplyMPqiHs+sf2y4
 NLh8H7xZSq0vr6rAPX1WeZm+76Vy5zQ2t/X32vWdFYkpqhLKvcDwHSvsXthKQaLospW4
 W+y1tfJHjhC5x3xbQm9ypQjMHOO6dZPV4CaSAy9FQYromTue0N7UK8Uu5vnMRV+TvNGE
 x8FJA4818HZ/7E1F6sh2XSFkHdCdULrigGb9EylUnPo5cMKf/urSLJhIIrj0+emvI7Pt
 g1ctbEw/Q0VplHy+3qcL0qKZafhr2pIr6jwn4RW04fGXY27KcdvAnFYtVzEkXrK+M4Ki
 tC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789649772; x=1790254572;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8WQmZyVtliJQwYqNrz5u75N1ri7IqDeS4AuUXNM6twg=;
 b=kE/6v7ohD02yH6IDf0HKSy0eXA6dWBmQ+Lc9vEJKkcOCcNNrQwroe8nhQsQ94NvZd0
 roYvxecnuEEDZ+p88GSxPibFx/Vm20iEUXbJjQhQM2G46IkAUVA3/JDe40wabUsOwtaY
 edaESi8n4Mk/w0BgVGSl0p1J5mhATQp7OabLLFkFFIlCx9zBatmpfxhEucCUmmFJSQS5
 K46IUIean7nG5YCcuicxadCVgl6DBJP/6eoUWQDYv38Q3yO05U4+/TTcifwDLSponOxn
 qS3J6x+G1nnCJtwu+84njYUKpBS2OH6Lyvo9A7687y6ugqF5jbkp0iZIBc4Fieyo5JzV
 kS5Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxs7dvvSPSCTxF+u96FVLzn9wtHjomhju88TJRIbg+PW2PA9O/WgD1XMzgeuS9jSjl0VOUFQlT3ojy9@nongnu.org
X-Gm-Message-State: AFuF++n3Bfgn+mA0rnD49Hzlp6wM6dQM5DTVawKlB3u6NdhDeBQvhITN
 vH4MpvPIPyC/Q56JDKvI/RsF9A3R69QYi5lvLz5ZYS91mwIG0zh/hXJHRhcBcb/Nq7ergEED5Md
 UO/U1gwfXkDAHIHbGtDNz/QzIiHEwLdaMOcfS8Jiq4d0SaZvNOryHQuDzJg==
X-Gm-Gg: AYBFou3SwX8m5KK7oZ6CLe2TJZAhQjSEfqQ/zSCbO4yOURfQOF2pxfxiK8FDOKiKM4i
 TGGvAuXuREDtNuuwQ/1ixoX2IOHzANcEc/VAAi2+FZCKWzdI6yJCJl+4qWjUk1RKCMYuVNA7m8x
 f6t09aR4JWsfGmKs7u55F20qvwxmrXxGeawbpyjsCBvL5QTWqCOmkkff3/S778hKHSXH2wMgaCg
 d62YciX2vzzkEuCPnkoVOMElP74+R2Vu6d6qXlKMyH3nGKrPIJwJlTA5Gr8OeFmsM+ZN1Elqx4R
 +js8F+pk2e7kgO8LdjImrh9uFB8v4I4W+hYu43TpzYfyW5P86CxmGJDqJxTVVvE3DENThMvQTm4
 qri3KBI83ed0Bgu8fzDgGMfQtpv6SCD7/3NEpAw==
X-Received: by 2002:ac8:5a16:0:b0:532:9ade:b6d9 with SMTP id
 d75a77b69052e-5329adec539mr2757311cf.66.1789649772254; 
 Thu, 17 Sep 2026 05:56:12 -0700 (PDT)
X-Received: by 2002:ac8:5a16:0:b0:532:9ade:b6d9 with SMTP id
 d75a77b69052e-5329adec539mr2756891cf.66.1789649771674; 
 Thu, 17 Sep 2026 05:56:11 -0700 (PDT)
Received: from [192.168.68.102] ([189.110.107.170])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5326208ea78sm51190681cf.24.2026.09.17.05.56.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 05:56:10 -0700 (PDT)
Message-ID: <355f95fc-9957-40b6-a7b2-bfdbd049a797@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 09:56:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/15] hw/riscv/virt.c: fix aclint soc/mtimer nodename
To: Chao Liu <chao.liu@processmission.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-stable@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
 <20260828203918.350131-9-daniel.barboza@oss.qualcomm.com>
 <725cf200-8a28-4fc9-8d96-4d705213505d@tls.msk.ru>
 <8594dca6-0af0-41a1-878b-1e7847b5f043@oss.qualcomm.com>
 <aqt_QMsRDWG7ojXk@MacBook-Pro-4.local>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aqt_QMsRDWG7ojXk@MacBook-Pro-4.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Wx_-1bL-C1t73GpiDTlmkmaYK-NhoEwH
X-Proofpoint-ORIG-GUID: Wx_-1bL-C1t73GpiDTlmkmaYK-NhoEwH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE4MSBTYWx0ZWRfXzQRHcMUg6s8V
 XXUuZw6cVu4vNqkXhumJAnAecgMzcuzko4g6w+jIpkgh1MoOvFNzp5vczVkQSzqB1Ei/BSg+Il4
 mioxn/j6KR5zIoH5uGphI/SiKL93R+L5qb7O1CibNlOOSKTw4/bFpKMH47HQf2dDnvWWp2ZNsnl
 6S5OW9er7fZ6KW1SC6UQbTJ1T+B9itiPhvH6M2eMQyu6J0jkxJzc6a+adnzxrm9xCQcxweRpsj5
 t31HDX6UCGWy+VLNXNmMo9KzfACWm/2oPmYlMn83W6M05BrQn+l+UVCHtw8+y34yXsSouxim2U9
 oVtf0dJbPoeJjEUIfOpfPIlWvdtCqXv3E8aZop8vqDsbGAxp/l57tNDPeN5AHCPddVUyo/dWxsc
 sLgWFmzxRNXC+MUBESdiabGfijPec4M+ZQ3FoAA3Khv+z107cYsuuoV1KyQfTbZHrIGDSu9pxB2
 5cbxePE2M9NGc5CUD3Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE4MSBTYWx0ZWRfX8gEkf88GbZtC
 QWegFp38kxdJ4BaNPfr9rKyEen4pLwW6rvZZ5sdj0WQGq1TxnOEqa059e9AKJAv1PktLCjVKCgJ
 P/HQzBzBVMr1jpgSbRTn0DyW2CouUX0=
X-Authority-Analysis: v=2.4 cv=VIRIDNPX c=1 sm=1 tr=0 ts=6aabe36c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=arNgJ3JLhM/z8Vk/iMOFgQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=69wJf7TsAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8
 a=gek8CpJ8HlS4fbe9-CoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170181
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



On 9/17/2026 2:58 AM, Chao Liu wrote:
> On Wed, Sep 16, 2026 at 02:10:38PM +0800, Daniel Henrique Barboza wrote:
>> Hi Michael!
>>
>> On 9/16/2026 3:35 AM, Michael Tokarev wrote:
>>> On 8/28/26 23:39, Daniel Henrique Barboza wrote:
>>>> Running 'dtc' to generate a readable fdt for the virt machine produce
>>>> warnings:
>>>>
>>>>    $ dtc -I dtb -O dts virt.dtb > virt.dts
>>>> <stdout>: Warning (simple_bus_reg): /soc/mtimer@2000000: simple-bus unit address format error, expected "2007ff8"
>>>> <stdout>: Warning (simple_bus_reg): /soc/mtimer@2008000: simple-bus unit address format error, expected "200fff8"
>>>>
>>>> This happens because the 'reg' field does not match the address in the
>>>> nodename.  The right fix, pointed out by Chao in [1], is to make the
>>>> nodename match the reg value:
>>>>
>>>> "In the current QEMU implement, `addr` is the MTIMECMP base address,
>>>> while the MTIME register is located at addr + RISCV_ACLINT_DEFAULT_MTIME."
>>>>
>>>> In other words, the 'reg' value is correct but the nodename isn't.
>>>>
>>>> We'll make the fix now, allowing the next patch to move the fixed version
>>>> of aclint FDT to fdt-common.
>>>>
>>>> [1] https://lore.kernel.org/qemu-devel/apHH1upnh8udUUT-@ChaodeMacBook-Pro.local/
>>>>
>>>> Cc: qemu-stable@nongnu.org
>>>> Suggested-by: Chao Liu <chao.liu@processmission.com>
>>>> Fixes: 954886ea6d ("hw/riscv: virt: Add optional ACLINT support to virt machine")
>>>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>>>> ---
>>>>    hw/riscv/virt.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> This patch is Cc'd to qemu-stable, but there's an interesting rebase twist here,
>>> it looks like.  This is commit v11.1.0-1035-g9d6ac47d318 in the master branch.
>>>
>>>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>>>> index a6ec9def16..83a4b7710d 100644
>>>> --- a/hw/riscv/virt.c
>>>> +++ b/hw/riscv/virt.c
>>>> @@ -234,7 +234,8 @@ static void create_fdt_socket_aclint(RISCVVirtState *s,
>>>>                   (s->memmap[VIRT_CLINT].size * socket);
>>>>            size = s->memmap[VIRT_CLINT].size - RISCV_ACLINT_SWI_SIZE;
>>>>        }
>>>> -    name = g_strdup_printf("/soc/mtimer@%lx", addr);
>>>> +    name = g_strdup_printf("/soc/mtimer@%"HWADDR_PRIx,
>>>> +                           addr + RISCV_ACLINT_DEFAULT_MTIME);
>>>
>>> Before this commit, `add` variable is declared in this function as
>>> unsigned long.  So this particular change is wrong, because now the
>>> format string does not match its argument:
>>>
>>> ../hw/riscv/virt.c: In function 'create_fdt_socket_aclint':
>>> ../hw/riscv/virt.c:408:28: error: format '%llx' expects argument of type 'long long unsigned int', but argument 2 has type 'long unsigned int' [-Werror=format=]
>>>     408 |     name = g_strdup_printf("/soc/mtimer@%"HWADDR_PRIx,
>>>         |                            ^~~~~~~~~~~~~~~
>>>     409 |                            addr + RISCV_ACLINT_DEFAULT_MTIME);
>>>         |                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>         |                                 |
>>>         |                                 long unsigned int
>>> In file included from ../include/qemu/osdep.h:118,
>>>                    from ../hw/riscv/virt.c:21:
>>> /usr/x86_64-w64-mingw32/sys-root/mingw/include/inttypes.h:38:19: note: format string is defined here
>>>      38 | #define PRIx64 "llx"
>>>
>>> However, the very next commit, v11.1.0-1036-ge6ea6bec5a3
>>> "hw/riscv/fdt-common, virt.c: add riscv_create_fdt_socket_aclint()",
>>> moves this whole function to another file, *and* changes the type of
>>> `addr` variable to hwaddr.  So now, everything fits.
>>>
>>> But this single patch alone does not work.
>>>
>>> Note also there's no mentions of this type change anywhere.
>>>
>>> So, what was the actual issue ere?
>>>
>>> I'm dropping this patch from the stable series for now, it is definitely
>>> wrong.
>>
>> It is ok to drop this.  This is a FDT issue that has been around for several
>> years at this point and no one noticed.
>>
>> In case you want to port it anyway the right fix would be this:
>>
>>
>> name = g_strdup_printf("/soc/mtimer@%lx", addr + RISCV_ACLINT_DEFAULT_MTIME);
>>
>>
>> This would fix the FDT nodename without messing with the format string.
>>
>>
>>>
>>> It is also interesting that only win64 build of qemu detected this, all
>>> other went just fine.
>>
>> Yep, this went unnoticed on my end since it didn't break on Linux during my
>> testing ...
>>
> I also run into build failures somtimes. Just share my idea, QEMU's gitlab CI
> is very useful! But be careful when choosing the base commit or branch.

I usually run Gitlab CI before submitting big series like this.  The thing here is
that we would need to do a full Gitlab CI run for every single patch to catch
something like this - it was a particular Windows runner that complained about it,
and just with this patch standalone (applying patch 9 fixes the issue for it).

The silver lining here is that it's only a single Windows runner, so hopefully the
overall impact when bisecting code is contained.


Thanks,
Daniel



> 
> If you just use the latest master branch, CI may fail..
> 
> Thanks,
> Chao
>>
>> Cheers,
>> Daniel
>>
>>>
>>> Thanks,
>>>
>>> /mjt
>>


