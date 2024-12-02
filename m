Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1451D78337
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI9mk-0005Wh-57; Mon, 02 Dec 2024 12:00:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI9mN-0005R2-7h
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:00:13 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI9mJ-0000zZ-Pc
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:00:10 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-434a099ba95so40961055e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733158806; x=1733763606; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xT44nfPM1ygpsmgsgD2juVyVm4spHR7nIm4LCe3IAR4=;
 b=aDgIUWvBzBUKM0ixbTDRNRR+ub/D7KW1C9Yu5uSqyZ9rZa41U5mslmX7T49Nyni6PZ
 8EWGImNR8VlqmVpEMGmnNZTKh3G/sA9dVOTW7rPirEB1c2pmXb+H5B6tI4k8AbtuyIV/
 NSwJzYdGV9jqqAMFuVbBfR815s1c9+2l9Vg0EJJQz8/Lpu1m6QaUMVuQ8phTUnitaZS2
 djcmXJC14jx4lejpzDsLM/LIxfIOCXXlR5Nq3gGEDgwdJGohweG3IpEXxbDhP8B3JCPV
 3AHkVmfq4GxYaPkgLtyTuQHdYkZZKPVJG2NTpJrewKzF9dvuzevjgEL8UHlwRbHgiVqB
 QweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733158806; x=1733763606;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xT44nfPM1ygpsmgsgD2juVyVm4spHR7nIm4LCe3IAR4=;
 b=H6rQTD99npykkl8OFJDBD+RhAAHWuevZiiKNvyGsFlqrt/qIsUK6qYgjBMRIwxQBrQ
 x3LYXtL/1m5AEPa0IAg+y/lu2xbSXKMuK03DiC0bYg380k6Q7webzCUcVBRALWUII4KB
 rh6vcEeyOZUYGWMpxIUwntG6FQ74D7xhZJ2TbWQ/HW9s79C4GWAolPieBfaN5Umn9ayi
 jN+RweCkDVo4WVkHtzwUJaQ3bDp0YbeeIlf0zhca8AxQsvpamMw0G/jPJnZEg8D6+98F
 iOfNe+01vHm4jrd/N4IXflf9WjiW5POhr2QMDN4mbcZ23Fc+sHIeekIiACCwBFtZIN4W
 i5/A==
X-Gm-Message-State: AOJu0YwEa+VaiKpnw+VRuZ7g7OpcAIZM/Hmb7LrOwzudQEbG5r6Djj4u
 kAJYD8aDTrHK0k56ysu07lROt2o0ZKBtzdllzz1nIyb3aPFzM/dTOsHRQRMXVmu2iGTuKu1OEeW
 Myv9WkGMOEaUh3UFp7C5RnkC/7hR72Hn6E12SDw==
X-Gm-Gg: ASbGncuzBSad2l+JRfv1uLSlaZpikliHaZPSuSwmvDCS7rbICOEfA9NVkA2NCN7t6de
 VvNKzziBO3nAm/PHk4F2vHu9jRE0EH8sf
X-Google-Smtp-Source: AGHT+IHeKXLBQBQh104CFO4kDTHTNWCGnBULIa6VUFRTEfSD0W3XRbN2fprkXR+yp7lViAfu5nyXH3l7S4jMn7GICa4=
X-Received: by 2002:a5d:6d8e:0:b0:382:4aa9:b620 with SMTP id
 ffacd0b85a97d-385c6eb5804mr21988573f8f.5.1733158805905; Mon, 02 Dec 2024
 09:00:05 -0800 (PST)
MIME-Version: 1.0
References: <20241201070955.223360-1-shorne@gmail.com>
 <20241201070955.223360-2-shorne@gmail.com>
In-Reply-To: <20241201070955.223360-2-shorne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2024 16:59:55 +0000
Message-ID: <CAFEAcA86NO7U5our5JiZEC4rNa-hdxJcMmpjY=b7ZZptbNFbXg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hw/openrisc/openrisc_sim: keep serial@90000000 as
 default
To: Stafford Horne <shorne@gmail.com>
Cc: QEMU Development <qemu-devel@nongnu.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>, 
 qemu-stable@nongnu.org, Jia Liu <proljc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

On Sun, 1 Dec 2024 at 07:11, Stafford Horne <shorne@gmail.com> wrote:
>
> From: Ahmad Fatoum <a.fatoum@pengutronix.de>
>
> We used to only have a single UART on the platform and it was located at
> address 0x90000000. When the number of UARTs was increased to 4, the
> first UART remained at it's location, but instead of being the first one
> to be registered, it became the last.
>
> This caused QEMU to pick 0x90000300 as the default UART, which broke
> software that hardcoded the address of 0x90000000 and expected it's
> output to be visible when the user configured only a single console.
>
> This caused regressions[1] in the barebox test suite when updating to a
> newer QEMU. As there seems to be no good reason to register the UARTs in
> inverse order, let's register them by ascending address, so existing
> software can remain oblivious to the additional UART ports.
>
> Changing the order of uart registration alone breaks Linux which
> was choosing the UART at 0x90000300 as the default for ttyS0.  To fix
> Linux we fix two things in the device tree:

three

>  1. Define stdout-path only one time for the first registered UART
>     instead of incorrectly defining for each UART.
>  2. Change the UART alias name from 'uart0' to 'serial0' as almost all
>     Linux tty drivers look for an alias starting with "serial".

  3. Create the UART nodes so they appear in the final DTB in the
     order starting with the lowest address and working upwards.
     (Linux doesn't care about this but some DTB consumers might.)


If you like you could also add something like:

 These changes mean that:
  * serial_hd(0) is the lowest-address UART
  * serial_hd(0) is listed first in the DTB
  * serial_hd(0) is the /chosen/stdout-path one
  * the /aliases/serial0 alias points at serial_hd(0)

as a summary.

> [1]: https://lore.barebox.org/barebox/707e7c50-aad1-4459-8796-0cc54bab32e2@pengutronix.de/T/#m5da26e8a799033301489a938b5d5667b81cef6ad
>
> Fixes: 777784bda468 ("hw/openrisc: support 4 serial ports in or1ksim")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> [stafford: Change to serial0 alias and update change message, reverse
>  uart registration order]
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
> Since v1:
>  - Fix commit message and reverse registration order as pointed out by Peter.
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

