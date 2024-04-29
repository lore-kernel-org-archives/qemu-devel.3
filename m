Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACD2C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 10:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1OcR-0007ht-5Z; Mon, 29 Apr 2024 06:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1OcP-0007gw-5g
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:52:21 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1OcL-0005KG-Kc
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:52:20 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41a72f3a20dso30312805e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 03:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714387936; x=1714992736; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iLuvAIFW8quA6QsLfrhr0POEUuzRAB3pAGqmS+tza40=;
 b=xgCyeS2qQ0PoHINztdJrFdXIzJbWy1zObps9KxTAPoUNCsdjPAOOhz3HZDR6Of3YiD
 GLLvsJFFneedw3/BpSyXME4DKo+7jPz3HcDgwEBbOhV9kI0R9EH1n8LeJq8uj8o2u9sv
 uYc78fVX/e2OrOVXRjDGFhyjawAyzAoLjr3DoWo60WOK6xGFp9n3mdHKo5Y9vKQRPNmG
 Biih1yUVrI2AOaSEW1wFbRjBII/szQY7OKwNJpny74uDfaAo/83nnIneTZw4WkJDFT7t
 jhaG7K9MSHuCJqXrZM0LqcY181nN8ZukvBawZsFhn88ooFvBy1f5OSrXOggVGHn6wvEZ
 yg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714387936; x=1714992736;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iLuvAIFW8quA6QsLfrhr0POEUuzRAB3pAGqmS+tza40=;
 b=eeel05/6xvsfMLdmVn8LEd9iHbjBi+j+gyGBmWbEwNw1Ej2jmdNtjEzzOjDl+kyhXW
 PPT9/SLJ4FTZL+rX8YjSG7BaSacJB3ZM0jOdaAWtgR5EkUi0Iv4gm+RnqucjaySadm6U
 Qd4pMWB71XwhaYrbo/9ueSijSGJNPxDWER1jegxS9JATC6VDX0iTreLD36O5s38xPUaT
 AzxllOxPO+GOLFJA5b8WXMsrzytLHanHo4rz4lWjU+tgUSTu/MIIu1dKpcZ+kkwbJRxg
 zqJpguSqDXD9U5SM9x++uby6A4SPYQoMjf2YGc6G5nP6BzBEAqOcZzINBv76LYdvzxcK
 ADCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfUntDny5R++QGkl5A1uI0WQB1vtZwEXRvrFEd7YnEbLLc9enyK5XHij8BlA1oS5oxQ34Oy6YQz6FOIRAU/Ysr7N/O0V4=
X-Gm-Message-State: AOJu0YypJ1etrIi3U12PIpsssi4noe/oeWLCzmhstQyngCE4VU5OZ/6w
 qwn6tAvle8N6OrnN/DXynntIlyN4MfeP3LvQgVcQrSoxEDACmQTjkz68NNC4XH8Kh/+2j6rnCHa
 HJo8=
X-Google-Smtp-Source: AGHT+IEo6Ci1S9mTUGcVB7JM8vjiQZS3M8F1pS/wUEmkitmM9+AL5JoqRBMXkZ7STeDy2gKxBbUYig==
X-Received: by 2002:a05:600c:1554:b0:418:dd73:b0a1 with SMTP id
 f20-20020a05600c155400b00418dd73b0a1mr8268911wmg.39.1714387935893; 
 Mon, 29 Apr 2024 03:52:15 -0700 (PDT)
Received: from [10.79.37.248] ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 b16-20020a05600c4e1000b0041bbec72670sm9926790wmq.39.2024.04.29.03.52.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 03:52:15 -0700 (PDT)
Message-ID: <b900ad68-03b8-41d4-9cfc-340f37d8f5e1@linaro.org>
Date: Mon, 29 Apr 2024 12:52:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/33] accel/tcg: Improve disassembly for target and
 plugin
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424233131.988727-1-richard.henderson@linaro.org>
Content-Language: en-US
Cc: qemu-s390x <qemu-s390x@nongnu.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 25/4/24 01:30, Richard Henderson wrote:
> Based-on: 20240424230224.941028-1-richard.henderson@linaro.org
> ("[PATCH v3 00/20] Rewrite plugin code generation")

Cc'ing qemu-s390x@ for these 3 patches:

> Richard Henderson (32):

>    target/s390x: Fix translator_fake_ld length
>    target/s390x: Disassemble EXECUTEd instructions

>    target/s390x: Use translator_lduw in get_next_pc

(could be reviewed out of the series context IMO).

Thanks,

Phil.

