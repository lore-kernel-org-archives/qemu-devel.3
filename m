Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D51C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 19:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrCl-00024T-3y; Tue, 28 Jan 2025 14:24:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcrCh-00023o-IN
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 14:24:55 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcrCf-0003cn-VX
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 14:24:55 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2efb17478adso10337493a91.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 11:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738092291; x=1738697091; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZiTWS4VbuHO7iaX3LFNjQlTylRbOjJ54NTZLurlERrg=;
 b=hD74b+0CODlJ5UnHyeYoiX79kqUW09JpZ85CLEeDLi9lyl8AxKt316x2yZ4zOPI36X
 egrdm5atfyE7XCSFboLx+omZ/Rai/uIY99Do1vG3KyM4STH3MhnBZeUWKo312f1MO4BN
 lUwMsen/jdLfk4aJplsnN6UR64tqdmGHzsIE7Fhh1dwHsQpU9JCbLVHZ/X9Wo8gk967M
 EFIodAD0ktmHxUNbs6t8q0euqyvvEQARipmcq9p9Jv/iuRgChZzVTkDJAgUQVV2m6w4U
 t9qoc7An8/UO0MXMXl6pG7hTehaIIGYkEumPD1R36cZ3VvXJPhZSnKlV29KCMUYVaIgg
 vNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738092291; x=1738697091;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZiTWS4VbuHO7iaX3LFNjQlTylRbOjJ54NTZLurlERrg=;
 b=tUhQRTK5PnA4vWOmEGElC2mbDxzGeyqdnkOUStaBP0E8VK1hTvZnuHW1qSKls1AC08
 TdbXYdctVhAQU1Cu9gNYOtn4ja8GNIsgb2DdofDTcy6iW/+INXMWWsuTROA3bg2rXfGC
 THNgBjQ0YJGip//L1TqUtC6LZgMLjbH4BJVdp0hi+ZGkysx+kyS/MlPdJBcg9OSCoR56
 VLVTnl535AQeS5/tQgVpwkIwJzHtvwZuYA+L0r0q25LoFx0WpMBJVoLIHS3Ux5X3mNSa
 8Kn8FYLSgJEfc2bNgQGEKa1cGxNJu91SxzWEMj1Z8ysaQEo0LrEo5Zq0dDrsmiOqliLz
 fe8A==
X-Gm-Message-State: AOJu0Yy4R2hEhE/Py9DGRYztxlfzebsMgXjnn+Ga27NV5jGM6K1hi7uH
 36qB/e7T8EZTts7O8vrO3CdMZBkMeZM0zN4F/5ehV8pubmEX+Po5+GUf7INEQYc6wjEUpXh9+o8
 q
X-Gm-Gg: ASbGncvTSJ93gTcP4CgdH1i9LPuWQxyV0eYwAw9j73jnPBATCVWrSWQV4pfeqPoaVfF
 r3WyAGRP8n2P4aSAJ8SlalPe+4QPvedPi2Lf7b8lEYfqbWMzm7WSAElVxGIZjOhKExWx6qtKd7u
 /wvw7nEW+yiXkIOj9L8Eb/c74tv1IiTD+Pe7NV4Dy6EZqxfmxDzFHBnYkH6M8xMs2n+MU6WRTle
 oF8PI+5I8+MvlPVmT2C3pN8M2UR4Q1+5RrFAXaURwEDqcslVgAW5kdMLYxBT+QAxD60FKquu7CG
 W25K6sSxGiuwyjc//i0X/Oz3mZMhgSzuhKIMGnSXzefBeOwKdk4ySTfYsg==
X-Google-Smtp-Source: AGHT+IEVKQ5ff9MGwmM6QeqCRh/QWZAKQ8D8ZU16hXjmtAnyPk7KGI6FpnQ8LAit9BSJ33FumeAjjg==
X-Received: by 2002:a05:6a00:2917:b0:72d:8fa2:9998 with SMTP id
 d2e1a72fcca58-72fd0c22e91mr476115b3a.14.1738092291559; 
 Tue, 28 Jan 2025 11:24:51 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a77c7casm9823131b3a.139.2025.01.28.11.24.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 11:24:51 -0800 (PST)
Message-ID: <e189e18b-3ccb-4f31-af6f-4fd199ccdb70@linaro.org>
Date: Tue, 28 Jan 2025 11:24:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] tests/qtest/migration: Pass accelerator arguments as
 machine option
To: qemu-devel@nongnu.org
References: <20250128135429.8500-1-philmd@linaro.org>
 <20250128135429.8500-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128135429.8500-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 1/28/25 05:54, Philippe Mathieu-Daudé wrote:
> The '-accel' CLI option is handler as sugar property as
> '-machine,accel='. Replace the migration tests command
> line, only using the best accelerator available (first
> hardware, then software).

Is that really true?  I thought -accel was split from -machine explicitly because of the 
introduction of accelerator parameters, just like dirty-ring-size.  Otherwise you risk 
confusing accelerator parameters and machine parameters.


r~

