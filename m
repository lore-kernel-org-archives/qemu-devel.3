Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5784CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 13:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDN9x-0000vG-1z; Mon, 27 Oct 2025 09:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vDN9t-0000ui-Ba
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:21:13 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vDN9i-00054Y-Ci
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:21:12 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-78af743c232so4139573b3a.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 06:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1761571256; x=1762176056; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g8Q/30bUWm2O2CU+TjmYKHZVjlU36Cumj5zQfUBgl38=;
 b=fQS0Jr4vzFEo0OO9/bKhpOJBQW4jEz4XDaueUG3prMrSSirlnQJ0zbPmgzAP0OQ3lu
 Uyoe2RPfJriVO2ntnbZ5Gyt71MsayFSY7hIE4t76KN5pgki+0ntho9LIKlTMlwKS5V56
 JvQq7GAlXHaQyVo/hqL9QFBA+U88pqpcfLJenTcmbWGaxKpmaASwZ0oGLYoFdTFQApeY
 NodDZ8TZw7qZjJINrsktXU/lCkJkK3ud+UHw0/DqQUdYVKfbTQLRe+jG464/RvKLFPHs
 airUOTw2lIcKliuxB/5gPchrWPucAJYgJdNncLfuR7o4BtmMX2UQlEYPgwFaB5sTkt9C
 lFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761571256; x=1762176056;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g8Q/30bUWm2O2CU+TjmYKHZVjlU36Cumj5zQfUBgl38=;
 b=FXUKqlb3yi+6NQf8N7BIs9MEghdC0C88iVhBwLdmhzbWrGNyDp9H7sVwGa3jDLbwAO
 RRqY9i2Z6PXCLZqmpfjMvUJVXXDsy0VhsJnuKTVhcRROzkE6TxPwgicA7tepladDBT76
 JCBniq6gpxS9uHeiuU/OCq0Vzvs/zrz/qsVELqdATEVwtg+xQuoROGFnm7ggPZsP7fxF
 I0dSUggx5oguyJtdkKK5Pre0anZpLQqRT+fYd4ufTApGFtdLNT1hzIC+0ZOcJoUXEM7l
 o4ANiGyMIYoevk/hv8Xr1i5d1gkoZ/kqTt5QYpyVnlVhUp12Jifh4XvJpcTNjc5LVxte
 HTJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0hCWLLWBPbBJgQqH0aYmuOYGXLAUlohDHxG8eRCDcnbH/X24yeS7gru7vq2TSTvEl9f2KRyE9jV9a@nongnu.org
X-Gm-Message-State: AOJu0Yx+fM2CZaa2DyCB9x5DGVllSqPCI/4xSIBUi65brTV54aZEou50
 eJAeB+ES61WbKaNtKY4v9gYRdRexGKiF9OHXeMLpi4w4czI6jkrg3I8sGfDAvesrXkY=
X-Gm-Gg: ASbGncsupmIqH9IKwZP7rz3zfvb4ohxMSGCTUr3vTh/jHaiXaRgdeyX8Q30XZ5andp4
 dfwfK5TF+dmdqBhzK/gMndvFNNfJe6YexPNCYH9Q3QbUSm2K9tekYvUj2xzpLGuV1XoPwEAEnE4
 341njRBAyHythmWIUn2F980/L1AsFSRTRm/b3UKIFxfoWXX5QYDZwTwuZl8uZ3ZoJyXQ/JNpqLI
 G85Iaf1wTWCQAwlIYu6SGqjlFzxLYpcUtjs7Hcj6zO7Xh6O8Oehu5al9EBmPDfojWIupGVgAbTA
 RI/0TQ4GFjXk7XuhV0mhSR4zFmVBrB1pB4JaqXqllR6/teMb64McSyN7zJdWW8HFTxuJtrXvTom
 7IWq5rsvvzzpDCeuuofZoIyyVWaXAJDxQSauWP1BWT47SkDPanK85FPu2VUUGhru/YnG7USHxv3
 yyJ3lZUuDwl3//eK2x76CZ3ds=
X-Google-Smtp-Source: AGHT+IEFaUsLRDHzdFEW1FTVJTg6Zu8WHr5LIy4QXPlo5vm2eWFv+tazkRop8FO5HtkxIBUgO4B9aw==
X-Received: by 2002:a05:6a00:228a:b0:7a2:7610:364f with SMTP id
 d2e1a72fcca58-7a28688190cmr13165060b3a.29.1761571255978; 
 Mon, 27 Oct 2025 06:20:55 -0700 (PDT)
Received: from [192.168.68.110] ([189.38.141.22])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a414012c40sm8347826b3a.6.2025.10.27.06.20.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 06:20:55 -0700 (PDT)
Message-ID: <934bc46a-6a86-4cab-8cbf-c98a4cc92ed1@ventanamicro.com>
Date: Mon, 27 Oct 2025 10:20:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/riscv64/test_sifive_u: Remove unused
 import statement
To: Thomas Huth <thuth@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20251027112803.54564-1-thuth@redhat.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251027112803.54564-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x434.google.com
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



On 10/27/25 8:28 AM, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> skipIfMissingCommands is not used here, remove the import to silence
> a pylint warning for this file.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   tests/functional/riscv64/test_sifive_u.py | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tests/functional/riscv64/test_sifive_u.py b/tests/functional/riscv64/test_sifive_u.py
> index 358ff0d1f60..847f709da12 100755
> --- a/tests/functional/riscv64/test_sifive_u.py
> +++ b/tests/functional/riscv64/test_sifive_u.py
> @@ -13,7 +13,6 @@
>   import os
>   
>   from qemu_test import Asset, LinuxKernelTest
> -from qemu_test import skipIfMissingCommands
>   
>   
>   class SifiveU(LinuxKernelTest):


