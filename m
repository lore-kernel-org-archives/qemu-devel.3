Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274141099B40
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 21:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3hlH-0001y3-R4; Fri, 20 Mar 2026 17:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3hlG-0001sJ-2q
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 17:52:06 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3hlE-0001Xy-GO
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 17:52:05 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-35a094cc3e9so1556944a91.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 14:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774043523; x=1774648323; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E/G4w3uWYX3HLRSysW/2c71VjbJPso6ZYo+5+Uvm/Bg=;
 b=RmvjCjO440ZSUUPFsltHE0rmm+YgnweMWyL1n36M+CoI8ZV0BCejqjhbT3Wf0kt4FU
 CT1Jll0JklqgyTWbNIKAiahxkKMwpSL2BsxZbAOVqXw6+c+hX8Iv++3D/C4AWMq/+qD5
 2quB6nEiCnWUXCErsezZew+ZbTelrRgSJonYBtK1xY2wZQ/9yGRaGRYyFoclVP0C0WUb
 S7YKfZt5w6CQAs5aR+4FKncq9FeRFTRzb31C1LhsoK8C0ynkg3LUo5tZx9G/opgIqqNi
 e9S9jEeUYmDgpTooqLRxKyrOyT/sRSg/NxaIEP8jDHylC0hyj266YhlaAxdFAnuXnDsk
 U0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774043523; x=1774648323;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E/G4w3uWYX3HLRSysW/2c71VjbJPso6ZYo+5+Uvm/Bg=;
 b=LJug3+UrsnIbLl3EG+X4TWyCqHRC8MS1pdI95wsW2J6yk5fV8C1g4eMpgU5N8jUB3b
 EVt9MJ+t8iWT0+TwrYOdJ7lKWb6WxfPkj7u1YyTN2YeYPWSbFjNHw8JkB5wo6aMkPQN8
 r5x+ZxbAJCPyfSfS691z/sq8lNsIJsABqZxIN1zuANwXJVJCHCeyhizVZpPlicilSj1Q
 yu8CXKvBnr4r5prC34sLqa7oCUr46r6oAefFD7JErxONjym43GuyG6FqRXpVVnH5m/TV
 i96u91ZruZf3vRJ4GGU8pedhQvb2kQWh9qTQU3pcpR5eJSY+IvycHARe3j2mSNu7yFgm
 WX+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQPyZhOxY6pLiUkD3F98UlLoalN7saEbUXMqTO/A7X8OKOFdzaDCGifM8O1T+Va2Z9Wmb/jVABI1o2@nongnu.org
X-Gm-Message-State: AOJu0YxVsyKfKonMpqQq1ormGfY/HKjVhEDj58pFc0+2b54GRmSKjdSq
 F4atlsArpM6p347Ulx38hVa/MubaXqvS1S60vGiPLEh/tsQZDA5jojelxuHYHtXcXoU=
X-Gm-Gg: ATEYQzy8ZwZMBYGnmumkjPxKoOs7T1mZA3UvHdgr3ea3Ynd98zYP3F1wdkZNkPd+4uB
 MQ4VrHL7xICCU5ss7izisid3udrlSPTnW4nPwdL4YxQDD/LZ9OeeLMeyleXP6+QZhSTqYFjnr6l
 FaFE2Nav6ZweIiVKbeoAdOpZWcDME72Qiim4P+WXFzHoQERQtN4uVD1P+QBvmJIm3+rbr5jcbc+
 pGfz3EnjciRVhGW8YSampXHNKV49cCfWWvy11YjAsqsS+hWV6vRtKmxX7WZ2M+nGoiCDfw/UhAa
 AwYZQXazMTpt++wAhngGSurBX/Bt9RiwrPtX2TPDZOVtZewHPzQ3Cb+vZ7JSIIYZxvHUjAKLnIj
 W4L3XzLqQaLNodiYFqhha7mAsUXdfv8K8fqZqxi8iHBd6vWcTCxH5qmPOmVWNFuIyOkkH8+UyP0
 J0rGoqhCa8KqHX7Rmlap3rQTlvxikoEIzKSNeR9tO/4L28Jy5JDwHlcAHh6Tgd22CFwhVg
X-Received: by 2002:a17:902:ecc1:b0:2aa:d67b:ef96 with SMTP id
 d9443c01a7336-2b082793ec6mr42592665ad.31.1774043523046; 
 Fri, 20 Mar 2026 14:52:03 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0836a3430sm31723355ad.79.2026.03.20.14.52.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 14:52:02 -0700 (PDT)
Message-ID: <a62a700d-69e1-4005-bad8-b8ff5fceda06@linaro.org>
Date: Fri, 20 Mar 2026 14:52:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 v6 5/6] monitor: Reduce target-specific methods
 further
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20260320091019.59902-1-philmd@linaro.org>
 <20260320091019.59902-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260320091019.59902-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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

On 3/20/26 2:10 AM, Philippe Mathieu-Daudé wrote:
> get_monitor_def() doesn't use any target-specific declaration
> anymore, move it to hmp.c to compile it once.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   monitor/monitor-internal.h |  1 -
>   monitor/hmp-target.c       | 39 -------------------------------------
>   monitor/hmp.c              | 40 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 40 insertions(+), 40 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

