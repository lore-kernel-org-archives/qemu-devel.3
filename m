Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B96C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 18:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdvYG-0005dF-VG; Fri, 31 Jan 2025 13:15:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdvYC-0005ct-3p
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 13:15:32 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdvYA-0000lT-AN
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 13:15:31 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38632b8ae71so1986545f8f.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 10:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738347328; x=1738952128; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2Ckum/ebxHBs+gO8f3qPwJgyKzVsoTey5TFw+bbPxJE=;
 b=Kc/Zb1CiHFhbeHmMkE5XpdPSEnSiAUb3sLdnJmHSfPvC3YOh5XlbADKwZSeg+NGkp2
 wYp5K1/ZaAIjgdHzK+jvaDeF3fh4SPea8cUwqtfU+M/yZb/ApNMLL2IluRmlS3oZo8yz
 ulQoQy5Xks0Sr+zw1GBVAgFNQLb8uCPZ5k8gaVAC2BE+ITfFkaWd7/UFi/WzLSzmb58Y
 98sllovLpYSx4AV7epeZNANZaTeKvXbex+IwwQC3c1cdUWhW8W1xW+LLSIfHuR43vCiw
 tnps2R974f+z+PegYotdmmk1kw81LYKYf/d5CppXwdqffJ+25S14I9hb98f4EEZ4uZck
 luHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738347328; x=1738952128;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2Ckum/ebxHBs+gO8f3qPwJgyKzVsoTey5TFw+bbPxJE=;
 b=xSAwat7KfNiwz3SqXDOZ5BOJlPLRJNBpTxow11Z+n0eqV2qQZlpx74cmq6YSWypmUh
 Ku1JfvtyHENkwCmlPzsTOfQO94i+8R6w6EzufcVOecM6ayR39o4G2i69Z5fm/Ge6a/fH
 CJnvsb6tDJYlIIddwqnNUGC/HKbdIPxKjEiPA/bNFMZMrSqJ1Zo5EmvyPkzqhaCRkV5l
 iYocRKgipQNfAvnPcRKR729qJt/b858Fb6WTL2pYXVf6WvzL6mx18yDfql0Tg/ez9LWe
 n0HmsBGuxr7AYdLEeKDWgQfI3+hXIi4R/xGgOOQgg6GWd4Mwjd1R7Z6sMle0DD+zwarK
 MgoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1uEqRXCsHydNihs0EOZTsIUmBwoclSgnCmAVxs63zvcS/CSuGg8UbToOuq4/3+7Xe1D2NJpD98wAg@nongnu.org
X-Gm-Message-State: AOJu0YyT4yjanmxEUIaf0XuxhQUDzJj5AavAf9mMKNBY1ZtMyTCqt1bD
 aefQoQsOw6hTYkizUhDHW3lv+nhRV/O2L6Uc0x8PfHWJyzqxqJSgoei+E15uG9c=
X-Gm-Gg: ASbGncusiqNl6WSKxD22KRKU0dDuXCpEr5swnvGV1bsA/DOHwdJvFdH/XUmF2R2F4ki
 DwOIhaycaAIi/7tkuO4SXsqFsxb07YAC9VfhHH3J57Im9/zIdNx9nbEx+ibE09viPE6RxIpgVgp
 WFz29xyRUX27Hmz8dFD6KxktucNo9cizCr9F6dENowxXQqPjdUZJJhxUnymTewehM9olUrsfoOL
 2OBx5GFZNEqap8EhlBbxE4QVg1FTsWHAQYeC7VM9kHZHq6aPqgsg3VGCySIVn4aHIZE8K19TtS9
 BGl+aiTTyaBKmWP/lQB8jBJVpQAliwIBbvtKHr5uY5CCv+ciqRSmyjcb6zs=
X-Google-Smtp-Source: AGHT+IGvPgbmEawhbKZim8hUbYZBmQlTVHKsRKa00KwF1oQeefAWuJQ/sVt2ZAYBgbJ6WjqSXo0GOw==
X-Received: by 2002:a5d:588e:0:b0:385:f16d:48b4 with SMTP id
 ffacd0b85a97d-38c5209715fmr11848757f8f.40.1738347328444; 
 Fri, 31 Jan 2025 10:15:28 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc8a59dsm100239895e9.40.2025.01.31.10.15.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2025 10:15:27 -0800 (PST)
Message-ID: <7484e0d5-66f7-4fb3-9262-7d698b2b1da7@linaro.org>
Date: Fri, 31 Jan 2025 19:15:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add myself as HPPA maintainer
To: deller@kernel.org, richard.henderson@linaro.org, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20250128170914.13353-2-deller@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250128170914.13353-2-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 28/1/25 18:09, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Since I contribute quite some code to hppa, I'd like to step up and
> become the secondary maintainer for HPPA beside Richard.
> Additionally change status of hppa machines to maintained as I will
> take care of them.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   MAINTAINERS | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Patch queued, thanks!

