Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B418AFD88CF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 23:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w06Sn-0000Vx-SR; Tue, 10 Mar 2026 19:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w06Sl-0000Vg-MW
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:26:07 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w06Sj-00010i-W0
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:26:07 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2aea41d4fbcso6419985ad.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 16:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773185164; x=1773789964; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GmfwyZ55m/LJNGA6u55EUJEa/JkWOYx78qlRBUOxTGM=;
 b=gVUucVjphLQnlltVwDnLCmBurD2+syGFgggnbzHZ0BYCE7rnd7Xb5rhOHK8AP1VzbN
 tjSy8p9G5fGpPwx2/dQHmBPhGbbzHNCT5g9cBOz9pHuSzu5IsNkR2AeO3oZ9U4cRm5k3
 0wTige/RGgMMD8rmfSrsjdATQSs1Vd8p97pJIXEVWyAYEHBzgAewXfDIIm6Osj3YYYMK
 bDkOb37UJ1/sYLboBfX88If3XkSUPSN4fHtPObIji4ws6rHU6UbPGQcT2F5yam8bPPo7
 HRPaIw+L4tKbZld8fmAbeM7YKU1SDaCHo6VCeAlI/OW88Zpy3rXSmNkRIPigzXXatYyk
 cfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773185164; x=1773789964;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GmfwyZ55m/LJNGA6u55EUJEa/JkWOYx78qlRBUOxTGM=;
 b=WBjGe4nJUoI9B9Sgh9OUi6u1e3yf3sogVQ8YK0lFRq7E08I+4x4magIJ32+izrC+uD
 56fyphv3ei+xmxkdRtRnMUlOF9ODYTeJhOJiYk3aeDCVEx5zBd3gMfmHLXhCN/9Wyr8x
 oYYQwPdMtIFNo4iIOODFxjI5l1ltVZeQa1DhayMzpz8+0AgfANcuktyoCjexhzltUPR+
 4QqJcuG9vjBp19PdoDraN2e+VIeMjcAv53URC0fhQpDMnwdIW5UKgyHees4f3sPUTgvX
 TXqgiQGkKEo5BUjoDRV6jQ6NsTv+BOTVeLUffIe4Qde3R/HPb9L6dIipqdZ1dMm8WgcS
 4Uhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMLmqQY3E5Jain00pMcTca3MYaehAOxZ9qE1maJHH+pnu5K0Ucj1HVgfV/fM61YuB5LfTbJikbAMMX@nongnu.org
X-Gm-Message-State: AOJu0YwjjrijByd9WkkbrmNmSIdXPRwOe2SkVMxd6qKAq7hcwhUXcah8
 gncEqyCrOCn0oCsp5fGL+t60AtL2zGuPhKn5C5Lnl6JVeTasHefNGqat88L1P25uYl6Tmxtpr5f
 Fm6pq
X-Gm-Gg: ATEYQzzcWjHref88vg56pY7ZFjLdTaRLaCjOtnYHbh/KrGOTlJEmU3cTdGRssrDIUej
 EmLMBPaSaCKAw6DF10pU5koxRSumQ5uHJxtBmeDOaQqzW+CPFEFtEXYi8nl65qchYLQgrMDwWrG
 MWIvnS0t4nABoo/ESMXbJNX4YKEmn6CnqbuD9CPw1MIPgj7HjzxuRIUwc20XANL3xIgKBWzMU5T
 kj4eb4gIO2DXXNnEE4iLpT3BP4nzSHNq99zy8PSeCoN9BcZ4ZXxCutrsej2oDePQ6kL9vJih96t
 9CUJnm6a2zSEcZZJJ1QjaptiPPsa2b4lEKMDBhIoxZrGJxSq3cc9AQpR6dfduewjrNA81Hu9KEo
 eU+phYjoOsex4OHC2W9hWLg91hV68s66/jdbwjvdp1moI4fErne8+AP+sXZYf+vfY6iOIWtY/CV
 EOPHvHA+3Tti/QelUD1dxD3tkItUsgYtPb9Lt4uQh+hbOvel+fqoicog8kEaS0RKR71tZZ
X-Received: by 2002:a17:903:174e:b0:2ae:ac0c:5a2a with SMTP id
 d9443c01a7336-2aeae792bafmr4437115ad.6.1773185163877; 
 Tue, 10 Mar 2026 16:26:03 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae246ac7sm4161035ad.25.2026.03.10.16.26.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 16:26:02 -0700 (PDT)
Message-ID: <98757626-0884-4958-878c-4fb135755a57@linaro.org>
Date: Tue, 10 Mar 2026 16:26:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/16] tests/tcg: Re-enable disabled multiarch tests
 for PPC targets
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260310232045.58440-1-philmd@linaro.org>
 <20260310232045.58440-14-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260310232045.58440-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 3/10/26 4:20 PM, Philippe Mathieu-Daudé wrote:
> Previous patch fixed gdbstub / PPC, we can run the tests again.
> 
> This reverts commit 9e5e2a0e8726d041fe0328dddd4263683e354935.
> 
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/tcg/multiarch/Makefile.target | 4 ----
>   1 file changed, 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

