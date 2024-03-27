Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F32C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 05:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpMI5-00083u-CX; Wed, 27 Mar 2024 01:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpMI1-00081E-Cn
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 01:57:34 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpMHz-0003Xb-Tt
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 01:57:33 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1def59b537cso42657935ad.2
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 22:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711519050; x=1712123850; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n7dpWrKUH9p/K5Rr3Mdq33XMyuTN0qXo6lLHkmOWCDo=;
 b=LZHqlfDRqiqLrixEQQVyti5bhvnM//cyP8M2cV/ayd9ihdzYhjr180UFWZSZUwuIS1
 6CBwKdNR7D/rU+fmPOE1cTx2w2FG90XGIy6A/J+GYz7ncdVM3kodFQOOE363nOTzP0h+
 oAD7J6K8rIvLxvxh7GlhfqwXOsiz7jdF7vInIkCTsKfg3cIjQy2RubR5wikJEdIRJFKQ
 j8rIRMBNxNRX1M7Gc6pISSOIJcUX1pZmCtFKX6zvoeBITamu/WUAFxhES2hseXvjMEkp
 +NnGS8xATLYUflnDRRhTTgXM2BagXxiktd62lFuqW7LNPXR9eBWHMV+V10sav4mQnNez
 UOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711519050; x=1712123850;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n7dpWrKUH9p/K5Rr3Mdq33XMyuTN0qXo6lLHkmOWCDo=;
 b=TcgUoAMLbTqODS7WeCYOJOM7m69HOwp8ZatTCcXr2F7T8BFXKsYwsxCeOqYsYQXgbE
 m05ircEGLw3QtHN69/F1I/4t/OTGF3e6/ANhJ1k2+U9Uh7g2b7rl601WX/VeS0Ekeszt
 7XPmroqiomZEq2bB7Gsjr7XYhTmphVx5sHQSUSeIVwMsk1eiNs3LErwqIaVePBXw4g1s
 G1HlmOO4+us047zKofRvWJTasNXtnI7i9E9cz47pszCgA0/7p/2+GYOeFv58Q9NYvX64
 PFjnTZID/I8cjlazsTfCuSb2rqDbyTzBXPs8Eo/26HQB5O4cPQqy5KL+ByxnMIi23uh2
 EnIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzyZFV0E7ckXGctqGbRMwkSGOG4Idn1djZnzpXrYZdf5zl5ciibe3bWFH9KmwCNG7gFZLo6WM2iS3/4uGOjJya7nbJTac=
X-Gm-Message-State: AOJu0Yx36K5XcVu2AcMhrWyJ2um32p3P1sQjYDABBpn6TGVQ6geRc40F
 aEIf5WMk+wSa8nrCrC9MlIy2hXgCkxEo83ep3fV/nZgfdEsSoJwaMMgtI7o4o/s=
X-Google-Smtp-Source: AGHT+IEDtXFsqXkqwDnhSFfCpPzhD7inr6qiWFdkmv0jbhbOBgj45O9JPfw4i8XQ0XAzE7qPSRaAyg==
X-Received: by 2002:a17:903:1112:b0:1e0:ab21:4e92 with SMTP id
 n18-20020a170903111200b001e0ab214e92mr1949512plh.44.1711519050509; 
 Tue, 26 Mar 2024 22:57:30 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 g19-20020a170902869300b001defd1c0ca7sm7972170plo.229.2024.03.26.22.57.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 22:57:30 -0700 (PDT)
Message-ID: <dededdca-ea80-421a-aca5-2169d9b43d23@linaro.org>
Date: Tue, 26 Mar 2024 19:57:26 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 1/3] gdbstub: Simplify #ifdef'ry in helpers.h
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240322161439.6448-1-philmd@linaro.org>
 <20240322161439.6448-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240322161439.6448-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 3/22/24 06:14, Philippe Mathieu-Daudé wrote:
> Slightly simplify by checking NEED_CPU_H definition in header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/gdbstub/helpers.h | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

