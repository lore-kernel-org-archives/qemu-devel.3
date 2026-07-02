Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F25C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHaV-00084D-5b; Thu, 02 Jul 2026 09:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHaT-00083M-Dj
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:36:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHaR-00014t-Ru
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:36:17 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0jJ3528139
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 njmqbkgMfWo0L1tIeTxyq2kRE3N0h+xK2z7layzUFgo=; b=V5N0iVhZ7XHxlhQw
 yiyLDpbxONOPzQj5BDA16vY684bF2C4ZGBbUujUDMwjDvd91nBRiZa0lfmJq/kWj
 uddna6NDci4gb5UrTAK77RGzHjJ7GFvmjBRvV6DlR28EyrbzJNI2DGhdNClI66LW
 bv3TxC2IzOIEm6MjfzrNmpZkKTz5kMK+ozr86AZOeTzYIMl6BOtHlMfbVe9O6VXd
 VrkdtO/svISqjP8eZ9sSlBTfRuYLWuWYqq08OnP0+UB6M0fJ+KX6AbTuNEUmoB1M
 N56Kyb+qGzgBynoOLPh2zgCdpSeYy28aQqLfh3spYivmB3YiBxqeOqHg6SnMPhdS
 dAkFBQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h7n9ya8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:36:14 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7390c789e4cso1596446137.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782999373; x=1783604173; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=njmqbkgMfWo0L1tIeTxyq2kRE3N0h+xK2z7layzUFgo=;
 b=MXW6CSxQYetJAHA2M6FmNlbFD7zb5gjMmSyzbjiwoZu+YMek5x/d06nVqskpowzyN5
 YH767nhGmE4rBNDmVpk02jJiOhJ4FegLwsyeGS9hOcMySVooKeyoE4GT4CVllDedHH9g
 kHSth9NAZVF13cry6U6F2EZ5snV/UzQKIk5kfpIWw075J8dM72rPXN6ECxzLXgFlkwV2
 J+7bdwOcI5UwiCLjodPlgQ3nupknfUbUPHCrswFcHHW2uBM8LBzq9dDTCm2xIJhfnNPa
 v0Bt1kKIjxEX+3cWjF0nf0bzW9KOpiVGjDRDL/OD7sJ2K2AO0b9AsNIOq56cYa+djbWs
 dI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782999373; x=1783604173;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=njmqbkgMfWo0L1tIeTxyq2kRE3N0h+xK2z7layzUFgo=;
 b=TAOJD3UobZLbRMFhYJEstBUB2dyjOPGODaCPBMXymFFjBtZru/Q8dO2txQljqhIhN+
 6BrEvAJ2ByGgGQYhc9uLSuExzUq+58P/PDIvFzCzcVzjx2VQXS5Kfzc4kqhkOYxMiYMf
 CGH9VUvDMhU9S0OaszwQB3gXi0UCODOaHdk+rv2SS0cNnhsgtBTgEVltdYLx6Depc2XQ
 YHvbpLdWYsUozjRUePdhH1FoM6YhB5TfwIma9LpZod161CbnlYZ8QOLmI5A8cwEF3h2O
 /FbOPMzqgEnJ/4bCT6l8q2w0kAa3dg9feyWoEXFTrU0zgcgSeKksdokyV5fmNI59J301
 oEmQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrfpna9ssFBIGWxU0l0Mf/ViZRN5YeiZNYqH5pEtslWxQ//70JABsujtAGnT3UQaQsHApsGnLg8WP6p@nongnu.org
X-Gm-Message-State: AOJu0YwwHqQn6tk3Buo/03vKmPIJycRh2JltqKMfxgBZ3pFEoTwZiUos
 U0jemf64CDiYkckJd2oE+Y3E+PPRGZGKwdBMsUXqOPcggR01WjGHuuzznYYHSPA9Xt/eWS6AXIW
 odMh9GZ/uWjn8MMG9fyXR7JPPhko/BQjOFCAHkbyVyoqs3mKJiHT6VyK0zA==
