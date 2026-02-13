Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0CAEF99C5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 18:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqyGk-0001fC-H8; Fri, 13 Feb 2026 13:51:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqyGi-0001eZ-T5
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:51:56 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqyGh-0005X5-A5
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:51:56 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-824adc96ad2so1276056b3a.3
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 10:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771008714; x=1771613514; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9GVUKZfJmVxACg/YQAkILvRrgJ5LoGKx5LnY2X4tbPw=;
 b=GEZu6t8fiHyVQFBxEW6M49TAhtP+IcotpBPQwDDkAVBHubA3MelFqY2dX2h7SiKY8N
 WAe0iLQspz5aepsY4PsQIjgDC79IyPkOWQVTdybHvNcGegtW1i5yHz5wi3FH7V3BbDi0
 CD1mto0vHMWmtm8FUg5HxATwO9Td29XV7EUDzEJ195tWlwP7jkD9D5IpdCcXMWqKdXcm
 y1DLEpZda3oZPy8KfZdREJ1XmFYZ6zEBFshWBOesxJ0UaB5l82JTw0IeMJDmIfxHLJkE
 zGE8P3ghpmolFECjLGnpeCnRVSpkZ5FrBhZ3xQOuly3aCu2EaixWV+9MW9Fg8qyqI+t0
 pMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771008714; x=1771613514;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9GVUKZfJmVxACg/YQAkILvRrgJ5LoGKx5LnY2X4tbPw=;
 b=g3iwRKD0hHz1EkJbrSdIicp6Hlzi4u3XRFXKKB0jSqw95pPm1wT7rtYpme7bxb5oqh
 whBHIkrQ8Hz1iBI7as+vCxTd9umUtx9uwU0o9OosPqZ2Hx6f5xyKjrkechj5TWJ3cnGu
 Y6/bBDHa1kXgd7bqp7cA3IPG86VSDt93ekIReQIfVoOk3ETBVmWz61o5tPpBhjxoJ8mN
 2IWEg5Y26OAKVvhYHtYLz4LJxBkkFMP/CxD1LLEYzs17wnQGnKjbXDeG23g7ifItpYWp
 ajID/AepD55LpIjL5Docm4GHWTuQR4K0MI19DdYz2ucNZmfZM8sUXpC6XKvhaEjnU7x1
 gxnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqSgXNi8k3CBv0I8ZenaHs9HePP3Uq8wDJvw87XK5t/oftnJbgOGHsib50ajMhZFCeaMz98ZhHzOPk@nongnu.org
X-Gm-Message-State: AOJu0YzgZGxo2A3KmpMyNxXgdQ2uaRgpMkaPO6rN27ZIVNrWQbaw1jrJ
 661hExKZrMOyDUIHfDy5R2Flv4IIAAWdrYVDdBCfQ+kcfVEBp4XCbxPM63exEiYI2zU=
X-Gm-Gg: AZuq6aJPXoayJT3lWMqpnzEEDg8KMztEs2hLo55jPtj/54D7HLvLwyH6I5aa4X0L5Su
 H+73hh2x8DEqU7eamJSgYME6d+kIDGCFRnop9iU2ygxvZ0UE3T3cADzQ86mgcJV1puBCYpUpX6R
 cMFtYDR4CE/A8GMfB4La3YljAkUyT9O/VQsfJPc+IK900eaDLW3sX92Tpc2O8+W2dcq0Y1RBYhf
 McBcsmCR1eXWtd6qBkTAi4E7qd8kQ8DLOePx03WaFqvpNcVHj9UXEwVrEVLnQwXGshVxzsxcEj7
 DIhc05aXqKQEum0NLwR/+DqsAi+c2kuYVRKp7pOd6EGy/tK8/RMIlPF4P/L9RD68+MkmuYp3plj
 Xgl92eQhLettNEtsUEHyjWM7AfGcX4KQDyrMYsHUWe5pyVb+Hz3fb88zNBmX4INcjQyd4NfWwB8
 gd0CytDrDnQIluquv5a/kIOuRAfSDib3GUCGQKWAGUZLfSB3L24A98lxh/acvlMd1/mdyR
X-Received: by 2002:a05:6a00:1786:b0:81d:e9b1:b6e3 with SMTP id
 d2e1a72fcca58-824c5ea2161mr3169628b3a.14.1771008713796; 
 Fri, 13 Feb 2026 10:51:53 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c68db466sm3248287b3a.0.2026.02.13.10.51.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 10:51:53 -0800 (PST)
Message-ID: <8b71c2da-18d1-44f6-9c79-27e87a3be032@linaro.org>
Date: Fri, 13 Feb 2026 10:51:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] system: Reduce 'arch_init.h' scope
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260213175032.32121-1-philmd@linaro.org>
 <20260213175032.32121-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260213175032.32121-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 2/13/26 9:50 AM, Philippe Mathieu-Daudé wrote:
> Better to restrict qemu_arch_available() scope so it is only
> used by generic system/ code to parse command line options.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   {include/system => system}/arch_init.h | 0
>   1 file changed, 0 insertions(+), 0 deletions(-)
>   rename {include/system => system}/arch_init.h (100%)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

