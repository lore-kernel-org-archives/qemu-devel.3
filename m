Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D83DC25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 16:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBdS2-00022X-LE; Mon, 27 May 2024 12:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBdS0-000222-65
 for qemu-devel@nongnu.org; Mon, 27 May 2024 12:43:56 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBdRy-0007bU-Ig
 for qemu-devel@nongnu.org; Mon, 27 May 2024 12:43:55 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4202cea9a2fso50057255e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 09:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716828233; x=1717433033; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kKIIv1kzhAIHP+FYpExFq/1mDgaBLK0fR6LQvtq4mqY=;
 b=TAi8sR3GazbJyrZuThRNQOkAxU/EQjhr/XxHN/J3+Sb/AVQOGtbZAJUTGkKXjZNiah
 iZJVNVZlyHN04Ynl9j1eZF2Tex4ADJ++5uHrlZdeTGB/9eu/0S0eI82HDdq6k5cL+u4b
 6EFjxccQm3ljCmCSSFqMyeoMR1EULUmbcd/xq17Nhz3Th5yn+Io9TlJ8KZa4671Lqk0j
 N3UBdA4lg4eQS7uLeePMquy2jNDFRIWGMJzb5QX8TwbqORqWx+QSSJFlz0YnGDWkNqXK
 7LC+GZV6exi6ADclJeZIry0Op4Clj7dAQTS7SWBLz2/Pzu5T2FAXGGkdkPHjeKecRw0S
 6QLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716828233; x=1717433033;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kKIIv1kzhAIHP+FYpExFq/1mDgaBLK0fR6LQvtq4mqY=;
 b=vM+XHibqn9EXEkgJ7Pi75VIhsbj0yEXeHhgG7BWBvRngiOYSNl3tAO6d79H+lYR5rn
 DfatDcMWa14tYw9ohKwS89WrC36dpumB7slF9vU2knuB350HkHBkjKtb04Y3P/81tHG0
 yyVepheKEHbORy3hl6cuzYa6v9X1AZFpkOs0spJTuH6tpp3iy/z+dHizJc5CLN4bxp9p
 kLUKkZzXDotbeUklzYiL9f0tkib9lqISpAboD5OFd8pk/IkVcdQK+nXKpBFCIVkCDqLX
 St/oqR3+orEb0ow3HqLVXbpKZ7JRPYsCetVQRgOkJfh070i34w2qmxpAzKCIIwN/yMiD
 JJ9g==
X-Gm-Message-State: AOJu0YyiEaYNVGVVV72jKLZ1DmedS+CcA4qiUQ6NeFrAq1XGNGODYxVE
 R5vse8G5BwhMLORonKa4NdNrsvYI7FvTkEMHiWTWkDnpStH/ZqJyt6E4uqf3nz0=
X-Google-Smtp-Source: AGHT+IFvK3t6Pd6vlcC3wzNTbFFTWLPsRNVpMYNWSzWTSxCNRsBrWUE0jhACDwmSAW+v5W2vD8TjBw==
X-Received: by 2002:a05:600c:4746:b0:416:2471:e102 with SMTP id
 5b1f17b1804b1-42108a271fcmr76029805e9.37.1716828232845; 
 Mon, 27 May 2024 09:43:52 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.152.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35aa9d22498sm516533f8f.0.2024.05.27.09.43.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 09:43:52 -0700 (PDT)
Message-ID: <ed27e6ae-164b-4aee-922e-6123e65d17ab@linaro.org>
Date: Mon, 27 May 2024 18:43:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw: debugexit: use runstate API instead of plain exit()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240523-debugexit-v1-1-d52fcaf7bf8b@t-8ch.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240523-debugexit-v1-1-d52fcaf7bf8b@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 23/5/24 09:09, Thomas Weißschuh wrote:
> Directly calling exit() prevents any kind of management or handling.
> Instead use the corresponding runstate API.
> The default behavior of the runstate API is the same as exit().
> 
> Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
> ---
>   hw/misc/debugexit.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