X-Gm-Gg: AfdE7cmMyBGGuMMmiPn6ieSZlH3/qZsc91ulgIz5ccdtEBohGsGDH/nCZlcnjL8yRv3
 1iuKS/hoqtdxIfOUNc+01ixxRdI6t16+nGwZraOGSDIbnWAiI9o+qFPbaBYG+EyJiFaaBkwSdg9
 c8i7BY0m2tScO4BLiFhqvattHsjD2sjfEkSKTXSvGNTi8xAuYsumg11J6W1zjoJ5ltAVSIOH3Fb
 76vdWQPTaYxgLJOKelmPgFwIcl+QhYhABSq246xttZDayt1Tj+DlBI2HWMqczVbW9CU1xIZMzvP
 BEXSPF2Ijt4SeqLIk+qBwD6AQnyt2ERBwsar95+5KaE2mGJmrMDjYrHnkcf8ohNOp0uRAC/ax70
 E2qYCAQOygyxzfPlX44/NZkRIFXV1+8zKTtH9FYQ96teN
X-Received: by 2002:a05:6102:5088:b0:738:2a8c:736b with SMTP id
 ada2fe7eead31-73daa6997acmr2879182137.20.1782999373371; 
 Thu, 02 Jul 2026 06:36:13 -0700 (PDT)
X-Received: by 2002:a05:6102:5088:b0:738:2a8c:736b with SMTP id
 ada2fe7eead31-73daa6997acmr2879167137.20.1782999372987; 
 Thu, 02 Jul 2026 06:36:12 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e1c4e64a3sm1248036137.9.2026.07.02.06.36.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 06:36:12 -0700 (PDT)
Message-ID: <8b0736d4-9d8b-40d2-9e41-2bcadbfea11b@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 10:36:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/33] cpu: Only check SSTEP_ENABLE flag in
 cpu_single_stepping()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-34-philmd@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-34-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0MiBTYWx0ZWRfX7ivNrgRhhlka
 L/FieGw0Z6b++jAjfh47yTwfvjw1sOqqX9vPqkuXkk8FdSPyyCu3yWmChqx+S+oH9s35QeUEmT2
 xUM9BUj95VGeYAOhBJxdBInj1VF9M6n0Qe7oO2MdJul+Ahfw3AQr19Q62QMTAmKHA7TLgSn3MoO
 L9n6N2Pzi1JHBp2ZiHOyEvFVp2g0cZ+KA3yDpct8C20BW8WswUUhtAuaW083HB6WNhoCuHLRkCZ
 1TK0/VO5hexHeqSfNKPjiIf11EObq8nFseuvmf0nquZJ4TVs6TVsin1m0h9yVE9KIB6NYw3+LDA
 VNl9Jrd84I2Fa6xlLytLhJYNUBkQJ7XyvQJdNyUHpbxZAr9n+Gbtxr33NIS8qGUxaTx43a0Ucd0
 WxQXZSrZTZcDTCkpOlzyTcgu3Av/esDKio8DOIpRaimJ9586DQ0ly9OK9aqU4EgBTTFLFLzJVDl
 ZAOIvTL5KLcZhDr16Tg==
X-Proofpoint-ORIG-GUID: bI90o1Wie5mWkrwA-u2nX5uHMNyE_lZ_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0MiBTYWx0ZWRfX5+hE1Tw7Zezq
 0A9mi6IJUbcWbEOjZ27w/RRLLdVagiZB2i3LopHjUwVKTRV5FBXzacZWaD9bFG4qk5NHQBdGSPq
 Yr0k/RSa/0IZz3bmBweMbkDNXbybF8o=
X-Proofpoint-GUID: bI90o1Wie5mWkrwA-u2nX5uHMNyE_lZ_
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=6a46694e cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=iUIvgg6-mZ-fqS6SiIEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020142
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 6/30/2026 7:01 PM, Philippe Mathieu-Daudé wrote:
> Only the SSTEP_ENABLE bitmask means single-step is enabled.
> 
> Fixes: 60897d369f1 ("Debugger single step without interrupts")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   include/hw/core/cpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 27ee0e54327..d092ab8aa5b 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -1146,7 +1146,7 @@ void cpu_single_step(CPUState *cpu, int flags);
>    */
>   static inline bool cpu_single_stepping(const CPUState *cpu)
>   {
> -    return cpu->singlestep_flags;
> +    return cpu->singlestep_flags & SSTEP_ENABLE;
>   }
>   
>   int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, BreakpointFlags flags,


