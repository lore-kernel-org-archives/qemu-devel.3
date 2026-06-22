Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BC5CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 21:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbm9F-00087S-GK; Mon, 22 Jun 2026 17:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbm9D-00086E-DB
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:25:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbm9B-0000F8-Aa
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:25:39 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJZxPY1553274
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 21:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1zObEwqrvqvWsZfz+B3vGPP1IKu628JDX7Cf7w4EPeo=; b=Gg03KlG+SBym2VSV
 iNQm6A/rr0fOlbNFUMR+MGTYNmwkSmqtaa7Bv8WDzWH5u4q+cHre7FB4xAXAMAXX
 ef+scPDsgEUPzZ9Ax0RHDkHx1m5IrJA/AtQvjqT2XKgXoFW3lEbOFBhSL5rSCV2R
 8G+hTC2kFP+lZ41akuG8RN/UjEnxQLFg7S/MkJgzBIDV2qgFJkM9Ttytske+XHt/
 /mWSPqFJ3vGUw/c1CtTGTzV5KTx1UpIurCU2MhewkDo1EQZwXXqjPuxKIB/rfJ4c
 Z/YecU3cumpO8JLQYFX6fDGXeowSMt2aUIbXH7drBc2rcgN05QN6a85/XM5jtnIb
 h0JQ8A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey729se2s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 21:25:35 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-91574ad681eso749880485a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 14:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782163535; x=1782768335; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1zObEwqrvqvWsZfz+B3vGPP1IKu628JDX7Cf7w4EPeo=;
 b=jTzxuG108DruUspgPv1Zq/5ucviU8xAWat2eOI7Qnzv2XkC6VXt6nbtsMBab76Fr4b
 i7xn6WtV/EdJaVmuqF/ZqMXNrwxGz2p+muQROcVnoT2yFOP15VKjkzMfE2xLvOoUjOhu
 +qoEjs7eNLrXRIswDnG6gNQT0g+gCs3P1ILJITBW5Hqw8m8cIiusseW70+xiwQG+S/Sw
 tG2Fms25GWNWUhcH6x38Sm57KAyMQkILUB4k0T+kf6Q8RBmAj8ZAbq5XTGeD6sxcwPdz
 vpPBvl1YsfGaZZG2wD1YLJZAMhE0O5mLV30OrSz550rMx1h+bfgPAK79sfshhD59nGdq
 HVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782163535; x=1782768335;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1zObEwqrvqvWsZfz+B3vGPP1IKu628JDX7Cf7w4EPeo=;
 b=EYSfIFO3aoX8xDxYajvQJHW7QbggD4iYhbdYNkRHP6Dt2H1Bp7B1XDAt/Uqn9zxTZA
 d99swR12nNlbcPdqfs+IB80beYYam9XcmA4WRmbCgQpa8mVsfDC/hSjyt9S8a40hwCHm
 Ut+wU4ryywfpUiuB6k+CajT8fZA2A+PAbGfqMzdIcw3i89EdGZELnsDTjCcnen3FZ/Z2
 nDzNeJTPF9W2tYreDxpCMrzuxUrl2sT/4LQt9o6xewTvc6gWmBJPrIjH2FYxkPHcYWRK
 Y49jxZCLaNZTGVtRBNmAbsxA7dsKqvgi/9worVcqiyPtKdx0yEvmjBjWLboEjigqarx8
 2hfw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/CLZwZ0Ff2AlquUztfgw1uxDk00TJwpxnWGHktkA+Ik+b/+r+ol9wtkkiKRKZvOlNnOB37UPMHsSVR@nongnu.org
X-Gm-Message-State: AOJu0YywHx41UpTNyHYHFSTtwaxgexvLTlh1qdYxShXr01ukA5C1jIzL
 yTBzyWbYK8JoFAH27Q4dwjgMHRpjxxPy9c+TPSykQfb0vEHDDsLF6RfnhCbBm0gSvfMAGOruWfM
 IXyNGBVNKbaoJVXquVltVf1o8updruxZB6wR8Dnxsz4xRyC9Z9uwCfIKOvw==
X-Gm-Gg: AfdE7clALp+1iEvSmRlqD0crjFQZR8vtruvNUev9jvdEoHrIV3jpwwh6R3Lyv6/9idF
 ++O7CRFUD5Y1p2cXQvnZ87pNA0GKbC0+hFSuN+BFilYRxRKC5+e/JnXNyImV47XqOjdD3a6Kjov
 tuoTT2XW+v9/vYAdrQWQ17lGQRNPGWsf0zdFVB4BDvejyGVx2j6Z2GArieHY4p+QiaCmwFM4EoW
 1+vmJIlxmw+fo7uQxguDmTxezz5F73LGc5qwrP+b8vrz1bk54PbBMVunklKDxL8UMo0bktlYQSQ
 O63s07o830/A+I/n9K91rhT3RvQ+6mtpxq7BEhAgbvYKogGO3a05xop/qo9OJg/YMY7Cj9zV0Kc
 765n9Bo/4+nEqfQ+FMfn0YX4d7QOaUJvCAL0pgX5aNVvxrLzU/BGIQaWaI6eoRw==
