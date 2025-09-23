Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6764CCAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 12:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v11zu-0004rA-Ck; Tue, 23 Sep 2025 08:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v11zi-0004nx-Cf
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 08:19:46 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v11zQ-0006fG-RI
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 08:19:39 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3ee12a63af1so2437448f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 05:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758629953; x=1759234753; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mtUtxOYte546DTIBwSJ4GxuCOojA4ezq+akkecOlHyY=;
 b=T9rREt0KtwXkjJnbQss4trBYBbiVVVyHyDaL5gGLUJGa1AtvEoSFyCaEwwNznA8Pbj
 wP4X37eEx12NbzinUG9WTi6G1qFDGii0wqamso/pluqLlCLZ3v36PB5GPYi7M+HrwDAk
 7c0P/ZBHVFZJFz6h3IaNZBYWtEiqLdagqp2zEdFvuhXSSFgxVl215etzeZsD+DKn3WpX
 JOH1n6GaV/c6MnBCFcr3vYUqsx1uPi4QN8QbH3k2PtzQsyPJN2gtEcWdzoU4pEZij3J5
 Nuy6IHSK3yRnAUcCtGLhlR0v7dDygnBEWS+X/Sd/hZ1XinSg6FoeML4wANEx4rfGAJaB
 6Cig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758629953; x=1759234753;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mtUtxOYte546DTIBwSJ4GxuCOojA4ezq+akkecOlHyY=;
 b=rCiKDWMw4cz6sP2U30yJNopsHXL2ekjPRMev0uOQiyWFrtCjiYE6R4M5yXw26c3PsP
 vDExlMWH+z+Y4tZUxeOHQQpVAE/Zc/d7VcrdB0dATMha/9+Sssyo4oS453eLSro1DxCh
 wEJGuMDhmO8lFHhDcxepJB9EYGFbOksD5JulP8wPGynmaP2q1RsppdgOaXUNZs1FhnZn
 alNXbYL6JJXibOcKC1+JK/fTLuMukhIJGZDNT1BgAV62hfyB7T+z3s/bMHHKBlfqJvIl
 GPUTPOTsJNbAtVjIXS+EDEaUBK+CH1QGvDaEEZsUzWWsUuq46gxIkGoaOZNLbojEuSzB
 H1bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWdlJoetdTdS/gHyzsBthkVAdtFuz50CBRo32l/buEYIHNmrx47Scn8gcDP3asb9YIVoqij5sKhUK8@nongnu.org
X-Gm-Message-State: AOJu0YyQJG5C1jgT29Nt6kNHfCH9AGvhpUtJXgV0CrZ8+SaRQ9q5S+rh
 DVhIk5QhAKubP7b8sV/ah5Mx22yCpCueKdumy28yoFxv330139U4xR7A2MJFpNk7hwRrDgZq5hO
 Ok3nZ38r/JQ==
X-Gm-Gg: ASbGncuUuTzwCUT94x3hBVms9Y1w4qjEtnSf0PrKZOPnM7ghsyUuOAgTFdtKoK72+fq
 zJZ25uITmGyrPKdmzWgtesTCsHl6cabCt11TH9DM9Jgcz0Jx0R4axb0RNTS77xIJHnoSsxSRqpt
 GoLjTL3Y0lBPj1GITvx9TsMEzOOXQt0OWAp1t3AtjqNDndQ9YUtQiNq7E0g5q2bWj/amo/NXKaJ
 46GGDNEkMMTt9ua2UH/hU6EHSERjmEHlikrquqpaTxzH6Es74LL9Gdv60Jr9ISfnwMSdvd7b9N0
 y3W9xof+K8ESR077ESY6w3wJZPCv2Arr8H5Kl0uV+WhIaMrmhtGfX+/T/GypW/Mr0zCQeCX8FK+
 iy0H5vF+X2Mki1veFfQKyCjDN7frl3GG7h2KVvoolMxYiqpsEt8JNjiNUo6LSbHKm3A==
X-Google-Smtp-Source: AGHT+IEV805tL9JEr5LGyZjVLPqHZMTuLQmT65L5nc8vRarrS/nVjqBNQE98wqBfps+IS3k5meyooQ==
X-Received: by 2002:a05:6000:200b:b0:3ea:6680:8fa0 with SMTP id
 ffacd0b85a97d-405c5bd8627mr2011290f8f.14.1758629953138; 
 Tue, 23 Sep 2025 05:19:13 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46dea20f833sm72665415e9.10.2025.09.23.05.19.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 05:19:12 -0700 (PDT)
Message-ID: <8c99f4b6-3ce1-414c-92fe-6e2118599550@linaro.org>
Date: Tue, 23 Sep 2025 14:19:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/specs/spdm.rst: Fix typo in x86_64 architecture name
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20250923120118.858581-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250923120118.858581-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 23/9/25 14:01, Peter Maydell wrote:
> The spdm.rst docs call the 64-bit x86 architecture "x64-64".
> This is a typo; correct it to our canonical name for the
> architecture, "x86_64".
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   docs/specs/spdm.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


