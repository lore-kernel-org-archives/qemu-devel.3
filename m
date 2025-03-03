Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864DAC282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 14:43:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp70H-0003sN-HI; Mon, 03 Mar 2025 09:42:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp70F-0003rP-DZ
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:42:43 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp70C-0004wR-Rt
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:42:43 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso28843335e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 06:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741012959; x=1741617759; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ILFNrG5LIonTMGJ0xu5gDy49lD5moB9+kTODvXFQcmw=;
 b=M/ieqIuwDmY8AaboiYLwH2JfmKhD0MKzBMUxdUENNVjrwOL0J5hC8F4c5IIK/+YhBz
 aipqcc6c7JJE4IgwxBWcRVszfC/xYaHrd8JQo/uMSZnOyxkQJ90LiWtg99Bso/Nru1Pp
 xyukmNirUfN30FDTeHfwp24GwzfqJiMTnzLZYk7k10tTNsnLgjkJMnKLXOJC5sWIrLi4
 07FrLgD7ljXZRRKF2obBJpJxX9s8HfgQoXPRBFOmHj9sr1f5yazE5+pX+ZIZXi69GGhU
 eZcAjdMf40qlZSTm2MVe/RzhZ1PWm9vOYwqrEERM9lpdg4JZ+OyPuLdZMbZ13VJKOkbN
 a0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741012959; x=1741617759;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ILFNrG5LIonTMGJ0xu5gDy49lD5moB9+kTODvXFQcmw=;
 b=mLgrZ61T7I+mu0aRlfdJ9hMCZmM/Umr7jAV5dPKnBJnluSGfd87SExkzWzjMAFFEQN
 DbtsfExOdKTtqvvMbFxV31aAo/rPJF857N2YDHeewKold4Z/tJX1O2C0maCYv2d0gbZ8
 pUShhgKB/Mpu887yhrMCFBgb2gvpVZF9YkIOe8QObTf2Tn0hin/0CEd8RX9VJibgsccd
 Mzoqb29XygNYPZwLIa7Ui6A7f9rf8wSmc4i3RWxxdynHM0DqukktlwcZmRiRez+DlDlZ
 Pqyiv1y58WY6gwyzoEjwmj3JrHSfLw33fnetv7746IWQW9p0CRQpDS1FPwV0errqA+ym
 RWFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtRZOqRD23dRoPVWmintEa8LKpecEjd7y1KDKJW3xU6EcZmod2bCLJGMmv8eWenMojrFbcq17gPLkn@nongnu.org
X-Gm-Message-State: AOJu0Yxdjc8Xltd5KJ2Uyr6E8JFICb+qKQGzzNQ1VQVvGzwR4rB/Gd5I
 G0DVGEZYXMExltYHkls3P6MdAwVv/kZETmUhOgfDsWZp1kC9oN9OioHj0LzbmgIvfIJzy103gsd
 uuzJSXg==
X-Gm-Gg: ASbGncvyYzS1vSSHhBu/Nu/tmmPs7j/N8Ez8GxpLF7pSAakadl51fT2b+RCAUQOfscL
 MROAXR87URBGb+6mRQX3vcl5VQxup1IHcjId51Euyj2s1nz2gzWgiR4b+C+yg/IrbTiKVpjzMp/
 9AUgETdvm/aq2OZPcGZ/Uu5l789JzlXbcg1jdR5VGUkDWDIYsGSpz2AIVULQ0yF+jpa7D1G+xkG
 OdfvqBsLcv1JvXLTpIH1zgRMraNGIwqCsgEprJcBB2rI9j9VTkCgZ5Cw6/mwyeOzAxHbLcV+pkw
 dnFQyYh/lNC2TPrTT/q2+nZ280rNlRuhHNsMmP1SGp3vzFXgRKfGeBLed2UXZHxQaDkO9bKkVgn
 GhvvxIXjcWtps
X-Google-Smtp-Source: AGHT+IF3gPssxI3TY8xPhxi/5kVAVXHdGnhob9n9DFKGWn3ASrRTRBuUb7TtOtMPz9FWqCBCr1RVvQ==
X-Received: by 2002:a7b:cb10:0:b0:43b:b32e:f429 with SMTP id
 5b1f17b1804b1-43bb32ef8c0mr57907765e9.27.1741012958852; 
 Mon, 03 Mar 2025 06:42:38 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b736f8034sm168592555e9.4.2025.03.03.06.42.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 06:42:38 -0800 (PST)
Message-ID: <62cde4bd-ecc1-4dbd-981b-2998cdf66dd7@linaro.org>
Date: Mon, 3 Mar 2025 15:42:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/macio: Improve trace logs
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, qemu-trivial@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jd Lyons <lyons_dj@yahoo.com>
References: <20250222122850.9D8B84E603D@zero.eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250222122850.9D8B84E603D@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 22/2/25 13:28, BALATON Zoltan wrote:
> Add macio_gpio_read trace event and use that in macio_gpio_read()
> instead of macio_gpio_write. Also change log message to match
> macio_timer_{read,write}.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/misc/macio/gpio.c       | 2 +-
>   hw/misc/macio/trace-events | 3 ++-
>   2 files changed, 3 insertions(+), 2 deletions(-)

Patch queued.

