Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF73CC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 06:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weo9O-0004Hs-Ti; Wed, 01 Jul 2026 02:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weo9N-0004HK-0L
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 02:10:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weo9K-0004AU-SB
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 02:10:20 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6615lPhU133259
 for <qemu-devel@nongnu.org>; Wed, 1 Jul 2026 06:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iyeWxppY89wILBKU0wojRM+VOlRW78CF5V2yAd/n2Qo=; b=IQbrzYjVFLz7fDlg
 rxUGuuq3n1qUKtoQv6NMIMpfS6acpRKOqBjud27e9iSMGUZSEiYPgAdvvz8quqNQ
 FiPT6GQFcbZFWk7qv1mNqbR23SAQFIr3ER2Qi1IRMyf704gr67N4F/0cV2+U2OEv
 Sna5xxPoTkVwJde9ARYhSo2dpjUqICpb9m3jd4n/cILoTx28Cv1JHgDrgY1tj6Xo
 GfmVLMEhNo1DhH9YLtV8xtMM7X+OrAdrmr9/sbxO74qKt2AbWm1B0Jvm0iEsp9Li
 hp8cWTRwOvwOirWktweifvg8dB92nRl3/6mMVxnN8tlbkQ6rEcCZ8KMNY+kuy/MB
 HnLDmg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4rsy107w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 06:10:17 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-91931144870so39012385a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 23:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782886217; x=1783491017; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iyeWxppY89wILBKU0wojRM+VOlRW78CF5V2yAd/n2Qo=;
 b=VffV81Yinu/C+26tVZ4s/ss1n3munC7MayuibTXRHzg1hK762ZsKpSc2yhA219mxDB
 ZeFeyVl3bLD4IHpmbx9C0pO0jvbtd2ruXfE1JpfI4md3/iKmpRx1mVPyKfL5nXtssH/3
 MafHIzv1xPhquEFjla0VGmFThogkyqM8J8d6ZMs8nPjjVWPpYlqpJUa5Tlkdxhe5m9LZ
 Zd1JHa+7DGWRwaeCuPiV3nfRKTbbgYOuga87/tM7G5/Zow8Ma9ZXrqhEIiGonGG6dkx6
 8Y/JaKLF0IvYtFZ7y01Ut0GZVjK94Ec0LvEBzMqTVfd+7r/TbW/v64mfVt8/2/YeiOpx
 bRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782886217; x=1783491017;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iyeWxppY89wILBKU0wojRM+VOlRW78CF5V2yAd/n2Qo=;
 b=qX9qEuLEkUARF/sg3ICsDU+E5kTYeDxzkt89MJEe+PCV/P82jMay4xQdDLOyZt4RDM
 A8STVldsdfaM+iMMECrCz2yaosb37EWWC5Lgwa4aN28+rtQOfuq422xg4dsNO1uHJBfQ
 YwRHB3qvqcfN+4Pip+/I2kPFCPho9HegR7aczTwFput77YybDyAjP4TWxjV2VgA9u3p5
 yH2jNXbkMciyWuq1D+7ijz3Re9Z358V7+vLSMeE1GQVOPTA8DvXwzWyubQtWFjGvcUMN
 UuWlOt6IjfsFlIyUbHcnHjZjKoc2thSJel1ol9Se9R3IRIBe7n7i/PsSpEe4tparjJwc
 CgIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+RcIyuGbwoJ/ik8iv7VbSwOxJPWaFgExjVNejgScg45Du0paUhMZ5x73Qh67hOKh+qPAGgZ4KsT+TR@nongnu.org
X-Gm-Message-State: AOJu0YzjE5W/qTfUBQPU0tMMAjeZsVqKJrGNDmfi8d4nNd0sw7eZfzO1
 EZF4vjEREHEvfdmhzU0orxDMfHuroDpqWrBmE203Ptn0oN5F5cC7Wh0l/gQ2xHf57avqq1qVhey
 1CL3XKS27Vjxd5+Ey5MbI/sALYlfImnRS80E2F+zj6KLg9AAOAMOdJn+LSQ==
X-Gm-Gg: AfdE7clv/VALZW2VC0td00g9IMkZ8TXR5GHqeYQGQgG9wSu9YIVniRi0EmrRMVN9UXJ
 13ROLoY1LuG0anMzMiLO2Xq2UO85zHpn0Flhzq8QhCJYjGDmx0E/snnvHKZYrgAiD79/B0zMssG
 2Ub8RlB4ULtajV+O9uiqgVnwonvbMtT3AkfYsjrgToH4YTTmD428H3aOegL8gcpfky2bg36fUPy
 lQ0XvDUF7iMINO4Y0NF67/cP5B4bImd2A/YFJ2Zmg8OmuwYWiv0jkUb9jFSoyRtUyuAGn94KZpi
 ewFFtkTvXc7+b+fi6a/hLZo44BXIKjXN4ZjLP55XPyZvQ3Q8hLsO4Y59I+lfGZdDvvOuEhDtbPR
 h9gYZXRH1cAcuMaws83rJqAbBoX9twkwgBbt+iaDSO/L0geyhOtMgV0/jXqbyLA==
