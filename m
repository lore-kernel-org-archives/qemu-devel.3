Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDE5C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 22:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUZvY-00024x-FC; Thu, 18 Jul 2024 18:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZvU-0001m1-OV
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:48:42 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZvT-00071N-BJ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:48:40 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-703ba2477bdso635463a34.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 15:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721342918; x=1721947718; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V0sl8VkOnFxACoVPoX6/tEslYK0aduS/9wjn+1L0iA0=;
 b=vxoVe+/3sUwntHkAXxd0Wx615I0t14W/oz9+lYqnJpHTV5DkQFL32Qt5FzHDS0xnd+
 9Zgxf9/7xNO0MdLeI9EubJGeDrKtIjOyFqwlnNqkjHDPynNmE6hDbHisK8Hhl2SVODeY
 W/y1kFVHLmtQfnFpzV72V+EJ/R9me3z0B0ZczrLBxOtq6SWpvRhBYsaVRpDTMuHya8vJ
 LKpEp8/Pwi2fo7mLWUT1gupIh+yNTBerW9F/Ti72Chwyl0EFd+kA4AoImRQbWio0j1Yk
 qhwbuxj3Cp5wky+tmaFz4rIgykmnX5rKshPxVhnk9xc/2xiNdBZf8PQZ8EZis1YbHEyg
 v1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721342918; x=1721947718;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V0sl8VkOnFxACoVPoX6/tEslYK0aduS/9wjn+1L0iA0=;
 b=CDKXn21i7aiqEq9kj+NNKPVr3mZdFyGevZj8btlJk9pxpViG8sFAIo98PwZj1jjIom
 ah4vdkTjw86TEp3jo3naEcLcXYNU5itqEfgxu94hkQBB7ldX+DBZHexiSRx2tUNx4yVk
 UywQcbKFTEwYxYZSjpTqjaCdXcL7mdyPXa+OooWa01g5ndn0B4PTxMfNE7CEzD5GvJWq
 S3xFc2o7AMCjTQ0kyyJkIaDb15QVc1jUn0oTVltJ8Vj+R7oOHL3gPWkTWGgSiP5j0aAG
 vI7SeikdIJgIve0FFW6J7ugXUD0RUD9/x5UP/u1Hmhl6oyz1zVIrnJCskbOdQH38C0iB
 LSwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlyVvXx4/NDwXquD+eWbWOi+xeUdtyb2RQz8nB0F2sfSJepa91OrYaQpk7zE9/Ah7x59GJ7NsNXkZocv5OmV9qNKj2AJA=
X-Gm-Message-State: AOJu0YyIwoqQgaZcrEQUlvRWartIy8OskivXjt5+gfzl7Ux0F6a7iEtk
 L8SFBKFr0ZgzUEkUtoAWLltsnVgK496EaPmTbnOTX4oT96qV4ktUi6ND+YRHpWM=
X-Google-Smtp-Source: AGHT+IE135VuVNe+HuHptSRxrfSyt2QndSiOzQncS4Ewr2RXyAU03iEXe114MII7KHez849LY+yQ+Q==
X-Received: by 2002:a05:6830:2803:b0:703:5f9f:82f2 with SMTP id
 46e09a7af769-708e788bc80mr7732869a34.18.1721342917965; 
 Thu, 18 Jul 2024 15:48:37 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-79db6122bb2sm100003a12.22.2024.07.18.15.48.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 15:48:37 -0700 (PDT)
Message-ID: <0d9fc91b-c3bb-41b2-a6b0-10d70f1d289d@linaro.org>
Date: Fri, 19 Jul 2024 08:48:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/18] hw/loongarch/virt: Replace loongson IPI with
 loongarch IPI
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240718083842.81199-1-philmd@linaro.org>
 <20240718083842.81199-17-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240718083842.81199-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 7/18/24 18:38, Philippe Mathieu-Daudé wrote:
> From: Bibo Mao<maobibo@loongson.cn>
> 
> Loongarch IPI inherits from class LoongsonIPICommonClass, and it
> only contains Loongarch 3A5000 virt machine specific interfaces,
> rather than mix different machine implementations together.
> 
> Signed-off-by: Bibo Mao<maobibo@loongson.cn>
> [PMD: Rebased]
> Co-Developed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Bibo Mao<maobibo@loongson.cn>
> Tested-by: Bibo Mao<maobibo@loongson.cn>
> ---
>   include/hw/loongarch/virt.h | 1 -
>   hw/loongarch/virt.c         | 4 ++--
>   hw/loongarch/Kconfig        | 2 +-
>   3 files changed, 3 insertions(+), 4 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

