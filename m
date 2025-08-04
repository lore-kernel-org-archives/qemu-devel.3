Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF59C87FD1
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 18:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uizsr-0006wY-6p; Mon, 04 Aug 2025 14:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uixtz-0002Em-6V
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:19:07 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uixtx-0001zf-GG
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:19:06 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2403df11a2aso29714055ad.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 09:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754324342; x=1754929142; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=svuoKhcAPO8Hx11IHq6pzcmbRY6dBIJmUK6cwetPPME=;
 b=r8A95wcqbmiyvw03x5IrpQMtZZeQX345kVSs0irKNpG+U1Ttf3fAs+PXKdHi24A5db
 4HxCYOFpm8GcozpuI4OpoaIRx0+uFZRlR53JSUpG0hwC+ey7JtqoOe0mYRy1qoipo4t8
 Nsp6XHfBph5bFXzPCpDlIPwhQJyN9uhqt+KSkke0Mcb3uUxlnCLBlqvQ22u5A2keXQ7M
 Bo4N2OVNvMGYOvzGYp6a11wN5tjt/tjq/ZbP7ioMVSCawuNCNojJN0J5krWQ64DEFY+6
 eoo7t8lUYkW0Mofa7qCKibMhF0Q2Gq9V8mR4yyaed4o7o1zjg3bP9/Jw0kfscqt5lX5C
 96/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754324342; x=1754929142;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=svuoKhcAPO8Hx11IHq6pzcmbRY6dBIJmUK6cwetPPME=;
 b=f5/GCnA/CWfXdsEAIXi9W0WOYLuNMr8ISeigJlo2ONlXzkKiItcxJwb+ymrpV8ej+X
 WGAZpj/z0FpQ8GgUTgALmW8Dxc3SqkC6zvaabQdvr3JSxvhtBjbfzLeKh9QnPatVEBgS
 ozPsBEIM7CSg8syAHk9gVTW4L+KqEh3jSesWclfM+58yuS0gwTro0UT0qlkTYkJ93qDs
 g8+Vx+A9I1Ebnp3tX9bebjyukAcXgtdNeX7wZotZInnSojTL+eQY1Ai4k4BwIvj0HIWg
 ubzFWLMyMsdXOAm3U+UhyjKRBbWWh3HtGjyHWtqaRxVht1vyThyk2pNFdJ8yR06LnuuE
 LiNA==
X-Gm-Message-State: AOJu0YwgSYiPB4peB0+IF47CfLlYc/aCau8VwJlb6VAChpEt5nt5XnuG
 fDA2SIqh84MzWa/j33kXc3mEyqQR+TFEsV33sMHnG7RKkOD4g1gwO75c+4UGSnZIFCHy072B0k0
 Chcr0
X-Gm-Gg: ASbGnctMhDRcco4GAiopXLjgIw3VadSEKmhYv6TCR2+4dwptX+lp2M+FQUVWB0ncYpG
 QeJ9hQOVZp43gvqRYugJ6MpGvYMiyCktOfYtZNZdc9CUwX8ZJO5NCKowXsVyw1PICJGJZRo0Xsu
 IzE7QXKA8KI01Q1bC5LN5sVLP2ZOaOoAgzwEFWG+t1EAfJ8g3TP5kthkcyFKfSw19l9rxrti7Qw
 40Pi3b2Vs290PMLEh0wRIj1PUGgKcU3yngeDrN8ALtCL7pMt/pgUm++CRWC3/vfuEC20tgQIrIw
 p73Y7tmA7Auct3i8taBQ304FZMMh1rIqvS57nSWAW5IsjgAlDN1p+v6Fl7EUhnc/1whNwjMruME
 eWUlQMYTPBIz6AKGbhbPUgD4a8RPUfGJiuzs=
X-Google-Smtp-Source: AGHT+IF3KUa8vNf3NfGbO5v4OscOO8fqpoiAkhVTKMJHirCFmZbN1MO4Oip4bwn9UsVoVKXW4rmdCQ==
X-Received: by 2002:a17:902:e84d:b0:240:3dbb:761c with SMTP id
 d9443c01a7336-24246ffbce5mr171200695ad.32.1754324341917; 
 Mon, 04 Aug 2025 09:19:01 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899a814sm114178525ad.117.2025.08.04.09.19.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 09:19:01 -0700 (PDT)
Message-ID: <327b7306-de98-40db-a2e4-27b4c9806a5a@linaro.org>
Date: Mon, 4 Aug 2025 09:19:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] control guest time using a dilation factor
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, richard.henderson@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>,
 peter.maydell@linaro.org, philmd@linaro.org
References: <20250628002431.41823-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20250628002431.41823-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 6/27/25 5:24 PM, Pierrick Bouvier wrote:
> Depending on host cpu speed, and QEMU optimization level, it may sometimes be
> needed to slow or accelerate time guest is perceiving. A common scenario is
> hitting a timeout during a boot process, because some operations were not
> finished on time.
> 
> An existing solution for that is -icount shift=X, with low values, which will
> roughly map virtual time to how many instructions were executed.
> 
> This series introduces another approach, based on faking host time returned to
> the guest, by applying a time-dilation factor. Time will go slower/faster for
> the guest, without impacting QEMU emulation speed.
> 
> It may eventually be used to fix some of the timeouts we hit in CI, by slowing
> down time in VM, to be less sensitive to varying cpu performance.
> 
> v2
> --
> 
> In review, Paolo mentioned timers deadline should redilated in the other
> direction. After going through this part, it seems that arrival is always based
> on one of the clocks we have (which is dilated already), so I don't think we
> should redilate that, as this would create a discordance between time set, and
> real time when this happen. Feel free to correct me if this is wrong.
> 
> - keep start time per clock and apply accordingly
> - apply time dilation for cpu_get_host_ticks as well
> - use a default factor of 1.0
> - rename cli option to -rtc speed-factor
> - forbid to use option with kvm, as time is not provided by QEMU for guest
> 
> Pierrick Bouvier (2):
>    qemu/timer: introduce time dilation factor
>    system/rtc: introduce -rtc speed-factor option
> 
>   include/qemu/timer.h     | 60 ++++++++++++++++++++++++++++------------
>   system/rtc.c             | 11 ++++++++
>   system/vl.c              |  9 ++++++
>   util/qemu-timer-common.c |  7 +++++
>   qemu-options.hx          |  7 ++++-
>   5 files changed, 75 insertions(+), 19 deletions(-)
> 

Trying another ping on this series.
It has been useful to reduce number of interruptions in a guest when 
running on a slow machine.

Regards,
Pierrick

