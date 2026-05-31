Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B972CD6E56
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 17:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTk2r-0002rZ-Ms; Sun, 31 May 2026 13:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTk2p-0002rL-99
 for qemu-devel@nongnu.org; Sun, 31 May 2026 13:33:52 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTk2n-0005PH-Sl
 for qemu-devel@nongnu.org; Sun, 31 May 2026 13:33:51 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2c0a5354da1so7275465ad.0
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 10:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780248828; x=1780853628; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UO2PNWkD8jqU75AB4uaGBlJqb9vHisDn96q/lQ5MBGk=;
 b=s+c0HjJf6tVaRelE3mOPx2l2y3jdaFWcX4sb2hJbPDAwRXo/W7+r3zh89HnP223Y7Z
 z1kBKG3NtjtoWscOlzod8KulY193GIjyouIeA4SKrfvLAyKANbHX89zFU8xeL4B3i/qt
 JbHUy1Rsts8vrqSGoHlB1WHQPnFJUf9YAsk/OjtVgi1JlHWhY5uSl9tn+IDrQpp3PWQ9
 TC7EQ0194onz1ZyzWkdn2gbZGnj5JQ1sAcuUGKTcx26jD/Z2OT0jk/n0viIYQRwH9sbo
 Bic5J3iMYUbD89n6HQHa3Wqih3GCIsNqiE2+EzY6B6yDlx1F9Rm+N9xxAYpQITcF4H/V
 SlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780248828; x=1780853628;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UO2PNWkD8jqU75AB4uaGBlJqb9vHisDn96q/lQ5MBGk=;
 b=ayCWhkw2ImG9SiLqoPYXNkR+gq6kT0H9pAiS4ouTDPQ2K+PiGvpa3Ucay90Ju9NSj/
 c1jI0Jvzbec93qYPnq1j+gpIG1C5/ZDRYJMZ42+Y563g7/ao3BzxJG7s9QLHBNes20yc
 uDAom8VcGgUXWYq2hsMn8smc8UAXxT46gpLw78Muh3jX8B68bLEOmXhcscsd5gOZnllt
 30o4aHzFJ9dOw67HkPY+IxePZLA0Fq7a7zPHyDSROyPaoV7DW+mXHfSpgLev5zSmeNfF
 73oWPnjD16QDpCZLw3xPrDeNWoQFB9Lwf3lYc14ygCOP/CEhkoGtotPAu+Gb/JALxGJl
 N0zQ==
X-Gm-Message-State: AOJu0Yx5gfTeol4PXI/+vZrilH+Kud53HXvfq/UEbYi80IIEdCudCkyx
 9lZOdYL+gKyHCneZK/syjvvUondTpM2/ZkAfD7qSNhL5DP/kt/Fh0Ue++tm01eWhjm4=
X-Gm-Gg: Acq92OHn7pa6wWDa1My9JKoDncVDKI53WwYXpR5rl6QJbqqxChN2NcBB9ivlYjqpNv3
 EtT84swT85xfugqRKsM40k1nWCBcvw3/CM58pMqbm7394o8gWOOKhayocc6KatczWgFdBOdK3Q2
 ujvdVIhKA9qhxFeCDsD8Ge40DPVmpRfcVE6UpktavUpNLULzybXw9dSgppiPuoUn/96S6R9Jq1p
 MBDSV6SyRxsGsu6LvHUbR1NDvAwR79JCFLCcRie1f/S4ZB8KiycrBKaVQW4M7s8MC06/HmwO0Dy
 wSo6IFmTZuVHNPabct46ipDUkNzIflWhokS5QY6UkM3slyCiAs4zVIKVKJ5ggy+IonQDNocJ28D
 a0cIVg9hGi3oE2bmp+vidxTnPdAFnyrNyO16hoMYr6ou95QeVXTbYJKndynjZf3GlUbaJJ9X7iJ
 0vLNIq2CzgwCq8jp4D1p2D+iMUr75x+JVZeVwu2RkVgbr9jTfCIxtP2SohHA==
X-Received: by 2002:a17:903:1112:b0:2ba:21c2:d6cb with SMTP id
 d9443c01a7336-2bf3795a8a4mr71638655ad.16.1780248827813; 
 Sun, 31 May 2026 10:33:47 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf239e5d78sm79312555ad.12.2026.05.31.10.33.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 10:33:47 -0700 (PDT)
Message-ID: <22f680f0-5323-4aa0-b692-f76889a04039@linaro.org>
Date: Sun, 31 May 2026 10:33:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] common-user: Move probe_guest_base from linux-user
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org, deller@gmx.de
References: <20260530211248.375318-1-richard.henderson@linaro.org>
 <20260530211248.375318-12-richard.henderson@linaro.org>
 <CANCZdfpLTPL4UKFMHrevMPJ-3NguLPpRXkNYrJnQjyMyvwVoQg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CANCZdfpLTPL4UKFMHrevMPJ-3NguLPpRXkNYrJnQjyMyvwVoQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 5/30/26 21:44, Warner Losh wrote:
>     +    void *p = mmap((void *)addr, size, PROT_NONE,
>     +                   MAP_ANONYMOUS | MAP_PRIVATE |
>     +                   MAP_NORESERVE | MAP_FIXED_NOREPLACE, -1, 0);
> 
> 
> +    void *p = mmap((void *)addr, size, PROT_NONE,
> +                   MAP_ANON | MAP_PRIVATE | MAP_FIXED | MAP_EXCL, -1, 0);
> 
> is what I had in my port. ANON and ANONYMOUS are the same. FreeBSD doesn't define
> MAP_NORESERVE that I can see, though you could define it above to be 0. FreeBSD used
> to define this, but it has no meaning in the current kernels.

We default MAP_NORESERVE to 0 in qemu/osdep.h.


r~

