Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58767C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzGJi-0007k0-G6; Tue, 23 Apr 2024 09:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzGJe-0007gT-FB
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:36:11 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzGJc-0005e7-Ka
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:36:10 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-34b029296f5so2363840f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713879359; x=1714484159; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nni37EdGZXTULT4DrCA0J0B9S1cffqAH/YEizpNpJBY=;
 b=B15FcWaubzifYev+ZYQgsOGUWvsLyIZX3Y/0+03lxHj6Nyaebjs5qSxvfsGfiYoKDp
 HCb21Knj6JhOJTke5nnCJpKAfL/+dmWrq54/NVK/BFvkSUAqYIqAMap5w+Kdq4Wj8JLQ
 sNks7mRjdYDPJPW7qSkpXteJWxZ+Puel2InpQ2UszCZ4dTa09P4fg1Nsyy85Tvegg5Br
 XbBMb+8AKsyHAtJ5mWUtIglALI7fChGPo2ubxQJC1YHXD7lMRBjjtMiNmpS+ITNynqjU
 pRSsz94XsA5+xywE3/XdELoTTP+y6WnkekjWeyAhwEgVey9FBqbAHgmDKCrgkMadiiZs
 V+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713879359; x=1714484159;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nni37EdGZXTULT4DrCA0J0B9S1cffqAH/YEizpNpJBY=;
 b=YhkxqM2fmVSRnXtUVBKMVuhOJA7eJWbBsQ/tUuFlAajvs5llQcSBn0RAxsWC7uieTH
 93wDgpjmq7UZXNJybeIiTL9WwULs4jkiu1TPA+xA7eCPpmzejMXciJDmTnS1cT1hydih
 NLqMuzGzGhrw4IdVocgraIme61ul8eoJDd7GozMo9+TjJyWWjOiWz7OHE8GCIDHQIjls
 0OYvojOIKLIEC8L6bOZSTWV5dfY39pZtR61G7ttPhsPqdZFcpSV6VeYNXtFTvEUjGuRF
 OzitENF8O9xoqwKzfnGSL1IDakxBzPtolLckoPTBiRUyR8JdRAFxV5tZBGwz8rdepJcM
 YaQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr0PwIud9iM53oiLB/urx9BbP8xR8id6ssJnE9aOs0wmifCmPChDcO5LhOWJXExG9vrRooVRPw2B4ZtjAibF4F3XCzNC8=
X-Gm-Message-State: AOJu0YzExkU7iYRMsm6iBetP9wMw8rAaKdRrpowzeN/S+xOzMutaxNvf
 lfiKsEb5sex/JzUHQcAjBbRoFM62uvcW4JIlSGNrzorhmPpG4rdT57FWKRzBwAc=
X-Google-Smtp-Source: AGHT+IG7WnzCAUPT1avjj8PU474GttL6d0fH2VB6PnSzf5aYxHIFe9TsuwUChh+mWt/ID6clVooKMg==
X-Received: by 2002:a5d:6652:0:b0:34b:f16:d54d with SMTP id
 f18-20020a5d6652000000b0034b0f16d54dmr4821412wrw.16.1713879358865; 
 Tue, 23 Apr 2024 06:35:58 -0700 (PDT)
Received: from [192.168.175.175] ([92.88.171.241])
 by smtp.gmail.com with ESMTPSA id
 w20-20020adfe054000000b0034a366f26b0sm12994494wrh.87.2024.04.23.06.35.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 06:35:58 -0700 (PDT)
Message-ID: <4bcc5c42-d72e-4a07-8f35-773b345afece@linaro.org>
Date: Tue, 23 Apr 2024 15:35:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/22] xtensa: switch boards to "default y"
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: farosas@suse.de
References: <20240423131612.28362-1-pbonzini@redhat.com>
 <20240423131612.28362-23-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240423131612.28362-23-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 23/4/24 15:16, Paolo Bonzini wrote:
> Some targets use "default y" for boards to filter out those that require
> TCG.  For consistency we are switching all other targets to do the same.
> Continue with Xtensa.
> 
> No changes to generated config-devices.mak file.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configs/devices/xtensa-softmmu/default.mak | 9 ++++-----
>   hw/xtensa/Kconfig                          | 6 ++++++
>   2 files changed, 10 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


