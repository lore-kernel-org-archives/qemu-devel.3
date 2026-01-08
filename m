Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF11D1D494
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 21:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdxK5-0006PN-EW; Thu, 08 Jan 2026 16:13:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxK3-0006CY-Fu
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:13:35 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxJy-0004uM-6p
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:13:31 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7d26a7e5639so2519627b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 13:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767906809; x=1768511609; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vNrYeVZvuMLyivYpd62Mctd7+9ha4vzYcl7fW4qeWV4=;
 b=Yp8pTogmh9XK30bPwAmyQBqVTLHWHENs5H1q/3zePDMFnq6XXI2YTQEk2iSiYGRmZm
 6gUsLzeN/dh6bWHQOzlHuaRCeKHahGWQDuhPGOuR4phbk/oFsULmD6RLIeLER/g145bL
 3YAZUDtbp3rCWiHg5vQu5upl34yeh3GmPUhIGytOwEpiWrXXi+KDUFVFhhs9EDxjnnaX
 wMRYPndM1EQWq4CDAFiO6gvxw8q4cIziB0Oo/IxStqB3MzVE1Rd2wxoIXiC5b4CZrjYh
 WEj9KysECVToGHeki6iV541J1A5oAbZjaD/uAEHMzP5N32F2k7/cOSCJOAxDmQaD0WzY
 ghMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767906809; x=1768511609;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vNrYeVZvuMLyivYpd62Mctd7+9ha4vzYcl7fW4qeWV4=;
 b=t8kaE446zJ9cHApUWVha3tjLgymODKdDfTdLgzh6BAxUh3a74g7mBCok2c5i4vh4Wo
 kbHChLBUDejaxnla/GkcxCAaPbS3pPcqhhFRAhvhXuIkr3KJFvGIKdKUIIs0xEr0zZnA
 Nfxl10TJlRbFJtvN2SnmU9QLIVsvUZVoNnPewkTK8vaGrBsfEykHEVwH0wxP2iUmYEVZ
 WC8ZB22hrw4Q6WOw/lfuCe7TuhKMQSyXGY7g1lwn5awHwCSEJSf4kwUMc0DuHC4jDn+L
 xT1sdqLbwxpP2+n3Sglv2wIwEDh1mGrZtiQ7jQuaA1DSs3sby9HNJF5Na0bkLXA83kJO
 FLyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2t6MB7wxLRGYONR4k0Kh4Qv3VzTSggC6ORCaGYO30l3FnXQjurBWOd16ECW0vbSxnJyKq0aTY7U5U@nongnu.org
X-Gm-Message-State: AOJu0Yy6isdCAUAh88HMg0hO0YwGACV5lQ3SXSwpfm5TlJO2MlmMjOQp
 TGbn9kMXNH/HmaXDmH8jrxbWCLHm6qefoAOIAdx16Y8NF1pQYrVXutXvT+O9YTiTxKHXdvpDY29
 enbTW
X-Gm-Gg: AY/fxX6AtQd78yLmpaSdaQxwhLNrelBtrdJMoF+sXnnt8YLd1Q1JRwQ8OoCra1pnIyo
 ztTo5HbLvafESW6Q+T/NKEyNKQLF7tkeZbaWPppwxeNbZ9YW3lsfbMgwMz+fG1S7/yuZZ0rGPUA
 pDDeYBHEc5aCWRh+9rD9OwB0hOvy0JVa1Il8K8DUwxVK+KujAy27H3uLHZH0H+nCA3xmuFuXs4u
 JihFn2uZvBgV/kVr+fpbir+n7e0VmCuLNXZpTeldSflOEXL7EX2GU4dLfPtxIxQ65jfIq4qw/Ht
 Ibi6mid275SrifLJ/OmotspvbLCj1E834qhElm2dcHEfp7OJRKn0AO1v/4cUdCbV6GE08tUJ3eY
 aH3xSb1KvZyGsUseRt4AO8U119DfVUmbSi5aOZTJAGQ1v1RaCWY7bdFgg6UFpPftpB5jUCpLsIX
 gINnd/IwmcP7GpTYtLR2XVzx5opI6U49BJuZT9otOLowx6+gOXlkzau9txa/Cl1EUUSBg=
X-Google-Smtp-Source: AGHT+IFzLIF4FHoKHcpNpIaWcmUhTkXwgHAsQHwQUncYYrldcPTCuhByRamaIjhFPA5QaYVtRPqlRA==
X-Received: by 2002:a05:6a20:3c8e:b0:342:44f3:d1bc with SMTP id
 adf61e73a8af0-3898f973ac2mr7726985637.35.1767906808820; 
 Thu, 08 Jan 2026 13:13:28 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c4795fsm87916155ad.33.2026.01.08.13.13.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 13:13:28 -0800 (PST)
Message-ID: <9dae54a3-6820-4d6b-b4fa-31f73c3435ba@linaro.org>
Date: Thu, 8 Jan 2026 13:13:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 41/50] target/arm: Drop CONFIG_ATOMIC64 tests
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-42-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-42-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 1/7/26 9:30 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/ptw.c | 18 +++++-------------
>   1 file changed, 5 insertions(+), 13 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

