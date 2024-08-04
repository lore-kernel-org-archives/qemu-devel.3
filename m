Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D88C3DA64
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 07:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saVfL-0002Tn-Hw; Sun, 04 Aug 2024 03:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saVfG-0002CF-PX
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 03:28:27 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saVfE-0005Rk-EM
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 03:28:26 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7a0e8b76813so6460678a12.3
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 00:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722756503; x=1723361303; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ob4BR+u5ckBxCUWLaKdSSThYwteQoY8lNI/V0KwIkx8=;
 b=Tb9bTnZ4o3hQCkZbzupogT0i/5vyI9mQvMmTJT5Mhp9FZX9y9Ss87Oq5TOMgcFC6Qn
 yZu5nnWlMkh4Q6gP+z8qngtsSBTrmEiSRu5IdmWGGuZM0rDg+hBlTSFh8TKza3YAVNJ+
 qmj0LinslrzQPTdwAlI9RM5Wv/IvgvVH0u8Db1IV/ym7z3D9TpnMxyY8u/1Mnt7zQ4Ai
 aMXlLmXAe7n7KNuw1JEwYILJlYSJD1IFbz8EZ3WaMlYKA0BrDC+pLLA9d/SIZkdaOJjo
 HynCElE81VgZ+D3x44/aDlOOmTTjdoEeBlis6LmKzwsPesfRcv7qxIGDXkz0bGTCEkq7
 +iHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722756503; x=1723361303;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ob4BR+u5ckBxCUWLaKdSSThYwteQoY8lNI/V0KwIkx8=;
 b=sMu2bNutCy3IGgi19WyTTg58ZVR00RX0vCwViJScRJKFJJxksT9c9iQB0FU76FBZQJ
 imF74gvj9BRt/lUdY0/qDSqFs1BQB74fqH/eH5XtjBHDzHjAoSlyJQgfV6tI/ZBTUsw4
 nfJAhXrO7aj0mGeazcM+YmpLnT7R1XWhzwMZD8lxpwUfcUDXT5x/oj38aFmoWDdBxJsK
 AL9g8H5zWkLG4l/Eb0vuT+b7XxMFqtZXd93zihbQhMvC2URMc1ZV1hZsnozwmBJiMVMV
 p/Lax3gxZhqjYHInIFd/yeUIDCnQ/gR4wfCcxSxx9SLTXQMncOkhjqfv+/98ZY0vY0vX
 1svA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQObl/k0mcp9ahlSOOnfe82ckJVIDY5HeO3FfVCPvvtPEEl4G3GVPyQ+Y7n5YwFIEyZTlvK7hO4GToeAjKi/WmuzhgOqI=
X-Gm-Message-State: AOJu0YypLNdT3gTr52QxvWugtZ5BRZJzsT7Z18b95MraAd3lVvZq6Wmo
 2y/b1SkR5Il+9POsz8UDaog8pc37GU7/OkOPFctE2KRfHRJIXbA/pt6w7o+Ul4A=
X-Google-Smtp-Source: AGHT+IEEcBgexyfPlxeo2cL7LdpgohjU8Cq9sU/vIJAN1RfFp3SSX08Df/iobgQxPzI7dOuo9HS4+A==
X-Received: by 2002:a05:6a20:432c:b0:1c0:ede4:9a73 with SMTP id
 adf61e73a8af0-1c699554b45mr12641294637.7.1722756502920; 
 Sun, 04 Aug 2024 00:28:22 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ebfeb58sm3609743b3a.9.2024.08.04.00.28.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Aug 2024 00:28:22 -0700 (PDT)
Message-ID: <ce2a43ea-cf34-4eb8-94b5-05ca56900374@linaro.org>
Date: Sun, 4 Aug 2024 17:28:16 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/17] bsd-user: target_msync unused, remove it
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Jessica Clarke <jrtc27@jrtc27.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
 <20240802235617.7971-10-imp@bsdimp.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802235617.7971-10-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 8/3/24 09:56, Warner Losh wrote:
> Nothing calls target_msync in the upstream or blitz fork, so remove it.
> It will save us having to modernize it.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/mmap.c | 17 -----------------
>   bsd-user/qemu.h |  1 -
>   2 files changed, 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

