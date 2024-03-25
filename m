Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182A2C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 19:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ropj0-0001Es-1B; Mon, 25 Mar 2024 15:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ropix-0001Ec-7U
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:11:11 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ropiv-00064Y-L4
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:11:10 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1de0f92e649so32907105ad.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 12:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711393867; x=1711998667; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l2aB34pg7RPuUIMLi3XCR2gYk2fLzQA2R+5W7T0tIkw=;
 b=y+XxgLpuBpoOunFJjPEeoqXqkvSmPExij6WQH1l7gHDCY0yzzsSsvIUK1ERExMDRw9
 IlNH40qI2X22KIZTyHofZlHSopfhirceH2F1fcg6Q6F7e75v9g2bbiBf6xWS0ZqNKS/2
 0hMmcJMFCO5G9kJEhcbaU9d3EHhFUjreaYl+YmsPb5w9vaD2oc/RtP6+e41VMfWwdHqi
 mb7sPNW4H7wptwZRflVozEOwdh4mj/GME2i+vM/Wz75InU6t71ZiUhyGgaG4qBGjHybf
 lakjQktnVHt7rmCMvqXqi7JLFeOlWelUvFETxL5dN9NZLE+LGPQVf9cjezq0iP5L5gXd
 BMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711393867; x=1711998667;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l2aB34pg7RPuUIMLi3XCR2gYk2fLzQA2R+5W7T0tIkw=;
 b=JhSHUZA5ufG652zxPbwruuFhQx1ZcHGS3eI9qh+1ydjZc3LnSyz3bip3kwm+w/3bv7
 Rk1IrNBkNRRWZAYpFuogJKDLEhiy6GYN9tIh1oLYeGqOo6DgTO289EJN7X4NZlNDjHgv
 2O3XKLKuCZ4jEOtdY0nO/0NJ4v1jM0G4g9YyJIuuGPgbnF7jfKRk2Y/Cs4kQalAd/Z+x
 dijLhzm7bwFO/MtROc+KL5hVeXexjtWeZxIc7D/tbyBoaS2lxuX/N0M5ArzIxhjDeBOI
 nmLn4deaqgy3z13/p5TuROqkyPsSmaBDI6HlaBzxBThpGog6uhdvRDhtk2gX1bFrVvl6
 AhPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVknMiz5yqhaU7LU2Oxw9hvYUKJvQw+AQwzCABBtrpIXOZO34eZf8i6yOVnqiNSJMJeR0JLHtTeVRVFckMYptuOfHm8Rr8=
X-Gm-Message-State: AOJu0YwuctvEzL0eShOFlfiQOOGfkvhEPE/l2UQrghfWg/9Mll/p0GwA
 GI/TdHMQvQDxt7O0FgFrXCKntdj1CpH0dTkaGsq6Vq1DG8+EW+z4ERwJQov0otY=
X-Google-Smtp-Source: AGHT+IHOhjg7zwMuYwwgpLVYLc+9RdkOdWs/88d2OeJPfn9SsghDHwS4wqupAyxW2w/BM/xPbiQZ1A==
X-Received: by 2002:a17:902:9047:b0:1e0:552d:8a1b with SMTP id
 w7-20020a170902904700b001e0552d8a1bmr663677plz.57.1711393866869; 
 Mon, 25 Mar 2024 12:11:06 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 q14-20020a170902a3ce00b001d8edfec673sm5175268plb.214.2024.03.25.12.11.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 12:11:06 -0700 (PDT)
Message-ID: <09c0a424-7c4c-40db-acf6-9df5430e054b@linaro.org>
Date: Mon, 25 Mar 2024 09:11:04 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] plugins: add new inline op STORE_U64
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240325124151.336003-1-pierrick.bouvier@linaro.org>
 <20240325124151.336003-4-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240325124151.336003-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 3/25/24 02:41, Pierrick Bouvier wrote:
> @@ -152,6 +152,18 @@ static void gen_inline_add_u64_cb(struct qemu_plugin_dyn_cb *cb)
>       tcg_temp_free_ptr(ptr);
>   }
>   
> +static void gen_inline_store_u64_cb(struct qemu_plugin_dyn_cb *cb)
> +{
> +    TCGv_ptr ptr = gen_plugin_u64_ptr(cb->inline_insn.entry);
> +    TCGv_i64 val = tcg_temp_ebb_new_i64();
> +
> +    tcg_gen_movi_i64(val, cb->inline_insn.imm);

TCGv_i64 val = tcg_constant_i64(cb->inline_insn.imm);

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

