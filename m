Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DDCC3DA59
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 14:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVB6n-0002u9-4n; Sat, 20 Jul 2024 10:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVB6a-0002tI-Uu
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 10:30:37 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVB6Z-00066q-A4
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 10:30:36 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2eea7e2b0e6so44669241fa.3
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 07:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721485833; x=1722090633; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Uptd6Sg8a8qm0Taau224XMUtyCDFbp5nkVVJUrPdyQ0=;
 b=mIJNZvCMvndnjfV50rH+6ymUbB04lldL8TL7ivT6Es/timnVyekxbSFdJ40tk4e1by
 A7uHmc0NsypLWLX3BYR6ncWrnvOfnFnaOTzCFWGZT9kvLnLUkdldShZMbhohl+2Hc21N
 /j1nFQkJmlJwQtDVb0hGo3lsN4zs1gtFa4c8weRICnDHMbgPh4poGSj63uZTDCEwmwJp
 7vgJIWtQzWFv2txMrSKitjyP4eaOwGrfufSrNIgaBTjKsGNRnXqtwSS66Pj62OBpgcCJ
 RobWGKVFEOvYZIXKk8H3qEr9SNow83Zp8DGbVGZTcU7D5PD6AWZYiaegHZ6aBaSEd6ib
 G6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721485833; x=1722090633;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uptd6Sg8a8qm0Taau224XMUtyCDFbp5nkVVJUrPdyQ0=;
 b=A58eUhVqN6faaWeXq3jycNjSrz20zvOv9BEEETtDkco9o2k0+IpPCaAPivK9OaZf+I
 nBiA2KzLVldQXCCkllZK1UskKOg9SaJHhdNbnnR/aZaU6koj+wFU6LSZZSvuj3aTQvPw
 F3nGei8TBS1HRTbSLM9u97VDmNBi/u34B2yawcKokEXTgkTerwvViIxAJvhJE5qDaiCI
 0YP72PR8tj8KOwwbtzipm7y5oNciAreOc2XFZFP7NVw/7+ofL4ZYbSQJLW3WYDxa9b3v
 I+ma5ucsKtv056971yKQ1mYZaJwZPIBROJAWM23MYYl7ofAlVMxCoAsHZtbpUSrLfioh
 Inxw==
X-Gm-Message-State: AOJu0YwMigfU1VQAea47xFk4K+/PBfnLUxuH9r3GCRMRwX5Vtqbz9dlu
 up4/0UqP/abIDf58MmvVg2FKwzT/SmXQYkHZqnA4eE7B5MiM0JgJ+mCeM6WQlW/LrLC62jJbz39
 5DgfvgxpNDYTJ0QJG8p0ylJjHPhZ7YmfX+9Hizg==
X-Google-Smtp-Source: AGHT+IH/MFZe3iWJamyWl9D6CTfWkNJ7xzhwe9Q23oqXl3blENXXvPBh3/25KahI0tLdfDiRBCb8r2H7B2BRoAWwyWo=
X-Received: by 2002:a05:651c:2102:b0:2ee:4c66:6828 with SMTP id
 38308e7fff4ca-2ef167bf608mr24353881fa.24.1721485832490; Sat, 20 Jul 2024
 07:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <TY0PR0101MB4285D5A3587179A5788F3356A4AE2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
In-Reply-To: <TY0PR0101MB4285D5A3587179A5788F3356A4AE2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 20 Jul 2024 15:30:21 +0100
Message-ID: <CAFEAcA_vY769Yws9t4WWitsShBK01Oua5zgarTj3YHgUuvpzTw@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] system/memory: Fix max access size
To: TaiseiIto <taisei1212@outlook.jp>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, peterx@redhat.com, 
 david@redhat.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
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

On Sat, 20 Jul 2024 at 08:56, TaiseiIto <taisei1212@outlook.jp> wrote:
>
> Before this commit, an HPET driver can not write correct values to
> comparator registers of HPET timers. When I tested my HPET driver on QEMU, I
> ovserved too early HPET interruptions. I investigated cause and found that
> QEMU didn't write higher 32 bits of comparator registers of HPET timers even
> though my HPET driver did 64 bits writing to the registers. When my HPET
> driver wrote to an HPET timer comparator register with 64-bit access size,
> QEMU divided once 64-bit writing into twice 32-bit writings because QEMU
> allowed only up to 32-bit writing. In the twice 32-bit writings, first, QEMU
> wrote lower 32 bits of the comparator register and immediately clear
> HPET_TN_SETVAL flag which means whether a software can write the comparator
> register of the HPET timer. Then, QEMU tried to write higher 32 bits of the
> comparator register, but the writing is rejected because the HPET_TN_SETVAL
> flag is already cleared. As a result, the comparator register of the HPET
> timer had a incorrect value and generated too early HPET interruptions.
> After this commit, QEMU allows 64-bit writings. So, once 64-bit writing to
> HPET timer comparator register is not divided into twice 32-bit writings.
> Therefore, the comparator register of the HPET timer has correct value. As
> a result, the HPET timer generates interruptions at the correct time.
>
> Signed-off-by: TaiseiIto <taisei1212@outlook.jp>
> ---
>  system/memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/system/memory.c b/system/memory.c
> index 5e6eb459d5..985a5bd2bb 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -544,7 +544,7 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
>          access_size_min = 1;
>      }
>      if (!access_size_max) {
> -        access_size_max = 4;
> +        access_size_max = 8;
>      }

This piece of code is setting the default access_size_max value
to be used by a MemoryRegionOps struct that hasn't explicitly
set that field. We use 4 because that's a pretty common setup for devices,
and also for compatibility. Changing the default because of a problem with
a specific device isn't the right fix.

If we wanted to change the default we would need to audit every MemoryRegionOps
struct in the codebase and explicitly set the value to 4 if it wasn't
already set.
(If we wanted to change the default I think I would vote for requiring
the fields to be
explicitly set everywhere and having no default at all. But that's a
lot of work and
it's not worth doing.)

If the HPET timer device is supposed to permit 64 bit writes and it is not
doing so, then that needs to be fixed in the HPET timer device model, by
making sure that its read/write functions correctly handle the size=8 case
and then setting access_size_max =8 in its MemoryRegionOps struct.

thanks
-- PMM

