Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226C1C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 16:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpWcG-0003h8-UK; Wed, 27 Mar 2024 12:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpWcF-0003ge-7h
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 12:59:07 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpWcD-0001Rk-Dv
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 12:59:07 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56b8e4f38a2so50546a12.3
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 09:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711558743; x=1712163543; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BXzajOyZ0mlMhFLydnxqXKYBs2Pkmyqt5Y42p0ohhmo=;
 b=ij+cFDAuoIV/FgirdVEFvvIRs7OjNVyrwWAl0mfraxWL+Q7h/WbT0NzmeZDb7q3LuA
 mCJodGoWTeOqSTb8y7evJrSGVjId4rnA24SFprV/SBLI/RMylxZZ0mgn1m6fNeORkExq
 Xg7TXGpj9w2wRkyj4wBqc325pBh6QRKNilPgVeFtp772TsrWfH5OGIrVPdB636FHcOxo
 VXIjcI2Z5hNBME1nry6fVhFiNZD1SJMzvq6WqLJ3ocDUWD3j7vTaT5jPzm5w6Hc2s83Z
 s7MVB+ciOSVh48qPaFI4/YhiO4NsGGpWaIRr+bk23q1+DhzYujqP9IkUD7jMe4zYpKDf
 5LQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711558743; x=1712163543;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BXzajOyZ0mlMhFLydnxqXKYBs2Pkmyqt5Y42p0ohhmo=;
 b=AZXQYQqsYnrbkB6QPQaBS8oDarPP6sQXKxxtUALfjZeEoOgmcXOX7HupaWGPE8cvYX
 nlrilBEnmBjf1BtqWRPfNLFE4wkBleapduP7gP2GM92DjGg4fFw3HOZEGSUeqbHd6J2L
 8lm48rR+P8wfnlVc3Ht6rb9hG+THu8+GCT20AO+Yl6M/hxSr8i9roSlG9vynZm6qh02t
 GDqidabxmmFItzbwrUeDEaAPswR7K//JvlkP5uUHaGLPiDUAfhJgYxrsYMCfOMYkQetH
 0w/VuFUz6rR9K34a8R1k+/MVlQGMYZp8CNs5VN4Gp9Hd1MDHqygk8SgWqa4HSoi7mfUA
 mqxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+T0h8ty5UNcRrq5P5z38w/xtxZT/grT3jCk4w9Z0TK1oGU6aNPZQHx6dFRsezpGJgE6FN25Y8C50+MzKuYJl8E73XyQs=
X-Gm-Message-State: AOJu0Yxhw2njuA05qdTM9az7qxXuUsxK1ULU+Yrj5lp5+ISVZHm8lOOz
 2vroeqp8EDQlJV1Rf5E+sHi6/3y35UAD5i9q2yQsVK37nqv7OroEO5yPWYhpEkU=
X-Google-Smtp-Source: AGHT+IHPLEJnZZmxGW1gzGPRDeZzKO3cZkW/xVUy98ITJKjiUmSvNQEtS0rueZMx5cD8lcJzBsIIZg==
X-Received: by 2002:a50:ccd3:0:b0:566:1952:694c with SMTP id
 b19-20020a50ccd3000000b005661952694cmr263358edj.20.1711558743603; 
 Wed, 27 Mar 2024 09:59:03 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 m10-20020a50cc0a000000b0056b0af78d80sm5522059edi.34.2024.03.27.09.59.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 09:59:02 -0700 (PDT)
Message-ID: <838bc25d-5df1-43ab-a252-5ed5d97cbd40@linaro.org>
Date: Wed, 27 Mar 2024 17:59:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] Refactor common functions between POSIX and
 Windows implementation
To: aidan_leuck@selinc.com, qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com, berrange@redhat.com
References: <20240327162450.888453-1-aidan_leuck@selinc.com>
 <20240327162450.888453-2-aidan_leuck@selinc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240327162450.888453-2-aidan_leuck@selinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

On 27/3/24 17:24, aidan_leuck@selinc.com wrote:
> From: aidaleuc <aidan_leuck@selinc.com>
> 
> Signed-off-by: aidaleuc <aidan_leuck@selinc.com>
> ---
>   qga/commands-common-ssh.c | 49 +++++++++++++++++++++++++++++++++++++
>   qga/commands-common-ssh.h | 12 +++++++++
>   qga/commands-posix-ssh.c  | 51 +++------------------------------------
>   qga/meson.build           |  1 +
>   4 files changed, 65 insertions(+), 48 deletions(-)
>   create mode 100644 qga/commands-common-ssh.c
>   create mode 100644 qga/commands-common-ssh.h
> 
> diff --git a/qga/commands-common-ssh.c b/qga/commands-common-ssh.c
> new file mode 100644
> index 0000000000..5fcf589206
> --- /dev/null
> +++ b/qga/commands-common-ssh.c
> @@ -0,0 +1,49 @@
> +/*
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "commands-common-ssh.h"
> +
[...]

> diff --git a/qga/commands-common-ssh.h b/qga/commands-common-ssh.h
> new file mode 100644
> index 0000000000..04621dfb7b
> --- /dev/null
> +++ b/qga/commands-common-ssh.h
> @@ -0,0 +1,12 @@
> +/*
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qapi/error.h"

This header belongs to commands-common-ssh.c.

> +#include <qga-qapi-types.h>

"qapi/qapi-builtin-types.h" seems sufficient.

> +#include <stdbool.h>

<stdbool.h> is not needed (already included by "qemu/osdep.h"
in source files).

> +
> +GStrv read_authkeys(const char *path, Error **errp);
> +bool check_openssh_pub_keys(strList *keys, size_t *nkeys, Error **errp);
> +bool check_openssh_pub_key(const char *key, Error **errp);


