Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6D5C5DF74
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwK0G-0000k9-Gc; Tue, 18 Aug 2026 09:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwK0F-0000W9-6r
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:37:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwK0D-0000nY-Gv
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:37:18 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IDQlIr1350759
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 13:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4CS9pfEIgJsUA/66JzPeSjETP+j6SrM55G57kc3c0Z0=; b=bSO9cOtXcxl/1ZJ3
 RTBCwN1RVQH3Z4TVXxUGEx/Hwl7NgPfOGCi7FoZtaRIcdCIZ09VN6udVzUZxJmIo
 KqXyJfq811ORtGu4dpSw4FhchvVqxHVDD8mGy6e2tY+AXN5IZ8W9bBf3bHjU6oPQ
 LxFY5X7Ftt5QxHDLYOsBynHGgTf4EyYRq0/CYlK+nWeYuI5OEBexGqU5P5kUvzc8
 ygN7rHwraTpQld+2/qYSxfidRN51eOjsIO26fSf8yPn9dbXkRYzR+AFLNTDbsUgE
 S21pIs0YXZxOFrt87ZmEPU0yhOO3DaFcZxuIXWwIvkCOevmE8cJSq0hClVq6KQRp
 wUpvGg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4nb18t3q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 13:37:15 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e52306621so455060385a.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 06:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787060101; x=1787664901; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4CS9pfEIgJsUA/66JzPeSjETP+j6SrM55G57kc3c0Z0=;
 b=Mms1wM86RRIt6WzDGZBPHdmntVbIbwvDeBHyAtdbNTiKxqzgqFdf1QIQ94vCk3rbZB
 XtcNhO3bMKHc8YUBviDO/E5RghgfEnQS7GEqSFUZL1rWagi43zNupBZ1g+0gLrOWUoHM
 ac4ziGd6nVmk23YXARDakobaJzohe1rp9FXY/UDiA3oBd/WNVEFYpbKN5pDp9V7lI2Df
 MFNUvnEVE0+ucW/50x7D3KWneiyGEyeFXy2+6ayAFFmoQJioumH3O7uHylXOxXEnmsdj
 xsnL97Ugtq72xf3bvZS5UAtFcvmXAEVmC8iKFN5E8/vUpHCiBEjCjP+4tanWJJQoj70J
 /D2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787060101; x=1787664901;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4CS9pfEIgJsUA/66JzPeSjETP+j6SrM55G57kc3c0Z0=;
 b=R1zQJnoQq2Udos+6xU0tC6c8sUjq57en1eBPKNplToMz3kXYtw0/cu9BtsHpxdxpPk
 Ht/y7PZU62QD5k4r1qc9GNV80sg54KhjT7jGsOSkU1YpZYQLiWAx0Ue6eMqh0fHtyJfm
 vLmhf9iCVMLj+isLgjXf6CBnCG3xYW6hpNlzgPK9g/kh8z/nBxgc2a8zg0E0FJmCfotr
 Zdgl+NlTedcqMzHDjwAgCfQmcHPXZSkPyQmfNbvzQXzdeK8KRo8M8wHjzEufq7TE0YRg
 zvdkFwWK6bAuASo+V07ScTB6C+Gea1O7V6mSgJIoYH5TvAgXpjRMsjnjumA5wGlGdk6N
 HQ/g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrOT+i5b1BJDbUSW9zokliCOaNKHm5GlTAWUgw5eiALZwuHTEdEXLS5zUoeGsgqKWf47x4DjvIF7unB@nongnu.org
X-Gm-Message-State: AOJu0Ywra9TO7oSGu/ZyAJXurCYYK5B+w7wvb+lF4D7LQaKsKbMIAWlj
 asi/Kkvbwpwy97r/QLA39+7/wJEboylQd6eCSAwX1CdsbQm4zLfFi30oGBoU7Ak6a0eNNQkMURK
 DpwpBtqVDVFFPkulS2spp6fOYtG6GMGkyU603KlZDQ1yP9xjwq1SfuYdxkROGyFl9PyhA
X-Gm-Gg: AR+sD11+AgUD6ttQyNBz5UVM4Rh9fiX8/iwjmvrL2wMa3UyHq6HMHcjnFqBR+nSE9Rv
 qLnU6DoK1+U6xc7LKS7bNRYelSflD9jeHWW+GzTL55l+l+tEZyLAdU9ZSh0Gd3hB8AiJVFMxzE+
 AQwyPVSr9rUc0g5avuYUIUJSaMxixZSBTG8CPi1if/ioo7LkuEhlos8HwjoJ2PGl8TrKhmkuXvn
 0PqeE53I/6MIOqPKAkUIylR2+NAlUC9veOTZ4DxGDCRWyzX8lWW5w/Qamu5vkht+SzFx/tAUVeM
 fcTZ7osj82NclwqxKRfKRp30j8AOmU07PN4S8FfUe096YFOUd+YyYcrHfvfVaf5GT6h+d2rFtCo
 199k7O7jKCEhEI5H8IcEQhEk/KxEGJ8Mnk6s=
