Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D384CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEPBd-0005z8-1N; Wed, 07 Oct 2026 06:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEPBJ-0005xm-LO
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:47:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEPBI-0000O7-1l
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:47:29 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697Ac61a2687227
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 10:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zTwDpqCTDAR/o1ceRdCR0OMNvjx25gjaWUhWaJJBvCY=; b=Y+lKa4X/ZN6XhTQD
 OBI0tG4Mor2dN0st4eeilUilouMNPsAyDqWcSuLOpChw4IaFZAKEtZJdbZYXioU7
 KHEnoGejMJGDct5yRMTV/XlaIvDHeOT+mEuUheE1OdqJjEgLyqaNeUUst5+txGvw
 zelocB5UiOOo31UDJk1ogAAC1Q1hAVBLn3gNgthtV5jUcgMKm3oKosj+iveS3JPd
 e488NWu3GpuBGxIGcuvWGEScbbdJvezqwUfoWEKXYTyR5yVgiDsJmHPJQozf+E1Z
 MrA43CGYgWyhtYwV5+Knhrp+L6wvvu19c/ExeS5YG4Yg3scKesR1qkZ1LMjy3WXI
 te7uhw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5mge00w7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 10:47:26 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e834ff4d0so591503785a.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 03:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791370046; x=1791974846; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zTwDpqCTDAR/o1ceRdCR0OMNvjx25gjaWUhWaJJBvCY=;
 b=jDhJIVSNuS6bhRjGy61DsyZnG3S2RtgzZ3rPh79WjuHoiMwCI6WIXiH3yaCf8r4HZG
 LXuF7q5BSreCjyRPC12qk3RGkmk7FUMe64+izI+ReCinJ4JQKId3Aceo0ZfNYlC6PSt0
 21sHoSSaZl9sYrHPiNNPSoz/v2ydJItSdPjYxCsBJnf/+SGOB1PxjvIrKGgZP6dX67hD
 9/8xW36eKWwu/hAFVny7UKzGTN4ig3Q8gGFrVkrOgYiIZhfyK5lb9PrDJTW1vRlZCWN8
 1bi1h9mTZLkLQAScmMsQn00/JEpVgkzmDWV7Q0GnjRVWGdWCE6DbVGyYuqC8TIFMm0AW
 G3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791370046; x=1791974846;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zTwDpqCTDAR/o1ceRdCR0OMNvjx25gjaWUhWaJJBvCY=;
 b=hn3Ios94AFCH0Xv8nmWLy+pXDb4tsQ8gkQsVntbWFTt6xffPLPNlX8Dkr1hRu5Ngyt
 cloERjOneTW+PAw+NAFn2dbdsaRspPyqTI3Ghu1wjqnisvt1TmG/tp6MMJ/XTve577T3
 G75eGpzUfo5EkYsalQ/T/V5MY3JM07WnVY6V4HPeLnGTBYigsSGc6owotVOwKe/Xmxhe
 3eBDeYUPfrhS2uMMLL6/qfu/DpV8LMW5xTD4yo2ThDGznkE1FB3Gf1RW+ddsKXN4adDl
 YnQAjT5Yk7w/8iIJY/lRt4MU0j3O3JBE5bHPck6QLCCU/ik8LAduC6a2KTmLe3goiAWS
 FYNQ==
X-Gm-Message-State: AFuF++lo+qeYQUDZ0VMx0eb6Yhyb9SevCCKcxmujJ0ZeoFZ1DuCT/A+s
 LUS7NiLgYb1TEfgulhPtLHHt7JfH9nMoo/ouqx4Yz7R+5+1rIz/OnWSRiAvuACNSBXeZn/5dUGQ
 qh5wncQHLVUDaIJ70x6sTjdJuwQ5rvgK9DEK+efZ0O+Vc3yYasdaUAmK/yux8/JaN7kbI
X-Gm-Gg: AYBFou3HnZ7WYPkG172djvLuAukn6StEd5alLonfemIv3EtwTdAPXYGjNuyx2fKFo5Q
 MvoPB3mz0q7qbIFePPFioL1Jx8KyXSo/N5Gc1swLPQ+9HBAwrdU6rHMPxCgcHcBKa9zrUIMHllX
 TO17waWvCGqpMiB10jyPpcNH4x1nkyoWwXmwnWrX99p0YWvtfHnRW5yC05SY+snKlxuGlah+m58
 GE1nQ71XMjPN8rtxQBF632D3aUwu+8yLQzu6yIYgECfmeBU+R+iPyRA+6jIrd71jX/i5SZ81l+u
 VCOFygNqg3EIHIRMB5Wcw5RfeOx0/ZOhrgwV9CoLeB/+vvGeT7/14YEgmtA4/L+Q/ZGsKvBcjgQ
 4bN2Mig9AFN3+yyJ7Fxc8RgeDiA/5RaQvTw==
X-Received: by 2002:a05:620a:29c7:b0:93c:b721:b10d with SMTP id
 af79cd13be357-93e9b2ea329mr344296785a.8.1791370045955; 
 Wed, 07 Oct 2026 03:47:25 -0700 (PDT)
X-Received: by 2002:a05:620a:29c7:b0:93c:b721:b10d with SMTP id
 af79cd13be357-93e9b2ea329mr344294885a.8.1791370045430; 
 Wed, 07 Oct 2026 03:47:25 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a181aeaea2sm31986455e9.5.2026.10.07.03.47.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 03:47:24 -0700 (PDT)
