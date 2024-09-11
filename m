Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383DAEDE997
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soE0D-0001TT-23; Tue, 10 Sep 2024 23:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE0B-0001SH-Fj
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:26:43 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE09-00010V-TJ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:26:43 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2d88c0f8e79so4918181a91.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726025200; x=1726630000; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pdh009yGduwZTST5YqvT1ncCj9Q+qW7QyH+HxojX1Ts=;
 b=N/HfE7qop3ZizE3yIuRSq2KlUcTha/lZAxkxCxgysrN9JHTPzjk9wXGaiYMA6wbQ9s
 HIkhU4fns/QPQKDYThfz4amLaJqtZumwU/QvhDBxqw0cGSV7Mi1u7lc9sR0ohY1cJCNP
 yAYaoRsKdPvG6d407prugclcPOLoVpz5cgqBiK8rHw3EbIdLbHVZjKLBWlmRDt0iGRJ0
 xV8K4w0tumRJDU3YvAExQZIjebW4GSSw++doGWmI5RYyMCP+VOgWD3sjheIqTnMikzga
 u9EPq2wlLQYP02oiABnXWvxHjScCjYbGU03W/vR032U0JihCJGBGIhJQmkzFpNTnXIdd
 SeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726025200; x=1726630000;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pdh009yGduwZTST5YqvT1ncCj9Q+qW7QyH+HxojX1Ts=;
 b=jpyVAKJcqqleH0pdzScx0IA2QCpInMPZejpaTpmcu3QjET2QT6vBiE/mOaltvaGnu9
 r9cCXgPvLjB81wZazDqxe2tuSNFJwckiRxMRkwFUyJzc52XRUIbIxG+vTyAAAAp9rRd3
 ef8VaHLPoyO2htKeD266hpUXwynqjf2IR9n0wt7fg8Pl3waT8XuFNKSHHOfeIf3k6C3J
 StOD8OzmeXGN0sU+0v18Q4KQBvW0kf+HdFlF1zK6OXr7Fdm69VcXOBUWSnKjbuZuLpZ1
 wcnAg+yNZ6koTpYmoxTlgc0A5SMDGsdYM3Jv18fbZU6SYDvzojYAYdoLwABvOR+CszGz
 7Grg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqKxrguwD+u3vQtrIrWzOT14WcO7QhrjMxuabhsJ2NmI1bCI5c0neBEmA6nFzBWyNs4hS2BvfzZMaJ@nongnu.org
X-Gm-Message-State: AOJu0Ywyqlgw9lw+N7xPDscUDGku/QLbv+6lKM7sgU7McI13/FPo242P
 fgDVy8qhkHocU/4x1kAUMKde9S5kETZeDO2O81Y22A99BgnviQFLY7GPqi8onPQpy6bHlzHJlnz
 d
X-Google-Smtp-Source: AGHT+IHahILPPi2Om3TquJZq8ycQkvehSrD5wsgBZZjLFFoqZXRetyKyttJp5qS0iFEA1MqgY09dWQ==
X-Received: by 2002:a17:90a:e10c:b0:2d8:53f8:77c0 with SMTP id
 98e67ed59e1d1-2dad4de0fc4mr20478623a91.7.1726025200129; 
 Tue, 10 Sep 2024 20:26:40 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2db04966d3asm7196574a91.38.2024.09.10.20.26.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:26:39 -0700 (PDT)
Message-ID: <06aa3123-0107-45e8-81c5-ef64a8a1fb58@linaro.org>
Date: Tue, 10 Sep 2024 20:26:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/39] hw/ppc: replace assert(false) with
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-21-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-21-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
>   hw/ppc/spapr_events.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index cb0eeee5874..38ac1cb7866 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -645,7 +645,7 @@ static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
>           /* we shouldn't be signaling hotplug events for resources
>            * that don't support them
>            */
> -        g_assert(false);
> +        g_assert_not_reached();
>           return;
>       }
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

