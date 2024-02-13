Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A16C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 18:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZxRu-0003LK-8p; Tue, 13 Feb 2024 13:24:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZxRs-0003L8-OG
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:24:04 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZxRr-0000uh-4q
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:24:04 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e10404557eso350530b3a.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 10:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707848641; x=1708453441; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ezMV5YSX0DBdGevzgv0CsrugYnBULTvRoeOTg3DSlbM=;
 b=E7hPKJok/mwAPZf8Qcv8IVMAhQMzc9+33BIehwuJC53N1WAG7OTEh36Wrd/nOGSCEU
 n4KNpW0Wfv+T2WOlAWeEjoLTonlAT5r1p8pDWxx9ASZB7Wo+fbD5yr1Zc6BmksyDp+hO
 WHGLAgOoiz1YSBNQ0pz/H4GyATZuRuC2hsiUolbOgABW6X9RdE/6Elfz/3cEab0isxfp
 FlX7YZCttATBzuUtUCUB4Pt6P15D5N/xJDBSotrncLnctfyqfV+DI4yjz3GH+H0H5kdB
 QBppxCb9jKx9wqhKp3uP4FM3542j0hzLfLZZ+Ha8LNVGmhXCS3B/5KQ3liEi0c5RUCkC
 potg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707848641; x=1708453441;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ezMV5YSX0DBdGevzgv0CsrugYnBULTvRoeOTg3DSlbM=;
 b=H2LdVtrdTSgfeJsPRGZ6FTpiVKeqEP2H/3NGJnFNaArHsxYdGgP4ulb6ctJvDJVjua
 rePtdVc7FZXyRKG0Wxhp+k8xahRyQFGS2yzQtRegr689qNOfHw1w4hhVOJ30/6WhnDlI
 SD3jF6ZdXTTPlQci9AKRauq35hXxMGv/U1ROE+FkQ7n95BvAu+7HqK8eY66YAM5OuymM
 7qsGEPRMZhBsUzNgfxPQ0HgPDe7x+8loJRbC3WOlKLh9g/aUw06mDnbYwziF7EtjcHDS
 RMBzMJqIz2HBYV2ejLoBo0NHGgZJqftzwONtkP985x95T2JjrLNXXe15uHxsdFupkokV
 OOsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlFuhXONUTujXr3hhQz0iueHFpkk8VibWv0K8rSTjV0tivKUAYDR41ss4Kw4/d9VnNri1rJcgqzNm9iDqAze8opnicZ30=
X-Gm-Message-State: AOJu0YwFPndLU9wekbiX5qhIwgVgTNTnYB4vHI8kJrd5vAhh8X0UOO7L
 eTt9mYK6e6PJ5wgv/M2v6YK2+aWj+HXCp0sf5tsmI8tDzfFlkwnDb1hm7U+ENeJi/L3E/do20/I
 U
X-Google-Smtp-Source: AGHT+IE3j7xUMalda6swh/stlvkDeXqkySAx9qPyWtIZruyw3pt+vf7weM8zFXxW72dSgmPAy+u2cA==
X-Received: by 2002:aa7:9a43:0:b0:6e0:9f24:af4a with SMTP id
 x3-20020aa79a43000000b006e09f24af4amr90645pfj.7.1707848641562; 
 Tue, 13 Feb 2024 10:24:01 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV6u/ZBPFXk4BsRwfppiP3usPmw42y6coUWensRq1JSMaGUXvhbRutXVZy2vpui5ENibkqcTpi5Ek6jGxZue7IebH+752o=
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 m15-20020a62f20f000000b006d9b35b2602sm7601317pfh.3.2024.02.13.10.24.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 10:24:01 -0800 (PST)
Message-ID: <88ee7217-c766-416e-9f3a-907ca003a063@linaro.org>
Date: Tue, 13 Feb 2024 08:23:58 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/18] plugins: scoreboard API
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
 <20240213094009.150349-6-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240213094009.150349-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 2/12/24 23:39, Pierrick Bouvier wrote:
> We introduce a cpu local storage, automatically managed (and extended)
> by QEMU itself. Plugin allocate a scoreboard, and don't have to deal
> with how many cpus are launched.
> 
> This API will be used by new inline functions but callbacks can benefit
> from this as well. This way, they can operate without a global lock for
> simple operations.
> 
> At any point during execution, any scoreboard will be dimensioned with
> at least qemu_plugin_num_vcpus entries.
> 
> New functions:
> - qemu_plugin_scoreboard_find
> - qemu_plugin_scoreboard_free
> - qemu_plugin_scoreboard_new
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