Message-ID: <7437c9ee-d1f5-452a-a456-d1dd7e1d268d@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 12:47:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/27] cpus: Add helper to log raised exceptions with '-d
 int'
Content-Language: en-US
To: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-2-philmd@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261007094516.75732-2-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0MiBTYWx0ZWRfX3wEKKQ2srmi0
 +Hbk2I5LZ2xKxgJ1DSRhb2Hx/8MxjIKs/qWN7V4tipbYLzVGV/kgBPruz6Y5JGtFbD9wnUwK6lW
 KTKp+xdIVntMPLVtQCyJEcHWvoCq6zY=
X-Proofpoint-GUID: 7vN6KUl4Zp5mrfNhrhe0DbmjvyLBmSC3
X-Authority-Analysis: v=2.4 cv=PdJqFShd c=1 sm=1 tr=0 ts=6ac6233e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=E14uGW6T9AX781czc9gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 7vN6KUl4Zp5mrfNhrhe0DbmjvyLBmSC3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0MiBTYWx0ZWRfX/UNFnyJNVO1i
 s6XGtYYwOSHkZ1wRWQGqbEmU9xqBu+cnvgLY3jg6YXO4ZOkzCJYxVmuYtb/L6fSCkyDQZmTLAm2
 FCjW9OQ1l318hVhb/dg/iBGpfbomG5/7oZb6I++NmhRTqAFxj4ZV47gZub8FWbOpQ7pKYANznn3
 FMeXgQJQ3EtFRbJG8cHqXrwnMkdu8hvtBNdZwVk65myymXLSiLFBYYKYykNG1ce3cMOVGwdw7Ts
 9jv48+nU4LEiHnqhA5/4a2cK0H15P8GjvMsOZeRg77NCyJNWbn0Ael+GMAj0xBhNxIEDM4IXEmk
 RZJE4231Wxhzkx0cYssumQS1FlP5Sly/whTiBWRj+tnSdScJK4kCry9E99MrcPApI/zOy7hkqpD
 HpvDyzBukoXkCDRXxVcTeKdWpxquJ7IqD4AYip6NkNKDsSz436aEyf9f5SFN96SuqzSBJvr/Fyu
 6vg+qEJU+ELrW5mQRKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070042
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

On 7/10/26 11:44, Philippe Mathieu-DaudÃ© wrote:
> Add log_raise_exception(), a common helper cpu_loop_*() can
> call to log a raised exception when '-d int' is used, and
> qemu_excp_name() to resolve QEMU-internal exceptions to names.
> 
> Use it in cpu_loop_exit_atomic() to log the EXCP_ATOMIC reason.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   accel/tcg/cpu-exec-common.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
> index 68077c8fd9d..2ac8380d0bb 100644
> --- a/accel/tcg/cpu-exec-common.c
> +++ b/accel/tcg/cpu-exec-common.c
> @@ -89,6 +89,37 @@ void tcg_update_all_cflags(void)
>       }
>   }
>   
> +#define EXCP_QEMU_INTERNAL 0x10000
> +
> +static const char *qemu_excp_name(int excp)
> +{
> +    static const char *excp_name[] = {
> +        [EXCP_INTERRUPT - EXCP_QEMU_INTERNAL] = "async interruption",
> +        [EXCP_HLT       - EXCP_QEMU_INTERNAL] = "hlt instruction",
> +        [EXCP_DEBUG     - EXCP_QEMU_INTERNAL] = "debug",
> +        [EXCP_HALTED    - EXCP_QEMU_INTERNAL] = "halted",
> +        [EXCP_YIELD     - EXCP_QEMU_INTERNAL] = "yield",
> +        [EXCP_ATOMIC    - EXCP_QEMU_INTERNAL] = "emulate atomic",
> +    };
> +    assert(excp >= EXCP_QEMU_INTERNAL);
> +    excp -= EXCP_QEMU_INTERNAL;
> +    if ((excp < ARRAY_SIZE(excp_name)) && excp_name[excp]) {
> +        return excp_name[excp];
> +    }
> +    return "undocumented";
> +}
> +
> +static void log_raise_exception(const CPUState *cpu, int excp)
> +{
> +    if (!qemu_loglevel_mask(CPU_LOG_INT)) {
> +        return;
> +    }
> +    if (excp >= EXCP_QEMU_INTERNAL) {
> +        qemu_log_mask(CPU_LOG_INT, "raise exception: 0x%x (internal: %s)\n",
> +                                   excp, qemu_excp_name(excp));

Daniel suggested on IRC we can use target_name() here to distinguish
between different kinds of vCPUs. Alternatively we can add a
CPUClass::log_friendly_format_name() defaulting to current "%p index:%d"
but overwritable i.e. as "accel:%s target:%s cluster:%d index:%u", so
each time we log something on a vCPU context we have an unified prefix
format to parse.

> +    }
> +}
> +
>   /* exit the current TB, but without causing any exception to be raised */
>   void cpu_loop_exit_noexc(CPUState *cpu)
>   {
> @@ -118,5 +149,6 @@ void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc)
>       /* Prevent looping if already executing in a serial context. */
>       g_assert(!cpu_in_serial_context(cpu));
>       cpu->exception_index = EXCP_ATOMIC;
> +    log_raise_exception(cpu, EXCP_ATOMIC);
>       cpu_loop_exit_restore(cpu, pc);
>   }


