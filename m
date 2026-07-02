Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BECFC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 12:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfGpC-0000n0-7g; Thu, 02 Jul 2026 08:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfGpA-0000lh-Ow
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 08:47:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfGp8-0004o1-JZ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 08:47:24 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662CkdgT490634
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 12:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iJTaN0UhzZMqOyr0u2fAEPgDy+zMLkWuJDNOukdLE74=; b=EJwNFo6vJr0Wsm3G
 Tb5dHdNYoEx1CLu42dmWabWkMPVO24HhU4T5jCLKPXgxwfZ5b8VcFLFuAqzO3gQE
 L/ld79IkhFaMmeznzdPsfHAkabCJces5xrNz8fnDyb+KE9Xft3ezlC9hGftyGy0A
 8Uq117N4jCoKHOe4fWvTnMHp6im7OYaB/Fod0G3d9RT5TEmRW9gjVV9PqRa7cdmM
 9ioyXd4MwhQK+0uiYaHnmPkKP8kBOyXhXGRZRtErPutdgrvDvhJ7jcLsZFHWszAb
 q7Ej2CN0o5LOiQJSqbWABko/I8n56Xi/nOdbq6h22hmek4B+7gNoBtN7nzezTN8U
 fP89sw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5541vryv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 12:47:19 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e632390d2so348538385a.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 05:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782996438; x=1783601238; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iJTaN0UhzZMqOyr0u2fAEPgDy+zMLkWuJDNOukdLE74=;
 b=SvjHZD/2j7aZzR7A+VoGwj+Y20wFXlw4hUz2ib+BydLx/N3fpMiz3pBowGv1OvMYHM
 sBLj46BWxabsdQ5BMncrq3ghe8CS0gt/3wNAzSegFFWJBXpFzafFNELLQkKpq70sID3l
 qloKMbbqUBbC1h5EvvfGPeYjUWwRuhsFdKJ7HFYarH8OjG8rJmdeoTN5/IFw9hC6UokO
 HRcAQGXXXYvWMe6ey9FbVpOPSS1LpBZRITEHr7wrtRWn0yje9AH7PidjfFv6ItrDch2p
 w/s4p6I6I/uxmKuV5PDz0TcItMRJnMHLiW/5021uBaPLvBlVpfWlA+QXRaZROx14fCYc
 gZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782996438; x=1783601238;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iJTaN0UhzZMqOyr0u2fAEPgDy+zMLkWuJDNOukdLE74=;
 b=jCtMXWbZzPkETOFmFyaC+/1XuLPUZbrKmzWJAE4MHHJQqnZ10GcM1YtWJ7gggn815g
 6hBPgNyMldGtpm+snJRXFcQlyzXTMwtosfkJQYy4az9EpI+OygMWH0hEAdiQi9KCkWuU
 6D2m5tVFRmry8uYyxWHvq48cX6nzYeq/QvtE00OHw3wEIFXW8kumxA4ZK2XLLBI+ziFD
 +TIZ03WabmZ7AuMv+6xLBriNIIGd/QoWm5zqg3Vpdfev00I4Qc3L3yoWRXX7GXYl68HL
 EkxNEc7Mm+P5Z0Vn8wQFf/Dc4BJ5AsgOMQXLLmoyoAbqE0B7vOv0WpRrqxdjwVxWE/fs
 C6Qg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8wi4maatZ4YyzqmPFOXPK9OtB4rWk/kXqhYrUV5v3S3lapaqvnRfNbZT4t79iaTuaPGjTGUef8qw4a@nongnu.org
X-Gm-Message-State: AOJu0YyhrSpkNdDiVqimDUUzYT5EjZC9NTqG9RPuXBYb7r9ELrap1Z3X
 DNx4Z74Mr9ZK7sl0LpCEGy007fQFJjlnjNvGbcz81OYs4twaIfchnbYCoOBwBWemS3YhZ2LgoEq
 o2UTw5EM1XpGbZN4LS/eIuAkZJw8Gk8zd47KR9wcEGct26PpyA9kQ9w24ow==
X-Gm-Gg: AfdE7cl88Tg10JvIKqJl4bObiKUL6awcyyWNNlpOFfKG6rMFiVOfyJF7jfq4dyaql29
 7TB7NOjL7rjn6LaP+1X39LtmCm6e8e+pWt0jET8ejs0bEoYIcj3EqBGyztFl3XYmidluBwlihaX
 6S16Tx7M/Gwq4oY32Xs7Hz1kcGgm4qZpZWIG4Cd1m3/FTn7xbmjvW0P5/L2TytdEDzXlbXAumoU
 mIKP2cf8mTsLtctX2BF3trg17z7AFLSEV78Sav5zMHH6HhRIUrKQUvxDwEE/V+Bvd94pb6ajmhN
 xxfpkc+cIwMQLEQp1YmUH7FxJyMB1kuUr5vx3Po+2J9HdDZkQqsgb6z9RMuVtAwG2xCwy1fHCIK
 aYMK4VwrPITdsl86stehV63mtIXtjieCx5IMRTJO0QVF8RjeDo6EPxl6qvsvCUw==
X-Received: by 2002:a05:620a:4086:b0:92e:57ac:f6ab with SMTP id
 af79cd13be357-92e7b3de6e6mr703327885a.59.1782996438326; 
 Thu, 02 Jul 2026 05:47:18 -0700 (PDT)
X-Received: by 2002:a05:620a:4086:b0:92e:57ac:f6ab with SMTP id
 af79cd13be357-92e7b3de6e6mr703322585a.59.1782996437759; 
 Thu, 02 Jul 2026 05:47:17 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c6372c52sm52597185e9.14.2026.07.02.05.47.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 05:47:17 -0700 (PDT)
