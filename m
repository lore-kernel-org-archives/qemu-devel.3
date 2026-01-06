Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D498CEFD0C
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 22:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdFzd-0001eH-Df; Tue, 06 Jan 2026 17:57:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdFzZ-0001dR-R8
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 17:57:33 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdFzX-0005eL-Ob
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 17:57:33 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-bc2abdcfc6fso723075a12.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 14:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767740248; x=1768345048; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=94mT/Xq91AL70g536VhaGLZdDh94TJHqcQqjnDEL68M=;
 b=LE8emPoYXGbTP3n+Ft/oH8hIuR+v41tmZRpfuulDPStcbJdqAhMvkiT0pZW4X1T/Bi
 cr2TwIHAH0F1pMcI8j+KVoPYcSxI1b1I+pK3p0JrGbtnB2hb2mVBxfNry6Hr0m0BEdO1
 WnK4+uHmL/eLulFFSU3l7Lw9ITBNWTH5BwFeZFVSAomAc+QTXvIlNGt01EG2xa3Gpi9R
 qKP/lBkplfhxkONijniLcoUxX5/X6IX1l3UYGNbjEPsXLMuaabwxklgPEucocSrk6z/3
 gojpPAGwRQpiBPW96s8tDTWMeGeiR8FVeYsQXeLu1W5H0Kw8V92F+1qkq2ZTbFnoSwHm
 8H6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767740248; x=1768345048;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=94mT/Xq91AL70g536VhaGLZdDh94TJHqcQqjnDEL68M=;
 b=JXr12oeJ+dUWyneV9UqYQmy/0+2rcjGoosTv9JTEY22EoefbqCitrYQ+fwXT5+ma0k
 ahYa0yvKRLyCZFvpZe/gnjcleSY/uZtjLrYNHXzKkOFzwVvdp1V1sQDNXap4+V7UVnFc
 FzCkhUfGtmCxV6u/TBICjFXU7alcuq4f6F4feF09y9sLecvyvrLul9s/g6QU8OntUOrR
 HFBQHQE7yDk3A5mtZjBbD6jmYqFoGBEuA46mcaltxZkZMAIAFJ2Kwqaigj4FcXoDX1WD
 UE88VAFBftLBXifujR4zv6B+FN+3H+fR3bYwFOIU9KfCZt5S5cQjQymxnSTjLUmn3ey7
 qtAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9vJdF3hzqdNoUNXzIlKd1losDqcm3GxNg+C4rTUCZd6Whve2dbL7o0rdLdhvLVVLlYYAWOu0fz5EZ@nongnu.org
X-Gm-Message-State: AOJu0YzlVG/lmMIQUOKQUmusHVzH90lty9UF/vYZAV4DTat2I+Lu7PQf
 bJEDuxYkHPh5WEQxZ8Pd9jYjuGSFeQLaW9U3MuQK+R4X3ko0V0wqgkd9t2lx9rgpayE=
X-Gm-Gg: AY/fxX5k3h25u7QUqjA5AHk06hjeb1PzsvpDQM/i+H+T8Nx1M20ULmJpOg67hD4xOlG
 Hyavz0INB5iAxOP8QnJc21fRy27uioG3gWdBbBd5DxkmcoWU1/+co/nPqmCWjMoFQZGHPGVk9vR
 PXNUCHpA7k+qv3IMyNNQv8LokFiqWd+FwnpQvvay7lINrjitile10UkxIhFoUeRuKkqeKQSHAJE
 cfD+arlTdRvDC1orCFecfkRdTmWBwa9us+OX5/nxcAbVgx/o+BbMCXrvdeSwwvYizcxP73TIeBS
 W8xISJD7Ya81llDNhB6tzqivHBDYTn6+GRhiAxgFL1vxD74ZqGiLPKMtAlKZV+udSqtjm6pvsLE
 7Eo3BdrPD7u8rHYOLDYmPKbIm9wi4ojy5bAiS4GVMunlzKHLtUWEITF9nao5+QxqbxLL0qgraeZ
 Q7434kwxQZZbFqDFLa3azz3N1u6T2w9v4QzD/rYmYDUHMxAEk7az/5REp8
X-Google-Smtp-Source: AGHT+IGnxYNNq+JSkTpxWFl5XDah5J6SBK0EqcoXZYrWtUKVKp+G3rTmhNY7+Xd00O9N9wI6CKIHgQ==
X-Received: by 2002:a17:90b:4ecd:b0:336:b60f:3936 with SMTP id
 98e67ed59e1d1-34f68c4ff5bmr636025a91.12.1767740247857; 
 Tue, 06 Jan 2026 14:57:27 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f601a4914sm1443010a91.5.2026.01.06.14.57.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jan 2026 14:57:27 -0800 (PST)
Message-ID: <4792c58b-efbc-4b9a-81bf-a4131ed5c246@linaro.org>
Date: Tue, 6 Jan 2026 14:57:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/optimize: Save o_mask in fold_masks_zosa_int
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260106225204.5859-1-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260106225204.5859-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
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

On 1/6/26 2:52 PM, Richard Henderson wrote:
> When adding o_mask to this function, we used it in a
> couple of places but failed to save it for future use.
> Also, update a related comment.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 9e397cc0df9 ("tcg/optimize: Introduce fold_masks_zosa")
> Reported-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index c546e8910b..23278799af 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1088,8 +1088,9 @@ static bool fold_masks_zosa_int(OptContext *ctx, TCGOp *op,
>   
>       ti = ts_info(ts);
>       ti->z_mask = z_mask;
> +    ti->o_mask = o_mask;
>   
> -    /* Canonicalize s_mask and incorporate data from z_mask. */
> +    /* Canonicalize s_mask and incorporate data from [zo]_mask. */
>       rep = clz64(~s_mask);
>       rep = MAX(rep, clz64(z_mask));
>       rep = MAX(rep, clz64(~o_mask));

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

