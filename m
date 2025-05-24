Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2498C54FC6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 12:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIoR1-0003SB-FA; Sat, 24 May 2025 08:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIoQt-0003N9-5z
 for qemu-devel@nongnu.org; Sat, 24 May 2025 08:57:01 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIoQp-0004JE-B9
 for qemu-devel@nongnu.org; Sat, 24 May 2025 08:56:57 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-441ab63a415so7756385e9.3
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 05:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748091412; x=1748696212; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rWICcmQInSwMPM6QRaPvZ9hJQo3lL+FVTyCiwmu5m4o=;
 b=x4SOKOjj2MfwJIbs6EeBaOyDzrmZ+PeSJbL3orPNBl0wcpZHyEl2VxE7SVocBDc7j6
 WPoXenJ1YnRBUSdeKJPfKmcZ+ThI8WcEWiuUajbhU8hAV+/uOeqJaHwuua9mLBd9UQsX
 HyfRuA/VpFj3zc0jgWObKCBzEFRycGTuzdEAVZW/uR+27YuPTdaY6xL3cfdLkVpfMe4x
 1DjAqEf157fx2FohasJWeVqwDh6CoFefnUbWQsnkNL3cQI1Hg9Ohl0rTUS7ELMj9Ecx/
 hHiaFWmvH3Eill2nQ2EdCLd+saxXqFBU5i7MPqIM3G6XoCn+9/xWzh76VAs5aaHJ1f1k
 MD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748091412; x=1748696212;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rWICcmQInSwMPM6QRaPvZ9hJQo3lL+FVTyCiwmu5m4o=;
 b=kBZL2KhUaqCeiP3u7uIhZYUvs53/x1WWhr70eFTjbKqTKvoqLoYHj9hwU/Br+o3TJQ
 SizBqYiBBjjQnNdID7jkSvrdCHIiHOkTZPQE+xEmNec1bv+0x4al9r88kIGaVhmX7F2l
 iGi3qo/L/Izs65HtQunSrsf1OeXaclT+dMDnDq9QpcOL6/DgJmtluh1YL5QO13k0BQwl
 HJyDvG32Ue2BnAqyi3AQUecGBcGIKa1qnbMBtJuivVNZ3Hc457HIHt3g5xk2Rlqdsgso
 hUdG7Ek5o4Tc4vC5cJ1yxBqPTxp7h8lYdrJl1vhYdoiN2B4vJlRnzZo8l+Mq9ReTDTYR
 s8qw==
X-Gm-Message-State: AOJu0YylUIi4HYVUzVkulab9PUeJnDr/uq3NPtv3kvFPseN4AhpF3fBc
 WC6IF9xAOrQE2u5NbIQT9rzCkwoM/dFgJcyAtkzceEMvBk7Obt4Es4F/3H0n8mV2RvU8kJyYbk7
 MB1CwXniHTw==
X-Gm-Gg: ASbGncs6dNWCHyzThIEMB0EhG70v60ZDdDvGRBzERdXOMI+0bXNm6vKEaeadG230dY7
 gQZl7D8xsfeqqHnz5Go7W8L3VGExppBQux4XttxfWrxpoyqC+zbJbm6KQEexVtmNRRhk0T3ziOD
 hecQpSCg6qzmgh8ytZMlup89gw/mpVpMCGb3ZU2RLk6pivJh4o6dfdllb7QT1WVAL1dVJ5EIE+k
 sp8S3zn5dLJm88i5NE2UZQHYvOBRr9iyC/j/1XSRI+erH7hzq+6Ib0HKB594WNpa5bkkhKAQT4c
 cfXktylaXnqVG56BSNnM9bxd79cDCSLBfaiP21ZqTYWJbZvIOJtvbnhrmtDktFE9Ow==
X-Google-Smtp-Source: AGHT+IH6X7DyceYw6nnSQfbXTGoijMHHwPDQX2EtZtr/mIfvqVDMExIFYZD1cEFy0BpR42LkRYbdJw==
X-Received: by 2002:a05:6000:4028:b0:3a1:f68c:3b63 with SMTP id
 ffacd0b85a97d-3a4cb428e82mr2221029f8f.5.1748091412552; 
 Sat, 24 May 2025 05:56:52 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4c90624cfsm3214293f8f.62.2025.05.24.05.56.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 May 2025 05:56:52 -0700 (PDT)
Message-ID: <792d2099-ee22-4ceb-a481-919e59512515@linaro.org>
Date: Sat, 24 May 2025 13:56:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/microblaze: Remove the big-endian variants of
 ml605 and xlnx-zynqmp-pmu
To: qemu-devel@nongnu.org
References: <20250515132019.569365-1-thuth@redhat.com>
 <20250515132019.569365-4-thuth@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250515132019.569365-4-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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

On 5/15/25 14:20, Thomas Huth wrote:
> From: Thomas Huth<thuth@redhat.com>
> 
> Both machines were added with little-endian in mind only (the
> "endianness" CPU property was hard-wired to "true", see commits
> 133d23b3ad1 and a88bbb006a52), so the variants that showed up
> on the big endian target likely never worked. We deprecated these
> non-working machine variants two releases ago, and so far nobody
> complained, so it should be fine now to disable them. Hard-wire
> the machines to little endian now.
> 
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   docs/about/deprecated.rst           |  6 ------
>   docs/about/removed-features.rst     |  9 +++++++++
>   hw/microblaze/petalogix_ml605_mmu.c | 15 ++++-----------
>   hw/microblaze/xlnx-zynqmp-pmu.c     |  7 +------
>   4 files changed, 14 insertions(+), 23 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