X-Received: by 2002:a05:620a:8706:20b0:937:70a:9d33 with SMTP id
 af79cd13be357-937070a9d7bmr433430885a.33.1787060101530; 
 Tue, 18 Aug 2026 06:35:01 -0700 (PDT)
X-Received: by 2002:a05:620a:8706:20b0:937:70a:9d33 with SMTP id
 af79cd13be357-937070a9d7bmr433424285a.33.1787060100972; 
 Tue, 18 Aug 2026 06:35:00 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d0876b8sm186974905e9.8.2026.08.18.06.35.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 06:35:00 -0700 (PDT)
Message-ID: <aee65084-b827-4ef2-9c3c-af40c5c5b0cf@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 15:34:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] accel/tcg: Make TCGCPUOps::cpu_exec_halt mandatory
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20240603160933.1141717-1-peter.maydell@linaro.org>
 <20240603160933.1141717-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20240603160933.1141717-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwMCBTYWx0ZWRfXyA6C3ifzkT+a
 Y4YUezvxyz/BO6NNesyaH7B+y+VzYucP+L6O8CXbhYJaiNh6i8LufXZ5jgmZl88QTLAllwbK5c5
 xs+YLPz76hHn3M7x+IrUBjYwwhOqheK9VwZe9LtMjQ0Brxlq4sBEP6kxzzTD9R11muV8K/6AL+0
 AcuJKKuL+cZBdQuNs51B/6VUURLnv9W+spznpSYm6rdSxF6AYmWUj24A//EXywyohKgzIZ00QPA
 BkJKbakFPYxmk1DA1WGj9rj17pNFz0BR+Pn9CDOAiwYHF2QzIYI46AOhRA8trsrTW7GGBpLAtTj
 ih1jkhz/wyWjU5tTna3lf6oKVqCSm0QdP/k8OocUKcpEYCy5HyBeBA+B/6O+BqdHH+LCDK9mI5L
 SpR2/eVmCGuUW3tu/CX6hcVdKt+1vau1Fgwta4Kg+b7zJ0DsEf4S/VolqCMBpI4AXRByl8jl0MV
 XJmHIPRsFdA4noaBwlQ==
X-Proofpoint-GUID: Bc_hdTseSCLsUSEADFihQ7oPLP40sIlP
X-Authority-Analysis: v=2.4 cv=Ze4t8MVA c=1 sm=1 tr=0 ts=6a84600b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=2dGzA8k-2Zh-ow3xcbwA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Bc_hdTseSCLsUSEADFihQ7oPLP40sIlP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwMCBTYWx0ZWRfX0fpNbd7bLhYf
 OKC3+myCzRpJqJQQECBMfZ4gQMmT0ZHruabNhF3hAZnWY2rCVSxdHksunEec/OxybdCMeHXXSey
 1dGfJ3FV29rK/ekIjPnQSVFIX9Lb0H8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180100
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 3/6/24 18:09, Peter Maydell wrote:
> Now that all targets set TCGCPUOps::cpu_exec_halt, we can make it
> mandatory and remove the fallback handling that calls cpu_has_work.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/core/tcg-cpu-ops.h | 9 ++++++---
>   accel/tcg/cpu-exec.c          | 7 +------
>   2 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
> index 099de3375e3..34318cf0e60 100644
> --- a/include/hw/core/tcg-cpu-ops.h
> +++ b/include/hw/core/tcg-cpu-ops.h
> @@ -122,10 +122,13 @@ struct TCGCPUOps {
>        * to do when the CPU is in the halted state.
>        *
>        * Return true to indicate that the CPU should now leave halt, false
> -     * if it should remain in the halted state.
> +     * if it should remain in the halted state. (This should generally
> +     * be the same value that cpu_has_work() would return.)
>        *
> -     * If this method is not provided, the default is to do nothing, and
> -     * to leave halt if cpu_has_work() returns true.
> +     * This method must be provided. If the target does not need to
> +     * do anything special for halt, the same function used for its
> +     * CPUClass::has_work method can be used here, as they have the
> +     * same function signature.

With retrospective, has_work() should be idempotent, taking a const
CPUState, while cpu_exec_halt() is expected to change CPUState
internal fields.

>        */
>       bool (*cpu_exec_halt)(CPUState *cpu);
>       /**
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 6711b58e0b2..8be4d2a1330 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -682,13 +682,8 @@ static inline bool cpu_handle_halt(CPUState *cpu)
>   #ifndef CONFIG_USER_ONLY
>       if (cpu->halted) {
>           const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
> -        bool leave_halt;
> +        bool leave_halt = tcg_ops->cpu_exec_halt(cpu);
>   
> -        if (tcg_ops->cpu_exec_halt) {
> -            leave_halt = tcg_ops->cpu_exec_halt(cpu);
> -        } else {
> -            leave_halt = cpu_has_work(cpu);
> -        }
>           if (!leave_halt) {
>               return true;
>           }


