Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDBED637DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 00:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVfiK-00018s-P8; Tue, 16 Dec 2025 19:48:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVfiG-00016i-NH
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:48:20 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVfiE-0001z6-Ja
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:48:20 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-34c84dc332cso3289953a91.0
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 16:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765932497; x=1766537297; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vgVzjWonhlHQa9PVdbwGuQqVmNy/ykCer1qfktrG/Vw=;
 b=ko53tetfnEuEGJ1S9VowQ/95vao4BQjtva63Svd7vy1gBpgQ0+x2jST+sClXifG97E
 6wYHmqCRnimbHaKVYoK39L9c+SSKMFrpkk84ev4pVs6N4qipdAxstzsYps0EdXPr2tAx
 /wew/6dft1S92Pz4b+t9644oOonH+ywjePpYZ14t1R7R26dju23CV9R8eLPjJswSRXts
 ngY5ypGgv+Uq9Cvi4NHqV3sHVm0aeRsANsUToDJsmnpVgmaprHt1dqmuFe37YwLvmYXK
 5/aPpF0dlkf0qfMe+KJYbAp347+FeOA9gsq2KFGw1CGR6no9VEYZOAKzVKLt3UvT9K6M
 PJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765932497; x=1766537297;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vgVzjWonhlHQa9PVdbwGuQqVmNy/ykCer1qfktrG/Vw=;
 b=rBNgzOXnKIv/HUYtB5klEZWVpHeTRQM9ogJtGqKeCCpMSAc1HVlxtb7BUCtZngzlP+
 8XpVctiRnjCFR8SBduNBSpyQU5pHuJacHcjAAPOUUWCmXvOdrdEmehRBrkuqImewqbdy
 EyhDhQMesSSW7JIKyxSoQKfjYlF5xz0SK25d6fE39u5ETLZJkx4bBUSvu6hECVmN1NMN
 Re525Bz1fdo34HpQinCIvMzL/M9GsbEJbwWGkoDjXahkFBab+8ANQVXmZhJ7glCxPr4i
 sBiH+OMkPQwMI0ebwxMSvfKD18YJv58FuuW8byFdosjDBSxfXUxe8wQVv/O2x6GQ4rbc
 HOUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc3WPKNTNvsePj8zwNyVeO8oX0Oh5ycMl5eDz/7LAe4W8dAzHbB8tlulqInSzmPvsoW4dk6fsj0TvU@nongnu.org
X-Gm-Message-State: AOJu0YzDnjnP1eLrXI/xBUh21XO8Ti3QjtNvpvXOZFKCnrT3J+PxENjm
 fl8qfn5j/+UG1xysVEi7khqdEgxT/Is8zZWLaH5RxaVPPAgOF9AHE4Vkkxw0D3w855o=
X-Gm-Gg: AY/fxX4FGetMQEMRN19C7QxPibx2il3U4Nh+Va0Aft3cHXpec0HPYZ9dBObRtPlkx8f
 QZzaWzFzkQtHINNI5aBkWzSEf1yZA1lLYvBMZ4QuH9hKhephW3t52SJaJux3Ysi5Un+m+HBEUmP
 Z5dTBFTjy9OztlmPkfJyT5yi5ZQErYeGOmsQAlG6T6ghvjray4UIHuFBPnqZMhtC9972wMQIkJG
 sBpiRJtsN4ASUInp3VORgdHZybD6mz+7QtA/sRAgeTU2IEyMyYquKXuj7M6RQ+je9yTf1BgSHt/
 ZobsfKbTuNmSU3gLCZG5TZPILG+M+5pIGQwHGqP63cizO2CbYL9f6jTDPjqUrxM+8l9wQaXczl/
 r+DgBjOgGN/JzOYpGFxpiGavNHBK3Ztnk7nujuoyOoOV6pib8HGFM+RP09y84J6pkILmmJAm+Th
 6Auv6/hCN7OGfgVmE5kSSTizlgHztQkwYKISBeM9N4fhIocmwn4jyvS9c=
X-Google-Smtp-Source: AGHT+IGMZnQ9AJJm8LbKsZ7KTjwcC6iP0RKbLp/nn6jBEth5TVmv7kGySTN39ld5CCYSmPWGT30Ssw==
X-Received: by 2002:a17:90a:d405:b0:34c:60dd:1bdd with SMTP id
 98e67ed59e1d1-34c60dd1c60mr9751374a91.22.1765932496748; 
 Tue, 16 Dec 2025 16:48:16 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34cfda21fa2sm611185a91.13.2025.12.16.16.48.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 16:48:16 -0800 (PST)
Message-ID: <6309fb5b-c09a-4ae6-acde-2f3824f01419@linaro.org>
Date: Tue, 16 Dec 2025 16:48:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] hw/riscv: Compile once
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
 <20251217-hw-riscv-cpu-int-v1-14-d24a4048d3aa@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251217-hw-riscv-cpu-int-v1-14-d24a4048d3aa@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

On 12/16/25 3:51 PM, Anton Johansson wrote:
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   hw/riscv/meson.build | 32 ++++++++++++++++----------------
>   1 file changed, 16 insertions(+), 16 deletions(-)

yeah!
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


