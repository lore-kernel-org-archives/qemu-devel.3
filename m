Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45631C9EC8D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfI3S-0002Zs-MW; Mon, 12 Jan 2026 08:33:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfI2O-0002Fs-AJ
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:32:52 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfI2M-0005N5-0T
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:32:51 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so44047255e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768224767; x=1768829567; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RbNI8l+QGUm8VuLtby8HDfCnJl5aMBIlx90I443we9U=;
 b=ormCzMmY/nC/dGOuMrs2dIC8FeRze/4cS73GHzABU2lTZo1v1I7jfidcQ1vYCrNUrr
 ch9cThHotkgNm/vjszrMp8tJMQ6cfgEkMGLuI389LaHT820zzdjgRZ6eYTFWZL4hVC2l
 GbgIWyaOy/GIEcyJcuvE2V8+U4QQCzehF5LB3prmDXVRGmxTPo5r5ItHSltL0l3EgoIv
 wc25AeB3qh+9EMiWo/6kY8RCAayxeE9KWn0Z6+MwiD8p58H4IPgXpWUkpOaQZGQDTT4U
 lbhIPknkPmeqWgIIRDyS0lBsG+7YMUfohjd3tCVqXBgNqajxc/JeDcdFnZQSLfWE+FA8
 ZBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224767; x=1768829567;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RbNI8l+QGUm8VuLtby8HDfCnJl5aMBIlx90I443we9U=;
 b=PsVDWmiwbsQteO6uMqwJ7B7ncIttCj5woRRaoXJujsXSy7GJcBnSQQB3TL/njaC2QR
 UQt5Ko4GF/EbM0bXuVw15Q4RI38JmXFq99zah6AsFCt7uzpxy7Smg5WrzcPevWBnKnPP
 196ZrQ5EW8uHd6kiDBDEkj4HUvVsNkm1JEsdtq0LXeesDS7t3nqaGhUEmwTs9ahoSBnR
 fSX1NEsoxMglACs5ssOK5GOEFrJ+d0/GUB4nnmZ4134CsmVcW1kcWrBBVy6SWp20r+1O
 CP5dNn/qAQV2YD+1MHgPepcE7Z83vFYAdG1DA8DNXUzUxXX4IgOs6ftZlZXJhIxCXTuZ
 ho3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIBL5rk7R8FpLWDrfiY1UK56AcT+T9S2FFtiah/+HYv9i+p0hYf7glDIyuDt8Er958AYv1x3d9Z4ak@nongnu.org
X-Gm-Message-State: AOJu0YyqCyQuKgxEUA+grlzkF1S9mHWcDg5QFFT2L5lYb76Yk3x2BsGD
 WqVoyyr/pRuAmmw7u+3iObE9GU4Cqi7sWmbi5HgxlmHjpxwgBD1p705U5bn9o8Fk9uE=
X-Gm-Gg: AY/fxX5jEk6WoxBmmxOPneNOeuW6rqTFYJ/h6Q1BYSIZ1nal+JobxHdiLL3UmWAbLjY
 B2txi5g8eg+WBq6EgRol5ZE8Qag0DxFoaNNq3m62+VfuNk++qcWA38e9VbJ8jX2uQKlFtj9BmqX
 4Zz8kDEF+z73b5+h5TKNQ8i9hfCIT+xIPOWLrcuBTJuuh6kErx3QD485li/fp2DqmQSIxBAUlJn
 wyjR8Qiqo715S2C6LixNHLudEZ0oa3UnUfLt7OMBCidiClzOUxpFI0UrdiKkztpvzhp6Ghi6hrT
 pPTT7TdYLC3yKhVKCjruDUwFNC+DyP2dzuyvhc4eoifF0HIZRe5r9kDr+holRPGDiymXcvKuM0f
 f7UQN8Bccv/1HCQI5buQZsDAvttIleegIcIko21SH1TZ0JdPY99vuTwenFAXHvOSBAPy93chZ6G
 3Sj1aHp1H92F7c9ex0Ra6bSvOsblzhXWKNfxfqQeoOSHiOzTJKpwwlFw==
X-Google-Smtp-Source: AGHT+IEKkTaa+szWIGXmebSMRdVA6GmYqVTsudKkGbleMZWpPX6WURBJptLhZbWQRhK8sQYI+lxv8w==
X-Received: by 2002:a05:600c:1991:b0:477:b48d:ba7a with SMTP id
 5b1f17b1804b1-47d84b4119amr186780325e9.32.1768224766924; 
 Mon, 12 Jan 2026 05:32:46 -0800 (PST)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8718b1a6sm129733335e9.13.2026.01.12.05.32.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 05:32:46 -0800 (PST)
Message-ID: <627a21de-9737-4271-972e-d932730324ac@linaro.org>
Date: Mon, 12 Jan 2026 14:32:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: Fix build error
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
References: <20260112123146.1010621-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260112123146.1010621-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 12/1/26 13:31, Cédric Le Goater wrote:
> Newer gcc compiler (version 16.0.0 20260103 (Red Hat 16.0.0-0) (GCC))
> detects an unused variable error:
> 
>    ../tests/qtest/libqtest.c: In function ‘qtest_qom_has_concrete_type’:
>    ../tests/qtest/libqtest.c:1044:9: error: variable ‘idx’ set but not used [-Werror=unused-but-set-variable=]
> 
> Remove idx.
> 
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/qtest/libqtest.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


