Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E195BC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 21:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmKLo-0005Iz-2E; Mon, 18 Mar 2024 17:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmKLm-0005Ic-M7
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 17:16:54 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmKLk-0001nJ-WF
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 17:16:54 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1def142ae7bso30832655ad.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 14:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710796611; x=1711401411; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pc6K+EVuScLxkRdWMXZ3dfKtbz1nm5lvHKndCLRYXHY=;
 b=j0FzsodsrKSsP/52EGNmsIC6NLhpgYln/DSKDMAXy0p3e/VGcmRMCFp974IMgP+lHA
 pbqlPGYXpT127MwFGIlRLqNA85kijTymEGnx75qT7S4hZlIZS1VSbzfEtq+RlhMD1DZ5
 bcQ6Ysx4SmHBvA4mKs/GSe25h8/9Q5eaEgV044JFt6jtoRq3u5L2ITkx8lflCPOiq+Vd
 W9Z4olVzXPIuMd9P2XmrUw0kK6M3KEewqpAZu41Mq6rO4WABhFNLX7p3zfy2PnstcnA8
 Ke9CKBJjDnNpGQlPKFxVOIV0eh000lqvTEAvyK2rNtY6mlh/feQl2FweiGoCw8iWw+mL
 nVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710796611; x=1711401411;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pc6K+EVuScLxkRdWMXZ3dfKtbz1nm5lvHKndCLRYXHY=;
 b=BjR62Fyj2ZMAA4SYMwLy81/r3miYhqdR7MVS5FjUFfQgEKVs0Utbk9tafaS/42Ifxm
 ocQtgnR6JLl3b2Nh3+J3lXB2+Po1cweG8GYA7ueintw6HroRli1DmqGIMCLKLfN8Z5t3
 Jqk7x0D4MJO09gmPdNUJW5MZ3jqO+QIiwxBwWBoMnHPGDu3u+9Noiz0c7JzleKo5Rzs5
 a4Iit6yKL4wnzjEU9trcrS/eenWD1Vcs4clapx/b2ptlHvSKLileeTzIFQJ8OdD516xw
 7sj0ykZ3mM8kaAJ3Spv+IGjUX7i3i7snTji0oE9VJjqN3YBuLuy1oP/UD2Qv6InWO5Ki
 K8HQ==
X-Gm-Message-State: AOJu0Yx7V341ozgFxOQsi+u0Y3ELJUEMPxoX3pYkLdxW7sTA4iGI+xAt
 wxYGKcs+jKl3HPOH93Xqxbo0kfQ+kBR/cI6JU8c4vigFLccQ7Lb1tyJ3/neGnFg=
X-Google-Smtp-Source: AGHT+IFQzsLfTSRPCIlCmNFA5yravw2mFo9dERKnFvhZbGjLsZ/b4cnKNnZxuJgXmWUjheuqeQghZA==
X-Received: by 2002:a17:902:6504:b0:1dd:651d:cc3d with SMTP id
 b4-20020a170902650400b001dd651dcc3dmr13259071plk.4.1710796611299; 
 Mon, 18 Mar 2024 14:16:51 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 l9-20020a170903120900b001dd4fabf695sm9761913plh.38.2024.03.18.14.16.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 14:16:50 -0700 (PDT)
Message-ID: <e30d9cbf-900b-4e9b-8a56-4ea0d5c80d8d@linaro.org>
Date: Mon, 18 Mar 2024 11:16:47 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] target/hppa: exit tb on flush cache instructions
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
References: <20240317221431.251515-1-svens@stackframe.org>
 <20240317221431.251515-5-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240317221431.251515-5-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/17/24 12:14, Sven Schnelle wrote:
> When the guest modifies the tb it is currently executing from,
> it executes a fic instruction. Exit the tb on such instruction,
> otherwise we might execute stale code.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   target/hppa/translate.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 8ba31567e8..58d7ec1ade 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -1940,6 +1940,7 @@ static void do_page_zero(DisasContext *ctx)
>   static bool trans_nop(DisasContext *ctx, arg_nop *a)
>   {
>       cond_free(&ctx->null_cond);
> +    ctx->base.is_jmp = DISAS_IAQ_N_STALE;
>       return true;
>   }
>   
> @@ -2290,6 +2291,7 @@ static bool trans_nop_addrx(DisasContext *ctx, arg_ldst *a)
>           save_gpr(ctx, a->b, dest);
>       }
>       cond_free(&ctx->null_cond);
> +    ctx->base.is_jmp = DISAS_IAQ_N_STALE;
>       return true;
>   }
>   

You should create new functions for fic,

static bool trans_fic(DisasContext *ctx, arg_nop *a)
{
     ctx->base.is_jmp = DISAS_IAQ_N_STALE;
     return trans_nop(ctx, a);
}

because fid and pdc also use trans_nop/trans_nop_addrx.


r~

