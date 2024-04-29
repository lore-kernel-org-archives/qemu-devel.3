Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9079FC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 12:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Pti-0001k0-E3; Mon, 29 Apr 2024 08:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1Ptb-0001hV-3j
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 08:14:12 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1PtC-0007nL-LN
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 08:14:02 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2b1b1a38f54so662089a91.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 05:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714392825; x=1714997625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dxmptApXkSVOt3el2KCh1kBgHnBHAydzd7dSiEJeOaY=;
 b=I3pu4afvFZcH8abFfjtEBbiFG2o3sbEioBIXo9KojbdzLUQN4srzqF+fv21vg7x6iM
 CiqTOsN5WUFqwllwBpzAy32fu+LaTDloj/Ze1plZQp86Y7OMuDzFX4FkGbHy3UPXOFRf
 8SRQsH1ZMM1/OiS8sdEmPOvoGCWSj3ULSWNTvVNBNaoaaXhTsc/mmY/o0kDs6V66atOs
 /qna8TFRjrkG6ZF31CH/1kLyG72I6IYkRlHNWWwbEbviWhMjhn/K+bSn8MyNS9ZclbVP
 4uW6BDOOceL/fFbtDWujf+db3QW951MefMKL4Zo9f5zjq9yiqiCfrhU7tkZj+4TsFIRS
 h2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714392825; x=1714997625;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dxmptApXkSVOt3el2KCh1kBgHnBHAydzd7dSiEJeOaY=;
 b=plqJaAFFKrftrF4aJ3o0Q5tR9ZpPlUvNChcdCEoOqKEzrQ444Hf4lulfJMSsfIvm9r
 M4mRkzxVcfGId0WbUzpca6rnoktQ+2Sh2mqNceb7sNzHtMZlrEg0OqWEZoGF0V2YkaSd
 gYlQyfwWT+ljIMMxED6WEA9GZxgASg8M77StQsrlLX/gmjhFFQjVRMgved6TNJ3gYYqP
 EA3Wm8mGkduhiuGyyTv0g4dJt7NYVCtUmuW7hMBX8fzdEhhzWoadfqKiBiLCLUuwu5BK
 MD0tU82C/QSuqekmQVAVVk+68dskWI++5IyBK1M5kyo6mVhOnn/o06F8u/bdDRPCiOS0
 kJ3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHx0te+uSt6hiJ6BQlf94mqIArwOW5c7xzCZa+fh35dAbcDUPkudVY2GREZOXjkAwDV4HG8rJWpXrp/1UmJzy/bjKo19I=
X-Gm-Message-State: AOJu0YzZfh3rywACjdFQcR29DhwMvygCaq+LzQ4sVUoXshZ/dHq8opWu
 qRbFEPvllC8g3dh0jLnKz6fZbhR8PijTT322cE2br8jkFzduZff2vvCmRQzlx2M=
X-Google-Smtp-Source: AGHT+IE7NHxZ2l8OyTlZqgEDBRFhb1ktXN4lPuRP5SYuj9lvy+ACsqZsDEZ3erL9rtO9eIgeX7qA0w==
X-Received: by 2002:a17:90b:1c8c:b0:2b2:3f33:32c4 with SMTP id
 oo12-20020a17090b1c8c00b002b23f3332c4mr327888pjb.36.1714392825165; 
 Mon, 29 Apr 2024 05:13:45 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 y3-20020a17090a390300b002a232e4f9ddsm20802754pjb.34.2024.04.29.05.13.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 05:13:44 -0700 (PDT)
Message-ID: <7f26e395-b478-4554-b038-74a3dbfcda65@linaro.org>
Date: Mon, 29 Apr 2024 05:13:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 6/9] backends/cryptodev-builtin: Fix local_error leaks
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20240429064536.238392-1-mjt@tls.msk.ru>
 <20240429064536.238392-7-mjt@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240429064536.238392-7-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 4/28/24 23:45, Michael Tokarev wrote:
> From: Li Zhijian via <qemu-devel@nongnu.org>

Please fix the author on this patch.

r~

> 
> It seems that this error does not need to be propagated to the upper,
> directly output the error to avoid the leaks
> 
> Closes: https://gitlab.com/qemu-project/qemu/-/issues/2283
> Fixes: 2fda101de07 ("virtio-crypto: Support asynchronous mode")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: zhenwei pi <pizhenwei@bytedance.com>
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   backends/cryptodev-builtin.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
> index a514bbb310..940104ee55 100644
> --- a/backends/cryptodev-builtin.c
> +++ b/backends/cryptodev-builtin.c
> @@ -23,6 +23,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "sysemu/cryptodev.h"
> +#include "qemu/error-report.h"
>   #include "qapi/error.h"
>   #include "standard-headers/linux/virtio_crypto.h"
>   #include "crypto/cipher.h"
> @@ -396,8 +397,8 @@ static int cryptodev_builtin_create_session(
>       case VIRTIO_CRYPTO_HASH_CREATE_SESSION:
>       case VIRTIO_CRYPTO_MAC_CREATE_SESSION:
>       default:
> -        error_setg(&local_error, "Unsupported opcode :%" PRIu32 "",
> -                   sess_info->op_code);
> +        error_report("Unsupported opcode :%" PRIu32 "",
> +                     sess_info->op_code);
>           return -VIRTIO_CRYPTO_NOTSUPP;
>       }
>   
> @@ -554,8 +555,8 @@ static int cryptodev_builtin_operation(
>   
>       if (op_info->session_id >= MAX_NUM_SESSIONS ||
>                 builtin->sessions[op_info->session_id] == NULL) {
> -        error_setg(&local_error, "Cannot find a valid session id: %" PRIu64 "",
> -                   op_info->session_id);
> +        error_report("Cannot find a valid session id: %" PRIu64 "",
> +                     op_info->session_id);
>           return -VIRTIO_CRYPTO_INVSESS;
>       }
>   


