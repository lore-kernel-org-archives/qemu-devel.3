Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC69CD6E57
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 10:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV5KQ-0004Ac-2q; Thu, 04 Jun 2026 06:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV5KN-0004A8-Jm
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:29:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV5KL-0000Zc-MS
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:29:31 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6547QlFi1476538
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 10:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c9krf2Ae0NEtButHNeog+rZO4eKir5eLvpq3x7svA/0=; b=e9sSu3iQHxKync4m
 WkoUc6pSfMR2wHU5U6M38YKNT1FOEbr3Yt/W9Vslpc2WS2SYt5dkQ6bmYJqgxOsU
 1uflD4dp2zXKMH0vN+JU9KXQrBKmmH0crIRsoQ/lYktc6EzAda2Y58anXqEqr01b
 SqPUZW663B3HEd0sGiIAgi6F2ttgupVtZ5E8J6cD2oVuzFgsIKsWZsiiW3ZplhHn
 rz05SlqaLyN/YwboZxWV2JtQquPtJ8RmF77SCMsB4yS21smYK3A0IB6yLrEaYFJB
 DegP00The1hdNKGG6Cd3ztePPZcDSUwsKLb1opQQaHBa+ntyKNI2GpU24JYHSOqY
 sXLjKA==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejp6nv9by-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 10:29:27 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-7e25a5f1057so8072527b3.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 03:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780568967; x=1781173767; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c9krf2Ae0NEtButHNeog+rZO4eKir5eLvpq3x7svA/0=;
 b=VemgbPwA6QbCPqGt0ZJRn9gRIEnjjcnrgM58HUQylAAZ+S7sEMOXH5EuX8qVmzKTuh
 J42hqKCw1QQKbwhON7vbIUGM0ow2QAJ5XZF0wDGr+badtbzsmJQ/BsWCyCX8mHjpJCvl
 czAD30vAl3ZxU7WcqSLjHoeV1LRQbaTy90Fp71U/zlCVcUz3DrHL2szOoWCDDrOCLvdv
 5/b1CcFRzEI6LULL63Heo7eY4PuSCBvw+O4H6DR4sl5i3xET2UBQZBnlpYcAsEv4RBcG
 6eeQA2REV1BI5bpr17TKrRyVDolc1qJqXTh84BqC56unHPtOeABQ1EsWosnQAxV17iC1
 iREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780568967; x=1781173767;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c9krf2Ae0NEtButHNeog+rZO4eKir5eLvpq3x7svA/0=;
 b=C20lBe98PEuPLHn7fPm66nZtKco0LjZnIxLy8+ijveUJwqBDA8xOuQs5u3tiRtg1I/
 g2sccaLCWJ0LXMgZDdghNC86BKonkI8GKLX+IWUidqCkEdWxO4BpDyKeWrEyrTQC1Aol
 Inuo5dT3M8bp9PhqoGfekRjujfauI+zmcaBJvvkzACTC750gdXfKmQP2Ps2JqSdr6xJS
 LCgyzV0a+Qf3e0ILb3l3hgon4qIGrxj5kS10QqBuXOJD8zVVl8J81OofOr2p9y24QXJv
 cwzt7nOSLMP+m8jEJQ8ZTySUDffqcIP0QG+8S+eweNVCtdrFKOHM/K4ag0fBx7NznTfX
 q8eA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9g3RZ6oIVX6N6AtJa23sewrFrkl8L5o/KSYOanAVspz1KhTp+c/3ph1a8nshkDtoYuW7byLWXtCydR@nongnu.org
X-Gm-Message-State: AOJu0YydhEt9rlUrIRMu/u7VqdW6AlRj5ISBvpsX1+AsSPp7j6u/4vmI
 nEhVuqyo92oQo0MeaoiPTmmyniHd1B28EtkhblzevW2e9aj/CWF5LRicznVQm3ROL5iyHCwbTo3
 1UpIEEdRZ719B8Igjn8d/XRVUVgVTyLYj/9CECSyloRnlyWxiQTbWlswnDQ==
X-Gm-Gg: Acq92OFnMrVTiU0MHv/GqoQYEtDa3vMjeil89aWTq54SU1x0euVi1+0HM0o3T49gPha
 ks7vAPVZkSIgF0PhpNf3x9n9TZXAoXNGod6hwvnIZ8Z5x8aq7tZw/vt/Ik4cXia6MiV0/2EueqV
 pICB77+hlriaH54ibhJda1obYjSHIrCUl1MKbnhj0bpyj4B6RIHfmA5BpHrRPXFN2GnmAYk5Ii8
 4xcG/u/ctaM9gAVQnbXnR26cLJaxC2XWe8B8cFSvZC88A+Gx3mxFCpAFS5oi5ARxk29/cvhmM3F
 M2hhz+StobR/6wvhbgKTUgQOnLzUQAgaLRXjINs/vzy98IjPCU2+/ireQTFeiFZep16UVq0pR87
 9010VcUR8s3sUtg9pE5VWquwLX2+tlNMjAUYWUJn+J/q/Caw3aMY961ByGHNByp7/OtmQ
X-Received: by 2002:a05:690c:6f0b:b0:7dc:ca63:d7 with SMTP id
 00721157ae682-7ea4af200d4mr63699457b3.25.1780568966942; 
 Thu, 04 Jun 2026 03:29:26 -0700 (PDT)
