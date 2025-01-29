Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86669C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 17:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdBx4-0007EH-Jg; Wed, 29 Jan 2025 12:34:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdBx3-0007E9-J3
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:34:09 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdBx2-0001zw-1v
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:34:09 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so80335215e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 09:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738172046; x=1738776846; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GLsSQSYNJvg6zJy8l6tEDsiVEOcAhL4bDwom7GwGAuk=;
 b=BYa+KQWruLY9rMUxqtSfSuFK8aarVk9E8rCxtD0r2EhrAqKVMsCXQLcL8UGj7gEHmU
 uFM7WEeaRrtfSSLJhGtUcrfk0brLuFrznc3ZTDBn7/ESdu45RDLcjrgBCK4kDFzG8a5z
 Iqz21UunkztnOAzOpRuh+FvTFOZunqjXAEasuDMfgJzqhXNW1TznLNmnGxa2UJWwj/Ak
 zwo4i79N0r534c7qMlU6ZzZqVdkYo8mcyeovHfzWlJDtqlHNqvQUUNm/TRydOKrC2pxI
 g48tbNqKH156gumIwTVuE8g6+nyZ5PVJ5TtS2DuDVBkOTwueXC9DTpqF2eEv2oL8X8J3
 DKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738172046; x=1738776846;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GLsSQSYNJvg6zJy8l6tEDsiVEOcAhL4bDwom7GwGAuk=;
 b=mzEuQE//LbCM2DmEwXQEcFkQ0nBBz66vc/mUV1ZeVo/j7LbMmOk0QAiISs5tq+STRV
 wk846uTRe37NAkLGnyTlq/yXf3tvI+agpoDdN6mdBF9DcnGyOeOBzngSnBEXxR9jHnLR
 P/19Xtj2xnl+Ht9rkmGWIeZmmB/SWnE2+RBNyR7epVUw0njhWVgijFkjVViKH/MXykmU
 AzQdcXoKrAiIoRIKtTb7nFQQjhEUhd6VabpkKO7F6VRhbAQjGREnrG+PDN1DZpPuZX3H
 1Ys3oucIVAsPGr/yn5IWI7/xPB+cJXVtALJTXJXDCt2Agaze1uuH6c6NWm2dMVAsCqTF
 l09w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu0dC0hoCavPd8Ezdaf/zxBQ5mHw610aSOZqZIQPyZkhrDfDcwTLiHq3kLAEs8aRHL3cmm/dDLYZ0M@nongnu.org
X-Gm-Message-State: AOJu0YzUcQZ6lCk1NmQQ/JAgaD5mF1r6+VxFvjVM1xjRdGEiR9X5gLEa
 XXq5ObMAgfnRZj6EwOxndGSwFjwQKDhXRbOZttUBOBr1AEJDapvgC3OkeMLXSKw=
X-Gm-Gg: ASbGncv1OVSYSA8T1lcg1k11JjxdGUMYg0Sxlcih6iA0REBr9gmCyG9PRaxDyDzVdJ6
 EYUmDCGYMqJp/x07uT9HquR1ZnT0xM4SDFcWYw0Bp8kIPduDuE5r2Tv4W33m6C0t8R2IH1r0OM7
 LbBIMp6gifWqSxDIBUuZkYwhPda8BGuJybH6FAYyBNNfJCWAxTATmvLDp0LTA7pT+zlo/DWYNbE
 irnmXkJ2G5POjl7Na2tiUtb/4LzfkmTSN8I5btDNg1xoxjnHtf0kEggGGG0JEGXOqOdmA1X8Tln
 38/7HEbOgPeZigArFUiwFJphZVk6OsVjs0Sda3+CE+ADyx1wv4roHB7m4kY=
X-Google-Smtp-Source: AGHT+IG1yk6NWJ+Un0DOqQNgOgAiD2yCT+kMbLq1WU4n++y7fmP3wQdflFT7ltrORz27vKo53WzkQA==
X-Received: by 2002:a05:600c:3d05:b0:436:18d0:aa6e with SMTP id
 5b1f17b1804b1-438dc3ab518mr45267615e9.5.1738172045704; 
 Wed, 29 Jan 2025 09:34:05 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc26cefsm29654945e9.13.2025.01.29.09.34.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 09:34:05 -0800 (PST)
Message-ID: <2ef35c2c-e196-4c44-89d3-e26ec24129fb@linaro.org>
Date: Wed, 29 Jan 2025 18:34:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/34] target/arm: Introduce CPUARMState.vfp.fp_status[]
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20250129013857.135256-1-richard.henderson@linaro.org>
 <20250129013857.135256-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250129013857.135256-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 29/1/25 02:38, Richard Henderson wrote:
> Move ARMFPStatusFlavour to cpu.h with which to index
> this array.  For now, place the array in an anonymous
> union with the existing structures.  Adjust the order
> of the existing structures to match the enum.
> 
> Simplify fpstatus_ptr() using the new array.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h           | 119 +++++++++++++++++++++----------------
>   target/arm/tcg/translate.h |  64 +-------------------
>   2 files changed, 70 insertions(+), 113 deletions(-)

Nice.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


