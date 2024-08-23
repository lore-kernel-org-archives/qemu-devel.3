Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC31C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 06:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shNnT-0002lL-0Q; Fri, 23 Aug 2024 02:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1shNnD-000253-Qr
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 02:29:05 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1shNn0-0005go-Qm
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 02:29:03 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a83562f9be9so190077966b.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 23:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724394526; x=1724999326; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IGoeM6bFZOwQWvE0nWqJSXjAwDrYs9h2+xwWYWt7zAw=;
 b=iZgc2gwijbcGMjKgYrSY6gjdItq3Om6OGJ27OPm/2Sv77tAyT6RusDWtbjS+WZbvoS
 iD010MHMmVLhDBwWM2TbtRisuyyWg2XCHktfAryBfutA+uztDx6Bb3a+bNBVzujX6Mzy
 pwbBKm5r2jRB5FMaKdODgbU2REjX4eZX72NEzlrX/WWsn5lRdsQ3Mb8YSRX2tBtl/N2G
 vLZwv6N+drV33UZ7puJndLUZ4uwP9ojRErkRetP9RpZaTsy6IJEJzbXn52/9fFA459Ba
 1EaiAjM/33AAYySoYsP77rsKQhIp7TNUzcVycq5BPqCuw7AM5lvdHefVToTZqB8WvVyX
 cjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724394526; x=1724999326;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IGoeM6bFZOwQWvE0nWqJSXjAwDrYs9h2+xwWYWt7zAw=;
 b=I+iZhzl8DXcfEVZQlhod1TKzCvZggHdjF1PXx8IfeKdybwe/bBQp1ax93rHhUsbMUW
 UhcIuWrTXW14vl5azCiZPFtpiTwVGdZZJtKOY/RGdUKu9q0p2D7qcJ8yiy3BID0+9ceL
 zXisMDOE3/WO/Vbw01Gvp6iVkqhea7KW3WBKCNehm8bydQvbGY0vFfL/WUNwWEDwSYB2
 /NSWSs7VrjqTJXw1zn8bxPSuPxzVYsWGwcZKp+dAAYuGMnC6l0QyoYHEVDAJpiuRBEt8
 Gkubh0xtHWeM6Dt9EXWqAnng3vb+rlg6mQqPFJWWRE0yjkQ5fO+MFSxt967+JHksNOxL
 hJDA==
X-Gm-Message-State: AOJu0YyEN7sauS2e4uw2qTHS2QwdlG/scVTf+P0s2wafxtNw18foBkzd
 D1qRF14X1t9mZF9j25+RPdgpAo4bzWyIVEHoZfJHU332ICg40OhS
X-Google-Smtp-Source: AGHT+IGJYfdFSmlKYcuDhz/zfyU1+eRqYiyM7q7MJWege7aG4ST2YwwUgAKTzNRKjDlKCskWEOSrTA==
X-Received: by 2002:a17:907:e92:b0:a86:8917:fcd6 with SMTP id
 a640c23a62f3a-a86a54cf719mr68122066b.60.1724394525334; 
 Thu, 22 Aug 2024 23:28:45 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868f4f4aa0sm212083266b.213.2024.08.22.23.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 23:28:44 -0700 (PDT)
Date: Fri, 23 Aug 2024 07:28:43 +0100
From: Stafford Horne <shorne@gmail.com>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: qemu-devel@nongnu.org, openrisc@lists.librecores.org,
 "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH RESEND] hw/openrisc/openrisc_sim: keep serial@90000000 as
 default
Message-ID: <ZsgsG_WL7TNcM1_l@antec>
References: <20240822163838.3722764-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822163838.3722764-1-a.fatoum@pengutronix.de>
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shorne@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Note the distribution list you use here: openrisc@lists.librecores.org
Is old and we should use linux-openrisc@vger.kernel.org.  I will get the qemu
maintainer file updated.

On Thu, Aug 22, 2024 at 06:38:38PM +0200, Ahmad Fatoum wrote:
> We used to only have a single UART on the platform and it was located at
> address 0x90000000. When the number of UARTs was increased to 4, the
> first UART remained at its location, but instead of being the first one
> to be registered, it became the last.
> 
> This caused QEMU to pick 0x90000300 as the default UART, which broke
> software that hardcoded the address of 0x90000000 and expected its
> output to be visible when the user configured only a single console.

This makes sense but what do you mean here by DEFAULT uart?  I guess you mean
the one connected to qemu's stdout by default?

> This caused regressions[1] in the barebox test suite when updating to a
> newer QEMU. As there seems to be no good reason to register the UARTs in
> inverse order, let's register them by ascending address, so existing
> software can remain oblivious to the additional UART ports.

This sounds good to me.  I will test this out and queue to qemu after the small
clarification above.

Also, I will wait to see if Jason has anything to say.

-Stafford

> [1]: https://lore.barebox.org/barebox/707e7c50-aad1-4459-8796-0cc54bab32e2@pengutronix.de/T/#m5da26e8a799033301489a938b5d5667b81cef6ad
> ---
> v1 -> RESEND:
>   - expand addressees beyond apparently defunct openrisc@lists.librecores.org
> 
> NOTE: I am not familiar with QEMU internals, so please let me know
> if registration in inverse order served a particular purpose.
> ---
>  hw/openrisc/openrisc_sim.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
> index bffd6f721f7b..d147b00e4817 100644
> --- a/hw/openrisc/openrisc_sim.c
> +++ b/hw/openrisc/openrisc_sim.c
> @@ -265,7 +265,7 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
>          serial_irq = get_cpu_irq(cpus, 0, irq_pin);
>      }
>      serial_mm_init(get_system_memory(), base, 0, serial_irq, 115200,
> -                   serial_hd(OR1KSIM_UART_COUNT - uart_idx - 1),
> +                   serial_hd(uart_idx),
>                     DEVICE_NATIVE_ENDIAN);
>  
>      /* Add device tree node for serial. */
> -- 
> 2.39.2
> 

