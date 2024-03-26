Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8002C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 18:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpBwM-0001tW-S8; Tue, 26 Mar 2024 14:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpBwL-0001t9-13
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 14:54:29 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpBwJ-00067z-Jx
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 14:54:28 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-29f9bffaa3bso3947424a91.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 11:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711479265; x=1712084065; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=apUxXYhnrlSe9jpTuWpmZ1Cv0hqFWU1KrjJJfSrYSX8=;
 b=nDWQu3KAAl12thF0a08Dp1eluaGa6bsgvimHaxU6xO496wG383yRXONRJhF6nDVHZK
 82D26h8wk6El3e24ClcRNQ0I01TSEdSRoVWe6x5XH3FCd6xPfw4GXhayp/Xz7Xpv1YXq
 bRwNuVwEDpuzYQznfmQfhcozeC2FUnxatIWRThy5VCUtHWjViFKstKn36/lXBOEfoEZ0
 fC484a9MSbA6ybkW5ZUkmARRROYmOXUUiyCNb8LAgFEmxWEzX5QSZBW5syqwwpA1rE8J
 v8neV5O52Uc6fnJYCmfWi9APpZW9QL8aaS5klIFq0lZMc71+LCH47czpZy32i+HUccIA
 uniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711479265; x=1712084065;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=apUxXYhnrlSe9jpTuWpmZ1Cv0hqFWU1KrjJJfSrYSX8=;
 b=aFwbrL0bPpjlE0HwtO67q/YwMEaKEH1v7EYpBv7xC8gBpMCJcHkoca144ApLV2ioRD
 z8F2b+BZu3Xr6nSpeM6g7iz5DV/KR9ES2KqnB1ggAO83ds15peXsbrvx0Ur9fs25ioDT
 C0wJhsgqkjWh8j6nIc/3my2/Evu/eLX2avrc2HTWucuypj807PJRKmF1x4UkyIQq1BMT
 p6UHmHGszQYPV1aZLZxb9mDcdshAfmMtoCLPkW9rTPyhkIiqDE/mqPGWJyWF++WAtfML
 lZRm5i/qVfNTA7os2gQvv/9sd1nYdIHllFqrKm9v7MuVHdFeVQESr7T5MMcL1BFDDfiI
 Bc/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXknscJvFWYms9R4NCYO2XCyFAOjWlbvVlacXlIZsKO8zztBuLbyiy1KjfI8e0wV6wfPEGPS4JCh9lWV9a/FWuKQSvrqQU=
X-Gm-Message-State: AOJu0Yyvzare6tck86299rN0weL1qNQg6DZYTm4c0t+AiW2M3TqhFgqT
 MdRHCe1BBd3N7idQRIwG9TLiCJvh0K8NSLeuuP8CoAoNI0wzdyUf5olmTMjb+6w=
X-Google-Smtp-Source: AGHT+IGrEcOuaAzYu4NgEcjkyE+Vo69YBP4z5aPSMcGmhVMInaz5tA+R8LaCc8se3BeQrIl0I2VASg==
X-Received: by 2002:a17:90a:ab90:b0:29b:6da4:277e with SMTP id
 n16-20020a17090aab9000b0029b6da4277emr1948689pjq.1.1711479264781; 
 Tue, 26 Mar 2024 11:54:24 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 x8-20020a17090a164800b0029de1e54bcesm13438789pje.18.2024.03.26.11.54.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 11:54:24 -0700 (PDT)
Message-ID: <3ac86bae-31b8-43bc-b319-aeb91f7fde1b@linaro.org>
Date: Tue, 26 Mar 2024 08:54:20 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] plugins: remove op from qemu_plugin_inline_cb
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20240326123426.761473-1-pierrick.bouvier@linaro.org>
 <20240326123426.761473-10-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240326123426.761473-10-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 3/26/24 02:34, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/qemu/plugin.h |  1 -
>   plugins/plugin.h      |  4 +++-
>   plugins/core.c        | 13 +++++++------
>   3 files changed, 10 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

