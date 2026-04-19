Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96476EA71A1
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2026 16:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEVIU-00036a-VU; Sun, 19 Apr 2026 12:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEVIT-00036O-2M
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 12:47:02 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEVIQ-0002Il-RJ
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 12:47:00 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488b0046078so21460015e9.1
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2026 09:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776617208; x=1777222008; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GsKZHkNGBT1IJgJUqOplS5YXYp0tK5q0J4FrtXbsoX8=;
 b=cIzidG35T0ZSeCSUml2N9hX3ch++g6Dq5WAgO5NIhWiaf1GRJILGw1mrE8p75WAGIl
 A8JNgCgQHqSmBSDZ4bkaa4yGtMmVvTeTqrHeAZWEOaNioDbNL96ekyO5WHRe/eeeeXwt
 fMDcDxiv13qGiNdCB4aLwECw4jKtfQmZTRw8T5DQsEdAQOneNQoSuvpk4fKc+pLqs3mO
 OC4IyuFN9k3lRs2Acs0/oD/H9yeEAj0Yezk4U0tSIJYfNYqi+5BNBfaPtiGBa33N3Fct
 NIEnpnze2HYvCGJha9qxKU9vhOJ65KRM3rArv5AdJ9LElJuAuxxWU/kZeWL7PwoggHIt
 DyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776617208; x=1777222008;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GsKZHkNGBT1IJgJUqOplS5YXYp0tK5q0J4FrtXbsoX8=;
 b=pVeIIwjgkod7U2awPV35s6yYTi9XtSJd26V7k4EBLFOh+HOVym8zUih9M44C+DYJgm
 B074jf4Fx/DHWieRalnPaOPu+gyAHYBbNLE3S03+bc0QnqMI6qMht/952QtwunpAZ7iV
 Ua6Qjibo1yt74csfRi22R5fIKfeGK25NZikxPL9WePlF4Ymy0ML9KjBmjqnZMI6p/mtU
 +swcwK3CZGxBD5OLLDE6nMv0xVbcQ5dQ7kcbCCOtTHbrtfOuUyViFyY+0rQPjsBgDt4R
 Vlfw2vGErz7NzkGHEKIKlRFE/v5ZARCni06lT6K+NLGQApTxsrOSlzsjmGnR0ovvmYlC
 Yyyw==
X-Gm-Message-State: AOJu0YyenbVbP3lPDpkSnDOncj8qZKs6Y/pIeSeGSTzyAH3gETLp2swW
 ilsmvYeT4tXllDhZQizlDUMMlXlYOlzN6bnTCt2P4/qdIISxXuYkJOiCLAB9aIuYPchZzJqySDT
 Fn5gNY9Y=
X-Gm-Gg: AeBDiet47wPRl+tNv+meN/XNoPlJfFzWhlNsBM23GaVuS1u0cwb1CEwvHVEueuhDWZ8
 QTYO+wl/UhRixxyQMjKp3fepdlOFoCRSQZgrf//GB3ecIp+Ei+RiSDbe0YZ4RKDXVXkbSP4FsZl
 jfH3ZmVSf8BlGNiYCL6YHte6yHTmvBKMziQXops0vkmUqMKkDSX1hCNwQ4avZo7iZCVZfOiu1rW
 xW765JJyTyGxjHE/wrc7bqojaB0eGShGT8J8RYPV7cSRMizQvU7+EbmIbR0IpeRMy2zCdNwMEKL
 9zWhLJAtOAsGsPUM7VlZlbAk/ka2xfy2R0COTyPgghLw6xrOoGF4VUNyMwMeBR3eR3mjTZvxhBV
 y9Ondh/AD/zewnO0/hjQQU2pECDiy2Bj5QXloDpe5tdpiWfA2M26h3hFD78pQlOnCjhuBi2bLUK
 fbECVcz2k1msh27Yio3RSa2k/Wpvoe0gUVJg03ZRwdaI/55Rk58iEwB5PgSdIxKcEOwKYth+qN+
 Oaj
