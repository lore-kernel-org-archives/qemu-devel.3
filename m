Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39302CDE004
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcM2o-0000dt-3J; Wed, 24 Jun 2026 07:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcM2c-0000Y3-Ne
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:45:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcM2X-0000IP-H4
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:45:11 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OANlkU2586224
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aURg9Rydjqo1qjZk9/UBXUGEZKeCe7brLhZ8ZDxQ7hM=; b=BSZpdC/3X9l1/Sva
 09/6gGb3eTW6RD7lez28Y4cjuouzd8j2XetJM9ZNHMZ7U+Ja2hvyfwYSi4vF0TiA
 MYU6dC6WTG4lc0kM97gw13wwYi8girriiu+CgJK2UttMU8IZkdKUTAcUPaKtsxEO
 k0pNgrOB3kBmWghbVKqoz0Puu346gyrjOo4yRg3tjrP6n4vF5y1TPA6863fOg1Ad
 fDVt1eJoARc0isnGBfrW+8a1+O7bn15v/n5iBUgznQVDozMb8VrW2qkV3VUuXd/R
 bdGDtYFnYWUeYu7cKM7WgD/Ebw/1co5InBQ4IlXXDrViYAv4zCGnymMR3Si5oRmC
 VysS5g==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f05aqa0w9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:45:06 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-139d0f4a9a7so1150078c88.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 04:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782301505; x=1782906305; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aURg9Rydjqo1qjZk9/UBXUGEZKeCe7brLhZ8ZDxQ7hM=;
 b=in0aUKaN+9r0ZRB+NmbdX56x0vJv9N/3bvqDssxwraKRwvWfQZkjw/tL3m8qDfvd+A
 oHiU6Bx/S9FVS5JjGBTGRdlxi3FeylVQfrdahLqhalhN73g2Yg8Bz03+32VeLE18UB89
 WFfN/Nq+NDhdUtEIyYVUi5+viMA5qeQWV+/Qp/mHUATcu1Edj/FQJV0Z/YVLTuIAM26f
 rS1se1FQ/q+m1+YzVhe6MzECWeSRJYD5J1zNYA/LQyA31dfRkbdwiDzG5aX5TtDZ2/5k
 QFedhfQLWFEynuSnIwOgjU1WFh7jmkIaO3YpOFAvqzGhIzhwKJptCynBW7dXD/XU1Jtv
 eodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782301505; x=1782906305;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aURg9Rydjqo1qjZk9/UBXUGEZKeCe7brLhZ8ZDxQ7hM=;
 b=omuq9nJ0WGja5RePPBmrFAiHy6Eg0qgESv0vN4qWtfO6mzNkRfB6bYQ23Vr/fo29Rd
 QLUNLOA7Y1yv8/cZhrpsZgc0D+k6PtLtOIckNUIbIMzjV6Q1dZ0Er2DFznVgWayNQlZP
 TOT0pIrVs/lSpTGrYep0wnNgDDotv3NzHpLlnWcc0e2v3FBgNTIc4CZO+WyAUn3eX3Je
 MHP+VMCpPIJH55IEwxc3MA8U4vvGvkCrCZGhbVPcG3lOrYDaO2vIWcPghFNn27K35517
 mkZL5jKtdkLsel0y0b0UkdxbFpIBulDncB97bA9Ebsx0ozWXjtR34fr5urtOZAGhv7ga
 mRUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/VT4fpuDv3qjRu5kR4gDYDZzJhO6fK5cGvE8ctATQfqwTump+K3nIfcTMJNmcDUrb+VXGf2aXZKsNp@nongnu.org
X-Gm-Message-State: AOJu0Yz1WfR0nAfbDsL2Z9NuRhQ6NC5SU51MeaF0CDBb+AZvDIfMa01X
 tLfzQBZ1MyeFwX13RgJLiK5b+M1g1G1nlvGJ4JVuNFo/dXxyq1OVUveBAsP4tTTvb/6rrhOLS3g
 eMyIlJ/SqmzcETxlTXtFHNfWrogtnuJn8IthPaVpSZ447PLy1IzwG/rpsBA==
X-Gm-Gg: AfdE7ckXemVhebkCmJxor6icU7/bvEryr+ZUcXxc65ZAlC3doQQz1CSE7Cc1o8o7pMB
 JmEL28plXk3dtvcBGr6xPjSWgghmNZ675igHEy8CD6JlVmZFfvWAhidBufDQJm7OuNuUndhQdxE
 ECmohYC8TOXd8noCiCoZl2N1GcfF4hjgG17SNK2ZgPXfWTzH2pnTsXjeFp/3uyELMPO9PUp9HNr
 hQkgy+gputRL1DxOGEBCS5vgnT+3kLv2LrX5InROBtVlxJ1vM/a1GySk+0Rt2jQluOMz6NmG8wK
 LECmOa7rgKjHd+ZP0Kiwn4wMhZqoM8M3lyflFv3fSa5sKQbTgZ9Nhx73WKb67wDR8Wqoj56HD4A
 ecZ0oErHWEwhYi0kFZARfuCzfsb0AyESKPPvCGsi2o4fX
X-Received: by 2002:a05:7022:239a:b0:128:cf80:deea with SMTP id
 a92af1059eb24-139d0bf341bmr2136416c88.1.1782301505401; 
 Wed, 24 Jun 2026 04:45:05 -0700 (PDT)
