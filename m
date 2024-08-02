Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6184C52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 05:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZl0I-0003KR-8d; Fri, 02 Aug 2024 01:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZl0F-0003Hu-6k
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 01:38:59 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZl0C-0004kr-QY
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 01:38:58 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2cf78366187so5198390a91.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 22:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722577135; x=1723181935; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c+9sBtiZAjrr81TBDIdY/JfIv4KYPYV/s5wq5dTS7nU=;
 b=dRulNQbLsBCUrx62un5I7YnqHmBcAsJPVYaRkmePEEz29mf3bYaxRTBNZB33bWMQyS
 rjtU8M9EB3B/MUPE1GXctP5yZstmerN8woUxmvjYR1D9m2l8m07wJXZoZQUGmCIZ5o4H
 m8Ouzfsi8lMyDE8MFhVMoupSMLXSxOgqv+8aPxzq99GSqBqzFk02d7QH5TM+AmAzvecw
 R+0TyBxwhtT35iG5Akjd8X4q66QTytpqlaYGZo9B8b0aLIjTcaOGKeMepTkU6CWH9So8
 JdniTKJbwmn8rw6lXLIb9q/MXWZPsy56fiSpOoH4mvQ7b1xvJy5ThvC6axHzT9mm401H
 cGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722577135; x=1723181935;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c+9sBtiZAjrr81TBDIdY/JfIv4KYPYV/s5wq5dTS7nU=;
 b=jeTIbDgBJgCgGJR6d/tv7XRduQUr28GHLKS+hes2riwtfshn1IVn+xyNTkSL+gpQwB
 z6M2YX+hsh9CuNb31I4asMQIglC+KGvzVBsj+/NiBfncwW2/n5fkdPmcpImT1NV1xpnX
 Qq+W3VksBj93r2zN+Jqiz3jzjwCx0afiueYEaOUFo0MAQSTnbfXs3DPrbkO6JX8ztbSB
 VJL5OmHR6rfF2Df91Ci3MYrixs8PCgO60fB2rZ1An4gp/361o1bWGHA+14GT/hejqWji
 m2jRjAeUGS7AOyNCJ5TpZLE/slS18YvnbFrxbGMRTpISU8dMlfecu2aU3VopWOWo6nN9
 elDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQR6CEQ+7M6zJFQwbA/5TIbw7av3UCbtCZpmPTpRrnWwLzswZpgeXAdqPeLU0apEUriT74+dZLUXWNLQN2lKBxtKvkUVk=
X-Gm-Message-State: AOJu0YzVyfPc+rdwxtE+KzkwQacjUgBgT2wIN3JVwsrEAg4rtICpZfDz
 8N2J4ZbAvxBMaUlmEMKiYPr8htOxG2d1JNKiJ7kw5zSs0KqL8Mgr1ex1pZva8tI=
X-Google-Smtp-Source: AGHT+IHy2/HGYjpQ0tWMrYhDLbb9WYaXDGwfxw0o+VR2d0kxvcnIFRSBUw634bAu05ptgUsNGPcOwQ==
X-Received: by 2002:a17:90a:e997:b0:2c8:6bfa:bbf1 with SMTP id
 98e67ed59e1d1-2cff94494bemr3125775a91.23.1722577135204; 
 Thu, 01 Aug 2024 22:38:55 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cfdc4064c3sm4336749a91.10.2024.08.01.22.38.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 22:38:54 -0700 (PDT)
Message-ID: <6a533a62-ed00-49bf-8922-fe1d30ce0857@linaro.org>
Date: Fri, 2 Aug 2024 15:38:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] target/riscv: Remove redundant insn length check
 for zama16b
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com
References: <20240802031612.604-1-zhiwei_liu@linux.alibaba.com>
 <20240802031612.604-2-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802031612.604-2-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

On 8/2/24 13:16, LIU Zhiwei wrote:
> @@ -47,7 +47,12 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
>       REQUIRE_FPU;
>       REQUIRE_EXT(ctx, RVD);
>   
> -    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len != 2)) {
> +    /*
> +     * Zama16b applies to loads and stores of no more than MXLEN bits defined
> +     * in the F, D, and Q extensions. Otherwise, it falls through to default
> +     * MO_ATOM_IFALIGN.
> +     */
> +    if ((ctx->xl >= MXL_RV64) && (ctx->cfg_ptr->ext_zama16b)) {

I think you meant to add the mxlen check in the next patch,
because you modify this line again.


r~

