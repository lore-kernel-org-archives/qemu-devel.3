Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E091FC67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 12:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsirk-00065l-08; Fri, 05 Apr 2024 08:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsirh-00065T-PF
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:40:17 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsire-00039k-PH
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:40:17 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-516c403cc46so4011995e87.3
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 05:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712320811; x=1712925611; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XxbVoTGHsgqwtvKB4IWqMw54fDqFOZGHYlsV29m4KxQ=;
 b=ofEbkcBPJAwLft+bbC1ZDA3edPX+s0tpCiyHAfEutZaXbXyaen4XpM/lp5D7HkMLId
 kUMpGqvk74ssDibIaQqtv81FPbOM8wsWI0mR5t5FnyFhTStQv6McQMD2dEBOzF4IleT9
 b9XSafePJiUCD0ncJU+MsE96cQMWe53heOXfE/Hcxzvbabz6xm27cXy81IOAh8rWjkmX
 84sx8THaHbLiR643YZ32Ny8/EenQIzUYLaCQ+xTCEAQjwDPKpVp6gyDJApDgumPheN0V
 TJjrXhCPolBAxKOVS2Ri3x7uKEkcA4yOOgv76+v2NfIzMcsWeVDNQ4hHmcYjpFK0yYm+
 Q7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712320811; x=1712925611;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XxbVoTGHsgqwtvKB4IWqMw54fDqFOZGHYlsV29m4KxQ=;
 b=eVTDPRDUhSWdpE4Xa7TxC2JvVrrmL4115SGUv4sfdwycIT1LmwHJAKx4W/AJCdX8q+
 0CfxeX/vH7pQxR1EiptbItv38j9X+X6pHklNYsXfV0R0f1wJokCm3Dye9i3w25e6RfFv
 KuhXe/fNFuOPdaIw2t1Mx9joJzhCbXht6AhA4bCcyQwgDsZ4wUezTsAB6pCTUfroqQYc
 6v9lzfTblM37C5//cmHaeDdibxuqKEdRcekCmNIiaZprxwN4n+2sZH5Zv4jQkDPpXb9Q
 XVUcCjh9eDHObyOETBFXUNKzLynlVVlnfsDnzQh0ppd6Nq68aJEGoO7bsXtnNMS2lgXw
 3yJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdtf3Zn1LgRDEXiDpJMCYhQXYzc4FmIniBE8NsttFEFd+naXpxoMb4Kc5Hj1QoG2Y49SJTCGcV1zk7hmOyOXLXrpLqPPA=
X-Gm-Message-State: AOJu0Ywzqj9BPvqIiW+2z/viuP+FzYU1BK1p0kxbKzk/lRmu8APeLj0B
 x7gidf4rQdvxMlE9LUqdJeNA2fpzHKHaL1AWMRnjR7P3aTOH5A4E2/8VSybZA1U=
X-Google-Smtp-Source: AGHT+IG1a3k3KgI5/4ipcsLjmhj1yMf7n/fdWmiUHHalNGwa2YlbFsfCU96NUi2vAluwHT7TZeK5JQ==
X-Received: by 2002:a19:4343:0:b0:512:fe25:550b with SMTP id
 m3-20020a194343000000b00512fe25550bmr1299007lfj.47.1712320810962; 
 Fri, 05 Apr 2024 05:40:10 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.34])
 by smtp.gmail.com with ESMTPSA id
 jy5-20020a170907762500b00a466af74ef2sm797881ejc.2.2024.04.05.05.40.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 05:40:10 -0700 (PDT)
Message-ID: <d24a8e8c-4e4a-4e95-9def-354a7b588dc6@linaro.org>
Date: Fri, 5 Apr 2024 14:40:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/32] plugins: Use DisasContextBase for
 qemu_plugin_tb_vaddr
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240405102459.462551-1-richard.henderson@linaro.org>
 <20240405102459.462551-15-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240405102459.462551-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

On 5/4/24 12:24, Richard Henderson wrote:
> We do not need to separately record the start of the TB.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/plugin.h  | 1 -
>   accel/tcg/plugin-gen.c | 3 +--
>   plugins/api.c          | 3 ++-
>   3 files changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


