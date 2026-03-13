Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B52107BCCA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15Wd-0007ka-GN; Fri, 13 Mar 2026 12:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15WT-0007UD-2c
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:38:01 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15WP-0001l7-Dl
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:38:00 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c73bc3dd25fso941166a12.1
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773419871; x=1774024671; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8jwADxIUapsfsaY0tzmD7ZQ72IgPGemaCuje4ThySGs=;
 b=epeVTqoVxJxB+/mX8XYQjoe4C4Z52wiigULTaRNOkqQHPpGReSFLArXQvkaJs+BbAl
 1252ex1K/IdcKHIrAJ2tYMKFEeztfL/OBSzq5ioz0An2E6q8WOZCzglI39zxllp7kL8h
 J8pmTSrbOL+suxyEby6EMuhFXuclCAvJko/iw7X3VN89kgiGqvSEwh0N+hFnHzbr0GfZ
 9DwsnSmzit0DS8GCcPaatQ0Ff0kyiObBVDV7JTvQBEyeQlrD0FH2HgN+7R5MfX/OBfJQ
 8kSWuvqPMhk7fiiYF9k3krkgXpdEnpV1jTRYRhx8SBteDM3fYCc5e/Vb4LwOLgKY+0u4
 hqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773419871; x=1774024671;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8jwADxIUapsfsaY0tzmD7ZQ72IgPGemaCuje4ThySGs=;
 b=OhWTE/pstBNYxNRky+C6B9eyXIocGGMQqywuRtwmw9xW3ftiyDyRfm9lOdZq+m61zx
 jEL6p5M3ShKQ6TSVPqqzNGiW6DlmfCtZJQWp/NA66vlxGIW5jezz2rqwGBkstyBbiHMt
 9lNz87R3Yg/sC2FR5d2x4wzCoHB5pWEgD1CmznhjItzjxDRr8AIgflM1x096iFwZy83T
 8xd+o8+eSE1boluMlsjcrZ3mwP95xVPqonrIwtkZbJnBaUQ3ai/7aYu79M2GCRY8eTep
 UaUFXarUbinrSuue0anrYxoVryK74kW0v6n+NdIeEUG7/unQGLvjAiCRbHFZ34qYuEDH
 cuFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZe5P2V7oSv9qGkwop7gBww9GYX/CKxnGWbx0lG/PpPYdb9EgCqRKDlGQ0IGQKdcAVIw9OIaO1wuid@nongnu.org
X-Gm-Message-State: AOJu0YyNEXRwSWXRcE0WXDJiqUlW+HYKQTjTyssCB07h4bNKClbbp5zM
 F0d298eSIKZqiFSNHOT4FXw+71pxE29zj89W/vBXhfsB2pRYHK8eZR8GHM66hnS+t/k=
X-Gm-Gg: ATEYQzz72Q7FINuq9npr6ti9txqlQjS1AiHXl9/K0LwpwLIOCg2H3evcnptDT8AzM1o
 qwZ1XFonMXNpdeAwA0JRLi2NsecNN01FHx3i5Z1Km7eMxp8jJ3rq77n3/JgQ/cTXABxaX2xpwlo
 KsK+CYxQmSNCadVkgIteSa0EWfLzM/FtzJvAnuNm11x8TklKxYA4msd+TxyGPWMOON6s7/sgtUl
 wmBiCZNakkey38fKpa+pzYgk7jHEPgiysV00zGHHuLKtAtUdtuQCcklkyr6kyW8HxuCO6T7dRj7
 7Fy8l7S7PFboC9xFsIGPU2K3eunb4S+fh7eWAXTaWdRnwDOlEsySKStZ9gWGAZfsyT+jDreVr45
 nN7hlTJSBpPL8cAu40WnQAVgOV5eJbE/gh13C78SfvoSbveChAo/uJHwdsKzGDBGnfYNRpVOhWj
 2SfCH3oQnxMx541AkQ4vwFnyDfbc+6p+X+miZi7ucN0f6BXMqTo3AE4vGqSvrbEw648dRT
X-Received: by 2002:a17:902:f683:b0:2ae:6457:3099 with SMTP id
 d9443c01a7336-2aecaa52b3dmr41863085ad.26.1773419871306; 
 Fri, 13 Mar 2026 09:37:51 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece83b35fsm29990225ad.80.2026.03.13.09.37.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:37:51 -0700 (PDT)
Message-ID: <7350db20-fb11-44c3-9073-df999d8e49d2@linaro.org>
Date: Fri, 13 Mar 2026 09:37:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/38] target/sparc: Include missing
 'exec/target_long.h' header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260313062055.2188-1-philmd@linaro.org>
 <20260313062055.2188-15-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260313062055.2188-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x529.google.com
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

On 3/12/26 11:20 PM, Philippe Mathieu-Daudé wrote:
> The "exec/target_long.h" header is indirectly included, pulled
> via "exec/cpu-defs.h". Include it explicitly otherwise we'd get
> when removing the latter:
> 
>    ../target/sparc/cpu.h:615:1: error: unknown type name 'target_ulong'
>      615 | target_ulong cpu_get_fsr(CPUSPARCState *);
>          | ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/sparc/cpu.h | 1 +
>   1 file changed, 1 insertion(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

