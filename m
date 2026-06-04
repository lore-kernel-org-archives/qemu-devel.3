Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61776CD6E6B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 10:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV5Kq-0004He-Gv; Thu, 04 Jun 2026 06:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV5Kn-0004HA-Tx
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:29:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV5Km-0000en-Hf
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:29:57 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6548UXmb1132194
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 10:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hCEMa0nmoXeMWQ39pYbDDWNPAo0cXZ88r9IjHPuQF88=; b=DBbxIjoEr5Jl/W8X
 CTnd6kUyHV+FrkfX64nCENcTubdOGrM7BaAleS8z7Qx6J+uiL72nmC8uOnsGBfUZ
 7PTcoWlcU1ELxabsqFhuZb+X3pYRy20LqhBNRhxkJ43I4Dw0ov3YrAF8poRmq3kq
 /GT13rOGUlBDJ04nkZpcd4Gw8H5Pk0gqzcfKgmro5uhb9NQH+M48xC2G2m6N7hWj
 RvcuIvuuKujmh+OuKLo5U4dnOI/Kfn6k59nefzlkVMvvwBBmIe5V1tkPIDAQecuD
 XD/ZyDQDRPgalDKsc0TplAZzlYz8/hW1f9mkxPSkGgkSRsy8r2PddIRmQBqNnuwE
 FYkU1w==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek5wsgen2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 10:29:55 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-66040e3ec06so971663d50.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 03:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780568995; x=1781173795; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hCEMa0nmoXeMWQ39pYbDDWNPAo0cXZ88r9IjHPuQF88=;
 b=AuCurrfs0Z1+08JiShQERjGX0PG2iQ+LN5g2eUl+hrOxNjWE8uxjRUITJ0TEbShGZq
 lWVe+lhm6U7ddXGzzkVNOYgIC1pUcHd0Qm5qqnbmpi4saA/39mt+Gb7zThMteZbV/GSE
 0MTRVzMavTX4Le3cuOBEcsBrlfjANE5sqs01gl+RZ70oQJLeS0hq5yViXv7Lp7EM0dto
 yGcSeAEJM+Fh/U8xlsjvhvHdKNSIcNIGUBE6zkgTynPLHvtJ5HbQwzvz3gthazd4mFtB
 tljWIq/MHtbkWlxqSfI7P6J+za62nA+jFYZbwSf3dcwbGR/T81x8zK9gcKJcQc3GQ6j3
 Ugtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780568995; x=1781173795;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hCEMa0nmoXeMWQ39pYbDDWNPAo0cXZ88r9IjHPuQF88=;
 b=gQ9aBEAYdPQSz2HFCrj4BJEYDS6BwgGN0q+IU5t8Oe9/KnU71QvOr4xp/pDsPvjxxK
 onh2bmOeeyApzsKS4NXrkx2MpNBnjdfyUZK9/gIKNIiMDLLOMGDovMS42EWADOHLuIxW
 JqMAVYcXbM0DrdchUUqHW7294M2liFKFHuTkJdQsS9CZH5mlibsdSIoGDv5rEqnwJflO
 KoihewhOutrAI5tD34MS2EBAy6k00764ANnOgRudSTV2pymYtM72DyoMWgYlk5rz2CNY
 kAd95eZJpi6KfxhO+Jq7wnAnvhK1Mimd1m1Vvpn7XoxphutCxOQdKjXCYTTG7+vARHXR
 cZCA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Go30sPlMU7El1iQwxUxV4uphTh3kdASn2JNoL2Lb9OorW/rXa3pGZs4b8q0wKWn0g1AhZYeLu2Pty@nongnu.org
X-Gm-Message-State: AOJu0YzC4m1xJzT/Oo9QjPnDtZ6UKJuwx07Cco89jFEv689WA9fhncTj
 9w0mo1doRXSckTAqoFjBQePW82J3WAmRRxbpmmBe/rB0sZtaMjVA7u6yot7bUbmiYMhyLTYRVUN
 c7VILP/JgQq80cVvmT/dUtklwwwCYBHX03fGrZh1vjt2WEF7HQ3lAIKZgtw==
