Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31F8EF99C8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 18:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqy7y-0005eE-Rg; Fri, 13 Feb 2026 13:42:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqy7j-0005Pr-Lb
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:42:41 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqy7f-0003CW-N4
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:42:39 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c6e191c4b8fso419793a12.0
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 10:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771008154; x=1771612954; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W4lGK/zacPHwSCNRe8J/qmmmq9oxn0hS0zigC8uRyr0=;
 b=Q1guU7yGT0JxHY0PyBxBbZe0GzuCfclwXf/UhsS+d8EkcPaPxwc1RBa4wU38Ea8r5H
 8NnHd1BiVNw8KgZa1X9LLBwzhdsuGqeFHnlzIjcV64AafB7AkKzXLPHJ5SSEnNnw7epf
 CAqNkrOMHyMnCXDgwuD3hJMXwTBw5RYIqdA8T92K8x9AE7gWDL3mrcHLsYvPVpUNeSeW
 PP/CcbbYrptfrkhuo2ejXBVkQYF0Z7IB6O1yfE/tn1TsrYkli6apnnyQJrkDaEFg5qNZ
 w1iTCjFZX5uAn+m/VvSdiujW/RrM7Eb4opLOe5tHvAR9qeoyaapNGtoIAGqN1nDCpGbD
 hm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771008154; x=1771612954;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W4lGK/zacPHwSCNRe8J/qmmmq9oxn0hS0zigC8uRyr0=;
 b=fv67sc4ZxoBCrp/NbCMPhB6OuG0vBJUZEkTZAHSCfv/xzWGvatK4STzvYCzJ6GLPEk
 Kye9iLWhUJ+iVlIsE8Mkbxa1bRxWSYtfY3GC9oB8bkwjdeGHjHMmwywowGsP4Zf16OP3
 0kAHCEISXSpyugk/A/Ve2jtq01a6Sj+ui/+juRuchjP6r/oGme43tTSUnOlLilwyg91k
 rhwkcDDRspZY5kA7xJV2HKoxMz/VTXshZ3YCevJMkRAMsQI6D8/KJMrTChhPxkimKv1c
 Z05aKQZVZX2r+W91ilpLFDwo6orOTpkGO0630v544C263F3qkS7C5vPXZnb0nBm4eR72
 COWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUiG9g1Vpo+ml7bIyqZVxZuCMQYeB0mwY1B7r0WxHvIF2W+ZvOFAOVcedfeBGefkXiqIhFR1Q1T5hL@nongnu.org
X-Gm-Message-State: AOJu0Ywjnb1Cl6KywrddwTATurExzQkn5duOlh54iQ3ZHa+yHGncNpHY
 of/7X+DNw5JJRmzWwFbEjGT9YLCcmoBvMPD248nh/Cc4i1h0cd71FHN2bM4F5mB57hA=
X-Gm-Gg: AZuq6aJUuq34s0W2sfGSqxfGEsb9RN3HN4lfIvrmXFFflcwiSe9OcMxqajQfITJnlbh
 jRrhBVLHYe81bVp8BwjZ250xUGsd3KGsniBc1vyzO0x6xNiJPGFDG1Q5gTfiCaNFTkl5zpw24VC
 ie4K536Murs4sPxhhijwdiHhQHXpoc9q9Xnl/uUQxzf9xue55qbIb7ZHeqeH4UXNZ59tljQ0haK
 v3a1Snm9q6ZB6rWnvtsKUYku6tg2hvvRWsdm8lEPP8K+F95CNu4yLpGkH0wgqJzpNG99H2qG/W4
 3ahg5zA/8riaJFhvx0Y9+d5gd1Ds0YXeqj94uVoZqA9+glsTixUeBbEQyc7Rh3xCI+Jv+hjx+mF
 ZxyZFztPiCJlKSA8D0yT9RGIuJ5lfW+/34wJ02vrDuGCg5B1bk/daIQqE0mDZjmbhf/mvB9IkI0
 zaove+fauF38u8O1bP3cGD4XgfFldTShOYELgKJ+VqLJ7qryItomscFDn5lUZF/1bBAzOGn/syr
 ZiZW+8=
X-Received: by 2002:a17:90b:4cc4:b0:352:bdcd:118a with SMTP id
 98e67ed59e1d1-35844f9bd19mr369528a91.21.1771008154179; 
 Fri, 13 Feb 2026 10:42:34 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-356a6bbdba8sm2116333a91.2.2026.02.13.10.42.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 10:42:33 -0800 (PST)
Message-ID: <1ddc2f1e-01b0-4c1d-afcb-b9b2626f589f@linaro.org>
Date: Fri, 13 Feb 2026 10:42:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] tests/vm: fix interactive boot
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20260213154859.1551283-1-alex.bennee@linaro.org>
 <20260213154859.1551283-5-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260213154859.1551283-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/13/26 7:48 AM, Alex Bennée wrote:
> For reasons still not clear to me passing the single dashed
> -interactive would confuse the argument parsing enough we tried to
> pass "nterative" as a string to the launch command causing failure and
> head scratching.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/vm/Makefile.include | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

