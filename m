Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1F5C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 07:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbEfi-0005kj-KE; Tue, 06 Aug 2024 03:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbEfh-0005gf-Hw
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 03:31:53 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbEff-00048I-Tw
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 03:31:53 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4257d5fc9b7so2858065e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 00:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722929510; x=1723534310; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zDOEo+W5JyVsxfNRr8iN08G+q5Wu2Uwll3fD2tpZV3E=;
 b=b5axchDD/hgBmmy1SXPuSuzTEI4x2zwgEYV8UKc/x1XPF0LSU4F2RRExF/lotjqZEE
 8kUX44RUjBilCmXxzBSKyigaERuu9Nfgm2Hz0tm4GHWFp3PHJn8KcDxitsuxCUNOT8FZ
 2+pQVevKr1st3u4tUyUJleoCcnekZn1vUPsWJFTZTzNd38v1EPCZKnVG/6ZNOoVrGghN
 PsMoB9tKrJwxW+pFKekTUQpdws/ZvO3y4fyLxqw1vmi3wTdaSINi5YcfvO7M19j0TcFX
 CNZsItiKQ+29GaVTZZn0yJBPgoiblSL5Vy/XlPbSGz99h9pvv4eZUGq8PVNT6kbUYbiA
 aftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722929510; x=1723534310;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zDOEo+W5JyVsxfNRr8iN08G+q5Wu2Uwll3fD2tpZV3E=;
 b=UVDGQ4zeVvV+wpiyiAVkZ9vIXHropheAYh1EjwbTzX8te+ahK8fISHNDX2+mTnki96
 bMyh7gGBjvDjnEFUlgEbr2WQbtgKtUSkqfHpDKFSwdzm5hRUXTSp6GfB5R1uQa3RAg7i
 vHbhfUuryRWANb5XwCMxOzlH9B0oXkWPrmBdOdx+a+KupFCI2pgwatf8XSFmUY+iFn8Z
 jzv0ljO8D53+eFIoNWeLQz9HbORhdNxL81MWwmmdp8K1W1xSSVU7B+raAqXek0J90VtX
 U0KGeJPTXFWIjKXRg9l9mvQU5Zo9FgQ/k+kEPig2ZUXnoA+xuPtO8MI0EbdADLiF5IZh
 C+Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW9zGwYaU3fTqrc1ztARoSfmaNJJ7MQQyyhafYJPT7l0FMkxFFMyTmagXHVEFmKWWrpYHYjRau6lVs@nongnu.org
X-Gm-Message-State: AOJu0Ywl6MHYZfEvqiaZ8X5VbfD8igNhxdYTbWqyvoK12Oh8ocmm/8Yy
 sYduyMPGgsoaDw16dmu5ks7w+SYcxOIdoQUDs4KI4/kQyiSsmbWZKsR7KmmKq/E=
X-Google-Smtp-Source: AGHT+IGXYvcQwTjd7KioZCLtIoa9V4tKc3PlapPjbCXuq3oBLu2eejWJQ4xkkVw+q3/TWNsNG2JjaA==
X-Received: by 2002:a05:600c:4e87:b0:426:5b44:2be7 with SMTP id
 5b1f17b1804b1-428e6b02594mr129721955e9.10.1722929510074; 
 Tue, 06 Aug 2024 00:31:50 -0700 (PDT)
Received: from [192.168.69.100] (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e6e7d585sm168821255e9.35.2024.08.06.00.31.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 00:31:49 -0700 (PDT)
Message-ID: <cbcfa1b2-c890-419c-bd08-2f99edaa6346@linaro.org>
Date: Tue, 6 Aug 2024 09:31:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] system/vl.c: Expand OpenGL related errors
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20240731154136.3494621-1-peter.maydell@linaro.org>
 <20240731154136.3494621-3-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240731154136.3494621-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 31/7/24 17:41, Peter Maydell wrote:
> Expand the OpenGL related error messages we produce for various
> "OpenGL not present/not supported" cases, to hopefully guide the
> user towards how to fix things.
> 
> Now if the user tries to enable GL on a backend that doesn't
> support it the error message is a bit more precise:
> 
> $ qemu-system-aarch64 -M virt -device virtio-gpu-gl -display curses,gl=on
> qemu-system-aarch64: OpenGL is not supported by display backend 'curses'
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   system/vl.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



