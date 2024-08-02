Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746EDC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZsd4-0007hO-QT; Fri, 02 Aug 2024 09:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZsd1-0007UC-Jk
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:47:31 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZsd0-0005uX-1N
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:47:31 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fd9e70b592so59197775ad.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 06:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722606448; x=1723211248; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dWIk+ZcEjFCzmC3Rado99dpXNMMPOt2ogLMDlArSX5A=;
 b=lHeL3mpWe9olfnZQQmPJmBH6/6qGIBQXjzD0d9ncFdiWxoHM083GgvXNGTzkCc9bdv
 pfXoK5sm2wR8FxMxcqz818ygTYup00qAnIWkuVe3ghbOPowxvFA/yIQyU6l4PWfC5JO3
 OTVpiWq+aYfuvv1kRiOO11XxIcjwK65ob2ebNRF4Dmi78xYsVtFzx7AM0POxdaSan9zv
 kM8KD/wtOMdbHX2ztfQKIP2Mkl4GuG/OZfRJHlgWPj7IokKkwQ632164snz7yRVbQ7mf
 pGZf+aV60cFuyIywePUg1+l4MXAJz6rPvVwV94wMIzf9QzhF670bXJjsOBL1HwN9HwhQ
 dI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722606448; x=1723211248;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dWIk+ZcEjFCzmC3Rado99dpXNMMPOt2ogLMDlArSX5A=;
 b=P3aHQxbwsnCnFNvV6o6rDRyHo+vXjd/q0/191aGXymtySgqlYbpTZPlXPvIS4LByxj
 XlRWwnOYK1ZZY+Dp0W6pv8isXGFibwYK8orGIPg5O9kWynhX9FXZBuSM44anPI59ViDs
 7c7DbH6hvJX8hMo515puGGeZ0hFpBt+417me60Ut2J7VgEl0QG4E41rurQKJ4TDpw2h9
 AaWj0TneSn7zLT5XWZQfSpDu87N3kfAnSwpJH69eUyNWft79FgPYNyChGbpFcnpPnjLi
 ICH8d54K4QMzKCk9B431DAZQfUZMgdiOdphCvDYqp1hQZ4KKAcfNDZlVB1MXISSXiJfV
 ocLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1CJjErdGMH6ptGEmk82vPcTojhW4llV0DknsZF8Zt/xRFsX6gGLbbl2CL3uWOxnUHcZNfcVSZO+sXH4M4I0QKZhnVbRE=
X-Gm-Message-State: AOJu0YyZjF/+JsnsW0c5ZExRuH598De2kNZPCiOwS8fICEyQ1RzfyPUz
 YAWpNSJaaiUVQqoLedHpIe0FxvQzYDuAxwplOxMZif1zq1tIa+S8v4TDr8CjDwU=
X-Google-Smtp-Source: AGHT+IG7l/Kh6uZ7A8Xip++0uiBl3j2OPWv3r2HaqFcXXmGDjCZCjKmp/qgdtcXtqP0Sw1DRL3RxeQ==
X-Received: by 2002:a17:902:ea08:b0:1fd:9420:1048 with SMTP id
 d9443c01a7336-1ff572ecef4mr40316845ad.32.1722606448428; 
 Fri, 02 Aug 2024 06:47:28 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f29c91sm17360995ad.16.2024.08.02.06.47.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 06:47:27 -0700 (PDT)
Message-ID: <5879610c-4bec-4495-a6f3-1b1747086507@linaro.org>
Date: Fri, 2 Aug 2024 23:47:22 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/18] bsd-user: Implement 'get_mcontext' for RISC-V
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark.corbin@embecsom.com>,
 Ajeet Singh <itachis@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
 <20240802083423.142365-17-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802083423.142365-17-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 8/2/24 18:34, Ajeet Singh wrote:
> From: Mark Corbin<mark.corbin@embecsom.com>
> 
> Added the 'get_mcontext' function to extract and populate
> the RISC-V machine context from the CPU state.
> This function is used to gather the current state of the
> general-purpose registers and store it in a 'target_mcontext_'
> structure.
> 
> Signed-off-by: Mark Corbin<mark.corbin@embecsom.com>
> Signed-off-by: Ajeet Singh<itachis@FreeBSD.org>
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> Co-authored-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/riscv/signal.c | 53 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

