Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D273C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:14:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjDs-0002rz-QJ; Mon, 11 Mar 2024 13:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rjjDq-0002q8-0v
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:13:58 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rjjDl-0001Be-7c
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:13:56 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e64997a934so3603698b3a.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 10:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710177231; x=1710782031; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/gvBsmeDiq6oCHyIO7NASEo/+7Is5cIMsD5RC/jrJwc=;
 b=vFvKo0rz/IcWMQ6ZfUKqagzSaX1YH8dyPy8p37wxs1/TLT+xgOP7xnz7Pw+2mduGFG
 Btgb/smYpu4t3mPYYAh4Ui0Xf8OlDZ/vPfApPM9h8yXbMSWOS/TIxggKigk0+uAx5DTt
 LMhQNXfxTUKFXm8dZbLbCXHvvZpCpmVNvK0g3qp3qYvLMISTEfYtdVRjJILCuAu7KH6M
 40wFedqGttYzkInEceXUKv5MBuh77wJgPyxBDWiDW0kyOGf+TrUNfzGc7rBfgNrsiIPS
 EAo66JCBdbyJ/1FFBgTErJ9d7GSKDrLNcoM8Gvgv9g70TEvuCpnQR2SUR1sApqf4QThA
 9IqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710177231; x=1710782031;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/gvBsmeDiq6oCHyIO7NASEo/+7Is5cIMsD5RC/jrJwc=;
 b=abgKxFJ/qErHNN5b88NLYDKeO2o/xvqKSENc2rc0nuDguvNXJnADHoNJroVk8/z4lL
 T4bZERrSUKuxeUdM+6kjTYTedQuPA30hBfRsTvu1/gvh8k/DGbe4hKi7zACclM7bqmYC
 sE61VCBBVIShQ2EN6WyIYZaLwveA99nH0RyHvlg37arFOAPJV6QS250wggAnB403vqVt
 bDZ7RmaK8Dhv/GI/yiulIG/Nhu1iZsYmrWmehtdIK79REA3GcKp/e2mhDP6Hvxc+gHSC
 SatfATlvg5uS2EYrqUmR6euU1mPxE31tryaY+KY/dFTbq27O5MmndQpZbHJAu4w9hFWv
 XqIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWycA3ji+jUPgLJZOcT0q7fLrQOcbDREoDrz2CvjVifXKVJJ4FABX9IbFCqA6AvnSqK/gPfhnZkg1k8T7RLtRnh22rf1es=
X-Gm-Message-State: AOJu0YxIaaSp8jA4bgRCTDsV15T5x7pIyTHUJAGYeD130d0OtNIoBTTT
 BA721NfJbzhGIgRlh5Y9/m3o0g08E1ZXVXYBjYJ+lyAG6Uw4U/qUsoBDmnVfJSg=
X-Google-Smtp-Source: AGHT+IEtJJXJpMviRJvxIwRvTfDzDmzBRxW9POpWApvYxRNXzhK4EVhklaIO7HfYb7J4yy3oFHOZYA==
X-Received: by 2002:a05:6a00:9389:b0:6e6:721d:f46b with SMTP id
 ka9-20020a056a00938900b006e6721df46bmr1167577pfb.25.1710177231297; 
 Mon, 11 Mar 2024 10:13:51 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 gx20-20020a056a001e1400b006e65726ab93sm4699700pfb.143.2024.03.11.10.13.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 10:13:50 -0700 (PDT)
Message-ID: <1cae03c0-7506-4dda-8ad4-dec865a11a7f@linaro.org>
Date: Mon, 11 Mar 2024 07:13:47 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/7] target/riscv/vector_helpers: do early exit when
 vstart >= vl
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 philmd@linaro.org
References: <20240311135855.225578-1-dbarboza@ventanamicro.com>
 <20240311135855.225578-4-dbarboza@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240311135855.225578-4-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 3/11/24 03:58, Daniel Henrique Barboza wrote:
> We're going to make changes that will required each helper to be
> responsible for the 'vstart' management, i.e. we will relieve the
> 'vstart < vl' assumption that helpers have today.
> 
> Helpers are usually able to deal with vstart >= vl, i.e. doing nothing
> aside from setting vstart = 0 at the end, but the tail update functions
> will update the tail regardless of vstart being valid or not.
> 
> Unifying the tail update process in a single function that would handle
> the vstart >= vl case isn't trivial. We have 2 functions that are used
> to update tail: vext_set_tail_elems_1s() and vext_set_elems_1s(). The
> latter is a more generic function that is also used to mask elements.
> There's no easy way of making all callers using vext_set_tail_elems_1s()
> because we're not encoding NF properly in all cases [1].
> 
> This patch takes a blunt approach: do an early exit in every single
> vector helper if vstart >= vl. We can worry about unifying the tail
> update process later.
> 
> [1]https://lore.kernel.org/qemu-riscv/1590234b-0291-432a-a0fa-c5a6876097bc@linux.alibaba.com/
> 
> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
> ---
>   target/riscv/vcrypto_helper.c   | 32 ++++++++++++
>   target/riscv/vector_helper.c    | 90 +++++++++++++++++++++++++++++++++
>   target/riscv/vector_internals.c |  4 ++
>   target/riscv/vector_internals.h |  9 ++++
>   4 files changed, 135 insertions(+)

This does seem like the only viable short-term solution.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

