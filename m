Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAB8C44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkLxV-0002w1-U4; Thu, 16 Jul 2026 09:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLxT-0002vS-Nx
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 09:16:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLxS-0003rW-43
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 09:16:59 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GBiaTx3747289
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 13:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wgZjHsnitJfDRDNhZGlPRx+iMqM5CBC1O83g8qUGuGI=; b=BsEVhybp/XB5uiCj
 Z8vQbtczfWe18bHbyE0KTNlbfzaXgjhKOSYGDhiMRyPRaiLLXZ+hRMj/YCKIfPVj
 euhiHh2r3ha7QtFG7f51M9RDzaLTS46/ZadW4yz1FWx/om/M2/mDAi/bGuQHUZ15
 v2lbXjFnN+ExxTFbgYO0mHjEJFTTzcIqRhbM/cVWwfVNjMWdpOyj03g0y5PXpOqv
 4ZzP/QPeI8gulmFSDgHnPvsggrEN2hFP39YxuHGtSt5LbqyyuOVt/qMSvgt5KjIg
 NwWy1SgKUT8aMYfnXEkFJAr7ntx/oXtVvaTjHVvgwNLtH7auRXe9xgcFhOzUwqLK
 eQ0w7Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feq3pjaac-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 13:16:54 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51e4ba1cfabso42983211cf.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 06:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784207814; x=1784812614; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wgZjHsnitJfDRDNhZGlPRx+iMqM5CBC1O83g8qUGuGI=;
 b=BE5VJghT5PahZqC4sZ8XQcpX+HgmCxQsCaUb8LHRl/WlQWG4qfzEBPNoeAdYi3LVFk
 e1q6+zDajJ0kTwecn40S6eH0zReO3LlHi83DRpJ2sb3i0WHxGVSZBpHnsUBpu07ibuSS
 M8rRFJaQ/WVNZz003r5qDky16juVI7n2//ilummV8HLLk5Tm7Plws98Gf9h6cGCLoghE
 ci8nfcRkFVBtRtHbkxHBAkSdzKsurn0OizJNLDT780Ltl7BGp105w4pyWIUxXcA5cJgo
 HZ/pBvbQngsByZdwN+HztaDkURA79pZA35y+oXkTLqX+u6XgE5yPTiZHAJTphCWMC8eb
 lBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784207814; x=1784812614;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wgZjHsnitJfDRDNhZGlPRx+iMqM5CBC1O83g8qUGuGI=;
 b=c+0r6wq9fbf8S3tBTexMQjMApddQeTIPVhTq7YTtv3cA5T9fKJ0UaqGTRCIRO8tlv2
 zJhiNYwz2eWwNIPJjDt/0KShOvqXU+d9QVVL+VTrrdc0CC3pVFHzE6YLE1/dpjW/OSE6
 LeREPZSDggfRObYnaEYDf5lg37Rv36dhY8M7VXfSPUYBJ2mZF5Oh2LStjlZ7GC4zp2Ke
 vJ0DGLX5KDNiONtwuvxGxDOrDIr3KB+QOBn+rG/jaohyfNk4FETQgsI8sZ9qsdreeFNY
 0yoYwp350KnOhvuLC1xf/LMhY1OgWkO6lQ8m6bRA0aHBC/7sFYI4DLg8ZcviAka532P6
 ooEA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoTYxolXUofzK0O81uvlMBQv6JzN3XpxmbyRE8gog2wzfoHYkEDa3wwewMChVJrwDKwMeDk9sU2KJgm@nongnu.org
X-Gm-Message-State: AOJu0Yz6HlTFGbsC7nw7PmExu//g7OEdhwhIbzgp0O66TdYM/mvpWFLb
 KkIQgMiJu6+Jaj5HQZJHunMT2RECynnoBJBTGoUXJLTAPK+oqXSGJnnK98P9n+gBaLesQseBneJ
 vYvVFCRn0cxnC7ewvxHQlF6e0r55Us3NN6QJFCSU1SJiiXUxzXl72VUldKQ==
X-Gm-Gg: AfdE7clPGE3x8XLtB1N1QQBw4BL6BzNrko6leVsXyNr5YdNVHRMeNInF2GcC0O7gk3e
 cab6XlTaOW+tbKZJLB7NmphY3ku1FZFEf+gp0er3iOl9Gxurxw2xglzmkV78qzpzeqY9lJE9VuM
 WevuoP0YmKcQxwh0HO8NUgeNXW1Mx5VdyzVLrr1/0Bb+iL0t6RhsKNYcVRriwZOw4rQbIItcoYl
 ouZBcBo4XPqWXcYr4N5tmLllvFQGN4ni2RyYFGB7IcuX+fSTo54VUrqDu/aD9ga2sdETv3hOxCf
 38MDsh1EA0Vc5nXPdSXmcpdYmyccJs7/dRox44Gy6Bb0uirFMeRQhKaZ7XSHtAzM1s+gHlXmwyV
 kSjzN+mWpwKhBeMi1p3rkEtH8e42f5zJaow==
