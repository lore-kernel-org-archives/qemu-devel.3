Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4700C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 03:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjsw0-0000gj-1y; Mon, 11 Mar 2024 23:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rjsvx-0000gM-4Q
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 23:36:09 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rjsvs-0003on-67
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 23:36:08 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3bbbc6b4ed1so3913320b6e.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 20:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710214562; x=1710819362;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BneU7fwOOqKNZKXdiSDY7DSiRfoBYXL8y6sh03dElAs=;
 b=J+Iy6kQtEJALDhYLvpyOdtAoMPkO8cV/N1Um+qKrtEFFcHJ/MuuvvX8hgmkHijkD38
 UMGB49NFWhUk23vSghyWERAQaOVhs7ShGH8k3frpPBruPb3gzmDIPDRgjvNTcl4gEFnq
 qvm4ZbQqlFrF/YYaq/V9o1RD37T52hFmXrmWXx9q5xj5acTbydJF2DPoSeCuDkawkw2X
 m9qhvx5/LyztnaueEAygTi2B0wLoUXscLnUExGcaruUykCEYgGlvityXCScrAh/7zOy8
 axUxegxJPP8l6rCBV36d3rRilEiUxf42jnqD0o13IhEVKqQ7JEpprFXP8FG0AaKrBOCH
 doZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710214562; x=1710819362;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BneU7fwOOqKNZKXdiSDY7DSiRfoBYXL8y6sh03dElAs=;
 b=H5YzVusY/ZhWcWhtDfK7sjng6j7QjPZ2pzKHcp4L9czwNkLfZKwU6tiJneHUwa81uT
 3/K4b6nTa96HQmUoQAf5d+E7a+cZpGLMiT8IdEm+/ESKBqBwFEiSrIQ4zQtxYvPQD46I
 DF4bh/R8xgEDuZWRy93NEa8uq/gyPmLdcs/6AuZQkHK4Mnn2Ocincm7Pb/xBIzcoTzTI
 YRIskAlWpUPhtxV4wL0cI/z+j+V86WDSJXSadTiK4wo5/YwNOLY3WhIBBtZ+MzYAfCnW
 MnZxvyGw35nHouiiFLpIHqXsiyrdo0NxZEKKZAc2kD94S5ongYJhpqVh+DZtB/oYO2in
 /fgA==
X-Gm-Message-State: AOJu0YzA5U0/GkCq9euQyapZDP8TFHNvFNPP/1mxfT6pRk2hYvRY2PPR
 Xqy3MnPptsiv+K4l/7l7FmTHzig3Cd4t29kux+VlIp0Qh6toS6x/tmZhqar0b2c=
X-Google-Smtp-Source: AGHT+IHvGUic+BKCINN7go6YqY7alZCwu8x9fWUQbB5nvOThnn/7FgeTGZcVX1Z+MTc/DBvpobkIMA==
X-Received: by 2002:a05:6808:bd4:b0:3c2:34d5:4354 with SMTP id
 o20-20020a0568080bd400b003c234d54354mr11012242oik.26.1710214562558; 
 Mon, 11 Mar 2024 20:36:02 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 x18-20020aa784d2000000b006e571bef670sm5081668pfn.70.2024.03.11.20.36.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 20:36:02 -0700 (PDT)
Message-ID: <bcfa9d1e-845a-48cd-94bc-44c1ab46733a@daynix.com>
Date: Tue, 12 Mar 2024 12:36:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Fix GDB SPR regnum indexing
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20240311175437.2177587-1-npiggin@gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240311175437.2177587-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::231;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x231.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/03/12 2:54, Nicholas Piggin wrote:
> Fix an off by one bug.
> 
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Fixes: 1b53948ff8f70 ("target/ppc: Use GDBFeature for dynamic XML")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

> ---
>   target/ppc/gdbstub.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
> index 122ea9d0c0..80a2e7990b 100644
> --- a/target/ppc/gdbstub.c
> +++ b/target/ppc/gdbstub.c
> @@ -324,6 +324,9 @@ static void gdb_gen_spr_feature(CPUState *cs)
>               continue;
>           }
>   
> +        gdb_feature_builder_append_reg(&builder, g_ascii_strdown(spr->name, -1),
> +                                       TARGET_LONG_BITS, num_regs,
> +                                       "int", "spr");
>           /*
>            * GDB identifies registers based on the order they are
>            * presented in the XML. These ids will not match QEMU's
> @@ -334,10 +337,6 @@ static void gdb_gen_spr_feature(CPUState *cs)
>            */
>           spr->gdb_id = num_regs;
>           num_regs++;
> -
> -        gdb_feature_builder_append_reg(&builder, g_ascii_strdown(spr->name, -1),
> -                                       TARGET_LONG_BITS, num_regs,
> -                                       "int", "spr");
>       }
>   
>       gdb_feature_builder_end(&builder);

