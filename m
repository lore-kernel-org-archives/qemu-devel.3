Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69878C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 10:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seAqo-0003g9-SM; Wed, 14 Aug 2024 06:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seAqn-0003fc-8Y
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 06:03:29 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seAql-0000kx-Ib
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 06:03:28 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5b01af9b0c9so6770855a12.3
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 03:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723629806; x=1724234606; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L6AdZbX4AePgyvzpCvj5p2nD5PTKuc5dc/y4Q+eKt9M=;
 b=JhoJwmEBdt5/5Vt+Xqv+fMw3tffxkYn/NZ1k26aVgjmuhT3+WQTFj14qKZDxEm9xeG
 KHaWjnZHvPK3cpF/8ZZN0oZjxu7OKabT300PqMtWwYA6b8swq7/2prE6OtQmbo/pS0GY
 SlC+8MelLOmgoIpVxb1YuKJJy9nvXcLHwamqSbdFJPoMgTrevqk/oegI+MlVWFj+RRmt
 tyCJJNVLeaBndHPhXq6yRmtd0giKGX81NqQvG/IrGcfkMOaUtx+76ect2BT+WLGhYNmL
 orvUMCxGBpMqGqc7z3D23gDlB3g3H4Gmna6csciO5SanI+eAk/e7XdaAcVQJZgAIzlwR
 nL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723629806; x=1724234606;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L6AdZbX4AePgyvzpCvj5p2nD5PTKuc5dc/y4Q+eKt9M=;
 b=M0WhPv/b9vNL3bopK1dooiISfURovkXfj07xyCy688biDH2geYRx/a6wKUqAZBD1dr
 /g/X0s6D2v8ofGGZFt60OITw62dGW3vbm+toj11OZKqK/11ZO2tQXhEsTvUIbIxLjVKy
 UWAxz5QmfefUr9wYm7zOo6Nn4w+sJ2HAAHkaztpyvspELznpQuuLeXLHdouV3XmaP21N
 uDhJXVrhVCAFzC6MhvERfeOlGkXNGrNqnvn83LGynN/bhW+7C6vYQhE9Xkrtb//4YO2t
 8yhr8KAYSF4DUN70PPZqvV07HInqT7j3Cj/63Jhf0BlxMcH+g8KhB8AZl7/MJOYOiCCJ
 Rh1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjvR7tmDMEtY6MZQEt0k3r81Mos30MD7tmRJX71jpsQb46bz75i6NlOd61y4n/kJJfIX8kqbWnRPFeyhpHClY85hddk7U=
X-Gm-Message-State: AOJu0YwPhpRrtK8R8KBQH+IOgURLv3W7rD/h9sOxbGKisyVeH8XNisCq
 Lz+oFyhtWGNOCiPFsSqYxiOFAatiYBjPt+v695DS/PltQ/ND0bPWXeH0lqNsOfxFEafCoCFEov9
 zMTw=
X-Google-Smtp-Source: AGHT+IG3zu5ucEGQ87VA8smXNp3wJ21CmD2nr1F46xm876h9j+Ns+xJkXp5EW311IGIDO9CsfcC22g==
X-Received: by 2002:a17:907:97c3:b0:a7d:a080:bb1 with SMTP id
 a640c23a62f3a-a836702c7f0mr160179666b.43.1723629805596; 
 Wed, 14 Aug 2024 03:03:25 -0700 (PDT)
Received: from [192.168.69.100] (rsa59-h02-176-184-32-161.dsl.sta.abo.bbox.fr.
 [176.184.32.161]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f3fa5db7sm153381866b.58.2024.08.14.03.03.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2024 03:03:25 -0700 (PDT)
Message-ID: <a3673d8c-3ac4-4e7d-afda-85741d0f4d28@linaro.org>
Date: Wed, 14 Aug 2024 12:03:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] MIPS misc patches
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 stable@vger.kernel.org
References: <20240621-loongson3-ipi-follow-v2-0-848eafcbb67e@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240621-loongson3-ipi-follow-v2-0-848eafcbb67e@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

On 21/6/24 15:11, Jiaxun Yang wrote:

> Jiaxun Yang (3):
>        hw/mips/loongson3_virt: Store core_iocsr into LoongsonMachineState
>        hw/mips/loongson3_virt: Fix condition of IPI IOCSR connection
>        linux-user/mips64: Use MIPS64R2-generic as default CPU type

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



