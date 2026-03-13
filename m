Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEF6107BCD0
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 19:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w185c-00039Z-BZ; Fri, 13 Mar 2026 15:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1w185a-00039N-B5
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 15:22:26 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1w185Y-0002U3-S7
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 15:22:26 -0400
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-8cd80f56b27so233027485a.1
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 12:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1773429742; x=1774034542; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nhjjC+vXD/L5Ip5nP5IyUb9dpnzxMQdtkBGgPmX0uXI=;
 b=ddm065YCeoAxeTtItCjEUn5YspMi2BMpSVDvdkOsBiiyW+WFyuua7tWX0ad/eNQ6CU
 GsBZqTJ22vTn0NvA5xeJfUjoXX2daQR5FCYBi/4GKREp8TZYSxER4AOZ1XVbYCxnG4ga
 Nb6gFwJgAtO4JwNovLitL1CoK4497UNYgcXuuOZn65QMqs0XAvG39vu8bPG2+GnZ9oMs
 OYae45lZaKTsaow1ZL/g4GzHF/EIwpui+FnJ1jPSDU3lf2BsyDidsL8XpsgLW9r2+bdz
 fenR7qQQtZ0xLZe57yPeSIADKXrV13kMgTjYVRm9h0RQSNz8/eCHp8YK3rrIE8Wyj8YR
 wDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773429742; x=1774034542;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nhjjC+vXD/L5Ip5nP5IyUb9dpnzxMQdtkBGgPmX0uXI=;
 b=FtyZYZ87kfKjgt7hgpkaTiq6Q8MPDvdD6bCeBdF+Sn6ySRqsQMg61Oe9UewhzzDV4y
 3IZzNuTLf4h9sRWNtxYamborYXXcu1o6gKOLABAQ1QW2L3l13h+aW3czghrek2Tqjwrh
 cSozRsUF4awjLnVf6NKmOmov13zuoNGAqzLSErQiQ5BVfKuz3tL1AtFpccfLH17s4+wF
 zqzfOkIBexaUhzAuyOcxgh+yUCQjqZMij2xBbNEOb9SlPB4mpTX4xYzCcicb1IbPy9KT
 BzT/70PgY+OYRHJoIhMZZ9SZ+bg+Of/G/HAXlN1PPteKqHAjYsonaMJxY+djMVdcJzQj
 lAdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+4K/OapEPOX/yxryegbCAVQoTfntvKSL0fQSGbLYTuRkiR4qzamUSbHvCqZ8dcmHFxCAZ109f/+3q@nongnu.org
X-Gm-Message-State: AOJu0Yzm3Vhr4y6TUwuw0CdScR7MG+N9wacS00mLsEtCRQvNaJqt5au9
 TkfDIYts1RbSqDOXz4JMkrlK5otSuYDcPFmQsUPYtclTJOCvU0naD/kg6s2XnNB25CI=
X-Gm-Gg: ATEYQzwSysomk82B/msIBqdHP7b/EyZodDeZK0nq0YxZPd68mdyCuDl9C03c39gmJhS
 badidmYFjm+q07QBg1FEmi9AuAPJSR3ksKV95/1r/Jzz9ZbESFaS6ydVI0dnd50WO4LuDw+3Ran
 C0gMOdb9H7LGyreidnXyybNjF7fYadehw1cmg0UnC84ki0XRlAauBijUpje8jylHfw2jOhjs95Q
 wYxn8748tiHPTGJ+OLVZReCNV2r6GelrSsrrVYO9YoWOgMor2lzcFBc08KYGAuc/B0L2lXWgHrm
 kClDoEZT4UCle+5qo9WB9MRc/Bac5x4kUjc9dlwvnANlTE/Y2uwMIgvpnkm35Q1aU68NLcRcAjj
 oRTNmYbCnQPzgCvp43XthImYHiA3dqpsiQ3NPyQyxLnFN+5OVl5z9vvHGP60enoUmK37StzxCyT
 iKN+fWkagUe22asQN3u8FhwC4xZqZStotZQ2p/oHTPLltToJikfx8t
X-Received: by 2002:a05:620a:2981:b0:8ca:2e36:18b0 with SMTP id
 af79cd13be357-8cdb5b1b145mr608565085a.39.1773429742364; 
 Fri, 13 Mar 2026 12:22:22 -0700 (PDT)
Received: from [192.168.68.100] ([152.250.131.163])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cda2152a41sm620733285a.43.2026.03.13.12.22.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 12:22:21 -0700 (PDT)
Message-ID: <63c51bee-cd54-4a92-b0f0-f227aa7274c4@ventanamicro.com>
Date: Fri, 13 Mar 2026 16:22:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] target/riscv: Don't leak general_user_opts
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260313182957.28432-1-farosas@suse.de>
 <20260313182957.28432-4-farosas@suse.de>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260313182957.28432-4-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qk1-x732.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



On 3/13/2026 3:29 PM, Fabiano Rosas wrote:
> The global variable general_user_opts is being assigned twice, losing
> the reference to the previously allocated g_hash_table.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index e56470a374..afccfc2935 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1099,8 +1099,6 @@ static void riscv_cpu_init(Object *obj)
>                               "riscv.cpu.rnmi", RNMI_MAX);
>   #endif /* CONFIG_USER_ONLY */
>   
> -    general_user_opts = g_hash_table_new(g_str_hash, g_str_equal);
> -
>       /*
>        * The timer and performance counters extensions were supported
>        * in QEMU before they were added as discrete extensions in the
> @@ -2751,6 +2749,7 @@ static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
>       cc->tcg_ops = &riscv_tcg_ops;
>   #endif /* CONFIG_TCG */
>   
> +    general_user_opts = g_hash_table_new(g_str_hash, g_str_equal);
>       device_class_set_props(dc, riscv_cpu_properties);
>   }
>   


