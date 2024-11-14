Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8A5D68B33
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcOW-0005pt-Jr; Thu, 14 Nov 2024 11:08:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBcNe-0004b5-6H
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:07:44 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBcNc-0003Na-2t
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:07:37 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43163667f0eso7072545e9.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600454; x=1732205254; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bBhHEF61l+0Qopee5hJyt7IAA+6q5Kb8PRWv833Y8XI=;
 b=bLh7xtmMPPeTYgfjM06JBSx2QcoeLkl2vjKbR99m63S//lvO0s9k5HDl71M4aO0N/q
 kcC7KZvfXQbAu8nIOpeKHHETbuQA26MhkSMfsLcRM1PsTSlTZ9nqfEHKAtP9Ge0yXgnY
 wosuYmMUnMtu0IufmYheUSK8ANc3X5AuBFG/wGt8geVqolprMIbyQegceUZCBbDlDt+O
 FPH3S2BkNjwOTApzz3/H7sb+LmUXxCodorFwsrb8CbvyyPekXGnVqTlG+rjfiCwBHk+1
 8RyJY8wLncbaj8+KhrSMooPsk/DCGW2GSlfDk/8QBNduC68AS4ip29j8ZYNe0E1HbI7L
 GDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600454; x=1732205254;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bBhHEF61l+0Qopee5hJyt7IAA+6q5Kb8PRWv833Y8XI=;
 b=uKoMaXW+0/hKtJRiRrVjkvrUSfE0sT8BUNVguNRAh+B4QYfsh+ah+UCkoBCTLwAeUS
 QTZiVIZaj244AHALvL50mj3ofWtWRL66Bo9ZuAOyOyCuZbMuQl/+mPy9713h5B2EF/8S
 +wmh3l8xlWZvPIayojoQVhjT1z9XnDGWHTatuMnfYlRwpJ8IHVxTT5LBT9Gat7MQ+9qk
 oQu+gspkeIcgZbgOE3FzCjTHKiC4USoASC/nFoYt7f+2kKQNz3ff5VztoEQVVSHSVcs+
 etzJUky5ET1qtYAsQt6UKcdakpx/vOb2op1fy49CZ20aKK0/+Q/paJ71hHsCYbZsDgy9
 v+aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ1T3jA1yscTfqat6/+MWdzyoGmU3RPX63B3Xz4+pg9J4rPjgKDV/cYRasQRXOMi3nj4N+8GfiiiVP@nongnu.org
X-Gm-Message-State: AOJu0YzRpmXQGEBaSOg6T6ougSfDnEAyVd5eysKMTGS/5o/xHsS4EUkT
 wRIpgEMvBI2nJ0KhIY/EStyY5N6jATH1QwYlWzbzBKA+0wZ8Iqm/hRwXiwY8+os=
X-Google-Smtp-Source: AGHT+IHjZHgUNJJg03g6FanV+yCx0iK8XBbDnxrbJNdqIZcZVahgFB8p/dsmbub+Q/AdllaExtXyTw==
X-Received: by 2002:a05:6000:2c2:b0:382:b57:f0b5 with SMTP id
 ffacd0b85a97d-382184fd7famr2040760f8f.12.1731600453910; 
 Thu, 14 Nov 2024 08:07:33 -0800 (PST)
Received: from [192.168.69.126] ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae311fbsm1816672f8f.95.2024.11.14.08.07.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 08:07:33 -0800 (PST)
Message-ID: <f5c31625-78fb-4bf1-a47f-081a146a652f@linaro.org>
Date: Thu, 14 Nov 2024 17:07:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] linux-user: Drop image_info.alignment
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241112203757.804320-1-richard.henderson@linaro.org>
 <20241112203757.804320-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241112203757.804320-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 12/11/24 20:37, Richard Henderson wrote:
> This field is write-only.  Use only the function-local
> variable within load_elf_image.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/qemu.h    | 1 -
>   linux-user/elfload.c | 7 +++----
>   2 files changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


