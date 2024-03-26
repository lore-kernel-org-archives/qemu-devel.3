Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B24CD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 12:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp5Se-00065K-Be; Tue, 26 Mar 2024 07:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp5Sc-00064l-Ap
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 07:59:22 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp5Sa-0007W9-Bx
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 07:59:22 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a4715d4c2cbso686217066b.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 04:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711454357; x=1712059157; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UfL+brPGJOzeOS7ViC5dGCPitcNeAGgyBVYMr8wZwvA=;
 b=r+jyctZO7Fe/9SLeFTlsI29r33uMyVRb/mUAd7svNYwWHrMeFmE9ME0xrUKv9v/kGV
 I1pPG1YA/a9qeG2D28h9UOw1qttPgnGbRBSMaAwuSEI7rEW0/r+RHU+B/bIH0jTdfC9T
 v9dGjioMWZlbttIrJj2TWIDlTp1VyBQ88r7xl0sUnnkmlVOJMAchTDCKFh/dd81OfnU8
 LyDtnyLYIGMKdane4mVZiTZfK+EkheGgy10r4Cn1OCGf4eaFS5k47Bj3jIcUSqzxcoas
 t5XsKKLy/gjHJupYI3RGJkVT7FfM0ZP0bWV96Avht4d46JpP3gvRg3+W5a/a7mW3KKtJ
 4lAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711454357; x=1712059157;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UfL+brPGJOzeOS7ViC5dGCPitcNeAGgyBVYMr8wZwvA=;
 b=TqnfTBhwKTEPElQfbGlUHBwhIH9+Yc5eg3BLua5q2TJd2SlQ9D+ZzQdr4ZCWjErHT9
 Ruxw7mDpOGVcNM7FkKNVLQJ8lgOOEfqhSoRPcj+6PwN3Dj54RFhnnaCPd0QaH4vuAWb8
 mSgRlehgUAK05qgsDgOcKm7tScQ8DTZYevo2f9RVvbMr1NViJp6XeOr4yPKeIm9rEL6j
 8FbJFaRQcRBJPAXsdGedvvKDPwzjB/MBpGwH+tfK/TrRRCu21FOqFAL70vvWv7YjORZK
 t7mHRkjMGb4M5NBGsgZIHmEQxLLRFzFJk/b+HNNveSqjPmrqBgSyCogvfryZdKBy47Qw
 oNDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp4f9EOac1+wRAvX7E02cE2Ud1NRYmcGRIMf73osNpiqoQpf87d98CX5HUZ5ts/mfTyLO4fpqWX4MIyXUTNFSW54YTxhY=
X-Gm-Message-State: AOJu0YzLppR191ivouJwOhH3GX+DhxpFvIf1iM5WEWFyP3/WKejEP9E5
 5r30TIC9izEoYJOCAAroETha20WJ4kXBxdQUSp2dY33ZQzlcHFtnLALERQLYFe8tpDp2UUolLT4
 T
X-Google-Smtp-Source: AGHT+IHeWh45u39qU3sYTOWdp42lhHkkK8s6iJTyi0daBLYH4jN6Eyxy3sjT8ikc/gOrAbDhzGQ5eA==
X-Received: by 2002:a17:907:390:b0:a46:635b:bb3e with SMTP id
 ss16-20020a170907039000b00a46635bbb3emr736402ejb.52.1711454357101; 
 Tue, 26 Mar 2024 04:59:17 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 i10-20020a170906264a00b00a46a27794f6sm4146095ejc.123.2024.03.26.04.59.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 04:59:16 -0700 (PDT)
Message-ID: <c1fb4049-7036-4b16-ae11-82150c1bc961@linaro.org>
Date: Tue, 26 Mar 2024 12:59:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virt: set the CPU type in BOOTINFO
Content-Language: en-US
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Daniel Palmer <daniel@0x0f.com>
References: <20240223155742.2790252-1-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240223155742.2790252-1-laurent@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 23/2/24 16:57, Laurent Vivier wrote:
> BI_CPUTYPE/BI_MMUTYPE/BI_FPUTYPE were statically assigned to the
> 68040 information.
> This patch changes the code to set in bootinfo the information
> provided by the command line '-cpu' parameter.
> 
> Bug: https://gitlab.com/qemu-project/qemu/-/issues/2091
> Reported-by: Daniel Palmer <daniel@0x0f.com>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/m68k/virt.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)

Merged as e39a0809b9.


