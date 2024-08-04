Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91656C3DA64
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 07:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saVdW-0002aR-Q2; Sun, 04 Aug 2024 03:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saVdT-0002Zt-Iv
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 03:26:35 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saVdR-0005IX-Qg
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 03:26:35 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fc4fcbb131so82191065ad.3
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 00:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722756389; x=1723361189; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X2y6oeL7r4Rh8/M/UWLHR82kj3IT1sRHyyh6+9CHl5s=;
 b=c/xPnbtK3aNfjwtri2A+486XiYHqW5o4Za8RLI2wsxHjHJ064DyW+mv10aogtWPmv3
 NeDBvBfx7jpTaNy228E9DX8Jmu3GZ2TT2Aacu99LJHdRKz8rfbuqqTOnoKnsWT12CIVg
 kkCr+OrUvWF2ZGOVBdlQiUVVXqJpUbvEv7qhQlUD7XoDNDvXAsBzE4gPLFHsqDh6Y5SM
 yo0BmS2uG9wce+vDTz/zqixmdpIDLf66sCe4hsk04wz3VeSeRc7mbX8os0NA8k/pKjvk
 gIQxsZQoP1wf2GsReCJLGasS9a8FzJC+LnEYv5TDPSthQXpXDXpRhAlA05ZCjyWPynsw
 7aPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722756389; x=1723361189;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X2y6oeL7r4Rh8/M/UWLHR82kj3IT1sRHyyh6+9CHl5s=;
 b=vjE1VdY4uyrQtv+yGI5299dGxctiB7ejijOjRjSNzSucHy+nnkQhrQByBeoQ96hW0Y
 7hqOotu6C1mMBNGY20WnXB4RuV02xWoWG38Ly+s7bMkfSXig8A2+fY4aLSKBWk5cpxxE
 LmLWgYKbRa7ELl9cQhcUq8FiWABJf3+awCvZlDEb6KdsqAzyx4Zes1DUmPuWQajOtU1n
 SYpEo7HsvWwZLlID4j3CUe+Xi01lkRsem9KUKAqbZRjLcul3fFnYCQix+T1wub6HCQCi
 GKanog1C9hldBCGCFWbTicijjfh+IscBy2+qaKcPMikFDZc5IfGvrS7SWntbKyu5/3X+
 sKrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK2/ryuaqnrZNDdtr0A5e/OSFKwJrnEWSxEwwNsKM9n5C93DhQxJyM7yLl57qW3HVKsonM9w+Nrx+dhSXsb5souQzbHIw=
X-Gm-Message-State: AOJu0YyC3qOqnZu/BSRm4K60T25YBWmP/HIAuAuHkxlqIWMK9gEA/H+A
 VUmV3GRe8ahJ6mvsf/FMXd+w69eY8CS74PwVsCKJvGV3m5ChX/GOU45o1LAgGU8=
X-Google-Smtp-Source: AGHT+IGYEXZTFULWdsN/oIBM5xAFpH/e1/QAo0yJWIef9VBKvW7WGI6n8YTGMnvtDs+UOQuoCGf8vA==
X-Received: by 2002:a17:903:41d1:b0:1fb:9cbf:b4cd with SMTP id
 d9443c01a7336-1ff574bc175mr111104015ad.63.1722756388564; 
 Sun, 04 Aug 2024 00:26:28 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cfdc45aaf5sm7938752a91.25.2024.08.04.00.26.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Aug 2024 00:26:28 -0700 (PDT)
Message-ID: <dfb34396-0f77-4f92-b345-b7ef05bf18b2@linaro.org>
Date: Sun, 4 Aug 2024 17:26:23 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] bsd-user: Eliminate unused regs arg in
 load_elf_binary
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Jessica Clarke <jrtc27@jrtc27.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
 <20240802235617.7971-6-imp@bsdimp.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802235617.7971-6-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 8/3/24 09:56, Warner Losh wrote:
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/bsdload.c | 2 +-
>   bsd-user/elfload.c | 3 +--
>   bsd-user/qemu.h    | 3 +--
>   3 files changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

