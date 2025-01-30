Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64D9C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 22:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdcoG-0003B1-E8; Thu, 30 Jan 2025 17:14:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdcoA-000369-Pn
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 17:14:46 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdco8-0007Hz-MK
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 17:14:46 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so9841615e9.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 14:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738275282; x=1738880082; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IDD3MNBRR1KtHGsacC9fczzE8ey0NDAPAxx1U/dP8Pc=;
 b=tQK5gKN+GrHf97LD3V8m5tqj7QWIi+kq7fxjm5pDwljBlU+qOfk2fSr7XJz/0OfYVx
 wjx9cpzg8S8JcPWxj8su31MMRD2D0/1k7clidTMK5SKGm69z1xRwYeuw2lh1srbLuahx
 66ip7r0jYmLfXzOTW8Kr+So1Ud0ER6Q0k5LoIy+k5jGWsyrQNeS/5U3ZGqZxLSsDhINy
 nmCO7ipzAhgsVKiGWPclZHhgPzd3+eLOj0Rjt/h4NSNeuvaROkX3S3n18RnWaGESuaSy
 Swpp2uH9Af5kpfhoVJ9ZNbw1JaZntlnpbUdxASVtJqkyJSmso09qWT3r47+ugNp5+hqz
 BFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738275282; x=1738880082;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IDD3MNBRR1KtHGsacC9fczzE8ey0NDAPAxx1U/dP8Pc=;
 b=UZSzuUwWPQpXPY+BNFdZFR5UQte6me+9kGoWvDVR8VLD79Pl7ifPsS0RVcKVjOkZLj
 51UikYV69xoZdrfG0a6YYpZwk3t7q5fnMLT0XXfX9JvSioCvrMaqDfrUXPYNqeH0nNk0
 4zxzX+JrPrXIcouulRzyRj8Tuev05YFZOL2he0FOM8ehKSE+f1FCVdRsQzELW/jKDnPd
 PScYZHTfAEjFSYwJW7lruRyv+sFzc8pUryZF/X02JtXLneDSytJQEN05Wsow8wAkpXMx
 FA32QfEarkuvbnJNTzVdcFt+S2XaCtAkAItWb6YL9/2DT5WW5kLg9dk+K+CWF6iQe6i1
 KaAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpVKVyQb8+jV+OW0HKwz7bz/KMWEMOCMbaAU/AeInV2ffnykHvGXo/HkTQfl0PspE0YV3FBww9dME9@nongnu.org
X-Gm-Message-State: AOJu0YyxZvrIh+Vne0RqIFMcEh/KDQIi2sjayCJYzlwhZx2YImicHBCr
 BW98guYdb+CCrcd6hkVl+haJ+uJQdmdqcXJWlMTvV1YD/GgKtyqthBZSsv9vi0s=
X-Gm-Gg: ASbGncsAhIzuqzMD9PhBSMi+Gs3YACZAiJT82kym1tkNyYEJrfSYpuRXihBXyDj+Zk0
 c7o+aVjWlKRNW++ojAMSkSEtiwzHh56NFL9/1jvDbn1E77Tt5JGGxCAGsS4RHMO/sRk1Q5pYu8i
 0MoKt6b9jXMwj52K2RqOt1Kknuy4QV7flZ/yLqib+ivlHWkzvKwA46OCNTByvUpL0gdOkbSryTc
 Uyyogey6xPVsy7Lto42HPYKgenxyINZ918Im9EBPk4rZskDJDWk2vzzrA3h3zvHqAHjmB3/lM6B
 3Nw35H7XsOZ8MErIuGoyqyAlFj5dWUH3J+fH2VAfuQ+kklfkkcEyjtoJMww=
X-Google-Smtp-Source: AGHT+IEty/r9WVcW9+sJ8QV/R+I0e2DGEUM9OnCGfGkooBPasR0YP+C9QPnyXXkuBWJoIlwl0u/bRA==
X-Received: by 2002:a05:600c:500d:b0:434:9e1d:7626 with SMTP id
 5b1f17b1804b1-438dc40f16bmr70073595e9.25.1738275281961; 
 Thu, 30 Jan 2025 14:14:41 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc26d05sm71319865e9.12.2025.01.30.14.14.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 14:14:41 -0800 (PST)
Message-ID: <3a8d576b-e49b-4013-8cd0-eeb415e3726e@linaro.org>
Date: Thu, 30 Jan 2025 23:14:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] hw/sd/omap_mmc: Untabify
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
 <20250128104519.3981448-9-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250128104519.3981448-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 28/1/25 11:45, Peter Maydell wrote:
> This is a very old source file, and still has some lingering
> hard-coded tabs; untabify it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I don't propose to try to bring the whole file up to modern
> coding style, but hard-coded tabs are a particular wart.
> ---
>   hw/sd/omap_mmc.c | 124 +++++++++++++++++++++++------------------------
>   1 file changed, 62 insertions(+), 62 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


