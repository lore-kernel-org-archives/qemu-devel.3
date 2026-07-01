Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57191C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wepbF-0007js-Mk; Wed, 01 Jul 2026 03:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wepbD-0007jS-C3
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 03:43:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wepbB-0003lM-FX
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 03:43:11 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6615lP8D133243
 for <qemu-devel@nongnu.org>; Wed, 1 Jul 2026 07:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KpgwEXfVOuE1N+aERsMuxkL0KFJqeK+CZg4KyW7mclA=; b=PHYbIauYixdhwIRs
 1Y6i1zU+ARM+PMrqChiXd5ISU7DKuBIOPE7iZypNfHpqQQTK0PkKVf1z+bOv2NNP
 ZF2LNOUSUbp0anG5mQ3U5fqGMSXS4OOGJ/Myvn9HppDbpFzHjMzO0pX8wN8OGp/+
 E458WNOiP8Q5+heGdzgTFy/FrFIdsfySU1Zap+JdRLxmruNYQlPJyC6BxdS9/bXl
 vJtUI1UruCsQXpdkjtMsOyI8fZ1N/ocCrzafbejBbXxOD1t3Q1cN/7WhKqaQ4DKA
 xEODRnazlqsCYzzuqBo62MbDUsL/orNQmRs8VRkBGICIVih99DDTvf7kcrfOg5O8
 yRfN4Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4rsy1fa4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 07:43:07 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e52306621so35137585a.1
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 00:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782891787; x=1783496587; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KpgwEXfVOuE1N+aERsMuxkL0KFJqeK+CZg4KyW7mclA=;
 b=Wpi7IPi0aR6Sx2wrApxijbauO+hndzFf/21e2oKanZnMN5yFVqm6GQ9Bmf/n79tji2
 K0nmslqBX3D+wtQw5aFclL24v/YCApgyghK0FeR9a3uU5Ng5lxBhu7DTG3b3STJ1sY1C
 KzrnfVQtw3hPJdDPD9BHLp2SY4zYSPMet63KXJ31yGStZ/9VIJW26IMc2+Z81eYOlYy3
 6jV/b2opMe2zHgv9G2VPaotXivu1Ga/WGczv3q0S0lYz5ZpRz3nFBMlPz+36ncseaAdS
 y6fve2QxKJe6nfgEsrXxFluW4Qp4uT619HSTgyigZjwJaq4lfKdXOf4+Gif9KF8Zrh3o
 daCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782891787; x=1783496587;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KpgwEXfVOuE1N+aERsMuxkL0KFJqeK+CZg4KyW7mclA=;
 b=VOQh8KTKobt8r0C+/mn/hd4OoyxY8MAIUfHH0HWlnxB/k6esnumMPVfCOIOT2qMqPs
 Q16rmFXiii76oGVG3Wb3+Fbkd+38wGDpwiic9iwC2Kyepz0ktIw9AOYxHTzcaWAwa/Gz
 /lLLy371py3/FJoV83O/h4nAhWFTCU18mrRWafdx9WbQnlwxKrStC5KGRRdts4dQ6Jqg
 vgRYZMs48/8gnfvDHIjHLXOjmlQBFf0qRCQJqsynBX2J1UckNEdmcCmElrCwFkTpLJcR
 Zt0BOi7eA2liO2jjTdLbo3GfR/K0cfYSBFOOWygBSbiemFEgewaH2YWhw/WTfx/PBUYq
 2ngA==
X-Forwarded-Encrypted: i=1;
 AFNElJ99JHmAmdMjPWzVhPRLpDIQ7OrmZei4bspiWmG/rn3+vpt3Rl38vcEa8B7fpYjVcfg4xzCuDHRacTte@nongnu.org
X-Gm-Message-State: AOJu0YyAamRpoTKuFnIqNTIZNjy0Vb+7+BHIPp50/ldZvYKe9uLy3fr9
 kPNTE7zGJdPmp0osb/cTj9NZ17baVvKI20ekAI4ttukKA6PBUoTi2OISURTnJ8FbLU1NGQKDZoN
 +bYwQNuBoHtZUgP2xfBZTAXC16nkeevJ76oaVTJx6P7etwsYqIYTrvkWZkA==
X-Gm-Gg: AfdE7ckATIQRDCI1O19QdRUzPwxm5R2CJgd3ovypYBRgQ3v0IoZspu8iTfrKDfUu1Ao
 3Eb+WuDo9w+r8FepRWuX9Gse0oMuAx2UsPRoyrmKmxYMPWk87lvFrS7YoTHwtG/oFO6/3ikMif8
 mxv4775a1OVydCwxEAQCx301WfemKduRo2fpzwyDbh2XRF31Xtvdde4bg1UGFeR2wFuwL3KR80q
 gTg+PjHsIncS150Ax6aS1cpvNBFDRrYxQgZRNo3t8xu9ZlitfiJbRksP0B+sqxCAcwjC56qOGw7
 6YZKR7UqUZP3kVEbmsT0zNzh5saMnB+vK87CQJgula+ZAOndFFMXktAduU1XQCCcDrcU6qaAZ1B
 c2oVBt1g1JrNXPqr+XeS8CmcW39Jl1QP5l4UYCupQCms49PdoWRWSBnyfdYtbNQ==
