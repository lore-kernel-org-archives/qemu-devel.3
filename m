Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726D6C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 20:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riKb0-0003vN-8U; Thu, 07 Mar 2024 15:44:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riKat-0003uu-D7
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 15:44:03 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riKaq-0002Dt-8G
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 15:43:57 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-29a8911d11cso881211a91.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 12:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709844232; x=1710449032; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+m/ao1DrGxKl6KMlsfP8COmGyncwprW0Bsh5ZR7VlUw=;
 b=adXRvhAsb+HxOWVHeVgqeFcMiWHT94ICF/FKzDnLksmC8WPM6knlvcaaSaa2CZdA1w
 pK52r4dyJzirEFMeV11CBrJ6pWPZBJ96Bkxwk7dVspFc59Fu9D5NZ9muLbC8MBaCi69A
 SNq4rn0X9pBkXJm+zKhRMpYFtMNw4KIG6UqckxNYIwX3wRfxheak6UJ1FMDC1tx15/Kv
 gJi/zkzecX5/m+acZ/TTZOry0fCCAOOTIc0b8SIjuHSy8zbCuaT0PlNpHtVnvJl2KVYc
 IBdDkJ3Oipyn2O756Be8CVF8ZPNSpp0H7DNfpaLoaTQ1W6nI2mHn1+zj08pQs7Vqziqf
 ORGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709844232; x=1710449032;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+m/ao1DrGxKl6KMlsfP8COmGyncwprW0Bsh5ZR7VlUw=;
 b=m0C/nFjbQ1H/8fWzBQdAoHEOd7t1mT0jV8btftZZPXyUAKHXiFLvzhOkzUghI30jrP
 5Q2KsJ9tskFBXMJWoMFy5gvv+hrhChREImHclUL+QRRwSutBITylyteLTes+zIjPTAzQ
 ikcpBZA8yKtFrB7zV6VRgVXpkU4X86W/4dV0/tgvJIXQxhoeaT5YIn+vV2y6XAqBW7ZF
 h26q7Srkh/RvHtnWMavF2s9HQqX6k2hXW0zQr6lRX8sc0/82II64yPzxc9qmnn+jAjMn
 +Ub2dBd1TjSPM9n/prEmt1HXU/bWKc/KOCJQmgaXDrD+Q9GwUX1h6j5svKKUxkvRocje
 OkVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs0UWg1Sqr4v5lu5k1jsKvj3KFSRCi0jYixUoHqtdNqUBvt9G/Kjev0JI3SqhIlx0OcDiptx2gjPy+EDZSuXbFj+aPko8=
X-Gm-Message-State: AOJu0YxIRExlFokNsz4lxFjudc7jZRH01k2itU1UzIFZq7hAboz7lm5b
 ASsFPBlwuHtL3cOGieJuciLsZO9VEsNs16zLUYJ2vhLSRem8UfxK8rA+7UZ5NXU=
X-Google-Smtp-Source: AGHT+IFo9URIH0ONESxQfNBFrIJakMtPZKAFDudD7bF6Fs6eOLHFAGkrZKy5fuTivnryDL2+yZMG7g==
X-Received: by 2002:a17:90b:1bd0:b0:29b:3d08:c644 with SMTP id
 oa16-20020a17090b1bd000b0029b3d08c644mr13281957pjb.9.1709844232495; 
 Thu, 07 Mar 2024 12:43:52 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 p1-20020a17090adf8100b0029b178a7068sm1961051pjv.50.2024.03.07.12.43.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 12:43:52 -0800 (PST)
Message-ID: <f9ef93da-8936-4ffc-8a21-ad90f475845a@linaro.org>
Date: Thu, 7 Mar 2024 10:43:48 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] gdbstub: Rename back gdb_handlesig
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu,
 philmd@linaro.org
References: <20240307182623.1450717-1-gustavo.romero@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240307182623.1450717-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 3/7/24 08:26, Gustavo Romero wrote:
> Rename gdb_handlesig_reason back to gdb_handlesig. There is no need to
> add a wrapper for gdb_handlesig and rename it when a new parameter is
> added.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   gdbstub/user.c         |  8 ++++----
>   include/gdbstub/user.h | 15 ++-------------
>   linux-user/main.c      |  2 +-
>   linux-user/signal.c    |  2 +-
>   4 files changed, 8 insertions(+), 19 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

