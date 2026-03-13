Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CBB107BCCA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15X7-0001Mg-KY; Fri, 13 Mar 2026 12:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15X5-0001EI-OG
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:38:39 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15X4-0001oz-8S
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:38:39 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2aec9255e04so10059455ad.3
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773419917; x=1774024717; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9bjt4jB5uaENogEoxxOUaQgXHC1hk5kHi7YAs+cmLhA=;
 b=M3Ug2cI51F1e7i+UUF6Ioh7KdvfdrWl3RYeqsGWth18rwg0bDBjqEhHK2gvENdrruj
 DO4IdKdR1C/mvq+r/7lFFzwf/Xiy4WYlmFRnLYLzEoAYEocl6AWh35e8Hn1ugQ8yM4Ux
 r2gjj6hlqOiNOnzsjSfZGXx2hBD+gZtoaw6XATMTJvwZJ+4wEe/I08xgkllmEumg9btI
 FTyzptACRBIYquANVs9tZxxR4nV+PuoEQh9BZCmChkWhHQKtuT08Ix0GSZW3cX//4be5
 sddpraKZNREVcx1SqDyJRG4eZqHQcrzIC6EUxsdqigEvePNOfe0T9sS+se81O0DZUPVs
 3UZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773419917; x=1774024717;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9bjt4jB5uaENogEoxxOUaQgXHC1hk5kHi7YAs+cmLhA=;
 b=e/12dGnD+5AQ07aX3r6sWKXkil51OfaXD3UEsBH/OVrooeXENIVpeSe71gLdbXekpf
 fiMY5TEadST7AwBSZPF1zgmnl7Fuk5EXmcKIr1zEOa2bSzPJoc+VCUolzKoTwM0fjrB+
 feiMsxyewnDzrnYeCAgHZs/GRN1YuQLIDg7ULlxqM4eC0EV0SAghlZkCMbQQyi936um0
 khx2gmPbC6EJsejAIy7J9Io1omY68VYplnumMRBWN7mqrfK1xLf4oJa999YIUAL+8Mdm
 ue6F9lt76VM8H28EdsdfImYhIiudMi5qfoBeFC1mgAUrS9KovOzWyjBdMlaXxpAPgQg8
 WXVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9ER5gd5SkjvecqUx2fJsXBCeI3FvuyXJK/btUUY76TSAr5zNu5InW23IcFASwFTluq/mAtnKUlaJx@nongnu.org
X-Gm-Message-State: AOJu0YwssrK7KBpZxVymJg+mz1aUy13deL++x86vbOK2HpHB9U4wQFYr
 PQLJ5xpYihYBwVfQ+hSD1yZtE4ZpQ4q4VQWuHuOyUene1P6A/clUeABayzNpNYARcoQ=
X-Gm-Gg: ATEYQzxYwRaV3bxurttH/uOZHcbSxbZn4li3gv1wq8ZlpzINJ+OdT5M11GwL7rooFMF
 cFapBn5htHCVx9bp/ijlIytc47Zrr9l5qdg+5i3b1jOOkeIBOgbx6OCOPB2ye4r6PF7Nko/DTL9
 7YpTmISKZ3O9EOs3HebsgEgG2PIJAHZq+VowbZmikPLipfCZ2GYfsgFjOHTt2DJL5PKN8Qcsywj
 nzon2jjDyKZOFUC1pm3CTkaTdO/PfqaYvIR9lay7NZhjr/FTHvjv+pg6UsHPaDBJAMXeCcaDS15
 EQQIMDrjCvw0+YUItrIN2FPcIopywUCi6gdjBti6ku0362FYzZqYtw6LhTVPmjsmrabwSd2dmzl
 DOeX7+GAQ6pk6qrifsD8OSYkfyMVbby1SbdUr+oUs59ZrguoQbN4YPocQq3uJsogw3/MyJ1g+l0
 HBsBieSHBFZIWxkEIoTvJ40FtJNpdEW/PNUatkuA00n+HU+zpHawuXUoWsnM+IiehG7lnS
X-Received: by 2002:a17:902:e810:b0:2ae:5745:f0f8 with SMTP id
 d9443c01a7336-2aeca941dddmr39309375ad.2.1773419916604; 
 Fri, 13 Mar 2026 09:38:36 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece605231sm25396985ad.27.2026.03.13.09.38.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:38:36 -0700 (PDT)
Message-ID: <c338eca2-1245-425d-9db0-a5b09ddd879d@linaro.org>
Date: Fri, 13 Mar 2026 09:38:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/38] exec/helper-head: Include missing
 'exec/target_long.h' header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260313062055.2188-1-philmd@linaro.org>
 <20260313062055.2188-19-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260313062055.2188-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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
> TARGET_LONG_BITS is defined in "exec/target_long.h" (which
> is currently included implicitly by various headers).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/helper-head.h.inc | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

