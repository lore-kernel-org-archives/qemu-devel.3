Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D430606A327
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SGHn5BWT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CW8X/JCN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLHeH-0005Gr-UX; Mon, 26 Oct 2026 06:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLHeF-0005Gc-Tm
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 06:09:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLHeE-00014M-5e
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 06:09:47 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q8xNCW1912088
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 10:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hM21uXi8DiYK8yNoYiYpWV0ZZNuMwIAuVUZNvRF7AjM=; b=SGHn5BWTXnGLgjLt
 m8ds01gQn+IvkJohV0SEtc2auA+kT/Um+LUznEBfK4J1cXTLqPttNyvNaPqcrcxu
 nI0bcplfcLDHGEO/25WZDiyHfa0l4zP5HVB6oXELEHwkfE7FkQUQwgriGBDMXd/N
 CPtgSfJbStNKDVCFcypiZIyxZBT69lM8BbEI2zkV/SZDuwOmZp2kGgqw+D0Nb9we
 lRrF6YFwYoA+QYgdU8VKHfuPSlOGCywpdFSCla4bN6lrOM6fuiFekaojlsf24Uop
 eOKPU3clgwMAgPFSE48NTyc2HWJMIFsAnujOxpbjsnlrRlJWlkqqjb2ilpcQLF3F
 TrPKmA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj3u608mh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 10:09:43 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so555895985a.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 03:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793009382; x=1793614182; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hM21uXi8DiYK8yNoYiYpWV0ZZNuMwIAuVUZNvRF7AjM=;
 b=CW8X/JCNjO/smVsJZFGJI2ph4vbi6DYi55TLsho7VLW3ZWgMUQd70hEbDK0V6WFk0U
 dhUiLUKIjWDmEmlTqTjnzQ1yYXUT62Y6mwvy/bGhRFu6B4aNyNmmcbFNW4TkiYw/j/zv
 8XOVdA9KNOhZY+kD7oxYo5zH0PnvHbl4/AIzYywbc3GFmJJ6Uhw+C3TWgHM0uWihOfAW
 x+7zZFb2DgQ+uEs3KK1v0681aN40+LVhzhX9Wjaip4EFoGJWlpsW5JK9o2Q6a84SHdGY
 JGZK40oapzLWJJ5ttlX1vPHfcruw/YqxQ8X7h8vEVLHrq/FKmOAP5XS1jx5nHiqKVhgk
 rR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793009382; x=1793614182;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hM21uXi8DiYK8yNoYiYpWV0ZZNuMwIAuVUZNvRF7AjM=;
 b=Qwi58B44gRbOP7OlCLaG0dUSEPinrBv7zWyarOzM4F4B50AkZHHH9lAe/2seXqEwbd
 8zxloL9Z4PaoK3lysTvPF0NNV5X0uF+wqp4fH9GYXmxW1rp44lkDBzmbTlAHCcN67U15
 JzUa0No0DQN1YPs74YdcTmzMnPN1agTvImdknsMBfOIzSO2gpGYE+ZmRKDFNTswuRacN
 0bha4Yp/wnB6mcqZBo+mTSCR3hZOE/n8FDLf+DDQlS53fLswSWMfu2FZHx2IJxcC6BT+
 xbMcNOhG7PGWQiYaPw8uVFjK07pwcqywZSiaL36QbeQwfEtoLGR4wgnfHTSPDZnPcKJg
 zltQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/dhtwDHNqPv2ctGVgpu162mQpr5onyvWEUIwoU5Pu3tDi3iZ2z0z8bZJc5pR4WnSxbc+T5HgyzI+u@nongnu.org
X-Gm-Message-State: AFq9FYK1+FKs4p8UkQBAr0nVJ8OhchiTtxaQfo6vhXBXHNQYUUBimG80
 /EkbRkFl+u0fZO+F0fwnVn3ofsAV1y67mxySFvocWavh7Bixv+rKvhcFQmfXau4u3so6Y6lGKb9
 M1uwM6Zh036rkCrMLSOJcdwF2jB7/ohdagaH0V++f/P2TUbX+jGIdjbDqsA==