X-Received: by 2002:a05:622a:410f:b0:51c:a8:51cd with SMTP id
 d75a77b69052e-51e4ede93d2mr78877051cf.1.1784207813846; 
 Thu, 16 Jul 2026 06:16:53 -0700 (PDT)
X-Received: by 2002:a05:622a:410f:b0:51c:a8:51cd with SMTP id
 d75a77b69052e-51e4ede93d2mr78876581cf.1.1784207813368; 
 Thu, 16 Jul 2026 06:16:53 -0700 (PDT)
Received: from [192.168.68.105] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51f2bf8ff21sm21928801cf.26.2026.07.16.06.16.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 06:16:52 -0700 (PDT)
Message-ID: <09fabffa-6d98-426f-af08-7b3e4e7845ed@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 10:16:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] disas/riscv.c: Correct wrong shifts for cbo
To: frederic.petrot@univ-grenoble-alpes.fr, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: julien.thillard@univ-grenoble-alpes.fr
References: <20260715190737.1381701-1-frederic.petrot@univ-grenoble-alpes.fr>
 <20260715190737.1381701-2-frederic.petrot@univ-grenoble-alpes.fr>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260715190737.1381701-2-frederic.petrot@univ-grenoble-alpes.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: os6e-x8MZxI-mrAf7sbw30Jiw3xFbaTT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEzNiBTYWx0ZWRfX/h/SwPB96E//
 vrRRUmZimG7XFzFQXz0virEl4+bsnZqAyDY0TMXwVqrrJdcy5/gGLELhA+gq7Jl4mCnlERsvQtY
 mSYHQt+NIIRH2fAibRIWap1vGJws7M0=
X-Proofpoint-GUID: os6e-x8MZxI-mrAf7sbw30Jiw3xFbaTT
X-Authority-Analysis: v=2.4 cv=PN8/P/qC c=1 sm=1 tr=0 ts=6a58d9c7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=FNu0ZtHtnlOnKnqYvqoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEzNiBTYWx0ZWRfXyTZX0CWakUrP
 LVttHScxqCEw6nhKp8gvFERqjnw4LmWgXgwQLdLkcAFOVE6VkC45f9cS+ic/OnVFbA6mLzMYqUm
 8yrjqFCuLWIjUe3+o3KClwZJkTNwP8PgStKQyRQmVhteSnW4sX1y/0XtN3CNYwXloVcGOa/1V1H
 a9oZvBnY/eb4rmBh6U0G6REuH95jS6JaYR14/YdTOeTeyvF07uL980Drjhw9DW6cY52KoPpEbPX
 ERagIXdWOYbLDKlfAlkPUCP2FSzsRnUYZbzBe7YfTjyOe/XkoDEVpCM79H9e/U26Xuzvc9prMWz
 O2jKXDkbD+HXMSZBw6Fe0refn8wOvxokiWcSIGq7Oula8Brt1xkQGqfoDiCDh5UswQE0Dz/cbUT
 7UN961wUfGbQpeB6FxDTdfUrueeCFgd31MFUuufRkbSjXdUOndPCd/WfWNbQA6/UXto5PAq6Eqn
 cuJ4RUV2Zen9w1bkD0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160136
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 7/15/2026 4:07 PM, frederic.petrot@univ-grenoble-alpes.fr wrote:
> From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> 
> The cache block operations are specified on bits 31:20, but for
> some reason a shift of 17 and a 5 bit masking were performed.
> Make this a raw shift of 20 prior to test for the cbo operation.
> 
> Reported-by: Julien Thillard <julien.thillard@univ-grenoble-alpes.fr>
> Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> ---

Fixes: 9273cda722 ("disas/riscv.c: add 'cbo' insns to disassembler")

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   disas/riscv.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 7f1b262773..490bda8e56 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -2889,8 +2889,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
>               case 2:
>                  /*
>                   * 'lq' shares the "(...) 010 ..... 0001111" opcode space
> -                * with 'cbo' insns.  Check the next 5 bits to select
> -                * what we want:
> +                * with 'cbo' insns.
>                   *
>                   * cbo_inval  0000000 00000 ..... 010 00000 0001111
>                   * cbo_clean  0000000 00001 ..... 010 00000 0001111
> @@ -2899,7 +2898,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
>                   *
>                   * Anything that doesn't match these will default to 'lq'.
>                   */
> -               switch ((inst >> 17) & 0b11111) {
> +               switch (inst >> 20) {
>                  case 0: op = rv_op_cbo_inval; break;
>                  case 1: op = rv_op_cbo_clean; break;
>                  case 2: op = rv_op_cbo_flush; break;


