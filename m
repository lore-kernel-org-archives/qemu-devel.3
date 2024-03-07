Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D47C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 21:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riL6r-0003Et-Gz; Thu, 07 Mar 2024 16:17:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riL6p-0003Cr-Ek
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 16:16:59 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riL6n-0003Nv-W9
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 16:16:59 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-53fa455cd94so1143103a12.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 13:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709846216; x=1710451016; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AL6FSYWCh12FPJunLG3Yw2OO7xg2mu2CK39Vd7Rmvdw=;
 b=indK0n+ccL5mlcTTi9f7SrHGr4OO1ldP9ZVzfrmQ1vV3Kdd0UrmpbP77fjZIqBakMn
 /Nk24vuG1QMceJhL9rOr9i1Gvki3hBalnXzckc9FfwSlAGwvHdibmTBk52IZqtZVoJpM
 R7s1IwTcHsSPA6WZ+CBa8U3X9WdkOzz00+8u19JGak2rJ2Gl/KR4Sey95myL0L9e98h6
 WUzoDYMVdsslpUvAsJ/kcMBi5FK6FTGyqaPkTkHb3MdjBC+ZlwOH9gG7//aX0kPtEla6
 qt/k7TKMDZr2MF7bFuCy6WpeYNpIO9arjdRBgsYSBsxxNni22TEqcoa2ySfQU9SBU0Wa
 mq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709846216; x=1710451016;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AL6FSYWCh12FPJunLG3Yw2OO7xg2mu2CK39Vd7Rmvdw=;
 b=uyLfFfIqE2MIs0GEqlL8AFSMOAari6Hlus8G0qlZzT3HAc2AcAqEH2cuetrorw1E2x
 Uex2xrqvYGf5fZtQmzQrXrh4zH6lsEdzl9sXx6cNvjNCDj+YRgYQvNWA8v8jT+QKF1XU
 J0oGVAe4//cnQ/+fret2uww85Pji9yTfxvuSCWCGqeNsmWWJIv4RATLh2q+F3orzfstK
 e57ZNLpKy44eUT0zfXIpuMfaxS04/v75gve9p5w54hmoK79dR2eWBaj4FTxD6P/nINsT
 y89JAPpfjCSNSo7BGZIpz0E0f3WaHhmkImwucY36lPciLLVTgRU8gla6DHE9pHsb0z59
 Q7iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDPT076LlAEMJC5f1V58AMeIXYKCNtZQnXOpgPnqdUHmNjrDQySzs52IRDBwsW0Nn7cLspMjJ8KxHw4f/G0GCFcqbaDpE=
X-Gm-Message-State: AOJu0YxDHOnuA6E8tlKtrXxUTDWv4JDC6wV8iYldcaMSLyIrIz8LgiVp
 FgHwVZWKsBt6JO/c+QqDuy5ZycodKxDIR7aWWORFdtRROqsyH+iWPKeVJBQ6v30=
X-Google-Smtp-Source: AGHT+IFPA4+dJwu6Bi8P5AZQ4PvN1DT8s6Tmqewn6wzgjeKkOuS7j//F398UQE8dCJJh5Aart70iJQ==
X-Received: by 2002:a17:902:f707:b0:1dd:689a:6ff2 with SMTP id
 h7-20020a170902f70700b001dd689a6ff2mr27734plo.63.1709846216079; 
 Thu, 07 Mar 2024 13:16:56 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 li4-20020a170903294400b001d8f82c61cdsm15139090plb.231.2024.03.07.13.16.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 13:16:55 -0800 (PST)
Message-ID: <bbad4f51-5e8e-49ad-ad24-ffe6f044dc39@linaro.org>
Date: Thu, 7 Mar 2024 11:16:52 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] tests/tcg: Add multiarch test for
 Xfer:siginfo:read stub
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu,
 philmd@linaro.org
References: <20240307182623.1450717-1-gustavo.romero@linaro.org>
 <20240307182623.1450717-5-gustavo.romero@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240307182623.1450717-5-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 3/7/24 08:26, Gustavo Romero wrote:
> Add multiarch test for testing if Xfer:siginfo:read query is properly
> handled by gdbstub.
> 
> Signed-off-by: Gustavo Romero<gustavo.romero@linaro.org>
> ---
>   tests/tcg/multiarch/Makefile.target           | 10 ++++++-
>   .../gdbstub/test-qxfer-siginfo-read.py        | 26 +++++++++++++++++++
>   tests/tcg/multiarch/segfault.c                | 14 ++++++++++
>   3 files changed, 49 insertions(+), 1 deletion(-)
>   create mode 100644 tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py
>   create mode 100644 tests/tcg/multiarch/segfault.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