X-Received: by 2002:a05:620a:4593:b0:915:e2a7:bea5 with SMTP id
 af79cd13be357-92e784f2c24mr67939885a.50.1782891786933; 
 Wed, 01 Jul 2026 00:43:06 -0700 (PDT)
X-Received: by 2002:a05:620a:4593:b0:915:e2a7:bea5 with SMTP id
 af79cd13be357-92e784f2c24mr67937285a.50.1782891786444; 
 Wed, 01 Jul 2026 00:43:06 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47566fe448dsm14725249f8f.27.2026.07.01.00.43.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 00:43:05 -0700 (PDT)
Message-ID: <72f8e95a-520c-44ce-b42d-7bac6ce8db05@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 09:43:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/loongarch_dintc: Fix OOB access in DINT MMIO
 write handler
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, thuth@redhat.com, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, berrange@redhat.com, lixianglai@loongson.cn
References: <20260701065454.1976188-1-gaosong@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260701065454.1976188-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: TmGoHPVerZ03B0ahi1ui1FPP6r0xVFLJ
X-Authority-Analysis: v=2.4 cv=fLgJG5ae c=1 sm=1 tr=0 ts=6a44c50b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=UxWyvXa9c_BcrdTXp0YA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA3NyBTYWx0ZWRfXx+m7igcFi9gJ
 dCi0ZD8oLwEUM3fFJYu+PHlU0UdwU8DrgAAjL3VP0njxaRe3xesotjorqycRtCYiKsvn3Cij5U9
 8OF9hzTdM+Xd6c4bamU+BpvX40lDqlQLtK86ctGNHvGDjfnZHMPjMwy/OdANoSWmwIEKVsWZniH
 eBWJoSFEm8gRgMww1ImknHkdyC9e2zjaMwdRGQocGUkf2G380dpXl0eYcpr86e1W+ulIaZFuwY0
 ecCnmQkdax/NqZ13UktNdRbK0d78wucKaF6Rj/49OC8Bs82F07Ghz6kWJZlYn0z5Q33WHA8AZfW
 cI6K3+3E6QyZua+DKccGHOhrDf/hVBvsbQyBrrfrWl2kemAhaoZwxvkEhT4YDiPmiZIax4nsdt7
 EFHlIK77g/3X2Gc7Jw3MIked0g/EQ9BAJtzuTN2K6X9rbzk8GsWlkKjhzqPbb247a5U3AJJoznj
 wmprfH71Leqzu2VUAhA==
X-Proofpoint-ORIG-GUID: TmGoHPVerZ03B0ahi1ui1FPP6r0xVFLJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA3NyBTYWx0ZWRfX4EALoDhI4tUU
 E6hoEXs5jh4DDAxM6oUBPzKa6Sq49hdipgklePTEMw+OHrKXehTKJpDaAPLttPdx7v1DLHrZyCS
 GjYFIczl4nP0zXGIuL4KNTt907TDMxs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010077
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

Hi,

On 1/7/26 08:54, Song Gao wrote:
> Validate guest-controlled cpu_num before using it to index the cpu[] array
> or pass to async_run_on_cpu(). Without this check, a malicious guest can
> trigger a NULL pointer dereference in async_run_on_cpu() and an
> out-of-bounds array access in qemu_set_irq(), causing host crash.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3616
> Fixes: 0d148eaf5a3e ("hw/loongarch: Implement dintc set irq")
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/intc/loongarch_dintc.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/hw/intc/loongarch_dintc.c b/hw/intc/loongarch_dintc.c
> index c877a8003b..e40292887c 100644
> --- a/hw/intc/loongarch_dintc.c
> +++ b/hw/intc/loongarch_dintc.c
> @@ -19,6 +19,7 @@
>   #include "target/loongarch/cpu.h"
>   #include "qemu/error-report.h"
>   #include "system/hw_accel.h"
> +#include "qemu/log.h"
>   
>   /* msg addr field */
>   FIELD(MSG_ADDR, IRQ_NUM, 4, 8)
> @@ -52,7 +53,19 @@ static void loongarch_dintc_mem_write(void *opaque, hwaddr addr,
>       CPUState *cs;
>   
>       cpu_num = FIELD_EX64(msg_addr, MSG_ADDR, CPU_NUM);
> +
> +    /* Validate cpu_num against the configured number of CPUs */
> +    if (cpu_num >= s->num_cpu) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "loongarch-dintc: invalid cpu number%d\n", cpu_num);
> +        return;

Do you know how real hardware behave in this case?

> +    }
>       cs = cpu_by_arch_id(cpu_num);
> +    if (!cs) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "loongarch-dintc: no CPU for arch_id %d\n", cpu_num);
> +        return;
> +    }
>       irq_num = FIELD_EX64(msg_addr, MSG_ADDR, IRQ_NUM);
>   
>       async_run_on_cpu(cs, do_set_vcpu_dintc_irq,


