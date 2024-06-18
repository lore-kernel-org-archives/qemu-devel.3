Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA559C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 23:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJhzm-00081U-WB; Tue, 18 Jun 2024 19:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhzl-00081E-7X
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 19:12:09 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhzj-0005Ft-Kz
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 19:12:08 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f99fe4dc5aso8911375ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 16:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718752326; x=1719357126; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nhICSm8BxXIpuoblOfcDr75MAdBi7We4iBMGlHcpOCM=;
 b=AfdFoxifqIkVLEyL1+NCbblQwN9IPkR8pbuedQdW2YEC4s9ks921ijer5855TPqbRu
 6GLz1MwQQq8j874wSzeUmG9rUSsS6+xMOd+ePOrf+awJUaoXkbtcx0YEu/e9+9CuDbMd
 /m+mCygoIyhxGFsBNoYqW7WeDLpkqlLOkr+KNSapVBShoTazkAWX0XHSqxGoG318NNQq
 vuHrXwaWbg9TLKxhiL3mAPPJc3ErtiJvvac9FfLF78jxHL5KkurhDXTNRxTujhtSXiDH
 84P5kRn8lP1XhuA6xjj5srkFNBoPp1gCUy7ybgib+Ypcni9E7am9hG3OS+R4bBmlRx8b
 sTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718752326; x=1719357126;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nhICSm8BxXIpuoblOfcDr75MAdBi7We4iBMGlHcpOCM=;
 b=AI17OaZGcYWHdjkgrrSWBUHbbaMsP1cn7VNq8125anV+JtJNsesATc7yzwpLIM5tIB
 JBzPUxgCdya4xOoClSUAGWR2GvjFv++hQYh6+VLe1B6LNTf98I0L2+b2s3dPK7vzvXNl
 YyYiZC7puSEhtdetqG0O1T/YS8/WEkQf+ArmsQA0fMebT7RBE8lTcOck5epjYQ/LxvFF
 JHzknDmYnU2Trtc/0RE1IvVs+8JLeU6dQS1cePB3JODWIKDfJWzDPcSbuJJNnqHIztKW
 Az3zv4Ty79SnUBUzdyhsHi/T/3NaTyi2ffmiO3WDNxZ1vBrrnQYcESOQ/0vVltqvi9yl
 RmZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHOyLtQXW4XzPA6v9S0ytimIQm5S7iN2qTIWoo+pcxTo9vvTSij+Gw/IFsuL8MqME9enaKgh0bKYPWU4w9Ks4KRA3IPf0=
X-Gm-Message-State: AOJu0YzHn93hvioW4hzSgrbg5sQb04m0UG5aAbQ2aAi2Y8LmTw/E/Y/o
 FeVpcOxsZJmVFdAAGv4sKFDpQYGJU61vI6WgiztRdp2AJk8Vh4e0TAMjjMqMYKaYOPLosQgHNdZ
 i
X-Google-Smtp-Source: AGHT+IF0AO/rs74SoTv+pYUoPHMJuqLA7oVTB9yLDnfSaQVGIejS2RCtDESoMABbBHG53flZGApFbw==
X-Received: by 2002:a17:903:2285:b0:1f8:3b20:3813 with SMTP id
 d9443c01a7336-1f9aa3b50demr10751915ad.12.1718752325838; 
 Tue, 18 Jun 2024 16:12:05 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855f002b0sm102637525ad.192.2024.06.18.16.12.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 16:12:05 -0700 (PDT)
Message-ID: <4537fbbd-6d84-45b6-a366-f317cfdc025c@linaro.org>
Date: Tue, 18 Jun 2024 16:12:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] sysemu: add set_virtual_time to accel ops
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240612153508.1532940-1-alex.bennee@linaro.org>
 <20240612153508.1532940-5-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240612153508.1532940-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
> We are about to remove direct calls to individual accelerators for
> this information and will need a central point for plugins to hook
> into time changes.
> 
> From: Alex Bennée<alex.bennee@linaro.org>

You don't need a from in the middle.  :-)

> Reviewed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> Message-Id:<20240530220610.1245424-2-pierrick.bouvier@linaro.org>
> ---
>   include/sysemu/accel-ops.h                     | 18 +++++++++++++++++-
>   include/sysemu/cpu-timers.h                    |  3 ++-
>   ...et-virtual-clock.c => cpus-virtual-clock.c} |  5 +++++
>   system/cpus.c                                  | 11 +++++++++++
>   stubs/meson.build                              |  2 +-
>   5 files changed, 36 insertions(+), 3 deletions(-)
>   rename stubs/{cpus-get-virtual-clock.c => cpus-virtual-clock.c} (68%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

