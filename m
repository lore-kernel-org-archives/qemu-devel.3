Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0465ACD6E57
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 10:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV5LD-0004nz-M1; Thu, 04 Jun 2026 06:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV5L4-0004at-02
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:30:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV5L0-00010U-IY
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:30:12 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6548UWBO1132186
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 10:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IwKWk7HK8RzvFKOSUN3yns8Atz0EDVuDpIIcb+R3WuU=; b=Y0gtfBKRFByyZ2uw
 QzVVmPoPz/1G7tuBs819j09vwikEow0rc7GS1uFm/EVFP0ImvleUkKc3MjYrg4tH
 I7/5R9cvuwvKa6sTAs0Uoc8R2d8j7dKY7XpJ9T6gfv+waw7sloc6artr+VPCeIco
 aZ/0rd65wew8mlkXbxqQh3RVMQvJnyV6rqI9Q8DqaQbQton1eNlstIwhSsJqVi7L
 FOtj+kQBDP2wWIFCeYPh4pa0puTkUK+F0EV+7Pz9GLzAbT6pDlkq7LBa6awMBftz
 W4CJxts3s0I51DWyqXqGM3JQkKb9cNDRsB2ZDeuob4CFxmmYAY44Yy5/CYDNjFEs
 hdfVtA==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek5wsgeny-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 10:30:08 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-7eb18546ec2so6567507b3.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 03:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780569008; x=1781173808; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IwKWk7HK8RzvFKOSUN3yns8Atz0EDVuDpIIcb+R3WuU=;
 b=kp2QvUdBAecNXsKBExyTwz69tv9dl6oOCSP6o0v+Cwwbt8xdLWhh43gc5EFI1a6vl5
 9M0FnaBzhaUWiSQ/XG3ILZMVSAeyGexqtI5gErxnEw2nrQw9EjTLNFRd37inyPISijYJ
 Zq8p/ajgULc+3mSGzmZcFMzNYvFsNfi7xnEyz3bON/c7hWNzIkGlbWp8K2FhVjbjJ5i9
 ok2Sud0uIWmhom9FfCdTjdRpP+QQhy0q3xst2VR+PFkK5pxbPE2Heju4oPRC64iLMSrc
 6oS3gWqaPJVFx7Of+esZrxXwd9FAXIQZrSeNdTDUIztaXS38vgGk5G6E9W1xCa3RXpgE
 Gw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780569008; x=1781173808;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IwKWk7HK8RzvFKOSUN3yns8Atz0EDVuDpIIcb+R3WuU=;
 b=C80B5Tyz4+DI1u555O5n/gWR8FLa+++Xn/YwGlkqav7uuDSkZ7e2H8C1lHwroNKWuo
 FpYrYW6ISNI2lPn7JzT8Hhko2Q297KQPhA4/BZAmcrylX7v2mBHECfGA4ERuO8t5MLvW
 GAnIx9neKa1DfBaN83Z1O4d09SGEIMPPFDFo04gQ70UQyAUSpO7PBkKUeTsqn9M7jRhK
 f4Jl+eK7gCNH6qFpGOfM/3okIVTBYSa7hzT60k1hVfjwQ5u96HbW4JaJwT9RO1Vd/sWU
 60b37rTlKkBWc067m5AeeR3TidS7zU2fkd/fzJctilRRUuthmHqaqqT1P41xF2GBQiuR
 S+0w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8SbhXiBMJCWOw+FInxUvjwkxVjAi8hTEeKvGN7HCnVZxCvexzupPxRzAJQErsxI5R1wjbRCCx/0VyS@nongnu.org
X-Gm-Message-State: AOJu0YxiavOyHuFETZd+ybl30gaEfNW2vn4S0kBBCzgk/5UQgjM90X9l
 F6EebmIBrlHi6YkeIgT+GI23wfdZbdoOzJL7eM/Jo0utUF07yjE13aq+4bFvQMKIsVywF718xiP
 PlGdzyMbc0xUmewiTbU985AZxiMtM0nr8VXWODTsBBbzmka0odiJsmBIjCw==
