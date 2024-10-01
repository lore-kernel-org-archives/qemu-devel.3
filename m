Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69262CEACE8
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfrW-0003oS-NL; Tue, 01 Oct 2024 12:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1svfrT-0003nz-K1
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:36:32 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1svfrO-0005pN-3q
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:36:31 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7ae3d7222d4so4912560a12.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1727800583; x=1728405383; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PpOtqP90E4Q6mUPyAcuNdqtxXQ/kO96V91KNrsTZRmU=;
 b=PWjN0FMs+ecjfcNaMvn53v42ZOeqH0WyoAlXjMzD1FmpRHqPSvrOPR2J0SZrWS7cST
 qRmTQhGmOBIJ7Rt+LeUE/o4V0WMR8Fy5GM/yfiRUSOxyfLHxaxQ9WMffZTvfdVVrdO3c
 3m2uoTm98A7inYQsnANpcRol5cv4YpVLtDTqfjbKBfCC5YxVibCHXA6YSsTCFsoN4lpy
 nvbjEw6wYpRnaOZv2p0evWjJwyYIPeK/j00nDqRpBul5c8IV+PPiXcKp71qUVTFBaShl
 baxraq4crSLMxHBSHdpK6yewmm1AArNnhXVVEzvFuJvCqMQvkN/lwTbDF7MdQkw4X1cp
 JnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800583; x=1728405383;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PpOtqP90E4Q6mUPyAcuNdqtxXQ/kO96V91KNrsTZRmU=;
 b=m1qc/ewEYs0aM1w0GqJ6W+EcL8/bzaG2JipqgJkYDP15ini9CkUmPaW6voNVgbgFJr
 2uhlTIaNrlAJqsYMO8uIiUUpK1actilxSJ0O3kfLToWejEnO6k5/4ItPN6+QQQ1+7all
 bABtluocE4qCreQ+f6lGpA+KY2/DBJuDrR5ZEM70Xe/9BdF0eweEc9n+DntRQS3KwMsm
 j//vj+1ZpLiE+q/yOkFnuS8vnM2geM67lL8ayabVrmsC0H4n/FqLXiBmeIb2R1OpqkVE
 MBgriiUmWSnAUswVNhPW+mdgdGtW69fqQ6mH3+Higreapt4Y5DbA+P4VXgJJzk+TClMa
 Az8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSEYAT+zXfvZElp/umftRo9w3wZvO8LoQJdDKJvjE1U3nIn/XGOziE2NzprQtMnuEJWYY0wcsR6l/u@nongnu.org
X-Gm-Message-State: AOJu0YysTyDeLfnygPmJtF10G67RjG0IQmd8apm74Apx/NsfU4yvZsNK
 5i7BNDQEd0CmBUkc/uuMtk5OaeG+f2BgBxYCsWJX3k5zlTK7vlrye2ad2jxXYd3so0L7aKrsvrY
 U
X-Google-Smtp-Source: AGHT+IEuWnNk5Y3kiGDHLS+eK1AWTAfVuf6KPqty+mz4A+w1rTYR6pSiPeyu7Ibei+520ZVJ9geCBA==
X-Received: by 2002:a05:6a20:2d28:b0:1ce:d418:a45c with SMTP id
 adf61e73a8af0-1d5e2d54c41mr375029637.50.1727800582840; 
 Tue, 01 Oct 2024 09:36:22 -0700 (PDT)
Received: from [192.168.68.110] (200-206-229-93.dsl.telesp.net.br.
 [200.206.229.93]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71b26517bcesm8490047b3a.99.2024.10.01.09.36.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2024 09:36:22 -0700 (PDT)
Message-ID: <b1ce0a4b-9e05-43de-a22c-90daae45ca22@ventanamicro.com>
Date: Tue, 1 Oct 2024 13:36:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/1] target/riscv: use a simplified loop to emulate rvv
 loads/stores only in user mode.
To: Paolo Savini <paolo.savini@embecosm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>
References: <20240925151330.50215-1-paolo.savini@embecosm.com>
 <20240925151330.50215-2-paolo.savini@embecosm.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240925151330.50215-2-paolo.savini@embecosm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x535.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Paolo,

Usually we amend the existing patch with a new version instead of sending
a new patch to amend a previous patch that got comments.

I suggest you merge this change with your first patch here:

https://patchew.org/QEMU/20240717153040.11073-1-paolo.savini@embecosm.com/20240717153040.11073-2-paolo.savini@embecosm.com/#aff5f930-d291-4ff5-8f24-53291059d59a@linaro.org

Set it as v2 and re-send.


Thanks,


Daniel

On 9/25/24 12:13 PM, Paolo Savini wrote:
> The simplified emulation of vector loads and stores that bypasses the memory
> probing in the vext_ldst_us helper function seem to benefit only the user mode.
> We therefore limit this approach to the user mode configuration.
> 
> Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
> ---
>   target/riscv/vector_helper.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 9026661573..08f71abc22 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -648,6 +648,7 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
>   
>       VSTART_CHECK_EARLY_EXIT(env);
>   
> +#ifdef CONFIG_USER_ONLY
>       /* For data sizes <= 64 bits and for LMUL=1 with VLEN=128 bits we get a
>        * better performance by doing a simple simulation of the load/store
>        * without the overhead of prodding the host RAM */
> @@ -692,7 +693,7 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
>           vext_set_tail_elems_1s(evl, vd, desc, nf, esz, max_elems);
>           return;
>       }
> -
> +#endif
>   
>       vext_cont_ldst_elements(&info, base, env->vreg, env->vstart, evl, desc,
>                               log2_esz, false);

