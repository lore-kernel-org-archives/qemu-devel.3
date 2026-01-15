Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0B5D4662F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 21:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgVDx-0008JQ-42; Thu, 15 Jan 2026 16:49:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgVDk-0008HJ-51
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 16:49:38 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgVDg-0005mQ-Ar
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 16:49:33 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42fb03c3cf2so1015601f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 13:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768513770; x=1769118570; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2Iris1lxPKvPi6s3i62pGcoD3WkAfCF9y49P+yFdxkI=;
 b=o5cNkhJeXEHMubFfZ5Et+OvIHrakx5P4w31zt/fXyZtDesKR3wKcX1lDzNp06u7ltX
 yBILo1L2kwA0mOsBerc14o7OCT8JHtFvC2LQQdtema89gNGT4/cg2OfGfyIcPfNv+43l
 eG1rWBbD9phmWP/n5l+qxnpKNXkB8jTumrnFwndfyhmOa5X6t222pclgvxMpgjsMngBQ
 R0z3KxXFJX3bl8GHh+iLsF6RGbEj4lPrCDIP4ArfqAtncHTdk+G0wZOlWMOPZkkABUx+
 V/cMAxoaBwcO8VK8MiD/JA0R3mYIkW87mxMUXRSW47r9ICGtaIOJY8S0uHypXp88Hgxs
 hqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768513770; x=1769118570;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2Iris1lxPKvPi6s3i62pGcoD3WkAfCF9y49P+yFdxkI=;
 b=MT+KWIOhhjEH1uReMgdp+hdwA0yKC30hafyBDN9vl/NJ7b6dq54S9PS2Fc+ndfEGcs
 4DKppaGSwCTcC29w8GJuLe4FPs7m2DWCUn1SDycxqTmkf8ZLLtIIVFMfL7FzZX5U8e0N
 TOpuSA+UnEBDG3hLPumn+MNVCkujl0SF2KfSHutnbflEuiVaqA+r/xTYFM24QTBFPtkv
 RsiOpYGaceb4XWVyS0OR9lUnM/UPOczfPbQ2hZVRQqadeTeA0Xwsd/haZw8gOL7dQHUj
 5b5k/2rZhQf4/eYko1DIYTb0bMplAmjeIqMew4jC1SOA20Rl9naqnZNc//k2EwEsSXAd
 NBXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPxBhl5QIyDyO1sZQ4zyAqASacjE2/CdTNzwqEDOpJgV++QihaHqjdkbWFQa+j84sD7FIKarbcMTxg@nongnu.org
X-Gm-Message-State: AOJu0Yxkuq+caJOZXIdZ45NnNRTGfb4t2DK1SywTJ5LsSHGYlt63wTRv
 fLBGLEzLvAGNCSz8dJ4n0G82yzpgQSdfvZ2FxzmAoiB8DjN3WHPXMm5LrrKToyiT1nc=
X-Gm-Gg: AY/fxX7ykvS2bRlrlBc2mcD54F3row0vr20qHj1dTMUOkxgwZLGh64sSzyxxQGT1W5H
 SsT/Nc4Y1CVKFNmBLfWbJP7AJQ5M0DnfdmR6TuJraKJavF3V71EDKIk0AMX0U68f1kIN86OwOma
 wP9c7wibzB4xSwoWk4KnC4hbqw+y161WY90ckvjxg2ReuOaRbmUnt4E8gDqSw9gxIDgBZ6w9rpY
 6s94Q25NrQAk6sqbPRcB+dDYeMdLT0Y5DlhG4SRkLIBDsC51tZw2JrWKUUKSTZ2kiB4VKsw7cNd
 79Ixz1zHDFVLitvPulL2b7+leOQPqDZ0bBznlRJRXO7kbj7DG7pphvzRnD4dVCZsk5J8f35CTcE
 fmvCYuUPIxgRvI0UcJICtpzuRSaRd14Mgp8Lz8e93WH/3S4XatrZBPCuOSGJ06fr8A0YVzUQ2ns
 86YTYzqrLiwoDYoLY1uqu9Z1P4maktrAe19Tv2q4iezT2cJHuhJbEaVA==
X-Received: by 2002:a05:6000:2f85:b0:42f:b683:b3bf with SMTP id
 ffacd0b85a97d-4356a02c4damr737090f8f.19.1768513770139; 
 Thu, 15 Jan 2026 13:49:30 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cf33sm1325357f8f.25.2026.01.15.13.49.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 13:49:28 -0800 (PST)
Message-ID: <70952346-bd9f-4b0d-9e66-c6772184de5e@linaro.org>
Date: Thu, 15 Jan 2026 22:49:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add co-maintainer for TCG Plugins
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, stefanha@redhat.com,
 pbonzini@redhat.com
References: <20260115202511.2709767-1-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260115202511.2709767-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 15/1/26 21:25, Pierrick Bouvier wrote:
> I would like to help Alex to maintain TCG Plugins. We talked about it
> and he will keep the priority for merging series, but I can occasionally
> merge some of them when there is a special interest.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

