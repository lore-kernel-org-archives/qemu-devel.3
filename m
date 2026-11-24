Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C281606A33E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K/fGYt70;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZF4buIG6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVvm6-0005y6-QH; Tue, 24 Nov 2026 14:01:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVvm5-0005xd-1d
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:01:53 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVvm3-0006aM-Ei
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:01:52 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOIXLbE2306250
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5XOiR9u3+rfv6OXl00b9tM1JEPzBxW8eRPbkqYeUAyE=; b=K/fGYt70ODOpJTBM
 wn1oEpXzlmc/9nFwYMavxIvke394Z7P9CFpJbE21HdJwMYVQhmoFdZoYVtXM5xkn
 122RjquJm/ryswcXvMQd4TAwc4TV4bAECWwM93ckq48zLKa/cSMAvGHgPMQrGm6H
 5+mqTDw/lDh/Wy/RZmT4fKyj65CCELl8yqSnBDszfMSn2J4gmyET7xWZPXF3Iuyk
 1tJjDl0k1QBPlqijZ5zED4jtEbUBLcZxqBA6sY83EUvixmqQAaRGvIoTPQVD5vV/
 B1hE4qhAbRGqFXmEV/rZAG4Xb+rMBiFXt/Q4IUdyP7fJKxvj8Ww+tZUJk5jCk4Pk
 nZKe0Q==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5cxk93bj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:01:48 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-67dcb5f084cso8626958d50.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 11:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795546908; x=1796151708; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5XOiR9u3+rfv6OXl00b9tM1JEPzBxW8eRPbkqYeUAyE=;
 b=ZF4buIG6L1N8Xcv22CzNNcHEREcel+71RzhGINsNptWeSkU4JF2e+Fac0q5mAVlALd
 KwXIczNNB62jPD+eW7/u6lq4mzv86zia3/+2Ygz4xPEk09Br3ktnd9JeoUs4huFSjcyo
 djxob4mzNu4oAo0Tnndhk3AxPfYNttpx99Va3A6graan2T3mUkkIRxrIw9XgBUrjcHaN
 e0v6jDN/N1EWLsCChCePL/FtfDhiRckK826+PAzQg/4XvRkuj5nH8kKsRGd605w/+Vxx
 /DCHZS9edW6dcf9PUkYeTXTD20QKD8Tal1r6+d6kTeT1bNZaLwtTudN5ADcSShWD8+dY
 mLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795546908; x=1796151708;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5XOiR9u3+rfv6OXl00b9tM1JEPzBxW8eRPbkqYeUAyE=;
 b=bPBby7N/CLLzaAIrRK4J3QIQsBJ92GnP17na6W9yXbVuKJ66y7ECkbDdl4XoN3vynP
 MA8KrcmphQSPwsYCw1Cybhsg7fGsch/VwvpXz4MrNn3gEl7n2R/coIKFgAqkp4musDiH
 IWpwYf86i/OUON64NLd7MM6L7jbBFTZSiB9pBuolyfF/JH0cN5YxIaYVpOzUQUz8+tW8
 EYsIQsyNZBzt/7q6/S+U7Ig9VQ3yzZzeOR4aHuXGgV+wKF9NUyyawHVgm0K18GU7A9jU
 5DV6Otcd64G59L8mhZ7Ek97Zg+q9VE2JdPK24Libhzz/WgTY7Gasuw6G2rNQLDwwyhXd
 yhIQ==
X-Gm-Message-State: APuU4Z+zG9i0Cm5BUf3fbnZ7wuT3POu1NR+7zG4N+tSqMPdQa2LPquIR
 Xvl1AddliB87wz4nQbOw/u1VeqXeRKVCwNBoz4M7bJfG+z48TupD1Xq9Mcf4ecV9I0lY3SSSbDZ
 JWDdqnTk9mjkGAZiKF5iwJ4VZjFg800OuCCH01QuGZww2lB99Wwv15RYB3A==
X-Gm-Gg: AZFdTZeCvFg8AmBc5HwCpK98Jm1knXK3GG7C9p/ZrurKMf6z2hmTN87TNWeUSiMmrKb
 Y6C/pReupg3oKfR+JQWlDZcOOEhR133XjHeIyw4L0YCZGKE56kY5ty8Lh/B/PN8vFTZRn3tP2M6
 RwRPMS7nj4S31eJBlAuffdPJlPcKHIkSarV6VFO07j4niN62U5xazSOfl7PZzYuIMlwuAZmyri2
 g6SEmh8YtuxRRUXzg3ihvn1f/YmRdySspCuMQokTkFgmFNXRubJQxZzmMN6sjAR4FUfnhmxCURw
 m1ybzg6gAP47aVvZacIw0YEkpiNPgw1qvCjFnQjf/S0qQHvpqeHuckpJnu2AuAfveeqa5/fQxqZ
 BhyijNWGaFKTnglBkuaon+qjjnQUQn0g8mLV1Y1k2ebphtNuWwRq7yhkjYSd9ppzDpp9/0ECZXJ
 7MeUatF8/F
