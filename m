Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0368C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 13:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRBGT-0004yV-Lj; Tue, 09 Jul 2024 09:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRBGS-0004sX-36
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 09:52:16 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRBGQ-0003gP-Ba
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 09:52:15 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4267300145eso6831525e9.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 06:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720533132; x=1721137932; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v4oSgC3bB0kwhJ+sldQulWyG3JEUhm8BrV94K6ASACA=;
 b=iYjNOKpA76CSl1ynutlOVzlRZ5xl7r5Nzu+goiUAi0EPOCyiCu8ZUGtYfDZ+eXbJcA
 2RqruUoioDUf1BNRCwVcvTdEyg2rw6e5f0rX3a+T2MpHMuMFckyI6o+vX21ddmSk3iDC
 JOhGGH6roLNsw0RUijVCBa4W5AdAqnHQxlo+SD0OrvySIhETJU/KOtpV0vT+RSjvryHX
 l1xxLIgs/lw9HUTwzpxBgcxOvckgDugzbnMVr4Fdgfd4PqLbCmSwZiNNLriwogdEI2TW
 fKHBYqZKHN6QjLyCSwq/LjvI3E5vowlt8pX+AlYyO4zVuC7+y+z8h02JseM7X1ubZNwI
 VP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720533132; x=1721137932;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v4oSgC3bB0kwhJ+sldQulWyG3JEUhm8BrV94K6ASACA=;
 b=VYDo2d96RuuPZsvOioceLndiC8XnRrIZFPxSsI0WEkA+/wDsEZLRI+QcCPVlaS14jM
 ojpZhlz3CMzOGHG06WUpWsH50BcjZl8Z7uVlHkaNktAiVYgoEQhxu4Vms+pYK/WrTFdx
 pHp/aGbvKKCCTShHh16RJW4DscMHV0cWRE4vsXcMGm2PbuTzkUuVOasi+ZXStwXUk8JF
 Sa5X8U41pulywDAEx3tybh/om/fFRT/LO9qirogREZ8Z6xBf8dpDLY+1FaBVag/rx3cu
 sLvYrEJmM+0n+e/hWByq95PsfN/SL5zzkrYwbe5Nz5/ZpwEdRMboImg5WMI2xSX3lfht
 sqDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlMQuFEs9a+LP8MIiMTx03sQeYXRFrn3MJURdRCZAPmoz/2do3xX7M+GpeTzHrVbGqKl00blDmBIuhrL5+QcQttjN+APY=
X-Gm-Message-State: AOJu0Ywbj7aQF1xuslKsnJHhRnZZViHdWstCYhDAm3K5yCDQffuftgs5
 j9MZ7KiOFYSs7lplDOTGqDNUwLglVe6Ihpq9crp8OZxS5Xa/4HpbHphLlYusFt4=
X-Google-Smtp-Source: AGHT+IGEpAPiEapn3CExIVI9wqWDkJS7k3SRJdVDpw7oT3wboqjy6qw+eHkzLMaPcHrZBpHvps9HaQ==
X-Received: by 2002:a05:600c:2109:b0:426:58cb:8ca4 with SMTP id
 5b1f17b1804b1-426708f1d36mr22108535e9.37.1720533132672; 
 Tue, 09 Jul 2024 06:52:12 -0700 (PDT)
Received: from [192.168.69.100] (vau06-h02-176-184-43-20.dsl.sta.abo.bbox.fr.
 [176.184.43.20]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42727805e4csm4528885e9.27.2024.07.09.06.52.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jul 2024 06:52:12 -0700 (PDT)
Message-ID: <3dacb6a1-9c56-4c1f-b21f-585742a307af@linaro.org>
Date: Tue, 9 Jul 2024 15:52:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/arm: Fix handling of LDAPR/STLR with negative
 offset
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240709134504.3500007-1-peter.maydell@linaro.org>
 <20240709134504.3500007-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240709134504.3500007-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 9/7/24 15:45, Peter Maydell wrote:
> When we converted the LDAPR/STLR instructions to decodetree we
> accidentally introduced a regression where the offset is negative.
> The 9-bit immediate field is signed, and the old hand decoder
> correctly used sextract32() to get it out of the insn word,
> but the ldapr_stlr_i pattern in the decode file used "imm:9"
> instead of "imm:s9", so it treated the field as unsigned.
> 
> Fix the pattern to treat the field as a signed immediate.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 2521b6073b7 ("target/arm: Convert LDAPR/STLR (imm) to decodetree")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2419
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/a64.decode | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


