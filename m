Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B91C48BC4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 20:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbRXj-00035V-1w; Sat, 17 Feb 2024 15:44:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbRXh-00035A-LP
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 15:44:13 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbRXg-0000Fy-7L
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 15:44:13 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-290d59df3f0so2607611a91.2
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 12:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708202651; x=1708807451; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M/KURmixgPMCy/7Mb3v5DHX0msHKFJrA8nPc7bgaBhM=;
 b=eXzF0Pq9+vR+e0gkVRh2D2ZsW+CoKm9Px1HNMVVv0ZRVY8OxIofirZ0dCZEYKVitO2
 cvVngMRIGPAEnkvmv1o5FQ7ppMAOOEGsRkFKLed0tbCw2kDJPSO4lJy1PFJoXkZTjPKx
 8ZIJDu0D1VZJqF3VmRLJXS1hbpupD/wgOd0vP6tQg9/vMf30hEnymRMNj4tW47mKmr0P
 jKs3jvwvMAgyq5FprzB1xLSevrXwePbLRNYkiqghsSRH/4uPvlU6KKSHWc7K3jUN0j+L
 b0rga9ACdsWU7Ul6CWf3ZezdUXEUbGurXxLKG0obmPuJt08tloVYt8bW24TKbz8PWuvR
 3m1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708202651; x=1708807451;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M/KURmixgPMCy/7Mb3v5DHX0msHKFJrA8nPc7bgaBhM=;
 b=lXymYIPkMKsd1Hk2b7EgkNttYPU9nW4066z7UMck+y0ypD3PVQ0vL+tgDUGCnih6AL
 FZVTUDpffdIRTdUDBKFQw8DXwOQLzTLXAemkHFJj6aiZLx7+92u5t3TLbjSf54pfAj8J
 sOwHw/7c8HWr2lKb0q2ZvNXWu/tNb5GsfkAuztQnTKlY0DMvAyapDF/BENwzPrBRXebd
 gmcjvsqEa2WINQkqUSta2GiJv2sR9hWOtp538pXV/hAq0gQE3my9kEAt/YUltVZYulXX
 InXO/O3FHEgX8BckuFLDIZYIxrnTmGUb8vqIe7LY6ttP929m+jb1oO8HE1T13Rp9FX7e
 DpuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjptgippOTK8NrHBhKEi08j43HAkdd9l53GrRCIVWLUbMvLXKHE+1YswIm8jZXcg05h6rveMVYlE4v3IYm17SgyrMI91Y=
X-Gm-Message-State: AOJu0Yxqxnh9ERRm+v3thYS8AKN5oZVIN6jRW5NL8HYJp2fbEZB4V5+R
 JjAK2yx3eoLJJ8g7hi0dSSDf0mQWOREY0F3984AF3S53+VbwhZHC6O5TKKJcXsI=
X-Google-Smtp-Source: AGHT+IHe9ktPhSPOcZTpITgJ6rHwyLgGJHm6K4p4yIa9A6DBIER0/jANKC+x2/l09itAT8yYZWe1Ug==
X-Received: by 2002:a17:902:da92:b0:1db:80d3:1af8 with SMTP id
 j18-20020a170902da9200b001db80d31af8mr12027422plx.19.1708202650772; 
 Sat, 17 Feb 2024 12:44:10 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 y4-20020a17090aca8400b00296f2c1d2c9sm2227236pjt.18.2024.02.17.12.44.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 12:44:10 -0800 (PST)
Message-ID: <a69dc66a-5227-47c4-8491-8d4666e4eeb6@linaro.org>
Date: Sat, 17 Feb 2024 10:44:06 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] hw/display/exynos4210_fimd: Pass frame buffer memory
 region as link
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240216153517.49422-1-philmd@linaro.org>
 <20240216153517.49422-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240216153517.49422-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 2/16/24 05:35, Philippe Mathieu-Daudé wrote:
> Add the Exynos4210fimdState::'framebuffer-memory' property. Have
> the board set it. We don't need to call sysbus_address_space()
> anymore.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/display/exynos4210_fimd.c | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

