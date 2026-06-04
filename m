Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BD7CD6E57
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 10:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV5MG-0006W9-8d; Thu, 04 Jun 2026 06:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV5M2-0006RW-OM
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:31:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV5Lz-0001OL-Jr
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:31:13 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6548UX7G1132195
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 10:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FkfQG2WMLVGhh3lScAYNiUngeU3+aha52uzRutFQJNA=; b=PHfDfMqO4sx7Rcw5
 otrw+PMU9XGlLQZDA9qvwCngtc7rqYRJDLuBZZupxLOcZADhvarOYe6qYloaZckg
 0BgZBLhU0QNbdLPY89epo5aNKweXvDyJI2VdD4vwYj+4wSnZMvQrZktK/3ymNDpP
 CumBOEf16vRs9vA+0R4NQYNwUSmxmb95udFOdvDGXIjqfo2rrPjEdLRboa1+Bqad
 F0ywsXA+/aDN7yOQWAJx2XuP3X3bKVvbNhNj/1cVE+BVkxP/CHBBC9OpdqSJp5VX
 FRunzjEbcC9Ipc9kZUOUMtxOXfR/yRDp4yhy8iFlwE6cx8qdgp/PGyI2SyOV5v/S
 Fhzw0g==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek5wsget6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 10:31:10 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-7ebbe5b410eso7612897b3.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 03:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780569070; x=1781173870; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FkfQG2WMLVGhh3lScAYNiUngeU3+aha52uzRutFQJNA=;
 b=VhuvuUVL7mpsnlsooYPesKXH0gIct+Fwkb6lJ+KFnNE6X4IZEv2bw1OOAj04zSb+RE
 c/KQe4EClTeGx+NbU73X8O1T+vpZs9Nj8SH9J0nqEOaumWGdeZrV+e5oFbRPCsCAibJZ
 mUFFRb2VmXU11oIZJbINkLmliHZ8xv/6oTaev7MRtnfP2j1tmSaOnARuJ3Ktwfg95fxz
 ElkP91lmJBSfg5GF6Jh8IzijD0OSsf3HkGv1T3v3nuYaXWZTxG9+eW5v5jMwMukHlqJT
 y+kkan5U5prnWBNSFSv9tfvuiixCLKLVHZrSbpAfFxhXAiTL4B/sDPWntQ1DyBqLUaLv
 hgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780569070; x=1781173870;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FkfQG2WMLVGhh3lScAYNiUngeU3+aha52uzRutFQJNA=;
 b=UmMwOxSo8jw8sBZajbouuOdq0ARloGepH7nBVd9m5FRcCFDCtBiMag4ZZOCvjC7JrT
 8N9QobPieCJJAO+z0FJzTrJmc88fk74Xkh8+5HwtzeJQfDfzHNYlLuB8ll2F1BnZdoZU
 7YMfTStKsJBFVbDnfc6de0laa2u6Q2kOZrnfoU33ykd0ZR15tOY9gOvHf2o0zHCQbiNp
 VGoU/fvpkVMtWRm1ja95A4ZP1IosrkmmIvlbB/SifHlTuGPUuhNa1xegJ7WLJZAvg2iB
 hHlaxh08A+U9R6jL505uINbRiyG5iBdZdtIm8OnowndZn7oFudEdqbmd0rVA7x/jQ1//
 AWuw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8J7oRWwJ0BtHmAUaTKbogPUKTztc2yHjCzdz1JNjgnaK2RuW/WJzspGj6UadOtNeryeImpInKF1U8y@nongnu.org
X-Gm-Message-State: AOJu0YwV2u0EJfZVG40V6FgqCb8eIScysagWpwBbxnPxG2mxFfVyyoKZ
 UPpLJaevH/KlvuSHms+e5+BC5A3F7zKWLtBoRRl1V1wXqE5en8GAqnJxlrSuni4B5CGEBj4gvk2
 DeRqBs/v/Tt72LIwpP1slC3aodr+P0iwFLEFomZ4Lh9LZTEHLRa0tLXqNMQ==