X-Gm-Gg: Acq92OHruG191U+2/XOTAlRAGjDoAtyccf3yHbbn9HiARV7mgsmoEqOUP8/iY8YJXO9
 9Yqvt07MiED4ToiDC0B94q2BLCDm3ZUdJCWnXXSphu0GL/zXmVAAgBNCdJ7Sl3RM/v9DeDyiSAa
 gwmbOypSGxrnr6xNl77xuJtHv+YHYkYa9xdb44EABIgBUQH4mqhls4+u+HMjdLNA+8vjvaVlOAp
 /X23knPVjS2oXLkzdAyG3bdtWi+i31ZbiCXY6m3P/8/3TiYe2CyNO0lH4Yr6/QnAQq6gqGWdFDg
 F3butq9gaTaTXMK/TyTI0+BwEblZbcGFDMNAqqKTaIo6xH65xfDHljuz7/z+hzdZyQU11wgZq5B
 oktYIX+D9m353FRj4VNHcpJJBMBGGcdmu1HqNa9sezIQTdarhJj6+hebvDBVV60EWZzuv
X-Received: by 2002:a53:d016:0:b0:660:689b:1539 with SMTP id
 956f58d0204a3-660dc5af389mr5944094d50.58.1780568994962; 
 Thu, 04 Jun 2026 03:29:54 -0700 (PDT)
X-Received: by 2002:a53:d016:0:b0:660:689b:1539 with SMTP id
 956f58d0204a3-660dc5af389mr5944077d50.58.1780568994492; 
 Thu, 04 Jun 2026 03:29:54 -0700 (PDT)
Received: from [192.168.68.106] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-660d6488b1csm3591926d50.19.2026.06.04.03.29.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 03:29:54 -0700 (PDT)
Message-ID: <b54d87af-3c14-4abf-97fa-40dfeaa99cf1@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 07:29:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/25] target/riscv/debug: Implement
 get_trigger_action for icount type trigger
To: Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>
References: <20260114044701.1173347-1-npiggin@gmail.com>
 <20260114044701.1173347-7-npiggin@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260114044701.1173347-7-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 8gzYvF1D3oZHYFIkYXvgARWHGY42e5KA
X-Proofpoint-ORIG-GUID: 8gzYvF1D3oZHYFIkYXvgARWHGY42e5KA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEwMSBTYWx0ZWRfX9INZ64b6ilao
 rWpOaajDQd1ULsW30vIgRhvyZGflwm8GKUkD3ZNB15qCptqoMpYxxSL4ghlIUX+flYkiDfb20uq
 91plmruyANPQSyRoTVFbHwVFmlNrlcstP2TWbGPa98fa8ePhlU4VlTHGBMz+ey+kMCjevtZZv9M
 UeEDTHkF0mdPIaYVnL8pkxJIsb8dkyGSgZp3g2lMk9kq+bSvwF4K87fHbWu4FkiP9cbMQTrVUyU
 wjf05h6xRJg0EU6SDYPHm46WfAIxkF8DXX0Nm25UyQBtmZzSjsC2NPhRdapo0uh7Ce/jisW7Cvm
 JNP/84WEOrHmtVZOqSNwU52dc86RACJssWqWXpmY1Cq+8eTUKqqrydssZ3Ve387od0UIUcjZjGS
 4AmP+pv07Mmb/ZHLjdiI18d4Y8z7QQ4blVBTIqtjNmvKJKGvL4ZmnlHmLb6SVhAosqWc281Oi0e
 mi7KpHFusCzHPqOGh1w==
X-Authority-Analysis: v=2.4 cv=POc/P/qC c=1 sm=1 tr=0 ts=6a2153a3 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=aLERe-55eW_5Fbas3b4A:9 a=QEXdDO2ut3YA:10
 a=uujmmnXaIg8lM0-o0HFK:22
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
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/debug.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index 51c5934bfa..af9c4e37cd 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -110,6 +110,8 @@ static trigger_action_t get_trigger_action(CPURISCVState *env,
>           action = (tdata1 & TYPE6_ACTION) >> 12;
>           break;
>       case TRIGGER_TYPE_INST_CNT:
> +        action = (tdata1 & ITRIGGER_ACTION);
> +        break;
>       case TRIGGER_TYPE_INT:
>       case TRIGGER_TYPE_EXCP:
>       case TRIGGER_TYPE_EXT_SRC:


