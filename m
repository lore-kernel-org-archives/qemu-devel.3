Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56A7CFD376
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 12:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOy4I-0003Uu-RS; Fri, 28 Nov 2025 07:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOy4E-0003TK-Id
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 07:59:18 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOy4D-0005YE-1x
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 07:59:18 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42b566859ecso1758234f8f.2
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 04:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764334756; x=1764939556; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eRGmG/JIZzxTazHZFX3QLWrrAMjvshZkcY1BRk6VzKE=;
 b=xuIBjmI1XSPeHUQpAOmp0Is8OUIEi4TXTELwRsKd7RsdU5l0x6hBk4BoI0Rvu67Qy3
 lRHqFKBLXGWpTv53rlip5JEkb8WSlQFvWHQ0ACRwPotp9jju6tVDYrtp55TIIPLMnEV8
 AR8t5btw6HbEJkfOnFglSs0pGMYjTVVt1VzFJIhZJC9WofvBgoTUaxfaHpbnzo7ayLHM
 5Qa8mUU/I7LVrYW+wh9UtGBkpDGGFBo9fbmFE8wGitVtGlKmJOEYUpdUy+eEo4CMxsDh
 /pWmQpRSQe9fwIy9E6skopVin4i25ncXEmzXfKc0/dcH/XMWPO/6ljeETcppn0VdmR5A
 zqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764334756; x=1764939556;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eRGmG/JIZzxTazHZFX3QLWrrAMjvshZkcY1BRk6VzKE=;
 b=Fq1o8DcDHkWKBaLM1bGr/CKb/ca1+KPElpsvSbUJF6XpXExpEQq08lYX33vnNj1NxK
 OJhXW6KHO8fcbpVvDenmFAWMGVHORmUMQudfdN1pGX/LYl/5YwtrKHeY0KfWJk3K8Mjg
 PS5F1P7r5qfBeyN3/hhpbTlgu1iVfnEHdBiSFhQq3mtLkbSdPpc3ez3u/jOh2BC3EARy
 +6akm833wXqe+AFTpzGxBHXrYt1YWiX3+zEdZNGAF7VqkaIxYVQh1oWOlM07TDhIbi3S
 yOuByEh3gj7ZN7gmIMVp/cqYz2sW1A0zGCXXjOOCt/oyybTGCf8yOTHXCbjJ9v4nZ1Dp
 jLaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPBUnC7YrFMPqG7u67+7fNUN07wyiyYaeDvLyunPJu+EB7tUqAJFZk+OIGkBo3qRjNzevPLyBuwsNf@nongnu.org
X-Gm-Message-State: AOJu0YzN29S/mzYSdZD+Hi6aNH543w3fuqjXGYa3c92QPccPJJuqRfh5
 RqclYQYIsDqW0UUPJ56EXLeFutk7L5OthHJNf0/IwGYMPHzN5J6efgICTax/aGRUL02SVwwgLNH
 zWa3DhkfuiA==
X-Gm-Gg: ASbGncuneKGH29+u3VCI2r6RuaXKgblIwGhwrxCIYH42GmiTbCFL5xQisCc/JzZbAIg
 OUnB5gnYIJTCyfOohaAZXVe8VWN65wduEX7ZxWN0BmG7QQLwrnjfNHhPJKXc/80edE3rximlkUp
 83XxJayhXMfpVPuMkfiIjqSRNPAbgWD8gvbzbHNj8bVctI5S8XJRQpNC6zbby4NX60RVCndE3P1
 KdKKd9JsDKqgRj3N1p3xTRjqDJndADQVuVoPjRXC5Dw4sgB5UO6EIK96374E+NAEcZY2lv8hR3C
 9yzcUnmMfbY4lkp9ALvj7Mh3Ir/m60Uqzq6Y+rCwuDRjhM0QaZYfHkC9BmqzogretPdkznqJyAm
 Fid3voefRBEfbKTV/CBRHEX1MuJvV8u8feNW/KJTAk3FC1CFf3qVTLlyBJTz/eKMrs5YNKNnPw2
 um4Vi/PqGJNwjwzRca3MXlU9oLImPnfGr0r5Uph/bBs7ZY+fqgWVEcioZxfJvB1n+4
X-Google-Smtp-Source: AGHT+IHAUJHPPytvEMni3EUjnwYocshnEzNGD40+fs8qIxlm/ROPBlE9329W5vhhVz9GdkKcVvVaGQ==
X-Received: by 2002:a05:6000:1889:b0:42b:3ab7:b8b9 with SMTP id
 ffacd0b85a97d-42e0f21e8c6mr16364165f8f.20.1764334755623; 
 Fri, 28 Nov 2025 04:59:15 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5c3041sm9107791f8f.6.2025.11.28.04.59.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Nov 2025 04:59:15 -0800 (PST)
Message-ID: <1a41fa14-68ab-42fe-be41-8b9bc86975ab@linaro.org>
Date: Fri, 28 Nov 2025 13:59:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] edk2: update submodule to edk2-stable202511
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <20251128084524.363989-1-kraxel@redhat.com>
 <20251128084524.363989-4-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251128084524.363989-4-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 28/11/25 09:45, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   roms/edk2         | 2 +-
>   roms/edk2-version | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


