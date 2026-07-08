Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6793EC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 23:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whbVN-0006Bs-SN; Wed, 08 Jul 2026 19:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whbVM-0006BU-61
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 19:16:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whbVK-0003lh-KZ
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 19:16:35 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668N92Xo001601
 for <qemu-devel@nongnu.org>; Wed, 8 Jul 2026 23:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SMR7m0ILsFACSjLwMouFa/LjUc6fZysk5moRIMo5GgY=; b=VpRqghEMbg6vS02j
 Ub34GFzMyHAK/phFh3wLmwTFNppQN9QlN7ivbNTJYHep0X2pXvFXdhp3s3LatRUN
 2Bvp5vz6LhtQfhyfa9q5LwS/l+0NgdnJnsImvrR9l8KDuqwn7VpRFPtpp0dbBV3l
 3gAKLKu+vJch2U14R2yTgVwXDlO1mHprhIjQi8PWavlngm6CHL2ifbl7sytKZyEn
 QX4WOrHZMNsY9BhtoqQifOMAzabtR/II19hEPmQObaucbSf/uqmPVnSH2vVyj9yI
 ssDPMicSFW+LdMEb1ocWgnrUtD8tMIhFcBu8u4clzVcL0e6vFMkfP8ar5RmjR0iX
 DP6oUA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9urvrum3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 23:16:32 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51bf321d786so13736691cf.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 16:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783552591; x=1784157391; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:cc:from
 :references:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SMR7m0ILsFACSjLwMouFa/LjUc6fZysk5moRIMo5GgY=;
 b=g/AKwlD6BiVnvuWh2tyLa1/2ZagTa4FaB7JUDAq9+2HSjjM6cFlXKcHYiaiVte57hy
 0Ew6wogzjKYmZU5m1bIENMOgWjTqlMr+2j8IzHTRWF04ghclS2M51ZlLIGyWZY0vvhb0
 jtDGYx3rpBk/b0toWoKrfdkucjV41X9uok0mka/N2rJUMjBbL6PgrLSQoq0zrkokGiOT
 EP2BrX+Y838VCTml1ZFT6zpcE1l+k7U5EtMSyr+xvVZPgMBVXQi0u6cYfQG8oRY7Mxv6
 5Ta05iGEDwuzemvi3CG6QUoiVQJHMQ0aHDBSsG7etAM8B/U98veiXdUGW2E3X0dF7k1P
 mVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783552591; x=1784157391;
 h=content-transfer-encoding:content-type:in-reply-to:cc:from
 :references:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SMR7m0ILsFACSjLwMouFa/LjUc6fZysk5moRIMo5GgY=;
 b=fCFOGVpiA7ZJyDa4HXx4qzGG3T9UgFCTyQ1BiWbREz3FIQQ1ORfDrrVif8ZcpznfXk
 0bapviiVKGN45hcNykOuGpLqDtQ4ZMtsMzf2RBroBVzNAMhrpXFhklY5hSgVjQX8BImm
 ndL9vXqeOYOERMhKjxyKRCKPTQs3B1LhiYN3/K3/LkWn/AmSezNQn8vgTuP+g8vLp+uC
 8A6tsU8HqhFQKdcDvFJEFfeQvQgUd5NDka+jkcH9z2XDxFUvGjMIUA+70T8Upff/LFsG
 wJvr7R9k0uWEOeEz0T0FgbryE5uX6ANoUF8prC1YC76SXbazdAn45EEuIZ+jZ2vdvL6O
 QH4Q==
X-Gm-Message-State: AOJu0YxodxcJTtg2adkd1fcPm7subRvDhCuSdzIArL3z1tBMmP8HuBCa
 IaVCBgftZuQEhTebx36J/LXjk8niBfAHzT8O7myCWfum/DVQYiLk/mHBQkkYawqU5xD9Rq34szj
 FI27LfugLKAmcWKnBZqCMbbU+5FRv+ZQN2ANP3uidi7SvjEFa8t6fI8NWGQ==
X-Gm-Gg: AfdE7clYHoCbn4B08Otzjpgl9qOU8W4BOc6pCQuQa9Qk8uM0CDvqZss+1il3pu5jn/9
 CL4OwcicQG+cIKwCb1Os1b2MyhbDnZ2MCC1lkBDA9Z6BYQDCgo+KoDDTtruDlJES+TVYLdGzG+4
 bU8n5gytze4DBeK42fz8uPS7jInrlO33paXW7Ommib29R6JrqrCGY+ASf69SCSK0vHD9NfXuDTF
 wES1g0Mnr6P+Eph+AWFl2l8637QleaqjfQ5Q6I83vaMNvFRcfi31KCun7wJCMDTYs4Tuly5BEto
 9Hb5TYX8ZYSswRGzexkw5HDOvWUsP/aaTMBuFiDPBRvxwBB3ExrHe3ramIyLkuw+/+xSWhWkiNK
 ipen0SjPMZJakQLxebao1WIhbzka5ZfAyUKYTmjSNV+R4US4ELLnr+BArm8FbsA==
X-Received: by 2002:ac8:7d94:0:b0:51c:1117:c6a with SMTP id
 d75a77b69052e-51c8b2d54e5mr53183291cf.4.1783552591573; 
 Wed, 08 Jul 2026 16:16:31 -0700 (PDT)
X-Received: by 2002:ac8:7d94:0:b0:51c:1117:c6a with SMTP id
 d75a77b69052e-51c8b2d54e5mr53182951cf.4.1783552591100; 
 Wed, 08 Jul 2026 16:16:31 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6df417sm13027425e9.8.2026.07.08.16.16.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 16:16:29 -0700 (PDT)