X-Received: by 2002:a05:690c:6f0b:b0:7dc:ca63:d7 with SMTP id
 00721157ae682-7ea4af200d4mr63699097b3.25.1780568966426; 
 Thu, 04 Jun 2026 03:29:26 -0700 (PDT)
Received: from [192.168.68.106] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7ea2358876csm31087047b3.24.2026.06.04.03.29.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 03:29:25 -0700 (PDT)
Message-ID: <6655a81d-2cfa-4757-be2f-d10be481f6ff@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 07:29:19 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/25] target/riscv/debug: Update itrigger_enabled
 after changing privilege
To: Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>
References: <20260114044701.1173347-1-npiggin@gmail.com>
 <20260114044701.1173347-6-npiggin@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260114044701.1173347-6-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 9HUsPSckTqZ1IyFXOaRVr6VwdWkON-kd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEwMSBTYWx0ZWRfXwlYJFGGEqLfK
 94CaT7zJwZs/WEJZOUgRIh/p1qbcfB+mHUcyZALBHnnoDp7tZ3/gvw0oQ/6ZlQaOT7/zS5W2LDm
 ZhdNJZ1MKnZTR6ftUBxa1BiOE8KsM+T2cO4xw722q8welWXPjqTThZChkDmxzeodOsOqmrCmOys
 oNu70hsCGEKAOzb5TM8GftulGhqbr297QY2JvyvAvA8kw8219jOE3PmiS+4QUhlY2ihdGXbX7pb
 T2iuAJ4WierhV7P4x7Mr1bUOFx4B8ScTDOXGmEyXze13bedY2C++CMX19ZapNVjNxPfeI996k+G
 NVQq6Zf68GAb4QRKRH0tK6UqK2Tx+u+vg6An4hPwOeU6Qqh+fv7E72CfWulsP4LSIDW338wh8h7
 9wbhKLkJW7EP3cDBF5AqLtOM6vHBTii3qZxbxHbXX/MmN3yZM3zAAallHzqAdkJ4z+wTPCJ47hf
 VZdQEKJ4l4/6r9uFUFg==
X-Authority-Analysis: v=2.4 cv=DbcnbPtW c=1 sm=1 tr=0 ts=6a215387 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=6OACQDigFZZbPGazry4A:9 a=QEXdDO2ut3YA:10
 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-ORIG-GUID: 9HUsPSckTqZ1IyFXOaRVr6VwdWkON-kd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040101
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
> The !icount_enabled() path should update itrigger_enabled after changing
> privilege, which can change whether or not an icount trigger is enabled.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   target/riscv/cpu_helper.c | 7 +++++++
>   target/riscv/debug.c      | 7 +++++++
>   target/riscv/debug.h      | 3 +++
>   3 files changed, 17 insertions(+)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index dd6c861a90..e096da939b 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1030,9 +1030,12 @@ void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
>   
>   void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
>   {
> +    bool change = false;
> +
>       g_assert(newpriv <= PRV_M && newpriv != PRV_RESERVED);
>   
>       if (newpriv != env->priv || env->virt_enabled != virt_en) {
> +        change = true;
>           if (icount_enabled()) {
>               riscv_itrigger_update_priv(env);
>           }
> @@ -1075,6 +1078,10 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
>               riscv_cpu_update_mip(env, 0, 0);
>           }
>       }
> +
> +    if (change) {
> +        riscv_cpu_debug_change_priv(env);
> +    }

Is there a particular reason to do this change at the end of cpu_set_mode()?
Because if there isn't, we can remove the 'change' flag, then just do a:

 >       if (newpriv != env->priv || env->virt_enabled != virt_en) {
 > +        if (!icount_enabled()) {
 > +            env->itrigger_enabled = riscv_itrigger_enabled(env);
 > +        }
 >           if (icount_enabled()) {
 >               riscv_itrigger_update_priv(env);
 >           }



You'll remove the icount_enabled() branch in patch 16 anyway so I wouldn't bother
do a if/then/else with icount_enabled(), but can be done too.


This will also get rid of the riscv_cpu_debug_change_priv() function added here.
Which is fine: from what I can see in the patches this is the only place that
it would be used, so no harm done.


Thanks,
Daniel



>   }
>   
>   /*
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index 2effbb49af..51c5934bfa 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -1090,6 +1090,13 @@ void riscv_trigger_realize(CPURISCVState *env)
>       }
>   }
>   
> +void riscv_cpu_debug_change_priv(CPURISCVState *env)
> +{
> +    if (!icount_enabled()) {
> +        env->itrigger_enabled = riscv_itrigger_enabled(env);
> +    }
> +}
> +
>   void riscv_trigger_reset_hold(CPURISCVState *env)
>   {
>       target_ulong tdata1 = build_tdata1(env, TRIGGER_TYPE_AD_MATCH, 0, 0);
> diff --git a/target/riscv/debug.h b/target/riscv/debug.h
> index f76b8f944a..5a14b7894e 100644
> --- a/target/riscv/debug.h
> +++ b/target/riscv/debug.h
> @@ -153,4 +153,7 @@ void riscv_trigger_reset_hold(CPURISCVState *env);
>   
>   bool riscv_itrigger_enabled(CPURISCVState *env);
>   void riscv_itrigger_update_priv(CPURISCVState *env);
> +
> +void riscv_cpu_debug_change_priv(CPURISCVState *env);
> +
>   #endif /* RISCV_DEBUG_H */