X-Received: by 2002:a05:620a:458d:b0:92e:2c3a:a15c with SMTP id
 af79cd13be357-92e78257463mr40606385a.29.1782886216673; 
 Tue, 30 Jun 2026 23:10:16 -0700 (PDT)
X-Received: by 2002:a05:620a:458d:b0:92e:2c3a:a15c with SMTP id
 af79cd13be357-92e78257463mr40603785a.29.1782886216278; 
 Tue, 30 Jun 2026 23:10:16 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4eee27sm47292835e9.12.2026.06.30.23.10.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 23:10:15 -0700 (PDT)
Message-ID: <a5d3aa14-4b74-4e0a-a514-a8dc23890813@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 08:10:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] exec/breakpoint: Introduce BP_CPU_ID_SHIFT
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: shivangu@linux.ibm.com, qemu-arm@nongnu.org, qemu-riscv@nongnu.org
References: <20260701030443.1382447-1-richard.henderson@linaro.org>
 <20260701030443.1382447-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260701030443.1382447-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: gbaEH5E2-xVpIyxcIONtQK8ySCCFhkyD
X-Authority-Analysis: v=2.4 cv=fLgJG5ae c=1 sm=1 tr=0 ts=6a44af49 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=0tBilwq7XwRVTi-M2XMA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA2MSBTYWx0ZWRfX+68lJG4RiEe2
 SMQsOrFw6PuDJQiT/KLA6Bp+VCq5OU+rKeTxNy/T29IW5Nklh5LuUbPrD48aDx2bvBPPAenQ4mp
 DewI5kQysGjC0E06T/4uu+cbHhTCvAB+Z/zC0rj/enzifixb2NLWajECTVjuUNJ45h1jwhuGF2g
 lxJ7BfIoIX78IRZ5X0sMOrian93m/LZLWn0MvbLKslIyyn1GUx+j95EnctxTfiEi16+uXaUXmcd
 ToaCSbcSgN4n52vBdoITqHRKqp1eEKuH+UfKIYnT7xRxj+ZFRwfYVqFeM2W+BWrYFa/UsWZUDOf
 154eVdDvDG2BY3s2P7tHl1Dn2q8qyxJb51tbhMFHPYjPU/3ntGBstC66UbKh5RHEEp3T4+CsVYS
 oKk81AKbag4htzGkFxmMmA2l51Vk4cfchfYuuKIN2Zpavl3bm60MHSNGZlxSzOYrg3gvYAlLaQJ
 UOyYlynQeo7iUIC3fWw==
X-Proofpoint-ORIG-GUID: gbaEH5E2-xVpIyxcIONtQK8ySCCFhkyD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA2MSBTYWx0ZWRfXyA1JTCR2nn8B
 PELdsg6POnX7dPgFBfa+brzfct9Eb/p1A9dy3kTD2kGcsmJAUWRv9ZyOwHGXtoCvo0GVDPzjfbn
 lngO+Y54pHrSlT3JvzVVHT5kOno5xN8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010061
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

On 1/7/26 05:04, Richard Henderson wrote:
> Allow the target to store an identifier with
> breakpoints and watchpoints.  Change "flags" to
> use uint32_t instead of "int".
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/breakpoint.h | 10 ++++++----
>   cpu-common.c              |  4 ++--
>   2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
> index fc91343875..93876f3304 100644
> --- a/include/exec/breakpoint.h
> +++ b/include/exec/breakpoint.h
> @@ -25,10 +25,12 @@
>   #define BP_WATCHPOINT_HIT_READ  (BP_MEM_READ << BP_HIT_SHIFT)
>   #define BP_WATCHPOINT_HIT_WRITE (BP_MEM_WRITE << BP_HIT_SHIFT)
>   #define BP_WATCHPOINT_HIT       (BP_MEM_ACCESS << BP_HIT_SHIFT)
> +/* Bits [31:16] are reserved as an identifier for BP_CPU. */
> +#define BP_CPU_ID_SHIFT       16
>   
>   struct CPUBreakpoint {
>       vaddr pc;
> -    int flags; /* BP_* */
> +    uint32_t flags; /* BP_* */
>       QTAILQ_ENTRY(CPUBreakpoint) entry;
>   };
>   
> @@ -37,13 +39,13 @@ struct CPUWatchpoint {
>       vaddr len;
>       vaddr hitaddr;
>       MemTxAttrs hitattrs;
> -    int flags; /* BP_* */
> +    uint32_t flags; /* BP_* */
>       QTAILQ_ENTRY(CPUWatchpoint) entry;
>   };

See 
https://lore.kernel.org/qemu-devel/20260630220100.1289-19-philmd@oss.qualcomm.com/ 
;)