Message-ID: <51024f9c-2b0f-4a92-b512-1c79fda0338a@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 01:16:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 28/38] target/arm/hvf: Keep calling hv_vcpu_run() in loop
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
 <20251031183310.3778349-29-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20251031183310.3778349-29-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDIyNyBTYWx0ZWRfX5fpwfDMAzYB4
 GhM6Jtku+s/M8iDsKsAmjv8sqBuRP+dBRTWWP86sJtt80AY2A0O8NLaegNMZgDFAuXvcX8OfwQE
 vbhTBlr+A26vXEmSenLFPDrck/x48T8=
X-Proofpoint-GUID: BwQ204N98Xm30hMRDxrDyJRQsW5ZreNB
X-Proofpoint-ORIG-GUID: BwQ204N98Xm30hMRDxrDyJRQsW5ZreNB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDIyNyBTYWx0ZWRfX4iut6880FctT
 5bcEahEvSXmhhbpd8UpU0HGdJUinjzVrM4EwZbqkIMqUgvSl0DKdk2+6pVE2W2qOW7Ff/FlAPn+
 k0gZnHHBCX1D8h6f7Fy3A8rCm4HdUxUefEnVNCd8P5bs00SbNP0RnK6I8M4+ucmxQ1lBQqYRT3L
 2jpD0ujw7JL0FikUQFoHt7WlodffpktEYSLdOnDYUX3Xco9mR5pHyjxC0jmjkszTS6cHNCEGHcA
 tQPvh4R4LyUjMYZlSCdEK8Z+JkHTU/Y5fqOgphSRornqBKe6eHOmJBRt4KlvA+ooHjnz9QgDBb2
 DYA2IQ4imG/+IjMsCDGgsISjI+9cGUqIqk1MovdflX7pha1mKFoWlSnIbiR8kb2qFMjYMReV8G3
 bIhF+2IwVQ9WcvrUycxIRxQ4i0AxDSW5QVm2YjbMniHJOhHS0OTFrt8KUi7AKnVqFNEX/K8/wUB
 61uqf6yeMHl5/gYmVNg==
X-Authority-Analysis: v=2.4 cv=H43rBeYi c=1 sm=1 tr=0 ts=6a4eda50 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=0Sh2Vq7NBo4H4iER7TcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080227
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

Hi Mohamed, Cameron,

On 31/10/25 19:33, Peter Maydell wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Mads Ynddal <mads@ynddal.dk>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 38 ++++++++++++++++++++------------------
>   1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 27c600148f9..79861dcacf9 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -2013,30 +2013,32 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
>       int ret;
>       hv_return_t r;
>   
> -    if (!(cpu->singlestep_enabled & SSTEP_NOIRQ) &&
> -        hvf_inject_interrupts(cpu)) {
> -        return EXCP_INTERRUPT;
> -    }
> -
>       if (cpu->halted) {
>           return EXCP_HLT;
>       }
>   
>       flush_cpu_state(cpu);
>   
> -    bql_unlock();
> -    r = hv_vcpu_run(cpu->accel->fd);
> -    bql_lock();
> -    switch (r) {
> -    case HV_SUCCESS:
> -        ret = hvf_handle_vmexit(cpu, cpu->accel->exit);
> -        break;
> -    case HV_ILLEGAL_GUEST_STATE:
> -        trace_hvf_illegal_guest_state();
> -        /* fall through */
> -    default:
> -        g_assert_not_reached();
> -    }
> +    do {
> +        if (!(cpu->singlestep_enabled & SSTEP_NOIRQ) &&
> +            hvf_inject_interrupts(cpu)) {
> +            return EXCP_INTERRUPT;
> +        }
> +
> +        bql_unlock();
> +        r = hv_vcpu_run(cpu->accel->fd);
> +        bql_lock();
> +        switch (r) {
> +        case HV_SUCCESS:
> +            ret = hvf_handle_vmexit(cpu, cpu->accel->exit);
> +            break;
> +        case HV_ILLEGAL_GUEST_STATE:
> +            trace_hvf_illegal_guest_state();
> +            /* fall through */
> +        default:

When doing vCPU reset I get here with r=0xfae94004, which is not
listed in <Hypervisor/hv_error.h>:

/*!
  * @enum       hv_return_t
  * @abstract   Hypervisor Framework return codes
  */
enum {
     HV_SUCCESS       = 0,
     HV_ERROR         = err_common_hypervisor | 0x01, /* (0xfae94001) */
     HV_BUSY          = err_common_hypervisor | 0x02, /* (0xfae94002) */
     HV_BAD_ARGUMENT  = err_common_hypervisor | 0x03, /* (0xfae94003) */
     HV_NO_RESOURCES  = err_common_hypervisor | 0x05, /* (0xfae94005) */
     HV_NO_DEVICE     = err_common_hypervisor | 0x06, /* (0xfae94006) */
     HV_DENIED        = err_common_hypervisor | 0x07, /* (0xfae94007) */
     HV_FAULT         = err_common_hypervisor | 0x08, /* (0xfae94008) */
     HV_UNSUPPORTED   = err_common_hypervisor | 0x0f  /* (0xfae9400f) */
};

Any clue what it means and how we should deal with it in case it is
not fatal?

Regards,

Phil.

> +            g_assert_not_reached();
> +        }
> +    } while (ret == 0);
>   
>       return ret;
>   }


