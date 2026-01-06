Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DC6CE9D6B
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 15:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd9HC-00069I-Tx; Tue, 06 Jan 2026 10:47:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vd9HA-00067m-7o
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:47:17 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vd9H8-0004VW-Cv
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:47:15 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47bdbc90dcaso8255525e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 07:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767714432; x=1768319232; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=49iuoeP6dcp4KavIFa7uOcjR6lVcIjlWLJDteWP8fwA=;
 b=e7tsWOT+3RMr+LULbxmBgOa5ejg1v7v32MwocY3nk+oEJJFFixh8OF22hWn1JVxZif
 sRW8GxPISg96QHtq7Ysrfxayp1BNyYoAMaez4AAtmzd1oAjzEuJN7niJOHIlvFyderUf
 VFnM7L1Vgky9LG6jmOaUxGYKW1zvW0Q8OxRQ/FHG6rXO9ojmxBI8AJiMrXC38edqibKe
 8p+La0qOVe2fd6fFMRmGpEm2/TmcL+2XLV3WT6ToUJ5Ncl7Z+wDjURKl415V5l3CWK2/
 Muqn6N7Ak0IxwsONPKBJNl45S3fQCgr1tBTSY3NIJX5dSqUJKASdD8nohEqIOEr2rwYk
 nZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767714432; x=1768319232;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=49iuoeP6dcp4KavIFa7uOcjR6lVcIjlWLJDteWP8fwA=;
 b=rsPI4QgzIafFjkD73ue4IfOx3UHmBvYBsU3tXTG6M7DBv9W+XlIaWelLy1b7gCC7wB
 kkp8oARcXNizYpiLtUVm8SMANQ9oMwJvyU2KRRzJMvUb4wZTT111i1WZAj95gqgvUYVM
 F8Ti9if5XYXgqRzo/AVR2IlIn3L9i/8QwjqTc8XkdhrO9ZU0bXcb9jt0ueaWs6UqPe7G
 5iINAtXrDFx+u4kFAO2jqIR5PWlkTjfICCbSlNIZ3VRpshAklZxyZjSEZtH4WCEn+Mzj
 FoJOiFZ55yJ4/QntYxme4wUapsHzob3FEuT/RivJVCPlaU3UcedfUBTHQNQteVxXXNEv
 TSPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq17WpL5adGtBJcMG0S1WB59pnuSaAwcsmwqJIoRyYKdMaVt8OaJh8WYhMIq53XOLOaYlxqGFrxbKo@nongnu.org
X-Gm-Message-State: AOJu0YxUdNoNA5TRsKQFHNlSJ8yyFywKEzL3/ZVFDbDAETVfPZQJI42/
 vBBf5B2psE6fC1AcKHbPB3QDWJjXavEcswdg4zVQ2CLoI4mEkuKjeGKgDnH+zi5hEcM=
X-Gm-Gg: AY/fxX5hTn9TtBcRWi27ht8a8SVLYHrqc5dRpmScmk2ICsqZ1g52yJ4pkwNSJDJ2plZ
 tOq9S3O55J/ngh/DomP4mWdVyCIUQRz07MT53Yvs2I4Nr9EK+j8AMnTml2+hmPuTVByvk6D9krX
 kw6e5OL1L29xpeu2v/EFeuuSFuJ5Yi9NwJKtBfqsmaGUCYR+QfOAxnvMXqM1kc9X+UV7DPBQKe5
 L/4NRrOfKOlkdNKuqDkFmXRcE2W3Chgfs72MgCsNKXHVyqSo7XM1Ab6NOSWgbfxOWTQwhParMnl
 0MfHNcwu0jDBTGHF5b1NKl+KNhKdySiRzKZ6mdfbGX6B/UMt1KfpIUbv6PH/yYPy1YcZRWK2K1V
 ObGSb1Ms3OypWRtcFCfNjnoHicV4nRx2MrUuSVb4S4iMacoWYbZ4w6/DeRKNdFKJ978bbNDd49D
 TYHe5419G7ykt+8zIovs0ZgNbOmOFco0iaEmsmINvMmNysOcK2iyf5hA==
X-Google-Smtp-Source: AGHT+IFgkpNhgIX2wiHTUguehrhITnvL5SufwjHWC+j48gf8+czEumUvyCdRqqqui+6K4BOA8Np1gw==
X-Received: by 2002:a05:600c:3554:b0:477:bb0:751b with SMTP id
 5b1f17b1804b1-47d7f0a2496mr40373985e9.27.1767714431786; 
 Tue, 06 Jan 2026 07:47:11 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f653c78sm50905315e9.11.2026.01.06.07.47.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jan 2026 07:47:11 -0800 (PST)
Message-ID: <f65867e7-9af5-498c-ba5a-eea62841cc9b@linaro.org>
Date: Tue, 6 Jan 2026 16:47:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/elfload.c: Correction to HWCAP2 accessor
Content-Language: en-US
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
References: <20260106-fix-hwcap2-sve2-v1-1-1d70dff63370@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260106-fix-hwcap2-sve2-v1-1-1d70dff63370@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 6/1/26 16:40, Jim MacArthur wrote:
> get_elf_hwcap was used when get_elf_hwcap2 should have been.
> 
> Fixes: fcac98d0ba8b ("linux-user: Remove ELF_HWCAP2")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3259
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>   linux-user/elfload.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


