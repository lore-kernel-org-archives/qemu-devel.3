Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56AFC2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 22:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJhDO-0002Rd-7N; Tue, 18 Jun 2024 18:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhDN-0002OJ-3W
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:22:09 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhDL-0005TS-Ec
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:22:08 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f70131063cso47355805ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 15:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718749326; x=1719354126; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZeKM/bPBFWkTNJurfBw6I4ynU+XdaSaXrLr8qXpi1lA=;
 b=UB55Zrq6APjegMj+fUyKJ0/TXFaNS26S+CWynIMehf8EpxC+FWuxGf1jGoyniox6ps
 s1NI+GqXLKyff34HkzvjdeqY/6ZlQ5SHZQ/6u+F3v3nSekbz/cg5BdbPNe76AfZOokGP
 3zyfXJYYc5GoFnACkI2tpIf969mcmtb7R1M41Gb4HAavxilK7PB6GNEeZReTWxC6KCod
 EnxxwTBGFOqdtfrQxoHUz+L7Sb8CMYkEdey+7rg/KSKnmBu/3PBEVkCM8kVvi2kuvfup
 xBRkM5FkGAO2obolyqif75RIk/z9jfFTf1TzY+pklXUfTU2RtOeiHI8SqPEHsMauyzQN
 Q9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718749326; x=1719354126;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZeKM/bPBFWkTNJurfBw6I4ynU+XdaSaXrLr8qXpi1lA=;
 b=Vx8Mk7dS54Y00ZaC9piYb+uB5snRjkytxa7lLQpQj7ZxGHy5ADDfj/dLWLpn4fxz6U
 N0sE/ppA2tz+lW9oRdrx88vSFdK/CfLHfSIDncBjO/dpJ8KSou1FIGLt+5gy7iZttZFY
 Z9UFNE413vGbuMsj5OZgptLJp0tTgBixNDGxlk4GC9nxNd31VtB+5PXKjNyD2HQsUurr
 hHGqJ89QC2Yu/7V4knhH+aq6cwyhlUZB21fm7Pq8MCZK4tmQ6V4/biHjPeSBsQVdxW4P
 kT73yGBacQf0P0Km+liJ8EC0hP0OfSSAhT7kz3Z1py8PGI4FohfzYTfYiqG7/1L+b0U5
 aueA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy7WplfkG8AIVeisxcfHzsgnHqtIZCSNcAzZsIaUiJyDuyzVNvjSQ7qnZCdedqBDFd0fGFa0b9/dcL+4hRRhXmo1qZ9Rc=
X-Gm-Message-State: AOJu0YwB6MTIhmeiGBz8Ps3p5ZGAjj4/JDmttgaoxHWC2UL1mRdiL5U/
 6c2y/iDx4zSZxSIZEXVInEXgYHy1I9uutjlnP5LRtVinwglNW8ogUH8HEK4EGz8=
X-Google-Smtp-Source: AGHT+IGzGsMpk5dAtDvt6D0yyXmjGKQxqEnzBkoW4tTZWrH8qGHPeXzc3UYDNx14y2Paoqq2vAWGIA==
X-Received: by 2002:a17:902:b183:b0:1f6:87c:6f with SMTP id
 d9443c01a7336-1f9aa471f9bmr8123865ad.62.1718749325978; 
 Tue, 18 Jun 2024 15:22:05 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855effc9fsm102579245ad.189.2024.06.18.15.22.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 15:22:05 -0700 (PDT)
Message-ID: <6b2c84ca-70bb-4045-8846-8cf028ce3b27@linaro.org>
Date: Tue, 18 Jun 2024 15:22:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/23] Add function to retrieve additional ARM AArch64
 hwcap
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-17-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617185804.25075-17-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 6/17/24 11:57, Ajeet Singh wrote:
> From: Warner Losh<imp@bsdimp.com>
> 
> Function to retrieve the extended hardware capability flags
> 
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> Signed-off-by: Ajeet Singh<itachis@FreeBSD.org>
> ---
>   bsd-user/aarch64/target_arch_elf.h | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

