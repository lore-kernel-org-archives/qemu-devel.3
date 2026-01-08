Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB5FD185C6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 11:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdnok-00013p-2r; Thu, 08 Jan 2026 06:04:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdnoi-00013N-RL
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:04:37 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdnoh-0000zp-8f
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:04:36 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-432d2c7dd52so249505f8f.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 03:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767870273; x=1768475073; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X/YBB3r4dbFeloLRPPKL9MSyCHZ+P65JTiWuunTroB0=;
 b=ZT6neU3sHsWrj3Ty+HjelmGSgSQi2HFKUHOStn3U9ZiUCUZvlScemKFdtH5qlQ2CkP
 f7pQmNhZVFxBWehTeErU28Hb3OfolDItGLQitOwoqjSQGH5U3I2wFz83SHOrnsvmWhv0
 cKxpkokGV597RCHbTdAxrM0rMuMMhKIPiOMiDjfNP6fXTjdPz1UoAPLIlz+GwhYvL38K
 OtNlZn07AnYo/zZfoG6HagicRJaIY54AA/Bh4D6m3r8RixKmXsKtAlNQPCiBYptLupea
 sqkk+tCRP+qU0M+Jn0rzAZtmyDrEfkhWS1b8vRTZQopPuJ9sGX7WYZRCySdclCuXWGEo
 mAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767870273; x=1768475073;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X/YBB3r4dbFeloLRPPKL9MSyCHZ+P65JTiWuunTroB0=;
 b=vWhOUoB62tYgB/mn7Oa3Ut6CX2MOjv3fMhW+Pst7gpDg4T9aeVAiqD62+k3cGWmTZI
 c9a405ePGm2rYfNjGOJIzqaEUFtls91CrfbcMR3lkHlelEvP3mixFfsTrD7JPxguCbfL
 b+m1K0/aFoh1hsDjHT234EzccZblTh3HR45TVYKCGruSiiJ4ACjXkl6EmEd1CkmlqPXx
 t7r6kLZTIPAySd+05lmuXsJ0iihaGHYzwC5cbwr9gQ5Sm7QF0gcm5wNgKZpFcSnLZCbN
 s6MkxeUKB4hsk1T2uUTF0niqKiUP/FonYd9wF9b7CjERpmbDfLKebLnb5IW5unmeWCtU
 otIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/dQvYdlUJ1S76ds0peEEerKH7zIjpPb7B3pRKeDv7OSRLbTpvjwhO49IaoJYwvhbzwSYYA3iU4lMV@nongnu.org
X-Gm-Message-State: AOJu0YylV1tBcYqHfKZzFPNNXoKpP8UjBJ2YFdZqb2CnmL71F/OpIYUq
 kMgJyRLIgFp1+sj2nuAuuuU8OuQu1oBfIfubfx1YpVYs7MOJxOAC96c7+eRhzrLzOh5muqpii5a
 PG/UXUHM=
X-Gm-Gg: AY/fxX4MtWCrvwp9wVg41McxpAy/equj4CM0zcojMWXuXTTbzjNrR/JY5Q52Qj79D85
 oQjZ0u/BjWMVn5wHpZBSkoOv5/AoICgSQA5HAZphVPLsq2WgH91kIrqSnyULBOq6CylBhQzw0yB
 oRS9BtgVhCSkimu5fIItCDJIKyfKYREM0fXQwht9ABEZlJj7IuOTt32jA25INT0GGA27GoF200d
 k4jjiENPQrIILdp1MMHjHzvOARycDj6HyagwIoEo5M4l4NCmETTUq38TryM0fAyXsY6BTM7ET73
 qURdhiqinVBdGiqXVupjl3vM12e+r1M5tRA+II9JwYWEPmcHvvyLtWQk638UCghSjgpPhQqWdX8
 adbmzikJvB3ZrxGu/cWeV6XSn1NVF/UqR6lJSxVzXkdl2xga6FpFkjRzBmL/CBPHsvOeEz6iyFr
 TqBntV5JDir6vrLt95RWJdROy3mtRdJBKdHlxt33RvDvYSaGG/vrB0vw==
X-Google-Smtp-Source: AGHT+IG3rWA8BsZOCWq6EdEmvSfeSv3gyae8wbs5Gf1p6mXclBAJ7I4tdMMs5M9u9KBe8ujyfmq1lg==
X-Received: by 2002:a05:6000:2305:b0:430:f7ae:af3e with SMTP id
 ffacd0b85a97d-432c3798309mr7177071f8f.32.1767870273368; 
 Thu, 08 Jan 2026 03:04:33 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0daa78sm15730962f8f.6.2026.01.08.03.04.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 03:04:32 -0800 (PST)
Message-ID: <baa731c6-44eb-483a-a0f8-7370370728a0@linaro.org>
Date: Thu, 8 Jan 2026 12:04:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 35/50] accel/tcg/runtime: Remove helper_nonatomic_cmpxchgo
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-36-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260108053018.626690-36-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 8/1/26 06:30, Richard Henderson wrote:
> This were only required for some 32-bit hosts.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tcg-runtime.h       |  3 ---
>   accel/tcg/atomic_common.c.inc | 20 --------------------
>   2 files changed, 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


