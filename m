Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADAAAF3ED66
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 22:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBgl0-00034M-05; Sat, 11 Apr 2026 18:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBgky-000347-VU
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 18:24:48 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBgkx-0003xb-ET
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 18:24:48 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso30885785e9.3
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 15:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775946285; x=1776551085; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CxLyaVB2t2xEPXpvFSlqEcsMBMuKLwPIjxP5Xi/fxQM=;
 b=UsYjKCrXFNUBMm6WZV9NeltEXwLEXLFXZ6uQSV2ewsKFA8Sfnq/Mez5u/KiDRzipPM
 GzLsTmmUKwwChhzcZQh0sMGUCPxOP9XRR0Cm4e/GibHjGgD+WHvX6RMieyu04EF+r7nt
 8l8w4iupbkYP5RCharymFqzMRIaV1xm3QztTm5N5jUAfIjXscNUaL2o770adkAZnbeee
 E0Jp3mqssCce+heksT8Nb9smV96Ft3PGf+9iQSxH0RclkQGnCEFPAdU3DtgtcqflI6Pz
 JhCmwWIPhc1NhTz7+3ibsCeTxVgM/nFyEjhC8J9WcRg9rTLRof4FWPK0v3kzUGugCYVm
 ejBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775946285; x=1776551085;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CxLyaVB2t2xEPXpvFSlqEcsMBMuKLwPIjxP5Xi/fxQM=;
 b=bBFbpfC1ekI1rhoXPnyScxOcSccudH5ZqBYpIjaNbC20a0LR3C9DSG0ykxwQpTN8DY
 AmgeTfBlKwiQsS4hAUJyCnLKZ0AG65k7kmv77ofr5JSzCiXNELgEwOZmjXXw+pI1cvRx
 f6A2TIsaFjT7QgIsYwODgOLj8HKyY7S8oq8/B1AsJkYpfOgedSzeHKj/49Dh7KDSE6me
 OxuijSt+qsK1J10lTCjLapoNbNYhYoQ4JrsZxpknbj2pJJzcauevzhLGiXadlsbR9PlR
 mW1kPL6B/dLzwRPmwGd6LWkRu+HJX+N2tsokXPaYzmeGeQRzUXEppFKvvjqPsONlTTie
 A5EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRDiEW4qD+2xMIDTgdgddeeOdgVM9UKfQQM65jEIuMigOt0xfTsGR30Mda554CtHTTLqtg1myFCXyy@nongnu.org
X-Gm-Message-State: AOJu0YzDAtEe0HLP1oU6xCi7XTmf0Dg+T875lM1xPMLINlFMr6RscoOk
 Qh/mF/hDsWaa9AxxcF/iaNb1wG9WzzF/yq3EqkOQDnl/P1pL0yhmADaa0aEfyQfeDRo=
X-Gm-Gg: AeBDiespiyTw2ghKEv4tv2oiSoAn7dNshoHwdlgIe7gLID2v2ftaPNjfgDM9F997F1d
 E7agj0laZXZ6mz+LKb0TqM7hwc10h9TF8pCQ4eGbJuKQF93Wz8r10R7C6GX/RR85Ls83VofnInr
 ASy5UtBnKIW/PgrUMyGdEf/RW+NKjYLC0LDta4AxGkV4bRIOfwmriHRf8zOHM+h8vGvN6eXUX1o
 c770cdhWZjpTcQ006zzonW0AOSv0AM4Q5s+bZumWWg+71HuZ941dVFHvOcwRPHjeS8z9ZPExIRb
 AzCnEmdMjAl2epM09SjabjwCVoQm3PxHfWVfreSFxk7N+ZjidQNSLOyX7WJ5H9RtARFAmLXatfy
 Jhmrcmj9/TcQHvPyLvBroU0JxVmNFbSenhxpu0h6/qXczJH2DJVTJzrrxaOmwoFJHL4xGEc2eRm
 jNc0qUi8YqMAqhpl1P7ZgMXn8bHijF9gPvpQOysMBqcbCrgjlD9JhzyRZmWnG262O0wA==
X-Received: by 2002:a05:600c:45c6:b0:488:a723:ea53 with SMTP id
 5b1f17b1804b1-488d67ce902mr91316675e9.7.1775946285046; 
 Sat, 11 Apr 2026 15:24:45 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e51600sm16993222f8f.32.2026.04.11.15.24.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Apr 2026 15:24:44 -0700 (PDT)
Message-ID: <3f917c02-e358-4da1-897c-90d9b39925e1@linaro.org>
Date: Sun, 12 Apr 2026 00:24:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/67] ui/console: remove console_ch_t typedef and
 console_write_ch()
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
 <20260410-qemu-vnc-v2-29-231416f76dc3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410-qemu-vnc-v2-29-231416f76dc3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 10/4/26 21:18, Marc-André Lureau wrote:
> Since commit e2f82e924d05 ("console: purge curses bits from
> console.h"), console_ch_t is a plain uint32_t typedef and
> console_write_ch() is a trivial assignment (*dest = ch). These
> abstractions were originally needed because console_ch_t was the
> curses chtype when CONFIG_CURSES was enabled, and console_write_ch()
> handled VGA-to-curses character translation. That commit moved the
> curses logic into curses_update(), making the typedef and helper
> dead abstractions.
> 
> Replace console_ch_t with uint32_t and console_write_ch() calls
> with direct assignments.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/ui/console.h         | 11 ++---------
>   hw/display/jazz_led.c        | 10 +++++-----
>   hw/display/vga.c             | 16 ++++++++--------
>   hw/display/virtio-gpu-base.c |  2 +-
>   hw/display/virtio-vga.c      |  2 +-
>   hw/display/vmware_vga.c      |  2 +-
>   ui/console-vc.c              | 11 +++++------
>   ui/console.c                 |  2 +-
>   ui/curses.c                  |  6 +++---
>   9 files changed, 27 insertions(+), 35 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

