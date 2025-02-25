Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2C7C021B8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 16:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmxMu-0007FE-Os; Tue, 25 Feb 2025 11:01:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmxMs-0007Ew-H0
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 11:01:10 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmxMT-0001uj-Cl
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 11:00:51 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2fc1c80cdc8so8963280a91.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 08:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740499244; x=1741104044; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b9XTk6z4K85n+ytR1q2JSu2SAm4/EuJxyo7sSPvd3R8=;
 b=OAErEfWoei4UZOI4f9+86cPGg9Wrwuyr65b7FcvubzcR5WBE4vcPDHDDkZAvsEIkDo
 RwR6rqktkP1a7+iM4lgQra24fvf1LJw2+FuEcNa0wf2x6LqMSDD66GF8n8xDXMHoNl1H
 crmZQCAdg3f9dgQc+eEbM7U4vVn4UJ3v8JsUXxp5ab4rHSPxRbzEnczm9Tq/5SYkqkcv
 uNvHhBd6pE/3Ey/3pJTdI7c1AovhvCyvDqYWYMNXxEKdqxWmZJuXcPUi97/WfOqlWTZT
 7ZOROhMd3/yBI4vql3BoW0R8aoUkas5dGrXa0BjGJ18Qw1BRzd9/A1cnswXbMujKpKBe
 ZyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740499244; x=1741104044;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b9XTk6z4K85n+ytR1q2JSu2SAm4/EuJxyo7sSPvd3R8=;
 b=LYr03ZNQorD/8qpcVBzsQTOV0y6k9H2FvFqbtrBezFM3ZYkUnrvHDHhRspZB2cjaWy
 YQmMjLJ1/ZrlHJV0+vzw+l6GGhi76RkTxml7cAR52ol+G4AnmdYl52u4wgJTDABBr5aQ
 9Nf1SFsHCWcY7FdGFczIF07gKcO/7LEO/PHteLvXHL0SY7fh+FTB+iv6fFwocZzidFI8
 iaY95Ysw5Ad+I+XD5GjVkTNVpvYJAiYDOwCIdxc8ScPjWG1jkEP39FtxIlWJdRCPzogU
 4dzkJzh5RH4zxFz5+IwyyEhc30m5V8sXoD9iED4DobCQJ+65suvVC+9L3UItmsmG+lsf
 CCCA==
X-Gm-Message-State: AOJu0Yxkgy5kzvTNh9oP1daArk4TFz1vAIWF9RYlB5nBFXvgHUXrhVMO
 Szms1CcR4PfCGPn4zRBZi8EAZgbDf3KCzw0kYn3HtW4j5rYX5LVA0IV1C9uTm3BMRXe22gG0m58
 e
X-Gm-Gg: ASbGncv4QDqyp9f1xZR1wN9MSZ67VYFHS3ux4YV7N89yZEMfkpyLxnKVgXMiirGxy6m
 JN2ry/X0zszr4pa5WOnEhiSm9A1KSYVSS+/I74PFiEhJuSw2mII/n40b2PJ6yu0/+xxH069Tc13
 Lv3GR59d5ov0YdPI5VA9t1XTtYR8OsRVokw7uuHr2Lm2JG9jsA3ClKXuPpVSoRYCELQMBjl7LsX
 bT7yqbcDNUacLZPMfM8oQIhdZ32MdpFSHi22pmGl/fMz4Pqs2VuMcuv8BIiky5o8Ymk2n26ZceR
 HYCbkfl6FicYuzzzn4ILVZxLdk35uWgzc/6tilKcSLlI5nBLygyxlWv0VWHqUfpKONNmLZIQLWp
 r+cDA/TA=
X-Google-Smtp-Source: AGHT+IH6mN5d2F7F0Eg6bVGtMsN6nY8oZRWgks4djjtb+uT36dDOqYcBcBzaaP+Biqn51ouIqkDCnw==
X-Received: by 2002:a17:90b:2d4d:b0:2ee:f550:3848 with SMTP id
 98e67ed59e1d1-2fce7699f42mr27118546a91.5.1740499243597; 
 Tue, 25 Feb 2025 08:00:43 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe6a43cdfbsm1763103a91.33.2025.02.25.08.00.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 08:00:43 -0800 (PST)
Message-ID: <549677f1-00a6-4ae5-bfdc-57dc52a70ab4@linaro.org>
Date: Tue, 25 Feb 2025 08:00:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] plugins/api: use tcg_ctx to get TARGET_PAGE_MASK
To: qemu-devel@nongnu.org
References: <20250225110844.3296991-1-alex.bennee@linaro.org>
 <20250225110844.3296991-2-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250225110844.3296991-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 2/25/25 03:08, Alex Bennée wrote:
> Requiring TARGET_PAGE_MASK to be defined gets in the way of building
> this unit once. As tcg_ctx has the value lets use it.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   plugins/api.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/plugins/api.c b/plugins/api.c
> index cf8cdf076a..10b258b08d 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -287,7 +287,7 @@ uint64_t qemu_plugin_insn_vaddr(const struct qemu_plugin_insn *insn)
>   void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn)
>   {
>       const DisasContextBase *db = tcg_ctx->plugin_db;
> -    vaddr page0_last = db->pc_first | ~TARGET_PAGE_MASK;
> +    vaddr page0_last = db->pc_first | ~tcg_ctx->page_mask;
>   
>       if (db->fake_insn) {
>           return NULL;

NACK.  While this currently happens to work, it's the wrong api. This value is only live 
during the compilation cycle, and this part of plugins is not that.

For this, qemu_target_page_mask() is your huckleberry.


r~