X-Received: by 2002:a05:620a:6ccd:b0:915:b718:accc with SMTP id
 af79cd13be357-9208fa25447mr2797741885a.24.1782163534795; 
 Mon, 22 Jun 2026 14:25:34 -0700 (PDT)
X-Received: by 2002:a05:620a:6ccd:b0:915:b718:accc with SMTP id
 af79cd13be357-9208fa25447mr2797734885a.24.1782163534209; 
 Mon, 22 Jun 2026 14:25:34 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466648c5413sm30645654f8f.11.2026.06.22.14.25.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 14:25:33 -0700 (PDT)
Message-ID: <e3c93122-d0e5-4868-bf83-d757c0d1e0d4@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 23:25:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/24] target/riscv/machine.c: do not migrate pmp state
 with kvm
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <20260622193141.1449724-4-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260622193141.1449724-4-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIwNyBTYWx0ZWRfX3AV6zQMjbK1w
 pXLn7E5MTLUYr6KXPNOfpZfx9yElMRb/Eml2kg9JpROkOz/wfAySS9Bey7xfKmfan2Wt2deMh26
 Nxb4bhf4xh3vi5Hr8k5fc2wrbyQ6Vck=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIwNyBTYWx0ZWRfXy4xJeNswD8fq
 rwsIJ7AwSlOEzheQCMd5KAgvcvdicVYtQ2xqwaiG++XpKKk+J72IH3zOOe1YfjswnmBpEyDl+vR
 B24pXNoQreh9VF3HzcRNFj25Bt3XZOTJ0qs0WLqsirnUjIIdhQho9KC7fHTpSfhcred0iQ4xQvY
 3bEfvXClpKClSvRjkkeZ09e0Bi1CU7o9gZrqVQ+Zhu7FK/Jrs6sTk8LcDZD0bhZESFd8fkcaRte
 XeLGt+6n6JyvzzbP3CSbu7jwogO9ph9no7qm1Am1adEOhrl3YS5pXh4uydJmQGJ+7VrWWyc2yIR
 cWgb1E4B5MGDtqgA32xfxzoEgpzo4NtxtXfT6YT0GWL6mKAbrwAigzjbGUtUNAGT1xyHNcfHriN
 L7sUn+TmVmqAKSQMHz0yn6U9SThh4crZzKPRvdo7ATBifyob6SI0qoeiSCUelEnk3OveEHwamlx
 n3Ua5bprL9xG5X+nKCw==
X-Proofpoint-ORIG-GUID: cJbgbmTgVRJFJ9v__MI6KDaYXcZcJSX9
X-Proofpoint-GUID: cJbgbmTgVRJFJ9v__MI6KDaYXcZcJSX9
X-Authority-Analysis: v=2.4 cv=eN0jSnp1 c=1 sm=1 tr=0 ts=6a39a84f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=jtdXYsQbIJyVuXW7qOwA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220207
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 22/6/26 21:31, Daniel Henrique Barboza wrote:
> The PMP emulation isn't present in the KVM driver.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   target/riscv/machine.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index ba96ceceef..bd93d6f3a8 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -20,6 +20,7 @@
>   #include "cpu.h"
>   #include "qemu/error-report.h"
>   #include "system/kvm.h"
> +#include "system/tcg.h"
>   #include "migration/cpu.h"
>   #include "exec/icount.h"
>   #include "target/riscv/debug.h"
> @@ -29,6 +30,10 @@ static bool pmp_needed(void *opaque)
>   {
>       RISCVCPU *cpu = opaque;
>   
> +    if (kvm_enabled()) {
> +        return false;
> +    }
> +
>       return cpu->cfg.pmp;

Here we want to keep logic parity, in case another RISCV
accelerator is added:

         return tcg_enabled() ? cpu->cfg.pmp : false;

>   }
>   
> @@ -39,10 +44,12 @@ static int pmp_post_load(void *opaque, int version_id)
>       int i;
>       uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
>   
> -    for (i = 0; i < pmp_regions; i++) {
> -        pmp_update_rule_addr(env, i);
> +    if (tcg_enabled()) {
> +        for (i = 0; i < pmp_regions; i++) {
> +            pmp_update_rule_addr(env, i);
> +        }
> +        pmp_update_rule_nums(env);
>       }
> -    pmp_update_rule_nums(env);
>   
>       return 0;
>   }


