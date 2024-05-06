Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88506C25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 22:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s46yl-0005ON-FA; Mon, 06 May 2024 18:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s46yj-0005Nw-RX
 for qemu-devel@nongnu.org; Mon, 06 May 2024 18:38:37 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s46yi-0000XV-8d
 for qemu-devel@nongnu.org; Mon, 06 May 2024 18:38:37 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2e3b1b6e9ddso16599321fa.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 15:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715035114; x=1715639914; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SC/qAlyxjg8JK8IgWA4GSnyQguXiKkEdt3S7NFpbIVQ=;
 b=c+kJrQP0Lnl+OfChuYjMnLX7f+ukNFSDfF99aBkQ8KgPxMQGb+lOYeOTaVLkd5h/ZN
 A9vs4kStF+uoGzd68+WAWNQ3QcFOHDIv7dygKMCgB0dntOaVxAm9bIejcSI52lzKdP3d
 JLZ46KW3LilVrPhs0n4mr3DcdRwcyzsXZXlwOZMpoiCBgvs9wofMA6vdSahwwAqGl5Dk
 Fwf8rH5iH+BsGJo+p2lh0W+LHrRAjCjV6FtmfIXm536dtJmmw2aVCtbXK5wvLQvg80/z
 j7aPlEvrHIsW4mG3+9c+9Alp0ILUAiRnsniaDeLERiBktGrZzkHLfhMhaG8rrMPfDWsF
 Y//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715035114; x=1715639914;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SC/qAlyxjg8JK8IgWA4GSnyQguXiKkEdt3S7NFpbIVQ=;
 b=kr3QzXuT64GsDn5Lu81fJ9Iu4Ff8hXaI7aVadUoXmHBvL0jq5sv28jDBSrVLD6a5xO
 4szRtzAznScAJJeyfvC59GBHRtv+pqxbnqDB3VKDeUdoyi/tMyBQLxNZ1yDLhTVEDohT
 XenJFx1CtG5N/rYv0ncaRhdc+V/4Qf4M3em6FACFp4P817D0BEIZr2ZB/WXMec6T41AS
 sHMQun0a5PjnCHjcpDB9sHUFcbdaVEve0bKjH7G6ySTL+znAd2SkpafjoyUUtQlgHmC1
 xpXREKCthz5BaHpfz6tHMUefVjT+PehfJc35JiZ75dXcBB1kcXmJHbVYnTh3AgnaC9Zt
 nmJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLnz5ygrb4cbrSMDDhzeHhAWomTqxPqDRlI1Y8Y9+1fbsqMJ41pL31BI8YXyH3RVgI3YrHMAvNw67KG6HR0kRF55pU/jw=
X-Gm-Message-State: AOJu0YzSI9xLJuccSYgmo+4mILbL8h1c3tP3ijbwu0/drbdTnKfrDIhz
 8xaeXYUN8YtiP3L7SK5XKMyKoLH7xbwfFFEetQHOoVXGSyj9Epz4BL8vfBjn75HfBFVd5tQEU1m
 0
X-Google-Smtp-Source: AGHT+IEHLFwKh08nc+8tS8RTg7bFdjsGvJHx7dVRCKGzCHYGixUHujvd589HGNEyFulNRgqVnfErFg==
X-Received: by 2002:a2e:7314:0:b0:2e0:298d:65ec with SMTP id
 o20-20020a2e7314000000b002e0298d65ecmr7764447ljc.17.1715035114009; 
 Mon, 06 May 2024 15:38:34 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 x8-20020a2e8808000000b002da968f03f9sm1717120ljh.89.2024.05.06.15.38.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 15:38:33 -0700 (PDT)
Message-ID: <2ff08074-c532-4774-bf92-e6eefe7f00db@linaro.org>
Date: Tue, 7 May 2024 00:38:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/33] plugins: Merge alloc_tcg_plugin_context into
 plugin_gen_tb_start
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424233131.988727-1-richard.henderson@linaro.org>
 <20240424233131.988727-16-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424233131.988727-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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

On 25/4/24 01:31, Richard Henderson wrote:
> We don't need to allocate plugin context at startup,
> we can wait until we actually use it.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/plugin-gen.c | 36 ++++++++++++++++++++----------------
>   tcg/tcg.c              | 11 -----------
>   2 files changed, 20 insertions(+), 27 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


