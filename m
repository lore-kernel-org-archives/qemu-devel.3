Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C14C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 16:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Szc-00041Z-EA; Fri, 10 May 2024 12:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Sza-00041B-GW
 for qemu-devel@nongnu.org; Fri, 10 May 2024 12:21:06 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5SzV-0006Hz-LA
 for qemu-devel@nongnu.org; Fri, 10 May 2024 12:21:06 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a59ab4f60a6so493714466b.0
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 09:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715358059; x=1715962859; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zCIKm8EKYDa63QlPKgNDbj2dLeKOvbAhBX9wOnswxI0=;
 b=pKXK47qa2GGOD7LAT9MAEk9UUXGr033bJUs/HKSZVANxFDyS3Hwa5tV/lrvBBx1TdA
 XS1VxGdjl/1CpqGmUwQC6Pm4JCVpnC3Mdk5dA4ZBcgUeAmms+DuK/xsdPiwKCmshynas
 doNvis7ZJHflxL8EO1WsWiTEe3LB4BtfK3PDL6IBCJNlmUCC9Tos9Vbd89RAaEfSDArR
 /XOXasFiPq4dTNSTheYwxcyop3AqHXdGi5ALRa6KgbCzkJ28xzeuS5KxXHPca5Ygq+4I
 0qly91aoMy5YhxorH3vwZLpy8Gcl9Cqaf/MugZ60K3pLSW3jFi+w/2PcOz8yIMKBp87I
 Jqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715358059; x=1715962859;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zCIKm8EKYDa63QlPKgNDbj2dLeKOvbAhBX9wOnswxI0=;
 b=JVwQ6PeqfFzJ6t8vl78yvHZCu8QoHeWMUiXfE/Jh8wyTKq7cTYPJSkTRNTGYbEIjBI
 Al4K0CB/bOFyS8vyx1bdaJBrA/5O49d0Undgbt18Nx+yaN+1Yc1DjzLu4BfqbmfwR2JM
 b8gLj2b9cKpo7rETjq9TSLfNXZ1U0eocFIQKLhfX0PV3iw20whcacg0xq87EpRlRjgZk
 GT1UGepH8ycyIYGHbkp5AtCvnFf1M7rWZYlAhiRdtmQgjgpyK7Y7ArncoV9k0vFPQbkW
 EqfCF+WAj2P9qQteMBu4rotglip+XfJbjvxA5ZjE7gLvftWXgTFJOnGEShvBpMREOLbp
 YIyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBcOnA2QaWGlBr6zS6MeDZqoG2m/cWH6UFzQzwmpnTpGQkl/8M1a/pCKijJcvQXr/HFjO8YPR+avqdaFAyPk/GHDI5e/g=
X-Gm-Message-State: AOJu0YwsmuEwE1igNbc21dBBmicaEUbGUpy4bS7fkMck+9x0xv2CnTiT
 +6ceDpPlpcVfa/tjKVRMTTY7w/xL3Mj/0b5dLzHWVJGKhxPiB73ebj6LwxffEZFjT/MtYzXekC2
 m
X-Google-Smtp-Source: AGHT+IEhot7tmaavYYhLc1r/YgIZHnfqcyFQGx2mdV9amLrHPuXGKA8wXAT0x3VhNf8NRGv3vpHnyg==
X-Received: by 2002:a17:907:320b:b0:a59:b177:22d7 with SMTP id
 a640c23a62f3a-a5a2d53b75emr380154066b.8.1715358058712; 
 Fri, 10 May 2024 09:20:58 -0700 (PDT)
Received: from [192.168.69.100] (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b177fcsm197266266b.202.2024.05.10.09.20.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 09:20:58 -0700 (PDT)
Message-ID: <d0bb2906-802e-41b8-9496-5ab6b0f1533a@linaro.org>
Date: Fri, 10 May 2024 18:20:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 35/41] target/sparc: Implement 8-bit FPADD, FPADDS, and
 FPADDUS
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
References: <20240302051601.53649-1-richard.henderson@linaro.org>
 <20240302051601.53649-36-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240302051601.53649-36-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2/3/24 06:15, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c  | 11 +++++++++++
>   target/sparc/insns.decode |  9 +++++++++
>   2 files changed, 20 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


