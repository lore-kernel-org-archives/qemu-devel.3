Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8BEEE01FB
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 01:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soCL1-00043h-2X; Tue, 10 Sep 2024 21:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soCKz-0003yA-LB
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 21:40:05 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soCKx-0004wA-Mv
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 21:40:05 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2d88c5d76eeso4021060a91.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 18:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726018801; x=1726623601; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QinYboH2bKtVZ9JQK0IIdUsUI4yRmNWTS8p0DWZS5js=;
 b=IaJfGLUUN++9Z2F62RfzRZnHQLNNv83/CHFApLJ8ZptMZpol20GRjijP0VEKXNx97w
 8HxulHqeBevqRHSaAaFP6xiwG4VgciDIqAwBEQjmUYHCy92xe+tqBRSI+3jjNkoqeCwJ
 77TLSCm0HNhlLq58t2/davQdfDNDxWIJnVFonkS8GB0Z157FC4iP/OwPsYDqrQAK8w9V
 jWhO/yFuyXRwUubpbCMOL3WhmmcieprV+UeYtIs9ATpnD+lkwjO0pf3Q0+u/xNtRbcHU
 K2jsfNR6FMSyjZfRDwksk6kLGpJs4PxOQsKwmgPV7IKxs124jLU48eFJ71hBJPVsqi4A
 rCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726018801; x=1726623601;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QinYboH2bKtVZ9JQK0IIdUsUI4yRmNWTS8p0DWZS5js=;
 b=f6zdkKCHMmYaX615vAQaphgKcnD0/DeiP3KWSeC2PnrVJVSEm7S79JJYTnVRa2z0sZ
 tWYrNRcRiD8welvjcWPAw6IzfgKmRiZBXAGkZiT0aalLOPTtvYahOtXai/70YqXoLfcj
 8KoovSpB4sCRwzTsoauXDBBxdpmkFYeNHOq8hkFSwJrRWeQ0FGgfev6wY6yRCszp5e5a
 IwMew23DzZwLtsh3jCj8pRFlk8YeNueesbHNBr3XKd2O9H4CXv6zetJ31I9d2PWyRxse
 wF5Y39tciaydIy4kM98OsxCV8CvTyvOTIiuFzpPKuBRmnmscnivNAY3cR2igd0VLjPMN
 mhNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7qyeNc17mqOw/Y423roeCXa7TidP8cFiKwA/Qo41KVjELvrEsh0fRROY9ZObEvOViPVqnQkjhDNeO@nongnu.org
X-Gm-Message-State: AOJu0Ywf7GmwcTA6ehKMMsKYnOKW+QaM9BB3inkWbOG3zuCxQS1dvFtB
 vPSk5gDG91lyFcmVnbV2d19SYOkisc2iQ1oPJ9xKREWHpaigLNHnCOUY09gdOJ8=
X-Google-Smtp-Source: AGHT+IEBbxzxjnmgKRFU95Td8bdW6q8iX20yEHAioa/6sq6FnqhjBahFracvnEVuKv7dukfY8rFPnQ==
X-Received: by 2002:a17:90a:b013:b0:2d8:9040:d170 with SMTP id
 98e67ed59e1d1-2dad50fcfaamr15444142a91.31.1726018801108; 
 Tue, 10 Sep 2024 18:40:01 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadc069bb2sm9287644a91.30.2024.09.10.18.40.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 18:40:00 -0700 (PDT)
Message-ID: <65944aa7-bf9f-4365-84bd-d492506f742c@linaro.org>
Date: Tue, 10 Sep 2024 18:39:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/39] hw/char: replace assert(0) with
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-5-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/char/avr_usart.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c
> index 5bcf9db0b78..e738a2ca97e 100644
> --- a/hw/char/avr_usart.c
> +++ b/hw/char/avr_usart.c
> @@ -86,7 +86,7 @@ static void update_char_mask(AVRUsartState *usart)
>           usart->char_mask = 0b11111111;
>           break;
>       default:
> -        assert(0);
> +        g_assert_not_reached();
>       }
>   }
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

