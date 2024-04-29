Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67FAC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 14:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1SHD-0001xz-Uy; Mon, 29 Apr 2024 10:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1SH8-0001vt-Ov
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:46:38 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1SH2-0006Zs-8E
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:46:35 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6effe9c852eso4059774b3a.3
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 07:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714401990; x=1715006790; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vjGH4AjGJJ6OdciphAOAPhmKdLR6SKhI0S7lTbYNYZM=;
 b=LgGuJfKG+Vn7slLjgL3bZXR0a88LS+mXRiFhtuuQRpdKBk4saJKzPIinS5hsrrQtXj
 AGnN2DYPu3GRZbh0EXNLcJRgQ4OgMyr3yCws4gs1MiGhcJtCjjen/Vx8YuRWLRd3ZPoB
 xucM5QCJybvF8/52q3Scbfp44s9irAEqWleuCseNXm8lWTk4dwSsm+gGRhcPzgqYz0mJ
 OcM1vBsG5eA0Bt/ou7YQqEG/YFk4f4M1X78eDQXzLlrKsA5sFDKwrSMhZ0urd79uaegq
 OdoQOOKlZOtKX5WjqtMFxbc2lxCiX77XEP+iXQAIjDfMQczvCEdcUm+iyTLHLEUHm7I5
 AGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714401990; x=1715006790;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vjGH4AjGJJ6OdciphAOAPhmKdLR6SKhI0S7lTbYNYZM=;
 b=M9BtXwileoclTEdrXXSWWR8OiPO2kAMwlzhmbshB6F1U5qlAQv4pE/ky16FPboewU7
 7cU5A1kfpG0LaT+xJH6k58L8DW9yCuAMwF76uamTT/mPynTmQx3BlumSWsNu316HHpwI
 6djUSj6hIBypkYdLdwKo0zLtA+wy9AiFVEOZ42MLbm2Xj/iqGNZgq1lYyuk2PL+r1MZO
 SRZTDQNhgKOKtGvsbl5N2wUbHLQqBbIw8U+AzCv2nirRwGU9/ltbVXKAPLs/g2dvD3zZ
 G2P+sA38umCJlLFEWcmvwqFedLpHSwDTctqbng4JwT8zVdOQQjFNMEU7eae4iMQ4yjKC
 endw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdCrD3reQ+wfYYgL5CpbdElVJWgXUoHA7dT6OJ2DrEWXbn+AGAKyCoLKS0F19ozO9KLYg3tsAAiM5I8yyBTR7w8JVU1dw=
X-Gm-Message-State: AOJu0YxePTB35xj6XF3L3N1wpWCtC2t6J9VAbL4XCUwEAeZlopbJ2GaE
 8tKJyia4Wa0IcnBwadFQ8j0iVrwebQnzSrUaNry46LbaMDEVV7go9QpijZYqhoLvu/HtOFHaOo3
 0
X-Google-Smtp-Source: AGHT+IF+5Kxbh2F1bE7iBOwz5yag46Zs/kg5AbZHNkIIYXyBGBwHTLGNABHAK4sWG8kER8CgA0tzCg==
X-Received: by 2002:a62:61c3:0:b0:6ee:1c9d:b471 with SMTP id
 v186-20020a6261c3000000b006ee1c9db471mr10201930pfb.25.1714401989733; 
 Mon, 29 Apr 2024 07:46:29 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b006ea918dab9csm19312963pfb.157.2024.04.29.07.46.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 07:46:29 -0700 (PDT)
Message-ID: <a1219547-2d36-4f3b-b558-6da5189366d4@linaro.org>
Date: Mon, 29 Apr 2024 07:46:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/24] accel/tcg: Restrict IcountDecr and CPUTLB to TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240428221450.26460-1-philmd@linaro.org>
 <20240428221450.26460-16-philmd@linaro.org>
 <5f59c754-44e5-4743-a2dd-87ef8e13eadf@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <5f59c754-44e5-4743-a2dd-87ef8e13eadf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 4/29/24 07:03, Philippe Mathieu-Daudé wrote:
> Author: Philippe Mathieu-Daudé <philmd@linaro.org>
> Date:   Mon Apr 29 16:01:18 2024 +0200
> 
>      accel/tcg: Restrict cpu_plugin_mem_cbs_enabled() to TCG
> 
>      So far cpu_plugin_mem_cbs_enabled() is only called from
>      TCG, so reduce it to accel/tcg/.
> 
>      Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

