Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138B3C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 18:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2xiI-0007mK-AN; Fri, 03 May 2024 14:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2xiF-0007lu-RP
 for qemu-devel@nongnu.org; Fri, 03 May 2024 14:32:51 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2xi0-0003gs-3d
 for qemu-devel@nongnu.org; Fri, 03 May 2024 14:32:51 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a59a17fcc6bso32195866b.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 11:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714761152; x=1715365952; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H+XxOd/OtkwvOv2tf6tI7/B498c5mLfUXBtNQTdFwds=;
 b=I+57eZtufyF8eQTV+22ETMfXziDDDOlkYSLChJu+L17Njz9N9+LGaYiaII16ws+XVk
 0o6scJBi0CDWZlJZkKJfFjXbPHRNT59X6ZXh7wChYgdUk+PNpfp6CTyuBeHChX5tbrSS
 DQT0bWE4OAkKA86QOzgFJ/1erJap7LD/hO5ZYAah/NMBfTb7SkkgeexOqRO+FvsGXTmh
 J6JP0/o7i/XzazZz+6gfLosC6gskzgHQ8edrWAgnVn+qtEwYWBTPnsl1+7e6k0RBhX4b
 aSap3tvvBYDqGKh4YsYJSnWEzBku2cMKKRuYyZ3Oueieh3o4ud5dcB2jNTVW38epTerm
 xVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714761152; x=1715365952;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H+XxOd/OtkwvOv2tf6tI7/B498c5mLfUXBtNQTdFwds=;
 b=ViwuvnaRl9TCu0evSX3pXz03wYfKMJSQ5HwrMuwUdYwOBtDys4WBLPlosbb7/QiKGV
 tQn4JSsVKFSjV2qHZLcyoMrBvhAc3myEj1wDQa5zdzA7RlRSabX8m1+j987yc0Vrfrqk
 x2vOoQqbXO0ChF7MENlJNaiQjE8BbhXHvu0GqQe5nKMwzZxlqfWNBcFZ8LDTLycDT9tP
 mm0P70esKnYeDITG9xlz/YjNBw2wa5BZ/GTGrrBZgVt5w9MOkvVUg96gzM81YA9ozXkG
 hMvveSdYLjlk91+yZx1usJNXl2utg1mYDcaZHb3f2ihutVw49ouligMc6+OXQcFyLLqE
 Ys6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjzwLtSX+xhVqwR+N3g7N5uDWyvzdLyOGWxYOiwg+H6//TNWSad2BaTQ44c21zgFK+fA1ogbJ197FSAehXwkh1PhpW0WE=
X-Gm-Message-State: AOJu0Yw6oJeVpHIqWjOze6wBxOxdIcrjf5UxI2Un8xMJn37h1DP1fG42
 s+KzU3xJh+ZSZq/NrM2gxFtfSW+pnHzI2HDrmR2UJtrJCTl3vrXsRWPY1XKjCPg=
X-Google-Smtp-Source: AGHT+IGxUchAAdUqXXdJS5rQsGOsV/XDuExsQEvE3txFI/Gc3k46DELWItRjrLjvpdN4+scTc9JMYw==
X-Received: by 2002:a17:906:e20c:b0:a58:ef89:d04c with SMTP id
 gf12-20020a170906e20c00b00a58ef89d04cmr1938625ejb.46.1714761152052; 
 Fri, 03 May 2024 11:32:32 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 uo8-20020a170907cc0800b00a5971c23e59sm1767142ejc.82.2024.05.03.11.32.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 11:32:31 -0700 (PDT)
Message-ID: <cecd4b38-5cc6-45a7-9238-7f61725dfa9b@linaro.org>
Date: Fri, 3 May 2024 20:32:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] target/sparc: Fix FMUL8x16A{U,L}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20240502165528.244004-1-richard.henderson@linaro.org>
 <20240502165528.244004-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240502165528.244004-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 2/5/24 18:55, Richard Henderson wrote:
> These instructions have f32 inputs, which changes the decode
> of the register numbers.  While we're fixing things, use a
> common helper for both insns, extracting the 16-bit scalar
> in tcg beforehand.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/helper.h     |  3 +--
>   target/sparc/translate.c  | 38 +++++++++++++++++++++++++++----
>   target/sparc/vis_helper.c | 47 +++++++++++----------------------------
>   3 files changed, 48 insertions(+), 40 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


