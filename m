Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0489BEB5948
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 00:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpy7h-00077t-Ku; Tue, 10 Feb 2026 19:30:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpy7g-00077S-C8
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 19:30:28 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpy7e-0000PI-Kd
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 19:30:28 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2aad1bb5058so15806965ad.0
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 16:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770769825; x=1771374625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x6iK9zCt0f6L7oHmB4AIiuFJ8rcHYzABWI9hyIW/z0c=;
 b=ZeI0D9Ph2HFem2Z94YQuPgBbP7Eh7lL3JuvwwAtDSB7xacQ0ew8kTHIs+YD0NAsMLf
 3iEVtkQ6kOxwZHS6kRN4gyLItCK9xorRQqeKbWWnoyEt5j0pVDMHdRjfvwpmJNlbzQtY
 5aCzcwOnhJhXR4OvJqxbO+HuhiMrgzrcnx9WTluJQa/O47QdMJmGlkdKvbyXQZMiwO+m
 nECEB1DmvJVFlrcLQwY/zlBEVAi7OjDITb4Q9uXwbfzd0oPCR2qrJWxJa46eBTPNKgfQ
 iG6zbHuVTroZ41RlkiAZ9QvoABdUGCUS9foxcmaaY+bgA6gU/zCxnOxwDAUV5SqxKgrs
 Tk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770769825; x=1771374625;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x6iK9zCt0f6L7oHmB4AIiuFJ8rcHYzABWI9hyIW/z0c=;
 b=UkVkB00GTNpemhm1Ow8Wj6O2QOeQ08yRgkyFfRNYdz9fRaDwwp7wfyMIBLXbmwts+v
 aJM7I7JBKCQPSBZIbNxp2zP7xIYRdGB7zra2v1JzL+TN7XJkG43+KV1lQzwxB2gJEBQU
 NH0HcY2sQF5Gjk9hLk2gSYlSJX1wqv1aewljkv7FM5jeggrsh6kI918zj+m/TdRmS+3D
 lmHh9bO+jIBZtSHm5jy/IQF3Fa0Ni+BGcdeqX8X2twxTnUZlTGUzz14N7WX3zTgj4sJC
 5qS4w0pFID2x83qQSD2Efwfs7PL65hkiObu8/6OrK0pGCX2957L5ysd5hFT7AY4fLAiB
 bmbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhcHdwYUfw3ZhgQHAeDNFDQlXn35G10VRVNUr9P4TKBbiNANueMVsP6YZz3V1/5O0k6ZWt79RLPdeM@nongnu.org
X-Gm-Message-State: AOJu0YzaDFBB/RSBjehBlWYKn1mWrxRboDUeTdL/W9csPq9cDeI0LU6J
 a7SMDM7KwHfFl6/qSO5NJ9052DsYsDIx6BTySqPIHjeh903ZoXSZIzdixg7YRKsh2oU=
X-Gm-Gg: AZuq6aKdQTNIbK0HEnsW2g6bWSW0y9ceNej6cX9645uOr38KFgw7TaXNLc8lGuUpTTP
 OP0Y6nAsV2X0nWLVTpEuggYMcYNxJ8xLwMJ5uXjYWPzIXKo/GvLqix5F9H9dJwpUxFkZbvqtWvv
 Y+lQZNNoiCHdnAkVWT/7+nXCYFeOg759euhuSKR+wz48gF577WzQNQHCsYYB7xD0kGBqsu7g8ou
 RdtZ7AMhWkF4M6CWCNHlAbWnIgXijyx+/eolLL8KHiB4Ly9u2ibfCa/XEKdMHtgGkvqKVvNdMTF
 0TJoud3n6/hXvjSRHSQIO3WtAATRIE2NwMblA5LBApp6X7WRq+gMLNBX3q85SBm8TpI64kpiRMt
 YTbwpYqsYAcGaN6sDC5ERsQ/5KeNMG7XWU2+LIt/Ud6kAyU/0SFNhaPyWC3b2i9dnW0hbseAixW
 B+SHQ7HQBfwXpV44937JAT+UlIKenbdg5uZ7lEv55GzLgJerZ7r0rAfvxdDPUmemv+iESBX/dZB
 WKszeVPc1MdcA==
X-Received: by 2002:a17:902:e54f:b0:2a9:6165:6e87 with SMTP id
 d9443c01a7336-2a96165754dmr128963685ad.59.1770769824695; 
 Tue, 10 Feb 2026 16:30:24 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:f8f8:2c3b:9605:55a0?
 ([2001:8003:e109:dd00:f8f8:2c3b:9605:55a0])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab2997aebdsm2613245ad.66.2026.02.10.16.30.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Feb 2026 16:30:24 -0800 (PST)
Message-ID: <c71baae3-929b-4989-b520-a361feaef7ad@linaro.org>
Date: Wed, 11 Feb 2026 10:30:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] hw/hppa: Use hppa_abs_to_phys_pa1x()
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 palmer@dabbelt.com, alistair.francis@wdc.com, pbonzini@redhat.com,
 gaosong@loongson.cn, maobibo@loongson.cn, deller@gmx.de
References: <20260210-phys_addr-v4-0-725a589e83c8@rev.ng>
 <20260210-phys_addr-v4-3-725a589e83c8@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260210-phys_addr-v4-3-725a589e83c8@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/10/26 21:33, Anton Johansson wrote:
> Makes the physical address space conversion for 32 bit machines more
> explicit, using the translation function defined in mem_helper.c.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   hw/hppa/machine.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index 960aefc9e2..472b90aab0 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -181,7 +181,7 @@ static uint64_t linux_kernel_virt_to_phys(void *opaque, uint64_t addr)
>   
>   static uint64_t translate_pa10(void *dummy, uint64_t addr)
>   {
> -    return (uint32_t)addr;
> +    return hppa_abs_to_phys_pa1x(addr);
>   }
>   
>   static uint64_t translate_pa20(void *dummy, uint64_t addr)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

