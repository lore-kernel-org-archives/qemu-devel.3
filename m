Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1584ACA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 06:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uliav-0004GP-MO; Tue, 12 Aug 2025 02:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uliat-0004GD-Uc
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:34:47 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulial-0000Px-NF
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:34:47 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3b7823559a5so2391432f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 23:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754980477; x=1755585277; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nzsCJYUYizMRIx4cHJq6bCW4wqv+x2wAtlq5RONtBqo=;
 b=VkKhqYl6LgTiROTBJL9hPAX9mriiAet9h2l0YlYhiE2RRBngVgW8cxbXg8HuOfU0nF
 KS1pfWwBju6fMX8YBntJj6ztVprpyIgDAKIHsigG2NlpX6ZCB6PYvlhAC+Z3/5O2/8D8
 jlPycxUyopjq7JrcyfAGwytOiXM28nwMTRaes8OO/i0o6DzfvPPwSQNoQ5av1eCo5oaM
 Qi4ftc9WwAE9YWqo6xQTTjaZVrEqYCU52vgSouQGA4N9FW/+J8/OTHLzY6IkamiQyl91
 nyg1mIZgUrQJb5eQxbriOuOFnkXhS9fgKpsp4lXjFBEhAdQx/mhaSu4TYS4nWtxTKD0p
 9O/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754980477; x=1755585277;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nzsCJYUYizMRIx4cHJq6bCW4wqv+x2wAtlq5RONtBqo=;
 b=QIJHb6yUDZqZ1XhQfuqF3hODdpZ2xPqtQZoTZFPjCLhXAXWoq3fLnK58CAxUB4HAvU
 K8OXNBOxArp7AmPXcUvTqoqMIgfCpihSrItynUlXXnHT5ZH5DDbfnQxsrb6qE8DGh546
 VtVQI6sHQmxKjGSW5r/epFl8/zelY6XIxJy6yHLNqhZAXWMOCX4GzT1WjJPCxy+ynlvN
 dv6D1XtY16iypzvu4seXybUmV8W02IPnQI/K5JaCyLz1/jpUICq7hAUYTuE5JLbPTMDv
 HyDWdZ/sSRoaaWXPxwu4HZ0LvqfCpZoXQt1PQoUMxvn1a4g6eKmzztaDIKEqM0GhHhbZ
 honw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURWeWSETJaqSzw+SMAV9IK3/whp7Y8o3jqfloQrldNgmw9mBsTWPuz/8oxnXQTFxuikFwbeZnAVhT7@nongnu.org
X-Gm-Message-State: AOJu0Yxv8hdKrO2tg0c4AT7V95IPr7XlqGUJSK/l2iRjsPb75xwR3RW/
 M1XUdacUPxnYSjU0t2JobIR97ka01VnE8P06Wy520iaW++biWLppMEmf59cAP7qF5D0=
X-Gm-Gg: ASbGnctNrlACMS+PoiolX9ugZo8+NJll3JOAeFzQbNryK/ZsLxZ1IMxnT7DE4ZlURUy
 SSELjWQQ/2RqusWXTaWd71H61xwEFVvEh42N547iiwlLjiuHfBlmMEjzdiYnq5Oxlk/sGojXxUY
 GBjx3IB2hePd2GGzXIJEuvpUV+pHIuLllgek9nmiV0/FZ7dUpIVDfhI4EpTORmgCq249KOMIhqK
 VYHRNOBHKqzK7FlL3ZdYLBSxU7rsxSyiu3HWs8jRL28L8rw3VUQev9ANsNY5BkBtolIlEZf9mcJ
 3jQiCteWBWgj3yR1eRDT7ASPOJOXcgQywq329M8pNMBOuFIWJtbe+83EGunKkGtWZrND4tgLq7X
 iQeyIXKrHc60bU6bhWC6sJRxygJZbtOIKjcDqkSIcNmHNzDT8PrpjKBAO+bq15thOUQ==
X-Google-Smtp-Source: AGHT+IH/7j8IHnMiG31svneAnN9KBrQVVYDusQBA3FGXL8+PvRowDfH82cPtUA9Mm0XS8zX+hRoPaQ==
X-Received: by 2002:adf:ce8e:0:b0:3b7:9c79:32ac with SMTP id
 ffacd0b85a97d-3b91101541cmr1079420f8f.52.1754980476993; 
 Mon, 11 Aug 2025 23:34:36 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5852e28sm278566495e9.9.2025.08.11.23.34.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 23:34:36 -0700 (PDT)
Message-ID: <14cb9d5d-3200-4c06-bf4e-6e09cb112e99@linaro.org>
Date: Tue, 12 Aug 2025 08:34:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/85] target/arm: Add prot_check parameter to
 pmsav8_mpu_lookup
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
 <20250802232953.413294-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250802232953.413294-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 3/8/25 01:28, Richard Henderson wrote:
> Separate the access_type from the protection check.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h    |  5 +++--
>   target/arm/ptw.c          | 11 ++++++-----
>   target/arm/tcg/m_helper.c |  4 ++--
>   3 files changed, 11 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


