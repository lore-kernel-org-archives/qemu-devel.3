Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22322CD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 11:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV6P8-0001XQ-4w; Thu, 04 Jun 2026 07:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV6P0-0001U5-KE
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 07:38:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV6Oy-0000Up-FI
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 07:38:21 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654BJoRe944402
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 11:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KdGrnDU85/Gp8A4Y6rDYfemrSoy+zFmAw8U7j3rLZss=; b=aL64DzInSksFjuSS
 iHn2v+u1CaAkA9T3nCaELzsHQ+msVffUHyygbj2Td+7P55sUGbWPG/D9mvU7THJU
 tD44Z+IXJwtulPTrJx3BbroLiI+bpV/VHCv0fGlZha6ER20CwL4fKbOe77GExRM9
 6P0tFST+fi+PvqZlf17ia/Ve/mTLdvgqX8kJqSMHXv0EeQNse4j5YNqv46+m29wI
 R9XL2mG3ksXyUGzfG4KKhf+CErH99NwymSAyBX5SpCAhvOhvPbJV8vkLsKyb0uES
 hwmZ0iljiHAEquw+lP9w7G7W2JwgGu/aVYBug8vbpSf51qxWMTOvKHjsNq4Xe/t/
 YyMnag==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek8d5027v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 11:38:18 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5ab02fb3054so119992e0c.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 04:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780573097; x=1781177897; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KdGrnDU85/Gp8A4Y6rDYfemrSoy+zFmAw8U7j3rLZss=;
 b=WrUa1CbpVatl8QcObEvu+QL3kbpZk3zoiAb8wTZCYRu0DepsIN5PIksmHlNNTUVH43
 sZU5Fpb3Uuyvyyr/GCq6CHEcLAVxO8/hzivjyFl4eNTYq8Znx8Z6L2Vhzgoxx82pTjbb
 1VUAgJM09sm3kqB6C0e8sCF3WGGiFrkHCQ8rWiMkylRdpZ/xMmVjRF0t7tW1khC8EH0G
 GmpJ1yayYvHXkcIDqO4H41To21GBKihxvVtQaFtQ9Cze4Ht+y73wt5obyW8f+n5Ij02z
 z/ABA8RUij/xvQ/OOKox5k9BzkefxpAzDFLK2OSqn39zljbdI6it0kXaJADexSuBUcs1
 4y2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780573097; x=1781177897;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KdGrnDU85/Gp8A4Y6rDYfemrSoy+zFmAw8U7j3rLZss=;
 b=jjwZ4bSr2cq8+DUnx0MjUTjgXGi5XLsSng7ePqlBwU1YvQMyvKGlZP9M4V5xSL8Zpb
 +9DafdtGciADbN/cYZ1G9VeOx4LYo/u1GWkNuMSMhcCEOq0j02NPoQJiDBJ9gE89chI3
 iYX2VrdH+GKH7UVKmgJfF7XqbIPluSMkwicJ1pwZ58na0ze1jJ5FuR+reOdGSNUFX0P8
 887iNHnXLdXhgQvawWCSNq7+yCSrzYOHzoeOn6Ju7cbxCcGKREIvdqV5Wczq7QVNzDFR
 jjcKLC2sMuEXqRBfN+im7u0A88ueuw3ynNhupAcGxF3A04OVkh7gJhA5ZJjefas8gow8
 oqOw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ZILXVQBG5BSMRTHPL4KOCbyW+AXGD5FHcHhH2OZZkLGYiEDKDhVEst9HiX7+ufSCaRWONVNlCQmUK@nongnu.org
X-Gm-Message-State: AOJu0Yz7dFEZnSMGXV3O8DTOyACxza+vubaGX956wzyNIXn25y78hsHR
 R4k6aovlGtSwiz3tMLgLR1EACEGfvf059UE+z0qFyy7Z8snfEtQW9kRGok/J/uhDmdraHnlLUnJ
 V0DO92hhx4Al4xLDt+vFHQRd7mUZL6kTrnL2Vn7LEtMe08G8R21lBHvX8mA==
