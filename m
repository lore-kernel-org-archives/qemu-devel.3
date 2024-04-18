Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81261C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 10:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxPHE-00019D-2Y; Thu, 18 Apr 2024 06:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxPHB-000188-Vd
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 06:45:58 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxPHA-0002gO-8U
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 06:45:57 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57013379e17so592976a12.0
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 03:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713437153; x=1714041953; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9PuiYkm7+gZ6ppHQrNcMSefqskPNd2Gr2aTOjb1Dtp8=;
 b=kTomWbsSQ4C3OxVBNprwKyEAYE2DBDxvq2/ztbTsuucI9roilyqi28ib+JGWNro0HE
 lrnTjv5kRaVEfS4iMM/h1Hf1ulmK2TJo9CHilQ9cNqEoE4Vb3mumAsmV9NGd08McgPJk
 F4NV6wvkBcgj5ZXeu/gJd0R5N0Nf88IeMqapmL/A9t37ihl3HKWS7ZgQdtwY2lSG0A1t
 IKJq39P62M+gJFj2HvoprIr2tBFlvL1D8W4aV2vnYpp4CKihcoJCfMHqLgLKkFmjP51s
 s3m09COUBCvNpBK8xvodFc3YNnCokcxqjok7Ovz5VaPwQEW2WC+ES5Tfcnjpp9P5PxHW
 ewiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713437153; x=1714041953;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9PuiYkm7+gZ6ppHQrNcMSefqskPNd2Gr2aTOjb1Dtp8=;
 b=GoTkARypynzsUUbSxj9ubtznGeXF1SdELRb55dnA38SndY23nH6WFa7LhhLRq5xp2R
 7OSM37gsWyfYkUk04kob8e7a95Zt8a4ak+U1TMuHbfMnKjdMdqD7m1S3T/HwqDkoeuAh
 JGz4qjel7KQN76np41P5w+Hdg7yYwj0bszWpRS9l2KEyoDxIK9TPXGRxO//w224+3LwL
 pBINZS0yJdcCGXm1uI4ma0VrIkb8KLLqpz2EmUKSKWFRVhRpOJnF8X8lxLX8/13I13uH
 tlYI78jnXmYd8pOpDJ+xrtSdiq7gmQC1vj2/4lj0dur1LTKxGI/R8sxutHHYELBgAIAO
 +rDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLJtp54mA81p9xEIoOgSjTvmIQNc10E+FseyrYYNEs9BLr8m+qa8+if4fQV0Tx1HNPXAm8KOtgiJ9t8lAgDj+MqPl/Uas=
X-Gm-Message-State: AOJu0YwedZRkqoFl9ptApW8tkGEbNDndll8s76fV3MV9BUTd4HUcDBmN
 HzH1pad5Wq4En/i1XnSGKitNcAim5gjPAthhIyNFqe6wJvWV8SBIFiuf8tGO+zs=
X-Google-Smtp-Source: AGHT+IGJ+2MLSa2KH8wYR7XGy12m6hjguWbnKM6ArA/m6JprcEO0XwDmADm5DkUnRcwjt8CPpNsLaA==
X-Received: by 2002:a17:906:28d6:b0:a55:41fd:a013 with SMTP id
 p22-20020a17090628d600b00a5541fda013mr1738760ejd.23.1713437152816; 
 Thu, 18 Apr 2024 03:45:52 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 m19-20020a17090607d300b00a4e23400982sm725856ejc.95.2024.04.18.03.45.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 03:45:52 -0700 (PDT)
Message-ID: <fd6137e2-ba9b-41ee-9462-9f713bb79988@linaro.org>
Date: Thu, 18 Apr 2024 12:45:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/21] accel/tcg: Un-inline retaddr helpers to
 'user-retaddr.h'
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240417182806.69446-1-philmd@linaro.org>
 <20240417182806.69446-14-philmd@linaro.org>
 <f86171f2-3604-4da8-b07f-8eacd2489be2@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f86171f2-3604-4da8-b07f-8eacd2489be2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

On 17/4/24 21:30, Richard Henderson wrote:
> On 4/17/24 11:27, Philippe Mathieu-Daudé wrote:
>> set_helper_retaddr() is only used in accel/tcg/user-exec.c.
>>
>> clear_helper_retaddr() is only used in accel/tcg/user-exec.c

Here should be "accel/tcg/cpu-exec.c", fixed.

>> and accel/tcg/user-exec.c.
> 
> Typo here, repeating the same filename.
> 
> r~


