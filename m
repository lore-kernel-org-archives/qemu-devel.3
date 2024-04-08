Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6CAC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 16:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtsCr-0002Vt-EV; Mon, 08 Apr 2024 12:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtsCp-0002VH-6X
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:50:51 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtsCn-0002zH-ED
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:50:50 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6ed2170d89fso957504b3a.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 09:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712595048; x=1713199848; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rAZS7tJcDWCJ1Ej2+Vwfvkr8lzhoVjFRFPJPE4CRh9k=;
 b=h0po2tQd/O3JxmN4Ma8TVdfYIEmHjQyd2aBqtV/h/4tWPXJsG1tuRHQqYg9CLXVeqE
 EUt7UIyJUiZFZcXQeaXmP7fWrSgBtWLylnEJf5ZwttFMewGbvIti85+j8F3w280+etHU
 BuvLN8uyXt0oP4UmxMImZ/bBaM2Kow0Gc4R4H5W/PbNufz9trE6Yi3JxLEoU1YXQw7Ck
 VEhM/+M6t/O9AdT3a1ZrYw7H5aCDEZRHIb4ZV7+nSTQSRh+7f7XcPE8c/PbVsVZM7ANY
 gNUhKFqbtn5xoIp18rJXNjVVLSGLOccSDjKpH49D76eq1WxzMJ+EyZ7zkrm7cAemcXNA
 cg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712595048; x=1713199848;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rAZS7tJcDWCJ1Ej2+Vwfvkr8lzhoVjFRFPJPE4CRh9k=;
 b=aML6VxQ0fTDq9Y4QFSNaWTBUxO78STGIfZw+61FvmMIKK5MYdtB4tKPCLBvqepkirB
 WTb8+deuboI9EHPfyAwaneuorWV4mPfzs4mjDTqAUTgyQgL47QqJlEJoUoGxLMKoE0q5
 e9LlsliGpW18t7PD2l2ExkRfe9X7SQHgRC8NDmAM3I1vMmfjjtwnIl2UdgmyHrZ7SZWz
 ZPgER0QYD20VrP1M9rbK9dh8MSj6hhTYZ5goUQgNgv0GRUCGod2+nPCq90znoq0l227i
 xFIrt//Xbf4ojOXVKWDMngQmy4yoMi7Ng4t7slD/G+qZqGHYqIT8rERUIcKbqE4eC+8L
 HkZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV08gBdOtZWAMVnxlNzWHoXjOOQz1U3w3Ua6K9L7C+8y6GpwOXQlM77Lh8j6vmh36ZX0pJgyan0pX9H508vvw/5HWtB+A8=
X-Gm-Message-State: AOJu0YwuDBckY5ILTb3VWMxxeA/NbOcffGniktb345OdjvjjfxWfs2FX
 2e68vrTHXURJEnqZXIYgJcY5x7M3iLj4o6cb6cZk/gzV2x4f4z7gJwjdhoYm19M=
X-Google-Smtp-Source: AGHT+IFayS3acKMLGLn6nB51lXJpRXfFVA4cFcLmHwSCCPATJZABTu7W9BUIKJ5RB4XsXuYNh1YljQ==
X-Received: by 2002:a05:6a20:430c:b0:1a7:5413:1e6d with SMTP id
 h12-20020a056a20430c00b001a754131e6dmr443039pzk.4.1712595047893; 
 Mon, 08 Apr 2024 09:50:47 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm6708619pgi.65.2024.04.08.09.50.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 09:50:47 -0700 (PDT)
Message-ID: <8e3a63f8-a5eb-48e9-b7ed-dc66dddc069f@linaro.org>
Date: Mon, 8 Apr 2024 06:50:45 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/18] memory-device: move stubs out of stubs/
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20240408155330.522792-1-pbonzini@redhat.com>
 <20240408155330.522792-15-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240408155330.522792-15-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 4/8/24 05:53, Paolo Bonzini wrote:
> Since the memory-device stubs are needed exactly when the Kconfig symbols are not
> needed, move them to hw/mem/.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   stubs/memory_device.c => hw/mem/memory-device-stubs.c | 0
>   hw/mem/meson.build                                    | 1 +
>   stubs/meson.build                                     | 1 -
>   3 files changed, 1 insertion(+), 1 deletion(-)
>   rename stubs/memory_device.c => hw/mem/memory-device-stubs.c (100%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