X-Gm-Gg: Acq92OHmP6wk1Y7T+GtXCV5iXxvBPdIkRgkGEg8WWNGckpTx/V8g7rkPtS3LBUHli3F
 I9LA7zKHR9c91yrit/hFtgCsOEIfXSy3gAwoE723DayGnsEPPVgvscYF5dRqWlzgo+ZKJxQqtHU
 XJQo6oBwheeL+rnyt7NG4taAfnnJBrf8vuzxgsRkSGWDkMyjbRF2WpEJcnh2HzH4mc1lH0BUf5M
 A+U14pymKQ0i1r6WYMuAm8/ZJcewtXJoqcTRHwfyp2UP1w8xJQ8+kfCUi/6WRK/u/X3s/3a0era
 gYIKNFtiE+2lSIUBi5R9wBIm+04SHQN4412oaahEKqERE92ldlnnsWImEtNoJuDN1BHE/mUWel5
 JmmWB7zadkB6/qSwM4NANjFG+26MjezQIRTLgaIrNTJttHzHHlAvdGl4ix9bxJNMWlATP
X-Received: by 2002:a05:6122:d84:b0:56e:f071:d4ef with SMTP id
 71dfb90a1353d-5a6e62bf36emr3592780e0c.8.1780573097054; 
 Thu, 04 Jun 2026 04:38:17 -0700 (PDT)
X-Received: by 2002:a05:6122:d84:b0:56e:f071:d4ef with SMTP id
 71dfb90a1353d-5a6e62bf36emr3592769e0c.8.1780573096515; 
 Thu, 04 Jun 2026 04:38:16 -0700 (PDT)
Received: from [192.168.68.106] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5a6d6413983sm4764197e0c.1.2026.06.04.04.38.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 04:38:15 -0700 (PDT)
Message-ID: <6dd6df87-132c-4cf0-ba73-18e6e29b6740@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 08:38:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/25] target/riscv/debug: Put mcontrol load/store
 match address into tval
To: Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>
References: <20260114044701.1173347-1-npiggin@gmail.com>
 <20260114044701.1173347-13-npiggin@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260114044701.1173347-13-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rsGNhiNLRxa27eaMwOQWcd2Lp_HA7xlt
X-Authority-Analysis: v=2.4 cv=IZG3n2qa c=1 sm=1 tr=0 ts=6a2163aa cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ZWLnrAQK2iS3FxJT6f0A:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDExMiBTYWx0ZWRfX6HsJjyNWWp3w
 bn7uQTikUagsuncVMRGdggmoHGwMavg/yVRhx/IyZbTlA1/BBfioUOvd3xscpEQs2zEpzr3Pa38
 rDOiqauOh5O7An8J3fBDku7v6jy4FQna6S3hi6b8RiXbhlsPxMgjl7rQyD8x8uYgyXVQ3M+OlMg
 zc6z2X1BhExWFHnbXBG60Hq7xQgH3k32rmtNqAbAdtptvfkT+R0zNvfiPdq6dx/g89hPgZM1C9q
 Rd9RoNrc14AzZw0+QWgicRnsdLDfdFzFo07f/xwz7eb/f05cp/7YxiEIQ+s8Nh7v+LQdqaV+LF7
 HKeay726s/y2M68l6lwj3jMU060t21MFdadbiuKBboeV/GGU3E37gSPGWa9mZAg3A6bYu0aCROb
 Wp/JNJ7GKBo/ZFtoMtWQFAynuZdSny3aPhLlHKnkRRrmCzEESjOrpvP7Q02I7Qqb5ky2MqwD3ih
 oz8HDljw+yPeEhR8R1g==
X-Proofpoint-GUID: rsGNhiNLRxa27eaMwOQWcd2Lp_HA7xlt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606040112
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



On 1/14/2026 1:46 AM, Nicholas Piggin wrote:
> When an mc/mc6 trigger triggers on a load/store and raises a breakpoint
> exception, put the matching memory address into tval, as is already
> done for exec addresses matching.
> 
> Tval for breakpoint exceptions is optional in the spec, but it seems
> more consistent to implement it for load/store if exec is implemented.

There is a non-written standard that we follow in qemu-riscv where we always
tend to supply these tval style addresses for exceptions/interrupts, even if
the spec says it's s optional.  So yeah, you are correct.


> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/debug.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index bd61b7ff02..19c45fb13c 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -1075,6 +1075,7 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
>   
>               if ((wp->flags & flags) && (wp->vaddr == addr)) {
>                   if (do_trigger_action(env, i)) {
> +                    env->badaddr = wp->vaddr;
>                       return true;
>                   }
>               }
> @@ -1093,6 +1094,7 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
>   
>               if ((wp->flags & flags) && (wp->vaddr == addr)) {
>                   if (do_trigger_action(env, i)) {
> +                    env->badaddr = wp->vaddr;
>                       return true;
>                   }
>               }