X-Gm-Gg: Acq92OE1dKsUmj7WknUFi34JMdB1cs62hoU0xd6Dpz5eLQWFtxBDXNtWMVE9BWP7BZF
 3+xin50OXK7uwfmewcKY5616q05DgQWkWK3trbptn+ylsnymMCQhLlN/FEFLI0coHJcb44yITj9
 9+LKRmrQ9+K+NvZCwVA5utpeHmOCnLVYumseFVf6XoIaHlkrkZ74vUss30ClJhPSVmx3KQSx1hd
 JRWRhYoHZ+8jdQghH7Pqbw2JquUnTsxUK07OPyHrjymf5TzlekO850gyavBwk8Tnm+rQUTl9R17
 gD6tulmf6ulurpRA+cxbYCtSyB8YFdDCMP9UxIZ9pbCXaYEzQB+B5ZiEq3XjkVLMb6cvIQudvFc
 x+lu+ZKOnecBj+XPTwTS4nqHbYnGmuZmNEmTanI0syOIhGgXpo9/PagR1S+IJShKM/8sF
X-Received: by 2002:a05:690c:4b83:b0:7bd:5579:185a with SMTP id
 00721157ae682-7ea49e6749amr68322347b3.25.1780569070095; 
 Thu, 04 Jun 2026 03:31:10 -0700 (PDT)
X-Received: by 2002:a05:690c:4b83:b0:7bd:5579:185a with SMTP id
 00721157ae682-7ea49e6749amr68321927b3.25.1780569069719; 
 Thu, 04 Jun 2026 03:31:09 -0700 (PDT)
Received: from [192.168.68.106] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7ea20ea986bsm31791287b3.9.2026.06.04.03.31.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 03:31:09 -0700 (PDT)
Message-ID: <a0ef41fa-3c63-4608-b452-78fcd8a0e966@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 07:31:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/25] target/riscv/debug: Implement icount trigger
 textra matching
To: Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>
References: <20260114044701.1173347-1-npiggin@gmail.com>
 <20260114044701.1173347-10-npiggin@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260114044701.1173347-10-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: sVfF7ENtIi_OP1Ce-8UOV5EYumbZhm-u
X-Proofpoint-ORIG-GUID: sVfF7ENtIi_OP1Ce-8UOV5EYumbZhm-u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEwMSBTYWx0ZWRfX755DFzbO4h1D
 TiRyJo4KYl+RLqjqQ/ZrRpRFmBnwVH6VqD5DU6M7LxOkSt1uFbnbu8et/09MSFZ7Q2Ttj6C/PhE
 rxsH0i23Ka6dTJhO+mbfFQFuYgo5JkGRk84UQFn9nsGL/M4HzuunABqMIDJ50V7SxpjzIlLFlq9
 I8SCw58bMcqCsAsK5pgb1EPiCe9eSQN1aFc4Mo0ERroOa/WGbc5GNxOBROfjhit8nSxShlErkB2
 yBE0AZNf3T2j8KGByfb15ElEV1ufEATAM7BKkbiKVGcd1jBQSwU4m0mjgfJRxiTifDXwGlxDHGs
 3XbwthjQvyq7mTQAYjkNflDpPS79TTDKNSXaHQbTsh3Ipj46jb0Dzn09r6l4G5hGFzvWOBmQKdp
 Vn3PCmSk7dJqtVM0QKgWw8P717xYdUOyh1HkZpCKvWeefVfflND/j9nUsg+z7HK5N2K865gRaDv
 imIXI3BDiUewuZEt03w==
X-Authority-Analysis: v=2.4 cv=POc/P/qC c=1 sm=1 tr=0 ts=6a2153ee cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=JvLbQTfvwFkklDSfm4gA:9 a=QEXdDO2ut3YA:10
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
> icount triggers are subject to textra checks, per spec.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/debug.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index ecedffd3b9..d835c0e79a 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -675,11 +675,12 @@ static bool check_itrigger_priv(CPURISCVState *env, int index)
>   bool riscv_itrigger_enabled(CPURISCVState *env)
>   {
>       int count;
> +
>       for (int i = 0; i < RV_MAX_TRIGGERS; i++) {
>           if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
>               continue;
>           }
> -        if (!check_itrigger_priv(env, i)) {
> +        if (!trigger_common_match(env, TRIGGER_TYPE_INST_CNT, i)) {
>               continue;
>           }
>           count = itrigger_get_count(env, i);


