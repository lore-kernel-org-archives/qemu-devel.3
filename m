Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC03D1814B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ipp-0002i4-BM; Tue, 15 Oct 2024 10:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t0ipa-0002gn-Oq
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:47:29 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t0ipW-0006vB-6k
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:47:23 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71e5130832aso1950275b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729003641; x=1729608441; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oLU9JFZH41dRezNGjUIlFApdphtq84Y37lvITKPsGLo=;
 b=HPt9cLRzVFPt2olwf5z/rSbi+p2PnKIRFU2bGUNwH1vv55BOGVEwPyWAdAqrtk6nBE
 jwCo/88/TVl88CoJIV/+ugSPw+fsa2l7YObgA5suAUgG8uXvxcqC7UCL6hVeC/9MaiRr
 VkMM6+VAveDyegdEQMCQI/SMCRtyvSN7OssfRqDgyZtdtWSyC9AMVY8u+uKeqKEaXa+l
 Ju1+EiT7njxRfgoF4cuTUtTr1gWNY5JioHb+6SwKxaeNkbdGWvjK2g1jJrLzWAlMTg6o
 jqAs2eMMrIefSHonF8xrf3Ic879suhgX41FKjIFTrRa7H6vcrBgE5m9A2gPOHYT0rgq6
 7ZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729003641; x=1729608441;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oLU9JFZH41dRezNGjUIlFApdphtq84Y37lvITKPsGLo=;
 b=btb9iNBZeQDvDtlbHXojJEktTyuaFezJ2fWn8bCUs5jLrCINoMK7IVJg2Q8EAhrCl0
 eQA2xWPxBlAPbagO9YrhXFno+JVPXL67TszaF8viect33A1W4SHhghhfoogBLu7gbTyU
 ETuRJroFjg5K/KZhVVB2ga0lby/sS0PklIAVdIN668fhp9mgMVxc7w8qEZKtS6J2UHNt
 DGjfKJMJOUd5wsG6x9hirTEdV0jVm8v1fOlGlwt/qapL9ebzn49aI9WNjSHLQipjTw2F
 Uawg7Tublhe1DFTwYHG38Wt7bvsE4E23h6JEXfvOUmGs9fdq0QBypUqxep78I3ZDj73Q
 5LzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb+VjhZ2CTtbZuOF7oFKFGVu3oi42Zkqv5IKsoIqk3Tb88kkaMUAf2DZHE3AHTTFb2m+bnDvraT8SN@nongnu.org
X-Gm-Message-State: AOJu0YxysNg5hmFzLq8lDgsuIqbMQPORuQBLxQroITvsTz6WJlqmqR+U
 Wa0HgpIRkVl1dn1PQzq9KvR7Z8jmM9tl6Kbb8IF5VyZWw9G1FUlMSjBd7dP2ygU=
X-Google-Smtp-Source: AGHT+IFW5cRIODPbiNm59YeWZaPskcbDW4uvUJsIIGwfJaMDcXJGXWP9bZmpI9h5ijsJFOVP8Qkr2g==
X-Received: by 2002:a05:6a00:b87:b0:71e:19a:c48b with SMTP id
 d2e1a72fcca58-71e4c1cfc30mr18172068b3a.22.1729003640713; 
 Tue, 15 Oct 2024 07:47:20 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e773a2fd2sm1345111b3a.74.2024.10.15.07.47.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Oct 2024 07:47:20 -0700 (PDT)
Message-ID: <3a7da33b-c802-44f2-8478-ce4de64665a4@linaro.org>
Date: Tue, 15 Oct 2024 07:47:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ui/console-vc: Silence warning about sprintf() on
 OpenBSD
To: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, qemu-trivial@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20241015112510.412471-1-thuth@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241015112510.412471-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 10/15/24 04:25, Thomas Huth wrote:
> The linker on OpenBSD complains:
> 
>   ld: warning: console-vc.c:824 (../src/ui/console-vc.c:824)([...]):
>   warning: sprintf() is often misused, please use snprintf()
> 
> Using g_strdup_printf() is certainly better here, so let's switch
> to that function instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2: Use g_strdup_printf() instead of snprintf()
> 
>   ui/console-vc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/ui/console-vc.c b/ui/console-vc.c
> index 8393d532e7..53fcee88f4 100644
> --- a/ui/console-vc.c
> +++ b/ui/console-vc.c
> @@ -648,7 +648,7 @@ static void vc_putchar(VCChardev *vc, int ch)
>       QemuTextConsole *s = vc->console;
>       int i;
>       int x, y;
> -    char response[40];
> +    g_autofree char *response = NULL;
>   
>       switch(vc->state) {
>       case TTY_STATE_NORM:
> @@ -821,7 +821,7 @@ static void vc_putchar(VCChardev *vc, int ch)
>                       break;
>                   case 6:
>                       /* report cursor position */
> -                    sprintf(response, "\033[%d;%dR",
> +                    response = g_strdup_printf("\033[%d;%dR",
>                              (s->y_base + s->y) % s->total_height + 1,
>                               s->x + 1);
>                       vc_respond_str(vc, response);

Could be better by limiting the scope of the variable to this case.
But either way,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



