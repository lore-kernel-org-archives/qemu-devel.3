Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB4EC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 11:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvEkk-0007vh-Js; Fri, 12 Apr 2024 07:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvEkh-0007vF-OW
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 07:07:28 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvEkg-0004uM-10
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 07:07:27 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4167fce0a41so10429475e9.0
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 04:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712920044; x=1713524844; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZTQBHv8uoMiQWEf8a6YUUTEodp8zg0PUA1ZmymYUuoE=;
 b=gEqqya5/6stunARk6YqL321sH1XL+oiFSrpvP+yrf4wA1RKcdx2Dm9OqouhKL7V1BJ
 8owdEgiCjbGZtJWqeUWNj30qc6MzIOhDW8+B99DcboCIM5nt38Nnao21EJTtP/sCPdZ3
 /iIaFevgl1dVYwShOVocGkSB+HxBR5ZKEf169WRrkiqtZySPSZxldnMauAOJn4iXEqxq
 bTQFBBu8xrVJhFPNG5soKwzp+viZSwxNUpcBZn25gxgH+kyttxUdMP14P/7DIAY+b3CU
 BjzWOVHuIrvviwTYUeMKccKqFAKZZ7KIkkMG9FyyB4jOrbgf+cxjyZ/e82eIxOkry/jT
 ge0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712920044; x=1713524844;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZTQBHv8uoMiQWEf8a6YUUTEodp8zg0PUA1ZmymYUuoE=;
 b=k9OMZ/kziasAppGkc81cYl2SIgNAfCnkpIPvlttHyoRdEYQiPkp9K4IWoAuD3LTxcC
 njPNFbcWN0WR1vRhmXNLLN7m8lKewfiUxpQEomOapOV12Omeij/1D06274pUXaiIqibJ
 wX8ZpT/JJ9oNopVNBGVNw9lVyktaZE413e7SwivUVA6MfW0vZBDkNf6QFluojMIS+Wvc
 V9ipTVwrjAn6iG4jhyJv/aHHTDbYa3gpuODWu2HCsnRfDw33YSnx1a8lkxeRzcQ0sZDP
 6mjuQ8vVLnu97PcN7TZqBIgbMQhjtXeJv5hmAWr4FG/vidm5BpcQssfVu7vKmdn5klP7
 sIwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV90X9W6KpW3NELlzj1w5ci1HV6grHpPRhGiuHZ/91M5dzrHTBbfsEx5iC6jKF4sAkOzL9PZMuvU+68CdLuUUIYavPeTg0=
X-Gm-Message-State: AOJu0YyzXYbfvJTsr2EnCIhfiEp6YRxAJ3KMnsxYuDLm2Hfd7hAbKkCC
 6SQ2BiSky6HAp2AOLDmEAQCWARnEjpOiOnFI4ephCKyjR1Q09bl6YR2/UWuNsL8=
X-Google-Smtp-Source: AGHT+IFTyYLQ/e2nxTBjbmtBC9oF6s/r/mA6UwZd9N2um8Lu2VaGTFN6p/fDDRnAQkoY7+bEazjtWA==
X-Received: by 2002:a05:600c:3146:b0:416:259d:b250 with SMTP id
 h6-20020a05600c314600b00416259db250mr2075054wmo.18.1712920043594; 
 Fri, 12 Apr 2024 04:07:23 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 j19-20020a05600c191300b0041663c75ef1sm5369441wmq.32.2024.04.12.04.07.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 04:07:23 -0700 (PDT)
Message-ID: <0eb8a3b5-cff2-4ce8-8e6d-ab4dc2dda84a@linaro.org>
Date: Fri, 12 Apr 2024 13:07:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] Final build system fixes for 9.0
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240412100401.20047-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240412100401.20047-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Hi Peter,

On 12/4/24 12:03, Paolo Bonzini wrote:
> The following changes since commit 02e16ab9f4f19c4bdd17c51952d70e2ded74c6bf:
> 
>    Update version for v9.0.0-rc3 release (2024-04-10 18:05:18 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to 2d6d995709482cc8b6a76dbb5334a28001a14a9a:
> 
>    meson.build: Disable -fzero-call-used-regs on OpenBSD (2024-04-12 12:02:12 +0200)
> 
> ----------------------------------------------------------------
> build system fixes

Since these 2 patches don't modify what we can build with v9.0.0-rc3,
would it be acceptable to merge them without having to produce a
v9.0.0-rc4 tag before the final release?

> ----------------------------------------------------------------
> Matheus Tavares Bernardino (1):
>        Makefile: fix use of -j without an argument
> 
> Thomas Huth (1):
>        meson.build: Disable -fzero-call-used-regs on OpenBSD
> 
>   Makefile    | 9 +++++++--
>   meson.build | 6 +++++-
>   2 files changed, 12 insertions(+), 3 deletions(-)