X-Gm-Gg: AYBFou2T78FIz0dF+GpFaGZ+JHqFiIq+MPRELEtY8EGTTc7L77TndTJcXTGE+IBZhjo
 F5qJnnK4y0Au3nhVOhm06l211nBxSQLgADzAj6Hx3rRImfWNUxXwbWIdNV46UkwaQ4RfNcmo/Sp
 JkLWv+KyObu3IokONDPV0UEZxupXieEkvFN/v+T6IvDrVsxaYl5bnIk9/72nRxxjHJLCNk2C8/3
 0LDA0XvJxMp0+eg/jIS9joDVnEQvb+kuK9NNUQU5jD4D2BlNgBRJXns+9MX1Iijszwx/ItNNxPm
 jI6Fe68uWr824t34WDzs/Kkbc/gj0ePqkSqsGZH+EOBrCJ1ecV/IqtzC7c8mohdPcXDAhtUbwvp
 ESAkSupWni8CsanrW1Fs2anSRfIl8JF7lrA==
X-Received: by 2002:a05:620a:40d1:b0:93b:d7a0:d9e1 with SMTP id
 af79cd13be357-940ef980fbemr830044685a.59.1793009382122; 
 Mon, 26 Oct 2026 03:09:42 -0700 (PDT)
X-Received: by 2002:a05:620a:40d1:b0:93b:d7a0:d9e1 with SMTP id
 af79cd13be357-940ef980fbemr830041685a.59.1793009381645; 
 Mon, 26 Oct 2026 03:09:41 -0700 (PDT)
Received: from [192.168.69.230] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a0aa0bcsm230530515e9.4.2026.10.26.03.09.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 03:09:40 -0700 (PDT)
Message-ID: <b66ae368-b2ea-4ade-90ef-3150253bbab4@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:09:39 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/loongarch: Replace sys_state with vm_level
Content-Language: en-US
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
References: <20261026095922.241092-1-maobibo@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261026095922.241092-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oVlx_-1o3Bk-7abhwsrHULPyLsqYwJjy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0MCBTYWx0ZWRfXwZPqb9pscs6r
 s59rFOXzDmMQEg7othvDsEi/jo3ta3DCX55b6HIh+YfszD++zrs64AbBAM/1Xe5fT8DKllvtmkJ
 hIXjRVjOpRXFNDf82tJeQcrsl++R9ppbtV6gDqMa5Q6SWn45pm0z5jgEcJ3tAluIbvYtNljC5nA
 fcdJ9lirOW/G9kTGMQT5Q484Qni8ZksNu7dbrJKkEysWIe5rwJnJmsdTnjNzrSQ99/KpkwsfoYV
 PLWOzYFt5FTqjCxwHWYQ87FNnxgoVebgj94WRP5Je1cOdcrjD8x42xBNUh5jolJjHmr0cSewpXX
 sJMF8g9M55fu87465qCr2E9s+AbyVMgzyJtc5I3LonC5I2NCwWXRZvp7s7148Pf4DNTrSmwV/Am
 656xPqn/IUCpHdt+93HuFwCq68TVZxvekbIbFuC3nVqvWOJsuMlH9BXwLOeyuDcRhaFvmPRF9qj
 TnT+Gj3H1QbfYv3mZEg==
X-Proofpoint-ORIG-GUID: oVlx_-1o3Bk-7abhwsrHULPyLsqYwJjy
X-Authority-Analysis: v=2.4 cv=K823jCWI c=1 sm=1 tr=0 ts=6adf26e7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=5jOq-suRuZgmoMenesQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0MCBTYWx0ZWRfXyP+44yARrvoK
 7zO127qb2kwBB6Rcm6JrJZ2+HeDNyvITLRD0ph+ZIdQcmFPP2BuXvM7rHZwlPXsEnS2iWeR+ExJ
 CU6w7l89ScEmcCnax+mQCzGt1yyUuGQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260040
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26/10/26 10:59, Bibo Mao wrote:
> Int type vm_level is more meaningful than pointer type sys_state,
> and it is easy to get current mode from value of vm_level.
> 
> Here replace sys_state with vm_level, and use vm_level directly.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu.h | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)


> -    CPUSysState sys_states[1];
> +    CPUSysState sys_states[VM_LEVELS];
>       uint32_t cpucfg[21];
>       uint32_t pv_features;
>       uint64_t vendor_id;
> @@ -440,7 +440,7 @@ typedef struct CPUArchState {
>       AddressSpace *address_space_iocsr;
>       uint32_t mp_state;
>   #endif
> -    CPUSysState *sys_state;
> +    int vm_level;
>       unsigned int irq_nr;
>   } CPULoongArchState;
>   
> @@ -510,12 +510,14 @@ struct LoongArchCPUClass {
>   
>   static inline CPUSysState *env_sys(CPULoongArchState *env)
>   {
> -    return env->sys_state;
> +    return env->sys_states + env->vm_level;

Correct but easier to reason as:

       return env->sys_states[env->vm_level];

With that:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

>   }