X-Gm-Gg: Acq92OH3kI/h3ayPuweycwBPYesvsNidCtXxYzp05uBejKG2isYsW/dJD2PrgC1CchU
 J3KaBYJRIln1iQmHxHIYgJvnrtHZWyieLxYldXQsPX10cIi9s14tjGmYh+7DVx2pY3SGvk1y9ty
 CkHCbnyE+veIqRlCIbXZWW9pJNkqM0YMvhrcWtf+R2UIrAp7M2TlsxWvZ+hK9PovwfQIK4i3HxF
 IF5EkuksGtj4sIIfks32jZfhWRdhp6gOLdrV9FuNOMZRKZZ2BtvQ3nVSdyzhD512Cl+BapL793O
 iqpatKwqbPqau2nxUHlYwKWFvxZWAYHtdgAuSI4TvTaF2QD+NXmUf8Z2/wLFZjpVuZ+ckAij+/a
 W7Ml7r6CSbi6j6VOYj+pGWdht6A9YRrsvoyc0KC1B5DFpW6HiMxZwgsezY3839t7dkOBM
X-Received: by 2002:a05:690c:4b81:b0:79a:6249:a046 with SMTP id
 00721157ae682-7ea4720ccc5mr62274737b3.9.1780569008203; 
 Thu, 04 Jun 2026 03:30:08 -0700 (PDT)
X-Received: by 2002:a05:690c:4b81:b0:79a:6249:a046 with SMTP id
 00721157ae682-7ea4720ccc5mr62274497b3.9.1780569007678; 
 Thu, 04 Jun 2026 03:30:07 -0700 (PDT)
Received: from [192.168.68.106] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7ea2409db52sm31051137b3.44.2026.06.04.03.30.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 03:30:07 -0700 (PDT)
Message-ID: <a82746fe-5c7d-4daf-86e2-6a477f55ff3b@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 07:30:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/25] target/riscv/debug: Fix migration post_load
 icount_enabled() test
To: Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>
References: <20260114044701.1173347-1-npiggin@gmail.com>
 <20260114044701.1173347-8-npiggin@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260114044701.1173347-8-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Ra7dxvR1bW-JfMIHsuSvxcfjDg9TVDnd
X-Proofpoint-ORIG-GUID: Ra7dxvR1bW-JfMIHsuSvxcfjDg9TVDnd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEwMSBTYWx0ZWRfXy73X/Psu3+tZ
 tVOTVA+RZf20O4sAf7qkASz0wROJlL7K5H/AytU7FfNrEKp0pii0ajBIsxi+fSIIHj/WQEvjrYU
 0JtRfMmdDNwLLsDvmGOeDQmEnQinTdYV4ZPrE+YqJvFBWOgEcqIulYqmqhd2b2jdQWjCclLIhPP
 Ai8Cm0Rcp8dD8DvJ64PF4m+DQm8xd53mvrwR61aUbv9HrU3wkVvF3TdQ/z5x2BCFeYMIe+raPvT
 XOsaiQTfqJFmW9GA5/qk4mTLEWMLpHSTqO5pQilhZt21lqpnYG0OttB0I7wR+ERbJU28IFtLfva
 6E8n0TCkex3zRv+mQrokZo6/Zl1l7iMbYJdkVVexh4zI3FHrYrajIK5vbfasrC86RAnYbKEB+/m
 +D6GzVNKOxn9W0R6KsIGAmGntrZkhxcWJDfZXOKgyTDLWsR4Vf26WWDslTXWwV6If2XMY/8q00p
 kYYsnkwYSIwfSuuXF0Q==
X-Authority-Analysis: v=2.4 cv=POc/P/qC c=1 sm=1 tr=0 ts=6a2153b0 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=aLERe-55eW_5Fbas3b4A:9 a=QEXdDO2ut3YA:10
 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040101
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 1/14/2026 1:46 AM, Nicholas Piggin wrote:
> itrigger_enabled is relevant to the !icount_enabled() path, the test in
> debug_post_load() is inverted.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/machine.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 09c032a879..34fd73c920 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -230,7 +230,7 @@ static int debug_post_load(void *opaque, int version_id)
>       RISCVCPU *cpu = opaque;
>       CPURISCVState *env = &cpu->env;
>   
> -    if (icount_enabled()) {
> +    if (!icount_enabled()) {
>           env->itrigger_enabled = riscv_itrigger_enabled(env);
>       }
>   


