Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8056ECD6E6B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 12:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV7by-00089L-7M; Thu, 04 Jun 2026 08:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV7bt-00088Q-Cd
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 08:55:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV7bq-0000R1-HG
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 08:55:45 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654BKRIR011796
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 12:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7ZE73+1U9vT7hklFxEDRaDg207uF+yiCvzXHo41NH/s=; b=oI6zYvG/k/sQoV2u
 9RQXQapYXKUOu5kMBlNuZNALFhgwIthX/XZ8EzB5D/nHnZPxhDz2CI4GSPQUYKUF
 DNPiKvrQIDXusA8HAdse9D4XFjIFU0ugdQfRKCLiFvhE/6FDrOSDfwN4uIBkS4Gs
 30o/TDZv3ZXtSZJZtn53MKPHEah8ClkMKEW/3SIg7wq3jnjVZXAHTp2uEnqUNn7c
 8nucQB/+E2j/WMa1DcWXJ+HbzguyKmaCx7jH4bRfL8uHgAfGY5tOUfxFvZebG1SL
 U0jSApilT863fFJQg2wIQs22ukgotuGbZwUFrZd24wKxK/EMsaTuqCa46KmrT7cJ
 dpI23A==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek8dc0c0q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 12:55:32 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-6607988ca90so1172003d50.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 05:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780577732; x=1781182532; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7ZE73+1U9vT7hklFxEDRaDg207uF+yiCvzXHo41NH/s=;
 b=JuV/IlH/YWSZOuC3Tdsuoe0PdD0XQKgg9CwWwZcsXfrhn9Vb4tZLnxQ+Pbgbm9qN+e
 VrZxu6q6mXZycQ3eJVe+LjPo3XDSUGDQ2X/koU9pdR70oGCsV88O7L7GTX41rD2p2jLA
 YuQxmPZIUypAyPAdi4SjTM1FZzhIqeRg0bbNmsleu5vsYptiaRzj5cDeLDPzy3rA5VV3
 BZMV6zsd95CFmrihzCeYAlYHdqH9ubrC+1ni7KZK+f9gJtmo9W+uP/rV2GXpdaK3KZdm
 nJVoFq+XPI+euAVRlEm7JvhzubmcKQQHEHh3FfuNMtf/tb+E/czpcx/md/jHGHS2tluv
 nImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780577732; x=1781182532;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7ZE73+1U9vT7hklFxEDRaDg207uF+yiCvzXHo41NH/s=;
 b=GuudZXnjeDQ2vLVTnMdYSeQkvInKF6ob5crASBCzwvgZaTUBE7fg3yuJwTvo6nJlSf
 2eRdXl3gjjXRTyjCVV8cnG6s7EtJeKWHa/C+RG/T1p2wOIMpVQR3VixklTkOACk4Gyk3
 MjFplk7eWfZzxemyWmLkb4LY3hn9IUGWqwuyf/JvftUSJXIwIfeSPnGloFjOlOZn8ukg
 Qr4fr72jZrZSQ9qMMSFOEVUIQLYZhzP4c9FmWpnvZjzlgA1++IpSOJAUYVDt4NI+Y7R5
 Hs8xc9jRYSJgnJGJaAufy7sRLCdWa3bsHH1zPC0IhMCciGMuAw0PPPcFooqBh795RWl8
 drXg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8iJgEwNTzNsiGHOUnvsgKGBzTouoF2jXAvhXR20ahBaYKXKowZgFAHqmvDxwTtcjtbO5LqDhGwsUY1@nongnu.org
X-Gm-Message-State: AOJu0YwyRu9czck6/JA3NsmLX4yOVaoy0AYlQOtFGFkFy+5GP2rCMF8Y
 nPP4bdcjxgkUokKJIEvNdCQFY87s2PoUspB9LG3OOxG+C5zKWbCo0CqJSNLhaS0ljgbOZLK+mZ7
 xXYHwAVezHnNTVyiIcAAcsXN+gA7zT54PttHmcoG2BUIRU+mcg+kSDgzGJQ==
