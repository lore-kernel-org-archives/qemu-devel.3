Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCC4C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 07:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbb1n-0005a3-Cn; Wed, 07 Aug 2024 03:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbb1l-0005ZO-02
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 03:24:09 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbb1j-0007bS-6M
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 03:24:08 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5af51684d52so1734065a12.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 00:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723015445; x=1723620245; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hzOlHT3mUwPVAVje3Y8cl+MAqw3wG6SAdac9TZ/W7E4=;
 b=iRMgV8/jMxiyWI8b9USkKD+RXoZY7EzClqTNoMIWRlpAmryvBeGaydR5HZoWdrAKxT
 uNEQVQObxMAs5kb8mdtTkKyBdVfHsWXfeBV3nZ5a2C7+GUtaw/rogiW/Zv7Rk6eNtCQK
 VCQ0OiyPD7J7Aq66Kb1oNQ1IiH933EgXOSN6SSJDnChneybGap29D8Fu+J1ebXB/gX7o
 4/q8xLZes8rVdssTZmIiQkp7+PErP1cnIIHmXEIBSYOT72Pr4fzAMRnTVcEQmiotoYsH
 8Cal27z1z5FkZ1O4nd4JHwSLCabalnYj3MX+GewcFI9heFK2KwDbumpuKWgVoNn8/XuD
 s/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723015445; x=1723620245;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hzOlHT3mUwPVAVje3Y8cl+MAqw3wG6SAdac9TZ/W7E4=;
 b=r/ytVJEZqZOtE+OulocNrz9OmPNG31HR3NWe74ICS/hg44no/3249ub1cG8P1EXkBJ
 Bc0lPX+H7mCb9q9+gd0Dx8un21Zo2D1CpUawqsEhE+hrt1HubJH5yeYjKTkF/SzSVzNn
 pFKOU3XjlxwE9BWs/lQyJBOOJkZYeOEK7Anl98C9xRoAHFyAHCcLzHNSwxUcNHKMhvRF
 ja6WNoRkK7WQk3bQfhEmb15jBr/W9WLJkCn8h3hVbkd2swUcN19YaHMVNMIexE7VbMW/
 OPK3+hBYlR5ev+Zk1OIsb5Fjj1EgQroawfnHb4AzuiOAngI1iDgvwqBcz1oQAveWc4N0
 w/Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeB0JQkWc2GgWbuWEwMYmh7+d81kMiQ/b5r6svQ9sExi5LaoP8yuL7hCYBbdm0t386VEQXp7+bH4HVtp+SXXLEUgACk88=
X-Gm-Message-State: AOJu0Ywm9MVhRYlz7azxeVWvmvamWK4Rf4tGzhVTpOthzfnQpRARkO/P
 VRnu87fT2dbag0moxgSPzxgXCwrRO5LstSxtnIPRCsTVxwsnzoadKEEJgQrjf3c=
X-Google-Smtp-Source: AGHT+IGGwgD2UxYGHw2ZdmRPFoHf8NUn7hPkWGrChWON75hE/sZbVNupe9gtPRX3FS8sqse2/Kt2rA==
X-Received: by 2002:a17:907:846:b0:a7d:340e:43a4 with SMTP id
 a640c23a62f3a-a7dc4fae19bmr1187745666b.31.1723015444990; 
 Wed, 07 Aug 2024 00:24:04 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9ec8dafsm615813766b.220.2024.08.07.00.24.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 00:24:04 -0700 (PDT)
Message-ID: <24fe0d07-1a66-45f3-8f7c-ed3d4c632161@linaro.org>
Date: Wed, 7 Aug 2024 09:24:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 01/28] hw/intc/loongson_ipi: Rename LoongsonIPI ->
 LoongsonIPIState
To: maobibo <maobibo@loongson.cn>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20240806125157.91185-1-philmd@linaro.org>
 <20240806125157.91185-2-philmd@linaro.org>
 <c5d485dc-72eb-207a-c348-b445303b41a4@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c5d485dc-72eb-207a-c348-b445303b41a4@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

On 7/8/24 09:14, maobibo wrote:
> Philippe,
> 
> I checkout the latest code, it works well.
> Thanks for your efforts.

Thanks! It took quite some time, but in the end I
believe the commit will be easier to review / bisect
in case of problem.

> 
> Regards
> Bibo Mao


