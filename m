Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23C6CDE002
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 15:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcPh4-0001gL-48; Wed, 24 Jun 2026 11:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcPgs-0001dy-RQ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:39:02 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcPgq-0006vY-Qy
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:39:02 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2c7f385883cso1403835ad.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 08:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782315539; x=1782920339; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B+Le6JC6UZJFeqikOs6p7XcSYx9F0PtvNwizfSFidR4=;
 b=D4xBF+2d2rZ7B60ArHtaytVw/YaYlaRSzfWZ3euYM+ikhKV4ikOPqWUqJbZjBHx4Q8
 iMUbVTJOFWa6DMotOjf7fGWLPqiNbmjzHnA96wHruJn3PwcgpliaP9M/BLgzERxq/vE0
 wO4sKEBJ0Q5C+nUyWGo8vqxekAnEJBCc/lr8mBzmTDblD7OZb+h6dWxso/6iTEfkZi1O
 27RhR3cFOSbQjWHFHgtB0cOgYKDnhWi89dBwNlyDrox0Qfov32dj+cVYklSNlqz+Bh8a
 f3KTBQqftWF+vXWy+Ni6pbEr8IdWYQ/URBXSc1q+igY5QwQ+p2NcvCKvtBhMbYY7DeEm
 HqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782315539; x=1782920339;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B+Le6JC6UZJFeqikOs6p7XcSYx9F0PtvNwizfSFidR4=;
 b=rQ+pTFJ3d5k/GqAruiJdV184Tt/wy/ynC4wDvjAiAY/ZrDHVVp7rPW2lCVe1GUPoAN
 TimY6VLwulg9zYJ5OgneF+BQghwqB9zCGnP5TyBejQRZv5/wb9+xI6dxp2xHXHveqK1u
 UKqbsaX2OXqceQdU3WNJIgmrsy07QbDARSOTgJuKl1yNDRY/QhNnJGV882jKJAHxHW1W
 R3yKTDyidhALJFJwKeuS3jYURYUtEQXtEoGChwa1+Pwz2luu9KG2KGypSa66ZA6MS55r
 yACSDskqvsItb09o19s3Sh95XEXD/FZ+xKqlD4tjcWsMxY68Gm7EMTqZoq4oSayFlqu4
 G55A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr2t/XoP1G+7OvZFo/FXGHXxc+8+0FPwVlDLdAi40zI5qY/+hfFWE18MGmRFbqaE9sLMvWee6fC3B33@nongnu.org
X-Gm-Message-State: AOJu0YxEoRKE86f/WQtkNAyzAy4EbQRv60MwioUUYd0Y8AH5XDKG7Jhi
 E/IJ72WYWgDHw+ESP+af+Z/JCy9Wr25iS6waxYXccWBnaRJ1GPs23FhCiNxANhUHzBw=
X-Gm-Gg: AfdE7cknJ0jnj4nAGDeeiUlTB7iBcaVZghdNumShjLBD5kSDcqSF9H1M68ujoly+yqd
 BCuHDisFvqJjuzRODZY1D3X9Z70SlPodcrrDNzH0cG9dexeAqPjIVJZPHpt5XnBpwDZ8erKWW7C
 1i7dqff8c9q1c630EbbjNO/5jq6WOF0obCp5cWBMPIZ9K8Uiny6GcHJYg8eoOqHhAzGVWGmmxHa
 7QWuFjl9vxM17CxlElOs2QWQ8wZZakC5gAJ7nD+EIDfQA1KWrvgoElqHFr7EuDoMzWLJDBFOQxB
 TX1bw4gBC2LZ3v/zxqOOv7rQn8OHoBjEY3Bu9uC+q4jVs/YvkT/nXUl2RpNz5lKqYorRYcJhItg
 wdBbXc3WvT0A35E9PlQX4jjGhYXtcGcN6bUK+vc/VZXTaE8ek1aaR43XaHei2uBKfRl/iN6PQ4Q
 gKccfcMyCFGLsXOBdZiWd3oLZjOBc36+mxTjAr8SfhcSQvvwRZRV7s7iyoMA==
X-Received: by 2002:a17:903:988:b0:2c2:bd0d:3cf0 with SMTP id
 d9443c01a7336-2c7e157f332mr39925025ad.25.1782315539008; 
 Wed, 24 Jun 2026 08:38:59 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f65082easm505365ad.76.2026.06.24.08.38.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 08:38:58 -0700 (PDT)
Message-ID: <c154f7cf-9f9e-4b5f-8ed6-65accb382e82@linaro.org>
Date: Wed, 24 Jun 2026 08:38:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] tests/tcg/arm: Tests for new FPRCVT instructions
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alex Bennee <alex.bennee@linaro.org>
References: <20260624-jmac-fprcvt-v2-0-dc6cf8e512b6@linaro.org>
 <20260624-jmac-fprcvt-v2-6-dc6cf8e512b6@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260624-jmac-fprcvt-v2-6-dc6cf8e512b6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 6/24/26 06:37, Jim MacArthur wrote:
> +#ifdef FPRCVT
> +        asm("fcvtzs d0, %s1\r\n"
> +            "fmov %0, d0" :
> +            "=r" (output) : "w" (input));
>   #else

Missing d0 clobber, but better as

   asm("fcvtzs %d0, %s0" : "=w"(output) : "w"(input))


r~

