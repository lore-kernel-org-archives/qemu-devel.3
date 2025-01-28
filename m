Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40ACAC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 19:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrEX-0003X8-BM; Tue, 28 Jan 2025 14:26:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcrEV-0003Tw-9T
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 14:26:47 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcrET-0003tG-Oy
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 14:26:47 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-216401de828so112229515ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 11:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738092404; x=1738697204; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nUwX7igBlz5PH7zspQERCE/tt9psMP54uVvwgf/e6eM=;
 b=i2etU6EIZU8nTtW0efzAd+cOg8gffXwarrq1HaKYB6C8rxNgIhus7Lv+o7ZWZEofgx
 qXYFlOtwAjdRJDLJHmUGMKBGwoCSy/YYeoHgp6KdzTIiQDC3IRyZKC+jcXXAgwn0Zetc
 NNVSIa1b8GtuEgJM8+/z/ORH2X01Ry70ifTFUkoBdmtPZI3sF0MeAZXdgcO/38000sfe
 UpRQyPwAtAsgl8zXyraTwkHw4aIEfx8Srh4Y42YMo1vpzPYZTF5uesUBoO9a0P5Eithe
 9fG3q+JXXT82XEn5THiYrMcfbyEHmCo3ORf5okaVFS5fm6kd9TKF5EaXDX/efOIHqvmg
 qXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738092404; x=1738697204;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nUwX7igBlz5PH7zspQERCE/tt9psMP54uVvwgf/e6eM=;
 b=gxrmpzq17otAu7M70yx3EqWc2jFq8+I410AlWUU6C/gMokxTk/wNRDslejWROBUVLa
 8T+Aqs2v3HaSmGt3obep18mc4Vie9IhTbtpiLSXH8vfvaBKAsho07geJb1SttydsO++v
 f/4q3V+DLCO50AMJaEmXPL0DppK8Zk2muUHNv2BU1amUVsLun3+gwClaLcwT8Rblo4g8
 FdkG5qDUPUT/6j+k96HpC4nDzwuZh2XobkWGBqBsa0JqWpQq/VA3Ma7N4tjoNiQKSMXO
 U5L/qgXiCMPBghK3z5gzqMSVf8JoFM9ty3MjsgfJpXiPtrxYzBEssG2H1uvofYYHoyW1
 kMLQ==
X-Gm-Message-State: AOJu0Yz5dawq163uVo5lI0Ng6E/2IjrA9jy3nJQPhUQ/QUFLTt697xW9
 ISYktCFFfqUWSFylOsX4/ptk/IrRSbjq9Ko2o7GchsaZDOqYoUyIO8FFWY+wPpDH6OLD3GOScVO
 k
X-Gm-Gg: ASbGnctl4MxQbhEcQSuIPikQLAjYAKEKXx3ezlZGQEz2JkYsbLs54d8lwb9voCpmkIu
 CEg29huj1+GKXL4Va6R/NHJmYk6D2CIPhllH5qY9bK27rK4us3GWiLp5Kt/bDOoMGEPr9Tvmg2q
 lL3i2o7J+cuWWU/x2T+ZzCBT5Cm6hRPD46bUFeWy4skZlkGA43u2pRrEkoiU0rpELxWJPGx3hr6
 TcF7u1tLFkE3JcHZsNuNa0G4L96Xwx+tTf7Rhq8hvHpxZ7476xJym9OG6rn2J12FAg39tAyLv52
 TBi7WK56fzbz5RpiBwD4le85w5LaMeA8Zee9yZfUj7Yjh5i6iC+sHkYxtQ==
X-Google-Smtp-Source: AGHT+IG1FHb3dysbzK09xtKgpqSQWrhVnnv55Go/LWO3OJaAXNeLk3BjTHM9++iTvTpGk7l+aP4ARg==
X-Received: by 2002:a17:903:2a85:b0:216:7ee9:2235 with SMTP id
 d9443c01a7336-21dd7dff6aemr3941805ad.43.1738092403947; 
 Tue, 28 Jan 2025 11:26:43 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da424d703sm85766355ad.217.2025.01.28.11.26.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 11:26:43 -0800 (PST)
Message-ID: <091ae9e4-2a27-4266-ba2b-15ed92edc118@linaro.org>
Date: Tue, 28 Jan 2025 11:26:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] tests/qtest/migration: Allow using accelerators
 different of TCG / KVM
To: qemu-devel@nongnu.org
References: <20250128135429.8500-1-philmd@linaro.org>
 <20250128135429.8500-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128135429.8500-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 1/28/25 05:54, Philippe Mathieu-Daudé wrote:
> There is no particular reason to restrict all the framework
> to TCG or KVM, since we can check on a per-test basis which
> accelerator is available (viaMigrationTestEnv::has_$ACCEL).
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   tests/qtest/migration/framework.c | 5 -----
>   1 file changed, 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

