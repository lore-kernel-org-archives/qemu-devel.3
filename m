Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4285BCD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHpK-0002qY-8J; Fri, 08 May 2026 05:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHp2-0002n4-6a
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:48:40 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHp0-0007JK-N3
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:48:39 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso16931575e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 02:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778233717; x=1778838517; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I4tBkpd2G3M3jUrwfXSsOcWBNXPeyhH6e4+UOK5U0mA=;
 b=TC1ZhTnAQ+u1eVATea/qxVUeyW4bocLYfMp6BONLHOVv10XSZfUlPL4Z43kv4/J6gh
 asElVxDK8ywzB+yJs7YMUx3E3fIghA3upHqvPpDuuAV2OR6R4yyvo3cD/Fgx/mHOwcDd
 W4+wkp0asSzysreUWSxfH+Aed2r2bF3aT+kXvr0foidLzalNVyRB+MZOen5WCtU6uhJT
 noohXVZEk3zljavc2yH9Qocq5OdnN882BQ2lBg4u85Nc/j+FPlflEHNUglzcpOEPBxN/
 hQQrfojnLS0fvofMkOTaR4X2pwWMO7Dj+ph1cLp8NOJv2LZJU73xnhuZP3SYOZJUrQRv
 pGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778233717; x=1778838517;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I4tBkpd2G3M3jUrwfXSsOcWBNXPeyhH6e4+UOK5U0mA=;
 b=Hk4knCVjwGfb8IxFPOXp9vJoPvxWt89l8kLYJEpmuMny4YUYhmvvjMY1q1n/scGXOn
 EQIgH6j9h0FU24yb8doxeSo4PEUid5IhKKhvQR2u+1ISp/YBN3aU2QiIXjdMxnISqAZg
 uJ7ltaPUJ8tDoA+cuXkz9j5T/hBAezz4VSPEn57uWgRNvzDZsdAfN66g0Lt153YwrGPk
 ZM3u/+jK+bChNY6ZnUiL7NFNDDDCBgK2BXclFqEfgKT5l40vd+r07YgBfGHy9jqaU+3O
 HPM447agt1v/WZ/5FwMagZNBblf3pptFYOI0am8j9Peg0Aat5vCWGS7pSyvVwtC58wrc
 hP2Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/P4LMCrzKhkyswA7gunbwylBLi7Z3WlGTMDPOUguWfG8CQsLxsY645Bi7ziHdq2/9wt4NN7bQNEaql@nongnu.org
X-Gm-Message-State: AOJu0Ywo9rp0xZhfULyjx6t7FKSUoh3RHgUUgRnBCOVc/gLZbZ409iis
 2MZptfSiyRqmCyrPh16sNK/RMKD0I9lxe3plkmmPdhcqoQ+nwI237N5CqjqtMOeSxjc=
X-Gm-Gg: AeBDieuZxXoOH3twUVgwj3k7mCEc4HlyEuqw5TI7wa8LyGJHHfD8BS4ORqkTEWbd7BI
 CfYKTLujH3zVLzeh/8y7X4LA8vBZchkFNBgQzW3+B3tLkf2+iTLfMX5q8g7Dyne6UytcoIwNP7B
 93tzWOzwqVh5mGyNTYt0Z/PYPvKkOHV7dB95YFFUrNafIIF/KYYVXvZk5I7hTbSE93ZjqLe06cG
 NnShMVvwFl1zR/B3p+6FHSCKmVlNKon0kmH2p+pdvuwSHT5dnwg/HZnNJLYWnENoLnnwhMOZnGO
 KgC+G7/x1b3VHNH0mvJKZc0EF9Zw4YR2xYkFqBaRPE4q2by+5g7W2YAHaTLkL+KHLn8DCubOKeH
 fPpEE8zKqU+n4rwpBkYpbQVD9PqUP6+lhqbBNOdTT+DrxNgnIw560W2D27yW5GTMHp8IFaGaCgr
 yuJrJXkSrqL+P9qUmbfO3EbuyML6ftKstFEGmdYd2eRSc4/Kg3rygk+77bw/fUx8giVxpRgQ==
X-Received: by 2002:a05:600c:4345:b0:489:1fa5:997f with SMTP id
 5b1f17b1804b1-48e51e1abcdmr104417175e9.9.1778233717067; 
 Fri, 08 May 2026 02:48:37 -0700 (PDT)
Received: from [192.168.0.200] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e68ef0024sm28755315e9.14.2026.05.08.02.48.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 02:48:36 -0700 (PDT)
Message-ID: <7a16f4ae-87a3-4221-94d9-aa7379fb6e67@linaro.org>
Date: Fri, 8 May 2026 11:48:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/18] fpu: Use get_float_2nan_prop_rule in partsN_pick_nan
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260507221717.486023-1-richard.henderson@linaro.org>
 <20260507221717.486023-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260507221717.486023-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 8/5/26 00:17, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat-parts.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

