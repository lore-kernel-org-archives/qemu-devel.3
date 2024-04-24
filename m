Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1350CC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 22:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzksN-0005SO-OQ; Wed, 24 Apr 2024 18:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzksI-0005Rr-7D
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:13:58 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzksF-00017v-FH
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:13:57 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2a87bd53dc3so351508a91.2
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 15:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713996834; x=1714601634; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3jsaqkhAx+Q50/TX5mvV0NuMIz8/EsB7xtWNvi2d+Bc=;
 b=FIrsVqYZJoCpIfyBOfWwLMApt67ciZWBSOaqg/sZ7+6RLYuWIfcKZBlilIrhz2FJsA
 y+a0T5LZ4pnQKEEiB2gZFzxpr1UYtLIZcoBiLlr+fEuKUyFGkP21qHubHVAnsEsKifQW
 92tdZAhqufihpEEOF62TBfbEl/hdDz7chiGgSdPTgENcIPV8whDrz22bCeqNFeKNE5i6
 ZeQCLJako1SWFS+YIMURVkTpQ3G3BN2hIcom6lwD6s5pNBWyjSFKYb6WOSd6fCLW+TXe
 ZwkQGuEx1KZOk2YrAqFP74DK9HvY800571fEs01nuYBRgT9TRVIHogGXFtFrOQ8Hroyx
 ZF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713996834; x=1714601634;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3jsaqkhAx+Q50/TX5mvV0NuMIz8/EsB7xtWNvi2d+Bc=;
 b=Kh4uHg2wDIZ8nLiNluluQVZLiXn85rr/C6l91+qIxVl+lTp8ufY03QCoA1l/v6RvOu
 vD7CYTZCp/6JOasKIOboeMIKMpasP/oFRXjrcjuOtM8OzogOg85SC17D4d3me9/fo8Mh
 skYeSbUYIIQ3rYF5aCqqCu2xU6pvubaGnxSa+ZGOkdTUexzPuVZyhDhMYxk6e7EIsHn4
 etvYximLlxc5koUgRlTM81GFgqICUo8IDVPRJ/4+wvNpkENkobqdDUIj7KNM87M7MWeJ
 DO7St72sWIqqfIVGfCrjD3aQUA173g6w8OgKEJh4PePGNE9D/d1Ze1Wc6bf4SJv8Es9K
 qNaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeefGgf/5VKSGO+Kbab/9T65MZpJfJCJ3HrPbGTlZ/mNaTi9DAlzcuX12AimsxO6uiJgeyA3hJY+mbwP1+0H2lSm8uNUE=
X-Gm-Message-State: AOJu0YxZSu3QGVF7ZPnnmRlaVsCOo4T+iMYBSS6QW+bPJ11n2i1ktSRs
 pIE6tWUN9QOOXUIUQRnaSyk/luvhoCKZhTEm1zeSshyA6Ryl/DRFl2+lOkAIPBs=
X-Google-Smtp-Source: AGHT+IGg0ZveAChJrLNbwcnVTlUEukCEl02Qcbqv1ED7R/of7RiyKYO7Vz7N0+eWAtooxOkC8J8cGg==
X-Received: by 2002:a17:90a:4884:b0:2ac:24ed:c930 with SMTP id
 b4-20020a17090a488400b002ac24edc930mr3774718pjh.35.1713996833704; 
 Wed, 24 Apr 2024 15:13:53 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 kh3-20020a170903064300b001e48565b40csm12452094plb.210.2024.04.24.15.13.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 15:13:53 -0700 (PDT)
Message-ID: <dbdada57-3bd6-4d63-b14b-f95ead5ec176@linaro.org>
Date: Wed, 24 Apr 2024 15:13:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] accel: Add new @dirty field on HVF/NVMM/WHPX
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Reinoud Zandijk <reinoud@netbsd.org>
References: <20240424174506.326-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240424174506.326-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 4/24/24 10:45, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (3):
>    accel/whpx: Use accel-specific per-vcpu @dirty field
>    accel/nvmm: Use accel-specific per-vcpu @dirty field
>    accel/hvf: Use accel-specific per-vcpu @dirty field

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

