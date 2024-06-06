Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152DFC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 06:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF6jz-0003f4-7g; Thu, 06 Jun 2024 02:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sF6jx-0003ec-ON
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 02:36:49 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sF6jv-0003JT-7J
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 02:36:49 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42121d27861so7270665e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 23:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717655805; x=1718260605; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jXh11LLV5UiIIwnV0wa60MhOy/gY7aBK1zuzxij7RcE=;
 b=zi1WFIktO+82e7e2h5hFv/68JousnkxX60nMTiDuRFkMpqDnTF0ew0pLhSSmM5Wo8e
 IRoXrkJtOOXUzXA1LO7F1YikV5++AIc7bvZH87lI+8A33btfW5hna4pmTXLQPfJEkKP+
 ZaVVeAeQWSv7Hj2gYTvq8kStaMFUB8Bt/9AYHeZed7Ki+r4hCHBY3q1AMtEpWL2aMlK5
 QfX9lJMoQTUxJmN7tMAnf/36oD8AjAoVTFbv/fn02ewIsrQYlH+lEKlnKfzGR+oa5Hu+
 HTviMAMwoQ6UX7AtojtKJAZ8otObzSEV1JGEjbEw1i/5zC7A0O2pz7Gzps5Asg4waJR8
 u/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717655805; x=1718260605;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jXh11LLV5UiIIwnV0wa60MhOy/gY7aBK1zuzxij7RcE=;
 b=PO+PWSdsvA7LX80IenPCnHirMc5jgtMV77AjSViY5IzRTH6+34AWpqO7ZoveFceqXw
 C/ARC5NbsTvgqhH5s0Gp+vWkXh54WozleYHozzMgHhqQACaSLlFe8ukQV9XJIMRAmpdI
 E1d/irNqNebVxQssx4YYZjQilSa79cpMxlwmBYAoK4cECfD2VxEmRlyFcMoUFLd3oPMb
 MmrPzyJ5dHVYsoldIry7ye+SW6Uw52SEWjnie7GkeKdxgI3wH1CYOoJ7S6hJb/eqb+s+
 vqz+owapHCGR4htlivA/cB8Ype54RQ0kidq7gkv4K9nJBCzoxmbN17iPlXpD4+nziAwY
 k58g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC8QPDP7XcdCmOrkwxw+wImNlksrT0QutANN4Q6BiyPAr0CYC9NAmYdzIL/aCtetdk3Vt6Ka9HcqtqAmbLo34WpwKcRdE=
X-Gm-Message-State: AOJu0Yx71kRtb3DeueqdfGps20I2TmksrmPViTJcWoS1VOvSYUP7QVSN
 4swyyc43Q5tOdEGH8UlgHZJ/i7gXm7ZkfWjnP0nOAZ9uHPlg8XIO6hBWEvytCC2OT8awAI/mI4u
 5v4E=
X-Google-Smtp-Source: AGHT+IE2wEQ1zykWxPZ1fzS+8Bg5v5PrUAzyBXjgW70h5IvoPIwI7IhJVteeyh92f3yi0aBQufTvrQ==
X-Received: by 2002:a05:600c:138a:b0:416:2471:e102 with SMTP id
 5b1f17b1804b1-4215634ded8mr35605845e9.37.1717655804776; 
 Wed, 05 Jun 2024 23:36:44 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.217.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5d69917sm689955f8f.62.2024.06.05.23.36.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 23:36:44 -0700 (PDT)
Message-ID: <eef1ed0e-bbb3-4950-8224-1bc02dc81c87@linaro.org>
Date: Thu, 6 Jun 2024 08:36:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/bufferiszero: Split out host include files
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20240606051441.111975-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240606051441.111975-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 6/6/24 07:14, Richard Henderson wrote:
> Split out host/bufferiszero.h.inc for x86, aarch64 and generic
> in order to avoid an overlong ifdef ladder.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   host/include/aarch64/host/bufferiszero.h.inc |  76 ++++++++
>   host/include/generic/host/bufferiszero.h.inc |  10 +
>   host/include/i386/host/bufferiszero.h.inc    | 124 ++++++++++++
>   host/include/x86_64/host/bufferiszero.h.inc  |   1 +
>   util/bufferiszero.c                          | 191 +------------------
>   5 files changed, 212 insertions(+), 190 deletions(-)
>   create mode 100644 host/include/aarch64/host/bufferiszero.h.inc
>   create mode 100644 host/include/generic/host/bufferiszero.h.inc
>   create mode 100644 host/include/i386/host/bufferiszero.h.inc
>   create mode 100644 host/include/x86_64/host/bufferiszero.h.inc

Renaming the files as .c.inc:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


