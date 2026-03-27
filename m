Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576DD10F287A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 23:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6GXu-00068B-Gg; Fri, 27 Mar 2026 19:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6GXq-00067b-Ie
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 19:24:50 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6GXp-0006kw-5p
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 19:24:50 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-439b611274bso1405213f8f.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 16:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774653888; x=1775258688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hWXl9JV0rE+rpJaSlQxZ62n6iMAe7KcIalG3ENfsSQQ=;
 b=Pl2orZUMjNpTLUYdlnZV5hsiYFumDH19OZIRr2QyX8CsVfeuwMpXVjzhRyoSAIzZa7
 XDFfffnPeny4e4xY3K9YgeLph92zFJ2AgW+/Ar7rXAz3GJfGKXeUchLasHtAvDfD4RY9
 omFbC7kvxm++dIbBJtWHBBTpdjBCf3jMcyYm/EUi2GO9VNtTAZLRtTcvijhtgx3y0qej
 v/hx7TbaeFfK86/6iHV9wWx5b7XwkMcSd8Ntt4uy0ry3Ys6wFAJTXL7ePPjm5Lyikfhp
 iVjvkwYhU/qUodF15MW6DjTnjRNVakPFqc5cXJAm2HKxcBd3Z7bxQHRVsQe0EdLJ/dyL
 EJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774653888; x=1775258688;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hWXl9JV0rE+rpJaSlQxZ62n6iMAe7KcIalG3ENfsSQQ=;
 b=mpW9ijhyP1i7cyh5eirAKnW6d+KdUT/1h6I76/iftSuhk7vSMeKX2dtL+j28AG7pqb
 YnsUDincd+kISelIaHUP6IQ5g8Lw/LmrcBE0TCHERalCOAS51rFWynzJq7iiT8C3N7JA
 Ir6szEFVuBT/gJpyGhjRZUK+6VPiQQ/dIJ9bSbvPjIA64vRW8cgSreHcgjV3BTVyVv+Q
 agGto8hiUH7jhX3UWdhLV3OHnNbVuJAeqL8LSLQH2cE1SSZyAf6MhbgAuVAM6nyaKvOo
 6zfLv7nAu87m3MGW9qoF3OW5lud9QLzOYMMUFwCl/hTjR9zS6SgrgZIokqMbW1f3GLeh
 swXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJgZ+aj6XlDmXP9bXUKRjHrU5urvPYZt+TusDEdLLujhARDFcYis+o2U0k1+L4Di8B+F9bKdxy0PDN@nongnu.org
X-Gm-Message-State: AOJu0Yxq3JZyY/O6BfiQZBnXRf0gYp62KVuyGZ4q1AsN8/NFcO/jO1x5
 x8WIoUDYKOruS2KomLuEW5P9w93RBf8oP83QhBL+bmE9n6LkHKOwPiwQZ6LLZ0WsjlhBTJT1/UA
 k0w0tvVA=
X-Gm-Gg: ATEYQzyg58+fdpbMb+MeNIryttYGWvvGG4D2rjSk1+rGfqALV1rfsaoiTAaD4HQaRjk
 piFmiDVfuRSBVfwyxJc+yPjrBzLAGlCmHTvcguyiutnzr7UEJucKB/8idx/7qsOXFmTJZJLFRea
 G2r3KBvW3YwNXgQsUKe3W9+JrWxn8/lTaRdG6JqwIOC+mCEb86Q4E/Tu6jZSYmV9JVktkzmyypG
 qr7FISiRZ1O1bdDEHAs7CRQtgIEDQq4oMjLRj33qxI3DjeDddsGXSBuIJRgalCYSy5jAWJIDM8a
 h9xi2xeDcDL/FFxYMXjAtabEqpnLBAUlz9Vuq1fKCPepxMYpHWiKSJe+Z0sN6ha2E0aPoYMLTdj
 fShAWBoE0AtlSxAHjhgPvRZ42sci/qsKff24Dj/LjtMff+uVwuKKZenlDoYd9qupJQ4sNssiCHi
 5g19Cb8uYiN8mOZUVQw95ZPPu/u4w2dCrB/MQj1FGoihnSKagMevtzhpZWI2qoWIuBSPunR5p/
X-Received: by 2002:a05:6000:288c:b0:43b:4720:1102 with SMTP id
 ffacd0b85a97d-43b9ea4aad1mr6708659f8f.32.1774653887581; 
 Fri, 27 Mar 2026 16:24:47 -0700 (PDT)
Received: from [10.202.147.66] (147.149.216.82.rev.sfr.net. [82.216.149.147])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21eb95fsm1327164f8f.12.2026.03.27.16.24.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 16:24:46 -0700 (PDT)
Message-ID: <94f1f365-2ef1-4882-ba11-530a318c543c@linaro.org>
Date: Sat, 28 Mar 2026 00:24:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] ncr710: unify two conditionals
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20260327212547.460420-1-pbonzini@redhat.com>
 <20260327212547.460420-17-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327212547.460420-17-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 27/3/26 22:25, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/scsi/ncr53c710.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
> index f7b1e153960..25a1018ab11 100644
> --- a/hw/scsi/ncr53c710.c
> +++ b/hw/scsi/ncr53c710.c
> @@ -797,13 +797,10 @@ void ncr710_command_complete(SCSIRequest *req, size_t resid)
>       s->status = req->status;
>       s->command_complete = NCR710_CMD_COMPLETE;
>   
> -    if (p) {
> -        p->pending = 0;
> -    }
> -
>       ncr710_set_phase(s, PHASE_ST);
>   
>       if (p) {
> +        p->pending = 0;
>           ncr710_request_orphan(s, p);
>       }
>   


