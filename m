Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244CBC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 10:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm9zt-0005bY-2a; Mon, 18 Mar 2024 06:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rm9zr-0005b3-3K
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:13:35 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rm9zp-0007G2-IZ
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:13:34 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4140eb3aeb9so6713185e9.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 03:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710756811; x=1711361611; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wcwn+sUR+Od11Wt0mE4L+CboL5vA9UhwnsgI8ABE3Ps=;
 b=McH0tAslksqRaDweFTded5dNH846ZG/xUfN2xYLuYtcHvjD7f3rVeN2cPrkqg4S8pn
 erJpcEiKzfT+H0dqpCmpSnyqL5ttXyJCaWWjVhaUzlrPeXmu5Lu0HqrB1IeLDqKzenCT
 +ksGU4UGJETMUMgOSee+uhA4LhELktfWBKCWnZyd49y746CV53BmX9SCibCE3qqVqQ1z
 AZuz/KCaFQ+RW3bfRnQJpXQH5yG3Ck1P34qOvJ4OLey+fZ2kMvNQkbXrZmBQrDo9HjRy
 ZiE7IJJ5rCP1MmKTWJ1bwzrF0G31eeik0vfCINrBq7z8P7ALXpDyCbw6Ip20wVFfme99
 1lBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710756811; x=1711361611;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wcwn+sUR+Od11Wt0mE4L+CboL5vA9UhwnsgI8ABE3Ps=;
 b=r/n8i1jJ+Z9C6aeIBHSDetKzcVXZzyt9EGfAQQA+tM3JDMc8G9PSjD3aIqLVu6EXUv
 k9UPYp5EvWAxjZJOVm6D4U6FqW/A8GdQu3ge87mkNFxJHFFo9VjjCekn8x5OkOz31gBV
 zA9bdlfVEnfCSXK9uW1SM8U0ilfZYzJ1gBc/WQEBCZhq2oT19B4+EPyhwYVRWZzdNOyv
 5g6RZG+GeylVu5dhnahwytcOhTiIHEOHJ7I12hRNFZpmCxUbHZRQYSSa0sizHMtR+xpN
 UBvkI0aTuMEzsLnsHwMO0S3NOGO56HLgAXhOJH1WtD2Q5+qnNFNvV0d89r39bNMbBD2E
 t2wg==
X-Gm-Message-State: AOJu0YyvvezYmK0oVsdRR7DI2BvRxxov/92e8pEWoiiWaluCvsmg67yn
 N/nogp1N5a67pjCFPf9f+R6XJmpsPQ9ZUkCRBjrZtKJRTs7DXRSrIMSvOMzpl+S/uqQFFjHaA+1
 m
X-Google-Smtp-Source: AGHT+IE3IqTn/I3Hx+m+aXBTjf7oqFaAKabHAJPMs97/TOln5XAZYalrUZq2PHBUyTxwB1WXBUjxGA==
X-Received: by 2002:a05:600c:46cd:b0:413:fec5:2982 with SMTP id
 q13-20020a05600c46cd00b00413fec52982mr7272457wmo.0.1710756811290; 
 Mon, 18 Mar 2024 03:13:31 -0700 (PDT)
Received: from [192.168.69.100] (vit94-h02-176-184-29-165.dsl.sta.abo.bbox.fr.
 [176.184.29.165]) by smtp.gmail.com with ESMTPSA id
 ay18-20020a05600c1e1200b0041412fa398bsm1566364wmb.5.2024.03.18.03.13.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 03:13:30 -0700 (PDT)
Message-ID: <1b903c28-f427-49ec-9b98-c96d0caf66b2@linaro.org>
Date: Mon, 18 Mar 2024 11:13:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 0/3] ui/display: Introduce API to change console
 orientation
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20240318100543.78846-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240318100543.78846-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

(Forgot to Cc Akihiko)

On 18/3/24 11:05, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> The idea behind this series is to reduce the use of the
> 'graphic_rotate' global. It is only used by the Spitz
> machine, so we could convert the '-rotate' argument to
> a sugar property on the PXA2XX_LCD_TYPE model, but since
> the Spitz machine has been deprecated recently (commit
> a2531bb855 "Deprecate various old Arm machine types") it
> doesn't seem worthwhile. So just extract the API to change
> console orientation.
> 
> Regards,
> 
> Phil.
> 
> Philippe Mathieu-Daudé (3):
>    ui/console: Introduce API to change console orientation
>    hw/display/pxa2xx_lcd: Set rotation angle using
>      qemu_console_set_rotate
>    ui/console: Add 'rotate_arcdegree' field to allow per-console rotation


