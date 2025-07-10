Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDB0C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 18:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZw6s-0008Ib-UJ; Thu, 10 Jul 2025 14:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZvVK-0000qi-Dm
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:56:22 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZvVH-0005gc-Pa
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:56:17 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-72c14138668so482712a34.2
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 10:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752170172; x=1752774972; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ac7NR0gN8eVK5JIn7wji7UD4+0giUiNtlrhy6lYn/CI=;
 b=fAx2c41lzsms/N4gYcgK/YwvoqiJAazHIGM+zTOsqfDaboSIEIm017JU3NAhsLjAWm
 CBqPas7fOPc0Y65/1ek13eB0kpSBIKGLCgP5zJROhPUOU4+9KSpYIKunI0F994redSB4
 Epo8UizltJf0AxWpqS6WuopfUo9JWmpnZwBerX/MthGiZZt+qiz9yKwKm7Xpnr/Aif7o
 a9o7sgYma5RsX8bPpXZaVrJzqUDlNzk83yNP4ysmnI5zmH8SMb4SL1AGR89ZvDcDcSVN
 sISHxJ1xJjqSJpCsVEvIlDVaW4MGOmnzR1aFEahm1N5lPLu1r3SVIQATSTVZywMoZYv7
 VOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752170172; x=1752774972;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ac7NR0gN8eVK5JIn7wji7UD4+0giUiNtlrhy6lYn/CI=;
 b=Lxwin8ONvUhmSJ8Uv6bWODPQp0uHPbNKrzi8DxFMulJ0okhQSgOFH9TBwA3UG+PtzZ
 hmPeaDsZoww8advKqsbxB6rEP/Pg0MuF8zFWSjiv7sVoMoi2QyttsJPDPEiyKGWQGUQf
 acVv6KD8yOMkK+wXgBHOFBA4S12l8ByH7yYzPY2V0CnuXYnoqmmKrVbRoQn/q+c8n7YL
 bwqPKyayYLenQCqE+zAuPVJUcfa5O/6SYbKe4ykiDqhu2MhClgqlo9Y40+bCHdaP+Ak4
 qOUEFPI0tI+a2AR5gED1KcVahjVPQjy8Nc86uPU2PgvgDXXCpPWi3U5qVLHffBZZ/N9s
 Nm+g==
X-Gm-Message-State: AOJu0YwbPoy18xxhLaBmkuZhf0f3SiLSpuLB3jL+4eGrxZPYXNtnHEf/
 IzGLNnHxjLFQARG8h8uwHuaXSs0W13/EpMq6MQFhoLrCkaP4zG+PjW5O8IDpbaLpMHKCbhW/hXD
 E8cvt+0c=
X-Gm-Gg: ASbGnctnYuQKbZSfaCwbLwfT9iC2izE201Jjf/Hvq3b+mWR8fL19DMsL6dcGsz+k549
 VXg4/tc0dNWMb/168jSjS/amvwmwTSlc0hu8Q8zxUadeZzUisezJGw3F4WRi/mCTizMWxljUvCD
 X10A46JfbNKx9FfR4KZcDu5GA4Sl9gSivCy5yKn4FgfcAfImo5GfaGx7Mn476rNG2/wkkBTXTF6
 AzS8SUXIDxLCOMTxGpP8+KArlIddao6AY8EValUU4UZd8OtSXKzKQZ5J+TAJUeXJr0c1dkWb/Wm
 ErHdp0PSRapnw/1WkEabXP1kjAGMcKouX+VUF4mXQkg+lZeLu8UhL2AKO+ccLGScg6/lPRgEWJS
 Flqs=
X-Google-Smtp-Source: AGHT+IGFOxPuPb3691fxVABbXV7t7/7zcvHG+2cKbN5jpipvZLNTgGYBQhovV8Gez9lDB6MKjY4jaQ==
X-Received: by 2002:a05:6830:2d86:b0:72b:9196:c15c with SMTP id
 46e09a7af769-73cf9dd76e9mr304274a34.6.1752170172422; 
 Thu, 10 Jul 2025 10:56:12 -0700 (PDT)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf1272561sm280508a34.33.2025.07.10.10.56.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 10:56:11 -0700 (PDT)
Message-ID: <f6973332-2329-47d2-88dd-79a6956f7201@linaro.org>
Date: Thu, 10 Jul 2025 11:56:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Check for EFAULT failure in nanosleep
To: qemu-devel@nongnu.org
References: <20250710164355.1296648-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250710164355.1296648-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

On 7/10/25 10:43, Peter Maydell wrote:
> target_to_host_timespec() returns an error if the memory the guest
> passed us isn't actually readable.  We check for this everywhere
> except the callsite in the TARGET_NR_nanosleep case, so this mistake
> was caught by a Coverity heuristic.
> 
> Add the missing error checks to the calls that convert between the
> host and target timespec structs.
> 
> Coverity: CID 1507104
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Tested via the LTP nanosleep tests, but they don't actually exercise
> the EFAULT codepaths...
> 
>   linux-user/syscall.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)

Queued, thanks.

r~

