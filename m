Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39E7C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 15:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhX4u-0000uC-8E; Tue, 05 Mar 2024 10:51:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhX4r-0000nk-3u
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:51:37 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhX4p-0007Pf-59
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:51:36 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6e4e608a374so1094778a34.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 07:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709653893; x=1710258693; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HUlAyjbs1PTV+vCUlXu3i4GjbGicSto1B6ION0v3BZo=;
 b=MdRvQu7A1r7hxgexbsyF2P5uw7UfJAmTWY20y3sLbtAsM5F0V0yCSOjCInFD7oxnwq
 01dJ5d6tc9zQqy37jFegL0MKkJ3qpU6EYFLC5nArAmS+teMR7dp7mg0m0ZoNMP6eZSFO
 ZnIwv5jyVl2Y5H+eJ7O3a+6MdM0OIfo+CQfbbqfFSQccM9Atq88YcHeZw2PRuyiL3152
 rxcndPJQwydvmu4aReHmwMsky+92aK68q2tiBtJaI19FC7rAcFyOa+ZZw1oKlDaxGKB1
 R7gEB77NvpcQqQpOLYIQAwe/Eezz06MhACqUQNQQCOzAKrwMAG5bJiQvcFClf1OW3muR
 jN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709653893; x=1710258693;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HUlAyjbs1PTV+vCUlXu3i4GjbGicSto1B6ION0v3BZo=;
 b=HTGheTaurNx/cqNRXozIdVYivRyq4epZfNmWbRbMmsHFZ+Cigg5WkDrpDRs/NuXCOB
 ccgUCcMVMGP+i5bdJAaxDYcnFZ04x04owc402xGFuhQKXYlqfzGQjMgwpxOZkSEgl06J
 LTf3BRZlfMAS5Scg3XjcQUYpsVTd9QKP6jUMd5a/AqtA0gXtkSYoxVz8xkRWxpTbS7Vo
 ikVN1lEaz1tlcOrbPgA7RFsBqk6+4Pc5Ly70V6JCKU5t/o0uebKWGwC5xSPJvbsDVaaA
 5EK5+kYbZeMVNxnPUTJpCxEqCAyZiSsNDKLA5e8PjD0NmKP8FADo8OTJI75SKJYSKzVp
 WqsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlDwbKegrIqJtPW47OPPB5THBwaODDHRkJ0DPZVJ/b+cU4lc/wBQwM1bwRy/1qHpxzzasll0K3nDj8yv8iTY3sHrcDTrs=
X-Gm-Message-State: AOJu0YxLJvl0teITJ5q03E5BQuGPAQwuymzr//AAbU28LL35FhKyYkzk
 lzYM83NNSqwOedJyeyiAT9v5r1x59nRnVWwdrqnUCSL4TxZ1j2H2HsQDbRBffes=
X-Google-Smtp-Source: AGHT+IHRHZkQ4IvZYLFMf3SYHF8rnXKm7BoWaYEOTNxnyVR6KJSpHcENQlCk5V2QkCA2lhqEnLyrrA==
X-Received: by 2002:a05:6830:1002:b0:6e4:f67f:9d46 with SMTP id
 a2-20020a056830100200b006e4f67f9d46mr2167797otp.31.1709653893146; 
 Tue, 05 Mar 2024 07:51:33 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 b22-20020a63cf56000000b005dc884e9f5bsm9470022pgj.38.2024.03.05.07.51.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 07:51:32 -0800 (PST)
Message-ID: <cdd286d6-2986-4c2c-8785-dc311b71e4fd@linaro.org>
Date: Tue, 5 Mar 2024 05:51:28 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Fix 32-bit SMOPA
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-stable@nongnu.org
References: <20240305023116.234256-1-richard.henderson@linaro.org>
 <fa8f1d52-f88d-4107-abfa-fa10ebef511c@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <fa8f1d52-f88d-4107-abfa-fa10ebef511c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/4/24 23:19, Philippe Mathieu-Daudé wrote:
>> +        uint32_t *za_row = &za[H4(tile_vslice_index(row))];
>> +        uint32_t n = zn[H4(row)];
>> +
>> +        for (col = 0; col < oprsz; ++col) {
>> +            uint8_t pb = pm[H1(col >> 1)] >> ((col & 1) * 4);
>> +            uint32_t *a = &za_row[col];
> 
> Shouldn't this be:
> 
>                uint32_t *a = &za_row[H4(col)];
> 
> to work on big endian hosts?

Oof.  Yes, the H4 adjustment belongs here, not on za_row above.


r~

