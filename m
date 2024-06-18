Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B0AC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 23:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJhxu-0006x4-E2; Tue, 18 Jun 2024 19:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhxs-0006sW-Sw
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 19:10:13 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhxr-00051q-2j
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 19:10:12 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-70623ec42c2so250707b3a.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 16:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718752209; x=1719357009; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KKkizdNuF6XgWwsNrhpLfsJbhRS6/N1HYoNN/s4v4pw=;
 b=KHCjcJY/oit3IaT1DZGtr18QNlKZZ7wrdXl3Cyg17FY9meAZmFFwdwTPCkZPQCQX6K
 mFgvr3GVvh9g/6/bsuhVU8VjVpPqTR1Y2RM5bX4ywgmms7MZAmXDLN7S5TGMS21fMJgo
 xKCBrMuXekgFGXc4wGu0vaHSZuIH3dA4Arx610gMXezbHuTJUnFAz1s51HihMJzAWJkS
 N0kGBpgPfBKqbSG4U7VygOSobGpOxXthshEYtb3Nv3iERhSHSQjRWCQulGbHrUB0MQGF
 xMK+Wi/VrS4EN11LGYL/7OSXsX8WGhrKD73EfXPtgQ2isL5bad+cLL0ChT6NoN0NRMFB
 fxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718752209; x=1719357009;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KKkizdNuF6XgWwsNrhpLfsJbhRS6/N1HYoNN/s4v4pw=;
 b=g2ZUhPXJcBbM5yosGysjQ5Uijo1ovVDd7oCMiglE09vO9yg6Txu7arFmz/8hkxUEnc
 F6EARjv3RCzRPqc44GmKfQsjDKgg62iNeEKux4+ZdkQYJzedBxHDK/fthJwF6YyhlPHR
 RizBzqbmtwkFHv+ZiSKPQ/D4p/Rb4OIe4z6CyhSq3jb1lUvHt79KY+scFwZQjGISRRI4
 cjY38aVEDJgfOYSfsGuc3uAc9RlMFCdI5XEycW5SGecODt5bpf34Q1b0+coIqQIj7lwH
 3XtzfXUbnooMFuR0MSN1CyA3qz7eAM5jJNkvCqteoqpmKrUm83N/G8YS2523WNzcF5FF
 wE5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV+kLHsfuQT0Q/GKQTE5fQdHrU9wLToO3rMZ8GyUou9ncF7eNfTll04vhyunUBabpo7uDf8Q9ex+bb08eAf/H4pq51jU4=
X-Gm-Message-State: AOJu0YzJv4zvnJ+ZIV2OtTmPQoFg27eQVz0o4p96lf3dWwVArRMyru93
 2tAqpPz+8VW/GOLBcVydaWzS5DL0bEk7hWsMrHH19Cn7s0Z2d1dCFA1yLao2+Y2H0j54GuxtAM2
 W
X-Google-Smtp-Source: AGHT+IFraMUOmhTNowrWPTMB+n7PWtMz9Wtznlh1CywsXKcNFBsVxAKaxEF0StyAUApY+NzJX0G0DA==
X-Received: by 2002:a05:6a00:2e87:b0:705:d6ad:2495 with SMTP id
 d2e1a72fcca58-7061ac0ea0dmr6219404b3a.12.1718752209088; 
 Tue, 18 Jun 2024 16:10:09 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705cc966d12sm9509926b3a.60.2024.06.18.16.10.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 16:10:08 -0700 (PDT)
Message-ID: <f653b3f1-8c52-4f38-9a02-ee64ba149733@linaro.org>
Date: Tue, 18 Jun 2024 16:10:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] plugins: Ensure register handles are not NULL
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240612153508.1532940-1-alex.bennee@linaro.org>
 <20240612153508.1532940-4-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240612153508.1532940-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 6/12/24 08:35, Alex Bennée wrote:
> From: Akihiko Odaki<akihiko.odaki@daynix.com>
> 
> Ensure register handles are not NULL so that a plugin can assume NULL is
> invalid as a register handle.
> 
> Signed-off-by: Akihiko Odaki<akihiko.odaki@daynix.com>
> Message-Id:<20240229-null-v1-1-e716501d981e@daynix.com>
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   plugins/api.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

