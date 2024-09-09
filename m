Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FD2ECE589
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 22:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snmgD-0000w2-AA; Mon, 09 Sep 2024 18:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmg7-0000hz-Cq
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:16:11 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmg5-0008VD-Pg
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:16:11 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c3d20eed0bso84283a12.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 15:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725920167; x=1726524967; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7+ho4BjSWQU1nd+uWWV0TOa11xGPakREUGrEK7RPxtM=;
 b=z23IUUVd12xELtpC4G/VY8A/4DWvVJOGM+21olQbWcu6BLXBJe8DgC+URQ5H5G7dY7
 mfCqoHxKZIrUETitZju9+0pkbS0g746kjHMfTYC2x7nGuEm+c9xoaKc3/nAFQiGy+sgr
 RFvtMp4bPI7Q0EwOdZVxU28QKX/uphCKd3eLufXuY9NUbd4iSfbRum8i9b+GUjlXYWz+
 uWy/59emZIZCiHpN3x9lyt0+DTivwtmTWpt2lkB2XRf8yfTRINDRWfjeHAsGadhYbgzL
 lT/GQxznucOlYl0l4rxRN4z2QoYZpvZUjb6GODeOq6eydy1iBfMG1xdRK7i7Sx4sMtYN
 TdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725920167; x=1726524967;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7+ho4BjSWQU1nd+uWWV0TOa11xGPakREUGrEK7RPxtM=;
 b=FiPkvjjVl+Igb+kWGRV3AEep7NNJBIn6KsVlHSec7DIZ/GHDqXiFPjFu9Ti2k9Y1rU
 7h4tFxi8+xb+yrei/Qpy+EWXrRtADjldYKZZEgxsTfXjyvneGaMD2KRWJzfQRLzsvgbK
 zhBkamR1VDyVDQs7wsf/AH4rLKAwMPFEdr6Ry0F0i9jSBO8YgQmZQn5F+Xc6r2aQVE8G
 EL1Rq1CPqKr3i/tV6xwTjRJAMGALYUMep5CbMuSmKHlT2z6Q/p97SbHLqg+47yVs7lbk
 wOXHuUghG2Ww0Aaj41Q5Vr5QohsURLzB5Oi72XUzhfxhLEBVb3rD7pPgxt/LGf7ZgbGw
 OAJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE9tAk/0cQyhr67V3p8nFF7qOYBRWoLKGQwnZQAuo7ASQ8KCwEiiyFCR/zv0J9avRoB/kLumsW7GVn@nongnu.org
X-Gm-Message-State: AOJu0Yx1eM0nUKW4ymdpimhWUWw8HZy0mgOnf/poOICS/VG/H+4fpjYT
 jdCkEqZ08HJOzEA05eSnboMBtIlrpqd3nlvtZXCkM0sPUSlyXZOYViSGK8IB0EM=
X-Google-Smtp-Source: AGHT+IFSLJTHNcywkngLO0ktVGguhquOnMYcQOmR4oGtuAMM/xZH+bSs/ZVcYxOb6FrFm7G+PZ70hQ==
X-Received: by 2002:a05:6402:1d54:b0:5be:eb9b:b72a with SMTP id
 4fb4d7f45d1cf-5c3dc785d08mr8762723a12.6.1725920167411; 
 Mon, 09 Sep 2024 15:16:07 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd51f84sm3424566a12.41.2024.09.09.15.16.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 15:16:06 -0700 (PDT)
Message-ID: <0c2c0018-ec53-4a54-85be-3740f09bb19d@linaro.org>
Date: Tue, 10 Sep 2024 00:16:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/26] target/m68k: Merge gen_load_fp, gen_load_mode_fp
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, daniel@0x0f.com
References: <20240909172823.649837-1-richard.henderson@linaro.org>
 <20240909172823.649837-22-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240909172823.649837-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

On 9/9/24 19:28, Richard Henderson wrote:
> This enables the exceptions raised by the actual load
> to be reflected as a failure.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/m68k/translate.c | 104 ++++++++++++++++++++--------------------
>   1 file changed, 51 insertions(+), 53 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


