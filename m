Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EB8C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 10:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU1TT-0006Mv-6Z; Wed, 17 Jul 2024 06:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU1TR-0006Ki-46
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:01:25 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU1TB-0000MP-NP
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:01:24 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4267300145eso53057955e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 03:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721210458; x=1721815258; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0D+xL7ZXgIiMqYUQST32m6wm2ferX/Fpi4YTaFNEpKM=;
 b=uKKAsIWT1Yqjp4TQRUvTYtTj7zplD7SX5jIpeDVi2d9hod2Q1YgiJPw92mKIhXax86
 7fWyjS47M/X6YeEhaBZsjbkEvxCbKZTXumE420xI3VpmLK7JGirmEzIc70baniwqQKFo
 szh+YjpwrJrBVrNZfbh7xX04xj1RgEr27B5URg8J45h4s2l5/eexkMPdsy6MUdKgovxo
 9SiTJvMhuNYli9xCdBcQ2wSLqvkSy8PQCEMfoA8JPF9qBxTp4E2yAjuVH6IiBhKQzNa6
 xUPLtb+ia1QwQM7QLkpvVkkt7GC9YubBqF7yeS0MtSu8rlZozBIUxS6FyAA8Z5P6nczp
 x5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721210458; x=1721815258;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0D+xL7ZXgIiMqYUQST32m6wm2ferX/Fpi4YTaFNEpKM=;
 b=Q7ASDfYm6yDjTQQajXDBt6ApYmTznYaleD/mxli/YrMIUavPaAo2FR9OTest60gcGk
 wDxsVAwbui/DKpkt9RSuYUOTly888V3cMopIbbzCbs5Q4fabmhAL9cqChEMrb8YUmE/R
 48FStk5zNi1dNBxCL9Gtl5cWoIviANkZd25Cz/bR0+qHMSmvGBbsvbdeMTvkEddR+orr
 ZO3g9yCZcqgnU4B1dQSOwDbQj6Fm0wFmKJ7y34/uTKCkFKAhXg6vCabYowlWnQj5rhzV
 kEtkjgfskH8aI6YbSv1mTHr2Bq8VnlR73p/wt10bJyRD0dSyvsoRmXN6zERdTOXuqajW
 SuGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEUKYcPcovZBE5wwZ8kNE6E9k8ffaj2HqueGXyuRw+iNBSNRG7szzz4xnABEdos6IlK2I7FcI40xKvkDU/fjD+WZKfes4=
X-Gm-Message-State: AOJu0YwHXh5pKzLmjOT24SLBQwYsdvWJ19cxGzCHOvi3VBrU+MWptGlq
 SyjTdrzL4qUV2/30K9PUXnqRMwmvdK3ReBB/MA7wNbbNOjpqnq3Yl3W0AxAwNpU=
X-Google-Smtp-Source: AGHT+IH+kNwt66eUyQev4j0rU2GbwyJRXdeokfBu1QmX9mmoMkCXk+8KWRfWmn933cLhp2xvGIncOw==
X-Received: by 2002:a05:600c:1912:b0:426:6f87:65fc with SMTP id
 5b1f17b1804b1-427c2cc848emr10442635e9.17.1721210458732; 
 Wed, 17 Jul 2024 03:00:58 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427ba20aaf8sm48491555e9.0.2024.07.17.03.00.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 03:00:58 -0700 (PDT)
Message-ID: <d86b4c48-dcb0-4651-92c4-8117f9f50543@linaro.org>
Date: Wed, 17 Jul 2024 12:00:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/17] target/arm: Fix whitespace near gen_srshr64_i64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20240717060903.205098-1-richard.henderson@linaro.org>
 <20240717060903.205098-12-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240717060903.205098-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 17/7/24 08:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/gengvec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