X-Gm-Gg: Acq92OEbSLeQ6TGn+RFpIo2rqshzg6JSEh0/B9RFidaBNnSpIR6aJiH/4z6qZZR/S6z
 kah2W0wsfqoXKsltNATy6QMcMwNZYpbqMUJefvNG3qi17gjOTgIIAlB0VP7mxefo5I1ep/pTZAI
 HU3aae9hlXEwoBBZXFuyMFgZh2/5jNo73ynJwwtv8Ms7YWVTkcTfK/cBYzwNJozqw/JfiKPgIaX
 jR4N8RgyGxoUzQKI33Me5/T92zrxpzQ+pjMgReAh82C2jQpBa+Q6GL/YhT10a/YVMrhkglxz4w8
 P+ON46I13/s9MTBwF2ns50ZNkPC58/deqDIWmYsMfh4n2H/svhBUhliGWiteLDB7uEWQzTiqwDg
 5/LgAoH8ki9LLPd/xlVpDcSmiEbu4BgI96bfwSijpbhQ78ky4BwjHI0HpNOiuFNWiEo5f
X-Received: by 2002:a05:690e:168e:b0:660:a41d:d180 with SMTP id
 956f58d0204a3-660dbbb0e94mr6705456d50.21.1780577731987; 
 Thu, 04 Jun 2026 05:55:31 -0700 (PDT)
X-Received: by 2002:a05:690e:168e:b0:660:a41d:d180 with SMTP id
 956f58d0204a3-660dbbb0e94mr6705429d50.21.1780577731434; 
 Thu, 04 Jun 2026 05:55:31 -0700 (PDT)
Received: from [192.168.68.106] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-660d5d1600dsm3754967d50.0.2026.06.04.05.55.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 05:55:30 -0700 (PDT)
Message-ID: <4f2a6b99-b18e-47be-94cb-267acbb4b5bb@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 09:55:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 17/25] target/riscv/debug: Advertise icount trigger
 type in tinfo
To: Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>
References: <20260114044701.1173347-1-npiggin@gmail.com>
 <20260114044701.1173347-18-npiggin@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260114044701.1173347-18-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: HU02-O2xFujaeAzcZr-RhWSuRvkmNx9-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEyNCBTYWx0ZWRfX27/RTGs9G/7K
 ZwXU6/A64q4eiXC7ulNT2fWm0cf01cqqOxuWaQ81yzwAfonjygstirUjUdwy+j/7pKdujMRwJFm
 atBp2kncKC0sMIgVao+74qkzoaX5M/d0GxZd4a0ce3HSsvkdMVgJJWl9KEX4IF8wiGSyuUwlLcH
 T/vOD4n1IDjLygv22CNMMALPbYp9oUk2yyjSkwv/Y1qyOCySVs+Ue+4+SVxp10YZKkMTeW0ucy+
 BY+WCWX29SOE59EOBCa80vqs42zm9Z4eM2ZHWXoJghKZxszst8pSznbIZg2wZlQ6sSAqKWf4sXa
 DKlIN4gqQ9hCygdi+6fJshHHQF63Cv51vyD0j4tEVGo+k2KYP4A9UivIhz3FhtFHGXGzekBNPPf
 4M6UVqc2IngIoR/4rig6akL4jXXAQVnGo/6r5f5YFJGHif8PqfyONnfJp0six7dhIX7Iw9nAh6O
 A2yR6LPRSbM6cdvGpJA==
X-Authority-Analysis: v=2.4 cv=eJwjSnp1 c=1 sm=1 tr=0 ts=6a2175c4 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=cH9IeIkF63hR4ahU3LoA:9 a=QEXdDO2ut3YA:10
 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-GUID: HU02-O2xFujaeAzcZr-RhWSuRvkmNx9-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040124
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> icount triggers are supported so tinfo should advertise them.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   target/riscv/debug.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index 69e7037fac..605ed95b14 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -865,7 +865,9 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
>   target_ulong tinfo_csr_read(CPURISCVState *env)
>   {
>       /* assume all triggers support the same types of triggers */
> +    /* XXX: should we set 1 (version 1.0) in the version field? */

For the 'debug' flag, no.  For sdtrig and others, yes.

>       return BIT(TRIGGER_TYPE_AD_MATCH) |
> +           BIT(TRIGGER_TYPE_INST_CNT) |
>              BIT(TRIGGER_TYPE_AD_MATCH6);
>   }

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   


