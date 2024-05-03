Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D0DC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 18:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2xUQ-0002IW-T2; Fri, 03 May 2024 14:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2xUE-0002E6-V8
 for qemu-devel@nongnu.org; Fri, 03 May 2024 14:18:27 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2xUC-0000tP-Ib
 for qemu-devel@nongnu.org; Fri, 03 May 2024 14:18:22 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d8a2cbe1baso122549811fa.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 11:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714760297; x=1715365097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3C53yKx8FpmnRvi2VDTwMn2dV7LXDFgd5JkbFo59PRQ=;
 b=oGscX4MU8nl0O9wQb927c75Ln90P8JswVzurvSind7y6crhyIKtd7FodGHlBGGL4O0
 j4S9MQiqoaIoPfdu8lBelCnguT7m3XOAhc9Gtim9QxhXbN91ky3ZEVQc5M0cL9dtb/KH
 wXCe6dYAel6RhAb9cGRauZkN3cKfF1OEey/guxenGvqK6g87KrY3W0+UyhK4ekmJIYL8
 fsVhRSxgvrgXO4gI4/CEBbOJJ35y8labuQjk/M+Vab1bGB0B6H8O/dPYooiBiF9gqDMd
 5S9tvh7LOx0J5Ae0CdkTSqAxEvJSIZGjR1U5KirBPQbEhAKVQtsHXaTTbddFgbCd0YWN
 kuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714760297; x=1715365097;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3C53yKx8FpmnRvi2VDTwMn2dV7LXDFgd5JkbFo59PRQ=;
 b=uQRXTlA1BBIQ7gzc/apGliPHwHDI05MVPzTka2LAygUdXezChXAwTFK/hQhho7TUCC
 V8iykeQkSxz35hBtBLTRkgVLUJsWdpGM5LYF7pWzNolYyQKj9jf4g6zwNf9QmRZFrSI+
 j3Waemc29pvvVlyQNKMNs6ws8TCTgdvDIsXn4Nm4Ji+o8Vg6iTZp+0sJISZ7TShZX260
 NwdzE9Cd4p5hKDMCDdDghNo/mbktprtb86kX2GheJAmd4benrC4EDiOdHM6Zn3x5hfxr
 LSWwMC4GNd++AG2kC66gU7XfSIpvmEhVsog3dpnDKdesHi4YUryPWJz8pfJUfofJMv/w
 7n/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWywlpPoD9f5d8PkuvbSPDeV5bMGxSk8VJ8xQZn2X8sDSvIAH5uP+DgnSN/1+MCsOnxeXcF44UttmdQbE0SSbL2bIIyLJQ=
X-Gm-Message-State: AOJu0YwRyf8eNkCld5j2i8RnozwiA1HssYrSbjj+UKZ/4vabr3lIQ3UV
 3eqRTCfNvF92aX3PG6Qm6xd9Gb7owD6ukRF6Pi5UtJ+/s3CzTOyry4x3LbT+MNGImXkIQeco7dH
 L
X-Google-Smtp-Source: AGHT+IH3zOeQ8SeEMdCxsNMSLXFp+9XLsZzAnPd8zEG5yTw9z8r9U/s30bB1ux8Mp7X5NsLdcm97xA==
X-Received: by 2002:a2e:9ad7:0:b0:2e0:b713:6bb3 with SMTP id
 p23-20020a2e9ad7000000b002e0b7136bb3mr3586713ljj.8.1714760297263; 
 Fri, 03 May 2024 11:18:17 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 p20-20020a05600c469400b0041bc41287cesm6501371wmo.16.2024.05.03.11.18.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 11:18:16 -0700 (PDT)
Message-ID: <d97b250e-0140-429f-81cc-357537c2a212@linaro.org>
Date: Fri, 3 May 2024 20:18:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] target/sparc: vis fixes
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20240502165528.244004-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240502165528.244004-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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

On 2/5/24 18:55, Richard Henderson wrote:
> Split out from my vis4 patch set, with just the bug fixes.
> I've fixed the issue in patch 6, as noticed by Mark, but
> include the follow-up that cleans up all of the macros by
> removing them.
> 
> 
> r~
> 
> 
> Richard Henderson (7):
>    linux-user/sparc: Add more hwcap bits for sparc64
>    target/sparc: Fix FEXPAND
>    target/sparc: Fix FMUL8x16
>    target/sparc: Fix FMUL8x16A{U,L}
>    target/sparc: Fix FMULD8*X16
>    target/sparc: Fix FPMERGE
>    target/sparc: Split out do_ms16b

I'm wondering about the coverage here, since various patches
fix bugs since VIS intro in commit e9ebed4d41 from 2007, so
being broken for 17 years.

