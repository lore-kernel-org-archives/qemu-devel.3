Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A537BCD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 00:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX6yG-0001R1-4A; Tue, 09 Jun 2026 20:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX6yE-0001Qh-Ol
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 20:39:03 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX6yC-00087M-I3
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 20:39:02 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-8421f0e9c5bso2827436b3a.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 17:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781051938; x=1781656738; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+FY52UL9ljOj+o26zMfRGfGB94OLL9pcUszNxj/CUss=;
 b=RoFlJy6rZhEOOZx0hOAWsovEck1cAxf4zKJwQ14JJuIF5+oLWPBdiMWmkdm5Zs32a9
 FXHaDuWL4JXv8qbJk5/D16t9XsciIcUQuC1NfhPT43zEUjBWYjOaaKk2YpbZ3jgczY3v
 i/U3Ih+GCVvuYmoHFg92/IW6rJG5vPggy2Pusjxd40a1YFzJcbwfYVQ1sEdtp834q+wX
 Kqt1oZ7Rv2dFNez8ADSo5etDUa3t83qfpMnigzM9kd0Gl+0/4FmOmP0Irg9AQwcPfjbA
 XkGqhO0YtrnDAEi+OtRk9cZW+kD2yBypyHiaJu8WayPylhHrpkcJ+p793nutvKCxP+Nd
 Izjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781051938; x=1781656738;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+FY52UL9ljOj+o26zMfRGfGB94OLL9pcUszNxj/CUss=;
 b=Zp6Qw7lUZWzFZ3Urq4voIfOFxoNwz1IdvTuuWhHiesuGdQlokYoy1s/EJCDDzJ4FYm
 k4tpMItcKvjG0r7//hmmX8V9olgt5XA0mUZg+hWZ1uKFwFq9NSRSUozvTYm4hVoCwJll
 /u6lgZcEJ4c8y8MIodg1uyDIKRTSKYs4lZc+yavkVXnbijaTNLBKDVKoN3e1195Nidgx
 blUIOtntoOnhnVo3UcnFtPHno+rktq4eJ0OsBK5SvRy77QDCZGGFHWCIUCrwyUfRJdx2
 Pfj6ZghJBBjxg/xloi8kJYxqcm5wQo9CEChPBacMgsYsjEqt5xSfYXdaQ5wzlktc65Vr
 aLKA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/rdDZYk9dY/PFdLnxxyBrJ/piWoJqHqR4W00TZ6qmKu9/1e2kI8KIG8XM8XOFGqbhP23DyVuhTsseJ@nongnu.org
X-Gm-Message-State: AOJu0Yx1vGQ31PH0J3any2ZkgoU6CClsnu/39DgJ+p0JVQ81ik+Hf6AU
 lPHoZ+CXv/1UO3Nhom92iJCqeCf+N3wQdKZpGOlggDygueqTOC7je32pnpRAhk1rRTw=
X-Gm-Gg: Acq92OE4NpHiVxR/OWB0emgSK5rPfm3UDPYAzwMtBXZ7L39dZvLX58aiuk35xgGg7MN
 LihyNqfCjmSwiHjJfz1wjC++dt/jcw1NyTmJYbb1zblLUDNKAjZpgRbiM+Gwe9+W36yzf4wb/v+
 0ijgLQs4fXHCcqbS+RH3/bubwvCD/o12TKvq/OZZynrXRWVezvhyoSy8L9CxzCRAd8yoZbfMwiu
 ev0u1qyu+49zEIcOC8pn1bPi9D9DUKWL/dz5BRtFH4g5S/wlHrmcv43u6tPAG6p/AmFq6AXqnEH
 dyqBZAq4tnS1lbwGG9YCNOT7Z6I3mNk99X06OtX8Mh/zgOSxsiTPVXGq4qkdVFh1UmRV5SW0Sy0
 Zwvyb6sysOTOHccecdmGpsHdbzDm5x74ppLFORqXhYDDG3VFawqVQFpctZLGk8RUwNIA+7ykeb4
 kr6cbZV/w27kNKMyM1Coj7RgROhvpzXPC9kDdR4/z3VuLgkYo=
X-Received: by 2002:a05:6a00:1304:b0:83e:f208:b113 with SMTP id
 d2e1a72fcca58-842b0e1c959mr24170802b3a.7.1781051937919; 
 Tue, 09 Jun 2026 17:38:57 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84282915fe8sm22827891b3a.54.2026.06.09.17.38.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 17:38:57 -0700 (PDT)
Message-ID: <da486ab5-9745-48d4-99ec-2c40b5eb7dae@linaro.org>
Date: Tue, 9 Jun 2026 17:38:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/27] tests/tcg/multiarch/plugin/check-plugin-output.sh:
 take test output as input
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell
 <peter.maydell@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-3-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260609214745.772536-3-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/9/26 14:47, Pierrick Bouvier wrote:
> Instead of executing test, just read it's output from a file. This
> allows to standardize how to call check plugins scripts.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/multiarch/Makefile.target           |  3 +--
>   .../multiarch/plugin/check-plugin-output.sh   | 22 ++++++-------------
>   2 files changed, 8 insertions(+), 17 deletions(-)

Could use "done < $test_output" instead of cat, but

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

