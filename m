Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764B7C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIsL-0006cj-Rv; Mon, 01 Jul 2024 11:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOIsK-0006ca-0L
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:23:28 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOIsI-0001oG-75
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:23:27 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7041053c0fdso1478452b3a.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 08:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719847404; x=1720452204; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9f0RYb7pS1bHCtmNp9F9Zj9h6sC3NgYnmgD0fd62l7g=;
 b=Ti6eJ5tZsCYG2yrYRRYyNce6CNmrgUd1JWygJKNZymejjMOnLgd8gR/fTnIfn8jR7t
 pPngYkNooY1nkoAk7gvuFJAtDNTc+4XsHvfOufL6/0npiOBf1ZFONp455LqaDc+pFFyU
 qbrHuUwUG2m5bExe5Y+Iowqwtf9fnMi7FeFa0ZIyNy56czGErjBAm41mDDmEB83mQjB7
 xnifmEzJn3aznWNHcTftJNwM3ryMp/KHU5i84PpjBOrtmCOF/izNiU+ZBG+Uz2bXpZEG
 bOmdykJGYndHgZXWFwlNSHKRsIecPHWusM6VbAzNWMVQob9bIQE9CgnlQbjdTT3NdJr3
 UEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719847404; x=1720452204;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9f0RYb7pS1bHCtmNp9F9Zj9h6sC3NgYnmgD0fd62l7g=;
 b=MulOMhPMwrtqfEEwgvsXZUhuYRyjkO7ADUe3Fpv82N5vIzVgw5DrQB7ieINMsZ3GWL
 WKyBiWw6NiuPlTk2tAjsrcoCRhUtrxQjQD4prXc5o12AWfmy/Dckn1phEf2kswlDc8x3
 goQUaJ7X+zsl6M2Z7yDGdlOZAv6UiV82RyonWG9U+bqRjYumBSjfPz/8rUVqDHz5r/No
 CBMjnBLCw/+v3ln/qgNxkYZnTdQHFXAYYTisqNTQp9eBTH52a7Dg1VevWzSIGqzQqj9h
 AjN7COBhCjYp1X1fY/KgVJqdMizOLhTMNFrGkFXQkXjjlX/Rim+JyVfL5Zh+WYhJ8Zk9
 1J9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWV9FKr4DVKSJbiN6pP0gLt5lDkYLUiuBWyi7FXJcNX7rrh83EWb1zE0gxbogv6htRF2OpCEzPV3zAvDo8e9i9iKm+j7cE=
X-Gm-Message-State: AOJu0Yzi/vYAdJhiy8QGVAgWT1ubsu4Z/tHZzaBLmExWQAnkI/EGPKYM
 LcciT9vUjERMbBVxkj1nc9ozxX0N5cYeVfwFUYuS1gPOHd2LaRzshkbhW+BIwpdmA5KRx7Vq8ad
 h
X-Google-Smtp-Source: AGHT+IFFvscRH6ufDksHuqGrQFQQ2Rs0daSzVIAUNWEMO5PGG603Bvy1nEV5R0qsBLtlA+0n+6KAsw==
X-Received: by 2002:a05:6a00:10c8:b0:708:944:2316 with SMTP id
 d2e1a72fcca58-70aaaf350f7mr4862563b3a.34.1719847404138; 
 Mon, 01 Jul 2024 08:23:24 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-708044ac424sm6617040b3a.161.2024.07.01.08.23.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 08:23:23 -0700 (PDT)
Message-ID: <522ccd9b-8551-49a9-ac01-0c26776a3d57@linaro.org>
Date: Mon, 1 Jul 2024 08:23:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] system/vl.c: do not allow mixed -accel opts
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: ajones@ventanamicro.com, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20240701133038.1489043-1-dbarboza@ventanamicro.com>
 <20240701133038.1489043-2-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240701133038.1489043-2-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 7/1/24 06:30, Daniel Henrique Barboza wrote:
> We're allowing multiple -accel options to be used with different
> accelerators, even though we don't have any machine that supports mixed
> acceleration.
> 
> In fact, it will only parse the first occurence of -accel and, aside
> from a help option (e.g. -accel help) that will always cause the process
> to print the help text, it will accept every other accel option
> regardless of being correct or not. E.g. this:
> 
> qemu-system-x86_64 -accel kvm -accel tcg -accel IamNotAnAccel (...)
> 
> will happily boot a x86_64 KVM guest.
> 
> Do not allow for different accelerators to be used when multiple
> instances of -accel are present.
> 
> Cc: Paolo Bonzini<pbonzini@redhat.com>
> Cc: Thomas Huth<thuth@redhat.com>
> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
> ---
>   system/vl.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)

We use '-accel kvm -accel tcg' to allow kvm to fail (e.g. no /dev/kvm permission) and 
proceed with tcg.

This patch will cause testsuite failures.


r~

