Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BCD1099B30
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 21:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3hm8-0002ZM-Ei; Fri, 20 Mar 2026 17:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3hm6-0002YF-5c
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 17:52:58 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3hm4-0001bd-LO
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 17:52:57 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c2af7d09533so1714818a12.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 14:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774043575; x=1774648375; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bjg5w/Z3vVC25ttMWwTe4w35Oo6l5nlAAKq5y8bfBIk=;
 b=n/3W4xU6qKD6ShTZhEBdzb05JNUanB7DvmytAVHuwHc+S4dl+S5NCY/3IPuByndMIN
 yA5ghvuFofrrvCQve76SUgE2jK2u+7EIZU9MDNYpW5wn40LlpSbKz8qP4F/52JEbDWp4
 EENb1CQuOdO3tnUMcKfb+W5dGRTKQNjoJDhOxRttlpbaAzbNYtI2x5266K35AiR8Gpxh
 FFftxIbantm/a2w1GxF/7hlGFb+guCAfMxC9aF4Lu1KoyTr40hafQuZIzwk4oyzLvhsS
 Z/5wOygsB4PTMUDOb5mujz4w/FNJQhfeHv9i3My1xVs8+lyCd+ndiB1NB0cxyjLdlesA
 h5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774043575; x=1774648375;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bjg5w/Z3vVC25ttMWwTe4w35Oo6l5nlAAKq5y8bfBIk=;
 b=nAZHFgQANl2YmGEyHswDPC9l53YgvUrdMtJ4VaHaKsB+SCjXA5ucNCdnrLeAtCWdr0
 EbnfZCYNw7kz33pFPr0VdhKkPEZ7G0j03vQ47hpcAsTmjMVxUU6Rws1TciB7jQ0Tq9IS
 qd/ODcwZPE8h+mDM4QA41znpMXz6KO44BlG0xBtrAkEp2EgBVJBNz1gKT31sXy+J5tpP
 yFRxnf41uNr9m1thaH5cw93eWuZ4uVdiPnkmXrt6NiV3F6D1gCUfoU/XCsICmAtPTU3o
 3A+B8dJ/1cWJ3LzFjoEa4ZSd6kL6q7bqAezoik4RomJZam3WsdIZJKM+qXFJhBJ5a4wx
 0e8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdv1/azIz5N/Mi5bazmr2iMZWEqDsPbBFpfN0dRC1kaMZEc88vqQHiwZsUMHNYVoRoeam/YznjqdJm@nongnu.org
X-Gm-Message-State: AOJu0YyutFFcqkArXlXh2tS/li4uwbSB8hG4MSxo6VFZdqQK5iYb9EBp
 hIXIZaOYIvnFFK2dZaPmgGxHau1WqPI3n1lY/K8xxXbFLNaRZye4X532uLEcDqSHlNo=
X-Gm-Gg: ATEYQzxU5FEFVbA49QEfoqKZx/+20+DRo4PY/b7HB6LL7LYBx7eFDM9FeRqmcAJd5Y7
 /0/uoswrzgjOjfyQUsHnndrkBHUu13e0Tvnm40Rm/k1h/wEg0K28V10TEys9dKr3x90OhM30shl
 IDZV03U8X62DZVnezJMe0nr9U0aC4Ed/tr0ZiKeX6VhEF3uoaBRDEj6Sxg0FGhB7WlHU4rD9yv1
 unMpxWx/IYzoFsNBlrCg20HgLTQqmrNxCWqzyDV8Bx49hQMqLAgwtvSHYGsonru45iSllILWk+8
 ByRmlgTnmQCNVrugQRymzHHY5dat0g6NFemyXlFKVYPOurB+mxmKl9dhmZfQiva7od2Om9Zo1Jx
 /Iy0SiQPNslAkmSks8Jt0X0eJc5Tf2xOinWUQ7ze+Oip0VU9yB7n3gQuCNPjrk1dUKFKmWp5rPt
 cFDu6MKGKIytt6G5ebbuudYGmeooRGTUi0XaOrv0x3jfxUSZqfOKPHllpl+dw9VgnOgpm1cwcC0
 xvHkbM=
X-Received: by 2002:a05:6a20:9144:b0:398:aea8:a9a5 with SMTP id
 adf61e73a8af0-39bce9c0bf2mr4053307637.18.1774043575121; 
 Fri, 20 Mar 2026 14:52:55 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b03bc6745sm3055554b3a.23.2026.03.20.14.52.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 14:52:54 -0700 (PDT)
Message-ID: <7336f7d7-51ee-4872-8ed8-501ce8fbb837@linaro.org>
Date: Fri, 20 Mar 2026 14:52:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 02/10] monitor: Forward-declare the MonitorDef
 type
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>
References: <20260320160811.28611-1-philmd@linaro.org>
 <20260320160811.28611-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260320160811.28611-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x532.google.com
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

On 3/20/26 9:08 AM, Philippe Mathieu-Daudé wrote:
> Rather than having core header forced to include "monitor/hmp.h"
> to get the MonitorDef type declaration, forward-declare it in
> "qemu/typedefs.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/monitor/hmp.h   | 4 ++--
>   include/qemu/typedefs.h | 1 +
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

