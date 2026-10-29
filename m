Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2183606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oJD2crVw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMQ4x-0006Ud-LO; Thu, 29 Oct 2026 09:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMQ4f-0006DX-75
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:21:47 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMQ4d-0007re-Ci
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:21:44 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-713e6ecf595so544815eaf.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 06:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793280100; x=1793884900; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=X7AOxLq/tsoqZTYm40DROrzTxnJXmnaHbR3z1cHn+lo=;
 b=oJD2crVwm9+ckIqWaCgeRHGG9+RmCUQn2PiXEvR9N/9d0rE4xYW8LxdVVJ73vNmsYW
 02zIDWl8SVO0MEAGscw8R6fSNoHULxaY6+Xp0WbdHNqbwzeyxtxK1/E8IbJD+Gm0ey5a
 A4yo4ok8+il+TUoRbxLpAEr8BLoWedk7OuDDLw5wZdvnRchmcI5MqSvF9rWehm8Q4nQm
 whUOCTwgEq7me4hppCNEbvkVenSRpL/DhkOK1n8TWyz6hcKv2t6jKmdH67qYbEUvG/Zs
 Bx1WZ2BjkL4ZXfZxQwcKO2hQC2Zs5dT8KfsNku9R7OMQpK8erNNsXk5boXNEm7k8AyRZ
 5Kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793280100; x=1793884900;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X7AOxLq/tsoqZTYm40DROrzTxnJXmnaHbR3z1cHn+lo=;
 b=kBU0Tn+cgX2rNbyhKatRb42jPAMogPQoi7WQ0MTO8pxumQ6/WWNaK+W4gf9AIax6Jb
 /fFCJr7vAboo6wXZoqrKE3UbeEHVrdbjYRoiDp8UP7Ig/ZtYAeJqDcykfXcuzxQbFsVu
 qcUatd7McgVLnE/AuQ49QJeNKMl7JSVEA1C7YgV3URXL00WehAyZJc1EhqVeo+ZQuLe+
 7RyJzc+3OeTbEO2IgKPMnpFAE4GxCIK5U3pbY/u6kCWCzmZQZLzj6yhrXTU3Uyf3tEiJ
 WvAndz1MZEYNx+b4Ir+r+mTnhvQEjZ3o5GSbOqjIqFiQsmLkJoWD6IoNdYP2rdQzZCUA
 j7Gg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzysn6nFhtC9lWPP19wDgHqBCYKXF3DR0006R1WDhi7tFGxxuPPU1mP58OUxtB1BxM/AfNOg0AWFpIJ@nongnu.org
X-Gm-Message-State: AFq9FYJDBnWMK0yHBeaCIJdtn6s+bd1jXC9RJMlw8fNL/9VMTKGADsHs
 7x3hMJx6sUjMEptj3jEvKL4AhnG9W4JdehsUTyNPZAKCN9jLFC905XfXp3Mzu8Dm7Bo=
X-Gm-Gg: AYBFou2BGwAjILCxHD7mRY8EAXzXZNATVxgSXQcLXZXVwzxyEd9f2W3C6WWk8jWlmJI
 ol0X1ZVSySWLh5f5rtcYv1Xz0onBN+SaVMkMrQpiuzjTLdHv9DTqoq4dHTawhbZtwKXlclyDIzw
 wHMO93wKSOpWNq8Trsvst1EvM5fxKs95pkZ+kSAP4z2KXYeKwfRWSQs/UcxouksOpB2D8ETXUL6
 NGnwD+3Tyh0o3JYHeHhzYwSEfM6hc1Rz2LwGPAIyW3XaM9ZpIinGu2Zjjw9+rekzguTIk/cag9H
 rUIZR5trEdQBkWOh7sZPdi1/qec10qO2GnTEAsQQ+IzkWx1L46piUP5R+yGASOd9+/KH0dPisOR
 qJjzVQDoWQ1L4VQQ8YwITQ8g+gAQZtQbAVLK5BgBkIR+FLDho5fun9X4stwaS/5vtVqmgPjI+pM
 c/Ufw8FMxCSW+JzZCZUGkWPr0IAvhVivmQDXv4HYm2Ed3KsK9PKwEpYizXe9iRZYH6mSSA7OVfC
 R9Z395x/Eby5Cditsp5gRUY090OVMQkuo3ipEhLcMpmZNIj4wxpzHSWsTv6pxVPxbTEb81AzFO7
 w1wUpy/vrYpH/wN9hTPHwelpSxYhUDiaUsqmwJeG2yYb
X-Received: by 2002:a05:6820:610:b0:70b:867b:e7a1 with SMTP id
 006d021491bc7-714ddaeafcbmr1186262eaf.0.1793280100349; 
 Thu, 29 Oct 2026 06:21:40 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b20219dc4sm4719719a34.22.2026.10.29.06.21.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 06:21:40 -0700 (PDT)
Message-ID: <a853f289-ee22-43b4-999a-34c66ae439b5@linaro.org>
Date: Thu, 29 Oct 2026 08:21:38 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/33] cpus: Add helper to log raised exceptions with
 '-d int'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
 <20261022215115.19680-4-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261022215115.19680-4-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 16:50, Philippe Mathieu-Daudé wrote:
> +    return STR_ARRAY_ELEM_OR_NULL(excp_name, excp) ?: "unknown";

Why STR_ARRAY_ELEM_OR_NULL and not STR_ARRAY_ELEM_OR_VAL, supplying 
"unknown"?


r~

