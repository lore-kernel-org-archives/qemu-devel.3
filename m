Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1B2C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 15:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWGz6-0004VF-9j; Tue, 23 Jul 2024 10:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWGz4-0004Rt-Hd
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:59:22 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWGz2-0007BF-FZ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:59:22 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fc5296e214so232335ad.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 07:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721746759; x=1722351559; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x6uWCaVoX1g0JE6gHiSmxw36WmqwjpOjf2hXA8O1p/Q=;
 b=Zexfm3gxtcLjORyit36E0uW4GSa5wXRqWwcgpnZOXdiYK5qOQtixE0DucDSQ8DBntW
 YCmHF31XwiV/orZxa3nQ9UziMOw8vbLjn8Yh9ZIKl7q3zxp4OK6P2h3W936OjDkGpOHm
 cPUpy9nq90DdFTGtSo3yNDVVgY2Lo8zNaMfiSdKcWpxauklLt0pVSMwlPE72GlAhyyAt
 lLQ0vRHoG4z0G4xrUO9efqJwx51pEeJqkNW75KVZOvprXXvyZgY/AC3RQHFwOWuzd6e4
 QvjLKgXWspsIS0nWjne5ANri69mUE9+C/Mb7OtvhKv9JtDPH1aVSykyeBod6NOKcBKlg
 Kjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721746759; x=1722351559;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x6uWCaVoX1g0JE6gHiSmxw36WmqwjpOjf2hXA8O1p/Q=;
 b=Topsf1yEO9X8qFwZ8VNDtPHB/yZze10LSGqAVSJT4ruXmKamUerjp4v9q3o7z+k5dL
 qNkOkc7MQGGF6TkKiqaqKrzSXupoSy8dp52dKd9D3OWXq9lA5zijtxI8B0S3OHOOdFD1
 bi8j1s9OGasSGztEp4hNYiXyGhJPi9F70BIslNhGgRl3UZ/BHXJdrafD446/MqEebNv7
 LOgX5l7/1PSE+pXeYSMLFUZ7U3ub5hGvG+HYEoOqIKHkTpdetVwBohe+3wK3sX9TRZi/
 7NNZlLr/1CgnySQ7bb9Z19yhMDUkVZB7v/K5NkUSSfBx7jhf1/XF3+eWvUJbwiXo4NhW
 H4hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqQAkJstdwrUK6qe5hncmMhR/6jpfHkEWKHwsgwl5mLamhR7lc03g4lCNEIiEqIqkUxTSXR3/271nndAUBuFad4GfB7x0=
X-Gm-Message-State: AOJu0YxgZV9v8k46x6F5eFyZlaDUeQ5rjeadK6sgk+08j+5jnUcWdflw
 YhjUluGVBZUqJuUbidLwD32R/xETRqvJLxrooMcTkEw7YXkCH2q2vErU1HbF0Q0=
X-Google-Smtp-Source: AGHT+IHEwNUn2iCjw+dEVWxPc4crtmm2YEZv3II5mGSit6snv51lFP5mUPqlZtYdRZViS+fAZ671Rw==
X-Received: by 2002:a17:902:db09:b0:1fd:9e6e:7c1f with SMTP id
 d9443c01a7336-1fd9e6e7ef9mr68803565ad.56.1721746758577; 
 Tue, 23 Jul 2024 07:59:18 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f290eedsm75868375ad.93.2024.07.23.07.59.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 07:59:18 -0700 (PDT)
Message-ID: <6b2274ab-1e05-4ebc-ae02-1bd8cc82791f@linaro.org>
Date: Wed, 24 Jul 2024 00:59:11 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] Ui patches
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20240722200619.135163-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240722200619.135163-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 7/23/24 06:06, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau<marcandre.lureau@redhat.com>
> 
> The following changes since commit a7ddb48bd1363c8bcdf42776d320289c42191f01:
> 
>    Merge tag 'pull-aspeed-20240721' ofhttps://github.com/legoater/qemu into staging (2024-07-22 07:52:05 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request
> 
> for you to fetch changes up to 903cc9e1173e0778caa50871e8275c898770c690:
> 
>    chardev/char-win-stdio.c: restore old console mode (2024-07-22 22:25:46 +0400)
> 
> ----------------------------------------------------------------
> UI-related for 9.1


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

