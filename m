Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58800C27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 07:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sElUs-0005R2-J4; Wed, 05 Jun 2024 03:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sElUq-0005QW-Nz
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:55:49 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sElUp-0004hH-14
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:55:48 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42138eadf64so32204425e9.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 00:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717574145; x=1718178945; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kW81FqSIjrgQtFVLLzSySnJuhnhJFEbLH9doDm7D07o=;
 b=EZEoMNuf7ci53m16GpYKu5SBPMnZITEzTlnoruPZh2KSZ1M82M2HWZS2UJc5kIX/m+
 gyRZ3hPJc75W13oV7cplu0xc2PirVTwhkqVnNGY3HVf1JWUkUTW37cBaC7bRwioyd86j
 Zt+0uJBjUsRRK+JXTovWR56Wycb8dMmERI9c9HFTI61+gPQmUHtqh5wHhA8Q3qFIERDP
 TQ5VvvT4DdqTq2TCKk1Gp32ivvkwwUVjhWVItlf8ooBXbc5LgCgBOnVkwFCPuFTDkqTP
 K9xzaGnYAYr3Oxh9rVrNFs1iXjaQEIHsAITMX7ajQw46k/MGEmqxcuWn/zUWZ1RuSeFF
 sRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717574145; x=1718178945;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kW81FqSIjrgQtFVLLzSySnJuhnhJFEbLH9doDm7D07o=;
 b=kdRreNeXXr4VbDp6xlRr/53IqWkSKDk+dIvZr95yjwR/yUFDPq8rY4HMZo2C+gD7w3
 reeqTZAaE6ktFSkz4pQxxRdZkAx/u1VaaTpGdlszgmZ0Ju93yIgybGf77IZn5g+Cj0g/
 TMqMZj4XntXgX18L6gkUKvDQiRZ1g6rwYKXsXspast8+KdOJP9JyoXkJ74qAJMUqfI9j
 kxfSgM0ZMOYNvTMvRPNpUHwebtbVLxGtnIPUmT+/UX6AyShAc7kRtoF7+U/DyDojNHLD
 Rny9q5F1M3Nndh44h4mo0lp/Db7El3ZsuKuQVmmscmC9NucFwKGhr/yYzaj+q4M+2+8W
 IHzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLIOKqzsQtWIM5dSlsmZ/d1NkPSzm06MvwONJ24NCUARO5YzQvqdqW/EvnEHNvIs30EuUSM6u08bVSiunDhpHNlLiXeFc=
X-Gm-Message-State: AOJu0YyhZXoG+oRT8ysBSsRiC6cBDFoJAo85UgXvFxf6qizThw0Tz5Qc
 HbuEHgMq7C3+H+Y1cAbhiAb/6j+TaJdvavohnOAgJlzXT1gc2lK6RYHen452b7q22JADp0jHLij
 XJNA=
X-Google-Smtp-Source: AGHT+IHw6BVihu/M2dsu8SIn1txBI3B0MHrAVnzXJHjOQBLsNwyyFzFwGgFHLW/pIRQEZwSqhGk39A==
X-Received: by 2002:a05:600c:198c:b0:419:f630:57c2 with SMTP id
 5b1f17b1804b1-42156354238mr12551485e9.37.1717574144931; 
 Wed, 05 Jun 2024 00:55:44 -0700 (PDT)
Received: from [192.168.60.175] (144.red-88-29-107.staticip.rima-tde.net.
 [88.29.107.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215814f0besm10601905e9.43.2024.06.05.00.55.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 00:55:44 -0700 (PDT)
Message-ID: <76ba76b0-691f-4bff-b23b-4a7001dabc2a@linaro.org>
Date: Wed, 5 Jun 2024 09:55:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/37] target/sparc: Implement LDXEFSR
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20240526194254.459395-1-richard.henderson@linaro.org>
 <20240526194254.459395-22-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240526194254.459395-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 26/5/24 21:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/helper.h     |  1 +
>   target/sparc/insns.decode |  1 +
>   target/sparc/fop_helper.c |  6 ++++++
>   target/sparc/translate.c  | 11 +++++++++--
>   4 files changed, 17 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


