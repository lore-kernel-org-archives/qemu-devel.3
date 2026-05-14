Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E81CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 14:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNXDE-0001TV-Uf; Thu, 14 May 2026 10:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNXDC-0001N0-8S
 for qemu-devel@nongnu.org; Thu, 14 May 2026 10:38:54 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNXCx-0003GK-F1
 for qemu-devel@nongnu.org; Thu, 14 May 2026 10:38:46 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-44dd5cb0f81so5827012f8f.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 07:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778769510; x=1779374310; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g/iUShAJV0NrvgtG2Ho7xtC8TUIfiuegCyJXYtUhbmo=;
 b=UeYiXSwot01nfS9JqxCx38RO65r8Foy75kSs9ybMlOrmsBI9RUHETU+FEwMXgEV5na
 sjrF6sxphEPnlomQn8QfC4yvpUcZaQbRRtBL8AqAR1mwNhuFzgjqvhgqupoBLWy+q3xh
 qQW2J75I9wNDViQ+1x8d/2Q2mpmOP/13gohBlCif3DtR+NHnax2DYtRHE0+jtdAyMXxo
 nZzed5+MkES03rc0u/ZXFXG6JcvpfTsoE3sqpAAHJcIs8qbbJ6EH5/1HA3KVMMwKJFr6
 JIKjBEsaOvslRsN9EUjgYjW82LS1PL/LV9MmwCa/zQ8Rq0DcPON3fH6xOAlvZf1eF9zO
 Ry4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778769510; x=1779374310;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g/iUShAJV0NrvgtG2Ho7xtC8TUIfiuegCyJXYtUhbmo=;
 b=JnRgdCEzRrXf0rEoiyYcimxuQz9W9Qr4/hu7qwsLPNG72MyOezO80VLwcaRwuJQslE
 Mgyki6I/QjPzroziL7LVXHWVj+lvsUlUb8cLxFEkt53UniYb+adI8bTPRX73T+F2eIar
 SAEYymxZOSDwfbb1KzVvR42u+JQxG+ycZkTydvshgaPObotE/g6g1wJrpfgklWuiK6Co
 +y4Y7k9yD1DJ558+tqzKWFNz/+mlqNj6E0GUhuQKP4QlLoCwUgxJUYx7AENHWzFj2WfM
 p5niGmlJyF9F8otlqfzpfMh9BRvEo8fCQT1JTw8RrprUVomS9H8RzkGngWRAvES44iJh
 k9Ug==
X-Forwarded-Encrypted: i=1;
 AFNElJ9IhpHfJY1VL5IgGL1+nXMVIyJg0x4X/cUqz/P2LZYUwZe/w8z8qY8vR5IlUhfa0WX7ygV34Tjo/sEd@nongnu.org
X-Gm-Message-State: AOJu0Yy+cKk+CbodhIyx9WAKfU2n60DDgvO3gfysqv8q7du+nlpWUj6y
 JDvYZtIiaSO+TZFN4BR9tQ4JbV2EGtM0UHHlU7+eZ+f/JwF0+gxqzM1PIWqd8ofpK1A=
X-Gm-Gg: Acq92OEgq25lrdM5L2HaygIsAWtf5ocYG56gXHwTTpVVKLSscC2FlClD51/xgZqFq3Q
 Wuq+vS9PRhYAfI+KpYCLOYyau9Li3yIsEuznf+oML9WWii7j7YjXS8fqTxbHG9wXg6v7bFtIUWJ
 T8BtA8Hxs4DR4jIsjEEByawXxwZvLmQx+saMPjPuocooeD+FgGjWFwFIqbiXFYcpE4zaB2Viwxx
 nbBTd2nxFu5L1WFGwoNf8CQ3UjwEJHWTzEOTMiT+ZgQwXrdgogIQ/9vWDEL4R6XHG+gf3ro4OU2
 /byY+6SVyQcr/C69qhdXj8hkySE6YhTAODxqo6BwxJrkVqhedAfhF2nibDw0bOTbGiCVozzRfnC
 3AxPkfM/tEqJ/BMcp/nNufbsfjLENJLZpMaQGS5uAoyuieDzCZk5OAzqPUMCb51dfnP0+ISGnGK
 zbLBQo7cfv3XnwmM2z9RWLDLcSfqlGMWgepNjrarGTheaiVzkIVIoVU4eYqmKrBKFMHQ==
X-Received: by 2002:a05:600c:8887:b0:488:aa33:dc8f with SMTP id
 5b1f17b1804b1-48fe2308265mr13983105e9.0.1778769509975; 
 Thu, 14 May 2026 07:38:29 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4621932sm2994685e9.14.2026.05.14.07.38.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 07:38:29 -0700 (PDT)
Message-ID: <d734ad13-b4d8-473a-b406-3d024099962f@linaro.org>
Date: Thu, 14 May 2026 16:38:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/11] fpu: Hoist nan check in partsN_addsub
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260507160959.449170-1-richard.henderson@linaro.org>
 <20260507160959.449170-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260507160959.449170-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 7/5/26 18:09, Richard Henderson wrote:
> The nan test had been down below because it was unlikely.
> But if we have to have one anyway because of denormals,
> we might as well take care of them right away.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat-parts.c.inc | 19 +++++--------------
>   1 file changed, 5 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

