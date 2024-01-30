Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15FAC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 14:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUp0l-0000Gg-9q; Tue, 30 Jan 2024 09:22:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rUp0j-0000G6-CJ
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 09:22:49 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rUp0Y-0000MG-5R
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 09:22:49 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-295c8b1cd4fso194807a91.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 06:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1706624556; x=1707229356; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Et6PFb0n91yKK3rdf7xB3qOYbOiHhQLvFwOxlWCTzmA=;
 b=YOTx12Yf4wnupfM9c5eaUHOsumNq03/KnN3IVGjsVwRh9dnRrcuGWM1K2WtsalYRfz
 cc55LDkWZfuIdA39RIHI43tIK4tbkPxIqT8+qhKxaE78RPcgzL5+KV2rTd7DVWZDtJi+
 JrwJ7DlBVt7mibDUNqdp6/hFeHpDlCcGp84m0uqKIpjWbiyqER/WjNQZJ6sxHuyZbeqM
 MWf5neFZWaAbvwiq6HdhppxpgUYoRaPKn8+fVb5CNLKLGpq5vxZ/BIWxydQa4bKlL3Gf
 AxmnyxO1zyibn0bJKMb0d6yKwMI+W9Tka1ceMwNTd1IS7q5xTNpsW3ZbaXTXri0hx3eY
 OJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706624556; x=1707229356;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Et6PFb0n91yKK3rdf7xB3qOYbOiHhQLvFwOxlWCTzmA=;
 b=ej2WIaDOyArCzu76SMJFMN6iSE6C0sEGGl0EnuecMDCWQphH0zYNpCq5K/rSKXj228
 scjFXinhI0ZIJACe1ZfTYoMK49nEZamJ+fpWfKbyQeRETtiwku25M1GCsZlxvHn/9iOq
 cZ4FhKcUAN/X46FUBYypLO2X9JpAA6Z6GX8G3p9trxeOVppPUbh42pXsMtl/6AHoSExe
 xInEe8oicGuauX9/BaNSMLzK/AHoxt1RP6p4mFJZeVToVyjTeKQqsisgoi8k/psXQ5oj
 PimDPynsTJuHiJEkBlzFDPrFuROZ2TnmlkXApB6jD9E1+1FumlBeL+HnL4Mh5tGlWU01
 a9JA==
X-Gm-Message-State: AOJu0YxM6jAvzboIK2GVBApPFvQrxd9OzdimCaMrxGjqBJqZ+/ONJHHb
 cT+CHHA6zUwcHWs2WTJSQwP/gH82K7SOLqvVdmdCS72Ug5SGiNYFjEk0mkh1b4n424Z5102tbc6
 6aa46+SnCEqx0O44Jc1KUqvvJlKBhJrtxFdSX
X-Google-Smtp-Source: AGHT+IEREpWiMN1CCy6iCpJbotWhFvovJcf0lzfaC8AvLiqBvdUwF3053FgkA8/E0hg+Q9e2fgTWCa8c/Xjd4oWjViA=
X-Received: by 2002:a17:90a:71c2:b0:290:38ff:b1eb with SMTP id
 m2-20020a17090a71c200b0029038ffb1ebmr1624698pjs.27.1706624556311; Tue, 30 Jan
 2024 06:22:36 -0800 (PST)
MIME-Version: 1.0
References: <20240130113102.6732-1-philmd@linaro.org>
 <20240130113102.6732-2-philmd@linaro.org>
In-Reply-To: <20240130113102.6732-2-philmd@linaro.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Tue, 30 Jan 2024 15:22:25 +0100
Message-ID: <CAJ307Egk1J1t22cug0dyWuF02fWxCkiuW_CcBmeAqU_-72Pjrw@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/sparc: Provide hint about
 CPUSPARCState::irq_manager member
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, 
 Fabien Chouteau <chouteau@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=chigot@adacore.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jan 30, 2024 at 12:31=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> CPUSPARCState::irq_manager holds a pointer to a QDev,
> so declare it as DeviceState instead of void.
>
> Move the comment about Leon3 fields.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/sparc/cpu.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Cl=C3=A9ment Chigot <chigot@adacore.com>

> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> index 12a11ecb26..d02684569a 100644
> --- a/target/sparc/cpu.h
> +++ b/target/sparc/cpu.h
> @@ -548,10 +548,9 @@ struct CPUArchState {
>  #endif
>      sparc_def_t def;
>
> -    void *irq_manager;
> +    /* Leon3 */
> +    DeviceState *irq_manager;
>      void (*qemu_irq_ack)(CPUSPARCState *env, int intno);
> -
> -    /* Leon3 cache control */
>      uint32_t cache_control;
>  };
>
> --
> 2.41.0
>

