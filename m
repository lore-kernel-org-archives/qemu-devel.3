Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C77C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 08:41:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR6P6-0007lG-TB; Tue, 09 Jul 2024 04:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sR6P5-0007k6-Kz
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 04:40:51 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sR6P2-0002WW-Bt
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 04:40:51 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so29383895e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 01:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720514446; x=1721119246; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FhSf7CTcys91uU+fZIOIoIf+mr8ywHbnC1+R5UJxBYs=;
 b=yj+e7Bh38qY8oGn2xXDaqFZLfswfiJH9j64NvJ9X2ZlyFQVJ1ZPF+uht6aDTGE+KkV
 gcaThWcOu3g6RNQJqySqbDRQKCDGaI/kmusqX2kuLTrlSCKvj+925d1I5BLKcOl88J1u
 DfMfbwI0FDa/GSMi7ZHDRdBAo3jfTIbPth+fkI81g6Tr+RdJAHaik6DY/Gy+SGb7D2HQ
 i7aAmTmN3FnuwFxxkm6YdHizTPCwu+0FnxQWRkKtFyjp5D/kRZkThyXHEsbqkjM8DQ+N
 2UQXH+5mzGvqco2rVxRvkmlUagHazDJHmEuUuVg0jRyiKXiO1VwjA5Y6xZrxHqQ2H8DA
 5VNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720514446; x=1721119246;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FhSf7CTcys91uU+fZIOIoIf+mr8ywHbnC1+R5UJxBYs=;
 b=rUP59cB+JPQ5sfo9HMtt/6HPa641dFrDaZeONzHfEBVP/r4kGedZJZ+Kk8ILt28Nsb
 IgKLgrDwDBlsQmEPwhczLxOXSNXWkPK5CWkerCzCzIGDdwcjxJWvCXDRbXJyey7h5gtH
 oT6go798FuYsUxycRBvXcBSqggMnelOCZFF+rXvvKv91mZR6QVt+RmZsgYwZXPKM3GzW
 BtGmbsOFW43eJ9d7kV8vPaEThN9yXgLkt+YZZtr8mNY52p+iXe3AYktl2tAekY4fcWVQ
 InKerLMexAVUbCWYNgVh0Bjfyju3jI0jd0GAuteC9Oyq4qyOY+8AHLDazw5c9HG5yVjM
 SQEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUbSJzkPqyBPUW3RjT5aM8AAH+clrVEZ7CIYqVEDgVEseM61/guKQzyUOjkrRcrby+iVvTLkwbl6vd99qHvJdVd7AO1mQ=
X-Gm-Message-State: AOJu0YzMZjdI8FEnG2rsPy2NBpgiSLPnwiXEWiiD6P3GZZ+KJ9K8JlD5
 w8V5qrvPJLBIjkqid/KLRwKRczcx4Hq7WCSNyLzRXc7ZonXmedXuDUNsKYpxE1c=
X-Google-Smtp-Source: AGHT+IGkCsllwNNmKShykiqxTMbfiXh5bfI1DomaLtH//HDYbc+jOhXdVW7Ix01vkW7mYe4FC8KVug==
X-Received: by 2002:a05:600c:68cd:b0:424:71f7:77f2 with SMTP id
 5b1f17b1804b1-42672338066mr12289875e9.16.1720514446179; 
 Tue, 09 Jul 2024 01:40:46 -0700 (PDT)
Received: from [192.168.69.100] (vau06-h02-176-184-43-20.dsl.sta.abo.bbox.fr.
 [176.184.43.20]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42668b87496sm78307215e9.8.2024.07.09.01.40.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jul 2024 01:40:45 -0700 (PDT)
Message-ID: <974ae42c-11b1-4411-89de-7a72396d9683@linaro.org>
Date: Tue, 9 Jul 2024 10:40:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] target/arm: Convert PMULL to decodetree
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20240709000610.382391-1-richard.henderson@linaro.org>
 <20240709000610.382391-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240709000610.382391-7-richard.henderson@linaro.org>
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

On 9/7/24 02:06, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 94 +++++-----------------------------
>   target/arm/tcg/a64.decode      |  3 ++
>   2 files changed, 15 insertions(+), 82 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


