Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81670C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 14:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVuAa-0005RU-Ax; Mon, 22 Jul 2024 10:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVuAU-0005LV-DE
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 10:37:40 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVuAS-0006xS-7t
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 10:37:38 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-369cb9f086aso1104305f8f.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 07:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721659053; x=1722263853; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7/kPwislHTjvX5KRQDtlNXK70ZY8PmJtnPvR1+V/OJw=;
 b=Zmc1T+iwjdHdrCY3IhmYldlF8/B1sX3cyz0BoxO8aHV8eyXRx2C6Ye/w1idX9tjI0+
 qKNjKVw3rDOqJEHrCOVUBb5C2ypp3TSeF5lKfgzZK9kWY4skD9TQItjPvxg9Xp/hO6bt
 EUc/aCD8d10zJEo5vWFCoDyPhU1UaxRjl0m6gzOEj2z5gxUOaQpo/uTpRiwy8qZQ3WiH
 /Vi3ndW8B53jDK9IX5sIha6sUWk8w3IGkmc5wm4uVATE3mEixMc+abKRuLk/YRAjNQmC
 XEwP9LoaMvZdxDRyWV/2gtMYzKDx78dT5wqMnlDSVNN5JR1vL8MFrLgOu6jjcRH3zSaW
 PgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721659053; x=1722263853;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7/kPwislHTjvX5KRQDtlNXK70ZY8PmJtnPvR1+V/OJw=;
 b=aOMjtW5gI35ubrxR9Bkw+Gw4pH8PRMDzxpYRpBuaY+AQOvDdFxaEuAmRe2vF5j8+Ci
 0JGqF8J3NY1+ydH0iBIPy/TJs7X6Y8FTJ/ovT6NKGzWpanRpM5XCnpH3QnBjg5Xb3Bln
 bmsN3XpWm8hMVS+HDYLEX/9+dL3w9/YVI6VlG3LR6FRSm8t64TuCZFMLdNpa+MvLCGg1
 MpGBEemr36Rf3co3lLSZW5477Nio4IZWurpv3uJYbo413MkFuDEsYUsHAJ9lBarHzQoe
 COkHusFZD1xykCHOPrgVjjFtAylAR2LildvEqnyqHKvmszPluYXttMM5dQ7uOTO4IqUI
 sI0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVflO5RiGelJaqqTwOQvsb3XK70a71fWTnUs7m6MJQHBbho7bOQLsZtDmCmVWD5XCWN/0AdeAN9kjr+LfYGRrM22Lxqxjs=
X-Gm-Message-State: AOJu0Yx9NvsyxUBDG9Hkr7g206GQsC+LdUUSUoNU7c7wXYk6V0h01d9V
 XJpUBnuIhS80ycGuod3tJIExgyT1AoF2T3tGuWnuofN60bCy5oBKAkdi1Q+KPuU=
X-Google-Smtp-Source: AGHT+IGlF3QSJVllDNZluwpNRjyAstEDSclveOBORMJmxIiCeuwvWMtFFjX5RsdLuJqiRY/iS7ikyQ==
X-Received: by 2002:a5d:6e03:0:b0:367:97b9:d5ed with SMTP id
 ffacd0b85a97d-369dec0cfa8mr72893f8f.9.1721659053363; 
 Mon, 22 Jul 2024 07:37:33 -0700 (PDT)
Received: from [192.168.69.100] (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr.
 [176.184.20.254]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787cededsm8770557f8f.78.2024.07.22.07.37.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 07:37:32 -0700 (PDT)
Message-ID: <1ae5a1f5-981c-4e83-a2b5-36f8d92f46f4@linaro.org>
Date: Mon, 22 Jul 2024 16:37:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] crypto: push error reporting into TLS session I/O APIs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240722131611.2820041-1-berrange@redhat.com>
 <20240722131611.2820041-5-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240722131611.2820041-5-berrange@redhat.com>
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

On 22/7/24 15:16, Daniel P. Berrangé wrote:
> The current TLS session I/O APIs just return a synthetic errno
> value on error, which has been translated from a gnutls error
> value. This looses a large amount of valuable information that
> distinguishes different scenarios.
> 
> Pushing population of the "Error *errp" object into the TLS
> session I/O APIs gives more detailed error information.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   crypto/tlssession.c         | 47 ++++++++++++++++---------------------
>   include/crypto/tlssession.h | 23 ++++++++++++++----
>   io/channel-tls.c            | 44 ++++++++++++++--------------------
>   3 files changed, 57 insertions(+), 57 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