Message-ID: <3a4c9213-b303-4b50-92a7-3e10a28edc36@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 14:47:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/loongarch_dintc: Fix OOB access in DINT MMIO
 write handler
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, gaosong <gaosong@loongson.cn>,
 qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, berrange@redhat.com, lixianglai@loongson.cn
References: <20260701065454.1976188-1-gaosong@loongson.cn>
 <72f8e95a-520c-44ce-b42d-7bac6ce8db05@oss.qualcomm.com>
 <b057fe4c-6ec5-6467-c88e-4c94d18a5891@loongson.cn>
 <d42c2c0e-0a2a-4b24-9143-c2c7bc9f7023@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <d42c2c0e-0a2a-4b24-9143-c2c7bc9f7023@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZNp_89Cr8ysZZi8XVlo73d9j4Me9C9yk
X-Proofpoint-ORIG-GUID: ZNp_89Cr8ysZZi8XVlo73d9j4Me9C9yk
X-Authority-Analysis: v=2.4 cv=Xbm5Co55 c=1 sm=1 tr=0 ts=6a465dd7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=8Ytube2T8V5n9d2HhL4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzMyBTYWx0ZWRfX3lAj/BQjrn7+
 4dr1XvbTK+OF2hGF48/zjINbiogSy2HlwllNCNIUaiKLrFyeGyI4FNtg0i7FqBoet5Lx7W6IpNs
 7IOA8ENTa2lmEKR9i7/AjU89SDz+bTWVyzU0VrJfBTIPZUnz1HDArNLR84hJ1j/2KJOP/3STekV
 9+9uI2U1GPAxnTXiVFI7JH8CmEvQyeZMdsVAg52FNK7mTPD358XLmZ+/s/KM2dU9KwLPURjrhNA
 3ACbhFPfZOwcsqyCGsg09QbnE15nyZwdX8/zQNTRHCYxe3rOMIeCo1l6yNfO6MbJcnw7YRrWhXE
 2h/qO3owj9ma90+EGZsEaeTODu/lXjegP6TKEvd52ZfHlE6LfVj6fdJuw0ITOVfQlaeFiUBBuJg
 TYRyzwvKNUsUv4jwjDO9864ikSYsrdfMvFdepGFr8J1p6zc7/KaYe8sEDrqoRGTxEU2QcwDsTsj
 pRhhZTfDEGCkGn5CSsA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEzMyBTYWx0ZWRfXwPEg4/0vCOy3
 IipoCOjGoaEPB+P8Rkr1rKqcVICEqTpIbmarQYyFpid+8DMoyd9IPKTzWa8xhbslEvC1sdSkAvM
 QQuDOVtcaCKhb2DhuTA7TCvR8bn87Ys=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020133
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 2/7/26 08:14, Thomas Huth wrote:
> On 02/07/2026 03.50, gaosong wrote:
>> 在 2026/7/1 下午3:43, Philippe Mathieu-Daudé 写道:
>>> Hi,
>>>
>>> On 1/7/26 08:54, Song Gao wrote:
>>>> Validate guest-controlled cpu_num before using it to index the cpu[] 
>>>> array
>>>> or pass to async_run_on_cpu(). Without this check, a malicious guest 
>>>> can
>>>> trigger a NULL pointer dereference in async_run_on_cpu() and an
>>>> out-of-bounds array access in qemu_set_irq(), causing host crash.
>>>>
>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3616
>>>> Fixes: 0d148eaf5a3e ("hw/loongarch: Implement dintc set irq")
>>>> Reported-by: Thomas Huth <thuth@redhat.com>
>>>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>>>> ---
>>>>   hw/intc/loongarch_dintc.c | 13 +++++++++++++
>>>>   1 file changed, 13 insertions(+)
>>>>
>>>> diff --git a/hw/intc/loongarch_dintc.c b/hw/intc/loongarch_dintc.c
>>>> index c877a8003b..e40292887c 100644
>>>> --- a/hw/intc/loongarch_dintc.c
>>>> +++ b/hw/intc/loongarch_dintc.c
>>>> @@ -19,6 +19,7 @@
>>>>   #include "target/loongarch/cpu.h"
>>>>   #include "qemu/error-report.h"
>>>>   #include "system/hw_accel.h"
>>>> +#include "qemu/log.h"
>>>>     /* msg addr field */
>>>>   FIELD(MSG_ADDR, IRQ_NUM, 4, 8)
>>>> @@ -52,7 +53,19 @@ static void loongarch_dintc_mem_write(void 
>>>> *opaque, hwaddr addr,
>>>>       CPUState *cs;
>>>>         cpu_num = FIELD_EX64(msg_addr, MSG_ADDR, CPU_NUM);
>>>> +
>>>> +    /* Validate cpu_num against the configured number of CPUs */
>>>> +    if (cpu_num >= s->num_cpu) {
>>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>>> +                      "loongarch-dintc: invalid cpu number%d\n", 
>>>> cpu_num);
>>>> +        return;
>>>
>>> Do you know how real hardware behave in this case?
>>>
>> I haven't been able to verify the exact physical hardware behavior for 
>> writes targeting a non-existent CPU.
>> However, I don't think this situation will actually happen,
>>
>> but QEMU ASAN has reported a code risk, and I'm not sure if we need to 
>> address it. Could you offer some advice?

I was just checking, better to not diverge and be faithful when we can.

> 
> I don't know, but I guess real hardware would ignore the write, too - if 
> there is no CPU with the right ID listening to the write, it's unlikely 
> that something happens.
> 
> So I think your patch is doing the right thing:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Maybe not "the right" but "a plausible" one ;)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


