Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4CDCD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 16:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruayD-0001Hz-BO; Wed, 10 Apr 2024 12:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruayC-0001Gm-EE
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:38:44 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruayA-0008Oa-Oz
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 12:38:44 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6ecf3f001c5so5726425b3a.1
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 09:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712767121; x=1713371921; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2wNkbEWa4uN8vf95K57kV+JQJirlgzVpIFj2kdw13iA=;
 b=KT2ckepzpC5LaQO4G9OlYthwtmjfdJWeBWqx9qUK6iDEnN7jzliI7TV2t4vsFyN496
 Iu0AVDUOICrJBAlwkCFrn6TcPqh1s04KCyFhVz0j4i8lo/9O74x35vIzQnhrvWYDLvdf
 9PQtdIXKf3hRlbLjcz0t9kCz0FlyEs0W+TkArmsIfJ8Ko6pQOJl74U43v5raUZMAgVOy
 V+zcCPW3cvCZcrN6MIQHHpvqDsuMlKl9DsYkQdjIl4ZS2ZCDJ5hxbP8BPl2GbC7lHWAR
 f4id3j7T2rOmulOj6EZRzvRxuBylFcYGcsucvAbdzwh75ndYkjnkKKOpHrddHEvOdbuG
 amRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712767121; x=1713371921;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2wNkbEWa4uN8vf95K57kV+JQJirlgzVpIFj2kdw13iA=;
 b=T22yIaHY3wloqIz+bVe/EVBmcea8ZP9pZPVBvR6xAUxezKO614mnNKLbmAbsuKG/Dg
 ZNu2K7W/x7jbZuVnvTmzo3jpVfuHS6yp0MT54n/UECwlb+tIZLLKNLn8JdTUVviuOkym
 d2n4/cP266CkHiv6cnrNabvaJhZn6Hh2RJ5tu+oZzqojxe7gV7Tmpm0bmX53BE4aT+FX
 FuR67XG0Ny7DEELwDbvRAeQzucS9uvaohoxm1YrXUKkyhNbFw41ABFhDH5qsna1CGDd8
 DVNmrZFVMUh0Grt6Q++ryrR0wFm1vCYzyq5IN0jovlRDjbttYmyWQqUrHIqM2eyzAkMn
 uGRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrdEQ3fAudT05QoasAXTSD5yuPFOQP//9NoQ0z6UJA3MT+0rRYpioYHXWyvz3lVbD3b1C2iQA7RGV3n9CARdee1N3LZns=
X-Gm-Message-State: AOJu0YzHEQo+ktrGlBAyl1KW8rORbE45I8sFCUNIOs/14Z+6yLKgpoIH
 iZmoj3f3SioMAZTwd5mztTw9sKwdVGJ0YlFGxIPszVmdQiV4bXpD7c+yteEcFh4=
X-Google-Smtp-Source: AGHT+IE93PdhA9eiuK2XSgH0fGPphGHMkcaJV5NVg5SdlXMkJiQtMeXq0ZX9eBcudkZOQrD6zDYUrg==
X-Received: by 2002:a05:6a21:4984:b0:1a3:df1d:deba with SMTP id
 ax4-20020a056a21498400b001a3df1ddebamr3311542pzc.31.1712767120781; 
 Wed, 10 Apr 2024 09:38:40 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 gw13-20020a17090b0a4d00b002a5d684a6a7sm1336794pjb.10.2024.04.10.09.38.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 09:38:40 -0700 (PDT)
Message-ID: <be265499-fa39-4e82-b1e9-f68b782f07e4@linaro.org>
Date: Wed, 10 Apr 2024 06:38:36 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/20] misc patch queue
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zack Buhman <zack@buhman.org>, Keith Packard <keithp@keithp.com>
References: <20240409193603.1703216-1-richard.henderson@linaro.org>
 <dfe80894-8a1e-48ab-adbd-9398f4ef156a@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <dfe80894-8a1e-48ab-adbd-9398f4ef156a@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 4/10/24 06:10, Michael Tokarev wrote:
>  From this list, do we pick something for stable?
> It looks like
> 
>   tcg/optimize: Do not attempt to constant fold neg_vec
>   linux-user: Fix waitid return of siginfo_t and rusage

Yes.

>   target/hppa: Fix IIAOQ, IIASQ for pa2.0

This is for hppa64, so not further back than 8.2, or not at all -- hppa64 is really still 
in development.

> 
>  From sh4 mac* et al, this can be picked too:
> 
>   target/sh4: mac.w: memory accesses are 16-bit words
> 
> but I dunno about the others:
> 
>   target/sh4: Merge mach and macl into a union
>   target/sh4: Fix mac.l with saturation enabled
>   target/sh4: Fix mac.w with saturation enabled
>   target/sh4: add missing CHECK_NOT_DELAY_SLOT
>   target/m68k: Map FPU exceptions to FPSR register

Yes.

> A long(ish) DisasContextBase series leading to
> 
>    accel/tcg: Improve can_do_io management
> 
> probably should not go to stable.

Probably not, or at least not further back than 8.2.


r~