X-Received: by 2002:a05:7022:239a:b0:128:cf80:deea with SMTP id
 a92af1059eb24-139d0bf341bmr2136398c88.1.1782301504852; 
 Wed, 24 Jun 2026 04:45:04 -0700 (PDT)
Received: from [192.168.68.103] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add5bd68sm21667597c88.11.2026.06.24.04.45.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 04:45:04 -0700 (PDT)
Message-ID: <861851aa-b3ab-4dd1-8edf-dbeb008750d6@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 08:45:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Generate illegal exception for inval.ir and
 w.inval in U-mode
To: stephensportia@gmail.com, qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Portia Stephens <portias@oss.tenstorrent.com>
References: <20260622224534.1923407-1-stephensportia@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260622224534.1923407-1-stephensportia@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA5NyBTYWx0ZWRfXwzrW5VyRXnZw
 lXo3ciyIQmahO1MRH2hThESnU++8X69aTi9yG+OzK+Kco3GIPuUHcRW6/L/7JwPURa4LnNdoofL
 Tc91i15R4v5RZu3T4HJUlsqArvY/+KY=
X-Proofpoint-GUID: cQ2uoqKvplq42KnwwM6XwcPvlg_dTrSv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA5NyBTYWx0ZWRfXx62bfn49idoc
 s2mPOBbmtBtFeguOwNVcI5VjRqhIfP0BxD6Nse4DnJq35j0wp8fShksReYprEJGU7gxUwZuFcVK
 xdnfbXJSsP8uXJPtk6YYt/r/pOMSP/kF635ENqSU5NH1l6dC2OF9uA7Dl0CLrAeydnWhxSldSDG
 0SyV37wjZ3xZKJcaVzoTyaiFanDa2GWxHxbuL6JE1e4mGrikCq/UKvfDKRWhtnMUUSzj2uRbNEm
 iv+SuWscV4K59aE+DEfQg9r+h0rrrFnvuz5MHYXMl6Sx4AJsPAwzdoVbCkKxMidP+4WchXM7TRE
 tx1FNjE+JZatuGverXhCDn/wHh9DbRNgdZ/EZOi0jknPtp4Fusfb6gnbyI4qomadHtmyZG2GVTm
 CBAmy4Z6rJgtrXqIpbrOSgxylKdkbA==
X-Authority-Analysis: v=2.4 cv=UphT8ewB c=1 sm=1 tr=0 ts=6a3bc342 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=t9496tuAAAAA:8 a=QYG0MOca-knv6KCjgzUA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=4wQ91nGE5lQcD7eh5OX0:22
X-Proofpoint-ORIG-GUID: cQ2uoqKvplq42KnwwM6XwcPvlg_dTrSv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240097
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Hi,

On 6/22/2026 7:45 PM, stephensportia@gmail.com wrote:
> From: Portia Stephens <portias@oss.tenstorrent.com>
> 
> According to the priv spec "Attempting to execute SFENCE.W.INVAL or
> SFENCE.INVAL.IR in U-mode raises an illegal-instruction exception." Fix
> the current implementation to generate exception.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3543
> Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
> ---
>   target/riscv/insn_trans/trans_svinval.c.inc | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/target/riscv/insn_trans/trans_svinval.c.inc b/target/riscv/insn_trans/trans_svinval.c.inc
> index a06c3b214f..10cb9e32b6 100644
> --- a/target/riscv/insn_trans/trans_svinval.c.inc
> +++ b/target/riscv/insn_trans/trans_svinval.c.inc
> @@ -39,6 +39,12 @@ static bool trans_sfence_w_inval(DisasContext *ctx, arg_sfence_w_inval *a)
>   {
>       REQUIRE_SVINVAL(ctx);
>       REQUIRE_EXT(ctx, RVS);
> +    if (ctx->priv == PRV_U) {
> +        /* Set the virtual exception if virt enabled */
> +        ctx->virt_inst_excp = ctx->virt_enabled;
> +        gen_exception_illegal(ctx);
> +        return false;
> +    }

I am afraid that the bug is already fixed in master by:

commit a4a35544e43220657f718a5d0be5ab49c6129000
Author: Zephyr Li <fritchleybohrer@gmail.com>
Date:   Fri May 22 11:31:44 2026 +0800

     target/riscv: Reject Svinval instructions in U-mode


We now have this macro that is called in all those insns:

/* Test if priv level is M or S. */
#define REQUIRE_PRIV_MS(ctx) do {          \
     if (ctx->priv == PRV_U) {              \
         return false;                      \
     }                                      \
} while (0)


That said, your code is setting virtual exceptions too.  Feel free to re-send
this patch enhancing the REQUIRE_PRIV_MS() macro to do the same.


I'll close the gitlab bug as dup/already fixed.  Thanks,
Daniel



>       /* Do nothing currently */
>       return true;
>   }
> @@ -47,6 +53,12 @@ static bool trans_sfence_inval_ir(DisasContext *ctx, arg_sfence_inval_ir *a)
>   {
>       REQUIRE_SVINVAL(ctx);
>       REQUIRE_EXT(ctx, RVS);
> +    if (ctx->priv == PRV_U) {
> +        /* Set the virtual exception if virt enabled */
> +        ctx->virt_inst_excp = ctx->virt_enabled;
> +        gen_exception_illegal(ctx);
> +        return false;
> +    }
>       /* Do nothing currently */
>       return true;
>   }


