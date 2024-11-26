Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF39AD3B98F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 14:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFwDy-0006fB-Np; Tue, 26 Nov 2024 09:07:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFwDf-0006Xr-Dk
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:07:13 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFwDb-0006kp-MV
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:07:11 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3ea5a7a5e48so424303b6e.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 06:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732630021; x=1733234821; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xcryzYJuSJxBgPfjrWgLsT+ux1El2hGVWKizBrK9DI0=;
 b=TSJwPCBvRwoztjwAKUyRkOzwpGOG7xuE2hFxtdvOlSr+bpPtt9RJgUtSIihI6c87TH
 XY/TrLzWSOQ2YkP00q6GCJ38IEVFd8fmqO2yCeLGG1n5OjeuF/9HTavLsW5kI+shTEsz
 XmFzfJ0ehGyTf8SYbM+XkLzMs4+dw/pdtMcbuR7Sy8i6gqsPEs/xJzk/6vjD0h4VV4kC
 Iqi4uGx3AVBM4VODw9Oas05fQS0OA1yUarB1sN617k3lzNrU+xpc7zxUc+2qlWv0hkRX
 ZaA/N302mZYKAhJgszZHWxRGky+MVmehVvipaQdRXLH/Cu+fzkVnzKKGidpyRST4tBEn
 SQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732630021; x=1733234821;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xcryzYJuSJxBgPfjrWgLsT+ux1El2hGVWKizBrK9DI0=;
 b=YBxZgvc8BsT9pT3Zu0o+A0yvkREySRsKxpr0FWzXZKcSurGdinLxS0LA84Uq+lPbPL
 b1O1NDQqH+JvaZ8OhB5jZRpIi2zqzmqTNhdJdUFmtSAdVWVvtoBhSyhZJ8Xqf3gkds8p
 rnibTn80pkn/v4TASVd6zCABkKc2H0w6KhuuBwzvwzLCnuY9pfglm+rN6aRYp8E1WezT
 81UpsAk6ZzoUvGHItZXNlbejakGiR6+W07ozD/rZGpk5dSKQ+taqsfUNRG6rrawv6yI5
 JH7POvDHCTZ1HI3yMR2CJxfi6UTHQ5IGKEIu4YTM9YBlVZ+0MTtVGasRtQvc4GNxsab2
 2L8g==
X-Gm-Message-State: AOJu0YzSuAoG64QA4wVAf9NBAHXqFpCa5zni5x/ROO3XoUq1qx+upHRC
 rMBXx+6/N2ZIxM1yMpAcTP6ocTRbvEXdJUlLROlonpsbJBBogOEUl6vpqYZLJgUa4KfCB9NIJJ+
 x
X-Gm-Gg: ASbGnct6+BwuqA7uQp3cyp5zaySXrTlox4gx00esJIPwK4FsXBgfvlKLWMLe44efeXv
 zUsQxj6Cu2UntYOC9dhJjkRIconf5kBX5J4zMLJBbrM1OMVgIhLj8qNyGfviIg+LkQ9hPWwK4P6
 ZTkGVTjgQpO8MM9m3mdY2Ui1MGsg/eZ40lLsPMwy5XrR5UXxoa45Hi7a4owWRSgvh49djHAqD/8
 VNtTPZ7nNJGE0bn2Mp2RtN7jJwNDt+1c4AXRSNFg1mEI30r/7I67w8aN1Qjj1GPzQ==
X-Google-Smtp-Source: AGHT+IFL8vo7VWMeR18/9bg1p2y0zFkHUhjLgriCQxyolSYRZ4hluS2zVgWB3Pdwqlhvua6tnZIsMQ==
X-Received: by 2002:a05:6808:18a0:b0:3e7:9f1f:b84a with SMTP id
 5614622812f47-3e9158770bcmr15642903b6e.21.1732630021007; 
 Tue, 26 Nov 2024 06:07:01 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e91500f91bsm2928224b6e.52.2024.11.26.06.06.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 06:07:00 -0800 (PST)
Message-ID: <d7988393-2cf5-4806-830f-9e6e60e72691@linaro.org>
Date: Tue, 26 Nov 2024 08:06:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] target/mips: Introduce gen_move_high32_i32()
To: qemu-devel@nongnu.org
References: <20241126131546.66145-1-philmd@linaro.org>
 <20241126131546.66145-11-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241126131546.66145-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

On 11/26/24 07:15, Philippe Mathieu-Daudé wrote:
> Similarly to the gen_move_high32_tl() helper which sign-extract
> the 32-higher bits of a target-wide TCG register, add a helper
> to sign-extract from 32-bit TCG registers.

Similarly wrt "sign-extract" and "from".

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

