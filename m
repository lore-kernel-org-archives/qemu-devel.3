Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E675D2ED08
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7vtx-00010z-1g; Wed, 01 Apr 2026 09:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7vtn-0000o7-Ed
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:46:24 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7vtl-0000qf-7D
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:46:23 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso59441395e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 06:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775051179; x=1775655979; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fxY7IpCefyW7whP+pVdfaDfUz34fB4PyDsKtotqTMZM=;
 b=yBxaw3mP2sscPbg6o1lgrxrh2b6p5v6qUEzRblA0gTr3yqytPNWXp0Zt71O+16xL2p
 hT1E9KKhL2QtI0LYdCicwFK9fVYXjSg8CilOeGqQnsa0VfFUulXXvTwfjq1zNyyVg47x
 OaLDOvG6YPPEEDl6/fM48xbUtZGPccvNiqfpNLQ+tFN4n8Cz9thuq42xR0FKpQ2fXHEb
 qQOPPT56juhaFYvfFBlDussjJCTBjn6jf4z6f9Sn+eeap4vZJEeGatbrv1wirPwb/GwB
 U2gJIMzZpgaULl9OQUTsW3a7tz49x8xsbbu+A+fXbuc0nSxkAMY0pl3wxWlrgU9u7FN6
 5VIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775051179; x=1775655979;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fxY7IpCefyW7whP+pVdfaDfUz34fB4PyDsKtotqTMZM=;
 b=RZDG+PhoK6MajdV/OREQXmq/yzj6MIj3c8J5w2LyccNeeIH7I9TVLXpFNao0fx4HSs
 U2vrSJSOdbcR05gFqj6dLcAGUdU3M3tLypKtSb6usQa7sLlDL6JnwivnifsSmyohBECG
 MRlRY3ZRV1lqTdjtyNrbQZDEo3REKalDpKBzfzTfRNaWAdcgE4XQTX+a1G5KWS0mVEHN
 Vwadj+R7+ALHsfAOZFxpV7ZVx9KgWHxVw8pVX5R9RwNiGUJqQT+WI40ZQZqSq6CKjVnG
 lkVvKYvKef0g2NZ9eFvtNIGn2FqIHdCROV6cELWIBzpwwdVZDCFttqW3OXIuTNYu3xX7
 KkSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB7I1qwoPgpgDMNmG4PuCU525yOzV3fx1GG6kZkfHWqWBKPVK3RRNpNNJkUZqPXcUTcomc9iXWRin5@nongnu.org
X-Gm-Message-State: AOJu0YymuU7TqwxkeVdPNVru5Yh8qf6x42PwvdW/l6ignGh6TTQm9Ybx
 Ie5txdFYxmUm4RsPc6k9169kuqF0h3SfcMZrJddxH44/lpiaQGPeKZ500POBrt7o/Nmq6I0qip5
 V7bRLVwQ=
X-Gm-Gg: ATEYQzzSsPSLnM+P+1srKBLmcPpAB8osY4WPTtppB4o4J28OmXw9aspHr5uOxg66cXY
 L34lBqrKqycICiA6eGe3ncqJHvITYWZCSE6d0UxVW/uNyrSRy5HXIZ2mpPx9gKF4rG4i9O22vgu
 pHBx+hXos+D2imZXJQz2C7SUUayRk6J+PSa9Jf/wElwl/QxCJRVyW65tqXKufnYVtJFYaOpI02o
 GbgJ6wGamjcouDs3NphjQOCUjLnTyHuShUoNaW2lbQipbnmq3wQVtuhpcN5QOzxvSbiu0oCpOX0
 5bvTAlMtvlt4WmSDXK8cVlB4wmazoq6p8J1g3hYkcov/M5JN9UobWpvoNLaxqFQyBhf/5GXQ0mx
 a00zJOMn439CSFgjvb1Iqe1eAH2UcvzBMzeEDg9QCOT6+D79Mq2qnNh1jAnolOO/+MJmtflnWm3
 JusDDwY7G/fR27dbXbQkt00VjotujeXwXC7GGXGab6Yvs++uyCyAp/HayVmpAVNvYTTw==
X-Received: by 2002:a05:600d:11:b0:485:3ff1:d5ed with SMTP id
 5b1f17b1804b1-4888355df72mr62639515e9.1.1775051178765; 
 Wed, 01 Apr 2026 06:46:18 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e2a71f7sm35215f8f.1.2026.04.01.06.46.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 06:46:18 -0700 (PDT)
Message-ID: <c821c6fe-9d05-40a3-9a41-9c56666762c9@linaro.org>
Date: Wed, 1 Apr 2026 15:46:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/60] ui/console-vc: extract vt100_init() and vt100_fini()
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-30-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-30-48eb1dcf7b76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 17/3/26 09:50, Marc-André Lureau wrote:
> Consolidate VT100 initialization and finalization into dedicated
> functions, continuing the extraction of the VT100 layer from the
> console/chardev code.
> 
> vt100_init() gathers the scattered setup (cursor timer, list insertion,
> FIFO creation, default attributes, and image) that was previously spread
> across vc_chr_open() and qemu_text_console_class_init().
> 
> vt100_fini() pairs with it by handling list removal, FIFO destruction,
> and cells cleanup, replacing the open-coded QTAILQ_REMOVE in
> qemu_text_console_finalize().
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/console-vc.c | 44 ++++++++++++++++++++++++++++++--------------
>   1 file changed, 30 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