X-Received: by 2002:a05:690e:130b:b0:67d:c106:bb72 with SMTP id
 956f58d0204a3-67e324d2738mr1462344d50.117.1795546907573; 
 Tue, 24 Nov 2026 11:01:47 -0800 (PST)
X-Received: by 2002:a05:690e:130b:b0:67d:c106:bb72 with SMTP id
 956f58d0204a3-67e324d2738mr1462305d50.117.1795546906960; 
 Tue, 24 Nov 2026 11:01:46 -0800 (PST)
Received: from [192.168.68.101] ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb34ac1esm1111995585a.15.2026.11.24.11.01.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 11:01:46 -0800 (PST)
Message-ID: <ff723ec0-8e8f-4537-adb3-94b1a5b51711@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 16:01:44 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/riscv: reject shadow-stack accesses in
 Bare-mode translation
To: =?UTF-8?B?6buE5Y2O5oiQ?= <1112433017@e.gzhu.edu.cn>,
 qemu-riscv <qemu-riscv@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, palmer <palmer@dabbelt.com>,
 "alistair.francis" <alistair.francis@wdc.com>,
 zhiwei_liu <zhiwei_liu@linux.alibaba.com>, liwei1518 <liwei1518@gmail.com>
References: <tencent_5AA0FF1F62236004454D3317@qq.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <tencent_5AA0FF1F62236004454D3317@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfX+64TWT6WQrQU
 zB7FxzgzgbhXUBNpmYmgB/sOVcvSx7goWbEKkEsQ0BcH7o4OAAl4WNoE5uAZaHLh9sRfwASukRL
 aU76OuaS3/4oKB9Y+f4Jvoif9IJQZRW3d4Y5Fv5iQggnygYBt9XTropk7y9Gxk6yfidnrurBksc
 9rSr4vRMC7Zny2jB9cIN4llB4jbyNAkjDfSlaa6SHpa1ZiMiB4UJ4dMqfL3DPqil1tVSuBxAeIa
 M9gYBSM927Ec+61yEVrSBW0PLZ/qsqB48vbBLpseZ/KxqJgIhQEw3z8qbJyENNKNSy+/NkJuz7t
 ywzxTx/hBoAFroE6Ib+tX/recEiLGnsA9eS9CX/RSxrVr3tPUEVGWZ+SpstXW9auSwi5/Rvqj3u
 SPDHu8L1i9MbbaefPg1YGw7yuj0tXeuSRpyX7gjt6W9s2K0RFV8aggIRNm1kBCTeGiIGrpMp2Kp
 SS4IATn+vlxT/QpTXSQ==
X-Proofpoint-GUID: QApU-Jxa76eJqznoAdj9RT3LHbYozJXX
X-Proofpoint-ORIG-GUID: QApU-Jxa76eJqznoAdj9RT3LHbYozJXX
X-Authority-Analysis: v=2.4 cv=TLbQ2Fla c=1 sm=1 tr=0 ts=6b05df1c cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=n683re5pXfxIVqmLlQQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfX75Z7afLlRC67
 U5dyF4+GsOkBV8dwbFdxClYrIUpFpj2WVaCk5IZdqueDOgotccbcDBcX5+FVVdlJa/6KYqjmuoQ
 YK9+H/H7x8R6c+utMZ0L9E9YLU2CWkI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240074
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 11/22/2026 2:57 PM, 黄华成 wrote:
> Hello,
> In VM_1_10_MBARE the translation returns physical == virtual with full permissions for every access, including shadow-stack accesses (is_sstack_idx).  With satp disabled, sspush/sspopchk/ssamoswap then operate on ordinary physical memory, so the same ROP+1 pivot as the page-type issue is available without any page tables at all (probe T27 exits "full pass" on unpatched Bare).
> 
> The Zicfiss spec permits shadow-stack storage only on shadow-stack pages; Bare mode has no page types, so all SS accesses must fault.
> 
> Fixes: 669b4867495c ("target/riscv: mmu changes for zicfiss shadow stack protection")
> Reported-by: <SENDER>
> Signed-off-by: <SENDER>

As I said in patch 1 we can't accept this patch because this is not a valid
Signed-off-by tag.

Moreover, we have a patch that already addresses this bug that were sent before
this patch:


"[PATCH] target/riscv: Reject shadow-stack accesses in Bare mode"

Cheers,
Daniel


> 
> ---
>   target/riscv/tcg/cpu_helper.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
> --- a/target/riscv/tcg/cpu_helper.c
> +++ b/target/riscv/tcg/cpu_helper.c
> @@ -1088,6 +1088,9 @@ static int get_physical_address(CPURISCVState *env, hwaddr addr,
>       case VM_1_10_SV57:
>         levels = 5; ptidxbits = 9; ptesize = 8; break;
>       case VM_1_10_MBARE:
> +        if (is_sstack_idx) {
> +            return TRANSLATE_FAIL;
> +        }
>           *physical = addr;
>           *ret_prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>           return TRANSLATE_SUCCESS;
> --
> 2.43.0
> 
> Thanks,
> Looking forward to your reply!


