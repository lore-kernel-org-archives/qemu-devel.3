Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B66C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 22:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYBSu-00018a-RP; Wed, 15 Jan 2025 17:02:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYBSr-000185-CP
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 17:02:17 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYBSp-0002EU-GX
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 17:02:17 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-436202dd730so1141255e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 14:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736978534; x=1737583334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gAlxvzE4wvmOkIoQzs3cuEsMrUpZ2bK/EPqKqWogwMQ=;
 b=XtEBMBYhJVXnX/Qx6XMOtDQnae5D3wyGc2wgnAhUxHPwfZQqgRs6USY0TAPRxBdeB/
 T39cH/S2/X8dKLiZmzOFlUBikN01nujcHBOUdwa3VXbTchw6Uaquay/T4lzwmhUjU2ZM
 +b3ZLZVr48WmJjADm7rpQq33cTKCG3XbCOx1HHCCi13BbRI6IDGzEUDj0EXs/QXgYed7
 BLM6H1oflRSwFQeaRnKVMohZSKsa6wNzXJxEdYG2qk0oXVHaIRKBO00AFKqhPC31MHd8
 zWwmqg91tdejhFieKj6xswYMPP+qy4WqAM7PA8qzg6Gz8sZLMFkCFpCnjxBUUWZqTmKw
 4oNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736978534; x=1737583334;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gAlxvzE4wvmOkIoQzs3cuEsMrUpZ2bK/EPqKqWogwMQ=;
 b=stvvxBrd57ITE95ENw197c6jNPL9x2Kz8HlrUBV25OmKc0o6dJmzsV8QbaqNWgUvQB
 sC1OaHm+JbF77oa0JEvG5qk/qj3KHsfZaJg8biqFSxrMkjuwkK/joRF3OfXn+56oaFnt
 WP2CBjWr5CSyPA4AxlwlnGMUDXBjiHbBfjATvkOd917/ssGkj8bor6y6i0dsiho1KIJh
 08ud63c7akAxVwdCpYfpd/BFv9xyg0756hFShtq7GDDNC2+tsUynurIQu0kbtP8xCfAP
 Tv+2gZRtfEtne5sGUdCMzxvvVCW4mync1hzLrxpFis4+4vae8r0+XoMhm4I2fJd6R745
 vPmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJLE0Ru/f3r7Q4X5peby65ewsBhDhXmU8GAM3vg/tAD6qMlcmz0ml3BVbyTeNbsUSBXmVhFhfTa70z@nongnu.org
X-Gm-Message-State: AOJu0Yz+sxSrawaCrSXTuh8hZWokXr7O1PQ3f7Xe3N5Khrf1cvEFlHnN
 Zf65gPmJpE2C3ST1KFZPYRjbGarlHtc1V10KtworCoA0P19TJKAr9j6ECtYrft8=
X-Gm-Gg: ASbGncvfFt5eeK3sNr3U2u5VgntV5huzy8u3mgjiVGdA19/cwme28237Aw+PGGXwvxb
 OX9BkLDsXn8pO9wdgYy6c5SUjeOHxzaUXJyQFCkH32dM3Z2kg04uX2j0PDiS+7zK1ixyu4x6M8z
 kzNfDcLQzc3csi/mfszRpc5qnnzGHiOQDh5fAjpR6VaGnwHBCt7BmfQqqA7Nv8CuHdpQh9/29/i
 P7+RcIiOiomq20+GWA4nKYtl9HAEuzeiKpR0x02b05KLVPshbaB9MGMpSy+BH1Uqf8zikaeAxn/
 UntKr6VmeFW7MEE/to39Slzg
X-Google-Smtp-Source: AGHT+IEqF04eey01tc1X7383cKHKxdJxsm8GxWUm9YPxJnfojooybnziNfqR+79xzvCAAlpkoLxcgw==
X-Received: by 2002:a05:600c:4449:b0:435:192:63ca with SMTP id
 5b1f17b1804b1-436e26f481dmr153918525e9.21.1736978533679; 
 Wed, 15 Jan 2025 14:02:13 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38b15d3c7a5sm12363013f8f.32.2025.01.15.14.02.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 14:02:13 -0800 (PST)
Message-ID: <9933f8dd-718e-4369-9df5-5e50a09050d8@linaro.org>
Date: Wed, 15 Jan 2025 23:02:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 32/81] tcg/mips: Expand bswap unconditionally
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-33-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-33-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> While only mips32r2 has explicit instructions for bswap,
> we have built subroutines for bswap for use by qemu_ld/st.
> There's no reason not to expose those subroutines for
> general purpose use.

Something in the line of this sound simpler to understand to me:
"We always provide bswap subroutines, whether they are optimized
using mips32r2 when available or not."

> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/mips/tcg-target-has.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


