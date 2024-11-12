Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BF5D32D8B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 10:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAo6W-0000PJ-1D; Tue, 12 Nov 2024 05:26:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAo6U-0000O6-GY
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 05:26:34 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAo6T-0001AZ-3e
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 05:26:34 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-431ac30d379so47443965e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 02:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731407191; x=1732011991; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MM+udzd6rUaQVQXLnyOWUvUsOm++hSjijhTgwiQyClM=;
 b=bLU5KvYUoG15RHHUMe4DTWh4VJYDC6iNSCKLTQZaBpR2q3neDyLwp9CgyNSzsAodL6
 6en27vuXGFTySb7vsXZo+Hr6qG90m8BMXDw3ljlQr3C5katWtfunptDOszXRh9vvZLdv
 6h5Wc7tbwL9FDKk4EOTUUPG4b6nFardNabGRRLSZ0TNd7z6N8X8e2TSsBzV2VboadYNJ
 4IVsgeEwe2kY9t0dd+uwYTIn67TF5cIocQFlvS2bw/fEwt+vJQDcHCl9rfeiNbbZLWNn
 Swy6SKJkEh9usXc4xHoS1TydkPLGC3nlMPrdKY3nzc6aYQHi6YS9PS/Qbpac3FhQV4SF
 N7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731407191; x=1732011991;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MM+udzd6rUaQVQXLnyOWUvUsOm++hSjijhTgwiQyClM=;
 b=HQnwK20JuCiNVp3UuaK8ua8Ntu4mcmPMnk6r/TyZGvqH3tkn0L/62/1vSjNT3UKkG5
 PuWpp0IA/EGZhCOISUnWtdgjQTo/Lzxx//36O2jX672iksIAqf0jScEyXGGaYGvE35/T
 l1mym2iKyHe2ftrtnfn0TMPyH7oTDmmKiTR8mnWbM32PcahwTRJihLEWpN1qyQlQqUck
 HEoUxGIZQD2F3whd6ad4vM/cwhjbgJr/k55KpZUpXYXxz0u2t0dMR1sZxOiDP9GR0fI0
 qgV74q0paX+8C9/gvzU1VgA1REV35CnS5SkezYi4Bl6bVKyl373qPWX9p2RWSiPvZcxn
 kdjw==
X-Gm-Message-State: AOJu0YzFNnSMCxlo4LSIKlILMdQmkjhUanHZv5TI3os4svoEYdFFGsPU
 0xfUTHefle0mxZG1oOHvwATHegmpSbRPrsb4qxkV6Fsh9Sy+LP+82+iPDhauFOATjpxMP+M+Ei+
 5
X-Google-Smtp-Source: AGHT+IFLxNMDDeLVdWmyBDepzcn8ukQuVKQPmmFlo11rS9AlTB3a7ReSm1ngC5G1/meGAZy1J1/Ujw==
X-Received: by 2002:a05:600c:4ed1:b0:42c:de34:34be with SMTP id
 5b1f17b1804b1-432bcafcda5mr108117585e9.3.1731407191393; 
 Tue, 12 Nov 2024 02:26:31 -0800 (PST)
Received: from [192.168.69.126] (vau06-h02-176-184-43-163.dsl.sta.abo.bbox.fr.
 [176.184.43.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381eda03e42sm15318691f8f.89.2024.11.12.02.26.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 02:26:30 -0800 (PST)
Message-ID: <e31a7686-5235-4315-80d2-b479687ad156@linaro.org>
Date: Tue, 12 Nov 2024 11:26:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add myself as the maintainer for LoongArch
 VirtMachine
To: Bibo Mao <maobibo@loongson.cn>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20241112073714.1953481-1-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241112073714.1953481-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 12/11/24 07:37, Bibo Mao wrote:
> Song Gao is will be sick leave for a long time, I apply for maintainer
> for LoongArch VirtMachien during this period, LoongArch TCG keeps unchanged

"Virt Machine"

s/keeps/stays/ I suppose, but I'm not a native English speaker.

> since I am not familiar with it. The maintainer duty will transfer to him
> after he comes back to work.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>