X-Received: by 2002:a05:600c:888b:b0:485:4bd1:4c64 with SMTP id
 5b1f17b1804b1-488fb796f95mr121381395e9.31.1776617207727; 
 Sun, 19 Apr 2026 09:46:47 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc10777csm248618945e9.8.2026.04.19.09.46.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Apr 2026 09:46:47 -0700 (PDT)
Message-ID: <98a3dea5-266e-4326-b224-0a3401e49783@linaro.org>
Date: Sun, 19 Apr 2026 18:46:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] io: use g_clear_handle_id() for GSource cleanup
Content-Language: en-US
To: Matthew Penney <matt@matthewpenney.net>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260408100605.66795-1-philmd@linaro.org>
 <20260408100605.66795-3-philmd@linaro.org>
 <_FLwJ4IKFwbr2FlwMah_gLTk8PG-FdvyrrFM2UgmbYPlN7wSwZIslJehtfZV7mb8w1UD69eX6LD5Lt9wGkstMiLrdrkkzU1coVZiuy7CSNE=@matthewpenney.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <_FLwJ4IKFwbr2FlwMah_gLTk8PG-FdvyrrFM2UgmbYPlN7wSwZIslJehtfZV7mb8w1UD69eX6LD5Lt9wGkstMiLrdrkkzU1coVZiuy7CSNE=@matthewpenney.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 9/4/26 16:20, Matthew Penney wrote:
> Hi Philippe,
> 
> Thanks for picking this up and cleaning it up.
> 
> This matches what I was aiming for with my series.

Thanks Matt, does that mean I can add your tag to this
series?

   Reviewed-by: Matthew Penney <matt@matthewpenney.net>

> 
> Best regards,
> Matt
> 
> 
> 
> Sent with Proton Mail secure email.
> 
> On Wednesday, 8 April 2026 at 11:06, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
>> Use g_clear_handle_id() instead of g_source_remove() with
>> manual ID checking and zeroing.
>>
>> This simplifies the code and ensures consistent handling of
>> GSource IDs, since g_clear_handle_id() checks for a non-zero
>> ID before calling the cleanup function and zeros it afterwards.
>>
>> No functional change intended.
>>
>> Mechanical change using the following Coccinelle spatch script:
>>
>>    @@
>>    expression TAG;
>>    @@
>>    -    if (TAG > 0) {
>>    +    if (TAG) {
>>             g_source_remove(TAG);
>>             <... when != TAG
>>             TAG = 0;
>>             ...>
>>         }
>>
>>    @@
>>    expression TAG;
>>    @@
>>    -    g_source_remove(TAG);
>>    -    TAG = 0;
>>    +    g_clear_handle_id(&TAG, g_source_remove);
>>
>>    @@
>>    expression TAG;
>>    @@
>>    -    if (TAG) {
>>             g_clear_handle_id(&TAG, g_source_remove);
>>    -    }
>>
>> Inspired-by: Matthew Penney <matt@matthewpenney.net>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/char/cmsdk-apb-uart.c  |  5 +----
>>   hw/char/nrf51_uart.c      |  5 +----
>>   hw/char/serial.c          |  6 +-----
>>   hw/char/stm32l4x5_usart.c |  5 +----
>>   hw/char/terminal3270.c    |  5 +----
>>   hw/char/virtio-console.c  | 10 ++--------
>>   hw/usb/redirect.c         |  5 +----
>>   io/channel-websock.c      | 13 +++----------
>>   net/passt.c               |  8 ++------
>>   net/stream.c              | 15 +++------------
>>   net/stream_data.c         |  5 +----
>>   net/vhost-user.c          |  8 ++------
>>   ui/dbus-clipboard.c       |  6 ++----
>>   ui/input-barrier.c        |  6 +-----
>>   ui/vnc-auth-vencrypt.c    |  6 +-----
>>   ui/vnc-ws.c               | 12 ++----------
>>   16 files changed, 25 insertions(+), 95 deletions(-)


